Return-Path: <netdev+bounces-103585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9901E908B98
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F693B22524
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1D19645D;
	Fri, 14 Jun 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efNlWAtJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38B195F00;
	Fri, 14 Jun 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367825; cv=none; b=ktUszs0Pxrfpn6FsxPJpX/rtcD9fd9y8hasLjMmWKMuSzq/S3XHh6xf+P9SCLdBl0/9IoJdVUw3S43QJOp5/jmQ2KaMgCWMcrXQUiKQIYqWkymtOfcEVH66ie0J2wevT0ViEH9lyXhUALEmQT0DoxFz5dqJRX6OlhC49K55FDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367825; c=relaxed/simple;
	bh=Wq0QL9TTeA8hyJFpC958b1J5yiGHR5mzwTwtihL+rwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZnPwLpIFqkKIyaRq9RQFUwak2AeP93+vl4ENBJ8heSW4sTCM53jSn5ejcqyGjOZgTf/jFCbyQcoBUgW2usu/Hcj2JyWEqA57e+BNefar2D+DvdyeVLpwkcy6l1qrHuuJQjVe4NTmYKg5eWe89HYvgTlXA92snvoGXlnR858Hu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efNlWAtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6291CC4AF1A;
	Fri, 14 Jun 2024 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718367824;
	bh=Wq0QL9TTeA8hyJFpC958b1J5yiGHR5mzwTwtihL+rwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efNlWAtJj1AqHSkLjjao0ysXiog2A6Cni2zjA4KCUQNFJtOEjO5RMkFt0Do+73mXF
	 7Uf47F+/GY6pS651dNy0ejIWP24xxOKKUUPIsgncQUZUKXHQS+nwPNRJBiG67HK6YJ
	 hmzhRhkbOE+1Vr51Du6rbWqYHmXYMsNPaePyMWz9bOpAoCwSYiztw2FyC7pNY03Kcf
	 WK3Cw8mP93h70zcLqgZSjIkrXB+RZqpUFg5KCB2aQ9/TBlR4Cku7YnnAhz4Kc0L8Iy
	 aefGsNoCywEpHClQUKs5s7AtiYMWfqLhlvliMYHGvuY89fmuBRxIzd/ShQYNXGkZDL
	 D7BNFMtYtxjaA==
Date: Fri, 14 Jun 2024 13:23:41 +0100
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <hanguidong02@outlook.com>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH] atm/fore200e: Consolidate available cell rate update to
 prevent race condition
Message-ID: <20240614122341.GK8447@kernel.org>
References: <ME3P282MB3617E02526BEE4B295478B1AC0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB3617E02526BEE4B295478B1AC0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>

On Tue, Jun 11, 2024 at 11:54:10AM +0800, Gui-Dong Han wrote:
> In fore200e_change_qos, there is a race condition due to two consecutive
> updates to the 'available_cell_rate' variable. If a read operation 
> occurs between these updates, an intermediate value might be read, 
> leading to potential bugs.
> 
> To fix this issue, 'available_cell_rate' should be adjusted in a single 
> operation, ensuring consistency and preventing any intermediate states 
> from being read.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>

Hi Gui-Dong Han,

If there is a race involving writing and reading available_cell_rate,
then I believe there is still a race after your patch: if nothing protects
to protect available_cell_rate from being read while it is written then
that is true both before and after this patch.

Also, I would suggest that this is a very old and possibly unused driver.
If you wish to spend time on it I'd suggest that time go into
investigating if it is appropriate to remove the driver entirely.

