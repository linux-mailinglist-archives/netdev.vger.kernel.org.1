Return-Path: <netdev+bounces-141550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12BB9BB4E2
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FC92826D6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586871B6CEE;
	Mon,  4 Nov 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIpai+nc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284901B0F3E;
	Mon,  4 Nov 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724246; cv=none; b=IPlEx2s2ptLUMF4gVOpQiwPESRidTa9S69z6vgom7/HaACZLy/lgT/JTYb3NFsPkilCiyHLrZ3r7D5hTUpCnfmbcKu0XONkKJUDoiV3y8BSUhia0e8GD/Un3yVpNMVKSzx0Idu7d4HKI7z6UnK0MjU2b2cJoeA2d4O3Oz2d2zUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724246; c=relaxed/simple;
	bh=lXtPD88/DLwgONUoZ+tzULrPtqdUA7Jgmsh/kJjJ43w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lg0/zNcSqhe4wcM4OeDOjw/6/6kt8tHMDMCK1uEXpqKaALgGb8lBm7lNGzBItPMY4VYiHP/OMZBKHmaJhQJD9KptX0ci44Qgdg1y7QnKQR0bGpn9Eu7G42tzcapYha4Tp5YOBelcxpKCfksK6YhC1hDkrnHnnZ6idirKoV7BAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIpai+nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6278CC4CECE;
	Mon,  4 Nov 2024 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730724245;
	bh=lXtPD88/DLwgONUoZ+tzULrPtqdUA7Jgmsh/kJjJ43w=;
	h=From:Date:Subject:To:Cc:From;
	b=FIpai+ncM6rfCSAP5JEy1GXo8SHGD2paXxiCvFoIvTkcPy/a1vU3K3qslEsgcqi9f
	 35bYZzNjytnC8lpK63OMl+7comQpLFmqf2UiUEqvewLv6fP8iMQ135iRlJg4KWRj5c
	 qO+RZB56pdja1stgPoiMOKD1ufSmpFIInlnV2Pg5txBdaDxk/ioNYd2n6c/cAH2gP0
	 coIIK/QUPCDv2Fn2eyr7kWNxIUpu4cRhu1LsQMyT0hT7/Mf6rOP04wT4E90CFMQr5f
	 xy3GUcVn1y9W28WdMD4XNFrMQhHpAqaDygRViYSpcFMQ5WCSXndVS/AgQ+v2n0U7ON
	 Rw4K/fZC06f8Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 04 Nov 2024 13:43:47 +0100
Subject: [PATCH net-next v2] mptcp: remove unneeded lock when listing
 scheds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-net-next-mptcp-sched-unneeded-lock-v2-1-2ccc1e0c750c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAILBKGcC/zWNwQrCMBBEf6Xs2YU0lor+inhoN1Mb1G1IohRK/
 91F8DAw7/BmNirIEYUuzUYZn1jiogb+0JDMg97BMRiTd75rW9exolrWyq9UJXGRGYHfqkCw8lz
 kwc71GI+TnPvxRDaUMqa4/k6u9Pfptu9fb5aZhH4AAAA=
X-Change-ID: 20241104-net-next-mptcp-sched-unneeded-lock-006eb3fc96b7
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lXtPD88/DLwgONUoZ+tzULrPtqdUA7Jgmsh/kJjJ43w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnKMGSxj8Sm8hkaENq4Ru4DFL4kUK4Tj+SKRnUH
 nnjiQLbiJ2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyjBkgAKCRD2t4JPQmmg
 c7scEACi+dZ/s9sji/LSCzCoqAVndbIEp/ojB7M+cui38Sj7+iTXIpUBKkkMM6yfedvTFqWaECv
 8+CW0C4OrsY7VekuaYjde3skbWTCGWF+ziyqtMA/lk8Ee/TvZyy5dHxZ6VNEL924SN2pDQ3zrI1
 1/RzVzdWJClcgRZ0bEhk//3uL6xrYhvJHUGJhjTJ0meuqUsOVjbOE0aVuDa9fbGAjTnXTHisTv2
 sHiS9Fh4Rf9IQf9pwA2YNddrTldLXVcXIXqhbutcK+PDdVi/7EDd13KF5nedHzrC24LydQAmAfP
 nYZQ36OYQ9mew1qjTPay+X0Zdbk3kvz20lrYBoGmwwD6PruIXqJXQjDoo0+/lJVd7OTqcNNeZZh
 kad+3xFRGFswXheabAv7DP20K9511AgHfexMgnO+hPIICZh3SElLPbG0lpPxaweFH6iPQ487ztT
 7uLqK2viN5KTtv1OUofUpumgW5VEDWGk/gE6VpskMqyA5/xpiIiKRmNPxlEnq7XaDGJRd+ViIEG
 rTqKOe3HgUB0kt+ikXSkxg0YysAGBf7oM1si6qdaAksRErGJUPk/m3n+KNQ23R9/erTzwfe33BF
 M54o5hNNqhzWAQ+cVibUxwqx5bmdrixQVMnJoL6+ywTEUZc4PMRoHJD66nPMXDKUgkIeJNm+8fC
 ZMlQ2RIRj0iFyYg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_get_available_schedulers() needs to iterate over the schedulers'
list only to read the names: it doesn't modify anything there.

In this case, it is enough to hold the RCU read lock, no need to combine
this with the associated spin lock as it was done since its introduction
in commit 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers").

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - Rebased on top of net-next instead of net, same code.
 - Removed the 'Fixes' tag, add Simon's RvB tag.
 - Link to v1: https://lore.kernel.org/20241021-net-mptcp-sched-lock-v1-2-637759cf061c@kernel.org
---
 net/mptcp/sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 78ed508ebc1b8dd9f0e020cca1bdd86f24f0afeb..df7dbcfa3b71370cc4d7e4e4f16cc1e41a50dddf 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -60,7 +60,6 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 	size_t offs = 0;
 
 	rcu_read_lock();
-	spin_lock(&mptcp_sched_list_lock);
 	list_for_each_entry_rcu(sched, &mptcp_sched_list, list) {
 		offs += snprintf(buf + offs, maxlen - offs,
 				 "%s%s",
@@ -69,7 +68,6 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 		if (WARN_ON_ONCE(offs >= maxlen))
 			break;
 	}
-	spin_unlock(&mptcp_sched_list_lock);
 	rcu_read_unlock();
 }
 

---
base-commit: ecf99864ea6b1843773589a935bb026951bf12dd
change-id: 20241104-net-next-mptcp-sched-unneeded-lock-006eb3fc96b7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


