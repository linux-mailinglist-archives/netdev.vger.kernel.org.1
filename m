Return-Path: <netdev+bounces-130929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D998C1A1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1871C242CC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F631C9EB6;
	Tue,  1 Oct 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbdy4aKL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0201C9EA4
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796555; cv=none; b=sAWidjJEE+azxD61TYG3u1XRG4vAhY8AnvfxY3vUBBER0g8bbKABTVMxSNYMiTO905aD1vyaj9fovjFxBtQQq2tLJU+Cdpo21akKgUySmK+cXdRJbeBTl2Q9F+UGD8QBJDYWSEKd9lUbG0bAlZqX7SkZzaAM9ZEueXKhcJkGFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796555; c=relaxed/simple;
	bh=x0K+zPxurcPZc7T/0ku2nqo+pouZWvdWEQrURO8PaFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuGZmXUIIu3m6grYnxKmNPSB4MrFP1K6FR+Uj82X/i/rdEHQNz4NMiZAC3e+SJg0xj3g9/7Xm30ybmOgleUjRsb5LJu0S/MzZeVrP8DjBlwrxe1/dNwEV2lh/+a9Tb2LHH1gUFs/LRFNbRjBGaV2NZddT2ZH/2C04hRJdrqZzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dbdy4aKL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ccd50faafso3662990f8f.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 08:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727796552; x=1728401352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b6p5BIzs+G9R7kkXcfnWlKyc4GV8KawD5tTiNldE9OU=;
        b=dbdy4aKLNpoovgHmOdjG294k86jRGuMX1ymGs3Aagn15Wx87tMFd+Rcl//pNAvVPj5
         jaZdvNuAspYN5EgMcm38KDucGkAaXWD5yenisJAlcTLk1/v+R1/7lkzuCKRYNBwig8le
         ljNPwTSQ3jG8HFww3DXkyAoaKzwrFzY91x+TFg3AQgu3emYdlgh4Vujb8DcVlzoCJvR/
         bmT0gVQWOeo8RR4rUY8v2KC2Bh/usR+/KU9dvtn6h+5e2I8QKRcwFlGGPW4FxMUUnYXK
         TJGg5+vmzJfg2RINTnbrNGAV5F84NUokqDdCUYr8ggqOoYbncdVc4CMOJN/5s75OpK/3
         plzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796552; x=1728401352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6p5BIzs+G9R7kkXcfnWlKyc4GV8KawD5tTiNldE9OU=;
        b=pvcdM0bTuvywOTyn4tr2JRhOfycfNqCicOT5w9TTmAQvH4hmRuyj7pE4E3OwipYJYL
         5vKIyYbULaXn/TNbqOsdYlx0VZJR5OaL+mDUf4mtdMRFaXVPNpPrBqZaYL+Hwgp7zvmQ
         4lve9Rs6/0+1QjTMAxNG6hwCyYrFZHoLJu0tSsYbp5ZZlauRdSyYTx16SFk8oOvUjXSi
         /25K+eNwAYoYM3W9pNnrPsLuT8arKr0ICtW4Pir/Zgx+PD+zmmHGGmv5wWWMhdGLCI56
         7YsmBCxL5xUZ19FvjjhoW5xEnIzkdH0TKmRtAJPIZ6o74TaDY/BuJPt9uE0Su4N8EjOn
         U+iA==
X-Forwarded-Encrypted: i=1; AJvYcCWmBz2jin1iYywdjOBno5ajZKtRBEXhcWftfcWVcw7FR1Y4A230Eieq+UD4mokJyj0qc+hGprM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUwqjMRnbYqjNgQAtXFc9Q0Lrz/PrtAFr2RivBrJKmIzo1Zqs
	sp0q0g7MDsOhR5FR922f0pu4aRCnvWv7ppfBiGQX0Zgus+HYRhiUK7jR6lfoxA0=
X-Google-Smtp-Source: AGHT+IGgImbinqs+Rcc+CHQ8JL/+9OoDVAqWT3R4ao9u1pYDvZzJtY+qfvUAJ+095/y74H3Xk/fJLw==
X-Received: by 2002:adf:a155:0:b0:37c:d275:9ede with SMTP id ffacd0b85a97d-37cd5acbb8fmr8775963f8f.26.1727796552131;
        Tue, 01 Oct 2024 08:29:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fb5dsm12053705f8f.88.2024.10.01.08.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:29:11 -0700 (PDT)
Date: Tue, 1 Oct 2024 18:29:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH v2] Simply enable one to write code like:
Message-ID: <35b3305f-d2c6-4d2b-9ac5-8bbb93873b92@stanley.mountain>
References: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>

Nice.  This would make it easier for Smatch to parse scope_guard() macros.

regards,
dan carpenter



