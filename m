Return-Path: <netdev+bounces-263479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO/JAB93p2nyhgAAu9opvQ
	(envelope-from <netdev+bounces-263479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:04:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F3D1F8A80
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23AAF30DF381
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC141B4156;
	Wed,  4 Mar 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="K7sgoJln"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262E25B2F4
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582479; cv=none; b=APWmfvGmJPnLxFTefqaMvQwUY3H03hmGZJcm3prf/2ZdH8d3OPFXs5rIMnrHJhfjAWlo4bjbr/DeTyG/5ycWHJU9aFHY3S+7+Dt6rdvQVWQ6oOS+QRy1J+shwJvV8Dmkq+kDqaabyVwt/7oxOngYr57O/yiEDrwQP1TFfoE5elM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582479; c=relaxed/simple;
	bh=23Pz19uSgY6adgDPW5Oy4zVddusZ93EGZWq0sWUZcnY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DQJLvAWfvtOqk32uobpClJW8uARR3Ryf5HaHV/Ihrs/Vba16sQ0rsV3hGwY0XkaT5gPt9PVz9lQrg+NOa7mq7JmBSAjE7dR62dSGHNP8YkrMxikH/+RIeNetaivzeXX7HQxf+l1DozwH8UwBmwgeU5fWHUDVHGZv07f9Mwus8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=K7sgoJln; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623NwBdW951640
	for <netdev@vger.kernel.org>; Tue, 3 Mar 2026 16:01:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=9YNnyCsY+fOs6q6fw/
	N+vJC8MrN3MQJF+zoWZ1MSxHg=; b=K7sgoJlnb+Wr0sE6/VgT2LLDOmUNrBlH2I
	9YC7TdFOKVcRYCYstK3kcoghPBtmBcsvTyXrYYunDbYHBSRn4IXc8aYYpDlkgnO1
	daoPzcTXrbNhDDVpVe20HSgHF067XlqYA9VIUqZJ/Fbh1hXlD87/rabgUIdBdTCg
	vfrEIQ1bkVbBeejV4HTZS5KSn0vmO7AUaGZldH7ST+yIyZ8JkVHBRyX/B6HD5zQn
	G4S79KP//Vf+YZNq3kfhE2aHKaS4nSm2BK+BLqIro7FTi+wGtA8LnVPLjrbVZe/f
	0+LM2oEMRiGHfuIwExoQS9zK65yuEl4VNG6eAMs258twKJQajnxA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cp9skg2dk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:01:15 -0800 (PST)
Received: from twshared4931.33.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 00:01:11 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 2D5CF7589C59; Tue,  3 Mar 2026 16:00:56 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>
Subject: [PATCH v2 net-next 0/9] psp: Add support for dev-assoc/disassoc
Date: Tue, 3 Mar 2026 16:00:40 -0800
Message-ID: <20260304000050.3366381-1-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=Bo2QAIX5 c=1 sm=1 tr=0 ts=69a7764b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8
 a=eYTLEcdz-R4i6C2NL-EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wyg_Zo5aq_wy-TW0-HcdqEjU4S-nlBKm
X-Proofpoint-GUID: wyg_Zo5aq_wy-TW0-HcdqEjU4S-nlBKm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE5NyBTYWx0ZWRfX9GCmCeKJMvdy
 ekGIs/2R05488vjbdfCYBVsN1NU1D4z/WI0tYGaBX7DjmLriLb+66euAFtV75JmJJDSm7Q7odXq
 FnQz5OLHXsvbkECd0h2O6DDd2hausREZ3mDMvzBLz5iYExSU3QccBrgDupq5Wp2Po8aM2tU/stl
 XC54l8PYY12hhZ7EvvHpzIKAFemY9TZI25SogfJARU39WPyOtkeDaqxb7PAokYQ9cHBGBFC+Mdj
 50Iq1PBgacZvcJRYvq3dx1rTjr/bszCHx1cK6qHhPkLF+uZnt4o1qsFCXhQsMhCxZQpvCiJ1WPv
 GdzVlPaQ2yf0jaaFwG2wdTSBHniTCvDknQKmspfcQ8Fy7hkSikgrxrpq7ki1aA4dtd4kZgQgdOG
 0/Z1WP0efaHN42+ap0OcE9jz8wfezkFHugXNKy4pRA0dNcWSsJWpI+WqV5XXCQOqN4ay49P5zFC
 xHvtD2ofF8OU5BhqBOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: 71F3D1F8A80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263479-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fb.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The main purpose of this feature is to associate virtual devices like
veth or netkit with a real PSP device, so we could provide PSP
functionality to the application running with virtual devices.

A typical deployment that works with this feature is as follows:
     Host Namespace:
     psp_dev_local  =E2=86=90=E2=94=80=E2=94=80physically linked=E2=94=80=
=E2=94=80=E2=86=92 psp_dev_peer
          (PSP device)
               =E2=94=82
               =E2=94=82 BPF on psp_dev_local ingress: bpf_redirect_peer(=
) to nk_guest
               =E2=94=82
          nk_host / veth_host
               =E2=94=82
               =E2=94=82 BPF on nk_host ingress: bpf_redirect_neigh() to =
psp_dev_local
               =E2=94=82
      Guest Namespace (netns):
               =E2=94=82
          nk_guest / veth_guest
          =E2=98=85 PSP application run here

      Remote Namespace (_netns):
          psp_dev_peer
          =E2=98=85 PSP server application runs here

Note:
The general requirement for this feature to work:
For PSP to work correctly, the egress device at validate_xmit_skb()
time must have psp_dev matching the association's psd. Any device
stacking or traffic redirection that changes the egress device will
cause either:
1. TX validation failure (SKB_DROP_REASON_PSP_OUTPUT) - fail-safe
2. RX policy failure after tx-assoc - packets without PSP extension
   are rejected by receiver expecting encrypted traffic

Here are a few examples that this feature would not work:
- Bonding with load balancing in round-robin, XOR, 802.3ad mode across
  multiple PSP devices, or mixed PSP and non-PSP devices
- Bonding with active-backup mode might work without PSP migration for
  failover case.
- ipvlan/macvlan in bridge mode would not work given packets are
  loopbacked locally without going through the PSP device.

The first 4 patchs are from this patchset:
https://lore.kernel.org/netdev/20260302053315.1919859-1-dw@davidwei.uk/
We base the newly added test cases on top of env NetDrvContEnv from this
patchset.

Changes since v1:
- Update the first 4 patches to reflect the latest changes in
  https://lore.kernel.org/netdev/20260302053315.1919859-1-dw@davidwei.uk/
- Update patch 9 to add a param to NetDrvContEnv to control the loading
  of the tx forwarding bpf program

David Wei (4):
  selftests/net: Add bpf skb forwarding program
  selftests/net: Export Netlink class via lib.py
  selftests/net: Add env for container based tests
  selftests/net: Add netkit container ping test

Wei Wang (5):
  psp: add unprivileged version of psp_device_get_locked
  psp: Add new netlink cmd for dev-assoc and dev-disassoc
  psp: add a new netdev event for dev unregister
  selftests/net: Add bpf skb forwarding program
  selftest/net: psp: Add test for dev-assoc/disassoc

 Documentation/netlink/specs/psp.yaml          |  66 ++-
 include/net/psp/types.h                       |  15 +
 include/uapi/linux/psp.h                      |  13 +
 net/psp/psp-nl-gen.c                          |  34 +-
 net/psp/psp-nl-gen.h                          |   4 +
 net/psp/psp.h                                 |   2 +-
 net/psp/psp_main.c                            |  86 ++-
 net/psp/psp_nl.c                              | 297 +++++++++-
 .../testing/selftests/drivers/net/README.rst  |  38 ++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   3 +
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c |  49 ++
 .../selftests/drivers/net/hw/nk_netns.py      |  23 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 ++
 .../selftests/drivers/net/lib/py/__init__.py  |  11 +-
 .../selftests/drivers/net/lib/py/env.py       | 260 +++++++++
 tools/testing/selftests/drivers/net/psp.py    | 525 +++++++++++++++++-
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   4 +-
 20 files changed, 1464 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf=
.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bp=
f.c

--=20
2.47.3


