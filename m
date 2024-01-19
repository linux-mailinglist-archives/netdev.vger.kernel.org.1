Return-Path: <netdev+bounces-64410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B59832F89
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E2CB22C71
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E883A55E7F;
	Fri, 19 Jan 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bjWx3A+T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FB1E4A8
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705694186; cv=none; b=Kpp8DrPlgKjfnFI9vNDYQaN/RnvWDVvYFtuiruthZyLN4CvBpWa3zW2voBf9LASYVNHJtNoXDAkEphkLJGdCNsyK8Vmc2ttVqWUBg7lam1aZgvUDVEFhBiDDs2FTcE9qnjxuB+pfm5Ej/fkvbq8ICdEvLC9b2hlN8zjZH3ZKU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705694186; c=relaxed/simple;
	bh=U0KGAPpcSLCR22uoEUE8ds/f8zbq4fWrKFWrJdOezQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0Vt9pG175VRpFYAk+pxM5ztmDfSXtFl8pc0Z3Kh3yevOReAzONTFi7/cp+9LQT3NDJ0SHTqYX1VTNQ/Xuotm1xT+2RxrBVfQeItM1TDgEeYnTlriRypbFxtYLMiBCGl6ymF2RbfrvJjE569/X/zmd+OGIsAHxdqstEZDozhoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bjWx3A+T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kt5RmijoJAHRRsVsPN38OT3BmY6xifAuT08bZuPFhYc=; b=bjWx3A+TN+RUsJEFNUEg1CrGTY
	NosN8FdBclWZM40wzBb3GMWY3WtVRQvlr16BMRtFxjgvEfYVAKZ5edjMQzxxu2FeT7N00DRLFOUaY
	cmD0vAwtQLuK073uM05InEOx2X1gQotYW6Os5qvHwvHEK58DpZy5KAVOVwMtJDEL0NRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQuyR-005aEF-1V; Fri, 19 Jan 2024 20:56:19 +0100
Date: Fri, 19 Jan 2024 20:56:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	David Thompson <davthompson@nvidia.com>
Subject: Re: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Message-ID: <0b033860-16d4-405c-b197-b3fd068ef262@lunn.ch>
References: <20231226141903.12040-1-asmaa@nvidia.com>
 <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
 <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
 <PH7PR12MB7282DEEE85BE8A6F9E558339D7702@PH7PR12MB7282.namprd12.prod.outlook.com>
 <a6487dbc-8f86-447a-ba12-21652f3313e8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6487dbc-8f86-447a-ba12-21652f3313e8@lunn.ch>

> What is the value of BMSR when it fails to report complete? You say
> you are using interrupts, so i just want to make sure its not an
> interrupt problem, you are using edge interrupts instead of level,
> etc.

Please could you check that /proc/interrupts do show level interrupts
are being used.

       Andrew

