Return-Path: <netdev+bounces-206424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD58B030FD
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 14:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75313B8D86
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DCE22E402;
	Sun, 13 Jul 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTxhNU0j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413A13AA53;
	Sun, 13 Jul 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752409706; cv=fail; b=gPD8BW3/BYRx+rLzlbiG2JNEmllJtBp+uMH3rZ8C/IrDX84w9zFuFdu9yxDGymMy8DN4Se9Y3K9O2Xfevd9hW5bbd50Id8iIWZg7J0jtaK6tO1Ak6xzRtvgdpQW7JXTp8YjZKT0USLX7Qit+IJQ+kO8Lc2NJLPmdtvCc1bNZjds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752409706; c=relaxed/simple;
	bh=bjgAQOU8A1WZn/979sJwskp+tCgZ8q6m1d74lH/Dgw0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzCTnA9MjItfvLOP/lK4sSqTlPOktxLUoDGKySZfblKPVkPPbVcqHbffkeCeXILyPI3/AWvgdTGNgR1ZYjtIBSK80C5GNdFl1fZafYPbWwx+qRgTVMtq5OfmnA/+vfKQJrYjQ7L1yH4FEOb8Y6oEmGUHOlVi06xU09vI/ylRowM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTxhNU0j; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzY4IKIZnMZrovOKXvLxSfSR6HBAyNABC3hzz7hhPrXm0HkYmOpXOEcl9416YPQh+5k2ymz60WPdc0B/2vp66TcTD37OJaC//ciBK/1oCR7c9/8gABCh6gEW1P6K+VtXpaFdSWee7BnwQ7a2R+2+AAI/Q/CzceKT0b7ElOwlBf1VeKriyAH40PFDlRTBEbMHsEqaeOtLm5u/mjc/LLE/jv5YdnRtQpTy1q2uH5cSTXlOOmWLOgVTHlZPP7ADHsO24nJar4fSbBb//2A/fPiyQfYOl9TfVlmKxbZF4MMXGSVpRIb0pPOB9EIaDTLkZASQ9fqJX87EOTVA2nI/7jVoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAfJicvNkpoTStLUAPVkd+/vB5sTFUTYmVYNc9mjrXE=;
 b=h711ZdWD5YM2XBm4suhxU2pgyfyikpXVTm36uhXZC+GBDWyK+nZiuK1nqzn9wlP7PMndSpocRE4P7342R5LaOtXaRy4gHTzxkIY3+CXiF89ZGA8k85IMY2LA5+hpxPZFR0MieF3Y7zKpwDDCitBNtQJYnQw9IMfeSJ3wlkTwUqIHhYWH7ftXvGo0NH4g+clKiyafVPj90hmYKiXMVbSA1DS7jSSH2javILuD88ww1MyQwPIpI3Dq1H0WPzrDcVF5MymoN1quinBJQWkufWNDH03kHfB513wr9VxfUGqjsrlD4IiDshi9NYG3ts/LTlwj5xixDSNN4vqVUgSCoPPs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAfJicvNkpoTStLUAPVkd+/vB5sTFUTYmVYNc9mjrXE=;
 b=fTxhNU0jYSmG0V71hBuh0PBEt6joBIKJjMKqRherU0ZW/S80T3ZPXft+ehhT0giiPhGbR7j+oQlYH+2Xfm+11u/7TGWDrwdtIwa2+JEDdcv1j2GX+y1Zjje/1QgyqrmS/SQoD+IZJ6/IP+Vz4KhI9Pm4q0DW4DsDP4yY4Uf2oapMFXWMHASkzHlK8kf70xmdXMz3Wd/0FccsbUsAktxuCHyPyNmJRHpPkfYOt183Jq/0jGvEADUDoX9rMSr3xG4ZZS26BcacsLflxI9DTe1vC83ikAFv5lhCvrQP63jSlF+iLu6lNwwS8+Z+dGa77zjmwTjIal6OQCXMZB631iTrqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 12:28:21 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8901.028; Sun, 13 Jul 2025
 12:28:21 +0000
Message-ID: <5ca43852-0586-4811-bc45-99e19232ce9d@nvidia.com>
Date: Sun, 13 Jul 2025 15:28:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] devlink: move DEVLINK_ATTR_MAX-sized array off stack
From: Carolina Jubran <cjubran@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Mark Bloch <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Cosmin Ratiu <cratiu@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250709145908.259213-1-arnd@kernel.org>
 <20250709174547.3604c42b@kernel.org>
 <40196680-c34f-4b41-a6cb-36e3a6089634@nvidia.com>
