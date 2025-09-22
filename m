Return-Path: <netdev+bounces-225384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302BFB93561
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B490919C00FF
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356BA261B78;
	Mon, 22 Sep 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ybJTtyxw"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379434BA39;
	Mon, 22 Sep 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575359; cv=fail; b=K5wGFE3JeshLUWdna9HNjxVUguzPXG71LLJdzFpcbUt9tBvEZRfUxTth1oOKpw9YJZDCi3oZ2AfMUfUwd/bV5HfmFMHKk38gv9DIFIIJ3PdWUHgCAuqnYs4waR6EbLQ49ZJRD3nVZfndofutAAsvnfuSeuKbO/EFnAFhjF6ym2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575359; c=relaxed/simple;
	bh=XuU0d1mTWZuXz5oE58fxCg0fUQPAKWEVwEQirEfC3uc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hMJnE34QRvjYawNAmWGyXBJFUmZTHXKlVZTPXR6y4wFqXvyKWbpf6ozWObtziRYyohZGyVyQNT+NxsbrOCq3zcpH03rhVT7z5W8Dr7pB+Rr1OGBG0jK3i5CVb14Of7P6xJD3jyRnJUFA0d0TUx6ul8ME0NvwlQqHF/kbxT0wwIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ybJTtyxw; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLwoehLgBPH8cpJuw7u8E/Vn4rHPE2wjquxTnGcWsboFFqC1engM0rmcLlXfB3tVpe480IEwcSG7bUYrKgf504Ut5H+jbARFfGJcK43NqYo7Tie0JolZUSHO5rEZU0kQjzn9x48oCRftLSU5qUzZzidW581LAZcQYfqrbW1w1jqdA3Agi4AGoOJ21aMnNF1s2eBCidj1SBJ7XZTeOirK1m9RDAousYzAkizCYK6TQSOonucowIAENGAXfOIDx3eyI9ErEZc3NooGE9NhBqN8RzveuDH8kyjBXNe3wlWOtP0Q1v+8Hgr57F3TJFpQcloILM6ZwtfaQMpXPyBFBXtLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEXtkpkfl4nXChiHLd9UrJi2IsGFP6P7sxz5G3Wntpc=;
 b=CNm7Bo6OSy+4XCIwIufbfjSICAqM+KYO6/4vlz8p1KwkmOo2V64JDPs53mGUKUBz2Y5UzxclKiXtUdbrkmr1BFl8UUFNL7gaMaXPzOsGQoGubAIGrQVT4gQ+sibwfbEfO2cCUrdfZDnDxjG5QkL6s+gdUZc/wnqRjIBm68v21OqSzI/AzCWvpi6VLbjgW/MGsM9loxT3VfyNgC3p3R1hOO6VMPKLxHsNJQ5Fmut1cVYMZrhnZuWAtmfaIjaV6zscqL8fMJtb/jSmFjS785q8LyAW+bh7RpywPEuEMcHQ8PIGPfwdCNvuMsFpJiSwO44ruJsiD0DwrCK9bxrp7FuRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEXtkpkfl4nXChiHLd9UrJi2IsGFP6P7sxz5G3Wntpc=;
 b=ybJTtyxwolyC6ppXy1KRcMj6ZkwsheOH3Ea7QqqfGJjIRpaKDsl80sxMIa3LDWZOgqFVM7LBBYvBlBfuO+mInW1CzZ2O0L+a6XLlxmHi79Ctgxc/50mTSv16rQ6BgjRnYOQ/CQBIQ+KRiEHtXmRpR2XIrIlFCHOczcJX0ZC1FM4=
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Mon, 22 Sep 2025 21:09:13 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::ba) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:09:12 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:09:11 -0700
Message-ID: <1b18b212-d348-4a9e-aa87-0cd3db596ed8@amd.com>
Date: Mon, 22 Sep 2025 16:09:10 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 09/20] cxl: Define a driver interface for HPA free
 space enumeration
