Return-Path: <netdev+bounces-291523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLypGIQVFWpoSgcAu9opvQ
	(envelope-from <netdev+bounces-291523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:37:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C595D0602
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B306030090A9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F943B9D9B;
	Tue, 26 May 2026 03:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C83B811F;
	Tue, 26 May 2026 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766645; cv=none; b=Qg0a0jjG2VCygCcDMIkKaJeQrPM004SqQBfCdhU+EN2wM0LRF6HRzfjStgHdrKwAQuvnsGL4yBUU8yjo24+PZrN/E8mMw4AMvsTDqEK8mgBydiOq0a3WzEOo1EQeUUwqvGoaGw+0bZi9sMwqK8XIiB0sJ53TII05S5XpDVPF51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766645; c=relaxed/simple;
	bh=Boux7FNQ+JAW0truX1BJUobiczz2+qoUKFqZPwokV38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BPJ1olFQUjZTiXHGWrmvno+hOvJPpm7Kaz3iera+QaG1VLMlGETO/qLw5NpxOFgvtMz6LeR8Grx3Q18sdxCUgWK6cTPGiU6GeaY88VQ9ZzMpfgKh03QPo/nSQx0tIS3vt8kBCFbPlwKpFqV72WZ/w4olCgoFtIUDYgFkstcti9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1779766549t11c3806c
X-QQ-Originating-IP: GqAAEkPdS2iwzbzs74pIeRAmWesvkmadLSOuxExARKs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 May 2026 11:35:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1407884131310676841
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
Subject: [PATCH net-next v4 0/4] net: rnpgbe: Add TX/RX and link status support
Date: Tue, 26 May 2026 11:35:35 +0800
Message-Id: <20260526033539.164061-1-dong100@mucse.com>
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
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MABkn+BX1UZ4XOSz50mEiNzrJYu+bzeETf2Q2VCGpDkOmKMmepRLajsC
	pbfLkZDUarb14e4Yj9QeuLe4zAHZ3KkAqHC4VkrSTE1VpliBJryNKs5RaNALhnHyxXm0NhA
	zHvqgR0sJUGpwLldczb4OxBF8PTwBKFTxJiLUupqMT1P6Zi1SEtu9WMmdA+//VLbFS7TOid
	WUGcXhdBd5ottWsQiPj6qIupLAT2/KbOAeJ2DIu6E6XUI4MZKCLMVqJUCd67ntdh53qqYeY
	RPpt2HX4m4kRvMQHCoK5x49jSk5hKXuvbmGj88xbTkwisU/uh6JXhsZrPxuXUOfjr4b18H4
	16vJwWlwAOQdN8AlNMHFFCJnZ5TeCJ3+Mlvypkn4p4VNP9ZiABNfY59axj8rrmvlDZCcbIr
	tmtg3dTbXNr+f06+UhzmRuK3XEY0A+Gc6R1tULN6M+WcNOfiJj6T+2EmGLCip3rXJQvEJvA
	JOj3jYGIVL+xN/iGzOkeNl19u6CmPElUOfrrsERWWvEz1Azs9fn3xoL8AEhACPc11RLTtCs
	cw2PL2mqDgkNPwcyCd4t9FONxSTHQnF+GEoQO1F2kx75u/TjKbtmT8A2mIXesyrzRhdYwNF
	gUEIPdBb+oq3oCng8qCg8REa0iY3V0+2A+sZQbMkPpkZW+4HxgB6U9lSlGw5jX5fXCogA7I
	lkThfj2exbcvJ9YpWEvojfzmWjuQWxls08ifxq3XQuJKeJ0pEZUOnR6mn4ERom8aieCADsj
	T6OXYKUUH7zq1i1TvSYgnLuDQ+TheClzlNH9jcTaFEBsPChtWs2S0pVvIT8bqmB0j2ZKRwv
	Dtp17xmPagXjkrxoA9bTMh75S317Dd1qTffk9gQEg4sbSx2YwGpSPrclUtrF7bgSv9cljqN
	eMPkSv+hkjs64dEhEQ0oKdA0+RqOVN2fB/Xa9JpAuPoj0GioScxHOt9viJOG7LN3mR0JHA1
	SBdFr+Z8DVL6MNz9F9/HV/eAGkG1Aea1wWiVzT/TUWOrlPv1a5lFF+CUgyslx3sqaFMEmie
	JbK2rd2c7sPmclIxN0xU9zP5CNBW8i+yJDjVOy/jKChoR+gKim8V3Kq9oIJDc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291523-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mucse.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mucse.com:mid]
X-Rspamd-Queue-Id: 04C595D0602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
v3 -> v4:

[patch 1/4]:
1. Use min3 to optimize code. (Vadim Fedorenko)
2. Setup RING_VECTOR in msi mode. (Sashiko)
3. Call 'pci_set_drvdata(pdev, NULL)' in err_free_net. (Sashiko)
4. Move remove_mbx_irq after unregister_netdev. (Sashiko) 
5. Remove '-1' for snprintf in rnpgbe_request_irq, (Sashiko)
6. Fix mucse->num_tx_queues and mucse->num_rx_queues after
   rnpgbe_alloc_q_vector. (Sashiko)
[patch 2/4]:
1. Convert tx dropped to atomic. (Sashiko)
2. Sum stats.dropped into stats->tx_dropped. (Sashiko)
3. use dma_set_mask_and_coherent in probe. (Sashiko)
4. Flush TX_START before free or change dma address. (Sashiko)
5. Don't cost desc for 0 length frags in rnpgbe_tx_map. (Sashiko)
6. Flush irq mask before synchronize_irq. (Sashiko)
[patch 3/4]:
1. Add commit to descript rx size guarantees. (Sashiko)
2. Add dma_wmb before update rx tail. (Sashiko)
3. Remove unreachable code in rnpgbe_cleanup_headers. (Sashiko) 
4. Fix "not without advancing next_to_clean" in drop_status. (Sashiko)
5. Fix "page leap" when skb failed, then close interfce. (Sashiko)
6. Flush RX_START before free or change dma address. (Sashiko)
7. Remove no-used mucse_rx_bufsz define. (Sashiko)
8. Call dma_sync_single_range_for_device when reuse page. (Sashiko)
[patch 4/4]:
1. Add BUILD_BUG_ON in mucse_mbx_fw_reply_handler. (Sashiko)
2. Call rnpgbe_set_rx in rnpgbe_down. (Sashiko)
3. Fix hw->link race in rnpgbe_watchdog_subtask. (Sashiko)
4. Fix reinit_completion in mucse_fw_send_cmd_wait_resp. (Sashiko)
5. Rename rnpgbe_watchdog_update_link to rnpgbe_process_link_event.
6. Rename rnpgbe_watchdog_link_is_up to rnpgbe_link_is_up.
7. Rename rnpgbe_watchdog_link_is_down to rnpgbe_link_is_down.
8. Rename rnpgbe_watchdog_subtask to rnpgbe_process_link_subtask.

links:
---
v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
v3: https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com

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

Dong Yibo (4):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  197 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   41 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   19 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2111 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   84 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   96 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   23 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  205 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   39 +
 12 files changed, 2801 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.25.1


