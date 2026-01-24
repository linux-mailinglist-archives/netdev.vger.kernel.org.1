Return-Path: <netdev+bounces-253069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBZaKkSmdGls8QAAu9opvQ
	(envelope-from <netdev+bounces-253069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 12:00:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B307D558
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC1A300AB3B
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0112D9780;
	Sat, 24 Jan 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeWJ7sFz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E12D7DF1;
	Sat, 24 Jan 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769252409; cv=none; b=QqbydMwtc3gHAjhpoUclmuQJzc5sB8h5Vw0OW6TNwn19uicFj4NAwhczl1ymjHyoT6Nnv2A4+bqB8bnZ81H49XEJTzPJf+Ov90iqhNStMkQTukqh4u8bVJ1bNB7yWxcTGz1/B8YOH8iv0g1bEbH5kpc5yDTMqU6HcIERplQrryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769252409; c=relaxed/simple;
	bh=lthNbk2tjVpSg/syKYZZX9ySa/YMEWd6OcjMr16I8l4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t71RSrratPFCxGLFEWlhLgRgml8LY069EQgss8BEbkCx8PaMvRHHjW+wpw4dGj15+R03oiMyGa77ixNZujSUviT3P9/c1O6BKdwXvZB1hfmNausHAX7W9UcZcF+e6u6F25Q/Qs4IsHk+GzPQB6mR9s06LK59MigMZC0rU69Avto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeWJ7sFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36DAC116D0;
	Sat, 24 Jan 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769252409;
	bh=lthNbk2tjVpSg/syKYZZX9ySa/YMEWd6OcjMr16I8l4=;
	h=From:Date:Subject:To:Cc:From;
	b=aeWJ7sFzsjZjgtptGEtihlmcWlM/CkL38eyBwvFscWsoVWjdRAi+xq8EoLnyCZmDH
	 qAGwpKzfC6CxuderMWFkmpBcJg8Oqk0C3xIE7TejwQFChrAnMgv8tboWv3lot4uc8W
	 ZgDHqxUT/+XLZvE0+RxERTOSXKsplg6DT8M5zlK2fdzgD6wvxsgUt+hyi7UZenFU5x
	 kdohVjyDdgy5F6wNuvOd8AGLK0seFxPlk8Wb7+qb/G0NvyUl4TtDv6Ttej6kilFs9b
	 mRBNnyO3xNz9BRrYyX5rxTukQK8hNyVAwSyyqBoWPdJIE3n9V3v6yaDnQHI/hvjfy8
	 q8GJSWOWX9WFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 24 Jan 2026 11:59:18 +0100
Subject: [PATCH net v3] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAamdGkC/02MywrCMBBFf0Vm7ZS8aNWV/yFSQjJpA01SklTE0
 n83uJK7OhfO2aFQ9lTgdtoh08sXn2IDeT6BmXWcCL1tDIKJnnGhMFLFsFazYtaGxriMbtnKPGp
 rc0EpB6d6Zrm5amiNNZPz71//AU2FZztdTgHrnEn/pyVrE0MnmeJcXZAj2S3oD9X7lNK0UGdSg
 OP4Aln6RI+zAAAA
X-Change-ID: 20260124-net-mptcp-race_nl_flush_addrs-337f460d1c9a
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, 
 Eulgyu Kim <eulgyukim@snu.ac.kr>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EOvo61EZ8SV1AmE5wMdL+Ivfqdh/wArm+jAQOQ1cN30=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJLlpldZCwTXMa1lXMR05SlzdvZW1axPP5vqPtWXnGSp
 ObNSdaPO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSuZLhv7ua+wbnJeELku87
 Pk096af4JvXoMuN3h/ukPSfF8E27sYyRoXF/1hVxTtv33u8cVixhXisZsGNr2CvJm+rbNd13qVo
 WsQAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253069-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F1B307D558
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
and/or mptcp_pm_nl_is_backup()

Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
which is not RCU ready.

list_splice_init_rcu() can not be called here while holding pernet->lock
spinlock.

Many thanks to Eulgyu Kim for providing a repro and testing our patches.

Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/611
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3:
 - Same code, but the v2 was corrupted: leading whitespaces before tabs
   had been accidentally removed, causing 'git am' to reject the patch.
 - Add another Closes tag to MPTCP bug tracker.
 - Remove empty lines after 'spin_lock_bh()' to keep the same style.
v2:
 - Make sure the list was not empty, return early otherwise.
 - https://lore.kernel.org/20260123030327.3041148-1-edumazet@google.com
v1:
 - https://lore.kernel.org/20260122131306.2119853-1-edumazet@google.com
---
 net/mptcp/pm_kernel.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 57570a44e418..b26675054b0d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1294,16 +1294,26 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	LIST_HEAD(free_list);
+	struct list_head free_list;
 
 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->endp_list, &free_list);
+	free_list = pernet->endp_list;
+	INIT_LIST_HEAD_RCU(&pernet->endp_list);
 	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
+
+	if (free_list.next == &pernet->endp_list)
+		return 0;
+
 	synchronize_rcu();
+
+	/* Adjust the pointers to free_list instead of pernet->endp_list */
+	free_list.prev->next = &free_list;
+	free_list.next->prev = &free_list;
+
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	__flush_addrs(&free_list);
 	return 0;
 }

---
base-commit: 8016dc5ee19a77678c264f8ba368b1e873fa705b
change-id: 20260124-net-mptcp-race_nl_flush_addrs-337f460d1c9a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


