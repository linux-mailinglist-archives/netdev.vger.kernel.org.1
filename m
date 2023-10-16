Return-Path: <netdev+bounces-41447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DFA7CB02A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8441C20995
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B322B2E645;
	Mon, 16 Oct 2023 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8O2bilA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD17286AF
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:49:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055FE1084
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697474951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4pxibnTyWUA8a8vki+wQumNwDWmRgaUk+tRPZ+po4KY=;
	b=T8O2bilA04zhH6xsCc8A/F+2WdiPs5Ceh1hi1hzHoSuM6yrWK2hl1IGKLKF/sKrJzE5FGV
	lhJYRQLFOG54uyQiZ1jlMl6GS7A0Ba8yP0y5Qv5IyMR/NMT/d7r7wTIakCyJznLhpl6a+d
	PEVWCSFmI8DYtDHCJzlha9Mf9IgBtfI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-xpG1QAN7PQi-L2j31zBYAA-1; Mon, 16 Oct 2023 12:49:02 -0400
X-MC-Unique: xpG1QAN7PQi-L2j31zBYAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C5191C0BB4E;
	Mon, 16 Oct 2023 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D67FA492BEE;
	Mon, 16 Oct 2023 16:49:00 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next 0/4] iavf: cleanups, dead code removal
Date: Mon, 16 Oct 2023 18:48:45 +0200
Message-ID: <20231016164849.45691-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The first 3 patches are quite simple cleanups.
Patch 4 removes the whole unused iavf client interface and the
supporting code.

Michal Schmidt (4):
  iavf: rely on netdev's own registered state
  iavf: use unregister_netdev
  iavf: add a common function for undoing the interrupt scheme
  iavf: delete the iavf client interface

 drivers/net/ethernet/intel/iavf/Makefile      |   2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  28 -
 drivers/net/ethernet/intel/iavf/iavf_client.c | 578 ------------------
 drivers/net/ethernet/intel/iavf/iavf_client.h | 169 -----
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 121 +---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  14 -
 6 files changed, 20 insertions(+), 892 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.c
 delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.h

-- 
2.41.0


