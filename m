Return-Path: <netdev+bounces-115483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF0946885
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 09:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961DA1C20A09
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8506814D2B5;
	Sat,  3 Aug 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjfu6OGU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E319450F2
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722669153; cv=none; b=Pgl2yurvt1uVVUoBM+G+64by31zxT+W6lG1SCEkO7zOQXdoUs2wxkHPcaENvOhmmHb8KalvJMsnQVDOSk4SyEf46uXPhFNAmOVZ7vGcmCubBzGwtiB8nGbLcmkOf3WCik/V1+51ZlHx6aoFEb7kpHZt5NrxVj7WdLwrN8CwcfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722669153; c=relaxed/simple;
	bh=pZUkjgaKBas5zcnRXV98nRffC+46PscO5i36VTYMoMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQw+tZKnf65/ESWYreu7to3mqfHVKnil7ComBYwym0nciyadPM/HjS3qrFbiqcrMV+ZkHWIPYG+5kUH24H43FAfxauAp0i0IM7dAoPc4GKHY3lRmTQ4rwWpVFbTY0z7r56aJ4H5M6ilMShzj6EjvnAwpFOFpWtZ8qyyWuahuSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjfu6OGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F1EC4AF0A;
	Sat,  3 Aug 2024 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722669152;
	bh=pZUkjgaKBas5zcnRXV98nRffC+46PscO5i36VTYMoMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wjfu6OGUUiXPqCgMoeDncWpXvGTd/0shOfCdtQxwU2An0JvVYS5PHPRCiQwVf//mf
	 F2ucIEzSKoL6l4ve1bgLFmvY8sAfnFk/VI7J0T/EFCErxgqO6STKMlu0oS2uu4+5Li
	 9ji0Mm50/I3qwP9fRgU4yzaozFHTXv8vj9WIqp6A=
Date: Sat, 3 Aug 2024 09:12:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] ptp: ocp: adjust sysfs entries to expose tty
 information
Message-ID: <2024080319-unpadded-hunger-0e5d@gregkh>
References: <20240802154634.2563920-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802154634.2563920-1-vadfed@meta.com>

On Fri, Aug 02, 2024 at 08:46:34AM -0700, Vadim Fedorenko wrote:
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
> +	return port->line == -1 ? 0 : 0444;
> +}
> +#define EXT_TTY_ATTR_RO(_name, _val)			\
> +	struct dev_ext_attribute dev_attr_tty##_name =	\
> +		{ __ATTR(tty##_name, 0444, ptp_ocp_tty_show, NULL), (void *)_val }
> +
> +static EXT_TTY_ATTR_RO(GNSS, offsetof(struct ptp_ocp, gnss_port));
> +static EXT_TTY_ATTR_RO(GNSS2, offsetof(struct ptp_ocp, gnss2_port));
> +static EXT_TTY_ATTR_RO(MAC, offsetof(struct ptp_ocp, mac_port));
> +static EXT_TTY_ATTR_RO(NMEA, offsetof(struct ptp_ocp, nmea_port));
> +static struct attribute *ptp_ocp_timecard_tty_attrs[] = {
> +	&dev_attr_ttyGNSS.attr.attr,
> +	&dev_attr_ttyGNSS2.attr.attr,
> +	&dev_attr_ttyMAC.attr.attr,
> +	&dev_attr_ttyNMEA.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ptp_ocp_timecard_tty_group = {
> +	.name = "tty",
> +	.attrs = ptp_ocp_timecard_tty_attrs,
> +	.is_visible = ptp_ocp_timecard_tty_is_visible,
> +};
> +
>  static ssize_t
>  serialnum_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -3775,6 +3824,7 @@ static const struct attribute_group fb_timecard_group = {
>  
>  static const struct ocp_attr_group fb_timecard_groups[] = {
>  	{ .cap = OCP_CAP_BASIC,	    .group = &fb_timecard_group },
> +	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
>  	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
>  	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
>  	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal2_group },
> @@ -3814,6 +3864,7 @@ static const struct attribute_group art_timecard_group = {
>  
>  static const struct ocp_attr_group art_timecard_groups[] = {
>  	{ .cap = OCP_CAP_BASIC,	    .group = &art_timecard_group },
> +	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
>  	{ },
>  };
>  
> @@ -3841,6 +3892,7 @@ static const struct attribute_group adva_timecard_group = {
>  
>  static const struct ocp_attr_group adva_timecard_groups[] = {
>  	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_group },
> +	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
>  	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
>  	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
>  	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
> @@ -4352,22 +4404,6 @@ ptp_ocp_complete(struct ptp_ocp *bp)
>  	struct pps_device *pps;
>  	char buf[32];
>  
> -	if (bp->gnss_port.line != -1) {
> -		sprintf(buf, "ttyS%d", bp->gnss_port.line);
> -		ptp_ocp_link_child(bp, buf, "ttyGNSS");
> -	}
> -	if (bp->gnss2_port.line != -1) {
> -		sprintf(buf, "ttyS%d", bp->gnss2_port.line);
> -		ptp_ocp_link_child(bp, buf, "ttyGNSS2");
> -	}
> -	if (bp->mac_port.line != -1) {
> -		sprintf(buf, "ttyS%d", bp->mac_port.line);
> -		ptp_ocp_link_child(bp, buf, "ttyMAC");
> -	}
> -	if (bp->nmea_port.line != -1) {
> -		sprintf(buf, "ttyS%d", bp->nmea_port.line);
> -		ptp_ocp_link_child(bp, buf, "ttyNMEA");
> -	}
>  	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
>  	ptp_ocp_link_child(bp, buf, "ptp");
>  
> -- 
> 2.43.5
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

