Return-Path: <netdev+bounces-112206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C2D9375EC
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8D1285C90
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134677D3F5;
	Fri, 19 Jul 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="o6ZXSGW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605E81AB4
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381911; cv=none; b=P3Z1vVJ2QSc/9vV0Jh9Dx+zPaXOEtGueH8Cx89wy67HjMaNVNwnfgpqPQMvzPe2SJcpYdpQUKS/2VUE3pv8VOQTh2q/SL7BLQ/BXMIEQ3yWDz3BxnZbZ0+JXrZRNBoSv61OwuKYOtxhGjtmSaq/wcjzTleIede1oSKEDA8AKvm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381911; c=relaxed/simple;
	bh=Oz1ZZ95Ao7GSNdeoOP9ZVx56CTt4X1T/ftYKvMwHINo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icf7obX7E+chHq3B9CvzEQT8+eb7ZkXCfVmE8MV65RTAd7KjHhqyY/NIvGBSA8XR8qAlz5H6aZvGfBFL5IGysjJCG3IBvm1Kcu3uVcUmp7gfHtAd8coG4Jxf+w8bmgEuK/ib6cRNF/Q5gAjcpw9kaO7iozd4DkJuv8g1elY/k6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=o6ZXSGW6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-427cede1e86so10080975e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721381906; x=1721986706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz1ZZ95Ao7GSNdeoOP9ZVx56CTt4X1T/ftYKvMwHINo=;
        b=o6ZXSGW64ztP6QUdRZbh4TIW4ypCCQ+7Mn+Uw31Fhm3zbLWqZdqLlnxnD3aimvqrqF
         VAfvMxEWl0+fuas7vzOHStzFLAgT+d4ezXnxwsOCFDeEOXMB535gaNnKWASYYUgNxo6+
         prqrcNJfhmMnl0/UmvII2u2vV9WXlFUflJqZNGKGvHDqXSGye2y1LhUXcLpD5IkjHnhH
         NrJ++sUzVU3lYXyMxIHWT51wpz8GKSM8gflfTXa/3ACF8rvbN7bWpvt0eGN+zxixJdaJ
         18PmTJTlhuMe//I7U8yVjD9eldj5bCT63/mmLwXqFcB9jQKyKFTUnViFNXTd94Co7dZs
         MHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381906; x=1721986706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz1ZZ95Ao7GSNdeoOP9ZVx56CTt4X1T/ftYKvMwHINo=;
        b=FwsB0jqbChHv8khhHF961pFJ3gQG+aTSqD+aU7VU9g0IUwGLni2+RaaryWaRO20mNI
         81ZjWoF5lqAkuNaySw/7h8Dts+KFg8W7E4T5NDyBgsFuBMsYz+ArCkjfqDTdEtfIyGmX
         yZCteCjNc3QwCIf5+N/1muddIYge7UW0ta4mRVXo4ghjDTKFugRqW6w2jx0e+W64gxCw
         UOWBonOF6GXgHW4jQLrNAb+/KN9vD2iuANKWI66HdzWy8qXJZo/tCm1ncK0/f4ruwup8
         p1U2mB4LHHTTbcdfB9jqTAiQfbRhIHDyjbRqB66X8aX7WiMWOJkNcZv64lPHLXvKy+Fb
         ZNsQ==
X-Gm-Message-State: AOJu0Ywzwarl22WdDze2KCe4i1XwNB8j9WzPCaHQL5rOSGpg9ED1RKqa
	X7077HIaz6JwOAu3RxQoXgn2l7dCxuUbT8svsygEDd2A9/BClWxYgcjbvgy6mr0=
X-Google-Smtp-Source: AGHT+IEA853+N33mpGcKHfY4woWIKE5h3uJ8DcoCqzqT58FMqrjDmcDP2FrtFS5TFI9AM02VKmF9IQ==
X-Received: by 2002:a05:600c:19c7:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-427c2cf2050mr51681625e9.26.1721381905718;
        Fri, 19 Jul 2024 02:38:25 -0700 (PDT)
Received: from localhost ([37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a6efb6sm46220435e9.24.2024.07.19.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:38:25 -0700 (PDT)
Date: Fri, 19 Jul 2024 11:38:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next] net: drop special comment style
Message-ID: <Zpo0ELbbzJRixML4@nanopsycho.orion>
References: <20240718110739.503e986bf647.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718110739.503e986bf647.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>

Thu, Jul 18, 2024 at 08:07:40PM CEST, johannes@sipsolutions.net wrote:
>From: Johannes Berg <johannes.berg@intel.com>
>
>As we discussed in the room at netdevconf earlier this week,
>drop the requirement for special comment style for netdev.
>
>For checkpatch, the general check accepts both right now, so
>simply drop the special request there as well.

Interesting. What changed? :)

