Return-Path: <netdev+bounces-163774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436DEA2B860
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC347A27BB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DE914EC46;
	Fri,  7 Feb 2025 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Lz5cm0GD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8D1474A7
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892784; cv=none; b=J2Ga+8WlBP8wQbTwksvwuyVGqImrTJec06y3pS2bihxIRjIyAmdQkwR+14elYmKQc4WTL2493YVUc+bDqZct1FL3pBF2eV1QuwtDlpXRZXtKpiflEHMaxtfBkSHm1MOzB08gyPvfjLA+Ffld7GVRvYk5MV8mL6Ly5G3ZtoDT6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892784; c=relaxed/simple;
	bh=hyLeDvnLTV29+khiprOAmxfCaatpQ++A9+PmCn+j+KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGSJfV2P15YG4nKai5XSF0hdOZzEByKoGDXpYmx+mDzhO7eeKKKNbNppGPBRWowvVyhbka0cKvfrXGszOE5HWVvv4Uwg421Tp/I+wtOhq81SKXkKNqt4+rOiPK0JJabxXQ7vNhRYNfdcE9/bQ2nGfgolf8NvgksJOYkFYK7/96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Lz5cm0GD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f11b0e580so31273315ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 17:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738892782; x=1739497582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95W319fF0TuhfADXZYWyhM8ZPI/uC+h6x4fXlzFN76M=;
        b=Lz5cm0GDjVY3zKssrueI3yp6yB6Dj63XoNB8OfiJexs9LQuY7zMNghBaUVtVGCF+A4
         Q56mpqr4xUWGTHzZwvbhgNbPZx0FIbyku4wJOZLAWwfiDJNWU1fY+UntwxvWbwse4cuC
         T5PtKm50gM/rurwBd1E8DGYQvAatzANG84d1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738892782; x=1739497582;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95W319fF0TuhfADXZYWyhM8ZPI/uC+h6x4fXlzFN76M=;
        b=s1kUkb97+sV9ue7kXEkAi7nqTvXDdgbp5ZGL4K7Ji7gadDk4610JwmVMuC5oxT9oyO
         jfwqKNu3KfIO0qfYnOLqpfdU8WyrtWbdkaqjNVuTSvdscjUmNUcwePPNHXQ/zw2tDdth
         XThLV1u7BuvzKKL3DHKj1zSSZdw/OGp5Pf0uwDv+5juHr9WuBdwlV7IR8s2UKZ1tIoUj
         HRqqyGCMQOtiWJsQm45Ezxk3OVhu2VFZVOGzQugFmoXiNDqLShlhQNySGQ1IAdvHEG01
         +iqy0UQUSYvwpukSco2M0zJlYFaRyl+FnIzgfMa/eWXVWWPdkX2z3uA4o61glzJDNDLp
         w54g==
X-Gm-Message-State: AOJu0YxmMXErjPjJOSXz/z04sEBEZ+g497WqNt3AjvWxDeIm+wUXJHnb
	iC92ds8bCgJJIEimV8SlJu1egH2fA23gbrZSq0vHj3v9tWUDDz3Bev/DgpU/2uw=
X-Gm-Gg: ASbGnctLbbN9HzldjPZKELs5nYDUr7k5GTHcS00P2rH8SdDONPT6q+iz5Q2u92ghs9T
	aEyy7BUJfnLieFDwO5nsbbyVQaJwKAC62EwD5jBsyjZs1M40fJV64U5JwNLILONIN9G/m+RQZmB
	Yj0wvBj/bytWPIdAbEILg6RMKhI+TaFZmLqVWaU4NpymD86+Xp7M90kEWYiDpZrwvNFq4bUpatW
	yuZ7d7AcDx5G65af7ah7y47smrRviVVP5LRZoTkedytsGiBkera8QBoIsdbVYCC6S3BMjQjhBke
	kkZNwmHWXwmN+svBlknryrfJKeZzTMbtUTFv99ToQDq+U3A0Xa/fRptgzg==
X-Google-Smtp-Source: AGHT+IEb0fEGfaDmVEdZDvNICNH+t4hrQlDHBujjTzaFy892ln/2xVZtzkVxDOZrFFZTZ5x9LoppSA==
X-Received: by 2002:a17:902:f60a:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21f4e73b2c6mr26502755ad.40.1738892781880;
        Thu, 06 Feb 2025 17:46:21 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm19561545ad.57.2025.02.06.17.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 17:46:21 -0800 (PST)
Date: Thu, 6 Feb 2025 17:46:18 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <Z6Vl6lcPpj1qBN5e@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	open list <linux-kernel@vger.kernel.org>
References: <20250204191108.161046-1-jdamato@fastly.com>
 <20250204191108.161046-2-jdamato@fastly.com>
 <20250206165746.7cf392b6@kernel.org>
 <Z6Vig04c-a46WScr@LQ3V64L9R2>
 <20250206174138.7de4580d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206174138.7de4580d@kernel.org>

On Thu, Feb 06, 2025 at 05:41:38PM -0800, Jakub Kicinski wrote:
> On Thu, 6 Feb 2025 17:31:47 -0800 Joe Damato wrote:
> > > nla_nest_start() can fail, you gotta nul-check the return value.
> > > You could possibly add an nla_put_empty_nest() helper in netlink.h
> > > to make this less awkward? I think the iouring guys had the same bug  
> > 
> > Ah, right.
> > 
> > I'll see what a helper looks like. Feels like maybe overkill?
> 
> Yeah, not sure either. Technically nla_nest_end() isn't required here,
> but that's not very obvious to a casual reader. So a helper that hides
> that fact could be useful:
> 
> static inline int nla_put_empty_nest(struct sk_buff *skb, int attrtype)
> {
> 	return nla_nest_start(skb, attrtype) ? 0 : -EMSGSIZE;
> }

Yea after reading the code it makes sense that nla_nest_end is not
needed. I wrote a small thing similar to what you proposed above,
but yours is more succinct.

I'll go with that and see how it looks.

> But totally unsure whether it's worthwhile. Just don't want for someone
> to suggest this on v4 and make you respin once again.

No worries; respinning is not the end of the world.

