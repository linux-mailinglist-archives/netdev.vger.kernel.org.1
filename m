Return-Path: <netdev+bounces-147931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F0E9DF343
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73842B20DEC
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55531A4F01;
	Sat, 30 Nov 2024 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czpJJvas"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAB130E27;
	Sat, 30 Nov 2024 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733000584; cv=none; b=CjA2yGlRsSqarnkV0mnc/UGmZa5rBJ57LNjcVvR7K2XTotaeUmHWE8KBbogVUqfYkJ8OqBvIR1Rg45kIb6YwtUZzl6FX6N4RKbyUvxUmS0gtspnTimmlWce81ORePTuLNyiFLDFyPXWlvcOMAuMD5ao0mY0Wm5IXrB7UgofDSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733000584; c=relaxed/simple;
	bh=EBeZJUBsWrpiPfn4xCYEZkI7rqKpJ8MQ8+R179mZrUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXyybF0qQDDKp731VzGMxaC0LK3ejw/EQ7OJFcHa5dAHkBBkvnPTT1YiN83NWqlk2UmK0aT68GsbKIFqoTbHTosE4/pV80eTIvFs555x58qL43uKY1SSzjA4NBlJVuCukeeIC204OOVQVwkmbtk3yTpOyIVu8HoTdKj+R0gZ80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czpJJvas; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2129fd7b1a5so24168265ad.1;
        Sat, 30 Nov 2024 13:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733000582; x=1733605382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBeZJUBsWrpiPfn4xCYEZkI7rqKpJ8MQ8+R179mZrUU=;
        b=czpJJvasn2c2gsPLG9F7mTsMOJh2fstbvi13S2ieYZEb/tpT2tkHK7pZXhLFzTOb13
         /Zqm/ICvoFLUIo5yjolTHDM9AN1srC2Sr/gVLqrrefvNHTyf4qsqkR7o14JZi+Eelm18
         0j2D6X4mSgQTHEMyNk5RQQX4TT4CPj7oHSTJI0kIAjAD1QeCLhvKokHFxkdmVZkUXUHR
         CB346D8+6vFF/JJd5UElnZAPkjbV5q2j9OZZdmpZCedFBGwfnI7A7RWz06YEQXPaWvFR
         o7ePopoEi9mwaJzRh7G1EaWA/7OR439JhBuYdFrNVs0TYI72HqGnXKM/7Gwa+fZOAg74
         ANEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733000582; x=1733605382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBeZJUBsWrpiPfn4xCYEZkI7rqKpJ8MQ8+R179mZrUU=;
        b=WxLGufTEyFH0KZcKPHql6hYzKAcNr0dMVbnYX6WBg3BtUa938NzY3Vr0Vy9WX2AzjF
         +ejCzEvxe/WnzexCqfv7r3H4fj/8TbO9Vsnmssur8Ot8T3zZkTSD9GerZQ0fKnya/vEc
         9V5wx1QEojLH1TO0kK6T2k2NSX8BvKVYDOcNzu4Y+rTrEf7AWQLcnMydBTGCzpm2y5iq
         SzC+Z9XBHfu//6vb5GaWY9Khe2lE/heR42O+kIUsl6+VPI6l2RRCkf5DjmTMNBfWyKhu
         2E7mBgmu89LOoOViXctq90dDSPwbrH743uM0G6lt9BxIA+nZMss6+xd2jjvPXHJ7RsXl
         ZQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCVWtiVuSfiRSXkbdhF9djfLn998LOzGCjgWagHJZVouaNmJD/nXhqKshvbRE3QSmUqdHHwXgD44aOY6+Cs=@vger.kernel.org, AJvYcCWEQUd7AyK2X6jq4zFuHUd0OfqlqXbx3bb8lWry1MyCaeNPQB1SKS85G38JI61Sv2LiIzdWGK5T@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1i2bbrV49hjFw1FhRJos5114iUYiq6xIgR65x4kgLjir3WsVw
	ltOGPvxMveBMQ41bt5A9UV2yRJNARF9xUa7CQ9JOTy6GnVvpPxvv
X-Gm-Gg: ASbGncu/jlAnCCkejxTVtaZJ6KqYoIxzWVOQK33FIIg2i3Zz56jW+98gndISYdH2mHW
	dvEOu1t1A/Vvy+aPAhzJlfMxYuZZsQ+4ac5qNbBNwTh8qFu8iP4GPu5qidlXEIiawsBcBREbwir
	+EzFjMVKRItGxr2t+AV0eDsVg5z6VZeYzcN3AvDvWn9oP50aW9vtvKRVijyhS4t3Mm+OO7qI+II
	+UPUFpI3AuERkz/xdZp6lBu74O0xLrS6P5UyEa/xuytB+ZQKPa8DozadohyvhpvGy3PUQ==
X-Google-Smtp-Source: AGHT+IH6HnEhwHYixj3k5bDFPRIuQtHOobkAIvBVBSJOG4ukLp4q7VMgO9yJlEEKYjsovx7S1CL17g==
X-Received: by 2002:a17:902:e883:b0:215:4fbf:11e1 with SMTP id d9443c01a7336-2154fbf147amr76137955ad.19.1733000582467;
        Sat, 30 Nov 2024 13:03:02 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c388f0bsm5133110a12.54.2024.11.30.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 13:03:02 -0800 (PST)
Date: Sat, 30 Nov 2024 13:03:00 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	David Woodhouse <dwmw2@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: Switch back to struct platform_driver::remove()
Message-ID: <Z0t9hKFT-S1782o_@hoboy.vegasvil.org>
References: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>
 <Z0soVfzwOT2IHunn@hoboy.vegasvil.org>
 <lchtswwdxq7uwjfg2e46k2jyzpr43jk5hxvwoode7cc56wuthw@l2feh4c2yu7a>
 <20241130110144.1a845780@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130110144.1a845780@kernel.org>

On Sat, Nov 30, 2024 at 11:01:44AM -0800, Jakub Kicinski wrote:
> Yes, we pick up PTP patches with Richard's ack. I wonder if we should
> adjust MAINTAINERS like this:
...
> so that get_maintainers --scm can find the right tree?

Sounds good to me.

Thanks,
Richard

