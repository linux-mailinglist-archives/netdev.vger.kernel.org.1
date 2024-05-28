Return-Path: <netdev+bounces-98533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66148D1B04
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA661F23439
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A216D339;
	Tue, 28 May 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SNRCXPQO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08581667F7;
	Tue, 28 May 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898944; cv=none; b=OU3GTVAJ2edIzAxgJusnMN7PrYqZlns0TM808yUOvCKvOg2jfwHaT9MJkdarPw/gDRUesdaovmXl8xkbJdgiE6+TM9bzy5MLCnRdVDIiMrfkZ25prcHy/zvmsDO3pldV3dYSWKvpO2pX1Ht1szKIzVg2CjM4dM81Dd01WOQ0/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898944; c=relaxed/simple;
	bh=WjJZBwHR+fahMg+Yy5ffjCSPaSygEhqXKeccSEhaJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFvvhzG2m8mcVwtvWDw7QGHfWR8w7ETwXi6NglYkVMTmr12uJp61Z1DXzR54PgG+nMyrohFzi0dONVjATzl+kkpDTCYQc8M6SmhOFSW1o8f0eL4A3DLmVChc1Qw8Ot13MjG+g996ygI81z/zb0anGiXzY2d9wb5Fwx4WKL7Cis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SNRCXPQO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yW/FU7UpcM+jJM7bEDl1D2hvUGQXB3YbQSi0AdGiRPI=; b=SNRCXPQOce3q69sRwG/yFHSyl+
	lbYw4S9Iu8RWmJ1MCSjYOyfChAQYmlaM07R3zJN4DW0QlEiT/Fik0RzUtklYuEHpw8OsGrb37HVI6
	kr5EXnQcSp0GEIlxeZQ75b85fSk6ke4/owGEGO4XrVFtEqKYgdS9Mkea7Z/4kTEDDFFk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBvpr-00G9Tx-76; Tue, 28 May 2024 14:21:47 +0200
Date: Tue, 28 May 2024 14:21:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>,
	"Looi, Hong Aun" <hong.aun.looi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Message-ID: <cf5ad64e-c9c3-426f-a262-3f03964b90fe@lunn.ch>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751CE01703FFF7CB62DAF9BC1F02@DM8PR11MB5751.namprd11.prod.outlook.com>
 <BY3PR18MB4737DAE0AD482B9660676F6BC6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751118297FB966DA95F55DFC1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <BY3PR18MB4737D071F3F747B6ECB15BF2C6F12@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB57515E89D10F06644155DA11C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57515E89D10F06644155DA11C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>

> > > Checked the link it is just a photo saying "come in we're open" is
> > > that mean the net-next is currently open now?
> > >
> > >
> > >
> > Yes, it's open now.
> 
> Hi Sunil, thanks for confirming, should I straight away submit another change,
> with the correct subject prefix on "net-next"? Or I should wait for others to
> comments, and fix them all in v3?
>

Please trim replies to what it just relevant.

You probably should read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You might also want to read out to other Intel developers in Jesse
Brandeburg group and ask them to do an internal review before you post
to the list.

	Andrew

