Return-Path: <netdev+bounces-192612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6565DAC07EC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6B61BC1091
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D654B2882C7;
	Thu, 22 May 2025 08:56:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8FA288C82
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904175; cv=none; b=VIfbCAnh31UPuQUKvCNQxERZdBt5S1+M6xrCTML7Uhc9OGZI2wS4ceQol7l54atxsDaKNvI8XLzGiCewxUL5JLugGZjUsyHEVVuEfCSbjGz3E43UZzo8kdL0/NzGoB2Y1m3WLhw0VdVaSZEn0UtrEYzu7pLCa5c+6NeNadalH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904175; c=relaxed/simple;
	bh=VyDvBEV3fO1OBjk1ynvl3O2WEV+B2F9EQqba8/egRPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrrSPAq1cpfLpkCt2ZDwlrKw09kVL0aMC1RnU1ISYigX/0ppK9mnjf0NLyJULAy9+PkpNgy1zG8bFab2XGMyL1NdhxyXMojtvC8KzuztXHNDso8+kEKinLZtpuuh3SHSOwrpLUECa2Q2HjwEH3Sn/AC/8GJB2T+WSkjlicsgRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz17t1747904150t2db08ee4
X-QQ-Originating-IP: GmLxeHFgpwSJO2YZjvomOfMUA/hCWgburLYSvlt5uso=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 May 2025 16:55:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12995344699829397857
EX-QQ-RecipientCnt: 15
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH RESEND net-next v5 4/4] net: bonding: add tracepoint for 802.3ad
Date: Thu, 22 May 2025 16:55:16 +0800
Message-Id: <20250522085516.16355-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250522085516.16355-1-tonghao@bamaicloud.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MCk7GSmjSGXyNqRlzs/W4OkWm1rfVMmezVl83A8I288ZyjeDm77z2v/B
	AMlgCosNuGYo8r/Xcq2EjwOb7w2zh4d4afs5EkW5wvg0kWcpOF8Qyc67ie6UA9CltCeL8lM
	JGAgwMEujuMTU2i5aH5+JcjsZ/IAgWmEoWO9Thf2+K8BpumwkDbnC5O4feIkh7fGGMLVgcM
	nVWONO7SYnTSVvbHZ9luXFNt2Yf9GFAuKP5f+/c8UvBz0m+Js8Nv2hJYSwG0iQ8iHXwLqKp
	iEOc+UYL60dgbUUTZCZkOue52/fFuAiQrnLf1uhN49lUMB0dF799OKeblnEvU1dpP3tm5jp
	cyEOBsZ/jSJByxMC3LXyd78up7I+QBOS/NKbIQY3Q3noP2NNhjBh8R4fO+y1xyVNt30RKCe
	cGTKMUSJ3UoR58XrdbkdgUSHo90WKHZRK6nlC1jJS441UtgytRqF9sEDUCDaFZ5BJQcytLC
	MBHRVRM6TBqiPn+kaI9StpHbtwdsNxlj/I+3rXw/pDJEPMTSEfpT86Egr0e20X0D0fUcPjz
	+XD/MZVmA/b/9QSkwhzExLX2Mnheuw5W17ri03ol5BHg5B4tDbJyIOouZ1fu6T0jG/JKXfs
	W8wyLkAM+VIFyhOFquojj3/F9q6ul7G3Sd/sARGl+C3/EQ+Gn0QRN9D0BSFSUeAvBvIyWgk
	4ozLIP6ueNl5QrwGg/hRE1jGVKSG/ujuWyzPNO/tQhdw1sNoCJ6beJTGfO6+AQtEItScGaN
	upuzrWtEJa6zMe0jKuM5vAA75zvTgUlxD6MhwGxgRZlNYHhAFzt6ynaylP3puphwN4OQtfQ
	D/fIFD1sEIlYJCliodZPQNfIiAwHad2IrOncd/zQNowp3gIlhXKrl13nwX3DUHtYS5iiOxD
	8HcZxmTPFeZznuvXDX3QnQQz0TusN26h4k8WahEByCvwWs/t03yhG9KwqJ2DmcwghHceV/2
	XHZ6cXPcqPVXGTuMCo7C8GO/aDwp97Nxfxk23SMSj6zNmz0USoWgD5tIZAtMFrDL64ClEcf
	yYkwY91qCS3rEj08mV
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Users can monitor NIC link status changes through netlink. However, LACP
protocol failures may occur despite operational physical links. There is
no way to detect LACP state changes. This patch adds tracepoint at
LACP state transition.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/bonding/bond_3ad.c |  6 ++++++
 include/trace/events/bonding.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 include/trace/events/bonding.h

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index d1c2d416ac87..55703230ab29 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -16,6 +16,9 @@
 #include <net/bond_3ad.h>
 #include <net/netlink.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/bonding.h>
+
 /* General definitions */
 #define AD_SHORT_TIMEOUT           1
 #define AD_LONG_TIMEOUT            0
@@ -1146,6 +1149,9 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			  port->actor_port_number,
 			  last_state,
 			  port->sm_mux_state);
+
+		trace_3ad_mux_state(port->slave->dev, last_state, port->sm_mux_state);
+
 		switch (port->sm_mux_state) {
 		case AD_MUX_DETACHED:
 			port->actor_oper_port_state &= ~LACP_STATE_SYNCHRONIZATION;
diff --git a/include/trace/events/bonding.h b/include/trace/events/bonding.h
new file mode 100644
index 000000000000..1ee4b07d912a
--- /dev/null
+++ b/include/trace/events/bonding.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(_TRACE_BONDING_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_BONDING_H
+
+#include <linux/netdevice.h>
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM bonding
+
+TRACE_EVENT(3ad_mux_state,
+	TP_PROTO(struct net_device *dev, u32 last_state, u32 curr_state),
+	TP_ARGS(dev, last_state, curr_state),
+
+	TP_STRUCT__entry(
+		__field(int, ifindex)
+		__string(dev_name, dev->name)
+		__field(u32, last_state)
+		__field(u32, curr_state)
+	),
+
+	TP_fast_assign(
+		__entry->ifindex = dev->ifindex;
+		__assign_str(dev_name);
+		__entry->last_state = last_state;
+		__entry->curr_state = curr_state;
+	),
+
+	TP_printk("ifindex %d dev %s last_state 0x%x curr_state 0x%x",
+		  __entry->ifindex, __get_str(dev_name),
+		  __entry->last_state, __entry->curr_state)
+);
+
+#endif /* _TRACE_BONDING_H */
+
+#include <trace/define_trace.h>
-- 
2.34.1


