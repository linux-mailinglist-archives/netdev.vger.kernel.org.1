Return-Path: <netdev+bounces-295222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xx1HGjFwIWq9GQEAu9opvQ
	(envelope-from <netdev+bounces-295222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:31:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C563FE2F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:31:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eX1TVbd9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295222-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295222-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9195C30296D6
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABD4418FC;
	Thu,  4 Jun 2026 12:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938A43DA4C
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:19:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575601; cv=none; b=fG0ZIeUiwKmG5168KsJsglLmJCKMhG7ahmYvYkpXx3EcWt4j/SIYzJME1djjtZELTMrDB9DipuYn6IhNUoGE3LH5hiACbEy2kyeSiEwf9zkcTa4rknmGEbr60O79sQ2TECfKA9FFpcfYQ8TtZ1LUUf1kq1DxTK+PbXLLz+yg2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575601; c=relaxed/simple;
	bh=SI0wUmmssdNyLig00onMvpbP/Rf7xOYdVtG8qWFPk8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZslyR6swXZilN61Ot0zUzSBK0keVP3NXReRgGi3v5+tNXV0DgoozwGQwiE/SCEUkZvaUAua7NDHyRR0IvGpwjKEPYQaQhAX1GQJN79PsmPBiFPIAF+UVUJ8/O38U6sNCFDgBYgfBHn9vDHcXxL1T8Ek9pzpq8g/4IWBHjJp2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX1TVbd9; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780575598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rQk73RjGmv1YYZSKsEIY/tBeBU1Z6whR3boOZNNywYE=;
	b=eX1TVbd9gGSMoiyEKb3Cw0mc2Yy7GlQ1tTArRwmxpZ9dBkza855f77m9C0qXGX4559RoGk
	MYV+2O66IZ9zTOMPw8DaA2Fx2qEzuAwT/YDKcrUMPBieFmhTifvSAr7Bo7mX/6Z4wOlVGV
	qXy/4ICB//ELru8Y6ICheb8w/kqskpY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-V6AZ3xNrNeeUPKgNMdDDkw-1; Thu,
 04 Jun 2026 08:19:55 -0400
X-MC-Unique: V6AZ3xNrNeeUPKgNMdDDkw-1
X-Mimecast-MFC-AGG-ID: V6AZ3xNrNeeUPKgNMdDDkw_1780575593
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59AAF1956052;
	Thu,  4 Jun 2026 12:19:53 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.32.149])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1D411955BC1;
	Thu,  4 Jun 2026 12:19:48 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pravin B Shelar <pshelar@nicira.com>,
	Jarno Rajahalme <jrajahalme@nicira.com>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: openvswitch: fix possible kfree_skb of ERR_PTR
Date: Thu,  4 Jun 2026 14:19:46 +0200
Message-ID: <20260604121946.942164-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295222-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:amorenoz@redhat.com,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:pshelar@nicira.com,m:jrajahalme@nicira.com,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 613C563FE2F

After the patch in the "Fixes" tag, the allocation of the "reply" skb
can happen either before or after locking the ovs_mutex.

However, error cleanups still follow the classical reversed order,
assuming "reply" is allocated before locking: it is freed after unlocking.

If "reply" allocation happens after locking the mutex and it fails,
"reply" is left with an ERR_PTR, and execution jumps to the correspondent
cleanup stage which will try to free an invalid pointer.

Fix this by setting the pointer to NULL after having saved its error
value.

Fixes: 893f139b9a6c ("openvswitch: Minimize ovs_flow_cmd_new|set critical sections.")

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index bbbde50fc649..f0164817d9b7 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1316,6 +1316,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 		if (IS_ERR(reply)) {
 			error = PTR_ERR(reply);
+			reply = NULL;
 			goto err_unlock_ovs;
 		}
 	}
-- 
2.54.0


