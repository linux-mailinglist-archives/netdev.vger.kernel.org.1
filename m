Return-Path: <netdev+bounces-187668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3DCAA8B36
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 05:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8B0171513
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 03:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD16BA29;
	Mon,  5 May 2025 03:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084672E62C
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746414037; cv=none; b=dU6njPO9vKLipbkBo8wmj8UVeD1rN0vPTbJAjWHMG0q+LhfQTZcdytvxa+bH21aVexAE4ocL7OI49EN9rMY+mECmIqf4pIo2MLWxrxNG8D4jAJ1z7FimFx1LT/V6Hvrfe86MPQIiHg1jepO/ZOvXM7qgn+MnYOtPWQ2U9eP30b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746414037; c=relaxed/simple;
	bh=DJet4tq8ZTTh9N8T6Q4cypfCjXfVaSgkVgkQ6L6wsBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5Odsci2oQj9UGbCIXxah4Wm1/4PMa1/IgqoeKBpxUz7rQb35NfmIwCvpiEwLpQUQaXnXfEazRp9ZfBGh0xhcM1+o2QOAz+5d2SAzZYFVZClWTnuqMtp4vWX4lyrvIef16+8zpcl/U7/9hBlBBz7sozYo7xdrOkjpnaUv/0one4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=basealt.ru; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basealt.ru
Received: from localhost (broadband-46-242-4-129.ip.moscow.rt.ru [46.242.4.129])
	(Authenticated sender: gremlin)
	by air.basealt.ru (Postfix) with ESMTPSA id C38CD2336F;
	Mon,  5 May 2025 06:00:23 +0300 (MSK)
Date: Mon, 5 May 2025 06:00:22 +0300
From: "Alexey V. Vissarionov" <gremlin@altlinux.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Alexey V. Vissarionov" <gremlin@altlinux.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Derek Chickles <derek.chickles@cavium.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Eric Dumazet <edumazet@google.com>,
	Felix Manlunas <felix.manlunas@cavium.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net] liquidio: check other_oct before dereferencing
Message-ID: <20250505030022.GA1405@altlinux.org>
References: <20250429210000.GB1820@altlinux.org>
 <9bd2332c-72fc-4d75-b498-87f4662824d4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bd2332c-72fc-4d75-b498-87f4662824d4@intel.com>

Good ${greeting_time}!

On 2025-04-30 13:46:54 -0700, Jacob Keller wrote:

 >> get_other_octeon_device() may return NULL; avoid dereferencing
 >> the other_oct pointer in that case.
 >> @@ -796,10 +796,11 @@ static int liquidio_watchdog(void *param)
 >>
 >> #ifdef CONFIG_MODULE_UNLOAD
 >>		vfs_mask1 =
 >>		READ_ONCE(oct->sriov_info.vf_drv_loaded_mask);
 >> -		vfs_mask2 =
 >> READ_ONCE(other_oct->sriov_info.vf_drv_loaded_mask);
 >> -
 >> -		vfs_referencing_pf = hweight64(vfs_mask1);
 >> -		vfs_referencing_pf += hweight64(vfs_mask2);
 >> +		vfs_referencing_pf = hweight64(vfs_mask1);
 >> +		if (other_oct) {
 >> +			vfs_mask2 =
 >> READ_ONCE(other_oct->sriov_info.vf_drv_loaded_mask);
 >> +			vfs_referencing_pf += hweight64(vfs_mask2);
 >> +		}
 > Obviously crashing when other_oct is NULL is bad..

Yes, even if this happens only when attempting to unload the
module.

 > But is it ok to proceed when it is NULL? Is leaving out the
 > counts ok? I guess I don't really understand what other_oct
 > actually represents here.

As I can see, the vf_drv_loaded_mask is a bitmap containing
the flags for all existing virtual functions of all devices.
So, if there's no other device, its' functions are missing
and marked as unavailable in the vf_drv_loaded_mask.


-- 
Alexey V. Vissarionov
gremlin נעי altlinux פ‏כ org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net

