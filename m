Return-Path: <netdev+bounces-264221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIQZDYA/qWnK3QAAu9opvQ
	(envelope-from <netdev+bounces-264221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:32:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9593820D7D5
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E60EF300AB3D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8A30EF7E;
	Thu,  5 Mar 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XcYAexqa"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6E288514
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699509; cv=none; b=q8SCPe8Ly6tASV8hcdM4MFgGalRP8ITGx3zxEhk5++ClYPKQYisR/A98TDtPIPf0Bt75aAxpkQq0YWRwAFl27EVJ885DvFkoWkSSXKHQYWjnz0hlkA/kZnFii/AtsizVgIrKr63Tv1CvYRogX0LV3dzegvBIixUPNVTNGdR2R/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699509; c=relaxed/simple;
	bh=5+PlJJMPZ01x4qhZ6DWfcD7AXC6l2dIoTVqF0OGJTYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UbS4PRklRfHpu0aWcIfmYSLATugcJfx1SjihV0T0itVAGU4z/ZfCc8S2TQqHns0xoyVMfJ7sHX10HLBpA2i0EuGDwiB4UrPEDdPtg2vzG0JC1r89GTnQqu4X6odVKWm4SdEQjICMqrGJzNSPvuUna2JvUJEo2TnNItM10rvTX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XcYAexqa; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260305083138euoutp01d6e0936816b6155743235c0c9297e3a4~Z5M03gVz41133511335euoutp01j
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 08:31:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260305083138euoutp01d6e0936816b6155743235c0c9297e3a4~Z5M03gVz41133511335euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772699498;
	bh=v7F1z746S5jKq3OMET0fWLruAhJ0LQTk08cIJ/i5TEU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XcYAexqafDCu8WqbE2PsmLHF97TAlqYY6oeG7fvljTlwMvgKnsWxnKDORsSFsfliK
	 G7hYH0pol2rF/Vb79dV1fguUIU4TKFvIYD+MEqvaU5mV6tLffdxMdDBKS3Lq8ZcNId
	 ji3qfEf73moCuGh+OSacjeBH2Qmc+Bhn8kFgO2TE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260305083138eucas1p19943c4dec735b06f536525de26252f03~Z5M0nRDVP0267702677eucas1p1v;
	Thu,  5 Mar 2026 08:31:38 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260305083137eusmtip2f9125fbc0b8da7f324d26a91ccd0cdac~Z5M0K2OZU1523515235eusmtip2h;
	Thu,  5 Mar 2026 08:31:37 +0000 (GMT)
Message-ID: <9433de15-8675-4645-a6aa-85458e833d2d@samsung.com>
Date: Thu, 5 Mar 2026 09:31:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH net-next 8/8] net: phy: improve mdiobus_stats_acct
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Russell King - ARM Linux
	<linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <2ceeb542-986a-404e-ad0f-62e0a938ce7c@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260305083138eucas1p19943c4dec735b06f536525de26252f03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260305083138eucas1p19943c4dec735b06f536525de26252f03
X-EPHeader: CA
X-CMS-RootMailID: 20260305083138eucas1p19943c4dec735b06f536525de26252f03
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
	<2ceeb542-986a-404e-ad0f-62e0a938ce7c@gmail.com>
	<CGME20260305083138eucas1p19943c4dec735b06f536525de26252f03@eucas1p1.samsung.com>
X-Rspamd-Queue-Id: 9593820D7D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-264221-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,redhat.com,google.com,davemloft.net,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:dkim,samsung.com:mid]
X-Rspamd-Action: no action

On 27.02.2026 23:11, Heiner Kallweit wrote:
> - Remove duplicated preempt disable. Disabling preemption has been added
>    to functions like u64_stats_update_begin() in the meantime.
> - Simplify branch structure
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

This patch has been merged to yesterday's linux-next as commit 
1afccc5a201e ("net: phy: improve mdiobus_stats_acct"). In my tests I 
found that it introduces the following warning on 32bit machines with 
USB ethernet adapters, so the preempt disable was there for a good reason:

