Return-Path: <netdev+bounces-60800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820E8218A4
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0041C20FDB
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5F53AF;
	Tue,  2 Jan 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="OMPg8DPP"
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEFECA62
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id EB3092BA;
	Tue,  2 Jan 2024 09:50:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1704185440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EWnLNmP8ycXFfGgtGCw8tql8p6JL0N060m1DGShhIw=;
	b=OMPg8DPPsUBolYr92Civ/uaxHoTe+8kbM/vWBXZrIORIDPgzuUyvqOWEFaL6ILqIicTdTV
	bK2rv31d71njMmE43aVjMxQrO3jtPlf9meCS3LAebUeM948eky3Lr+aTvS08FMQ6XkjsVg
	0n2TTSjtJH+acq4RDauWHSyr+PTWU0NFJ0qQeVYMzoFWVTg6amvEMKr5XdFua6cZyFZAfp
	UO4zzYM42cE9Oq+VmVm0fgTmn0luSSPGRw0D4rgZpNxeUsqm4rjQi1vXwTlwszfhI6IxRQ
	hNISum+LRo/vahJdvPqGhqcBo7JhQ7JiovVT6DvZT+qssYlRdM1Ei7Ro6rWvhQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Jan 2024 09:50:39 +0100
From: Michael Walle <michael@walle.cc>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: ezra@synergy-village.org, Andrew Lunn <andrew@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
In-Reply-To: <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
Message-ID: <cf86ad14e88362952c9f746dfb04cff4@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> Since commit 1a136ca2e089 ("net: mdio: scan bus based on bus
>> capabilities for C22 and C45") our AT91SAM9G25-based GARDENA smart
>> Gateway will no longer boot.
>> 
>> Prior to the mentioned change, probe_capabilities would be set to
>> MDIOBUS_NO_CAP (0) and therefore, no Clause 45 scan was performed.
>> Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
>> least with our setup) considerably slow down kernel startup and
>> ultimately result in a board reset.
>> 
>> AFAICT all SMSC/Microchip PHYs are Clause 22 devices. Some have a
>> "Clause 45 protection" feature (e.g. LAN8830) and others like the
>> LAN8804 will explicitly state the following in the datasheet:
>> 
>>     This device may respond to Clause 45 accesses and so must not be
>>     mixed with Clause 45 devices on the same MDIO bus.

If implemented correctly, c22 phys should never respond to c45
accesses. Correct? So the "Clause 45 protection" sounds like the
normal behavior here and the "may respond to c45 accesses" looks
like it's broken.

> I'm not convinced that some heuristic based on vendors is a
> sustainable approach. Also I'd like to avoid (as far as possible)
> that core code includes vendor driver headers. Maybe we could use
> a new PHY driver flag. Approaches I could think of:
> 
> Approach 1:
> Add a PHY driver flag to state: PHY is not c45-access-safe
> Then c45 scanning would be omitted if at least one c22 PHY
> with this flag was found.
> 
> Approach 2:
> Add a PHY driver flag to state: PHY is c45-access-safe
> Then c45 scanning would only be done if all found c22 devices
> 
> Not sure which options have been discussed before. Any feedback
> welcome.

I had a similar idea and IIRC Andrew said this would be a layering
violation. But I can't find the thread anymore.

> Related: How common are setups where c22 and c45 devices are attached
> to a single MDIO bus?

At least we have boards which has c22 and c45 PHYs on one bus. And
on one board, we even have a Micrel/Microchip PHY on this bus, which
forces us to use c22-over-c45 for the c45 PHY. I really need to repost 
my
c45-over-c22 series, although there was no consensus there 
unfortunately.

-michael

