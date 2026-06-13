Return-Path: <netdev+bounces-298936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VNZwF4EiLWr5cAQAu9opvQ
	(envelope-from <netdev+bounces-298936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:27:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C095867E3A5
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:27:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LsB75swd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298936-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298936-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459DF308552A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177638F25E;
	Sat, 13 Jun 2026 09:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7E3368AB
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 09:27:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781342835; cv=none; b=Jwh1vyim47hwRflatKQIb6y2WtYSRmIr1EMMTdq4T6gN2opBQkqx/G7GERHfMTOpacZUJ4PJcrxCpNb3jUnDGJIWdRHkUp1K/3ZccVg3PGhSx90yp/qmXmwP6ZE0Rxp2+GP32eIEpTt3UUmWpMCU6eMw2tAzgtFN8sVcd247+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781342835; c=relaxed/simple;
	bh=a2Z6Ady4K0H23tACMTBtTlfiHsqAoRQkWObnL6Grihw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orLEHKKyoph8DWEZpFRAV0DNOLTsrf00dFQnJumVnPIjipt3y8bM7BY7jESwtW6SoUpLT2io02r/6raeQJayhwIKmc4JI56BS5q0dkSzFceMxknv0WTjG3DIQzJXxr3oZprYfSE2BOEjrcex8dVzkGvowagAd7hJVgVoAeqxFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsB75swd; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781342832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ+pUo5K2YdLgPNo6Ciwj2KiVz343QZRMZTnIquFAlY=;
	b=LsB75swdcxve+5jkw2rrBdlBppWM5hEqZQDfFN7MidWcyxt5ozU1HhbCzf0smz7G/fMUdb
	wwNIx7l2LRZrKNcbVdSs5aAijIplh1UO3cpK/iQX2LXH9lgTYInjyJe3RkSm0CjcTCPnRZ
	RHMP1fTHvr7hy3iJNrzQaS6UFOWEzRc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-O2T34K-6O1qeQKGd4YhaOQ-1; Sat,
 13 Jun 2026 05:27:08 -0400
X-MC-Unique: O2T34K-6O1qeQKGd4YhaOQ-1
X-Mimecast-MFC-AGG-ID: O2T34K-6O1qeQKGd4YhaOQ_1781342825
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07B6519560B6;
	Sat, 13 Jun 2026 09:27:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.22.88.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1ACE51955BC2;
	Sat, 13 Jun 2026 09:26:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: ciprian.regus@analog.com
Cc: parthiban.veerasooran@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 13/13] net: ethernet: adi: Add a driver for the ADIN1140 MACPHY
Date: Sat, 13 Jun 2026 11:26:45 +0200
Message-ID: <20260613092645.123432-1-pabeni@redhat.com>
In-Reply-To: <20260609-adin1140-driver-v4-13-0753e28ee004@analog.com>
References: <20260609-adin1140-driver-v4-13-0753e28ee004@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298936-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ciprian.regus@analog.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,analog.com:url,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C095867E3A5

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: ethernet: adi: Add a driver for the ADIN1140 MACPHY

This patch adds a driver for the ADIN1140 10BASE-T1S MAC-PHY which talks
to the host over SPI using the OA TC6 protocol. It introduces a custom
mii_bus to work around two hardware issues, and exposes both rtnl link
stats and ethtool MAC stats from periodically polled hardware counters.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50f795dfa880..c3cab8f7b9ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1858,6 +1858,14 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/dma/dma-axi-dmac.c
>  
> +ANALOG DEVICES INC ETHERNET DRIVERS
> +M:	Ciprian Regus <ciprian.regus@analog.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/net/adi,ad3306.yaml
> +F:	drivers/net/ethernet/adi/adin1140.c

[Medium]
The MAINTAINERS entry references
Documentation/devicetree/bindings/net/adi,ad3306.yaml, but that file is
not added by this patch and does not appear elsewhere in the tree.

The driver also introduces two new of compatibles:

	{ .compatible = "adi,ad3306" },
	{ .compatible = "adi,adin1140" },

with no YAML schema. Should the binding document be added in this same
series so that the F: line resolves and dt_binding_check can validate
the new compatibles?

> diff --git a/drivers/net/ethernet/adi/adin1140.c b/drivers/net/ethernet/adi/adin1140.c
> new file mode 100644
> index 000000000000..306e5de6faa5
> --- /dev/null
> +++ b/drivers/net/ethernet/adi/adin1140.c

