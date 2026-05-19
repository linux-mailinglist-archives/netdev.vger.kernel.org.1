Return-Path: <netdev+bounces-289300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILkxIpUQDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:26:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971D57903D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2979B30074A9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE563D3481;
	Tue, 19 May 2026 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8VtNZt+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A413D25DC
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175570; cv=none; b=jO6FzTCi7dL1XzeZ2c3jNe7aps0ZbGG+MWdckiM4WxoyI40u3gsdVLtbvi0Izp8yFVB7iHEHYZjrvRVk8fU+KhaNXtpm8vJLQ8lCuF0uAuE5X9GoORD/qtQgfT+zjfnHsQ5RNHuXzU8fqJ5/F1PjHnsQ006LsXrOZFI2/UgWlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175570; c=relaxed/simple;
	bh=E5tbrL6gDSZ/C+kamk4PKO0Wqa9UDvCknl/PJPOeSAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXBu5RP0vnpv2x6G1v5YeKNuGNa/rkWUxYCwa5XygNyRmjNhumcRBRQk03CXqKYXjsFC/IYNi8P8qWKo7/F8ELhkAZon5d3aFrCSGZTMqMxapABl6G2wU3G+/f6m4KyXpaBj4XI6pf06VIX/PRpclmG8ADFnRXd5bm6I6f0Surk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8VtNZt+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d75312379so2749723f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779175568; x=1779780368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=a8VtNZt+5y+ixT244aAYDcFwUDEJcJkqTr8ACOGDp6cbyE9XPvTx06mQiZoDp7F1BC
         e0d/fPF0f+iWdNr7sAw3lZLJDWeF0wGmQg1HUhUiQY9E99DFDi0scixr0O/WFsRzbbh5
         x91Q0jqRyNNn0weY6KR10WVirKTZMy2zWmBur7GfTUHWYGRDKV+sSfLRbMoGdjCNDmkr
         ITl8HayIECN9LEsHxtAdnjCxONeSLUyA7+HHO7slBGlkKn/06w3tmUYJDiCYeYlgAHlW
         b7H3l73Fbyty9C0JemelCefvLYxuLHV+bm7DXXKJac7yF1Laf2vD5QaSrs7TSmfxh2sh
         bOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175568; x=1779780368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=LS2gmVcZFeHJG9O9HS079JQS5Lf/fSrpAyLqoSFFYDSS7xibjeCTunqZ7shwsSc5pa
         ciMzxCRRl2/DRJ/TeHR5g6ujW9nJluQGzzd+LILezy/Lg4uSBOKZamwDSJY5ySKv3Y2B
         YQximNC9WgzfUmD+iYBRJdUzFGXt1mQ/Ub29Wnqfd1cfJ4RWhtmvMBCWjvQTJFPyhsOG
         j1Uew8wFPPcrJpEtWtY+owH3Eht0/fJiZMriqv0ml0+0EgYOICLqBRcXucz/OpZUyTEQ
         ftiFhdBepD5itO0PikanT+6ICvhvTivq+ddT3uEOYAYfD7a+o5/zZgIGoB+3vdtM/YjQ
         1wTA==
X-Gm-Message-State: AOJu0YyUlKJXd2lAhPO/yh/0BKmBI8I4hIu1oLaKsiTwcZZk4m5s8BNt
	HvBhCYMEvRVh/BtrcgSia4QEg40yOu0ZztKeSY9vv6LvhJ5BGpY6DdtS
X-Gm-Gg: Acq92OEa8dLPhDjEfgv28+/lCpcwTLnvPyh+JswajO9YcOqe7yB4jaPfJEjKLyZSXVM
	7ZGMVELuXCjy5NHX+WeUK51ha6PWDas4lB8yROffbs11jv70qR458XuVdL4f+iwZijIxZGvC9H6
	KzL50awf0MoQsCtzaIWhuhj5BMAr12EIi3Jdf+HGOB9Bzg/gEpwvrgDlnFO3Z9ss6qLhUfZw3x8
	rSjUNrheXVrQldGk3xYMr1uBcCyIqtse6nRm5m4DfL9b5tFL0ckqh67SIvN/V6tPiViTE3ZXCDu
	qamMonb21r9JGY3N9PuT/nnkMnqU/h/6Vr9UAydRr6FyFdHA8oyFehxa1qkwmxIHQnDbAgOSqtr
	jbClXHH+1PXOlwu8zQPAVRHiP5Ra4aawyX2glvB0xFTd9IeHBvBn1lPgVaasByrzhtDWkz1Z0vS
	MbuV/hQDQOf036Yi33dhAolDalz0mLZM/nwSUgVeSlRuzyNdTbtVenP0CizW601HEaGlVkkZR2O
	Q==
X-Received: by 2002:a05:600c:8485:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48fe537fb70mr3651885e9.9.1779175567423;
        Tue, 19 May 2026 00:26:07 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88e5asm327422845e9.6.2026.05.19.00.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:26:07 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kees@kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 03:25:47 -0400
Message-ID: <20260519072547.33974-1-meatuni001@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-289300-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4971D57903D
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
Cc: stable@vger.kernel.org
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


