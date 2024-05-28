Return-Path: <netdev+bounces-98795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4438D2841
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51A8B2508D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2E13E05F;
	Tue, 28 May 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calian.com header.i=@calian.com header.b="aNRt7P4l";
	dkim=pass (2048-bit key) header.d=calian.com header.i=@calian.com header.b="c7mxYDRp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0c-0054df01.pphosted.com (mx0c-0054df01.pphosted.com [67.231.159.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D94D59F;
	Tue, 28 May 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.159.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936703; cv=fail; b=R0YfAZh0knLnOsR1a7czOK1eFk6i38k/rIks6kg359loDwG4z5U+zfflCiXtSPkCn2U5QSVTDERiO/oJpyaLk+bXjZCmBuajJlOALazVufHSygCeZR6+DCw37tWo7vYsFM5/eDxo7Eb8/WUVA2QEepNHgt1V2rkEWoWpYdsqxtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936703; c=relaxed/simple;
	bh=W3mYCLpE6hRiSoha4I3m6BLorUZ+g0w5USptQCuuKEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dEaNGRGRWvHKzhgfomdtOjRvt4Tj35c4awV3rS+D6R1dH7TNHUUyaZh1OV9gHQeFHu8WF/RpFHJGUYvUDCoRml7N/igDnrsHxj3xJGW6rHZZLgmE3ezPlMIaclyr9WOKQJJFEfNope8TgiOJp56PMp/ex2clGyYpQtibVtaMTFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calian.com; spf=pass smtp.mailfrom=calian.com; dkim=pass (2048-bit key) header.d=calian.com header.i=@calian.com header.b=aNRt7P4l; dkim=pass (2048-bit key) header.d=calian.com header.i=@calian.com header.b=c7mxYDRp; arc=fail smtp.client-ip=67.231.159.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calian.com
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
	by mx0c-0054df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SJN9QU023253;
	Tue, 28 May 2024 18:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	selector2; bh=W3mYCLpE6hRiSoha4I3m6BLorUZ+g0w5USptQCuuKEQ=; b=aN
	Rt7P4lY70M1jw861zRh7UrUZKhLgeIQ6RJalbDEtMeSTQxpGSHI5rDSVwFT6AFEJ
	z3aAcSyO5tDtWWATOqp3KUvf/ev+dgcllrzrcORava/42+mDLumDTOUL/teIXVXr
	roKuZB1ljZjrmZYEI4QqdsIvvPEF53i3560lkPamu24m43ghpYJWLholDEYGBzYR
	nV8nW91EL90DeF9vdZ/UTqdja6cRgPXZgD1pP7dHSNoqrWputJKBpF8o/TzaVckL
	ET1BX5fHD69y0auhyusno6CeksydgWj4W5dX2kCtARAOGrX6ZvwFewUQ3qFaRzT1
	5LrnEtSdHzY+7aKwf1Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	selector1; bh=W3mYCLpE6hRiSoha4I3m6BLorUZ+g0w5USptQCuuKEQ=; b=c7
	mxYDRpo0Hrhu0sDXGWmWO8MIN/EfzP3WzG2K0X42JgYBdrY0tMKHbPld7JMFX5i7
	IGXfeDpldf8ssY1DpEQdBdOBJp1XG/RHbXXEUagnwUCFOaHdSMYWwZt5RgCGG/qV
	tQIsjvo3B4f4bgHYFh1Z2W5ZOr06M3rSavzehqTH/PQbW54oZcoI+iNRbuokME/N
	pgaTJPNTCOa/useOghhT8bvxzvch4EQQkWkQwFKWN4/GfiOPwwOOTwJSiJ2kSTkX
	WiqdX6zJVy+8deqe7DL6KnV3M0lR1bqRANWmL9ubgfeip5+4GJdz4Zcxheex5mY/
	6UL/jXl77p3Es460V+Qw==
