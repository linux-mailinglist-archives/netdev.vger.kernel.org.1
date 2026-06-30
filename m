Return-Path: <netdev+bounces-303370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id akaRLtkyRGrJqQoAu9opvQ
	(envelope-from <netdev+bounces-303370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:19:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 104EA6E8170
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:19:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ya0nPVOj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303370-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303370-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A2E0306A17D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72CF2D594F;
	Tue, 30 Jun 2026 21:18:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA0202F71
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 21:18:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854308; cv=none; b=iQznDtvgpHOc5lKek9yTnq7ReKMah8idZf7xYuOQOlhY1z1LbMNvrVpVEAlWdEwck5xzbp1m1dhie2Z5YOdI+GSfEWdM3pB4XOP7j13dkjoIt3Lbgb/xMsrDOAHGYmnHZMMO3UaKYm5Nr9qAP9GrJgceYcUuR+Ov10P6W7WHLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854308; c=relaxed/simple;
	bh=fcmANZ004Q0lNW7yrfpsdAerR3yiHCf/824ByPXnnIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXe0dgLDzWI4cHwP2vh5T1c8I+dDEMG2FFqvEkzsutEK/qG5ZEt14Dh95zAu3aI4+O0pWkV21D19nLMOKnk7r88qTjNkkhlFQgodSWxM2Qo8EQqUltZpTQ/+vjD+OX4vBYITahy6bhtJh5OZ6UNGHbJB/kbEGcwhPnuaBEXZOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya0nPVOj; arc=none smtp.client-ip=74.125.227.130
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37ffca5d434so489a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854307; x=1783459107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2r2hvWyxJvr9jrBQHVSlf0QNgNk9jJsPhFYeRiWKWmI=;
        b=Ya0nPVOj4inlsFXwboOIrQiikl9v1N1LdUlTYyNIbi74K/8ni4kyw5WxoRtIJHsV+Z
         E2wiDRaxD2VcV2QCIreliQyALK3zxQ3IsY9hkoQrwiKJ5XLjYyu8wG7zoNBVK3WpO/Oh
         cruVXTy2zjrdzMgP6HfdmAtER4350QMEquX19d9wU5Eu9SWe1igsuFCIxpsWUY6s021a
         KO9pVRrO3yIkmjHSUNLUcBCjDjGVa3/n8P4djmHK+eBNyfif6WSyqhZU4sg5o/V2stHR
         fSM1kTkilcYCkHByAFM5ENxyGHC7o8QrfjoJy9h5iYzjaEHtbGaLNlMfWFq0YnS7LsQO
         MjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854307; x=1783459107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r2hvWyxJvr9jrBQHVSlf0QNgNk9jJsPhFYeRiWKWmI=;
        b=geZxPrN15iHOzdUmFCBUkg5XgCn2FOTU+NqVL0IAqf952sDLq0vzMNx8qMbBvaNYZP
         3G4lcf9VFtmQVtjPLMCcH6BNryv9gPwNcf8OukBIzUi9u+7g8uj1sFM3WvUDLVN1LZVT
         RA8lgrCU6BBuFUL6GrlSqsSKbDoCACbxjZZKfJhOX/IuMQxMqdiB51twe7tXMcRyqgQ/
         2zKXngfgbhZJg9RFc6PNAS9qlVaYRrPeLYvUGRZ1MnwfTMb0BIMiTOfLbMLnIT42nEDd
         WJHw4MaNNjE+fgYpgI/Ei9PkMb/mztKqhj04CbjzgsgKVPDcHp6rfM97Mgjj3zW+EKY2
         io5w==
X-Forwarded-Encrypted: i=1; AHgh+Rr2tW6Uo4xeqDV0v8W8TkpSYHVeaRwC3zHorURgkgTvtumZolaOglGWb/n7IRmX7U+ZfeqwQyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPz/NqDZ3QJ8ysfnJhU8a8f1TXKCRFrRPZ8KZQWhYpQkZbQXCG
	aVo5nJF5aZxtcgmZ8fAv5/gKmVS26fRFRspSngHeXPbQp4pS/yJWLRYN
X-Gm-Gg: AfdE7cnfpV+rvhi+3bkSUtu1jQnyIji8k8yaYakSIf+OlfBWROiS4kcvmMYnkNEnbEQ
	kxZN+JASHfjWIwmAVlVPL0KizQhZKCmOm/ELuWkSs7kvtClkxd3B3ZnfcFqpD9JWEncbYahKSvT
	GcPKi/WCkuRJsloSfvfP3C3bp+nEz1a3XKP4MbFde35QfgbnGadmwT9pJCP4PJwtbRcgFHXlsaY
	0dvjvWW07d46up1qEJAW/LTqJwH5GPW7UZqU/Oi9ik1/fFcjQZNR5+DlJVpBrlU5Y1yggGROi+6
	5KI+KOu71MUOPBuuRhqrvMs+mg7ZeDWH1F9jLZWowFPirAcP+YSpM8qWOc0pr2jNXDcYqzMD4bx
	hgkSwQEpizWYM+9ER+PtvZQ/3JJMsVG1NVeWb66WFvrJqHKfG6TRa5xIQRilvTLVbc095mu99Jd
	Mjxd9nKw==
X-Received: by 2002:a17:90b:55cc:b0:37d:a52a:ff12 with SMTP id 98e67ed59e1d1-38068b9afabmr2435095a91.10.1782854306807;
        Tue, 30 Jun 2026 14:18:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d8c8cdsm597450a91.7.2026.06.30.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:26 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:18:22 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, lorenzo@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 0/7] xdp: RX checksum metadata hint and
 checksum assertion over redirect
