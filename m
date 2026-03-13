Return-Path: <netdev+bounces-267595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJbmK+94tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:51:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BCA289E6A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CD7D305ACB1
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B33803D0;
	Fri, 13 Mar 2026 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OxR/c4o1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD737F8B7
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435113; cv=none; b=lpsJQhKfzGYjiO2g5bzTaHErNHypN4LlsYC3iRb2uvPDFlaKuWBws4NP4hJvgDJO7rnhpZ2QTbsZoqy/hIGP8l2pb7Fzyuzj48YW4ctYzB96hBB0GJeBmxsTcPKGWzw7HyB252agG2YFH9Gj7wqpiBbOSzsTWo4LHjG2V58Vlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435113; c=relaxed/simple;
	bh=aTGdGKIbN78z0HccJeLIaLaLIQQWPHWa0zQSLVb6wio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Md3TN4wc8hN49DH+LlQnuTMK0ywB+l34JxTG9qALfAgGFr6FqyqDCzH5ydKlm5mVQvI3rgcR4aRsimgU3bPYmVZdh/X6KF3/Z4FOy8pJHYO4nqbk4HC/8SB62ywB85eIeIqiGMcMXYn/EduQdzoxNX83ELI9EcpvqwqC9k5bJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OxR/c4o1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so2767619f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773435110; x=1774039910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=OxR/c4o1f0QC8cN3WE+/q09o5uOssYcl/zvikjv58JmrBg7GjLkI7VUuZGZX2G1iGi
         m93ksJcnvj3tfY+AQCdzfXmuSgMRC/fja8fhszoSoS35msvXVO0w6cfr/xxZRVWQmx4u
         IGOZe6nHjL3wBkdMQmY+UCbEl7uaD+zgKPm1FoJOzOjP9aV716N19SRSyEaYV50e7G76
         QfHYvs0Rdazq5bI26vIxFiZoAWM9g/tPmDSFrWGu+HQbNeA+7HUIAiV4tiMUi0eFSwPW
         n5hT6HwyJMyMSHnYHo3G9cHtxiF38tfVMbxiZptDuqVx6rxwElReudZL0Z9hVIvRSG4f
         f+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435110; x=1774039910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=bC7/sC+sjPN2ito9xq+8PtZNsUgL3zRSUvnU3ZtH2sT1cuJJJYmWTQLgjzF8dD+ZlQ
         aps15OE2oi3ifrszq1mxUELR3obXMQ82twkFAy5PM3VXs3kZA2kX/oLBbRWq46LaWI9j
         NMUijjsBuNpLlFUdyMTsEfzjsP9mLlOj0nS9tgKkTh8FgfDBwy9QqMzuNxYHALBqy/7k
         eGZG1jklkrnQSDq7Kcm+HMvBv/nPEt+0s0GB4BjwG/gft+FMwAnM9ZWeEPTnww6a9pEa
         z19eaPgsNEu/YKfQqE7j8CwIMN9oAJmdyt6/+5+pDYn9X6MPntDa3JZ+S9sWbqsE7bOA
         pDhw==
X-Gm-Message-State: AOJu0YyoZsfLO5U+T+QtTEb6/btqJRKnOca/IUOQ6z5FjIrdIg+GPbcY
	3z1t6dTK/31GVon/mQIIx5CeSOgArsRlFxAKxBBiGQBgwrewbh526/iBosUUM2JznXIMpL9t83W
	OUo+EKHlwVWGUP7Mjr7LeiCmzY2P+Jydev91N3iUsY9ZjDzT80UAItEcWNSp4I6t7
X-Gm-Gg: ATEYQzz0By3rZlIDLj6sdDMkoiyIAdIkc1SOVLc7BtxXRV9EmPZIvKEaFso4Ld5I17G
	R0NLs1P+N9VF0KsKKx5qIjObmIgpZvfmvHhgVhMdOI2+GU8RMjCftRh+rDqJuv2CjGmr+HEwfWV
	dqBbDZUR2RFT/rqnHuVg13TTkz+YSpoc13G/Y80zBfXznySoiqx0Bx1sQjeywlROiqWNH37N+0S
	BRTcx9t/G5ULflDpg/J0Qtc8sQab6NciDSR5MG345I5uBaoWQ2eWpW+kSmZvP0OklCV6NigEDyc
	Qf1utQn0+sctibFaYr638m1LTpHIa01OPavmQ8yC9Rif9yEYaMOCGrj5KeB60R5ycrtC+C93kFG
	+GvYmM8INzBQTPBs/tJ8Kll2AnpHpvWDmzSMY+adv9IpSRugXKF8JH0OxhUpiTfAGezXuQ7taBZ
	NTODYYgxFfDcR1zINRCOlWbPocqG1RmxRYthli0inVVie3kIU=
X-Received: by 2002:a05:6000:2901:b0:43a:3cc:83da with SMTP id ffacd0b85a97d-43a04d8623emr9239642f8f.18.1773435110147;
        Fri, 13 Mar 2026 13:51:50 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9684:4355:e76d:6ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm23120468f8f.34.2026.03.13.13.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:51:49 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/9] ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit
Date: Fri, 13 Mar 2026 21:51:32 +0100
Message-ID: <20260313205139.2950-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313205139.2950-1-antonio@openvpn.net>
References: <20260313205139.2950-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267595-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: 31BCA289E6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

In ovpn_nl_key_swap_doit, the attributes array used to parse the
OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.

The wrong constant was introduced by commit 203e2bf55990
("ovpn: implement key add/get/del/swap via netlink")

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c7f382437630..fed0e46b32a3 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1061,8 +1061,8 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
-- 
2.52.0


