Return-Path: <netdev+bounces-99094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D68D3B9B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7985B24C37
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B01836D1;
	Wed, 29 May 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lb4Vts5+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E9C8DE
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998466; cv=fail; b=Sc7L56u2KBTYpT4w5j969hmfezbVZyKvNVOaLImcxbx+iD6J44YjlF/i8AQikkNe5UOsZYquxPkvU2UliTmPx4t98egpxtfoRDXHLxIN+sSmElOuf8PO8zbj2q/V5ql+nrRUHp5RBJnLt0WGjIjMRauC7RFNemcQMWxbx/HggCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998466; c=relaxed/simple;
	bh=8Xd1j4w4rstxLnm9fzfTk5UXf9+jJij2ymesfwZsb/U=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bS7Sh1U8pwhiQDiXzbcOF7bE1+iLZKeVcm7xCCPOlqVwIyanXt6u1SQl3v/PNR/KZ3tBwHtZ4sAeMeoV8DDdi1I97ScImD6JKDtN37nlpidatwyvQr5cZuD+vz2B140VpB6tguJg06ePfIjvOnSqc4XrOzaIvVVsWnMlsnfLkE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lb4Vts5+; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEyJRdlYEWUYKIA0X+cmKBxWARcWvjrnXs4gCqCkWzuE1afnGkevPcxL/2wC+Z0L1OVlLEG8k+BogS1N39oiGTfxqzzgEyxHsUVmIhb6+TQRf/xr/rnVfhU6PCsBUVtZjj9s9LO6Jlqocr3bgtsxvLeyiM7tCiDef8VMCkSxP+K3M/ZC5CMfS6bU3Uv2GvJLGPsKorsKczOsNddHsbeh4cgsR/VoXlrPVALsaUdXA+BGpi/w7kOStZ0Kb0c4f0A9seRimZUC/p7AlPqQULIdy516m+/j+ocbJLKPbnLUmXAv94HZJZ0w7wleYxDasKPkyeE6ZA+4VpHmQodY7jfpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyE16NhsgkOsEdnaAM/WIOmU1SNcFr+qsPNoTgl0Vbo=;
 b=eb/1TQd0v+dJLjc++kE7xhGyQMUwVywsSbRre9kqiW9JOhiThTRv2MzJ9F+1xeMoEPY3TOMEp4dWYk1rq+n1nwFkXs3voKKhwtdFWRecY0X8XSDaubcnn08FhjUJcExqypnurxKHu0CIG8aBmjJZr7lI+zKhNBbdj8UOuTlngbr9CVmgB2ZLnkZBiSOxXzEa3jB8BTMFhJKJAsUB1iH119/FwPKyQ0vVMoQlzH0p6a5bZbJ9PQwIHoHo9pjT+/SolHZ8KnqIZB3yRgpv8z+P1ux4eegKl2b+Kh8BHJ27wRNU4VeTKgAvjhKuIam+x7r8LqEnyEIXJJy1iXhb0AFmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyE16NhsgkOsEdnaAM/WIOmU1SNcFr+qsPNoTgl0Vbo=;
 b=lb4Vts5+GP9iFEKbA8wz52NXvRcgAWE6d/Vqp+wvRmQ1W4i102eO/FeoTAGIufhhu5MVtiH0sGOW4X8KS7eWXTpNktnb71hVhT87zO9ntDvO3IPHHcdavR8YLS8dZ3O5Uega8gd8WyNN+VD/0zY3ML9LwciGdPUgf08FOO67n4i6vgDFv+q6X8eVQbsPW7BeOk9xBSUnwuX24mOG4C9RXlNtcTidxg/BiE+/FWTLWLb+8b7APyOo0BDAOTkNyLzeTITef6fkTTSeVjZhqZw2BsLLnnWt00Rsc8xFDs5egjvrO9TnATTd/Hkp5ekCWTpT8v7qEE+5n2q+1MmKPfmwWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:00:59 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:00:59 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH v25 00/20] nvme-tcp receive offloads
