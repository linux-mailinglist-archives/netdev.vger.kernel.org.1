Return-Path: <netdev+bounces-205558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E735AFF410
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D373A7BA618
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0BD23C514;
	Wed,  9 Jul 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Zgf5ycfA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14723D29D
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097294; cv=none; b=WCv/VpianlXFwjiIzjOfvAKK/QLRi9lbv4FCSeKhvDEtBcfxoxkwgZYd/AaQGWe+jZnB9j50b4c2hTTIKuN2ztEwo9U4zRyTCzZBkhJ5PpsDYBATEMguarkhbUeHKdGq2bbh13+rgpN2FedaKTNQyyvvjMld/bjHri6Mv/53gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097294; c=relaxed/simple;
	bh=qHr/ej+IX4u/FXh28EYJbuaYRkiMF1DPwAgk02tEV9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXJGA+5s0sFvvpPO20j+ZabD07NYgGtplfY5y2eHLhk5jitr/V9Ug/LV5u5RyOzfH3ZVHFugErVuqV+hV/MrykMhhZBuSXUhvcaecFYMOQER3lEtRzfK8ePlTi4pwYDHedvAeOCsJmcUSZWCONY9fVQ2Y5BcheBaQglzmvHLtl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Zgf5ycfA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so3274765ad.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752097292; x=1752702092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hETGV1Ls3GgOBkGlRIJgrhnNVooPnMq+2ARFX1z9RCc=;
        b=Zgf5ycfAfpC87hkKVUwDBl6PDm9jIvNXZuDdi4gEdY5xd0l71KOF0fHdUie5nz5xuq
         2OHcbuaicONGrte8RKZlrkBV1k6WJO3Tsnwjqb4g+fSs/AfJqh41wkp6rxfNuApLz1K6
         LfDrV3g2GBCakFI8cjn6jTSrD8BqCesEnqKxcaWQ7gw9WVaGP1CLUGbeaU8fwPZ2duea
         0U53fg9jU+L6aw+IY/E3IQqcZ5fTGIhs2ri4eknTfh2MX/MPzxwf3WJIKyHfxLfF5AI9
         UzQy7OBsaTnX8s/x3lmfHoR0RnT5/uc1IeWAnjK2gniJiEdKnr5bvbni2/I3G5e6H3Nn
         oq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097292; x=1752702092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hETGV1Ls3GgOBkGlRIJgrhnNVooPnMq+2ARFX1z9RCc=;
        b=dEbca1SDih2YVo4oPhSSddm6TDBh1/ggnqv7SEnagie1a7IVxkPUwmXw0gIWYczfdu
         CEPf5m2fYDExFt8oxQCmjxMVQ0QGgZxh3mO1njomFcqNmViF5I0QYuRe/Uy2NWkoiIcR
         9i9w2RcvTnwWVw+9kiV+0cV4GhNB/nZ4Xcl5z2YPepb+c7Hup1u7lwCqxVLtlWwwEXwh
         miOthpDxQepzjpORFBBPqbH1YAdGspJkvVNxUAiwqCAa9Gtaw0lwTNyAwpmbONwu4QTB
         uRSEx9xpA6d+RY4Zzu1ABGmJr7+SmD2RCmQy3sX1WzTWPniNP23At5hvqDS4YaozqwQc
         aNGw==
X-Forwarded-Encrypted: i=1; AJvYcCU2mYsDhfCoWmflI1l3uhepW4o9+UzHZ6xA00L2po5RkiaqVFnPkNHtm1lTxzJItaCbZ4/IhCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dzCxrJR5m+I6aYXYDFi0+gcM5u5G6KzNwkDAjxGpU34hlpz8
	El1LQYfu7QYXQFe1g1/Iwm2ywafa8RR01aUx07Xv2FIHUgimbme/48Z/gVeS+urHPQ==
X-Gm-Gg: ASbGncsJx+vKZJjVXacpl8MAgm9Xix6FvF7s4gudIuC5VtLBNKb8FWQBb0uMyR/5YAg
	1OSuZ+NVWBwaKSaHD/ULc/vvx52V43nA+EKkl0Dqzq9KCBcbsEJ5xFjZ1yC1zF34vAhY+UKKRtk
	dDpA+eMOmPwAG+LKT5+pqlDJMMXsDU6nKPHEWb5O2T7baMhjjd1OXYJ9zB9R9d/sTxrxrEMKCsk
	g+KcPr+IdD3ryehiZ0Cl5vGYuPGpTSMrdLhUs5zcVNNKdSR5p7NugFNt6IoN+aDX0YWudIXEr1r
	yzai3syszBfq20odseqket0+XYJZqunL2dkfsOCYJx7BpYwUOes3B6K5y+Lla1EFwAFtR0J6
X-Google-Smtp-Source: AGHT+IFnJcQwEQHae5JdSMVgd9oMj46DkZMI+34z6jt8pPMFYFoq1dG3JPWONtAz6v/TuAPp1s37/w==
X-Received: by 2002:a17:902:ef02:b0:234:d679:72f7 with SMTP id d9443c01a7336-23de4832d76mr493955ad.23.1752097292143;
        Wed, 09 Jul 2025 14:41:32 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341a99sm1394975ad.170.2025.07.09.14.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 14:41:31 -0700 (PDT)
Date: Wed, 9 Jul 2025 14:41:29 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v2] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aG7iCRECnB3VdT_2@xps>
References: <aGwMBj5BBRuITOlA@pop-os.localdomain>
 <20250709180622.757423-1-xmei5@asu.edu>
 <20250709131920.7ce33c83@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709131920.7ce33c83@kernel.org>

On Wed, Jul 09, 2025 at 01:19:20PM -0700, Jakub Kicinski wrote:
> On Wed,  9 Jul 2025 11:06:22 -0700 Xiang Mei wrote:
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> Reported-by is for cases where the bug is reported by someone else than

This bug's fixing is a little special since I am both the person who reported 
it and the patch author. I may need a "Reported-by" tag mentioning me since I 
exploited this bug in Google's bug bounty program (kerneCTF) and they will 
verify the Reported-by tag to make sure I am the person found the bug.

> the author. And please do *not* send the patches as a reply in a thread.
> I already asked you not to do it once.

I am so sorry that I misunderstood it. Now it's clear, we should always 
not use "-in-reply-to".

> -- 
> pw-bot: cr

