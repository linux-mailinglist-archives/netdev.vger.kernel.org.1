Return-Path: <netdev+bounces-87156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF438A1E42
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA51C206FD
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684F778C82;
	Thu, 11 Apr 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC4qHTvF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DEE3717B
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858525; cv=none; b=TBMC2r8en/x52r09dem3Hwrb6zLt6Y2b8Ee6QsReW6xjMFJzYQneIGTrLbUl+P7h6hiZRL2z+/AR7m1K+gR9W7pj9OTbyaSo1ZAnkU8xY/IY+8mzkQ7PZNUl3JG9kQXA+vfpGNL6adblg+b73C32LBSSCqBcO0xLq1M1EOKjVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858525; c=relaxed/simple;
	bh=pB0yJMTHQPFpyWwBrRC1MsRB12f2RZKv65uPxMBMNMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vb/Hj9JFNjSgVhsZlilgbTJpACMSQ/1ywoPC62G8fCKPsGXAWmoic+XItP8f4Q1TKRuv/yoQ6kc4W2uQe4KpCCi6my7hWNsxMML8DaNJ75EyBrSiRaHmfIYLwAwZI5u5jZXe6FmA7Q0U0eyKDAT9RUad0WPM8LdSFk98YDYRHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC4qHTvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A85C072AA;
	Thu, 11 Apr 2024 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712858524;
	bh=pB0yJMTHQPFpyWwBrRC1MsRB12f2RZKv65uPxMBMNMI=;
	h=From:To:Cc:Subject:Date:From;
	b=BC4qHTvFg4BIFO1rbiR3OO4HfuR9HBu/JaJW2c5j981kqUo+lNpfVvZfwAHvyGsMm
	 FJH3KMWQ+A0+UtsXnPcbGgggo2ErzGQd8R7oQAaT71cc4RYzPGHw8jtkJUgotLppyI
	 m/gEiLla47Ik8MWBQWuoffFADjkorUytLc823ZYZ9fjDSp0CRglUXir4bcIDKkUdRx
	 D1way7HT43eJ0DlXeFkoP/2oCx5zgYXFbhYm66gtvCPFIh+XoyTr3gUvohdQ4sTHY+
	 eWREtdJotjKkbH4ZtEol1NcHvScnpzbS4hFYw+B8AZrP7Y9U77EqBITGys64D7mY7E
	 LXFvfojjsfzfA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dsahern@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
Date: Thu, 11 Apr 2024 11:02:02 -0700
Message-ID: <20240411180202.399246-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit under Fixes optimized the number of recv() calls
needed during RTM_GETROUTE dumps, but we got multiple
reports of applications hanging on recv() calls.
Applications expect that a route dump will be terminated
with a recv() reading an individual NLM_DONE message.

Coalescing NLM_DONE is perfectly legal in netlink,
but even tho reporters fixed the code in respective
projects, chances are it will take time for those
applications to get updated. So revert to old behavior
(for now)?

Old kernel (5.19):

 $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
            --dump getroute --json '{"rtm-family": 2}'
 Recv: read 692 bytes, 11 messages
   nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
 ...
   nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
 Recv: read 20 bytes, 1 messages
   nl_len = 20 (4) nl_flags = 0x2 nl_type = 3

Before (6.9-rc2):

 $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
            --dump getroute --json '{"rtm-family": 2}'
 Recv: read 712 bytes, 12 messages
   nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
 ...
   nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
   nl_len = 20 (4) nl_flags = 0x2 nl_type = 3

After:

 $ ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
            --dump getroute --json '{"rtm-family": 2}'
 Recv: read 692 bytes, 11 messages
   nl_len = 68 (52) nl_flags = 0x22 nl_type = 24
 ...
   nl_len = 60 (44) nl_flags = 0x22 nl_type = 24
 Recv: read 20 bytes, 1 messages
   nl_len = 20 (4) nl_flags = 0x2 nl_type = 3

Reported-by: Stefano Brivio <sbrivio@redhat.com>
Link: https://lore.kernel.org/all/20240315124808.033ff58d@elisabeth
Reported-by: Ilya Maximets <i.maximets@ovn.org>
Link: https://lore.kernel.org/all/02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org
Fixes: 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU protection")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
CC: donald.hunter@gmail.com
---
 net/ipv4/fib_frontend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 48741352a88a..c484b1c0fc00 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1050,6 +1050,11 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 			e++;
 		}
 	}
+
+	/* Don't let NLM_DONE coalesce into a message, even if it could.
+	 * Some user space expects NLM_DONE in a separate recv().
+	 */
+	err = skb->len;
 out:
 
 	cb->args[1] = e;
-- 
2.44.0


