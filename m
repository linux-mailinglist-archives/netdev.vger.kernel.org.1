Return-Path: <netdev+bounces-214661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB0B2ACFB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26A26242D7
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E23270575;
	Mon, 18 Aug 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dY+Cbr4c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863B25B301
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531573; cv=none; b=LXcd7xiLFplKYa7w+fVBYGyudII7GU+5FGxCt3k/mtq45qlJxhcY6WCYlCk9MLJFeX2S8U7J2ylE9NkP+R6IVnfbk37D6ydqM4+iaTpCOXCNGLvKeJ+ZfAx3ECtHJFfeaLWdyxV2So8cTnLK9HNihICJP3DmN+44LRG2hGKoi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531573; c=relaxed/simple;
	bh=8zaaDth9l4LlmIT3KTdouDi5yVbk965iAG1Z/stXycA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hB681zNXmZRTqvV6dAPw1ZY6+voJTVSdDX/2BciKoLFw0k4Eq5WI5qWVx8/+PV83hsqUYmd+gHWPlH9ZQgYRozYSM/MW+omLmTC1zg5CZG6EfWQ7VNO3xMmCGCvN/h5B8IZAv+uyST392gmgFzDaF9xwrUJ1VbGdCT+gOqw+44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dY+Cbr4c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755531571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qXpvRoFv2Wa2W3v8CasK7ERjDyTSk2kwzM1QvDnLBZA=;
	b=dY+Cbr4cavmhgp+cfRyF8Ux0pSXOGP8Cwo0uls69tzsOFvavkGUbpQQensvR5ebIkw7AjE
	V3xeFX4fj952Ycs568dzcvHdWiJUoxjUqCsE9F09zhAq40bXIKlMLhaIqY61gKt4wVuC+H
	aCKiXemBXFBGJMcW3duw/rdhkoBso2s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-EryE0nfpMqir1Dz-bMW5Hw-1; Mon,
 18 Aug 2025 11:39:27 -0400
X-MC-Unique: EryE0nfpMqir1Dz-bMW5Hw-1
X-Mimecast-MFC-AGG-ID: EryE0nfpMqir1Dz-bMW5Hw_1755531566
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96CD718002C3;
	Mon, 18 Aug 2025 15:39:25 +0000 (UTC)
Received: from rhel-developer-toolbox.redhat.com (unknown [10.45.224.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29844180028B;
	Mon, 18 Aug 2025 15:39:20 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path
Date: Mon, 18 Aug 2025 17:39:03 +0200
Message-ID: <20250818153903.189079-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

If request_irq() in i40e_vsi_request_irq_msix() fails in an iteration
later than the first, the error path wants to free the IRQs requested
so far. However, it uses the wrong dev_id argument for free_irq(), so
it does not free the IRQs correctly and instead triggers the warning:

 Trying to free already-free IRQ 173
 WARNING: CPU: 25 PID: 1091 at kernel/irq/manage.c:1829 __free_irq+0x192/0x2c0
 Modules linked in: i40e(+) [...]
 CPU: 25 UID: 0 PID: 1091 Comm: NetworkManager Not tainted 6.17.0-rc1+ #1 PREEMPT(lazy)
 Hardware name: [...]
 RIP: 0010:__free_irq+0x192/0x2c0
 [...]
 Call Trace:
  <TASK>
  free_irq+0x32/0x70
  i40e_vsi_request_irq_msix.cold+0x63/0x8b [i40e]
  i40e_vsi_request_irq+0x79/0x80 [i40e]
  i40e_vsi_open+0x21f/0x2f0 [i40e]
  i40e_open+0x63/0x130 [i40e]
  __dev_open+0xfc/0x210
  __dev_change_flags+0x1fc/0x240
  netif_change_flags+0x27/0x70
  do_setlink.isra.0+0x341/0xc70
  rtnl_newlink+0x468/0x860
  rtnetlink_rcv_msg+0x375/0x450
  netlink_rcv_skb+0x5c/0x110
  netlink_unicast+0x288/0x3c0
  netlink_sendmsg+0x20d/0x430
  ____sys_sendmsg+0x3a2/0x3d0
  ___sys_sendmsg+0x99/0xe0
  __sys_sendmsg+0x8a/0xf0
  do_syscall_64+0x82/0x2c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [...]
  </TASK>
 ---[ end trace 0000000000000000 ]---

Use the same dev_id for free_irq() as for request_irq().

I tested this with inserting code to fail intentionally.

Fixes: 493fb30011b3 ("i40e: Move q_vectors from pointer to array to array of pointers")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b83f823e4917..dd21d93d39dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4156,7 +4156,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		irq_num = pf->msix_entries[base + vector].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
 		irq_update_affinity_hint(irq_num, NULL);
-		free_irq(irq_num, &vsi->q_vectors[vector]);
+		free_irq(irq_num, vsi->q_vectors[vector]);
 	}
 	return err;
 }
-- 
2.50.1


