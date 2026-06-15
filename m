Return-Path: <netdev+bounces-299288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jEO2AHFVL2pv+gQAu9opvQ
	(envelope-from <netdev+bounces-299288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:29:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72A682C06
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:29:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=N7Eeqduo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299288-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299288-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30BE23003EB1
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E391EDA0F;
	Mon, 15 Jun 2026 01:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2B21A447
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 01:28:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486938; cv=none; b=SVE8GCC+EPJsdX3n3RUA79qCvzb5Nm8V2WDfRz1c1Ug/t8+sgIthCBoXgzsoQYiAetAYFEX6nY2RmOq8F0/p0FIOEd4Ss0Xk5r9DIgdpXMVZcyGGimvkbdIpCfyUMpH11LpAwoVEJaQdgQdItFb/EusH9FQqm56vOeHZRiTzYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486938; c=relaxed/simple;
	bh=p0PNIM+AdI194NEDzvHgcBoZhq48rNFDPdXQrXERr3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOGxsPASBWfulkBwjmPvOrJgC8x0pOWvwIvaB3spllgzLWeRZbzNoRU+YomPQ+xmPG1gDHm//aMHGCkvXF1EPp/GpzbFYY1CulmP07M5Xhu//2dTEQ7i2RZgjtdhD9qtiGlynufru5ubSmOlOsxo3niHc7lc8B9T3s5/GAo7Ymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N7Eeqduo; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=M483btWre2cnhhj8gL56GG70ENRhHk5py6rwm6CMRmU=;
	b=N7Eeqduo/7+BR2+dxEpXDvc7w9quwS9MrtopAynm951PhPbQiXEY9d0IHyyMgW
	nVom+bFZ+bQID10cltGcxkj+0OoIg/pXFcPfI0IinZFiRPWD+176wnUcAUFUnaON
	WUXnuJpD87XBuKEC6z1l1NS/w9yxbn4SSXYkBUCS7Pz88=
Received: from [10.42.20.136] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXRPIwVS9qIyKeDA--.149S2;
	Mon, 15 Jun 2026 09:28:18 +0800 (CST)
Message-ID: <6a4bb07e-dbfb-4017-b0c3-b01ef2fc5432@163.com>
Date: Mon, 15 Jun 2026 09:28:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] e1000: Initialize phy_data to avoid
 unexpected values
To: Andrew Lunn <andrew@lunn.ch>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Rongguang Wei <weirongguang@kylinos.cn>
References: <20260612080331.120096-1-clementwei90@163.com>
 <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXRPIwVS9qIyKeDA--.149S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1UAF48JrWxGw17Xr17trb_yoW8tF45pr
	47Xa4qyF4UXr9Fg397Jw18Ary5X397t3yfCF4fuw1Ygr95JrWvqF1xKFWUGF1avwsrurWa
	vF1jvasxAan8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcSdkUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-hLHM2ovVTLRgQAA3q
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:weirongguang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER(0.00)[clementwei90@163.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299288-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clementwei90@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C72A682C06



在 2026/6/13 03:39, Andrew Lunn 写道:
> On Fri, Jun 12, 2026 at 04:03:31PM +0800, Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> The phy_data variable is not initialized. If e1000_read_phy_reg
>> returns an error, phy_data will not point to a valid value from
>> the PHY register, which may cause the regs_buff array to be populated
>> with unexpected values.
>>
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>> Change-Id: I46071b3b21a566f8da650168d38d6968251b077d
> 
> What does this Change-Id mean?
> 
Sorry, it just a auto generate id when I push this patch on my own repos.
I forget to delete.
>> ---
>>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> index 4dcbeabb3ad2..f068108c5004 100644
>> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> @@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>>  	struct e1000_hw *hw = &adapter->hw;
>>  	u32 *regs_buff = p;
>> -	u16 phy_data;
>> +	u16 phy_data = 0;
> 
> 	if (hw->phy_type == e1000_phy_igp) {
> 		e1000_write_phy_reg(hw, IGP01E1000_PHY_PAGE_SELECT,
> 				    IGP01E1000_PHY_AGC_A);
> 		e1000_read_phy_reg(hw, IGP01E1000_PHY_AGC_A &
> 				   IGP01E1000_PHY_PAGE_SELECT, &phy_data);
> 		regs_buff[13] = (u32)phy_data; /* cable length */
> 
> Isn't a cable length of 0 also unexpected?
> 
> How does this patch actually make the situation better?
> 
Uninitialized variables may be initialized to 0 by the system, explicit initialization
is performed to avoid accidents. 

The 0 is from e1000_read_phy_reg_ex in e1000_main.c and e1000_power_down_phy when use
e1000_read_phy_reg function the last paramenters is initialized 0. So I used this value.

There are many other function which use e1000_read_phy_reg also not initialize the last paramenters
eg. e1000_phy_reset_clk_and_crs. I can do it in V2.
>     
>     Andrew
> 
> ---
> pw-bot: cr


