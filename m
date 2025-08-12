Return-Path: <netdev+bounces-212711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3667B21A4F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BE3680AAF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74A1E32D3;
	Tue, 12 Aug 2025 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nLG6gXYr"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-20.consmr.mail.sg3.yahoo.com (sonic314-20.consmr.mail.sg3.yahoo.com [106.10.240.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD016A8D2
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963126; cv=none; b=smSQzNVLgNYzKWHYoPRGSCyZsAch0/TUIhL7OFfiR4hsGzqVRqGRQacs9laaGfPGt51o8vyJm19okuhQ6bl1chTPUH710WnwxIabOMtgoTDvDqaR3aF/SmnOWSlL/eifvL1FOtp4LXkcHkklP9HTpeHHMgrLwvDk/EQRkaK3b70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963126; c=relaxed/simple;
	bh=89HKYPxjiF7wit1u6oMkCdvBba/sQq7p9ey7bdpVIp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=fbQ/MgqX9lMiOdRMq7ZcbVbibBPRdHNtyJZXIze4Zla9CikvTvl/oM5xrMCHeRSB/eY6fToINEWzD6f08/myVY507QSZrHEWNSlvFr0SiUvTWk/0TkWz7Iw/wOFDHlOT+O7f/sT2DEb+Q7/Bj3l1IXG1HAPgodqyw3HSz4dgigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nLG6gXYr; arc=none smtp.client-ip=106.10.240.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754963117; bh=RkP1tU3ghX3hRnFkR9my3q4DiaolNbRkVbzWjH6ZYNg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=nLG6gXYrc8slUAj76dFRa+o85ajMi8tA79K4YBtmCXlWL2W/d7r1l928gzNwJr2YFcHIfvv2vs4IPZkKmkBlZwakjX9thb0IF9nu0P1IdAph+qeqoh6GmFndEA9d2ncSVPFFQuAyUhmSDgnpyLpSdQssE47V8f5YQVtDu/I15elgnxSGA+GJdcuf5CwyP3OEVQVgOXmIKfAnrFOJSbAvFsdhOZyEVpmXFBLDLBVLLlbLmp7+RrTXi4DbGF2XuFLwMz47jJ0BINhrYgYeEk1U2KXxI4toCDsO4AofwnalFAjn7tsJtwJsSyTvHptWcApJsNmsgtURAvfijxOezdfayg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754963117; bh=7ea+KGOIoPvs1ao/ZRa3B2RRgXrOLJTdQ3CAu/oDfmY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LNPyrCYjG6OvDwxnuvCyuJE/zT34RXXBuG+vMgIJR7TE3ySZZ6F6xjTUAq8q93hj8MpwRjEc3Hl14nCcDwdwZp9eFAu5Q/kjG16Yt1nQttIe4t/WU7q+I85nz850IkTLQewFTCOsptvfxgWtfkLxl2C4qKQlwAb0XE1IeY3t7b7rnp5+ilF7IHBPhVS586D3ZcUmW4dHvLN4u2UGZtU1tRNeDCLB7Pmifrs/zl9+s1/eKZR910UMI+WhjhAMWHdJ6FTHqX1Ls4BBaE1p55Dkvo+jFMuHoyil1ciJD1ETJX7H4jd8zlS/thA3L/U90KJNBowQNE4+SjLAbWVvicX7sw==
