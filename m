Return-Path: <netdev+bounces-176754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50766A6C000
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C411724E4
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53F1ADC6D;
	Fri, 21 Mar 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+DlKpyl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E14431
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574824; cv=none; b=BMPS3imPBUF0U4mpvqJyx9HIM+q5jxwwVR8adG/BGDTZqqe7huX6v9zxYwOYyj+ZgJrTupLsV4T4aQD6hB3//kpMtJJvDoa+zWMqD6Sp8FHsxflojz1l8g4gumSKBB6t0fzAWsLHHlsAMWyBDdhvCIefC44KugSAwFT2iby63A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574824; c=relaxed/simple;
	bh=YqRXYYe3p8JvpGDRei6PLMfsoWOlng3+rtwPuNJdrVg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QHniGl2AptU/9atbMjRK3ytM7J18G3IoVzlU/H0pIFMeIwW7hYwda/HpJkb6AauJS3Ohpo1VNJRqZUZUAgVNQYRVe7Za76QAnGoAhvkYv+5N4ioUn+Gk3IJYNWLpMND3zG83UNuuap+IkqY1+4+Y+rvjiAoQcWA13zHgrEgIuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+DlKpyl; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e6c082eac0so18835306d6.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742574820; x=1743179620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfG1XmeYXtvii9gg33jsGFmVpbAwMvg4tFsWF1X/pYo=;
        b=X+DlKpylnCpTerbgb07XEfWX0Q0t2F97niP7rC7CNaOVyNIBKSMl3tkOMzTo6LWPRL
         T49WfxNs5yx673ktl/fqRYJJUGrB6rFiqOVqELFf30L0PIumyoBLvIkBiWdcrqKpQhXL
         L6Zpw56aZlTrKH9FSDD94CB/wnl7d+mRTFiAKOdUcY4j1GXPiJ/Ueab/pj7t50plXG0Y
         NJU3g2Cv69/2nchtXZcCvIHWxd/J8y9s9dtaTKHwbgxdcji8LwqnZE/rUrVeOfv14dh5
         qt5qHV82y0/bfvEHZCrWgZy1jFGBRAfl0VZ74YMHu62deswGSwLvB/nBOktoyd5kCwL9
         8sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574820; x=1743179620;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EfG1XmeYXtvii9gg33jsGFmVpbAwMvg4tFsWF1X/pYo=;
        b=wk1OEiwL0KqC5luU35CVsLqVggWTyp/YsaQnibLq9Vrfa6kmKKdZqrdCrlsYrZ6cwI
         T9OkbAXQcqKKJbfzUBEtPCiEq9cms2Qkk4JfG3b8b5GXLYPHpQfq9vuDvCBMWp2zDwWd
         NgythJH0FfbCBSoCiAkci5QmspC5TL0GX/XrTt3OCwPje7xWAKIIZZwwY709jRAvIMnT
         KeWaQrbUEtqIqa19pGQf1IS+Lza0K95GADoJWnc+zmBFzairy5u9pmVfGmSOw94FOQ5f
         39Va+ciCKkP+4Tq3l7nEMzv/+Ftc6skY1Dejm72gUWdt8U5qGjBKn0q7dfhzQDxX0zzf
         1Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCU3vtf2B9ceJ7K7HulDB3HaQeyb93XLI2MFmNnFbD+PUTEV2CY97y2stKkOCeilu4TPQVIXAKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBba4f4y1f5+B94chCGBEUIebunqcJIu07iOJnTOPWq3eAuQPn
	FGk8HlbB33KuSMHucwQSoXXzDI1G+NV4P7kQ+xzO/TmmjYJsD2uP
X-Gm-Gg: ASbGncu4WnjCzyyLh0OPf+W3ZQgYotul788RO9BYugB+i56fFQtZFO48m33H7xS1aLh
	r878HcQvcAsjuhGBUXmQPlFavzhUp62cZgn06OJQosgX7C8c1JhDLj0tT07brEk/urkabsfVfh5
	o4idX8u4jtFIvZdS1iGN6Jxv5le0Fc75bp7qTZhddwrnZKVuGESoceh+2AT7TDR3Qef/K2P2vq0
	ETXdzhBYcCxHEwi50uZbEw5Wd2E0FnU+ZjnaXNoe1dMWnvWX18IDGHgP77bqmVCx5508uG7VHEH
	21OeCCcwWbeIrX/F4CqAhnnn4phnnHV80oOCfq+ffQQ7CxfZRxEQKvdi795rdzEkXpvcwNSuO4X
	MHUc5X7Pw39usgaEOz6G7eA==
X-Google-Smtp-Source: AGHT+IFB5rgvXcW0MxPx1WNCZnBd7K1asqcE3dWDBI9WKAU/L53/qV5kwj1pn+c91XIsm9OKfoibtw==
X-Received: by 2002:a05:6214:1d02:b0:6e6:5efa:4e01 with SMTP id 6a1803df08f44-6eb3f2d6f7fmr50442676d6.20.1742574820052;
        Fri, 21 Mar 2025 09:33:40 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efe0ca7sm12733836d6.98.2025.03.21.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:33:39 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:33:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
Message-ID: <67dd94e315ec3_14b1402947e@willemb.c.googlers.com.notmuch>
In-Reply-To: <f4659f17b136eaec554d8678de0034c3578580c1.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
 <f4659f17b136eaec554d8678de0034c3578580c1.1742557254.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/5] udp_tunnel: properly deal with xfrm gro
 encap.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> The blamed commit below does not take in account that xfrm
> can enable GRO over UDP encapsulation without going through
> setup_udp_tunnel_sock().
> 
> At deletion time such socket will still go through
> udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
> trigger the reported warning.
> 
> Add the GRO accounting for XFRM tunnel when GRO is enabled, and
> adjust the known gro types accordingly.
> 
> Note that we can't use setup_udp_tunnel_sock() here, as the xfrm
> tunnel setup can be "incremental" - e.g. the encapsulation is created
> first and GRO is enabled later.
> 
> Also we can not allow GRO sk lookup optimization for XFRM tunnels, as
> the socket could match the selection criteria at enable time, and
> later on the user-space could disconnect/bind it breaking such
> criteria.
> 
> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - do proper account for xfrm, retain the warning
> ---
>  net/ipv4/udp.c         | 5 +++++
>  net/ipv4/udp_offload.c | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index db606f7e41638..79efbf465fb04 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2903,10 +2903,15 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
>  {
>  #ifdef CONFIG_XFRM
>  	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
> +		bool old_enabled = !!udp_sk(sk)->gro_receive;
> +
>  		if (family == AF_INET)
>  			WRITE_ONCE(udp_sk(sk)->gro_receive, xfrm4_gro_udp_encap_rcv);
>  		else if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
>  			WRITE_ONCE(udp_sk(sk)->gro_receive, ipv6_stub->xfrm6_gro_udp_encap_rcv);
> +
> +		if (!old_enabled && udp_sk(sk)->gro_receive)
> +			udp_tunnel_update_gro_rcv(sk, true);

The second part of the condition is always true right?

