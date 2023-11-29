Return-Path: <netdev+bounces-52137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3C7FD7AA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FF91C20BC2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1324A1E53C;
	Wed, 29 Nov 2023 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqU/7FAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CE683
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 05:15:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40859dee28cso54220075e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701263699; x=1701868499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCb7mO0P65hH982TSTp6VehL+Jw2ctYJ381TqQAIXHw=;
        b=oqU/7FAgIcKgw5Gvky7LX0iZ9F2BKF+QEux4zlBNMfryZtMsusj6gcxeAvAhxXM3BN
         ao/knDPBAmE7nKgjorD2bhc0nKdlLebb+euJ222sqShtUvUyEmot7ZyyOIcP8cjcj7Iu
         GR+qHgR0sKy3qOEA2rHr/AWyrBnMhMkFm983/85PCD8L14UCoAbxvSaTOMeg2hQNzkyl
         1YlM/TK1wyqr8uOiy6wR+yWpdPzdk+cOQrc5Mnwx+NZp0rNRpYQ7+E78YJExEuBy21hK
         ky0vl9IBW8HlE+j9/0K7IZ9pkpgEpeQZq3vxCOznOOSJvPhVYo4KyqosrvDtvJ30N2tA
         5LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263699; x=1701868499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCb7mO0P65hH982TSTp6VehL+Jw2ctYJ381TqQAIXHw=;
        b=lzqCcOhKF5KCP/L+v/rG0jj5klgaqc6P10gu9sj9ybBfHm9LZZh4L2IruCU05aAyYm
         VmXcuKSX4ZZ6XaMR8E4uJNLMSNaT1jMKLtSvfvgujQU4ymFAjYe3h5pSFy8S4KzvqfWJ
         zIyopp046uoCd1FsNkwJ8BIgJzv2doZQa7t4D9iXvjxmn1PFkJczD6hn1j8gu13300MG
         k3BL52i9vZhXBHjDp6ldoNb867kVa3EwHaPa+yiH08uWSY7mlE4eVSEmoP5A0wSwSNBC
         V85Gp93EbKd4caVHfh7SzQ9aqhSKYMVewbD1gVZO/N9ZrTu1XSGWJArVaD2dDZdYER44
         TioQ==
X-Gm-Message-State: AOJu0Yytfh15EDPy+pXd6XZLxglwjhGgsc2hVODomoM0At47MG6qGIIE
	fH7+BEgLKxRMvrSE/OlSSe11zQ==
X-Google-Smtp-Source: AGHT+IECLzmX8tnTjge8QgN9y71O8HaUe8WVuFH5FAYhx+jzE27lljnm0cOhKi+7XoSsIN0MkAcYNQ==
X-Received: by 2002:a05:6000:1a48:b0:333:130d:4319 with SMTP id t8-20020a0560001a4800b00333130d4319mr2468608wry.17.1701263699272;
        Wed, 29 Nov 2023 05:14:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332c0aace23sm17799621wrc.105.2023.11.29.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:14:58 -0800 (PST)
Date: Wed, 29 Nov 2023 16:14:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, grygorii.strashko@ti.com,
	thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
	u-kumar1@ti.com
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: improve suspend/resume
 support for J7200
Message-ID: <1d1490a2-7d7f-42b8-862e-f0959544a520@suswa.mountain>
References: <20231128131936.600233-1-thomas.richard@bootlin.com>
 <e37e8d74-d741-44fb-9e28-2b9203331637@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37e8d74-d741-44fb-9e28-2b9203331637@kernel.org>

On Wed, Nov 29, 2023 at 02:38:49PM +0200, Roger Quadros wrote:
> Hi,
> 
> On 28/11/2023 15:19, Thomas Richard wrote:
> > From: Gregory CLEMENT <gregory.clement@bootlin.com>
> 
> Subject is vague. Please be explicit about you are trying to do.
> 

I'm glad someone else said this.  I wrote a similar email but never sent
it.

It's not clear from reading the commit message what this looks like to
the user.  Is the network slow or does it stop working altogether or
what?  Is there an error message printed in dmesg or something?

I feel like if I were more of a domain expert I would understand the
impact better perhaps?

regards,
dan carpenter