X-YMail-OSG: 03RWYmcVM1nlnmp8eCOP6YIogzsS2dNfmz0mvS0nLzbnff4AM8wx2v3mFakOMGG
 MynWxPwaiGGX5_ePATMUPvTUjDJa8J59ZJr.KPKEOm55tmptb3KlDWtbBzR2AMk4xT9dzUUXNtrB
 44Edjam5BRzzNexd..kr2nKpZlbNFag.u0_587QHCUYeXoG7.I1zqLftUsYx58aPAeXpAnVNziQs
 swlkfw8LQ.vemwhg7sparstyBB2fBkP7AJKTmZKHo3MkRABZ8_wyOHszyK3EM_OvmEcsC85AnIEe
 VQbQqP7u3nQhnwdgkdgI.54b.3tnaQsQzJ_qwgY53pGyYVBU6tysUTDo5KJZvfVxL3uZUPIWnC.P
 _nc4oH0Dfg5LXUbqdbPkl3LwoOfWHMrD6I3vsBvC3nVnW.J9D1gMIy2u4aLb1DweyUjqPat9IBD7
 .Rzb.D6R9BqAbkjhLugkmvdCfCdgMIQj37B_RFrWQMO_TIbKyo7YcSRtUekiN7zaRprphayOZcNR
 O9B35ITQDFx_GKObKNnzzw64aKEi9KXyzgd5qF1VsMpDL23CuTWNbsqE8dQtF8Z5nCOAtU4DlnPT
 72yltGqjSe0zxuN3jjiRyQqdvjzGSaeuDeRwmiXzj_riiLSpdqyFy4fc2BPlxNFJt8X2BYx9RJSs
 6hNqJbJYGd8WgLOvMckJUPgS6._lHwK5pUSD7Em05px1stNKITwtB3clRtarpbDPx1fRLWaW.fj4
 Oz6e7RXs4Qc.cLaaiGl.jioHVPjiFWNG8m0EJHOcw.cyMtDE486K48.czJWlnaJ7lpWenkrCNHQ7
 irsHz_ZzukOLGyB_cPE7v0hRETtU7WqFd2VZBNETvW0ZummHYzmGbquhGM0oERaR3XyHxldM7cPV
 i7LeEFWE.hnq2yJE6K95gJJHNgAzSy2Mxyz2jn6D77Ut.J.UjVH3M5SLMPxUmbAgfG_f3Dn3BXPX
 q36jPCfmFGnv._cUkA7dMA0DrPh5CBon.4VqKiNvLtoKWSh2s2TKz.59p62ohM7s0dipqlmMKUC4
 lEDHSS6gfRoKWjaypOis_CeBIuckXPRy.JR1naLlPQjI_neQekie7BYui5fvqPUXYo4RVWTqie_J
 uWsc4vY1ltgfhkBw2bGwjcVY2POvl.tB6ktvNq4ID9RcLnSvWLSz7FgZ1Ku8CCDkva79v3nd8Wmz
 d.c3B.oA5mqOC9zzBw9lqqG9qQgJF5dCBcG5yJK33ReTE_n_qLBYN.y20q0dC_TjAt6PjJ2.mgey
 QoHrfhulUqCwRGolSP2Ge_pOTm4M79EPB7oRUeqAALeTuujEt4wyT10CHhxi.rJAJKuTOvjNtMiZ
 vee.y1K3JPywbqsVvy9VvDIVQAoz8ex2EYAnLtBtj2Ao2HDipnAgBAt3CbTQZNtigy.VAr9Xvav4
 ytunb6Kh5SE.3trrpWl0ScKQeUhjIzWgWChjmje03avbL7LazGQGehgTTtE_oFay7t8EWY275Nl7
 dahQ.0vKHC_GXHCTQuNOSqJFd9GhecJenC2pHFORFFuDesKfLUAnjamWGOWHPZ41vMsVv2Cm3dy3
 G1H_mUFfWQNrVSj4xKS2C1Wo_Fk26gfv33Px9kilPHKjA7V8pxtFnWZTERkDqDYX2EuE52VUo.QB
 oUYoAqosBclrystyILzuv2iaFdotvv451oxyAO2zorBZJOOFsBUXOlG3Um0F7mpW4mrHTZjaKMSM
 UmpXO2WtucHqn.eSJXQE0_lAtmikbynV0odeuWloTgTsnWR03Uk2.wzvIKF4vpEMTR_cr61kA5Sc
 hhSSfglBzs5RWl4NffeBgpQS5XgLsMf9SRjFMJBMWCjMHl9lVEyEEO32QCW_iRTTlCgenyt.zSWH
 q4_N_9PMo9VhtU22G5BShBUX7YIM3jtKPBtriZrWIGhoHEti1F8hwgDtZLYHGg7GY54MmsCvSDSB
 g7nDcETnshNGUbeby_lJnPBnxQrn1l0n2tw7iSdy0C2yBskVUJlUh9kOVcSzggnGpSDnfKyurj8A
 6cyk_SwQitRD7.AvHTp7d4_Jcik8KjBnuq8ki8RNllIviT5inKifXwxcI4IWIiY3VLB9JH.kkikW
 HJf71IGns0DnzPjYqWiP.XBtDbrQ5wOkpq3tGqSpC2jPTPtzQmIy9mH8EVWg6gsFSCsbGDV2yXYl
 m2VMqb3pPz6tKjp0kLcDCwqFWZIZ9GKCuMi22unpIyX8pnfhikfRhTVhepZIcs0fbRM0WL4OAZ9_
 j02pRycBxzx4fryO184YBEuei.FbYhmETwxl53ccAmjvmMn_1SPei9aJgxqnu9v_UrSPrw2jxauO
 6KSbU6G0oY.teR2Lxph2ljZqd8u6ysUc9qji09kI-
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 8dc53b6f-8111-432a-9c02-d0341aa0fb87
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Tue, 12 Aug 2025 01:45:17 +0000
Received: by hermes--production-ne1-9495dc4d7-xm7v9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38c766bccbc99becfbbf34cc0d5af190;
          Tue, 12 Aug 2025 01:35:02 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
