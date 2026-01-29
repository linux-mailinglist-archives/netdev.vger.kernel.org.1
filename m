Return-Path: <netdev+bounces-254912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPIWJpfGe2m7IQIAu9opvQ
	(envelope-from <netdev+bounces-254912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:44:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA6B451E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05422301725F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB5E358D38;
	Thu, 29 Jan 2026 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8TtZImj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63F328B4D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719443; cv=none; b=d/9y1VshQ24FyzWOkIOhSQrqyW4FBVetD3Jz/x02G71icmPmJrenckYFlloAT71EKPLv8QGKxeqE45tXiPgiZuG4An25uXhMjf0YR0V1v0yCDs9X9ANB0UhKxq3r86Qnh9oO7ChJyeebYvuZltDME+ENUDui2VK9CKM9Hs2hr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719443; c=relaxed/simple;
	bh=iE3xdHiFLbSoPBYpGyMnBO/XjwFgYbJymPC8gdMT6oE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YlqBDBx7D10+zhwk6DOtiGYO0cG2B1uzduiqlmqjmcWhwKVtUbubUt6wVMGnSC+d2mfiqY7gEdyqT3E4p/WwzsC65qtVrhNxK9B6UtrOcVHSgsIgX4GxXZso7ofolsUCx2nRxVK8BiPP7R/PChOcPhCmoQvbB0ChFW9mOgibqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8TtZImj; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a2f8e7d8dso47604786d6.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769719441; x=1770324241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ww+ew5iMA0LOYxm/aV0mnYtojRk44ZRbGIQ6TqBp/oQ=;
        b=M8TtZImjkzXkXA4jR/I65TeUJzmj0kiJ/1h79tbiM40TKTMicnX7eLq8XrCwVlmJqs
         TUzx7Jj6bCXPhS8IhZCioEz+0SN6tqz/Hf8AwSxeSudkKko/HOL1u6hZNBA7cFQnl8Zd
         dd9WGhu7ocPNgXVMvJecsSWQ+2XMibzSwu/U5+NLfwtmzaA3S6BeDar31HS4XkSHm/tz
         vUT6LS6Zdq7R5+m7y5XANItrxEimSLGJGyTW1oHt3kQzNCgXvaCW1pu5uivPv/hmh0XZ
         jGIMDauGrP6FK2bp3Plnh0/CYRQxbQzXQ1ouW+6L4mluANl31hswgaGKRi/LYh23EWOi
         lvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769719441; x=1770324241;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ww+ew5iMA0LOYxm/aV0mnYtojRk44ZRbGIQ6TqBp/oQ=;
        b=biMFFXInLcgFsZz2a93zC+HuPccI9AlQidNeVFijdJUXX6zYL6XxGUrCEk6Wfj3i1z
         Ky6MRbm7EQfppl55p6GNeKwAcrB2GVWFeMoJ1/Cxy8NNI7vSpAGGEu1N1Ji17jyQEijJ
         s+q0SozPS8TBO+2eGu67O5PNeiV4sy8nDeBBHeVyEW3qCSTF9LbbKCOZet4IM0kGNp5C
         62kYCmncRG5Ruz0wyWHgJ9VDiY7+fvr72ZPKuZwk1ICnvrMriXguuY6KDJwAL0J5OAt0
         BnZKGGVHjRy68nr4sjdlc3TnmFhrtXIgOA44p+ROvdB+9ov5gbgu1D15Zecj0/J7bLvR
         3zbg==
X-Forwarded-Encrypted: i=1; AJvYcCWyEWXNAYbNfEfKLhaX6yZCPEODEk9EHWzwzDhFpjXvgYOUJ2suvapCyhQ7cJ3I5HWmfUV5aUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKUbDo0+1c6+Ty4fgI+upH9ie4jNXW4vgVozjP7RmBHsiqlXw
	+C6qt6fFCE5EMm9bhzOBYcBnKKLJdYe+mn6tOjuXcmop4UwUyDgX+2IT5anFZkbln2FNQP8Y3S0
	qzVA95K8k6wL0Ww==
X-Received: from qva17.prod.google.com ([2002:a05:6214:8011:b0:894:a073:377])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:519c:b0:894:7405:d364 with SMTP id 6a1803df08f44-894ea0a9a88mr11020556d6.64.1769719441139;
 Thu, 29 Jan 2026 12:44:01 -0800 (PST)
Date: Thu, 29 Jan 2026 20:43:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129204359.632556-1-edumazet@google.com>
Subject: [PATCH net] macvlan: fix error recovery in macvlan_common_newlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, valis <sec@valis.email>, 
	syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com, 
	Boudewijn van der Heide <boudewijn@delta-utec.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,valis.email,syzkaller.appspotmail.com,delta-utec.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254912-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,7182fbe91e58602ec1fe];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 14FA6B451E
