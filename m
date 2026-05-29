Return-Path: <netdev+bounces-293021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCw+EMNBGWp8uAgAu9opvQ
	(envelope-from <netdev+bounces-293021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:35:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C15FE980
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90142301A737
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417F303C9C;
	Fri, 29 May 2026 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="dYni2mqg"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418323346A5;
	Fri, 29 May 2026 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039831; cv=none; b=CuWaRfexF8zU2HuKgsq7guI/zNszpeoerLVEs2cx3Jz2CX4FKpgQfnMrPHU0axtQqjRDEprhiSbdPYUQAj5KoE2TxUAAXbDNPlFY9DGvWErdcdvk7xE5vaixruv33tVlgvXUL4cSPdUwv1kauHwt51WXjL2HcHZ6QEwIgqoRTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039831; c=relaxed/simple;
	bh=bDcc3e1/+tlUpzYBAtfQ4999iYs7jrR/uqNUkby/v58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AghQSCM854Zl8fB2bq9muYS+dnbeiAvEwKEu1qv7m62asdDR/pe2C64qzR23rtqoxvNM1FZRmBvVOoGP+uJ7HRH+4Dt0C7Y7h8CQONPTrw1bdZsajhcCfHxuL/DYBNaZMhhqdbHcdXS+HnHxmOUerWLFDQ4JK6ul1f+dSvX3/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=dYni2mqg; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=ow4tc
	kwQ8vjwY0JRKYyVPTWB7hz1NZLnStROh8EGIDA=; b=dYni2mqg4gOOzGuPCviAk
	BbgnSXN3X2YBIqcc+GqhpCCgtWqtr+LM0h2jp9JI+gcpFB/V+AMMYX40Ghn9zHkV
	IcCF+sbbJzC8LrZ2KrgHc8d3gRbaooCOM4bqthABJYkJBpi/m6dQOraHkbBovqbR
	nKzA9lzAFKcTbdOa+ni/zs=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web5 (Coremail) with SMTP id zAQGZQCHP7+CQBlqW673AQ--.46090S2;
	Fri, 29 May 2026 15:30:10 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH net] vlan: fix REORDER_HDR race between header and xmit paths
Date: Fri, 29 May 2026 15:30:01 +0800
Message-ID: <20260529073004.77147-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCHP7+CQBlqW673AQ--.46090S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy3uFy7XrWfGry7ZryDAwb_yoWrJry7pa
	1UGFW5CFWkJr9ava1vvw45GF48Ars5J3y2kas8GryUZwn8XFyxZr97KF9rtrn0qFy3Kr15
	ZFZxZr15ua18GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUY-BMDUUU
	U
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQQCAWoZNVkg3wAAsm
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293021-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:dkim,tsinghua.edu.cn:email]
X-Rspamd-Queue-Id: 937C15FE980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vlan_dev_change_flags() updates vlan->flags under RTNL, but the VLAN
data path reads the same field without RTNL.  In particular,
vlan_dev_hard_header() and vlan_dev_hard_start_xmit() may observe
different values of VLAN_FLAG_REORDER_HDR for the same skb.

This can lead to inconsistent tagging.  If REORDER_HDR is cleared when
vlan_dev_hard_header() runs, the function pushes an in-band VLAN header
into the skb.  If REORDER_HDR is then observed as set by
vlan_dev_hard_start_xmit(), the xmit path may also attach a hardware
accelerated VLAN tag, causing the packet to be emitted with two VLAN
tags.  Conversely, if the flag changes in the other direction, the skb
may be emitted without the expected VLAN tag.

Avoid making the xmit decision depend on a second unsynchronized read of
vlan->flags.  Instead, use the packet contents already produced by
vlan_dev_hard_header(): when an in-band VLAN header was pushed,
veth->h_vlan_proto matches vlan->vlan_proto and no additional hwaccel tag
is needed; otherwise the packet still carries the encapsulated protocol
and the xmit path must add the VLAN tag.

Also use READ_ONCE() for the data-path read in vlan_dev_hard_header()
and WRITE_ONCE() for the control-path update in vlan_dev_change_flags().

Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/8021q/vlan_dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c40f7d5..30cabf7 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -54,7 +54,7 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 	u16 vlan_tci = 0;
 	int rc;
 
-	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
+	if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
 		vhdr = skb_push(skb, VLAN_HLEN);
 
 		vlan_tci = vlan->vlan_id;
@@ -109,9 +109,18 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 	 *
 	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
 	 * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
+	 *
+	 * Do not re-read VLAN_FLAG_REORDER_HDR here.  The flag may have been
+	 * changed after vlan_dev_hard_header() ran, so using it again can make
+	 * the xmit path disagree with the header path for the same skb.
+	 *
+	 * Instead, look at the packet contents produced by the header path.  If
+	 * an in-band VLAN header was pushed, h_vlan_proto already matches the
+	 * VLAN protocol and no hwaccel tag is needed.  Otherwise h_vlan_proto is
+	 * the encapsulated protocol and the tag must be added here.
 	 */
-	if (vlan->flags & VLAN_FLAG_REORDER_HDR ||
-	    veth->h_vlan_proto != vlan->vlan_proto) {
+	if (veth->h_vlan_proto != vlan->vlan_proto) {
 		u16 vlan_tci;
+
 		vlan_tci = vlan->vlan_id;
 		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
 		__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
@@ -223,7 +232,7 @@ int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32 mask)
 		     VLAN_FLAG_BRIDGE_BINDING))
 		return -EINVAL;
 
-	vlan->flags = (old_flags & ~mask) | (flags & mask);
+	WRITE_ONCE(vlan->flags, (old_flags & ~mask) | (flags & mask));
 
 	if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
 		if (vlan->flags & VLAN_FLAG_GVRP)
-- 
2.43.0


