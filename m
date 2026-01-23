Return-Path: <netdev+bounces-252599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENFsDF/bcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:22:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 976856F8DD
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E0FE3013715
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD5B3559E7;
	Fri, 23 Jan 2026 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SlJCpjtG"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0632C942;
	Fri, 23 Jan 2026 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134936; cv=fail; b=S8OvoVSMQpTmnnDx3LM2zoojQ1qEOw99y0DVhSaKbJ6D7O/dxhmv/t+JMj/aHMQgZszqNb/HqJ6Qk05NAGEb8Djge+GRTxMA1Vb2TW9Jj+pslJiotwOqzF/O4qA/c+B/8YfnnSGMapd80TCAeXyhxcn5htJqd1s0Kb93RwZoykM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134936; c=relaxed/simple;
	bh=8Abx9k3R1gyCBh4gaw5V2bzAXrZbNowGK0VOL/ZinHM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sEDvBS5JOyXCU2BFfHCt4gMlDQnH7xkUeu31G4GVl1rbf3Jqm9a02ofh4bFR0Vi5RKgsnsRpfVg0wpExv9hAgEDLjMhCGmCZ4r+OGaUzj2v0QDQ5LjnaihmEIRu3MzrVorGWwHT8zzu/BYesB7vCFTBjphCGtdKAKjtzh6L0eHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SlJCpjtG; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEtHKK9HYoZKPDhAX+HiVrSuHu4piZifLA6j+uruVdgCYzOEnwDk/xpl8eFJGskf2heMPNdFYXjo6o3jWtsH2dBQFOU92EEhn2Oc0eXySRMODKkfYgqR2FshYnePeFVw155hzWUKPExIoTrWGOHiJc8weU70XjlF4Kn6xSogTfOJ1qF3+okfXDymmVGfU8amGJA0YbzLZYr4PH5+4EhbjaxjCcSbpNrzvvacIHv52+qTzzSuRnz+xgDwTGzgKnEKcdIVQ6IX7Q+ypjgj3bxypfYzjwDZwam0Tkbit+mxTK/RdZCkFkR53RnDo5zAQ/ElOkOWKCyxP70VsxvsYpqRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c3j3SkiSYwsxDyF3qTaxTArgDxHZV/e+mpLPpuG4fE=;
 b=KHYuovJkuxD2dpMGMMZxKqb0QtvpzoOz/19Qfa4S8SHr/jFXzzrHol1evxCwBiXnu9ISbEZpCHIR1KU3YdhoIdjHj7fFMRsw+5sEHveN4ug1UKovmH0rHNwTilUBhP50JCgKeNwdZsZE1NpLmIwTEpOBKsz6paRik8ZX8UE36ZwA8z/tKiDEBqDOJ0SPvotqXNJSguUBaeeKarUttI/X14efoAI/V7wTgqDDaS7qwCTpte6PMOEp4TmQzZY3OL8NI548tQPOjMsc/IsZVBMk6XUwO6qGUprT6hf7tcr2JAEYgN5igWOfZJqYLA9y9fkaY+p2QECVR4HutiP5Zfks9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c3j3SkiSYwsxDyF3qTaxTArgDxHZV/e+mpLPpuG4fE=;
 b=SlJCpjtGiK0Psukj0nq8uJ7E+61t3lM/mwVvuDMl/UC7sR0pthgFiNr8Eqh6HeRYC2OKgu198pB3DCm+UTVZCq/1z5dma23cJTk2N6p6DkQZ1tnfPFJefurUtT9qmKC+fbDU2b8VGHf0WrDMpCYd8c8/0g0S0uHIIcJqMIG1j6Dr0dC3LIARfnY1lE/8BeogPRyY5Lz0yHQuXublB1DHKRPdUbaryWhqfw+EOMD4gHbHO8XonZgd8hKRr40JspHFfKo7GXKPOtAhk/dYNuUi6S0AWkR5wLGN3QC2v1repUmHSborB5OHGjyo7osVNTtGzKyNmt9EahqMmkYwW/ZJHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 00/15] net: fec: improve XDP copy mode and add AF_XDP zero-copy support
