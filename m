Return-Path: <netdev+bounces-90499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74028AE442
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4F51F21277
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477780600;
	Tue, 23 Apr 2024 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CiB/QDUO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB17E78E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872392; cv=none; b=ib7+pXDPzcGU+ZeMCJClWl1VCPzM+8uKv+5AUyq5IECCq/7rBRQp/hHYSp+kYzG4eTOuITuYcFHEmJOF8hzFYo72EsJc9ldr26otw6417n6WsV/zoA7MWvWkr9bpWRRx0oPMaVjhYae+ckV+4OwsJ5xSy/bPNdnX7X06rqS7sVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872392; c=relaxed/simple;
	bh=iyLcZgUC3yWD3g5g4WseTYGtJFBfHr8K4b59CgFesEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u76+Eg99LZRMfcXle34wXPYDbkKdmIDcfuS9Tr4YLrzZKfj5Rj08iRJQy1HZ7p/WDPYXl8uDnm1BQyQnwpVSmJZU9VTh4iBFvUOdE7ZbPtNOdX1lYx70SuEUlSID4gDUJhPShDX1XbDFg0gUhU+nNABrX0u/RfhLXfPucRM2qcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CiB/QDUO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso6855944a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713872388; x=1714477188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iyLcZgUC3yWD3g5g4WseTYGtJFBfHr8K4b59CgFesEw=;
        b=CiB/QDUOs6vc2QSDIoxFsrL8umDaMSr0cFx90XAF1Nq+iwGymqDBUaftkIDfdBPmRE
         mHtrHAsiHG2svpm5XwZ0Kex+LoFqsej4U89qHGUKFofYOF51SDgt9+1D0qdET/btap8v
         WI2DV4xz2lINrCDxOZ5ed8FWUlw7MXLSTJXoHUN1kydaflfjx7LQkkh+8n6+JO538l+Q
         o7X/FIHBceM3qj5U0zOi3HH7sugND+Xg/A3rvUlOxGbJphpemFp4/vp2DIIeVPkVF5nE
         ethu7o09kfDCBBZ0c/CDA5bf5Yrmv1sJtkoRUGx+nqQD8+wSMzPJUxnEo4TaLfl6eD2E
         29kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872388; x=1714477188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyLcZgUC3yWD3g5g4WseTYGtJFBfHr8K4b59CgFesEw=;
        b=OT+sPt8+3qk8xVh4d1DrcbkqNungLj7VFfWGSmncELaGfGcedfEo1YCKFOqiptEUAk
         qL3G7ld2c5OPdgyf+TGlgOGIxzxbEWlx2fEbh0xP1QWjz2suJ147brH0zJTXW1Gj/ktU
         rWESn/geEmz7Tw0l1f9WELN+Cw1QLXWyjfUYOvyY4nzy/GthYvZzj74TqQ1KsUpp0IXQ
         AY08BF4ryD+pymZdQvfkemIpF9IRanIDBSqBp1cz9y41BRHFLJ/xb+gQavBnP1Y7xXkb
         aWqdSgwEc27D4UmvAIpgP7oVUOD2kHWxi6Jxf8TQbSXDmUBKjMZZrbP0ZV7RI1imphOe
         Lc+Q==
X-Gm-Message-State: AOJu0YxiPC0aqgcIJDE0mrtLy29MDdlYc4oO6EsOLGIUjE0IBBT4z0xd
	klL4kIxRvFCSsReREQsLb4xRAz1FBfqTxVAA82qDYru5x3xKdBdh47UgXmtIhCc=
X-Google-Smtp-Source: AGHT+IGa4HWxIX6vrI7haUKjQvhlJoWi29d/kjFzi/og+2lt9apgKQtAatdl7P8Yx5RjVVqC1FHKAA==
X-Received: by 2002:a50:d682:0:b0:56b:9029:dd48 with SMTP id r2-20020a50d682000000b0056b9029dd48mr9737766edi.5.1713872388295;
        Tue, 23 Apr 2024 04:39:48 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id p36-20020a056402502400b0056e064a6d2dsm6713511eda.2.2024.04.23.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:39:47 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:39:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: sfp: update comment for FS
 SFP-10G-T quirk
Message-ID: <ZieeAky55p1OKXCp@nanopsycho>
References: <20240423085039.26957-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423085039.26957-1-kabel@kernel.org>

Tue, Apr 23, 2024 at 10:50:38AM CEST, kabel@kernel.org wrote:
>Update the comment for the Fibrestore SFP-10G-T module: since commit
>e9301af385e7 ("net: sfp: fix PHY discovery for FS SFP-10G-T module")
>we also do a 4 second wait before probing the PHY.
>
>Fixes: e9301af385e7 ("net: sfp: fix PHY discovery for FS SFP-10G-T module")
>Signed-off-by: Marek Behún <kabel@kernel.org>
>Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

For patchsets, could you please next time provide a cover letter. Even
very simple one would do. Thanks!