Date: Wed, 29 May 2024 16:00:33 +0000
Message-Id: <20240529160053.111531-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: f83aa965-8798-4250-3167-08dc7ff8882b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVBBNzNFUkVoOVZGMmZEd2RwbHY3cjVTMWREUDlkc1N2ZlVFSldWd3pUaUtw?=
 =?utf-8?B?TlVlMlB1WHV1WUs5SlhNbDhnTGZXVFo1QU01UlJ2NWNuQkRKZVJhSG0rcEhJ?=
 =?utf-8?B?VGdLYnAxN2c1TWRXQ3h6Q0htVDBsTk9TQ1N2K3VDT0pqanArUXBwSUZPYVBE?=
 =?utf-8?B?UmRQTlRrOWttK0ZxRFUyWHN6NE5WSDIyZkdMOW5KN1NCK3FySFFCRXowY3Qv?=
 =?utf-8?B?Q0RoYW15UEtwNGN2cGo2Ymw1TDM5cGt5amZFUVRRbkVsWVhXQnB6QUVVWnRI?=
 =?utf-8?B?NnJxQWVza1grc2c3M0Z1ZWJqNExQWEliNkswcGEvV25zM0t3QzNZMXdpcHYr?=
 =?utf-8?B?c1lJeitiUHZGVjk2dlJzYnRuRXNmWEx4QUdPVU95Z2RWQnNyMFFGZ0NBRTNG?=
 =?utf-8?B?UHVsemw2eWR3eG05WTM5K0xvSnUvVTRLK3VFS2RnMmNEZUV6aFo0QUtmL2Y3?=
 =?utf-8?B?Mkp3WUVPdENWNnV0Nk1TU1FCZS9rVWM2anFOTkQrL3dCMjJhdjdHajdpQ3ht?=
 =?utf-8?B?VERTaDBGaE84U2dPTWxmcUt6OTRHVUZIOGhTanRRbDBJOEsxN0VDU2hYNHNm?=
 =?utf-8?B?MmJvbXFlMzBuSTMvWVkwWnlUNTNtd081bEdlSjBHbE5kL1RlMGtBRTB1dGJr?=
 =?utf-8?B?cEVFc1ExWlRIdGpacnBnRlFGZ3VqNkpzZWRzSzRoc0xHQ0hxU0hqOEdrUmRo?=
 =?utf-8?B?VDJxZmhtMUlMZ2VRdjRkMUVkWUNZVUZxb3FGM042T1RuclZkcTVKMmlpMlNR?=
 =?utf-8?B?OUJIQUpPZHJ3NUtFcWFVSDBvd3NTZXkzY1EwWk1LaHBzb0c4OUdOUWthN01N?=
 =?utf-8?B?Z1djcXI3SU5oRTBiSVJNYmpMSzJiSCtGY0ZpaXJzL1pkY01ydVFaVk1zL1BE?=
 =?utf-8?B?TzFxYjJBdXZaY3VOMWY5bTBUaTYzRkhaZWdaZ3ltbFZMWFlFUHhiamZYM0pT?=
 =?utf-8?B?WU1FYXRybkEzZG1QWWllQXZ4RCtDSFUvVnhnYys2c2RzSGdRZzc5OC9nZUh5?=
 =?utf-8?B?YW9YUFVGL2dsTDlDR041bjYxUUwrUE90QVc4RnBJUHQrYWZRbjhsZzkvM0pr?=
 =?utf-8?B?bCtzZFlEMFdJRVI2Rzh0alk5Ty94cC9VZzA5UzlSdUh5UTF6THdKaHdyNW5C?=
 =?utf-8?B?bkJMckJNNVB5OG9uNzNKcUZjOWF4T1pPTDJ4TER3N01lQ1h2MzhndzJSQ2p6?=
 =?utf-8?B?WUpyd0dYaXI0aEhZdmtiN1lxTmo2RTA5aHlYVE80V0g5bzZSZzZnS1QwazRs?=
 =?utf-8?B?djZFVWdMUGRzVkViNzVwUC9uVmcybUhzejhuRmFYa2o3bE1yVzQrUlhFaHBy?=
 =?utf-8?B?djJacWgxenFLQjAvQ1dsd3BHbjhFU0cydlV4Qk9XdWV5TllIUlhYWTFKVVhy?=
 =?utf-8?B?bks3K3lOM0dDLys3ZnZuTHlMTmxqMDBsUnF5QUJvdTZXYzNEMkUzYVpJaC9r?=
 =?utf-8?B?RWdVVTNtVWU4Y0d4WFpOcUFyRThUZFBpUktMOExsV1RlcU1LMzBRcWN6SVRC?=
 =?utf-8?B?MTBrbmhTTUtvaWdISVAvT3AzeFpON1lzK2NCSkdtSThLUnppMmZwMmZwcnBX?=
 =?utf-8?B?bGtQV0tDYW9ILzYzbDdvZEw1N1hPWEsrTTFUSlZ5TGpDTm0wNjYrQ05jYUF5?=
 =?utf-8?B?VXJGSHNodlZqTHUrV0o5THBJcXA0ZWY0Yk93MDM3OVJiQm5BeXJ5Tm1tU0tH?=
 =?utf-8?B?QmRyZWJ4U2pyc0F6UGtLbjRLZ29qVkdIQ1IyakExVWRFZHZiUEZNd0JSUXZw?=
 =?utf-8?Q?AAM0bK5QnWubn7Pq9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWlrQXRYQ3VuT2k5bUlydXhvdzdEc0x3dVFqTGkxajNtVW5xWmMxK25GdDA2?=
 =?utf-8?B?VlQ0cXNCaVZ0Z01uKzBmcGZyWUVLcXExNjVDUWRaclRtMDY5VHp3RHRtVU9n?=
 =?utf-8?B?TFRoL3FEUUg0M0VMY3lER3NJL2N2UnFkeTR6Vi9CTEVxL0lleC9pM0hyUFJi?=
 =?utf-8?B?bG1FVnJsWWVrSE40bkhvVXBQejJKQkloellGOEdtN3FyS0ZCM3ppeUdUaXdr?=
 =?utf-8?B?d0p1ejN1YVJ0MWJ5TGQ0aUVtQlE0c25JamNTd1c4RmRreVlQNWU5YldobXJI?=
 =?utf-8?B?WGxQa042dHVZUVduOFBRUTlWRDBUL0poRGlSQ2dHc3QxRitoV0drbHVxLytw?=
 =?utf-8?B?SldxQ0trWHpoM2ZzOXUvbVhPdWpWSmJZNGVCYjhVazlIVjdsSVhocHJuQkk3?=
 =?utf-8?B?VzBuSGYyREdIcTgvdUVRdEwrUGI2eGlmb3NXa0JRQkpNbVI5bFJHUUZkZGpE?=
 =?utf-8?B?bGp1RlJSMFdwVVd1YXhiUnpoYWhpZmFnb2dTM3p6cHgrbmc3aFZ6enYydzZ4?=
 =?utf-8?B?M0RDVGVYd0gxeHcwbjVQelJRcWtMUDhNY3JuN3J6YlRxNGU0bkJ4LzJVTXFC?=
 =?utf-8?B?S3cyZmZtZ1Jlcjl2ZGw0ZVRKMW00eXh1Q2EvZXVwMVVvUXQ5Q0FKeHVmWjdH?=
 =?utf-8?B?bUFxNzFscFVBcTdSb08zbFNqbWNvUStOS1NMS3cvME9VbkdvbkpMNkhxeXBN?=
 =?utf-8?B?TjVGTHVTUUJES3FsTHRkSkNxbkFRTHV6YTNGclpoYktETVB1TGMxc1lmZTB5?=
 =?utf-8?B?OUxPdzhzbDJNNGs5ZnNqcldmMTFoU0h2R1F3cXNsUDh3cHVBdEpqZjNXV1RR?=
 =?utf-8?B?TlZTM1RBeWl4c2FpWjdjandqdWw3YTZoUEFlMUtpcEh1UkFhanlEZkxqOTN0?=
 =?utf-8?B?UFIzeDNVemxpbjNuZnhaUFdaS3NmZmh4b1c4bEp4OFFFTDRibUNBUzN5MW82?=
 =?utf-8?B?dlV2V013cFFHSkg2NzB4Q0Q3Umx3Rm9uK2REY01FWjZNTXk3YzlkUzlWUHlY?=
 =?utf-8?B?R0pZb0xSYkhxaXltSFhJNHowTEY3b29haUtjSVRiNzNNeDEyM0RGd0liMHNM?=
 =?utf-8?B?V0x5WURSWmlnNjBBRXRleXhGL0ZPQTJpODA1ZEFyTk0vMTFDNFJqOUJ4SVlK?=
 =?utf-8?B?aWVCYmRRQzFHakZ3Smt1UWZubHlJN2UrZlBoWStLcDFKSE5HMnlhbDRsMVRo?=
 =?utf-8?B?Sk13WWlpT3V6Q292MGlsejI2MEpjQ3BFY3p2cWFzNUoyVkptTVdlOVAwNGpt?=
 =?utf-8?B?QS8ySzA4Y1pFQktSSU5ITm9SckZNbmxHdWxZZWh0KzZMb05BTkFtaWx3QXU4?=
 =?utf-8?B?c1ROWVBURmFXNnF1dXhORHNjVUdVa1pOdXJXcDU3aTJRb1h4ZzBOcnJHMFh1?=
 =?utf-8?B?MlFwQmpLalBIcDRTbGJ0bHF5UklxRGhEaHVGckxKL252THJTN29oMit6UWxn?=
 =?utf-8?B?OWpteFZmUE1PYnNJVWcxc1VsYVUrdUZVWm9IbmNFQjdoQmFNYzladGN5K0R6?=
 =?utf-8?B?cCszRnM3N1RRNERqSnlvRXV0dFlxakZ0QkR5NFhVMTdUU3BCa2k2eU5ZSlNV?=
 =?utf-8?B?MUV3cFJMY1E5YjdCbnJWbCtsYVJYb3loTk1wVGtVZzREZjdueGRMS1UvYTJh?=
 =?utf-8?B?QytGK2tFYWp3VTc3VVNDVlRoVXZqcG9kd2FMdzc5QXU2aFIzUFpXMzMyTk5V?=
 =?utf-8?B?ZGc2SGdWT0VoaVM1dGYzM01WcEV6VWtJRklNZmFzdWpsQ0Y0ek5BeWJsSktH?=
 =?utf-8?B?bHQrc0hJRW9lMldyeFNQMU55ck41Z2xSd0ZhVFY3WGxoUVJJWCt1dndSMFc4?=
 =?utf-8?B?YVIwN0wvMHprLy9ITVE2NVM3NVBtUXZobWRMTU4ycW9FWFF3cGsvUDNWU0FN?=
 =?utf-8?B?aTZBMXd3Z2dQbE44K0xyQm1zTlQ4engyK0pzdGcweHRjaWVxeURWL3hqRDgy?=
 =?utf-8?B?U2tvQzRkZTl3MjZIcWYrU3dQOGU2VDBETTY0MFp3M0x6SW8wZ1hUdW5Lbklu?=
 =?utf-8?B?bWNMZ2t5ZUI1YURkRnhYTmJtV1luTXhuRFNVeFl6cUhHZnZXUEpuYVVIVWt3?=
 =?utf-8?B?YTlxbENFVjFQbWtNeTdPbE9iSTVRY3BlVzRjQmdqNWZlSFdRaEVJdlJpZXhz?=
 =?utf-8?Q?87/kDbKWGvt0od9Jwg96MuzFF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83aa965-8798-4250-3167-08dc7ff8882b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:00:59.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAf2mq3nSYVvbkOPhlurR7iSgz5rSKZ5+jI/xN2Nd8RBBX7JNmusQQIMsLSp6hHKje2nzUO3WzQ1uf1ON+fC6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

