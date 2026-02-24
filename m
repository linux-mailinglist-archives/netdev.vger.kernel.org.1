Return-Path: <netdev+bounces-260277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM7sFtnvnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:24:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C0D180357
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60C1B3033BFD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0B8217F33;
	Tue, 24 Feb 2026 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="tKR4VSOL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAD1DA62E
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892693; cv=none; b=iZrHC1A/SCSJXXNqmZuskEohitQ68FJ1T8Wzv5wsYXhcr1VTs7vtkJkczDU4sCh3B1Bm1I/xxkknqA3k4qFkvi4mBYcEiIKq/j208A5LV+zC7pTrAZYK+EsRXhIQLBrojTVXUSCA/zPUUm6S6PZSl/75lRViaL/bw9bwdkuGRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892693; c=relaxed/simple;
	bh=wftEqqoIaEXBT075ZuLZT9XQ6NZE0po7GtTFRaPN3zk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hTDHG5VCY5Wr8fiRGMopg/nRW2BRHVz1+ItzbLV4osAykzv09h9CNm+YPxRac5SUJXRFydRzHOy2G7lNVbM74qtNEm6Jv8d8/oca9Bd8pPAWnDEbKSW1gLrPVdTQsJS1ZFhfruGcT7vufNRG2nJm4lOZ/30J/NOmdabhcmVw4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=tKR4VSOL; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NJbiRh3068159
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=n/hdCunRT3r8N8wHVO
	bBDQW4B1h+KFvJuSh4MD2zGKQ=; b=tKR4VSOLYW3ITHTaY7/CnmeISJY+qYWpEt
	dxDIN98I8Jn+3lgCRgXS1BvoqLDu4+QCuJmVDTa/kVpCp3gdA+1Pb9Dj4LMzHSAY
	pn1aLVR9gPdsiA/8BnIFwYOPGWoOhGN4aA9NjtMKZgiHHibvMYiCHvZVu/rD7AmG
	z9cJ3enmzYUiAt/3j6T5Ki5C86Ixs/omWrmZQRKz11/1leKuG2ZyzujZ/kxjPkNV
	8Jjuym+voMS3fuCaM7pz9ceTWO5uGeciC1e/8StwEf1b3EZnTw+SBa5TxoqYY+H0
	8AC+D2+dSGGBUeDQru4guHx3M2X9h6Fl/JZcSZYkulQQAaQECTxA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgw7hjkvs-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:50 -0800 (PST)
Received: from twshared107802.16.frc2.facebook.com (2620:10d:c085:108::150d)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 00:24:45 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 5F98A65F7E90; Mon, 23 Feb 2026 16:24:38 -0800 (PST)
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
Subject: [PATCH net-next 0/9] psp: Add support for dev-assoc/disassoc 
Date: Mon, 23 Feb 2026 16:24:00 -0800
Message-ID: <20260224002410.1553838-1-weibunny@fb.com>
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
X-Proofpoint-GUID: RoNI0YAwwtNd4i9faLKdNeEzgDSB11pK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMSBTYWx0ZWRfX7zhCsx2D0ww9
 IApqXGaQTY9WU91oRXdNYopUTHpoxj6pSHZdm7OnoNqwxgVS9ZeNVDWHU7ZM2uCPPC3JP7Lop6u
 gSczlHoC267KnJUSqvb5z9IEnrvrHK4YHfBrLUaGx3SFVXNzg4fPiAF2jDEeVRzkLtNhEUE/CjL
 N7gk1TJiN8cVShFiOrEF/Ld2vjtTzy8BDkcFAIVztuirX8ECUe3YWlPHeMKbiUVbSbuORGrxmP/
 LCJAcAIUo8sJ7fQyd5RanWjwREvm1vVxt/MzPmvv88M98dHqZT64eHUJsf8yA4dXFYNV8lFpEAw
 Ev90uP4wv2Tl4MyUQ6xMqa0svBdFfIbfqbNkPd5TPFqPehnvdlDrvepq1EjHwLVvLwzGVdvl5D+
 473Z63xxt/AC0322KvFHWf24c5vJ4+UyAXwrj+J1GxGLejHkPnm/4i8lCZG3WGjbl/5SuRiipkF
 blBvHSRzsPBQfOEQnJw==
X-Authority-Analysis: v=2.4 cv=VcH6/Vp9 c=1 sm=1 tr=0 ts=699cefd2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=RXTwUTbELHFx_DGCVLAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RoNI0YAwwtNd4i9faLKdNeEzgDSB11pK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260277-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fb.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 12C0D180357
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
https://lore.kernel.org/netdev/20260210200419.3555944-1-dw@davidwei.uk/
We base the newly added test cases on top of env NetDrvContEnv from this
patchset.

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
 net/psp/psp_main.c                            |  86 +++-
 net/psp/psp_nl.c                              | 297 ++++++++++-
 .../testing/selftests/drivers/net/README.rst  |  19 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   3 +
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c |  49 ++
 .../selftests/drivers/net/hw/nk_netns.py      |  23 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/__init__.py  |  11 +-
 .../selftests/drivers/net/lib/py/env.py       | 347 +++++++++++++
 tools/testing/selftests/drivers/net/psp.py    | 462 +++++++++++++++++-
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   4 +-
 20 files changed, 1470 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf=
.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bp=
f.c

--=20
2.47.3


