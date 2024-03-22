Return-Path: <netdev+bounces-81172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0689D88663C
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C24A28650D
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0908C1F;
	Fri, 22 Mar 2024 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXkAkenu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2838F68
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085530; cv=none; b=VMEsxLEOOcJ8nx/zK0KIIUyYasn5LvHuBsQ5qoyKSXGEFjR2VzssBS6k96sx3shZkU9bMUkzXtN4PbXCCuGt91q1ua64997djsZq/IB8weFQhuPcZbJqqEoW5RgeQO2klvXMj5kZAlgvpbgl/cDpv6KnxboayezvdBJ55efAYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085530; c=relaxed/simple;
	bh=gW3fIZf8vN6iEiqmwYK/QLqdMMMGzpIb+vf5nBRh7oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMHVuhXH/YlxV+z54HdK/Bk8yaaKo7Ar2357cLkMw8KqCmxVx+eoOd49FHE3rHjECg+gIaneeNpwXrzx4QheYXg4A1oCO9ROqHaPx4q4wry9M629HgD/GJo5bUHfReJtecQF4PXH36yErzAKozmtOpX4uyBUaECGUuR+mnMzQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXkAkenu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414775b1cacso7352725e9.3
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711085527; x=1711690327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+glO5iNDnOJRX1bMlWGx35LFvgqhLSy12w38sJ7h5I=;
        b=DXkAkenuMD7Dq0tSxFGZb9UuWfFh3h4GzTJcEZ+KwSTUI6OBpVtt2i4OILSAvO20wc
         dg9+NhibWifTjbapox5n/gfBfKoIWfBJ8L8mBWlgUoax3768YRVrqRjd25xhjDA1iv7Y
         gqxLn1kRI1iRX1YDDHxuPR2KzqEgjaW8y2PMv12DaypLPyyxUZJqrMsLx212XZ1Q/YKM
         Vbk9eKR2YoMlo6mpnDkNrFiOY0eI2zul2smqOGRwR+t3Dkki63suyfdfiL9EnVxABmdr
         8mZPP+p44X7PX37H5WNPj6+MMa01EcyWuMQAz9TK+6XzG1Xd6N02ABp4R8sIopen9Qke
         WB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711085527; x=1711690327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+glO5iNDnOJRX1bMlWGx35LFvgqhLSy12w38sJ7h5I=;
        b=Dgq/f2yMAVXKYoZYvSKV7FEf59O0LJR13F6kT2Gt8edx7MqNQpa95YHGIAQXLZJviZ
         lusZag/I7t4TD192V2SsayzQWsPyQQV/9Bz8i3AgT2lVmG4cY0Xf6O9zfuT6ib8gamux
         B7gGrwp/ZJA9r9QeKSn7EI60SnYgltj1SwOQVL3wlLJKFdkMpm1fEKeYMEAaSp2UOfZa
         EKisGcSUnnlYO/wMzbKxPcUNyFqc74DrGfkCyW4Pk5fCM9SDJCBWpH5qxj8t/LjMV50J
         nxrDH6LvLY4VLnG81NWepRojj/YpjzEM/4lU2mVbQ3ggLX5YO1eFevAjTg2sl/jpofkO
         XL5g==
X-Forwarded-Encrypted: i=1; AJvYcCVoJ2dSLsrBoJU9DTkSzgVH+rYum+5cCmlw/9Xu+gbQAL6fxwXTKTvFQ9Z4kaMEUslpwncXUNvs1iYoNFnxcnm0GTTGRoZ0
X-Gm-Message-State: AOJu0Yy5e0jV21SPh594BHSAxR72HCT1UeLxuNg/uZY9xxdsmpLZRx4k
	7GF/GCaNGDCQthiiaSJcfXSa47QXtKW5uHub4ZA7pg58zqfhzELsY23tENpvlhM=
X-Google-Smtp-Source: AGHT+IFUrNidyaL2odjdKfD+FtYadw4MHtswbb1LkvUM7SXIPYO/YUG7URif4e21XfDKyIOZxaierw==
X-Received: by 2002:a05:600c:3502:b0:414:7909:6680 with SMTP id h2-20020a05600c350200b0041479096680mr751469wmq.16.1711085527043;
        Thu, 21 Mar 2024 22:32:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4d12000000b0033ec8f3ca9bsm1190810wrt.49.2024.03.21.22.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 22:32:06 -0700 (PDT)
Date: Fri, 22 Mar 2024 08:32:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Kees Cook <keescook@chromium.org>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Message-ID: <7ca4a907-2a9c-4711-a13c-22cbfec15e0e@moroto.mountain>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
 <0d7062e1-995b-42bc-8a62-d57c8cb588ee@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7062e1-995b-42bc-8a62-d57c8cb588ee@web.de>

Markus please don't do this.  Don't take a controversial opinion and
start trying to force it on everyone via review comments and an
automatic converstion script.

regards,
dan carpenter


