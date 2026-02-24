Return-Path: <netdev+bounces-260281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BK8GWHwnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:27:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D1180399
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9A7631045C9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6721773D;
	Tue, 24 Feb 2026 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="J152qi12"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78033217F33
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892702; cv=none; b=geFNBl/hW0Q+o2IOATlZxgP2ecN1O9+PRkqTNPypkvYQzuu4W6/zdyjJ29meankrL6tcJFFbhmRp2EX2j3KMRn7Pcp5rFlXut58NMg4ENBcaj0F6aqlUbJth9+G9mOKDyzorfB1HG3oseWcG/lfYfZCqAP17aDVE77kKmTNX7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892702; c=relaxed/simple;
	bh=iM6r1Busi0LAUWrrZAhgeT8auJsGICQnQP8hlBT3h8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngIM5tCunHofrlUPUyndvEtvQ6NBQ0gxunfco62LHxNl1k+XnTbuIX3XTI32wXFXPBmTXva/36g8ffHfMJ/mO6ELKLFhFapgWrvS0Tq4Gt+WtEHA4a+n2bN6ckab6sDpE6gj8yktP8Taes4qSUcL8/44H5rFEJULGMpMJE7ZpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=J152qi12; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61NKZldx258584
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=QJqcjo0QKkOxUiArUHlUe7RsvjwNYLiFZIAobXnGeiE=; b=J152qi12g02Z
	CgLWWl3FYNoYvlYnqbBECGFzpOdMnesf57ZNJPjreCPpARJdtuJEEY7JlrVE2xKT
	fjGMsEa6Y+FXf+Bn49GCD/cdXRGhozNge2tmcJN+zq8+APxDGxaxA6KnS6/PSkxn
	zT2o754zy5rG3od2hHYGJ17dOPV1b8GK/sqo45UcDCOORoa4yI0wQb8AHY/qyVWl
	LJb8hx2o4oeAPLNiadQymibjxid25SYlXeFYLn/UkhmA0yQu3WbWhoS8lU+toDNL
	5hqyEXFwhkwWMuL8lJn/8S2dr7TNFPYCeUoeroK0uu7y8em3gBX7N3AwBWX9rKO5
	mx8vswreeg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4cgx2rj2fh-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:59 -0800 (PST)
Received: from twshared52957.40.frc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 00:24:47 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 351BC65F7EDF; Mon, 23 Feb 2026 16:24:39 -0800 (PST)
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
Subject: [PATCH net-next 9/9] selftest/net: psp: Add test for dev-assoc/disassoc
Date: Mon, 23 Feb 2026 16:24:09 -0800
Message-ID: <20260224002410.1553838-10-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224002410.1553838-1-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=MOJtWcZl c=1 sm=1 tr=0 ts=699cefdb cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=FOH2dFAWAAAA:8
 a=-zO_nrNNvhy5WaGkCxoA:9 a=-V-1Jcp_KgIpURNX:21 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1b1i_ZriY5ORAyzIfNsQexnOtYthKno-
X-Proofpoint-ORIG-GUID: 1b1i_ZriY5ORAyzIfNsQexnOtYthKno-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMSBTYWx0ZWRfXzMl8rjbrbJss
 APopCSj1C3KHTgVYn5JDzeqeQCX/F8cYu8d8P1ppWpNpH8SbITYuReC6BSus0DSlw0o7tbpS2dN
 m169zv4hqyXbffJUDDEONSPS2dSXoLWNw/FGM+oO5xwIb9vXb+X25DpcTSoh4Ae4UZQgA7PINeq
 daovsP6BIEY9QAEA2zzD9gjEJYnZdsNSkoPbwizstes8XlytsofI+AQuQRkpZjiOg/IzQJPF3mn
 V8bOeMj/+L5nZkImsT7wguhzJqZJ8WYfmXAFoBATCWWiwhEX9rV0PggaQJbNETjZHo3F+dfODRT
 MtEnIu0Bc5+qpCd7G8/ahOaD6UqU9IJcGHastym1NgBI/A1qm5LrJ40moFQiv+i2+ML8XQ0UAQ9
 i+hDluAigls04T0HjtwEVDfNo2MEwzsn3PpZiE6rijD7G87anOrpE5p/yb8RdGtx8BM0zcnlQ0u
 /74u25qHt1iWm8hTO3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260281-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:mid,fb.com:dkim,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url,netns.name:url,self.dev:url];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: BB9D1180399
