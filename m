Return-Path: <netdev+bounces-191980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7158ABE15F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2713B0FCF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F247262FE4;
	Tue, 20 May 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL+QNTFd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5326D4E3
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760239; cv=none; b=q/c8LsXh5OGstjfdlRjSsl+HhokAmlbdDtyqdYXo4MwwHuw0aqMA3QTLcFocman1f3HdrGUglNoS4N9Q0B819Mq/jdKC31Mc6qf8tikhPwBOdgu4KMSS0H0ONyGTC5hNEzXyJSWeWlhlOprA4vqhPqlveKEIDCMshUj1H0PD33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760239; c=relaxed/simple;
	bh=60vT+67lmqH9CnlGUGsi6mnynZYLQGO8nrLpCMfp8Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EohisiUfifkuHh2yIZcSNTnZBdcCsU8VcXPyH2F+uSiuFGyjTdf4sRgDlPxQJ5wAnQytetNu9VntG1T4XNIGNJ8M9tZqMOvdj6S8mtJzXFXVmn4lSdHdgnFUp0sGBujSP4+DoD25n7bfVknmdCoFfUJcijXiWbrMNf+PcVw5L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL+QNTFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED2C4CEE9;
	Tue, 20 May 2025 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760239;
	bh=60vT+67lmqH9CnlGUGsi6mnynZYLQGO8nrLpCMfp8Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BL+QNTFdkGYSV4oruqS+ItFMIRonofXtLeF72DuKjhufDRC2/rEoGvY2BcRylAIYY
	 8vzDuRYynVlummZO0AOdC9tCsOJVYvVi2nbCi7k/hIadBqaoSRJGX2h2OvFRXWssdN
	 abBl4ddn9UKHGmfR5P0/ZIwxOo4tLnyXRSOS2rGTJEqZeJk5t8bvX1DD5OJJBxlXLh
	 jfOWpoSkey30V7+WVnlj++hdHJflMiObXrtAxlkhQUCC2U3Hhlt+B+0NK+6cmZSYWL
	 YG5ps0AcW7XlBxBTE8z2dsGD3LkeJ5GgOc1fvqBsjbsM8B9vcF/UpcV1kgGHnjTEjk
	 H3Dd0coKkXI+A==
Date: Tue, 20 May 2025 17:57:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 5/9] net: txgbe: Support to handle GPIO IRQs for
 AML devices
Message-ID: <20250520165715.GK365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <6542A0ED1333A1E4+20250516093220.6044-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6542A0ED1333A1E4+20250516093220.6044-6-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:16PM +0800, Jiawen Wu wrote:
> The driver needs to handle GPIO interrupts to identify SFP module and
> configure PHY by sending mailbox messages to firmware.
> 
> Since the SFP module needs to wait for ready to get information when it
> is inserted, workqueue is added to handle delayed tasks. And each SW-FW
> interaction takes time to wait, so they are processed in the workqueue
> instead of IRQ handler function.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


