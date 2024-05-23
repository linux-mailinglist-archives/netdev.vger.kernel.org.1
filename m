Return-Path: <netdev+bounces-97763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8E8CD0AA
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C809282C59
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0A130AE8;
	Thu, 23 May 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BnXJFS5M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135291C3E
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461337; cv=fail; b=P81lR832phvUyysgL07w+vW/rhqOnvsDO9DRG6Ld1nWdztiSoSBYMFK2ZNqe1eYd4VFNFMNhGAz1/+EnZHwfoZRfzpYmrmE3YIaX+n+Rm8zf6oixwFWyhvYo4FBLRw0twMgCspgJLscGyroJsPDxua6r3c6mwnFm/6Tfuriv+Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461337; c=relaxed/simple;
	bh=PZww1EQ2IW+hSG6GenvKm43mHqlEBseJRyUh/mtEOdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ENk/hdEnUDvIS+magXcYBgL7eIv3fB/rGSLcTZtHGqXtl7PJknIQeJguOhGnxLpUw85OaGtZYhIrZb6G1TJxrIwhBArU0j7eWcX/wWJhc9lin14SGIB3R8mI0LpxD3/aw0NhVIm4T8i5FU2yqcfHzAN9MibqziI3FUa+jB0+JVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BnXJFS5M; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw/3W3eIWNLyPz5j6EkxfUj9iPAk78QJConTO3zw/xZiVTRpcqA+n5213niieUIH0bixB49uco1dD+Gp2lYBfh2uSu0TiRUZXs2im351q26TU+rY9JmdsRscjCauNicfHHKN5zSGpRKwbb3x43VtbS5aggN4GluwY1Sv1zkfO2GrugnMlmesm/pjKCRJBCkn1wU1ufmu8tbnGhTc5d61kktO2Lu1+OQFG8Sr3d0nvg0QOcqCK6Zch7vkdggsFZNRBuEyOo4MVdVnFbedQ/vcRzYCKlnXsddDlUf4y/z9W2XCvxL0pRsn5glHMf7GoOmy1Kv8Q8tE1ezQvEiCMUVO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X8uW6QCSoWbfO0ZWrUL0jD+DdgyHJ7FX2yfcnoqEMM=;
 b=cEDlU5ctsjBiAHtvbZwZbnwus5iHen93gyENuM+f9ZCQTWikT2VoPfTbO2iC8O6mdvhFqsU3gr0kDUUradxRMpzburCIxXurok6sVVYQ2h2Taatd1DcAah1p8FwjVo4nBHEzIko5c+knPcToo1/2aOdmGsplHaBo1M/Lz/bW1QWXy/uzhuXyP8OZ7j4jQ9WbGtbMCdf1tZ6rRz+TEv2i9lHlDvHeOLUJCOzY3HyiB+D3hyDThrKjUhOhBDZoNKX05h+HKpXnfR+avYGH++lC+grI3rY03HxJbZ6fHez3Teyl+S9zhR6vDqvCAikH7Rzj0hSvFaVmBBAfzwYBTPzvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X8uW6QCSoWbfO0ZWrUL0jD+DdgyHJ7FX2yfcnoqEMM=;
 b=BnXJFS5Mel/y4h7NJUVC/B2aB+SMvx3DwwWqT+tRX5XXBy+8ODBUVhBDkoyxch67L/bjw3W7eE1VOxM72j7JW0fgYbf0hY3VMU9VMQ05Uh01wEodJLfYTcDgufm+SbDD9kVnY1Uhvar/J1VzeyQqGu2aj4ypsNYEFQRqV7EKLctPqs29+ZGPAAYHD9HBQiVuQ3AlqKQGNdYLl8MvbTyAVOXSWjHz8PJAGTYZpAlJZ2IzWIc+TDURLyS7C7yHwlUL15P+wpeqJZXqd5L2EnRUw+3UT6emEPKhj6FGlXDsn42X/1moDsvcmx9bh8Dh9GgDiVgiCDybCQtbzErQrDNtTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 10:48:50 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%3]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:48:49 +0000
Date: Thu, 23 May 2024 13:48:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tariqt@nvidia.com
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Message-ID: <Zk8fC-wZlLT6hSKl@shredder>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
 <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
