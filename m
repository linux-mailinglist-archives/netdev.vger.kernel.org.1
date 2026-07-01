Return-Path: <netdev+bounces-303416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jBjNFvdaRGqPtQoAu9opvQ
	(envelope-from <netdev+bounces-303416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:10:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154F6E8C7A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sZnry86D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303416-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7037B3023DA2
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C12AE68;
	Wed,  1 Jul 2026 00:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278631EEE6
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 00:10:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864629; cv=none; b=LNgT03Fxn2ehO1p97sG56JIJeTzLMO29001m4Idyf4I6BIjk4cbBJbFqqVXwMpuKKi1n8SWv46Pu9Fjge9JpI4GU0RBrGRhD4jydSZu1lwTDMBJnG6WbllBONiUGISq2LWF6KrGLWr17KX+ZA3lU1b7QwSdAa9t2d+QXMATIYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864629; c=relaxed/simple;
	bh=h3OPAHc6C1XvzxT6cx8e7622PtDg/GnQUlgHe9kP9os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL7AaZl0lPltgNtrWmqAXb52C07GW2D10zSbW6eKMXG9rmd5J9IEnzEsZUXdAnzPy0kqcQXl675O34X/o0Df2oF/zjph1/vUMYE8scLep8e2aLj/3wZibu1eCZboE0+WEhvr88l0YGIi8SxUsUt0c+QEeG2H2DjFEqYDVDIL+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZnry86D; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37e4098e920so34802a91.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864627; x=1783469427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qbc/GpNfKXXWiTDBIO3A45WUQ8ek6nJfHhq11a1Wyk=;
        b=sZnry86DLFBVU4Yx86holz0W0Pn1Tgh9/UD1qG2Y7D0Km2njR33nHiDuI5c5Mf5YIQ
         kpYn/NaglyUFNJJXpM9xmpUrMXRpeVQW4CZ/EDKthWb6xKD+MhSa2lpxqs+jSWgXDW0C
         0t54qjCUuhDsQFdU3pwGXmdh0OSThbjA/MWJUE4P7uON/msuds+BixO31wIh0K1kg2xc
         Ug5GAOOaqwvk3/w7c4Bkj6fvn6nmC/qfrecLrH2q9X8/QemCRvri96a7E+DQBZ7rT2vu
         gofjkdPaFHgbuz4xrrIZdVC5XlU+HbyYe/mD6ZHeh9+rv5bVuVp79NNeXuQtlUt9vQhn
         ymDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864627; x=1783469427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qbc/GpNfKXXWiTDBIO3A45WUQ8ek6nJfHhq11a1Wyk=;
        b=Vd8P7ub/AM1ZEeQxR8s7YzMeyD1LgjdvVcG+pjAeDtp1zFvJ235y9z9rFw16jTMiqe
         +DLT7VLs7fQPend1adkRj0IGbZvXmQSllcCNFzIF4KTJ4HLdyYx4Ke2C5jZuelAZsXov
         GlklhgajH5ahefbCj8B1JHJLLW05ivbOiM15mOBB5YRs7yYAfSW8x6i/I3HXIb6SE0/4
         6AOBzJi2o5WqQP0AJ6D4DA0jKB4+lwFZ6fBgni7rvqaob/ATHwLhP0owqs/EvW0XUVff
         1MihE81K8L4+CfqKj5ei4vrVIeW7KGtYJosRh3D6G3V56KTKqhfbrOLyd0Vqr/SLQJNk
         tOfA==
X-Forwarded-Encrypted: i=1; AHgh+RqUFWjejCLINiGVduGtS9ppONMmM+gC1WFdeIEKG0nAc9Za1VYRld5nKZbmigg/Vn1AJsx6ILY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt2xdnCzy+U/yBdsl18bKLmgQeXuP6Copz+WUePDBUJZ9zJ5AB
	9jJGx60DVC/e2UYjFXuZ95k627XNAlwjmcaxeyEQHMRHXD2Hht2N/PR0
X-Gm-Gg: AfdE7cmpYwJhOdlKH4X6FxxSVWBtcV91Vgx2y26FVmHBkbmqw1RIiBK/c4xIYX2t/pg
	pw5nK72a+VzI4hs5A1UMppw6LVhC+D+8T18LHPleQi23MN0TGVBt4KMWOt/cHMCCrGWakVLjJfe
	yf/gASWXS02PwuOQP3Ys9o+ChYwN6aiAWGelV2pTrUJlWGhHW/41D4e66Nr3uc2xmzNesaUyoHs
	CyXA7HFpdDnvDFdjmhAUtU+CXQhqLoxvJWrXh/DZM3WpDIV1rS5+WL4ijGpfVLaduKBGCHtAz3s
	purfnxGnaExT+w2S4c3tkaeSGJ16MH6WRaw+Ot8+7cqWGoaOV0p+QMTSK8IoyyMnvGHOY/941sq
	qbeAkESpBVcYfQgvl51okFHn78csZ4MH5GTLs3l/B8OqHHgOAuEs5YeMf6WY81KRpvCJmTL/sYN
	BIgu5QqVuMYA==
X-Received: by 2002:a17:90b:390b:b0:380:540:d49a with SMTP id 98e67ed59e1d1-3808bd2ffe9mr2231773a91.7.1782864627409;
        Tue, 30 Jun 2026 17:10:27 -0700 (PDT)
Received: from john-p8 ([98.97.43.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809646e38dsm675137a91.17.2026.06.30.17.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:10:26 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:10:24 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Varun R Mallya <varunrmallya@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: drop
 tc/xdp/flow_dissector/socket_filter sockmap mutation tests
Message-ID: <akRa2NjCanobYZSw@john-p8>
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:shuah@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:varunrmallya@gmail.com,m:ihor.solodrai@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303416-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,linux.dev,etsalapatis.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,john-p8:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0154F6E8C7A

On Tue, Jun 30, 2026 at 02:54:06PM +0000, Sechang Lim wrote:
>tc, xdp, socket_filter and flow_dissector programs can no longer update
>or delete a sockmap. Adjust the tests:
>
> - verifier_sockmap_mutate: the tc, xdp, socket_filter and
>   flow_dissector cases now expect __failure with "cannot update sockmap
>   in this context".
> - sockmap_basic: drop "sockmap update" / "sockhash update", which load
>   a SEC("tc") program that copies a sock between maps.
> - fexit_bpf2bpf: drop "func_sockmap_update", whose freplace program
>   updates a sockmap in the tc cls_redirect context.
>
>Remove the now-unused test_sockmap_update.c and freplace_cls_redirect.c.
>
>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