To: <alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-10-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: fb683005-d7c5-490a-f917-08ddfa1c47d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXR1eTBlUUFTKzlocXIyek1FQy8rWWFCTmpoeFkrRktTTFRTOUNGNjQyd2Vt?=
 =?utf-8?B?ZDNOWmpXN28wR1MrY2xLaG8rdk5nWERFUWlmQVhDb3cwOEVMRDRMZEkxL0Nh?=
 =?utf-8?B?K3NlcmpSOEtHU2hBOGNyMk1QUU0xbmNOZ2gxMkg5ZHljbFRwMkZPNmJERDY3?=
 =?utf-8?B?OGFNOWlpOGExUWNjc2F5NG9FUDBqYmI3YVFSaGZkak9FQzA5ZGw1MUwyc2p1?=
 =?utf-8?B?WU5FeFpuUnFzSDF4M2owWlplY1dFc1pnSjkwTWJWeDdBNEdFUnVCdXZRd252?=
 =?utf-8?B?R01KK01wM0dzd1R5VzN0Tzh1QVAraHpDWnZyTGtldzhNNEV6ZTdINEJ4MDFV?=
 =?utf-8?B?bGpnOC9DM1RyWVh1ZjcrczdGL09MaDhBeW91QnFhcnBmOElMcW5ETkZpYm15?=
 =?utf-8?B?akxaVUdHd0tUNUFDZDMyVUJEWVdqbGQ4a1RZVVN3azNwa0tFb29DZkI1RTR1?=
 =?utf-8?B?T2UxVGxFSTlxVFJ4ZS9yZWgxSTA5YXJhS3RvUzRtUWZuZmlqMlNUR28rYWp6?=
 =?utf-8?B?OVNGSlpXQXE2UGJtYkllelpoYkI0TjBLUGU0ampid0IzcFBjd21nRGR0S0ts?=
 =?utf-8?B?ekJXYm90VEFLaGNwMUFoOTFHSnpYa1ZmZ09XTmtKRzdyaUxacy9Jb3ZuSFJU?=
 =?utf-8?B?NTk5azAwVlBJb2NNQnh6OFJleGtTSVdKY0hoT2ZsbHVwUEE0Zjg1S3pQekR1?=
 =?utf-8?B?STNybDFKdWpYVDZQY2d0S0Z1NFhRazd1ZlRnanNESUdpRmFUanVUdGZxRnZG?=
 =?utf-8?B?bGFPMEZNRlBDSFVIR3pnZUVZUjA2YjhidStsUDBZRjE3d2JMYktaOW9WTXJK?=
 =?utf-8?B?b2ZuYThodkNGRGJIRXJWMTFMYVZYNFM2SHgyNnlaNCtwdTFLbmxQNFdBbVE4?=
 =?utf-8?B?MVh5VkNTdlIrUnV5eFA3MEE2cU9IVGRIc2RUbDlIdGR6eS9pWElabU5ucmZV?=
 =?utf-8?B?aXY3NCtraEFCNEdUY25VMUl1NTEyOVpmWWhPc1NYNjhMYlRBelU1dk4yNWJZ?=
 =?utf-8?B?M3BwdHlqdkpac1djOWcrUWtGTGhXVFV0UlROcXMwOXhaMU1GeDZYRmtuRmVr?=
 =?utf-8?B?ZzNCemF5WXNQN2d3VUFDdUVuTk85UUdYbTg2MkJyeDNVT1NZRU0xMWFRL0hz?=
 =?utf-8?B?eWZkazhodUJNbEVpSXVkYmNodkJKZStQQVpBTExyUEZWN1hCbE1TanVnYk5I?=
 =?utf-8?B?bk5uMExWOWhoSWVldHJXVnJ1Vm5RZnVMS0ZtdDJvSURzdWVuWnBTNHdpbVFv?=
 =?utf-8?B?NGpoeHhEQ3NyM3Q2TWxNOGJOamIySk1HSTNWODlGSGVNc0pDNEFsakIxd29S?=
 =?utf-8?B?bkpUYlFPSURCblNWbUdEaXUzbllCQ0VCeWNqZ00zN1kzWk4yalY1dmMraTFW?=
 =?utf-8?B?dThmVUpGY1pWTWpPUHJMUXYxNnV4WWZrZjFwbWdZclVOWmJKLzdVSWZ4L3p4?=
 =?utf-8?B?T2Y2UXBaVHdSdzBMMS9UU2V5Qlo5NEh5cWY1RXhBWmhlZkVJZVhBNDNndGN3?=
 =?utf-8?B?MGJkeENZZGJlb3JGb2llWXBnZExEaWhIZDZma1dmUldQeHZaek44cU5FdE1D?=
 =?utf-8?B?T1lFUnZET0dtRTlVUjlvS2w4Sk9iWWtNUVIvd2tHVjgrU05HdXZCTTJaelFS?=
 =?utf-8?B?bVhjTTRJQ080cGpybndpVzlhRHFvK0UyTDRYemQ2SFk2TjhoVHlHY2tXMmVi?=
 =?utf-8?B?NEdDS2xabG9UaDZ4MEZvMTNzRzVZOFYxWUJKUHdnSStnTDZIbm44dDF5bUtX?=
 =?utf-8?B?Nms3aTJjQ0pyZ2dpVzUwcDhJY2RCRWQ3UWNYTXBmYUJka0E4cjM3SVYvKzVD?=
 =?utf-8?B?d25lUkpqLzhQelhFVktjMXl4M3JHWmxQcVBqK1dDUnY2a1RPallGNXhaY0NB?=
 =?utf-8?B?blNCYnI5NnYwN3BKeGVucWZNdXFUMy9kSkQzVklYRmxmMk5qT3gyOXhkM0Jn?=
 =?utf-8?B?NlNCT2g5eC9KS2luc0JpMVNTNngvRWZyMlRURWdsR25kWTNsc3VJbDVMc21G?=
 =?utf-8?B?QSs4QjlPSDNqZWtNZ1FiSVJvWjRDdVFJM0lHRmpQT0g0QVZ5anRuVW9jYnBr?=
 =?utf-8?Q?qDXOR1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:09:12.6654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb683005-d7c5-490a-f917-08ddfa1c47d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

[snip]

> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @endpoint: the endpoint requiring the HPA
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * Returns a pointer to a struct cxl_root_decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
s/capacity the/capacity and the

Or you could cleanup to: "If by the time the caller goes to use this root decoder
and its capacity is reduced then...".

> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_root *root __free(put_cxl_root) = NULL;
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = &endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +
> +	if (!endpoint) {
> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
> +		return ERR_PTR(-ENXIO);
> +	}

I'm 99% sure you'll crash in this case. The endpoint pointer is dereferenced when assigning to ctx above.

> +
> +	root  = find_cxl_root(endpoint);
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");

s/can not/is not

> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);

Do you need the brackets for the scoped guard? I'm not sure how the macro expands when they aren't
there.

