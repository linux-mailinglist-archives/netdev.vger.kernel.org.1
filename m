Return-Path: <netdev+bounces-55096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7B809558
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CEB1C20A9B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5756B6C;
	Thu,  7 Dec 2023 22:28:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919821716
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 14:28:46 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7Lb9mA031149
	for <netdev@vger.kernel.org>; Thu, 7 Dec 2023 14:28:45 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uufqfurdr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 14:28:43 -0800
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 14:28:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 920133CC54571; Thu,  7 Dec 2023 14:27:55 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH RFC bpf-next 0/3] BPF FS mount options parsing follow ups
Date: Thu, 7 Dec 2023 14:27:52 -0800
Message-ID: <20231207222755.3920286-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: E5uePRV_l4q-4nDL2Dh-8tk4tlPAO6V0
X-Proofpoint-GUID: E5uePRV_l4q-4nDL2Dh-8tk4tlPAO6V0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02

Original BPF token patch set ([0]) added delegate_xxx mount options which
supported only special "any" value and hexadecimal bitmask. This patch set
attempts to make specifying and inspecting these mount options more
human-friendly by supporting string constants matching corresponding bpf_cm=
d,
bpf_map_type, bpf_prog_type, and bpf_attach_type enumerators.

This is an RFC patch set and I've only converted bpf_cmd enum to be generat=
ed
through reusable mapper macro. If the consensus is that this approach is the
way to go, adding similar support for three remaining enums is just a matter
of mundane mechanical conversion in UAPI header. Kernel-side logic for all
delegate_xxx mount options is completely generic already as implemented in
patch #1.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D805707&=
state=3D*

Andrii Nakryiko (3):
  bpf: add mapper macro for bpf_cmd enum
  bpf: extend parsing logic for BPF FS delegate_cmds mount option
  selftests/bpf: utilize string values for delegate_xxx mount options

 include/uapi/linux/bpf.h                      |  81 +++++------
 kernel/bpf/inode.c                            | 127 +++++++++++++-----
 tools/include/uapi/linux/bpf.h                |  81 +++++------
 .../testing/selftests/bpf/prog_tests/token.c  |  43 +++---
 4 files changed, 208 insertions(+), 124 deletions(-)

--=20
2.34.1


