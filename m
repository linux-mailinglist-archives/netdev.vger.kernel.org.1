Return-Path: <netdev+bounces-26408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B725D777B80
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A481C215D2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CDC20C85;
	Thu, 10 Aug 2023 15:02:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459091E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:02:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3704A2694
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691679722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O/NtsihgMacuhLXf7PfM9N+iTRpxdVc0Iq0EEupE6Gk=;
	b=PiaY+fIR5iJ6FLe6CBLCc0T7HuqN8P5qe8y4iAe70C0JaIAalEMUoZwocvVqltdit2eJKj
	zEmACqbMcOnJxtAv3VISZ/r7RWVXtxbQcHk40GK7XFGlwvoKuUk28AbjgBDIp1f60/C5cY
	tsQ6wMhO9PiLjyPSvyv90VJEs/LZMdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-k8Yh_OfeOjCaWlabDFY08Q-1; Thu, 10 Aug 2023 11:01:54 -0400
X-MC-Unique: k8Yh_OfeOjCaWlabDFY08Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79FF3101A528;
	Thu, 10 Aug 2023 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0835740C6F4E;
	Thu, 10 Aug 2023 15:01:51 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>
Subject: [PATCH net 0/4] octeon_ep: fixes for error and remove paths
Date: Thu, 10 Aug 2023 17:01:10 +0200
Message-ID: <20230810150114.107765-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I have an Octeon card that's misconfigured in a way that exposes a
couple of bugs in the octeon_ep driver's error paths. It can reproduce
the issues that patches 1 & 4 are fixing. Patches 2 & 3 are a result of
reviewing the nearby code.

Michal Schmidt (4):
  octeon_ep: fix timeout value for waiting on mbox response
  octeon_ep: cancel tx_timeout_task later in remove sequence
  octeon_ep: cancel ctrl_mbox_task after intr_poll_task
  octeon_ep: cancel queued works in probe error path

 drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c | 2 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c     | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.41.0