Date: Mon, 11 Aug 2025 20:34:55 -0500
Message-ID: <20250812013457.425332-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250812013457.425332-1-sumanth.gavini.ref@yahoo.com>

commit 5af1f84ed13a416297ab9ced7537f4d5ae7f329a upstream.

Connections may be cleanup while waiting for the commands to complete so
this attempts to check if the connection handle remains valid in case of
errors that would lead to call hci_conn_failed:

BUG: KASAN: slab-use-after-free in hci_conn_failed+0x1f/0x160
Read of size 8 at addr ffff888001376958 by task kworker/u3:0/52

CPU: 0 PID: 52 Comm: kworker/u3:0 Not tainted
6.5.0-rc1-00527-g2dfe76d58d3a #5615
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x1d/0x70
 print_report+0xce/0x620
 ? __virt_addr_valid+0xd4/0x150
 ? hci_conn_failed+0x1f/0x160
 kasan_report+0xd1/0x100
 ? hci_conn_failed+0x1f/0x160
 hci_conn_failed+0x1f/0x160
 hci_abort_conn_sync+0x237/0x360

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 net/bluetooth/hci_sync.c | 43 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3f905ee4338f..acff47da799a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5525,31 +5525,46 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
-	int err;
+	int err = 0;
+	u16 handle = conn->handle;
 
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		return hci_disconnect_sync(hdev, conn, reason);
+		err = hci_disconnect_sync(hdev, conn, reason);
+		break;
 	case BT_CONNECT:
 		err = hci_connect_cancel_sync(hdev, conn);
-		/* Cleanup hci_conn object if it cannot be cancelled as it
-		 * likelly means the controller and host stack are out of sync.
-		 */
-		if (err) {
-			hci_dev_lock(hdev);
-			hci_conn_failed(conn, err);
-			hci_dev_unlock(hdev);
-		}
-		return err;
+		break;
 	case BT_CONNECT2:
-		return hci_reject_conn_sync(hdev, conn, reason);
+		err = hci_reject_conn_sync(hdev, conn, reason);
+		break;
 	default:
 		conn->state = BT_CLOSED;
-		break;
+		return 0;
 	}
 
-	return 0;
+	/* Cleanup hci_conn object if it cannot be cancelled as it
+	 * likelly means the controller and host stack are out of sync
+	 * or in case of LE it was still scanning so it can be cleanup
+	 * safely.
+	 */
+	if (err) {
+		struct hci_conn *c;
+
+		/* Check if the connection hasn't been cleanup while waiting
+		 * commands to complete.
+		 */
+		c = hci_conn_hash_lookup_handle(hdev, handle);
+		if (!c || c != conn)
+			return 0;
+
+		hci_dev_lock(hdev);
+		hci_conn_failed(conn, err);
+		hci_dev_unlock(hdev);
+	}
+
+	return err;
 }
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
-- 
2.43.0


