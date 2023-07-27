Return-Path: <netdev+bounces-21961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F83765783
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741F5281175
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC217AA1;
	Thu, 27 Jul 2023 15:26:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B1171AB
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 15:26:41 +0000 (UTC)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E76E358D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:26:21 -0700 (PDT)
Received: from [130.117.225.1] (helo=finist-vl9.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1qP2qc-006EQV-2G;
	Thu, 27 Jul 2023 17:26:09 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	David Miller <davem@davemloft.net>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 0/1] qed: Yet another scheduling while atomic fix
Date: Thu, 27 Jul 2023 18:26:08 +0300
Message-Id: <20230727152609.1633966-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ZMJcDvPrz1pEBPft@corigine.com>
References: <ZMJcDvPrz1pEBPft@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Running an old RHEL7-based kernel we have got several cases of following
BUG_ON():

  BUG: scheduling while atomic: swapper/24/0/0x00000100

   [<ffffffffb41c6199>] schedule+0x29/0x70
   [<ffffffffb41c5512>] schedule_hrtimeout_range_clock+0xb2/0x150
   [<ffffffffb41c55c3>] schedule_hrtimeout_range+0x13/0x20
   [<ffffffffb41c3bcf>] usleep_range+0x4f/0x70
   [<ffffffffc08d3e58>] qed_ptt_acquire+0x38/0x100 [qed]
   [<ffffffffc08eac48>] _qed_get_vport_stats+0x458/0x580 [qed]
   [<ffffffffc08ead8c>] qed_get_vport_stats+0x1c/0xd0 [qed]
   [<ffffffffc08dffd3>] qed_get_protocol_stats+0x93/0x100 [qed]
                        qed_mcp_send_protocol_stats
            case MFW_DRV_MSG_GET_LAN_STATS:
            case MFW_DRV_MSG_GET_FCOE_STATS:
            case MFW_DRV_MSG_GET_ISCSI_STATS:
            case MFW_DRV_MSG_GET_RDMA_STATS:
   [<ffffffffc08e36d8>] qed_mcp_handle_events+0x2d8/0x890 [qed]
                        qed_int_assertion
                        qed_int_attentions
   [<ffffffffc08d9490>] qed_int_sp_dpc+0xa50/0xdc0 [qed]
   [<ffffffffb3aa7623>] tasklet_action+0x83/0x140
   [<ffffffffb41d9125>] __do_softirq+0x125/0x2bb
   [<ffffffffb41d560c>] call_softirq+0x1c/0x30
   [<ffffffffb3a30645>] do_softirq+0x65/0xa0
   [<ffffffffb3aa78d5>] irq_exit+0x105/0x110
   [<ffffffffb41d8996>] do_IRQ+0x56/0xf0

The situation is clear - tasklet function called schedule, but the fix
is not so trivial.

Checking the mainstream code it seem the same calltrace is still
possible on the latest kernel as well, so here is the fix.

The was a similar case recently for QEDE driver (reading stats through
sysfs) which resulted in the commit:
  42510dffd0e2 ("qed/qede: Fix scheduling while atomic")

i tried to implement the same logic as a fix for my case, but failed:
unfortunately it's not clear to me for this particular QED driver case
which statistic to collect in delay works for each particular device and
getting ALL possible stats for all devices, ignoring device type seems
incorrect.

Taking into account that i do not have access to the hardware at all,
the delay work approach is nearly impossible for me.

Thus i have taken the idea from patch v3 - just to provide the context
by the caller:
  https://www.spinics.net/lists/netdev/msg901089.html

At least this solution is technically clear and hopefully i did not make
stupid mistakes here.

The patch is COMPILE TESTED ONLY.

i would appreciate if somebody can test the patch. :)

Konstantin Khorenko (1):
  qed: Fix scheduling in a tasklet while getting stats

---
v1->v2:
 - Fixed kdoc for qed_get_protocol_stats_iscsi()
   (added new arg description)
 - Added kdoc descriptions for qed_ptt_acquire_context(),
   qed_get_protocol_stats_fcoe(), qed_get_vport_stats() and
   qed_get_vport_stats_context()

 drivers/net/ethernet/qlogic/qed/qed_dev_api.h | 16 ++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c    | 19 ++++++++++----
 drivers/net/ethernet/qlogic/qed/qed_fcoe.h    | 17 ++++++++++--
 drivers/net/ethernet/qlogic/qed/qed_hw.c      | 26 ++++++++++++++++---
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c   | 19 ++++++++++----
 drivers/net/ethernet/qlogic/qed/qed_iscsi.h   |  8 ++++--
 drivers/net/ethernet/qlogic/qed/qed_l2.c      | 19 ++++++++++----
 drivers/net/ethernet/qlogic/qed/qed_l2.h      | 24 +++++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_main.c    |  6 ++---
 9 files changed, 128 insertions(+), 26 deletions(-)

-- 
2.31.1


