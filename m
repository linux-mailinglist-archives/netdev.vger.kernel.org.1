Return-Path: <netdev+bounces-206386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 462D4B02D3D
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9097B1D98
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B62226D00;
	Sat, 12 Jul 2025 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lz1ZEpWc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA391E5714
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752356590; cv=none; b=mrZWfQK4pL+CZOGTGeLYWgzq/Uum07808asj6yatEdWLxNHBYORd+Vr/ztyOGtG1gpObDwwRl+tyoLHCbkhDgvA//xrSGGW+RuRecgjWo6vVH1eEdhp95V4zhPI26n4BGJ+i3D/glCOIuiIh8uBVyg8MGQ7BMMhKCAtIHRIgQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752356590; c=relaxed/simple;
	bh=wvRv7dlxhUorY0L4dSxcUA+1OKc70xuk0+Co6kYc48Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zzxtd1DODbha6f6XNn3jdIlYaeTCasy96C9jVNKBU/jy99Ed+pQ/C4VkucXb6fzoWDECVMlQq7rMDMarPuYwAcG16GgYLCP6cjSQQdw9SSLV9CFLHaiGOuawvvQZyHD7FPxwn5iwE64LFAE7GKV5V3SceC4Hydqrz88kvO0EJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lz1ZEpWc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so3087370a91.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752356588; x=1752961388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvRv7dlxhUorY0L4dSxcUA+1OKc70xuk0+Co6kYc48Q=;
        b=lz1ZEpWctLab1x/ZADnIY5NvJQCurd7BK1kBpAGsNcJUSrLHsMfT7sgM2Q0x8+N1uP
         LjKWXEWBkfNhQdfL4fP4Jn+d605ATeeVb4D1E1cicik4sa2nZ+22aR5Jj3iiHjnxcQ5I
         +eeM7kGfWiPv9M4JiuE9z+JVQc5/4MHN+Rm4VxI25vnPtWp1mTpHrhTM/VASHTTwTqFn
         DD3/bU5kC/SRg+MMDhOsU2yC6nedSRWx11kz1zVAPAvCsnMpdKGxHYOwfPYPLenquAd1
         PkGCX8w+2euKXiao84vb5MsOPvjFFze4GKajvkVLZtm5grk5OEZe16+Xnl6+a64BXxWS
         OLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752356588; x=1752961388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvRv7dlxhUorY0L4dSxcUA+1OKc70xuk0+Co6kYc48Q=;
        b=O5zSIx1GeZIu/HgXqZLUkCRMf4JEdp4SD5yxVCljFyUrx4+g3eyjMuZrWIWO0BlpWT
         sWkmlP6xguP01b8kC+v//DQiBKH/0HkfZ5WqNzwzMnHdA/MVRkIAHZ+apZPsT+KgIINT
         fn7J6jEe5NOzy5MPEnl9fz3knS+wbnE5afDf1AlOtF5thSsYZtYC/67gyP7+3VwzaGLi
         sVNZICiG6RDieaK1Ggieyu479XPg1TKFwJGRlbLCMnrx4SEsIPZDWSwnbh6ZzMqxmjdz
         ezhwJ3viRPgHvq+z73rzx5wqaKkOfBXme/g9+TixVHIFkVyGMWkgojmC9VYelR4dQg0I
         6S7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWACFWe2jARo3Xwhwk0jofiq5GEjhbE00bdBjlsoZHRtsSWvAF0iGjwK1J/JL+9CLrjwoe6Xag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxRKYYry+7Bstyh8EkzfMmXLCGESAINYMly82dMFyqZsNAj/i
	N8cYNIdRBMW61jM5l3MXtS1zpRmG3M/us926ELi7p/l7B2zqvDCw07l3jL7cw5dyajjZScjWVv7
	OaRq0oEu8mEzIQEqWiiZ0jnP70k6LWJBMMogtLaAL
X-Gm-Gg: ASbGnctfFg0JNJ+tgmum3q/d0/Pj63IRoQepra5MpTn1daxWty1kNM1ZzSL62PIe4PH
	rZiQii/v69gcPqmEjd9TgGGGC84lPxhqwmWXxv4li5xVUFqKsTYkHzm9WDY3QQaJT7dhE1ToZXT
	NheDDlex60qBtOX0eE8Dw1kFQZ3+JZrp2O7iaJwK0E1q9WWKje4RwqnKt+EJe0Mft8TvYMlHMex
	cqZX/0MDBRzQbZ/H1sHmSwUpv9xAOtjTZCfXDic
X-Google-Smtp-Source: AGHT+IHBrm4u2o9zK8m/k5BgsFTwGXC3WEWTi2nBl6HGhi1LhzuVyLBEWDBLVECaiFoHbuy7txnWjrWm1Pqw9mGjLVA=
X-Received: by 2002:a17:90b:1ccf:b0:311:ba2e:bdc9 with SMTP id
 98e67ed59e1d1-31c4cd0986fmr12374965a91.27.1752356588279; Sat, 12 Jul 2025
 14:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-6-edumazet@google.com>
In-Reply-To: <20250711114006.480026-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 14:42:56 -0700
X-Gm-Features: Ac12FXzFbgekMukJDYlCoN2oVjwfr5nCyPHmOUz5gyfNOf6matilGqlV3uqxhxI
Message-ID: <CAAVpQUDDB=HYrnBMpPOoBuT58w3_hz=Y0JEjJYPkKWgPqm8PGA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] selftests/net: packetdrill: add tcp_ooo_rcv_mss.pkt
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We make sure tcpi_rcv_mss and tp->scaling_ratio
> are correctly updated if no in-order packet has been received yet.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