------------[ cut here ]------------
WARNING: ./include/linux/u64_stats_sync.h:171 at 
mdiobus_stats_acct+0x288/0x2b4, CPU#0: kworker/0:3/50
Loading compiled-in X.509 certificates
Modules linked in:
CPU: 0 UID: 0 PID: 50 Comm: kworker/0:3 Not tainted 
7.0.0-rc2-next-20260304 #12283 PREEMPT
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: usb_hub_wq hub_event
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from __warn+0x94/0x210
  __warn from warn_slowpath_fmt+0x1b0/0x1bc
  warn_slowpath_fmt from mdiobus_stats_acct+0x288/0x2b4
  mdiobus_stats_acct from __mdiobus_read+0x84/0xf0
  __mdiobus_read from mdiobus_read+0x30/0x44
  mdiobus_read from get_phy_device+0xac/0x140
  get_phy_device from mdiobus_scan+0x24/0x104
  mdiobus_scan from __mdiobus_register+0x21c/0x478
  __mdiobus_register from smsc95xx_bind+0x3f4/0x5f0
  smsc95xx_bind from usbnet_probe+0x330/0x928
  usbnet_probe from usb_probe_interface+0xec/0x318
  usb_probe_interface from really_probe+0xe0/0x424
  really_probe from __driver_probe_device+0x9c/0x1f4
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __device_attach_driver+0xa8/0x140
  __device_attach_driver from bus_for_each_drv+0x84/0xdc
  bus_for_each_drv from __device_attach+0xb0/0x214
  __device_attach from device_initial_probe+0x3c/0x48
  device_initial_probe from bus_probe_device+0x24/0x80
  bus_probe_device from device_add+0x5c0/0x810
  device_add from usb_set_configuration+0x4e4/0x974
  usb_set_configuration from usb_generic_driver_probe+0x3c/0x78
  usb_generic_driver_probe from usb_probe_device+0x4c/0x14c
  usb_probe_device from really_probe+0xe0/0x424
  really_probe from __driver_probe_device+0x9c/0x1f4
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __device_attach_driver+0xa8/0x140
  __device_attach_driver from bus_for_each_drv+0x84/0xdc
  bus_for_each_drv from __device_attach+0xb0/0x214
  __device_attach from device_initial_probe+0x3c/0x48
  device_initial_probe from bus_probe_device+0x24/0x80
  bus_probe_device from device_add+0x5c0/0x810
  device_add from usb_new_device+0x23c/0x4f8
  usb_new_device from hub_event+0x11dc/0x1ca4
  hub_event from process_one_work+0x24c/0x7b8
  process_one_work from worker_thread+0x1b8/0x3bc
  worker_thread from kthread+0x128/0x168
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0a15fb0 to 0xf0a15ff8)
...
irq event stamp: 5711
hardirqs last  enabled at (5911): [<c01c6c54>] 
console_flush_one_record+0x424/0x570
hardirqs last disabled at (5943): [<c013ce4c>] handle_softirqs+0x53c/0x5c0
softirqs last  enabled at (5944): [<c013cc3c>] handle_softirqs+0x32c/0x5c0
softirqs last disabled at (6157): [<c013d07c>] __irq_exit_rcu+0x144/0x1f0
---[ end trace 0000000000000000 ]---


> ---
>   drivers/net/phy/mdio_bus.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 48c0447e6a8..b32a369cd25 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -358,22 +358,17 @@ EXPORT_SYMBOL(of_mdio_find_bus);
>   
>   static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
>   {
> -	preempt_disable();
>   	u64_stats_update_begin(&stats->syncp);
>   
>   	u64_stats_inc(&stats->transfers);
> -	if (ret < 0) {
> +	if (ret < 0)
>   		u64_stats_inc(&stats->errors);
> -		goto out;
> -	}
> -
> -	if (op)
> +	else if (op)
>   		u64_stats_inc(&stats->reads);
>   	else
>   		u64_stats_inc(&stats->writes);
> -out:
> +
>   	u64_stats_update_end(&stats->syncp);
> -	preempt_enable();
>   }
>   
>   /**

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


