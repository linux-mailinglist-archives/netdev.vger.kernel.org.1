Return-Path: <netdev+bounces-258373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPu/Jtr+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC4C128089
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5FA6304A701
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4D1350D7D;
	Wed, 11 Feb 2026 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EafprCbG"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00434FF63;
	Wed, 11 Feb 2026 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847934; cv=fail; b=tlYDP4Pii+1Eyr6PHwlvVL/igHpKNhxlzxwuKl7IqY8cDGBryFnwHHbo6piWux/00O6MnnXvWYiMu5E8bGdUsPDAgFlpmRetu3P0c/174+W+oDX9zuQjRNZs79e1E68aGA4TYRURln2zUw0IB0+sLPMhPK5KXV+DD0Odhp+uC8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847934; c=relaxed/simple;
	bh=Ap5aB+WMWnwHP0h/nJcIzCBV+ZHoHDAO4M5Mr1pERwM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=eQmxzgYCHDqlP3ya0fMgvjOabudwaO8QzksvrGtXd+ikqqIiay/St/arHeeUNCGkJ+Xs9uxK4M55Rht7YaZxR5EkIfziJB4F3OVAWLmS/Oik9xnQTPlQ9mXIcD3GhceDHj1Hm6aZu5CRDpB4pBnNKUNIQJ3bhvajSt0aapFO8z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EafprCbG; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFJj7FK++jYvI5KpzwByEyIqXwExRYZTrIhQhOr1cbGgqwEWq2K9iStWRNA/9xvng7Qqh+sVh8p8+0NyQ845c03IeYWto06xemXzKRvKPr9G5/RWsUXvnRtcawYOrYdrA6U3w2EZk0wmmARevuSqrlswNYM3lSP/GwoqnidPTKMapxglcm/y5wcoI/JBGmqsIQPpfio/1qPtAqjns0BCtgtXLI6lGIYrFeTdsfRixga58olPjAXnnvGUhrXoL+Yq6uzPZ425HhD99GuGnI8cGSLywPxClj0i4U+PrddJzVYBDv0fOrK5wBOCygtOfKhiroeYudFzJDoDg6nUNt+ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aINENPgIILrvmV/vCQRcKKvhZ6cvVzsNr8KSH3h59pY=;
 b=fr2R5THuF3OQskWAh5ir4DnYQKdGu8Ul5kspNyb5wtMB2EEic+tjpKamx7YSrjZTAgkhJOqRPKqjUDdL9k8XTJPXNzOhyJKwRz4nqUSA4ousnDpIE29EstJpjYt0fwH7v3P0nvFPca9lwp3pB9WvJGySV2bzQcHoWcbTJsXKlVHfRRKHCsxErG9yCtHbXJrrU91R47cvXZfEfhglybIz3U4sOBvJ84ymgPT849eEOGa1ShO+zh3ZBlcn9I7Xs936xeJwueEgO5wm8fRlgegNVkkWIUK0RMhOetOxkqdoUubILZyt9PtXOZtI5+k/W97dPzEoxQd+0crD4YFCqeeRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aINENPgIILrvmV/vCQRcKKvhZ6cvVzsNr8KSH3h59pY=;
 b=EafprCbGZImyYC1k2wUrgT0iWVnSrIhdV/1D0Ui8TO7N6xPU5tSLZ3p77M++0HlMXOg1nsaWFIRQGR7b2oQCTYD5at9Zn/UAMGRnD/trmH0Ph79UWqd9aULTA81o+GvWin2efr89XYZUPCf0TQBWv9DYBXQcs9nfGt3Dy6Wz6qE=
