Return-Path: <netdev+bounces-176720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02FBA6BA29
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548E73B0B1A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B8224B1C;
	Fri, 21 Mar 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMLWaBqk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA322332C
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558042; cv=none; b=lwtQF86FVrCBu0AdwplRLcxw4J8HLXVGiqiRQ/ROlBeQGvE/pgPeOubYBrlA/VeHSF2r/VeszXHBuioGKQiExh/K2MHDn0uOMpZzCn1NEvUlt/sBIwM2ege+fb5nRqpm8ikEZOWmty6c6e6P/2F5xDBGkyCiUiz4TOVzG3uQo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558042; c=relaxed/simple;
	bh=fFEBmNXZAj97owxosfDuZ1PvhJ86k5AAufbjCfYBHdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSKn+GWMaU2riYm/lt0DKkWgBgp81P/LJIoBLL4OXANPW1GQNoHL4x6PftvP3Q28sGQiAf/YQtbs+qwzJBVHZkl+B8cJbIg72yQq0O/J+H8YqhOrKDla5svFAV82IBsVVH3OpJh0VwoCTD1Qk6w1SNAOWjN/cDKteXjXWv9GtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMLWaBqk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTBqSO1E5sbU6a5eCrmvivcUTinpdVFuKl5JRaK8lS0=;
	b=WMLWaBqkvq6kTymC9K58hypxmkWxcjHTeWFJfytmv9TFZ7AkSSS6jYpJCSYg9ny42CFUFz
	oBzSd8q5LN0/xU9rg2rFbgVG1zNrrPd9xxu7CIlUug8OkDmg7SabuafPZ6s9RbRk/yqMrS
	ZUcdStIdwgV8kjzHrla4afssTEI4f8I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-11ni0tqsNz2qqDTXToT1Vg-1; Fri,
 21 Mar 2025 07:53:56 -0400
X-MC-Unique: 11ni0tqsNz2qqDTXToT1Vg-1
X-Mimecast-MFC-AGG-ID: 11ni0tqsNz2qqDTXToT1Vg_1742558034
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B825F196D2D0;
	Fri, 21 Mar 2025 11:53:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6986A180175B;
	Fri, 21 Mar 2025 11:53:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH net-next v2 1/5] udp_tunnel: properly deal with xfrm gro encap.
Date: Fri, 21 Mar 2025 12:52:52 +0100
Message-ID: <f4659f17b136eaec554d8678de0034c3578580c1.1742557254.git.pabeni@redhat.com>
In-Reply-To: <cover.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The blamed commit below does not take in account that xfrm
can enable GRO over UDP encapsulation without going through
setup_udp_tunnel_sock().

At deletion time such socket will still go through
udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
trigger the reported warning.

Add the GRO accounting for XFRM tunnel when GRO is enabled, and
adjust the known gro types accordingly.

Note that we can't use setup_udp_tunnel_sock() here, as the xfrm
tunnel setup can be "incremental" - e.g. the encapsulation is created
first and GRO is enabled later.

Also we can not allow GRO sk lookup optimization for XFRM tunnels, as
the socket could match the selection criteria at enable time, and
later on the user-space could disconnect/bind it breaking such
criteria.

Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - do proper account for xfrm, retain the warning
---
 net/ipv4/udp.c         | 5 +++++
 net/ipv4/udp_offload.c | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index db606f7e41638..79efbf465fb04 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2903,10 +2903,15 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
 {
 #ifdef CONFIG_XFRM
 	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
+		bool old_enabled = !!udp_sk(sk)->gro_receive;
+
 		if (family == AF_INET)
 			WRITE_ONCE(udp_sk(sk)->gro_receive, xfrm4_gro_udp_encap_rcv);
 		else if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
 			WRITE_ONCE(udp_sk(sk)->gro_receive, ipv6_stub->xfrm6_gro_udp_encap_rcv);
+
+		if (!old_enabled && udp_sk(sk)->gro_receive)
+			udp_tunnel_update_gro_rcv(sk, true);
 	}
 #endif
 }
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 088aa8cb8ac0c..02365b818f1af 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -37,9 +37,11 @@ struct udp_tunnel_type_entry {
 	refcount_t count;
 };
 
+/* vxlan, fou and xfrm have 2 different gro_receive hooks each */
 #define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
 			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
-			      IS_ENABLED(CONFIG_NET_FOU) * 2)
+			      IS_ENABLED(CONFIG_NET_FOU) * 2 + \
+			      IS_ENABLED(CONFIG_XFRM) * 2)
 
 DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
 static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
-- 
2.48.1


