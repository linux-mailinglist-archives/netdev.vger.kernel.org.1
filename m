Return-Path: <netdev+bounces-88493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5F8A7768
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010F9281C8C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF806E61A;
	Tue, 16 Apr 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZA8x+Gfr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z9YPTn4+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FDE17736
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304891; cv=fail; b=DpIjwleelm/ZLdIoLlc5BPL1Nxf6CBQae1O6WtUCi3L9mmy4CytAyD9HLdwNeHc9Xb11PRXJl7khGasuZXi09Q4TdqDlHeNlVyX5Y0H0/TsTZSDMkKW3IiX8AJVH0MFMhsbmYK/w7AAcFwNd2gLKKcdih9QD5kMWUNcjjGCOE80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304891; c=relaxed/simple;
	bh=gs074RjVFkFsSYlMTEwxF39cwLZUYnFqJIWf1nLvnTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5zPwuY+no0KUpAaxA0NX8c5FC1wlCcL6uBw45xQ9A+ph0Sr+apvgvg90bnGWG0CdQo9VWhx/N+3OYn25yCYbTt/UDoRfZRq2sRJoxSStf8e1VdcJcJUGPnsku/UgZl83XsVMfJK5KR8sjbdsublu9RY9pHkt9YSor2JHWIS1wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZA8x+Gfr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z9YPTn4+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GJjuhI023989;
	Tue, 16 Apr 2024 22:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h2+eBdulcEN/+31Yfi+AJv/7f78FNVNVhYLvJyfd3mM=;
 b=ZA8x+Gfrhvsv/p0/5mMkvLaUSuKS+xYnM6VJEZWo1NRriJA/af1XVsbBFbXR07XIjnFN
 hglLCi7rD2zzQtIszUveApJc2mCCffVjOGt6wGf9L5yiUIOZdsJzZDYPFwQI5YvEWtmX
 jAm6CSgcSIHlTRxeBsAI96KIzGyK8gIe/szcNUk0X70uOjOMPiKCdbekz5IfPihAVFtz
 EatrloM5yvUEcwUijAlXWGSoAjRsD4d2pbiSR29BUHb6WbGYntg5k8hYu2Fr66P48yQC
 UO9FG0LSfvJZRk8CTKlc8/ec9J6H95/1XzL8RLLJnkLK+wiRx/Hj4olQ+61qQQPfFmfz oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffefqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 22:01:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GKOcrm004389;
	Tue, 16 Apr 2024 22:01:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgge5gkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 22:01:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSUF4/uwWcavuC1mkYGnqqxaJIKRWu5Cld1TLFa6NCDv5l6XvoUGtv9lHlFdTz+1g2z+XESDxhGuj6ByxXaL6+677qxBfNmA+3NTx1/xubsdOUlTJzsv8e3rUJ7eyNGkVz6M0ARlMn73lcShzbYzYVaF9tHOxtK55tVZ6em1emt4Qsj7dCr2/w34SXAJ7V8s3Bkz3GFqJEvXA4NUoc4TkLFO+vrew+J693z1b6aZmZuXbVa7ikFbH/kk+2fkfBsHR1+RPZo5+UwJvYTI/JLOvQiFNYeXV7ZmSqAzT8psMTuok1iSIsq/tu328wV6eMad1NcgDffRyjVgpqWoqq15uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2+eBdulcEN/+31Yfi+AJv/7f78FNVNVhYLvJyfd3mM=;
 b=Dit9N2bkFlAUzgnSDTBuygNo0NcWfLSYFfiHTc/4BHjLCS29H4stIEUaGfcIBbsvfamAdmcwNP72aFZI4oicnVsFoqnaSZYC/nXctGxIhEbMRO6eK1nq7aOHb2S2hAIE3lfjtTteVhP7B6RXk0Q19FELXFJYJ0l2cOxZDi3Z54bgLSQo4h8W/8WNEu/osImCqBqljT+Amqe8y1RGYZsmmsEsUuYy2R2ikrfAL49PKNX4P6HWwJDxT1/u+hmgDRMARnwpq0BgaWR/fHJuSriqSLaPCFozb7U3OtUuyi74BBks09VaJpWsmSFJrXIukpF1EtG5VnSncbsO7zMjppEEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2+eBdulcEN/+31Yfi+AJv/7f78FNVNVhYLvJyfd3mM=;
 b=z9YPTn4+5VqoLmOOCUCJV4vDbwY6sA/bmdhi2YvKjjpPYjRNPuX/ifEoM7Wa6RiUNjW9vmGACScGTYwaakgkYR2xbud9gOAZBY7T7lgMTplw+bCv37dCK3wnzRU4KwxRvGDVHyDlMEuUc8UzW0ui+NlESy2JVXoNvxBKrYA8yrk=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 22:01:16 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%4]) with mapi id 15.20.7409.053; Tue, 16 Apr 2024
 22:01:16 +0000
