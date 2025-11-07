Return-Path: <netdev+bounces-236797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 727EBC40382
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 620B54F1EBC
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C530E82D;
	Fri,  7 Nov 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V9a+JIp2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CB319875
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523736; cv=none; b=n3JGpo4cQGJPn6qtbDXroGT5CbGgBt+usWvz4gahbsdZmZk9pnN07ldCEjCFNvSURfnV4iIGLbWUsiheJdrqh+xal9866YQiWJwDYnom4rY3wgLHKQ4iGSqkGLIvCpOYqHqT9XYCxGxFFVwPNY+o1MiqN7oeC9fPZxNDF259K1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523736; c=relaxed/simple;
	bh=38Zgesq5pGPo4O7vNxVABbwfK0n4VGHEBWEukcFIdA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jgfu7LzmXMFAGp3sp0dR0f+lOlf98hWBsnwANH9lgf5w9+Pe9nnm5Q9fQ1OBLYjDjuM+OrzWGMjOVZRZ4arkryricjoVcrehvEmCp9Cw74+bPOvPYKQtyDD9i6rfqb8/PN/k+rjBNbVo5VfrNtyazMckY4OD4VmYh/z0rh0JpW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V9a+JIp2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=QRu+P3n+xJ09Xx+vs0/OMXNTsYIGEBIzB4DZpWV5NIA=; b=V9
	a+JIp2zh+9TXvUTIlthXdu6lvNviQUXudJ81INIb+3SjVllxaGuwsMp96XxnbMi49m8cXAdfp3RCU
	4O6mgA8ClafKh855IodCody9HNI5q/6eKdAnHGZ+L5QwuvhXbhsRldW3ZyTR0SfsoCjbqPInwyAqA
	tPsmm4N81yc1kG0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHMw0-00DEUM-Iz; Fri, 07 Nov 2025 14:55:24 +0100
Date: Fri, 7 Nov 2025 14:55:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix mii_status when slave is down
Message-ID: <fbc92957-4cf4-4687-bc2d-ed09cedf8572@lunn.ch>
References: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
 <7a6372b3-b170-49b9-ae62-eb0d1266bd6c@lunn.ch>
 <80576ce0-7383-4b46-bd3a-3ecb0837007e@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80576ce0-7383-4b46-bd3a-3ecb0837007e@6wind.com>

On Fri, Nov 07, 2025 at 09:10:58AM +0100, Nicolas Dichtel wrote:
> Le 07/11/2025 à 03:36, Andrew Lunn a écrit :
> > On Thu, Nov 06, 2025 at 07:02:52PM +0100, Nicolas Dichtel wrote:
> >> netif_carrier_ok() doesn't check if the slave is up. Before the below
> >> commit, netif_running() was also checked.
> > 
> > I assume you have a device which is reporting carrier, despite being
> > admin down? That is pretty unusual, and suggests its PHY handing is
> > broken. What device is it? You might want to also fix it.
> Yes, one slave is put down administratively. Before the mentioned commit, the
> status was correctly reported; it's no longer the case.
> It's a regression.

I agree with your fix, but i would also like to know more about the
interfaces you are testing on. We should probably fix that device as
well. What is it?

Things do get 'interesting' when there is a BMC also sharing the
link. Linux cannot tell the PHY to drop the carrier because that would
also disconnect the BMC, but there should be some separation between
netif_carrier_ok() returns and the state of the PHY.

	Andrew

