Return-Path: <netdev+bounces-151872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E69F16D2
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B869216170E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB11119258E;
	Fri, 13 Dec 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTkXgXmN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2841922F5;
	Fri, 13 Dec 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119673; cv=none; b=MYIOcGt0JL9ueU8dmkhxECLHvgD5fJVaV6pkS79IiP/lKSoZXDl0LdHnpKI4yQ2gxqRsjWsIFw3zl+f5986RXkI2Ou5njMOCViGN6Dp2ax7A9dfg+BxfX+R11O7q+OW+Z2yEZfurOIPV3JbRSdMit1f0HAYAyg93ir6OqlC1mgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119673; c=relaxed/simple;
	bh=ahdJp3dJDP2d6bk+EFEpUx7qhNP/bGaBb7kaEZWi21s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFwnuCa+W0LnDrkF94XrbytSwqlnJrdSMrpm2hfsygZ3NTxb60KQrg95oZXTa0w7WT4aFlXiy9qwRgJiF7YbGwOPgRcAVdKeAKF9T5lpOppGxSwni+pcK2El3aGtJJXOjLwpGrwXRZN9rFrvQoSoxmoz+esLJWQR8MXoFUGVD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTkXgXmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D414C4CED0;
	Fri, 13 Dec 2024 19:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119673;
	bh=ahdJp3dJDP2d6bk+EFEpUx7qhNP/bGaBb7kaEZWi21s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TTkXgXmNd1xQ7u+A3ouaJZ93KaP113TQ2qur9ZD7Jyp4IAtKdGPkjWD+SAHc4sEAA
	 fMFKJ+pCfqE2URAyxKQ7bhz1uKyuSQxIe23Qe9Ey0uz9wfshepzZNVid241exFLFny
	 lE6vk/ywWEV2jVziuxcyarf9m7pKjo1R8G/B54mNqK5LQMwOJuw7C+0jl/nXPodU/F
	 JC6tjn/dw8mGcPWQdEkTMUlcyYCHg//RB4yJVonHzL2S8LwcwhUtue+qdgPjzNkcYu
	 QkrajRqkwYfgsyXQnQKAospqOIsatvLdvSKloVbM9Pj7iGjn2qruwBuzLQYogS2Je8
	 RIWxA9SikKU7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 20:52:53 +0100
Subject: [PATCH net-next 2/7] mptcp: add mptcp_for_each_userspace_pm_addr
 macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-net-next-mptcp-pm-misc-cleanup-v1-2-ddb6d00109a8@kernel.org>
References: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
In-Reply-To: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0oPYOdV4cYEweeRear2GUoPeFWizDuCJIBsUhNclTL4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXJDxDpv6zmIUb0Wr/Z7Op5oOpmBWZyo46UkK+
 uHXuNL0P42JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1yQ8QAKCRD2t4JPQmmg
 cyzyD/4ojWBjyCehGHLOXfVueOTsheseuIoBJW6b7l7D9vES3I0UQfDrSzNVRmsmP5ChjYlfJd4
 hqLOH+lktGi7qPo5Ik77zqgKG/onsyd0WAj6t787Z21QuGBWPUNwAokF+xKiZBMWcZe9hBTJD+b
 NwmQYn1KAg9aehoGGLUckXDAmAcRjvntya35yD8tfeOX5tDfMkj2l61/IDkAtj0ptstUzTM4nji
 2XUDchOGA3Kzo+SeoKFKFRpBCii3/eKVtMNJ+A8hE6ZfW20DCKqnFAi45Z5zHBwGdIOsnw/c3Ol
 ZA+mrNpgT23TejruEdYHzQuRcn9hRSrtgcSnAydzx+RLY63pqCgUvt/7l/UZMObKw1x3gW8Hm3E
 Zk3NX4IiO3/pUpkWVxiB0N4MGSh61mtbTtQqMZv687qqbJ9Ovd4og4KNp2v8dteItzr0r5PiO8g
 wePGmWKQMH9xQvBLDG9pKV8wC6aMtQfpUTv/2EzciAwt5mZvU+24OPxjbCaCJDOdMjRRF5Z/DF/
 fEkB0+MCYq/RI8W5YwEMgGSwmdLq9kbHSw68+qABLuQE5N454ksiZJJDirBzPLFTQyJFMtTQBG3
 SHOWmRutAT5jAyiVZyWHWz0OSivGk4r5cO7KS5tTfIDFyT+o+U3KEKeI97T5YjG8N6eSgiurNFl
 6QiIWAqcBkIklRQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to mptcp_for_each_subflow() macro, this patch adds a new macro
mptcp_for_each_userspace_pm_addr() for userspace PM to iterate over the
address entries on the local address list userspace_pm_local_addr_list
of the mptcp socket.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3664f3c1572e269fd7c74ea1d86a49389ed5c0c1..6a27fab238f15b577e1e17225d4450e60ffd25d7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -8,6 +8,10 @@
 #include "mib.h"
 #include "mptcp_pm_gen.h"
 
+#define mptcp_for_each_userspace_pm_addr(__msk, __entry)			\
+	list_for_each_entry(__entry,						\
+			    &((__msk)->pm.userspace_pm_local_addr_list), list)
+
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
@@ -32,7 +36,7 @@ mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_userspace_pm_addr(msk, entry) {
 		if (mptcp_addresses_equal(&entry->addr, addr, false))
 			return entry;
 	}
@@ -54,7 +58,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_userspace_pm_addr(msk, e) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
@@ -124,7 +128,7 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_userspace_pm_addr(msk, entry) {
 		if (entry->addr.id == id)
 			return entry;
 	}
@@ -659,7 +663,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_userspace_pm_addr(msk, entry) {
 		if (test_bit(entry->addr.id, bitmap->map))
 			continue;
 

-- 
2.45.2


