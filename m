Return-Path: <netdev+bounces-227447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03011BAF9A7
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 10:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3F864E22A6
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03027FB28;
	Wed,  1 Oct 2025 08:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228DF27B35D
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307074; cv=none; b=QQBOXoGDR4tE3H523xwHgQc1coHeHE8h5Vs26oYL1BB+FWhYBjoxV+GLUUv8QWF065t7WEkKqQvtlAKkxYoEeI0np1/qbuT3NOd1+ayuXGqEVatRgNUoKQ9OiOs0UEg0wpiDv5YyF/u8uQtYPQ+A63Kcp7EZvY/rx2NGWK2hQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307074; c=relaxed/simple;
	bh=SSYEdbw57HmsQSOoktylLw6Y1i1FVwNizpRV044nV60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHxV+8XfaEQA37sWPPzkeADJEQuQn4xYDBawnn659Sa9C6y4ucLQ9WuJB/lxQPExWy2M/vFikY8U/O7updx9MyNBlgW44DTzfjN28t37o0VzShZ6MDSboP3YD81rYONJaOn46eNjzSDj/1RTIuvKs1CnM7OmC4bRHs2iXqdgu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3s8N-0006EK-T9; Wed, 01 Oct 2025 10:24:23 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3s8M-001Nmd-3B;
	Wed, 01 Oct 2025 10:24:22 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3s8M-006SMX-2d;
	Wed, 01 Oct 2025 10:24:22 +0200
Date: Wed, 1 Oct 2025 10:24:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Thangaraj.S@microchip.com,
	Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
Message-ID: <aNzlNkUKEFs0GFdL@pengutronix.de>
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
 <20250930173950.5d7636e2@kernel.org>
 <5f936182-6a69-4d9a-9cec-96ec93aab82a@gmail.com>
 <aNzbgjlz_J_GwQSt@pengutronix.de>
 <e956c670-a6f5-474c-bed5-2891bb04d7d5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e956c670-a6f5-474c-bed5-2891bb04d7d5@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Oct 01, 2025 at 01:40:56PM +0530, Bhanu Seshu Kumar Valluri wrote:
> On 01/10/25 13:12, Oleksij Rempel wrote:
> > Hi,
> > 
> > On Wed, Oct 01, 2025 at 10:07:21AM +0530, Bhanu Seshu Kumar Valluri wrote:
> >> On 01/10/25 06:09, Jakub Kicinski wrote:
> >>> On Tue, 30 Sep 2025 14:19:02 +0530 Bhanu Seshu Kumar Valluri wrote:
> >>>> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
> >>>> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
> >>>> +		/* If USB fails, there is nothing to do */
> >>>> +		if (rc < 0)
> >>>> +			return rc;
> >>>> +	}
> >>>> +	return ret;
> >>>
> >>> I don't think you need to add and handle rc here separately?
> >>> rc can only be <= so save the answer to ret and "fall thru"?
> >>
> >> The fall thru path might have been reached with ret holding EEPROM read timeout
> >> error status. So if ret is used instead of rc it might over write the ret with 0 when 
> >> lan78xx_write_reg returns success and timeout error status would be lost.
> > 
> > Ack, I see. It may happen if communication with EEPROM will fail. The same
> > would happen on write path too. Is it happened with real HW or it is
> > some USB emulation test? For me it is interesting why EEPROM is timed
> > out.
> 
> The sysbot's log with message "EEPROM read operation timeout" confirms that EEPROM read
> timeout occurring. I tested the same condition on EVB-LAN7800LC by simulating 
> timeout during probe.

Do you simulating timeout during probe by modifying the code, or it is
real HW issue?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

