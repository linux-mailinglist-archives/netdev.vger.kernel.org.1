Return-Path: <netdev+bounces-72064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F987856693
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FEE282848
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB0132478;
	Thu, 15 Feb 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KgyW6gs3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB075433B9
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008787; cv=none; b=ON5kpZBI2yTMiRiNnrI4YH4GfcVVGxLszMwLLodE95FoRlpeBehpaRGWhRqhTjnZ97jBrt1F7w7990He2CL69hZkkI8Wsm8mLt8AkWJPdN7yuSFcR3TyfQjJbsJ89NWVMCu2TVs0mOe5ZENTSa/ukhYCNQCn1EuofQFCDWETN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008787; c=relaxed/simple;
	bh=TrpsExvFcQZvSueBrPjciRldMViz2auMV0qYCiOgLIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddubQtTAPT5UEMEMGaAFWmOso9MTImLLIjqD5VAnJhA3Qdb4sIm8VVqh52t7QnNx7AmXjkByteLrbiRyeiDfHufmtHu6ZTfCpVn+l7vPDPr8hlkHwJEkZAmEcdzDSXO/EIxESHrl8K9SMwBWjhmNfrW9CcphqHKf7DanMX2opKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KgyW6gs3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NLvIVsfUwApO/Z1mtFVQOcNSVkApXPq0eCnW7/zZWEY=; b=KgyW6gs3pzDFBBrCfXGsuUDSmf
	bErwNU/3yUBL3v5vSMnQxlsi/phpuoxRIAXOVZy/hF3FODMjkg7yrcEDk5kgLZrhp/wiNYt0YShsQ
	97LOU8s+cQimbFPn2nmTAyr0JBMS15VX6hpKh1fc9xaxtnkUwPSaXPH8/trkZs/dZBU0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rad6l-007tic-0I; Thu, 15 Feb 2024 15:53:03 +0100
Date: Thu, 15 Feb 2024 15:53:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vigneshr@ti.com, jan.kiszka@siemens.com, dan.carpenter@linaro.org,
	robh@kernel.org, grygorii.strashko@ti.com, horms@kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup
 calls in emac_ndo_stop()
Message-ID: <3279544c-fbe9-446c-9218-4d2c59f30905@lunn.ch>
References: <20240206152052.98217-1-diogo.ivo@siemens.com>
 <ce2c5ee0-3bed-490e-ac57-58e849ec1eee@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2c5ee0-3bed-490e-ac57-58e849ec1eee@siemens.com>

> Hello,
> 
> Gentle ping on this patch.

Gentle ping's don't work for netdev. Merging patches is pretty much
driver by patchwork, so it is good to look there and see the state of
the patch.

https://patchwork.kernel.org/project/netdevbpf/patch/20240206152052.98217-1-diogo.ivo@siemens.com/

This is marked as Changes Requested.

Looking at the discussion, it seemed to conclude this is a cleanup,
not a fix. Hence the two Fixes: probably want removing.

Please repost with them removed, and the Reviewed-by's added.

You should also set the patch subject to include [net-next] to
indicate which tree this patch is for:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

       Andrew

