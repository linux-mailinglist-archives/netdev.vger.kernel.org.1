Return-Path: <netdev+bounces-19867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86C75CA0C
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5371C2170A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0781EA92;
	Fri, 21 Jul 2023 14:31:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622861F93C
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:31:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32792D4E
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689949876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MpKxOrpuSB90OSxKrjns0kOCSpyJhZ7urVx0lL9Q4d8=;
	b=fgOXFliWkvcywKBwtLvKtQZ9ZBjd3yx+M/zDIyUfJFWVjRNBmD95++QHeqLTnr4OxtViA5
	Zhg+Fzg78hqIKDxh5Z4kWkVvd925SF6iQWLzwQOYTj/vjd0ogHA628Tr/kvHTDGeJijraV
	bNWu3vpYy8vGtT8Xa/gxpgi2AkutQTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605--i3naos6Ns2jCbmCXBkt5A-1; Fri, 21 Jul 2023 10:31:12 -0400
X-MC-Unique: -i3naos6Ns2jCbmCXBkt5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFC6489F4E1;
	Fri, 21 Jul 2023 14:31:11 +0000 (UTC)
Received: from griffin.upir.cz (unknown [10.45.225.158])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CCDAC4094DC1;
	Fri, 21 Jul 2023 14:31:10 +0000 (UTC)
From: Jiri Benc <jbenc@redhat.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net 0/2] vxlan: fix GRO with VXLAN-GPE
Date: Fri, 21 Jul 2023 16:30:45 +0200
Message-Id: <cover.1689949686.git.jbenc@redhat.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The first patch generalizes code for the second patch, which is a fix for
broken VXLAN-GPE GRO. Thanks to Paolo for noticing the bug.

Jiri Benc (2):
  vxlan: generalize vxlan_parse_gpe_hdr and remove unused args
  vxlan: fix GRO with VXLAN-GPE

 drivers/net/vxlan/vxlan_core.c | 142 ++++++++++++++++++++++-----------
 1 file changed, 97 insertions(+), 45 deletions(-)

-- 
2.39.2


