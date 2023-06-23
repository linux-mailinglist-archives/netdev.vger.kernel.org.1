Return-Path: <netdev+bounces-13494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B0573BDD7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C001C281CA5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B326100D8;
	Fri, 23 Jun 2023 17:34:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836C100D0;
	Fri, 23 Jun 2023 17:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8CAC433C0;
	Fri, 23 Jun 2023 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687541656;
	bh=FLvkBTqQ4fDkpvhNSEDzGht6wnWmChrIOkilvXMac20=;
	h=From:Subject:Date:To:Cc:From;
	b=WyapiKWySuAzrTlb5d71tifkQ7hvUa3iH0wpVKaavCf1aqNDeCjkE8UuNjvZicpvk
	 ClgerCiLM5oPa/BVwToSq0+4Hlww7Sh3SpdOEpHFL0Hqi5Ooxo5xW63uP+X64ICT5n
	 y+rtV6JC55JKYzdpclNswn2re7VAXKaFlfJozsb2+lKds563kqCn0zpk8nkzyjrbth
	 CGl3baIBVNzuNVx6qibL49afGPTtR7xnQ1q8xNp4sjrPNPGoCDpflc9zUvdhKPc4GT
	 7fIihJaLqWqiwen8i0rUNzFqN+tL0uu7LbF2DIlugrLxmofnYFVIyOJmzhodQ/Q3hD
	 nPucpAdRfYkYQ==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next 0/8] selftests: mptcp: Refactoring and minor fixes
Date: Fri, 23 Jun 2023 10:34:06 -0700
Message-Id: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI7XlWQC/z2NsQrDMAxEfyVoriCVTYf+Sung2GqjRQmSKYaQf
 49TaIcb3h13t4GzCTvchw2MP+KyaIfrZYA8J30zSukMNFIYbxTQWQsq165W8W8HisQ5lhgyQS9
 PyRknS5rns85tXayewWr8kvZ9fMBvB577fgDJxfTZiwAAAA==
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>, 
 Yueh-Shun Li <shamrocklee@posteo.net>
X-Mailer: b4 0.12.2

Patch 1 moves code around for clarity and improved code reuse.

Patch 2 makes use of new MPTCP info that consolidates MPTCP-level and
subflow-level information.

Patches 3-7 refactor code to favor limited-scope environment vars over
optional parameters.

Patch 8: typo fix

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (7):
      selftests: mptcp: test userspace pm out of transfer
      selftests: mptcp: check subflow and addr infos
      selftests: mptcp: set FAILING_LINKS in run_tests
      selftests: mptcp: drop test_linkfail parameter
      selftests: mptcp: drop addr_nr_ns1/2 parameters
      selftests: mptcp: drop sflags parameter
      selftests: mptcp: add pm_nl_set_endpoint helper

Yueh-Shun Li (1):
      selftests: mptcp: connect: fix comment typo

 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 631 ++++++++++++---------
 2 files changed, 369 insertions(+), 264 deletions(-)
---
base-commit: faaa5fd30344f9a7b3816ae7a6b58ccd5a34998f
change-id: 20230623-send-net-next-20230623-3242ec4d43c2

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


