Return-Path: <netdev+bounces-240063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC2C6FF34
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 98E762EFD9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B698036E576;
	Wed, 19 Nov 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mJIoihdj"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893036E565
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568483; cv=fail; b=SBTZNnoycGcy3UUjaAtokocUe6fdbnW4YIlOt0ITA045mkS5Vymq2pStBYB6zxkNTLDVV9MqZzRw3FlwfVlUXAnUXO8idJ1Kwzr5NKzWRWan9nhNt3xB249ItKpLc9hK5WCg7P5JiyOaUUdX72kVekmSAzNoaceXtqnLjmxMd3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568483; c=relaxed/simple;
	bh=60UPvBFZvlqlBXQ+5BKo9lMGXCThRJ/RbCR/TLqdTPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uwB/o9lC/sErtMkIv7G9XUuDbThyGBbuJnX7cDhaXRnrcxMPCEwscsePSEZplVMn0ZtecrQjgn0M5auutvD2FKR8bXZ+xqWTZ+CT72ZS8BzvEtcqi7n9gEVWAp/tOO1LF3dX+I6W/yTV/P8RUeSlVUPFde293vBQJUJB1FUnOfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJIoihdj; arc=fail smtp.client-ip=52.101.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQKv+qKj4N1kAjAOeXA9WtNRfmVuKFyCoyjeSltUjUr3flsCTnHIdc0JZAwZ6/7uSmju97v/gYjfV5vu283GbDiyOv9Dguf26HWngCIILTrVKwFB51AZ8O88WXBGAlXync3IlC+uZGYCvyJjpWJI4y3yq1t1i4pkzvDfmTQkefNyNU1+bysqMftnOWqFiFLKinulbylTlQ9wliD+yXZ1oBZgLuTQltOXB6jJAi0mz6X3fAfDrdq2KdPSsiDoaRmrdQ271noQ4Zi/8XzYum2Ccb8jF7TgMErIWUxuLPN9Lb76zlPbPkeX82/U3kG2bSSfqsouol1hVALc/ugafpfezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXkuNQQ+3XDbKZV0pQOT3kzppeJERLmcxwYH1PdFmPo=;
 b=m6ljaFIrKpryPcNdKwoaHN3WsRKxIZuPMk+O04zeJ4rWyCHUjblgeHop6B9VC23IQ56qy21RA3np71AzfgzXka569TxBQ7PWJSalSGdrn3gqlq3uO0lxzLA48aw/bLP8D72M9jPvX1ES3Xh3Q+pbCCyvorRjOvaemEmHcsveOboXqaz6CmTlkjbWP0HqNkRtm6Cm69PlhYqC6DAjVt21bABFI/BcHgz+qPJ7YWH38MEJFkckNmNT5tH6afAWujjlQoLwSUdv9Yo2aKb9yojhGget1rt/1M+EJFHsEgTvz58Y7x7OXQrA1pAmoKJ1Ohs1xuqoluYVdC2trjGxSYK8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXkuNQQ+3XDbKZV0pQOT3kzppeJERLmcxwYH1PdFmPo=;
 b=mJIoihdj+M2n5JkVwK4Rl+ykf209fKleQHyTm/mrea7Yy8+WMxi/hP89Su/Svj2IBIO8fejSYwCKMBhf54+RrBDZrUA+lhzB7l0MwT9cvAUvOvpMteWk5FiyEBxhO8CYkHcZ9jRzmJTRM4ahHxp/VBvUWe9cvPAHZir21BbZk70ir2MxudQtHs4eiuUadhh6O8snF7/tp5UySUhnRedsffoVi7uh9yNnXmZgUWMn1jYUatwtEcBOveB8YQ0zoInj1cOEELgek7uQoQjca91gdem67MjgzZ3n0xVb0okN7SAx013NPmHN7pNZZ4er5RyO40yLatf2hUAkM3umZWmj9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:07:59 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:07:59 +0000
