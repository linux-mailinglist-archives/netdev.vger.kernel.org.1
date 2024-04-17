Return-Path: <netdev+bounces-88569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504AA8A7B74
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6552843DC
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 04:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035647F7C;
	Wed, 17 Apr 2024 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eZBcM3NZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DJ2p7Sty"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3E3DB89
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 04:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328684; cv=fail; b=nJcXYk3JiH3+x6vXF4zE2ORfnoOqXaLRZ1wL5WfKw9x6avqLUwfy1R0YkZgQDoL6AkdaP4fWXi69CJ3I8WRf5xa2QGnlzWqvxx64JDitDeQ3RhpS3UUfxhac6qaqyEPzbhXhzWsdwbqlMejEuvIhx5Z9+bmwBSm9t12zxVHq6H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328684; c=relaxed/simple;
	bh=ntNJ+QuXZrv0/Ebu+9rLiQ2hq2BBdQM2gKDHgS/ESzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iFSAmHamfV3AYR1SXzhX9TfCiUPTzssDIJhtse5Fb1acxrcbPZiNXZ3IZQPA63oRjd+TXqCK92i/fgqxMS/AlV2WO2rorp/WaB+oEwY6tdW1kTiibd7GEzQeKgyStGJslCpNxie4T66PfJa2ICcLumygLuaR0XQ9ieiYvXf3bDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eZBcM3NZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DJ2p7Sty; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GJjiGT027180;
	Wed, 17 Apr 2024 04:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6J0rTCzMuohGHCT37FIi2T+/zpqDb01uilma8OBlI4M=;
 b=eZBcM3NZuJxXovBRHZwgH1pbJDYC+wOlBQyRgs+oFobJQUeSnPiy+Y52FZyF0+zDXr/W
 UMliDP+buaG8B5I09G+7X3BHStSYjKEid8LaUsg3/7zlFuffwQwZQ/Xxzy/GPZjOTg5Z
 H9t70Ftl4xwvMa3LGUC5yu59WaQUcCMnlOrEnGWYaCoRqaFzWdJnMItRQTBeF0ijGYdd
 p9Mf+O+RxNE1urrZs0czc3GjIitWCHsRrDwunfuodOtxVqfFXS+qa6aPGDVEhpsfKUT/
 dSGEc3nSdtgyJrlRPy6W0WP/rA7Dxc/QMb2yKauxX9RjoX52DkCZTNfU+TLnhfjorK0Z gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujpy8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 04:37:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43H4XZoB029181;
	Wed, 17 Apr 2024 04:37:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg87dtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 04:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+dJ6Uads8gcdRXSon5pInuTi6w+f+vuh7sFr02EdaCoEg74dV14MJc76ky9GlN0Egixb45SsC4H5V7pteYivW/oJ3rjVIP+39lDAgEs1dk39iSKw7UObiI8dmMZduVStOTs27eEQfKkSS2VORHVvEuY+/JeXMJ+O/6xHZr/jUDtJv6xJSS3aeNamq16qBwr32bdDhYWbC5v0B4E/XvRJ2F6ZwN/3z6HS/siA+Xsjx2Jqn5o2LNvID0O2fjxf0EkDS94y5kbzEsYJaqi4RONaJBdQfiLu9thII08whLqTeGZUAFMNgouJQXFFHV9w+Ys6p0DeuSHSBVPWsMlWashRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J0rTCzMuohGHCT37FIi2T+/zpqDb01uilma8OBlI4M=;
 b=jBrDYhxS9AGYkUa2GLIzX9R4nzCSbo9PrXb2W6ZpjOLkrjpYuhlEqIbpGgPUnH92GzwsS8ddKbT7lXxc+IMjAQfuDY5et/Gbye5kBUsBuTxjTf7zjGZC0596z4B88W73bI444efjO8iS5LbtKrJd4jLGR6tp7CUXuXz6OnvVLWRVwdtS9PMVwUXKLNWKxhamn8CV0QoPAepde7T6zU+BeRetuuElSIcZSLFTLhTYp0Cr7yAHk1ObH39VtzpKLEur9m54Gi2H3tcbqFHYp15G2B4PpinuiSor6bqLymV7iUg4lY7BB8BJRvwZObY+yB1qHUqF2czYosNjQVCVT4OXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J0rTCzMuohGHCT37FIi2T+/zpqDb01uilma8OBlI4M=;
 b=DJ2p7Sty4Wem211N7wGodhXI4cz/qkaLXMYhtfD/ttnJkkvbQEXkPxQJehrH6dV5ZHwX9ooqAi+5e7aDOTgkN1CJdkipHv98RU3PpsXX6WQnVjCvnUUhbXcnTiCzCLtsgwGbi18MnLgRRGlMtozIPIPMwIA8PCO22xXBrzvBYbo=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 04:37:49 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%4]) with mapi id 15.20.7409.053; Wed, 17 Apr 2024
 04:37:49 +0000
