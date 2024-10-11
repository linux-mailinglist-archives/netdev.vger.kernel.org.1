Return-Path: <netdev+bounces-134494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8E999D14
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06F9B23B22
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579720967E;
	Fri, 11 Oct 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cCO8ynkF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FB20899E;
	Fri, 11 Oct 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629468; cv=none; b=bWDQwBvteQqo1HlYZEhUPn24lIJxbPv0alHkUurkg5j37AbdR/sLrEBTyjgMojk3+uk8nJ0p+izvS9/yoiAnGRelZH6V4DuTnUrKZIcFVELToJxrHAuLpW2YDpoOjA/2Z6VE9qzOvkWMf4dVEJ/Zdw2dAQeiE7dS7JZgUkBY5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629468; c=relaxed/simple;
	bh=74P+u7tRaTPsSp/1l2gWS+CbNxKtgCI0rAAgfVMg+Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoNe5Od4Vc7AISoZ/jbGLFSjBR04cdWyU2foBp0971VNycJjxPUMNV3LZ0wxjWCzxJdBG819jgNiTn93hThH1oJ64OU7vI7pQe/xDL+2X9G2Hzh6gGyidK/+5jCP8tyJHRksndmPTpterN+kr6A3iCDCW4zPe31xzGlZ64lHI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cCO8ynkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66663C4CEC7;
	Fri, 11 Oct 2024 06:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728629468;
	bh=74P+u7tRaTPsSp/1l2gWS+CbNxKtgCI0rAAgfVMg+Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCO8ynkFqKSetj73ukAR/w2rg8FP4lN8e8+B+eZNEA8+V+zM6Uf7FG2JEL715CZ55
	 WfQ1U9LUcRdHAEMBhZ1jFXcZ3jefBzif7adczZ6Lyf662DSdKmhPM20VQj+sbQPd39
	 5qxeD5eZsfpFq01TsxPcF9FKMpjvd6kg0TH9S3UI=
Date: Fri, 11 Oct 2024 08:51:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, arnd@arndb.de,
	masahiroy@kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] binder: report txn errors via generic netlink
Message-ID: <2024101149-steadfast-skater-c567@gregkh>
References: <20241011064427.1565287-1-dualli@chromium.org>
 <20241011064427.1565287-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011064427.1565287-2-dualli@chromium.org>

On Thu, Oct 10, 2024 at 11:44:27PM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> Frozen tasks can't process binder transactions, so sync binder
> transactions will fail with BR_FROZEN_REPLY and async binder
> transactions will be queued in the kernel async binder buffer.
> As these queued async transactions accumulates over time, the async
> buffer will eventually be running out, denying all new transactions
> after that with BR_FAILED_REPLY.
> 
> In addition to the above cases, different kinds of binder error codes
> might be returned to the sender. However, the core Linux, or Android,
> system administration process never knows what's actually happening.
> 
> This patch introduces the Linux generic netlink messages into the binder
> driver so that the Linux/Android system administration process can
> listen to important events and take corresponding actions, like stopping
> a broken app from attacking the OS by sending huge amount of spamming
> binder transactions.
> 
> To prevent making the already bloated binder.c even bigger, a new source
> file binder_genl.c is created to host those generic netlink code.
> 
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  Documentation/admin-guide/binder_genl.rst |  69 ++++++

You add a file but not to the documentation build?  Did you test-build
the documentation to see where it shows up at?

thanks,

greg k-h

