Return-Path: <netdev+bounces-165079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AEA30547
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF9B163D19
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1DA1EDA2B;
	Tue, 11 Feb 2025 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUpIj5Fh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98EE1EDA18
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261349; cv=none; b=s+C5GAHQW6n7vL056LwzElLGjvPudknu4BxHfV8V4j+SLW/yeGxKH47KRLouOSMj1RRAEa5prkqkIboO2re1b1K/7KVqxcJTuuev5iUfGkwk5IrI/0Z4AzjXb5vsiCLsOdbV+9AxunHg/zR1CFKbnzszxW5cQaKJsgLwxKRI9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261349; c=relaxed/simple;
	bh=EIHK36EHvqXNfJShR0B6u2xH5/sGyZjJj6voLm7Sn1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUowGdCBbBny7Rk+AgXixV1y/MFRX1LoNLLsY0OBfbpLVDEl6c+rUWph3pqUJXCWireOgTNt29PDbQFzYY4qdJ1990GI9Zktb4klnjScOngg0pol9JiVu9/YcpjW5dhyXvbj/oqqHq1s43hcCfu66audAhvNQXD+z7BJCYI01bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUpIj5Fh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so6230299a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739261346; x=1739866146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG6e8unvP83ksHQWgChsby1Eosod0PJ4WdLiUX1sgbs=;
        b=WUpIj5FhA4gA360g/pYx77xqVU7CfWZ0L5PVnA7jMApQEODN8sR6CNhaSFjvsqHgwf
         aoG7ptXyZiPt5O75Sr90VUchV6Ct54Tkb3KNa5oQiV3Lf9o9hc6bIJ3xxcvPRbdDvdBT
         zsxmj7PAa4cbRNgCIS9AKTSqVVV0KIoSDaZa1I4KPPiy0CpnapqomM2Hajlk1rFlx9UZ
         ufB/YuCPqtXaMhM4gW9MgifBDf9KeGaxpu/BFqSo9G+SGmngZq+6F21fbR7s9mECliug
         HqOJXI+Ofphx+bk0I0tbeVxXlwrSVWvjNMUZ682QrIz2Ml/kY0yIZe4RboZ7aUFswMrK
         zn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261346; x=1739866146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG6e8unvP83ksHQWgChsby1Eosod0PJ4WdLiUX1sgbs=;
        b=if9MhfBTEo18aFgL03db7GcES6cZhfLeUy1G2OOOB9bAJdxW800K7FJV5Hs1faVJMH
         U1XQWLwF7osF6Q1qBI7/c2FDybumznHrkYG1gYY66eAf8uv6fwub2MoHdjWrHsDPW+po
         5hDxvDnOz2hi3K2STeMRqgf1WEx30xGXptcJK/Yu2jJ9I6SbOE1kC4lO+4GOf+k3xfey
         RC3DCk/1PK2/eSROxRxVKUWVpah0zM2osmZ4y6pkzweBUNhEyHCIVLIby7yT06Gy4RvK
         HtgIjeDtA4XgVXM/Wn+PeMJ+cD3YPQq+HiqiKVj3ZVXlaAF/IwHNG51wE9HyPwmeh1QJ
         Y0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtRjZlm2nXkDhjbizVhFOFbNc7RujlGRHJaaaIWPNMGImMa6d3rVNDji0+mtaSTepESaaTLz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iEELkAgKt/Nuxa3eXsRkRhUoPQHdteFFberpBvZDyA8bRKe1
	qgUj6kfaJB8qV6mJJXJgojm8eFj/498F5Wve5eaFpacvLm0fvotgX4lIjUJqfcImrmOIk0lp7Ju
	QuUOr1odES63Z2RUQ4KHiceij23SRDhyeEYTd
X-Gm-Gg: ASbGncuBBKN+8DFUWx0z73sAdQd35cKIBtuRcSVg6+Vz9Vq2xzVKEG/4CMJdO4YTk0C
	4Cf6Miyq24I0LiwM+uSe3JMx/uY329RCby0x6c/V2jnZAFfI21chxeaPLDX6ev4T4cavJC28=
X-Google-Smtp-Source: AGHT+IFZee0T89qKM+2ftfmr4a8W0Sn7ggCuC444PBKTPKa0TpgDX8mI00sV+QdxN+ESxeEaMsekt+Ystzz/L3N2nyg=
X-Received: by 2002:a05:6402:3510:b0:5de:5947:ea35 with SMTP id
 4fb4d7f45d1cf-5de5947eab6mr14037700a12.25.1739261345681; Tue, 11 Feb 2025
 00:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com> <20250210082805.465241-5-edumazet@google.com>
 <67aabc5aea2eb_881f329441@willemb.c.googlers.com.notmuch>
In-Reply-To: <67aabc5aea2eb_881f329441@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 09:08:54 +0100
X-Gm-Features: AWEUYZlcy_kS6VrXQ4VNvdG863uJ1heRn64upn1OxCxhvJVlKRWOewPKxDOzKY0
Message-ID: <CANn89iKh1xww10fQtcZEWBdOCYTxX98eMPOZ_5guBtYwwZvduw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] udp: use EXPORT_IPV6_MOD[_GPL]()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:56=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
> > to be exported unless CONFIG_IPV6=3Dm
> >
> > udp_table is no longer used from any modules, and does not
> > need to be exported anyway.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Should udp_disconnect be included?

Yes, it can.

>
> And perhaps udp_encap_needed_key. The only real user is static inline
> udp_unexpected_gso, itself only used in core udp code. But not sure if
> it would cause build errors.
>

udp_encap_needed_key and udpv6_encap_needed_key can both get the new
macro, thanks

> With those minor asides
>
> Acked-by: Willem de Bruijn <willemb@google.com>

I will squash the following in v2, thanks !

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 73ac614beb109146c5635aeeb10c2e9f77a6ee1c..3485989cd4bdec96e8cb7ecb28b=
68a25c3444a96
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -808,11 +808,11 @@ static inline bool __udp_is_mcast_sock(struct
net *net, const struct sock *sk,
 }

 DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
-EXPORT_SYMBOL(udp_encap_needed_key);
+EXPORT_IPV6_MOD(udp_encap_needed_key);

 #if IS_ENABLED(CONFIG_IPV6)
 DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
-EXPORT_SYMBOL(udpv6_encap_needed_key);
+EXPORT_IPV6_MOD(udpv6_encap_needed_key);
 #endif

 void udp_encap_enable(void)
@@ -2185,7 +2185,7 @@ int udp_disconnect(struct sock *sk, int flags)
        release_sock(sk);
        return 0;
 }
-EXPORT_SYMBOL(udp_disconnect);
+EXPORT_IPV6_MOD(udp_disconnect);

 void udp_lib_unhash(struct sock *sk)
 {