Date: Fri, 23 Jan 2026 10:21:28 +0800
Message-Id: <20260123022143.4121797-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 267cfe5b-04f0-46dc-c427-08de5a263205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?De+IiEMVt0A3mIbf3VGYkbpMwf7GhfVY4lx8u2fkDrHTXN3NpWqlimF6BYVa?=
 =?us-ascii?Q?O2h9AB56cvhf9UN1mpe7suz29LGslYaBUqqho+MhW5gzQtrOEaShPdHKIbyD?=
 =?us-ascii?Q?zImst+0p7tXxv7BP6TtTk37hsrnArRzBgGoPiX+QuGSQxbjITm3r74wSATGc?=
 =?us-ascii?Q?6qODn+BbWqfJ5CevDCP21ZibLuYFXt3kS7hcbOklwKry/Ors7WZwatgAWqVM?=
 =?us-ascii?Q?s+2JHp/Sk9C+GcMMqWIZLIpYTNG8HTrhqBBgXi0ocRixBEzOpy1RZmw9KZOF?=
 =?us-ascii?Q?0IvJIhhMTgxpk+5TDJwMHPtdXijaoRadRVVCwtus8PVl9fhSIxx9wFifCWvP?=
 =?us-ascii?Q?YRo/vWAvJPezE6W0VO261Douh05RxVZx0PEY7cCuxh8cttdG2gYUoDCVM2NI?=
 =?us-ascii?Q?oM59RqDoCZePCXvl19n1w+FndBY2gcg8JP9tW0jDXIMnXA5QZtRRTQJn2mtS?=
 =?us-ascii?Q?ObyzoifRtkgjJG6LCc3qrxIZsytkI8rml7ZlCSqgT7equdWI+tPEQ3Ig2a5H?=
 =?us-ascii?Q?VZ8f31SgsBwGOIrl+uniB9FxkCQ4xjDto7Jw2PDUn4GODAKNiX0530BWjyDW?=
 =?us-ascii?Q?C7VtPGqofwdRQdx1zn/mI99s8n3zkXEDhu3zmSzmEDq9Dam7AaYGiyUFHIAt?=
 =?us-ascii?Q?CQQxriGsUzhFecYjEoybOcBAEyenQFn66hBk21kMotVhgYnlE+mM3WuNR+Fy?=
 =?us-ascii?Q?pz4Q9Gyim5wTwMmec5DTL3AUcxcohaXoW5NqFnfcVYhBNrqRNkLRIbgT46T/?=
 =?us-ascii?Q?/2LjNCcGv3ev013CiSA0MNNPOcx09cUucM7tBHJeTpJJZBqREpyeR8O8r+1o?=
 =?us-ascii?Q?Fx9DY5cN/zL5M3QjAVfOFhwT1BIWLGnT9N1MMlZQtjtlFvA8F1bIOgy55y+j?=
 =?us-ascii?Q?EILxCkNQi2a4g2pNcsntMxCWHmM2jFjeKyywwqWpGQlJoDNT5ljOkoGG7Hl+?=
 =?us-ascii?Q?66EZDNl8fo4Ev+1f+9KOtC0M6fzfmnL+k/vihVWKwlz/TddXqy/Oiw+4z2jL?=
 =?us-ascii?Q?UKijgxrFUtQN0YLja+8UvLmdhKLYeGvVdF07JzDoO02azA2DUl7989GzOG9x?=
 =?us-ascii?Q?2L1STsIqKoJ7DQjpe5YFVIOvAX+Gt+ehtyxMIpsDSrlnynOzqXCGLSR+0pMn?=
 =?us-ascii?Q?FpLF20KGXvQ9ZtQR4mWVvckez6q1d9c+dCm6kthBDwtWADgbTlNQ7b8p8bsG?=
 =?us-ascii?Q?YYuX3dDIYhyLSLrVN09mhgyW2XkYA3Muaw260M7Z2XIoNQWIpszvrrxxG8jU?=
 =?us-ascii?Q?DG/D3qoyguzBf1tRw2nBXzflLn4QxJo3VnLq8Xc5zjLag7rQkDYxpC6ABA1v?=
 =?us-ascii?Q?v3TjklUO7u40IdH/fwlRC4ME7ajZIZGxhwoc04MExhZ32MMMpmJFr95FppqJ?=
 =?us-ascii?Q?+QlGRqyFHNcAYP0OIS0bf9MpFR9xPEVo6+j+wr+7632mEya/QZ8mb85K7LHy?=
 =?us-ascii?Q?CR3X+rAVCxxSsQMYHZ7qtC2HFJgFIKIci70/3dkrFgCr4vW4HxzDzcQs44VT?=
 =?us-ascii?Q?6nwVFMnvHyERw+qIk6OxzaGWSs6zkQ87lkgIc+aZ6ZTyowKxYjWigYQfrA73?=
 =?us-ascii?Q?hjCaLxlZ7gviYZDUBXA6mV0wai5yX8sZtMUpnPLuL5GEUHJzDJfx0zM7ndMW?=
 =?us-ascii?Q?mxLLee7lGrBom1FQU0gM1mc5EagIVTrtBobLZ75AVb3K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OaY5QeZfVJUfbiEDhq5/LtBGKBEaTof6/RfvE5u5B5LcfPKxt0P+QmdNI1kj?=
 =?us-ascii?Q?4sD20feisJMXlYp400jMR8cUg1Tw0/CVjEoJ6o/cDHA1PpH8a7IheHS4ZCDy?=
 =?us-ascii?Q?URONfu3B2I1oKSTPuVcemrfF1o2HmjITcBgiH/NoRutr9YixD8BZ8trnwcrU?=
 =?us-ascii?Q?nhjc451EhBs2i9ijtlYHHApvc/MYS1jPjN8IfeJF6o9JSNOV2wFalhIioEBt?=
 =?us-ascii?Q?r/Vl1OiAnDYwB4sPmxrfzMYNReOik937a4MwPEcVolauEaNeGNWN72EQQyL8?=
 =?us-ascii?Q?pXHNDt4Inq8xStg0bNcJC6N/6yiKZBrdBt+uKIzjl+/ECYaX/aAOxyMmOWrR?=
 =?us-ascii?Q?502H4IkpnQ3wiQKSMTMePjyUBpoyU4YR8KCe9w6Jr3uWo4//YLtCFQ3nC/L8?=
 =?us-ascii?Q?NNMVrbLomety3tNCU6ZGE5+t5FoUrmSK1ixvvkpYIfXRZJ2i/j/qlreixvPx?=
 =?us-ascii?Q?lYPSWslKl1r5YczrtyLzNgBFeFMxCfz6Nz1jCbXt4gEVKTG0aUgt1z7dTJCa?=
 =?us-ascii?Q?gnoCdhorqv1jl1hawBlqZ18VPBwctbi7Oiav6Ki9xplbludQKQPR+rQT/k/D?=
 =?us-ascii?Q?Rr3KM+601yUJuyEAJZnDFJOjejY+T9dQcgLHp7D61F5dST0FSR0jfCSFexhX?=
 =?us-ascii?Q?MnL9b2ElJJ3IqPW0xs+fmkX/C8trdTMYArjC3i4oOJbitEHziyWjp09LxXBy?=
 =?us-ascii?Q?22ftZ49gMlHQoJDMduNtzGofZ1dSEd6jsia9da+jCZtpCbx6W94nBpQhSaN6?=
 =?us-ascii?Q?XUHNFC3Xdr6lEEKkIaPcziDKLJ3PRtxdyOR5VRZOAHiwOtkNIyB1WUkw5j2F?=
 =?us-ascii?Q?S8jjgio0BBJPofnBbQW7uAvLC0qCwPL2S04HHvrbR+S5pu0xPTiK7kQ7HPvP?=
 =?us-ascii?Q?APTB9kbd0avlAjNWDxTpcQhRMnO7Gus+NEgCNpLRBQwRTy2C3e4z+T6vKmrE?=
 =?us-ascii?Q?jqX8u2DszsKamltU7Vg927EEXkLhTqWZ0ez5oJayjgSegdY3UcMW9laj8ICZ?=
 =?us-ascii?Q?6aEd9b2w2hrWOrIZ89YlVfDXS7qmpW/j3CmaDvOogDa6NgsmIQleyq14BJh8?=
 =?us-ascii?Q?9GqsTKaQgNM1rUxjROoACzOQNjqQkdKWTsJaVdGXE5gIpfqSstHmFGoKr+S8?=
 =?us-ascii?Q?3Ab+teip3vE6WLER+HxPPl7GE7lbDu7wCNGTPi7EehHqTnnc9TzVbhBTsNv8?=
 =?us-ascii?Q?jzlCTqB2PJfqMJrMz7Ou6/y7ChevBhdg/mAV/ph/5lvnYKImlJvl2p/9bT6P?=
 =?us-ascii?Q?fmXkSxAu8KrAfyCHBbh5OS96ejJt3brVSEXGK2Su1K2jnSqYzJ/wVQrPRdQE?=
 =?us-ascii?Q?/tBzIuNTWex1PmA8la40XIhBm3S49UzAEHIkjgBKNuhZ+UGNZaslCB89pVI1?=
 =?us-ascii?Q?yZFYbGnY+2lfiFpV1QkcPljxASZUltRYQWdA4fgjK210XQ3ypSjpXTj4miqj?=
 =?us-ascii?Q?qcopgW7GNwtfyRg4MK8QKbO0q4e9kWPpgc8W7x2yC1G7Or4wMlOlbC29GM5l?=
 =?us-ascii?Q?PoPhcQ5wyPuAZQ9P/Ia0FvXmusDtZTi77llrzRcrhurxGYherbrbtc5oMtXj?=
 =?us-ascii?Q?Li0VU2V4yOEWD2qaiVBc9JtlcpjjkP89mpl+LnDEipVWFlbQ7gSO4+v5dVzr?=
 =?us-ascii?Q?tmam2p2tRnDnb05LaDjOzwNH+XBUTbdInyZ0cA64Cvcz0QkaFSaVP6C3iuMv?=
 =?us-ascii?Q?fOkmCEPn9pFSLRBaGM6ZfkXrKfLJLvmruYPbIFj58z/HEZxn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267cfe5b-04f0-46dc-c427-08de5a263205
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:02.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pBUV9NCeG7D6r0cGCQgr35ZhtVt79d1ItGj/QAUbpKw3fNXaMiXHlm+fUkoVtoqZWbW2pas3K3Gtm7WMXec1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252599-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: 976856F8DD
X-Rspamd-Action: no action

