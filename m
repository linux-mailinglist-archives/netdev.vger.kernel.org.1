Return-Path: <netdev+bounces-261224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLHKMH7/n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:08:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E3D1A24A5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A94C30BB539
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1073939A7;
	Thu, 26 Feb 2026 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xm/D/gmf"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272B392C2F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093033; cv=none; b=XcdNHMQ8pMWNu1uNFYjGiVQDbTbB0AD2vsxUqlm5c0nC58exBFn27HLsugl8Ja/3TdSHab9WR3Cx1WPUZ+E2u/hfLh1z7iVgcG9uSQ4xDc+FwcYgJvFBlFKeoIIoSr2yAUlk4o6TvmfSPTVTakSbe2+wUY/gVsoWVwL1dJ0BbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093033; c=relaxed/simple;
	bh=ao2JN9o8rgMD9ewIXTsOj16/l7c71xfGRqxIq1BebNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsZx+wujTCMEA65+61eQd0akqJBxksj3H5vyYewG0Z/v0rdahL05D4SjDR+Cvqx1QnDulNNXAEYmb8jHqCGrw7L78KNr9gxuzLlrUXU2hTbreo2lw2twhmm2XQiBWuM8i+lJMOXDwjzmp3NGKYXL2g0MXR92F2aLuITW7vqyA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xm/D/gmf; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772093029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGngwSjwz2jDUPqIlsxjsx9PtSmCzj/KBjQeZXWW0sM=;
	b=xm/D/gmfKMiLN0uXkcO22+38CFUYiAGM3uOpoZ4FjCZ9X/ihuk45FHM64xCgwSejeXWE4h
	2JQrGLzCp/DKhvp8qlMycfzzpu1gVxgcDtJwCR/t1Uy0DdF15st5xm55J8x+zWpXJ1k6ew
	CCbaFOtIf4nFLsA/IBIfnJLJU+pXcCU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	syzbot+5a287bcdc08104bc3132@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jussi Maki <joamaki@gmail.com>,
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v1 1/2] bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is loaded
Date: Thu, 26 Feb 2026 16:03:01 +0800
Message-ID: <20260226080306.98766-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260226080306.98766-1-jiayuan.chen@linux.dev>
References: <20260226080306.98766-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-261224-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,5a287bcdc08104bc3132,linux];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,appspotmail.com:email]
X-Rspamd-Queue-Id: 33E3D1A24A5
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

bond_option_mode_set() already rejects mode changes that would make a
loaded XDP program incompatible via bond_xdp_check().  However,
bond_option_xmit_hash_policy_set() has no such guard.

For 802.3ad and balance-xor modes, bond_xdp_check() returns false when
xmit_hash_policy is vlan+srcmac, because the 802.1q payload is usually
absent due to hardware offload.  This means a user can:

1. Attach a native XDP program to a bond in 802.3ad/balance-xor mode
   with a compatible xmit_hash_policy (e.g. layer2+3).
2. Change xmit_hash_policy to vlan+srcmac while XDP remains loaded.

This leaves bond->xdp_prog set but bond_xdp_check() now returning false
for the same device.  When the bond is later destroyed, dev_xdp_uninstall()
calls bond_xdp_set(dev, NULL, NULL) to remove the program, which hits
the bond_xdp_check() guard and returns -EOPNOTSUPP, triggering:

WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL))

Fix this by rejecting xmit_hash_policy changes to vlan+srcmac when an
XDP program is loaded on a bond in 802.3ad or balance-xor mode.

commit 39a0876d595b ("net, bonding: Disallow vlan+srcmac with XDP")
introduced bond_xdp_check() which returns false for 802.3ad/balance-xor
modes when xmit_hash_policy is vlan+srcmac.  The check was wired into
bond_xdp_set() to reject XDP attachment with an incompatible policy, but
the symmetric path -- preventing xmit_hash_policy from being changed to an
incompatible value after XDP is already loaded -- was left unguarded in
bond_option_xmit_hash_policy_set().

Note:
commit 094ee6017ea0 ("bonding: check xdp prog when set bond mode")
later added a similar guard to bond_option_mode_set(), but
bond_option_xmit_hash_policy_set() remained unprotected.

Reported-by: syzbot+5a287bcdc08104bc3132@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6995aff6.050a0220.2eeac1.014e.GAE@google.com/T/
Fixes: 39a0876d595b ("net, bonding: Disallow vlan+srcmac with XDP")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 drivers/net/bonding/bond_main.c    | 9 +++++++--
 drivers/net/bonding/bond_options.c | 2 ++
 include/net/bonding.h              | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 78cff904cdc3..2854cdfa4af9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -324,7 +324,7 @@ static bool bond_sk_check(struct bonding *bond)
 	}
 }
 
-bool bond_xdp_check(struct bonding *bond, int mode)
+bool __bond_xdp_check(int mode, int xmit_policy)
 {
 	switch (mode) {
 	case BOND_MODE_ROUNDROBIN:
@@ -335,7 +335,7 @@ bool bond_xdp_check(struct bonding *bond, int mode)
 		/* vlan+srcmac is not supported with XDP as in most cases the 802.1q
 		 * payload is not in the packet due to hardware offload.
 		 */
-		if (bond->params.xmit_policy != BOND_XMIT_POLICY_VLAN_SRCMAC)
+		if (xmit_policy != BOND_XMIT_POLICY_VLAN_SRCMAC)
 			return true;
 		fallthrough;
 	default:
@@ -343,6 +343,11 @@ bool bond_xdp_check(struct bonding *bond, int mode)
 	}
 }
 
+bool bond_xdp_check(struct bonding *bond, int mode)
+{
+	return __bond_xdp_check(mode, bond->params.xmit_policy);
+}
+
 /*---------------------------------- VLAN -----------------------------------*/
 
 /* In the following 2 functions, bond_vlan_rx_add_vid and bond_vlan_rx_kill_vid,
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index f1c6e9d8f616..adc216df4345 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1574,6 +1574,8 @@ static int bond_option_fail_over_mac_set(struct bonding *bond,
 static int bond_option_xmit_hash_policy_set(struct bonding *bond,
 					    const struct bond_opt_value *newval)
 {
+	if (bond->xdp_prog && !__bond_xdp_check(BOND_MODE(bond), newval->value))
+		return -EOPNOTSUPP;
 	netdev_dbg(bond->dev, "Setting xmit hash policy to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.xmit_policy = newval->value;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 4ad5521e7731..395c6e281c5f 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -699,6 +699,7 @@ void bond_debug_register(struct bonding *bond);
 void bond_debug_unregister(struct bonding *bond);
 void bond_debug_reregister(struct bonding *bond);
 const char *bond_mode_name(int mode);
+bool __bond_xdp_check(int mode, int xmit_policy);
 bool bond_xdp_check(struct bonding *bond, int mode);
 void bond_setup(struct net_device *bond_dev);
 unsigned int bond_get_num_tx_queues(void);
-- 
2.43.0


