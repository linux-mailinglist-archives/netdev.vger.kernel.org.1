Return-Path: <netdev+bounces-286940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOv1C7SqAmqkvQEAu9opvQ
	(envelope-from <netdev+bounces-286940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:21:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD435198BA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A3453021BE4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591F32E68D;
	Tue, 12 May 2026 04:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jknoj79U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7731578E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559651; cv=none; b=IkUOLm5ozxjwEbkXQ5lAtGgYRs3gRrR6AzULbEAroKXT9LYgjs+bJui2vZAJ2iRnjRoZYjFd69J5+Ew2i1hj5zDoZKIhEuWUKuYBALjxQFOsjZVnQwAOC3QD2etynWmBfHuJh18kK9gl2xy2mRsvpfmU+W/UMUE6Rhuo+yc2uFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559651; c=relaxed/simple;
	bh=eaO/GAO2q9KnLpudsDf6ByiH6uufTvW/8bDXbw/Lot4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bk/OBGTKPUQsDBA1Zc4Fwe9WzPRbDtkZaukSPAukb/yGaNA+97tbJZ2K7oN5iYaFRZWNOwc4uWWQx6iYQjWBKqRQJf1x7/Ba3DPUtOc8/2HFQ+IXai71pwEabBDFqBFu999cyJONRkY8AWdawx+X9J8FH7OQB3+xoo2V3AvzILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jknoj79U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d102471a4so49394905e9.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778559647; x=1779164447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrTxPrLZSrX9/AE26HqoZYG+0GxCFkz4Bhu3XTJcKCM=;
        b=jknoj79UDYd4IZAHjm5zToPiEa1hoP+cMULohiFLl6UG/+efO4dh/h3pH+KB7UYRRK
         MGpHuKa3cta/klU91PB/m1HEaBCCX/9y/OGoKxvzM4lOk9QJspXePGDej4VRC4vWszjB
         fOSLB1lV8YwZDMengKUXGUY2UbPSV0zzNdNJhlbcrZmsaYrpj0K3ITxRJIEvuQVuplmz
         gWNwJvvClhvO4mJfS8bo7LHBmT2aH6oyHn6KuywIf8I/xQWHQJ1DKHfjaxb8pJrxZvgI
         P0l/j6xTYnyJ+uc7ejepen/aiHLzqn/p4qulXMmv/ALEvg8fhlks6Uo9mqnn3356KCaa
         g8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778559647; x=1779164447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrTxPrLZSrX9/AE26HqoZYG+0GxCFkz4Bhu3XTJcKCM=;
        b=ot2DlG8OVH5c/wTISxEqILrNkLob0XpBGSVVJaw9bovZVSGj0T1uBBl/PkllavLhii
         8AR7YK/D6fpVz3GxHYNd+JcKnHp1JDKWrWEiUcpVzGVM4dR83KYbj8QXcNSbKaTMfaRT
         Kx7Nchi0ECIs8kJLTz4FC6QnkrRaBsjxZhfqQXEdXKbUGteynPdz7fGnSknObfaTR3F9
         Rf7tqnkHqZDlaN/UvJt3bjVK5JSLvzif41GzoYwVTtq5vLYoaggqOoS9jyBgMK0GxeSZ
         5YGoxpDn5PtECM3HCxExaogNDIXR3YNx3dBRZ06JrA0thOl/N9uZBPXVx+qLcgM0mI4n
         rYrg==
X-Gm-Message-State: AOJu0Yx+oz2Js2CIZLEb2dDdOKS/OKizQsjqBr9UFMgxM3jM/NgaTOX8
	GkXZTKIS9gJ8EkQThVlsVoB8lBti79n4OL6+e83Av/VT03klrRwsOVfcO7KKzhXqxV3E5Q==
X-Gm-Gg: Acq92OH5ThVWimTtVPU05mFe+v9ZWrS3iwroGawNBWLjWS5IwClOSfrq1oAjFB9j5wo
	Xqm7ckXVRAmNzVAH2Rfunv9EHigY0pjtqDbK3gassb3oG0aCF1mJWGZide652+DeQPqOulMPrbA
	aINwhABqpmCHoKhUSNobabQnh3zJCYi7x0bRfgD8d88E/sOUkUgdwn4cy0Lb3J0R8gvjoJFyqth
	Ci2qiLBfvzVgUDoVWmMIC9ouzZqiFyYPHNAFRrhI3UAj7JRA370yaPf+PtkjvXwlVDDsrtzk/KA
	6JlYG6Ph9ei45P6CaLRLEK+kyBzwNGbDjSCtwe4JMzJZF1fGAlRPt5EVtgT7i3EvKMW/ziQv2IB
	GPIhRn3DudLnPstiKS30AOyQeVj4Ftkm3Y7Kc153hPrtfvidV1P5Kf7tJ5DYxp4IrjnT95O18y2
	bsfoqb8z/SYjWx+dEbUbssL7RuCQvJc4RhZ+VkO8k8N1U0CC311CAsuBBgmsmWFkRmNl6WNfWDH
	ICd4k4M+rU=
X-Received: by 2002:a05:600c:524e:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48e676c14b9mr262868345e9.29.1778559647181;
        Mon, 11 May 2026 21:20:47 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e908d2c77sm16802215e9.12.2026.05.11.21.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:20:46 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] ovpn: respect peer refcount in CMD_NEW_PEER error path
