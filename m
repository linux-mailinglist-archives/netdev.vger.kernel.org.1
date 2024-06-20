Return-Path: <netdev+bounces-105114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A490FBFF
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C071C22BBD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 04:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57F22331;
	Thu, 20 Jun 2024 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPga2nV2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED651BC5C
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718858575; cv=none; b=ZyoaTcYeT7CY+omohm2A/4UbsqFm4i7fUInY0AINJ7vn+AvBSLZ/K3b0trDAxiHzEqK/DpgI44LriMJmrja1VGduVAukvZ3/uYFxqUYlBT2LLWx1ZUZ9s3tFod9jz8p20kK3B+lCcp17eQyBxgCuh+6WHXIAP1cBpnB5OgAMiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718858575; c=relaxed/simple;
	bh=uzzkPcs8lCHNAumYb3EKWfabn2YUL1wDortOyGc71RM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PtzqSI02UdHh7xLAOZj0cbogQpK2rLQTXtQVYQbBNqpc4dLeBT7kFJC4GERu8OhCeknNKvHV5YWVDUqXK7c3uv9uQe08rPLd9YSuMNGV9O4RjWrVfMtt0UcqHhTz8w1vGYyibcjuLBs6hZcohATQQJmptg+xtBHuufA8neAFhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPga2nV2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so5241055e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718858571; x=1719463371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j2WdRgfdMpyiBrvtErarE+gTPA01d088qFGFQbVqHg=;
        b=kPga2nV2LZtZ4XrlKlu4GXZoaoz03wR+XJ+EUz9gFjg/eR4mqEBiOaVcv6T3ffyBR9
         DvVuyyEn4cIMy1nSgAvs8LxKfTCyd0SDiq0MH+5C1WOE0z9dGrohjOYyUhUO0SViGWK2
         8I9HYf8Or+Xv93q3VEW/LU7OvXmteh2LSI1SW+WkkHZqrpdTM8pwzpBGE7dgzxkE0ytN
         YF0FVoflHExwJAhUMdXJiZQHIkM7bW0Vl96ysel7rWmezfww7v0Affx/MXmwrjXryDcg
         NhWqWvk5beML0R/SZDpL6rFsijBQYcSi9hYJ9PrfaNE2ujXQExDqkv49cTUDCE9VuTM7
         mlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718858571; x=1719463371;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0j2WdRgfdMpyiBrvtErarE+gTPA01d088qFGFQbVqHg=;
        b=A56PSPibztzxAUGkH7XqjaRv5hPgrwJqfbilF2HVGa27lGrHL209FK2ZqjTHuqoV61
         Q/jsqy1hPw9QW/KFUAqJvjll/CKQsnptQFN8GlFinhla/wSjCVbw/YmBuww+7aY0cG9t
         GoR/4bgD2nPt2HArZZDOXJj7TpKCLS18CK931aXSWsOBTXd4Zx40icOrALx9QHlsTN21
         H6rYMOqrXu4lIQh9bh1hhgQW1ZNVqirAmUjW+mur9PSCISFOi8wX4Jo1+mIDhP+UG/We
         rn+s4Q4ntgTuwsznwmJyHHo/APDl0xVTiczocqNqhgThzENO0vNTHoPzJi4Md78tZDeW
         YdzA==
X-Forwarded-Encrypted: i=1; AJvYcCVgAXEZaKhi5dDe4Kphi+ejJP0aVuBDv7c1kgzMmwTC+8GWZ51t3R2QVKI4QydATXF+DFSIag9G2iGt+C3YJdVFxyFZhfst
X-Gm-Message-State: AOJu0YxF7R1+Tmz0r/uCeQeG2wddEY7GWIt2N3pq0i5ECcrityViWxmO
	1GIQGG0HS1dxEHOiFxq0BudcyYr3Z19TlYWvlfwu717YOT1UPe3U
X-Google-Smtp-Source: AGHT+IGdKxD15vyFB9SqkmZN/2KOPwkGVhierVAa42qXXA8YsihT5Top7UihDeOQSuYY/9BBPmyi9Q==
X-Received: by 2002:a05:6000:e81:b0:360:9392:4bbe with SMTP id ffacd0b85a97d-3631998f4d9mr2780962f8f.68.1718858571385;
        Wed, 19 Jun 2024 21:42:51 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c7e5sm18797846f8f.30.2024.06.19.21.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 21:42:50 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 4/7] net: ethtool: let the core choose RSS
 context IDs
To: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.com, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, mw@semihalf.com,
 linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
 <7552f2ab4cf66232baf03d3bc3a47fc1341761f9.1718750587.git.ecree.xilinx@gmail.com>
 <20240619102435.52b7be88@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b00f5093-d1d2-45a1-4af2-4c98f6d3fb32@gmail.com>
Date: Thu, 20 Jun 2024 05:42:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240619102435.52b7be88@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 19/06/2024 18:24, Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 23:44:24 +0100 edward.cree@amd.com wrote:
>> + * @create_rxfh_context: Create a new RSS context with the specified RX flow
>> + *	hash indirection table, hash key, and hash function.
>> + *	Parameters which are set to %NULL or zero will be populated to
>> + *	appropriate defaults by the driver.
> 
> The defaults will most likely "inherit" whatever is set in context 0.
> So the driver _may_ init the values according to its preferences
> but they will not be used by the core (specifically not reported to
> user space via ethtool netlink)
> 
> Does that match your thinking?

Yes, that was what I had in mind.

> Indirection table needs to get reported.

Okay, I'll alter the documentation to say so, that notwithstanding
 this bit...

>> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
>> + *	note that the indir table, hkey and hfunc are not yet populated as
>> + *	of this call.  The driver does not need to update these; the core
>> + *	will do so if this op succeeds.

... at least indir MUST, and the others MAY, be filled in by the
 driver if they weren't specified in params.
(sfc does this already, because it uses the ctx as a place to store
 the new table and/or key if it has to generate them.)

>> +	int	(*remove_rxfh_context)(struct net_device *,
>> +				       struct ethtool_rxfh_context *ctx,
>> +				       u32 rss_context);
> 
> Can we make remove void? It's sort of a cleanup, cleanups which can
> fail make life hard.

At least on sfc it's possible for it to fail.  Apart from anything
 else, I don't think there's anything in the core to catch the case
 of trying to remove a context while there are still ntuple filters
 targeting it; I believe that gets all the way down to the firmware,
 which responds EBUSY or something.  If that happens, we don't want
 to pretend it worked and delete the context from the xarray.

-ed

