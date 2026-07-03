Return-Path: <netdev+bounces-304614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q5jvBvbnR2qchQAAu9opvQ
	(envelope-from <netdev+bounces-304614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:48:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C73370468D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:48:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="E/Ol+7ZL";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304614-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304614-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36096305BB55
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0057430AAA6;
	Fri,  3 Jul 2026 16:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6CD2E2DF2
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:42:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096979; cv=none; b=YfqaooCJ+BWdL8bUQL0gnFq3OVwdJ6+bNb5fWHX2CsuJo/EdtTV9g9FzZsfWhgO+1jvk8VJ447n/hfk25TyJQNNIBkQpqosjZlIwd6e0TpianK/rZx90QRTuxD1HL9HcBaCwxhojDlMShCmgi0XLrwF45Xves4fFYbKqnPVHKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096979; c=relaxed/simple;
	bh=LrO73FNsEp8JEgdsFcET9E6lQ82u0824/9f8DOWEEjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V62hJb7leWtdUFAUCScT/S+jumZP7atnKgNfw5g3xJ3Fwuc1lLWVWxU6bn5u5eZRRjAFi3ss9tKYJkU5sUR8xDuiUcLDeZ7rFz4vXrRvfaRp4and4JHhmxDrwtngV9NcazcfOVEC2/0QHk+XHDiTkdYqPjXGb93c6bNfNthV8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/Ol+7ZL; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783096976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RRtTWI8es+DNvxOnoS2/+a0IeV54OfACZzUtphWt54=;
	b=E/Ol+7ZLPEKS7aHP8AZUxr6sdQxlofDpkDvbqkAdBf6dETSh4KwWUtu8i0l3l0JVLsuJvD
	bz8IRDbKZbJ2xLU6oXsWHX+1sCYb0I38Tjetq1B/mnWAZPVEAtg4pr+usQ1a0jOvkFgni3
	TRUJdfhOtOliZ6UMDK9jClNNt/4tkis=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-nsZovw73Op2bqhGVfJ9nbA-1; Fri,
 03 Jul 2026 12:42:53 -0400
X-MC-Unique: nsZovw73Op2bqhGVfJ9nbA-1
X-Mimecast-MFC-AGG-ID: nsZovw73Op2bqhGVfJ9nbA_1783096971
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EB9218908DC;
	Fri,  3 Jul 2026 16:42:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.68])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 689621944B04;
	Fri,  3 Jul 2026 16:42:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v7 2/2] dinghai: add hardware register access and PCI capability scanning
Date: Fri,  3 Jul 2026 18:42:43 +0200
Message-ID: <20260703164243.336173-1-pabeni@redhat.com>
In-Reply-To: <20260630111532964R8a8-5zlzQRMas-VWfCi2@zte.com.cn>
References: <20260630111532964R8a8-5zlzQRMas-VWfCi2@zte.com.cn>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304614-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:han.junyang@zte.com.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C73370468D

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
dinghai: add hardware register access and PCI capability scanning

Implement PCI configuration space access, BAR mapping, capability
scanning (common/notify/device), and hardware queue register
definitions for DingHai PF device.

> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
> index b492fd2c261b8..fb80b0baca34d 100644
> --- a/drivers/net/ethernet/zte/dinghai/en_pf.c
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.c

[ ... ]

> @@ -104,6 +105,443 @@ void dh_pf_pci_close(struct dh_core_dev *dev)

[ ... ]

