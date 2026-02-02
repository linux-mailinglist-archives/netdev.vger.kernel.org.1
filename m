Return-Path: <netdev+bounces-255969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDYoH/LhgGleCAMAu9opvQ
	(envelope-from <netdev+bounces-255969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:42:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F84CFB4E
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B0E6300361D
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B15385EDD;
	Mon,  2 Feb 2026 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aO7KJbS8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF63816E9
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053950; cv=none; b=kLAQEkgy7ZB/8qHMPjU1TFIL9ab/NA6YjBwnEoTNnXUbwi+UEZJenqr77j9lU1qoosX+M0jRczYTOgAjpq2p9xoehQM0R1qPwkDNuwS38QzcChDev7/oUmeZEMPUqex/F6hSr4AbCQrWleGaBDqLVIjfmIYgd7C3P0tLFX+LSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053950; c=relaxed/simple;
	bh=H8ge6u2G9ETLaUdtm8m9+HEAAf7jKP2YUXl5JQrlHeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfKpCUR2l6bXumTdz+khVWuFCHkUUPIYNCCLuSZ95DF91F+SEzk/WgaBgeA27DhVQRazDod9APQMA1Y3LSuXexRSurmgge1H/otB6N7v1S3ky12/MN+LPKpnRfVDksBnzz31Zdn1etGDXlcGZsMozbL+QFHea7xB38HQqxrFwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aO7KJbS8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CC2A2C237F3;
	Mon,  2 Feb 2026 17:39:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA5E960767;
	Mon,  2 Feb 2026 17:39:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 414E2119A8888;
	Mon,  2 Feb 2026 18:38:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770053945; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=c1h4euVzUgrsm8tkmQ9pvrCo/Vv3M9QxABZPkbxAwm0=;
	b=aO7KJbS8NSpYo5S5oDL+njQYcE85HvoejlfbW7DXcpX0YdfdYWwC2xLyt46gLO8V0vHOz3
	U8J1Q527/uqJlqqf4Mm4bVaiqa4mpq5iqTa57VKuaxes//OwtF6MxpvigOY+4oZN+mkJ7k
	rzwlPLFwR++P/bDRcAiM4sR/U/ATwOMtlFKhTBcNK4zcw/2Kh+1kWS+TqT04YogK6mHREY
	0G3T3BfscbdveB6+yUvMh0bt4XGzkAxkss7zRc6CkCyqAoTTnJWeb0HsjkrkwWOXtAdcJZ
	tKXg5qZvg1AhDQWZdK1o68pdDrWPHpGaNrnbffADy5n37aM1LQt2jTfmMuc0ew==
Message-ID: <0689a2ab-352a-4275-9662-0c45daf8a0b2@bootlin.com>
Date: Mon, 2 Feb 2026 18:38:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: phy: change devlink flag to
 AUTOREMOVE_SUPPLIER for non-SFP PHYs
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, florian.fainelli@broadcom.com,
 xiaolei.wang@windriver.com, quic_abchauha@quicinc.com,
 quic_sarohasa@quicinc.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260202054533.539883-1-wei.fang@nxp.com>
 <267c78c1-4ad2-4f06-be63-0fb506c5134d@bootlin.com>
 <aYCzxVTTZvok9_d1@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aYCzxVTTZvok9_d1@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255969-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,nxp.com:email,quicinc.com:email]
X-Rspamd-Queue-Id: D4F84CFB4E
X-Rspamd-Action: no action



