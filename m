Return-Path: <netdev+bounces-187514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEEFAA798F
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 20:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115491BA3A1A
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D471E04AC;
	Fri,  2 May 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JPYY1KKp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0B1A83F7
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211955; cv=none; b=VIrA6Pc1cV9uq1HlmQmBmb4GSC/CFTNK3sSiFRTNdD9gjmhY6wdqNii7ic1Lt4hux++ROoaLAgy/0RxAffLqzR2IYvpFFuvSBp1YV3YIe4Me7jU7Y7Vlm2VN4hTXrnmHob1BA+EVGZXVJAW4NsPbL1vAKhjqIj7cFUdhBEP8BHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211955; c=relaxed/simple;
	bh=WwFHPpYiJtPWSvVKRAQ6LCXVIkNWRRF6DXqHpHiRv3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EChkrdOY+affKbhxrEQTem4xMkxePqFc0HQa32j8OkdQYpZhIopw6xppDsMihlh01iG7W754vx/f+LZaJQwEDg2w6GHZeVh5HODVbMRRavvj3EpnmyFyy4X7pySYEq7ns1AU+P/N/UIR/95lvsyUqo8kk/D9pJCrD4WdSxkbTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JPYY1KKp; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 542F0htk011027
	for <netdev@vger.kernel.org>; Fri, 2 May 2025 11:52:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=/jbLj2IuHQv5eYqx6c
	C7dtGQdy7Uy1+CLaJsfU1UcxM=; b=JPYY1KKpI9L5b1YkAnT7U+9/jvIBIsu1hv
	9D8kRZxa4gUEPfOOrTE86mmus+iwnj+9ZatJv4WOWlzfx3N7/TBdJOOmcH1Lfflg
	5UsBotT1jeZRN67kRgYSv8DnaF5f6PIKrz7OQSp/38IGMtEVMJxLzHHo+aVs3rNd
	H6omfh9oxpIUMsMb/hY2eXLx70J5pFl0pfgoFFQNo4ZTx+EMiLVG4Qn+SJr4yzyr
	JAh8aWCI4UUdEt/yTVZ61+HbHXvTtBOXE1BZV+eaPdsoZ43H35aH33n8jaJydFmU
	Lxwz6wykE1HFKQ2D/OE84UMKtOTICigmPoTcM5j5Ug2cGAei/OAQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 46cjpyy6nd-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 02 May 2025 11:52:31 -0700 (PDT)
Received: from twshared35278.32.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 2 May 2025 18:52:26 +0000
Received: by devvm14721.vll0.facebook.com (Postfix, from userid 669379)
	id 61EF122C0376; Fri,  2 May 2025 11:52:23 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <kuba@kernel.org>,
        <jiayuan.chen@linux.dev>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: remove sockmap_ktls disconnect_after_delete test
Date: Fri, 2 May 2025 11:52:21 -0700
Message-ID: <20250502185221.1556192-1-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE1MSBTYWx0ZWRfX9SeIzHJm8lnj zMub4yT4d7l3I+J1ayLARcyZQGeRmtX8Xz4VvnHsps4oLkOn6qGbk2DAvuHWh6i1a7IgXvoY1mD EiCl3wXMBoMe5nGDpx/Bp75v49ptbn6zgwtgAqmj2z/d/hRIAlws1ZuEFc72ZtqIN6Gz5axAaxU
 /5PjGExkpHO9ztyVOOZFQYPBeeJmwV42gTpZD8FpwlN3TFLG3jOUVWER+5lJaPkwf3jGs5Ym3bl Womg+vqOOOzSWJ94SoF8wbtawMSZvykYo51jqmSO2v6vQFHN8kYKqNTSTVVh02LY7gM2xD1RCQs ynEn+R6pYBxj10LZDXD1uuudYr5Ooy9/2deq4RaA62l60fyxj+mqQ2FsHf+ypvESXQj4ceE6ut1
 7PhQVwldxJsTkwEGZZGKEMD4Zs8rVisrEW8b3pHZuEuG7F66nIkLhFGk2HrruPAiIlAgrZVP
X-Proofpoint-GUID: 8HSiSwFTy8C3N-op9LNAPuoQOIeVYbB_
X-Proofpoint-ORIG-GUID: 8HSiSwFTy8C3N-op9LNAPuoQOIeVYbB_
X-Authority-Analysis: v=2.4 cv=NM/V+16g c=1 sm=1 tr=0 ts=6815146f cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=wzi3Pb8H_usUsDU_QI0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01

"sockmap_ktls disconnect_after_delete" is effectively moot after
disconnect has been disabled for TLS [1][2]. Remove the test
completely.

[1] https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@li=
nux.dev/
[2] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.o=
rg/

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 67 -------------------
 1 file changed, 67 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tool=
s/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 71b18fb1f719..3044f54b16d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -61,71 +61,6 @@ static int create_ktls_pairs(int family, int sotype, i=
nt *c, int *p)
 	return 0;
 }
=20
-static int tcp_server(int family)
-{
-	int err, s;
-
-	s =3D socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(s, 0, "socket"))
-		return -1;
-
-	err =3D listen(s, SOMAXCONN);
-	if (!ASSERT_OK(err, "listen"))
-		return -1;
-
-	return s;
-}
-
-static int disconnect(int fd)
-{
-	struct sockaddr unspec =3D { AF_UNSPEC };
-
-	return connect(fd, &unspec, sizeof(unspec));
-}
-
-/* Disconnect (unhash) a kTLS socket after removing it from sockmap. */
-static void test_sockmap_ktls_disconnect_after_delete(int family, int ma=
p)
-{
-	struct sockaddr_storage addr =3D {0};
-	socklen_t len =3D sizeof(addr);
-	int err, cli, srv, zero =3D 0;
-
-	srv =3D tcp_server(family);
-	if (srv =3D=3D -1)
-		return;
-
-	err =3D getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli =3D socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
-		goto close_srv;
-
-	err =3D connect(cli, (struct sockaddr *)&addr, len);
-	if (!ASSERT_OK(err, "connect"))
-		goto close_cli;
-
-	err =3D bpf_map_update_elem(map, &zero, &cli, 0);
-	if (!ASSERT_OK(err, "bpf_map_update_elem"))
-		goto close_cli;
-
-	err =3D setsockopt(cli, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
-	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
-		goto close_cli;
-
-	err =3D bpf_map_delete_elem(map, &zero);
-	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
-		goto close_cli;
-
-	err =3D disconnect(cli);
-
-close_cli:
-	close(cli);
-close_srv:
-	close(srv);
-}
-
 static void test_sockmap_ktls_update_fails_when_sock_has_ulp(int family,=
 int map)
 {
 	struct sockaddr_storage addr =3D {};
@@ -313,8 +248,6 @@ static void run_tests(int family, enum bpf_map_type m=
ap_type)
 	if (!ASSERT_GE(map, 0, "bpf_map_create"))
 		return;
=20
-	if (test__start_subtest(fmt_test_name("disconnect_after_delete", family=
, map_type)))
-		test_sockmap_ktls_disconnect_after_delete(family, map);
 	if (test__start_subtest(fmt_test_name("update_fails_when_sock_has_ulp",=
 family, map_type)))
 		test_sockmap_ktls_update_fails_when_sock_has_ulp(family, map);
=20
--=20
2.47.1


