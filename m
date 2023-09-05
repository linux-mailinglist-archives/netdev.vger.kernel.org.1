Return-Path: <netdev+bounces-32063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E93792253
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1060B28111D
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F168DD304;
	Tue,  5 Sep 2023 11:55:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E6D2FF
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:55:21 +0000 (UTC)
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 04:55:20 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608231B6;
	Tue,  5 Sep 2023 04:55:20 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  5 Sep 2023 13:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1693914590; bh=FxjzhMsEXbd2V05at0TDRKWZ5Vs57RGKp/5uaokS04U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aKkOEyu7ZG4ESRwHolf1wmfg4si8EhEKSvRdsiddd2RKSwSkqfZ21ligIa6FVby40
	 hNADXAi7bMf63zPagSchspJJooyd9G+yZpzsUOcIhFUNcqD4r1M3o3v8ImP7Cd4GeZ
	 f/iR48dmT81T0zRq2c8X3QAapgo29Ac6FUo9Af+8=
Received: from localhost (unknown [172.17.88.63])
	by mail-auth.avm.de (Postfix) with ESMTPSA id 31DB382158;
	Tue,  5 Sep 2023 13:49:50 +0200 (CEST)
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Tue, 05 Sep 2023 13:47:19 +0200
Subject: [PATCH net-next v3 2/6] net: bridge: Set strict_start_type for
 br_policy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-fdb_limit-v3-2-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
In-Reply-To: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
 David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, 
 Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Johannes Nixdorf <jnixdorf-oss@avm.de>
X-Mailer: b4 0.12.3
X-purgate-ID: 149429::1693914590-4C48745F-8F184E4A/0/0
X-purgate-type: clean
X-purgate-size: 807
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Set any new attributes added to br_policy to be parsed strictly, to
prevent userspace from passing garbage.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 net/bridge/br_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 05c5863d2e20..1dc4e1bce740 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1217,6 +1217,7 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
 }
 
 static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
+	[IFLA_BR_UNSPEC]	= { .strict_start_type = IFLA_BR_MCAST_QUERIER_STATE + 1 },
 	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
 	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
 	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },

-- 
2.42.0


