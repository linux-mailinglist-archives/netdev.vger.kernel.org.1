Return-Path: <netdev+bounces-112454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B2C93926E
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 18:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6732824FB
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06616D9B2;
	Mon, 22 Jul 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="j2YMDRkR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A25E2907
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665158; cv=none; b=u/+KMLBOLBbsnQZtCJ67CMF7I0Xm/bLGtAaKp4Od8Gb+hTgSZeHemmGcTryqB8KyFtqQjVBHWHB7MlrbQrznSeZEpVIW+xnTUSVPnZe3pTSrXBnbeKW9MbRqTkBMQEzYZcjm4y1u/QmCZJsXDvAU/tM2ddoegVqXB3vtqF1s40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665158; c=relaxed/simple;
	bh=oSuZ9GzwKYm9u9rw3lZZfvwMhKfYoCJ/OrxEZNvF2Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izJ3XPEiYm2KdscL/wyMd29Hjw8io1B6mgdlrsWWE7sFPCCb3khqJaeIcWfYwjmH/9JCYckLKb0QMp4tUL/vRhOczyczHjIDSsGuBGFsUuVzGupxTl6Nh2DYfLYRht1S4FrfEs3ACXTBRFBlx6hzHbdjnUR3tJklo83ognEAQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=j2YMDRkR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc491f9b55so34909905ad.3
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721665156; x=1722269956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXlksb4Z1J7E3IS7lXfG+qoUB9fXZVAMP1u+8w3MrMQ=;
        b=j2YMDRkRe0UT9GGnpC8ToD6q4nSf2JLrqwGk4zC/Ft7t1/ez/wyYmem98uUfCmlo0/
         CJxKfB8De+0A6RI+Sc0fJDcY/IFqOpPrwh6ROlm7b+IoeMPOSC8zGLGC0B6oqbErAG6A
         ppHlCpxHbX8dQZ93QlL0xSnX6c2MkltfH9Xmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665156; x=1722269956;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXlksb4Z1J7E3IS7lXfG+qoUB9fXZVAMP1u+8w3MrMQ=;
        b=vKPm1UCmE8N13g1Hx+/LfEBVh60NnWf0o0nmKAERSLF/uZxSWRuWwa7tFdf84J/8bV
         cam0X6cPU87eSbGB6OckmvikRTLojaCqVfG9BEnOoe0ieUXKMNRdKflovljdJKyVrJYU
         mwp6HeHc258iyC0Br8fpfPx0NBGkvHQNI7p9Jlahkob71CprRPq0G7d4JgapQt21ZOBf
         9QIdc7nNP7b9cXWJm4hke5IaYLVMBoo+V/blMG5sd0clnNil0UT5hf5yTUWTkIpBQRI0
         hzSirLz1y6JCUE4p8Xw1B3AlbiSemtyK0lDIWI7qNkh+ElpNFtyxtO+uoL0V0RjgkRrE
         RGbw==
X-Forwarded-Encrypted: i=1; AJvYcCUixiOBFeB53YpscGcIuJAV6lQnaB8VNeohdxOTdl2CeF5br2lmS0eJJ0h/y7RKUgPEGguFSqb1QmvHe/FkOkvTjtbrepsL
X-Gm-Message-State: AOJu0YyTq/+/PmYY89rR96GJLqSroovMOLugRnYkcaq2uJi+h7lP3KvV
	oC6q7Le4eKo3CDrSy072ZL7n9wf53xt8zr8qOrmlmHrvi5A3B1Xrj0a/yvTYuYo=
X-Google-Smtp-Source: AGHT+IHurzTTaVPTX5lLk+TTfSyV3Yu/0YWjmvliHmLuEOZY45K9H7OEpXuodNn8MEGoAsMwHUQWKQ==
X-Received: by 2002:a17:902:c406:b0:1f6:f0fe:6cc9 with SMTP id d9443c01a7336-1fd7461c163mr47470395ad.54.1721665155867;
        Mon, 22 Jul 2024 09:19:15 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f290f5dsm56637285ad.71.2024.07.22.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 09:19:15 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:19:13 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH RFC net-next] bonding: Remove support for use_carrier
Message-ID: <Zp6GgddK80vPZbCX@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, Jay Vosburgh <jv@jvosburgh.net>,
	netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>
References: <2730097.1721581672@famine>
 <900054ae-be78-4d5e-aa5a-cb3ad91599e5@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900054ae-be78-4d5e-aa5a-cb3ad91599e5@davidwei.uk>

On Sun, Jul 21, 2024 at 11:28:23PM -0700, David Wei wrote:
> On 2024-07-21 10:07, Jay Vosburgh wrote:
> > 	Remove the implementation of use_carrier, the link monitoring
> > method that utilizes ethtool or ioctl to determine the link state of an
> > interface in a bond.  The ability to set or query the use_carrier option
> > remains, but bonding now always behaves as if use_carrier=1, which
> > relies on netif_carrier_ok() to determine the link state of interfaces.
> > 
> > 	To avoid acquiring RTNL many times per second, bonding inspects
> > link state under RCU, but not under RTNL.  However, ethtool
> > implementations in drivers may sleep, and therefore this strategy is
> > unsuitable for use with calls into driver ethtool functions.
> > 
> > 	The use_carrier option was introduced in 2003, to provide
> > backwards compatibility for network device drivers that did not support
> > the then-new netif_carrier_ok/on/off system.  Device drivers are now
> > expected to support netif_carrier_*, and the use_carrier backwards
> > compatibility logic is no longer necessary.
> > 
> > Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> > Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> > Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
> > 
> > ---
> > 
> > 	I've done some sniff testing and this seems to behave as
> > expected, except that writing 0 to the sysfs use_carrier fails.  Netlink
> > permits setting use_carrier to any value but always returns 1; sysfs and
> > netlink should behave consistently.
> 
> Net-next is closed until 28 July. Please resubmit then.

AFAICT, the subject line is marked as RFC (although it is a bit
confusing as it mentions both PATCH and RFC), but my understanding
is that RFCs are accepted at any time.