> +void __iomem *zxdh_pf_map_capability(struct dh_core_dev *dh_dev, int off,
> +				     size_t minlen, u32 align,
> +				     u32 start, u32 size,
> +				     size_t *len, resource_size_t *pa,
> +				     u32 *bar_off)
> +{

[ ... ]

> +	if (length > size)
> +		length = size;
> +
> +	if (len)
> +		*len = length;
> +
> +	if (minlen + offset < minlen ||
> +	    minlen + offset > pci_resource_len(pdev, bar)) {

[Severity: High]
Does this code inflate the length returned in *len?

Because length is not capped by pci_resource_len(pdev, bar) - offset before 
being assigned to *len, the returned length can be larger than the actually 
mapped memory (which is capped by pci_iomap_range).

Later in zxdh_pf_map_vq_notify(), this inflated notify_len is used for bounds 
checking, which could allow out-of-bounds MMIO accesses to pass the check.

[ ... ]

> +int zxdh_pf_device_cfg_init(struct dh_core_dev *dh_dev)
> +{
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +	struct pci_dev *pdev = dh_dev->pdev;
> +	int device;
> +
> +	/* Device capability is only mandatory for
> +	 * devices that have device-specific configuration.
> +	 */
> +	device = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_DEVICE_CFG,
> +					     IORESOURCE_IO | IORESOURCE_MEM,
> +					     &pf_dev->modern_bars);
> +
> +	/* we don't know how much we should map,
> +	 * but PAGE_SIZE is more than enough for all existing devices.
> +	 */
> +	if (device) {
> +		pf_dev->device = zxdh_pf_map_capability(dh_dev, device, 0,
> +							ZXDH_PF_ALIGN4, 0, PAGE_SIZE,
> +						       &pf_dev->device_len, NULL,
> +						       &pf_dev->dev_cfg_bar_off);
> +		if (!pf_dev->device) {

[Severity: High]
Could pf_dev->device remain NULL if the device capability isn't found?

If the capability is optional and not provided, pf_dev->device will be NULL. 
Also, passing minlen = 0 allows undersized mappings. 

Later, zxdh_get_mac() and zxdh_set_mac() unconditionally dereference 
pf_dev->device, which could trigger a kernel panic due to a NULL pointer 
dereference or out-of-bounds access.

[ ... ]

> +void __iomem *zxdh_pf_map_vq_notify(struct dh_core_dev *dh_dev,
> +				    u16 phy_index, u16 index,
> +				     resource_size_t *pa)
> +{
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +	u16 off;
> +
> +	off = zxdh_pf_get_queue_notify_off(dh_dev, phy_index, index);
> +
> +	if (pf_dev->notify_base) {

[ ... ]

> +	} else {
> +		return zxdh_pf_map_capability(dh_dev, pf_dev->notify_map_cap, 2, 2,
> +					      off * pf_dev->notify_offset_multiplier,
> +					      2, NULL, pa, NULL);
> +	}
> +}

[Severity: Medium]
Can the offset calculation overflow before being passed?

Since off is u16 and pf_dev->notify_offset_multiplier is u32, 
off * pf_dev->notify_offset_multiplier evaluates as a 32-bit unsigned integer. 

If the product exceeds 4GB, it wraps around before being passed to 
zxdh_pf_map_capability(). A 64-bit cast is needed to prevent mapping incorrect 
device registers.

[ ... ]

> +void zxdh_pf_get_vf_mac(struct dh_core_dev *dh_dev, u8 *mac, int vf_id)
> +{
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +	u32 DEV_MAC_L;
> +	u16 DEV_MAC_H;
> +
> +	if (pf_dev->pf_sriov_cap_base) {
> +		DEV_MAC_L = ioread32(pf_dev->pf_sriov_cap_base +
> +				     (pf_dev->sriov_bar_size) * vf_id +
> +				     pf_dev->dev_cfg_bar_off);
> +		mac[0] = DEV_MAC_L & 0xff;
> +		mac[1] = (DEV_MAC_L >> 8) & 0xff;
> +		mac[2] = (DEV_MAC_L >> 16) & 0xff;
> +		mac[3] = (DEV_MAC_L >> 24) & 0xff;
> +		DEV_MAC_H = ioread16(pf_dev->pf_sriov_cap_base +
> +				      (pf_dev->sriov_bar_size) * vf_id +
> +				      pf_dev->dev_cfg_bar_off +
> +				      ZXDH_DEV_MAC_HIGH_OFFSET);
> +		mac[4] = DEV_MAC_H & 0xff;
> +		mac[5] = (DEV_MAC_H >> 8) & 0xff;
> +	}
> +}

[Severity: High]
Does this code silently return without initializing the buffer?

If pf_dev->pf_sriov_cap_base is NULL, the function exits without modifying the 
output mac buffer or returning an error code. 

The caller might proceed using the uninitialized contents of the array, which 
could expose uninitialized kernel stack bytes.

[ ... ]

> +void zxdh_set_mac(struct dh_core_dev *dh_dev, u8 *mac)
> +{
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +	u32 DEV_MAC_L;
> +	u16 DEV_MAC_H;
> +
> +	DEV_MAC_L = mac[0] | (mac[1] << 8) | (mac[2] << 16) | (mac[3] << 24);
> +	DEV_MAC_H = mac[4] | (mac[5] << 8);
> +	iowrite32(DEV_MAC_L, pf_dev->device);
> +	iowrite16(DEV_MAC_H, pf_dev->device + ZXDH_DEV_MAC_HIGH_OFFSET);
> +}
> +
> +void zxdh_get_mac(struct dh_core_dev *dh_dev, u8 *mac)
> +{
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +	u32 DEV_MAC_L;
> +	u16 DEV_MAC_H;
> +
> +	DEV_MAC_L = ioread32(pf_dev->device);
> +	mac[0] = DEV_MAC_L & 0xff;
> +	mac[1] = (DEV_MAC_L >> 8) & 0xff;
> +	mac[2] = (DEV_MAC_L >> 16) & 0xff;
> +	mac[3] = (DEV_MAC_L >> 24) & 0xff;
> +	DEV_MAC_H = ioread16(pf_dev->device + ZXDH_DEV_MAC_HIGH_OFFSET);
> +	mac[4] = DEV_MAC_H & 0xff;
> +	mac[5] = (DEV_MAC_H >> 8) & 0xff;
> +}

[Severity: High]
Can these functions trigger a NULL pointer dereference?

In zxdh_pf_device_cfg_init(), pf_dev->device can be left as NULL if the device 
capability is missing, or it could be undersized. 

zxdh_set_mac() and zxdh_get_mac() unconditionally dereference pf_dev->device, 
which could trigger a kernel panic.
-- 
This is an AI-generated review.


