Return-Path: <netdev+bounces-23307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457BB76B856
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7498A1C20F67
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB671ADC1;
	Tue,  1 Aug 2023 15:17:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DAF4DC9E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:17:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF011BE7
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690903028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CzmpDm0iARiF7fd9lr90QfbU+3pL+DyJiubj8v8X23o=;
	b=SZXda30YyH/W3Rnbn/UJ6pw/BY2qquomzxiYMiweXejCR+/CsoJPBh+bcUR6k0fFgx93aQ
	IOZbXonWnOtTom7PQMkMi3zKt39fY0U8uKZ2yCmKsK1+JxaGsZ2Mflw32MYb882PtPvQR9
	vgoP8lRNyE+ClVCbbRf8jyitqymNjvY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-3wTvMOpQPQCTPrURI3Xe2Q-1; Tue, 01 Aug 2023 11:16:59 -0400
X-MC-Unique: 3wTvMOpQPQCTPrURI3Xe2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE2A53811F22;
	Tue,  1 Aug 2023 15:16:58 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 56928C57964;
	Tue,  1 Aug 2023 15:16:57 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [RFC net-next v2 0/7] openvswitch: add drop reasons
Date: Tue,  1 Aug 2023 17:16:41 +0200
Message-ID: <20230801151649.744695-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is currently a gap in drop visibility in the openvswitch module.
This series tries to improve this by adding a new drop reason subsystem
for OVS.

Apart from adding a new drop reasson subsystem and some common drop
reasons, this series takes Eric's preliminary work [1] on adding an
explicit drop action and integrates it into the same subsystem.

This series also adds some selftests and so it requires [2] to be
applied first.

A limitation of this series is that it does not report upcall errors.
The reason is that there could be many sources of upcall drops and the
most common one, which is the netlink buffer overflow, cannot be
reported via kfree_skb() because the skb is freed in the netlink layer
(see [3]). Therefore, using a reason for the rare events and not the
common one would be even more misleading. I'd propose we add (in a
follow up patch) a tracepoint to better report upcall errors.

[1] https://lore.kernel.org/netdev/202306300609.tdRdZscy-lkp@intel.com/T/
[2] https://lore.kernel.org/all/20230728115940.578658-1-aconole@redhat.com/
[3] commit 1100248a5c5c ("openvswitch: Fix double reporting of drops in dropwatch")

---
rfc1 -> rfc2:
- Fail when an explicit drop is not the last
- Added a drop reason for action errors
- Added braces around macros
- Dropped patch that added support for masks in ovs-dpctl.py as it's now
  included in Aaron's series [2].


Adrian Moreno (6):
  net: openvswitch: add datapath flow drop reason
  net: openvswitch: add action error drop reason
  net: openvswitch: add meter drop reason
  net: openvswitch: add misc error drop reasons
  selftests: openvswitch: add drop reason testcase
  selftests: openvswitch: add explicit drop testcase

Eric Garver (1):
  net: openvswitch: add explicit drop action

 include/net/dropreason.h                      |  6 ++
 include/uapi/linux/openvswitch.h              |  2 +
 net/openvswitch/actions.c                     | 42 ++++++---
 net/openvswitch/conntrack.c                   |  3 +-
 net/openvswitch/datapath.c                    | 16 ++++
 net/openvswitch/drop.h                        | 34 +++++++
 net/openvswitch/flow_netlink.c                | 10 +-
 .../selftests/net/openvswitch/openvswitch.sh  | 92 ++++++++++++++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    | 22 ++++-
 9 files changed, 209 insertions(+), 18 deletions(-)
 create mode 100644 net/openvswitch/drop.h

-- 
2.41.0