Received: from BY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:180::18)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:12:11 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::41) by BY5PR13CA0005.outlook.office365.com
 (2603:10b6:a03:180::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 22:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:12:11 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:12:09 -0600
Message-ID: <5241fd0c-f8b2-42d1-9fd8-0de62a5940f9@amd.com>
Date: Wed, 11 Feb 2026 16:12:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 00/22] Type2 device basic support
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaaa5cf-90c8-43b8-7115-08de69ba9ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXlRMFFqZ3kvbWJXZWtTWDJwamlrSWM4ejgwWkROUnF6WjJQMThNWjJEckcv?=
 =?utf-8?B?SXViNHBpZUlsL2lYUlYwN3VWZXp4Q3hlYzRrUWdvVWpSaXF1bWNrenB4MXJC?=
 =?utf-8?B?eFRDdVBQclZHaUF4MkZLQm1hY3cyaDZWT2dUV1Q4K3N5Tko5bklzS1VKVDV3?=
 =?utf-8?B?QS9wZUtTdkRwWVo1NVR5UzByUFJMWThhQmZONmZYU3BJZUFjYUs1Z3orUm5J?=
 =?utf-8?B?aFU0NkxxeWxya3BlZENycFZZWXpPTk4wUVlYempPaWRhMmdFTFY4NTlJdy95?=
 =?utf-8?B?Z1VmNGIzVE5qUVRWMEdVYVRsR21XRHFSc25lMlc3M0YzZFphUm1YSnNXRitw?=
 =?utf-8?B?bkJaY0NTSVBYWVJ4MXpNYk9aa2FwRGxrM0l0a0grMmdLS1lyaU9wQ2h1Uzh0?=
 =?utf-8?B?T1N4NTlzcWorb1RjVVpaZWVucFpXZ1Q4Uk5SQklma0VQd29UWUNQWkdwSUZk?=
 =?utf-8?B?THJhVFRCL0RuQ1FQakx1dGZUN0YvQTI2cDBDTm5RckxUU2hGVXJYalgwc1Fo?=
 =?utf-8?B?aEltVEpvWmFiL2JmZ2Z4Rm9ieDkzc3N2MExOb21nVms5RDd6dzV6WElSN2lv?=
 =?utf-8?B?M3QrZTk3OGh5djBxcUltd2YrUG9JSlQ0bWs1K3kwOEpBb3JuTS9Qa0tYbHYv?=
 =?utf-8?B?WEpZVEhCS0w2eThLeUlQeG4xeXhJbVp4NzRmZ0lTRVN6RUI3VzVIUmpqUjFQ?=
 =?utf-8?B?VGNlclJPNHJTN3pBdDBtQjJqSW1WVEFVa2luYjcvYXJnVEFoYnlZMDJibG5p?=
 =?utf-8?B?cDAyN1ZseTFseHA4UW9RRGx2bTR3VXpjUVV0UEx6MU1ORVhtdG5FQlBlQmhz?=
 =?utf-8?B?dXd0K09sSSt0Sm5MdDY3cnlhci9BSGlnQUlpOUxJRGJOZVVCNEJqU1VCV3FH?=
 =?utf-8?B?N1FHeGtndEZaSG9EU0VGODQ0U3VnMTRhTmdXd3o1V0ZvZ2pvVy9xdnBDMEFj?=
 =?utf-8?B?NDR2VUxKWi8vY2tXMkxROGw1dlhPY05pYlZQWTZqMDdPNGEyejlYRytqYll6?=
 =?utf-8?B?VHQ1V3hONnFHNTkrN293amg1ZjdOTTZJM3VYWHJldDdXQm8wSUY0aGxscy9U?=
 =?utf-8?B?RTd3c045cmFnT0xpU3UwckZHaUxKZWhMWi9GcEtCeHpNZGNpbnlMYVFLOXFo?=
 =?utf-8?B?dzNQSi9IWHlqak0yWUNzanVVaHZHM3JaUnZPYUplbG5hcFRxSWQyRkZXcmFF?=
 =?utf-8?B?b1VWSDQzSUdLeFkvSDBvTWZYMWhUYUp4dk5pUlJQODdNMXhWYjZWVDI3bkRF?=
 =?utf-8?B?Vk9qMHJnZU8vS3F5Q3ljK2dueU5Mak5iM3VXL1J2dWxLZjlWM3FlQ1NHQU12?=
 =?utf-8?B?Wm9iS2ljWXIvQ1NEZTQrbzlvZGdoTEVhOEtadHVDSzM5bFVNUkVVUllVTnk0?=
 =?utf-8?B?eDR4NUE1TStzL1g5V2EyT3VMdGxwS04rNW5naHUyRFUxdmRoR3NzeVpQZ0NL?=
 =?utf-8?B?eGxiZzkxa0pFL3JQMllXKzQwckJ5NFp3NE85UkpkbTN0MmtFR0hkR1dGcFNm?=
 =?utf-8?B?MTFEa3YvSnZ4Y2lhSnVRYThTdWUzVDFsLzlpOHkzd2MyTnJxeUJaM3hlYjQy?=
 =?utf-8?B?clhVZ2NCNG93KzlzaVI0RVcvT0RPZjBZK2doN0JNbzcrM3JNOTJHQ045cVh6?=
 =?utf-8?B?NkJUV0RaNkg3eTNhVXJqMEFyYnlRbjhBSTExa2JvVFlEd0Z1ek1OQ29Bdi9S?=
 =?utf-8?B?MlFzWmNYWmRnMWpudWx3L2w0QVo1cFFBSE5pWkp0ZElWUmRjRks1WGgrWDll?=
 =?utf-8?B?OE9zbjdnQkdreCtEWGxHd0JEL3p5clY5dzUxcU9ISjZOUTNncVZLMm9jd3Uv?=
 =?utf-8?B?Myt3THBpSXdzQzVjTEdZMXZNdFpzSk1SNUt1NGVtMldVWUlXeEMvSitDRXFV?=
 =?utf-8?B?NjV5bllnbnB2ZTF0Rm15NXBpNmthY0c1dDVVOCtQWGF6bzRuTmR2SEIreW9W?=
 =?utf-8?B?L3dBUVkyZDhQN1JjSVpzR0t5WFJHdjYwWmxubVNxdm1YSlZuR2RjWmt6YU5v?=
 =?utf-8?B?L2pXdnhJRGppYnJKUWI0cWdBQU42UkhVMEc0WHFFN0J1WXBkLzJKZmNqMFlJ?=
 =?utf-8?B?dkJWcUpma0hYTGdIOGY0ZmlyUVN1R3lVc1hEM3NkVEkvZGMvc25XdEJYbUtz?=
 =?utf-8?B?ZXVKZGFpTzlOMHBNNlN0UHVBRVpRSVB6UVA2ZVF2S3IvZFFhWk5JdHZGL2Nv?=
 =?utf-8?B?dmxhRCswUDk0WGZMSWNVMjRZTHdnNUdVdUJWcyswL1NmekliTnJPMGR4V0th?=
 =?utf-8?B?c09LcWc2UGZxajBWQy9KcEMra1FBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p6VVViXR63xIZYgzVD8uM11q8Sx0XQDJQru6WL3C05YXkxJaBE5VUqNYCdBQqkGqdQTsZqdvBBm89CPw2FYvA4iQJuUUD4+H4P5TjXcpY834JRxqmmkf+rZJkFK94nu2Cz1F6A53pZpZQd+KQdQMgprLzXctJTSIPJKlvMYHjAPqKoez1s1NZ8byM+cQhrGKvgI9ih3f7Y+TYrzLbNpd6G0c0Ft1nEPbCa4ygX2XIrLZfwPxf+EQvmeOK+LzHH7wh+hGuYyCsLbsX+NLGkywNeRO6v6jwDC3CsG4kXcAn4H3TcfCGL5lRSo9IAgX3tcrgBEUciHqLG3SUSzNu30G55r9yWOW6H/chW6H8VHierngKCD3m7x1gUcJ5gqkP6PG2qyjE4A/Ga+RxzHglIAKwNDfyrd9Od7beDWq4zNd7OvtU++Ft2cgbuX4UZ/JQ1Of
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:12:11.2564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaaa5cf-90c8-43b8-7115-08de69ba9ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258373-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: CCC4C128089
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> This patchset should be applied on the cxl next branch using the base
> specified at the end of this cover letter.
> 
> Dependencies on Dan's work has gone and also on Terry's as the only
> patch required is now in next. The other dependency is on Smita patchset
> but it does not exist such a dependency as that work will not avoid the
> problem with Type2 and DAX/hmem if soft reserved memory. This needs to
> be solved by the BIOS and Type2 UEFI driver for populating the CXL.mem
> range as EFI_RESERVED_TYPE instead of default EFI_CONVENTIONAL_MEMORY
> with the EFI_MEMORY_SP attribute. There exists though a dependency on
> one Smita's patches:
> 
> [PATCH v5 3/7] cxl/region: Skip decoder reset on detach for autodiscovered regions
> 
> This is needed for the default behaviour with current BIOS configuration
> where the HDM Type2 decoders will be kept unreset when driver unloads.
> This is the main change introduced in v23: committed decoders will not
> be reset. Previous v22 functionality supported first driver load finding
> committed decoders but resetting them at unload and supporting
> uncommitted decoders in next driver loads. This will be suported in
> follow-up works.
> 
> v23 changes:
> 
>   patch 11: fixing minor issues and droping change in
> 	    should_emulate_decoders (Jonathan Cameron)
> 
>   patch13: refactoring unregister_region for safety type in Type2 API
> 
>   sfc changes: slight modifications to error path
> 

This cover letter is really long, I'd remove the change logs for anything more
than 3 revisions back (assuming a v24 is needed). After that you could leave
a lore link for older revisions if you want, but it's not needed imo.
Also, feel free to add my Reviewed-by for anything I didn't leave a comment on
(felt I should cut down on the mail).

Thanks,
Ben

