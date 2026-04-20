Return-Path: <netdev+bounces-279918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOshF+OC5mkIxgEAu9opvQ
	(envelope-from <netdev+bounces-279918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:47:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E218C4336F5
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FA063030D1C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DBE3CBE93;
	Mon, 20 Apr 2026 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4sxpCKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608E3CBE65
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714321; cv=none; b=CMqsoIQfJYC4UkYnjPO4Qf4+2ceoG6jSluC7Zy4Of07CL6Zd+mYHZgqpcT9sG9Eb/p6F/l0eLoei6um2/RFGxd7yUqWMhp/ZZwGOSAPueHTCNAc+r9yaEpZpFLbtFn/aHQ4UGg2s5rty0E+tC+XpPUVXSQeQbRndHuqRAKzZzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714321; c=relaxed/simple;
	bh=MPzkA4rnkkQCuqpXpfd6+oMKFrOoPRYNMbYm4l8qyeQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=b2Zh2WzEUKf9zusmIMQ4RkgsO8Ywuij7e6l7j0rOWTOWwJcZ1Mvegx9mBJQ46gDtU4GJB75Lv94LlPz6J5ZLw+vgcGsONn/8NO70GzQFu3CVUCh3zykR16hBJZa4pq4SPkiavq6gPjxtKglsTNR+TW7gBT1ScbBR70Tyq3xDaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4sxpCKM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79ee5037d44so45181507b3.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714320; x=1777319120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/PwzGRNcB1I/BsMsmiZ9vrYb18/9jvWIWVEOY/l1EY=;
        b=K4sxpCKMNDsg6x3v8IfBU1nV8n5/+TPYf2qxk7GXqCNLGCgqdILEe5cXtgccPZa8c1
         LGAhcF+dpvLWVWc3krMTdKMo5KOt/+DKa3eeFMq7rO9W06uGINA85UVULPlldrKZ0eD1
         D/OCiggRDTPtUWzssx2Kv7AccjR0kkN4L/vT/wVBzmmFo6weOECUubNRBE6D+Pj1uZEd
         HobOiak06Gvl7g+XRXoiLfk90/AWccPQIAt2M/fylfYeirwarfuchF9UJbC0qiuzUDaL
         vbkgWncfh2dvEf3ZtojDCk5jwX8VQw8xD7ofvAUGv38FEChKqN9h87pD4SyOG/uh7P+y
         RdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714320; x=1777319120;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/PwzGRNcB1I/BsMsmiZ9vrYb18/9jvWIWVEOY/l1EY=;
        b=aSVfN8he3Edcu0e9QxKPK31sJqouJqfhqM9vW8fHZuzFmDFMgufy/NOXWYDAmQY3Ab
         Q69K1WzDtvOLEDXrifh1Ao6K6bCCJLQCcilbteR2IyIKpLUgOtobhVP4cJ7sbpxZLCfS
         IA3xcVk6nMI11PDKBmq4tJtP2r5Yz6m672zlaHA+NrFxWTRGWigMuQMb7hmdlJA6zxzl
         uX/A6htqyWEBKQWcvmubos3jGxKEAXSdXRX67lVItqlYp6PLy9hVXk7lDOBHqUIVxiZh
         aaXimvDwPiRc6K/t2Bp+KVUfWUoKGYOysSKpN7+D8oGYr2f5dEVUjKjuPSBhM4y9OvFO
         9lTA==
X-Forwarded-Encrypted: i=1; AFNElJ908/XhMdTxgjul8cqGiFDMsKdBDC/7A+ENA70/hFHNYw76LWolIN/fIqzwypRpmDo6FH7fCAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0oCuQPWWGalhTkmRaNRBMse8FonF9K9oodgQh92kLswb7g2x1
	yLr7neosQRqk9pTg5aUpNqUTFrbsJF3kS8Mj5zNbCUqliUH4qzNbOz+R
X-Gm-Gg: AeBDieumS85V7SZAMOBaJ0wQB2ykYhTBCz43pnu+Duetq07PBwmeChKTrYQdk4ruqAk
	o2JC+ultYr8wRR9oICZB8lDGqCeQowKckMZx6LgYccCtEZkzN2L9naf9vCzePQzFJxC/upbPOcY
	PJIyYQb2asdWwgrFMn+9ZYRHSxD52FfPODJRn2a28CDDJO9zUig1ub8hNiEbGAgH/0XiPw9pZgq
	ShNbomjddMB/ZegdBWR4UZ05CFRzomH7UOzhZIXR/en0lm4C9qS/6tT6mS7lQeJOT3srkDslCle
	zzTYxFQEAGrnxSLGVrA7IoJui4SfxUJnMn+qa0Hw4vYLTnwZ6PNgnpbSOBU+IaIe0wDeLJZfjJC
	W4mk1kVK9XsLpK/bxYsdeOFpjJJD0/Mlm2iuFPMpeZutYwoIpgryi9CPv3vL4/zOegQmew5eJx2
	mRdFZun6ZotYRglkFD1AUo3cOsRr+DQTN3rbG9sHIxTIu00NxW5thwA3iP7RVeWyJ+NP5oUOQgN
	LIStXo+TbHujao=
X-Received: by 2002:a05:690c:c50e:b0:7b8:567e:d536 with SMTP id 00721157ae682-7b9ed29c6f1mr110198987b3.2.1776714319748;
        Mon, 20 Apr 2026 12:45:19 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bb09sm49116397b3.32.2026.04.20.12.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:45:18 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:45:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1ccbc2a02f0bc@gmail.com>
In-Reply-To: <20260420104051.1528843-5-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-5-nhudson@akamai.com>
Subject: Re: [PATCH v5 4/6] bpf: allow new DECAP flags and add guard rails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279918-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email]
X-Rspamd-Queue-Id: E218C4336F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Add checks to require shrink-only decap, reject conflicting decap flag
> combinations, and verify removed length is sufficient for claimed header
> decapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