Date: Tue, 12 May 2026 05:19:13 +0100
Message-ID: <20260512042036.19870-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512042036.19870-1-devnexen@gmail.com>
References: <20260512042036.19870-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDD435198BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,openvpn.net,queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286940-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

ovpn_nl_peer_new_doit()'s error path calls ovpn_peer_release() directly
rather than ovpn_peer_put(), bypassing the kref. The accompanying
comment ("peer was not yet hashed, thus it is not used in any context")
holds for UDP but not for TCP.

For UDP, the ovpn_socket union uses the .ovpn arm and never points back
at a peer; UDP encap_recv looks up peers via the not-yet-populated
hashtables, so the new peer is unreachable until ovpn_peer_add()
publishes it.

For TCP, ovpn_socket_new() sets ovpn_sock->peer and
ovpn_tcp_socket_attach() publishes ovpn_sock via rcu_assign_sk_user_data().
From that moment until ovpn_socket_release() detaches in the error path,
the TCP fd is fully wired: userspace recvmsg / sendmsg / close / poll
on the fd, as well as the strparser-driven ovpn_tcp_rcv() path, can
reach the peer through sk_user_data -> ovpn_sock->peer and bump its
refcount via ovpn_peer_hold().

ovpn_tcp_socket_wait_finish() (called inside ovpn_socket_release())
drains strparser and the tx work, but does not synchronize with
userspace syscall callers that already hold a peer reference. If
ovpn_nl_peer_modify() or ovpn_peer_add() returns an error while such
a caller is in flight - notably an ovpn_tcp_recvmsg() blocked in
__skb_recv_datagram() on peer->tcp.user_queue - the direct
ovpn_peer_release() destroys the peer while the caller still holds
the reference, and the eventual ovpn_peer_put() from that caller
operates on freed memory.

Replace the direct destructor call with ovpn_peer_put() so the kref
correctly defers destruction until the last reference is dropped.
In the common case where no concurrent user is present, behaviour is
unchanged: the kref hits zero immediately and ovpn_peer_release_kref()
runs the same destructor.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ovpn/netlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 291e2e5bb450..4c66c1ec497e 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -462,10 +462,12 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 sock_release:
 	ovpn_socket_release(peer);
 peer_release:
-	/* release right away because peer was not yet hashed, thus it is not
-	 * used in any context
+	/* For UDP, the peer is unreachable until added to the hashtables, so
+	 * dropping the initial reference is enough. For TCP, the peer may be
+	 * concurrently reachable via sk_user_data->peer until
+	 * ovpn_socket_release() detaches; rely on the refcount.
 	 */
-	ovpn_peer_release(peer);
+	ovpn_peer_put(peer);
 
 	return ret;
 }
-- 
2.53.0


