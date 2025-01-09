Return-Path: <netdev+bounces-156674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99BA075AA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A8A3A82B0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A1216E27;
	Thu,  9 Jan 2025 12:23:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07D20551B;
	Thu,  9 Jan 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425398; cv=none; b=e8asDJoopOrLceTtEsSBMRNVpgWsR/1BVRTJ+YXeSmaqgpuTWBGEEiJZ2Hvajd3qzIxuqgF/h9K1eMoDmkyEdRcdnI4nFb0LNtqjiogvZcRqWMQdPpgcDzSuLRrM0E8uBZVie4w3bEfHrrfsELCUB0mvlhKpebB9vqqbEEOtmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425398; c=relaxed/simple;
	bh=7+n0QynMprKvKZ35aUlzW3CFxbeWcgYeWYRJa1HMf7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iI8Dnz0krpZ3aFu6weadCYvIL/U72i9KG3IAlEb+Z4XxUx3L7+0rTHmxR/A7iI70botA5pS29Fv6Dhtnh3PnIO5aofTtqWy4HNey/IKz61A8zGITJfDSKSIxsQGFTA5ZwTkd8j95Ob/Uoo/iy5YtM0egi/Swu8umzegfIzFsNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso9541065e9.2;
        Thu, 09 Jan 2025 04:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736425394; x=1737030194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrNP4iM+dKjOzSzFjGe+I78I/aSS5rp5dYXJ1rHOADA=;
        b=l23YLKBme7He0WT19rpQwLk1U61SdSuPGaT76ib3fn4zkyQ+V15QLhlR+D0HicVcBp
         LL9s2ZlXVpargwyGntLzwvdtCqIugOX25gip7i2lpzT1yKF1t33C4zn7w4kJKnPPPjcX
         FlQkSQY7b0gXjA7l3UZ+SXYeUXIITJCKCh4sWE6ze33nfDWJJO/W9zdO+IaUqfgJ9+nc
         XztvxF5Z7jgcjHvm/dOKk+o4rgOWbxJS/eeoM/pwuvyzFh6KufnHG14oeXtXyxosXaL/
         LCIfFo/gIueVnzpbV4FaRWVTnyk7BhNIEHXyG8rn11hj+zujxcCDfFGIKKmQ52nC2CvX
         2/tg==
X-Forwarded-Encrypted: i=1; AJvYcCV/jGAYjKwWPxYNaJ3Hc8bvEnJDrZAmwTJgV49ILml/AsPPl988L/eemWDsw2QV/EE0CjmhGjXjt02lYwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1EQjs7Y4R3W53AGbT08skYWVTRiWN5dKdFatJaWUPGzYOprmN
	Z9pjw6DJP2BaBsTTXE3eeWcvyQsYPF+9p4ACZvcTknqKkxWQLGJtNkhm9eI3
X-Gm-Gg: ASbGncusjsgE9PrXqaiJh6ncEiQUQAZV0xs7OWuYw1nAOunjb3m0weMxgh7yDeJKsyu
	Ig/71GsrcoS+87FK14UoEiyBdhI+mK9mUawdy+FBGzci6+t0NnZJE9JGE5X2r65CWU4lq41FHwe
	xp+quZqXXRFYLmLEwiADg3L3XAzSAfbpzq117WkdzL4w4QhjyjdA30tJdpZtBLnFjyEHKFBo3xd
	h7PUpPH7/LMoJx7mFOOT4GpBHzOMIPuDKr3adDqsGkDPHU13Gin3ThkUXLfdGcBeZlRszTDRO9s
	8F2bhol4kGaCXtaDdCo=
X-Google-Smtp-Source: AGHT+IEUp+4FQMuai1vfLoPr02YbfVvdXSu1gq6Z2SFxrOsxv/3on8mNC2W9EOG2nmadrYP5xzO/dg==
X-Received: by 2002:a05:6000:1564:b0:38a:8c9f:dd61 with SMTP id ffacd0b85a97d-38a8c9fdeeamr2300174f8f.46.1736425393780;
        Thu, 09 Jan 2025 04:23:13 -0800 (PST)
Received: from im-t490s.redhat.com (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38534csm1672896f8f.43.2025.01.09.04.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 04:23:13 -0800 (PST)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Friedrich Weber <f.weber@proxmox.com>
Subject: [PATCH net] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Thu,  9 Jan 2025 13:21:24 +0100
Message-ID: <20250109122225.4034688-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit in a fixes tag attempted to fix the issue in the following
sequence of calls:

    do_output
    -> ovs_vport_send
       -> dev_queue_xmit
          -> __dev_queue_xmit
             -> netdev_core_pick_tx
                -> skb_tx_hash

When device is unregistering, the 'dev->real_num_tx_queues' goes to
zero and the 'while (unlikely(hash >= qcount))' loop inside the
'skb_tx_hash' becomes infinite, locking up the core forever.

But unfortunately, checking just the carrier status is not enough to
fix the issue, because some devices may still be in unregistering
state while reporting carrier status OK.

One example of such device is a net/dummy.  It sets carrier ON
on start, but it doesn't implement .ndo_stop to set the carrier off.
And it makes sense, because dummy doesn't really have a carrier.
Therefore, while this device is unregistering, it's still easy to hit
the infinite loop in the skb_tx_hash() from the OVS datapath.  There
might be other drivers that do the same, but dummy by itself is
important for the OVS ecosystem, because it is frequently used as a
packet sink for tcpdump while debugging OVS deployments.  And when the
issue is hit, the only way to recover is to reboot.

Fix that by also checking if the device is running.  The running
state is handled by the net core during unregistering, so it covers
unregistering case better, and we don't really need to send packets
to devices that are not running anyway.

While only checking the running state might be enough, the carrier
check is preserved.  The running and the carrier states seem disjoined
throughout the code and different drivers.  And other core functions
like __dev_direct_xmit() check both before attempting to transmit
a packet.  So, it seems safer to check both flags in OVS as well.

Fixes: 066b86787fa3 ("net: openvswitch: fix race on port output")
Reported-by: Friedrich Weber <f.weber@proxmox.com>
Closes: https://mail.openvswitch.org/pipermail/ovs-discuss/2025-January/053423.html
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 16e260014684..704c858cf209 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -934,7 +934,9 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
-	if (likely(vport && netif_carrier_ok(vport->dev))) {
+	if (likely(vport &&
+		   netif_running(vport->dev) &&
+		   netif_carrier_ok(vport->dev))) {
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
-- 
2.47.0