Hi,

The next iteration of our nvme-tcp receive offload series, rebased on top of today's
net-next 782471db6c72 ("Merge branch 'xilinx-clock-support'").

Previous submission (v24):
https://lore.kernel.org/netdev/253a5l3qg4k.fsf@nvidia.com/T/

The changes are also available through git:
Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v25
Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v25

The NVMe-TCP offload was presented in netdev 0x16 (video available):
- https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
- https://youtu.be/W74TR-SNgi4

From: Aurelien Aptel <aaptel@nvidia.com>
From: Shai Malin <smalin@nvidia.com>
From: Boris Pismenny <borisp@nvidia.com>
From: Or Gerlitz <ogerlitz@nvidia.com>
From: Yoray Zack <yorayz@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>

=========================================

This series adds support for NVMe-TCP receive offloads. The method here
does not mandate the offload of the network stack to the device.
Instead, these work together with TCP to offload:
1. copy from SKB to the block layer buffers.
2. CRC calculation and verification for received PDU.

The series implements these as a generic offload infrastructure for storage
protocols, which calls TCP Direct Data Placement and TCP Offload CRC
respectively. We use this infrastructure to implement NVMe-TCP offload for
copy and CRC.
Future implementations can reuse the same infrastructure for other protocols
such as iSCSI.

