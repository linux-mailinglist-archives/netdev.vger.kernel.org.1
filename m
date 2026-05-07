Return-Path: <netdev+bounces-285182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDUgCqVK/GmZNwAAu9opvQ
	(envelope-from <netdev+bounces-285182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:17:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC84E4A1C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2CDC300D637
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA27F346FCA;
	Thu,  7 May 2026 08:17:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C853264C2;
	Thu,  7 May 2026 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141857; cv=none; b=fsWnR3tL7XbK6S5nurOX2pkqH4p4mCmTZHtxWWMvfVU5IM9EiKJSR/H0IOnPvzxmV773SbPvtk/soCMD2hJKHNIZtTMdq7Se0vOOAmd0p4l4dgDqPpKjUvQHMYMXeJsaPDuNWxfS5lN1oABw1tD2Oauq/McE9SQz+t/ol8WHtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141857; c=relaxed/simple;
	bh=IEQM43gi5uhjUJAJbq68ax2cdYjcHrrGjUyMIi2xxqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tPQRveCYHGomzGjl0ic4RcVSmC3B+c0gIqBCI2e6vpAEabtDOPy7giV5ZT+MA76+d7V1vfY07QBBWjBaj+Y1gxMaUMxle71QKfOuT56fTWocwH5K4f5tydentRLU0C5XQ5wUmBKVQnHkS1MIGymPsBWVOgR1vn0QcjXgleuS7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1778141751t65dfd05b
X-QQ-Originating-IP: qwiEdhhDDBVR9mRy7CmBvTteb2xM1NPCLLJX+kuUn2M=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 16:15:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1322933894851787973
EX-QQ-RecipientCnt: 12
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v3 0/4] net: rnpgbe: Add TX/RX and link status support
Date: Thu,  7 May 2026 16:15:35 +0800
Message-Id: <20260507081539.171844-1-dong100@mucse.com>
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
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NcTWQ5EIkx4dqrTVih2+V5wKByTN1tzdQj9lkYCYv8e2edKSeT9Ruw8w
	YKO2WxG5fjE7/yJo8db7yUuFv8Pw2bYjS3DL9ctT8WFxY21rSKCMr8IA9tTOiOJAg72JtMN
	jQe2KuoCVoOmXw9cvhFOA20VTpOplcS6NY4dMr8GFRE2iLganEnBxBjTOoFpSe97AqMZ/V1
	3tgtHYsXWADBsVYqeQJMy4c5HVhEuBE5GP1wutFTrlEfZgiu7JoahoMPDwFhRSMeQox1FUR
	E9zifq/CTD3M6qu0CaPpDBJ9HSrUXc9dOQIyS0N7Ba1G+A3iuXMa17TExfcdzyxm01RBGhT
	UVDUibI7c+e+XGkdyYZavmWBNDN4PxLwvc4XdT2hkTGh1TCz8VGBzlcqeN9qqqccbUap+nZ
	Dk6wxnDlvzwFa6Kk3if7N4k+f4YL1yFkFUvJiHYNI99fPnS2KWoPHjfhIJendPb0/AAacIK
	gPl8Lx9p3tn5qum4wi/DXhuqTY7S/WhP74lW8Y3uo8V00jM+Bqhf4+g4Sdf8SSeqe1U535J
	2nQXSVVATBQEHGD9jtSM45kAIYM6h1Ywq2Fn1e+vE3bZqM3ppTh0h54xy3EdTjnUZ7VdflM
	EG/uvnuokY/khwRhcNYw2IQW7JuCxRgasheW0SzKZK5L+sZKNbqI8ncjCJFTvlZvETqUnzR
	/WEq1H0IwOI2/ixENAZOuSK79mutqifg56suIiyuHPI4sXTTcZuL2WqL6lLmk5unHSJG02+
	KJlzu0634JPoin+Z2Y4cGt/W5EfheMLg959jfwFFrQ2Ny4AxzHnqWZaifsJMwteKpIIxFT7
	wQABm2u8BKsT7Oio4Mv2JiehCexrWfM4I3tL0PoBIoSWWdPwKJYEjtENm8EvcbHrOXzFPg5
	xOiKKvQHV8ZXvYDYT8xZO85H4wTytFjiEfkWqymEQZPH8F3hfYPSjNa/Ag+8r9FFLwHPl0l
	1mTvXf87cKLQJg5UXvoPDAvi94V4nJSrrvZyecB7gw/Sne7wVLq2Wt6TYHmJ+cNnFQ18Ri3
	BHS/b8fs8wAjNqU/e/TdmT1n8ijhoNLDlleQKPQL3fi2HvQQ58rTNt0PpIdaTmde/Flnpfo
	vYNzVBiYmUK4iqHF2ba/GAxDdrpprVoxw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 68FC84E4A1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-285182-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

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
v2 -> v3:

[patch 1/4]:
1. Fix WARNING(use flexible-array member instead). (Jakub Kicinski)
2. Fix rnpgbe_poll maybe return a negative value. (Sashiko)
3. Use bdf for mbx_irq name to avoid sequence problem between
   register_mbx_irq and register_netdev. (Sashiko)
4. Add null function mucse_fw_irq_handler to process fw-mbx in
   rnpgbe_int_single. (Sashiko)
[patch 2/4]:
1. Check mapped_as_page in function rnpgbe_clean_tx_ring. (Sashiko)
2. Set RNPGBE_TX_START to 0 before free tx_resources. (Sashiko) 
3. Fix dma_unmap_single condition in rnpgbe_clean_tx_ring. (Sashiko)
4. Add stop hw ring in rnpgbe_clean_all_tx_rings, which is called
   before rnpgbe_free_tx_resources. (Sashiko)
5. Add drop stats when tx_map failed. (Sashiko)
[patch 3/4]:
1. Drop all desc until eop if frags more than MAX_SKB_FRAGS. (Sashiko)
2. Clear rx desc when rnpgbe_build_skb() failed. (Sashiko)
3. Clear RNPGBE_RX_START before free desc memory. (Sashiko)
[patch 4/4]:
1. Fix M_ST_MASK define error. (Sashiko)
2. Fix UAF in rnpgbe_service_task. (Sashiko)
3. Set GMAC_FRAME_FILTER only linkup. (Sashiko)
4. Fix 'dropped mailbox replies' error. (Sashiko)

links:
---
v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/

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

Dong Yibo (4):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  196 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   41 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   19 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 1981 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   91 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   93 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   23 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  197 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   39 +
 12 files changed, 2667 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.25.1


