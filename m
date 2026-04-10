Return-Path: <netdev+bounces-277418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EORAOZ712GlJkAgAu9opvQ
	(envelope-from <netdev+bounces-277418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:05:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 338803D7DA6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DED253037D49
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2820B2C3251;
	Fri, 10 Apr 2026 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU8Ds6kh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF7156CA
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826161; cv=none; b=LUE5XBJeXnDWcrWSUuyjwyfzuMOEcus+2NCQriepIM2Z2wm9nJPnjBu/xzwcGZJ+NvALYWSzNL8X8WeWk5Z9V0M2Jd58oGmmy5eeSjiqCpwPYlwTgoUHi+vL6qnvQCun6u5MCM3M8mVDDQvify+UACBQYVmPQmifRooEOJQXbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826161; c=relaxed/simple;
	bh=WrUzq7mF9Tkjd17cuGBa7sv6cof+mTghCXts2RO3AuQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XE1Cg2jl3gI44KOdQ5qZYJ3UfvWPBNWeagK+nXihzZbX64lSTxomXL5MDfUVywwh5ztcWyQStPoX3MzulRgptt+YZ7zdMi1fWoW1ufb2Bgeh7dWqnbdlm4ibYCBJGWeqJdfY6sU00lk2S3zma8lcKI/RFi7aSb+NE5nOueYDUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU8Ds6kh; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79ee5037d44so30123087b3.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775826159; x=1776430959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh+uRbTG2cQEQ4G+HE9Tsypegg9tybrhMZPOrs9UF2g=;
        b=mU8Ds6khZCG9xPmXYI4/PF924/uCE9anDcjgUJBvC1cExRbZ3gE62wQRoGxBgAkFPv
         W2NhtbbNnOm12JW3rT+FGYNnYgkdYVFAI5gUbUzp1jfQgJQxkTJYlutUxhFG35/93lMw
         Ye19iOeNOhpbsQ8fqvwWSGC0BQO6kiACmkvIJe56KZBHXNiCZHNQMpsmG6pTYUZBr+Ty
         2sNAWsWu8QMats+4sd7q4aGMwJxBzYNVxpfxl3asEWICUUL7pOZAFxt+Myxz5uU0sl1A
         hfRumHnd8bCXuwdwfVYLzBg0xzp7K35f0a+Ipl+GicJM43YDVTghRcg8bA66pqwzIzyV
         LETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826159; x=1776430959;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yh+uRbTG2cQEQ4G+HE9Tsypegg9tybrhMZPOrs9UF2g=;
        b=RyY2Dmo526ekq10hz8AMx/u6dztvkgWXrWhyOWQJXpHYhJSVtJfeIJSpz+IEDdQM0f
         K0GjamzW2F8rJBeu326fciv2AOT6bRtTPj4oq2dpR10/cV8WOXCU9uBU2AdHCq0o5g/F
         UwyR3F61LdmBfmnRX0mOIGvVqddnXItZ4w2BnfYWZit2nVO4Zf9N3vLzC5zaODedGpp+
         P8S98alye56gF7p4mHJ1VAip9AiYiEgm69qzpxR162eF63lZwDMc5tdRTEE5gBgUiXNa
         zZn+oMquy4+hGURFmFfJZk04nE+5Rm/gRDzmXDzvYKqjcOSFkfkysRiRLqKENOd52jn2
         Dw0g==
X-Forwarded-Encrypted: i=1; AJvYcCUy9G83X1B2X2P5Z02+QrOIpcxLvfxVNFtKhtLwTawBcyhOwWVD2e8LXwnOnlWLcydFd+vWLFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlnjag0jAqLX46a7FMEdXY2/aNYpiQQkPRghdl384zcBbtAd/
	ewP0k4EzPf5zRddlpX2lgUGLWtKgcIFnJtj2KzBMdQ0mxYACf+VE9/Ye
X-Gm-Gg: AeBDiesgW1QHxIfi5XOZOKw/H6S5Z54cgF0EyY4np4NFIPEb+5L0msCxBVkxMHF6c73
	U6u+rXTCTxfbdi+/Tgl/g8M7k01hrkCPpQmv27DdKzonvxCLPpbhnV9MUzaF/EXuEfwUZIVHNmS
	S9NzcM361u6I2BCZpb6HzuhpNyH0xFWUeDj74B4lTwJzPEgLkFs7+l1huelz9zXaAAmOEBEPi3x
	3utM4pdyau/J5jk75xg7omdKBsQkrNuijAblDQt/Pq/8NS3kwlc0Nk6j2VltdKPAEn77EtKOPMq
	yq9zgNTKcHsk6Tsb1WH97HZFDEXY8XWNqnIYKmS+zuSIm9XHzvR6D6jFMRuZj9kiSPVLBm0SnBO
	1RHtmViE0d4E5KaTA6GlzCfC3GQZVHH+IgsfNav14eldMDshWd0yD9MKGHxHKKERPZuRMyHDSpN
	h44dedUny4IGCNz4u46giiDMDiPse9+ymd4RrX0C4H+rUzIoeKeiTeXVW4ZDutyjwWArBmIqXPB
	FyZ
X-Received: by 2002:a05:690c:ed6:b0:7a2:ce0e:8641 with SMTP id 00721157ae682-7af78f56acfmr22974457b3.18.1775826158650;
        Fri, 10 Apr 2026 06:02:38 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa061bbsm12742947b3.35.2026.04.10.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:02:37 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:02:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kuniyu@google.com
Cc: horms@kernel.org, 
 netdev@vger.kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <willemdebruijn.kernel.16fc0cd4fa9dd@gmail.com>
In-Reply-To: <20260409221532.69090-1-krisman@suse.de>
References: <20260409221532.69090-1-krisman@suse.de>
Subject: Re: [PATCH] udp: Force compute_score to always inline
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277418-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 338803D7DA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gabriel Krisman Bertazi wrote:
> Back in 2024 I reported a 7-12% regression on an iperf3 UDP loopback
> thoughput test that we traced to the extra overhead of calling
> compute_score on two places, introduced by commit f0ea27e7bfe1 ("udp:
> re-score reuseport groups when connected sockets are present").  At the
> time, I pointed out the overhead was caused by the multiple calls,
> associated with cpu-specific mitigations, and merged commit
> 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites") to
> jump back explicitly, to force the rescore call in a single place.
> 
> Recently though, we got another regression report against a newer distro
> version, which a team colleague traced back to the same root-cause.
> Turns out that once we updated to gcc-13, the compiler got smart enough
> to unroll the loop, undoing my previous mitigation.  Let's bite the
> bullet and __always_inline compute_score on both ipv4 and ipv6 to
> prevent gcc from de-optimizing it again in the future.  These functions
> are only called in two places each, udpX_lib_lookup1 and
> udpX_lib_lookup2, so the extra size shouldn't be a problem and it is hot
> enough to be very visible in profilings.  In fact, with gcc13, forcing
> the inline will prevent gcc from unrolling the fix from commit
> 50aee97d1511, so we don't end up increasing udpX_lib_lookup2 at all.
> 
> I haven't recollected the results myself, as I don't have access to the
> machine at the moment.  But the same colleague reported 4.67%
> inprovement with this patch in the loopback benchmark, solving the
> regression report within noise margins.
> 
> Fixes: 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

Acked-by: Willem de Bruijn <willemb@google.com>