Note:
These offloads are similar in nature to the packet-based NIC TLS offloads,
which are already upstream (see net/tls/tls_device.c).
You can read more about TLS offload here:
https://www.kernel.org/doc/html/latest/networking/tls-offload.html

Queue Level
===========
The offload for IO queues is initialized after the handshake of the
NVMe-TCP protocol is finished by calling `nvme_tcp_offload_socket`
with the tcp socket of the nvme_tcp_queue:
This operation sets all relevant hardware contexts in
hardware. If it fails, then the IO queue proceeds as usual with no offload.
If it succeeds then `nvme_tcp_setup_ddp` and `nvme_tcp_teardown_ddp` may be
called to perform copy offload, and crc offload will be used.
This initialization does not change the normal operation of NVMe-TCP in any
way besides adding the option to call the above mentioned NDO operations.

For the admin queue, NVMe-TCP does not initialize the offload.
Instead, NVMe-TCP calls the driver to configure limits for the controller,
such as max_hw_sectors and max_segments, these must be limited to accommodate
potential HW resource limits, and to improve performance.

If some error occurs, and the IO queue must be closed or reconnected, then
offload is teardown and initialized again. Additionally, we handle netdev
down events via the existing error recovery flow.

IO Level
========
The NVMe-TCP layer calls the NIC driver to map block layer buffers to CID
using `nvme_tcp_setup_ddp` before sending the read request. When the response
is received, then the NIC HW will write the PDU payload directly into the
designated buffer, and build an SKB such that it points into the destination
buffer. This SKB represents the entire packet received on the wire, but it
points to the block layer buffers. Once NVMe-TCP attempts to copy data from
this SKB to the block layer buffer it can skip the copy by checking in the
copying function: if (src == dst) -> skip copy