This patch set optimizes the XDP copy mode logic as follows.

1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
frames.

2. For TX XDP packets, using the batch sending method to avoid frequent
MMIO writes.

3. Use the switch statement to check the tx_buf type instead of the
if...else... statement, making the cleanup logic of TX BD ring cleared
and more efficient.

We compared the performance of XDP copy mode before and after applying
this patch set, and the results show that the performance has improved.

Before applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   425,778 rx/s                  0 err,drop/s
Summary                   426,042 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   698,351 rx/s                  0 err/s
Summary                   701,882 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   210,348 rx/s                  0 err,drop/s
Summary                   210,016 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                354,407 rx/s                  0 err,drop/s      354,401 xmit/s
eth0->eth0                350,381 rx/s                  0 err,drop/s      350,389 xmit/s

This patch set also addes the AF_XDP zero-copy support, and we tested
the performance on i.MX93 platform with xdpsock tool. The following is
the performance comparison of copy mode and zero-copy mode. It can be
seen that the performance of zero-copy mode is better than that of copy
mode.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

---
v4:
1. Remove the unneeded semicolon in fec_enet_bd_init()
v3 link: https://lore.kernel.org/imx/20260121033357.3261464-1-wei.fang@nxp.com/
v3:
1. Fix build warning due to missing break for the FEC_TXBUF_T_XSK_TX
branch in fec_enet_bd_init().
2. Add new patch 7, which is separated from patch 6
3. Collect Reviewed-by tags.
v2 link: https://lore.kernel.org/imx/20260116074027.1603841-1-wei.fang@nxp.com/
v2:
1. Improve the commit message
2. Remove the unused variable dma from fec_enet_rx_queue_xsk() to fix
the build warning
3. Remove fec_txq_trigger_xmit() from fec_enet_xsk_tx_xmit()
4. Separate some new patches, patch 4, 8, 13.
5. Collect Reviewed-by tags.
vl link: https://lore.kernel.org/imx/20260113032939.3705137-1-wei.fang@nxp.com/
---

Wei Fang (15):
  net: fec: add fec_txq_trigger_xmit() helper
  net: fec: add fec_rx_error_check() to check RX errors
  net: fec: add rx_shift to indicate the extra bytes padded in front of
    RX frame
  net: fec: add fec_build_skb() to build a skb
  net: fec: improve fec_enet_rx_queue()
  net: fec: add fec_enet_rx_queue_xdp() for XDP path
  net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
  net: fec: transmit XDP frames in bulk
  net: fec: remove unnecessary NULL pointer check when clearing TX BD
    ring
  net: fec: use switch statement to check the type of tx_buf
  net: fec: remove the size parameter from fec_enet_create_page_pool()
  net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
  net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page
    pool
  net: fec: improve fec_enet_tx_queue()
  net: fec: add AF_XDP zero-copy support

 drivers/net/ethernet/freescale/fec.h      |   14 +-
 drivers/net/ethernet/freescale/fec_main.c | 1454 +++++++++++++++------
 2 files changed, 1079 insertions(+), 389 deletions(-)

-- 
2.34.1


