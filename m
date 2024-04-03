Return-Path: <netdev+bounces-84626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66625897A3C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0228D1F21AA2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838A154BE2;
	Wed,  3 Apr 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PXxn38Aa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98603218B
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177208; cv=none; b=h+NhcFp+42WDcQZl13izDa/5YqFT7h/DY/LaB6Itq4DgrDqOV0BTJPfpQAP8YQiXqGWUf6xRQiwPPiPbcbnOzOvcyvmyo7nebT95/9NoGuJUMQOLXYLJvOapEcSfID2sBkHqyKu7BrWaGOqPMzrB0jpFA5yS8EeB6U76EOpJn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177208; c=relaxed/simple;
	bh=OnGSvz0sMOScoXSe6Vtch6jgOwOVr16ho9dfmUTTbBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuPuerv18VlKbhcGlGhVcILjuCKUcbcY2Vsvh1NjsNnSW+UrNhZiAWFNzNbMFTZRn6MqKI0cKPtLR0/OuP/P0GEdmJv9sDpvOkGqlv91cI9Gg6IKp4BQu/DYOjEO9FvpnLe72X8W9etAZMrS03TxUBLeoSHYpXahwk9yAZcgdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PXxn38Aa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lq8H1ilh9GcLVJanCt300842Idj+hhabzlORtyAReLs=; b=PXxn38Aauj4j0XxZJsofMIaZiI
	Hh4aNdzRslDYzn1/J8pYclvh6J+9ALDktbXSxWL2ZXqRG7GQtVqnv7maOGHNZNqIMXS9Tj219IFpH
	s3LVKxo6rA10+MdUJqDgVL9Ea49Vwwp8TPF6safk7MB0bZBo+xAmSBo7CZTASUdDOO8E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs7VL-00C78n-V4; Wed, 03 Apr 2024 22:46:43 +0200
Date: Wed, 3 Apr 2024 22:46:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 04/15] eth: fbnic: Add register init to set
 PCIe/Ethernet device config
Message-ID: <32deafeb-82fe-48c6-a15e-08e065963876@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217492154.1598374.14769531965073029777.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217492154.1598374.14769531965073029777.stgit@ahduyck-xeon-server.home.arpa>

> +#define wr32(reg, val)	fbnic_wr32(fbd, reg, val)
> +#define rd32(reg)	fbnic_rd32(fbd, reg)
> +#define wrfl()		fbnic_rd32(fbd, FBNIC_MASTER_SPARE_0)

I don't think that is considered best practices, using variables not
passed to the macro.

	Andrew

