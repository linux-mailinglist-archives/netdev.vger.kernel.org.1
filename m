Return-Path: <netdev+bounces-173121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E82CA57705
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 01:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A745176B86
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE68E56F;
	Sat,  8 Mar 2025 00:46:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E96C2FA;
	Sat,  8 Mar 2025 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741394778; cv=none; b=NJyDPgy8atTFeVKyPV5NTYbVPTLeiQ2UACqSR9aun33SVUDZG1u4R53kQGDiPkBEGmDfVUUJituAl5hCUnD0BfxOTc5sj79ObgqQ0fwNpAMwDmu/1IMHAk8TCZnq5DZa8QcyhyXT+lQrxUdV7W4zgIuTJpC3z1varD0T6Fo9cOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741394778; c=relaxed/simple;
	bh=y1W4e1wYfpdVrT1KOl483GYtqc45OqLl/qLvkC8zYjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uI21qnVu9MfZ3Ewynpkab7HjKuymoosK5jMMx9kDwdEgIZLk0FqySz879Pr5U5mttQA4cqiYHUaMBR9zpLC88C4RN2XinB3IpIUT6YC5Vs1Zel1AcbrhjlupJlI4eYumSG6AKfIQ3nalEuNfHQtUPztw6VfubXcNAoxnUxOj6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-391342fc1f6so1292878f8f.1;
        Fri, 07 Mar 2025 16:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741394774; x=1741999574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpQ9W6r3A269sn54hKhYIafhwiAez/jqGdPqFLq8ztg=;
        b=u4fG8MO2BpYwkd2nJynTLAd1Btax2Ob6jUzmAdUayREecFkng5Hjtc5A1HCDSAbsi5
         piRl3zS6levRKCW5bY4Q3WY4pbLWpITfQHzGiVcbEv6QmMtMjJxWm4bo1u7XpNiZMPCT
         tsLvDDUqJiF3r2RzfYrgX69N13TPYl/zlXCE08KQVzbYpEwVuC9iq+SZsE5P2PbsAkGT
         5VrE1XVCIq2L/AVc2G3wtjwpIs4xa1aUqTXYKzMT0b/zdDo9eAWK2CsRt+j83j75S6h/
         r37IFCCWMx0HieOoWoqB533E0231ovOHQd5yoe174sNX1gIZ7rqp/07VemCxM4jEOSeQ
         kKrA==
X-Forwarded-Encrypted: i=1; AJvYcCXkdCx7WWPl6jZ93vfydapOaU/7sZZORCsq5NE8sYfrlAr8U2cJB6b4lAwd0pb1d2DiBWrNdRdsocmNTUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GCRHpzSjOGUIOGsqTKiXk8wRqkd5wiamcyY76jrS2tXKRm/8
	UxbIGQr/jXFDxbIfG6EgoYsQQgbDycRhlWrI8cS1KQ/587NIO63SdWRUWBrK
X-Gm-Gg: ASbGncs9zJfZJxRGSBRxXv37Z+SFkKi1BW/dxGhGaVSWSStlmPxkM+bMt2D58Q0y/kA
	vLJfNB4NO924awQWr3zxt0W6L69ych6QVsiDXxIUaKb2dTp3LYPBkKgaf8NFgFyGBjit7GqHWw/
	6N33FLBQTZe1LSMzLCxPNvKu2cjLDyBs9jocM8RMkT1qyWK8M4TWgV480E+2B8MsneE4IcpwEWu
	PFGCUF9D8ZZ/S5y2QlhEvtGbD3FGk5vp59DFU++tlrTUKC0uMuBvo5IeQXtLUQBk29j5roa2Og2
	+6HDQOZEI3ljoe36KqdfpQy69j4/4QQ3PRL++aCdhKcPP9BpApR0lhnYCdkKuO4MBhAXOYDfquM
	zhW5bshk=
X-Google-Smtp-Source: AGHT+IGMBvkOP0HsDWpJIUBSXM0T0CXGMaX2xgRyqY9FTDhwupT7f8MHEcd9UI0KpFjphg80zBOA/g==
X-Received: by 2002:a5d:5f89:0:b0:390:f552:d291 with SMTP id ffacd0b85a97d-39132d68331mr3762833f8f.22.1741394773696;
        Fri, 07 Mar 2025 16:46:13 -0800 (PST)
Received: from im-t490s.redhat.com (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426c01bsm98554725e9.2.2025.03.07.16.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 16:46:13 -0800 (PST)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net] net: openvswitch: remove misbehaving actions length check
Date: Sat,  8 Mar 2025 01:45:59 +0100
Message-ID: <20250308004609.2881861-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The actions length check is unreliable and produces different results
depending on the initial length of the provided netlink attribute and
the composition of the actual actions inside of it.  For example, a
user can add 4088 empty clone() actions without triggering -EMSGSIZE,
on attempt to add 4089 such actions the operation will fail with the
-EMSGSIZE verdict.  However, if another 16 KB of other actions will
be *appended* to the previous 4089 clone() actions, the check passes
and the flow is successfully installed into the openvswitch datapath.

The reason for a such a weird behavior is the way memory is allocated.
When ovs_flow_cmd_new() is invoked, it calls ovs_nla_copy_actions(),
that in turn calls nla_alloc_flow_actions() with either the actual
length of the user-provided actions or the MAX_ACTIONS_BUFSIZE.  The
function adds the size of the sw_flow_actions structure and then the
actually allocated memory is rounded up to the closest power of two.

