Return-Path: <netdev+bounces-300653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYtTJOIFNWqPmAYAu9opvQ
	(envelope-from <netdev+bounces-300653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3305A6A4D45
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:03:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lfTcTxsn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300653-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300653-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B29A63014400
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A035E1D1;
	Fri, 19 Jun 2026 09:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BA330666
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:03:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859797; cv=none; b=IfHZ2HbRLdQV+duWMVw+vkgqZZu9aLCYcHXIOor23ZOV2e+/f0KVc8sFO1eVR42HQpdXgkbCKf95HDiw76fIE9heznZ7pxtZNTiyJ1d384IBBgF5oGqc683w9Rv5geTGmgRqTiC/B0+p98Cuf0Xy4TXyRm1U3OwLmMzQrwwooHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859797; c=relaxed/simple;
	bh=ZDMKVKiJ99ZZuTo0IWaiei0vmrhN+tQnlsIgRBvy8hg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V9H4p83xUGie4QZD5X/SOEvR4fXW2wJyE8kUW3OEWsjqiYF/QDTk2UxIw/BQCruktJ+V+nvQWz6+wJiwcNAdJGD/18nc0e7LZ218BczfMqwaeN4duMdG7wIonqZYy+kAEpWkD6FABiSE+wwGE1qHntxNBLFwZ4ew3+RyQYODgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfTcTxsn; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-842307472d4so827894b3a.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781859796; x=1782464596; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6rYFKdT28w7xlw0jk+pEDYESMf9ldPJ9JkhM6PXa+g=;
        b=lfTcTxsnAIGBxffLQBwtxh8cRnLByTGRDojzR58TMA96o+5updz2Cq4Kqr13kSw8j5
         S10biHOxBqAtNjsiLl1kQSLxnpSXB5qOucUJgtsya1Hif4xr7TZ4Ot/zVskPOtuU3z+f
         1Ny95RvVwNt0u+FJcWT+cD/tODttSTk3jV/mVaYzoWyHmSYNkGNyX6zrwkd4LJgEQsws
         ZtzwIcZmRdFWyQGzNSYYVGRmV4vw1uOa2IlotScGoZJ9EBRPqhjiZQHbBa4y6RfUMsNQ
         KoGRZVOCk0HbNsUIPLYvxEoHqtAtAaYn6NBLstCftkFCG8JrHQfQCbDPNvTKpHhcZgDQ
         uqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781859796; x=1782464596;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6rYFKdT28w7xlw0jk+pEDYESMf9ldPJ9JkhM6PXa+g=;
        b=UXHbArsss6gBYPGuVXqxyaJJvn9++Q+hNYpKoTFEkxAvCOu/6TGzr7IL76AaG8SG11
         hcDvUqqQRUXbDEG+11Xm6d84d9GTYg+DutfZb93zoWkJywEUrNxpk3Y53OrrEv+5OzHX
         vqcn9Jcv7m7sxpAR3K625XBu+DF0P4rc6rUrpRoJF8ZzHNPQDr7g3y9fgCr0tRprXVEd
         JRJDVJykR9r5tl+cEuW7APmmrhQEuQLCAH0fnVKs6okF5A8iR6bi50GmI1nfD7mGlPyw
         LxXAOclQlcgmbE8YvhUlSTQs5270FBPEYpFqnAO/wvoT1nlrQotj6HN3XiTgfNszZpG1
         EhAg==
X-Forwarded-Encrypted: i=1; AFNElJ9JzD7+GtaY1eXwRjs8E8RRuM2VWzGQkMO5PK26u42fiJ0Mj/NLwIDCsZnKCs16ADaSRN8yJrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydtY/ABx9EWjsIq19p4K8TFqwV2JgIiPnHQsgDVBZLYE83M+h6
	KYTEYv5lrj1O3zktg9l0i7AioqfZcRgCkEK5zt/umnIbMDm1+RVGqOOh
X-Gm-Gg: AfdE7ckOVB5AWs3KTRHX9M2IcYkZqUJydHkm5WATWz5766A9buPcLksQFG2wF/QFdm2
	4xVFaeWIJFmexaBSMyOKae+mbFsxiY06P7VHUj19kYmypQ5c0TTRAiODGg7O2bIJmagm/E57Fjb
	wp/XCGiYST7V0P8p7pmx0D8Yo0ZTbWmQ/MzkhIDyoVgsETOdfyAauubyhEiY7ZewPz1RtHc8vyh
	XT0QenVR28bZ5tireBD1Ax297hvr+jTzaXwkOVBFF2jQUtXEIWDBXWI+M9lIw15MQG053QcJwK3
	wsR+8Oic8/+cUf8V8q3a/qqf9FhKXzeyumkWVPipbx5MAwvC2tCXD0jGl9v1vrX9uVLgkItzEqf
	n4esiaadsI9LzfkyQFsPMibnYIz2BVUg7vd+yUaSmfcbxCp13HiDo5uUMALf3YwHS4uKejj1ZH5
	M1zAF7NqX/Q5A24M60a6Rt5GqMwWlHde8CV/wq+w==
X-Received: by 2002:a05:6a00:12d6:b0:835:405a:7e6f with SMTP id d2e1a72fcca58-845507bca47mr3121373b3a.14.1781859795694;
        Fri, 19 Jun 2026 02:03:15 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84553829240sm1984824b3a.44.2026.06.19.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:03:14 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH net] net: wwan: iosm: bound device offsets in the MUX downlink decoder