[ ... ]

> +static int adin1140_mac_filter_set(struct adin1140_priv *priv,
> +				   const u8 *addr, const u8 *mask,
> +				   u8 slot)
> +{
> +	u32 reg_address;
> +	u32 val;
> +	int ret;
> +
> +	if (slot >= ADIN1140_MAC_FILT_MAX_SLOT)
> +		return -ENOSPC;
> +
> +	reg_address = ADIN1140_MAC_ADDR_FILT_UPR_REG + 2 * slot;
> +
> +	ret = oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
> +					reg_address,
> +					get_unaligned_be16(&addr[0]) |
> +					ADIN1140_MAC_ADDR_FILT_APPLY2PORT1 |
> +					ADIN1140_MAC_ADDR_FILT_TO_HOST);
> +	if (ret)
> +		return ret;
> +
> +	reg_address = ADIN1140_MAC_ADDR_FILT_LWR_REG + 2 * slot;
> +	ret = oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
> +					reg_address,
> +					get_unaligned_be32(&addr[2]));
> +	if (ret)
> +		return ret;
> +
> +	/* Only the first 2 destination MAC filter slots support masking.
> +	 * For the other entries, the destination address in the received
> +	 * frame must match exactly.
> +	 */
> +	if (slot >= ADIN1140_MAC_FILT_MASK_LIMIT)
> +		return 0;
> +
> +	val = get_unaligned_be16(&mask[0]);
> +	reg_address = ADIN1140_MAC_ADDR_MASK_UPR_REG + (2 * slot);
> +
> +	ret = oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
> +					reg_address, val);
> +	if (ret)
> +		return ret;
> +
> +	val = get_unaligned_be32(&mask[2]);
> +	reg_address = ADIN1140_MAC_ADDR_MASK_LWR_REG + (2 * slot);
> +
> +	return oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
> +					 reg_address, val);
> +}

[Medium]
adin1140_mac_filter_set() performs up to four sequential
oa_tc6_write_register_mms() calls (filter upper, filter lower, mask
upper, mask lower) and returns at the first error without rolling back
the writes that already succeeded.

If the upper-half write of a new MAC succeeds and the lower-half write
fails, the slot is left programmed with (new high | old low). Callers
treat this as single-shot:

	ret = adin1140_mac_filter_set(priv, address->sa_data, mask,
				      ADIN1140_MAC_FILT_UC_SLOT);
	if (ret)
		return ret;

	eth_commit_mac_addr_change(netdev, addr);

so adin1140_set_mac_address() leaves netdev->dev_addr at the old value
while the hardware filter now matches a third, hybrid address. The same
applies to adin1140_rx_mode_work() which just returns on the first
error and leaves the dynamic filter table inconsistent with
netdev->uc/mc.

Should this function stage the writes (or perform a rollback / clear of
the affected slot) so a partial failure cannot leave the hardware
filter in a state that does not match the driver's view?

[ ... ]

