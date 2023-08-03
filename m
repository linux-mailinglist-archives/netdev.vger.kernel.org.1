Return-Path: <netdev+bounces-24126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8D76EE0B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1862821AA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB13200CC;
	Thu,  3 Aug 2023 15:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160B6FA2
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:27:08 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED443180
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:27:03 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qRaEA-00066O-B4; Thu, 03 Aug 2023 17:27:02 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: sbrivio@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	dsahern@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	shuah@kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net 0/2] tunnels: fix ipv4 pmtu icmp checksum
Date: Thu,  3 Aug 2023 17:26:48 +0200
Message-ID: <20230803152653.29535-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The checksum of the generated ipv4 icmp pmtud message is
only correct if the skb that causes the icmp error generation
is linear.

Fix this and add a selftest for this.

Florian Westphal (2):
  tunnels: fix kasan splat when generating ipv4 pmtu error
  selftests: net: test vxlan pmtu exceptions with tcp

 net/ipv4/ip_tunnel_core.c           |  2 +-
 tools/testing/selftests/net/pmtu.sh | 35 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.41.0