X-ClientProxiedBy: LO4P123CA0559.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::15) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf7e80b-122a-4202-ebef-08dc7b15ed88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFIrMGwrZXQ2N3lycVNmY3dCNVpoemFMQ01qMUVxaGFQQjF2TStCRnZSai9k?=
 =?utf-8?B?OFl1aWNDczh4UDB1VEx6MERJVXRNbjNMRjZZaDhkSkxkOXV4RzV5WjJXWVVB?=
 =?utf-8?B?TGt1YTFBMngvWFpRQTZ3RDJ2enRBc2YxOWtudFJJQXdtaTFRZXZMRmNIWUxy?=
 =?utf-8?B?U0FiY0l3S2ZZWTJyZzJYTTRlSzJ0d1N5ckxTaUl3eFVWR09aVjZrVytQaTdh?=
 =?utf-8?B?ZmtDK3hlaDhFaFpEOEJobURjZTl5Q3lSZ3NwMGJzZ29kOHM5dEwzSlgxV0lS?=
 =?utf-8?B?NlZRdWFlWlRGVGNMaHFXSHdzZXEvb2U0SWZneDBBbUo3NnExZzdYbnU0UEIw?=
 =?utf-8?B?Z0N4aU15M0lFTjg0V29sSWRyUG9ZdklPS0tkSHlqOFVNc2p1dmU3c2dCemwx?=
 =?utf-8?B?ODM3czlYbXJGdmEzclpBVkpMeThmRXFNZmEzSzY2QjVWSE02ZkVBMmp1dFBa?=
 =?utf-8?B?N3ZVSXNXOCtRdnA5T2lOb3lzSWppTnZTa2N1UGFGbjgzZ095S2JGOFN6cUEw?=
 =?utf-8?B?cGgzU3h6NEVyb1E5c1RsMy95bDczRXFrWEk1S2pxbnliNXRCYjhUZHduVU1M?=
 =?utf-8?B?Z2tVRHhrTkhleXFsNWk4SGlJby9jVFc2MDVVVUVKUGF4M1k0N1AySmUzc1Bl?=
 =?utf-8?B?aWk1TTV0czd3cWorT3FDVHpWMjVhU2JnTTdmZ1doMFZ2M2JwblhFcnVSWS9F?=
 =?utf-8?B?NGVxcTVIR0xEUW9lL2dpY2xoaWFNTnVQNGFhbnZJL2FMNENjRHpBMGp1UDRJ?=
 =?utf-8?B?UHhUTEZOaUhRdVl1V0EwTXE4c0Fzek9MVllGQUVVd1VxYzhpaENVbjJySUFY?=
 =?utf-8?B?Q21UazhPSGlGSzhRbHY2N0RISTRsM1RiNGZvM0dVaDV3SUtCT2RqNE9CT216?=
 =?utf-8?B?TXI3bGxhMmYwcWh1K1RQRmplbDJVTXppSDNNWlRrK21LUEM4TGtTMjRRQ0pX?=
 =?utf-8?B?NzFlRTQxNXduWDFNYy9vL0FnUTM4ZHczcTk4MU5MY1k5bVF3Mm5pcXNYa3E5?=
 =?utf-8?B?bm9NQUU1QnFYMk5yYzRVT0JJWnZwSkxsVEFIUlR6alRJOHVjSmVKWGYyNnJD?=
 =?utf-8?B?dmlVRU9XcCtwNndnOHEzRnVsY2hHZklrbnpTWUR5QjNLQnFkeFFFUkhxUitD?=
 =?utf-8?B?M3lvWHVRaHVWVExpTzE3bVFaMTBMQ1J5MmNveEQ1KzZBL1hhejVIbFhIYlFw?=
 =?utf-8?B?MHdDY3doMzlDYzdGUGtRV3BYbWpXYWlYeldZQXM0ZDBUNzNoMlFPWlpjby9V?=
 =?utf-8?B?d3FJeGEzcWhBRU5NOWZWWjlWU2dhMmRZRERXbUJlazNJQ1ROTWJMcVg3UHlE?=
 =?utf-8?B?eTFqR2c0VVhVaDVFOXRJVHlrTjJWd25YSVZJd0tYUFl6eW1lSTM0c3JjWEVr?=
 =?utf-8?B?djZNZVp4MmE0U1NIN2xaQ0hmdWlPenczRm82dDl0OHFrUEJvUFB6aXJ3ckgr?=
 =?utf-8?B?ZWk0VUhEdWxOeVgwV2J6Q3h4TlpOS2FQWWVsTEY1SjM5RXVwc0NLS1dUWVhH?=
 =?utf-8?B?dE93RjZFamFZejNpdmtMeUhnbnF2WVRScGsvUW4veFdsTUtVUnNiWDRtTFUw?=
 =?utf-8?B?NkJEOGlEam91TlVhQWZPWStuQWh3K3Q5eUpXWWViRVUrZzYyaVVybGxRbTZN?=
 =?utf-8?B?NHBaS3QvcGEraTF2SGoxbGtwR0RqUkg3ZXBhMmpKQndmS0l2L0NxRHJ5aXdZ?=
 =?utf-8?B?Z0h4bzZSV1FOdHEyMzNRSVhabSt5dTdPbko3Q0hTSWhVWUlBb1lON0VnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3hVbVo1K3VhYk9kNFViSEVHeWpiekw1WkkwYnlkcXNpc0RDcVJIZzhZN1JR?=
 =?utf-8?B?YldyeHBBOFZqVmRUd3RZTXNFZXZvOHFYTGJvYXJQRmxqS3pyN2RTVVFjT09K?=
 =?utf-8?B?b3Y5bktwSCtJdTh0Z0R3TlVZTUVGaktwUGxzdGIydzhhMTRnMmF2d2tyUEt4?=
 =?utf-8?B?RE9kcFBNK0FHS21HV3BaV0QzaE9LNlhEcXRmNzBTZXhIWlhTSzYvZ0xMZ1RC?=
 =?utf-8?B?d0MzZnBkQlZ1Zk1nWkkzUnN0ZnQ3RHI1N0I0SXFnWk05a1pYNEtsemFUOEor?=
 =?utf-8?B?NXZTVDRGVlpvbXFQVlFFbzltbjU0VEZnaXJuNS8wdmFMZ2pOQWJGR3FRUVpR?=
 =?utf-8?B?UXhVV0wrdUJqc2ZYd2VRak5uVmpOdTlBZWNVc295NERmTFBQSG1hb3lQanQ2?=
 =?utf-8?B?ZWNDR2lHMEpTa2d5S0NDWUJYblVrN3V5WGxEYWhXRGFSSVlBd3ZyYTlySlB5?=
 =?utf-8?B?dGlGU1IxUWlsZ3hnK1NWenJwbFZpSFg3RVZYN0pOS0gwUVp3TC8rV0ljV2M1?=
 =?utf-8?B?L0Vudkg2ak5tTFJSVVFucStuNHhJTjdNZ1NEYlZVN3lxNHRoR21nVG9xRklQ?=
 =?utf-8?B?Mm9ZTDA4T2drQ1pocnNsV3Q1RjlhQzRXaUZsVVBDcUF3alc3SVhwY3NPQ0l1?=
 =?utf-8?B?dUJWazh3UFZZZTBvRE1JbmlVQmhKaHlHdDJHTTdGVDdkQTk5ODBPb0MwVnRH?=
 =?utf-8?B?cjBaMXpIRzl6alNaa1d2ZEJkU2d1VmgwS2pvdW5FWGxwNk5NMm43Z0ltTVVT?=
 =?utf-8?B?N2VwWi9DWE1WVFREUG1UVldPR3orcU40NGp1WGRWWHFYYStJb3BsK1J1T0Fo?=
 =?utf-8?B?bWZOTHFwQ3F1ekFQdDNROWZkYmVsUC9CbjRLQTFnWkNaMWtqNGFMYmgrT1FY?=
 =?utf-8?B?SW91Njd4Uzdac3duLzZPdEFMV3hqYndWOXJndjQ0T3lCd3ZpV0RTbUc0QU14?=
 =?utf-8?B?WTVROHBJUDhZTHRiazFSa3FKNjBlNkJ5cGExaDV5TmZxSzRuZlVOWFZ2MnFw?=
 =?utf-8?B?YWI2REFYREV5WXp2ZHVBMDkzeFA3c0t0ZnpYN094OEx1Q3VCem9WVng0UlBZ?=
 =?utf-8?B?eWZYMG9UZVJjTjUrR1FZYS9ZMzg2VTdTM1pFdnN2N1dNL0VhdXI0NWVuc3A2?=
 =?utf-8?B?aFlCbVBERFhxMmdPS3YxMDBGanVmcXlSZTJ0NW1lcTNTZUFzZHZOMjgzUm1E?=
 =?utf-8?B?Nmp3ZmpFWU5wWSs0aXB1eDZ4emh5MzhnVXRGOUFLNFhSR3RFU0tNZEQ5bXJn?=
 =?utf-8?B?L0FpM0ZxaEZqbVA2QnNpNTdiOXJsRjV4czc4cVlyMkd0WWlKdFRiLzlLbkIv?=
 =?utf-8?B?dncyQ2Y0K1FFZ2JORm9vVnY4YXgwRWRJdkREWWpUNUQ2VjR0N1VaZEpBbGQx?=
 =?utf-8?B?MGhqR3JjOUJWbDdoeFErc2w0T2NvYlFNaFNoZUlvMW9FcDBPWGM2Z0w0V21K?=
 =?utf-8?B?K1RjZGRpS1M0ZS9yNmdkK01HMnFheHdDMGM1UzBCT2N0NHJTbkxObC81K3JS?=
 =?utf-8?B?SjBublNLa2pheGZVVFEzbk5DNjk1TzFLWlNXNHI1bFdHU1RObE1xQTRNbG1u?=
 =?utf-8?B?VEdkUU5IaDNISHFDNENkdDFRdVBzcFlUSXA0QzFNcldIY3VFV1ZpSnFoUDdu?=
 =?utf-8?B?NWtqSVRDaUtONkd5elkwSXhXYWt5NnVUbE5UNjlpYTdRN24vNGtjY0t6aXhH?=
 =?utf-8?B?d29LdWZHQkp3Y0c4dkhORTE5T1lJeEdXSWdNTUJ6N2h1NTJRbGhuZWxiN1Bq?=
 =?utf-8?B?RURMZXRPYjM2NzdZbk9aVm5ab1pqZTBCNzMxQU41djlucEcrM3J5NWt0ZFhs?=
 =?utf-8?B?bzZVSXZZc2dEVVhOQnhkOE1XZ0tLUEVQays5OWI0RWlhelZSUlExakxFekVo?=
 =?utf-8?B?Mmtzd1doNWxsQjlrYlY1aWxETnQ4VUFYNW1hRSt1cFZsNUphdU1mRWpvMzdt?=
 =?utf-8?B?N2xZa0ZaYndlZWh3aUJmSmRDTU9pbUQ2SlpsU0F3U2JYdS9Lb1N2YWliY0FJ?=
 =?utf-8?B?Y3p1bEdhMC9VMWRaOE5VOE9vWWM5aEl2Z3QvQ0M1S3Y1VmVIdnM4cFlrQWty?=
 =?utf-8?B?SXB2Y2dOUTdrV3JBZk1ibXNoVkJSRnFTclIrTlNURU1VNkpNRWx1d2M1ODdC?=
 =?utf-8?Q?zFMPcIDSRzMJ9CTjoonSoM14q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf7e80b-122a-4202-ebef-08dc7b15ed88
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:48:49.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx4qxz9UbDl0yvaXH3zzXnufnPKyaXn4Nw/UGO1VcAjRpGjxScT1o8q6roCI1V5AIhtcDkiwn0oGNgioHLH9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963