So, if the user-provided actions are larger than MAX_ACTIONS_BUFSIZE,
then MAX_ACTIONS_BUFSIZE + sizeof(*sfa) rounded up is 32K + 24 -> 64K.
Later, while copying individual actions, we look at ksize(), which is
64K, so this way the MAX_ACTIONS_BUFSIZE check is not actually
triggered and the user can easily allocate almost 64 KB of actions.

However, when the initial size is less than MAX_ACTIONS_BUFSIZE, but
the actions contain ones that require size increase while copying
(such as clone() or sample()), then the limit check will be performed
during the reserve_sfa_size() and the user will not be allowed to
create actions that yield more than 32 KB internally.

This is one part of the problem.  The other part is that it's not
actually possible for the userspace application to know beforehand
if the particular set of actions will be rejected or not.

Certain actions require more space in the internal representation,
e.g. an empty clone() takes 4 bytes in the action list passed in by
the user, but it takes 12 bytes in the internal representation due
to an extra nested attribute, and some actions require less space in
the internal representations, e.g. set(tunnel(..)) normally takes
64+ bytes in the action list provided by the user, but only needs to
store a single pointer in the internal implementation, since all the
data is stored in the tunnel_info structure instead.

And the action size limit is applied to the internal representation,
not to the action list passed by the user.  So, it's not possible for
the userpsace application to predict if the certain combination of
actions will be rejected or not, because it is not possible for it to
calculate how much space these actions will take in the internal
representation without knowing kernel internals.

All that is causing random failures in ovs-vswitchd in userspace and
inability to handle certain traffic patterns as a result.  For example,
it is reported that adding a bit more than a 1100 VMs in an OpenStack
setup breaks the network due to OVS not being able to handle ARP
traffic anymore in some cases (it tries to install a proper datapath
flow, but the kernel rejects it with -EMSGSIZE, even though the action
list isn't actually that large.)

Kernel behavior must be consistent and predictable in order for the
userspace application to use it in a reasonable way.  ovs-vswitchd has
a mechanism to re-direct parts of the traffic and partially handle it
in userspace if the required action list is oversized, but that doesn't
work properly if we can't actually tell if the action list is oversized
or not.

Solution for this is to check the size of the user-provided actions
instead of the internal representation.  This commit just removes the
check from the internal part because there is already an implicit size
check imposed by the netlink protocol.  The attribute can't be larger
than 64 KB.  Realistically, we could reduce the limit to 32 KB, but
we'll be risking to break some existing setups that rely on the fact
that it's possible to create nearly 64 KB action lists today.

Vast majority of flows in real setups are below 100-ish bytes.  So
removal of the limit will not change real memory consumption on the
system.  The absolutely worst case scenario is if someone adds a flow
with 64 KB of empty clone() actions.  That will yield a 192 KB in the
internal representation consuming 256 KB block of memory.  However,
that list of actions is not meaningful and also a no-op.  Real world
very large action lists (that can occur for a rare cases of BUM
traffic handling) are unlikely to contain a large number of clones and
will likely have a lot of tunnel attributes making the internal
representation comparable in size to the original action list.
So, it should be fine to just remove the limit.

Commit in the 'Fixes' tag is the first one that introduced the
difference between internal representation and the user-provided action
lists, but there were many more afterwards that lead to the situation
we have today.

Fixes: 7d5437c709de ("openvswitch: Add tunneling interface.")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/flow_netlink.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 881ddd3696d5..95e0dd14dc1a 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2317,14 +2317,10 @@ int ovs_nla_put_mask(const struct sw_flow *flow, struct sk_buff *skb)
 				OVS_FLOW_ATTR_MASK, true, skb);
 }
 
-#define MAX_ACTIONS_BUFSIZE	(32 * 1024)
-
 static struct sw_flow_actions *nla_alloc_flow_actions(int size)
 {
 	struct sw_flow_actions *sfa;
 
-	WARN_ON_ONCE(size > MAX_ACTIONS_BUFSIZE);
-
 	sfa = kmalloc(kmalloc_size_roundup(sizeof(*sfa) + size), GFP_KERNEL);
 	if (!sfa)
 		return ERR_PTR(-ENOMEM);
@@ -2480,15 +2476,6 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
 
 	new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
 
-	if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
-		if ((next_offset + req_size) > MAX_ACTIONS_BUFSIZE) {
-			OVS_NLERR(log, "Flow action size exceeds max %u",
-				  MAX_ACTIONS_BUFSIZE);
-			return ERR_PTR(-EMSGSIZE);
-		}
-		new_acts_size = MAX_ACTIONS_BUFSIZE;
-	}
-
 	acts = nla_alloc_flow_actions(new_acts_size);
 	if (IS_ERR(acts))
 		return ERR_CAST(acts);
@@ -3545,7 +3532,7 @@ int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 	int err;
 	u32 mpls_label_count = 0;
 
-	*sfa = nla_alloc_flow_actions(min(nla_len(attr), MAX_ACTIONS_BUFSIZE));
+	*sfa = nla_alloc_flow_actions(nla_len(attr));
 	if (IS_ERR(*sfa))
 		return PTR_ERR(*sfa);
 
-- 
2.47.0