Content-Language: en-US
In-Reply-To: <40196680-c34f-4b41-a6cb-36e3a6089634@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 718f6649-0c4c-4f5f-cdb3-08ddc208c0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWNCaDhoMUFnbW9WcDF4eURacUhqUUdVWU83UHFkdjVJMmdTWGt0bkJOZEEz?=
 =?utf-8?B?NTVzMVZqSXdCR3VCdEZkMU43aDJTWlpNOFhiVTVsZTFoSTRrbzJ6b2Jnd1Ft?=
 =?utf-8?B?ZG9BQ1A1cFhRVEM0b2dWMU1Vblg2clhlbHUrZ0FXcnZvdktKbmovSllDdmlz?=
 =?utf-8?B?Z0RPTmg4WWpVQ0ZadURiYzJTdVF5WjI0alRNTFNLR3Q1Z016MWZpZlBockk3?=
 =?utf-8?B?TnVaVW9JYVpUUGdKUzd0cGVPSzlCRDkwRGtvSUJuTE51UUZGWndrZGxTclIy?=
 =?utf-8?B?a3pnTk9WSWdaclg1dlRLMUdubVIxcFZzdUFqZkVJR29qSkRITVRUQlpxU0gr?=
 =?utf-8?B?YUQ1ZXFCTkhqZEhrQy9HeDcrWS9XRUVwVm11Ly9ZOENYZWFiVFN1MkJPdWpX?=
 =?utf-8?B?T280emg1c1M3eEJLK2RZZDNsOHgxVVV0QzVPTnI3L0VvMHpMMjZQTFZwWVZw?=
 =?utf-8?B?VVNjanEzS3pKOHhuYzg3aXFMS0RINXZQMklBVmYxa0VyKzRCM2M5eHFBTlNv?=
 =?utf-8?B?anJOZTV1akkxNWJBb004YjVhdWRqMmp3Tjh3VFE4M2xyVEEzV21ZcXZCSU1y?=
 =?utf-8?B?ZENvc1ZXVGt6OVFPdnk2ZTVubXhRcjQvNVNHNnlENjNoaHNWaFR6NHZOd3Vk?=
 =?utf-8?B?STBLMnRZSGJ1cTRFbDdnTDh6TnhxbHl5UHpMNTBaTnpFV21GYm04VTg1YWZN?=
 =?utf-8?B?TmNoMHo0TXlmSW51RVNsSWI5cExpL0lWOWdxZG05b29ISEorb2l0a3NtOW05?=
 =?utf-8?B?Y2twVTI2SW85SzR1SXNWNDhaejBjd2FwOFNHd0F6c212WmZ1cTlpTkdncVI3?=
 =?utf-8?B?UlVrNGpITzJ0TmZWVWgzcDQzME1jN0VsTmUyNUh5RzRRM3Zlbi9sWm9jNU8y?=
 =?utf-8?B?c2dVUDZBMDNBZmxVYTBHaXBBR1VYN0NsU2p0SG1nODltVEhNTUVHUC9UaGFL?=
 =?utf-8?B?RVVxRUFyMmxFQ2pVcEhJMzVRcTdBS1FMdDRjaUVIejYvUVZkVkxKUTlnNWpT?=
 =?utf-8?B?aTZUTzZvUEo2OFljUEdLdjB5WjFYRGh4Y1NOaGlRTkdSckwrQkdieHI5MGwz?=
 =?utf-8?B?MWZsSzYvcGpYN1JtR28zMiszUVVMbmRjNEFUR0phYnNrSEEvdVA2d3p4Q3hh?=
 =?utf-8?B?bUs1QlRpSUpHSlVjd2JNcG14ZW1vNDJYQmNJWGNzZDlQa0ZjOG56c25nQ0JO?=
 =?utf-8?B?aWY2RWliL3IzRDRNaUpKQ0RKK0NlRktyK3JBQUN3TWdnTVgxRDBGK2ZROUlE?=
 =?utf-8?B?VFVkL0N4elBXUFdvTW5wQWo1cVdXMm5jbmNCSDJxMFU0dmhWZC9SUVBldVB4?=
 =?utf-8?B?Zk85cnQ1dEFLYmRaWTMvcXdmRjFVR3ZTMEszVEJXZnc5dk9LQm9Oc3l6N05Z?=
 =?utf-8?B?emNIRGFCcW42Qnk4U3plRVZXVytVQTNVQXpVM0g3VVV2R01XV2lkVkJLZ2VJ?=
 =?utf-8?B?cVJ6azJ5OGhxV1E3RUNSOTJNQjhnUVIwTG5GNHhQTVFCU1VxVldITEZXdzNC?=
 =?utf-8?B?aEREajRhaVBtbkFVRHA5SEkxZjlKaWg1WHBvamw2cktkUnJ3amxvSDFrWjRr?=
 =?utf-8?B?R2VPWGdJOWlyVXFScnN5T1JqZmxiZGVoMlFXVGgxYXM4bUY0SDlTRDA2Njdm?=
 =?utf-8?B?YTE4U3dEWVlkT0xLVWVtMUo3TEI4aHIrNFliZWpvUmpBdWJHNStrcGtvK2Jr?=
 =?utf-8?B?dDQ4SEdSWm0vcjF0elRuY3l3alJ2bmpkSzJVK1R0dEdCWWZ4c2dDWTFweTVG?=
 =?utf-8?B?TTg5UVdsd2hPRVdmaEpGc0tvUEthTGtkRHZHUS8xazhWVXVRK1ZPYlBXMlNu?=
 =?utf-8?B?RFBwbUpVdU5ueldmL0JZOEpRV3ArZ2tVbzZ3L0c2SEJYczhEbDhoNHhEd2hN?=
 =?utf-8?B?QlNSbC9TOWJQRFRxZUloQ1diaDBLVTkxR2FYS2Jhbm9PbVR0bk1aZEJ1VmJE?=
 =?utf-8?Q?cRPtUCSWeYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2Q4NXVpSlVjdzBXRzVlL2JTajE4dEs1dVZqOE40UFlKalFwaTlPek1PeWty?=
 =?utf-8?B?dzFXU29RUjBVMW9sdU5tV3Z5bDFBK3BoNnB1SzNzQ3FZb3ZobDRCeDhYaGtI?=
 =?utf-8?B?cy9DdVpLUWxDTTJQY1V5elhLK2E3K2NHcFdYNm9CK0xQZm9QTGIreWFrQnRx?=
 =?utf-8?B?cnpiVXd3T3pzaEUrbWo0dTQ1TXFWbXQ3NW10c3ZadlVUWm1yYUxNbDRSZE10?=
 =?utf-8?B?eEFnK2ZEOXVzSlplRFo3SG04bm9qUzM0ZHNEbS9Db0FEY25Mb1Fmblp6WFZn?=
 =?utf-8?B?L1l4aTlWQWtuUk9Ma3c1bnRCTE4zcE9FL1JvYisyQWlCVC8yTlpmQURJUFRp?=
 =?utf-8?B?NVFkUG9heWxwTFdDbzUycHMzbm5BQVBDYng0dCtnNEt1Tk9DU1ZsVDB2R04r?=
 =?utf-8?B?ZmF6Q0NIbmVpN1A2eFAzT2JDUTBMUnZtODgrQWprQ284MDRla1RXMGhBYjVl?=
 =?utf-8?B?OUFKSTMycXBHN3ljenhGUm9xVjQxR1dhZmRoOGhudUpBczV0enhWZm5CTzd5?=
 =?utf-8?B?YjJ3MHg0K2ViM0FqVkZ4aWhjMEdFcnlMRzZvRHgzZW1malZvbXFxa0dVdFRH?=
 =?utf-8?B?d3hZYUM3Q0g0a2JFN1RwRlVhQ09KdmpWTElYdHowdnVnL2xGOHdvVjVaYTVK?=
 =?utf-8?B?YnA1MEd3VnJHMmFDWFpSN256S0NsRWtNdElnRitJbG1hZXVPVU9hT3cwUXh3?=
 =?utf-8?B?L3pIbUJWNUtpOW1FY0dlekVlUVJ0MkFlbHNmU21OTWpxQS92ZjFZLy9lTXhQ?=
 =?utf-8?B?MlVpU0dXY0tKdm1DaU9ZdlE0K0puQk5hdEdEZytyY2puTDA0RUs0L1cvbGM1?=
 =?utf-8?B?WTkyRnNkVysxaEI4cmlrbHFLRWpROG1TbzAxUlYvbkEwZCtsTDZZTFR5OGFo?=
 =?utf-8?B?YnAwU3BZSUxoZjRCN2o4bmR3d1JvdVNPOWRTNnFBRUluZVQyeUhBNG9sbk5S?=
 =?utf-8?B?R2c0c3g2Zk5Ram1ZTXpmSmxkYXZCZENBYnMzd0ZIS1dBQXVOZGFmcGtmVDUx?=
 =?utf-8?B?MkFoQlBiMEhaK0RxamRQM21XbU56UTJITzBGbUROOGl2eVBLaHJIbFM4WXB4?=
 =?utf-8?B?QTRCNWFDY0xtM3UybGpzZGZpRFFwWlFhdzc1RmxzSDFkZ0haNlBIOFFCQk9I?=
 =?utf-8?B?TmhuWDlGZGE0VlFSZWpDK3pQeWRxT0hNSUJSWEpBd3NjOEZwYmNQM2dtRFlo?=
 =?utf-8?B?REMvQmVHT2NtYUJnTWZlNzF2N2JiNEh0OFBTejdtK3JWdWJ1U3I2MUVZdklF?=
 =?utf-8?B?c3JLakR2VCtsd1NpanBXNzJsbGRjbzdUbHNMcWNVUGg1M2RIcDdvWVZnU1JG?=
 =?utf-8?B?aVpOMUljS0pWRFM0RXhZWjRCZ0pIbjZtZUhzOEg0MmRNY2pKc0xNcWU1Rm1X?=
 =?utf-8?B?bm9aNEZSOEtMUXJNMXp4OWtpNXZoQ0RGUFc5Tk1lRndqQVkremlwT0dabWRr?=
 =?utf-8?B?VTAyNmNVYXhybnZXd01hVXFXWWpQQjNBY1ZTamJpTi9WU3o5diszSlNBaDUw?=
 =?utf-8?B?WFU5UFFKakRNcWZPcUF1YndnYUUxcVVpanVSVXF3Wk54LzVjVkpjV1hiMVRK?=
 =?utf-8?B?a1hDSFgraVJuTm5wbE1RZHpnb244TXJFYXNMQWpOSnU5bytmTkFISzdQU3hh?=
 =?utf-8?B?TEVPN2tZcnFQbTFNRU8xVndpZldtVkloTzFjc1ArWXpUdzNzdmg1d0o5b3FD?=
 =?utf-8?B?RjQzbEw2N0dNUkFoWmNjSC9yUFh2UUVZZmtGZzlNZXhHa0NYUk1zZlp6bHV3?=
 =?utf-8?B?ZjhNYmZjZnNnUGhuTEE4dEcrbG1BTi8xTWR0UjRKSmh2N3V1VXFQOEhMSFdI?=
 =?utf-8?B?NDNKTldjZzVsZVVTbm5ROVZYTnNWaDUrb0MvTDNsK2NHRGYzc1EyTmZRL2Zk?=
 =?utf-8?B?ZFBWYXZNUUwvbytpZFRVYWNXay8wczROZ2RHU3g0Nks0QlJ1bFBaZnZmQy91?=
 =?utf-8?B?VmJQV1VHQ3NFU0hJWmIxQ3ZRL25yNExkbVUveG1TRVFzQWV0YlFnRjZDeVFz?=
 =?utf-8?B?OHB2VUhjRlJxVm9Sbmt6MVFlc1ovb2hha3MreWc1UHRVSmZoUGpLbi8xdUw5?=
 =?utf-8?B?WHdOOGhTbUNPcFNvR0RjZlpFQWRIVWprbTJKdmhJd1dOSkw1NU83d1JESXFN?=
 =?utf-8?Q?aHw2U97CsZuPQazJckoam84z3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718f6649-0c4c-4f5f-cdb3-08ddc208c0cc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 12:28:20.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQQ1iYSNtPhdlchRbmybyi1aDAguZswCtatp06RxygLvPBpEhjHKsv1mqy+PmX9gDYnCI3WBM47NkQK1r6BIGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702



