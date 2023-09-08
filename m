Return-Path: <netdev+bounces-32566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16457986B7
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 14:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204B5281A02
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60F55226;
	Fri,  8 Sep 2023 12:06:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA24C7B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 12:06:37 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D31BC5
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 05:06:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qeaFt-00061w-Fm; Fri, 08 Sep 2023 14:06:33 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: [RFC ipsec-next 0/3] xfrm: policy: replace session decode with flow dissector
Date: Fri,  8 Sep 2023 14:06:17 +0200
Message-ID: <20230908120628.26164-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RFC, its only lightly tested, if at all.

This replaces the ipv4+ipv6 session decode functions in xfrm
with a flow dissector description and then uses that to populate
the flowi.

Main drawback is that if we don't want to break MOBIKE the
flow dissector needs more bloat to get to the mh_type from
the ipv6 mobility extension header.

Comments welcome, mainly sent for the sake of next weeks
IPSec workshop.

Florian Westphal (3):
  xfrm: move mark and oif flowi decode into common code
  flow_dissector: add ipv6 mobility header support
  xfrm: policy: replace session decode with flow dissector

 include/net/flow_dissector.h |   5 +
 net/core/flow_dissector.c    |  27 ++++
 net/xfrm/xfrm_policy.c       | 290 +++++++++++++++--------------------
 3 files changed, 152 insertions(+), 170 deletions(-)

-- 
2.41.0


