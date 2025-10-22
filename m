Return-Path: <netdev+bounces-231694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC774BFCB42
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83E964FE8F1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835E34B402;
	Wed, 22 Oct 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="fX4+oZfw";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="bgdOX2mO"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay31-hz2-if1.hornetsecurity.com (mx-relay31-hz2-if1.hornetsecurity.com [94.100.137.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8482ED161
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144788; cv=fail; b=BtJ+YGx0L9py4lMOhXE2kSqUKIYetlQTWYIn88SyfeROkX+O56pT2plM+bRRq/540m5/IOVICN/Fh+qbGYsZ8fIEOU+zF+2EfC5DmqLNvTtQazmzkXs8ZlRj/av6arcABOI+25W/mW56klu9cE6bocLU+/Wxdc5OeqGNYHipm1s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144788; c=relaxed/simple;
	bh=xxrA8Bi8VfqrMY2IWvxGC5nJMMdtV4Wqub90OhELMDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Disposition:
	 In-Reply-To:MIME-Version:Content-Type; b=T9k8zZ9ewbyX/hw+Fhune7oXjYbrno0gBqWdT+HooTG0qH0LU3v9vta1xsUQvMTHUmyHC5NzLpp3uPLrt//KHqjDq9rY/mHDbnGj28GXfV+Bhpdw/Ra8c8+k+piT4np9H0hei7XQx3Set0bQ7V1DXLoDcki630x2u/NJwMtojGI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=fX4+oZfw reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=bgdOX2mO; arc=fail smtp.client-ip=94.100.137.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate31-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.72.115, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr02cu008.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=3fXZnt0fpuoiXlTZy6zb0g+1Aw3OUcJuSl0jhOPXgIg=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761144767;
 b=JycbaGISCPgYNyk4M1Kb2XSON/Yhfq0AToDYlhsZ6BwR62UGjsfwmHmWFvMazp+RVZ+pQ3Yx
 VY7KBF7Z7C0jLQM8VS432VBm462qMjgOt6mh/+fdpJUPcmEKEEUmNp9T5DyFcr5thOOH23ce/Rw
 NV4O2paZYAKdMiQLeZGUG1BYHMP8EdHX2TjwmTPpjBPukxJV0iWi4PSezLQcS7bc+47klMekTu/
 gZAmX7/G+zpBV9YhMiPrXVb0hrpg0M8DHv6LQUKSiyQAon7MN0cj8mooKlMUOqlwdntdeiM3tX4
 kY9nVTXmztVFWc2NQDjChyivSDCKvlCb5rd2p/oiEKTYQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761144767;
 b=Imen3GF109E4VcOcHuejtKua0kdAaILi7Y1sKd2gA+MY4vBI9HnniVyT4dznGj6QIbXtobLk
 4B5IDRk1asjXRECIZPEU7j4e4VaTqh9VwszKpAC1CtIANa537vwfF79R/QofHr4mDxEuiU1cjU6
 9xgmDTb7VI9dOd4Bo10fLLHDdmtQz5joZJoT3+86HryRfXenq09Q1nXc3lMz4RQuJPfyYDQDy/i
 4qYx94L5D1K/Mn5YDKvdOmupMyZYVz7fU/qDuu6gqNsvYd0Gl1CYsQU7ge8T/Tqyfi2DdeI3etd
 aQDPosum1T1x8LaE0v78wP3eqpUXehDBbJTnDZOZCZTSw==
Received: from mail-westeuropeazon11023115.outbound.protection.outlook.com ([52.101.72.115]) by mx-relay31-hz2.antispameurope.com;
 Wed, 22 Oct 2025 16:52:47 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/P6FvKDAVSU7N5By7eTberuVk6dsNlHhXeaeSjqDQcsj/ayiraVqh9i1z/dcw/1OCwJokd/GXWNaRt1BwVoLha477EkkFvF+RS3m4Iz9Da+5Kjolzz67vJI6MhzjAVIXpRwwfq+KTDIlqKWqe+FNiZ2iTg9sq7Qxrv/62YCbCEyVbOIGvLMbkeIDCYnkMp0gY1mMSuZgFIEAS9Pe0X/f3G0LxYld/tjFiEgk6MUTph8ORQuWWWbtva08/uFN0OyleqPIYtqNX7ry8ZYDt5ve8qNrJAOBLOFxrl+1moT2evqSRTwT5Z9k2T7SxdT9Lvflj+W9a2yxJG00DYffmUgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYNYUEK/gScQ8Pc2vbK4NJgRCZmsQ3D3ihCaJe81cx4=;
 b=npUp+U79Y7hNy6rO3XINfUqeUPxiHOW/C37W1dCDIvW/WGVDi7+CuPUVLP83F/lwZKPDF6hhSVoQTCdXZBECd+jrKuNtKQV57z8BwM8nnybc8sbcCKlRKFpj1jcm5PvIQMcgIgLyilUhfrEVtneMRBrDD30dGeBZJk4xoxvtFmxZ27oe/NZ5tPNPCbhe6dWvARPFjm/86OTTyoOnU/M4FW2nFL54X6al+5O+BzQBbFmwWk9smgQZH1jtmkv87PJqLSFCyKSlvFN4kIcX+uk25Q+Vhkcb0hUQ5zMIHZRFcUAQnUJrYSozPuF59Qz3pHg6klaz5pofQweE1jQxnjlO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYNYUEK/gScQ8Pc2vbK4NJgRCZmsQ3D3ihCaJe81cx4=;
 b=fX4+oZfwcrJfCZPjgdCziGXuVTqZlXHvYk72jk5+KEzyqUD78qCKynsxAi0sxnj6imf/z9D/UVzzCx6GE86wUjE0C3gEV8vyp0c6rnIcP6PmTe7fQJsT/eAjJRHEUDZfUKhiScMUIc56NsA4dOd+/U1Gv+kd7SbV2gMAyPRiOkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by AM8PR10MB4036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:52:36 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:52:36 +0000
Date: Wed, 22 Oct 2025 16:52:33 +0200
From: Johannes Eigner <johannes.eigner@a-eberle.de>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH ethtool 1/2] sfpid: Fix JSON output of SFP diagnostics
Message-ID: <aPjvsU-YEwdIyYha@PC-LX-JohEi>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
 <20251021-fix-module-info-json-v1-1-01d61b1973f6@a-eberle.de>
 <DM6PR12MB451638CD4E7B3DC33F16E58AD8F3A@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DM6PR12MB451638CD4E7B3DC33F16E58AD8F3A@DM6PR12MB4516.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|AM8PR10MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: f987cd77-4996-4da1-6435-08de117aa35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WS90L1F0MmEyalBLaXRVa3ovY0oxSG9nSE1QbTRhNkY3bEQvTytDUDV5SHB1?=
 =?utf-8?B?YUhHYVl6TXIyQm1ESGV4ajhMWDVvUjNVaUtpbjZjMjRidngxOUpzcW1ZbU1D?=
 =?utf-8?B?S0pVZWJ5NnlXbzhCNEFWU2ptMEdNTmpkYzBSZlk2R2ZTRlc5bDBNNUpKV2FP?=
 =?utf-8?B?WXNjZnRXeElSdk5JSmNwVkFDc3pwRm9GbEczK3dxU25SZkFSSzFkcS9EdFBB?=
 =?utf-8?B?TkNmRGRUaFFCYmo1Nm11NFB3c1JPVnJkTWRrbjFLSndCK0VEd2VmV2h1bTJD?=
 =?utf-8?B?UjB5UmZkem0wMEJyaWl4U2lBN01RYmFwbWZ1UERxMVFMaXVUUDhObHBLazRJ?=
 =?utf-8?B?SEFaNmJFVGJ3V3lJSTNienI3R0tXcjNHRzVPWmp2bXNzUnUrVStxQ1JzbFdm?=
 =?utf-8?B?NlI2Sm5VMUNKZXFZV0tic3VZSjU4QUxwMG9jUGJBVHA4M1A5cmczc1NoU2sx?=
 =?utf-8?B?b0FqeEF4L1dBazUvbXVjZFdYSnhzOVhQK2xrK0hvbmxZc0Nxc3FoeC94SnJY?=
 =?utf-8?B?QjFuVDFYNUphcmsxNVpJZ1pmK2xhWDZZcjdReGVNekJ2aVdrbXhaUkVTbWRm?=
 =?utf-8?B?Zk02Tm9uWC82cXJLTnJpR0d5UUtQNUNLcTNZb3lCUkRhSVptNmNFYlp0Yllk?=
 =?utf-8?B?eElPeEtoRytwZS9UUTB2eVhQY2RsYmNnSDNqclRtN1hzL3NpZjdUMzJCZUl4?=
 =?utf-8?B?M2hYSjRZb0pLYVRlYm50bTlsanVQaDJCY0hWSWozazU1K2k3UFRsdDgzRFdu?=
 =?utf-8?B?OWd3T200cTROdndFdzJNdk9WU04zcWJYcCtHQ1lYZkt2OHRlSFJySjV2dE1M?=
 =?utf-8?B?d3kzQ3IrTXltTSs4b1ZERlgrY3l5Q095cVJSK0llekt0MEt6RWZxczFDV3lu?=
 =?utf-8?B?M1AwalJ5a2xXWVdHTkFybkpMdjVlbzFhSlU5dnNOK21VeVlJL09zMDRyNHNT?=
 =?utf-8?B?TVplRHNZNnZWUnUzZGxPYWFXZnBKNDBlcnJjeEVDLzlFenY3K2dTVCtXNElh?=
 =?utf-8?B?TkFCQ1dtUG5weTIxV1BsYzM0UVVrejZmbUhiY0NQd3VDWFBLZzA1S1VETk14?=
 =?utf-8?B?VEw0VmpjaXdvTTZjRTRRQjk1R2wwdkRVVTZXdW9PMGVPWjY0K1JOVUlKY2xE?=
 =?utf-8?B?NDdEalBYN2xYZ1dsRndOWXFleUtrSFBCS3Qvd1k5eEszU2xpTFRJbmRxSnBi?=
 =?utf-8?B?NG1vQ1RUQlRoU2dqbnRGNDlubWhNVlpQL3NFUEZtU0xQVWhWNklSN2RwQ3Ar?=
 =?utf-8?B?VzhvT3V5QW9pRytqbk56MEJBZnNVWG9xbUl4YzRJY0xiYUE5eE03Tjg5YjJq?=
 =?utf-8?B?QWdreEozS2JZbVRyY3JTZGJpOHJlZTBSeTlYMnI4ZjM5NzNtQVFZOENrSzl6?=
 =?utf-8?B?N0tvRjlCaDJOVE9PNlFVbzNnTG80MmxCQlVCN3BNNXZHa0dEV0p2L0xhZkdR?=
 =?utf-8?B?MjNRVmJUR3dZVG1jSHg2aWdaTDFqS2NoaEM0SFAxc2NnOTQ0dERUVytic1Qz?=
 =?utf-8?B?c044aHlranpxeERMVTZqL1QrK3hJYitmZVQ1b29mL1hqVEh1amI0dWlwNnpq?=
 =?utf-8?B?Y2EzYk9qOXNJOGo2UlhWLzdNd2NhbWt1dkgwcElXVVVBRktkcHd0S3o5ZUFR?=
 =?utf-8?B?Y21EU01XTTdCYWRaMjZxN2daSTduN012TmhrQmZVTG40QVBhVkFLWm5DaHpT?=
 =?utf-8?B?ZnFLUkF2eHI4N2JQUCt6MkZrcmpla05xM1gwM2g3SU44WDBucHNVOC9ESWRO?=
 =?utf-8?B?TTRtaEUxSkFGTVYyRldTOVlOR1dyamJwdVpISVNXRmg2VjVNaDNtbVFnZ1o5?=
 =?utf-8?B?ckp4b285RFJyU3ZnTjNXNzVuaUJwUTA4eFd2ZFI1QUdjK1pHK1UrQVYvWVJm?=
 =?utf-8?B?dkpOU2ZUQ1hEK2JTUDdtZ1JmblhHb0xvUHg1ZEpYZlJFWUN0M2pkMnRRTHNs?=
 =?utf-8?Q?7V8VK4qdCjvxTLtGNaa8TJ7tM5agai3V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTAvbEJFTWs1L1liVXF3bHdRSEtOMmhtSXhXRDhiWGlkMi9iVEFuYkpsd1Vv?=
 =?utf-8?B?RGdwU0hlRk52L1RBcWRYQktQb1M0SnU0d0tYaU5PbjJseUVSaDYrakJBRTRT?=
 =?utf-8?B?OXRnaGxDMVRKb1ptQWpBSUNyMjd0SG0yN0lZVjN1SDV6TEc1ZTdpVCtwQ1hC?=
 =?utf-8?B?YnAyTzhWRTlyZGk3THNCS00rVjlMSU1IRGwzK2ViUXZ0aG1CNXovN2pGVTV3?=
 =?utf-8?B?ZXdsdVc5bXJzb1dlNzN2MnN1ZmtabWVEQkpkUCtVM2lKcmVNMmhkVkFkcGlF?=
 =?utf-8?B?b2FGcUNURE5FdEhoQy9yb3hWemVPWnI5cjJYUDIvYWVxVzRPK3k0U282Q2Jz?=
 =?utf-8?B?U21iU1VKUFNJOWk1WVowbUNQNkUxbFluZVB3Y1ozRjE5aHRNMW92cVB3UC9h?=
 =?utf-8?B?bDB3K1ZVdnpTemMrNkpUNlp4MkF4VWxPWHc5bVByZ05XVmpmZnB3YktYbmZM?=
 =?utf-8?B?REJ1b1FYaU5ib3pTMHVTRFdHWkNSZGQyZjZ6b20wN2V1OFdpOVgyY0tPMVp3?=
 =?utf-8?B?ZU1DWFBkbnpqa09kMERubndadjI5WktYVDFDRXRXVjQrYkdIVFlVM09ZeGcv?=
 =?utf-8?B?L3kxTU9ML05RTy9VOU45YUlqaGtIVzhDUGJCaG1GcWwxR2pzRGp3aVFmSWFs?=
 =?utf-8?B?S2EzUitXblp0c1hOQkcrMDFGSTQrRFFJL0RvSmxCMllZZ1NwTU4wMmFQekIw?=
 =?utf-8?B?YkJRTUFJTGVkR1kxQkZNUDNTUGYxYlMzSnNYRGhYeXpmRjRaNWt2NnVDOTVx?=
 =?utf-8?B?ZzRYcUNYWjZ1UktKMVdBQWd6b0ZzV2FaTUxUQm1sSk8wcjNhUFdCZ2lSOE9r?=
 =?utf-8?B?Q3FiYU50czU1R0xlRnd4c1hnYSszUmdyUUdhSFVISUFUZXhFNzJENGE4WnBC?=
 =?utf-8?B?dUo2dXgvVzYzajIxbGlWczNRWkhoUUFHZ2toVDFRbEM3cjlVbFQ5cjNGazRZ?=
 =?utf-8?B?bVl1WVJzaEorMDBrK1BncktkWENBQmhndnJ6UnovdGVZaXBjbC95Q1FKQy9x?=
 =?utf-8?B?cG5HUlNYalRHWXkvQVFIbHJSZUFCcEpWVE1mWm8yWkhSRmpVMm5sVEVMb2Vu?=
 =?utf-8?B?RlQ4QXZQSjU1OFJONjI5S3VMR3k3by80Y3psQnNVVVdRQUR0Wk1RbC9pajlS?=
 =?utf-8?B?WlU2MEZ0ai8xS0xqZEhQRjVvYkZmay93cXZ6SkVnZXNsQVI4MFpCYmVKL3dD?=
 =?utf-8?B?aVhmWmduMWlwZUo5ZUxUUW1oZEJ5M25UdjhEWVQ2Wlcvck56ZHJWTmljajFy?=
 =?utf-8?B?Y3ZiQlRNVGJXY3BtRktDN2dXdTNaTEFuM05wcmRydVd6Y0NCZDgxaEo0Rity?=
 =?utf-8?B?bThtVCtWbWNpbThIMFhBcmlXWHZ4QmY3L2F6TTZlbDRZcTJ6c2JoN2Q0RldN?=
 =?utf-8?B?UFVDMzRsUjhwV3JPeG5BVVZteUxKL3NSYXhNVTM4cmFFRHZBdm9tTzVCd1Nt?=
 =?utf-8?B?d2s4NUZSeE5lNzkxNEJtR1I5MjlvWFBua1lnOHNORzYwYXlkdTNsUHEzalJt?=
 =?utf-8?B?aUNGZURGMnhib1Bvb0ttQUM5QS80TUlTakxyd0JYeU05MTNvTlNvM1hhUmhN?=
 =?utf-8?B?WXlKcDRhZ284Z1NaOUNzdG1ZSWpuUEhuVWZQYk1mcjNVdThaZWJ3aEtOc3d2?=
 =?utf-8?B?dTYyUXdMWHZ3S1E3MmdpWmZ6TDhTZHhDWXI5WnhuTmQveFFTRW9QRStvL3Np?=
 =?utf-8?B?S0w1K3hvUVNxOVBRd0MxaFcyS1pHcTlQTFlYOGlDUElGcVVMMEkwK1RaM1k5?=
 =?utf-8?B?NEtwT3V6VjRlcVlScU10ZWRqcnRzeGZKU3dOd1ZUUFRnTkRrZDNOd1J4SWtV?=
 =?utf-8?B?V3M3ZnhZdlF5NmZIZ2NUazNMTFZqblZ6WjQwdjhIZFJlQm9yVng1L0oyRkpo?=
 =?utf-8?B?Y3lSODFwcTB3RjExNTlrelRCYjA2K0JBckJSeE5KSkpTSVhiSk9Bd0JiQ1VP?=
 =?utf-8?B?U2dHaUl4aHBVbTl2dms4TWt5aWU2Y01kQ09GVW1zSWdlQ095aXk3SG5lWWxB?=
 =?utf-8?B?ZnBKWWY2eThaK25XeFlQTzRmWFQ3K1VkSlZ3OXA3M3BMdXhDSEVIajdKQ0JJ?=
 =?utf-8?B?bHZUUlpXN2g4VVhYYXdNNU1uM2RCWDBlc3JzRzRoU2h3VWlHTWViM0tVVURO?=
 =?utf-8?B?Q2ROMzlmRkp1SmxPWDlxTnFsNmppZjJwZjhlUFlYRm1zR3krWngrdjQ4ZkpF?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f987cd77-4996-4da1-6435-08de117aa35e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:52:36.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEBx/uypLic8HtXYVyrCaIeB4cj4a5NHmZ/AvsoaH1UFmn0u5bxRYqtBNgZzMzVmxQsC2kaKs+U66uy7ONIqOca+Unp8V5nRStitIFdUj9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4036
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----EC0AF7DDF4258B7AC197367143D8F3F2"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay31-hz2.antispameurope.com with 4csBwP5B7pzGq7L
X-cloud-security-connect: mail-westeuropeazon11023115.outbound.protection.outlook.com[52.101.72.115], TLS=1, IP=52.101.72.115
X-cloud-security-Digest:a3a7d0ecc1288023b3ef27e9ff8006c8
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.875
DKIM-Signature: a=rsa-sha256;
 bh=3fXZnt0fpuoiXlTZy6zb0g+1Aw3OUcJuSl0jhOPXgIg=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761144766; v=1;
 b=bgdOX2mO87U8yo4EuqlqauNGTfj4McadnpC0Xfw1yZq0nsKvFJ2zyOzMgVFY8Al0sMmBztYI
 aPfH3ai/sD3o58Zf8EtOa7xgzuqqzXPJ9qus3KguAXg9Q0r738ioKwbwlfMwPHfd8qcnOQ/rptq
 bRFvkye5Af8Y3uNUYOThlbQkhgp9kNm1WhdnFv7MeBg4dUaAKyOsawbEgeD8HInQ6EHeacVcmvB
 u4nsuIG+i45GdBUOUAR0v2w5jKe4b+8hcPB0d6yk8FmJKK44ElcJFHNWTSNXQDJsIGvdEhWM/Xp
 Z+5lK3nF2iA/vyrfJ3uCU7+khzqTFm1XZTQhQ/l9dyjlg==

This is an S/MIME signed message

------EC0AF7DDF4258B7AC197367143D8F3F2
To: Danielle Ratson <danieller@nvidia.com>
Subject: Re: [PATCH ethtool 1/2] sfpid: Fix JSON output of SFP diagnostics
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Date: Wed, 22 Oct 2025 16:52:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Am Wed, Oct 22, 2025 at 12:55:45PM +0000 schrieb Danielle Ratson:
> > -----Original Message-----
> > From: Johannes Eigner <johannes.eigner@a-eberle.de>
> > Sent: Tuesday, 21 October 2025 17:00
> > To: netdev@vger.kernel.org
> > Cc: Michal Kubecek <mkubecek@suse.cz>; Danielle Ratson
> > <danieller@nvidia.com>; Stephan Wurm <stephan.wurm@a-eberle.de>;
> > Johannes Eigner <johannes.eigner@a-eberle.de>
> > Subject: [PATCH ethtool 1/2] sfpid: Fix JSON output of SFP diagnostics
> > 
> > Close and delete JSON object only after output of SFP diagnostics so
> > that it is also JSON formatted. If the JSON object is deleted too early,
> > some of the output will not be JSON formatted, resulting in mixed output
> > formats.
> > 
> > Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
> 
> Hi Johannes,
> 
> Please add a fixes tag.
> 

Will update patches with fixes tags.

> > ---
> >  sfpid.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sfpid.c b/sfpid.c
> > index 62acb4f..5216ce3 100644
> > --- a/sfpid.c
> > +++ b/sfpid.c
> > @@ -520,8 +520,6 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
> >  	new_json_obj(ctx->json);
> >  	open_json_object(NULL);
> >  	sff8079_show_all_common(buf);
> > -	close_json_object();
> > -	delete_json_obj();
> > 
> >  	/* Finish if A2h page is not present */
> >  	if (!(buf[92] & (1 << 6)))
> > @@ -537,6 +535,8 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
> > 
> >  	sff8472_show_all(buf);
> >  out:
> > +	close_json_object();
> > +	delete_json_obj();
> 
> If sff8079_get_eeprom_page() fails, then close_json_object() and delete_json_object() lines will be called although the object was never opened.
> I think those lines should be after the sff8472_show_all(), but outside the out label.
> 

You are right in case the first sff8079_get_eeprom_page() fails,
close_json_object() and delete_json_object() should not be called. But
for the later goto we need to call close_json_object() and
delete_json_object(). Will add second goto mark to resolve this.

> >  	free(buf);
> > 
> >  	return ret;
> > 
> > --
> > 2.43.0
> 

------EC0AF7DDF4258B7AC197367143D8F3F2
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjIxNDUyNDFaMC8GCSqG
SIb3DQEJBDEiBCAAeAZmUl5ZUEjoMtjqUk5DPoFaK4BjccpCLg6jIbr7MDB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgBBCXQARyiD
uDxg5AIXmDuAcdDMx0bsn6DtfwZ4XbATahHeRBYfEeGLdrjnIKPWVKVd5T0zwsTe
60m8tIf9Upuffq7O3CdH2F5iF3MIkTh+I/ZeHX92vt+n46yYeUMW60F/dVG3ySgI
TwfU47cyEMMh6o6DH1c4/bV6xmUNtIVOuIZS12Kq8aeCcV0NPC+6EkyC/DrkYO4W
qAbQmtKcQ/pa5aWO1oMR99GE3xR8r10e+bswE/9Nej9HVUi/y+U2wUm1TjQUzitD
3nOEwf0DbGHIp74iRD6DcENyDbhN+tJU/Prej/rj/VsgsJVXvf+DoLRncs/12Jbm
kts48wWoB39rcQAtlgT4APkNvTvp2oqsbR2M8mQiSCnK/zoltnq7FF8g4GZejew+
QpTtgDtX1seB8aVZl10uobUUUaZuaa/Q20+KWWzPKVs5Dfq7hFm9uFf8HHvCiJ1/
hRZEq1CG0MtoWXHy9S9mlwqsxSpRmQ9Q4HX+rx/73N7IowZbzr3JD+O3Nn7Z5ceT
FFZX93n94t9PBNwSZAS5HHTWNET5jbZasBVpU2JnVnj1SIsiJZQ7um9EYYC8YAdN
gVp5vVrCXP3GZKOT0lxOtFPIo/FJqgvDEew7+8tdvbAcDbha7xD4aPjQ0djlfHCn
4n/srFtn9b0ZMXjKAmDfLH+cHUcDy9Wm/A==

------EC0AF7DDF4258B7AC197367143D8F3F2--


