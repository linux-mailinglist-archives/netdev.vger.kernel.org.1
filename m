Return-Path: <netdev+bounces-298576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OiTSMk/dK2qWGgQAu9opvQ
	(envelope-from <netdev+bounces-298576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:19:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71069678A82
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:19:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=bBME3aOj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298576-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298576-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5598E30FF885
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77503876BD;
	Fri, 12 Jun 2026 10:18:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580A3845D8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:18:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259533; cv=none; b=QBtCpyqVPjwlw9MVDTATxYCReqvH764hDKvrBDAjRzAB/jLUsNYSLlfpI/Zv8R//DOmYYWiiMbq2IW3QX47F0FXEstmz4AILpiqD4vQJIJ6247LZgeaJEQylmApCd3c55ai0AiRIBJlXNMDkbthbSKXOnGoqNzRUiawoFtztaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259533; c=relaxed/simple;
	bh=Iu+WsPA3d5zC/vpm66sf0PXFm63IcdCvAGgoL0vzIyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiwB5xuKSX5v9NXOPRz3ezuQBmVOv81h/gP2K1heFdXIm3Pf7trS3RM65IvugnaYCAEYx1q2raPjnlQTvdAJl6GB5jXPdpMT+hFrbCWlBEj+FnfzzUeshTrl6Z6p1H9o+e0xz3ZBs80Z89CWBsl/osrtrsPS6k3CVk2PdJ1QCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bBME3aOj; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so9319255e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781259530; x=1781864330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZYS51t2QXr2ZWiJCJ2esfR2JgSuWZes3mVwU5icUks=;
        b=bBME3aOjy09Ne3TOuJciwQgMQrD3QA56oZBnha0V1aiAml8vZFjlLytwRDLcbAjTfK
         gs0paoiXwr+SoduVvkIUms0MRhDY4psKxnYztyMXaCgHdKmYEU1TrRrQrbGmf78LFKLy
         Nb7MwXBQq6cZ5ahJc1jkRoGezwCEYiQdNVic+lM3Sq67OQ6+JDEzb5aqGGVaMTwwdG8l
         Y1dVVIssm8yet7XPKGHJgxwSWw7e8nfefziTDbuAI1WXNifv4/FxN7bnwKl7QZznlsK+
         /L52yU+EIT8vhOhbInFxE4932yW9o6b9QOztuVi07hqQf1r1TUk1zeLIEwTU7TKGdYaS
         IVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781259530; x=1781864330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZYS51t2QXr2ZWiJCJ2esfR2JgSuWZes3mVwU5icUks=;
        b=Gh1Gv4Dp3P4Ej//Paw+0PE9SH6p/8uOp5PzZXEdUtvM/sK77mg397gq7/S6E/KlkQZ
         RUPT7jqqdEp0/CHtYTD1fZN8Y6uq5H77rqO0dOvcmmJGQuaORxyhBtf5hCWtCwlvOc3G
         /nv3qD2Gxm6EUUQE3gDrrCaxLPdNYXALKIuTwN2X/kSaFzy53mP1p7/SOHzwb9aic+wf
         X/zVgU8wvBa+CWbNSvu1T4cJ0fYzBhyDCC72Skn8tzWYN23S6Iu48dcou4lmsYkuvF3J
         UNj6mUTpd6uEeNlNsoDHJtsBjTTtQSz/PRpv4F3qwg/C0AvuMr1IoahyPMjgepgsZgQI
         G34w==
X-Forwarded-Encrypted: i=1; AFNElJ8OzjJXmfFmNiiYdAZL5TKlLdjhIBol3an6EPA2gt0tdUdPBpVLAxCjBnyvmtJSkfXtX4mXG2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7J2GeU9cDa5P3lDkM9/dA/srgn9pkDYJEAE14KVi6pPdb0dzb
	OT608q6cWAk0wlmgz9Pdaimfw2g/AsDlNLhHvfX8xjTkWnAp5AYME2TTEMVozlU4fmw=
X-Gm-Gg: Acq92OFbT/oI7PiwKGTtDIdsAJ+jnSLI3iCKRqBOt3P1P0r5xnRqLza+5vcsUwOdvgG
	13Uqq03k6itM5SR/zdHr+91xeyc0ziVErdjiVQwQyNi2AYqzwERI4HOsCtKuVELyst/57z9MORJ
	00vLjJyEpJhAerjJvXehfAmjhED7q4hGUYexwGRe3SXDyxdUeQ3pF15I9epiK4QRBtTShSBRHaI
	ARTt6yByrYM3LCAr5ounwphmx5RrmtbnHtsXySYOBm9vJLm+0rUxdQT95j8hxiawxXpLjhZx9YB
	7wq4R2gS7iN1wiOpdVrjMsRCSzlr9uPlYcvz79wuw4zghdJQQiTmDz9XbHZYp0eok9zCuClyPPY
	wFcZYERwMauxZRV5p5WPNEb48O6JxvOnuLQgOYPD3HA/ec4o3BPorDmuVzrgCCpi0MA0kG51UJ8
	m20eNisAYKo/BN9riltukwIrlBJGd8PXQVP+RRqZ+s
X-Received: by 2002:a05:600c:5493:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-490ec4f26ecmr26968165e9.19.1781259530302;
        Fri, 12 Jun 2026 03:18:50 -0700 (PDT)
Received: from u94a (27-51-56-85.adsl.fetnet.net. [27.51.56.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95342sm2857806eec.29.2026.06.12.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:18:48 -0700 (PDT)
Date: Fri, 12 Jun 2026 18:18:39 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Zhenzhong Wu <jt26wzz@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, eddyz87@gmail.com, 
	stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
Message-ID: <aivZ9jYGw6QRxLQQ@u94a>
References: <20260611160749.391279-1-jt26wzz@gmail.com>
 <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:jt26wzz@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,google.com,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:from_mime,r7.id:url,vger.kernel.org:from_smtp,r0.id:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71069678A82

On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
> > Add a verifier runtime test for a branch pattern where a helper return
> > value and a related scalar stay live across the same control-flow
> > sequence. Rust/Aya-generated eBPF can naturally produce this shape when
> > a match on a helper status keeps data derived before the helper call
> > live across the same branches. Such code commonly uses the helper return
> > value in r0, where 0 means success, producing an r0 == 0 / r0 != 0
> > branch shape.
[...]
> > +SEC("tc")
> > +__description("helper retval linked scalar pruning")
> > +__success __retval(0)
> > +__naked void helper_retval_linked_scalar_pruning(void)
> > +{
> > +	asm volatile (
> > +	"r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
> > +	"r5 = *(u32 *)(r1 + %[__sk_buff_data]);"
> > +	"r7 -= r5;"
> > +	"r2 = 0;"
> > +	"r3 = r10;"
> > +	"r3 += -8;"
> > +	"r4 = 1;"
> > +	"call %[bpf_skb_load_bytes];"
> > +	"r0 += 1;"
> > +	"r6 = 1;"
> > +	/* success path keeps r7 independent; failure path links r7 to r0. */
> > +	"if r0 == 1 goto l0_%=;"
> 
> this exercises linked registers with BPF_ADD_CONST logic.
> We already have such tests. Why do we need this one?
> How is it different?

BPF_ADD_CONST wasn't what was meant to be tested.

The main logic is r7.id == r0.id only happens on "if r0 == 1 goto l0_%="
fall through, and does not have such link otherwise. I only check tests
added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
sync_linked_regs() precision tracking"), but it doesn't seem like such
conditional linking was tested. 

The other rational is that this seem like a common pattern that is
genereated from Rust-based BPF program.

> > +	/* success path keeps r7 independent; failure path links r7 to r0. */
> > +	"if r0 == 1 goto l0_%=;"
> > +	"r7 = r0;"
         ^^^^^^^ conditional scalar linking

> > +"l0_%=: if r0 != 1 goto l1_%=;"
> > +	"r7 <<= 32;"
> > +	"r7 >>= 32;"
> > +	"if r7 != %[test_data_len] goto l1_%=;"
> > +	"r0 = 0;"
> > +	"exit;"
> > +"l1_%=: r0 = r6;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_skb_load_bytes),
> > +	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
> > +	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
> > +	  __imm_const(test_data_len, TEST_DATA_LEN)
> > +	: __clobber_all);
> > +}
[...]