> +static void adin1140_rx_mode_work(struct work_struct *work)
> +{
> +	struct adin1140_priv *priv = container_of(work, struct adin1140_priv,
> +						  rx_mode_work);
> +	struct netdev_hw_addr *ha;
> +	bool all_multi, promisc;
> +	u8 mask[ETH_ALEN];
> +	u8 start, end;
> +	u32 mac_addrs;
> +	u8 slot, i;
> +	int ret;
> +
> +	/* The ADIN1140 has 16 dest MAC address filter slots:
> +	 * 0 - reserved for all multicast filter.
> +	 * 1 - reserved for broadcast filter.
> +	 * 2 - reserved for the device's own unicast MAC.
> +	 * 3 -> 15 - available for other unicast/multicast filters.
> +	 */
> +
> +	mac_addrs = netdev_uc_count(priv->netdev) +
> +		    netdev_mc_count(priv->netdev);
> +
> +	if (priv->netdev->flags & IFF_PROMISC) {
> +		promisc = true;
> +		all_multi = false;
> +	} else if (priv->netdev->flags & IFF_ALLMULTI) {
> +		promisc = false;
> +		all_multi = true;
> +	} else if (mac_addrs <= ADIN1140_MAC_FILT_AVAIL) {
> +		promisc = false;
> +		all_multi = false;
> +
> +		slot = ADIN1140_MAC_FILT_UC_SLOT + 1;
> +		memset(mask, 0xFF, ETH_ALEN);
> +
> +		netdev_for_each_uc_addr(ha, priv->netdev) {
> +			ret = adin1140_mac_filter_set(priv, ha->addr, mask,
> +						      slot);
> +			if (ret)
> +				return;
> +
> +			slot++;
> +		}
> +
> +		netdev_for_each_mc_addr(ha, priv->netdev) {
> +			ret = adin1140_mac_filter_set(priv, ha->addr, mask,
> +						      slot);
> +			if (ret)
> +				return;
> +
> +			slot++;
> +		}
> +
> +		for (i = slot; i < ADIN1140_MAC_FILT_MAX_SLOT; i++) {
> +			ret = adin1140_mac_filter_clear(priv, i);
> +			if (ret)
> +				return;
> +		}
> +
> +	} else {
> +		/* The filter table is full. Enable promisc mode. */
> +		promisc = true;
> +		all_multi = false;
> +
> +		start = ADIN1140_MAC_FILT_UC_SLOT + 1;
> +		end = ADIN1140_MAC_FILT_MAX_SLOT;
> +		for (i = start; i < end; i++) {
> +			ret = adin1140_mac_filter_clear(priv, i);
> +			if (ret)
> +				return;
> +		}
> +	}
> +
> +	ret = adin1140_promiscuous_mode(priv, promisc);
> +	if (ret)
> +		return;
> +
> +	adin1140_filter_all_multicast(priv, all_multi);
> +}

[High]
This work iterates priv->netdev->uc and ->mc with no synchronization:

	netdev_for_each_uc_addr(ha, priv->netdev) {
		ret = adin1140_mac_filter_set(priv, ha->addr, mask, slot);
		...
	}

	netdev_for_each_mc_addr(ha, priv->netdev) {
		...
	}

netdev_for_each_uc_addr() and netdev_for_each_mc_addr() expand to
plain list_for_each_entry() over dev->uc.list / dev->mc.list. Callers
are required to hold netif_addr_lock_bh() (or rtnl) because dev_uc_add
/ dev_uc_del / dev_mc_add / dev_mc_del can mutate those lists from
user-space ip address/maddr changes.

Inside the loop ha->addr is then handed to adin1140_mac_filter_set(),
which performs SPI register writes that can sleep, so taking
netif_addr_lock_bh() across the iteration is not directly viable.

Can this race with a concurrent dev_uc_del() / dev_mc_del() and
dereference freed list entries (or skip / duplicate filter slots)?
Other ethernet drivers that need to issue sleeping ops while syncing
the address lists use __dev_uc_sync() / __dev_mc_sync() which copy
state under netif_addr_lock; would that pattern be more appropriate
here?

[Medium]
In the IFF_PROMISC and IFF_ALLMULTI branches, slots 3..15 are not
cleared:

	if (priv->netdev->flags & IFF_PROMISC) {
		promisc = true;
		all_multi = false;
	} else if (priv->netdev->flags & IFF_ALLMULTI) {
		promisc = false;
		all_multi = true;
	} else if (mac_addrs <= ADIN1140_MAC_FILT_AVAIL) {
		...
		for (i = slot; i < ADIN1140_MAC_FILT_MAX_SLOT; i++) {
			ret = adin1140_mac_filter_clear(priv, i);
			...
		}
	} else {
		...
		for (i = start; i < end; i++) {
			ret = adin1140_mac_filter_clear(priv, i);
			...
		}
	}

If a previous invocation populated slots 3..N with extra unicast or
multicast filters and the user then enables IFF_ALLMULTI, those
previously installed unicast filters remain active in hardware
(carrying APPLY2PORT1 | TO_HOST). Should the IFF_ALLMULTI path also
clear slots 3..15 so traffic for addresses no longer in netdev->uc/mc
is not still forwarded to the host?

[ ... ]

