Return-Path: <netdev+bounces-202052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4EAEC1CD
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F69178BDC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212E25D546;
	Fri, 27 Jun 2025 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0N8K0Ug+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B225D209
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059104; cv=none; b=k9K5cTDGWDbFztC+WAN2c6ScXLZXJxjnpiGsmKNJvhdS4TTwxgX1Da25EvI+uW/Ujzs2CswIHJTe3CMWvC18/CDgbsAnK3qF57dHt0Nc2eTAISQd4IQSFSGgGeubDWqub0qUBfx0NqpA9BKRk8OVdeNJiJ0Ug/EDpJVHBoWgJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059104; c=relaxed/simple;
	bh=HZt8/wQUfMfPMDGsfBaMIH7NSQDQRSbpqyzIO4+VWc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKPdaqCi23erpU5ABmuZMvVFpo0Q29w8Vjbg0REpeSRUn9txabXE+suuKBTlSehc1ZollKQNKJArKtDu/7SOPJ4GxT36zqLRmVuNsA94xjoCeim1NspzdQXRmWQfhe9PAZbn2Qw/Ck6plMlCzhog6MZaS9eTbXyR+1bc+tA39vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0N8K0Ug+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3134c67a173so22683a91.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751059102; x=1751663902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZt8/wQUfMfPMDGsfBaMIH7NSQDQRSbpqyzIO4+VWc8=;
        b=0N8K0Ug+gJcQ/i27Ldq/tqM0LhBrtFZnUcJtdf4oH/8kCt9TwR0pOzvVdSxoojZ9Ud
         v2kbB0Y0bDUcYQwuPY9CKdl324tOHYJlO+8L3OrMVB3OxasJLSwE40/x9L5faB0ALtI+
         6Vh8bqxZRj3YocatOiFCDYhaU2Ng7ct/p8ljxDqmJxHWQspagCz2E8s8QY+h2ZlLOfbO
         vb0OOUVOkYbRUz8FJ8HK5x1kQhysbQd9UvJn29O8iCw1sdLT/2//+bNkD3CCVl8VWi//
         lGGw+dO9pNwKI9d+I40r+/EKxcPb/IVr8wR2m4jCzSK+n5v6VXk37n4iPLXkEa3zpGDz
         2cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751059102; x=1751663902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZt8/wQUfMfPMDGsfBaMIH7NSQDQRSbpqyzIO4+VWc8=;
        b=IP7Ye8F51YteK3+4uk5cPURvnd2dDMQ4WWLrTh7648bENnzRffvu8m7/XBKTgPMuZm
         ciik1OWxZBFFoRmDcvM0H7mfuteN52gDkcDTfquHfKYR+O7OBWJczUphcXqeW0Mactjt
         Un4qL4AQaqxwodW8hcqs+fZF2N/Oyv3Gzix5p44eNOVOJm58unNnL0AGcwJiPESr7bFO
         M8lcqzhJdtqZBaNo6IeTG+E7fCa6/XzpGUrr3so6vSMpdCv0BreHztuJkbck2usGEk8u
         /Vu5wYqc5s/ZfLosyhwVlJQqnJDGVhMszW/rkgmGQl44rQ0Ox7CPnsRj/1+TW7lCaIj8
         W88A==
X-Forwarded-Encrypted: i=1; AJvYcCVR8x0N8NiRTi/B89YM2gZDsqNqbDYez/hnVcEgW0VOzrS90A/5QyleLmY9vn6+MPBFwNLtZCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyimgCsWVdpTCOJmtu+UtNZxmTrJ7J0Tr8pIIeDUhHiO8zDDbzf
	9e3Oxj/qI5bTqar0oBOIkBYwTCUfiUWtQkgjh4io3AAzx5fYgmYkD0xyIyKSu6eHni09DMHZBLU
	/hnfNPFPl+H4IqjcatU5tsypTT7ckgOo1Mt3Z46iV
X-Gm-Gg: ASbGncthTgFoFqmlDHIn3bcRKoyLI3kKsjWzRMByRMckSG7C8e32TPiwd4sWTfHa98O
	ziF3Dwesr+zQUTYf3uemgTdbmIIjD9s7qKwmFQ+GI9eFDGJXwjPqNOirsr/Tomd1V0UeLA8OD/G
	oUDXYxHjpk9r5WGMrHNJS8+y4yxYbxIsXm/Lpiw3i3sflKcFRG9n3+w6VIhdIE3BwPcFP/HQWQ6
	R12
X-Google-Smtp-Source: AGHT+IHQrOfOPmvQcQeTNICzBb7TKelECe9cGUH0UInBkNUpBFww0eype33NQVI8CUZLUg/1Cpm/5k0rGPO6y7qgNDs=
X-Received: by 2002:a17:90b:554f:b0:311:fde5:c4b6 with SMTP id
 98e67ed59e1d1-318c8ecda6fmr7338955a91.6.1751059102105; Fri, 27 Jun 2025
 14:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627130839.4082270-1-edumazet@google.com>
In-Reply-To: <20250627130839.4082270-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 14:18:10 -0700
X-Gm-Features: Ac12FXyuwZ9YvmuqumbVtl51wPV6vg0uYlJOvr5zg2GGEIvS663elLkM-OOT-tY
Message-ID: <CAAVpQUAvX89aD9D0e+PybP_kCs0_zD5JjJ6ku=qF7Czj_xJ+HA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove RTNL use for /proc/sys/net/core/rps_default_mask
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 6:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use a dedicated mutex instead.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

