Return-Path: <netdev+bounces-222257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D066B53C0E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C516F16291C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD17B2DC794;
	Thu, 11 Sep 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MkCyK23u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA612DC77C
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617346; cv=none; b=bi0g6yKzwsOkYEOT5wAU6uhbzAu/zCP3MKH2Q9dfU4FSod6w24clkndtYjWGiTcJBSc2ffcCrCQTORJrwoWWDSBtdX/AM2yEQO9QiTB9EaYUw8UVim/Z4qAgKkhoDb46OtwymXRiz2QXZDB59E8YdKsCeFDUwdIMMQsKoEd4u68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617346; c=relaxed/simple;
	bh=CV/viJpcmWCQfSZOEaoViEoomF90iOdOtLLTr5lL8aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzaaSLAQOXgBBnR3dKsLgCbmHxvEoQPuv/tVAxodprLJYvQ6ZrFczYvH+WfU+uDu/HVo9l0PqiA3GcHMOu3eygjRPed84Sq3Y0DzJlr3TWo17QhGlfS14q4dYMxsx5LHBSCCLfZ7I59E89HeZwLaS0kn1UgSYS2PE7mLoPzr75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MkCyK23u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nZsrZe1y8qCgCTG5/3LXrcsXtTwDVb+psjvDFy+cWFY=; b=MkCyK23uJBSzSJ0ObZ2BvzL1VG
	ZWy+B7+TkV+TQd6SpTdRSUZW+SSTT1J8AfAhPrGSUuHycXU2IaesCb+gD/Zl4kaOIpcpwk+vZ0q+Y
	nCOp3lbzWPNp8zfhbbz3ZW5p6l+UX+N7yTblpFbGMl6SlrN5PTWp5DZtJekitr85Kos8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwmYl-0087mG-I8; Thu, 11 Sep 2025 21:02:19 +0200
Date: Thu, 11 Sep 2025 21:02:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	alexanderduyck@fb.com
Subject: Re: [PATCH net-next] eth: fbnic: support devmem Tx
Message-ID: <55352354-2468-42e3-b5e3-815712f83ecf@lunn.ch>
References: <20250911144327.1630532-1-kuba@kernel.org>
 <CAHS8izNHRmcuw=Ya4UC_QdtyJ_z_vYiHEWKRk1f6gQ5hdwXODw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNHRmcuw=Ya4UC_QdtyJ_z_vYiHEWKRk1f6gQ5hdwXODw@mail.gmail.com>

> It seems in your driver you have a special  way to grab fields via
> FIELD_GET

There is nothing special about FIELD_GET().

~/linux/drivers/net$ grep -r FIELD_GET | wc
   3724   15584  331380

They are the recommended way to access fields within words.

     Andrew