Finally, when the PDU has been processed to completion, the NVMe-TCP layer
releases the NIC HW context by calling `nvme_tcp_teardown_ddp` which
asynchronously unmaps the buffers from NIC HW.

The NIC must release its mapping between command IDs and the target buffers.
This mapping is released when NVMe-TCP calls the NIC
driver (`nvme_tcp_offload_socket`).
As completing IOs is performance critical, we introduce asynchronous
completions for NVMe-TCP, i.e. NVMe-TCP calls the NIC, which will later
call NVMe-TCP to complete the IO (`nvme_tcp_ddp_teardown_done`).

On the IO level, and in order to use the offload only when a clear
performance improvement is expected, the offload is used only for IOs
which are bigger than io_threshold.

SKB
===
The DDP (zero-copy) and CRC offloads require two additional bits in the SKB.
The ddp bit is useful to prevent condensing of SKBs which are targeted
for zero-copy. The crc bit is useful to prevent GRO coalescing SKBs with
different offload values. This bit is similar in concept to the
"decrypted" bit.

After offload is initialized, we use the SKB's crc bit to indicate that:
"there was no problem with the verification of all CRC fields in this packet's
payload". The bit is set to zero if there was an error, or if HW skipped
offload for some reason. If *any* SKB in a PDU has (crc != 1), then the
calling driver must compute the CRC, and check it. We perform this check, and
accompanying software fallback at the end of the processing of a received PDU.

Resynchronization flow
======================
The resynchronization flow is performed to reset the hardware tracking of
NVMe-TCP PDUs within the TCP stream. The flow consists of a request from
the hardware proxied by the driver, regarding a possible location of a
PDU header. Followed by a response from the NVMe-TCP driver.

This flow is rare, and it should happen only after packet loss or
reordering events that involve NVMe-TCP PDU headers.

CID Mapping
===========
ConnectX-7 assumes linear CID (0...N-1 for queue of size N) where the Linux NVMe
driver uses part of the 16 bit CCID for generation counter.
To address that, we use the existing quirk in the NVMe layer when the HW
driver advertises that they don't support the full 16 bit CCID range.

Enablement on ConnectX-7
========================
By default, NVMeTCP offload is disabled in the mlx driver and in the nvme-tcp host.
In order to enable it:

        # Disable CQE compression (specific for ConnectX)
        ethtool --set-priv-flags <device> rx_cqe_compress off

        # Enable the ULP-DDP
        ./tools/net/ynl/cli.py \
            --spec Documentation/netlink/specs/ulp_ddp.yaml --do caps-set \
            --json '{"ifindex": <device index>, "wanted": 3, "wanted_mask": 3}'

        # Enable ULP offload in nvme-tcp
        modprobe nvme-tcp ddp_offload=1

Following the device ULP-DDP enablement, all the IO queues/sockets which are
running on the device are offloaded.

Performance
===========
With this implementation, using the ConnectX-7 NIC, we were able to
demonstrate the following CPU utilization improvement:

Without data digest:
For  64K queued read IOs – up to 32% improvement in the BW/IOPS (111 Gbps vs. 84 Gbps).
For 512K queued read IOs – up to 55% improvement in the BW/IOPS (148 Gbps vs. 98 Gbps).

With data digest:
For  64K queued read IOs – up to 107% improvement in the BW/IOPS (111 Gbps vs. 53 Gbps).
For 512K queued read IOs – up to 138% improvement in the BW/IOPS (146 Gbps vs. 61 Gbps).

With small IOs we are not expecting that the offload will show a performance gain.

The test configuration:
- fio command: qd=128, jobs=8.
- Server: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz, 160 cores.

Patches
=======
Patch 1:  Introduce the infrastructure for all ULP DDP and ULP DDP CRC offloads.
Patch 2:  Add netlink family to manage ULP DDP capabilities & stats.
Patch 3:  The iov_iter change to skip copy if (src == dst).
Patch 4:  Export the get_netdev_for_sock function from TLS to generic location.
Patch 5:  NVMe-TCP changes to call NIC driver on queue init/teardown and resync.
Patch 6:  NVMe-TCP changes to call NIC driver on IO operation
          setup/teardown, and support async completions.
Patch 7:  NVMe-TCP changes to support CRC offload on receive
          Also, this patch moves CRC calculation to the end of PDU
          in case offload requires software fallback.