Message-ID: <f7cb246f-a0a1-4ea0-938d-45ce80aa8414@oracle.com>
Date: Tue, 16 Apr 2024 21:37:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/2] af_unix: Don't peek OOB data without MSG_OOB.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <dc42242b-40f2-4be0-b068-62e897678461@oracle.com>
 <20240416221055.35661-1-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240416221055.35661-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abb0cc8-4a8a-4fc3-6022-08dc5e9822ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7Z66JhZn95kpfrvgtfbrONtHZwWeEg/HMjtsOacPJvQeDNCAWbaPkgS6ehd/KphlPwLg44Eo0rsgE0V4yEHEXn1q9lWmM32N96dOF/cw6110bXHzrw5V/G4vYLUfnBH3RNkgf5X/X2mIYeZfmXJ05m+LyxDbDPsODtkQ0vTOs107HG0Os3juk0RcQ6ML0kiS89ow+bdQAFtkYdyxNHWABMQW9Ywomw2aUlgygnXMghjlcEAq4xvVuPpPpSic79T9C3upJWmT4ntPpGpr6nAO0Ke9nFEzEolYWXdwkTeHv8HNH9Dg2X7VOgqnsyyj/MR9FMZpoBp6vnzBRVoKxaPozdI/F/kDWuUrllZDQkmAZ8toOheg0Wk+Wa+xCYL8F6M/hcZpShR4BUYXOm83mdNi0Cn0FEjYAStxxTqdcA3fTTi1ARkg70rm+ZAn6o9sJ6W7svwnvCy2GiFciCevNEqGLDW/hA/nG36ShprafKXTTTIefUhTJRopEYORFU6ju7V49u++tzdvmz3zc9GqRDlHA5J/XfdSjaJ7ZBikCEHw28g/fSoUuW/cR7HOm4ESSW0/4ZiF3TMchxpTm1FVst5J2x2VcdqdGYD7n71cFKXulcJi9edHQEGeM9Pd14nNsWBcCZsQqSg7yLy4WjXIc4SOaWqiMsCm4LKG8F/TeEwwgB0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bldEUGdaQnoyRzhvcDYraWhGcWI4SGlwekNTNWFDckZ3U0t0L0F1Y1V1NXZX?=
 =?utf-8?B?NEM3bzJvajhTR0hEOWFQRTZyYXBOd3NUNmZjV2NjcFlBR3ZIZ2NOV3lRZ2hm?=
 =?utf-8?B?amRDUDhXYnhiK0NGYm9iT2RDNDQrUDE5TTZXZms4czVrUWxUMDAybDNtUXNM?=
 =?utf-8?B?a29idnNvVWVXV1FnQXJBbjhYZXlRSUI1OFJUSWdPU3ZyODR2M2E4ZlVobzFU?=
 =?utf-8?B?Z3lkd01jV0pPeW43dndrclJzQS9oUlVncG1WZ2FwRmY3UDNQaWd6NzNPekky?=
 =?utf-8?B?cDBnbEhlQ25xTkhqOS96MDg1QkVORHgwSGY5bDZGcmliTDk2UDhUVzRLUWFN?=
 =?utf-8?B?ZURPRmVZejJnc0VCWFU3NG9iODkvZkNaeHorejF5Mjc0YUhTWlBYMzliYVRy?=
 =?utf-8?B?cVZCM2JaM0FaTzdSZHgvQlJVTzFDdlpnUVVBcURWWVVpQzdWeUFYbVV2Z3RZ?=
 =?utf-8?B?c3VTMHZ3TWV3WE5mREIra28yM0laSG1TcTR3WnNqNzBWZUd1NjRpcWZVUGpF?=
 =?utf-8?B?OUF4alV6dVppbmF3R1JwTDhjVWVrRW1aTUMyQXdRSG53TXNaWFozS2tKSHEx?=
 =?utf-8?B?dnZlOWJ1K0lRdlM0MVVsOTJkM2pjcGM3bVA2N2pZRnlzejBXY01HdjBHTHli?=
 =?utf-8?B?cUd2NTBvUTBjazV3VTJwakRoeko5RXNrMklXNFd0MDlCTFczV3htZmVCWVFL?=
 =?utf-8?B?UzBUeHpZeGJONXVvUFFOdVNIYy8yZXpmYU5TdWxydGV5Rmt5ZmVpcU1OMnli?=
 =?utf-8?B?dXpCREhVSFFjS21NbEdxY1F4Z1dRTC9lK1FndEx6VHE0ZTJOZXBENHF6ZG43?=
 =?utf-8?B?R3Q0MlhBTVZ6aDBuWGJBMlZFSWpRWldWM0VpUHBqdjhrK3ZFMU16cXRmajZU?=
 =?utf-8?B?WisrTEd0d2duMktaWEZlUDVGN284K1ZLR2wxWVl4Zk1xZEVpREYzaG5HdGVa?=
 =?utf-8?B?RHBCbVBQaEd5ai8zZi8vY2VVQlFmTmhrbFlGOUZ5WkI5Z0pERll4YTV3UFpr?=
 =?utf-8?B?dXNENTk3THdLdHAzY3I1eVJBL0dWK3c2UnJxb2x0M256aWR4dzVtL1l0L3pk?=
 =?utf-8?B?V0RCd2E5M2RGemVQcTdrUkZlQkljYm0ycnlPcW5aUnhTclF6Ukloc0RuZ1JL?=
 =?utf-8?B?NjZ2cU05M0JXaVpjTnloaVk1MWR4UWNOc2tWQVR3MHNTVG5MV1ZIQUUyRGVi?=
 =?utf-8?B?em1xWU1kT243NmFFd2JVbUZyY3BxdnA5NWUzdmFjUVZwWm55TmRYMUJ3L3V5?=
 =?utf-8?B?cDFaUFE4NTZvOGswQk9iMkVpL1laQ1hYdDkyR2F5TUt5MHVlak5acUN6ME5k?=
 =?utf-8?B?MnJ2VmpPc3p2MnRqRHQ4NVIzYmJ3Q0NqdHN0eCtXanczdG1zekM4VzJLNFdV?=
 =?utf-8?B?dGNBYTluM1hJUytMMExvN1VyKytudlJXbnA3MHFhYWNkSGp1ZXVNZndpbERt?=
 =?utf-8?B?VUoxQkhXcmhTczJiQ1J1cWhqMjFVYXYzZ3R4TC8yVkhPT2VSZmt3RWltN3A5?=
 =?utf-8?B?MHhwVUd4WG1yVWpwYnB2Q0RISVhSYVFmRDAwZ1Zmc1I0ZjFjWjloRkZKem8v?=
 =?utf-8?B?ODFsZlg0d0I3ODlvb1VOdFpkaTEvem5qZ01kN3Vjam5jMHhwS053QTdVbE5M?=
 =?utf-8?B?L0VqaDArL3JrRVNZQmdqSHQvdEN4bldGU01FdVllM2FBamExdnEwY0tnUXJl?=
 =?utf-8?B?UU8zSzFzK245ME1DS3NwYUViNmxCQzl1aGduSG5hdVM5ZGdHTkQ2dnMydk9J?=
 =?utf-8?B?T1pJcG5xVnJIOFBpYUd6RXd1YytudjFKRmliNjZzc0RrbVBaTFV2VFlTR0VJ?=
 =?utf-8?B?SXFDd21XdkVFeEdBUk5QZG5IL0lmemd4eUJoNUFKZW5qR1oyZEdkbTZZR0xU?=
 =?utf-8?B?a3ZRNEFnTHh2RHZ2UjZ6WG9zUjF4TVpaR2hQRXlEaCtITWhlM2dqd2lSdnln?=
 =?utf-8?B?amRhajloNVMrRzRsazZMWTdiTFAycVlCdE1nRERLR0NBck9mbWozbnFJM3Vq?=
 =?utf-8?B?Z2lPS25hWEk5YjZOMnMxM1NXaDBhOHhPLzdHRHB3OTVGc3M3MHhQTXEwN045?=
 =?utf-8?B?dE9hdHMvVlo5WVlNclg5Q0Y1SmFJb1lJb1R0SkFJL0M1eGF1a3ZHTHU5Y2o2?=
 =?utf-8?Q?N7/AflbSgtkWedsgxF/m8kV3N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sBT6YB/eQ5eqLv9hOTKMt70DspqG/YP5nBLPA0yGxBMTYG4zz/PfobZ1HJgjgK06SZCHuWiIPNHMQe7+wLb3QW0SavdVs+hgCKDQYoh2wmG146j9FSFxlBgxtf+aoQg70HaAWS8hqIgEGU/8zOEhtpY6JCusDGARCo0+dMp84O2CrWaw43Hkdt53HC22oBXuds0EPLZWQ8He5/OimQgBtCas8B4I1e8aH/TEH4tmbPBMjyTEJrpw6HsAlJR9ANoaRPYFFATWwgkicz3R4OWcRshY5zH4RG+eXdtzCokNaCzJccXNcWw3bdbJ3Ac6seCTUVJ5b7sKBUMGtK1+28kAE/SkBRkSKe+DAV/jTs1tMAZWcYE/V9Gm1IYW5Mx8kNF1z+Hq6bSLPIA1h/96ppGowuC66QqCvaV77sU6kqpn4xsSFYOGegXiHh/SQPZL6SENIYna2XmlxOQNP3qPlQXMrL15aqkkTvL/bW59AgdkEvT5hxR1EoeUYo2QjxP81alb57NdmI9bqQn5VKMp6x/+Wu51KnIFG/3qWv9JE2n22DZywClo1ZxiUvPiYFBOhSGiAc3/mfLiZeqqdqpdh+xApNwBIoBVVpt6HAlvHWsMJu0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abb0cc8-4a8a-4fc3-6022-08dc5e9822ed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 04:37:49.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAX3eZpT39quWGGnWcE39WjFG98M9mYNbsJ67/EdEku9mIMjB1wYWMrmvO5BheUGSYaDjXGiUDo5L8Bd2UxUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_04,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170029
