Return-Path: <netdev+bounces-263956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCkvHSZvqGkkugAAu9opvQ
	(envelope-from <netdev+bounces-263956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:43:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA05205536
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AEE63005585
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7936B050;
	Wed,  4 Mar 2026 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gy84EENM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7FA37AA6F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646178; cv=fail; b=LI6JUzOxUxuuDA0dbtOUuFWxwMbRwLMuMptD5bJYvGCe2ypo6tqI8nLkhSIoAHaVFYhxGUr8R/cfIfQoDucWcxIc6OGFeJtQBcf8tl4bwi4ufhiRuAlWO9a7UJdmQvDF/jeSSxS4GwnwZZ90stz2YwKZmzvHcwj0DCciNnuu1Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646178; c=relaxed/simple;
	bh=B5XZXhO+vJMPSjQRqxxio3maENNCh4mPySekQZ7OK9w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qdioiy8a2PFDh5m+tzDYHczhyU+9Rtmlmo1f9SGdiFy1Km+Bua9VON7OEVopc8n8d3/KnWY5xRuX31Z6qug13so9hKbKt5pWMTuiZm0zzYXH834CE17cwCNyhIkpBOVWO5bKV7SOHwbAw+pRJ94HclQJKo1t1avKx6vhxPsutso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gy84EENM; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 624H5kCF431818
	for <netdev@vger.kernel.org>; Wed, 4 Mar 2026 09:42:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=B5XZXhO+vJMPSjQRqxxio3maENNCh4mPySekQZ7OK9w=; b=gy84EENMRpbC
	Rm+MILE9LmR6xO1mIq737YASYNwgu4EluYKQTCTTEqFKL8NDPQfNA2LE5wEjqUeX
	051ZheuWDaE8w/kb0bNfWABGlVGjwRPY97RXw8qQUKrkthd5x7TYnDM5dkUY7EUH
	jvQpw7W1wlKOrjvUIFphHClKn7vKGlEwVbhcs/rnK8K6hdrA6tgQJ06GCGfSjyoX
	ucldvjmDBAxgGR45kmnvvrgeZHRkEZuLsSUc/onhFi6K7zx4NDBRFnohWh9BMBoc
	f7DQ5CKRgL7ySeMx/ybBTcYafJXUJDKgdOm8iTrx6oLOcfuHYKZvW/JUQnO29rmI
	xJnju4A1RA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	by m0089730.ppops.net (PPS) with ESMTPS id 4cpbnpg4kk-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 09:42:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQAHT0KZX+Zq2eeaz2GIwW2D6lMXEfosO05OV3EtBko+RvOumZJfKyIN/lXTZ/vOU5Nwtl0FzlNFEtQTjRmpi1cokMC9Oe3ag8hB1dgk0E2aXidu2qDcM6jl6aBo/zyAlxWvD0uhT7SjSruXY4bjjDep8zggF2ZsFmZ9uUNHV/5+XZgn57j8iPZQ6EjmnzjUxeDwVBCEt09rq6HE+rQcyHTNUzNVh3m9jTL9RWLevGnqNZ7PECFzsKNeV/ipJgUB4YIiVlTT4uyvhdziiklDRYgAN6Efo06Xk4dOGiLqs1SRqxrm9drhmQW81l4IMz9JoJdRE80Wx6DalylawfOFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GVw50BQUZTPZaG/lbqJPHsQWPP4xw9kBuARCN7jx8o=;
 b=rFd6p0tzSBmRuq6fzSvZS4O9z1qriIUMwzMmxr71BxfjMap7SxCUOA7pyQDCOjSu18YHXvuENQPf/Hc55Q1HKHBsCb7I5DpQRB+DGUR2naNb3YTUwSo+8PXQU74XHbIi7658Eeq3/+NPMo/dKWptwchuxZP4wgglbx5DTUEyx4uTOeATifchaRaQXUKGdtWt3+J0Jl14fqVsBcMCQ0qz3mcSuWu+YBt1z7qLPTyJCpUVDxBtCEUVtLNqcN9Rtvthw48a2zaI4VpaAqZYL4SYMMyNc+gKXi3sPZsKe680uhntJ4lQmik/vN1A9MlRwt1X5G29MrZtF3wsi75spMKjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5817.namprd15.prod.outlook.com (2603:10b6:806:33a::11)
 by DS4PR15MB6933.namprd15.prod.outlook.com (2603:10b6:8:327::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 17:42:52 +0000
Received: from SA1PR15MB5817.namprd15.prod.outlook.com
 ([fe80::5aee:c356:70f0:66c2]) by SA1PR15MB5817.namprd15.prod.outlook.com
 ([fe80::5aee:c356:70f0:66c2%6]) with mapi id 15.20.9632.015; Wed, 4 Mar 2026
 17:42:52 +0000
From: Wei Wang <weibunny@meta.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
        David
 Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
Thread-Topic: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
Thread-Index: AQHcq2vctPcgZuHnIkGgU6JfsZG6gLWekEYAgAASKuo=
Date: Wed, 4 Mar 2026 17:42:52 +0000
Message-ID:
 <SA1PR15MB5817C41068E5167A39F4CBD1BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-6-weibunny@fb.com>
 <willemdebruijn.kernel.2c99d96277de8@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2c99d96277de8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5817:EE_|DS4PR15MB6933:EE_
x-ms-office365-filtering-correlation-id: 12be313b-6b92-4a03-4799-08de7a157604
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 Y74OufBTqD9Kk7JVIRyWMZJ84xiixyuiDfv6ldFnSq8Kxl5fHyRafCbsEGCquql/B5VPV2wkXdL1xfXkivHHgUCTtWm/L2O2tICp2nvt+vSEHovOPzxQbUqrHh+uBANeQpsBIKnacmUAFiIvFK/4ZFfijuA9wBFrWig64iHbUCKq0A8GIZcEgh5hGmHtWIlOCKqnERWyeKUGgbZvt2V9KDI10ArfwFY3beeDDKbWwiNRQX6HdulNhv8NarK22HBD4tvfziFnggBw/h6Vo/UAo4U2kNsjDH4xZ5/UVebhemVpMJSbyUPMw0p36MKrbczZvstZsgaG0r7IQ30jBRrl/q1lfA4jf0XxTX0FTCuq//Z4XKhMCUh0EPadP4ZB74trED8DluD5gjK1WFp8t7rn9daHXG5GVNuqT1AITjIOD8VfT7yvr0uxF0/Sm5e3g/g0vGMLxuYVs2CGIplSUj1ybK2Orj6oSHYSNeRU6oaE+ryj8E9vCZGZPukvVbUwY9mdugi7A4u9h1kPPnmqwYrfBae4uW+jZlsIFUAQn6OUqcH9lZEbaGVQOn361zq4RyuroCrk12KM917UfwLtWX4FTHh5sbo25Xj+nFft9/vaUA6Zls7iLeARc4wcNWDuCl73k3JetvZ4+8ngPS12pAKTPF4RdvVh1zpOWP4Y09bPH0ZGGyjp6mlfKy8M/vAnQUVC6CgYWEnzFS5O3Q351GOcCdRJRVfsCFcfVocrLgiZjJ1ZxfPC/UXuZNdZPJhuJE//VXOg4/0z0P4uhzuhRVhurI3G70ucYO27iy4bVZKRSFs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5817.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xkZZwCk4zuOOAnAGLm2Y7nQYXF4lGuaWGETj+1ZDhDudmjWR0jT3vRTpq1?=
 =?iso-8859-1?Q?7sSywp0MBcCEUa4RuTrxRT6vbcWdrxPZHYYzV3cJfMhjkmvOEz10Z1RNk5?=
 =?iso-8859-1?Q?3SEHv39wh04CzxaJv0M+HF8/4FJoUAwy0Xy59E7vV4fpnPsnjdIaEgbeRB?=
 =?iso-8859-1?Q?u5ASVY/9cxqur7vg3L6ujJHn86S178qkgWHVihFIDzkUU3Abh930vXsO9i?=
 =?iso-8859-1?Q?+M0/diAbVlNOIaa+3/mTEOtZBdW2W5VWCsoYxmOrNTNZVny26wW0voyKne?=
 =?iso-8859-1?Q?Aq+yWxTzyAaIin9yQLdn8pwo3GLvnPCL3oqrJbdlnsT2EI0I1VVy8tTGN8?=
 =?iso-8859-1?Q?mctDjWdhnvPSP9SslsPvu76K+JogfNUJDe1BAEsSZSsNwGGUm+94JX/xqf?=
 =?iso-8859-1?Q?T8Ahbho7xIewA3OVlmZwNGjsAoGc6LiLGrlyDUQU+eH8X3Qcrlqe0J6vZU?=
 =?iso-8859-1?Q?7MWiSEjMvPvWtzwgutLog/TM/g5XZZ3mxX4WiIEDQuw2NOyOm5uf4xMA+Q?=
 =?iso-8859-1?Q?vOg/EJgouBLwh1bSE8FgXgZ5CEPOmgwj7augKwFkv3QwZzgKHN+tMM7xR5?=
 =?iso-8859-1?Q?qa/CRNJGAsVMWbVYjnOZ1NexhjTARN9Mf56a080t7qUgPs0FeOqf/hKd2p?=
 =?iso-8859-1?Q?F/SjM+qWr08rDRhXS3yslZe+UO2Q8OrqT21R6nAKj3Pjv9ZawWgDn5VTtz?=
 =?iso-8859-1?Q?Oxnz7iDSDJM1OQTrAwlmwT1M2I3Nz8+rF6ii0UwXgpzj41ZUFwoQ/9XRXz?=
 =?iso-8859-1?Q?4IsXMQPwfi+JchkEewgaPvYpHgp+wCgjAZOj7i+sqSIT8uiRYxYbOnvDKv?=
 =?iso-8859-1?Q?o5KU+eaoQnY5JdoZwH82sNmTYAUj7r01bBtxO2PwB8cCfAwW5fyOqLlhca?=
 =?iso-8859-1?Q?vHkRtcJkN8x0vRWTjsAflSZY0loJhUyJKKOm3ORCB+BMODUOrnPmkWmYfs?=
 =?iso-8859-1?Q?dLL2524LW8n4IkfIbFtk2hJ6H6N3si3GEVMAPJN141Chkm9/ZBY2TSsTls?=
 =?iso-8859-1?Q?dszNS4xh+Y3phEtF8HbkDasBEXmLuHwG1JOFuxbstnVhhsBp42Z2uvYcA5?=
 =?iso-8859-1?Q?KvCbukHiLBpKhp9kUCkOOnej+vRMspVahZlmqKFRMXb+Sv/f07BD6Vd9xE?=
 =?iso-8859-1?Q?/OZDs7I6Bd3Dn6/93RlBRs9GzEqHLJEZ2rFmBmvufuPPHLTYz2C8Y5uysV?=
 =?iso-8859-1?Q?tbLROc+BPLUBnyMYNhN7Q++BjF0VbC9M0L84ey1GUoqQQ8KTyUcVGeEmUA?=
 =?iso-8859-1?Q?Pc946HRS7DTa27i91iJ8EiRFDX76TJ3n2fAStmK3ckEbknfWSrpSHDI9yB?=
 =?iso-8859-1?Q?0JM3gwLGBcfNglxElSkihbtqD+K5wK9UgUXfRYA4j77w9spTqt7qz3SHtX?=
 =?iso-8859-1?Q?D9wJHzIbtt/LQLHcstyYZFL0e8LBZwKwtaV64fzGB13P7d+Wxhq2M5Hf3r?=
 =?iso-8859-1?Q?VoA30eZxw22ws5SYikz8udHAhjinHo9dg7uv5KhKJOmLPZMNfrvuZ7JOj8?=
 =?iso-8859-1?Q?wT5Z3kZpHZaTDRTkjHG6aE5y5VAE9Br719KrnrZ94co989XoAYtBNKSnfr?=
 =?iso-8859-1?Q?buwHRqT9fZ4wpHTLlYy4eAQysu3bzIfPGWIRvg2GariDn/v5NJgpfFXBP/?=
 =?iso-8859-1?Q?YDn/A2w5h4F4guWl/087Rv6VWJ6F5peqqKs6ggewVKPbF+x6WBPNC7j9ZX?=
 =?iso-8859-1?Q?1tLB/3NmsUeVSPI6sHEymlg/AdAeCTfydxt1rt/tT1ssiLADbcqTIvRzuv?=
 =?iso-8859-1?Q?xxNp6ZYrNnZy6it3XDSD/xDQwXH/7tWz+vYPRJW1rGTXT37/POuBSduUcs?=
 =?iso-8859-1?Q?1OG5Y77dJg=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5817.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12be313b-6b92-4a03-4799-08de7a157604
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 17:42:52.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVGPN5bZskNWN6+FsoBjT1xGZ6jjtnhrNib7PkLT8UjRCgx2GAN9YaVU5a/MdUPYe4DSBM0SkYBTetpWDoPKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR15MB6933
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: j4gmLTAh1b7hN4zGYlo-LFwPUKw6b_f9
X-Proofpoint-GUID: j4gmLTAh1b7hN4zGYlo-LFwPUKw6b_f9
X-Authority-Analysis: v=2.4 cv=AYS83nXG c=1 sm=1 tr=0 ts=69a86f1f cx=c_pps
 a=kUUFNZ5xtaGOIvhvlLDUWQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=mjuSnDa_7q4-WsMlhKgA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NCBTYWx0ZWRfX45rMP2h3A2SF
 gdhYQTmTagJwMHTe/wUFZInaaCtc9XVEdDmjPjW595/9RB5OzSTOy6aBxAwfqb+CoFz10QtyJ1O
 yre6GQV/af/sFz56ml1UVJ6MfCXjoF3n5h6nEbKjbB80mIeStGgnHQA5eREAEMEDeMMURiRk5ox
 4Gj0rGrdRIM2d8t752kcoB7+FUFr8MyjOPI77UR9vtX6HZ8A+aWc2+gawe+qzNsB4HY07lQwRwi
 ZOoNZcXroTdBfgGKaBNqnq8NJ4PPBLqc28I7FKk/Oj+gEMRtJNt5iCuggktVbA1tCv/PNmBfll5
 10+gxGk8S83KHrAUYs+iGg+qrxj5C5mFigN6l0rBxn682ZLiVMh7NHrKF6T0UZuStQY7LQJzKRq
 940B94CwQcbrdIPLbnoST0bu+/wNFAd7GFO0VHeHfFy+/S3qntkFeXl7jQ7PXMBkwmMgVgP0v3i
 2hYetaaQEjzYorc8Kng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Rspamd-Queue-Id: 1AA05205536
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:dkim,SA1PR15MB5817.namprd15.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action




________________________________________
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Sent: Wednesday, March 4, 2026 8:25 AM
To: Wei Wang; netdev@vger.kernel.org; kuba@kernel.org; daniel.zahka@gmail.c=
om; Willem de Bruijn; David Wei; Andrew Lunn; David S. Miller; Eric Dumazet
Cc: Wei Wang
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of psp_d=
evice_get_locked

>
> Wei Wang wrote:
> > Add a place holder function called psp_device_get_locked_unpriv() which
> > will be used for commands that are unprivileged and are used for
> > exisiting commands like dev-dump, dev-get, rx-assoc, tx-assoc.
> > Commands including dev-add/delete/change-ntf, key-rotate would keep
> > using the privileged version.
> >
> > Following commit will be implementing the unprivileged version check.
>
> Can you define what unprivileged means concretely in this context.
>
> From the follow-on patch, it seems to only affect
> psp_dev_check_access, where it additionally allows some operations
> from other netns if that netns has an associated device.
>
> Can you give a concise reason for which operations to allow from
> another netns and which to deny. Also as forward looking heuristic for
> when new operations may be added.
>
> Btw minor typo in first sentence of next commit: associcate.

Thanks for the comment!
Yes. "unprivileged" means access from the main netns as well as any netns w=
ith an associated device and is used for commands like dev-dump, dev-get, r=
x-assoc, tx-assoc, which are user-controlled functionalities of the psd.
While "privileged" means access only from the main netns and is used for de=
v-add/delete/change-ntf, key-rotate. This is more like the admin-types of o=
perations of the psd.
I will update the commit msg in the next version to make it more clear.=

