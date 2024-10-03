Return-Path: <netdev+bounces-131602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45398EFE1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7FF1C20EDD
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E7174EFC;
	Thu,  3 Oct 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaN3Gw8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982F12CDA5;
	Thu,  3 Oct 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960439; cv=none; b=YigfKD3avXniMTAe0rEQMugDLn0k4Hp+aQc+Qx7u2DFh55IGzSyB/gu5ImrWW3qriaEenlEvo7gtal/bwhmhPAh7wUok7Qm5F+aqi8Rhpdk+UoNgmmbJKa5l4RVChqTWoyX9z9eLixZ4/WIpRGA2vLGPaClHfMHVC2mQR5/MOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960439; c=relaxed/simple;
	bh=lr1LcrlZiAs3pzclK8WLXSAmyjiu/JdtDjy9KqWpOl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXdg2EyuWkAcx4RxYl4bIIdpxVU5GuTg4FhZ3p/PJMy2qULNOBVedq4v9e4ztdOKq9DcBXNIUDkk+/iXY8Fg681AgpztbgDdz2wEkI11Ooyrdq96T0SQfL6Oc+MS3wMA9YpRVszK8pMfl/l4RsIvdTDhiYhvNn7DpACPYQslcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaN3Gw8e; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso565231a12.2;
        Thu, 03 Oct 2024 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727960437; x=1728565237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNStZ17uWpYU/jURve9EvXV7ntb2QbEt0z1Hbrg+6RI=;
        b=SaN3Gw8e/Rq8NH5cLHzJ15/QItzF4WQ7o44Z6zWqhChXzYpPvBC7k1R4Zx0QUIQPb5
         MnTVEly1UebFTb8XjF513eaSN/b7RJH6MOeo+W149fXVXKvbvCfBlAHv239E5dL5Cf+Y
         e1LBX0AJnWcBbfLwQbn7ZUDDWM9epieOhV/rGri412QkvrEWcn4srTMUEF/acvHgJene
         gW7hDm9g8mVAgQkQjtBZRE5iRn+kB2kqWfk89oI/JAXMoA2MDpml9TwmPGmJDfw0L72g
         TTJBabargbP40Zllqa5LjA4El17UlFbCljdCiuYAvrCRg3hnmC/zHJ3LYWRjKiT51iae
         9U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960437; x=1728565237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNStZ17uWpYU/jURve9EvXV7ntb2QbEt0z1Hbrg+6RI=;
        b=tNsfdQIVLBOXOROu68eHPDiLDV1RZoaKYJ0Ex4FqI7EX+uLMTWQ7WT7wnBn8UsHfCV
         wRqYM1tsTjs4/qJISsHMRyeVkungQ2wmAGdqx7R240YwIdsPMK7AhWWf0S72BC+SUJr/
         cTVc9JjV1d/ZHjbShC6ZuILUzAsYzd7cdgxFJKGy4UvDn4kb+FHxFqUi9iTOvJ0DkLTH
         XkluWOlYtyw2a0szSYsRoDFU0iWNrSwavXReXisHy09uAExC9cFEKSJNF5AjAyluQVdc
         86YPtQt3L/LfmL4otmmx6ht12lDtLUZ47lFPHLML3evoz/d70V8Y7Jww/zrQe75W0BHE
         C4tg==
X-Forwarded-Encrypted: i=1; AJvYcCUD1PT1XS4iLvpkBNlXm4FH2f9rdarsdadaABxeAQixWt5mCpGHS3lS/t9Q6E6EOEMWj8+50Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWHlj8Patplyw4vmK5aueRMniRKuVCMLc3Spv0y2SnM1yhhX0
	ZW5UBMMM89u/RC88BSmAgZu1SKsT2emkV06EqvpVI37kysSthJ5U
X-Google-Smtp-Source: AGHT+IHlS4Q8FtWOWYBJbJh3/oZyzRizXMY9jYwFIye5OLUfQgTnyFLvAaRC+XJAItdrwrI59oxp9g==
X-Received: by 2002:a05:6a20:6f02:b0:1cf:3677:1c4a with SMTP id adf61e73a8af0-1d5dc378445mr9796636637.16.1727960436925;
        Thu, 03 Oct 2024 06:00:36 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fba0:f631:4ed6:4411])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddbaf7sm1245476b3a.136.2024.10.03.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:00:36 -0700 (PDT)
Date: Thu, 3 Oct 2024 06:00:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
Message-ID: <Zv6VccBLviQ2ug6h@google.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>

Hi Przemek,

On Thu, Oct 03, 2024 at 01:39:06PM +0200, Przemek Kitszel wrote:
> @@ -167,14 +172,25 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  	CLASS(_name, __UNIQUE_ID(guard))
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
> +#define __is_cond_ptr(_name) class_##_name##_is_conditional
> +
> +#define __scoped_guard_labeled(_label, _name, args...)			\
> +	for (CLASS(_name, scope)(args);					\
> +	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\

It would be great if you added the comment that "!__is_cond_ptr(_name)"
condition ensures that the compiler does not believe that it is possible
to skip the loop body because it does not realize that
"__guard_ptr(_name)(&scope)" will never return 0 for unconditional
locks. You have the explanation in the patch description, but I think it
is worth to reiterate here as well.

> +		     ({ goto _label; }))				\
> +		if (0)							\
> +		_label:							\
> +			break;						\
> +		else
> +

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