On 10/07/2025 10:58, Carolina Jubran wrote:
> 
> 
> On 10/07/2025 3:45, Jakub Kicinski wrote:
>> On Wed,  9 Jul 2025 16:59:00 +0200 Arnd Bergmann wrote:
>>> -    struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
>>> +    struct nlattr **tb __free(kfree) = NULL;
>>
>> Ugh, now you triggered me.
>>
>>>       u8 tc_index;
>>>       int err;
>>> +    tb = kcalloc(DEVLINK_ATTR_MAX + 1, sizeof(struct nlattr *), 
>>> GFP_KERNEL);
>>> +    if (!tb)
>>> +        return -ENOMEM;
>>
>> Cramming all the attributes in a single space is silly, it's better for
>> devlink to grow up :/ Carolina could you test this?
>>
> 
> Sure, testing it. Will update.
> Thanks!
> 

I have tested and it looks good. Thanks!

>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/ 
>> netlink/specs/devlink.yaml
>> index 1c4bb0cbe5f0..3d75bc530b30 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -853,18 +853,6 @@ doc: Partial family for Devlink.
>>           type: nest
>>           multi-attr: true
>>           nested-attributes: dl-rate-tc-bws
>> -      -
>> -        name: rate-tc-index
>> -        type: u8
>> -        checks:
>> -          max: rate-tc-index-max
>> -      -
>> -        name: rate-tc-bw
>> -        type: u32
>> -        doc: |
>> -             Specifies the bandwidth share assigned to the Traffic 
>> Class.
>> -             The bandwidth for the traffic class is determined
>> -             in proportion to the sum of the shares of all configured 
>> classes.
>>     -
>>       name: dl-dev-stats
>>       subset-of: devlink
>> @@ -1271,12 +1259,20 @@ doc: Partial family for Devlink.
>>           type: flag
>>     -
>>       name: dl-rate-tc-bws
>> -    subset-of: devlink
>> +    name-prefix: devlink-attr-

