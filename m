Return-Path: <netdev+bounces-261827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGxRFnmAoWkUtgQAu9opvQ
	(envelope-from <netdev+bounces-261827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 12:31:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E299F1B6970
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 12:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E804304B3AE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5336D4E4;
	Fri, 27 Feb 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVz4uZ8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6251ADC97
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191702; cv=none; b=EvUzQLiDyFgw6JutunMXt2djz7LXS/9P5oCUEkouC4PlDBQBALLYq3bPzC3EchI70kNNHd1Bc5iyalTSQ0Q66FN6EDE+DBM7ERwLDpTGYILzBppuRA1qtUeGTnHEP3lqzyqHzC/oydHPol3lQNTjJJYQ1DvlOrT+sdqM3pbS8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191702; c=relaxed/simple;
	bh=WlnIugoYmzIJ5xTnltyR4jSckheGi1NmY8EiVTuCICk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoonPROQ9F+VjgUwhtBkSpr8SMFOYmObqzXCEKqZfROzk8lUTbwnL9LVhVHRV51peNyzyeYzvjuI/sP5wh7rIWZwqdTOFW1lop+2QoYd4dH8rEd8yCKD9zoiN+3DDa1QnzOwn429+PgvbDA4/+OFPQuVKjhZT0RXzTKq/L+5tZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVz4uZ8b; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso17090605e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772191699; x=1772796499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Kr1PpxLyoA/9WG5YRuxQpDETs+iItrRpIE+rfTT4Y=;
        b=YVz4uZ8bblE4I8ITJ4xhU5dObaGlRwKeR/iKBLJ0KV5o9Wtb7fqnP5y9NdGsWlrNOs
         GN3iucGN9DVTE5Zb4Z4ifIc+KYGlBEOtHp1ckIgVHZgOp4vITI/NvtX5pfRS0VRXjjJf
         hPvuso1taV/TmWsghutEZNr1j5LbdtX2/+6I1FhBDa7Qh9uoWl20rH8njj3I2Qv4MMaO
         gjM1qGzrxZF9orw/LCrbZ08c9jJbxrbqAuhXBA2JN3qaH7ZF9IJCMEO0Uh02YdvTnLQT
         UcF1xorElM6opmUx5GxBkBB6Lmdb6O91jUd72eIXipC90N3u71yMXTRqHi5ioD8us0uG
         TCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772191699; x=1772796499;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+Kr1PpxLyoA/9WG5YRuxQpDETs+iItrRpIE+rfTT4Y=;
        b=o3/5BG1BY9y5SsbCc5amGXSbXzQS4ayxPoFm20DkIzJFVh81vtruQWrfG30/701taD
         yEQl7zbWrTzB0VCSorsLUnvVnyI01b1GFe9NbEIjJIPkR3kQ4f3qMKu+fx6rUCsCJEk/
         CYwWMWlFg8gI16wvtX8+Vx84PaGvBho6yYpWOVPrP3Lg+j5RqLFRo0hfnl+MdDd+CTkf
         FACMdDy/LxjEkZTtdbsfSOyt5dINkUACVR+k05XkljXcfNnn24YgRQyq4rI6vlGdXwpE
         WhprgGECeq8AFG5AAiYA/Hh99SHDHvoHT1bPk1d86CxVAsAzC7Pz3qFm9T3t+UU66p09
         0Vkg==
X-Forwarded-Encrypted: i=1; AJvYcCUkL5wsWDq7NXnycOaF4y5R/85qnZggQpXzsWAxs1BYjHx5/7SJolMFSF0Cf265YOwI6pC3ea0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMihDsmm0+ZBOwh61/NLUdviNQS3i+Dyog67BCgOQGcXT9/Wx
	8EoTxH8EPMUbkrX93Gklk8lhAca9riBkFVzot6ZIIaGPmQ0nPVazwQ0E
X-Gm-Gg: ATEYQzxXolVQq7hwlcqYNI6q4hvlR2MKVvm6fusKqkuI9Xux0d567zXMmHGu/HvwkUI
	0JdMOTwYI1bPiAd6rKfXn6mH2QHdc0nKaEmGM/+PIk2i7Bv8+24sNCUuBsWoKTwVTog9k+GRgNy
	mn577mVliCV4fJ157ontMqdhXXBDKnXRwP54j3mnwjQeo09bQ55p0za1DmfQTAen7aglvSbOsgY
	HE3A63BpJWy2Dn/YDPqCXuC8AAF+bPNTEuUbt8pne9apIb1l7dbuj80R7J58+tIYXM3UXHHFkQj
	rv6qyYW5m3bN2MNAbA+0WmfNI+29TCd+ikJpSHqO67gGkC4884/qcvMTVER4gL7THyReCfguVVe
	jwYt7Npq6ApV/NydU6KE/1Htzigtod3nWmeb+5RcpCXzVMIQbRQzKVGtcwq76DEFir/ypc0MA9C
	F/ncQR9Q6giTHBFYPhSGhXF+iLajJx3dccGTXvuXzNNgPsCSfCWLf73s0aO6eCSUJYyKN2Fw==
X-Received: by 2002:a05:600c:64c7:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-483c9bc55a1mr34558265e9.7.1772191698675;
        Fri, 27 Feb 2026 03:28:18 -0800 (PST)
Received: from [192.168.178.48] (80-218-237-147.dclient.hispeed.ch. [80.218.237.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75dfaasm186992645e9.12.2026.02.27.03.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 03:28:18 -0800 (PST)
Message-ID: <786338e0-0a6b-4b7b-9e22-8253bb655aec@gmail.com>
Date: Fri, 27 Feb 2026 12:28:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: enetc: fix sirq-storm by clearing IDR registers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: claudiu.manoil@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zefir Kurtisi <zefir.kurtisi@westermo.com>
References: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
 <20260223163227.y3yzzpncyf5a7klq@skbuf>
 <b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com>
 <20260226195158.sagjq3hgs6l64w2u@skbuf>
Content-Language: en-US
From: Zefir Kurtisi <zefir.kurtisi@gmail.com>
Autocrypt: addr=zefir.kurtisi@gmail.com; keydata=
 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
In-Reply-To: <20260226195158.sagjq3hgs6l64w2u@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-261827-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zefirkurtisi@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[westermo.com:email,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E299F1B6970
X-Rspamd-Action: no action



On 2/26/26 20:51, Vladimir Oltean wrote:
> [...]
> If I understand correctly, this patch should resolve your issue?
> 
>  From 887cf74648fb10b7dee3c60199349d184c5a851e Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Thu, 26 Feb 2026 21:50:13 +0200
> Subject: [PATCH] net: enetc: avoid sending too short Ethernet frames
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index b0b47b0f7723..4f5e593b348a 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -982,6 +982,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>   	struct enetc_bdr *tx_ring;
>   	int count;
>   
> +	if (eth_skb_pad(skb))
> +		return NETDEV_TX_OK;
> +
>   	/* Queue one-step Sync packet if already locked */
>   	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
>   		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,

Hi Vladimir,

yes, that fixes it.

I expected identifying invalid frames with all corner-cases to be 
difficult, not realizing that making them valid is way easier. Thank you 
for that insight.

Tested-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>


While I was debugging the issue I extended enetc with features that 
still might be useful; the first change was to selectively process only 
the pending BDs instead of looping over all available, saving a 
significant number of unneeded calls to enetc_clean_rx/tx_ring(); the 
second adds a fail-safe mechanism for potentially other issues taking 
the same code path based on the fact that now a BD is only processed 
when its IDR is active, which means there must be BDs available to process.

Please find the patches below, if you think they are of some value, take 
as you see fit or let me know to prepare a v2.

Thank you for looking into it and resolving it so swiftly.

Cheers,
Zefir

---
 From 54791dad5555d6dea0c0276268058d491b25548a Mon Sep 17 00:00:00 2001
From: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Date: Fri, 27 Feb 2026 11:14:08 +0100
Subject: [PATCH 1/2] net: enetc: process only those BDs that have IDR set

The enetc_poll() function currently tries to process all
BDs without considering which one caused the interrupt.

When a frame is received, it then still loops over all
TX BDs to in enetc_clean_tx_ring() find out there are no
pending BDs to clean.

SITXIDR/SIRXIDR provide us with the list of BDs that were
triggering the interrupt, so we can limit processing to
those affected.

This changes enetc_poll processing accordingly.

Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
---
  drivers/net/ethernet/freescale/enetc/enetc.c | 24 +++++++++++++++-----
  1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c 
b/drivers/net/ethernet/freescale/enetc/enetc.c
index e380a4f39855..e9d600506d83 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2114,19 +2114,31 @@ static int enetc_poll(struct napi_struct *napi, 
int budget)
  	bool complete = true;
  	int work_done;
  	int i;
+	u32 si_idr;

  	enetc_lock_mdio();

-	for (i = 0; i < v->count_tx_rings; i++)
+	si_idr = enetc_rd_reg_hot(v->tx_ring[0].idr);
+	for (i = 0; i < v->count_tx_rings; i++) {
+		/* only process TX BDs that have IDR bit set */
+		if (!(si_idr & BIT(v->tx_ring[i].index)))
+			continue;
  		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
  			complete = false;
+	}
+
+	si_idr = enetc_rd_reg_hot(rx_ring->idr);
  	enetc_unlock_mdio();

-	prog = rx_ring->xdp.prog;
-	if (prog)
-		work_done = enetc_clean_rx_ring_xdp(rx_ring, napi, budget, prog);
-	else
-		work_done = enetc_clean_rx_ring(rx_ring, napi, budget);
+	if (si_idr & BIT(rx_ring->index)) {
+		prog = rx_ring->xdp.prog;
+		if (prog)
+			work_done = enetc_clean_rx_ring_xdp(rx_ring, napi, budget, prog);
+		else
+			work_done = enetc_clean_rx_ring(rx_ring, napi, budget);
+	} else {
+		work_done = 0;
+	}
  	if (work_done == budget)
  		complete = false;
  	if (work_done)
-- 
2.43.0
---
 From a144fc991784ea7ee51c4a46d03b46ee4a17956a Mon Sep 17 00:00:00 2001
From: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Date: Fri, 27 Feb 2026 11:21:49 +0100
Subject: [PATCH 2/2] net: enetc: clear sticky IDR bit causing IRQ-storms

We observed enetc entering a state with a sticky IDR bit
set causing IRQ-storms. It could be tracked down to
a zero-sized IP frame being transmitted, which causes the
HW to issue IDR but not advance the TX BD.

Vladimir Oltean fixed this by ensuring TX frames are padded
to the minimum size.

This adds a fail-safe mechanism to recover from such issues
just in case there are other stimuli causing taking the
same code path.

The mechanism bases on the fact that the current TX BD is
being processed because it issued a IDR. If contrary to
that no descriptors are pending, a warning is issued and
the TBaIDR is cleared.

Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
---
  drivers/net/ethernet/freescale/enetc/enetc.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c 
b/drivers/net/ethernet/freescale/enetc/enetc.c
index e9d600506d83..d8680a5768b5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1229,6 +1229,14 @@ static bool enetc_clean_tx_ring(struct enetc_bdr 
*tx_ring, int napi_budget)

  	bds_to_clean = enetc_bd_ready_count(tx_ring, i);

+	if (!bds_to_clean) {
+		/* this shall not happen, since IDR indicated data available */
+		netdev_warn(ndev, "TX[%d]: IDR set, but no BDs to clean => "
+			    "clearing IDR to recover\n", tx_ring->index);
+		enetc_wr_reg_hot(tx_ring->idr, BIT(tx_ring->index) |
+				 BIT(16 + tx_ring->index));
+	}
+
  	do_twostep_tstamp = false;

  	while (bds_to_clean && tx_frm_cnt < ENETC_DEFAULT_TX_WORK) {
-- 
2.43.0