Message-ID: <d0da012b-6dda-4fbe-bb20-5eb988bb4ccc@nvidia.com>
Date: Wed, 19 Nov 2025 10:07:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-12-danielj@nvidia.com>
 <20251119040931-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119040931-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::13) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c697f48-c681-4029-b6df-08de2785cefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dThNNStwK1h5T1F6aURZa25qcW00QUs4Z3pkZHZ4U0E4Vmg3TlZ2aW5LSlFr?=
 =?utf-8?B?QVB1OENKTEl2eFhLOGFVWFlFMmhRcHA1WUtQUzA0WTRMaURHNnQxVWcvSDZE?=
 =?utf-8?B?Rjlnako2MjVjdytmbTlKb20zYjErZVp3ejlxd2Z1c1dEZFZuOHJocnVZUGZo?=
 =?utf-8?B?cENqaW5NcXVpQ3RXRmxyb215SVBCeHJHNUFicmhldWZnaklBcFp4dVkyYzds?=
 =?utf-8?B?MEhKQU12VWt6VE5GYnFxLytlejczSmYyeXVDZ3RUT2xGSGhhTnMrNFMzaXo4?=
 =?utf-8?B?WnVxUCtvaDRmdTJUa0hWRTZqK0wwQmYvaUFNamJsQjA1RkMyMitOa1p3NSth?=
 =?utf-8?B?dExmYnptbnRJZHBRb2pLdWhHai94cmRZcTVNY0N6c1lHRUNXc05USUd6U3I3?=
 =?utf-8?B?R1o4RFBrTEJ4OTE2V0ZRTitnZkJLRlZvWEE3cXVKaGpLV3pKOGJsSk9zVGw5?=
 =?utf-8?B?TndOb0JZUUoxU0RONC9oR0V5anA3dEpUQm9UWCtVNGlob3VRclpFckxkU2NK?=
 =?utf-8?B?WmdJRGdFQjNsN1dEM0JJb3UxbEFPOUsvbmR2N0FneDFSaGhiZUVWbDFVRm9a?=
 =?utf-8?B?K2dOd3JnbUFKUExUMXp6S2RkRnR2OEhjT2pyUkFjNys0VnRzQVJoNGxTNmN5?=
 =?utf-8?B?Z0lYY2wzWTBkL2traDN3VUs3bW10RTE0TGxZTUs1KzVpOE9NOXhrYU9EYTdZ?=
 =?utf-8?B?VUVYbURFSmlZei95R2htYWVkNllWQUVGcFhkTDZDMC90WTBwNk9xRzJBbUN4?=
 =?utf-8?B?Vlh5MnYzRElmRlY2V1B0WENkZDc5RXE5V1lqWUZuZWJ4SXRKTFVLb3pqODNB?=
 =?utf-8?B?UFQ4K2k0dDBVYTNlWm1nVXRaQTFsdW13NVVEbTNxY3VIdWNEaVA0UUhXY3Rx?=
 =?utf-8?B?ZEJtREhXRXVSZUFQYjhxVTJ2UXJGUWtVSEQvYkRNVWJPZGVYa3lscFRiSXlj?=
 =?utf-8?B?bDN6bFVvZS9HOUEyS2ROZUVPOHdyZUVSQUZYd3RrZTNBdWNKL01HUkJJK0lN?=
 =?utf-8?B?V2puNWpnRGJZU3FzTkJBaVJIMWM2bFdSRkRYejM5amdRSHhEVUhLY25TZXBi?=
 =?utf-8?B?ak0vdThCZnI2dFR3a2Uxd2M5aUh5dUxNd3VOT0ZlREJxRXpGeGJ5dFA1anht?=
 =?utf-8?B?ZUxucHhRZ0ZBbnBYWSs3SkdqVHdFQUR2TXpBTkFPWENGMit5WTBzaWNSK2hW?=
 =?utf-8?B?L3NRa2lxVTNhQzJ0QjI5QkJqK3dwQUs1b1NzMWpwN3VycTNSQU16bkdYNnMv?=
 =?utf-8?B?bktTdFJKSHRRMm5oRXNtMWJCR3BaZWowY0NFMmNVNjlVd0lsUDJmQWluSk14?=
 =?utf-8?B?UG93TTgyT2NsZHY1Sk90djJCbGlSSHhkTCtTTXZ2eFZQV2Z5Q1d3RVFaT2hL?=
 =?utf-8?B?VkxNeVR0bmJCK2k1RXpNdCtHakh2bUJ5K2huTDBQZ211cS8vZzcxVGx6enNL?=
 =?utf-8?B?WmhuME0reXVlazA0c1kxUUlWOStuandUYkVNNElnOERwWUlrZ0pNWHdFODlU?=
 =?utf-8?B?MjUvakc0WUw3anBZdXlMSWhJQzk5bFRZdVc4cUVtcHljTWV5MlhJZWNVeFcx?=
 =?utf-8?B?S3F3UkZBdTQ5c2N0WUExYXIyS3dVNER0RnpCL3dtWUt6VG1HZzdyWWJ3Tkw4?=
 =?utf-8?B?WExFMUlHYW5zTWhpR3F3NVo5K3pydVB4a002aEZjQzl2Y2p2dVBSZkhwZmo5?=
 =?utf-8?B?RnpFdm1KOGZnTXl1Qit4M1JabW9FSVkvZ1o4TVhQU2dXTTBrWEJlQ1dHbmha?=
 =?utf-8?B?Y3BUQitEUmZOdW1JRGNya1BTc2NkdEhmOHl2N2htaXh6UWQxbUdNTCtvT25M?=
 =?utf-8?B?NjZZNTdxL3V4cXRyVFc2YUpjRTFQRDZlOUdibXlFb0xvNGhLMjBTVVJvWldR?=
 =?utf-8?B?REhQRGlQS3hST2I0ZnB2bERxL3FWL2c4TTFYRlVCOVB0bkFCOVAvRGx5aWZK?=
 =?utf-8?Q?W/0gxyvejhK3AYvkQF1q8omUho9i3RT9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGhWZHI1OFNLVEpXOUZuMU5MVXcrbEYyQ2Q3NjYrS2R3Z1U5UjVNd2QzaS9q?=
 =?utf-8?B?NFJVcStMeXRTWm5hL3BFMEIwRjd2Zk5qUGQxb0I4U3hHZGJtQ1c2cUdNV01n?=
 =?utf-8?B?bC9xMi82T3Z5a25Wb2JRbW5KcEZrTG5QKzVteVQwVmtxUytjYWJKc3ZIWjB6?=
 =?utf-8?B?L3crVFlUbFFDNmJDQnk2MGR1dndTemF3MzNQNEZ0bWhWamRtdUkrTTkwZUE2?=
 =?utf-8?B?M0V3TGxGZXBEcDU3RmdVMkh2ZDE1K0JtclNoMGY2dmIxU083akJ1ZkJRNm5x?=
 =?utf-8?B?RklrMDQ5Z0lTeFRQZU1RZHY5VXlXeWRvSy9vRmhsS09QMkZnd0V3R01EQW54?=
 =?utf-8?B?bXhybnhXcUdWNWwzLy9IeGU4UHU3TWhzekQ2QkZhZ0Y1T1l6Y2l1U1NnL2Jr?=
 =?utf-8?B?eXI3WGVlY1ZRTDlha1dYdHhqNllrRHV1dXJhQmJLenF3aHZ1UHpWaVBEbXJ3?=
 =?utf-8?B?Qlc2T2RaSmhGYzZ4eDhlb3F6b3hSRnZ4VEVnVnRMWDNxWWlFSDhzRlB5ZERS?=
 =?utf-8?B?TzAyRTJXem1Zc1kzaGdFVGt2MnptK2NRL1RWdEhFN3prWnhDanRTK1JkOXl5?=
 =?utf-8?B?eE01VjRDWGZ0V1hNcW9hK2czOHRYSzZrZFFKTkdOZ2kzU2VQdDNoR1gzK0dy?=
 =?utf-8?B?dW9ZV2dxRG5MejRrb0hvRDVTaHVlVStOU1BHNmRCRkp2TS9zZyt2ejE0Z3Fl?=
 =?utf-8?B?eWhFQVdpV0JkVkQ0ZGFGN2dBdDlKckFZRDc4NjFvYVE0eWxmUEcwcjNRSmR6?=
 =?utf-8?B?bEkwT0s2b3l3em5BQ21NRnY2T3ZVSmExcktSUzgrdE91bktWM1dhWHJlcVZ4?=
 =?utf-8?B?Ri9PSjlBQzZkcHNLZHRoVjJhanVsMEJvWFBsc2RvRUNwVzVzd2dyNDJNT0FE?=
 =?utf-8?B?cGwxWVdPcW0rTXc5ei80V0pkQnVtUHFjeGZIekdTdC9mREtmYWVHTWVGeW80?=
 =?utf-8?B?UUtHdkxVUFBUY04zTVpCRHpiZTM4SGRYZjVQdEpUdnRTY0dBZUErWHZsaHZl?=
 =?utf-8?B?OWRCcUJvaEYxcVVhczNPOExxdkZ3eEFKYjI0eWVJenEzMlhvVzhUbjBwTU9D?=
 =?utf-8?B?b2laZEViY085NnVWMGQwOG15dGJicDlXR2VWSVc5RWt4VG1XZHZoTmt0QWZw?=
 =?utf-8?B?bFFjSGphTkowWmFHYk44R0hYeDE5NmNvK1NCSzB4UlMzcXNMNGtlUis1RGZ2?=
 =?utf-8?B?djRvcU41dE5LaVhKbGcxWDNDdGs4YVFRaU1RV2ErMU9XZkJUL0o4ZlBNOXpZ?=
 =?utf-8?B?RWxZcHVmZ2VObGdmUUVzU0o4bWFFakdaN2xpc0NMSW1RRVRTN082R1dSeXZk?=
 =?utf-8?B?dEkvaXlHYzRBT25VOTVVcnNOWko5RzVUWUpkdDVRaWxSQ0lYbmFVNWpZWDVy?=
 =?utf-8?B?NXZ2SVdNd3VDZFVLSlRRMi90akxwV2dzV0d5VXdaQW5qUU1STkdXQzgxMks5?=
 =?utf-8?B?Nk11a2RpU2tISXNseG8rcHJmaFU4SHJrT3FueDhheXgyOExZYTVNYlRoOFVs?=
 =?utf-8?B?bys5cWdUYkdNSU5RbkdLcGE0Vm9DdDJOdTFkblBZUkd1MzdyUXlWZzM0QVJS?=
 =?utf-8?B?Vk5kK3VacGpkSnFTM2xNbHo2WjRHVlZyTlJMRzZ3V0l6WEs2MFVlT1I5WWVs?=
 =?utf-8?B?QmR0UmhFVUhFRVdnQ0dRVmVjQWE0ZGhKUXZwaThxWjQ0aVNJV2xHRjZ5YzFk?=
 =?utf-8?B?V2JydVNvMmVxQkpoNXZuWmw1NmxqQUh3S2ZZQmNuZTgwcHMySVJKTlhRc3Br?=
 =?utf-8?B?L0hqL3BFZzJCeTExSmFRNTZxOWRLcWZvTnZCM1JsUDFZQjluOGZjQzBaVnVG?=
 =?utf-8?B?WFB1MmlXWkh1QXhaWXZNV3FndXJ3ZGw3M1RaK3dQUTc2bE5ZcDl0bUlkOXB4?=
 =?utf-8?B?aVZTTUVmM1RabFJMd1orUGFHZzlUWGxoMzhiVlhjWmE3M1ZDenRNYWlNS3Bx?=
 =?utf-8?B?TGJyVlhJM2owa1RrZXZnSkd0alVLV3NIalExRmFIZTJzNFE0MHc5VUpZbEVD?=
 =?utf-8?B?Ti81ZlFTOGpPU0c3dVg2WHhrN1E1VUNBNlFUamRsNTQzd2l2eGFJZTl1cjJI?=
 =?utf-8?B?ZDdmVXdWQlI3Q3pvNmNqazhwK05tNnZHWCtQQWFZY3NRYnVETURUc0REbTBT?=
 =?utf-8?Q?ZoGONrI58Xha495VCrgN407Of?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c697f48-c681-4029-b6df-08de2785cefd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:07:59.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94Rrp0UTPO9uamE9E6LTcN5EN+dmmtQfsgDEmAKMILQfZ4Sq/CaHN8m5BZfQdlomEcyr+0c04+KW2mVv6+CwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515

On 11/19/25 3:14 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:39:01AM -0600, Daniel Jurgens wrote:
>> @@ -7167,6 +7261,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>>  	case ETHER_FLOW:
>>  	case IP_USER_FLOW:
>>  	case IPV6_USER_FLOW:
>> +	case TCP_V4_FLOW:
>> +	case TCP_V6_FLOW:
>> +	case UDP_V4_FLOW:
>> +	case UDP_V6_FLOW:
>>  		return true;
>>  	}
>>  
> 
> it kinda looks like you are sending flow control rules to
> the device ignoring what it reported as supported through
> VIRTIO_NET_FF_SELECTOR_CAP
> 
> Is that right?
> 
> The spec does not say what happens in such a case.
> 
> Parav what is your take? is the implication that driver
> must only send supported rules?
> 

validate_classifier_selectors checks the classifier we built against the
caps reported.