Message-ID: <dc42242b-40f2-4be0-b068-62e897678461@oracle.com>
Date: Tue, 16 Apr 2024 15:01:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/2] af_unix: Don't peek OOB data without MSG_OOB.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <a7fe079c-5ed7-4ff6-a127-adb34b2246f5@oracle.com>
 <20240416214750.29461-1-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240416214750.29461-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::21) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: ff193904-5c1c-434f-2f19-08dc5e60bd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4PNlo+ZusDZ4MhkpyfJBK/U5gDBcV8q5ZK1l1ciGxXbszOHstGG/MJ0W4IlXwqT5Rz1e2WdKH7l0udWU0ZBZr/vTmMm8/NSfovNcoTXOmQDkzlBeVzncKAoVfhrdCzte/V29HtbAWuRHfKrGgVGN8iXDmVdPY6uPra6g+b6gr2hXDeqlKh3N3qgmX/YTMIZxGAHndG5ZvY5Om3WhVv0KNmzyuRhBDir2tXmQ3twRyaOSN+qLTtgjVcMpcaHUFHfTEKyi+2mBW8e12tFU894ElWPTgSTp4kOmrt/4ssPJQUJ2CW5MgEzgN+JnZH7fru7B58gs1GXWFMJkzY2/RG6FlJ6PbKXqT6Ky0Kf0GqCYB9VDCloVdidMEh1joh1WiHs1fUmld8TASqwSORLPNOnYuKU1iSV+DBBDoLK/8SdCCiyOEIPnH9aHaVU7B6FmLGGHuNBLuc5UvmpGs1q0Gg/o5uErEahetqbZFi01AyI3t8ycT4CLHt+ZVunNXujsIn/Q7c+4NJcr2n5VOTuHYme+0P/qZ9UD5AkZxXQYCGi2dKGCgYVH/I/jzMWU+fjghOItpDV7+0Juu/+QfHe3ITwbAELEApSLztfr0WNDq2dExZRT2dF1B4GUUqDdIP0QY7Wb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjJKamdLUUNvMVJldnVnM2pMOFUvNWhWR0JKamFJbXBKZGtsVzVSVm4xMElo?=
 =?utf-8?B?aDZRUjEvSDJsVWdVbkY3SVVtZCtOdzlCYkYwM25walhtOGNkVW1aa2lIZ0U2?=
 =?utf-8?B?REZ3bjNGdlNkUlY2OW11aWJZcHNucStwK0ptSWd6TnBkNGFnc3IvZEFaTEVy?=
 =?utf-8?B?QnpwSVJSUXpoeGhoOVdHL3RuTk5vWERLZitFL29JUjc3b2hnN3lPUmJQNWh1?=
 =?utf-8?B?OVlvNGRmaEdzRzJYd1RTSHRFaS9zRm9URkdiSHNSN0tVWGRONnhSQXdOdkFl?=
 =?utf-8?B?M0JtWDlJdmorZ0xnRXcwOE55dXQreXJCRU9WbkwwY21nSVJhZlpsbkEyNnVE?=
 =?utf-8?B?WFVhQjRieFRoeTR0S3VGekttYXRaRHBZak51QjBTeWo1d0IyVWxyK25BSFE5?=
 =?utf-8?B?Z3pOVTEyckZyQjRlRXJid2FvODJFeXNUQy9ZQ0s1MS8wZDBqSHRzdkVWVGlO?=
 =?utf-8?B?cCtkVzA1RzhGRmZZdDR2bUlsVzYvazFTOHI1VHU4bGpMY2IrZG90TnlxSWFp?=
 =?utf-8?B?aVJMcklpRmU1d0Q1VU50V3lmMURldUtQUDJqelJRclNFeW9OZDl1V3ZTaGhN?=
 =?utf-8?B?cnJlVDZwcHVLeXljdm5VQ2drb1RKc1RGWHpWNG5DMEVnUmJqVzdEc01PUVlr?=
 =?utf-8?B?dUwyQ2o5WElxMWd6L2NmZFJKaXR3eExkd0x5RklRempkRlZIb3NFL25NZWRt?=
 =?utf-8?B?VlZFMDkyZVZRM1lQZkl3ZXdzM2pTaEpsV05sTE1KWm1HUzJjZVV5RVB6dFVC?=
 =?utf-8?B?bmVBTHV6UElBSjcySnB4ek9zcjVDSEYrTFU3dGI5eUVFNnB6SFcyT0x0RFJq?=
 =?utf-8?B?Z1RNZDNLbDFzaVRqcS80bWw2aG1ua1M2bUlMTjRsVHlmeWhxUEY2MUVRSFJS?=
 =?utf-8?B?VEVTaVRTekVVRGYvdUU5V2kyb0lsYjk0MWhJN2NlUnpNRjRXdHA0bmNXUjgr?=
 =?utf-8?B?Z3JSbFlSSGlBUW1RaEpZblpNNGxlQnJQWjA2ZDRUWTg1YjdrdUVqYkc1NEtZ?=
 =?utf-8?B?MGd0QkQ4RjVBNElrNDNSTHkvL1pzTlRmK3VXNHFtbnE5UlVIaUgzNkltaWxh?=
 =?utf-8?B?T1hyWG9Jb3NxOFZ4ZmlDYjU0NktaY002NXJscTZ3SHQ2NVE4UDlYZEhhb21X?=
 =?utf-8?B?dHV6ZkxGcDRHaXlML2tEL2hNTjJITUVOUVBna3F1ZEFEUXNVRFZIbkJXV1RQ?=
 =?utf-8?B?RVQ5dVA0Q3VQWWxTdjMrYUl5aXBHa0Q0ODJiczRyMlZRRmZQbFVNTWo2T0lh?=
 =?utf-8?B?MGtiK1ZnU3M4OGFicXFIb2tzVW9VTENJNTJQQndPSC9UcGU1STBtSENhYkxX?=
 =?utf-8?B?ZGhTNnRTU1hsb0xLMHFWTnlGemlkQmt2UEZRN3hEYkJuTlRldXp3WEpUUEw5?=
 =?utf-8?B?MHB3WnNzL0RVeWpsSEk2Z255cE9lbGVjczBKVkNyL3pLd3cwdHk5QTNpbUs0?=
 =?utf-8?B?cDk1WDJxaWt6TGs0VFROTGZ4b2RJRVVEMTA3VU1EY216cEtYcEljOFBqSGNC?=
 =?utf-8?B?TGszS1A0Y2s5WmF4ZklmeUFRdmoySmg2UVltRGVmTVgzaTE2Q1ZNY1AydnJn?=
 =?utf-8?B?OVZlc2RVeUxIRXA0TVZVYitRdk1BWDkvcWh0Zlgya0hNWFByNTRJMVBYNE1G?=
 =?utf-8?B?bnlJcG1ldDVGc2RGbkRjVXlSMEhocTBLME9JUGdSUXNkbHR4cEpZd1JUK0l3?=
 =?utf-8?B?VFF5OUowRnB3SnF5RG1UN1M0cGZLQjQ5NG1wdVlwSzVTYTRkaGkwSFdjd3pr?=
 =?utf-8?B?ZVo1SVFBcXNCUC9uY0MwTDIya3FnbGFSN1JIcnV5MEFXdFJXb2luSHZlUUVl?=
 =?utf-8?B?ZnRQbWhqQmNWek1kUmhsbFBXSTRFL0xQdEgxRk9aYTRKUFhxdFA2dWhKNFkx?=
 =?utf-8?B?WXlBR1lZK2RjNGtpd3hrNmJaK3JESmQvM2ZVZm5nMWNVMlY4d2NFMC8ydmV1?=
 =?utf-8?B?RU12dVhLZytOajlYYUhhMGpJeUNWTW1VR21OQUs4ci83UDZoWG4xa2E4Mjh4?=
 =?utf-8?B?ZDZqOXVCVDhmM0JndUdTWm8wWk9MQ1RzYnNwMDNFeG1oOVNtOE1iMFI1SVR5?=
 =?utf-8?B?ZFVoenJZYTNqT1pQTmZWOXA5SXVKY3NXNkYyZEgvZ3ZXS0NVQWN5Sm9EMTl4?=
 =?utf-8?Q?dyKbvaPGgIOfco5GWZYERygvM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uZnSq8bn7ptzoIg0l4j0rJyH32/MExHV6XAnLMR/3LS+Jr5WksFclDRIAjzRH35geEHQcApv0sFJHkdla2eQFQypkCUzoUb6YDKY6muKC5T4OXuXWFJBZ5oebheZdchOPfbeq8pn3ylusth/XnsJusFn/pFyi4wAOnqkVGYzQqJn220xAOGAZX0n2SOjO6LFOJlAVK5AwUbnqkRBN8a4TLmks/24pHSAnzhWNts+tJabHJm8X165AkyTPE67FihLOv05D66EvMBtI/Jl9AYw41FpkVee3loFohjgs8RGQA618MtEIIRDZWGqKg73hPvtk3fS0G9kuoA/9PNS5sVWImeeFJj0aFL4j+VUY1cxoVTZsl/ERm/2iXJBdDYLp2GpDbWiCFcsuE14YYgvUPk4tihb5cAUcriJN1TBQv1rE5XUYz/ppepPfAXiMKbh58KyB6+NlZU2iuGlOVloPkYZkngGb85UM42SDPwX617EP7UH1eVleWzVOS0ULhIkQYQ+5A923uFv79qCaXkJs6oskvmUyarR2wndowq75mOGDT4v5h6cWmSjPD/FDwCzc5HSruD5q9OVXJSR14dWA1vHa3xGDd7nHPlKLVHiydwX/30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff193904-5c1c-434f-2f19-08dc5e60bd08
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 22:01:16.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/8RUmZZjp6pwzGFnoc4M+RAC/7VXTJVHfIYleSsC5bs+ZkAFxjDNe5P7ZlNAshVMvMp6RAlGcDb7uIIABWQeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160142
X-Proofpoint-ORIG-GUID: VuQmhliDAVkD8QsVLcSlEy8TQe6ZvC6N
X-Proofpoint-GUID: VuQmhliDAVkD8QsVLcSlEy8TQe6ZvC6N



On 4/16/24 14:47, Kuniyuki Iwashima wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> Date: Tue, 16 Apr 2024 14:34:20 -0700
>> On 4/16/24 13:51, Kuniyuki Iwashima wrote:
>>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>> Date: Tue, 16 Apr 2024 13:11:09 -0700
>>>> The proposed fix is not the correct fix as among other things it does
>>>> not allow going pass the OOB if data is present. TCP allows that.
>>>
>>> Ugh, exactly.
>>>
>>> But the behaviour was broken initially, so the tag is
>>>
>>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>>>
>>
>> Where is this requirement listed?
> 
> Please start with these docs.
> https://urldefense.com/v3/__https://docs.kernel.org/process/submitting-patches.html__;!!ACWV5N9M2RV99hQ!PswtQoZm7r5MGnH8pv3OewI_PvmSRJb29YcA0pnVOzuu8T3xvWlw4lLlLzFhzn6uO2lo0bUA5Yikc2A$
> https://urldefense.com/v3/__https://docs.kernel.org/process/maintainer-netdev.html__;!!ACWV5N9M2RV99hQ!PswtQoZm7r5MGnH8pv3OewI_PvmSRJb29YcA0pnVOzuu8T3xvWlw4lLlLzFhzn6uO2lo0bUAdoz3l7w$
> 
> 
That is a suggestion. I see commits in even af_unix.c which do not 
follow that convention. They just mention what the fix is about. In this 
case it is implied.