Patch 8:  NVMe-TCP handling of netdev events: stop the offload if netdev is
          going down.
Patch 9:  Documentation of ULP DDP offloads.

The rest of the series is the mlx5 implementation of the offload.

Testing
=======
This series was tested on ConnectX-7 HW using various configurations
of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-TCP
targets.

Compatibility
=============
* The offload works with bare-metal or SRIOV.
* The HW can support up to 64K connections per device (assuming no
  other HW accelerations are used). In this series, we will introduce
  the support for up to 4k connections, and we have plans to increase it.
* In the current HW implementation, the combination of NVMeTCP offload
  with TLS is not supported. In the future, if it will be implemented,
  the impact on the NVMe/TCP layer will be minimal.
* The NVMeTCP offload ConnectX 7 HW can support tunneling, but we
  don't see the need for this feature yet.
* NVMe poll queues are not in the scope of this series.

Future Work
===========
* NVMeTCP transmit offload.
* NVMeTCP offloads incremental features.

Changes since v24:
=================
- ulp_ddp.h: rename cfg->io_cpu to ->affinity_hint (Sagi).
- add compile-time optimization for the iov memcpy skip check (David).
- add rtnl_lock/unlock() around get_netdev_for_sock().
- fix vlan lookup in get_netdev_for_sock().
- fix NULL deref when netdev doesn't have ulp_ddp ops.
- use inline funcs for skb bits to remove ifdef (match tls code).

Changes since v23:
=================
- ulp_ddp.h: remove queue_id (Sagi).
- nvme-tcp: remove nvme_status, always set req->{result,status} (Sagi).
- nvme-tcp: rename label to ddgst_valid (Sagi).
- mlx5: remove newline from error messages (Jakub).

Changes since v22:
=================
- protect ->set_caps() with rtnl_lock().
- refactor of netdev GOING_DOWN event handler (Sagi).
- fix DDGST recalc for IOs under offload threshold.
- rebase against new mlx5 driver changes.

Changes since v21:
=================
- add netdevice_tracker to get_netdev_for_sock() (Jakub).
- remove redundant q->data_digest check (Max).

Changes since v20:
=================
- get caps&limits from nvme and remove query_limits() (Sagi).
- rename queue->ddp_status to queue->nvme_status and move ouf of ifdef (Sagi).
- call setup_ddp() during request setup (Sagi).
- remove null check in ddgst_recalc() (Sagi).
- remove local var in offload_socket() (Sagi).
- remove ifindex and hdr from netlink context data (Jiri).
- clean netlink notify handling and use nla_get_uint() (Jiri).
- normalize doc in ulp_ddp netlink spec (Jiri).

Changes since v19:
=================
- rebase against net-next.
- fix ulp_ddp_is_cap_active() error reported by the kernel test bot.

Changes since v18:
=================
- rebase against net-next.
- integrate with nvme-tcp tls.
- add const in parameter for skb_is_no_condense() and skb_is_ulp_crc().
- update documentation.

Changes since v17:
=================
- move capabilities from netdev to driver and add get_caps() op (Jiri).
- set stats by name explicitly, remove dump ops (Jiri).
- rename struct, functions, YAML attributes, reuse caps enum (Jiri).
- use uint instead of u64 in YAML spec (Jakub).

Changes since v16:
=================
- rebase against net-next
- minor whitespace changes
- updated CC list

Changes since v15:
=================
- add API func to get netdev & limits together (Sagi).
- add nvme_tcp_stop_admin_queue()
- hide config.io_cpu in the interface (Sagi).
- rename skb->ulp_ddp to skb->no_condense (David).

Changes since v14:
=================
- Added dumpit op for ULP_DDP_CMD_{GET,STATS} (Jakub).
- Remove redundant "-ddp-" fom stat names.
- Fix checkpatch/sparse warnings.

Changes since v13:
=================
- Replace ethtool interface with a new netlink family (Jakub).
- Simplify and squash mlx5e refactoring changes.

Changes since v12:
=================
- Rebase on top of NVMe-TCP kTLS v10 patches.
- Add ULP DDP wrappers for common code and ref accounting (Sagi).
- Fold modparam and tls patches into control-path patch (Sagi).
- Take one netdev ref for the admin queue (Sagi).
- Simplify start_queue() logic (Sagi).
- Rename
  * modparam ulp_offload modparam -> ddp_offload (Sagi).
  * queue->offload_xxx to queue->ddp_xxx (Sagi).
  * queue->resync_req -> resync_tcp_seq (Sagi).
