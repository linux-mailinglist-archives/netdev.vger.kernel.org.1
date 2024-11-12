Return-Path: <netdev+bounces-144081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9159C57DE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEBE1F219B0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5595A1CD21F;
	Tue, 12 Nov 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="O8AMiWdV"
X-Original-To: netdev@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8E1CD1FB;
	Tue, 12 Nov 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415011; cv=none; b=l3xjPi1FnPVHKsrhXek7DSobsDjjmyaHN86+TI/NzCYVzUDpQDfA7RMcm9UV6iww9DxrLi3dbAjIytedEZ08Co3CbU2DRXK/VxqJibK87C6NivZ04ljP4h5+22ZiCDwVoKP+ewY5HkbhoLM/NeiTUmR42+zY0fvec8LFLsiOICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415011; c=relaxed/simple;
	bh=j7/f1cs+iC3zEmd0U4xhw5VpEjLNHJFPyUeBoxXe/YE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MNpy8I/2spLN7hxrnplN/YTP2q7aqSG2HS+fgkvSAmA5AoolCYJeXjH4PXqdQSUEyK1AEn4J7EqXMZv0RbOLqhG5CqULJNHQM19g+qDCdm5C554nRGNqLT+Vc+Zr48Mmoe/9yOp1TzF2sCqvRPBJGP0da5/Bad+rENBvmRtVHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=O8AMiWdV; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=j7/f1cs+iC3zEmd0U4xhw5VpEjLNHJFPyUeBoxXe/YE=; b=O8
	AMiWdVrkOVhfPW6cEDr7DfMl9GYrWuX4BnH1b08aP30bfXGwE6SniHgTxhhKwqyXnup2pAibEqicA
	c/2BthUAr23l1z+GeoWD11iRkHc3UR8AXx+qe2GK0CVOy7FasYXOxNGYt6Vz3tBPyTz5B5l1mOsdO
	H1paKbs8XJ5NVOBIGMY3wV+JGsAFaiF90SWhF97TTWtjeC44Wshm9ZwnwsW/D9/lBqnj+wuGAobNy
	i6d/geqAqjd8d6r+d0QMwebMkGRP3krZTmS8OT5Xk3GuFD/eJZcMaX/Mb+Bup6RBzImYfrGdD8cBu
	lpztIvhOfaW9XRc7n+dgy6KCKHDh8G/g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAq8M-000PiT-I4; Tue, 12 Nov 2024 13:36:38 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAq8M-000492-0W;
	Tue, 12 Nov 2024 13:36:38 +0100
Date: Tue, 12 Nov 2024 13:36:37 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	imx@lists.linux.dev, netdev@vger.kernel.org
Subject: Initialize ethernet phy in low power mode before ndo_open
Message-ID: <4t7npxg4jxxoeemcat3besmrfn6sbgsgoolpxbw5asfxfj7xxl@inac2mylgpzl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27456/Tue Nov 12 10:49:43 2024)

Hi,

I'm using a imx6ull, we have an unused ethernet on our board. We would
like it to use as little power as possible as it's battery operated.
During probe I would expect the ethernet driver to probe the phy
deivce and set it in low power mode (BMCR_PDOWN).
The bit is correcly set if I up/down the interface, is that prefered
behavior?

I can see it's the same stmmac driver for stm32mp1 etc.

I can also set the phy in low power mode in the bootloader, but then the
fec driver would reset phy and we end up where we started.

Br,
/Sean