Received: from yt6pr01cu002.outbound.protection.outlook.com (mail-canadacentralazlp17012010.outbound.protection.outlook.com [40.93.18.10])
	by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3ybb3sub1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 18:37:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF4wbxPgFeQ37vlJqlgyQuAVFLt7L6Hs+zBA9FVHJpQSmw6TMHysps6IsfTS2HKMQMpxhsxqojKdZLrWZ6XGh+MNBpf3+lumESSw0QikLGTgzMmVnmncgqXqzZvFCHWBllojIXlb6v3MSZwQnsxeQWdXHoai42zMm5EMCA94DcX8MCVcuEyREUMuRS4AQhVA+utGYVWrrA//owujE2Kw+jDcsqxmmxJPJxozgIgHpQu+tqXfAx63dji5N53PNEMVNA4L1B/DWDpagkuM3BfdsgZHda5Reso0ngGcUQpg7XeOmRNQIMnPVxqelJAFSmkPOGcCtaCjUMuxFz+USTTvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3mYCLpE6hRiSoha4I3m6BLorUZ+g0w5USptQCuuKEQ=;
 b=TuqSprPN932t7Z4JvAJ3XxJLGBr+NY4s8EAxnjtzVy5GhlHMPTJusYxUn8pF3WZ8PgspQemcfObLNWpZebmd97JxYk/xboctPhGOS+AS7pt/GxLQvAleIJx+wlzpw8MPvklNN40g+zktwxy1jxOqGqno1uYDCgQbdw+NsNDV8MM61TP/C7U4OoWjrPpQMpVP0/5Kxqyno22rAPSKUwEuYX+Z6+yiwDu+FXQzOXdh6KyxXCvT3j04gQi/H5HJJx4fO+IwVC1Bf1/IQhWEZr/lWUKmkTXYVAlHSi8MwySC+fJUIKIwozh66vDU4jUV44BCzrmFpmLp8r/P8DntfK/wSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
Received: from YQBPR0101MB4129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:13::12) by YT2PR01MB9350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 22:37:04 +0000
Received: from YQBPR0101MB4129.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::f136:60c4:8f93:d352]) by YQBPR0101MB4129.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::f136:60c4:8f93:d352%7]) with mapi id 15.20.7633.017; Tue, 28 May 2024
 22:37:04 +0000
From: Robert Hancock <robert.hancock@calian.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "Tristram.Ha@microchip.com" <Tristram.Ha@microchip.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>
CC: "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: [PATCH net] net: phy: micrel: fix KSZ9477 PHY issues after
 suspend/resume
Thread-Topic: [PATCH net] net: phy: micrel: fix KSZ9477 PHY issues after
 suspend/resume