Maybe use name-prefix: devlink-attr-rate-tc- instead?

>>       attributes:
>>         -
>>           name: rate-tc-index
>> +        type: u8
>> +        checks:
>> +          max: rate-tc-index-max
>>         -
>>           name: rate-tc-bw
>> +        type: u32
>> +        doc: |
>> +             Specifies the bandwidth share assigned to the Traffic 
>> Class.
>> +             The bandwidth for the traffic class is determined
>> +             in proportion to the sum of the shares of all configured 
>> classes.
>>   operations:
>>     enum-model: directional
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index e72bcc239afd..169a07499556 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -635,8 +635,6 @@ enum devlink_attr {
>>       DEVLINK_ATTR_REGION_DIRECT,        /* flag */
>>       DEVLINK_ATTR_RATE_TC_BWS,        /* nested */
>> -    DEVLINK_ATTR_RATE_TC_INDEX,        /* u8 */
>> -    DEVLINK_ATTR_RATE_TC_BW,        /* u32 */
>>       /* Add new attributes above here, update the spec in
>>        * Documentation/netlink/specs/devlink.yaml and re-generate
>> @@ -647,6 +645,14 @@ enum devlink_attr {
>>       DEVLINK_ATTR_MAX = __DEVLINK_ATTR_MAX - 1
>>   };
>> +enum {
>> +    DEVLINK_ATTR_RATE_TC_INDEX = 1,        /* u8 */
>> +    DEVLINK_ATTR_RATE_TC_BW,        /* u32 */
>> +
>> +    __DEVLINK_ATTR_RATE_TC_MAX,
>> +    DEVLINK_ATTR_RATE_TC_MAX = __DEVLINK_ATTR_RATE_TC_MAX - 1
>> +};
>> +
>>   /* Mapping between internal resource described by the field and system
>>    * structure
>>    */
>> diff --git a/net/devlink/rate.c b/net/devlink/rate.c
>> index d39300a9b3d4..83ca62ce6c63 100644
>> --- a/net/devlink/rate.c
>> +++ b/net/devlink/rate.c
>> @@ -346,11 +346,11 @@ static int devlink_nl_rate_tc_bw_parse(struct 
>> nlattr *parent_nest, u32 *tc_bw,
>>                          unsigned long *bitmap,
>>                          struct netlink_ext_ack *extack)
>>   {
>> -    struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
>> +    struct nlattr *tb[DEVLINK_ATTR_RATE_TC_MAX + 1];
>>       u8 tc_index;
>>       int err;
>> -    err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
>> +    err = nla_parse_nested(tb, DEVLINK_ATTR_RATE_TC_MAX, parent_nest,
>>                      devlink_dl_rate_tc_bws_nl_policy, extack);
>>       if (err)
>>           return err;
> 


