Return-Path: <netdev+bounces-130299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0541598A01A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F0C1F20FE2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4D18C939;
	Mon, 30 Sep 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHRjIyHb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78B1885A1
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694531; cv=none; b=OI9ZT83bBHTmes3uXUKWC8LklHxGg+Nxi2zr4M9anWlxaCxgb8O8X719lna+MMqQKpisrtNIozOQxTVgoei2ALkpWHdoYzJpiVUbgIY+bIBwXj1GejnsoCnCcBPPBBB7qs+HdG5xbogfsHJZlptjEIMVcYUgKuk90jujrHVKzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694531; c=relaxed/simple;
	bh=ZW51ODNUv+K2+wQaXfngP1wkDubT9uHM4iEgGzXdkhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L27nviQjkGux2u4XacGuNqJmtplE1Lvd1ZcanqJxpXgK0HDjRd0WgT1EmqlMpTUZ+ZD4Jyo5V85eZhLBNjuQtWd8y1xvVfAya7IbnjveYeYUUKfnO8NgWeMmxXT2rMspsi5wRXZy5zXaEvaoNat1ch08Ujk/WYHqAaSQomxFwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHRjIyHb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so38550185e9.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727694528; x=1728299328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jS5foYPFw+7MlHtlttaFVc51kmQyW9V+nLbvWZ1rUR0=;
        b=kHRjIyHb1piJXys9T9mkozTOTqasDM82rpfT/C7sAOBSeB8dAygLEpCIeAq+lgGKFM
         U5E1T/0xX8Y2sDBDwZuNuwzgnQTF4hBUcZFe2p6j7IyNJiijvPzsK4hTkm1Sgf6Wkk8D
         JpxkOJ9LNPD0L5p0A0FolRsdwS98RwCbdo+Dl86YyFEnKZYAl5h6lIzJGM2TbbzHH1aS
         IZfHX1zIv1O97CRcLCfAJp/dYMvGQLomchs8RTgRPALCNUIFnAf/mHQ95nXdaJdGx6SR
         uUuJ2Rg7/WkCR9+QIf6hrVqjAQZad2t/YXQfGPkBXS1HbINTTvMi6SEhEnNt8LM+oVbz
         M5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727694528; x=1728299328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS5foYPFw+7MlHtlttaFVc51kmQyW9V+nLbvWZ1rUR0=;
        b=qFdRI5fFNblJmZS/evMz8irfOcCSO8I0RDspj0neOkKI6l0ZcMwR1YZvr2vH6XcA6j
         Wq/tTaGRV6dV6X7vK+3qvC0+m5a65mYb//j7ebMuejZr9tIFoJSTg34rB3WpjA1Y88o1
         vlMWMU9s0ACDjfPtY8Af6LQ0ZnNRTcY0E0wb6oXtJ63mR37i7WXI0UsMt+fsOfbApHYP
         TOdgRdKWApbvukfeekR95vLOlNjzUsN2wiUMMO/qytUfkG9GtTs+32qoOD7YGVDHZFIX
         R9FcgYXgBVEBW74MWdZPSVWHaKRpFTn5S5QsV+qhE8oiKdg454k0ZWy+pDtH3zklYI+8
         GR5g==
X-Forwarded-Encrypted: i=1; AJvYcCV6zmyfa+jEW3T5hFedtuff7CEjAgcER+No7/O4exT2zK4HwzfNpGK5YUcQswq1ck6c78520+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpdi6dG0x1R3FTcDymKk2+m5VmX7V7VcBSBfg7XYPOGCI7SWtz
	HY0kMrocMznE8nzUKgM6BUe+nnV7aDfu4NBqHElF9g4iRMJ62pwvyqiD4oNROgA=
X-Google-Smtp-Source: AGHT+IFGg2veOSfnmKLkdXdNH1vwXOxwCNmNPQdYmbq5EeHtVBttVKz1yThA3rghx3EQfbeYSVomVA==
X-Received: by 2002:a05:600c:63c5:b0:42f:6d3d:399f with SMTP id 5b1f17b1804b1-42f6d3d3a1fmr12755275e9.21.1727694527929;
        Mon, 30 Sep 2024 04:08:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ffc56sm147423715e9.22.2024.09.30.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:08:47 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:08:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
Message-ID: <129309f3-93d6-4926-8af1-b8d5ea995d48@stanley.mountain>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
 <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>
 <faff2ffd-d36b-4655-80dc-35f772748a6c@stanley.mountain>
 <84f41bd3-2e98-4d69-9075-d808faece2ce@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f41bd3-2e98-4d69-9075-d808faece2ce@intel.com>

On Mon, Sep 30, 2024 at 12:21:44PM +0200, Przemek Kitszel wrote:
> 
> Most of the time it is just easier to bend your driver than change or
> extend the core of the kernel.
> 
> There is actually scoped_cond_guard() which is a trylock variant.
> 
> scoped_guard(mutex_try, &ts->mutex) you have found is semantically
> wrong and must be fixed.

What?  I'm so puzzled by this conversation.

Anyway, I don't have a problem with your goal, but your macro is wrong and will
need to be re-written.  You will need to update any drivers which use the
scoped_guard() for try locks.  I don't care how you do that.  Use
scoped_cond_guard() if you want or invent a new macro.  But that work always
falls on the person changing the API.  Plus, it's only the one tsc200x-core.c
driver so I don't understand why you're making a big deal about it.

regards,
dan carpenter


