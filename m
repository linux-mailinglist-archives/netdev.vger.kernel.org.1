Return-Path: <netdev+bounces-176082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50450A68B44
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC4E8882AE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DE3254B01;
	Wed, 19 Mar 2025 11:05:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28125486C;
	Wed, 19 Mar 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382334; cv=none; b=YxPYJ170enrKQ/qrxoNcUxl7yp8XQQTE1kYRoKUVxYRO9m7FVUzjaI2Wjn/v2t84R0mycz8tcLvfJzMTjtCWD8jkXLi6dzHF4D8NwMe5yqJ5QVB1APo+ufwQrcKGbsv0u/xuFQ4Er/dk7ij9MhvFOA2DD3PD7dbwjJaSn5UVVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382334; c=relaxed/simple;
	bh=6kdJ1bThmZDKcaY7qtSnF8fnT00j7X3FdOLmez9f1Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFMsgxKxz1G65w0dwnR4bMlnbZH7mPzREU9FOnWBLaUPARfdlvQBL2Kd4TaqCGhshXOKBIi3eEqsMNRkTJXEQYfuF8vVLqSc8YUHrNaZOAdkXkhimyriGorMDIJWtDLKz47jEftoAjHCTj4kSaEz+Zsn24wcZjxSEvth9Dk0Rxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47604106F;
	Wed, 19 Mar 2025 04:05:39 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7F2A3F63F;
	Wed, 19 Mar 2025 04:05:29 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:05:27 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 8/8] net: phy: fixed_phy: transition to the faux
 device interface
Message-ID: <Z9qk9xOuNFawFhCq@bogus>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-8-e6cc73f78478@arm.com>
 <5ded6e25-111b-4771-9be2-46cfbee27932@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ded6e25-111b-4771-9be2-46cfbee27932@lunn.ch>

On Tue, Mar 18, 2025 at 06:12:21PM +0100, Andrew Lunn wrote:
> On Tue, Mar 18, 2025 at 05:01:46PM +0000, Sudeep Holla wrote:
> > The net fixed phy driver does not require the creation of a platform
> > device. Originally, this approach was chosen for simplicity when the
> > driver was first implemented.
> > 
> > With the introduction of the lightweight faux device interface, we now
> > have a more appropriate alternative. Migrate the device to utilize the
> > faux bus, given that the platform device it previously created was not
> > a real one anyway. This will get rid of the fake platform device.
> 
> You were asked to split this up by subsystem. So why is this 8/8?
> There are not 7 other patches for netdev.
>

Sorry for that. I admit this patch unlike other patches in the series is
not dependent on the macro introduced in 1/8. I should have posted this
independent of the series, my bad. I will do that. Thanks!

-- 
Regards,
Sudeep

