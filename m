Return-Path: <netdev+bounces-115238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB091945925
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908BD286BBC
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C960263;
	Fri,  2 Aug 2024 07:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DEC3FBAD
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584948; cv=none; b=Tys7i7Yk8gZ7Q56kausKL1fYufAArPVLvIz/Lm9+PaxM0yxWCLu3+h/l6kdjfZjlw2XcJUIQX9s/LSK3BE4ORNsOZkz41iz3ypW2QyoMTycysy+ibzvrNgL59STqUhLG6z2kiJNMk+49wRhX3yrl1ouAgVdGHUtsjOpbAKfYo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584948; c=relaxed/simple;
	bh=rv0eXyWTHMJu7eKQzllgjzsNTHPTFhGz2lBvTBB1nU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHho7AemPpUQd6oEsfGSi3jR8oson8+RJ0qGxjvrBFnQkpt73hK7kdQ1MmRfFFEMH88chSU4rEn/sl5pfk82yY7wBD72Na9mJfIqF+y0tQ1jeIcsYMnFe7QJ2qRa6eK+mQaxy9BlOnadoOs67KRTdtbBoImn+qG5e3JWNITtp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sZn22-0005pg-JU; Fri, 02 Aug 2024 09:48:58 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sZn20-003xLV-CA; Fri, 02 Aug 2024 09:48:56 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sZn20-00Eq9e-0r;
	Fri, 02 Aug 2024 09:48:56 +0200
Date: Fri, 2 Aug 2024 09:48:56 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: vtpieter@gmail.com
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH net-next v2 5/5] net: dsa: microchip: check erratum
 workaround through indirect register read
Message-ID: <ZqyPaBQoU5XqMt10@pengutronix.de>
References: <20240731103403.407818-1-vtpieter@gmail.com>
 <20240731103403.407818-6-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731103403.407818-6-vtpieter@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Pieter,

On Wed, Jul 31, 2024 at 12:34:03PM +0200, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Check the erratum workaround application which ensures in addition
> that indirect register write and read work as expected.

> Commit b7fb7729c94f ("net: dsa: microchip: fix register write order in
> ksz8_ind_write8()") would have been found faster like this.

No. It would be not found faster, because there are nearly no active
users/develpers participating in the development/testing of this part of
the driver. I still do not have access to any KSZ879x variant and the
initial erratum fix was done on request without ability to actually
test it on my side. You seems to be the first one for long time making
something for this series :)

The strategy to re-read configs after writing them is also not
consequent in the driver and would not really help here too. It will
show you an error only if the driver is accidentally writing to a
read-only register.

> Also fix the register naming as in the datasheet.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Nacked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

