Return-Path: <netdev+bounces-146908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF79D6B3B
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 20:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39CC28203F
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 19:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6914B942;
	Sat, 23 Nov 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1j2Nycmr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691946F099;
	Sat, 23 Nov 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391158; cv=none; b=rfqkZJJ1sUGY5QSUg53fux1J4EAW4dKSwn/hUQIWDrtVLWVtYUBoJMEHqoIrDan59osFIAs10GhPAT+jSGh2F1ipl+UTjHt0kLkrvdzJSZXWsdlY2G5zmqJK/rhb7paaZ4JOq0RwFurujuYzgk5xbqtVEnQLN0cYCUVj0VHvdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391158; c=relaxed/simple;
	bh=Il+2syc5dSmitzzBL/NDQCB7GsX20F7hSb/T8QYrcWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTW0m5kA+GCC2fAvlw2lkVo84U0KyoxCeCPr+K+8IDhzRqG3qM9FMof6yxHKNo7S+gNIySxKFC1ugr1gFhBtTbzOfrfgkyVJqtAZqxg7ooL7YxQDPqo+FujreHp4pLlyhrcoDcZ6MVLKDriyFxlSXkkBgLbvUDwdMtbUQXcay+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1j2Nycmr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xUz8szYT2S3oxWL3VZFvQNTuoi+77WmzMXSa7g7vzl4=; b=1j2NycmroZtMJsGvd+zMNR/4uB
	4JYk+EkqgQxEQAXUhoCWuukBZZ1TneCADwl1PoqKyz7XMZ96xaxzCWoS6X1hyYtUuaik8zxtm0uR/
	qeSjUvkIQb+1xETSwCcKPX4ynTbIeED8fZWsba+p2nqH/fgwNmRNxL8HFFdXm2lNHg7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEw4Z-00EEDe-M4; Sat, 23 Nov 2024 20:45:39 +0100
Date: Sat, 23 Nov 2024 20:45:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: zhangheng <zhangheng@kylinos.cn>
Cc: joyce.ooi@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	chris.snook@gmail.com, f.fainelli@gmail.com, horms@kernel.org,
	shannon.nelson@amd.com, jacob.e.keller@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: Use dma_set_mask_and_coherent to set DMA
 mask
Message-ID: <fb4a5fdd-9bd0-41fe-97ba-a3a64b846be5@lunn.ch>
References: <20241123102713.1543832-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123102713.1543832-1-zhangheng@kylinos.cn>

On Sat, Nov 23, 2024 at 06:27:13PM +0800, zhangheng wrote:
> Replace the setting of the DMA masks with the dma_set_mask_and_coherent
> function call.

I can read the patch and see what it is doing. The commit message
should be about "Why?"

netdev is closed at the moment because of the merge window.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr

