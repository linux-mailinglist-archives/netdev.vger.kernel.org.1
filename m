Return-Path: <netdev+bounces-96442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B3D8C5D82
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 00:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5528DB21361
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7E7181CF9;
	Tue, 14 May 2024 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SFsVvN7k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Soi9tD2W"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFB181CE9
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724766; cv=fail; b=kMKincarfzNH4L7Rxx9pcQK0SU38XDMqzQrVnhwS3FvkXBWmx8BRVVulUnTzgLvBBPW2NKTM2eBOjt/hh0GqasC1FEElKWiR4XTswxnVQ7Io3Vie3ojNTN8pk2+nDjsPiaZ5Ixc2pvdCAUMdfXhrshHLNgzX+x/UDTE+5fOXPtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724766; c=relaxed/simple;
	bh=7flsSqbBDbPaJJqhPIR4gzSI/Y6coJh+Zq5u/5cDA5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tKxVyA4e7ugZ6e4Wen9P65PimJ/QX3h6hqw7VosQwXjNINXRkuPhi1c/5Fkw9Xdf4r7HxOOAifM9IeKdjnWPo/9tzegLLJgPD80k6I2Nx2keOoaUpFMdjWqQBmCQ8D/Aj7Nr/y2ZiYOyUehvVor3cPU27O1lmFrXYPdal4AMolg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SFsVvN7k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Soi9tD2W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKXwKY025447;
	Tue, 14 May 2024 22:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=jDJh3rqUy3X//m8oGqJJ4G4M19K9ZSJlazEbGDPf/zU=;
 b=SFsVvN7kpgjdKsfcc3VV544KbM2S4g0VLiOSAqtHmY52HLyQXNzZotOM+rKGkZAio2gH
 /vKZ5ffZtIL4Xu8pjLkrQFGA0zkbjc1I+miZSP4EmPM4J2eA71KNdNTdeD3HsSIGFoRF
 b15EOrmw/TpOndPbqXz6bv7ka8eMXCpIN+iaPekrkSZK+Xi4HYfD9Ay/t6CW1AeCdwK4
 WZW6rerKuKAVBH4z1uQ5JyZCmxkwfC89+IAHfUNgAD52yx/JJ+QGHGaxwr9vi+NLx5Ld
 KBG7cjNNJwDnnfW9jJwCMfFjdyrxAQExFuecpfKkZ7U5kI5gLiAitpDQIS/4divULpDC og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y4c8r0xg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 22:12:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44ELrOnM005717;
	Tue, 14 May 2024 22:12:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y47wxhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 22:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeIXrs/tiVgD5D+oiXFGnYllKT61T/Ri59F/9cj8gePLYy9eH9NPwbOHqkJubyl5FlQi/c2xXxBTshVZ6iy84HWfGGZMQfr4YCX2l7J3M8q56RCmMfiAJIQ+IIT0OBIXSrVjm63NzZsgc4TOSSgvxrvQajo6syReeqkQ9hFCSHZMWQqFmoN7sqOCFC9iPM+X4hDUkyzph0qZ8HlgqUbNP0Opqb92CeOPWAe3kNR0PPfNXjdBazBnkUBa6JWkbrYTO/f+FT+AO8nt6LIqcFlKz1tEC77hL0vjz4N7PvKG50fxUwgf3ViHNw3/rVxbODvNe3DfQp+3V6s03BKcNLjj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDJh3rqUy3X//m8oGqJJ4G4M19K9ZSJlazEbGDPf/zU=;
 b=FHjxP2wLPWzWbsatUMMTrY0tors8+eERYh91dZNdJfzKHoKcOxoRCEefirMJ0xsBV/SHIjeIqjGLrzDrLDpbPOhvsGf/M+g0iDnjU54DWtW+0ntRuQlmHlKYqK8dmxe0SXOz76v2knpI9qHXgSD9tciBjea+JJxLsqEk7sJ1pwmizqK/3v6UBgoCYjawJiGLMVBXG08P/wu5GyHqN59RwuUa4z+3ws2yxCo/enydKxsu8u8SusTbqYQjSyuDQ/6Wogyy2nJHE7GP2Ew0Tts84ZbjwfNf6J7nZu5K1KDFrvUv1ToD9nrTGFuTcxi/el686AXa9GU+bZAtmEzkR6+0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDJh3rqUy3X//m8oGqJJ4G4M19K9ZSJlazEbGDPf/zU=;
 b=Soi9tD2WzhS4KpLNsjA1OKGITTkAKI9+LOjMDBCz/U3Ad5xTjZSYEK4ljEifn5/8znLBS8iLkKj9UQaFsNUrTEGogltHWswkcqe/Ohl/wZBFPer25ANA45YATbbLXVhZeQXq28TVZKlibVsUuJqFxWJpvjNfDasgc6m5qmCrRto=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB7585.namprd10.prod.outlook.com (2603:10b6:806:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 22:12:28 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 22:12:28 +0000
Date: Tue, 14 May 2024 18:12:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        netdev@vger.kernel.org, Arjun Roy <arjunroy@google.com>
Subject: Re: [RFC] Make find_tcp_vma() more efficient
Message-ID: <l3abhimtyv24oogb5l2is7hml6fcs6vlthbd7n4rmnyou24e5l@capndvics4kt>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Arjun Roy <arjunroy@google.com>
References: <ZivhG0yrbpFqORDw@casper.infradead.org>
 <CAJuCfpHxpZVnpM2bE25MeFK7CrSsO_pGaYuwVNzre47bb1Jh_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpHxpZVnpM2bE25MeFK7CrSsO_pGaYuwVNzre47bb1Jh_w@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d575e17-ddbe-4457-735a-08dc7462f165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UHpZdjBvTTdybFMyY2pEWFBrbUtmc0hpNWpTKzVIb2FmQ3dBVXcrQ0dEbUNI?=
 =?utf-8?B?QUpzdUl2bW1vSGw1WDhaUHdEZ004blEycXpiejhpM1hwV0hxTk5MclJhb1ZD?=
 =?utf-8?B?YkR0UXFNSnJ5Sy9jQ3VnVzBGMGlOYnk4YU5YQTZaYWF0Nzg0c09nak9FZlYx?=
 =?utf-8?B?N2t0S1BZa09DWUgybFZjUE44YUxkcGxhRGxrUTNsVUxqaWdYQXl1bDZmOGRU?=
 =?utf-8?B?VEVQb1U5U0ZMR0J2aGFLOGFlU1crK2EzMXE5U3pneCt1N2Nydis3b0VmNkh2?=
 =?utf-8?B?aVJIZzhKTjZWTHU3TERWa1c2WlNVRGZ0enlycm1NZnJpeEJBaVJvaHhOTG1K?=
 =?utf-8?B?NTJjVTN2YW1xOXIwNTVYc3hoUEhLSUhCcVhaeFZOSW1kOVNIVzZHSnIzNDdw?=
 =?utf-8?B?bWs4Ry9sOGZxd1lIamVxQ1A1bi9ONmhHblZROVB3NjJRNWtXREZzZk9MckR6?=
 =?utf-8?B?SHkrREN5Y2d5STM5T2pZSDVheURxN2N4QUlTUWUvM0FvQ25RcytvWkdIaVBN?=
 =?utf-8?B?MklNNllZS0paTWVFOHBxSlMxOVVmSVBkRUFJVXZZZ2pnb3dlSnRDQkN0WHor?=
 =?utf-8?B?K2ZqWGZ2bHR1NFlPUzlrMlR2c1dBd3lGeEJaeVRhVmN1N1oxV3M4RDNseGdD?=
 =?utf-8?B?RzVySDE2MjJSUkJxVUtmalhIaHVtQ3RlZjFpRXhob2F3OHZLZnJzbVFpcEM1?=
 =?utf-8?B?MmhaZDYvdXR1S241MU5YZlJLc3ZZOFErWkNuNjhSNWhrUUxQMlRML0w3TWJu?=
 =?utf-8?B?dEhQTk81WnRIQUE2Zys1MWhCNytNOERKanI0QzhPSUJTeU5BNk14TEdhdzdz?=
 =?utf-8?B?T3NTQ2MyYnBKUmdqWDIyUXNsM2Y3T1FOOWNyMjZSZHpIRkVpZzVQc2NJUXlI?=
 =?utf-8?B?YUJ0ZWNjSVB0NFFNZURDbCswR0xQYW9pUkp2MVVVT2p6TEdNU2JWRXh2dzRP?=
 =?utf-8?B?ajZkNmovQnpDY214SW5QNVFJaWkyS0gxTjdLNWdaYjEzQlNUQlN6SWd6KzlU?=
 =?utf-8?B?UmZMZVNCekZuM25oQVUzZHNpSzlOZEE0eE55L1pxcER6U1BPUGFZcXkvMUUy?=
 =?utf-8?B?bC9ScTErdVh5enZMNjBaWlgwUksrMWtqcVdUa0hkUDg4bVI1cFlKQTlVVUxx?=
 =?utf-8?B?UFlYR3NTQVlHbEpidXU4cmUxbFZsUjlWdE1HbW11RzI4REJwc25iMDNRRGJP?=
 =?utf-8?B?V3dzL1J5bVFpTlc2ZGd3aVl6ZkljUVJuNzlQWVdHMjVtME1WS1NkQzBlelRY?=
 =?utf-8?B?K0lqd0lmd0VzWkFKMHZ4Yk03K0gxOXNjTWJHSlQyWnhhYjE3ejIyOXpXdVJC?=
 =?utf-8?B?U0FIK1hMQm80MWdad0MwNFRoZGQvREp2eEJFR0k1R29pRjA3MExVY0s1d1ZZ?=
 =?utf-8?B?MXpMUnphTW9GemhZeGhnK1NEcW9rdFo2V3R1NWZxZWRDMEVvU3ZEdkRqVGF2?=
 =?utf-8?B?bFd1ZWtsTDF5MkVtbWg3ZUphUnlvM29jSTlpc2xqOHhDQjI1SW5tendpaGda?=
 =?utf-8?B?TGhHTEh5N1BOeXNHQ1VyQ3c4UHR6cFJlUjlob1FmOHVhZENZME9wRTJDQW5s?=
 =?utf-8?B?RGV3WGZYR1A5ZkR5Q0hxSytQdU50K2h0Z3Z0R0s4MUJ1V0lma2c5TUxjWFRm?=
 =?utf-8?B?NVNzc2tPSmlMNlNPNEVNL2Noem9HT1RsVHl2OVBmWTBIdGZEcFNnd3VMcTBl?=
 =?utf-8?B?UHQwVWhCaVF6M05kdFhEaFE0RVFibm5RbGFRdE96MFBJdGg4cFk1QStRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckYyb0c2Zk5qMmZBcTBmTnhCOUFuUldUOWZrdWIvMUJwc1g2VGExRldiK05i?=
 =?utf-8?B?ZUw0KzZmcXRhdW1aZnpWWWZQR0hxaTM0UC9HNDZEVHlTK2hrNjVySzJQUE9I?=
 =?utf-8?B?N2xjNVNhWEhYTXVwTkVaVUZCb1NmQjlZaUNBaXJ6SDdZRlEzeWxLbUJIYmlw?=
 =?utf-8?B?ZjNYZzFZWTdEUDIyeEZWWk5iTzNkM2VXZXVUeXFMTWt1RmJRMTQ1NisxNDVC?=
 =?utf-8?B?S3AvQzRMaGZjNURRVHpUZ244T2pWUkJPOEpGYk5sby9GSVFzU2xRTmlOV1FW?=
 =?utf-8?B?SEZIUTJKQzEzOVQzbTAxdi9VcklRN09adFRNd1czUHhFS2RielVlTzRBcmZa?=
 =?utf-8?B?WHVSL200MWM0QThvVXIxSU5GcjhZZ0VVVStWTkQ1QmpQOFRlUjVvTSsyaWhj?=
 =?utf-8?B?N0djaXdITUFmbjRPQmpZZDMwOTZTTjI1aUoyblcvSDJvU2x0emxJa1J4cVd2?=
 =?utf-8?B?eWxVYnkzaitHbWhOWGtJN1NRQSs5a2ZTMHRWeHNzeC9YeVNqVWg2UE84YlB5?=
 =?utf-8?B?bFFmRkw1aGxUNUIxcTkxa1dHTkN0OER5bW1rTUtHUTZWc3BlQkFNMnFUem1j?=
 =?utf-8?B?VDd1dFZoR2tWU3oyTGRwY3lzdEpWZGt5SzdKdmkvZUFNMmNWSWR4TjVqRHBz?=
 =?utf-8?B?WEZGSmZuWDVoRnNRTUNIMTdKdlRnUnlqdit3dTM4Nk9FcFZNYXBGaDVFOGxy?=
 =?utf-8?B?bmNzTDdIeW5LSE43TTdxZDRHUGFpZTB4aVRxdlB5eFhLNmszSmhFUDlIOFJ3?=
 =?utf-8?B?TkJxNWYvVHBJMDI1YkdHdjZYdUljSzRmM3hpaXVJcUQ0RUdJcHd4QmgzdGdJ?=
 =?utf-8?B?c3ZEUWRyVmdLSnR1c2doSVA3Z1dmamJTNzUwY3owMCtkaW8wNWoyS1B1Vkk2?=
 =?utf-8?B?Q1c5QlNxbUxSc0tyZlc2QUp2NHB3NTFkcUpHSUt6aXpBNWxBeUhoeEFySWJ3?=
 =?utf-8?B?Nm9xSmo4YUlDcmdhVFZ6ak1CTjJ4cHdpQ3ZLVU90YnhLd1lYZndEVE5jOGtU?=
 =?utf-8?B?eXNFSFM3Wi9oWlp4NzllQnNqT0h2emlXZ0JnZFhRaEJ1OEdWSFpBSUZ1NzdC?=
 =?utf-8?B?dlJFSHhFS3JGekM5VjAvaWRkeGJHcWdEMERkMUd5ZEFLa3hUTmpCSHRrZGdN?=
 =?utf-8?B?aTJlK3RYS3pSdTJtcXdRR2dqRmJsSW9iRjFZNERYSE90RGxaRWcrMm84L0Fa?=
 =?utf-8?B?MkY3TllzZlZ4WUxRS0hjYkVtQVkvRkcxdWViRDVPNmlYWjhZSHFhY3pjUkFE?=
 =?utf-8?B?MUR2NjFxMEtaVkx5N1AzWHppSHQ0NklVNzV1d1pwMTJWQ2lqc0tGdE9OU2cz?=
 =?utf-8?B?MmxGanVPbzE0M2NUZWIzU0tUNUVQWmYxeENySmNJM2Vqd3RhR2QyRi9DQkNa?=
 =?utf-8?B?ZXhocGtuR1dDSTJLN3hSOGlvVjBkUFFNZk5odWt4T3lyRXBZK09vb0Z4dyt1?=
 =?utf-8?B?bndySHNJSTNpS2lTaHMzZUlwVGJxTU4yZG55a1VGSCtiQUM1V2lJTTRON2tL?=
 =?utf-8?B?TVJCMTZvVjE4WnhyUjZDNUNqWkVOVXJoQndSQ1ZPbWJiWFk0WGZxd0FVN3la?=
 =?utf-8?B?QTIydTE5V1JTMzU2NS9uenovK0ZRUUsrdVFZd044TGlYWFJkODVsWVR3Rm1W?=
 =?utf-8?B?eVdUOThMcUtZNVMzTVNzVXZRaUZoWUFBSUU2eGlhVFlrdmhvLzhQM0NlREpV?=
 =?utf-8?B?MEswVWY4U3NvZEw2QVdqSUxzYVNERUJ2WHlSV2IwMFZkd3ByRStKb0xOeFZG?=
 =?utf-8?B?ZHFsU0VncytYUThZUU1FdkRpQXJxalZrSEFPSmNRWStEajVTU3dOeW85bmtq?=
 =?utf-8?B?T1p1eVA0U3F5b0ZLbjJKdG50cCtvVmVIUHBvVFZMQ2lhUnd2c1dpZ2cwajdS?=
 =?utf-8?B?MElyV0szMUU1cmdoUkNZM0FzTGtQNVZlVDRvV1ZtZlNzOW96V0lndFV0SGxi?=
 =?utf-8?B?VEU4N2lDaHIrK0pQWS9lWkFheVhVdzJ5MVUrY0QyeHhVbmVHSEUzOTYvVG1M?=
 =?utf-8?B?SDZ4YlBCS0dSYURUQ2xRcGVuMXZNeit3S1Z5SE1xajM4MHpzUkZHSHlMMVBV?=
 =?utf-8?B?KzFyK0dMTXIwZlczcGp5cjB4c2FkYzEwZS9VQklZU0lWOXVkMlF4RVlvWUEx?=
 =?utf-8?Q?O59+G3YBPVj201xXbduNv+jQP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tQknxHGOFfws+pf6d3cG57FkDBH0+UoGk9BrJCbGMQcMZXAgw1RjIXXkEee1tA3HyYQSA0sI6iccRb7GtY7bVZn5LenigWt12NyXjx8UIyTYllzevbZh9h1F8r7lG3hRGrFrbqFaHdetbh0/qG6vxHfr2/qW4djkpmc3iYdET8EzuX0XxHObXkXqLEOi4jYn5bvAxb/XGuV8MZcNU+I/iimi8fQ1iZKq27DxdUzzqDE3xBIecqsDXk2lm7w8WdHAC6ZmRiFBzgpTLErM8cQg577UHbMHf5+edEtwTsbrbfjvT98szvndzc0howuwAsXb+rkwt26OtIRL+pfSTsOsM67zqWu+wogCjlN5unPUAOIqjt5xWnH3IOz4wTwvdkqU6++yHCqt/W2wOSj445MMSWph4WMRiFPwPXQVYl4fSWHlbfViwRRF7vs/OV2ty0hWuuFVWGwXdzJE0y78s7S6BM/NGIHuqA+zTjhBozcujOQ2OTBIxPPfXYsaAs54OPZ9zD4Ri1ptNpJBAes6He/Jjn4ehrEAJVdEnTofQyqupSRGk/A2dmSeV91bpOoJPylIA+zVB9ahBCpSgCvWINt+q+ipwP2R9vT4RtwoiNF5tlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d575e17-ddbe-4457-735a-08dc7462f165
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 22:12:28.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGyfvRb2zZKZg5bGN4gSSDkhQFmQB+KUkKV50SIQwCrUnY8jvKqQF9rYPNavkHgcKXhIw4D+OVbejWIGDYaIig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_14,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=931 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140160
X-Proofpoint-ORIG-GUID: fNmY3DDydkpYPG0i6YJYqWLRAf5fc-Mn
X-Proofpoint-GUID: fNmY3DDydkpYPG0i6YJYqWLRAf5fc-Mn

* Suren Baghdasaryan <surenb@google.com> [240503 18:29]:
> On Fri, Apr 26, 2024 at 10:15=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > Liam asked me if we could do away with the "bool *mmap_locked"
> > parameter, and the problem is that some architctures don't support
> > CONFIG_PER_VMA_LOCK yet.  But we can abstract it ... something like thi=
s
> > maybe?
> >
> > (not particularly proposing this for inclusion; just wrote it and want
> > to get it out of my tree so I can get back to other projects.  If anyon=
e
> > wants it, they can test it and submit it for inclusion and stick my
> > S-o-B on it)
>=20
> I went through all uses of vma_end_read() to convince myself this is
> safe with CONFIG_PER_VMA_LOCK=3Dn and the change seems fine from
> correctness POV. However the fact that in this configuration
> lock_vma_under_mmap_lock()=3D=3DNOP and vma_end_read()=3D=3Dmmap_read_unl=
ock()
> does not feel right to me. Current code is more explicit about which
> lock is held and I think it's easier to understand.
> A new interface like below might be a bit better but I'm not sure if
> it's worth it:
>=20
...

We could do something like we do in the release_fault_lock(), but
without using the FAULT flag..

/* Naming is hard. */
static inline void release_vma_modification_lock(
		struct vm_area_struct *vma)
{                                                                          =
                                                           =20
#ifdef CONFIG_PER_VMA_LOCK
        if (rwsem_is_locked(&vma->vm_lock->lock))
                vma_end_read(vma);                                         =
                                                      =20
        else                                                               =
                                                           =20
                mmap_read_unlock(vma->vm_mm);                              =
                                                      =20
#else
        mmap_read_unlock(vma->vm_mm);                                      =
                                              =20
#endif
}  =20


