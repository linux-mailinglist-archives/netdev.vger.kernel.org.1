Return-Path: <netdev+bounces-78782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A159187671C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C818281442
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895F1D54D;
	Fri,  8 Mar 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="otASCXDk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD529567A
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910810; cv=none; b=KZJxo+OY2XW3irUC6gNk/RYUJiveWTuVRfhRM3Fq0ICEnlCHI6WJMxw2uJ1SMLHug5m9N0UZ0BPZ3WeT8EU9s3q8uMBOUEH0xbFXtPqxLS9I9Mt5YOsXIMkIrqAz5oROe2s1PmoRzkVY/aTuo8ErFv0XT04+Zp/Gd06XQgF3bcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910810; c=relaxed/simple;
	bh=fQq9n8llFmJ/dTLhn+aHyeYUTbcGoCI47AAG9k/NWvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl51TngO9yPTwXFJBNl5vtM0HaiUQvY7AbBn3Cbd0lcNwXgiSlz8u+vByiU9XXqspHo6XKVWSStEn+dwdjll/16EKi+REHN3h6hKGtbfWUqFn2xe7kc+Bl6MSac7ajw+ANA587d3MCFfclRASRZggZYYQWinknHWFtd8wucIft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=otASCXDk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8560NN/LiN+6uxYv0AIBBq9pWN4MNFAiUMndQLoojGw=; b=otASCXDkI8dwDEM0rCMfUrGOX5
	whl9eziq406EkaapZErOzbRe3LJxbYfGXMTdtXSdkEKf6Bz+mbGThH2iJyuzu0kwSX5JmqiWr+Ban
	BxUFBbL3sWVf3/AlsdD7xFBidl33FiRwNgewCTem5mPxZ3EZrc6lZfuH/eUGs6JcMdSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ribv2-009o3A-Od; Fri, 08 Mar 2024 16:13:56 +0100
Date: Fri, 8 Mar 2024 16:13:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: "Sagar Dhoot (QUIC)" <quic_sdhoot@quicinc.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nagarjuna Chaganti (QUIC)" <quic_nchagant@quicinc.com>,
	"Priya Tripathi (QUIC)" <quic_ppriyatr@quicinc.com>
Subject: Re: Ethtool query: Reset advertised speed modes if speed value is
 not passed in "set_link_ksettings"
Message-ID: <6814906c-3eab-42b6-a44f-36046557f3d0@lunn.ch>
References: <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>
 <945530a2-c8e9-49fd-95ce-b39388bd9a95@lunn.ch>
 <CY8PR02MB956757D131ED149C97F7D0DBF9272@CY8PR02MB9567.namprd02.prod.outlook.com>
 <fb8b2333-cde2-4ec4-9382-f3a563954d06@lunn.ch>
 <20240308141624.sj3m7imkcaeq2vjy@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308141624.sj3m7imkcaeq2vjy@lion.mk-sys.cz>

On Fri, Mar 08, 2024 at 03:16:24PM +0100, Michal Kubecek wrote:
> On Fri, Mar 08, 2024 at 02:56:30PM +0100, Andrew Lunn wrote:
> > On Fri, Mar 08, 2024 at 06:33:00AM +0000, Sagar Dhoot (QUIC) wrote:
> > > Hi Andrew,
> > > 
> > > Thanks for the quick response. Maybe I have put up a confusing scenario.
> > > 
> > > Let me rephrase with autoneg on.
> > > 
> > > 1. "ethtool eth_interface"
> > > 2. "ethtool -s eth_interface speed 25000 autoneg on"
> > 
> > phylib will ignore speed if autoneg is on
> 
> It is not passed there. With "autoneg on", speed, duplex and lanes are
> interpreted as conditions for modes to be advertised, i.e. they are
> translated to the same request as "advertise ..." with list of supported
> modes matching the parameters that were used.

Ah! Interesting. I did not know that.

Thanks
	Andrew