Date: Fri, 19 Jun 2026 17:03:10 +0800
Message-ID: <178185979029.4044562.9993615975949055530@maoyixie.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300653-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,maoyixie.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3305A6A4D45

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
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index bff46f7ca59f..1c021bb0aa7a 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -557,15 +557,21 @@ static int mux_dl_process_dg(struct iosm_mux *ipc_mux, struct mux_adbh *adbh,
 				< sizeof(struct mux_adbh))
 			goto dg_error;
 
-		/* Is the packet inside of the ADB */
+		/* Is the packet inside of the ADB and the received skb ? */
 		if (le32_to_cpu(dg->datagram_index) >=
-					le32_to_cpu(adbh->block_length)) {
+					le32_to_cpu(adbh->block_length) ||
+		    le32_to_cpu(dg->datagram_index) >= skb->len ||
+		    le16_to_cpu(dg->datagram_length) >
+			    skb->len - le32_to_cpu(dg->datagram_index)) {
 			goto dg_error;
 		} else {
 			packet_offset =
 				le32_to_cpu(dg->datagram_index) +
 				dl_head_pad_len;
 			dg_len = le16_to_cpu(dg->datagram_length);
+			/* The header padding must not exceed the datagram. */
+			if (dl_head_pad_len >= dg_len)
+				goto dg_error;
 			/* Pass the packet to the netif layer. */
 			rc = ipc_mux_net_receive(ipc_mux, if_id, ipc_mux->wwan,
 						 packet_offset,
@@ -595,6 +601,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 	block = skb->data;
 	adbh = (struct mux_adbh *)block;
 
+	/* The block header itself must fit in the received skb. */
+	if (skb->len < sizeof(struct mux_adbh))
+		goto adb_decode_err;
+
 	/* Process the aggregated datagram tables. */
 	adth_index = le32_to_cpu(adbh->first_table_index);
 
@@ -606,6 +616,11 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 
 	/* Loop through mixed session tables. */
 	while (adth_index) {
+		/* The table header must lie within the received skb. */
+		if (adth_index < sizeof(struct mux_adbh) ||
+		    adth_index > skb->len - sizeof(struct mux_adth))
+			goto adb_decode_err;
+
 		/* Get the reference to the table header. */
 		adth = (struct mux_adth *)(block + adth_index);
 
@@ -629,6 +644,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
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


