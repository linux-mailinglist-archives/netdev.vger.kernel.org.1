Return-Path: <netdev+bounces-299972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L0lwE93IMWp6qAUAu9opvQ
	(envelope-from <netdev+bounces-299972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:06:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E22695870
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qa32olrU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299972-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299972-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44D54300C3B5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595A37F015;
	Tue, 16 Jun 2026 22:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D346349CDD
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:06:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647575; cv=none; b=upODmsb7Hygh45/BBU6LItxBXcMq4U864a9F+pPPMi9W8etiO9fX5BKzzHszJlpz6wApDqCMQop6bRMZw4E+d5nGFPYLs9VSytFitSDzfsCgki0AYV8iIfo/hxxt2AETcBX2nqMqgbJEIpodWcufGLZ+b7KHXxbtafaaE4TO0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647575; c=relaxed/simple;
	bh=SIl3T/y6XKz2CSlLjTLbn53bB4naiteyTJvlcUtHyS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuDTfx9CtP/TbXkUlA136BcgnO8VeLFsezlQ1lqBvkA1PDNMcx4l3y5M+j0XpaJlB+7BFvaHxMde3cNphuFGH8VVUVfoMeI2XNI2NuND6Cba7javIdeAqNqsGuQnNG5w/H8OIxO9zazAGu/PFvysbX+W6QvCkvbdxW3kqKvF2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qa32olrU; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso44457465e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781647572; x=1782252372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjc2krrqahq+APUkDAlJCVHal69icYfN/Ux7mYOZdFA=;
        b=qa32olrUm5hksv6d18/YPAqoaRz2NeanXAfe4AK4sVsqNv4Yni+CWBg4IgUp4kiWKe
         yjDmJqB2Vcy9SkbxuAqL7GVUl/weBIqIj1MQEj5G9ExJyuQwLUjTXMB4wSAnfhtT7OnH
         w/iDtLXPcUSZbT0vP5dARzkMDKli/UivUGfHEjKIpcM2enpyLtG8Zn/Ax1KOl1+GKtTZ
         x9ZBxfGWdBpjrR72oA3Ag69DSPQZuMQdRs9avNl9wbCYUT23T3uhP0U5vjGVcIVzxyjX
         RdwZe6zByoFLZp5KLnZDVoe25Wf1e36cWvoZM57H14xrPJ3yPWTDmWFUo+iiIlQ/Q778
         OXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781647572; x=1782252372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qjc2krrqahq+APUkDAlJCVHal69icYfN/Ux7mYOZdFA=;
        b=lq0QuAF8ul/vX2o6evLeHaSz3jKzwcXTuEqtOTcDONgDA2k5bgfT0PTolerlI2u/+M
         iUHy3huIijZ2VnBvPy9x/fQJMT6Ec3ZMLoT1z7WPPetxd8JOy47vFYpOFlBux8QHwnlr
         Lo0bzu75vfJDOnP9WmvBeDSnBwQpyF/DuQHCo6RweQq+pI5jV1UvMxXsBMMPLT9dlmyI
         Q6noF7pBKQgd9XrN6Q1edta9a1rIKg6wE0kr3BOFhOPlm+lg++yJZ29zadGFWlZwC0xE
         NWYwU3NPJ6ak5dWvoJsAhGf5Ve7aynT8shKY//Li5/V8w5ybWDIeEfI0at/oNB/g2wmK
         j0Zg==
X-Forwarded-Encrypted: i=1; AFNElJ9pk1hAlqJ0XfRSJokbkTxGE9X9k3Dkj54C+xZx50hWBFk4h+ioF74qnW5GhZGC/N2SXdCt9gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoTl4010qfnO53XjX668J8bAr8pMomTIt8lDdeeI7Ij8X89/Z
	ny1IecjLgfpbvMJPepDH0l7+h30mQud8ig149ac/HAXNs6di8e/9Ik0S
X-Gm-Gg: Acq92OGU2pma3dfn/CdZ1FgTe625AsZZOaNcB7pe/TvytN+uIfpfCe6X2vZ1EFE9myB
	kXcr/aIyQPVxdB+aymyn1XEI5lJfn3mXaGkWXNM3HctYbX4uKzXExZuNgF/1c6o7ccIEohpsv8f
	G/LKrjc9wRDgjk3uOYDERHSbAxV4eJ0McpGR5D387Z14pkTA1rpiD8P69I3qzw7D2ahGugD7v9c
	IU7ebw8yHzMBsdA/IWZP+tALqnMSjHAjTXsJo/nSbf9Y03zR1HPhOmF6c3AmhX7pB4mTZJOyRRv
	/QLRX0TgfNMS2Ethc5EDfmvXI/CAHyuTBim+3/41Z9GY+pljyNv5qsLKmeMQSeTBfimEC2XSyKs
	QANUYceZtTxCDBkRbollMHMA4Wz2dTHq3NXqf8Iap/nqBTEaNa2tLxetsnapXiJVm5tiK3AOxMe
	+4EKlOeubwdo2snj1hAIj8Fm7sajfHE9PjcqnWFsltycPaYjwWoBn1yd7j+5hOPaExY6cxAXBp1
	7mORnvwwmpTg3Le6DTwtwPVbw5inyvIM05OYgwyQn81nnrT9xI79kZp89ls63AOb4rHmR0Kh2kY
	A6LtCNb7R2zIvhmnbvyjh5ELOT5htVjyh3tpjKX0+88=
X-Received: by 2002:a05:600c:e557:20b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-492333bfa01mr15869775e9.13.1781647572241;
        Tue, 16 Jun 2026 15:06:12 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004325bddd753d2e35.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4325:bddd:753d:2e35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49233be5901sm10431785e9.1.2026.06.16.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:06:11 -0700 (PDT)
Date: Wed, 17 Jun 2026 00:06:09 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
Message-ID: <ajHI0eUUqJpAmKvb@mail.gmail.com>
References: <20260613183424.1198073-1-jordan@jrife.io>
 <ajAXF8Nvg91xU4f2@mail.gmail.com>
 <CABi4-ogYKX9T_gWcXsKSs5-y=3GA_WqwfyjobmCxexTtQ_H86w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi4-ogYKX9T_gWcXsKSs5-y=3GA_WqwfyjobmCxexTtQ_H86w@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299972-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jordan@jrife.io,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47E22695870

On Tue, Jun 16, 2026 at 01:49:26PM -0700, Jordan Rife wrote:
> > IMO, calling it BPF_F_EGRESS would be less confusing. It's a shame we
> > can't have the same flag API between bpf_redirect() and
> > bpf_redirect_peer(), but this is creating inconsistent semantics for
> > the terms egress/ingress across the two helpers.
> 
> Yeah, one annoying thing about BPF_F_EGRESS is that it would only
> apply to bpf_redirect_peer, so you still have inconsistencies across

Yes, that's what I meant by "we can't have the same flag API" :)
Alternatively, we could define BPF_F_EGRESS as 1ULL << 1, for both
helpers, but I'm not sure it's worth it. Maybe Daniel will have another
idea?

> helpers. Perhaps this is less weird than having BPF_F_INGRESS perform
> an egress redirection though.
> 
> Jordan

