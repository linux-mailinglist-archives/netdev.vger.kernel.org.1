Return-Path: <netdev+bounces-240680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F32C77A9A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74DFD360476
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81FC2F6187;
	Fri, 21 Nov 2025 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="UJt6984P"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45566231A32
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709332; cv=none; b=p/GZ3KVsdVT5SGN2ViVNYzCkSqoM8aqqAGJqDt7o84JARoqIhsO0CRdMLO56mLsAWxVd7C+/0w4w6I0xTHZFF2xKlM0SdM+aDkfEaSN/Yq1ryz2om5fHTeph8drFatyZlDU3eIyhhVwA0QtdHCfY7nhPzMFEKCnmwtJG3meMLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709332; c=relaxed/simple;
	bh=ipfjVsepAvk52qhaSjXq6b1osi+j8VVuiUPewKucB9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHjyTAXsd4PM1/w/Mm9H+gBOl/L3tcJ3bkDOGZIN+dvrqv/zNMVf2MVnqp6yq/u7aY2e3+SX23KJJU5WONv0hltZzKt/ifjZmEJPxPpZsFLNVNQbEs3G9ogb2dO0kqSWv8paqJGjWCMtemfZItOpj92zc9RX94FQ4/sx6JnGEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=UJt6984P; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B4DFEA118F;
	Fri, 21 Nov 2025 08:15:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=WQHW970UNnDOavB5bx0Q6o+GMlgCZVqkFLmhbUJAl2A=; b=
	UJt6984PDCnPdvpIR5TpFTdnY4GiNUP8KcwoJ37KVsS2Y/NoSDfY2AzvMgNaHM1u
	j9W5GHLJtxAYfFh5kun99cBgtvrV/bw6fETO52HIJF5t1fwkqoXcNXOrQvwZLCuX
	iw7gpeX1NAVo00glqq8q+kfwunwPTzSnfG7KBWTuHUVVgwjvyQ3hZFrvr8DUPbyp
	9Qre7mlJD6FxCPfQGVzKEPFplkI9bY+aneJCbEvK17oVVmLXXJmlETdwq14BuB2N
	fSt/O24OyXENqx1rLvTo4sQ1do/QviYSuQBa6VqwIa87LC4cjWNZ7IjCBtv1ISsg
	X15Ekuz8xuFF7bnn7oP/60fIvCsV+FQuskzxqtTL0qqiaLRpH3OFOfrGQNRBB+4L
	gI11mldDFwe01uYEwaRaUejYlD1nyhWuGxDarE8O9niZxHMapTj73YcyM9CYfVSA
	501MzGUrc9Al8qL9WC3TseOdMsyrUljV7zncMXqfDAd201au7v/FaRylm7/WFXwA
	QuU6ne0E0Ztge7jIpe6j17m3Ufhvc6a2bkT8VRQ2oeem1Itthd5hfPFsV1yebIeV
	VxmyNfkB9rxX+c9FIxaR23tnyZZqv7nh2z4n0EYlZ1jxNy/4mWl5RX1ZPR/oGXnl
	7sJmo66aVwhzH5dR43gUQnHVLVv/TnYjm8icV3bdnmw=
Date: Fri, 21 Nov 2025 08:15:24 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: Heiner Kallweit <hkallweit1@gmail.com>
CC: <netdev@vger.kernel.org>
Subject: Re: Re: [Question] Return value of mii_bus->write()
Message-ID: <aSARjLeqFjHKvrem@debianbuilder>
References: <aSAHVPsxrM60lRIj@debianbuilder>
 <8cbd4650-aeed-4d1c-8173-957776dfec51@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8cbd4650-aeed-4d1c-8173-957776dfec51@gmail.com>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763709325;VERSION=8002;MC=2746087551;ID=93058;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F60756A

On Fri, Nov 21, 2025 at 07:53:21AM +0100, Heiner Kallweit wrote:
> On 11/21/2025 7:31 AM, Buday Csaba wrote:
> > I am preparing a patch to eliminate kernel-doc warnings in mdio_device.c
> > and mdio_bus.c
> > 
> > I have ran into an ambiguity: what is mii_bus->write() supposed to
> > return on success? Documentation/networking/phy.txt does not give any
> > information about it, neither does the kdoc in include/linux/phy.h.
> > 
> > It is clear that 0 is treated as success, and a negative indicates
> > failure. The reference implementation also follows this convention.
> > But the code in mdio_bus.c, for example: __mdiobus_modify_changed(),
> > seems to also expect positive return values from write().
> > 
> I think you misread the code. __mdiobus_modify_changed() returns
> a positive value in case new and old value differ, but __mdiobus_write()
> never returns a positive value.
> 

That is right, thank you!
Csaba