On 02/02/2026 15:25, Russell King (Oracle) wrote:
> On Mon, Feb 02, 2026 at 12:10:41PM +0100, Maxime Chevallier wrote:
>> Hi Wei,
>>
>> On 02/02/2026 06:45, Wei Fang wrote:
>>> For the shared MDIO bus use case, multiple MACs will share the same MDIO
>>> bus. Therefore, these MACs all depend on this MDIO bus. If this shared
>>> MDIO bus is removed, all the PHY devices attached to this MDIO bus will
>>> also be removed. Consequently, the MAC driver should not access the PHY
>>> device, otherwise, it will lead to some potential crashes. Because the
>>> corresponding phydev and the mii_bus have been freed, some pointers have
>>> become invalid.
>>>
>>> For example. Abhishek reported a crash issue that occurred if the MDIO
>>> bus driver was removed first, followed by the MAC driver. The crash log
>>> is as below.
>>>
>>> Call trace:
>>>  __list_del_entry_valid_or_report+0xa8/0xe0
>>>  __device_link_del+0x40/0xf0
>>>  device_link_put_kref+0xb4/0xc8
>>>  device_link_del+0x38/0x58
>>>  phy_detach+0x2c/0x170
>>>  phy_disconnect+0x4c/0x70
>>>  phylink_disconnect_phy+0x6c/0xc0 [phylink]
>>>  stmmac_release+0x60/0x358 [stmmac]
>>>
>>> Another example is the i.MX95-15x15 platform which has two ENETC ports.
>>> When all the external PHYs are managed the EMDIO (the MDIO controller),
>>> if the enetc driver is removed after the EMDIO driver. Users will see
>>> the below crash log and the console is hanged.
>>>
>>> Call trace:
>>>  _phy_state_machine+0x230/0x36c (P)
>>>  phy_stop+0x74/0x190
>>>  phylink_stop+0x28/0xb8
>>>  enetc_close+0x28/0x8c
>>>  __dev_close_many+0xb4/0x1d8
>>>  netif_close_many+0x8c/0x13c
>>>  enetc4_pf_remove+0x2c/0x84
>>>  pci_device_remove+0x44/0xe8
>>>
>>> To address this issue, Sarosh Hasan tried to change the devlink flag to
>>> DL_FLAG_AUTOREMOVE_SUPPLIER [1], so that the MAC driver will be removed
>>> along with the PHY driver. However, the solution does not take into
>>> account the hot-swappable PHY devices (SFP PHYs), so when the PHY device
>>> is unplugged, the MAC driver will automatically be removed, which is not
>>> the expected behavior. This issue should not exist for SFP PHYs, so based
>>> on the Sarosh's patch, the flag is changed to DL_FLAG_AUTOREMOVE_SUPPLIER
>>> for non-SFP PHYs.
>>>
>>> Reported-by: Abhishek Chauhan (ABC) <quic_abchauha@quicinc.com>
>>> Closes: https://lore.kernel.org/all/d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com/
>>> Link: https://lore.kernel.org/imx/20250703090041.23137-1-quic_sarohasa@quicinc.com/ # [1]
>>> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
>>> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>>
>> I gave that patch a test, with the following cases :
>>
>>  - On Macchiatobin (we have PHYs that share an mdiobus).
>> When unbinding a PHY, the MAC dissapears as well :
> 
> Correct, this is why these band-aids are harmful. One "device" can
> correspond with *multiple* network interfaces, and the loss of one
> PHY can have a *very* detrimental effect.
> 
> Consider the case where root-NFS is being used, and removing a PHY
> on another interface takes out the interface that root-NFS is
> using. Your machine is now dead in the water.

That's what I've been seeing. I unbound one PHY, it took out 3 netdevs
and I don't have log regarding "why". I guess there's devlink debug
knobs for that, but not enabled by default it seems.

However, we seem to have the issue even without this patch.

On MCBin, if I unbind eth1 for example, all 3 interfaces that are on CP1
are gone :

cd /sys/class/net/eth1/device/driver
echo f4000000.ethernet > unbind

only eth0 is now left. This is on net-next/main :(

For Wei's case where unbinding netdev 1 brings the mdio bus down, used
by PHY on netdev 2, we'd be also dead in the water as well no matter
what as well no ?

> In my opinion, we should be concentrating more on the issue behind
> the oops.
> 
> Given that this problem is because of the bus being removed, one
> thing that would help would be for the MDIO bus to be properly
> refcounted, and when the bus is unbound, to replace the bus ops
> with versions that return -ENXIO or similar under the MII bus
> lock. This would be easier of the MDIO bus ops were a separate struct
> to struct mii_bus.
> 
> Similar with the PHY itself - if the PHY is in-use, it should be
> refcounted to stop the struct phy_device from going away, and
> should we have the situation where the PHY driver is unbound,
> phydev->drv should be set to a set of dummy ops (under the phydev
> mutex and probably rtnl.)
> 
> It seems to me that throwing devlinks at this problem is giving us
> more problems than it's solving.
> 
> A graceful way to handle a MAC losing its PHY is for phylib to
> indicate that the PHY has gone down, rather than removing the
> network interface (and potentially a whole host of other network
> interfaces in the case of one struct device being associated
> with many interfaces.)
> 

Agreed, that's quite the can of worms though I suspect :(

Maxime


