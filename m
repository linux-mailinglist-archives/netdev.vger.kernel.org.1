Return-Path: <netdev+bounces-209332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A578AB0F33A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF91C3A7FDA
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FAB2E8DF8;
	Wed, 23 Jul 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V/X/j+P9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3272E8DE4;
	Wed, 23 Jul 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275859; cv=none; b=iZ3GHACg/ookqjmqUuW6N0I6d5AvVlTLOT94w/4HLPTiauKm+/fY5N174rNkj9H3UIWOAMahpO/qw12ImI1r6ou1Adrf/gB5W4gkTpSJpIXY/O4nPGe5pjV0/mCNEUZseidus9pcJlPuOUs0HCwUBejoP8U/3NljMAKUNgkFYbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275859; c=relaxed/simple;
	bh=w/9OtaMeEiVS2xNmC0iski2P65RG5/IVinW9MNewWrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4yV+xCaEO4hQTFFmIckpiLZOG6rnbaUKSeRNRCvmk1oexSVpus28MLq/wP8kja4nM2umJXkeXjzjnlpwCuJ7aVfuvT6+t2JyInCJgwTTePVHaBKSJ6Jcyq2VsGXpm+kSGPGlJEAwccJTrE3sx4NvxVxI85jQFaroaluYqKabXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V/X/j+P9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6fi28c4WdnvJ8Srjsg0gsNHyyk9cO4yVoUg2Y0UaAns=; b=V/X/j+P9X02TRH4IEf/+2IfgXy
	Jpy1YqhdK6AOxxdL6+5jS02Ravx00MN1gUzV+B9b/gpUdGylYZAAMmje3Wo3FMbtgcU7ji2ocYedo
	NB6gI4sL52wG7/67AhuO0o31IkX76xNVGa1qxyPnU4EyBWu3ZPdmq6kJOC39mUJSLafs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueZ8c-002Zdx-VU; Wed, 23 Jul 2025 15:04:02 +0200
Date: Wed, 23 Jul 2025 15:04:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of
 MII
Message-ID: <7d2d0313-4e20-4c3d-bd2a-5160465d4fa2@lunn.ch>
References: <6373678e-d827-4cf7-a98f-e66bda238315@suse.com>
 <20250723084456.1507563-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723084456.1507563-1-yicongsrfy@163.com>

> Coming back to the issue described in this patch,
> usbnet_get_link_ksettings_internal is currently only used in
> cdc_ether.c and cdc_ncm.c as a callback for ethtool.
> Can we assume that this part only concerns Ethernet devices
> (and that, at least for now, none of the existing devices can
> retrieve the duplex status through this interface)?

"ethtool" can be used with any sort of interface, if the driver
implements the op. So you should not assume it is only used for
Ethernet.

	Andrew

