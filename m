Return-Path: <netdev+bounces-242600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826DCC927D3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171813AD160
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64306270ED9;
	Fri, 28 Nov 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wM0Uzo57"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C522FF22;
	Fri, 28 Nov 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345394; cv=none; b=NLXUGinWwHtxhDM7BehMa60oEgvsToI97/uvXzOYy8gS9H5Rf2sBUg4fFsndWa7Jn6kQ/8QAZzPeGQye4GbkCMaRQt7BNMc+HfDtff98k8P8KS20v+Arqm2yuIbGZEt984JeGulAcWX1+MEuppqeRVh1HMGfkiWAQc0hj+kQNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345394; c=relaxed/simple;
	bh=DUN3T/O7mwlU/l8r6nW27JhH8m/idZgjr8EhHI2LDOg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HDTldaKoY/k4naOqjdqJsnMxyH3pMGa77os7Z8Gt96Ufgd1kmMrZgQqjaM9NQwVCqO0jSEB0Mz/Kfp4n/XVkyB/7sx9hDAgFeIr9cBlG+691XWG59OzSxw8yDTaHHzU59zsvQYxZolAz9/5uP7GoB04iXgLU0M81I8dCRIxCAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wM0Uzo57; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764345387; bh=2x4NrfhW0r6HcxkNmJayC02RDyP01HYHt1iraYfcwHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wM0Uzo57G1Lt8R5qLoYsd8qqnljYKgQkt8yjb5iKJnlH2hlKes7Bk/oFqtFa/GsI4
	 LIIXujcF+s1YSTziNsy0p+HJFr4pExm+pw3hm6qR1N79Wnbol21svt0eb4RB9VWNjz
	 c9s6kArGr4GreD1EswLsJoitnvwzCb+d6Z47X76Q=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id E188E693; Fri, 28 Nov 2025 23:56:24 +0800
X-QQ-mid: xmsmtpt1764345384t4lrfosg6
Message-ID: <tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com>
X-QQ-XMAILINFO: NwpXcT7OGK/nWUuM2KhDeF5qZqNn3Jy9wM6Ohkx6S8a9Pq379RB5czpOeEMinM
	 SgTrvQ240z9WKCiJr6g62qX1JmxUBJMzZlCDWMe8lVQOdd8kYdg447jPuxowCuCGdGvFy1sIZ+Zy
	 9qwwEmgPBTmKG9R42sbNykLysuZlzkh94ZlEaGp3reQVkNcuRzvtUbzuw/DkAE7VUkKvNlFMMmLC
	 wMylPF58bOMyTAinytz2D7UNSP31La3Y6pWzjuGwkopZiQTaWChfUna+bgSDhcWVpGVup/ZH6OSN
	 TqucQ/r//2IK206tg0d4iaWkXp3SbPMRc3HKXFehfn4IY+bF/HVWcGqI+P5UekN6JD5PpGCzE7v/
	 7hVOmbDPnh9KyYMD00IHIje9ym2tQ+Hbc63OhwxI50jLTxHgURgazmzYJpmGloTLeIQ6vhg0993R
	 CpPDXYzyRp3fuD3NB/X07MPtT1weq+a1hkOayWmwdxjpd85sktttu45F9vXMHYSbOrdvDD3s6ers
	 OrPx2DFdbDO+7ermGZEoYm4PO/A1wvZe3gDvnqETJwr7tHoLRuUiMBdzeGM83yMFBf0bYPun1J+K
	 p/jWFLMCykdJ71WA/Fs4pyuWe3A+0Fo/Lh7fEZSZy4+wB4FdONP6Vx5s6RpFXXO2lfsSFuImU0A3
	 VztsU57ZW6wCtBrj9/EhvYLfVVROkVVMd7om7iCfefPznB2MVAWPiCvY23gaeCVEOZeyngt6j2du
	 E0K1LgbdFOS0Uj5OR0pNJjBwTJzd75AyZhXbnPwUXV5T3mu1ZUbYgQ07v5d/xT+E21Hm6aVHaohu
	 gQzVfm+mGo1GcEynZKmNmXUF1tOMyV52TF2BVoHNmE8928ZnI926k3KFBn3OrWrM7s+cHbaAwARS
	 r40VX0L2soQRh84RtHhdmnplED39ETQcJgfMlVoQFqu/2gc4GEy4OlEi/Bai6PLs+VPYwCe/sqkM
	 e6JcwpHe9Exs+k0aQ3f85bTdMrStZ81WuboStjzhiaJWoNVRkJz1DJhhzBoo+9
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] net: atm: targetless need more input msg
Date: Fri, 28 Nov 2025 23:56:25 +0800
X-OQ-MSGID: <20251128155624.134731-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69298e9d.a70a0220.d98e3.013a.GAE@google.com>
References: <69298e9d.a70a0220.d98e3.013a.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot found an uninitialized targetless variable. The user-provided
data was only 28 bytes long, but initializing targetless requires at
least 44 bytes. This discrepancy ultimately led to the uninitialized
variable access issue reported by syzbot [1].

Adding a message length check to the arp update process eliminates
the uninitialized issue in [1].

[1]
BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
 lec_arp_update net/atm/lec.c:1845 [inline]
 lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
 vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650

Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/atm/lec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index afb8d3eb2185..178132b2771a 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -382,6 +382,15 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 			break;
 		fallthrough;
 	case l_arp_update:
+	{
+		int need_size = offsetofend(struct atmlec_msg,
+				content.normal.targetless_le_arp);
+		if (skb->len < need_size) {
+			pr_info("Input msg size too small, need %d got %u\n",
+				 need_size, skb->len);
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
 		lec_arp_update(priv, mesg->content.normal.mac_addr,
 			       mesg->content.normal.atm_addr,
 			       mesg->content.normal.flag,
@@ -394,6 +403,7 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 					    tmp, mesg->sizeoftlvs);
 		}
 		break;
+	}
 	case l_config:
 		priv->maximum_unknown_frame_count =
 		    mesg->content.config.maximum_unknown_frame_count;
-- 
2.43.0