On Wed, May 22, 2024 at 10:29:43PM -0700, Krzysztof Olędzki wrote:
> On 22.05.2024 at 05:44, Andrew Lunn wrote:
> >>> So right, the function returns 512 for SFP and 256 for everything else, which explains why SFP does work but QSFP - not.
> >>
> >> Since you already did all the work and you are able to test patches, do
> >> you want to fix it yourself and submit or report to the mlx4 maintainer
> >> (copied)? Fix should be similar to mlx5 commit a708fb7b1f8d ("net/mlx5e:
> >> ethtool, Add support for EEPROM high pages query").
> 
> Oh, thank you so much for the pointer! Turns out, it was way easier than I thought:
> 
> # ethtool -m eth2

[..]

> Looks like all we need to do is:
> 
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        2024-04-17 02:19:38.000000000 -0700
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        2024-05-22 12:46:57.290947887 -0700
> @@ -2055,15 +2055,15 @@
>         switch (data[0] /* identifier */) {
>         case MLX4_MODULE_ID_QSFP:
>                 modinfo->type = ETH_MODULE_SFF_8436;
> -               modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
> +               modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>                 break;
>         case MLX4_MODULE_ID_QSFP_PLUS:
>                 if (data[1] >= 0x3) { /* revision id */
>                         modinfo->type = ETH_MODULE_SFF_8636;
> -                       modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
> +                       modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>                 } else {
>                         modinfo->type = ETH_MODULE_SFF_8436;
> -                       modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
> +                       modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>                 }
>                 break;
>         case MLX4_MODULE_ID_QSFP28:

Need to update QSFP28 to use ETH_MODULE_SFF_8636_MAX_LEN as well. Looks
OK otherwise.

> 
> If I'm not mistaken, the rest of the logic is already there, such as:
> 
> static void mlx4_qsfp_eeprom_params_set(u8 *i2c_addr, u8 *page_num, u16 *offset)
> {
>         /* Offsets 0-255 belong to page 0.
>          * Offsets 256-639 belong to pages 01, 02, 03.
>          * For example, offset 400 is page 02: 1 + (400 - 256) / 128 = 2
>          */
>         if (*offset < I2C_PAGE_SIZE)
>                 *page_num = 0;
>         else
>                 *page_num = 1 + (*offset - I2C_PAGE_SIZE) / I2C_HIGH_PAGE_SIZE;
>         *i2c_addr = I2C_ADDR_LOW;
>         *offset -= *page_num * I2C_HIGH_PAGE_SIZE;
> }
> 
> So, we don't need to make as many changes as in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a708fb7b1f8dcc7a8ed949839958cd5d812dd939

OK.

> > Before you do that, please could you work on ethtool. I would say it
> > has a bug. It has been provided with 256 bytes of SPF data. It should
> > be able to decode that and print it in human readable format. So the
> > EINVAL should not be considered fatal to decoding.
> 
> Yes, I was also thinking this way. Luckily, similar to the situation with the mlx4 driver, all the logic is there - sff8636_dom_parse() checks if map->page_03h is set and if not, just returns gracefully.
> 
> So, all we need to do is modify sff8636_memory_map_init_pages():
> @@ -1038,7 +1039,7 @@
>         sff8636_request_init(&request, 0x3, SFF8636_PAGE_SIZE);
>         ret = nl_get_eeprom_page(ctx, &request);
>         if (ret < 0)
> -               return ret;
> +               return 0;
>         map->page_03h = request.data - SFF8636_PAGE_SIZE;
> 
>         return 0;
> 
> As you described, we get all the data except the DOM:

[...]

> Do you think it would make sense to print a warning in such situation, or just handle this silently?

Yes, I suggest adding some kind of warning. For example:

"Page 03h could not be retrieved"

Otherwise we would be papering over bugs like the above.

We don't need the same treatment in the CMIS parser because drivers
supporting CMIS modules support the get_module_eeprom_by_page() ethtool
operation and don't go via the fallback path.

> Finally, as I was looking at the code in fallback_set_params() I started thinking if the length check is actually correct?
> 
> I think instead of:
>  if (offset >= modinfo->eeprom_len)
> we may want:
>  if (offset + length > modinfo->eeprom_len)
> 
> I don't know if it is safe to assume we always read a single page and cross page reads are not allowed and even if so, that we should rely on this instead of checking the len explicitly? What do you think?

Yea, it seems the current check only checks that we do not start to read
after the EEPROM boundary, but not that we finish reading before it as
well.

> Once I hear from y'all I will prepare the patches.

Thanks!

