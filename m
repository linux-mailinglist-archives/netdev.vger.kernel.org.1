Return-Path: <netdev+bounces-164739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD02A2EE74
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7945E163213
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDC22E409;
	Mon, 10 Feb 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MoEXM9F0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D622FE16
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194658; cv=none; b=aiY7dvEvo91LqPQZSWbUWka58Lq6SbnZnJLcuECfGPNa9o48AdotdimbbkZ1LxtPiPwHvsMjElNWjW86s1MtpA+CCfoyRHONX1sOJf4a1OS0tM+tGSQhPbU/7V2sl3JEOincIfSkBFjObshtH5PdfD5Q63UX00Qqu03MdOu+mYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194658; c=relaxed/simple;
	bh=Th4VIwBrFf9Z4H4yl5znB9YYyd3GXyNnJnhSZ+nyhdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmBVwg0omTOvUpSKT1Td1SE8xELOXIHVHBI+wWfYAED8A/U/sm6bdfxZTcKtDF7zf5fOXKTLK1DOvkGepzMqoHHyCuqfvTxptdMhhAKAXC/FuKOIGZ9Ol5jF8aYEq2RDUUl1C7WwCqOJUs/vDsd306rAOwWRtqnmWUoveMeP6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MoEXM9F0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wIs1hoS+WXkB+Bc/qpt2291isC/SnfHWfi8qzKuV7dY=; b=Mo
	EXM9F0CeJ9nkoo3tF0MRJmZdQwJAvMEBjaqJYUtpqZvLVaNAyElp26l7fde0JCDbh/6QiUkWLkChy
	gO+p1pU4iaxP1XS3KJl+Xed0MxuYQSBZchjf0jOvf8FBnzCCZGPrrbYVxrDRm3JP6urr9wU5qlm8G
	ToGXSl5YNT/fOu8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thTyb-00CirB-73; Mon, 10 Feb 2025 14:37:29 +0100
Date: Mon, 10 Feb 2025 14:37:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Anthony L Nguyen <anthony.l.nguyen@intel.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: add support for
 thermal sensor event reception
Message-ID: <7085302f-af69-484a-8558-2aa823379fbe@lunn.ch>
References: <20250210104017.62838-1-jedrzej.jagielski@intel.com>
 <87644679-1f6c-45f4-b9fd-eff1a5117b7b@molgen.mpg.de>
 <DS0PR11MB77854D8F8DEEE0A44BB0E17EF0F22@DS0PR11MB7785.namprd11.prod.outlook.com>
 <442420d6-3911-4956-95f1-c9b278d45cd6@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <442420d6-3911-4956-95f1-c9b278d45cd6@molgen.mpg.de>

> > > > Then driver
> > > > logs appropriate message and closes the adapter instance.
> > > > The card remains in that state until the platform is rebooted.
> > > 
> > > As a user I’d be interested what the threshold is, and what the measured
> > > temperature is. Currently, the log seems to be just generic?
> > 
> > These details are FW internals.
> > Driver just gets info that such event has happened.
> > There's no additional information.
> > 
> > In that case driver's job is just to inform user that such scenario
> > has happened and tell what should be the next steps.
> 
> From a user perspective that is a suboptimal behavior, and shows another
> time that the Linux kernel should have all the control, and stuff like this
> should be moved *out* of the firmware and not into the firmware.

The older generations of hardware driven by this driver actually have
HWMON support for the temperature sensor. I can understand the
hardware protecting itself, and shutting down, but i agree with you,
all the infrastructure already exists to report the temperature so why
drop it? That actually seems like more work, and makes the device less
friendly.

	Andrew

