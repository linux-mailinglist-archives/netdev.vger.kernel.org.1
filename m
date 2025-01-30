Return-Path: <netdev+bounces-161662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BAA231BF
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9768E164292
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4741EE001;
	Thu, 30 Jan 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YxVHJjx8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746891E991E
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254372; cv=none; b=nwXantELz4+8C9KapOK9iuaFx/TfJyLd2AfBQmSFIow7bxp/xiGNVbqqBwb8nB465N4h14Zk92SYy55R/sPDWSLy2h12gQHMEcoJO1ehjMLlBpk3AxOayyWlEmXzCNhzC186Xcqo8QIW04GUoAiHdFzGdcCVPIEaMqnnRw/uzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254372; c=relaxed/simple;
	bh=9ORXU9xp+yfOWrwhTIVPTgQagM73q2aaZQtDqYwm300=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWPAD+4pamfI2lqsniLanNw1tVOr66lLIiLVHmk/NSL06CFUfEZXwyx/Rv3MCs2tO+Xak8f91qaZIr2oJ8XeH2X51nIb2wJ/dAfPP3yajjQxSf71EgqKmdDr+LT6+ePbP5csitl6dG/KbePOuowutiUU86x6q1NTzA671PDzTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YxVHJjx8; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd420f82e2so12702876d6.1
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738254369; x=1738859169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFJun+65leLVhnu3FjKXbxUekmn1THbonCmFZrm06tI=;
        b=YxVHJjx8DMPMrx1+m0jM9ixRXKX0RKKvOoBwkf8e9cr65BU0BcKzMCL05zGLA8vj45
         uBH/U6iGvb6dEi0qIeOOnZNiLLnZFtIdBkR75LaeUodBNSSdaXhKUNVOTJpk/7f8yDpB
         1l1VpiEXDrki3fApbiXspW++XKOcfa6dC8D78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738254369; x=1738859169;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFJun+65leLVhnu3FjKXbxUekmn1THbonCmFZrm06tI=;
        b=rH4FHvMUtYW5f64uAWOHdwyQGLDFnZSMw3MrBxTep9ryVHkCy4p010mk5aqIjOqXow
         yC5V8BUlNr3zEmWN6+rldPdIPo9ZyDvzEcM+P/8eDxEahaX4Bywn6SapoAXFO3n5lVWA
         1i2BINifY0oiyCo5ee0V+p3ngjZ/6qQlJtnzZ8v7RS+JTtvfr+UhNC8+i0ssNXOdNp8k
         9B4s2hYidOe5CedrjBLcKIvO5Z1NqFZuuD1wOG7Iel0Tbge78DFC/R/Dvl7u9QueQCan
         bSSrfPxsfb76bHqddhKKhga52NVCF/Xs8v0E9l3C5D/vMUgdRCm0ho5k/jri8q0iW0QR
         iYiQ==
X-Gm-Message-State: AOJu0YxdYreRO8DNbtefjZlin8ULp3jMcf1adbVK4SzheRYzkpSHjbHJ
	NZM5+JP58kdnuSX9NjTO0AUGHuacQrkQUhepUXFmGLXZM/fXRkOFs9AYvQY9nvE=
X-Gm-Gg: ASbGnctDTBVrJd6OsbFaAsroNFvfllSxzN2YVZ1YkYXs51cR3WgDaZVOKqCnHdzD8VS
	HBCDlC6/Qb81IAyXKj+7og0SwswXi9k6BjvKft8M5iyCqDBn/WwGW7wS5M+Kl4aF6DlqGRmDlqw
	uCxka/q/IY0nSiYPiEEFLvSe2egZo/oFZPiW46ssykduqadVRGp7Z1zqZsCJJy07b5TO3KKnsxe
	FnIPm3OzdQ3YY9GLr/oMF1JQTn1U+mS6AcINzBgR6/W5NsA6H3pn/KUpds0I9EMwFq2ig2EeHD+
	HXoVdDcLOM0RMkzC0BNr
X-Google-Smtp-Source: AGHT+IFCtbiT5jitHYjlOB5KglRFMHJCSGApdMl8EWMtvRA1gCdNmiZdo9EppRnTbuH+0Zr2ViLTcA==
X-Received: by 2002:a05:6214:4a8e:b0:6d8:9be9:7d57 with SMTP id 6a1803df08f44-6e243c7f716mr149666086d6.37.1738254369421;
        Thu, 30 Jan 2025 08:26:09 -0800 (PST)
Received: from LQ3V64L9R2 ([208.64.28.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f0e0bsm7726436d6.20.2025.01.30.08.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 08:26:09 -0800 (PST)
Date: Thu, 30 Jan 2025 11:26:07 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/2] netdev-genl: Add an XSK attribute to queues
Message-ID: <Z5uoH-RkXNreyU1h@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250129172431.65773-1-jdamato@fastly.com>
 <20250129172431.65773-2-jdamato@fastly.com>
 <20250129175224.1613aac1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129175224.1613aac1@kernel.org>

On Wed, Jan 29, 2025 at 05:52:24PM -0800, Jakub Kicinski wrote:
> On Wed, 29 Jan 2025 17:24:24 +0000 Joe Damato wrote:
> > Expose a new per-queue attribute, xsk, which indicates that a queue is
> > being used for AF_XDP. Update the documentation to more explicitly state
> > which queue types are linked.
> 
> Let's do the same thing we did for io_uring queues? An empty nest:
> https://lore.kernel.org/all/20250116231704.2402455-6-dw@davidwei.uk/
> 
> At the protocol level nest is both smaller and more flexible.
> It's just 4B with zero length and a "this is a nest" flag.
> We can add attributes to it as we think of things to express.

Thanks for the pointer; will do.

