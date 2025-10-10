Return-Path: <netdev+bounces-228527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7DBCD58F
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A84634F95B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128882EFDA6;
	Fri, 10 Oct 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wZtnX/4g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33E288C25
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104377; cv=none; b=oWPx9INJ+im8wV0DFKWHUivzIBpBwRMoU/72PRP3T1ladpq/tj2kDSwEfuFe4+fRK8jW/BhlnQUpnPbU6fXeMztks3oR6uFatkomStVYVclT4bSI3ejT9l8kb+dAN/+LcpTdBkv+lCoOiW+Dg2NagRhfdPtULQRMMmTpakcfzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104377; c=relaxed/simple;
	bh=52FH/UthIByShqOMgMjB+i5hbOx0pMWmDVdqVUuEL9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1GN9bVzZruPk2uDUub6Y93MqNdUKv+Gbq2j58Y4LVmur65/AA0yBaIWGV5WfTp8EXj/wP8tTTSa8xQfr0VNMpjUJX0fl/oAlP+ovqoIwm2ztkcBJkvTgV7aVJ0WZRZXnxv4oGYfhYq9NESZNmUHTMZxu2AbYbgnOnn5rvE4kJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wZtnX/4g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6aDPD3sm9RPdq6tvBSzBbUI+uHVMKnRgb+CD3IUbDcQ=; b=wZtnX/4gkp8xtA9PUwtEwGjgmt
	cLtz6qqft/dk48V0juRAkdVLanb0W32hp86MgNjCYyofGbtIIylbydXKbbugEz9GeFraqQvmOPPEp
	ZvUNMzIoNaPQxISIGuul36zvn4KqAbggVfUf9Awh5ymS0KGAUPPjemSZ835g66ETy/Hs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v7DYC-00Abk9-UJ; Fri, 10 Oct 2025 15:52:52 +0200
Date: Fri, 10 Oct 2025 15:52:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Simon Horman' <horms@kernel.org>, netdev@vger.kernel.org,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	'Paolo Abeni' <pabeni@redhat.com>,
	"'Russell King (Oracle)'" <rmk+kernel@armlinux.org.uk>,
	'Mengyuan Lou' <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 1/3] net: txgbe: expend SW-FW mailbox buffer
 size to identify QSFP module
Message-ID: <f4c6d749-020a-46ca-844b-558542113327@lunn.ch>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com>
 <20250928093923.30456-2-jiawenwu@trustnetic.com>
 <aNqPAH2q0sqxE6bX@horms.kernel.org>
 <000201dc39b9$5cdcf5f0$1696e1d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201dc39b9$5cdcf5f0$1696e1d0$@trustnetic.com>

On Fri, Oct 10, 2025 at 03:42:00PM +0800, Jiawen Wu wrote:
> On Mon, Sep 29, 2025 9:52 PM, Simon Horman wrote:
> > On Sun, Sep 28, 2025 at 05:39:21PM +0800, Jiawen Wu wrote:
> > > In order to identify 40G and 100G QSFP modules, expend mailbox buffer
> > > size to store more information read from the firmware.
> > 
> > Hi,
> > 
> > I see that the message size is increased by 4 bytes,
> > including two new one-byte fields.
> > But I don't see how that is used by this patchset.
> > Could you expand on this a little?
> 
> It is used for QSFP modules, I haven't added the part of these modules yet.
> But the firmware was changed. So when using the new firmware, the module
> cannot be identified due to incorrect length of mailbox buffer.
 
And with old firmware? Can you tell the end of the message has not
been filled in with old firmware?

	Andrew

