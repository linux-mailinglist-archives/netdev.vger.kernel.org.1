Return-Path: <netdev+bounces-195616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A2AD17B6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9577A43F0
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 04:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E083078F4B;
	Mon,  9 Jun 2025 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pkipP3zS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE4B67F
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749442956; cv=fail; b=QJYC7d0dEPAA241xgvgMaM/fVArja6CCUny6zypzVmalHTUp7yeNJjbNoCDoDJeolgiL4GlNCtHmBMDeahMQ4SCB40JhmVnpNSEDr0zqIjZWWVguYF2Q6lI8H9pL+8HddNanLZ7TJjf0R4cZZ6SmGWFYOcPZpTyV5kNzV15Xp48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749442956; c=relaxed/simple;
	bh=7RZknZMr0d1qQJGYoqfi9hGHu17+eYRhoBHvmE8WpiI=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=pRD3J1Uh5TjTE7x7kG1fE7AGqdjtddMOKV7n2L2eFhPZvDQI7pDIIufCzov4pLu0KqG9uckFhq0EB5BxLh8xgIhmQIkknZhgc2m7BgDM3gBiz72WGKs/e2FCmMuKKZgeupztDvvVtNipHWsHUXOfsBPRAqFiPbvZbATT/ts8AiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pkipP3zS; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55940fiP027550;
	Sun, 8 Jun 2025 21:13:48 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2132.outbound.protection.outlook.com [40.107.243.132])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 475m9d8bqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Jun 2025 21:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njDraMNt+uxx8stl6GW5+AMNI8wzxi2i86PQJRoN2g2RH6FQXhSyVuEwbdqZh72bRtjnOVO/SddZoxbfdXJdG/6hn5xstQdkVPkeLfD2WvZfB8g1VcD5+NBaoKU96r9g40dxFknAYwBZ/CpbhI8SIN0+acBaE5Us6Y6sT78+H3rZ6NFaxjpzjrC9/sUd72pip1Tzr+84fglCOEnHQspPRBzNz9heoQPQBUpVOvnc2zqstjetLYQJmM1B3uZcYutTjntwjWGlyUydR066vXSUF18LVN5E6UAU3ivAT8Tlm6nOEMtgA47+Ue570QzJcbT/rL0p+jxUNdExTajGojE+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RZknZMr0d1qQJGYoqfi9hGHu17+eYRhoBHvmE8WpiI=;
 b=ePl4mf7SGUKeyH03fILu3PoV0UPbXfFxfZwhIHxoKQAyb4xsgT/B71a2uDlHOGEhseYKpF/w0hb7+IdMNaRtFMc3XmIwZgbx2rscJs8GoIST+4gu8AWDYwBGhWCVFqzYgSf8CwMToSxypc43Pl42r9r9cbJk4Nqz/fch3Q7CSzTiAEDAslaqj939hL11Kb8OIxB043Klv0CHPKduv5Yv5lx0MhA3zETBmpL78kAcRqr1V322daE176w779qUDiygsSnBSmYHcA/NRTIJCXKGIIbDOLQefrp0cLRppNGgLcVJYYu2vREZvBByQFZz2lZM+C4iJ1xh7ptkPq8PJFFydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RZknZMr0d1qQJGYoqfi9hGHu17+eYRhoBHvmE8WpiI=;
 b=pkipP3zS0zk7IpV6HSo9NbwPxc+ZlrM+jRam5zmUBt+Lee8omF0KIJkadNzS6ZPdK3NQ8i9FPpp7uINREnn/O7bap9dVktI9nrzfEN3xXKkb92eHayxseVO5P/tbGs80EyQ82no6KsQqVid7BIoyrLx+FRhiGf9SkjjcZJA3uw4=
Received: from substrate-int.office.com (2603:10b6:f:fc00::aa9) by
 DS4PPF7EE294EC5.namprd18.prod.outlook.com with HTTP via
 DS7PR05CA0058.NAMPRD05.PROD.OUTLOOK.COM; Mon, 9 Jun 2025 04:13:45 +0000
From: Aakash Kumar Shankarappa <saakashkumar@marvell.com>
Date: Mon, 09 Jun 2025 04:13:45 +0000
Subject: Recall: Re: [PATCH] xfrm: Duplicate SPI Handling =?utf-8?b?4oCT?=
 IPsec-v3 Compliance Concern
