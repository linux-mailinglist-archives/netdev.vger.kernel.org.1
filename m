Return-Path: <netdev+bounces-300390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8jgPFALGM2peGAYAu9opvQ
	(envelope-from <netdev+bounces-300390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:18:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C68B769F36F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:18:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300390-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300390-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B49F31C6136
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F331367F4A;
	Thu, 18 Jun 2026 10:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B53C9EF1;
	Thu, 18 Jun 2026 10:12:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777558; cv=none; b=F+BbABACDODJj7VEkoR4fS2EWsTPVcqE36rbRP1EDc3/4mLDSDVU1StMBjz2P9CiN1AUNOjOLLezSgc2AMlnN4zk+teR06pd6P629T8HSoYuenos754kE+5PuTAXNZRaPm7IZXeacpqgMFF/ihacN0RkY4WWmBfCDTD6pCHPSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777558; c=relaxed/simple;
	bh=4tDEosFbhGcCJLIfzFw5V+1C91U3ys6mQQAKi6VHrtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC/eIfvcW34G/J6lRGIfKQZaN3iREMm79tjjo/OhUHXV6qHzQH4rxcfht63Us69eI7ur5dTMTL0/wBuzEm8kNwl3pclBRXbiz0vpCzJLQOOhSkRsTz2ugI04KY9Ext4UTDL/TJdy9j8p3QER4tO0JIWG3Vd288Cn6bb+ELwcRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 78B684C2887192;
	Thu, 18 Jun 2026 12:11:41 +0200 (CEST)
Message-ID: <a9f9da7b-d55f-4f8b-8db3-c33b623168d0@molgen.mpg.de>
Date: Thu, 18 Jun 2026 12:11:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough after
 reset
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260618073324.1843310-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300390-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FORGED_RECIPIENTS(0.00)[m:acelan.kao@canonical.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,canonical.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,molgen.mpg.de:mid,molgen.mpg.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C68B769F36F

Dear Chia-Lin,


Thank you for your patch.

Am 18.06.26 um 09:33 schrieb Chia-Lin Kao (AceLan) via Intel-wired-lan:
> Some systems support MAC passthrough for dock Ethernet controllers by
> having firmware rewrite the receive address registers after the controller
> reset completes.

Please give one example system.

> igc resets the controller before reading RAL0/RAH0, so that reset can
> restore the controller native MAC address temporarily. If the driver reads
> the registers immediately, it can race the firmware rewrite and keep the
> native dock MAC instead of the host passthrough MAC.
> 
> For LMVP devices, poll RAL0/RAH0 after reset and before reading the MAC

What is LMVP?

> address. Stop once the address registers change to another valid Ethernet
> address, allowing firmware a bounded window to complete the passthrough
> update.

What are the downsides of this approach? Longer reset times?

Please add instructions how to test this.

> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 48 +++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 2c9e2dfd8499..fa9752ed8bc5 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -11,6 +11,7 @@
>   #include <net/pkt_sched.h>
>   #include <linux/bpf_trace.h>
>   #include <net/xdp_sock_drv.h>
> +#include <linux/etherdevice.h>
>   #include <linux/pci.h>
>   #include <linux/mdio.h>
>   
> @@ -69,6 +70,52 @@ static const struct pci_device_id igc_pci_tbl[] = {
>   
>   MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
>   
> +static void igc_read_rar0(struct igc_hw *hw, u8 *addr, u32 *ral, u32 *rah)
> +{
> +	*ral = rd32(IGC_RAL(0));
> +	*rah = rd32(IGC_RAH(0));
> +
> +	addr[0] = *ral & 0xff;
> +	addr[1] = (*ral >> 8) & 0xff;
> +	addr[2] = (*ral >> 16) & 0xff;
> +	addr[3] = (*ral >> 24) & 0xff;
> +	addr[4] = *rah & 0xff;
> +	addr[5] = (*rah >> 8) & 0xff;

This looks like a common pattern, but there does not seem to be a 
generic Linux implementation. Maybe `igc_read_mac_addr()` in 
`drivers/net/ethernet/intel/igc/igc_nvm.c` can be used?

> +}
> +
> +static bool igc_is_lmvp_device(struct pci_dev *pdev)
> +{
> +	switch (pdev->device) {
> +	case IGC_DEV_ID_I225_LMVP:
> +	case IGC_DEV_ID_I226_LMVP:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
> +					      struct igc_hw *hw)
> +{
> +	u8 addr[ETH_ALEN] __aligned(2);
> +	u32 orig_ral, orig_rah;
> +	u32 ral, rah;
> +	int i;
> +
> +	if (!igc_is_lmvp_device(pdev))
> +		return;
> +
> +	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
> +
> +	for (i = 0; i < 100; i++) {
> +		msleep(100);

Up to ten seconds delay(?) sounds excessive. Please elaborate in the 
commit message.

> +		igc_read_rar0(hw, addr, &ral, &rah);
> +		if ((ral != orig_ral || rah != orig_rah) &&
> +		    is_valid_ether_addr(addr))
> +			return;
> +	}

No error in case this didn’t work?

> +}
> +
>   enum latency_range {
>   	lowest_latency = 0,
>   	low_latency = 1,
> @@ -7259,6 +7306,7 @@ static int igc_probe(struct pci_dev *pdev,
>   	 * known good starting state
>   	 */
>   	hw->mac.ops.reset_hw(hw);
> +	igc_wait_for_lmvp_mac_passthrough(pdev, hw);
>   
>   	if (igc_get_flash_presence_i225(hw)) {
>   		if (hw->nvm.ops.validate(hw) < 0) {


Kind regards,

Paul

