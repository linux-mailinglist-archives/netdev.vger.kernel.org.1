Return-Path: <netdev+bounces-289268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGe0MzPlC2r+QAUAu9opvQ
	(envelope-from <netdev+bounces-289268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A6577342
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 228DB304D709
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FF930499A;
	Tue, 19 May 2026 04:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN+9HMmP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6EF2D7DC6
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779164450; cv=none; b=UiWneYQ6KMuxewJeiWjSyK4RmqTgUV9BmPZbV9tRK5wd935ONq+aiM17gOBbDekBqfelMnc6wPg19ef9qERDqrYCJGT+ppOtZr9R6NI2R0lO3YiDpuVT70Ho4cwYO1bH9T/AdSXUUmT7KeErf49gc2IuhNuDQeGE35QLKUreV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779164450; c=relaxed/simple;
	bh=LiV0xUqYF1sDgcQ4JGiJk2vaMfz4EW5Z764wJBePVXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kuwp0R3mY88eXKEpV9Swdyp7x4++e95HO4dyxx/FUXByuwiR/1vdH4URid2Mh+B2RwN0+ZDdprdbgndQtPuYjeDNtQ4r/oiO3h4X8o9m07wlFBe6KSJvK/FohJC4R0DkQpsvmnW4JHDGE4GF2/UwFo6Ba3E77lcCrc9+kbaDwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN+9HMmP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso1443040b3a.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779164447; x=1779769247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUFBQc52UJfk2XrsTn834tkvWEs3F4USHaB2v8AXGtk=;
        b=mN+9HMmPwfWflA/7V+bxot6Y4Hn438kqmFqWq2bw80NYUjYm/3J1Gxto+O/muGvWuo
         OxJUihMzIi5Alo3NMs2cw2VHEIbgU4Mi/dwFz2ycRazpYswheoQUQ1coLAFQ/ojOZNwr
         LCv+SSpzQIxl4ufz6zbZbaM3Jcgvds6sIgICsa/9OymWQUqZ4oZzM9DaVBp/9NjNW0wb
         WcDvOVCRbbsOApabXyUjWNfPAiOioOTj9rJbh2p1uA/XdO88/+LIpluveUIwOFNyHD2z
         ECaet5dPLoOKGWT/tSS17wzKjnTGjxxmNi+7oKIiMyUJnUYXIXzz7YnqshMxPSJTrNmW
         tPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779164447; x=1779769247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUFBQc52UJfk2XrsTn834tkvWEs3F4USHaB2v8AXGtk=;
        b=dVwITiiW9Pas2xAcV+FJFeaSPwu3pAV0rp99P9AwwFaxBhx8wwuS9WAvczxlgQSXkg
         mdkoXR9gk9wZ/Pd5gBEWrT49ulYFk/IE3iepteAe5MIP+GhGnlpWREcMLpu3LZOGXJKS
         FWQ118gMZk1z+NeH7YFn9Ve8dQkRe1Jyh4x5KSuD2ZjM+Cc++0ec/7KkPLl1koOjqo++
         EwJeVk1OZeh8I6SMRiPYagtU6oeZ5Sk04FCZpy8sbzDeX214miWO4FPTBqE03eotBGQo
         0W/L2UjhbScIhLs7AaJmQLYJoElVjxfT1SbeiKAqWSvWPYWB31zkx0EYQbZfp9F+ylPf
         eeNQ==
X-Gm-Message-State: AOJu0YyBK1VOAKFEN7WQ5rR+KJsCqUep72JHawBM/Zi+FL4M1YFoTu5O
	gDlpzvxvDncEK2mGDzMEhuSW5ZxvVjXE1vaBH/jBbYgLZouCvQ5g98TC
X-Gm-Gg: Acq92OF7OxJWVP+e6zWt15Skhfjg8/d/zYcNENbAZvhq2eiu2qRE8AYDZZx+FQZSYY1
	+NsNyD7N8JDlitguXmjIzj/7dChrspIdvfxsMF/J+jtiBn1vQBgklgvh5+zvSTaZj4/XNS8aWgA
	I/ta1FvykD0QAAUJC2+U9zzN5AwFF8a7Ns73WATI6tC+ph6ssuxUQ9h5qDq8OnUs/GaIUFClbme
	wpNFbleS68X6IMypCBVYzsYlnRVlx9GrKLiy/lGJkAV9JX38NJQSGax2/w7dyeb/9caFnAA3/CK
	0S3HzTK1IudnRCdA/wqw/m3SGFo2dqqiXVm5/73ToT8WyqBUoa7AFgNWiGieJKr1/yaMylHqHRx
	LP+opTHvEX2HUVRXN9jVpZK/uE5eDjCYrg5ET+g2aKXz22VzmgVbX/2LGhPzN+JiGBSHukdMSTG
	eYzW/saBKrIqpZoKrLaQqJdFPniEGfr5teHnh3nvCeiLyljAGPNAj5Uwgd91+GqHJzqCutzn6wY
	Q==
X-Received: by 2002:a05:6a00:2394:b0:82c:7420:82bf with SMTP id d2e1a72fcca58-83f33c8a27amr13455006b3a.19.1779164446475;
        Mon, 18 May 2026 21:20:46 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b4bfsm16929148b3a.28.2026.05.18.21.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:20:46 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 00:20:17 -0400
Message-ID: <20260519042017.29564-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-289268-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 885A6577342
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

Add a minimum length check before the header pointer is assigned. A
well-formed RFCOMM frame requires at least addr(1) + ctrl(1) +
len(1) + fcs(1) = sizeof(struct rfcomm_hdr) + 1 bytes. This single
guard prevents both the header out-of-bounds read and the skb->len
integer underflow.

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..6b300237c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,7 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,10 +1750,17 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	/* Minimum valid frame: addr(1) + ctrl(1) + len(1) + fcs(1) */
+	if (skb->len < sizeof(*hdr) + 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
+	hdr = (void *) skb->data;
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
-	/* Trim FCS */
+	/* Trim FCS - safe: skb->len >= sizeof(*hdr) + 1 >= 1 */
 	skb->len--; skb->tail--;
 	fcs = *(u8 *)skb_tail_pointer(skb);
 
-- 
2.54.0


