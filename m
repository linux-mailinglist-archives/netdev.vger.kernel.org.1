Return-Path: <netdev+bounces-94212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2A8BE9EA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CD928C144
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533485491A;
	Tue,  7 May 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gJ7U3P7z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72951010
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101032; cv=none; b=hfPXNytgS7CVK+se0vv2WOLkfSdYsoSXct8I+jRMfQ6WHFmd67XLjsPEUkPdKypkZLgRUngIeEoYx52AR9KHEDFMv6T8lCLfwltohNsRnZk0qeNM+8QlEFA1HO0hmN103u6yIPfrzbwg6P5yqL2XiyaSj/I4wzRdqNP6G+SPHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101032; c=relaxed/simple;
	bh=AfjwtAP39slTw9D/sFg9CFQE5+RUn89+ulANIbcQzzM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lROGQSqaj908WTgiiSgbuJxx16yhjPeekEODg17jQpAH8g2r4AD6rwDA5DuqJmcqLqprQrIwwGwrvBHiQrqyiJEHpOxzGe/wSy0vhd+DPj2Rd1eJeADZm0bi7JBjrjdOTGFmxPX3Xp1WlJOS3Swl0f9k8pew2uYPrGE6TgjVeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gJ7U3P7z; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7928ec5308cso315388785a.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715101030; x=1715705830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZxb5h1bT1BCqcDGT4BId77aDMzJorIHfT9PA8+hbtU=;
        b=gJ7U3P7ziVV3kmtmMFaQM9dR5I8IwpfSZBEDpVUoeDv/M5MAQxbaijWZYDEHb3o0a3
         OSb4Dm6v7CVZu2z4t5PJesV8WU/UIQ8FqmiEPwLkRMEX7kaVGu1XJczCAU81j1huVH6E
         SdVtkFyZ8OoesdL91zetH6Aiw83ZkFOX/7vRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715101030; x=1715705830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZxb5h1bT1BCqcDGT4BId77aDMzJorIHfT9PA8+hbtU=;
        b=q9zTUQyv2xpQDTQgTJ0Ir/w+zgjoZWsk7fkvcdQAqY9z3EDWrZnYoQ12jq0Yno3XvJ
         o4rT1Eo5c0ACADB4VxDydhjK3nRFzcv1GbtvkHD4O1PDyIX/GuNMLTwn8NZc7IuKQyE1
         qrQotiuBDVdIP6RoXH7U0radRatqmYcziSp1S+8PeYghCQ5tp1CRmNdLyDWTyIrEnJNG
         3sRkUjd8Y06LGSPTxYAHJ1Y4xRHJo1RQgyGmVYyRhRA74mY0JA3DVa4eE95t8huXF89c
         nZqR9LPUrAmJf/aUsbQ1E1+cFfJEAN2CCI5D3k5D73mmxh5PsclQXX0FKR7995A4mBk+
         VUaw==
X-Forwarded-Encrypted: i=1; AJvYcCVto2gBv+UvUtY4lBjtJWfAgKwlCwnMgvPKEbVWw9SAd/ZzS8c1Km9NX5u6La9/F0rt/1k7C3pCAiQ7AjAg9GOUpOD9CYbc
X-Gm-Message-State: AOJu0YwtG94VzSfyCl3PIxvkeYRMDxmM60UzpmDzPSbOZz5s6xcHeSE7
	JzxiANxWIcYRBhQVM1x29txhP4TveR992VNBabaVyn5DYRbFN8RdI0+VNOACEQ==
X-Google-Smtp-Source: AGHT+IFOmr0eq/RLjFJ112y4htBTOBtdH3gY0yWqdaIiSvivvjiR7XfmN7nox9x3/iKMV3CfdfGENw==
X-Received: by 2002:a05:620a:1728:b0:792:948c:318d with SMTP id af79cd13be357-792b2521a75mr70982885a.25.1715101029686;
        Tue, 07 May 2024 09:57:09 -0700 (PDT)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a229100b007929201d701sm2960029qkh.99.2024.05.07.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:57:08 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Tue, 7 May 2024 12:56:55 -0400
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Message-ID: <ZjpdV2l7VckPz-jj@C02YVCJELVCG.dhcp.broadcom.net>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
 <20240506180632.2bfdc996@kernel.org>
 <1c36d251-0218-4e9d-b6e3-0d477a5e6a02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c36d251-0218-4e9d-b6e3-0d477a5e6a02@kernel.org>

On Mon, May 06, 2024 at 08:05:36PM -0600, David Ahern wrote:
> On 5/6/24 7:06 PM, Jakub Kicinski wrote:
> > On Mon, 6 May 2024 13:59:31 -0600 David Ahern wrote:
> >> Suggested topics based on recent netdev threads include
> >> - devlink - extensions, shortcomings, ...
> >> - extension to memory pools
> >> - new APIs for managing queues
> >> - challenges of netdev / IB co-existence (e.g., driven by AI workloads)
> >> - fwctl - a proposal for direct firmware access
> > 
> > Memory pools and queue API are more of stack features.
> 
> That require driver support, no? e.g., There is no way that queue API is
> going to work with the Enfabrica device without driver support.

I defintely think that there should be a consumer of the queue API
before it lands upstream, but if it cannot work without a
driver/hardware support that seems a bit odd.

Maybe I've missed it on the list, but do you have something you can
share about this proposed queue API?

> The point of the above is a list to motivate discussion based on recent
> topics.
> 
> 
> > Please leave them out of your fwctl session.
> 
> fwctl is a discussion item not tied to anything else; let's not conflat
> topics here. That it is even on this list is because you brought netdev
> into a discussion that is not netdev related. Given that, let's give it
> proper daylight any topic deserves without undue bias and letting it
> dominate the bigger picture.
> 
> > 
> > Aren't people who are actually working on those things submitting
> > talks or hosting better scoped discussions? It appears you haven't 
> > CCed any of them..
> 
> I have no idea. I started with a list of well known driver contacts and
> cc'ed netdev with an explicit statement that it is open to all.

