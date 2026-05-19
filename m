Return-Path: <netdev+bounces-289579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJNDJ3GpDGpLkgUAu9opvQ
	(envelope-from <netdev+bounces-289579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:18:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA55838AB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 935733020BD1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9CC367F25;
	Tue, 19 May 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtGfUqBY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067D367B8A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214698; cv=none; b=ZqNM5SMlvmwx1zqqjHsLnkfhKzbDjp9pc1Z1jXCTJGYIJsnIL6EqSBpLbNKi+lv+0WYOPF4X17wqJ0JvT19sETjcezzxuEGMKj1zcAAmPFj/Klbh3IXLX1IC0Cp7t4XiUV9PrzYvVfg/scr86PQmhDNyRYdLiAjTOq6KVOhiRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214698; c=relaxed/simple;
	bh=eXHp82baqxaLH1q4iRY469trvVd0cOQSdBovZjXWxvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAcBa92irGMNKnqc/3F+twl6FTk6Pq4ViK9K2m0BoitxLnpecTGWzRkxZhlECJq2GMfA4HUh0kUIsW0UgiCnJOz/3A/CkEC/Y9LGzX2BPUsaE1Waua9LkRBVOFqPyZQuzXzDLi93T9edpWLW9qw9z9TLstX1nrDTRbz2b3fCbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtGfUqBY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-449de065cb3so3650470f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214695; x=1779819495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqmfQ0wqvW/5YkQLpj5T9YPDYLhpHMgWUpuXe2X6Ab4=;
        b=qtGfUqBYduP1Yqkr80hR5CRBMSAVJ/GH5tic7dtOMSJy0cHxqs0oYFbEFMJXPIyDMa
         vt5BYb2doWXGl5USANsICHwuIr8zrTlwZMbvyV59toTY14aIkI/DTpmKJ2VUQKu0iJx2
         jG4TI6zNHoT9cAeRSG85IGvVr0weQpp02Mx8kUTlXQyJkmaGFdDk01FuOzomnKzuuTpz
         kEeprK3vNKmY1yuDjLIEvI/7eiLxCenY7YL+zyOIIfrnP2cA7mDd1lmp4fGBgGilPLuc
         XplfuMCpepzt/LvswZdv7UKJx2Wg58FgbM83dCvUrZk1UoVVFsRu41F9G0bbSHaIEg8t
         rkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214695; x=1779819495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqmfQ0wqvW/5YkQLpj5T9YPDYLhpHMgWUpuXe2X6Ab4=;
        b=tGti0dlnICJPenLtwdUjHqg4/SRsmDX6f5iRq/EFlQq3ZLyKY/dkZ/+7lX8MHvlRdN
         aNAYUt2upx22u5OukKzX3SAkaQuVGsbLPqvf70/+VWlaMura2zpDqGeqXwIpv6gAO0M1
         bmZ5QoLYpNzgIQ8kbZzy0l6x6/uXnrM4rXVSn+A9xDz8MEJWykdSEmcgar0DWMD+Z36q
         1te8oBYa12saSk6/7TrFl6XkpPhrgg+OGhDljW5iMmAeH7za9DroLCyURvaiXs443Z8J
         teMPikhdbAf3S+/ci4TvFY2NEFiB76rHRgj+IGgmX6seOseG98kuln9uvfSu6j9S3xd6
         ufnQ==
X-Gm-Message-State: AOJu0YzRNKZP+5Yr8dEtgfZtPN3x7B+Y9A3ysbboGJabr8dA+Kepb2+2
	RlK+MuWyRuK9qRDP1Eh8X9jwkKnu6WskCckZm4FU47mmCQ7VHkti39Rq
X-Gm-Gg: Acq92OErAerqEoxZK2ZH8TOPYI9UVRO52jCettG4EbcDdpMVuu6B70K56Lc8SNR7X7I
	Y4Jyr735/ULMPah8g0wFRSxLBkDujH7uilaKZzXigrqjGBN++F3LfCW1wg6MbOeStd90hkKzLw/
	AdB6z/ldsGVoJDWRpJ8We27qgQX5p/EfOPSyZKJBgMb6IOapU4hh75WW3JBhmBX/RIjx5hso6Sk
	I5z2EAECG58hQU2iRYF7qLlFyrAeUlRxMT6Q90a5HyB9ytJv5I8x4rndYqrXPCRiJnS9/Rq/qrC
	UHMXHYnVe5yMmN9jJyjKVkWIM9uwgoZI8ppx52MMYv30nmSK4tm2NLSHwqoTsb76PMTSOuAnc3P
	va7glihl21r73ekARtwQQtINay2opqxnGLrrsLslv7GTv71EbZqOJd9FVpI7eqBK+89VqZJWhE/
	GF9WmiJUfkbHssmOcK3TVBmbb8e4g1Xo3h3JfyIGa1EMxp1++Ms9xdkGsKJP73ohMsCYUT/E6Vr
	hKum1HxgKHS
X-Received: by 2002:a05:6000:1845:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-45e5c57d2fdmr33277547f8f.6.1779214695304;
        Tue, 19 May 2026 11:18:15 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm49915487f8f.23.2026.05.19.11.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:18:14 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 14:17:49 -0400
Message-ID: <20260519181749.15746-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
References: <20260519042017.29564-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-289579-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9CDA55838AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

        skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Replace the open-coded cast with skb_pull_data() which validates
skb->len against sizeof(*hdr) and advances skb->data atomically.
Save the original skb->data as frame_start before the pull so that
__check_fcs() receives the header bytes as required by the RFCOMM
FCS specification. Guard against a missing FCS byte with an explicit
skb->len < 1 check. Replace the unsafe skb->tail decrement and
skb_tail_pointer() call with a direct end-of-data index and skb_trim().

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

---
v3:
 - Replace open-coded cast with skb_pull_data() per Luiz's review
 - Save frame_start before skb_pull_data(); pass it to __check_fcs()
   to preserve correct FCS validation over the header bytes
 - Replace skb->tail decrement with skb_trim() per Luiz's review
v2:
 - Fix GitLint B3: replace tab with spaces in commit body
 - Add Cc: stable@vger.kernel.org
---
 net/bluetooth/rfcomm/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..66eee8a86 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,23 +1741,29 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
+	u8 *frame_start;
 	u8 type, dlci, fcs;
 
 	if (!s) {
-		/* no session, so free socket data */
 		kfree_skb(skb);
 		return s;
 	}
 
+	frame_start = skb->data;
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr || skb->len < 1) {
+		kfree_skb(skb);
+		return s;
+	}
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
 	/* Trim FCS */
-	skb->len--; skb->tail--;
-	fcs = *(u8 *)skb_tail_pointer(skb);
+	fcs = skb->data[skb->len - 1];
+	skb_trim(skb, skb->len - 1);
 
-	if (__check_fcs(skb->data, type, fcs)) {
+	if (__check_fcs(frame_start, type, fcs)) {
 		BT_ERR("bad checksum in packet");
 		kfree_skb(skb);
 		return s;
-- 
2.54.0


