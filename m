Return-Path: <netdev+bounces-162262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3023A265AB
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFEA18861AE
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C1211283;
	Mon,  3 Feb 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="f26jmyK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD520F08C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618223; cv=none; b=InUzPES34NFO+l+v/Oszyx9k+IiZeGq1jneb0jGbGwXDTH859TwvE9NeLKbnzICiE3PowkBcOSSSS4FB3Ly4LUXZGbDiszuIsW9X+D6hJO8+Oxo+6n1JJzMRI8eZJiAV6Z0jsFZzUITYsixOIZaIipc5lGuaorJhqH/ZtVZiy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618223; c=relaxed/simple;
	bh=TpHcaiFbiRJSlKQ/f+5YA5ZmgRX1YdSeB0s5+Xy1O4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9tJ91AvcCugQNQVn6WEt0k+G0tro7b1cIznAWXfsg1QZS+aEA7thpNEoR4xbeJ7GYi6QSA6e4Ru2GXx8VhYDrPWxXcOgt4e9IbFYy7MY6vHtZVDwwxfZ60vWcn6a627+0ItkrBQ813m8FdBO4PlyA2D0V8s2yWT+8OvPKkwi1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=f26jmyK/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so8153348a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 13:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738618221; x=1739223021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXtKgZcHTwldZ3DkK1zCE1LD70D/NiFdZz2SxXR3kkM=;
        b=f26jmyK/6rRAen0ndeBD9scmxP48FiS76kPQWn9lqAzv4vVrNtXpeJJgCi4Vsurl5s
         vT02FsgF14aBZ5nNvg1kzEDbcYkcOqtpMx8z2QLri4C6QtQ3oKY+ELGE7UbZA20z3VqN
         9JZKyUAHidQuWrsi3luiuU+Na5vQ1oHhuzcQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738618221; x=1739223021;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXtKgZcHTwldZ3DkK1zCE1LD70D/NiFdZz2SxXR3kkM=;
        b=gKnUF/A7Evef1S45qoBdsY/oCp+nmbEMk+PGkkmILVOVhi+4fWk796WcZVEc02JMbU
         bX95U4+KL494+aoR5mQAnnP2G1qFYNyEJ9pg73/oOWtJtQtkGHsFhvlUVBYoqUNXfAyZ
         9wJOPhr6UZE0u+/kmYysY4PQ9biZazroIG+0vIH4CJM8S2Z/0m5SWvM47oVB4XWnmEp4
         W9p5jzrmLahVdSLh58WtZBQpF7uSmMqYJDEBldgplffsM+MLiuLXJ2BZB1deqHFgd4YH
         uF/8CGGcxVeKpN3R9aKUVf/LPlbvBV/Vo62sewnCjS/WeHeW65rUeHBOSVdnOpYIXUoY
         hVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMeOll+VJGBguOf5FP8nwKNgX3S3CZAh1e+h08FSnb1McHCCctAlTR1A1U/IItkG25JnjCXvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCS/6BE3wrULSak4LCeFEOUjK8wXe3H7Tyk/nb2WTuIFP3X9kC
	UtWDS2TqE5qnWA+M4U3hzlHLYV0dJs8rRUOnrqsJzKr0Te4peekAsxHnwQPmLoY=
X-Gm-Gg: ASbGncvcU7U0q7z0no7SdalBRdKmPcKXXlKfaw9mbunA6REYR0m2r5YPZZewrz4B1Nm
	gK1mzDRdNF8i+xzzswSYzCIXwnw/wkU8krCXig8w0IPkvGLs2u2iudR44aDQMXpYBMe7x1GCBNF
	oe1QXopaseLvRP9tnSkggmZZESazl0C+dtzoS+NkQfqaoBGWKubDlLwJAZcxoQPIcKNPUGFWYpk
	DEPRTOYAEIa/O5iYLaLrVxMEUJm6XpO57qpsjnx9EnvHxRkJlkpK9LR4HaqXQoexoLCSLYdoQlR
	p80tWJI+bMKoRAtVUCIeHLeKh8Ib1XoHBC8tdLSZttQSTx999jfvd4ui3Q==
X-Google-Smtp-Source: AGHT+IFvrlnoIZyqeRoeC/CS60FZyMiM4TegbRQAxCzGXrhi626UWuro5c4uOpLDW84enj7xYkVrOA==
X-Received: by 2002:a17:90b:5212:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2f83ac83ebfmr29826825a91.32.1738618220615;
        Mon, 03 Feb 2025 13:30:20 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489adf7csm9638955a91.13.2025.02.03.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:30:20 -0800 (PST)
Date: Mon, 3 Feb 2025 13:30:17 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 2/4] ethtool: ntuple: fix rss + ring_cookie check
Message-ID: <Z6E1afDYGcU2NM7V@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
References: <20250201013040.725123-1-kuba@kernel.org>
 <20250201013040.725123-3-kuba@kernel.org>
 <Z6EyPtp4rrCYSCTb@LQ3V64L9R2>
 <20250203132519.67f97123@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203132519.67f97123@kernel.org>

On Mon, Feb 03, 2025 at 01:25:19PM -0800, Jakub Kicinski wrote:
> On Mon, 3 Feb 2025 13:16:46 -0800 Joe Damato wrote:
> > On Fri, Jan 31, 2025 at 05:30:38PM -0800, Jakub Kicinski wrote:
> > > The info.flow_type is for RXFH commands, ntuple flow_type is inside
> > > the flow spec. The check currently does nothing, as info.flow_type
> > > is 0 for ETHTOOL_SRXCLSRLINS.  
> > 
> > Agree with Gal; I think ethtool's stack allocated ethtool_rxnfc
> > could result in some garbage value being passed in for
> > info.flow_type.
> 
> I admit I haven't dug into the user space side, but in the kernel
> my reading is that the entire struct ethtool_rxnfc, which includes
> _both_ flow_type fields gets copied in. IOW struct ethtool_rxnfc
> has two flow_type fields, one directly in the struct and one inside 
> the fs member.

Agree with you there; there are two fields and I think your change
is correct. I think the nit is just the wording of the commit
message as ethtool's user space stack might have some junk where
info.flow_type is (instead of 0). I only very briefly skimmed the
ethtool side, so perhaps I missed something.

In any case: IMHO, I don't think it's worth resending just for a
minor commit message tweak.

