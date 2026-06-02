Return-Path: <netdev+bounces-294108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE0xLiOmHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:45:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C362BC9C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE523055C34
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC703546F8;
	Tue,  2 Jun 2026 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PkZPaK8/"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF93C81B6;
	Tue,  2 Jun 2026 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392653; cv=none; b=S1ZF8qcGpoqps174QL2TfvBsT66i+ejb8xdB4/rmG5TL71TZ9wpoj33XDAFBShHgDJ5l07XPknqUrbR/VKMUKfyMhqWRS9Vx3LV0YZQQ+KM+5vPyBSfTlGSW07NO16Aok/8v/V1YwCbvpAHc/8MUGqqKnWp8QczMy9qSgVmCMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392653; c=relaxed/simple;
	bh=Sd4pqFslZsE41Oo6J+Gf/c7omco/dRn0J6aD5gr5yWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhOkFs2M0fes0WmE0IOFLh53exQvlw08aPKFa6W65HycGHiw3Hj2Vw9zoERQU1GFHg6rzyCkwy7sk0lPmxkDBFRDGbmIwont0CJM4taGw+jwg4H0dkmjQXsvHYqOcDyu0y0jJCKwl6buvr5NzDvHsUos9sjRL/fNRnJJ4oOfrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PkZPaK8/; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=hwhnOXJquDTFrNkY3bAEDfh98xtmc3TROZSuwO/v1yg=;
	b=PkZPaK8/d2mnZxilpRJtFfxV62MDrsJQxMOAqjTDtXrR17I6Tw7SdKqlbt/Kjn
	jCQ1Q1ESIJeBmDvVND9XFFsMWM/Yqgbbd8yiUAJje2Gaw5TzOncrZgaytnxWgcLe
	Q/g6t7AjnhMetcsI6DsrEjz/7Z2lQULkt+p5bmmBHS2SY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCn8hoxoh5qnwk+AA--.6197S2;
	Tue, 02 Jun 2026 17:28:18 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: pabeni@redhat.com
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dinghui1111@163.com,
	dinghui@lixiang.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	liuxuanjun@lixiang.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com
Subject: Re:Re: [PATCH v2] net: stmmac: fix fatal bus error on resume by reinitializing RX buffers
Date: Tue,  2 Jun 2026 17:28:17 +0800
Message-Id: <20260602092817.929979-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528120203.245762-1-pabeni@redhat.com>
References: <20260528120203.245762-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCn8hoxoh5qnwk+AA--.6197S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWfuw13AFy3tr13KrW5Awb_yoWruF47pF
	W7Aa1qkrykJr13Jw4UZw48uFy5Aay5tF4UCw13X3ZI9ayakr92vF4aqr45ua47Cr18Zw1S
	yF4UA3sxCF4DuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pihL08UUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0hLWA2oeojJeHwAA3w
X-Rspamd-Queue-Id: 566C362BC9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294108-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dinghui1111@163.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,163.com,lixiang.com,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,bootlin.com,gmail.com,armlinux.org.uk];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

At 2026-05-28 20:02:02, "Paolo Abeni" <pabeni@redhat.com> wrote:

>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 3591755ea30b..0dc27d8c66a0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -1642,6 +1642,79 @@ static void stmmac_clear_descriptors(struct stmmac_priv *priv,
>>  		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
>>  }
>>  
>> +/**
>> + * stmmac_reinit_rx_descriptors - re-program RX descriptors from existing
>> + *				   buffers (allocation-free)
>
>[ ... ]
>
>> +static void stmmac_reinit_rx_descriptors(struct stmmac_priv *priv,
>> +					 struct stmmac_dma_conf *dma_conf,
>> +					 u32 queue)
>> +{
>> +	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
>> +	int i;
>> +
>> +	for (i = 0; i < dma_conf->dma_rx_size; i++) {
>> +		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
>> +		struct dma_desc *p = stmmac_get_rx_desc(priv, rx_q, i);
>> +
>> +		if (rx_q->xsk_pool) {
>> +			dma_addr_t dma_addr;
>> +
>> +			/* The XSK pool may not be fully populated (e.g.
>> +			 * xdpsock TX-only); skip empty slots.
>> +			 */
>> +			if (!buf->xdp)
>> +				continue;
>
>[High]
>Does the continue here regress to the same fatal bus error this patch
>sets out to fix?
>
>When the slot is skipped, its descriptor address fields keep whatever
>HW writeback left behind. Then stmmac_clear_descriptors() runs right
>after stmmac_reinit_rx_descriptors() in stmmac_resume() and unconditionally
>re-arms OWN on every slot. For dwmac4 that is dwmac4_set_rx_owner():
>
>	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR |
>			       RDES3_INT_ON_COMPLETION_EN);
>
>and for enh_desc / ndesc the equivalent OR of RDES0_OWN / RDES1 fields.
>None of these clear the address fields.
>
>When stmmac_hw_setup() restarts the DMA, the controller sees an owned
>descriptor with VALID_ADDR set and a stale address — the exact failure
>mode the commit message describes. Could the skipped slots be cleared
>(stmmac_clear_desc() or zeroing des0/des1/des2) instead of left intact,
>or arranged so clear_descriptors() does not arm OWN on them?

It's right that the skipped slots must be cleared instead of left intact.
This change will be reflected in version v3.

>
>> +
>> +			dma_addr = xsk_buff_xdp_get_dma(buf->xdp);
>> +			stmmac_set_desc_addr(priv, p, dma_addr);
>> +			stmmac_set_desc_sec_addr(priv, p, 0, false);
>> +		} else {
>> +			/* Theoretically unreachable: napi_disable() in
>> +			 * stmmac_suspend() ensures all initialized slots
>> +			 * have a valid page before we get here.
>> +			 * Defensive check only.
>> +			 */
>> +			if (!buf->page)
>> +				continue;
>
>[High]
>Is the comment "Theoretically unreachable: napi_disable() in
>stmmac_suspend() ensures all initialized slots have a valid page"
>accurate?
>
>stmmac_rx() assigns buf->page = NULL at multiple points when handing the
>page on to the stack or to XDP, for example:
>
>	buf->page = NULL;
>
>in stmmac_rx() after the page has been consumed.
>
>stmmac_rx_refill() allocates with GFP_ATOMIC | __GFP_NOWARN and breaks
>on allocation failure without advancing dirty_rx, leaving the failing
>slot (and any subsequent slots) with buf->page == NULL:
>
>	if (!buf->page) {
>		buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
>		if (!buf->page)
>			break;
>		...
>	}
>
>stmmac_disable_all_queues() only does synchronize_rcu() and
>napi_disable() — it does not retry refills. Under the memory-pressure
>scenario this patch is explicitly designed to make safe, a prior
>GFP_ATOMIC failure can leave the ring with NULL-page slots at the
>moment suspend happens.
>
>If such a slot is then skipped here, the same OWN-with-stale-address
>condition described above applies on resume. Should the page_pool path
>also clear the descriptor for skipped slots, or allocate a replacement
>buffer rather than leave a stale-address descriptor for
>stmmac_clear_descriptors() to arm?
>
>> +
>> +			stmmac_set_desc_addr(priv, p, buf->addr);
>> +			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
>> +						 priv->sph_active &&
>> +						 buf->sec_page);
>> +
>> +			if (dma_conf->dma_buf_sz == BUF_SIZE_16KiB)
>> +				stmmac_init_desc3(priv, p);
>> +		}
>> +	}
>
>[ ... ]
>
>> +}
>> +

Same as above, the skipped slots must be cleared instead of left intact.
This change will be reflected in version v3.

Thanks for the review. I will upload the v3 version soon.

Ding Hui


