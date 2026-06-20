Return-Path: <netdev+bounces-300812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4+bUOfWRNmphBQcAu9opvQ
	(envelope-from <netdev+bounces-300812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:13:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 192FD6A8EDF
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:13:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JMf8iBLW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300812-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 311CC30262D6
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C27393DEE;
	Sat, 20 Jun 2026 13:13:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C508315D33
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:13:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781961188; cv=none; b=fIXHFIBOvAB9BKh+07IhSjiQD5RX6r0EsLwunBgL41qrV6r0KfKyrp9fBH5zoz2QRg2Hy0yyqXtknTB9DIYRNe6sc+j2KgqfAdaAM09A73d1aa4/Mex+epUtbkVdlPifZQseLs7AewHZoR20ArTmHVpeFAAXdZaCOSjvU40wctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781961188; c=relaxed/simple;
	bh=mt/3ILTG+XNwiIzhNrlbnzFKkgephpF+6bXQ/A6h+gg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f6JQQ+1tKlL209ClMKzcx7gqT/OdPS0fCC4O2SSdjIsEuOygIamhakmdrsWEuGGzO261df4gsKYirgtErphwGnVoZfQ7qe+/H7G/pp/bNL4ZolDbkk5uAxazZ5Qyg3HDEoMc1lxvAv3ZFSAq4rykUudenun8WTd9s7vFHmkWxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMf8iBLW; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c379e8ffso24401395ad.3
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781961185; x=1782565985; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s369gC1gwT7dsz7DMcgFie9Oig2M6XFOV+HnD3kXY14=;
        b=JMf8iBLWUo0pHXTpVGcg7eBWd6CQssM/iqVqLcrADrlinj+4r9/3fn+toxNuSQL3vy
         xHOP9ZbB5eBBloDN+AWXrP5N8eCjyUzn2i4opAEridKv40/C7Lj2CCaXWXAJ/7j7JmU+
         /JW3HDsdRTg4yTS9repa5nLlBP3AoU230eIV3bu5Uv1YcFya7dluEbkY2pRIJ4uxKm18
         p70fiIZK1Jxj0iTTeZvSRrUKhMZ3BXNRFCvm1tlvHKw9KcqCXgY0pyBAVArF4pSbU4uF
         MAaZWx+zffcnDlnd0H2VmuXtJSHrHSWGyLQKVpJYVsuijymKOTr1tBZkgFBkdb1NNOPb
         l79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781961185; x=1782565985;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s369gC1gwT7dsz7DMcgFie9Oig2M6XFOV+HnD3kXY14=;
        b=nDP+k693vRS4gUjcmDBEnSzkfLaSYqS9IPiiJlu8CAXkbybyRv47rc9ryurEZnDD9V
         0jeOW1GQRwxDFxa5gWvjrOERhnEDLJkIMU4LrAaBB700i4UXGwJY89n3H/tPBhZ7Xfu6
         VIL48iS92SsPmuCSvSAs/AwU9Uc2ffO47+bFLPoXlFU7jAt3JLLAMU+ebcq36O3XbCFh
         YXbWva3exYwAAkBiaO2eiLzkiNZJ0tkji8T2wr64FL91yQkbDo+s2c9DoxrPI5Uwd2H2
         /EIksttxWRwzmJ8fD0ZvArQbSX835GhIn0pM/t3ulEKkXSUVnQIKEkuEmWPzE39t+kBo
         8elg==
X-Forwarded-Encrypted: i=1; AFNElJ8xJOPGP4ofhMcogWxODdijnHk9qWUKH98M3E5XWYbOQHpzqwmhg1CKVC/NLZ9hmsAQ85kNEL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5IZ6xtqt9AVWExvKtqMpPw9RHRRqvtp82E9pzn8efAZ7mDGH
	XIGNMNofgott45jSzsak60SrNFjL4ulpqVLgMvKUBeVs7fPddfP+HJF1
X-Gm-Gg: AfdE7ckxsgYD3KJjTzfGfnoWPlC7kfYfL8mHNobiwJrWQ+N89NZ6proxqnCZW/gRf/u
	T6Ly8Btk5TdenOUEWa1lqstBJm+Z45WGc7fxx2uai8JlHAmkHr2xY+qo80JGeWIgxEDGRyyUsWM
	zmbN4i7D9pPTSPB6EEHfiE49pdAMwd22QnKtcsqQ0mWzxbS9x0Em9H+z8aVv2LXjHlz2iHFVvCc
	SNQkBpBnsFnfpaGMt5AxJPyIWpL4CAmCDxH2Ge/eoOWJbK9VrYEoC38b53b0guCvLLn5OPzX/D4
	T2qkDPl2d2/3inIMcydlFvkigFmCeub8ZtC+99slasABxtWtyy+9i/wtEOoX4tD/P5835zFdQAS
	ccSn4A0652lanWJlenU5I4hL3IK7g/8W12oo6qnXFwH707wB5HanCmeWSUAjen53Lohjat3OYAu
	nPmndGMdzSEjYOpehASVk7lF7TINBdc3k9WC/Yvw==
X-Received: by 2002:a17:903:41c2:b0:2c0:b081:849a with SMTP id d9443c01a7336-2c71901c644mr79485055ad.30.1781961185503;
        Sat, 20 Jun 2026 06:13:05 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af57asm27653775ad.13.2026.06.20.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:13:04 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2] net: wwan: iosm: bound device offsets in the MUX
 downlink decoder
