Return-Path: <netdev+bounces-293001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAF1AIMxGWqDsggAu9opvQ
	(envelope-from <netdev+bounces-293001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:26:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511775FDE58
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E11B730056DA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC403876BB;
	Fri, 29 May 2026 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="h3hRAA4i"
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29E346FAD;
	Fri, 29 May 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035723; cv=none; b=LbVoMzIp4cuKnLdVKV6bogUDIyvcAJ1PEvdBEr1+PjuJUHvBIfRbljLglSPtZjY4rA6JSP1BPSi0pgzv+rAoDyksTvjIVpadIjoO0ypF8TCq/X0XlLgXmuuj5ua+zzJQW3b4Y7a6Pr92ebmipbI/zimPknuF+suZ5zqKsPTPf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035723; c=relaxed/simple;
	bh=CHF6QtmzT6Tk5OH9nu3VaO5GO8oOAbuQK7nlBFs8uhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB3dioBxOEPB5M6cuBaKw7C5ki2KFSaI++p5NyDJexRm15j+Wwmuq6g3Jqdk2RKmosQSafqyB/N9fqFkkHtxKf8wsw2d/4q7YyxuZw1NkIvANxXie2imu4/AOS8RbZ2YdFeGeDaXzUMZJZ/hHSRVBHleNWUGTTRHAY3eX+QstN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=h3hRAA4i; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=ix23Q
	yk0YdItmhR/wIfPOtWcJ6bXqWw3b9V10mrkzUI=; b=h3hRAA4i60pJRgHAuFeEK
	SLe71kjRprpVnMe3rNncHhUIVhsC2vXZh+GXuU+TA/uHIq480TiMyxd/36oLvxTi
	PMm5YUBD0s6IpzqDVXF0puqXDRJz/sZDSuLeTdKjlbd0UtMsrm+MnJboxfDbh+rP
	inx2qQFpr6mq6ScYkDpbdg=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web5 (Coremail) with SMTP id zAQGZQC3bb1xMBlqAzb3AQ--.36352S2;
	Fri, 29 May 2026 14:21:38 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S . Miller" <davem@davemloft.net>,
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
Subject: [PATCH net] vlan: prevent unsigned underflow in VLAN MTU calculation over MACsec
Date: Fri, 29 May 2026 14:21:33 +0800
Message-ID: <20260529062135.70490-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQC3bb1xMBlqAzb3AQ--.36352S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UtF45Zr1rGr4xAF1xuFg_yoW5Gry3pF
	WjkFy7JrWUtryqqrWvqa1kZr4UJa1qv397Ar98C3WxAw45GFySqr48KFZxGrW8Za97CF18
	Jr47Ar4jkws0gFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjgdbUUU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQQCAWoYwC6FfAABsi
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293001-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,tsinghua.edu.cn:email,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 511775FDE58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a VLAN device is created on top of a MACsec device (where
`netif_reduces_vlan_mtu()` returns true) and the underlying device's MTU
is smaller than `VLAN_HLEN` (4 bytes), subtracting `VLAN_HLEN` from the
device MTU can underflow an unsigned integer. This wraps `max_mtu` to a
value near `UINT_MAX`, bypassing MTU checks and allowing an invalidly
large MTU on the VLAN device.

The same underflow exists in `vlan_newlink()` where the ternary
expression `real_dev->mtu - VLAN_HLEN` can wrap if the real device's MTU
is smaller than `VLAN_HLEN`.

Fix both locations by first verifying that `real_dev->mtu >= VLAN_HLEN`
before performing the subtraction. If the underlying device's MTU is too
small, return an appropriate error:

- `vlan_dev_change_mtu()`: return `-ERANGE`
- `vlan_newlink()`: return `-EINVAL`

This ensures no invalid MTU values are set on VLAN devices when the
underlying MACsec device is too small.

Fixes: 18d3df3eab23 ("vlan: use a valid default mtu value for vlan over macsec")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
---
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c40f7d5..19c838c 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -145,8 +145,11 @@ static int vlan_dev_change_mtu(struct net_device *dev, int new_mtu)
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 	unsigned int max_mtu = real_dev->mtu;
 
-	if (netif_reduces_vlan_mtu(real_dev))
+	if (netif_reduces_vlan_mtu(real_dev)) {
+		if (max_mtu < VLAN_HLEN)
+			return -ERANGE;
+		max_mtu -= VLAN_HLEN;
+	}
 	if (max_mtu < new_mtu)
 		return -ERANGE;
 
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index a000b1e..52a47d2 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -178,8 +178,13 @@ static int vlan_newlink(struct net_device *dev,
 	if (err < 0)
 		return err;
 
-	max_mtu = netif_reduces_vlan_mtu(real_dev) ? real_dev->mtu - VLAN_HLEN :
-						     real_dev->mtu;
+	if (netif_reduces_vlan_mtu(real_dev)) {
+		if (real_dev->mtu < VLAN_HLEN)
+			return -EINVAL;
+		max_mtu = real_dev->mtu - VLAN_HLEN;
+	} else {
+		max_mtu = real_dev->mtu;
+	}
 	if (!tb[IFLA_MTU])
 		dev->mtu = max_mtu;
 	else if (dev->mtu > max_mtu)
 		dev->mtu = max_mtu;