X-Rspamd-Action: no action

Add an env NetDrvContEnPsp which is based on NetDrvContEn, but add an
additional bpf redirect program on nk_host to redirect traffic to the
psp_dev_local. The topology looks like this:
  Host NS:  psp_dev_local <---> nk_host
                |                |
                |                | (netkit pair)
                |                |
  Remote NS: psp_dev_peer      Guest NS: nk_guest
             (responder)             (PSP tests)

Add following tests for dev-assoc/dev-disassoc functionality:
1. Test the output of `./tools/net/ynl/pyynl/cli.py --spec
Documentation/netlink/specs/psp.yaml --dump dev-get` in both default and
the guest netns.
2. Test the case where we associate netkit with psp_dev_local, and
send PSP traffic from nk_guest to psp_dev_peer in 2 different netns.
3. Test to make sure the key rotation notification is sent to the netns
for associated dev as well
4. Test to make sure the dev change notification is sent to the netns
for associated dev as well
5. Test the deletion of nk_guest in client netns, and proper cleanup in
the assoc-list for psp dev.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 .../selftests/drivers/net/lib/py/__init__.py  |   6 +-
 .../selftests/drivers/net/lib/py/env.py       | 184 +++++++
 tools/testing/selftests/drivers/net/psp.py    | 462 +++++++++++++++++-
 3 files changed, 644 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/too=
ls/testing/selftests/drivers/net/lib/py/__init__.py
index 6b55068d5370..ec512a9b8a2a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -44,12 +44,12 @@ try:
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ks=
ft_gt",
                "ksft_not_none", "ksft_not_none"]
=20
-    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
+    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv, NetDrvContEn=
vPsp
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
=20
-    __all__ +=3D ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "Generate=
Traffic",
-                "Remote", "Iperf3Runner"]
+    __all__ +=3D ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "NetDrvCo=
ntEnvPsp",
+                "GenerateTraffic", "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
index 857ae0f37516..83a4d79c6053 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -4,6 +4,7 @@ import ipaddress
 import os
 import time
 import json
+import re
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
@@ -452,3 +453,186 @@ class NetDrvContEnv(NetDrvEpEnv):
         value =3D ipv6_bytes + ifindex_bytes
         value_hex =3D ' '.join(f'{b:02x}' for b in value)
         bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")
+
+class NetDrvContEnvPsp(NetDrvContEnv):
+    """
+    Class for PSP testing with netkit pair + BPF redirect topology.
+
+    Inherits from NetDrvContEnv and adds PSP-specific attributes.
+
+    Topology (3 namespaces):
+        Host Namespace:
+            psp_dev_local (2001:db8::1) =E2=86=90=E2=94=80=E2=94=80linke=
d=E2=94=80=E2=94=80=E2=86=92 psp_dev_peer (in _netns)
+            (PSP device)
+                 =E2=94=82
+                 =E2=94=82 BPF on nsim_local ingress: bpf_redirect_peer(=
) to nk_guest
+                 =E2=94=82
+            nk_host (fe80::1)
+                 =E2=94=82
+                 =E2=94=82 BPF on nk_host ingress: bpf_redirect_neigh() =
to nsim_local
+                 =E2=94=82
+                 =E2=94=82 netkit pair
+                 =E2=94=82
+        Guest Namespace (netns):
+                 =E2=94=82
+            nk_guest (fe80::2, 2001:db9::2:2)
+            =E2=98=85 PSP tests run here
+
+        Remote Namespace (_netns):
+            psp_dev_peer (2001:db8::2)
+            =E2=98=85 psp_responder runs here
+
+    BPF programs:
+        - psp_dev_local: nk_forward.bpf.o (from parent class) uses bpf_r=
edirect_peer()
+          to redirect directly to nk_guest (the peer of nk_host)
+        - nk_host: nk_redirect.bpf.o uses bpf_redirect_neigh() to redire=
ct to
+          psp_dev_local with correct L2 headers via neighbor lookup
+    """
+
+    # Use a different prefix for netkit guest to avoid conflict with nsi=
m prefix
+    nk_v6_pfx =3D "2001:db9::"
+
+    def __init__(self, src_path, **kwargs):
+        # Set LOCAL_PREFIX_V6 to a DIFFERENT prefix than nsim to avoid B=
PF
+        # redirecting psp_responder traffic. The BPF only redirects traf=
fic
+        # matching LOCAL_PREFIX_V6, so nsim traffic (2001:db8::) won't b=
e affected.
+        if "LOCAL_PREFIX_V6" not in os.environ:
+            os.environ["LOCAL_PREFIX_V6"] =3D self.nk_v6_pfx
+        super().__init__(src_path, **kwargs)
+
+        # Track nk_host BPF attachment for cleanup
+        self._nk_host_tc_attached =3D False
+        self._nk_host_bpf_prog_pref =3D None
+
+        # Set PSP device attributes based on whether we're using nsim or=
 real NIC