> +static void adin1140_stats_work(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	u64 stat_buff[ADIN1140_STATS_CNT] = {};
> +	struct adin1140_priv *priv;
> +	u32 reg_val;
> +	int ret;
> +	u32 i;
> +
> +	priv = container_of(dwork, struct adin1140_priv, stats_work);
> +
> +	for (i = 0; i < ARRAY_SIZE(adin1140_stat_regs); i++) {
> +		ret = oa_tc6_read_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
> +					       adin1140_stat_regs[i],
> +					       &reg_val);
> +		if (ret)
> +			break;
> +
> +		stat_buff[i] = reg_val;
> +	}
> +
> +	scoped_guard(spinlock, &priv->stat_lock)
> +		memcpy(&priv->stats, stat_buff, sizeof(priv->stats));
> +
> +	schedule_delayed_work(dwork, ADIN1140_STATS_CHECK_DELAY);
> +}

[Medium]
stat_buff is zero-initialized and the loop break on a read error is
followed unconditionally by:

	scoped_guard(spinlock, &priv->stat_lock)
		memcpy(&priv->stats, stat_buff, sizeof(priv->stats));

If oa_tc6_read_register_mms() fails partway through, every entry from
the failing index onwards is still zero, and that all-zero tail is
copied over the previously valid u64 counters. Since priv->stats[] is
read directly by adin1140_ndo_get_stats64(),
adin1140_get_eth_mac_stats() and adin1140_get_ethtool_stats(), a
single transient SPI/TC6 hiccup makes the rtnl_link_stats64 and
ethtool_eth_mac_stats counters drop to zero before climbing again.
Should the memcpy be skipped on error, or should partial updates be
merged into priv->stats[] only for the indices that were read
successfully?

[Medium]
The hardware counters at MMS1 0xA1..0xBA are read into u32 reg_val and
then stored as-is into the u64 stat_buff[i]:

	ret = oa_tc6_read_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
				       adin1140_stat_regs[i],
				       &reg_val);
	...
	stat_buff[i] = reg_val;

priv->stats[] feeds rtnl_link_stats64 and ethtool_eth_mac_stats, both
of which document monotonic u64 counters. On 32-bit hardware register
wrap (0xFFFFFFFF -> 0) the user-visible u64 value will go backwards,
and with a 3-second poll interval a fast counter (e.g.
FramesReceivedOK on a busy 10BASE-T1S segment) can wrap entirely
between samples. Should the driver compute deltas with 32-bit wrap
handling and accumulate them into a software u64 counter rather than
overwriting?

[ ... ]

> +static void adin1140_get_ethtool_stats(struct net_device *netdev,
> +				       struct ethtool_stats *stats, u64 *data)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +	u32 i;
> +
> +	scoped_guard(spinlock, &priv->stat_lock) {
> +		for (i = 0; i < ARRAY_SIZE(adin1140_stats); i++)
> +			data[i] = priv->stats[adin1140_stats[i].idx];
> +	}
> +}
> +
> +static void adin1140_get_ethtool_strings(struct net_device *netdev, u32 sset,
> +					 u8 *p)
> +{
> +	u32 i;
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		for (i = 0; i < ARRAY_SIZE(adin1140_stats); i++)
> +			ethtool_puts(&p, adin1140_stats[i].name);
> +
> +		break;
> +	}
> +}

[Medium]
The driver implements both .ndo_get_stats64 and .get_eth_mac_stats,
yet adin1140_stats[] adds private ethtool -S strings whose values are
already exposed (or trivially derivable) through those standard uAPIs:

	{.name = "rx_unicast_frames", .idx = rx_uc_frames},
	{.name = "rx_preamble_errors", .idx = rx_preamble_errors},
	{.name = "rx_ifg_errors", .idx = rx_ifg_errors},
	{.name = "rx_addr_filter_dropped", .idx = rx_addr_filter_dropped},
	{.name = "tx_unicast_frames", .idx = tx_uc_frames},

rx_addr_filter_dropped is already aggregated into
rtnl_link_stats64.rx_dropped by this same driver:

	storage->rx_dropped = priv->stats[rx_fifo_full_dropped] +
			      priv->stats[rx_addr_filter_dropped];

rx_unicast_frames and tx_unicast_frames are derivable from
ethtool_eth_mac_stats (FramesReceivedOK minus broadcast minus
multicast, and the Xmitted equivalents) which are populated in
__adin1140_eth_mac_stats.

Per Documentation/networking/statistics.rst, should these counters be
left out of ethtool -S since standard uAPIs already cover them?
-- 
This is an AI-generated review.