X-Rspamd-Action: no action

valis provided a nice repro to crash the kernel:

ip link add p1 type veth peer p2
ip link set address 00:00:00:00:00:20 dev p1
ip link set up dev p1
ip link set up dev p2

ip link add mv0 link p2 type macvlan mode source
ip link add invalid% link p2 type macvlan mode source macaddr add 00:00:00:00:00:20

ping -c1 -I p1 1.2.3.4

He also gave a very detailed analysis:

<quote valis>

The issue is triggered when a new macvlan link is created  with
MACVLAN_MODE_SOURCE mode and MACVLAN_MACADDR_ADD (or
MACVLAN_MACADDR_SET) parameter, lower device already has a macvlan
port and register_netdevice() called from macvlan_common_newlink()
fails (e.g. because of the invalid link name).

In this case macvlan_hash_add_source is called from
macvlan_change_sources() / macvlan_common_newlink():

This adds a reference to vlan to the port's vlan_source_hash using
macvlan_source_entry.

vlan is a pointer to the priv data of the link that is being created.

When register_netdevice() fails, the error is returned from
macvlan_newlink() to rtnl_newlink_create():

        if (ops->newlink)
                err = ops->newlink(dev, &params, extack);
        else
                err = register_netdevice(dev);
        if (err < 0) {
                free_netdev(dev);
                goto out;
        }

and free_netdev() is called, causing a kvfree() on the struct
net_device that is still referenced in the source entry attached to
the lower device's macvlan port.

Now all packets sent on the macvlan port with a matching source mac
address will trigger a use-after-free in macvlan_forward_source().

</quote valis>

With all that, my fix is to make sure we call macvlan_flush_sources()
regardless of @create value whenever "goto destroy_macvlan_port;"
path is taken.

Many thanks to valis for following up on this issue.

Fixes: aa5fd0fb7748 ("driver: macvlan: Destroy new macvlan port if macvlan_common_newlink failed.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: valis <sec@valis.email>
Reported-by: syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Closes: https: //lore.kernel.org/netdev/695fb1e8.050a0220.1c677c.039f.GAE@google.com/T/#u
Cc: Boudewijn van der Heide <boudewijn@delta-utec.com>
---
 drivers/net/macvlan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index b4df7e184791d0fe0a60c17522b91b2766847b37..c509228be84d1bb836cc221c1022d4037cd5c883 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1567,9 +1567,10 @@ int macvlan_common_newlink(struct net_device *dev,
 	/* the macvlan port may be freed by macvlan_uninit when fail to register.
 	 * so we destroy the macvlan port only when it's valid.
 	 */
-	if (create && macvlan_port_get_rtnl(lowerdev)) {
+	if (macvlan_port_get_rtnl(lowerdev)) {
 		macvlan_flush_sources(port, vlan);
-		macvlan_port_destroy(port->dev);
+		if (create)
+			macvlan_port_destroy(port->dev);
 	}
 	return err;
 }
-- 
2.53.0.rc1.225.gd81095ad13-goog


