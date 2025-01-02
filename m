Return-Path: <netdev+bounces-154717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327FF9FF8F8
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628A718829AD
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B413D51E;
	Thu,  2 Jan 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHZx5obM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D43A95E
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735818674; cv=none; b=O36RzS9I82Ii5pdaW1rRe8i/Avx2no+gFV3K6YxVi6jMZ3GV6bFW2m7RyNrMhIKYBWw2ndACEsMC7IP+05pQaO7JWkyuzFvKBGSpvnV0Hl4vh6WCkbtRbgeQB+KI8tnYnag7cg4Tb+vrutDuBl4Eupp7T4F5LZ6xtgLqmHz32gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735818674; c=relaxed/simple;
	bh=cNaYHTAOZoeR/twTUzggyo1IE3ZhxN5JJeKSUuHJgLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYJTjhjVUE+LlagpCGj9vG4avF8WiUvuQ7vuGvLaTGvbbETJIHUvJHy/iuJ9r3fM3dOU7kdcBmYPRB8jO7BnZMx2e2VFBGljEntJuqrEQ1k31QdOWBBEo1pZ/4/Mevx1E8zpNaWm0KT3js1qWr8QsXZNyuR6n35pTUYTWxpnp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHZx5obM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso13771214a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 03:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735818671; x=1736423471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU3KDcWlMCobf4fcpB1Q0kWJ/13iIsNKoDqoM2RYIr0=;
        b=bHZx5obMCbpwsaPWVfEcEADppTs1l9nkXLXsZaCG1JD5jhbmH+WiTqQvUWwzxQxodX
         WU3flM8oGIG+BOFgkevVSshBDIlgyV0IFeAALNngV5lw/T86ukIJhde3g4pC4Pabad9V
         N6UB8LbPNERxrTEZiMSewgRvK+wy0AA/oF85zCzo3QmRk6FiBX/DRfQkD/aqPGzgGO5+
         4Wg2Q/vMdU9Ml+vDJa4l7DlGMYLPOiJ02jk4O4oiqXygKNm/ajzVlNYGrvc1CCADh6ek
         XSHUbbj+GpBFZNQIb0KaokbcXpkVkSE61VXN8CdxTTVGluR32sJf4TerXUu1bTY34cL+
         cjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735818671; x=1736423471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU3KDcWlMCobf4fcpB1Q0kWJ/13iIsNKoDqoM2RYIr0=;
        b=giMSkKKxkjJtzHpbJkcxbtr7Ya2U37GApjp4pDJmjy2rjm/KddzcbGzwrE8uKi/q1p
         ubk4bQLIsd+I1g5SJD0EWa4eqTjve8buod7dUNNvg6KL8O6x3Vl0aesTtxgIoToJn0mJ
         XYj5HWGViA1wo53c+4lJSR6jafC9fvegVgFeiFYYCCaFaBWplqdeKdB1lkK9/xKJn3vQ
         HHglxNWrfASZiXbv/eWX/kPoB9oSwT5cBz37WDGPSf0tQMrCWKIcy+URttdxG5HLZ1GB
         DpysIrKZarn0SvIIyNumqbkgOfebVIoAwbc1ezp5YlGahP9AW0XMrRZA1vzMf9Kvi7Wp
         Lyqg==
X-Gm-Message-State: AOJu0Yzg/MjX2igHWn9l9QS8YwU8KBEDuw/kkVZ6iCxMRFbyIqase+lt
	/pj/2uAniQ25PS4/WXQhbVz7Jv+FP4H9+3Qdf3EPs9xoyoDSlJMSx+KrABTdHJPwjh4jD+fnpDH
	VB1M4AXtUQuP//YexjTf9hCRuZ5IKCnUtaJvC
X-Gm-Gg: ASbGncssupbnB0Rg5VylhHnt16wohaSZZ+OzQ5jxAS6NtDSXg0G0Vp4NtUo36NWg3EE
	aKqa8esdKMoG76iIBW0xLdSiyiYXUportyLFsnQ==
X-Google-Smtp-Source: AGHT+IEQh8U7vOgFqrxkmkgucPPKZaJussRisSbpRbaFF+9JM6pAxkiCU+q4UYOi3eJDnbm6H0/DMPtGVCiAFYeCG/M=
X-Received: by 2002:a05:6402:3581:b0:5d3:bc1d:e56d with SMTP id
 4fb4d7f45d1cf-5d81de086afmr39086567a12.31.1735818671076; Thu, 02 Jan 2025
 03:51:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250101164909.1331680-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250101164909.1331680-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Jan 2025 12:51:00 +0100
Message-ID: <CANn89iJP4unWmk2T36t1LiFrchy+DSGkbZWz_i42mb1eCDXyeg@mail.gmail.com>
Subject: Re: [PATCH net] net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, benoit.monin@gmx.fr, Willem de Bruijn <willemb@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 5:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> The blamed commit disabled hardware offoad of IPv6 packets with
> extension headers on devices that advertise NETIF_F_IPV6_CSUM,
> based on the definition of that feature in skbuff.h:
>
>  *   * - %NETIF_F_IPV6_CSUM
>  *     - Driver (device) is only able to checksum plain
>  *       TCP or UDP packets over IPv6. These are specifically
>  *       unencapsulated packets of the form IPv6|TCP or
>  *       IPv6|UDP where the Next Header field in the IPv6
>  *       header is either TCP or UDP. IPv6 extension headers
>  *       are not supported with this feature. This feature
>  *       cannot be set in features for a device with
>  *       NETIF_F_HW_CSUM also set. This feature is being
>  *       DEPRECATED (see below).
>
> The change causes skb_warn_bad_offload to fire for BIG TCP
> packets.
>
> [  496.310233] WARNING: CPU: 13 PID: 23472 at net/core/dev.c:3129 skb_war=
n_bad_offload+0xc4/0xe0
>
> [  496.310297]  ? skb_warn_bad_offload+0xc4/0xe0
> [  496.310300]  skb_checksum_help+0x129/0x1f0
> [  496.310303]  skb_csum_hwoffload_help+0x150/0x1b0
> [  496.310306]  validate_xmit_skb+0x159/0x270
> [  496.310309]  validate_xmit_skb_list+0x41/0x70
> [  496.310312]  sch_direct_xmit+0x5c/0x250
> [  496.310317]  __qdisc_run+0x388/0x620
>
> BIG TCP introduced an IPV6_TLV_JUMBO IPv6 extension header to
> communicate packet length, as this is an IPv6 jumbogram. But, the
> feature is only enabled on devices that support BIG TCP TSO. The
> header is only present for PF_PACKET taps like tcpdump, and not
> transmitted by physical devices.
>
> For this specific case of extension headers that are not
> transmitted, return to the situation before the blamed commit
> and support hardware offload.
>
> ipv6_has_hopopt_jumbo() tests not only whether this header is present,
> but also that it is the only extension header before a terminal (L4)
> header.
>
> Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 hea=
der contains extension")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Closes: https://lore.kernel.org/netdev/CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCt=
se_BTNki1pWxAByTQ@mail.gmail.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Willem !