Message-ID: <akQyT2d0wNF5F5LG@devvm7509.cco0.facebook.com>
References: <20260630191510.81402-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630191510.81402-1-deliran@verdict.gg>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303370-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:deliran@verdict.gg,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:lorenzo@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 104EA6E8170

On 06/30, Vladimir Vdovin wrote:
> This series lets XDP programs work with the hardware RX checksum verdict:
> read what the NIC concluded about a packet, and carry a "the L4 checksum
> is correct" assertion across a redirect so the stack does not revalidate
> it in software.
> 
> When an XDP program redirects a frame to a cpumap (or any other path that
> rebuilds an skb from an xdp_frame via __xdp_build_skb_from_frame()), the
> HW RX checksum status is lost and the stack revalidates the L4 checksum in
> software.
> 
> Two kfuncs are added:
> 
>  - bpf_xdp_metadata_rx_csum(): a device-bound RX-metadata hint, like the
>    existing rx_hash / rx_vlan_tag ones.  It reports enum xdp_csum_status
>    (XDP_CSUM_NONE / XDP_CSUM_VERIFIED) and is implemented for mlx5e, ice
>    and veth.
> 
>  - bpf_xdp_assert_rx_csum(): a generic, non-device-bound kfunc that lets
>    the program assert the L4 checksum is correct.  It sets a buff flag
>    that rides into the xdp_frame, and __xdp_build_skb_from_frame() turns
>    it into skb->ip_summed = CHECKSUM_UNNECESSARY.  The kernel cannot
>    verify the assertion; the program takes responsibility, as it already
>    does when rewriting packet contents.
> 
> Posted as RFC to get feedback on:
> 
>  - whether the read hint (bpf_xdp_metadata_rx_csum() and its driver
>    support) belongs in this series at all.  bpf_xdp_assert_rx_csum() is
>    self-contained and already covers the main use case: a program that
>    computes or fixes the L4 checksum itself, or trusts the source, and
>    wants the rebuilt skb to skip software revalidation.  The read hint is
>    an optimization for programs that did not touch the payload and only
>    want to relay the hardware verdict.  These could just as well be two
>    independent series (assert-only first);
>  - the kfunc naming, bpf_xdp_assert_rx_csum() in particular.
> 
> Testing:
> 
>  - new selftest xdp_cpumap_rx_csum drives a frame through a native-XDP
>    veth into a cpumap redirect and checks, via fexit on
>    __xdp_build_skb_from_frame(), that the rebuilt skb is
>    CHECKSUM_UNNECESSARY iff the program called bpf_xdp_assert_rx_csum();
>  - xdp_metadata calls bpf_xdp_metadata_rx_csum() over veth and checks both
>    verdicts: XDP_CSUM_NONE for an AF_XDP-injected frame and
>    XDP_CSUM_VERIFIED for one sent through the stack.

This was posted somewhat recently from Lorenzo (and had a fair bit of
discussion), but there haven't been a follow up:
https://lore.kernel.org/bpf/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org/