+        if self._ns is not None:
+            # nsim case: PSP device is nsim_local (in host namespace)
+            self.psp_dev =3D self._ns.nsims[0].dev
+            self.psp_ifname =3D self.psp_dev['ifname']
+            self.psp_ifindex =3D self.psp_dev['ifindex']
+
+            # PSP peer device is nsim_peer (in _netns, where psp_respond=
er runs)
+            self.psp_dev_peer =3D self._ns_peer.nsims[0].dev
+            self.psp_dev_peer_ifname =3D self.psp_dev_peer['ifname']
+            self.psp_dev_peer_ifindex =3D self.psp_dev_peer['ifindex']
+        else:
+            # Real NIC case: PSP device is the local interface
+            self.psp_dev =3D self.dev
+            self.psp_ifname =3D self.ifname
+            self.psp_ifindex =3D self.ifindex
+
+            # PSP peer device is the remote interface
+            self.psp_dev_peer =3D self.remote_dev
+            self.psp_dev_peer_ifname =3D self.remote_ifname
+            self.psp_dev_peer_ifindex =3D self.remote_ifindex
+
+        # Get nsid for the guest namespace (netns) where nk_guest is
+        self.psp_dev_peer_nsid =3D self._get_nsid(self.netns.name)
+
+        # Attach TX BPF on nk_host: redirect 2001:db8::/64 =E2=86=92 nsi=
m_local
+        self._attach_tx_bpf()
+
+        # Add routes for cross-namespace connectivity
+        self._setup_routes()
+
+    def _get_nsid(self, ns_name):
+        """Get the nsid for a namespace."""
+        nsid =3D 0
+        try:
+            list_result =3D cmd("ip netns list-id", shell=3DTrue)
+            list_output =3D list_result.stdout if hasattr(list_result, '=
stdout') else str(list_result)
+
+            for line in list_output.split('\n'):
+                if ns_name in line and 'nsid' in line:
+                    parts =3D line.split()
+                    if 'nsid' in parts:
+                        nsid_idx =3D parts.index('nsid')
+                        if nsid_idx + 1 < len(parts):
+                            try:
+                                nsid =3D int(parts[nsid_idx + 1])
+                                break
+                            except ValueError:
+                                pass
+        except Exception as e:
+            raise KsftSkipEx(f"Failed to query nsid: {e}")
+        return nsid
+
+    def _setup_routes(self):
+        """
+        Set up routes for cross-namespace connectivity.
+
+        Traffic flows:
+        1. remote (_netns) -> nk_guest (netns):
+           nsim_peer -> nsim_local -> BPF redirect -> nk_host -> nk_gues=
t
+           Needs: route in _netns to 2001:db9::/64 via nsim_local (2001:=
db8::1)
+
+        2. nk_guest (netns) -> remote (_netns):
+           nk_guest -> nk_host -> nsim_local -> nsim_peer
+           Needs: route in netns to 2001:db8::/64 via nk_host (default r=
oute already set)
+        """
+        # In _netns (remote namespace): add route to nk_guest prefix via=
 nsim_local
+        # nsim_peer can reach nsim_local via the link, then traffic goes=
 through BPF
+        ip(f"-6 route add {self.nk_v6_pfx}/64 via {self.nsim_v6_pfx}1 de=
v {self.psp_dev_peer_ifname}",
+           ns=3Dself._netns)
+
+        # In netns (guest namespace): add route to nsim_peer prefix
+        # nk_guest default route goes to nk_host, but we need explicit r=
oute to 2001:db8::/64
+        ip(f"-6 route add {self.nsim_v6_pfx}/64 via fe80::1 dev {self._n=
k_guest_ifname}",
+           ns=3Dself.netns)
+
+    def _attach_tx_bpf(self):
+        """
+        Attach BPF program on nk_host ingress to redirect TX traffic.
+
+        Packets from nk_guest destined for nsim network (2001:db8::/64) =
arrive
+        at nk_host via the netkit pair. This BPF program redirects them =
to
+        nsim_local so they can reach nsim_peer.
+        """
+        bpf_obj =3D self.test_dir / "nk_redirect.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("BPF prog nk_redirect.bpf.o not found")
+
+        # Add clsact qdisc to nk_host
+        cmd(f"tc qdisc add dev {self._nk_host_ifname} clsact")
+
+        # Attach BPF on nk_host ingress
+        cmd(f"tc filter add dev {self._nk_host_ifname} ingress bpf obj {=
bpf_obj} sec tc/ingress direct-action")
+        self._nk_host_tc_attached =3D True
+
+        # Get the BPF program info
+        tc_info =3D cmd(f"tc filter show dev {self._nk_host_ifname} ingr=
ess").stdout
+        match =3D re.search(r'pref (\d+).*nk_redirect\.bpf.*id (\d+)', t=
c_info)
+        if not match:
+            raise Exception("Failed to get TX BPF prog ID")
+        self._nk_host_bpf_prog_pref =3D int(match.group(1))
+        nk_host_bpf_prog_id =3D int(match.group(2))
+
+        # Find and update the .bss map with nsim prefix and nsim_local i=
findex
+        prog_info =3D bpftool(f"prog show id {nk_host_bpf_prog_id}", jso=
n=3DTrue)
+        map_ids =3D prog_info.get("map_ids", [])
+
+        bss_map_id =3D None
+        for map_id in map_ids:
+            map_info =3D bpftool(f"map show id {map_id}", json=3DTrue)
+            if map_info.get("name").endswith("bss"):
+                bss_map_id =3D map_id
+
+        if bss_map_id is None:
+            raise Exception("Failed to find TX BPF .bss map")
+
+        # Update map: match nsim prefix (2001:db8::), redirect to nsim_l=
ocal ifindex
+        # BPF .bss layout (compiler reorders): ipv6_prefix (16 bytes) + =
redirect_ifindex (4 bytes)
+        ipv6_addr =3D ipaddress.IPv6Address(self.nsim_v6_pfx)
+        ipv6_bytes =3D ipv6_addr.packed
+        ifindex_bytes =3D self.psp_ifindex.to_bytes(4, byteorder=3D'litt=
le')
+        value =3D ipv6_bytes + ifindex_bytes  # ipv6 first, then ifindex
+        value_hex =3D ' '.join(f'{b:02x}' for b in value)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")
+
+    def __del__(self):
+        # Clean up nk_host BPF attachment
+        if hasattr(self, '_nk_host_tc_attached') and self._nk_host_tc_at=
tached:
+            cmd(f"tc filter del dev {self._nk_host_ifname} ingress pref =
{self._nk_host_bpf_prog_pref}", fail=3DFalse)
+            self._nk_host_tc_attached =3D False
+
+        super().__del__()
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
index 864d9fce1094..f6337028f41c 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -14,9 +14,11 @@ from lib.py import defer
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
 from lib.py import ksft_not_none
-from lib.py import KsftSkipEx
-from lib.py import NetDrvEpEnv, PSPFamily, NlError
-from lib.py import bkg, rand_port, wait_port_listen
+from lib.py import ksft_exit, ksft_pr, ksft_run, KsftSkipEx, ksft_true, =
KsftFailEx
+from lib.py import NetDrvEpEnv, NetDrvContEnvPsp, PSPFamily, NlError
+from lib.py import NetNSEnter
+from lib.py import bkg, cmd, rand_port, wait_port_listen, NetNSEnter
+from lib.py import ip
=20
=20
 def _get_outq(s):
@@ -117,11 +119,12 @@ def _get_stat(cfg, key):
 # Test case boiler plate
 #
=20
-def _init_psp_dev(cfg):
+def _init_psp_dev(cfg, use_psp_ifindex=3DFalse):
     if not hasattr(cfg, 'psp_dev_id'):
         # Figure out which local device we are testing against
+        target_ifindex =3D cfg.psp_ifindex if use_psp_ifindex else cfg.i=
findex
         for dev in cfg.pspnl.dev_get({}, dump=3DTrue):
-            if dev['ifindex'] =3D=3D cfg.ifindex:
+            if dev['ifindex'] =3D=3D target_ifindex:
                 cfg.psp_info =3D dev
                 cfg.psp_dev_id =3D cfg.psp_info['id']
                 break
@@ -394,6 +397,387 @@ def _data_basic_send(cfg, version, ipver):
     _close_psp_conn(cfg, s)
=20
=20
+def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    """
+    Test basic data send with netkit interface associated with PSP dev.
+    """
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Test connectivity in both directions before PSP operations
+    remote_addr =3D cfg.remote_addr_v["6"]  # nsim_peer address (2001:db=
8::2)
+    nk_guest_addr =3D cfg.nk_guest_ipv6     # nk_guest address (2001:db9=
::2:2)
+
+    # Check if assoc-list contains nk_guest
+    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+
+    if 'assoc-list' in dev_info:
+        found =3D False
+        for assoc in dev_info['assoc-list']:
+            if assoc['ifindex'] =3D=3D nk_guest_ifindex and assoc['nsid'=
] =3D=3D cfg.psp_dev_peer_nsid:
+                found =3D True
+                break
+        ksft_true(found, "Associated device not found in dev_get() respo=
nse")
+    else:
+        raise RuntimeError("No assoc-list in dev_get() response after as=
sociation")
+
+    # Enter guest namespace (netns) to run PSP test
+    with NetNSEnter(cfg.netns.name):
+        cfg.pspnl =3D PSPFamily()
+
+        s =3D _make_psp_conn(cfg, version, ipver)
+
+        rx_assoc =3D cfg.pspnl.rx_assoc({"version": version,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        rx =3D rx_assoc['rx-key']
+        tx =3D _spi_xchg(s, rx)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": version,
+                            "tx-key": tx,
+                            "sock-fd": s.fileno()})
+
+        data_len =3D _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+        _close_psp_conn(cfg, s)
+
+    # Clean up - back in host namespace
+    cfg.pspnl =3D PSPFamily()
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_gu=
est_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _key_rotation_notify_multi_ns_netkit(cfg, version, ipver):
+    """ Test key rotation notifications across multiple namespaces using=
 netkit """
+    import threading
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    results =3D {'main_ns': None, 'peer_ns': None}
+
+    def listen_in_namespace(ns_name, result_key):
+        """Listen for key rotation notifications in a namespace"""
+        try:
+            if ns_name:
+                ctx =3D NetNSEnter(ns_name)
+            else:
+                from contextlib import nullcontext
+                ctx =3D nullcontext()
+
+            with ctx:
+                pspnl =3D PSPFamily()
+                pspnl.ntf_subscribe('use')
+
+                collected_notifications =3D []
+                for i in range(100):
+                    pspnl.check_ntf()
+
+                    try:
+                        while True:
+                            msg =3D pspnl.async_msg_queue.get_nowait()
+                            collected_notifications.append(msg['msg'])
+                    except:
+                        pass
+
+                    if collected_notifications:
+                        results[result_key] =3D collected_notifications
+                        break
+
+                    time.sleep(0.1)
+                else:
+                    # Timeout - no notification received
+                    results[result_key] =3D []
+        except Exception as e:
+            results[result_key] =3D {'error': str(e)}
+
+    # Create listener threads
+    # Main namespace listener
+    main_ns_thread =3D threading.Thread(
+        target=3Dlisten_in_namespace,
+        args=3D(None, 'main_ns'),
+        name=3D'main_ns_listener'
+    )
+    # Guest namespace listener (netkit peer)
+    guest_ns_thread =3D threading.Thread(
+        target=3Dlisten_in_namespace,
+        args=3D(cfg.netns.name, 'peer_ns'),
+        name=3D'guest_ns_listener'
+    )
+
+    main_ns_thread.start()
+    guest_ns_thread.start()
+
+    time.sleep(0.5)
+
+    # Trigger key rotation on the PSP device
+    cfg.pspnl.key_rotate({"id": psp_dev_id_for_assoc})
+
+    main_ns_thread.join(timeout=3D15)
+    guest_ns_thread.join(timeout=3D15)
+
+    # Verify notifications were received in both namespaces
+    ksft_not_none(results['main_ns'], "No result from main namespace lis=
tener")
+    ksft_not_none(results['peer_ns'], "No result from guest namespace li=
stener")
+
+    # Check for errors in listeners
+    if isinstance(results['main_ns'], dict) and 'error' in results['main=
_ns']:
+        raise RuntimeError(f"Main NS listener error: {results['main_ns']=
['error']}")
+    if isinstance(results['peer_ns'], dict) and 'error' in results['peer=
_ns']:
+        raise RuntimeError(f"Guest NS listener error: {results['peer_ns'=
]['error']}")
+
+    # Verify that both namespaces received at least one notification
+    ksft_gt(len(results['main_ns']), 0, "No key rotation notification re=
ceived in main namespace")
+    ksft_gt(len(results['peer_ns']), 0, "No key rotation notification re=
ceived in guest namespace")
+
+    # Verify the notification contains the expected dev_id
+    main_ns_has_dev =3D any(
+        ntf.get('id') =3D=3D psp_dev_id_for_assoc
+        for ntf in results['main_ns']
+    )
+    guest_ns_has_dev =3D any(
+        ntf.get('id') =3D=3D psp_dev_id_for_assoc
+        for ntf in results['peer_ns']
+    )
+
+    ksft_true(main_ns_has_dev, "Key rotation notification for correct de=
vice not found in main namespace")
+    ksft_true(guest_ns_has_dev, "Key rotation notification for correct d=
evice not found in guest namespace")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_gu=
est_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _dev_change_notify_multi_ns_netkit(cfg, version, ipver):
+    """ Test dev_change notifications across multiple namespaces using n=
etkit """
+    import threading
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    results =3D {'main_ns': None, 'peer_ns': None}
+
+    def listen_in_namespace(ns_name, result_key):
+        """Listen for dev_change notifications in a namespace"""
+        try:
+            if ns_name:
+                ctx =3D NetNSEnter(ns_name)
+            else:
+                from contextlib import nullcontext
+                ctx =3D nullcontext()
+
+            with ctx:
+                pspnl =3D PSPFamily()
+                pspnl.ntf_subscribe('mgmt')
+
+                collected_notifications =3D []
+                for i in range(100):
+                    pspnl.check_ntf()
+
+                    try:
+                        while True:
+                            msg =3D pspnl.async_msg_queue.get_nowait()
+                            collected_notifications.append(msg['msg'])
+                    except:
+                        pass
+
+                    if collected_notifications:
+                        results[result_key] =3D collected_notifications
+                        break
+
+                    time.sleep(0.1)
+                else:
+                    # Timeout - no notification received
+                    results[result_key] =3D []
+        except Exception as e:
+            results[result_key] =3D {'error': str(e)}
+
+    # Create listener threads
+    # Main namespace listener
+    main_ns_thread =3D threading.Thread(
+        target=3Dlisten_in_namespace,
+        args=3D(None, 'main_ns'),
+        name=3D'main_ns_listener'
+    )
+    # Guest namespace listener (netkit peer)
+    guest_ns_thread =3D threading.Thread(
+        target=3Dlisten_in_namespace,
+        args=3D(cfg.netns.name, 'peer_ns'),
+        name=3D'guest_ns_listener'
+    )
+
+    main_ns_thread.start()
+    guest_ns_thread.start()
+
+    time.sleep(1.0)  # Give threads time to subscribe
+
+    # Trigger dev_change by calling dev_set (notification is always sent=
)
+    cfg.pspnl.dev_set({'id': psp_dev_id_for_assoc, 'psp-versions-ena': c=
fg.psp_info['psp-versions-cap']})
+
+    main_ns_thread.join(timeout=3D15)
+    guest_ns_thread.join(timeout=3D15)
+
+    # Verify notifications were received in both namespaces
+    ksft_not_none(results['main_ns'], "No result from main namespace lis=
tener")
+    ksft_not_none(results['peer_ns'], "No result from guest namespace li=
stener")
+
+    # Check for errors in listeners
+    if isinstance(results['main_ns'], dict) and 'error' in results['main=
_ns']:
+        raise RuntimeError(f"Main NS listener error: {results['main_ns']=
['error']}")
+    if isinstance(results['peer_ns'], dict) and 'error' in results['peer=
_ns']:
+        raise RuntimeError(f"Guest NS listener error: {results['peer_ns'=
]['error']}")
+
+    # Verify that both namespaces received at least one notification
+    ksft_gt(len(results['main_ns']), 0, "No dev_change notification rece=
ived in main namespace")
+    ksft_gt(len(results['peer_ns']), 0, "No dev_change notification rece=
ived in guest namespace")
+
+    # Verify the notification contains the expected dev_id
+    main_ns_has_dev =3D any(
+        ntf.get('id') =3D=3D psp_dev_id_for_assoc
+        for ntf in results['main_ns']
+    )
+    guest_ns_has_dev =3D any(
+        ntf.get('id') =3D=3D psp_dev_id_for_assoc
+        for ntf in results['peer_ns']
+    )
+
+    ksft_true(main_ns_has_dev, "Dev_change notification for correct devi=
ce not found in main namespace")
+    ksft_true(guest_ns_has_dev, "Dev_change notification for correct dev=
ice not found in guest namespace")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_gu=
est_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _psp_dev_get_check_netkit_psp_assoc(cfg, version, ipver):
+    """ Check psp dev-get output with netkit interface associated with P=
SP dev """
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Check 1: In default netns, verify dev-get has correct ifindex and =
assoc-list
+    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+
+    # Verify the PSP device has the correct ifindex
+    ksft_eq(dev_info['ifindex'], cfg.psp_ifindex)
+
+    # Verify assoc-list exists and contains the associated nk_guest with=
 correct ifindex and nsid
+    ksft_true('assoc-list' in dev_info, "No assoc-list in dev_get() resp=
onse after association")
+    found =3D False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] =3D=3D nk_guest_ifindex and assoc['nsid'] =3D=
=3D cfg.psp_dev_peer_nsid:
+            found =3D True
+            break
+    ksft_true(found, "Associated device not found in assoc-list with cor=
rect ifindex and nsid")
+
+    # Check 2: In guest netns, verify dev-get has assoc-list with nk_gue=
st device
+    with NetNSEnter(cfg.netns.name):
+        peer_pspnl =3D PSPFamily()
+
+        # Dump all devices in the guest namespace
+        peer_devices =3D peer_pspnl.dev_get({}, dump=3DTrue)
+
+        # Find the device with by-association flag
+        peer_dev =3D None
+        for dev in peer_devices:
+            if dev.get('by-association'):
+                peer_dev =3D dev
+                break
+
+        ksft_not_none(peer_dev, "No PSP device found with by-association=
 flag in guest netns")
+
+        # Verify assoc-list contains the nk_guest device
+        ksft_true('assoc-list' in peer_dev and len(peer_dev['assoc-list'=
]) > 0,
+                  "Guest device should have assoc-list with local device=
s")
+
+        # Verify the assoc-list contains nk_guest ifindex with nsid=3D-1=
 (same namespace)
+        found =3D False
+        for assoc in peer_dev['assoc-list']:
+            if assoc['ifindex'] =3D=3D nk_guest_ifindex:
+                ksft_eq(assoc['nsid'], -1,
+                        "nsid should be -1 (NETNSA_NSID_NOT_ASSIGNED) fo=
r same-namespace device")
+                found =3D True
+                break
+        ksft_true(found, "nk_guest ifindex not found in assoc-list")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_gu=
est_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _psp_dev_assoc_cleanup_on_netkit_del(cfg):
+    """ Test that assoc-list is cleared when associated netkit interface=
 is deleted """
+    import subprocess
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Verify assoc-list exists in default netns
+    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+    ksft_true('assoc-list' in dev_info, "No assoc-list after association=
")
+    found =3D False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] =3D=3D nk_guest_ifindex and assoc['nsid'] =3D=
=3D cfg.psp_dev_peer_nsid:
+            found =3D True
+            break
+    ksft_true(found, "Associated device not found in assoc-list")
+
+    # Delete the netkit interface in the guest namespace
+    ns_name =3D cfg.netns.name
+    subprocess.run(f"ip netns exec {ns_name} ip link del {cfg._nk_guest_=
ifname}", shell=3DTrue, check=3DTrue)
+
+    # Mark netkit as already deleted so cleanup won't try to delete it a=
gain
+    # (deleting nk_guest also removes nk_host since they're a pair)
+    cfg._nk_host_ifname =3D None
+    cfg._nk_guest_ifname =3D None
+
+    # Verify assoc-list is gone in default netns after netkit deletion
+    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+    ksft_true('assoc-list' not in dev_info or len(dev_info['assoc-list']=
) =3D=3D 0,
+              "assoc-list should be empty after netkit deletion")
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
 def __bad_xfer_do(cfg, s, tx, version=3D'hdr0-aes-gcm-128'):
     # Make sure we accept the ACK for the SPI before we seal with the ba=
d assoc
     _check_data_outq(s, 0)
@@ -637,6 +1021,74 @@ def main() -> None:
                 ksft_pr("STDOUT:\n#  " + srv.stdout.strip().replace("\n"=
, "\n#  "))
             if srv and srv.stderr:
                 ksft_pr("STDERR:\n#  " + srv.stderr.strip().replace("\n"=
, "\n#  "))
+
+    with NetDrvContEnvPsp(__file__) as cfg:
+        cfg.pspnl =3D PSPFamily()
+
+        # Set up responder and communication sock
+        # For NetDrvContEnvPsp: psp_responder runs in _netns (remote nam=
espace with nsim_peer)
+        responder =3D cfg.remote.deploy("psp_responder")
+
+        cfg.comm_port =3D rand_port()
+        srv =3D None
+        try:
+            with bkg(responder + f" -p {cfg.comm_port}", host=3Dcfg.remo=
te,
+                     exit_wait=3DTrue) as srv:
+                wait_port_listen(cfg.comm_port, host=3Dcfg.remote)
+
+                cfg.comm_sock =3D socket.create_connection((cfg.remote_a=
ddr,
+                                                          cfg.comm_port)=
,
+                                                         timeout=3D1)
+
+                cases =3D [
+                    psp_ip_ver_test_builder(
+                        "data_basic_send_netkit_psp_assoc",
+                        _data_basic_send_netkit_psp_assoc, version, "6"
+                    )
+                    for version in range(0, 4)
+                ]
+                cases +=3D [
+                    psp_ip_ver_test_builder(
+                        "key_rotation_notify_multi_ns_netkit",
+                        _key_rotation_notify_multi_ns_netkit, version, "=
6"
+                    )
+                    for version in range(0, 4)
+                ]
+                cases +=3D [
+                    psp_ip_ver_test_builder(
+                        "dev_change_notify_multi_ns_netkit",
+                        _dev_change_notify_multi_ns_netkit, version, "6"
+                    )
+                    for version in range(0, 4)
+                ]
+                cases +=3D [
+                    psp_ip_ver_test_builder(
+                        "psp_dev_get_check_netkit_psp_assoc",
+                        _psp_dev_get_check_netkit_psp_assoc, version, "6=
"
+                    )
+                    for version in range(0, 4)
+                ]
+                # Run netkit deletion test only once at the end since it=
 destroys the netkit
+                def psp_dev_assoc_cleanup_on_netkit_del_test(cfg):
+                    _psp_dev_assoc_cleanup_on_netkit_del(cfg)
+                psp_dev_assoc_cleanup_on_netkit_del_test.__name__ =3D "p=
sp_dev_assoc_cleanup_on_netkit_del"
+                cases.append(psp_dev_assoc_cleanup_on_netkit_del_test)
+
+                ksft_run(cases=3Dcases, globs=3Dglobals(),
+                         case_pfx=3D{},
+                         args=3D(cfg, ))
+
+                cfg.comm_sock.send(b"exit\0")
+                cfg.comm_sock.close()
+        finally:
+            if srv and (srv.stdout or srv.stderr):
+                ksft_pr("")
+                ksft_pr(f"Responder logs ({srv.ret}):")
+            if srv and srv.stdout:
+                ksft_pr("STDOUT:\n#  " + srv.stdout.strip().replace("\n"=
, "\n#  "))
+            if srv and srv.stderr:
+                ksft_pr("STDERR:\n#  " + srv.stderr.strip().replace("\n"=
, "\n#  "))
+
     ksft_exit()
=20
=20
--=20
2.47.3


