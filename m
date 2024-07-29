Return-Path: <netdev+bounces-113643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85A93F609
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79D8282289
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82331E4AD;
	Mon, 29 Jul 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y70Um/Ep"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B561DFCF;
	Mon, 29 Jul 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258047; cv=none; b=aVPFNt9gKEubNgnR1eZn5g9m1rjRKx4zpnhMzhHSzkWpcHp0Um5HsA1JkeePOULTykGXCSjvYiAxI85bSYxeqWuPWhCIh/zSDhqNQFJPo0Y1TOgUB2kpSRO7+VglqofSZmWAAHIkm3ubuqpDeTjED6CXOX7/iN9xKEtjMdeBP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258047; c=relaxed/simple;
	bh=r0HQ934cPkEcYgVY96ZcGAvReJeLe+hnzGSeso8AQug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgFDYBYqisxslqwXT6CSq7lBndCbJZE/Hg2fvfZIO6etYaHLSXs9SDwoKKVs8gvoX1EpVqDGiiUUOBjZlWylSsnLjJDDZArAtPIqOGXpKY5ER59yPUaDkbZ6oHg5OssjpHDYfpeE0KvQQukxPzOiEdnaM0EcZQ1FISpnmCmBj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y70Um/Ep; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ItI6BSwn2l+PK9p8abWyy/cwtXwTy4aLklVJ9mHKhrg=; b=Y7
	0Um/EpzPKr7sUruIUHD/Z7IdZ++VDhUiEPYNUNOs/dlLurYjNL5w3R0PIR1lYfGE/1ikZgVs3PUrq
	vSC6akpyf24oWY9pE2wyk3ns4XYADxncXAcTaWD/kBh1L0GL4UujtxbZGCnxvzIGHKHZ8ykq4LjCa
	ykvaIXuiZ+ZynDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYPzV-003T2O-Bn; Mon, 29 Jul 2024 15:00:41 +0200
Date: Mon, 29 Jul 2024 15:00:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Justin Lai <justinlai0215@realtek.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>,
	Joe Damato <jdamato@fastly.com>,
	Larry Chiu <larry.chiu@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Ping-Ke Shih <pkshih@realtek.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v25 01/13] rtase: Add support for a pci table in
 this module
Message-ID: <7d85ae3a-28d3-4267-9182-6e799ba8ae0a@lunn.ch>
References: <20240729062121.335080-2-justinlai0215@realtek.com>
 <446be4e4-ea7e-47ec-9eba-9130ed662e2c@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446be4e4-ea7e-47ec-9eba-9130ed662e2c@web.de>

On Mon, Jul 29, 2024 at 11:33:22AM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> > @@ -0,0 +1,338 @@
> …
> > +#ifndef _RTASE_H_
> > +#define _RTASE_H_
> …
> 
> I suggest to omit leading underscores from such identifiers.
> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+define+a+reserved+identifier

Do you have a reference to a Linux kernel document which suggests not
to do this?

My grep foo is not great, but there appears to be around 20,000
instances of #define _[A-Z] in the kernel. So i doubt adding a couple
more is going to be an issue.

	Andrew

