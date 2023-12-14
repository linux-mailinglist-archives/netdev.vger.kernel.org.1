Return-Path: <netdev+bounces-57482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F226C81329B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808F31F222EF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB0459E28;
	Thu, 14 Dec 2023 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1wYbW4hR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56C7129
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:10:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso809546a91.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702563013; x=1703167813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtaQB9sz0LTSzN03qou8mjbQ8pgYf+mC/SbrJRF7YOc=;
        b=1wYbW4hR5Gn/DbPqaToviFY3k/br3lSv/x9Q8R92gMIRnqEa9iJfDvNsQ2pzScbgtk
         TfuUgOEQC5PHpS76AlBSVnr+jc56r4kofRWUa6UHAe0WqWP6GksPwJLXD0V8wW4G15v7
         +98yMFMYbWvZuADkkqmRyuH1RM6tEuX23R4Whs4WkbLEWLuoL8p9B+LEZMBy3zE9moDd
         SzVQqkJjqQQhiR9x6p7sQ/r8JyMRwqOKSQQPlqtfkoGCa68n88qIyjyEYmKV4eBX1ESG
         zpguWfLhJXJBXtLPWATfymnYl3p9zoKkYe07lV7PJ2lAva2UA2Bl+68dK+Y9gpIsuAwL
         kWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563013; x=1703167813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtaQB9sz0LTSzN03qou8mjbQ8pgYf+mC/SbrJRF7YOc=;
        b=NvACpcIFKCJlnBGSiHa1N5rzwR3igYYh7TeKESLLyp41GbRJRnAD607Pp0sFBlfWx4
         bvar/Y3ZEZk2AnFUlcj8P347FIwBCfB/G2SMu2COo3TPGa8+i0HXfy3mtUoZkhsX4Qcs
         NICLrn3mjgUbWPrjZHZR1Ze4N7FSgBa2RK3dAIMOd0643uoLXs1Qp2YUvq3dB94N3iSe
         0wvGUeZW96bDr0DZH8o5+hU/rN/v+QjEJEPGdf+U7Zgv0gm72UhJq+g3KgrRJpjQXc/j
         Mtmc3lkMM9lMHFylN+/wBLsgTkePCR6MLGeMsMHON25AlIXsGnP8pgw3D6MP1FCLnLdr
         BVSg==
X-Gm-Message-State: AOJu0YzJCv6EeLeMsbcdDlTSt8y0r9HKYmlNRFJvsj7g3+NJDo1PpACr
	7qjY1RY2ttV/deD68ftS9hxbK/EoQruLeGbqbbA=
X-Google-Smtp-Source: AGHT+IF8SPUAzKhcpUOie49MEKw+aJaqsbNIy1axcCGNy5hK5EsMvumvpB7sDcNdYkZDVA0enWjapA==
X-Received: by 2002:a17:90a:f302:b0:286:6cc1:8678 with SMTP id ca2-20020a17090af30200b002866cc18678mr4544687pjb.93.1702563013059;
        Thu, 14 Dec 2023 06:10:13 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a430200b0028a4c85a55csm11028698pjg.27.2023.12.14.06.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:10:12 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v6 0/3] net/sched: Introduce tc block ports tracking and use
Date: Thu, 14 Dec 2023 11:10:03 -0300
Message-ID: <20231214141006.3578080-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__context__
The "tc block" is a collection of netdevs/ports which allow qdiscs to share
match-action block instances (as opposed to the traditional tc filter per
netdev/port)[1].

Up to this point in the implementation, the block is unaware of its ports.
This patch makes the tc block ports available to the datapath.

For the datapath we provide a use case of the tc block in a mirred
action in patch 3. For users can levarage mirred to do something like
the following:

$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22
$ tc qdisc add dev ens9 ingress_block 22
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22

In this case, if the packet arrives on ens8, it will be copied and sent to
all ports in the block including ens8. Note that the packet is still in the
pipeline at this point - meaning other actions could be added after the mirror
because mirred copies/clones the skb. Example the following is valid:

$ tc filter add block 22 protocol ip pref 25 flower dst_ip 192.168.0.0/16 \
action mirred egress mirror blockid 22 \
action action vlan push id 123 \
action mirred egress redirect dev dummy0

redirect behavior always steals the packet from the pipeline and therefore
the skb is no longer available for a subsequent action as illustrated above
(in redirecting to dummy0).

The behavior of redirecting to a tc block is therefore adapted to work in the
same manner. So a setup as such:
$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22
$ tc qdisc add dev ens9 ingress_block 22
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress redirect blockid 22

for a matching packet arriving on ens7 will first send a copy/clone to ens8
(as in the "mirror" behavior) then to ens9 as in the redirect behavior above.
Once this processing is done - no other actions are able to process this skb.
i.e it is removed from the "pipeline".

In this case, if the packet arrives on ens8, it will be copied and sent to
all ports in the block including ens8.

Patch 1 separates/exports mirror and redirect functions from act_mirred
Patch 2 introduces the required infra.
Patch 3 Allows mirred to blocks

Subsequent patches will come with tdc test cases.

__Acknowledgements__
Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this
patchset
better. The idea of integrating the ports into the tc block was
suggested
by Jiri Pirko.

[1] See commit ca46abd6f89f ("Merge branch'net-sched-allow-qdiscs-to-share-filter-block-instances'")

Changes in v2:
  - Remove RFC tag
  - Add more details in patch 0(Jiri)
  - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
    Reported-by: kernel test robot <lkp@intel.com> (and
horms@kernel.org)
  - Fix bad dev dereference in printk of blockcast action (Simon)

Changes in v3:
  - Add missing xa_destroy (pointed out by Vlad)
  - Remove bugfix pointed by Vlad (will send in separate patch)
  - Removed ports from subject in patch #2 and typos (suggested by
    Marcelo)
  - Remove net_notice_ratelimited debug messages in error
    cases (suggested by Marcelo)
  - Minor changes to appease sparse's lock context warning

Changes in v4:
  - Avoid code repetition using gotos in cast_one (suggested by Paolo)
  - Fix typo in cover letter (pointed out by Paolo)
  - Create a module description for act_blockcast
    (reported by Paolo and CI)

Changes in v5:
  - Added new patch which separated mirred into mirror and redirect
    functions (suggested by Jiri)
  - Instead of repeating the code to mirror in blockcast use mirror
    exported function by patch1 (tcf_mirror_act)
  - Make Block ID into act_blockcast's parameter passed by user space
    instead of always getting it from SKB (suggested by Jiri)
  - Add tx_type parameter which will specify what transmission behaviour
    we want (as described earlier)

Changes in v6:
  - Remove blockcast and make it a part of mirred
  - Block ID is now a mirred parameter
  - We now allow redirecting and mirroring to either ingress or egress

Victor Nogueira (3):
  net/sched: Introduce tc block netdev tracking infra
  net/sched: cls_api: Expose tc block to the datapath
  net/sched: act_mirred: Allow mirred to block

 include/net/sch_generic.h             |   6 +
 include/net/tc_act/tc_mirred.h        |   1 +
 include/uapi/linux/tc_act/tc_mirred.h |   1 +
 net/sched/act_mirred.c                | 280 +++++++++++++++++++-------
 net/sched/cls_api.c                   |   5 +-
 net/sched/sch_api.c                   |  55 +++++
 net/sched/sch_generic.c               |  31 ++-
 7 files changed, 302 insertions(+), 77 deletions(-)

-- 
2.25.1


