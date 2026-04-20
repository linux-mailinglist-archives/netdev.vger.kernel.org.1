Return-Path: <netdev+bounces-279947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F8dEIsKl5mlPzQEAu9opvQ
	(envelope-from <netdev+bounces-279947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:16:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D54AF43488B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2680A3003604
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645E6382F10;
	Mon, 20 Apr 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="dUhxPEyP"
X-Original-To: netdev@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022143.outbound.protection.outlook.com [40.107.40.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D509418A93F;
	Mon, 20 Apr 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723391; cv=fail; b=My8HJnLaLNdbh1HQcSbfQpoPNupOeD2f9zCykqsrOHOSvlh1s9KYvevgbKnr98peX/tQyr7/qf6WQvq4yYkjeVoS5DZJ0dwJtrumZ9IMtiFzrsxhuWCOZWtVm9EIqDzBwtag68FcDkSBLFW26zUO4kerM4p0toPeocLbI9meOJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723391; c=relaxed/simple;
	bh=AKOoItNo+SGHyGuSI29l2ATns/VH1jtmqayOXagb2K0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rRug9zy+H/ai/IDsMa0T+fk9GIfnO09P5BpEILXtcFjkhzvxqGDbr7+LtLNmOFl3l0FQUF//QX+GkHFHWWqmyamPZQ9L4clDFtAfbyG7kKFIkBx6rSR14XaFhgkhYEb6pzL6QRtijtMId1xMUL6ptMPlnvGNaBM4Fq5zUAj6zwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=dUhxPEyP reason="signature verification failed"; arc=fail smtp.client-ip=40.107.40.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDa0ugMewFcZ0/wCCJm9X6vR5YqukBbMokn/mQnTbyo+HW36kopJrN8nJ9F+GfhJB1KurOXtW2sfSUL7Agr2pPSkdCQvcyrz1YS1Ful7Pb9vn3XAF0o2GdBZPbyrrAbEoa/IHANGim1/lsozaHj5/4mThdfEe8+p2xNU3HPwWBJNJgHBG6WxBzpiZr8VlkfaeU7+y9bT6x6Tm+Gyggvq7ML0RU8cZtMjfP7MPdAFQaxHKO3Tucr1LDVEBRuI826aNol4c230OP9pqO7cncOTBZ1ecBcHIoB0M688Q3ac6uqgMy+/aMNtS3SgUB6uOFk+OIPfwW93EeOO/qZAZxLSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj7RnFLKdkMePmosKMVZ4lMz6KI+0gtMrJXgIfoUp/0=;
 b=j4zZWV9kMPMgL6CZx38MoOVkzMToQ+Ar+RyBdJ6i1It2zbf/x3G7vqKTX1N83efkBNoMJubU8iKZHr4fvQrLhKdy+0piBSOASZsPA8IIGLKutKbwWqVZ5YTWYSNqZ+kqmDE9pLmkIkAOfX7n9HZ2XveidikQsf7cPSHw0t0C5QtXiZ+kmqiDp3cqoAod6ShyajPmwrbhHEyoAt8lSHekOlsXHR9XC/wuC6zFnub2SJURlApqlmEoz0fx7XadhLJTKDdluCISXM/MqGASyY8+Er7hFH+/GGkVfPNshP+hkVBdfXmstmuFsXxvo9wJ5CP8gH8vD9XpnywPNSvN40f/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj7RnFLKdkMePmosKMVZ4lMz6KI+0gtMrJXgIfoUp/0=;
 b=dUhxPEyPQbyN0QFySQgri0HttveiHybudzjiWVfBC+0pFHK87FyqE6c/o2X0otQkf8Un082FpGYhqFlcUlcmJepvR0se5ivhhmcJPlBB9zgUMmzRwMQByt4i3YHYeX/rJCVBeH/NyXdtJuWO1cSzSMTdwMWW4WJYX873HGfx1zOK/ifs73W98xGs1GKg7kUy2T1mH3sMQsHutl7OGx83XQkoUqElNxkw2HzZql/60gmRTRNYdzLcecQMU/CCmNmErzcbWIGavAh82692nhoYRDVsydN2De4qZu/AuA2vncR445FvBzmbfAPID6zarJ51LkPh0HarMkba9xfD2UYH7A==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY8P300MB0061.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 22:16:25 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 22:16:24 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Werner Kasselman <werner@verivus.ai>
Subject: [PATCH bpf v4 0/2] bpf: guard sock_ops rtt_min against non-locked
 tcp_sock
Thread-Topic: [PATCH bpf v4 0/2] bpf: guard sock_ops rtt_min against
 non-locked tcp_sock
Thread-Index: AQHc0RNThweEPstU0keOTfe8JlI3jw==
Date: Mon, 20 Apr 2026 22:16:24 +0000
Message-ID: <20260420221621.1441707-1-werner@verivus.com>
References: <20260417023119.3830723-1-werner@verivus.com>
In-Reply-To: <20260417023119.3830723-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY8P300MB0061:EE_
x-ms-office365-filtering-correlation-id: 8b1c6e4b-97fe-4ea7-c399-08de9f2a75dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 UzRjwI/ZbVJk/hN+B/ohx3JKzvFslM92CibZpbs8+hJlkVkgIpeRTUy2WB/vgbL1HhLlaa6c6qSJY/zpTgCTzxHy+5a0Gf+INGZJ98ihp+ZE9Zlq2AxxR2idTzdYzcCezbQ6PIWYjG5rrMmaSjQWUWNe6NVo8hVBMnKW90A+vjq9ADKZSjDzOlCOd7zCSQmS8KCB7XOVqBaFKIyyK3tfMQbkD+sMQYOHVPdll6mc9RPpDKYHDKgQ1ud2RYk+wsa0iPvEA4DiTb0njWNGZQlJ8mOswTzv7ZUBK2/tTdu5U2O5lFBB612GqrxOZnSoE8+J4e2tH26A1P/P99tTWq3K/5LSiuTAwL5EK65ILqYle9kBYJ5iK6BQ8L93yYrUWTap3H6q2K1wiYDtmBftOU0qg3bD5WBJrgaSo6oOpMEi6a9IOAYDk7VY0HYiIPYwWQOGDyJ7Lsp04CC3kPiE/+4qDNwEeYxIFBMBfHB6TiRqxRj4XrMBoD5flwnaVvGdngM4FaSYYwzhXb4OOuyjwM3QHI9Y6+20DLBVzsJFLLkWVWLLLUJCLhDoyZe2DgmJ1XSXC7E0TRmJPQN4eBnE1isgtMPAr7N0Ym9dvZ/LLpT0gQG2nW6R5BnHZ0D/Zz8n4JOiKIjYdfr56oVIxs7i1nuurZw4zxaaVUJi3J0XgqFtM9j+T3KVFF8KMxkqBcU08WSH/sUuGLY20ERBtsIO6+Y5m+shjSxngn29m/X4qqPdjb2wvTdG3mRngl8agxFkkehzJsGg2mIfLR3EfkinYt2yQHfjSBLeqi5OizZFdcQnbf0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ajxoWsl/Vet8NG2fuOprNqyRI2huJKoSDjPAhSuvarL4Q2/oWeHnnhMMqa?=
 =?iso-8859-1?Q?ICr7IJhMWU0Z256rJeRiEfRhQalGcSRTKWAbiioHMnpeQjhvDT2U1ysRKR?=
 =?iso-8859-1?Q?GbZvKe/LHXAKRBnYiy/iR5ZhOVklNmJyPWSKQVK8hrOo3XXGdBagbf1ihW?=
 =?iso-8859-1?Q?H+/eOU2CkmO75KANnn2hgTc5J+gF+rP7xzajMhYEezBKqWEK31z0whICno?=
 =?iso-8859-1?Q?2q10KlR8sKrlBQ3PiaV1Ja/yr1KqIEZCmUmgk8JCItpIVImkwzjcruC+sA?=
 =?iso-8859-1?Q?wn66dM9zMgq/MJZbwdgztjOCnyxrQ0hl81n6/OhmeCZVR3cjvluhlWShyW?=
 =?iso-8859-1?Q?rHxNNjLKg4YAmo/+8nT0rycRImvAi9xkz5JDpIkHOWsHd1+UCTPaF3M6KI?=
 =?iso-8859-1?Q?1/0n7VCPL/XqWe651lolAUJwDh8P5IN9NH1pwi0gc60O6N8q3ulNdJCeJi?=
 =?iso-8859-1?Q?X45d5jyNmqJOk/qIMvPJh/cLJhS8g2fnUgTcpetTQX0M8dLcvlHya//aJ7?=
 =?iso-8859-1?Q?GhKMHtmjB69F25mYmUmznLYLCV/NM8myVZnEYfuKywp2cvhCwcUH2MiHlO?=
 =?iso-8859-1?Q?4dYS7nWpvwfAeuGEWSEuMPh3XjiU8p2FnUvsLC/xRU2PgiVqWCeFW5+ZAp?=
 =?iso-8859-1?Q?u1OyBy+chnfdy+4g35eaV95FgabDeLFIxTHWsDYiIiitS9XZrNrJO/qu9p?=
 =?iso-8859-1?Q?/zjUvosiZ3+jZqmpEEstG7vRt5kUKKPFbxzgUqomLXMeCv2DD2w3rCSwcQ?=
 =?iso-8859-1?Q?c1vFFBN9RBQqRf7WWIuL0NRt0MzbOQPt6Pzu3BB2RsxGGiJFsmObI6RGTD?=
 =?iso-8859-1?Q?GSuR14+6ARIJLXc9sOql6v5jxC3wWCDQABDkIUBl74AaAoj432aGJ4PiUj?=
 =?iso-8859-1?Q?AjTacqwN4Zdbyu+jwALy5Dbk8ewg5QiGXzn2KUIyCvZcdQkNYcA8BGk8fb?=
 =?iso-8859-1?Q?QvwjwHoSBacx/1Obj3LKCklSu6smwa8cixCMFNnBnpqf/m27akmZ61kIsl?=
 =?iso-8859-1?Q?PISBLcOZO9WstZsaJjjWUvMlz4MhJkio6aLptW/sjCQteLqERrCJ1NPWBj?=
 =?iso-8859-1?Q?5a09tZWPXPb19gfbKmhqCbXZIXxpuwg9Lu6IFRaSp3dBGiecpF4I7ghz/C?=
 =?iso-8859-1?Q?5E0jnTdGheM2iSg7EyftF/A3NoU3g+XcEdTop4Il5G+QnPLpmn3+FYO1n9?=
 =?iso-8859-1?Q?KCKwJzSZh9W6MNto07P1qxISAtAKx5Ic5MzpcnDbJbYpVnJ6iKfCom06G3?=
 =?iso-8859-1?Q?JhV2UoY8dWtH5RngBSbfksrOK2T4VlvLv8mADqN4X3c2urOkpRmdxoTZV2?=
 =?iso-8859-1?Q?EdwpjIlCnAVZmIiTFlREDbL5QUva/9J0itmZrc9Xo71aLw2dyc6ManHeVF?=
 =?iso-8859-1?Q?iHM0U3XrYt9O8rB30KGhnYJzIEfa6wN2CzbT4hx6o9ivZF3/kcs2ri1zBC?=
 =?iso-8859-1?Q?NVW0MOlAPtakgnUT81SqmMc5bXChduaiHrRE/KJCE+OL4bGAwZRyWVbCjK?=
 =?iso-8859-1?Q?ZJkmvrwPGOrfvgtkZtLMFqeI7wR2cwd6USM2+j5NdHT//DMVVcg+E3h4kL?=
 =?iso-8859-1?Q?xXPjnJJVfigX56GIfB3JH8V77DYXDFmUmlLXL6S638XRzS/+6lTHc2Hqgv?=
 =?iso-8859-1?Q?wkGKIu3WQ0WNzdDFjj9BcWhGEeMnPDuAPXiy4t3WbXm4LDv7gwMbT4Cj16?=
 =?iso-8859-1?Q?U2K1PEhRKPvwBlMjsaJ/KmQb5wziKqLED629U6YBcqrB72aJVtftkxpRUS?=
 =?iso-8859-1?Q?RHcHZ5Ue1Ztt47G6LXDlYBMOH0T6Uy2XTT2P0GOTxvEEwQSptQcL0t7waV?=
 =?iso-8859-1?Q?ScXqaT68gQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1c6e4b-97fe-4ea7-c399-08de9f2a75dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 22:16:24.3503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8y8Oa6Tp4Col1SuNBcEH/UOkoN+mhjEO3Vo+/xj5vGfmf35EuZvceV5EKn7gFqWgB5WDw0RW9MNlbTEf4wouNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0061
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-279947-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[verivus.ai:-];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,verivus.com:mid]
X-Rspamd-Queue-Id: D54AF43488B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_ops ctx rewriting guards the direct tcp_sock field loads with=0A=
is_locked_tcp_sock, but rtt_min still used a raw load sequence. On=0A=
request_sock-backed sock_ops callbacks, that can read past the end of a=0A=
tcp_request_sock allocation.=0A=
=0A=
This series switches rtt_min over to the shared guarded tcp_sock field=0A=
load helper and adds a tcpbpf runtime test that exercises the=0A=
same-register request_sock path.=0A=
=0A=
v3 -> v4:=0A=
- reuse a shared guarded tcp_sock field load helper for rtt_min=0A=
- preserve the dst_reg =3D=3D src_reg failure path that zeros the destinati=
on=0A=
  register when the guard fails=0A=
- replace the weaker ctx_rewrite test with a runtime tcpbpf selftest that=
=0A=
  exercises same-register request_sock access=0A=
=0A=
Werner Kasselman (2):=0A=
  bpf: guard sock_ops rtt_min against non-locked tcp_sock=0A=
  selftests/bpf: cover same-reg sock_ops rtt_min request_sock access=0A=
=0A=
 net/core/filter.c                             | 39 ++++++++++---------=0A=
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |  4 ++=0A=
 .../selftests/bpf/progs/test_tcpbpf_kern.c    | 14 +++++++=0A=
 tools/testing/selftests/bpf/test_tcpbpf.h     |  2 +=0A=
 4 files changed, 40 insertions(+), 19 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

