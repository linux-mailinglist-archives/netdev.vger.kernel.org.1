Return-Path: <netdev+bounces-59443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A481ADD6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB77B23B58
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64F5248;
	Thu, 21 Dec 2023 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RR/vxRWz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA197465
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d408d0bb87so564745ad.0
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 19:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131150; x=1703735950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3k480YkVOXqnrESiVDu5wpNOGDSLp/Szk817lT62Ko=;
        b=RR/vxRWzsglAr/gVk6YJs5u/gdX2T3FZHcsBkzL1fDzffB0TSUTS0uIoozMbluWcm2
         14EGLaXcZPAvrd2QE4JH9btFnfM0ls7lHeToqVRcZfzPUJQouZS+T7tNtTCigZfHn25C
         6a8W656r7/RpTlPbhWr5Km55L7kn1LDYs7YPX5QvKayC/oimc7DipzDN3spuZAhdZLv5
         rZ46IV1MIELQ1swzKnjQvYpeP+/ZpYRqzLI3a4m5fGBIxBl5orLJGjt25hKWMcCRDvpH
         C0PX0NcfTv7odD0A96e37OcuTWP9TEG1I6yaqMgV5hS98IP7a7RC5Ry8YKmIJVDFWXIz
         oZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131150; x=1703735950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3k480YkVOXqnrESiVDu5wpNOGDSLp/Szk817lT62Ko=;
        b=d80+VZ/KgZ2sjU/kYizuivglqdoJ/BLYYqqdy+F0v2kaFDb9+Yvcfn6YhRra32L7nV
         4+UZMl80wUl1qoDP93Lf5P8oi+dhsnk46Pe46DvCvhO8ABnpWbyMnUryeEPGTn1icrt4
         LSlparhd9ew327Z552Mxl8dz9rQ12wHd0r2k68PjwkQBQu6THYy8s7k1B1eMowEs8hkp
         RqJ4KDgxi2BBwFvSE6b5/+UXGtKKba6I3lNzFLNG/yrOa8iYD8VXb+ERQbYwNFsUxZe+
         WnzuTxN1SvW7S5Yp6eVHao3MTNS2zzLFBi/f8zmmeo6JQkox4GGovZTaocbO2Gapv++f
         I6qQ==
X-Gm-Message-State: AOJu0YzEcseXRAEnoioezelKmltYFrniJwZwjzsa7upcJnh/PoeElrGf
	sc4JBhFj6Cv13uiMNg/A6DlapA==
X-Google-Smtp-Source: AGHT+IEjjoimA4GMGrj0xwZDrcUVqBkWvQE15jQ5PhNNezmJUYr+IJ1SpPw8uvs3pkR7fsj62elnZw==
X-Received: by 2002:a17:903:2448:b0:1d3:f921:a453 with SMTP id l8-20020a170903244800b001d3f921a453mr1614922pls.139.1703131150003;
        Wed, 20 Dec 2023 19:59:10 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001d3fa5acf62sm503502plg.85.2023.12.20.19.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:59:09 -0800 (PST)
Date: Wed, 20 Dec 2023 19:59:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 03/20] bridge: vni: Fix duplicate group
 and remote error messages
Message-ID: <20231220195907.41c0cf4a@hermes.local>
In-Reply-To: <20231211140732.11475-4-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-4-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:15 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> Consider the following command with a duplicated "remote" argument:
> $ bridge vni add vni 150 remote 10.0.0.1 remote 10.0.0.2 dev vxlan2
> Error: argument "remote" is wrong: duplicate group
> 
> The error message is misleading because there is no "group" argument. Both
> of the "group" and "remote" options specify a destination address and are
> mutually exclusive so change the variable name and error messages
> accordingly.
> 
> The result is:
> $ ./bridge/bridge vni add vni 150 remote 10.0.0.1 remote 10.0.0.2 dev vxlan2
> Error: duplicate "destination": "10.0.0.2" is the second value.
> 
> Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

