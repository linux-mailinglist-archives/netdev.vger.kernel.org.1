Return-Path: <netdev+bounces-32323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5E7941D9
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 19:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3199E1C20A22
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457710968;
	Wed,  6 Sep 2023 17:08:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899746A2
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 17:08:52 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492213E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:08:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF3C720007;
	Wed,  6 Sep 2023 17:08:48 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Dave Watson <davejwatson@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net 0/5] tls: fix some issues with async encryption
Date: Wed,  6 Sep 2023 19:08:30 +0200
Message-Id: <cover.1694018970.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I've been playing with a few hacks in the crypto code (forcing async
crypto for every request, smaller cryptd queue), and that has revealed
some bugs while running the selftests.

With this setup and those patches applied, the bad_in_large_read test
case still fails. With all-async crypto, we don't know which record
threw the EBADMSG, so we can't keep the first couple of records that
were decrypted correctly. We have to throw away the whole batch.

Liu Jian has also found a bug with async crypto and wrapping record
numbers:
https://lore.kernel.org/netdev/20230906065237.2180187-1-liujian56@huawei.com/
It will get fixed separately and I'll submit a selftest for this case.

Sabrina Dubroca (5):
  net: tls: handle -EBUSY on async encrypt/decrypt requests
  tls: fix use-after-free with partial reads and async decrypt
  tls: fix returned read length with async !zc decrypt
  tls: fix race condition in async decryption of corrupted records
  tls: don't decrypt the next record if it's of a different type

 net/tls/tls_sw.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

-- 
2.40.1


