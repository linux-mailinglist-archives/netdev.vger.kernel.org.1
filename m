Return-Path: <netdev+bounces-34208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5446F7A2CD0
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B601C20B08
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44143136B;
	Sat, 16 Sep 2023 01:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35DEA2A
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 01:06:29 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251390
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59285f1e267so71768837b3.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694826388; x=1695431188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VAlLorKxLGL+nfra8zdDEIrY12tNi6QIagN7d4SruoU=;
        b=MbHjNucmOq7l3gcAklqfGSgMa/wm1XqVbexD5fTbo8J/W6fnWD5yr8i/FuEx2bhwcL
         Vcyd7tjeRUx/kirknhWrmlcaKU9+olaTTFOIKopdFIgF84Y2y8pzBcy+mXL7ShcO4WBL
         ZM893RE1abqTUUj69SMdvhaAYQXW/xkw1xhr7Bz/QFL4PxfCk/TBA9TrQQOwgWXd3AVB
         l/qwzJnoVwBWFYkWy7HzJdakBSjAlR7Q+cnJdiTCTBbpt2UxQ1PhzGXVl8JcZpU5kW6Q
         kuixjEINuLlV9KjUKEOAJThAIQ1QrX91BFiX0DTuP8VuoCaNXbxCpOHXNOZuuw7b70Ry
         ++GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826388; x=1695431188;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAlLorKxLGL+nfra8zdDEIrY12tNi6QIagN7d4SruoU=;
        b=H+aVwNHGPBhfmqKkL40+kuiJ0/d6Mz7dAapGoh452n3TrHJd0sYms6WVmUq470UygP
         DYv8xXtitJTXXtp8oeWr7cIYcuxXBudP3+owstkBvwy4YAqoHLRzSrAd4lHrqBCCf3Uf
         laWnj4YInVKRY9jazHe/c2ZKID6RSKgiRHVGI93HTuVqOqFFRYfw+N47Om/WcAI+J4jn
         v8PWdSeuDA7/7hu7iJMvHqR2qvnkSJyTDvYvBrMfbKTaqckpli4eKbJx5QxvDXQ+EToi
         uz8WZuwPrB6eKuNXRUOTtlZwv99V6oyWLMgDw3TzsvB5ure/cuW+LM0SipWAefevMFDQ
         tdDg==
X-Gm-Message-State: AOJu0YxUVVhZYvUAvR2D/HoEVE2a/ebB59GdOF8pKXpOGhPo4PlpF2s9
	I0+mRlgSyBS/0FUA9to5UnqPsvvxAYSTYE8=
X-Google-Smtp-Source: AGHT+IHO0fwI0M2zbr8+MlvXDIAh70SyEFs+EvNiQo/B0cIlbt52nyJeqYPi7b35MCn6zDpmYlusYIHzmJ9GTQs=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:6902:1366:b0:d2c:649:f848 with SMTP
 id bt6-20020a056902136600b00d2c0649f848mr99599ybb.1.1694826388009; Fri, 15
 Sep 2023 18:06:28 -0700 (PDT)
Date: Sat, 16 Sep 2023 01:06:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916010625.2771731-1-lixiaoyan@google.com>
Subject: [PATCH v1 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, variable-heavy structs in the networking stack is organized
chronologically, logically and sometimes by cache line access.

This patch series attempts to reorganize the core networking stack
variables to minimize cacheline consumption during the phase of data
transfer. Specifically, we looked at the TCP/IP stack and the fast
path definition in TCP.

For documentation purposes, we also added new files for each core data
structure we considered, although not all ended up being modified due
to the amount of existing cache line they span in the fast path. In 
the documentation, we recorded all variables we identified on the
fast path and the reasons. We also hope that in the future when
variables are added/modified, the document can be referred to and
updated accordingly to reflect the latest variable organization.

Tested:
Our tests were run with neper tcp_rr using tcp traffic. The tests have $cpu
number of threads and variable number of flows (see below).

Tests were run on 6.5-rc1

Efficiency is computed as cpu seconds / throughput (one tcp_rr round trip).
The following result shows Efficiency delta before and after the patch
series is applied.

On AMD platforms with 100Gb/s NIC and 256Mb L3 cache:
IPv4
Flows	with patches	clean kernel	  Percent reduction
30k	0.0001736538065	0.0002741191042	-36.65%
20k	0.0001583661752	0.0002712559158	-41.62%
10k	0.0001639148817	0.0002951800751	-44.47%
5k	0.0001859683866	0.0003320642536	-44.00%
1k	0.0002035190546	0.0003152056382	-35.43%

IPv6
Flows	with patches  clean kernel    Percent reduction
30k	0.000202535503	0.0003275329163 -38.16%
20k	0.0002020654777	0.0003411304786 -40.77%
10k	0.0002122427035	0.0003803674705 -44.20%
5k	0.0002348776729	0.0004030403953 -41.72%
1k	0.0002237384583	0.0002813646157 -20.48%

On Intel platforms with 200Gb/s NIC and 105Mb L3 cache:
IPv6
Flows	with patches	clean kernel	Percent reduction
30k	0.0006296537873	0.0006370427753	-1.16%
20k	0.0003451029365	0.0003628016076	-4.88%
10k	0.0003187646958	0.0003346835645	-4.76%
5k	0.0002954676348	0.000311807592	-5.24%
1k	0.0001909169342	0.0001848069709	3.31%

Chao Wu (1):
  net-smnp: reorganize SNMP fast path variables

Coco Li (4):
  Documentations: Analyze heavily used Networking related structs
  netns-ipv4: reorganize netns_ipv4 fast path variables
  net-device: reorganize net_device fast path variables
  tcp: reorganize tcp_sock fast path variables

 .../net_cachelines/inet_connection_sock.rst   |  42 ++++
 .../networking/net_cachelines/inet_sock.rst   |  37 +++
 .../networking/net_cachelines/net_device.rst  | 167 +++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      | 151 ++++++++++++
 .../networking/net_cachelines/snmp.rst        | 128 ++++++++++
 .../networking/net_cachelines/tcp_sock.rst    | 148 +++++++++++
 include/linux/netdevice.h                     |  96 ++++----
 include/linux/tcp.h                           | 233 +++++++++---------
 include/net/netns/ipv4.h                      |  36 +--
 include/uapi/linux/snmp.h                     |  29 ++-
 10 files changed, 877 insertions(+), 190 deletions(-)
 create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

-- 
2.42.0.459.ge4e396fd5e-goog


