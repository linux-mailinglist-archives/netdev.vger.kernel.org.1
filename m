Return-Path: <netdev+bounces-118868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132EC953615
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D6C282BA5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEE61AC426;
	Thu, 15 Aug 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oHarmSyQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB81AC422
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733069; cv=none; b=ifA4euuqIHWO4sCGqQlnknDX9fDe0AA0ntcVG10CvFytsIGDgXJlyddbGprBzSnm7iFtEmWJKMKXE3hlkRzxPoIsftYcnVb/zufKEvwuoWLVr8jZV898XrIAqMOZds0WyyTrtxYjrAWfss680D5jrtQxOqLWvlkPyt3AsfXtMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733069; c=relaxed/simple;
	bh=qm6RS91ieENK+z2/TMyLHWO14ioZVtkzWFGfmQzIqOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U14pbfAcgNeDoV8aWWXhmEHD/jsDk3PVF6SraFWJPpqJQSZiBOK4Ff4lQ1ndL09wzFw0Pjbf8EBCD1hw5UhJv9geGYhyWufFrdls9ISUDOfRyv/t0J5kmJVnbRRMdS6rrND3uGP0KCN4clGAmCpGBEIlPZzYtoG+OLdiSrCQnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oHarmSyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B85C32786;
	Thu, 15 Aug 2024 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723733069;
	bh=qm6RS91ieENK+z2/TMyLHWO14ioZVtkzWFGfmQzIqOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHarmSyQ/6lFd/69pewjwzArWJ/tKsOGREc8zqpoAVbCs8Iib79ASAUxJFS9dOxJE
	 5GiKz+xIX9KablDPStihcGu58x7uQiZx2SqiXbBntS1446wxlxIRa7aK7SW5iyHNGK
	 T27alyqRayQ8O4GiQNMytRUHVEzaPIUJzbFyWeC4=
Date: Thu, 15 Aug 2024 15:41:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
Message-ID: <2024081530-clasp-frown-1586@gregkh>
References: <20240815125905.1667148-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815125905.1667148-1-vadfed@meta.com>

On Thu, Aug 15, 2024 at 05:59:04AM -0700, Vadim Fedorenko wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design. Implement
> additional attributes to expose the information. Fixes tag points to the
> commit which introduced the change.
> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Complicated fixes, nice!  Thanks for doing this.  One question:

> +static ssize_t
> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	struct ptp_ocp_serial_port *port;
> +
> +	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);

"uintptr_t"?  That's not a normal kernel type.  var is of type "void *"
so can't this just be "int" here?  Or am I reading this wrong?

thanks,

greg k-h

