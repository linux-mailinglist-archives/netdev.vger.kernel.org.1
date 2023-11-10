Return-Path: <netdev+bounces-47014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A617E79FE
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B520428138E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C7748B;
	Fri, 10 Nov 2023 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ona3d9yf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3679EC
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:12:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB438A76
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699603937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3nK/HAcjQd19QuF6/CNQqVs85Tk5g0Fx2VwPP5v9z+I=;
	b=Ona3d9yfOnQF58kARJC90URoJZp5ThVWg9h9cLjnToDGYLIloAvjFAR3AeJcMvz1TTyzdA
	zJCD+38EjjnDNJClYbmULeIyZt6VAkHsx7wvw7IIm+KGx9XJxVzCd9s8mb00MLgXc6BurI
	j/A+Y/gbI1Opo3P+lK7xSBrbicIgjEg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-HYGfeWpsPHG_pxfz21skTg-1; Fri,
 10 Nov 2023 03:12:12 -0500
X-MC-Unique: HYGfeWpsPHG_pxfz21skTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D28111C06500;
	Fri, 10 Nov 2023 08:12:11 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0596F40C6EB9;
	Fri, 10 Nov 2023 08:12:09 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Todd Fujinaka <todd.fujinaka@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] i40e: Fix unexpected MFS warning message
Date: Fri, 10 Nov 2023 09:12:09 +0100
Message-ID: <20231110081209.189481-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
a warning message that reports unexpected size of port's MFS (max
frame size) value. This message use for the port number local
variable 'i' that is wrong.
In i40e_probe() this 'i' variable is used only to iterate VSIs
to find FDIR VSI:

<code>
...
/* if FDIR VSI was set up, start it now */
        for (i = 0; i < pf->num_alloc_vsi; i++) {
                if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
                        i40e_vsi_open(pf->vsi[i]);
                        break;
                }
        }
...
</code>

So the warning message use for the port number indext of FDIR VSI
if this exists or pf->num_alloc_vsi if not.

Fix the message by using 'pf->hw.port' for the port number.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e870afa0e401..c36535145a41 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16225,7 +16225,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
 		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 i, val);
+			 pf->hw.port, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
-- 
2.41.0


