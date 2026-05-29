Return-Path: <netdev+bounces-293034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INB3LlxFGWrzuAgAu9opvQ
	(envelope-from <netdev+bounces-293034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:50:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6135FECD6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9346E328AA4E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0651D3B3883;
	Fri, 29 May 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nete6hT0"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3963B3887;
	Fri, 29 May 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040743; cv=none; b=QAX/jYxN4jWuZawuthsxLOaWDhowxEc3U051RNF8FlCl7ldbG214ym8/cM0ywGuEUuxuWK/KT38G/SsqQs8qDuiH6EG+aGYgjrAbaYiS+o8WgB0OlI2w/21n0WqBO3BXVyfuR33h9FziZLdu1odb4uHhgS+x4oKqU00EJSHuqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040743; c=relaxed/simple;
	bh=BSmnAoxqgcRVwz0shbT4icyDfMVFaY5F178kWXIXsdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4G38CzATF8e/2KrLf5lujnJ4n3i5L+MHr+Fojtmnxm526puyxb9ppCBrDPRmlBgZ1QR4Y/eQmabZTpmylMwv0JA6mhddeInTx4uhcxtuBVcuSftamaK0BTb0Id81EWesKD3esngzFnzhHQN3b2XodeOgIr7GCJ3WylJF+YuwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nete6hT0; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=ib7Ut0SfSUbe54vHfazcErQh/0J2DlD47lgc4LGMbCM=;
	b=Nete6hT04hIRmZhZBhxZ4uB3g3iLGdJMNAFbsfrlKtX78aTJg9uWmNr30ZboX6
	nEqxR2S7SCF4pR0ZMcsSWWDeiC/9WLXa5RBXWlYPQo/Quu3Y9RIheNjXdQoRdqid
	JeuviavYa30MfhSup/GMzinyvBxn1y4iarh4ngePCzMcQ=
Received: from PC-YLX4CAEK.company.local (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHv0t5Qxlqea_vAA--.36333S2;
	Fri, 29 May 2026 15:42:50 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: j.raczynski@samsung.com
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
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com
Subject: Re:Re: [PATCH v2] net: stmmac: fix fatal bus error on resume by reinitializing RX buffers
Date: Fri, 29 May 2026 15:42:49 +0800
Message-Id: <20260529074249.2640274-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ahhX4lIpHwhVekMc@AMDC4622.eu.corp.samsungelectronics.net>
References: <ahhX4lIpHwhVekMc@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHv0t5Qxlqea_vAA--.36333S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry8Aw1rCFW5ur17Cw1Dtrb_yoWrGF45p3
	yYkw4DtryDGr18tws5Aw48ZFyYvayrJrW5u34DG342k3y5urnavr4aqw4Yva9rur1v9340
	qr45Z3y8CFyvvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_nmiJUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0hvP+2oZQ3uJmwAA3k
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293034-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,163.com,lixiang.com,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,bootlin.com,gmail.com,redhat.com,armlinux.org.uk];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dinghui1111@163.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A6135FECD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

At 2026-05-28 22:57:38, "Jakub Raczynski" <j.raczynski@samsung.com> wrote:
>On Tue, May 26, 2026 at 10:26:17AM +0800, Ding Hui wrote:
>> From: Ding Hui <dinghui@lixiang.com>
>> +		} else {
>> +			/* Theoretically unreachable: napi_disable() in
>> +			 * stmmac_suspend() ensures all initialized slots
>> +			 * have a valid page before we get here.
>> +			 * Defensive check only.
>> +			 */
>> +			if (!buf->page)
>> +				continue;
>> +
>> +			stmmac_set_desc_addr(priv, p, buf->addr);
>> +			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
>> +						 priv->sph_active &&
>> +						 buf->sec_page);
>
>It this generally sufficient?  Or, in fact, isn't that overkill?
>stmmac_rx_refill() generally does a bit more preparation of descriptors.

You are right that stmmac_rx_refill() does more work — it allocates new
pages and maps them. The key difference here is that in v2 we intentionally
keep all RX buffers alive across suspend/resume, so no allocation is needed.
The only thing that needs to be restored is the buffer address fields in the
descriptors, which were overwritten by hardware write-back.

>The issue seems to be that during suspend there is mismatch,
>caused by writeback format, between rx_dirty and rx_cur pointers and
>there is bad handling of this case, since there is no verification
>of leftover stuff and there will be leftover bad address crashing platform.
>So stmmac needs to refill/reinit descriptors that were consumed but not
>refilled. So isn't going through whole dma_rx_size overkill?
>Wouldn't it be better to iterate over buffer from cur_rx as long as descriptors
>are 0 and only apply refill to those corrupted?

Actually, The hardware may have consumed additional descriptors in the window
between stmmac_disable_all_queues() and stmmac_stop_all_dma(), so cur_rx can lag
behind the hardware's actual position. So maybe not only the descriptors between
rx_dirty and rx_cur pointers need to be refilled. 
You are right that we should only refill the consumed descriptors. But checking the
OWN bit requires a new lightweight get_rx_owner() helper across all descriptor
variants (dwmac4, dwxgmac2, norm_desc, enh_desc), adding complexity for marginal gain.

>Could you paste panic that occurs during this issue?
>You mention "fatal bus error" which I would assume is system panic?

Apologies for the misleading wording — this does not cause a kernel panic.
The issue manifests as a Fatal Bus Error interrupt on the DMA controller.
Taking XGMAC as an example, dwxgmac2_dma_interrupt() detects XGMAC_FBE,
increments fatal_bus_error_irq, and returns tx_hard_error, which triggers
stmmac_tx_err() to stop and reset the TX DMA channel. But this has no effect
for the RX DMA engine (may be we should reset RX DMA here). The practical effect
is that the RX DMA engine halts after dereferencing the invalid buffer address,
and the network interface becomes non-functional after resume — no packets can be
received until the driver is reloaded or the device is re-probed.

To reproduce the issue on my platform:
  1. Connect the DUT and a PC, configure IP addresses so they can ping
     each other (e.g. DUT: 192.168.1.1, PC: 192.168.1.100).

  2. On the PC, start an iperf3 server:
       iperf3 -s

  3. On the DUT, start a high-rate reverse UDP stream to keep the RX DMA
     busy during suspend:
       iperf3 -c 192.168.1.100 -u -b 900M -R -t 0

  4. While iperf3 is running, trigger a suspend/resume cycle on the DUT.

  5. After resume, check the fatal_bus_error_irq counter:
       ethtool -S <iface> | grep fatal_bus_error_irq

     Without this fix the counter increments and the interface stops
     receiving packets. With this fix the counter stays at zero and
     normal operation resumes.

I will update the commit message to clarify "fatal bus error causing RX
DMA to stop".

Thanks for the review.

Ding Hui


