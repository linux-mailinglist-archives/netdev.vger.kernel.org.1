Return-Path: <netdev+bounces-117960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A479950147
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC81C23EF8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731013CA81;
	Tue, 13 Aug 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFyi0+yJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AEA8BF3
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541631; cv=none; b=bAkFBuxvA2TXje+rLC/UuJSD9tGv5QBFAS3Wd2v0WyHsDhJ408dXsA4qf1ZdjDgtpRfIbPvUSbWskNVbJxF6W7Iq+VhXJBYBD1kS9/AlIVoB9RoTtf8ffU3UW9fVTX0hB6Ofkb9quhcSTRNkp8WJ8Y3W2VCp6A7OpbhytF0QeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541631; c=relaxed/simple;
	bh=f3nTAgnEIqr5K2FKM1P4rW4/8RwHOlhcmcq0aCD5Sqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIGSOJxjSXrK0fbpzk7dFzM92aFiCrBI3DTwFF9Vwgn15TcLFXnUpPy0M9FZNss205+uMf1TXmhj8g0dbFaDrBQsVWDea8M7hm+HlIQJi9VEQeeh0TDsZjsOutBntLMNMee4NAqJ63C+hsWVyhDqP5VMxydOGrdGYHHzuUrRQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFyi0+yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C93C4AF09;
	Tue, 13 Aug 2024 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723541631;
	bh=f3nTAgnEIqr5K2FKM1P4rW4/8RwHOlhcmcq0aCD5Sqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFyi0+yJpTtQQUR2GrA4JFXF5I7o25dkiqRZmcf66n39dxi79TD2yH3cMpaR43gOZ
	 kUljOInHTrvIOJSfIcckQOPFZr3uvzNK07W0rmRTD7Y+v3qy0hqYlsKxUnLYx8GhTG
	 z7gvwPFtvsEqP8EyA4h10eYSOvXPAUrKqx6k33Ew=
Date: Tue, 13 Aug 2024 11:33:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
Message-ID: <2024081350-tingly-coming-a74d@gregkh>
References: <20240805220500.1808797-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805220500.1808797-1-vadfed@meta.com>

On Mon, Aug 05, 2024 at 03:04:59PM -0700, Vadim Fedorenko wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design. Implement
> additional attributes to expose the information. Fixes tag points to the
> commit which introduced the change.
> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  drivers/ptp/ptp_ocp.c | 68 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index ee2ced88ab34..7a5026656452 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -3346,6 +3346,55 @@ static EXT_ATTR_RO(freq, frequency, 1);
>  static EXT_ATTR_RO(freq, frequency, 2);
>  static EXT_ATTR_RO(freq, frequency, 3);
>  
> +static ssize_t
> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	struct ptp_ocp_serial_port *port;
> +
> +	port = (void *)((uintptr_t)bp + (uintptr_t)ea->var);

That's insane pointer math, how do we know this is correct?

> +	return sysfs_emit(buf, "ttyS%d", port->line);
> +}
> +
> +static umode_t
> +ptp_ocp_timecard_tty_is_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct ptp_ocp_serial_port *port;
> +	struct device_attribute *dattr;
> +	struct dev_ext_attribute *ea;
> +
> +	if (strncmp(attr->name, "tty", 3))
> +		return attr->mode;
> +
> +	dattr = container_of(attr, struct device_attribute, attr);
> +	ea = container_of(dattr, struct dev_ext_attribute, attr);
> +	port = (void *)((uintptr_t)bp + (uintptr_t)ea->var);

That's crazy pointer math, how are you ensured that it is correct?  Why
isn't there a container_of() thing here instead?

thanks,

greg k-h

