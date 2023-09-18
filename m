Return-Path: <netdev+bounces-34564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC887A4A70
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9804428224F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68DA1D541;
	Mon, 18 Sep 2023 13:02:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E921D53C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:02:04 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B081AB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:59:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qiDqc-00073Y-2T; Mon, 18 Sep 2023 14:59:30 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: nharold@google.com,
	lorenzo@google.com,
	benedictwong@google.com,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next 0/2] xfrm: policy: replace session decode with flow dissector
Date: Mon, 18 Sep 2023 14:59:07 +0200
Message-ID: <20230918125914.21391-1-fw@strlen.de>
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

Remove the ipv4+ipv6 session decode functions and use generic flow
dissector to populate the flowi for the policy lookup.

Changes since RFC:

 - Drop mobility header support.  I don't think that anyone uses
   this.  MOBIKE doesn't appear to need this either.
 - Drop fl6->flowlabel assignment, original code leaves it as 0.

There is no reason for this change other than to remove code.

Florian Westphal (2):
  xfrm: move mark and oif flowi decode into common code
  xfrm: policy: replace session decode with flow dissector

Florian Westphal (2):
  xfrm: move mark and oif flowi decode into common code
  xfrm: policy: replace session decode with flow dissector

 net/xfrm/xfrm_policy.c | 277 ++++++++++++++++-------------------------
 1 file changed, 107 insertions(+), 170 deletions(-)

-- 
2.41.0


