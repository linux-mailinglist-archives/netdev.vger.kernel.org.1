Return-Path: <netdev+bounces-68034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A421845AD1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CADF1C2591F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10062156;
	Thu,  1 Feb 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YhYk+fye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB8B62151;
	Thu,  1 Feb 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799839; cv=none; b=mpVbnLrL+U1CgK+Udbxsn/DqgAhPoSv3dl9CbEWNeKyUYWJa25ohhgTrwyxofPJGwpAwiONp0MPgMrYNzeoqkyNieM/0ZNSbqxhO2doaFlOeCFCYW7TMtMPO7BHNNBK5q7qUGvsRx8OxurrYXxE6Ai8l/qtz3XEZG7Vk2pDTEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799839; c=relaxed/simple;
	bh=U09eNR21Lbmrd2l9PZFgQtRK0fx92Ls+0PVGzJDFuko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q03mstUH/4jMs0JFa0pEaHIEz/47wgx6HASGlPFsuGCE0UklzIyHKULnv8+zkN1jTLijgZ42FB7djWa04KXT96fFj+4YRS3cre85f1nLfVVAmU4skG587SyvjCb+oV7T33v+DUVGWPzuGUbHLxHc+1vcyrdW7oArAoq2yL5ljf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YhYk+fye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AFCC43390;
	Thu,  1 Feb 2024 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706799839;
	bh=U09eNR21Lbmrd2l9PZFgQtRK0fx92Ls+0PVGzJDFuko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhYk+fye2duZoKq7wrP/wZM3zLUsVgooOMGedUBMv9sY58Fkhw1LQoOv10cUkea5d
	 XQmlhMIApgGld71PJf4ibrlNyNGdZvNr9qUrHG4/+C3CtP5B0Vc6cpYHLKOg8mOz+M
	 gAaH3/y/b900seFnbfsnWCIoEhJlBzf4hikXk2Ao=
Date: Thu, 1 Feb 2024 07:03:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Leech <cleech@redhat.com>, Nilesh Javali <njavali@marvell.com>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/2] uio: introduce UIO_MEM_DMA_COHERENT type
Message-ID: <2024020125-bunt-nearest-242b@gregkh>
References: <20240131191732.3247996-1-cleech@redhat.com>
 <20240131191732.3247996-2-cleech@redhat.com>
 <20240201044637.GC14176@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201044637.GC14176@lst.de>

On Thu, Feb 01, 2024 at 05:46:37AM +0100, Christoph Hellwig wrote:
> As the least horrible way out this looks ok:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Bt maybe you can add some commentary why this mem mode exists and
> why no one should be using it in new code?
> 

Good idea, and perhaps a kernel log warning when this is used as well
just to prevent anyone new from ever considering it.

thanks,

greg k-h