I am not opposed specifying it but it seems it's optional.


>>
>>
>>> Could you post patches formally on top of the latest net.git ?
>>> It seems one of my patch is squashed.
>>
>> I pulled in last night, your last fix has not yet made it (I think)
>>
>> [rshoaib@turbo-2 linux_oob]$ git describe
>> v6.9-rc4-32-gbf541423b785
> 
> Probably you are using another git tree or branch.
> 
> Networking subsystem uses net.git for fixes and net-next.git for new
> features as written in the 2nd doc above.
> 
> My patch landed on 4 days ago at least.
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=283454c8a123072e5c386a5a2b5fc576aa455b6f__;!!ACWV5N9M2RV99hQ!PswtQoZm7r5MGnH8pv3OewI_PvmSRJb29YcA0pnVOzuu8T3xvWlw4lLlLzFhzn6uO2lo0bUA32gMtng$
> 
> Also you should receive this email.
> https://urldefense.com/v3/__https://lore.kernel.org/netdev/171297422982.31124.3409808601326947596.git-patchwork-notify@kernel.org/__;!!ACWV5N9M2RV99hQ!PswtQoZm7r5MGnH8pv3OewI_PvmSRJb29YcA0pnVOzuu8T3xvWlw4lLlLzFhzn6uO2lo0bUAnOykbCY$
> 
> 
>>
>>>
>>> Also, please note that one patch should fix one issue.
>>> The change in queue_oob() should be another patch.
>>>
>>
>> I was just responding to your email. I was not sure if you wanted to
>> modify your fix. If you prefer I submit the patches, I will later.
> 
> As I said, my fix is already in net.git, so you can post a separte
> patch based on net.git/main.
> 
I used the latest from Linus.
I will submit the patches later.

Shoaib

