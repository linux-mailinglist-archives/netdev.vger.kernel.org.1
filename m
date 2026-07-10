Return-Path: <netdev+bounces-306451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id flWGMXqeUGr82QIAu9opvQ
	(envelope-from <netdev+bounces-306451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:25:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1ED738055
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:25:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306451-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306451-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55B4830459F3
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0A3B893A;
	Fri, 10 Jul 2026 07:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D69390C8D
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 07:19:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667995; cv=none; b=TbiOPWFNF7GSg2sCSyc/PBdXTTo62hqq8H+/VGJyAvG3czJmPVt97g0l0kMrsI+hgIBzbwMul3tPbQ1VPERm71w/sqpbht+kW9GgjBWm+puDbGnNKW4B21+QZFJDkRqvm7MtECZ9+G/f3hSW7bzW3jYi7gDLlt9isMKHQC9JGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667995; c=relaxed/simple;
	bh=fUHAXw25e3i6sdV83L9BOxgf8Lmy7Vd1iNneUSg/kNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAI8HCydIzNkjBeXw5gSrUTof+4XM6HhPWRLTpTHGlYZa+hYSJlre0424jSPbo7WZYlB052lx15AxvZzrM/wJ+tLaNea/9DdX7LWtKGltn882q9ZSb3cW2eXdHNOjmQC09dEkxFRMUhRKTc8Tw3aUm18zbjhDaY0DFs/8KGPUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
X-QQ-mid: zesmtpsz8t1783667921te390757c
X-QQ-Originating-IP: W4iDUtyq+5TmFws3JSLbuj8wxRM1PD3QZ0dVOMRu1LQ=
Received: from w-MS-7E16.trustnetic.com ( [60.188.196.189])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jul 2026 15:18:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6538837993321223082
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: libwx: disable TX VLAN offload for packets with >2 VLAN tags
Date: Fri, 10 Jul 2026 15:18:31 +0800
Message-ID: <C1BF77C0E073A40C+20260710071831.210196-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NsCbNQtmHR1k7yt2KtvYL7y7Icy0oWfweeGf7LfQ5YL3OJiRYmZTAWg1
	8KazbCUGFf/2rI8lhML42JjFm+wW4Ti7NCFuiJ1v3YOxTkVbLkLEEBfjqWKY3EyKBHdSRcB
	LYbcbZpQrcs68OpLqYxsRdAUpgYxyWi+QCyxZhRCBVAumveEsDBTxZyCL8you/BzZKAoF3r
	CsH2gm3VIHULdxVmv0sJxiooMOcjtNhVEFbrUzt08tlQCrZdhrtnrV7/wyTh4AcNehpfzyA
	RLSqVGMEdqmgE80O4f9oyoqqpGbYKfmvC5jBuPuQt/qZg/mi1jIyo/jVw6e7nTgBWhd5CCl
	zAPCmDrKRu7jcbkf3OS3Ue2vHilOrhfmFMyXsmpQgsNnq3+BIHyuIXysaJ0PluDd0r48osD
	qlmGNcJQIK3YTdG2P7ZsYNTzp+7yfxcYu/SjHiVq5EL/7eD6RCqp6ThBjErRuQf6mNSnKOK
	z3FHfJedxyXIKxtmOkrzqQJ8WmqpsJ0BGMKNIltnKXV1wFWogYjaLt2+UOrSd8Rzvmme2Gx
	xFTaLQaRaPTuSNMKf5MAOcDnC/NCyn7QMdsS8XCTqvBpmHDPE03D70Dt/yXysadOl91irMH
	KwFaDLtwue7mRm6tdDoiPBhQmL+it9jkY2EjVC+EpthhtNlW16VTqnbkL7SHEJsFaWKT1vC
	cxDlF/oqfYs7gdnUb7tHhTRkj34pIKfXgvX/spZq/rj1CoFgN8hsiqqRVXyLBXfC7rPzNrG
	xw5qsFIcCyqpLldlMzcmUZmVoss9yjKHHoTv2BhJeQKqMslDxWwfEL7ny/XcJ5Ktf97RfsZ
	fDuFmegBlv+1WKTDGyH09MagXjUNxPyrbQqz7HnqNhKXwkjfV1TEH1ZWxXSjDTMR3ColEdo
	2OsW2WWh1mfkec4VTi0HSc1+HI7cBCbIAmkyfpKsmoeOPh8vUsmioArLG85dSVjT9s7z8TN
	umC4GEzB5F1i/wPpJMIj1s3aA5jjx381JyU/FPOdFXmN87r6uNuE+I3sfrAR8zXcuf0rtXY
	+Yq0IbCO0J6g6n1IFifSIgJaM/och7V13/R+eJo0OEFHFRYIryp3MXRBpi/evW9JrTXNGau
	sIcOmB04s87
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306451-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:duanqiangwen@net-swift.com,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:kees@kernel.org,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB1ED738055

The current hardware does not support TX VLAN offload for packets with
three or more VLAN tags. When such packets are transmitted with hardware
VLAN offload enabled, the hardware may malfunction or produce corrupted
frames.

Add a check in wx_features_check() to parse the VLAN depth of the
skb. If more than two VLAN tags are detected (including both the
hardware tag and in-band tags), strip NETIF_F_HW_VLAN_CTAG_TX and
NETIF_F_HW_VLAN_STAG_TX from the feature set. This forces the
kernel networking stack to handle VLAN insertion in software for
these specific packets, ensuring correct transmission.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 814d88d2aee4..65dab6bd8a39 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3223,12 +3223,37 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
 EXPORT_SYMBOL(wx_fix_features);
 
 #define WX_MAX_TUNNEL_HDR_LEN	80
+#define WX_VLAN_MAX_DEPTH	8
 netdev_features_t wx_features_check(struct sk_buff *skb,
 				    struct net_device *netdev,
 				    netdev_features_t features)
 {
 	struct wx *wx = netdev_priv(netdev);
+	u16 parse_depth = WX_VLAN_MAX_DEPTH;
+	__be16 type = skb->protocol;
+	u16 vlan_depth = ETH_HLEN;
+	u32 vlan_num = 0;
 
+	if (!skb_vlan_tag_present(skb))
+		goto tunnel_check;
+
+	vlan_num++;
+	while (eth_type_vlan(type) && --parse_depth) {
+		struct vlan_hdr vhdr, *vh;
+
+		vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+		if (unlikely(!vh))
+			break;
+
+		type = vh->h_vlan_encapsulated_proto;
+		vlan_depth += VLAN_HLEN;
+		vlan_num++;
+	}
+
+	if (vlan_num > 2)
+		features &= ~(NETIF_F_HW_VLAN_CTAG_TX |
+			      NETIF_F_HW_VLAN_STAG_TX);
+tunnel_check:
 	if (!skb->encapsulation)
 		return features;
 
-- 
2.51.0