Message-Id: <Q3AX2MAKDQU4.SX8SFRJIZ1CP2@bl1ppf25ef7e22a>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, akamaluddin@marvell.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: 19867a7e-8937-81b2-a5ff-d593ae425681
request-id: 19867a7e-8937-81b2-a5ff-d593ae425681
X-MS-TrafficTypeDiagnostic: DS4PPF7EE294EC5:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnNiNGQ5eWEwdkZEdTRZam42NkQvWlZ2YzV3R0Y4ZHdOQm9kZnM3ZjlZb0VG?=
 =?utf-8?B?TG9YNWtTTC96QUhYRE9mMmpaV1ZXb2J3NGwzNHNEcmh3ZDZnTFBPWUo5bjhz?=
 =?utf-8?B?ZU1ZZWNZWFNvWFplcHo1ck9Cd1FiMVVmLzluZk5PaTlGMURlVDlxdElKM2tE?=
 =?utf-8?B?QkRJaVRjcnlIVXZyb0hYeDdYQVhjRDRSd1Ixc21LNWlnZ2w3L1dZZ1NDU0Ix?=
 =?utf-8?B?bUh5YjJWMmZKU0NyQUY1REZrZitETVNvNEVEZVlyTDNjNGp5ak1hMzk5RzJS?=
 =?utf-8?B?VzJFNVlGUzBhYk1iYzFGSmVlOEFjSVZZczlTY0p2RHdOc0trbU1SZXR4c1Az?=
 =?utf-8?B?RzZ4WnIwaG8rTVpnTlBFM1U5Qkw4UEJxMy9CVExCejNvUEk5T1JJelplQXFv?=
 =?utf-8?B?b0lwR05ZQ2ZyeUR3eTBnTDlsc0JQM1VSdVdnS2hKWEpWMHlCeDlsb3BaZzNk?=
 =?utf-8?B?Ym9nUUp2YUJXZGN1dGhtbXRyWHVSNkxhcjBweEhhWXArNnVISW9laWhqYi9P?=
 =?utf-8?B?Nld5dHd2OWZDNXhiemw1M1pkWGRaSHRWUm4wamhsaXVNUDlaUE4rOVZMSWlv?=
 =?utf-8?B?SFVkOHo5M1RRNHNYQUlVN21LQkJ2Si96QjVjTmt0ZEhmUXRQK0JPNmJEa3py?=
 =?utf-8?B?aEFrOXN5dGtvRWppdW03NkdwbzVxZi9Kck1YV29Na2NiOHphVHpSSldkUVF5?=
 =?utf-8?B?aGVsczQ1cGg2Z3pvNldBNDY1MThyMUdzME41dnAwU0hNR1hpdVp0czN5VTBN?=
 =?utf-8?B?WEt3SzJETERITFRCaUtNenRqRVRGM1o1RzZ6L1gyQzRpVi9MdlgzMXdmV3dM?=
 =?utf-8?B?RCtkSDEraEZvMmNPYXF5SUxXMTBKZ0phRVlLTVNDdUJ2RUVZM3U2QXd3ZERK?=
 =?utf-8?B?Z3YvNko5cDBWZDlKMElOc2RFRGJ5SFRmeW5INUtTQ2kwZ1BNc2k2TFE2Tksy?=
 =?utf-8?B?cjhoVjRNSzJYeTNRVW9FZUoxV0x4dUQyalYrQWRDUVJrdXg3R05vU0RTelVo?=
 =?utf-8?B?TitDRkRHUGJRK05sUHhEVi9GMlE2ekhqQURyamJtUEgzV1FmVmV0azREYkhs?=
 =?utf-8?B?bnBBWE45aXU5K0VuYUdjZ1dzL1ppK2R3R2lCRGxDTyttczZucVpHL1VTS0dU?=
 =?utf-8?B?WnNnNVNVa2ZrUngvWDExTmszZ0lZK0tQanllT0JpZ3hOOXo5QWlPWDE0SStO?=
 =?utf-8?B?aTBsWXlCMDVISzN0YWE0Wlc0eWZhVEh3Q2cvRWlHRjMzRUUzYXJrWXc1VWdi?=
 =?utf-8?B?empUM05KK0laa2NIQlMrK3FDd2tXMmQ4eVo0Nk1Dc2gzUGloS0dFaEhaTE13?=
 =?utf-8?B?Y09XK05sVUQxa21ZeXh1U1VrakNGam1Qc2JKUmZaQXRnS21SSWxFL0xDY1Zk?=
 =?utf-8?B?Y2pLQ2E4RkpkMEtadU1menAwZmM4dE5RQk9OWXdTbnhTWEdBQ3NmTSt3VENR?=
 =?utf-8?B?K1NHSXNEdzZINE12b0FMMGFNOVNwTUhYWDl3d3V0MlhTUTBVVjdOMm52ZFdH?=
 =?utf-8?B?bUc2WlluVWRLQ2FQcy8zYUQ4dnBSVTJ2VmZiTG1RcjhuSU1MRVkrSVR6a3pW?=
 =?utf-8?B?cTVHdTVyS1pCZERkcXBUS3dGVkIzdVhOZW9hMkJQNnQzazBmZFJmdDV2T0t2?=
 =?utf-8?B?Q0ZobXluN1lMVkJUdmNhdTJ6MnptL1B1bE50VU1CaTRuRWF2UXl3UTZhZDZl?=
 =?utf-8?B?L20rRytaRXE3Z2FaeVdRZHpncFQ2WEQyUmpseWlNT0JZclQxOW8yMTM4bkhv?=
 =?utf-8?B?NGxXM20rOS9IWEZNWE9aRFZXVXNxRC9pWWw3UHpRUTgzdHpaeVJ3ZUZPa2R2?=
 =?utf-8?B?MC96cy96bEcrcy8rK0pTK3laZFVGSTZpNytYZmFzQXFZekhWWDFWQ3o4TXBB?=
 =?utf-8?B?MUdYOEhmcHBwREE1YWhidG5BSUdMckhxR1NwY3VEQ0dnLzFXUEdvUEhRUU9X?=
 =?utf-8?Q?cgzmOSc4RoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EClb306iCOSkPUCVG9uF6R/fm4ZNum9wT2U/2ILpco8JXw+WxhE9boMMq2FsISvTfhDN948CnqfIgjhIW8t/zjgcfQh4xeZ7uncCxLZSZdxDszccCtuYTBo0lIwllPjPAA4bm3zaFbeuAtqf29WeGOajUZjTXY9Ob92g1Ix0sdAkEmxwMvUqrZ8TzCXaqEMUUydD9qYcaOCbwY4G9iSVb2ZQpxr8TEXlQ3ivIZPNdjIYTbUzya3LHEUIA9aZRzxLYRbY+8ptPPKuU8NwyWuFWJNNxyc5RKN9I2cfyyMwzrjB7LijQJeFSFStHk04ik/JoNxUhpxwtZ4nwcjF+U7JNEJXpGy41K5QhEW5r7xmFQa7YZkDfo9zPeoJIfV8mpizQohcWzr4zqtHn84Xcf1Fw7lyW1aDdjZ5YZLIrhoGZe0=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-DS4PPF7EE294EC5
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 04:13:45.9417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id:
	eb7ec2ef-83e3-412b-f3ed-08dda70c0747
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7EE294EC5
X-Authority-Analysis: v=2.4 cv=LI5mQIW9 c=1 sm=1 tr=0 ts=68465f7c cx=c_pps a=CixL6RxEtn7Qem6gLs8pAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=5KLPUuaC_9wA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=WvMNB7J51JmsecufNMgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Dah5q-dcpJ0A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: otliwEuRIv0-649lcp69rqnjusVUBsfw
X-Proofpoint-ORIG-GUID: otliwEuRIv0-649lcp69rqnjusVUBsfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAzMSBTYWx0ZWRfX6Lv1pTVfmiHt Rpo62BXI+wnUISvNgDnvf/pKOkZ6Ng7Y/H2M/ZmOrNgu8vQhtQIzU2ATySqVWbTUkgq9mR3pKog yU+/pzx1zyGAJY8i55LQ2spFIaVYcHFFxCl9gumwOdItj/xhWdujcC+EPUKBnQuhT8O9eqzv1Yg
 fym9Q5Y+pTpE0ztriPhLxXFvjdKvil66DQxH7YLEKMUnzl+Nl2ufY3bVe3vnpPugyB0sTDkKB0W qkgwkbSU6t5RAQ7km/4q7JyUBd9TSaL6ubYu/YqEz37dmPQ6as2ZOWVe1fbu5ZArJ4C8pZsRooG WrNpyKLoC3PnFVUu7k6youkpPrmy7xG8wjsX7VJ+Aq33i35JHXIgWZTbNeZjzf5jiZl4QgrMabq
 qH772QUFn+SNSTr1pDumGiBKgsW2hEuqAvfBwYZtG4S46RnfLx5aM6ix33sV74yOrzEW/LkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_01,2025-06-05_01,2025-03-28_01

saakashkumar@marvell.com would like to recall the message, "Re: [PATCH] xfrm: Duplicate SPI Handling – IPsec-v3 Compliance Concern".