- Use SECTOR_SHIFT (Sagi).
- Use nvme_cid(rq) (Sagi).
- Use sock->sk->sk_incoming_cpu instead of queue->io_cpu (Sagi).
- Move limits results to ctrl struct.
- Add missing ifdefs.
- Fix docs and reverse xmas tree (Simon).

Changes since v11:
=================
- Rebase on top of NVMe-TCP kTLS offload.
- Add tls support bit in struct ulp_ddp_limits.
- Simplify logic in NVMe-TCP queue init.
- Use new page pool in mlx5 driver.

Changes since v10:
=================
- Pass extack to drivers for better error reporting in the .set_caps
  callback (Jakub).
- netlink: use new callbacks, existing macros, padding, fix size
  add notifications, update specs (Jakub).

Changes since v9:
=================
- Add missing crc checks in tcp_try_coalesce() (Paolo).
- Add missing ifdef guard for socket ops (Paolo).
- Remove verbose netlink format for statistics (Jakub).
- Use regular attributes for statistics (Jakub).
- Expose and document individual stats to uAPI (Jakub).
- Move ethtool ops for caps&stats to netdev_ops->ulp_ddp_ops (Jakub).

Changes since v8:
=================
- Make stats stringset global instead of per-device (Jakub).
- Remove per-queue stats (Jakub).
- Rename ETH_SS_ULP_DDP stringset to ETH_SS_ULP_DDP_CAPS.
- Update & fix kdoc comments.
- Use 80 columns limit for nvme code.

Changes since v7:
=================
- Remove ULP DDP netdev->feature bit (Jakub).
- Expose ULP DDP capabilities to userspace via ethtool netlink messages (Jakub).
- Move ULP DDP stats to dedicated stats group (Jakub).
- Add ethtool_ops operations for setting capabilities and getting stats (Jakub).
- Move ulp_ddp_netdev_ops into net_device_ops (Jakub).
- Use union for protocol-specific struct instances (Jakub).
- Fold netdev_sk_get_lowest_dev() into get_netdev_for_sock (Christoph).
- Rename memcpy skip patch to something more obvious (Christoph).
- Move capabilities from ulp_ddp.h to ulp_ddp_caps.h.
- Add "Compatibility" section on the cover letter (Sagi).

Changes since v6:
=================
- Moved IS_ULP_{DDP,CRC} macros to skb_is_ulp_{ddp,crc} inline functions (Jakub).
- Fix copyright notice (Leon).
- Added missing ifdef to allow build with MLX5_EN_TLS disabled.
- Fix space alignment, indent and long lines (max 99 columns).
- Add missing field documentation in ulp_ddp.h.

Changes since v5:
=================
- Limit the series to RX offloads.
- Added two separated skb indications to avoid wrong flushing of GRO
  when aggerating offloaded packets.
- Use accessor functions for skb->ddp and skb->crc (Eric D) bits.
- Add kernel-doc for get_netdev_for_sock (Christoph).
- Remove ddp_iter* routines and only modify _copy_to_iter (Al Viro, Christoph).
- Remove consume skb (Sagi).
- Add a knob in the ddp limits struct for the HW driver to advertise
  if they need the nvme-tcp driver to apply the generation counter
  quirk. Use this knob for the mlx5 CX7 offload.
- bugfix: use u8 flags instead of bool in mlx5e_nvmeotcp_queue->dgst.
- bugfix: use sg_dma_len(sgl) instead of sgl->length.
- bugfix: remove sgl leak in nvme_tcp_setup_ddp().
- bugfix: remove sgl leak when only using DDGST_RX offload.
- Add error check for dma_map_sg().
- Reduce #ifdef by using dummy macros/functions.
- Remove redundant netdev null check in nvme_tcp_pdu_last_send().
- Rename ULP_DDP_RESYNC_{REQ -> PENDING}.
- Add per-ulp limits struct (Sagi).
- Add ULP DDP capabilities querying (Sagi).
- Simplify RX DDGST logic (Sagi).
- Document resync flow better.
- Add ulp_offload param to nvme-tcp module to enable ULP offload (Sagi).
- Add a revert commit to reintroduce nvme_tcp_queue->queue_size.

Changes since v4:
=================
- Add transmit offload patches.
- Use one feature bit for both receive and transmit offload.

Changes since v3:
=================
- Use DDP_TCP ifdefs in iov_iter and skb iterators to minimize impact
  when compiled out (Christoph).
- Simplify netdev references and reduce the use of
  get_netdev_for_sock (Sagi).
- Avoid "static" in it's own line, move it one line down (Christoph)
- Pass (queue, skb, *offset) and retrieve the pdu_seq in
  nvme_tcp_resync_response (Sagi).
- Add missing assignment of offloading_netdev to null in offload_limits
  error case (Sagi).
