Return-Path: <netdev+bounces-112645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E593A4F9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FE81F21B05
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC8B157A48;
	Tue, 23 Jul 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYdIrLMy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9713BC18;
	Tue, 23 Jul 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755952; cv=none; b=Tea7gtIGTCTToQX4I5Z/Q6xwW7yBov4xoroxq07NFozJR8iQ3O5rYXVTwJcS5xzUPYmTdt+4wUn6KdYTF9VTDdtQvZ1WcKn7MRnI8g4yGZm7uXtawHHGXRy/Ld/OIH4u8g6JkocN43JJVfBa4qI/vXvOa5rki6FQoaKLJk+g7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755952; c=relaxed/simple;
	bh=VeKv1mdM4b2Az2hwXIufGbGyrkqjcYonv0q7odEaJbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1hbkSbew2HGTNxUTMAzKlTeLjj9kW+aGZn45371q9F11DOFgbf6CDmDRGuaSy/Hvqcaot81xfh/uSnoH4zKnQp2gZdqNvQavxcV0RLv5Td/RkaGW6CWVxOh41wt+nlVes8csRp6JSW2JcMR9R32mU1Kz8bBkb/d9jDRQLXlPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OYdIrLMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B792AC4AF0A;
	Tue, 23 Jul 2024 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721755952;
	bh=VeKv1mdM4b2Az2hwXIufGbGyrkqjcYonv0q7odEaJbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYdIrLMyfCk4J6Tu7KzRzullXgcO5GzZ+dgXmbi+rYKn3AcYr7ZGg8/URI+9ktb39
	 ryxQMQx/FgIRi7W/z84MQSJsAqiJEaGacoIX8G3z1pd76e7xKrfZ9ayHqvHs/3beJw
	 3tzlHkssxFZgvyRLlC551eHA508kuzd3ZzcbVNJg=
Date: Tue, 23 Jul 2024 19:32:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, liujunliang_ljl@163.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB2NET: SR9700: fix uninitialized variable use in
 sr_mdio_read
Message-ID: <2024072305-dinner-prize-bb82@gregkh>
References: <20240723140434.1330255-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723140434.1330255-1-make24@iscas.ac.cn>

On Tue, Jul 23, 2024 at 10:04:34PM +0800, Ma Ke wrote:
> It could lead to error happen because the variable res is not updated if
> the call to sr_share_read_word returns an error. In this particular case
> error code was returned and res stayed uninitialized.
> 
> This can be avoided by checking the return value of sr_share_read_word
> and propagating the error if the read operation failed.
> 
> Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

You forgot to document how you found this problem.

> ---
>  drivers/net/usb/sr9700.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

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

