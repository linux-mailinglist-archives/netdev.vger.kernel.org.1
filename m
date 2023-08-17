Return-Path: <netdev+bounces-28310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7E77EF86
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40A61C2110D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85742639;
	Thu, 17 Aug 2023 03:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E71638
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:28:23 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182D10E6
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:28:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc0d39b52cso46706855ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692242901; x=1692847701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj4gH2ezZcdsYe6ys9dkVYH5040knkAeB6AARsUR30I=;
        b=VPirofcb3Ghex7IWGdAepnecgK+OJCiKdHuJmpNA0kv1snGrHrpxS/WkCLn9yBYqiw
         O4N7wxmw3RdiYxnhaQGVsUjSrnTsv5zpVXFpejf8Z7K8pKNknsDobRl55YmjQEzouI6g
         dSErSMXYnXxS7hoIFMRx6LmR58mVhjuPjyITKfHuYA+oEUAdr0i2esz5iyPsVg0OF13w
         dDkX9gNZ5lYXqgN72iCQp7rYUPX+ZTPzmRbnaG1haer4tkdc68bLspfsb7WOQH1ohSV9
         s9uHXkygOniMUA2dPnLZCgl6swGLbTOZqIdpU7KCNrsgW78M0bR/xtTFAh3I0DSOwY4n
         p9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692242901; x=1692847701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kj4gH2ezZcdsYe6ys9dkVYH5040knkAeB6AARsUR30I=;
        b=TTtcymHraSKmQBYSuy+JCHgGoWcU4gfmLxsuOtN6VGp8syvTozvYoE6RWFEEkbB1jz
         mtj55tNj5r9ub1qvBdSi552iMkiayEUppGpQgP/Ydvox6LVATYBRwpRFqANY0VpWSvzN
         KsWri2U03acpHmYHQpUayIRnlSEhhM3we+g8Oxt5sCtRuEGRFOoVhpVYLxvWPNK53wOT
         Hmh9/VZmnZ6EbbaARXqi8aFPeeBRo7zD0yRwSfRz989CJSweKhBj82LzmUN/L34ITADd
         Bnoa5LSShN3IrDiqRZoEBbRQnWJ9HYRczSKt3eNYQb81bWhHaYBpjTO1JFebnJUWW1hL
         b39g==
X-Gm-Message-State: AOJu0Yx8+HCkKVEBkkekIa7Eefo7J69+1+1UB7/HtRxSlDadGozmcwFP
	RceL4wP65qZ+P4dQFwRDVviR/EHy1TgoqDOE
X-Google-Smtp-Source: AGHT+IFe4V2+01RFv2etg1wtdpRvCyLlLrib2PKAOv7GJFX5PQSpk0mHQ8hmVa2Jd2psxBeJLcUA6w==
X-Received: by 2002:a17:902:efcc:b0:1bc:382b:6897 with SMTP id ja12-20020a170902efcc00b001bc382b6897mr3695874plb.13.1692242900790;
        Wed, 16 Aug 2023 20:28:20 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902a41200b001bdc50316c3sm10136580plq.232.2023.08.16.20.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 20:28:19 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] IPv4: add extack info for IPv4 address add/delete
Date: Thu, 17 Aug 2023 11:28:15 +0800
Message-Id: <20230817032815.1675525-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add extack info for IPv4 address add/delete, which would be useful for
users to understand the problem without having to read kernel code.

No extack message for the ifa_local checking in __inet_insert_ifa() as
it has been checked in find_matching_ifa().

Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv4/devinet.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5deac0517ef7..40f90d01ce0e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -509,6 +509,7 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 				return -EEXIST;
 			}
 			if (ifa1->ifa_scope != ifa->ifa_scope) {
+				NL_SET_ERR_MSG(extack, "ipv4: Invalid scope value");
 				inet_free_ifa(ifa);
 				return -EINVAL;
 			}
@@ -664,6 +665,7 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ifm = nlmsg_data(nlh);
 	in_dev = inetdev_by_index(net, ifm->ifa_index);
 	if (!in_dev) {
+		NL_SET_ERR_MSG(extack, "ipv4: Device not found");
 		err = -ENODEV;
 		goto errout;
 	}
@@ -688,6 +690,7 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return 0;
 	}
 
+	NL_SET_ERR_MSG(extack, "ipv4: Address not found");
 	err = -EADDRNOTAVAIL;
 errout:
 	return err;
@@ -839,13 +842,23 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 
 	ifm = nlmsg_data(nlh);
 	err = -EINVAL;
-	if (ifm->ifa_prefixlen > 32 || !tb[IFA_LOCAL])
+
+	if (ifm->ifa_prefixlen > 32) {
+		NL_SET_ERR_MSG(extack, "IPv4: Invalid prefix length");
+		goto errout;
+	}
+
+	if (!tb[IFA_LOCAL]) {
+		NL_SET_ERR_MSG(extack, "ipv4: Local address is not supplied");
 		goto errout;
+	}
 
 	dev = __dev_get_by_index(net, ifm->ifa_index);
 	err = -ENODEV;
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "ipv4: Device not found");
 		goto errout;
+	}
 
 	in_dev = __in_dev_get_rtnl(dev);
 	err = -ENOBUFS;
@@ -896,7 +909,14 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 		struct ifa_cacheinfo *ci;
 
 		ci = nla_data(tb[IFA_CACHEINFO]);
-		if (!ci->ifa_valid || ci->ifa_prefered > ci->ifa_valid) {
+		if (!ci->ifa_valid) {
+			NL_SET_ERR_MSG(extack, "ipv4: valid_lft is zero");
+			err = -EINVAL;
+			goto errout_free;
+		}
+
+		if (ci->ifa_prefered > ci->ifa_valid) {
+			NL_SET_ERR_MSG(extack, "ipv4: preferred_lft is greater than valid_lft");
 			err = -EINVAL;
 			goto errout_free;
 		}
@@ -954,6 +974,7 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			int ret = ip_mc_autojoin_config(net, true, ifa);
 
 			if (ret < 0) {
+				NL_SET_ERR_MSG(extack, "ipv4: Multicast auto join failed");
 				inet_free_ifa(ifa);
 				return ret;
 			}
@@ -967,8 +988,10 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		inet_free_ifa(ifa);
 
 		if (nlh->nlmsg_flags & NLM_F_EXCL ||
-		    !(nlh->nlmsg_flags & NLM_F_REPLACE))
+		    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
+			NL_SET_ERR_MSG(extack, "ipv4: Address already assigned");
 			return -EEXIST;
+		}
 		ifa = ifa_existing;
 
 		if (ifa->ifa_rt_priority != new_metric) {
-- 
2.38.1