Date: Sat, 20 Jun 2026 21:13:00 +0800
Message-ID: <178196118045.462404.11069139160448641355@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 192FD6A8EDF

mux_dl_adb_decode() walks a chain of aggregated datagram tables using
offsets and lengths taken from the modem. first_table_index,
next_table_index, table_length, datagram_index and datagram_length are
all device supplied le values. Only first_table_index was checked, and
only for being non zero. The decoder then formed adth = block +
adth_index and read the table header and the datagram entries with no
bound against the received skb. A modem that reports an index or a
length past the downlink buffer makes the decoder read out of bounds.

The buffer is IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE and skb->len is at most
that, so skb->len is the real limit, but none of these in band offsets
were checked against it.

Validate every device offset and length against skb->len before use.
The block header must fit. Each table header, on entry and after every
next_table_index, must lie inside the skb. The datagram table must fit.
Each datagram index and length must stay inside the skb. The header
padding must not exceed the datagram length so the receive length does
not wrap.

This was reproduced under KASAN as a slab out of bounds read on a normal
downlink receive once the iosm net device is up.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Changes in v2:
- mux_dl_process_dg now uses intermediate native endian locals dg_index
  and dg_len so the bound checks read cleaner and avoid the repeated
  le32_to_cpu conversions, per Loic Poulain's review. No functional
  change.

Link to v1: https://lore.kernel.org/all/178185979029.4044562.9993615975949055530@maoyixie.com/

 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 33 ++++++++++++++++------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index bff46f7ca59f..ff9a4bc52f29 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -553,19 +553,21 @@ static int mux_dl_process_dg(struct iosm_mux *ipc_mux, struct mux_adbh *adbh,
 	u32 packet_offset, i, rc, dg_len;
 
 	for (i = 0; i < nr_of_dg; i++, dg++) {
-		if (le32_to_cpu(dg->datagram_index)
-				< sizeof(struct mux_adbh))
+		u32 dg_index = le32_to_cpu(dg->datagram_index);
+
+		dg_len = le16_to_cpu(dg->datagram_length);
+
+		if (dg_index < sizeof(struct mux_adbh))
 			goto dg_error;
 
-		/* Is the packet inside of the ADB */
-		if (le32_to_cpu(dg->datagram_index) >=
-					le32_to_cpu(adbh->block_length)) {
+		/* Is the packet inside of the ADB and the received skb ? */
+		if (dg_index >= le32_to_cpu(adbh->block_length) ||
+		    dg_index >= skb->len ||
+		    dg_len > skb->len - dg_index ||
+		    dl_head_pad_len >= dg_len) {
 			goto dg_error;
 		} else {
-			packet_offset =
-				le32_to_cpu(dg->datagram_index) +
-				dl_head_pad_len;
-			dg_len = le16_to_cpu(dg->datagram_length);
+			packet_offset = dg_index + dl_head_pad_len;
 			/* Pass the packet to the netif layer. */
 			rc = ipc_mux_net_receive(ipc_mux, if_id, ipc_mux->wwan,
 						 packet_offset,
@@ -595,6 +597,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 	block = skb->data;
 	adbh = (struct mux_adbh *)block;
 
+	/* The block header itself must fit in the received skb. */
+	if (skb->len < sizeof(struct mux_adbh))
+		goto adb_decode_err;
+
 	/* Process the aggregated datagram tables. */
 	adth_index = le32_to_cpu(adbh->first_table_index);
 
@@ -606,6 +612,11 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 
 	/* Loop through mixed session tables. */
 	while (adth_index) {
+		/* The table header must lie within the received skb. */
+		if (adth_index < sizeof(struct mux_adbh) ||
+		    adth_index > skb->len - sizeof(struct mux_adth))
+			goto adb_decode_err;
+
 		/* Get the reference to the table header. */
 		adth = (struct mux_adth *)(block + adth_index);
 
@@ -629,6 +640,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 		if (le16_to_cpu(adth->table_length) < sizeof(struct mux_adth))
 			goto adb_decode_err;
 
+		/* The whole datagram table must fit in the received skb. */
+		if (le16_to_cpu(adth->table_length) > skb->len - adth_index)
+			goto adb_decode_err;
+
 		/* Calculate the number of datagrams. */
 		nr_of_dg = (le16_to_cpu(adth->table_length) -
 					sizeof(struct mux_adth)) /
-- 
2.34.1


