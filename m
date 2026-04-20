Return-Path: <netdev+bounces-279685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CDJKVHl5WlkpAEAu9opvQ
	(envelope-from <netdev+bounces-279685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:35:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D20428369
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C3453075B29
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0F5388E4B;
	Mon, 20 Apr 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFIjokuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C082F49F1
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673712; cv=none; b=Fr29AnrGqM1S8j18tW5gNdwjffPbg5aBPMPnFS3WYAjc8EZNMRdiRMijlGEDhFUr0zqTFCoy8yZ142ynbVAAp8q9jqp6GxLaMi6X7i0H644XzVHku4YHHFOA1/xmoDxe93isQMN8LdLpmHNY33uJxl7nTp2I2JhGMguKTenxqBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673712; c=relaxed/simple;
	bh=JoQ/dtzaAG1Wm70JNPQk2Dc6RgytNEkXxIb9VjggRW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JC0IRh7c0gCXV3Ui6RH6OZ5h4tbwU64l3QyfJme/JuM8PCBemRUvI3i9oVX9h4YEoLH3lPvX3vEclc/G8XyyNpPtQ8vxB9W4x4a4DoW9cwYUYAyVP3o2soG30tn46RFqxaytyxwJv5Q639JP/5+y//iZfaJ4wfVWYRoRnUDOvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFIjokuX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d965648a2so2356053a91.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673711; x=1777278511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRDahej0krcsoJOw6RQ2fK12XeV0DzeNJyhXEkJvsCo=;
        b=lFIjokuXvfBYZu4PHk0gCvNw2iiy/Y1KGLz7beH0jcjg8k+5Wpze7qdwCH0O9B8hNv
         yirMzIbRuBfPWY4VFTW4VmkmQuKohu/uDeBzypihKPLz8K13XqrKz3ODBtmQ0BTrGXoq
         n6fsyq0jBxKL2x+gewiFPDt0Dx/nSOGqJB1flo3kU0NRr8F4NUYpEMzBgGcaDibJGr5O
         nc4dOj7KcnlCMNXrI8GQWFXktDI50mlYQ0YxbVEPOz02WlFtGY0ahDD7ucxx0SDfwhgi
         eItWBDsRpgUx22jYSc5J2D5rWJOl9fIUIRik7ZQ1LCpR9XVBRS6JpsUmUWJ936SUV7E7
         0UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673711; x=1777278511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRDahej0krcsoJOw6RQ2fK12XeV0DzeNJyhXEkJvsCo=;
        b=daJPfKfjNw3kqg5JUTDzOHX7q65HGs/IJa3yb5engXnMAUEbL3IhtDDcV8vSX13k0D
         eioywnHNIGkOx0IXGACIJ+dn9hzPQI5MZEFRJv1bSsMT1ytrVDCCkxAu36ArE8AxSkip
         Lj7LUQ+SjyUaGgCals1QyhLLEJNMgAMWX3mW21tolBNbaFKn8UFMv8F87ylSa3nSYuSe
         erkHNX7PO4L1MqHe8Sj9l2fSyrlMdko57KiOawXitLE1JkjmMXedy52+W379catlzTog
         /JafXGAnRKPEVtx8tlW2MWkPljFV9RZUXK9AW6mADuu7X0WuKSVJA0FwjxNrO6Ame/pr
         PHLw==
X-Forwarded-Encrypted: i=1; AFNElJ9TdQYH03w4Ez5g+kECibVYky1nebZL56NPeicFO+M62dI0Tnk+h8ACd80EQGjGIrGF2/nBO40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LELuLmYDAmsdPVBqs9fTqUhFLjji4rGJLdxGiyQPGcz/G5p/
	1GtorZ0Am6SDcAbcjI8/R8/DP4eO/ghr0YGiWmcf9dBJ9yb/NditNfyc
X-Gm-Gg: AeBDies4ArdW7EPPaFJlAn6pPykACQwYW1nvNnQZgl8khn9JVkel5If228/M+2suwWd
	cigwftJSrk2ri2UhSuvTA7Kn+N9iHkh+J8g5vLrrx9rMYiR93PuHfnHoBB+rZ8AD5qGpSlZJu23
	lvn+7CYqjE2duIP9rVBfVEMW1EewGXt7Rt664BRpyexPjNljJeUV1Cn8Mgk5GT5qip6sYqe6w++
	+bZfdGu1Xk+N/nKXuSD2vyW+hp+nDI6L8Q991l+bWjU+5NZ/A/PHZNvI3jdNwundJVYl91zAJDa
	hAtbVpvlP1oOUNwrkh9fsrBbin6k1FhASyDRzlZkXm3uqZxMWUwHLsZLI9DrdOUlB3LlcRllukH
	5tW2WY7zePmuXYfvZ35kzReJDfsyM4sGpwjcGjxWgOpRl0mN9T1wlxNX9vQEemKrS6e6pYVsVz2
	S8b5vfH9QgRPi9STTDuvC9cKMwCstyYimM9vcu+doFO1c8om8UDqxX8+aUwi8HWZ8HuY9bg6BdK
	e8LB5xq
X-Received: by 2002:a17:90b:3f84:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-36140468c28mr12543900a91.17.1776673711144;
        Mon, 20 Apr 2026 01:28:31 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 3/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Mon, 20 Apr 2026 16:28:00 +0800
Message-Id: <20260420082805.14844-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.963];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 17D20428369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding
any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
to accumulate subsequent descriptors.

If a continuation descriptor fails (e.g. alloc_page returns NULL with
-EAGAIN), we jump to free_err where the condition:

  if (skb && !skb_shinfo(skb)->nr_frags)
      kfree_skb(skb);

evaluates to true because nr_frags is still 0 (the first descriptor
used the linear area, not frags). This frees the skb while xs->skb
still points to it, creating a dangling pointer. On the next transmit
attempt or socket close, xs->skb is dereferenced, causing a
use-after-free or double-free.

Fix by adding a !xs->skb check to the condition, ensuring we only free
skbs that were freshly allocated in this call (xs->skb is NULL) and
never free an in-progress multi-buffer skb that the caller still
references.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6521604f8d42..4fdd1a45a9bd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3


