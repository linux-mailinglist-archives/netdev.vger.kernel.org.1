Return-Path: <netdev+bounces-295189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wsxWNH1hIWrBFQEAu9opvQ
	(envelope-from <netdev+bounces-295189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:29:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F239C63F6C9
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:29:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295189-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295189-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6381300B061
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9535EDBD;
	Thu,  4 Jun 2026 11:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA763976AD
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:28:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572491; cv=none; b=XQsPNIQQu+5I4IWBneyb2mqsE5d6tUGQCKSiwIv1SEGYH/WgrjqvsVodvSejIYGxdDpZ3Y6QTwXE4GVz8aA586uG+C1gPzK2YbemmGO5z7rUC7CAQa9Z9MjWJa7TJhK1kDnJOlsOH2hTi765cQdt64PN/1l6pFj/qH7f7RrLpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572491; c=relaxed/simple;
	bh=+wJr1c9etthmDHnG+V/RFg87Yn4SnxMxT9zZOUhYCgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D1kKwimi7I9hsFnHQiZVPL+zZjQKwzqCkhFgb5jK/b4vrw4QmhByLXzk9SJKGPQhHDNDpGZ0D7qq9eL3VrLg6pLYRNeFsVZNy9HiPDrxtHdhf+GRf70n6d3A5dxLX+w3v5nif2u5BIO6ahtzpqtLfHuk3h1u6rgnRqhh2MiH4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
X-QQ-mid: zesmtpgz8t1780572479t9c5e5ebf
X-QQ-Originating-IP: nZD3A13UevUf0tyW1WE+VpUAXPhIj4ecYttoQ4wGmIs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 19:27:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2139578684678422659
EX-QQ-RecipientCnt: 13
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v6 0/4] net: rnpgbe: Add TX/RX and link status support
Date: Thu,  4 Jun 2026 19:27:46 +0800
Message-Id: <20260604112750.769215-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N62ltAQ19hpBvekPX2vk+73UmU7MI/hfo3FJYUq+FuccCsCf/eKHFT4u
	SvFyzCjDoDJaHB+Cr8uYg9wNSwMP3y+JDj0hhYbcME0jMi0MZnDHS4kW/VLwwLHGC485PON
	gaCitpKGN5jXuA5tmXmC3xN8Ye02hbjJg5rFgd9TgHPct7JOcgI/wgD/QjzuOBzrhDVrPnW
	Mlsq2RyQlcyvHFFMqD1L+g8Hf9YP8TJ/X0aq/rWon2oMS1L4KlkCEOuvzr3gdK4cx33pJlp
	+y+mOxv3AR83sNjgmDkf5tWW6T2Qsm/gLfyEsTAb9Bigu8pCt2uQkwqSY4IH+ASKuhHJdc3
	W+o+qwRZDteU9mPqm9NF+HEnwRewbrgobObB5YNuvUUvZV43O78rpfOrxbehBfdtFn7q987
	ndylra78vVRiYnKPA3ggxjjOAxQWpqEJEJt+mfRu5IOosbg8sv6+rxWPXJ+IONpZuqBhs6o
	5R5FmQo3x3KEWz3uC0PxoSjVL7fsnr25tUhXQC0lzmdg40+tb9kwGBeED1cyKFnEIBTTGIC
	y4dnlPEaQEm3VViEyY2Dy6vUjnu8iWt+3X0MdylhUJhnVT3oIusvGF+uTE+oHGAfxRc0bSw
	ymuUQnjYTq5rRggpYkp1fbjlcTCtunqPsdNZKn2xccncZBm8VUQtiv3IZFWdKGB8z2PU+AF
	2jdOjgt2P0mAsB9fOUp/7uPC4HLbiIrN4T0mwZ7CwVbkQCwxSq1tDOm3iXnaNudQEO4ohtq
	LCUo4ikKYsL2wuOgJeHi8IvHN0KqRtjaK6rKGjX0dIJ9feAEG0wVnlCjrMS9boCa1KzR7hU
	Kofjk9YKmEU0uNqbzDbR/G38tcOsid8QMqJJU+nfmwSVsD/Y5y0Jh2trL9mNuAmWyWgLSnW
	YUoZk2ugH7sL/nilr+6/7bX8GUWBswtu+b7sXy+WZbUugeCGs1PWdBVX/3YIobfRrzt2EiQ
	h3PEF1JDTnhsgx1prj8jLjLWl/egQz7z6wPLKoRsj9hxtiOkuV6lvKX3O0oBITvZV/6/CGW
	TPD3EKo4w5QabvDWbrrrsU9yrI8Dwy+yNsP+UBh/x0z3cf7C/lLkcQ5eWBEm1yFxNFZqBzr
	Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	TAGGED_FROM(0.00)[bounces-295189-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:vadim.fedorenko@linux.dev,m:horms@kernel.org,m:u.kleine-koenig@baylibre.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:dong100@mucse.com,m:yaojun@mucse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F239C63F6C9

Hi maintainers,

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- Msix/msi interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- Link status monitoring and carrier management

These changes enable the RNPGBE driver to support basic tx/rx
network operations.

Changelog:
v5 -> v6:
[patch 1/4]:
1. Rename remove_mbx_irq to rnpgbe_free_mbx_irq. (Sashiko-nipa)
2. Rename register_mbx_irq to rnpgbe_request_mbx_irq. (Sashiko-nipa)
3. Register rnpgbe_int_single for no_multiple_msix in
   rnpgbe_request_mbx_irq. (Sashiko-gemini)
[patch 2/4]:
1. Use existing helpers for wake and stop tx queue. (Jakub)
2. Use dma_rmb()/dma_wmb(). (Sashiko-nipa)
3. Avoid &NULL[i] in rnpgbe_clean_tx_ring. (Sashiko-nipa)
4. Add quiesce delay after set TX_START 0. (Sashiko-nipa)
5. Add mask (ring->count - 1) for ring->next_to_clean. (Sashiko-nipa) 
6. Remove err define mucse_fw_irq_handler in rnpgbe_lib.h. (Sashiko-nipa)
[patch 3/4]:
1. Remove wmb() in mucse_update_rx_tail. (Sashiko-nipa)
2. Remove dead code in rnpgbe_cleanup_headers. (Sashiko-nipa)
3. Fix spell error. (Sashiko-nipa)
4. Check size range in rx-path. (Sashiko-nipa)
5. Add 'cleaned_count++' when build skb failed. (Sashiko-nipa)
6. Add quiesce delay after set RX_START 0. (Sashiko-nipa)
7. Add mask (ring->count - 1) for ring->next_to_clean. (Sashiko-nipa) 
8. Clean RNPGBE_DMA_AXI_EN in rnpgbe_clean_all_rx_rings. (Sashiko-nipa)
9. Make rnpgbe_free_all_tx_resources and rnpgbe_free_all_rx_resources\
   symmetric. (Sashiko-nipa)
10. Use delay_retry to handle rx alloc failed. (Sashiko-nipa) 
[patch 4/4]:
1. Add clean link state in rnpgbe_up_complete to avoid
   'link state leak'. (Sashiko-nipa)
2. add completion_done check in mucse_mbx_fw_reply_handler to avoid
    splice fields from two different replies. (Sashiko-nipa)
3. Rename rnpgbe_set_rx to rnpgbe_set_link.
4. Fix timeout handle in mucse_fw_send_cmd_wait_resp. (Sashiko-gemini)

links:
---
v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
v3: https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
v4: https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
v5: https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/

Additional Notes:
1.
Sashiko:
>  static int rnpgbe_open(struct net_device *netdev)
>  {
> +     struct mucse *mucse = netdev_priv(netdev);
> +     int err;
> +
> +     err = rnpgbe_request_irq(mucse);
> +     if (err)
> +             return err;
> +
> +     err = netif_set_real_num_queues(netdev, mucse->num_tx_queues,
> +                                     mucse->num_rx_queues);
> +     if (err)
> +             goto err_free_irqs;
> +
> +     rnpgbe_up_complete(mucse);
Could this sequence lead to a queue stall?
If an interrupt arrives immediately after rnpgbe_request_irq(), the handler
will mask the interrupt and call napi_schedule_irqoff(). Since NAPI is not
yet enabled, the scheduling request is silently dropped.
When rnpgbe_up_complete() later enables NAPI, the interrupt remains masked
and the queue stalls. Should NAPI be enabled before requesting the IRQ?

Answer: The sequence is safe because the hardware cannot generate any Rx/Tx or link
interrupts until rnpgbe_up_complete() enables DMA engines and interrupt
sources. There is no race window where an interrupt can arrive before
NAPI is ready. Therefore no stall can occur.

2. 
Sashiko:
> +static bool rnpgbe_cleanup_headers(struct sk_buff *skb)
> +{
> +	if (IS_ERR(skb))
> +		return true;
> +	/* place header in linear portion of buffer */
> +	if (!skb_headlen(skb))
> +		rnpgbe_pull_tail(skb);
> +	/* if eth_skb_pad returns an error the skb was freed */
> +	if (eth_skb_pad(skb))
> +		return true;
> +
> +	return false;
> +}
If the first hardware descriptor provides a size between 1 and 13 bytes,
skb_headlen(skb) will be greater than 0, causing this to skip the
rnpgbe_pull_tail() call.
When eth_type_trans() is called later, it assumes a full 14 byte header and
calls __skb_pull(skb, ETH_HLEN). If the packet spans multiple fragments,
could subtracting 14 from skb->len cause it to drop below skb->data_len,
triggering the BUG_ON in __skb_pull() and crashing the kernel?

Answer:
This issue is not reproducible:
Hardware enforces a minimum packet size of 33 bytes (no 1–13 bytes
descriptor sizes). Multiple descriptors are only used Format
frames >1536(M_DEFAULT_SG is 96) bytes; all small packets use a single
descriptor (no skb fragmentation). Thus the problematic __skb_pull() condition
cannot occur.

3
Sashiko:
> +static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
> +			       struct mucse_ring *rx_ring,
> +			       int budget)
> +{
> +	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> +	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
> +	bool fail_alloc = false;
> +
> +	while (likely(total_rx_packets < budget)) {
> +		struct mucse_rx_buffer *rx_buffer;
> +		union rnpgbe_rx_desc *rx_desc;
> +		struct sk_buff *skb;
> +		unsigned int size;
[ ... ]
> +		/* This memory barrier is needed to keep us from reading
> +		 * any other fields out of the rx_desc until we know the
> +		 * descriptor has been written back
> +		 */
> +		dma_rmb();
> +		size = le16_to_cpu(rx_desc->wb.len);
> +		rx_buffer = rnpgbe_get_buffer(rx_ring, &skb, size);
Is the size value validated against the allocated page size anywhere?
If a hardware device provides an oversized length, such as 65535, could this
cause dma_sync_single_range_for_cpu() to operate out of bounds?
Additionally, since size is passed to rnpgbe_build_skb() which uses
__skb_put(), could this cause skb->tail and skb->len to advance beyond the
allocated linear buffer?

Answer:
Can not happen, hardware splits data into multiple descs with 1536 bytes
(M_DEFAULT_SG is 96) for each desc.

4.
Sashiko:
> +		if (!size)
> +			break;
If size is zero, does this cause an infinite loop? By breaking here, the
driver doesn't advance rx_ring->next_to_clean or clear the descriptor's DD
bit. On subsequent NAPI polls, it will examine the exact same descriptor, see
the DD bit set and size 0, and immediately break again, locking up the CPU in
softirq context.

Answer:
No, an infinite loop cannot occur here.The hardware guarantees that the
descriptor size is always non-zero when writing back the DD (Descriptor Done) bit.

5.
Sashiko:
> +static void rnpgbe_configure_rx_ring(struct mucse *mucse,
> +				     struct mucse_ring *ring)
> +{
[ ... ]
> +	mucse_ring_wr32(ring, RNPGBE_RX_LEN, ring->count);
> +	ring->tail = ring->ring_addr + RNPGBE_RX_TAIL;
> +	ring->next_to_clean = mucse_ring_rd32(ring, RNPGBE_RX_HEAD);
> +	ring->next_to_use = ring->next_to_clean;
Can RNPGBE_RX_HEAD contain a value greater than or equal to ring->count?
If the device register holds an out-of-bounds value, it looks like it will be
directly used as an index into rx_ring->rx_buffer_info[] and by M_RX_DESC(),
causing an out-of-bounds memory access.

Answer:
No out-of-bounds risk:
RNPGBE_RX_HEAD is 0 after hardware reset (always valid).
This is just driver/hardware sync for queue down/up (no full reset).
If ring->count changes, a full reset sets head back to 0.
Head value always stays within valid index rang.

6.
Sashiko:
> +static void mucse_mbx_fw_req_handler(struct mucse_hw *hw,
> +				     struct mbx_fw_cmd_req *req)
> +{
> +	struct mucse *mucse = container_of(hw, struct mucse, hw);
> +	u32 magic = le32_to_cpu(req->link_stat.port_magic);
> +	unsigned long flags;
> +
> +	if (le16_to_cpu(req->opcode) == LINK_CHANGE_EVT) {
> +		spin_lock_irqsave(&mucse->link_lock, flags);
> +
> +		if (le16_to_cpu(req->link_stat.port_status))
> +			hw->link = true;
Does this correctly handle multi-port link events?
        
Since req->link_stat.port_status is a bitmask of changed ports, checking it
as a simple boolean might cause this port to process events meant for other
ports on the same NIC. Additionally, this unconditionally reads from st[0],
which would cause all ports to adopt the speed and duplex of port 0
whenever any port changes state.

Answer:
This driver follows a 1:1 mapping — one PF (Physical Function) corresponds
to exactly one port. The multi-port bitmask (port_status) and multi-port structure
definitions in the firmware command are only for forward compatibility interfacethe
driver-firmware communication interface, to support both multi-port and
single-port designs.

7.
Sashiko:
> +void rnpgbe_set_rx(struct mucse_hw *hw, bool enable)
> +{
> +	u32 value = mucse_hw_rd32(hw, GMAC_CONTROL);
> +
> +	if (enable)
> +		value |= GMAC_CONTROL_RE;
> +	else
> +		value &= ~GMAC_CONTROL_RE;
> +
> +	mucse_hw_wr32(hw, GMAC_CONTROL, value);
> +
> +	value = mucse_hw_rd32(hw, GMAC_FRAME_FILTER);
> +	mucse_hw_wr32(hw, GMAC_FRAME_FILTER, value | BIT(0));
Does this lockless read-modify-write race with standard network operations
like ndo_set_rx_mode?
Answer:
No race here, ndo_set_rx_mode is not added now. Even in the future,
GMAC_FRAME_FILTER will not controlled in ndo_set_rx_mode, hw has other register
to control promiscuous mode.

8.
Sashiko:
> +/**
> + * register_mbx_irq - Register mbx routine
> + * @mucse: pointer to private structure
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int register_mbx_irq(struct mucse *mucse)
> +{
> +	struct pci_dev *pdev = mucse->pdev;
> +	int err = 0;
> +
> +	snprintf(mucse->mbx_name, sizeof(mucse->mbx_name),
> +		 "rnpgbe-mbx:%s", pci_name(pdev));
> +
> +	if (mucse->flags & M_FLAG_MSIX_EN) {
> +		err = request_irq(pci_irq_vector(pdev, 0),
> +				  rnpgbe_msix_other, 0, mucse->mbx_name,
> +				  mucse);
> +	}
> +
> +	return err;
> +}
Is it intentional that register_mbx_irq() only installs a handler when
M_FLAG_MSIX_EN is set?
In MSIX_SINGLE_EN and MSI modes, the mailbox is serviced only through
the multiplexed rnpgbe_int_single() that rnpgbe_open() registers and
rnpgbe_close() tears down. Between the end of probe and the first
open, and again between every close and the next open, there appears
to be no handler attached to the interrupt that firmware can signal
through.
Does that leave a window where a firmware-initiated mailbox interrupt
in those modes has no registered handler?
Combined with the empty body of mucse_fw_irq_handler(), how does this
match the commit message wording:
>     Add comprehensive interrupt handling for the RNPGBE driver:

Answer:
Fw only tirg irq after driver set mucse_fw_link_report_en true (in
rnpgbe_up_complete). So this is not 'no handler attached' contition.

9.
Sashiko:
> +static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
> +{
> +     int v_budget;
> +
> +     v_budget = min_t(int, mucse->num_tx_queues, mucse->num_rx_queues);
> +     v_budget = min_t(int, v_budget, MAX_Q_VECTORS);
> +     v_budget = min_t(int, v_budget, num_online_cpus());
> +     /* add one vector for mbx */
> +     v_budget += 1;
> +     v_budget = pci_alloc_irq_vectors(mucse->pdev, 1, v_budget,
> +                                      PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +     if (v_budget < 0)
> +             return v_budget;
> +
> +     if (mucse->pdev->msix_enabled) {
> +             /* q_vector not include mbx */
> +             if (v_budget > 1) {
> +                     mucse->flags |= M_FLAG_MSIX_EN;
> +                     mucse->num_q_vectors = v_budget - 1;
> +             } else {
> +                     mucse->flags |= M_FLAG_MSIX_SINGLE_EN;
> +                     mucse->num_q_vectors = 1;
> +             }
> +     } else {
> +             /* msi use only 1 irq */
> +             mucse->num_q_vectors = 1;
> +             mucse->flags |= M_FLAG_MSI_EN;
> +     }
> +
> +     return 0;
> +}
If the PCI subsystem allocates multiple MSI vectors because v_budget > 1
and the device supports Multiple Message MSI, does this code leak the
unused vectors? It looks like num_q_vectors is forced to 1 and the
remaining allocated vectors are ignored.
Answer:
Hw only suports 1 msi. MSI mode should falls back to single vector.

10.
Sashiko:
> +static void rnpgbe_configure_rx_ring(struct mucse *mucse,
> +                                  struct mucse_ring *ring)
> +{
> +     struct mucse_hw *hw = &mucse->hw;
> +
> +     /* disable queue to avoid issues while updating state */
> +     mucse_ring_wr32(ring, RNPGBE_RX_START, 0);
[ ... ]
> +     mucse_ring_wr32(ring, RNPGBE_RX_INT_PKTCNT, M_DEFAULT_RX_INT_PKTCNT);
> +     rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring));
> +}
The return value of rnpgbe_alloc_rx_buffers() is discarded here.  If
the very first population fails under memory pressure, the ring is
left partially populated (the remaining descriptors keep the zeroed
contents from dma_alloc_coherent()), and rnpgbe_up_complete() then
writes RNPGBE_RX_START=1 unconditionally.  When hardware walks into
one of those zeroed descriptors, it will DMA an incoming packet to an
invalid address (just fun_id, or 0 if pfvfnum == 0).  Because
rnpgbe_configure_rx() returns void, rnpgbe_open() returns success and
the failure is invisible to callers.  Should the allocation failure
propagate up and unwind RX resources?
Answer:
Cannot happen, hw only start request rx descriptors after driver
update rx_tail(which is only update after desc is write correct with
memory alloc success).

11.
Sashiko:
> +static void rnpgbe_pull_tail(struct sk_buff *skb)
> +{
> +     skb_frag_t *frag = &skb_shinfo(skb)->frags[0];
> +     unsigned int pull_len;
> +     unsigned char *va;
> +
> +     va = skb_frag_address(frag);
> +     pull_len = eth_get_headlen(skb->dev, va, M_RX_HDR_SIZE);
Because rnpgbe_build_skb() places the first descriptor's data into the linear
SKB area, skb_headlen(skb) equals the descriptor's size. This means
rnpgbe_pull_tail() is only called from rnpgbe_cleanup_headers() if size
is 0.
If a 0-length descriptor with EOP is received, nr_frags will be 0. Can this
code then dereference skb_shinfo(skb)->frags[0], leading to an out-of-bounds
read on uninitialized memory?
This could result in a severe length underflow in skb_frag_size_sub() since it
passes a hardcoded M_RX_HDR_SIZE (256) to eth_get_headlen().
Answer:
Cannot happen, hw never writeback 0-size descriptor.

12. 
Sashiko:
> +void rnpgbe_set_rx(struct mucse_hw *hw, bool enable)
> +{
> +     u32 value = mucse_hw_rd32(hw, GMAC_CONTROL);
> +
> +     if (enable)
> +             value |= GMAC_CONTROL_RE;
> +     else
> +             value &= ~GMAC_CONTROL_RE;
> +
> +     mucse_hw_wr32(hw, GMAC_CONTROL, value);
> +
> +     if (enable)
> +             mucse_hw_wr32(hw, GMAC_FRAME_FILTER, GMAC_RX_ALL);
> +     else
> +             mucse_hw_wr32(hw, GMAC_FRAME_FILTER, 0);
> +}
On the DesignWare GMAC block this driver is using (GMAC_CONTROL at MAC
offset 0x0, GMAC_FRAME_FILTER at 0x4), bit 31 of the frame filter is RA
(Receive All) and bit 0 is PR (Promiscuous Mode).
Given:
        #define GMAC_RX_ALL    (BIT(31) | BIT(0))
every link-up transition forces both bits on, with no destination-address
filtering applied at all.  Is that the intended steady-state receive
configuration for this NIC?
Also, because rnpgbe_watchdog_link_is_up() re-applies this filter on every
link change, any future ndo_set_rx_mode() would be overwritten on the
next carrier flap.  Would a perfect-match filter driven by netdev->flags
and the uc/mc lists be more appropriate?
Answer:
This is intentional for the initial submission. The hardware has a
separate register set for MAC/promiscuous filtering beyond the standard
DW GMAC frame filter; full Rx mode management will be added together
with ndo_set_rx_mode() in a follow-up series. The current GMAC_RX_ALL
ensures basic connectivity works without packet loss.

13.
Sashiko
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 5b024f9f7e17..cbe60f168346 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -35,21 +39,63 @@ enum {
>
>  struct mucse_hw {
>       void __iomem *hw_addr;
> +     void __iomem *ring_msix_base;
>       struct pci_dev *pdev;
>       struct mucse_mbx_info mbx;
>       int port;
>       u8 pfvfnum;
>  };
>
> +struct mucse_ring {
> +     struct mucse_ring *next;
> +     struct mucse_q_vector *q_vector;
> +     void __iomem *ring_addr;
> +     void __iomem *irq_mask;
> +     void __iomem *trig;
> +     u8 queue_index;
> +     /* hw ring idx */
> +     u8 rnpgbe_queue_idx;
> +} ____cacheline_internodealigned_in_smp;
This isn't a bug, but the driver mixes the mucse_ and rnpgbe_ prefixes
throughout. The Makefile and module are named rnpgbe, yet the core
structures are mucse_hw, mucse_ring, mucse_q_vector, and the helpers
mucse_add_ring(), mucse_for_each_ring, mucse_fw_irq_handler(),
mucse_hw_rd32() coexist with rnpgbe_poll(), rnpgbe_request_irq(),
rnpgbe_set_ring_vector(), etc.
Is there a planned partitioning between a shared mucse common layer and
rnpgbe-specific code, or would it be preferable to settle on a single
prefix to avoid future collisions if another mucse PCIe driver appears?
Answer:
The mucse_ and rnpgbe_ prefixes follow a layered convention:
mucse_ — Hardware abstraction layer. These operate on the
mucse_hw / mucse_ring / mucse_q_vector structures and contain logic that is
shared across Mucse product lines (e.g., ring traversal, register RMW,
mailbox protocol). They are not specific to the RNPGBE device and are expected
to be reused by future Mucse PCIe drivers.
rnpgbe_ — Driver-level operations. These implement the ndo callbacks,
interrupt policy, NAPI poll, and other Linux networking stack integration
that is specific to the rnpgbe driver instance.
This is an intentional separation: the mucse layer is the cross-product hardware
library, and the rnpgbe layer is the Linux driver that uses it.

14.
Sashiko:
> +static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
> +{
> +     struct mucse_ring *ring;
> +
> +     /* tx/rx use one register, different bit */
> +     mucse_for_each_ring(ring, q_vector->tx) {
> +             writel(0, ring->irq_mask);
> +             writel(INT_VALID | TX_INT_MASK | RX_INT_MASK, ring->trig);
Does this write to ring->trig during NAPI unmasking risk stalling queues or
causing an interrupt storm?
If ring->trig is an Interrupt Status/ACK register (W1C), writing to it will
clear any pending interrupts that arrived between the end of the NAPI poll
and this unmasking step, resulting in a lost interrupt.
If it is a software interrupt trigger register, writing to it will
unconditionally force an interrupt, leading to an endless interrupt storm.
Should interrupt status clearance happen only in the hardirq handler instead?
Answer:
The RNPGBE_DMA_INT_TRIG register is neither a W1C status register
nor a software interrupt trigger. It is a hardware lost-interrupt
recovery mechanism: writing to it instructs the hardware to check
whether any interrupt events were missed while the queue was masked.
If the hardware detects a lost event, it re-issues the interrupt
after a short delay.

15.
Sashiko:
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 70a2b0082ba86..9e541c2419232 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -32,11 +33,28 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
>   * The open entry point is called when a network interface is made
>   * active by the system (IFF_UP).
>   *
> - * Return: 0
> + * Return: 0 on success, negative value on failure
>   **/
>  static int rnpgbe_open(struct net_device *netdev)
>  {
> +     struct mucse *mucse = netdev_priv(netdev);
> +     int err;
> +
> +     err = rnpgbe_request_irq(mucse);
> +     if (err)
> +             return err;
> +
> +     err = netif_set_real_num_queues(netdev, mucse->num_tx_queues,
> +                                     mucse->num_rx_queues);
> +     if (err)
> +             goto err_free_irqs;
> +
> +     rnpgbe_up_complete(mucse);
Is it safe to call rnpgbe_request_irq() before napi_enable() (which is
called inside rnpgbe_up_complete())?
This exposes a race window where an interrupt can fire, mask the queues, and
call napi_schedule_irqoff(). Because napi_enable() has not been called yet,
the NAPI state still has NAPI_STATE_SCHED set, causing napi_schedule_prep()
to fail and napi_schedule_irqoff() to be a no-op.
When napi_enable() is subsequently called, it unconditionally clears the NAPI
state, losing the missed schedule. For edge-triggered interrupts, the
condition won't re-assert by unmasking, leading to permanently stalled queues.
Could NAPI be fully initialized and enabled before registering the IRQ handler?
Answer:
For the per-ring MSI-X handlers (rnpgbe_msix_clean_rings), this is safe
because the hardware interrupt source remains masked until
rnpgbe_irq_enable(), which runs after napi_enable_all(). No interrupt
can fire between request_irq() and napi_enable(), so no race exists.

For the single-interrupt mode (rnpgbe_int_single), the handler is
registered at probe time and persists across open/close cycles. Here
we guard with __MUCSE_DOWN:

  rnpgbe_int_single():
      if (test_bit(__MUCSE_DOWN, &mucse->state))
          return IRQ_HANDLED;   // device not ready, discard

__MUCSE_DOWN is set at probe (before any handler is registered) and
only cleared after NAPI is fully enabled:

  rnpgbe_up_complete():
      rnpgbe_napi_enable_all(mucse);      // NAPI ready first
      clear_bit(__MUCSE_DOWN, &mucse->state); // handler can proceed
      rnpgbe_irq_enable(mucse);           // hw unmasked last

The invariant is: clear_bit(__MUCSE_DOWN) happens strictly after
napi_enable_all() and before rnpgbe_irq_enable(), so by the time the
handler sees DOWN=0 and proceeds to napi_schedule_irqoff(), NAPI is
already enabled. On the teardown side, rnpgbe_down() sets the bit then
calls synchronize_irq(), guaranteeing in-flight handlers observe the
transition.
Both paths are safe, just via different mechanisms.

Dong Yibo (4):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  207 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   45 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   19 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2140 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   87 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   99 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   23 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  211 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   39 +
 12 files changed, 2857 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.25.1