X-Proofpoint-ORIG-GUID: Bbfzmlnj-mVvWprx-ors_nUZvmRuKMev
X-Proofpoint-GUID: Bbfzmlnj-mVvWprx-ors_nUZvmRuKMev



On 4/16/24 15:10, Kuniyuki Iwashima wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> Date: Tue, 16 Apr 2024 15:01:15 -0700
>> On 4/16/24 14:47, Kuniyuki Iwashima wrote:
>>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>> Date: Tue, 16 Apr 2024 14:34:20 -0700
>>>> On 4/16/24 13:51, Kuniyuki Iwashima wrote:
>>>>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>>>> Date: Tue, 16 Apr 2024 13:11:09 -0700
>>>>>> The proposed fix is not the correct fix as among other things it does
>>>>>> not allow going pass the OOB if data is present. TCP allows that.
>>>>>
>>>>> Ugh, exactly.
>>>>>
>>>>> But the behaviour was broken initially, so the tag is
>>>>>
>>>>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>>>>>
>>>>
>>>> Where is this requirement listed?
>>>
>>> Please start with these docs.
>>> https://urldefense.com/v3/__https://docs.kernel.org/process/submitting-patches.html__;!!ACWV5N9M2RV99hQ!PswtQoZm7r5MGnH8pv3OewI_PvmSRJb29YcA0pnVOzuu8T3xvWlw4lLlLzFhzn6uO2lo0bUA5Yikc2A$
>>> https://urldefense.com/v3/__https://docs.kernel.org/process/maintainer-netdev.html__;!!ACWV5N9M2RV99hQ!PswtQoZm7r5MGnH8pv3OewI_PvmSRJb29YcA0pnVOzuu8T3xvWlw4lLlLzFhzn6uO2lo0bUAdoz3l7w$
>>>
>>>
>> That is a suggestion. I see commits in even af_unix.c which do not
>> follow that convention. They just mention what the fix is about. In this
>> case it is implied.
>>
>> I am not opposed specifying it but it seems it's optional.
> 
> You want to read the 2nd doc.
> 
>    1.1 tl;dr
>    for fixes the Fixes: tag is required, regardless of the tree

Thanks will do.

Shoaib

