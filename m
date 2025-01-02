Return-Path: <netdev+bounces-154731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE419FF9C9
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0909C7A1C67
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC131E51D;
	Thu,  2 Jan 2025 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q0D1W38w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD426ACB
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824146; cv=none; b=lSAfPg9sQphwHr+w+Fs58t8iZaK6cTq5GzacdtCTZDSfoaubd5k5Fx3T0Uo2wc+QfIMtuM2NrqfBmmRXOH+IekXYl+be61Ypt5gisYqk2R4bfSUZSZOLEmdg6Oejcv0UhOMaQpXlH9YbPPhoXBOUqofqNJ0ZGieCZcboB9LvRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824146; c=relaxed/simple;
	bh=WlLdZnhVLVnr9k3o+MfHfDEABOfVvHt6ijOEQX6i84I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oky1+CsBr0iM7JEncbIOAnQKRxASDDHPCb0SDYtMaTk0VI1kB7Ge5RErPU8a/hFPyrOwBxqWMbYvtTvipNDugYVT7xrMxxjZsBpc6jcTQZLj2Zkuoq5KegFcQo1TqodEtddzpkOR2RGcAi1NEJ9f+UjN6jrlP8RWOdQIeUyYc1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q0D1W38w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bdtC6GAXHG5jZPjGFTBaRw5ZT1DrSm4Fpb3HdcMkLWo=; b=Q0D1W38wCOv5WrPCcCXnA6DBTm
	AjmjvC7Q+MHUUuLgN0FlFNziPsKe2msva2usny39uqCp5OExUZIXlkqUbhzSbpfc4w+eYNpTMIVrW
	2AUwKKfUPaVDpNP8LGfHyFFWlw3KWm0mgeKFZUm2sSaxXlmxfHw1vVzw+8qs+RGEWQ9Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTL9T-000kK5-4X; Thu, 02 Jan 2025 14:22:15 +0100
Date: Thu, 2 Jan 2025 14:22:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Muhammad Nuzaihan <zaihan@unrealasia.net>
Cc: netdev@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] Add NMEA GPS character device for PCIe MHI Quectel
 Module to read NMEA statements.
Message-ID: <4b576e34-ec43-4789-b18b-86d592f9d031@lunn.ch>
References: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
 <5LHFPS.G3DNPFBCDKCL2@unrealasia.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5LHFPS.G3DNPFBCDKCL2@unrealasia.net>

On Thu, Jan 02, 2025 at 05:12:41AM +0800, Muhammad Nuzaihan wrote:
> Hi netdev,
> 
> I made a mistake in choosing AT mode IPC, which is incorrect. For NMEA
> streams it should use LOOPBACK for IPC. If it uses AT, i noticed that using
> gpsd will cause intermittent IOCTL errors which is caused when gpsd wants to
> write to the device.
> 
> Attached is the patch.

This is not my area, so i cannot do a full review, but a few things to
note.

Please start a new thread for each version of a patch, and wait at
lest 24 hours between each version.

The commit message should be formal, since it will be part of the
kernel history.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> @@ -876,7 +880,8 @@ static long wwan_port_fops_ioctl(struct file *filp, unsigned int cmd,
>  	struct wwan_port *port = filp->private_data;
>  	int res;
>  
> -	if (port->type == WWAN_PORT_AT) {	/* AT port specific IOCTLs */
> +	if (port->type == WWAN_PORT_AT ||
> +			WWAN_PORT_NMEA) {	/* AT or NMEA port specific IOCTLs */

This looks wrong. || WWAN_PORT_NMEA will always be true, assuming
WWAN_PORT_NMEA is not 0.

    Andrew

---
pw-bot: cr

