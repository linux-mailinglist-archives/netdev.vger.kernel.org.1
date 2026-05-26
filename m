Return-Path: <netdev+bounces-291699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HoNI6ahFWprWwcAu9opvQ
	(envelope-from <netdev+bounces-291699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:35:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFEA5D696C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4828A3057492
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661F3F7AAB;
	Tue, 26 May 2026 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="WOIuSAhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D73F7886
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802162; cv=none; b=W4UGyFmOrQ2tJGyK5bdRdx2uIe+lAspmJgGE3u0Oq1ZjQw/2Meoesz+TI120HJ5qNISgh0zOSmu+lCdY+rJDYdhdpUqRmxEO5Bw3hUTUp1v25gug1C6cU5pSZPuKDZ1SR0ml/+aDl22RukZDVDlvnvn64kgahyeO5246H9GqRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802162; c=relaxed/simple;
	bh=a3Ad0XJlIHX5RtWby+b2O9m9DTbL8t/LUh+au+p0U/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCDL2LBexWGYyhIsB/rVqW5xbTp/bC3rOCTywAxCCpCXfxB83BQmb4Ept0YYYsGMFPKbAMAK8U2fTmF6VWmlc8Kj7f4FrX7sQ2p/njzNBZ5wEQUlthvFOuy97cFmEuCgZmejpnDPE+Zg4JBLeMibHo31do9d1KsJ3TkEsi0nXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=WOIuSAhE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49048e043e5so30561415e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779802160; x=1780406960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3Ad0XJlIHX5RtWby+b2O9m9DTbL8t/LUh+au+p0U/Y=;
        b=WOIuSAhE4PNSk4YeCGpjoG5cohDtKnOYsTg3d26snRl9e48Ve6Lx1LmKvTC6QmpyTy
         AfeCBPLEbgc9IXnn+7/7ZkFGRa9+RRxL2gsryVia+yZfpfhbkpGBAKg1FASv7wsybBGW
         VCRfaKDZkhidZ+S0PTDHtZGl3Jf/NTMf4vJ1JRBjezZwEz78fF6G43KRUg73/ZR94drT
         dw5Vail5Yn2wW5jv+2Bw1MuFd2cbC9rSTapt7SMV0UsIHb/CBioKed6C09EOouSNx2cO
         0a807z48sx8K5OTp10PFZ+BZjW+JUBTz3c9U3V1TjHob/cgfR0SR0OUcAngutwNpyrqz
         zLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802160; x=1780406960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3Ad0XJlIHX5RtWby+b2O9m9DTbL8t/LUh+au+p0U/Y=;
        b=MQLvMoN46eagFlEs0fQ4nEgFmYRw9Sl4NMvYKzwBElA1kY1FMbs0cGJpu6N+ULZ+68
         uXLP7yCti0JEJFlMB6ProdztP2iSoPGd2kS0bb8DeYtZ4sbIs+DyXTP265DprBYv3d/V
         HNeW8YXwmnqVsLrauofYM+yCytugFF9JjGNwT0GZyQw2KMNo6rIWxaLBsu1rekGmpFPX
         ThpMf+pGXS1uB1PhSYg3DBMVR3BHA828LGx+bn8R9DfgUD1BvXD7i9XjB8BUWoV+QM9s
         aFH6PfpoJeHHKirGTWrdE3vwTR7VD2KOyJrzJB8cGyZpXqJZODhI85VgbU8ALD2wXcan
         FS0g==
X-Gm-Message-State: AOJu0YwEuwDbfKKyYHCGXTwpLSnYQVStuFu/NQ6CDD/sQjjd2W9xnRYP
	nzzoyZTKLKvS+/vUYzzpzY+zdkDg4uijrm9jEyRUaxczv9uMAJgJiutQvzz/q9ypCR0=
X-Gm-Gg: Acq92OHvX/rlI88zwBswQbBiuIAyt/Mu0O3wyFyCGVW/0UMu27Jd/wokGkiiDaZwkAv
	nXeSyXE1b2EKplu6jSMGGmeWY68jFwC0C9YTGWTdGN7jQ/OhrQYR/sa/E2sI4Gv6f80Txy9CVzY
	UjFo4g/X6921rq5T0aUqkdgfcK08RbiCCRLJZjaPvnvRFn6uRjbausUQuVLCoFi2GlZGYq5NQup
	br1Z5FoOrCQ45DP6F/MWcX7VM8Z7UKRdfwivlrzHcPFz7a9t2Qf5P3423P0plpMuuBsHAh96Ynj
	Y9ezzUSI6fuTJY6mpHsFoBJgor+Z8YUwt4ZnKbqffPb8UFsb0rNVyk55bpQNm60kqZaB6l/YqEV
	SlPraFx6FYlvPO3BwfQ20hYmDJ4kN+qC00DTdsPkQb0bim+hF5POdiaubBas+xLhZKED2TtcgVx
	GWwb1YoU5cX6ibF40fkjWc5cSRsOtJF+nW
X-Received: by 2002:a05:600c:a106:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-490424a0d41mr204824095e9.2.1779802159514;
        Tue, 26 May 2026 06:29:19 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d698fsm108777035e9.19.2026.05.26.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:29:19 -0700 (PDT)
Date: Tue, 26 May 2026 15:29:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Jakub Kicinski <kuba@kernel.org>, Petr Oros <poros@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] dpll: export __dpll_device_change_ntf() for use
 under dpll_lock
Message-ID: <ahWgJS65myAHz8QQ@FV6GYCPJ69>
References: <20260526074525.1451008-1-ivecera@redhat.com>
 <20260526074525.1451008-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526074525.1451008-2-ivecera@redhat.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291699-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 2AFEA5D696C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, May 26, 2026 at 09:45:23AM +0200, ivecera@redhat.com wrote:
>Export __dpll_device_change_ntf() so that drivers can send device
>change notifications from within device callbacks, which are already
>called under dpll_lock. Using dpll_device_change_ntf() in that
>context would deadlock.
>
>Add lockdep_assert_held() to catch misuse without the lock held.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

