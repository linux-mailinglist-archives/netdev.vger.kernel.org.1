Return-Path: <netdev+bounces-160426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A3A19A35
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 22:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2147A5333
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2461C5D78;
	Wed, 22 Jan 2025 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nLTN5kQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E741C5D71
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580438; cv=none; b=s68r77+m8ZLmKgkwKuu7knNU+sGDPqX5DsRQc+KwsD+nHXlzZc1F046auwuKZsnP+JqVxGlHMeBo2txhAZGE1Tv43LqhK9PFAg9D0qUg1IqDH9zgiJ2hACu55TRzPJw8+R0A0thWiFEG+UidmIqhOZuabU5J393pxMuJQ88FYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580438; c=relaxed/simple;
	bh=sjbjhnDFCszh8dsB5a7lQjTp4yQh5R6DJ9RD9J5J+cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOOCF2yum6ljnQgWE6WEw8X+On1twJotEI0xNRI5GY4UqLHWxhT+DqzLPYKXMzVNRNDoHKTiYqvD4lFuARIQxxLYvwfrRr6UbEIimHjKrN6PuCLSpiXfKYndJm+hLNiB8ErpbCfAdx1Dmy3wVNxk6pKgSpMvVdBKLhjp/aLBVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nLTN5kQ9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b1f05caso2049285ad.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737580436; x=1738185236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7HDsLV0VmvzJvPT51BF388McDxmpNDYV4SLQX37XOo=;
        b=nLTN5kQ9lnCZFVPyEY38zGB7F9NMjM3YThjbznMjV9e5uCYYjDLnphhL2qb9zUPEnc
         9yzm7dTnZrQkjKn2uqm9cwaq/KCi67cEtqzDokMJ3UZBF9KR+78fYtrrBnI1d7aGYD7g
         +Jjt6fkN1B37AmkOuYitnyiNQaaIw4q2LUTOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737580436; x=1738185236;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7HDsLV0VmvzJvPT51BF388McDxmpNDYV4SLQX37XOo=;
        b=I8uRdFHXJEoEsSyWeeHxIjKle7aOeXWcRm0/riJam5zSqpNbCycuExoN+gK7iUBNjk
         XZksiEUzCCPnFL7qnVLsr7dTFZbwmypMUXz38HekKAPtarsgvC7ukmYaWHNdMOxQbwk6
         CtJdJ4b3k+e8PlC1QGd4hR53vkaVtfgBYcTkzbENbCzzwbidKpk//hABlXepUmpBt/Mw
         vUjWaVm0ElP55rlzEsIzb59VIOteRzZlqJoVLksmMRhTmCqjcryEk+8WErxALeWTSyw0
         oi8fK8kPrzaiNrtQvOuqEX2D9b5jKYxAddcEnpsn03nkVzAr0UbdahJVX1tz2htK0K8A
         8paQ==
X-Gm-Message-State: AOJu0YxHV2LKVhQIpWIl8qvh4sQNETeP8HqofgT1JfKIQvxWmw/9Vh4+
	zLeYV35CKPmsCNAghm0PhrkUV1zYn4+xYvmznyhFZaVsCeCfxREIsyDrEa8mygo=
X-Gm-Gg: ASbGncvzdmE9ZAFi7o0u++YupJjha4nIb/7O7gW6AjKA6P5V302K/etV1kPoQSIHuLd
	9YeYu41XtRK/BbzWHj3xuJsQRHz5RXhPpmEisvBjvbmSmTiw2KyXCza9d5vVFSN0ywEVWHt+8R+
	/7pflVzd3mUA0MVF9nToJ2eXT1grVO1CV2HitLsbOAhuuI7/3c6iZnjou9k/RyE1SGAF+uRrKLM
	scPuwG8N8BLlHoaGUZh/0BVtJBD6AqAqLdDd2hGtKpih4KA/J11fJMXr+tVXPPBfg4IohEDSPZk
	OzSiCZnCenRKQgHFdhXQvwnCYrIhx8x3n/K/
X-Google-Smtp-Source: AGHT+IFnGTbyJeWJgJNMPN5e8gwkVuHfMKDRUWJU0nRCQAB2/XDxUqPMySd1Gi66ENhJK3FvANYlPw==
X-Received: by 2002:a05:6a20:3d8d:b0:1e0:f495:1bd9 with SMTP id adf61e73a8af0-1eb2144d37bmr37973029637.8.1737580436218;
        Wed, 22 Jan 2025 13:13:56 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ab57d7c40dcsm4881347a12.41.2025.01.22.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:13:50 -0800 (PST)
Date: Wed, 22 Jan 2025 13:13:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v16 0/1] MCTP Over PCC Transport
Message-ID: <Z5Ffi4PSf5LH0vOS@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	admiyo@os.amperecomputing.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
References: <20250122153549.1234888-1-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122153549.1234888-1-admiyo@os.amperecomputing.com>

On Wed, Jan 22, 2025 at 10:35:47AM -0500, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> This series adds support for the Management Control Transport Protocol (MCTP)
> over the Platform Communication Channel (PCC) mechanism.

FYI net-next is currently closed [1], so this will have to be
re-posted when it re-opens.

This could be reposted as an RFC, though, until net-next reopens if
you want to go that route.

[1]: https://lore.kernel.org/netdev/20250117182059.7ce1196f@kernel.org/