Thread-Index: AQHasUa9Azn9/9MN6EW7u8nWJ4fDMrGtPJGA
Date: Tue, 28 May 2024 22:37:04 +0000
Message-ID: <13cc6020cab02aba5848de43c8653a159d47a367.camel@calian.com>
References: <1716932220-3622-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1716932220-3622-1-git-send-email-Tristram.Ha@microchip.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR0101MB4129:EE_|YT2PR01MB9350:EE_
x-ms-office365-filtering-correlation-id: f7941a65-582a-43e1-a17d-08dc7f66b2e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cEp3T1M0UUFTOUkzN2h2d0xLY2ZBN08xK3ZQbzNJcnAzV2VVdXJHOWpKdzlu?=
 =?utf-8?B?ZkpmK0RPZFh2Z3hhYTh6a1ZtZmJXTEd6TzlQbTdmc1cySnBVdFFPQUUwVkxV?=
 =?utf-8?B?MW1UalFWV04wdmR0c212MFUybWtzOW5oMERVVmtrS09NdVFsR3JhdEp4NUlz?=
 =?utf-8?B?OG9pbDZnaGtXWnlTR0NWNS9OZHAvdk45QS9ReVRRMTRBUEFTUlZ6djFVa2Jn?=
 =?utf-8?B?SUJkQWFqYVYwK2NacGhFUitOck02UFpIbHY5aGJzWjY1VGxtT1dKNjNQMk1a?=
 =?utf-8?B?a01uZmx3OUQyY2tMSnVwdTlVZXFkK2Q1a3psTXQxell4dGhYZWs4TUhEUW96?=
 =?utf-8?B?TEl6SEdSelp5NlJoeE1Bd2ZWYjZpOW1JNDRVMFErNy9qdndiRDdNUk5XWWE4?=
 =?utf-8?B?clZIYXdEbzlCTHlWejJqclQxZ1pzalZWVzJZaEh0REw5c2xZbERkcFRRWjdB?=
 =?utf-8?B?SU8vVlRoa3VBY2ZHUXRwS2Vud1lYZ3VSejdnUFZRbUtRRWtyOUNMRU42d3JV?=
 =?utf-8?B?TlZwVk1NRitSbDRUeDlSOFVadFFmK3JZV2lpRWdYSXZMWW5oeXpUeEtURjRp?=
 =?utf-8?B?b25uNHV0QU5FdjlBcFN6VnFIaW1IMkdhVW1pQlp3WnlLL2cydkwwTnFGRktU?=
 =?utf-8?B?RDE5ZUZVdm8vV24zYStpbUhtaENKcm8zYTVQcENoK1h5T2thbzQySVpyZEl5?=
 =?utf-8?B?N3JVdVMwd0NHdkJYNVVRb3ZiY08rV25tcDFhQjM5YnExMlJWOVdvME0xT3Z6?=
 =?utf-8?B?VmdWZkdaOVVIb3VYbkpCWjhOeHhudUl3SFNFczZCK0h0MUIwdzlJaEIvQ3gz?=
 =?utf-8?B?TndSOUU0ZVhkbUZmNU5YNWNWOXVtSThHTS9WRmtGSE5vUlE5TmFaUndjRnZQ?=
 =?utf-8?B?cFM0WlFuQUw4azJnUnRhZE5XeEtUS3hic2NLTWlBcXpzWmFFWkhCR1JBUVFk?=
 =?utf-8?B?MC9qUG5sdjdCNVR2Kzk4ZCsvRSthYXgxWHVFcVo5QU5lYktmdjE1V0RTVTk5?=
 =?utf-8?B?d2hDdWZzUk11ZEI5TXg5cEcvWVp1Z09FUzhtWVFrdDhzeVQwZEtWeGo1ZW0x?=
 =?utf-8?B?NURFTWx2eDRaLzBqNE9GNDFFWm9CZDU5NUZ1RjdVSVovWjRxdDBUZzVGQm5i?=
 =?utf-8?B?OEtZdzNNai9EU2V4ajErWk50QURIK2JUTm02ellZcTNNMHR0R25IR1pkMHls?=
 =?utf-8?B?bElyQlRsZUl4Tk03ZFlBOC9DT3pOWWZZVzBmQStKNjNYUVdSUkc5RDJ6bUpG?=
 =?utf-8?B?djRaU3FObzNVRWtmd2xKYkFJVVhZN0FzeGxTTEFFb0ZjQ3pkU015dnN5Q0tH?=
 =?utf-8?B?Tk9ybVZtSVJJZEY4K0ZCODlGL2paYWQrc3J2OXFjdVI1cHFZd1RNRm84TitO?=
 =?utf-8?B?NGQ3Vkd2WmZLUlg4UkF1VDNlNUZNWjhXSU14T2VBRlF2SzYxRnRYNTMwQmRS?=
 =?utf-8?B?YWQ3ZkFyQnRLTHM0NUIxSm1NZkp4OSsyZCt5Y1FEZGlnbWtJMlJZNWZMY25S?=
 =?utf-8?B?VkY2M3ZsRFltLy9mNW02MUhCcjhkVEYyU2hzL1hvSjhMbUVSYnUwMjY0RWNT?=
 =?utf-8?B?cmtocjVVU0xvUnhSblhMdnFOL0dVd1IvR3ZlN1RmM1NhemxZTTlMWjd2dlI1?=
 =?utf-8?B?RWlMN2dyb2wzaFBOcFIwbThjRzBmaXJFMXJPajJsZVlsTFlTSTZKTHZEMlhT?=
 =?utf-8?B?R29KbXcvYkV3Z05JdlExRkp2ek4ybk5uQkE4SzFDNUdoT3V2YXJ5MENKVE1o?=
 =?utf-8?B?QkhHQ0pVd1B1OGdkc1V3UWJuRy8yT0lzWHJOc2RGNE5pcUl1bGljbWM0bENl?=
 =?utf-8?B?K2tqbzMxQVAvVU9TVEZhQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB4129.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R2xqUUdkdjFEVWdmVkdqc2ZMcEZZWGxnRjZ6ckxNSC9KTi9ZYjVING01eGVQ?=
 =?utf-8?B?aDJmMmo4Smo5QVZ1Q0d2RjFGWmRNV0JBemxJMGNVVEFLUk9ROVpEcFdhZS9s?=
 =?utf-8?B?TnJvUkVRMTlnTENnRjE1d055ZUx2WjhmdjU1bldjbE43MHhmeVhaY094aVdw?=
 =?utf-8?B?dEhleDdLbFkwdVk0OE9vR1FnTEJaR2VsU09PdUFhYy9tZTJsZk1peG9SbG9N?=
 =?utf-8?B?VVRMd00zaTRDQ0dqdGtDNWRaNVc3a21EbEFwbE9UUml1ZWptR1dKNGVDRGd6?=
 =?utf-8?B?VnltMWpsck5RNm5SVXNoYnQ2djhEQVlnZ2FoQ2hRMnlxNnhRR0hjVTdGdDRU?=
 =?utf-8?B?MG5RWnAvb2kreVlKb3RyVGlBUjJmVFJNZUR0WXVCRWtaelllTXo0Y0lJQVAw?=
 =?utf-8?B?TWp6NUdvNkdGK0c4NDUybWc4ejJUVUhKd1JHRTl5bEdvd3pVWVZnL0k2TXc5?=
 =?utf-8?B?b2F6SFRGSnJRcFlKOSsrWUtrWkp1bkJHSVI3Mm9tMUNiWlErZ3YxRzJHOC8y?=
 =?utf-8?B?OWtqa0FHbG5kTENDbDhzZXR0M1lNc3ZJclBuU2xjdHFqeEU0YmNGYWlqQ0N5?=
 =?utf-8?B?M0Y3WC9mOVlxRTJkSEE4aVRPNXpEN0R5dG5lcTBPS0pyeEkyTG5rcUVRc2kz?=
 =?utf-8?B?VmlNeENJOXlxRnpDZ1lLMFZpUCtRVjVFRmRvdE1FNkN0cFRCblZjbDlteFJU?=
 =?utf-8?B?SGZVOC9TRTBaMUNaRjhuekJaYU9wUDZXbStkS0VzK1JMUWFpOFZIWGJ0ZCtl?=
 =?utf-8?B?RDJSd1V6L2RpQnNTNjJ4ZkMzTlk1ZmZ0NktZWmxSa3UyY3NQbEhSTldxeHNZ?=
 =?utf-8?B?NHRHVCt4Nk05UlJma2VZSXlFR055dGVDdkdPUXcxcGFoaXUvSDFTODFnVGE4?=
 =?utf-8?B?UnZ5UEYzdys2TURiMVp5UnUyT3oya29EMjVmaTdnOEc4UW1pYjBuWjAyUFVG?=
 =?utf-8?B?eFU2UjlEbzI1dXBramJJdXNId3NEbEcrVWNvN1gvOWNVRThrZTRPaHRzZEZr?=
 =?utf-8?B?RGlFTlhFcHlkMnJpTzd0dXlYS29zaG1rNVJleEZteUZjQmpsM0NBcDkzTlRo?=
 =?utf-8?B?ZGU0YkhENmNLL3FreHNwc0xDYnpXaDZYajE4QTgzT2NYU1MwakZEbUhycjBK?=
 =?utf-8?B?eTdIVUxneUo1WGw4bVptcDYyUXFMaEM4cXBFR25nMDBtaGlQR0U2ZTV1MkE0?=
 =?utf-8?B?bURJMTRwcnRZT0xrUmtNVElMaFNGOGlkcjUwNVJzSDZoWlY3U2dEbmdnb2ZB?=
 =?utf-8?B?MGI4T0tDbnV5U05wc0FleTJGSTZKbldPem43VjBmVVFINkNLQlZDdENYTUJ6?=
 =?utf-8?B?TytGVHFMYlV3NjlMTnU0L3JyclVyV3ovWXJ3dlpOSzNpRy9VcTJOdXRFa2dN?=
 =?utf-8?B?KzlLclBDUm9VejIxTWZkbHZjczdncmhLWC9JMHhmdEtSKzlwdE9ldXEzc1lL?=
 =?utf-8?B?WXBDc1k1RHlGQXloSUtxMnJ0WHFTUVBhUTNwdWVsUE9jZURnSWY4SEh2VklC?=
 =?utf-8?B?N0UzSHVUeVpvT3ZNdTF1UCt6MWIxTml1U2puUHhOSzBCVjRNSXYxdFJmVHBv?=
 =?utf-8?B?Y3p3RnhCdVdQVi9TTjNaS1ZtWTF3QUJlWlFWeTdVNUdlSnoyQ1pRUkNxQS9y?=
 =?utf-8?B?Yjkyd3ZhTkRwSThDemFtTjdkMjF5SS92cGt2Y2ZTT1h3bkFpUHllTzNxLzcy?=
 =?utf-8?B?OFovbEFGUUQ0ajVEY3NBQmVWNFRxOWZnM3U1SlZOSUVHblRvanRMOHQzWmhK?=
 =?utf-8?B?SFhzZzV6RllTbmtkWFFTc3BuWUEwMnlrMlNmemluVFc2elFvZUY5NEowMVlw?=
 =?utf-8?B?QVhzTFdkWVJhRW94TDdNRmYza205RlNoZDlxZUJNNTkyZFd2Y2NlRFByZnk5?=
 =?utf-8?B?VUZvQ3BXdGJzeWNJdEoxZ1YzeUlialQxTXRjZ1hBcjd5TDhJa2w0WWZ0Nlk0?=
 =?utf-8?B?ZGdVRVBqZGdmZTdXS1VtMEZhSFRUM1p0YWpNaFh2aVRGVDhheUpmbitrU1R4?=
 =?utf-8?B?a1BOQ2JNN1BrTmUxaTlmOXVYTkFuTVdNTUU1SnRhanhjdzRRcW9lc3F3RGp2?=
 =?utf-8?B?aU5TSDJKRGFDL1dkbFI3blNpdm5MTFFLemMza0NYVXJlSGtWNk4vSHBoam1a?=
 =?utf-8?B?VlZaN284azVFUjEvbUFFWFlYeURUaUtPYm55WjM2all6OXowNHRRd2ovM2pZ?=
 =?utf-8?B?dlZYRGVmaSt3WnM0cTJIczRlUlYyK05tV0VnVjlkVEV5cUYzYUZDUStJcVZS?=
 =?utf-8?B?ejNHUkJycG9BNFFCTWZwdmtGbE93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C3C0FEFDD3F184F8A65A9C5793F6B60@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	83V8V27WMPchBBr3BHzH34eYO0NGRArkhqpI5eCKIa/WZpqG1YrlkwxQ5zHMb2EEePbd2fSZGG0ll7FhLJ74dCQ9agCnzSr6AbZs7znPlA0mB8WDj21yUUWCCQM10lKZXDlAZ/45OcdYIq/pxn/gZQgQA8jFabj61R5ROzyWid6Qk8p+yanjImx785JiVWb7+2OkStbAX/OuUt/IkVJZWiYBTx8P8Iu15sIngM+yx57+jAek6Z5+gJOuRzPWwxtwfsFfOTwBxulXF12oju0YRCU3uWm60UPUkqwMB35BTxNd/QV7R5JJoLCMtZbSB075aIq2gCsdBRZPn6Q0xDhFFYW0OHAjug8ZppeYDtdKGhJl1V2Rvg6t4s4uKL1Skhe8jvby4yxHooojoNFfdxOCwypu94hABRx4xF5LOlfotEdqBO6ER+2pw1WqlEnm+kdexRsx1T++jt8QqBZMBt5DdBIBKkZ8jIJ3l6X6SxgpcG7KVyhwbqY+22HkOxN4dpUP0XP7cJbEogW1ZAQIQ6tA1Gqf7IZPuqkWVTphTyx/d5xBHsrFtb5h/Oc/MZ+vZytlXhKF9kYk7iYF/CXZyc7NpGe3uv5EPGA+KgqZBjjmA0De+lWt6yPrVvkQXFW/Q/JC
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB4129.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f7941a65-582a-43e1-a17d-08dc7f66b2e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 22:37:04.3782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cynSyJfiPv5q8/3NILqdbjL62XygB2MvpQ4nhWZvqhvEVfePhqaCMlfSGV+wG5/7XIN2AbqPXSyf7wNYxwavk8UQGlB1RH/lY1FdXsVTHyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9350
X-Proofpoint-ORIG-GUID: k6lBxwI4L0bfgTB_CC6w3xnzHNwH9gzy
X-Proofpoint-GUID: k6lBxwI4L0bfgTB_CC6w3xnzHNwH9gzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405280167

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDE0OjM3IC0wNzAwLCBUcmlzdHJhbS5IYUBtaWNyb2NoaXAu
Y29tIHdyb3RlOgo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyCj4gYW5kIGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZS4KPiAKPiBGcm9tOiBUcmlzdHJhbSBIYSA8dHJpc3RyYW0uaGFAbWljcm9jaGlw
LmNvbT4KPiAKPiBXaGVuIHRoZSBQSFkgaXMgcG93ZXJlZCB1cCBhZnRlciBwb3dlcmVkIGRvd24g
bW9zdCBvZiB0aGUgcmVnaXN0ZXJzCj4gYXJlCj4gcmVzZXQsIHNvIHRoZSBQSFkgc2V0dXAgY29k
ZSBuZWVkcyB0byBiZSBkb25lIGFnYWluLsKgIEluIGFkZGl0aW9uIHRoZQo+IGludGVycnVwdCBy
ZWdpc3RlciB3aWxsIG5lZWQgdG8gYmUgc2V0dXAgYWdhaW4gc28gdGhhdCBsaW5rIHN0YXR1cwo+
IGluZGljYXRpb24gd29ya3MgYWdhaW4uCj4gCj4gRml4ZXM6IDI2ZGQyOTc0YzViNSAoIm5ldDog
cGh5OiBtaWNyZWw6IE1vdmUgS1NaOTQ3NyBlcnJhdGEgZml4ZXMgdG8KPiBQSFkgZHJpdmVyIikK
PiBTaWduZWQtb2ZmLWJ5OiBUcmlzdHJhbSBIYSA8dHJpc3RyYW0uaGFAbWljcm9jaGlwLmNvbT4K
PiAtLS0KPiDCoGRyaXZlcnMvbmV0L3BoeS9taWNyZWwuYyB8IDYwICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkv
bWljcmVsLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMKPiBpbmRleCAyYjhmOGI3ZjE1MTcu
LjkwMmQ5YTI2MmM4YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMKPiAr
KysgYi9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMKPiBAQCAtMTkxOCw3ICsxOTE4LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBrc3o5NDc3X2VycmF0YV93cml0ZQo+IGtzejk0NzdfZXJyYXRhX3dy
aXRlc1tdID0gewo+IMKgwqDCoMKgwqDCoMKgIHsweDAxLCAweDc1LCAweDAwNjB9LAo+IMKgwqDC
oMKgwqDCoMKgIHsweDAxLCAweGQzLCAweDc3Nzd9LAo+IMKgwqDCoMKgwqDCoMKgIHsweDFjLCAw
eDA2LCAweDMwMDh9LAo+IC3CoMKgwqDCoMKgwqAgezB4MWMsIDB4MDgsIDB4MjAwMH0sCj4gK8Kg
wqDCoMKgwqDCoCB7MHgxYywgMHgwOCwgMHgyMDAxfSwKClRoaXMgY2hhbmdlIHdhc24ndCBtZW50
aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCBidXQgSSBzZWUgdGhhdCB0aGUKbGF0ZXN0IGVy
cmF0YSBzaGVldCBzYXlzICJUaGUgdmFsdWUgb2YgdGhpcyByZWdpc3RlciBtYXkgcmVhZCBiYWNr
IGFzCmVpdGhlciAweDIwMDAgb3IgMHgyMDAxLiBCaXQgMCBpcyByZWFkLW9ubHksIGFuZCBpcyBu
b3QgYSBmaXhlZAp2YWx1ZS4iCgo+IAo+IMKgwqDCoMKgwqDCoMKgIC8qIFRyYW5zbWl0IHdhdmVm
b3JtIGFtcGxpdHVkZSBjYW4gYmUgaW1wcm92ZWQgKDEwMDBCQVNFLVQsCj4gMTAwQkFTRS1UWCwg
MTBCQVNFLVRlKSAqLwo+IMKgwqDCoMKgwqDCoMKgIHsweDFjLCAweDA0LCAweDAwZDB9LAo+IEBA
IC0xOTM5LDcgKzE5MzksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtzejk0NzdfZXJyYXRhX3dy
aXRlCj4ga3N6OTQ3N19lcnJhdGFfd3JpdGVzW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqAgezB4MWMs
IDB4MjAsIDB4ZWVlZX0sCj4gwqB9Owo+IAo+IC1zdGF0aWMgaW50IGtzejk0NzdfY29uZmlnX2lu
aXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikKPiArc3RhdGljIGludCBrc3o5NDc3X3BoeV9l
cnJhdGEoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoCBp
bnQgZXJyOwo+IMKgwqDCoMKgwqDCoMKgIGludCBpOwo+IEBAIC0xOTY3LDE2ICsxOTY3LDI2IEBA
IHN0YXRpYyBpbnQga3N6OTQ3N19jb25maWdfaW5pdChzdHJ1Y3QKPiBwaHlfZGV2aWNlICpwaHlk
ZXYpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gZXJyOwo+IMKgwqDCoMKgwqDCoMKgIH0KPiAKPiArwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7
Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQga3N6OTQ3N19jb25maWdfaW5pdChzdHJ1Y3QgcGh5X2Rl
dmljZSAqcGh5ZGV2KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoCBpbnQgZXJyOwo+ICsKPiArwqDCoMKg
wqDCoMKgIC8qIE9ubHkgS1NaOTg5NyBmYW1pbHkgb2Ygc3dpdGNoZXMgbmVlZHMgdGhpcyBmaXgu
ICovCj4gK8KgwqDCoMKgwqDCoCBpZiAoKHBoeWRldi0+cGh5X2lkICYgMHhmKSA9PSAxKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0ga3N6OTQ3N19waHlfZXJyYXRhKHBo
eWRldik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVycikKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPiArwqDC
oMKgwqDCoMKgIH0KPiArCj4gwqDCoMKgwqDCoMKgwqAgLyogQWNjb3JkaW5nIHRvIEtTWjk0Nzcg
RXJyYXRhIERTODAwMDA3NTRDIChNb2R1bGUgNCkgYWxsIEVFRQo+IG1vZGVzCj4gwqDCoMKgwqDC
oMKgwqDCoCAqIGluIHRoaXMgc3dpdGNoIHNoYWxsIGJlIHJlZ2FyZGVkIGFzIGJyb2tlbi4KPiDC
oMKgwqDCoMKgwqDCoMKgICovCj4gwqDCoMKgwqDCoMKgwqAgaWYgKHBoeWRldi0+ZGV2X2ZsYWdz
ICYgTUlDUkVMX05PX0VFRSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGh5ZGV2
LT5lZWVfYnJva2VuX21vZGVzID0gLTE7Cj4gCj4gLcKgwqDCoMKgwqDCoCBlcnIgPSBnZW5waHlf
cmVzdGFydF9hbmVnKHBoeWRldik7Cj4gLcKgwqDCoMKgwqDCoCBpZiAoZXJyKQo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7Cj4gLQoKa3N6OTQ3N19waHlfZXJyYXRh
IGlzIHNldHRpbmcgdGhlIFBIWSBmb3IgMTAwIE1icHMgc3BlZWQgd2l0aCBhdXRvLQpuZWdvdGlh
dGlvbiBvZmYsIGFzIHRoZSBlcnJhdGEgc2hlZXQgcmVxdWVzdHMgYmVmb3JlIGFwcGx5aW5nIHRo
ZQplcnJhdGEgd3JpdGVzLCBzbyBpdCBzZWVtcyB3cm9uZyB0byByZW1vdmUgdGhpcyBhdXRvLW5l
Z290aWF0aW9uCnJlc3RhcnQgaGVyZSBhcyBpdCB3b3VsZCBwcmVzdW1hYmx5IGJlIGxlZnQgaW4g
dGhhdCBzdGF0ZSBvdGhlcndpc2UuCk1heWJlIGl0IHNob3VsZCBiZSBtb3ZlZCBpbnRvIHRoYXQg
ZnVuY3Rpb24gaW5zdGVhZD8KCj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGtzenBoeV9jb25maWdf
aW5pdChwaHlkZXYpOwo+IMKgfQo+IAo+IEBAIC0yMDg1LDYgKzIwOTUsNDIgQEAgc3RhdGljIGlu
dCBrc3pwaHlfcmVzdW1lKHN0cnVjdCBwaHlfZGV2aWNlCj4gKnBoeWRldikKPiDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gMDsKPiDCoH0KPiAKPiArc3RhdGljIGludCBrc3o5NDc3X3Jlc3VtZShzdHJ1
Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoCBpbnQgcmV0Owo+ICsK
PiArwqDCoMKgwqDCoMKgIC8qIE5vIG5lZWQgdG8gaW5pdGlhbGl6ZSByZWdpc3RlcnMgaWYgbm90
IHBvd2VyZWQgZG93bi4gKi8KPiArwqDCoMKgwqDCoMKgIHJldCA9IHBoeV9yZWFkKHBoeWRldiwg
TUlJX0JNQ1IpOwo+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDApCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiArwqDCoMKgwqDCoMKgIGlmICghKHJldCAmIEJN
Q1JfUERPV04pKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ICsK
PiArwqDCoMKgwqDCoMKgIGdlbnBoeV9yZXN1bWUocGh5ZGV2KTsKPiArCj4gK8KgwqDCoMKgwqDC
oCAvKiBBZnRlciBzd2l0Y2hpbmcgZnJvbSBwb3dlci1kb3duIHRvIG5vcm1hbCBtb2RlLCBhbgo+
IGludGVybmFsIGdsb2JhbAo+ICvCoMKgwqDCoMKgwqDCoCAqIHJlc2V0IGlzIGF1dG9tYXRpY2Fs
bHkgZ2VuZXJhdGVkLiBXYWl0IGEgbWluaW11bSBvZiAxIG1zCj4gYmVmb3JlCj4gK8KgwqDCoMKg
wqDCoMKgICogcmVhZC93cml0ZSBhY2Nlc3MgdG8gdGhlIFBIWSByZWdpc3RlcnMuCj4gK8KgwqDC
oMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoCB1c2xlZXBfcmFuZ2UoMTAwMCwgMjAwMCk7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqAgLyogT25seSBLU1o5ODk3IGZhbWlseSBvZiBzd2l0Y2hlcyBuZWVk
cyB0aGlzIGZpeC4gKi8KPiArwqDCoMKgwqDCoMKgIGlmICgocGh5ZGV2LT5waHlfaWQgJiAweGYp
ID09IDEpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBrc3o5NDc3X3Bo
eV9lcnJhdGEocGh5ZGV2KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
cmV0Owo+ICvCoMKgwqDCoMKgwqAgfQo+ICsKPiArwqDCoMKgwqDCoMKgIC8qIEVuYWJsZSBQSFkg
SW50ZXJydXB0cyAqLwo+ICvCoMKgwqDCoMKgwqAgaWYgKHBoeV9pbnRlcnJ1cHRfaXNfdmFsaWQo
cGh5ZGV2KSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBoeWRldi0+aW50ZXJy
dXB0cyA9IFBIWV9JTlRFUlJVUFRfRU5BQkxFRDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAocGh5ZGV2LT5kcnYtPmNvbmZpZ19pbnRyKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaHlkZXYtPmRydi0+Y29uZmlnX2ludHIocGh5ZGV2
KTsKPiArwqDCoMKgwqDCoMKgIH0KPiArCj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiArfQo+
ICsKPiDCoHN0YXRpYyBpbnQga3N6cGh5X3Byb2JlKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYp
Cj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IGtzenBoeV90eXBlICp0eXBlID0g
cGh5ZGV2LT5kcnYtPmRyaXZlcl9kYXRhOwo+IEBAIC01NDkzLDcgKzU1MzksNyBAQCBzdGF0aWMg
c3RydWN0IHBoeV9kcml2ZXIga3NwaHlfZHJpdmVyW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqAgLmNv
bmZpZ19pbnRywqDCoMKgID0ga3N6cGh5X2NvbmZpZ19pbnRyLAo+IMKgwqDCoMKgwqDCoMKgIC5o
YW5kbGVfaW50ZXJydXB0ID0ga3N6cGh5X2hhbmRsZV9pbnRlcnJ1cHQsCj4gwqDCoMKgwqDCoMKg
wqAgLnN1c3BlbmTCoMKgwqDCoMKgwqDCoCA9IGdlbnBoeV9zdXNwZW5kLAo+IC3CoMKgwqDCoMKg
wqAgLnJlc3VtZcKgwqDCoMKgwqDCoMKgwqAgPSBnZW5waHlfcmVzdW1lLAo+ICvCoMKgwqDCoMKg
wqAgLnJlc3VtZcKgwqDCoMKgwqDCoMKgwqAgPSBrc3o5NDc3X3Jlc3VtZSwKPiDCoMKgwqDCoMKg
wqDCoCAuZ2V0X2ZlYXR1cmVzwqDCoCA9IGtzejk0NzdfZ2V0X2ZlYXR1cmVzLAo+IMKgfSB9Owo+
IAo+IC0tCj4gMi4zNC4xCj4gCgo=

