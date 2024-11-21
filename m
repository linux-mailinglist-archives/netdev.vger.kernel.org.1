Return-Path: <netdev+bounces-146702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E19D5176
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 18:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E48280DB6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF71A7045;
	Thu, 21 Nov 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=seoss.co.uk header.i=@seoss.co.uk header.b="D05j2VDv"
X-Original-To: netdev@vger.kernel.org
Received: from relay0.allsecuredomains.com (relay0.allsecuredomains.com [51.68.204.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332B17333A
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.204.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209312; cv=none; b=tFFeCqXmygh/X/qaIEUCzojsxYLtO5K1i1PjOXEi+oKP18F1Kd0dSbJEYPMDUOiHZ7sImXac8zZDF8Ge2wD0O6pYixE5/dLNqLTRJrvZTgUeNeViba77VEbpliGf5pZWhIAQ8LT148CV4tNc+FyTYojrtQROxVHXRHp5owfzsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209312; c=relaxed/simple;
	bh=Zp07nk2hYaqBxL0vv6nuaTmHsHX/1Y+Ic5vLGxqAUR8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=F301kRtQfv6sdma6RJsKCEgHl3YQwkmCFIPe/BfwyHTjscr/4ogGS7+3vuT7SxZGHg1p0egsVDYoEXTX4SBD2celXif/Ueh/cLYxoiLyjS2wHevraGB3DRAwJ1P6zxCjSVUxsSK58l4DXlE2SdbpEl+HUTsXTcZ0ZEUuM2JmndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=seoss.co.uk; spf=pass smtp.mailfrom=seoss.co.uk; dkim=pass (1024-bit key) header.d=seoss.co.uk header.i=@seoss.co.uk header.b=D05j2VDv; arc=none smtp.client-ip=51.68.204.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=seoss.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seoss.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=seoss.co.uk
	; s=asd201810; h=Content-Transfer-Encoding:Content-Type:Cc:Subject:To:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d2XGZoWR3NXO2nBInIhWT+oQvb36n+z1Dg8CJYFuhUs=; b=D05j2VDvt9qOYmClV5pkkxo5nd
	UVcTuN3bMD0yX46Di8OYQDfaa4/zA+VlQqg6x/kGrFMqOpsJI/QKgXHFJtEK7RUMpvkGPQo21BRwI
	tQ2HXIisbTf3WpspLrfODP3nMI+9Mlt4p54qRt65b/UHy01cXHDrR1os1BegaeTLti+g=;
Received: from [81.174.144.187] (helo=[172.19.198.146])
	by relay0.allsecuredomains.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <tim@seoss.co.uk>)
	id 1tEA7D-00023l-JA; Thu, 21 Nov 2024 16:33:11 +0000
Message-ID: <ea3dcffe-d7a9-48d2-975c-75b7b20ee3d4@seoss.co.uk>
Date: Thu, 21 Nov 2024 16:33:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tim Small <tim@seoss.co.uk>
Content-Language: en-GB
To: Andrew Lunn <andrew@lunn.ch>
Subject: Marvell 88E1512 cable test tdr timeout
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thanks for contributing your work on cable test to the kernel.

I'm trying to use the TDR cable test functionality using the Marvell 
88E1512 PHY which is included in a wifi access point.

When I run:

ethtool --cable-test-tdr eth1

I get no results, and the kernel log includes:

Marvell 88E1510 mdio.1:01: Timeout while waiting for cable test to finish

The wifi access point is running OpenWrt snapshot v6.6.61
  (Huawei AP5030DN) and has a MIPS 74Kc V5.0 based SoC.

Since support for this device is not in the mainline kernel, I cannot 
easily run mainline, but I've diffed the OpenWrt tree against 
net-next/main and can't see any changes to drivers/net/phy/marvell.c 
which which look like they would have changed the tdr test path, and 
could attempt to run mainline if that would be useful.

The markings on the physical chip are:

88E1512-NNP2
NNR3880.5JW
1442 A0P
TW

I can't find the programming manual online (I assume it's NDAed?) so I 
can't check to see if there are any differences between the 88E1512 and 
the 88E1510, or errata etc.

I tried increasing the hard-coded poll number in 
marvell_vct5_wait_complete(), but I just get a watchdog reset in that case.

Any hints or tips gratefully received.

Cheers,

Tim.

