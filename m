Return-Path: <netdev+bounces-224998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B87B8CBD0
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 17:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0C71B24E34
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882371E47CC;
	Sat, 20 Sep 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MrH5tkZq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE6288AD
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382881; cv=none; b=IE/Hzpbk/abSylnmCMsCZgE7xbuPbSkhEzQyMQ4SpEqcy7xgGD3yJkiD1R5GZg9bGSe0cY/0Hiz4SrzVvi2A7u4jYvbgzvIbDRbcW3wjZsT26g5vnAkGt5oA44s40cVX9jwyK/K7QxAWqoqdMKlNWCtTfJ8k7YL2QqnZYE+9vEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382881; c=relaxed/simple;
	bh=8SMmqY7E+HB4vHTbf35C/8WHoOU7JFECfr8MeEQpOL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVOblkq3ztfO0ehPUQ4aEfHUtrBCRWT7RbS879Ss4c9njd70+qE84/R4K373gw9KNWdg9K3IUxAq3/DzQMUCrWiYDNdOWndPHOUOFR4/1zWTQHpTIROJJdsB/CC+cX0A3ykuBCV1YJUtpFGvnMqpfKBl30wn3/uKbvENfBFuqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MrH5tkZq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o/HJ145V/QZ0jb9PnUv15MmvFbpJ6OBS/hIF3Pp+KL0=; b=MrH5tkZq++m9NIciC1/5Qq1m5j
	KZIzArpouvevTjsXoAMj7pcVIuQDPYJrPBCgVwabhbJQ6txqXvsnWGtoaBFMm4s4Z0JEEf0ebOaad
	Yd63TpMO7TdvCRLU8nujHo2Xy6Si45uANgxKsZ/KXm8cmVx7DVYNUKn8DmSSaP3jOQ3g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzzi0-0091Jp-O3; Sat, 20 Sep 2025 17:41:08 +0200
Date: Sat, 20 Sep 2025 17:41:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sankararaman.jayaraman@broadcom.com, ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] vmxnet3: remove incorrect register dump of RX
 data ring
Message-ID: <0ea307d6-13c0-407f-8275-50712f95e225@lunn.ch>
References: <20250920120732.351640-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920120732.351640-1-alok.a.tiwari@oracle.com>

On Sat, Sep 20, 2025 at 05:07:18AM -0700, Alok Tiwari wrote:
> The ethtool get_regs() implementation incorrectly dumps
> rq->rx_ring[0].size in the RX data ring section. rq->rx_ring[0].size
> belongs to the RX descriptor ring, not the data ring, and is already
> reported earlier. The RX data ring only defines desc_size, which is
> already exported.
> 
> Remove the redundant and invalid rq->rx_ring[0].size dump to avoid
> confusing or misleading ethtool -d output.

ethtool get_regs() is an ABI. Please can you add an explanation why
this is a safe change to make, it does not affect the ABI.


    Andrew

---
pw-bot: cr

