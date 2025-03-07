Return-Path: <netdev+bounces-172977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65265A56AA4
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A86189B553
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185221B9F3;
	Fri,  7 Mar 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN8mUzNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1A1922EF
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358418; cv=none; b=UojROwpd79pHMclnqDDw1641whX+U/2SRN9bPBPbPbB7jwS0c9W+uwyHFoSh0cEYWF1VAOFXXp8IWrw73DhoXKfXrMZMpL1A750d1oyxfRMweECfzQSXJvVQAxgUqurCge5Qzh81oQfab+sx+s5ifZuLz+8xdQH+R26FcS5SE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358418; c=relaxed/simple;
	bh=L3buUM6TQI3XhDeJt6OgiTlycBcinvg8tyhfn0nA/dg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=U3d/Lqxds21MLgYMxKrTdhlsaPztLw5OSAFBZ12yiQGzozLpnGMCTZt94FNvn4SDVrUEF1cDy6zMJmMRp7Y7GAEBnDAVzG3AUJ7Bc4Jz7fhbtGSuFuAf71LEhXo0MMK0qpzZa0Loy0BcIO3GV/6S5jMsUZKWZXqEpJ6eVfn7qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN8mUzNQ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3b63dfee1so214461085a.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 06:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741358416; x=1741963216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CWFKwr2Lfb5XOvjvzAhJugAjU4+k8gQzhYzvDn0wDA=;
        b=KN8mUzNQO3Eh+ghZEVxoOU0a3fBpm00N03DAVp3e4reHL28dh7nyE+306urXot1+lk
         Xrs3LShwSjJQ0w8JlHro2lDg6OO1WL1yOD5UOZccDn03irKuTMjkk7atFmL8Seod4vHW
         vL+wh/pERjfchRUitI914dmL6xkqMfrqRq27B43SWwia0ou218W63ZrBgBK407017g/g
         WAv0wh2wkwAyotpyW4yBje+JT9qb86SL8RHobJif7G4iLmNCgqoouVFfadH+xOK+P3pu
         Fn/fmKE6SNKdZiESkWy1myIGO2yJA7INO9jkoWiDIqPnivB2B2h/0XvJC8RR4M8l0OQA
         SN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358416; x=1741963216;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6CWFKwr2Lfb5XOvjvzAhJugAjU4+k8gQzhYzvDn0wDA=;
        b=C3ELYLQn7JoRVr2/VbJvhGkVA+IwOhp8E5AUu6k8xv4ZlHVJBYD4/+tLpZrkinAGew
         83csnwU1hPPShyahb6NvD2WhPjU2W7BUc9iGnE756N4LM35BC6gcEEbmACPxCQoT/9Jd
         dsn9/2NfwWU4gKMICcs8TUnRpIkIP3GjL/6jAGuFiEN4HzjiAuLc9Jss3r3oBxuZj7qO
         L7BFV2KM0KaEeqi37PZi9wkkhyKIzN0yL78c2a+EzDZuEb3bfGckb5DC1TWtaDt4j7r+
         2Qb4Q99kBjNT6hpf92xByEujH83DeXpcVANoDMS0ZbVExmMcfG9LbwiVoWfnFpTgx8kd
         bhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeaThcBgtB84Xcg5s1c2WOnG0WqIGXcvLrVQtKzafYs9Kb0nl1n41THNWaCWTOndi0O0MjXkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1I2o91qeeRGm/Ml00hsFGpfz0TnhPBl/c06T7r8hx7mFMf4Dw
	cUjO/bP/z+Av83he/x8yMaAf84ILSB13O56pDJqZ51zqlTojfXTV
X-Gm-Gg: ASbGnct2bCD9Csd0bcxGwJGJm0k3cu3fFqRzxK9rsxgcrlNRNAmCgCQDgjsNFsXIRlQ
	WtgYwXxOIOB6qu/sjLb9hA5542wMiuiLE816Su9jOsa3a7MEEZTox6eygCsTJ4ThBWeCtj6roJ5
	5Im6bLppJqt+6yudnCu8+5PD8S9xUVtqd9e7+n1BOFRTPrkNe55l9c4DKJt6AgF2gB+XDARcgjC
	MEkY2MlKhJbJubLYoQ/YOJv2NDiARIs3W2WnLr/1vLPlOhNQCQd0XF2Ph2ioAZz5NiQPAAkTPxa
	DNOHXAv8GKVF1MfWEZGkwriNkBoh3TfqBe3wEhEpIyh581HDESSciZHaYleFLE/voHbBLk3dviU
	P1ooslqfX6EwlPsxNBO8wFg==
X-Google-Smtp-Source: AGHT+IFQVtgoBboB7qLgGqSUmGH8YTQsMUsQW4rodHGoVlawLdkC52t0VqwuvM4TKiXWgZAGjlSGeA==
X-Received: by 2002:a05:620a:2603:b0:7c3:c87c:6755 with SMTP id af79cd13be357-7c4e5ffc200mr579504885a.18.1741358416173;
        Fri, 07 Mar 2025 06:40:16 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c53b8a5afcsm2991285a.97.2025.03.07.06.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:40:15 -0800 (PST)
Date: Fri, 07 Mar 2025 09:40:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67cb054f2ed11_a6a3c2942e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250307102002.2095238-1-edumazet@google.com>
References: <20250307102002.2095238-1-edumazet@google.com>
Subject: Re: [PATCH v2 net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> SKB_DROP_REASON_UDP_CSUM can be used in four locations
> when dropping a packet because of a wrong UDP checksum.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

