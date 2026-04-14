Return-Path: <netdev+bounces-278574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DI0OKOc3mlrGQAAu9opvQ
	(envelope-from <netdev+bounces-278574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:59:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374AC3FE328
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 448373021B04
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2F31AAB8;
	Tue, 14 Apr 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doVQC936"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE31A01BE
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196704; cv=none; b=SSgvn0bgHiyX6BhT6KUdJZlMnIlTJOyLalx9186iIIkL+LWwXK6ZVfk71Hyw3zCYK857hgKCqKjyYZAUadi5WZOp7Hq+iq33UaFD6IgIWCKw8O9bqSvs99iWCQPHot1dMJpNR4VjHKvVj3y/cvWvwk9vcAzBtfdtnNKgvtA7Wp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196704; c=relaxed/simple;
	bh=ernxs9cxHgjN2AeqI2C5IXCVzXbpo+QBi4gBE9QGuTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCSkpXa3gC4+nG50n8E0DYvhY20L3ntHSzWv+fo6qZQ+485jNvnyMecaKCAt1uDjo6e5akn1ugj0LzhONG54veIi0FaiJ7s7e7JhJyuf9D3hn1ZhKzq3JRn14gkFd/YMUDJzFt/PRDC4UbASVbL1XkUw8Oqm8OdXc7xcztjJDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=doVQC936; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b243198058so530555ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196702; x=1776801502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyXCqfx4Fft4vEevLGrI+paObPMm4D0ED0NZ2f9ixGI=;
        b=doVQC936mOV/N/mJndX/lAzC5YuIeCwvKz+I68DouN5nFUpABKQtvzBTSt4clzFGTu
         NzPiGeajYIS48TqFMWKf7LbqicVBKTCLde+jCPoY7BrWwM15MRmQsEG4NIqLHzldQzYT
         dTUgTJCdYhOs3o5Di4dUmm2wHUXvPurU4SdV2sf7bse98i3FYeHi2ciuEacjoOQ8Hetq
         LiqfTtjT6Uz7mgdjjD0An7scx2HtdvNN/VG3GdE+NfPNwmomTonTZEsSZxZXRjYRhK0a
         ATUxGWzsObvtqI3lj4alGrmq8xRSpxHfboFMbHIBL4cAyUK/fQjULdDpJo7a2ETYcXwE
         LQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196702; x=1776801502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyXCqfx4Fft4vEevLGrI+paObPMm4D0ED0NZ2f9ixGI=;
        b=ae3ojnLM++7x9vo039Nm+Jv/ZZdjZSJJ/DDOa8J8x4mlm3BGrqsIdlpqn4uBMwM3KC
         /OgwciJt3N8e20ENtQi+YJ84tRmtAZmP7ca4cTgRg3w+HQ355DMYGtunMLD3tiyXsDEL
         i3I/YqdCsY5OrAXuuOgYZUC+KyLkSQieeikzeLP+9Der5crvc22TvY7XBk0DFQvD4XJV
         tNYvyovMhmj5eAG4krABCnbRtxJ6aYGxkKIUaB8hquY54AeCujQ7VMF/bmbDKnjZ5kDZ
         avBSp6c9Fs91pww8CWSFY7OxrJykZhGopD/PUA0zWfQDRxUaG4Gm7brNHnjNhF+B1pxn
         lOvw==
X-Forwarded-Encrypted: i=1; AFNElJ9901yO43w9LYdIWa2po8eihy+DZ/7koNhkZWZjvGcm1sGDl/LTUWdfGCWWnh5MY49ZWrwAK8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGY6/0am72fzt+SstT/W+DLmrFcmoqlI3Qp3UQR3EXzXvtMUhT
	sniq0lt0jmsctiRgazAtGtXZ60L5tVr/I/LlIG203JeXNh/Ko2+xwVYD4/nalvhtqQ==
X-Gm-Gg: AeBDiev4vUbxihhD+siqPWSa5mZ2z+02bGT04N6C94kHbQcD3hdjQP7bkznPp7XZGtA
	Yylsn5SCSfcQJcg2ys/hZXJUiMp8Ywb31fLABLFhAeapWVmcL1a0Azcd9Ch14qj85Tr+3EHfQ3/
	ArkC6O2LZd8RCqgvrylCIi/0AYsqpOLMiDXRJOKo24ISwnwrSrYjomvZIbDhlsZDE91pExtKQLW
	Fi4aDzB5oYULE36CDEKB5IpNb96DMKNsfYcwxIUloBe3H1PQ580MYFgjcFQrzw/BM2ntXOpj+PH
	Rj787+DI4rllqBBbNL2sPgCVYHUXUMKNQ7Nk9amwz01uuh5yb2/2gvDlhRJ59oeaPDzxHK/VC04
	BdTraXi8O2Sa9+bP8+5KFCsEN6NuDYfAGSBvSK2//Nt9Xg7/Ude22CAsO8DZxlCq0s6KyRmJRJ5
	6vb6d/KXDvhECPZ8zW+bVWFJXKrWNld1VUenuQ4oO688OcmiD9RyxlTIg+emYau8dLdk1FX3qao
	znEvRbTtgAndIRMVw==
X-Received: by 2002:a17:903:1aa4:b0:2b2:4663:abe0 with SMTP id d9443c01a7336-2b476b8bc90mr72225ad.7.1776196701859;
        Tue, 14 Apr 2026 12:58:21 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c338dafsm16427701b3a.17.2026.04.14.12.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:58:20 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:58:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com,
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] nfs: make nfs_page pin-aware
Message-ID: <ad6cVbDGy3alQ2uK@google.com>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-4-praan@google.com>
 <ac341x4RXKoShXsB@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac341x4RXKoShXsB@infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278574-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 374AC3FE328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:04:23PM -0700, Christoph Hellwig wrote:
> This conversion really should go first as it is badly needed independent
> of any P2P support.  And I wonder if it should go further - currently
> the NFS I/O code is using folios for buffered I/O, but pages for direct
> I/O, which makes larger I/O very inefficient.
> 

Ack. I'll send this out as a different series with migration to folios
for direct I/O as well.

> The iov_iter_extract_bvecs wrapper allows to extract bvecs instead, which
> might be a good choice here either by passing down the bvecs or
> converting to an nfs_page inline.  Or just open coding a variant of
> iov_iter_extract_bvecs that converts to nfs_page structures instead of
> bvecs.  This would pair with a helper similar to __bio_release_pages on
> the unlock side.

Ack. I'll attempt an open coded variant.

> 
> > +			req = nfs_page_create_from_page(dreq->ctx, pagevec[i], false,
> >  							pgbase, pos, req_len);
> >
> 
> A lot of this code reads pretty odd as it's overflowing the lines.
> 

Ahh, my bad. For some reason even checkpatch didn't catch this, I'll fix
this here and everywhere else.

Thanks,
Praan