- Set req->offloaded = false once -- the lifetime rules are:
  set to false on cmd_setup / set to true when ddp setup succeeds (Sagi).
- Replace pr_info_ratelimited with dev_info_ratelimited (Sagi).
- Add nvme_tcp_complete_request and invoke it from two similar call
  sites (Sagi).
- Introduce nvme_tcp_req_map_sg earlier in the series (Sagi).
- Add nvme_tcp_consume_skb and put into it a hunk from
  nvme_tcp_recv_data to handle copy with and without offload.

Changes since v2:
=================
- Use skb->ddp_crc for copy offload to avoid skb_condense.
- Default mellanox driver support to no (experimental feature).
- In iov_iter use non-ddp functions for kvec and iovec.
- Remove typecasting in NVMe-TCP.

Changes since v1:
=================
- Rework iov_iter copy skip if src==dst to be less intrusive (David Ahern).
- Add tcp-ddp documentation (David Ahern).
- Refactor mellanox driver patches into more patches (Saeed Mahameed).
- Avoid pointer casting (David Ahern).
- Rename NVMe-TCP offload flags (Shai Malin).
- Update cover-letter according to the above.

Changes since RFC v1:
=====================
- Split mlx5 driver patches to several commits.
- Fix NVMe-TCP handling of recovery flows. In particular, move queue offload.
  init/teardown to the start/stop functions.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>


Aurelien Aptel (3):
  netlink: add new family to manage ULP_DDP enablement and stats
  net/tls,core: export get_netdev_for_sock
  net/mlx5e: NVMEoTCP, statistics

Ben Ben-Ishay (8):
  iov_iter: skip copy if src == dst for direct data placement
  net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
  net/mlx5e: NVMEoTCP, offload initialization
  net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
  net/mlx5e: NVMEoTCP, queue init/teardown
  net/mlx5e: NVMEoTCP, ddp setup and resync
  net/mlx5e: NVMEoTCP, async ddp invalidation
  net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload

Boris Pismenny (4):
  net: Introduce direct data placement tcp offload
  nvme-tcp: Add DDP offload control path
  nvme-tcp: Add DDP data-path
  net/mlx5e: TCP flow steering for nvme-tcp acceleration

Or Gerlitz (3):
  nvme-tcp: Deal with netdevice DOWN events
  net/mlx5e: Rename from tls to transport static params
  net/mlx5e: Refactor ico sq polling to get budget

Yoray Zack (2):
  nvme-tcp: RX DDGST offload
  Documentation: add ULP DDP offload documentation

 Documentation/netlink/specs/ulp_ddp.yaml      |  172 +++
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/ulp-ddp-offload.rst  |  372 ++++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |   11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |    9 +
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |    4 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   12 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |    3 +
 .../mellanox/mlx5/core/en/reporter_rx.c       |    4 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |   28 +
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |    4 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  |   15 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |    2 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   34 +-
 .../mlx5/core/en_accel/common_utils.h         |   32 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |    3 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |   12 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |    2 +-
 .../mellanox/mlx5/core/en_accel/ktls.c        |    2 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |    6 +-
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |    8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |   36 +-
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  |   17 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 1118 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  141 +++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        |  355 ++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |   37 +
 .../mlx5/core/en_accel/nvmeotcp_stats.c       |   66 +
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |   66 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   29 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   71 +-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |    8 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |    1 +
 drivers/nvme/host/tcp.c                       |  540 +++++++-
 include/linux/mlx5/device.h                   |   59 +-
 include/linux/mlx5/mlx5_ifc.h                 |   83 +-
 include/linux/mlx5/qp.h                       |    1 +
 include/linux/netdevice.h                     |   10 +-
 include/linux/skbuff.h                        |   41 +-
 include/net/inet_connection_sock.h            |    6 +
 include/net/ulp_ddp.h                         |  321 +++++
 include/uapi/linux/ulp_ddp.h                  |   61 +
 lib/iov_iter.c                                |    9 +-
 net/Kconfig                                   |   20 +
 net/core/Makefile                             |    1 +
 net/core/dev.c                                |   32 +-
 net/core/skbuff.c                             |    3 +-
 net/core/ulp_ddp.c                            |   51 +
 net/core/ulp_ddp_gen_nl.c                     |   75 ++
 net/core/ulp_ddp_gen_nl.h                     |   30 +
 net/core/ulp_ddp_nl.c                         |  344 +++++
 net/ipv4/tcp_input.c                          |    7 +
 net/ipv4/tcp_ipv4.c                           |    1 +
 net/ipv4/tcp_offload.c                        |    1 +
 net/tls/tls_device.c                          |   31 +-
 60 files changed, 4272 insertions(+), 159 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

-- 
2.34.1


