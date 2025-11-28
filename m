Return-Path: <netdev+bounces-242616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5FAC92EA5
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F93A901B
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2C27703C;
	Fri, 28 Nov 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCsjXwU6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E42236FC
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355135; cv=none; b=JG3uOm+JR22E5TtbCebkWrvE09JcgtjNKGLhtnfeAGg0brSigVkaxye4HlFtS3J/ug1jHZ+Bve6UI3ayE7vYkA9oo5mSZXEBRMs7/xIYOASmq2BL4dO3lIuoFmVech0cdd8EPESm1EGNaaI+W85yCMRD8BNV1wvJyF4/cq0wPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355135; c=relaxed/simple;
	bh=/EChcVjXZPHfoEsdICmU3iZmzn5N95UgVFeC72tHyak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j76nw+qFulyYUj+rv43qYAWeVyKjNIjsfi+UdfY1SGB4y+d32P9O8gVRSoxSq25nfe6ncOFIZlj1bMeLELXTFsYMjqvigMgoQznvw7fq39mgHz6wakECTrtMRI6yDiXnHonA9a7IT7VXwcBhlDBuOcK5n24mU96OLy8W0QcM8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCsjXwU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA4AC4CEF1;
	Fri, 28 Nov 2025 18:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764355135;
	bh=/EChcVjXZPHfoEsdICmU3iZmzn5N95UgVFeC72tHyak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VCsjXwU6ujqtdmNC1p2SDf98rW5fSn527o3gy9svDuydY8BPcWNH0y2bHI8WM7dbZ
	 3IPa4hcvgXbe9fifoqK7v1iAszyBOBJtaUa5L/TXav4lyel65cmwvb/PYy1/6b+8G3
	 rkiyD8D+ogQi9twkcU/cDEwknM+oVwtqqzqJOmWlN7ELy1DHgjbzA2Tq9QKWSG5vNl
	 /7UkqazGDxP+1NUZ0ssgz29xm7C37XfaZZUW9eyRC8YhJ01afvu0YrLvrxRseoGS5G
	 7+NeEhJD3pS2/soGJh5oEswqx+cGJ26XK/dJrn2AWqBtfsAuPa9IrS/Ou9ZsqmbU/1
	 43crxUP75z80g==
Date: Fri, 28 Nov 2025 10:38:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net-next] amd-xgbe: schedule NAPI on Rx Buffer
 Unavailable to prevent RX stalls
Message-ID: <20251128103853.3e6f7996@kernel.org>
In-Reply-To: <f288dbe8-d897-4c12-a866-fd70f259ebe4@amd.com>
References: <20251124101111.1268731-1-Raju.Rangoju@amd.com>
	<20251126191342.6728250d@kernel.org>
	<f288dbe8-d897-4c12-a866-fd70f259ebe4@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 11:20:09 +0530 Rangoju, Raju wrote:
> > On Mon, 24 Nov 2025 15:41:11 +0530 Raju Rangoju wrote:  
> >> When Rx Buffer Unavailable (RBU) interrupt is asserted, the device can
> >> stall under load and suffer prolonged receive starvation if polling is
> >> not initiated. Treat RBU as a wakeup source and schedule the appropriate
> >> NAPI instance (per-channel or global) to promptly recover from buffer
> >> shortages and refill descriptors.  
> > 
> > You need to say more.. Under heavy load network devices will routinely
> > run out of Rx buffers, it's expected if Rx processing is slower than
> > the network. What hw condition and scenario exactly are you describing
> > here?  
> 
> During the bi-directional traffic device is running out of RX buffers, 
> it could be because of slower rx processing. HW notifies this via Rx 
> Buffer Unavailable (RBU) interrupt. What is being described above is 
> that, driver should treat RBU interrupt as source to trigger the NAPI 
> poll immediately, rather than waiting for regular rx interrupts to 
> process the rx buffers.

Ack, all I'm saying is that the commit message seems to be overselling
the impact of this change. Patch is very very unlikely to make anything
more "prompt". 99% of the time if Rx buffers are not refilled we are
either in OOM or Rx overload, so either we won't be able to alloc the
buffers, or NAPI is already scheduled. But of course trying to schedule
the NAPI does seem like the more correct reaction, in case we missed an
IRQ or such. Maybe rephrase a little.. unless there's some magic here
im not aware of

