Return-Path: <netdev+bounces-284008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPtTExnr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009854C2C5D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C612E30221E6
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E03E6DF2;
	Mon,  4 May 2026 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="PUEB1QUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11F3E6DD6
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920774; cv=none; b=R8CqH4M/t2GggLwmL/xKbeYEVXO4eSFzCpNQ61nb3GqxRuzWz8TpRDtc6PU1nBLQ7ScGPjzWFdiQxRer5WrvmqWl5seDUmSvnNRhYEQlzY/aHQ62dzleqQKU9terLsiJjvHWYkk2IJ4ncpX/9MHRlDOsPOmaEO2T/DV7qLxN5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920774; c=relaxed/simple;
	bh=y4ORDRJDmh9OrfJ0hz6xcNZhqefx7Eo2CtlK+CMOobA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PecGnrdL9A0ZRzHquMssL45pWEFNzgaAHTq+esMvrcN2PN1F0FnS8F6byFRYKqZk7v5S5m8X/Mg+bQ2bmCMoBbzR56YnbR91slcXYDPAG9ydkU+QeU4ODdOyRtu6eZLzR37kMm9Me8zEJHRBKXh3pq9TU+y6wTXmdHwICv+vBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=PUEB1QUW; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f30a4601bbso1051422eec.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920773; x=1778525573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umiOuNQ4F0PD1/2mj1WUPlTegUaQOzlnngHOYuR2SXU=;
        b=PUEB1QUWu271LDQhGQhrDIzgBd7G1njR5JN98zvjT8CJKdC0CUn4gEDipx43LGi2Xm
         pO2YOIK/yHqAaB7iKHMJDEnHUO2UdsM3LcGPE4gnMmOhU8+JUw07YQ0gdodVmIrCJP+E
         iP1s1nqEq4YBTuc03S2HcYSAs6z6/VIfDEnAqg7HqGRzIlq0tpNaEznTLA5hHMDsRBg5
         NO2k7SDH+YiKUvT6XmZg6zvugyr6DE6OGw2AoTDkCd+XmVxu+17cJKffPDSaDbydm/Dm
         EhqELDBjQtYptGmAz52IEoiUWscq79edWn6seiDPMhcVBWoKDq8UXrpnTtdA8qyBTLt+
         yTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920773; x=1778525573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umiOuNQ4F0PD1/2mj1WUPlTegUaQOzlnngHOYuR2SXU=;
        b=Il7g8cY9xfaOhMzl11Wdlh6Vt+eRt2e3B2VjMhpPoNznQD7/efmscvVxMEt2+A2Oik
         HEQJG2441WhGM8AkjTzmpNbUTEEQzkcA9xf3EzhWx/e6pP10ADZ4PAIIr0yjjCW/zGDY
         gtnYL/tGnhUX67ZP9k/jugjTHvt24ae2SrTagxx9OnF6EBhFZH3qOMdKQ0vKr5PtpKuF
         A+eKyMBJtiHAM2pFbPB02jJ34qrhC4dZ0fdgoeD7Kk816MFBRoe8V/4qUhmBeKoN26j/
         MyJMnB/8INfBQV1WyhtSJUItZez+xCSP5MUSgsB7YOt+rQTA93dqEcyNuT+0VIxoaDz0
         idFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f03bdaXy2DhE5YdkVhXgeat1OndSstinVOd0gPxSsFv+vQBmsoFEHbbvE5YJ84GjuiLfe7Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRXnjGEqlrYgOy+7WsmiNE5oJVYldIkRE3D7cXQAdbOM+MKxy
	PzMTcUZl6ffEx8YyEVTt0E6p4wNk4DU8jmCfpajeNO2wrHQBevPvT9ACY2F2hSyNwA==
X-Gm-Gg: AeBDieuBJbc5J+cu7Jqq9QP5zWoHod8SJaSl/i+N1+gOKFlxefcxF/pBOGgmM9V5Uk0
	9XhrY+3O+xidzxBpQKG7KFyozujmGul9lZ2htScT+Mb+5DTXjqZ+Pa9zwwkdCIOiUQhqlGcKPVc
	IG7JNmPZ/8QaWlhe37d8qyNUU0j+MqjPESHgevNZdEIk0Qzx0YkXtq7jx9Xe7dj3oaT6FbErpY9
	q5/yOADHXvGxFeCiTqb2AWTqFy2zJazr60DnCmTwgPvg/iB5gEZ2CBViQm6RqG81yc66Uh7KSru
	Ufsb24AMUWIMczjAXnxJgAXfpRZ4xxpbu8cA5VTyI7lj8QBQvrwbFYd8oURvo2vGgVK3N2vFsA1
	5zqqmTNllprjNRNyN+ykj+YdBYvOtRM/+ye/rDv05EELBPTqGWo08tSezQu8LW2bw7BXLOgbI+k
	xazH4rg2YDDIxP0tGfUeAcraJgBThk3+BT2n6B+2bBnRforso2MB7CMk9SaZ8BhOTF5R9eCHCQV
	gxdMszKKY0=
X-Received: by 2002:a05:7300:1493:b0:2f2:c336:7753 with SMTP id 5a478bee46e88-2f2c3367eddmr1794824eec.31.1777920772439;
        Mon, 04 May 2026 11:52:52 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:52:52 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v10 03/10] ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Date: Mon,  4 May 2026 11:51:15 -0700
Message-ID: <20260504185122.50642-4-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 009854C2C5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284008-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdpnet.ai:mid,herbertland.com:dkim,herbertland.com:email]

From: Tom Herbert <tom@herbertland.com>

IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
processed in ip6_tunnel.c. Add a case for it in the switch in
ip6_parse_tlv so that it is recognized as a known option.

Also remove the unlikely around the check for max_count < 0 since the
default limits for HBH and Destination options can be less than zero.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/exthdrs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 64e85189489c..b50f4b3bf59d 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -122,7 +122,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
 	int tlv_count = 0;
 	int padlen = 0;
 
-	if (unlikely(max_count < 0)) {
+	if (max_count < 0) {
 		disallow_unknowns = true;
 		max_count = -max_count;
 	}
@@ -202,6 +202,16 @@ static bool ip6_parse_tlv(bool hopbyhop,
 					if (!ipv6_dest_hao(skb, off))
 						return false;
 					break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6_TUNNEL)
+				case IPV6_TLV_TNL_ENCAP_LIMIT:
+					/* The tunnel encapsulation option.
+					 * This is handled in ip6_tunnel.c so
+					 * we don't need to do anything here
+					 * except to accept it as a recognized
+					 * option
+					 */
+					break;
 #endif
 				default:
 					if (!ip6_tlvopt_unknown(skb, off,
-- 
2.43.0


