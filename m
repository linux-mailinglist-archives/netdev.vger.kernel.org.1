Return-Path: <netdev+bounces-268276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIMoILNuuGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:57:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010FE2A0753
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0BAA301CC75
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1B35B64E;
	Mon, 16 Mar 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxKeZcfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94A35CB75
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694637; cv=none; b=T1HnYwJLF60doSydTgupmsWFA31ggNUwM4LocAIc4rvFSY9KYkIPQKsg7xeS4eWI5vgjwcwa5LJcO2tjUj3fTB1/hCmMaZz2R3zGxUPoGBlT6VvqKMAapszWct94WSe05kM2KQJfOdF9u5PcFYnoJjKlVqrA3upkWSJPqKab1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694637; c=relaxed/simple;
	bh=D7y7XQHaMsKBo0fZQqrBDSh9xP5an1NYpg26xhytOSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbFl1XChDLKPN1gJLsY8JCsOzdpWsXsblCr2MLIjmjaJIYZlDaabdJ947o+vatmuVS7LMHDbYb3eAeU+3zeNtUQ4/FK6O4dHzK9Ct/5raajoN7scZMKO+v88kENKERboGXpBt68S7OMhVzk95p+yjNKFvNLQfar3izcKUhL51Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxKeZcfl; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7123455eec.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773694633; x=1774299433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7y7XQHaMsKBo0fZQqrBDSh9xP5an1NYpg26xhytOSU=;
        b=kxKeZcflp/SHR4lUssQjDuTWXRttu1+Poob7OSllmhM8+H/K72CSenYPxt2tYt9fVe
         PTh35w2UXDXngRtpt47/tcz+HcIhjA61K/XCmyDvK6suYTVhl2CKCrLS7mGSnOegdAhO
         iFM0PwYH6o97QoPtqG88GR+iwXqq8kRoAOQ2CFWVZyF+Eb9qLsxNJQHkWiagkggkZk3P
         s21V0w0dXzdO5PBKaNXF6RWVW83myxiwax0FTNFI29wTNAUzzA49SqM2olsD+2X88SsF
         LRnxr9LqVXmXCfuWNC8HGyPQDo5b03t7UuRvMDoRFU9w4L3H2E6/+XcDS/Y/u+H/2s4H
         6xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773694633; x=1774299433;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7y7XQHaMsKBo0fZQqrBDSh9xP5an1NYpg26xhytOSU=;
        b=eAZ8Rkmx8yZg4eV8QkadT5ViwwIxZbvHaQ1cG8RXMZDheZG8SvoYjzfpgCqNSAFomg
         O5kxcY/khKeDuhj/W4DzG8w+ISYJ65ZJuTxg2wucu5qyKi9NFcsW5N2oF/kqi2NX4/FD
         f6rY7sQhrO6RANScL6XbU6Elt8VCkBJZn1FjjwZnnCTWVrFf3++3NLOxsaL9x5XfDQDs
         AkhSRvUPC8f5TLQx8jI0VG1oZgjN/M9IysP5OnjoljEbxSK8SOcANB0Fu0f4P5cw6TD1
         csdihgrA7GxoumzX1n1gNhv20ax+IZtZ8hP5H8YRw9HOh1pFUQlWhxH3fKjkzbPB12hF
         ZiDQ==
X-Gm-Message-State: AOJu0YxNIx/YpzIPWoCctjwQg5L3SGfuKMNT41PSwNXhG1CEojS9Kfvc
	DcjJPpbdCarFw92P4LyjbEB9Ap/SEAfxIIT4gUMReAFmO/kULuR1eouhkSMxFmCF
X-Gm-Gg: ATEYQzx2fMQ68WTLpH8SOcQ9hpoeH1Iou+YrGbIbPI7kuPFIcVI0uC1A7m6OcOAjZYS
	fYD2LzJkZy0VB2dMSdCue1GPKX5KphH7apyatI99zP8cUZ7ZG/zsi34y9g2uGw5gTTFeSpqBPKs
	UupIgrRWMw/PZ2RTekLlDmYKmsr7UjlZU/4LxWUCvx4wTTLEm+GTth6VXzgRjvQCmFNupjDMdUK
	CNfu81oV1GsyL9MLRHttperRgPyfT3aJbRCApcl+nchonqxriUCQpsT82ZX8rfRZrJSfFiqxUoX
	v2Mi4A2QeYaoEFiC4z09X33kJ/70wPb8u//9lzsuWp7XvKH06up2H5LksxUalDQWVJPTzEW9GJ7
	Q5gRHFcpmJ0solYHWOlH2CRoTdNhEjblbkw2+3m2dp5eWwCnog3x6hiiifZkruXshg9QDCk+Mpy
	UAadSzTjF4B0esa5ma65b9tXozg4LGZU1gCzfWdoyHaokKySQdi6tEbsu9m10=
X-Received: by 2002:a05:7300:8b83:b0:2be:2964:44c3 with SMTP id 5a478bee46e88-2bea547ccb8mr6542994eec.10.1773694633132;
        Mon, 16 Mar 2026 13:57:13 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0c34sm15964777eec.7.2026.03.16.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:57:12 -0700 (PDT)
Message-ID: <29e5aa5fc5a9724d0c3737297fbecd3a3eae76cd.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type
 flag based on prototype
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Date: Mon, 16 Mar 2026 13:57:10 -0700
In-Reply-To: <20260307064439.3247440-2-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-268276-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 010FE2A0753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-06 at 22:44 -0800, Amery Hung wrote:
> The verifier should decide whether a dynptr argument is read-only
> based on if the type is "const struct bpf_dynptr *", not the type of
> the register passed to the kfunc. This currently does not cause issues
> because existing kfuncs that mutate struct bpf_dynptr are constructors
> (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> additional check in process_dynptr_func() to make sure the stack slot
> does not contain initialized dynptr. Nonetheless, this should still be
> fixed to avoid future issues when there is a non-constructor dynptr
> kfunc that can mutate dynptr. This is also a small step toward unifying
> kfunc and helper handling in the verifier, where the first step is to
> generate kfunc prototype similar to bpf_func_proto before the main
> verification loop.
>=20
> We also need to correctly mark some kfunc arguments as "const struct
> bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> argument and to not break their usage. Adding const qualifier does
> not break backward compatibility.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

