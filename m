Return-Path: <netdev+bounces-301908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LO+zM53xPGoeuwgAu9opvQ
	(envelope-from <netdev+bounces-301908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:15:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B966C420D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:15:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301908-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301908-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA82F304C2F1
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90665373BEA;
	Thu, 25 Jun 2026 09:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521335AC00
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378626; cv=none; b=ayJc16pt+kk2UwlZGN3+FTbETQ3uvoWJ482Ughl2MSOPn2lUMByZHCR9y9TSQYcgVhTI8su1R0bvF3KqEefUOtg3hBKftkjEHB/foQ1vRaeM8dH/N1M4/B+UF2hGH+TbkPv54soFyOFUBNMLJSLYDcYKyk5ziIOlLJfzfIlOMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378626; c=relaxed/simple;
	bh=PEBEmMy90gH/VhkxoRHvNdAN5Mi8ama6b4nY5UPxTdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxXO5DArUB82fd/PiJW/ofhsTUtR7/QDMKIs7ORJve6R5rNfm54nChbHh0eP62PrPotouBGnMN9ArDKFgxjc/GRAL4BHQJAh4Ydtmd4TZFDfNXbIGjklQG7pKtpzzjq/TJs/7z9YqQbsXNraffhH3xd6UImz7uhOW09esApZakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
X-QQ-mid: zesmtpgz4t1782378540t9e8d38c7
X-QQ-Originating-IP: YBh5evtk62P4jHOxlaba8OdhCzi35ewp6JCcmARGh70=
Received: from w-MS-7E16.trustnetic.com ( [115.204.248.247])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Jun 2026 17:08:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7305110803469154808
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Kees Cook <kees@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: libwx: fix VMDQ mask for 1-queue mode
Date: Thu, 25 Jun 2026 17:08:51 +0800
Message-ID: <60D88ADD3E295420+20260625090851.539640-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NNHaSqFB0TH+6FKDqaHSIXlbwgtswPdDsSGAYTxi/MilrKBgyYDSIqC8
	UgdiAU3gaypk2mS7Ma3PDQr511zz86zF+y9OQ7+JJPcKzdFKXnonUl9/3Auled32Xcrb65s
	Khv9WmbduG7wrNY0sbXnh4DOyOvs4Uba0vYgV+M5kF2wuWkRP+xVH1F8qSwPL4lBr5gccSa
	77IY1FUh9z+odipfpGpqCGEsE6ubR2UsEXnBkylJwOilHYtT9lM3FAM6L2NDYihzZjRfAJV
	Z/WW9mZyMfml5LdEt6giuvq/ReFPNc9hXrKuIaxFx2J0grEsBw6b+7GepmIu/jLyZb/wOWa
	lE98KTu7kBAi5T/24VOBSLYt9TC2nVfWuC0Y4BmCKhocL1ZIofLMCbGTMVypr3Een8tl1TB
	N/LZKmS9FosK83Hnr2OO81H8cskX4CKn/3MQoiIAr7xwkMVxOcjVjYA4glSjQfVYNVi6FfS
	M1VEnlwJXzeNZl0djY8T9sshhBzKDMH5J280cHz1tQBrN4jwN0yVPfFuCgB5JsiOz2hc0aq
	/+CpYvMYNJTLs1QpTbX25GIbK5HiS3DCQ+/0Ory0F3XsGnIo/jGqMirzvN3CObfoSJ7RBCz
	Dw7uIQx+Pc5EHSANKHtsoK0vFp4uyiODWzmEPJF+wsoNHcjhSDsoCTttr/47lQlLzruni2+
	OShtdxscncr44/xlXlSlAd3/I1/EaxeTIqldZ71U2Mv/rTgFNdFtm+219CfQvbOPrTc1fAu
	f3B+hJ3GvtKMwwHWoD5CjWCjYXZwo1aBObblYGkK8dfB7nnzfq+okQa47l2BZdzIyLA+qDY
	ZbbP91TRMw5uaxoKH5NoeT5MSttMKyzd+g4enmLmE34+70rVKkfCSFW8I6t3DYVlWxH2UPg
	EAVD/oPHF1b00qnQeQoXwrpZ711DpubAz3AY/S6VQsCNGC/dSwgINsE248Dnlfkti007OKC
	JC4pA/FZ9aXSq7M1df+adUaC6m13VG30wE6GtW9TcVXQe40UGERTX07a5TyJgHI9v0tD/Td
	uKc9NFKUFbDcKko4/CL6owBfjXid/zTwFAndKVLHxDfjS6ST6NyTFqDrP2YC3zeyUunWzW7
	DOmA8ImdjGAL2dQQ5GDdRta3gcsVH8LTw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301908-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:larysa.zaremba@intel.com,m:kees@kernel.org,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B966C420D

In wx_set_vmdq_queues(), the VMDQ mask was not set for the devices not
support WX_FLAG_MULTI_64_FUNC, i.e., NGBE devices. A mask of 0 causes
__ALIGN_MASK(1, ~vmdq->mask) to return 0, which incorrectly sets
q_per_pool to 0 in wx_write_qde().

Fix the VMDQ 1-queue mask to 0x7F then ensures that __ALIGN_MASK(1,
0x7F) correctly evaluates to 1.

Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index d042567b8128..814d88d2aee4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1802,6 +1802,7 @@ static bool wx_set_vmdq_queues(struct wx *wx)
 			rss_i = 4;
 		}
 	} else {
+		vmdq_m = WX_VMDQ_1Q_MASK;
 		/* double check we are limited to maximum pools */
 		vmdq_i = min_t(u16, 8, vmdq_i);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c7befe4cdfe9..65e3e55db1cf 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -486,6 +486,7 @@ enum WX_MSCA_CMD_value {
 
 #define WX_VMDQ_4Q_MASK              0x7C
 #define WX_VMDQ_2Q_MASK              0x7E
+#define WX_VMDQ_1Q_MASK              0x7F
 
 /****************** Manageablility Host Interface defines ********************/
 #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
-- 
2.51.0


