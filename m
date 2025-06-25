Return-Path: <netdev+bounces-201272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7811AAE8B55
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E46188C23A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780D273D86;
	Wed, 25 Jun 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pxKR8dwU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBFF7D3F4
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871304; cv=none; b=gK9X+JkA5j7+j8RolYeAGc6Z3m1q0lgSDUPBpLAxc9iERKWREbO7EAPxNxSTxQ0AqPJYUdtlAdoxK/+12vDYT+7sov7rGSzWfQojmyDOb/J/h+hdgxj+5pea0Gv7ZZ4xmkq57wRYB1WiqRjgmqojA873UnY8tssPb94iE4q35Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871304; c=relaxed/simple;
	bh=y1y1sw0WxvbfsaIZDdMdRpwVMVvjQjCu/ou1AaBU4q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYrblp2obRcomhZY4we6Y0NGu/wOq8rok7et2BV0lnda0hS/IPZ83MEQCr2eCugD8qEkkKUnQwAyXXo6dRV5Ut25exwb0QsbB64NKpUXljdEVHjfMA7IArrXBKpdIvJD2B5VdRABNcoOGe8iAySOVhrdiblessCzDIRlaYzbi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pxKR8dwU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7hZnDcvmr/7zDKgBtgOtbFRCdPcRC4xkpHODKiVz3BU=; b=pxKR8dwUFltE+GgiuZV5ESIeoO
	JQMc67NjvcRJvSSVEfEHhaAfAu1mBkhFPrlO18ExRRSK9/yJhXfD12d5zzUhHfaER6dBD89mb3Kj3
	Q1Ndo4xOzBYCUx46dLat24Mm9hTh0mGyq65ocsoY2xqbAkcgwQAhSh8qup15XCsabaJU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUTbc-00GxJY-Qw; Wed, 25 Jun 2025 19:08:16 +0200
Date: Wed, 25 Jun 2025 19:08:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	andrew+netdev@lunn.ch, duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com, jiawenwu@net-swift.com
Subject: Re: [PATCH net-next v2 08/12] net: txgbevf: add phylink check flow
Message-ID: <71d0b663-c717-45a5-ae23-f5b91d199eac@lunn.ch>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
 <20250625102058.19898-9-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625102058.19898-9-mengyuanlou@net-swift.com>

On Wed, Jun 25, 2025 at 06:20:54PM +0800, Mengyuan Lou wrote:
> Add phylink support to wangxun 10/25/40G virtual functions.

What do you gain by having a phylink instance for a VF?

All the ops you define are basically NOPs. What is phylink actually
doing?

	Andrew

