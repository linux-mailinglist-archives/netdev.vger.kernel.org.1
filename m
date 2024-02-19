Return-Path: <netdev+bounces-72801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D4859AFB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EAA1C211A2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61163210D;
	Mon, 19 Feb 2024 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKbB1S71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEC4C81
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313359; cv=none; b=IxR/5Dv1lsTS6HChoRLFKJgGSH1hZpk9BiQ2WmJPXpXkc2Rmunb1yQvqlhkInbsLmjGI+iog4c7e8mtKuycF91N5I7gM3CPwZtj4RpvXES6P+Fuh5ku2VVkNbHoGdvsJXEIP28jfjIXnBDOAzlgXdcoaeIxAXlxn6LdIkD46xYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313359; c=relaxed/simple;
	bh=beTa8kvuVAR1xuuwoOtkmKnK0Wn7xIsrcdGr8CPSjQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQt0ADKsoMj6P7cungGRu2VZBu/gHt7k1AdxdygRWGnlBw9WSvJtoiE0EEMcE7f9D8U0kGd6sv6i29rrk4WXrGMwVY2Yc5+wWZOW1Cg/++Q40ScPnnISQ2nmWTxjh/tEi0KMqqOsz6xjpDVx8PPh7HTB8vIuSprozvPCc6RyHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKbB1S71; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3289029a12.1
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313357; x=1708918157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiHRSiDQCWhkRJWyWtx70sVdTRuKjyaav9BVyuxi7cY=;
        b=aKbB1S71/OtlO8K6WMPK42aXWaJcxBqkGcAUoOhF6CC5btbZU539+RdB2lPoTzoGoa
         ngGKmEWRmHX3yQtlu0QM0JAmea8iDAlhfhKcJd54Od98O9iJVuAkduV/WZBBpkwUr5Mp
         Ft3cZfBvOzxKCH9M5V/c64n/h64krxr0UERzjxRHfWv10v+ivJEUcz/l8DQ78hN+tjTX
         9Lm5HMF10YNxCMlgpD7H10XgCuYPh60RUSkSm0TfYCbK5gUf8Uo6KPkB0KLzFuKyjOMl
         dzlDJ+kQd2KOgktR7nowp66uOPHzzGfi1WL+6IT95dx9h0TRb/WP8kR+p6IF3kn0seVM
         bdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313357; x=1708918157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiHRSiDQCWhkRJWyWtx70sVdTRuKjyaav9BVyuxi7cY=;
        b=wrmT3qk89V3EX+0+QyIu04F0cs9xUHf19AlzNX/bMFDH8WwjM6h0xezVzfYVqxA6Eh
         GsVj/uXvVCEbn4BsRFTrmyrEinG0Yz0VgvhSTCVjX4VsktumS9ON+D0Kd+W3xsGkBeUl
         vSEuLc5o46tO4W7SFnfDQkZfS/oTWzbGaIXc/DrnGEYmWdvRu+wMbhSURXvdexEj56UZ
         Vf5G/1AHanCJd16D+kx2lrvlsjmx9rIdAQMmU3pcQC9kt2xCjFBAAhre14T6Rv4oCH0s
         7NzBeQP4OQTqlLAAn+wMi8dwGZFCFeTF8Vvm40b3HEIAbiFGD1sdUhTGZW6hiykzD11Z
         jJww==
X-Gm-Message-State: AOJu0YxezwZ4MbJU+UKX66Yh/YC1YVFLfvrm4+Ptd8OZoFfXhjCXo0ZS
	7lnw2PVip5tJW8cPwf76spv7TNvPTtFnT9ML16mqP1dQyVkBcuVG6vxiFRFFvEs=
X-Google-Smtp-Source: AGHT+IE/zQLb4Z0dHXYFREmyhWutCKpuQF4hy7nIodsYXy3I3wJE2HvAw7YBdEexEEj8728C9R0zwQ==
X-Received: by 2002:a05:6a21:9206:b0:19e:be5c:b7c6 with SMTP id tl6-20020a056a21920600b0019ebe5cb7c6mr15774250pzb.45.1708313357248;
        Sun, 18 Feb 2024 19:29:17 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:16 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 02/11] tcp: directly drop skb in cookie check for ipv4
Date: Mon, 19 Feb 2024 11:28:29 +0800
Message-Id: <20240219032838.91723-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240219032838.91723-1-kerneljasonxing@gmail.com>
References: <20240219032838.91723-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
no other changes made. It can help us refine the specific drop reasons
later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/syncookies.c | 4 ++++
 net/ipv4/tcp_ipv4.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index be88bf586ff9..38f331da6677 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct rtable *rt;
 	__u8 rcv_wscale;
 	int full_space;
+	SKB_DR(reason);
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -477,10 +478,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (ret)
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
+	else
+		goto out_drop;
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0c50c5a32b84..0a944e109088 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1915,7 +1915,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v4_cookie_check(sk, skb);
 
 		if (!nsk)
-			goto discard;
+			return 0;
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb)) {
 				rsk = nsk;
-- 
2.37.3


