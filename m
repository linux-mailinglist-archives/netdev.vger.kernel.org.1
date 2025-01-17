Return-Path: <netdev+bounces-159244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79586A14E7E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAFF188701C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3801F91E6;
	Fri, 17 Jan 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="gfvuQRpE";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="oK/RiNc1"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay67-hz1.antispameurope.com (mx-relay67-hz1.antispameurope.com [94.100.132.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BE1DB34E
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.132.234
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113527; cv=fail; b=qurJaqRba4JhNzwpyf3RGCsBjhX35b+7Egz8eB89yZlzubQeYZy3XjZe1i9Jo6e0V44WRa4ZVhJIh4/Ud5MsO/vNAhBpVTCgiFYk+e1yRrauMoqt/Hq0ES6UtdDeWvR6RUYY9jhbzHtsz5vL2yAxzUiv0LkaB0J5mFNzh7rb9fU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113527; c=relaxed/simple;
	bh=brErExzOHNabk0CSQkJ1caXkP+Gt3vH7Sgg/pPYiSEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gg4a1iFwOgbcAp0GdYut3bh/YiLFiYZB/VP8TkZajvlgWQYbl+6q3hWZDfYIUUaT45S0l03LaihZ7SLsolhLW9wudLxJqCN3DVrkPgjVeiyyEBx80EnTP2+DUW8aD/CLVk2qtOoJLPNQ1QKlF97/wM6EKha0TrS6120L8anfrOY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=gfvuQRpE reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=oK/RiNc1; arc=fail smtp.client-ip=94.100.132.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate67-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=104.47.11.43, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=eur02-vi1-obe.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=brErExzOHNabk0CSQkJ1caXkP+Gt3vH7Sgg/pPYiSEI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1737113451;
 b=Y7X864fbLqXri4iTM9Yetj7Zs9F/lRl23JwrDHTk5BknW6qvepg5olM4v+Xw/FE2OcZWyO0U
 8wQpsg0x+3XgjWQv3VnFXim3bqxNLpwgWkzwb6SkmVlPA1KFFYpt+meJmeMXamEd/PtJaukFm3Y
 Zv/Un95NkP0z3+1PGKK1JyRnWi0ty6nqHAeHM+tpf8ah0yYZVTsC3wr+QwmL5u84CP21M22V6jT
 uJYcmS9QU09g0gXGQUCFXHYzwDN4jpfMxAsRZ2IZq1hh/4HFdHVYiv2nKLxI4eI/VhNW7n7z30v
 VDMtyw5vaRbS20JYNC48R2MyrNQiAnIPPtAHbmsjUNXYA==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1737113451;
 b=HP+LopS6SmE04HDkrKN+ym41zQaoBwkzEFVlhviBH6vPjulB2BN23VFBQ+Qk5xdeuLjPqAHf
 Pioq1WKPQbst7DZ8bTT1qq3ee12ej+BFt5owFMnKpYi0U8VhKX62GIEu+GqljNtdsa7Y9njLPmt
 GnhTmgVTQu4WTCWlvTqwgipbTnTZfHJ56xkWWDfkp51DlYa5/4FtquH8rOm7k6QKPjviJhh5puU
 N9NXWc72XU4F4M6GPT+wTUgvZHyOO6Dq6A+QJDhlwUI05S/XEwWhdmzuvgub28/+0kMmdVuDG7e
 Jm4WYvsLWcl2BKM9Rray1I00dbIk51g7nOfl+uGPqI5TA==
Received: from mail-vi1eur02lp2043.outbound.protection.outlook.com ([104.47.11.43]) by mx-relay67-hz1.antispameurope.com;
 Fri, 17 Jan 2025 12:30:51 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERt+lMzqmr1feIhR+W26GniLzEzCGSVGDXmKRPMxwbom/1693h2qyFebXu0YAnIBVuVz6w9opyvB62mt4x9dUjPqGegGoIXCn2guyVY9JDFdll5pwpcgIu5PyprwqmHjxCoD0RygrJ/+Wd8aFGOuog9VMgMfIgY+nVoP9dAQUamnWGUWzstV5VcGTCoJKw4WxC+JD2+L7yIjLErxnvbBy1iCqgXT7w2OMcA0IFwHN5Z8uwSA0XbVOaY0VD+WxFQp4gEtNfO6CHv6KilpBwy8sSI4aHD3t7nA39QkuUbVAZWR/sH32eFxXuYAeYlCWwkkVpzDZTaXRaNR3DE1UruYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brErExzOHNabk0CSQkJ1caXkP+Gt3vH7Sgg/pPYiSEI=;
 b=PEpoX+2OO/DrovUkRjp4L/TMUdJU9z0uGK1tkthCN4F5DJjS/DJ7Nx517nA6NUtjpBJxFrLdqATZl9RvK+cXmBVb8xbmlyKpArh1BAGMdmQlgE9F47oWGJA9sUxF7jkrWidGXP7WiX5DMY0+l/yBY9Dd4mxOrH9QxGtgUdGSPBaTVY3Dnb+CnL2dxJZ5jd4Sspj8XhQdZEPqBDcVhFd31vHUWlgFZIPJIEq8f+obiP2fqvH6ShmB8KdyU2jt92ytpQldpl1mMc0DuXcZqHA34V7zk1fcr+rhzeF4tzbDt+7wWX0P3PA257MLuFLspLlVA1WoI1jIIFRruVonDEPRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brErExzOHNabk0CSQkJ1caXkP+Gt3vH7Sgg/pPYiSEI=;
 b=gfvuQRpEOE9oxLk9M3XvVMI8MJ28YZ3G7tMuip5grpQP3x6F4zLV6ogHLyHhgqTcyTH/tkNupCSXTRsVUaifeksyJeCFQKV28CinYaJCkK/UvuD/qmjqiTLs8xftpU+GkAD9lcn+tZ/bgDpYFld3VVWu9sdTB8b022J6ZuOYMjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::16)
 by AS8PR10MB7352.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.6; Fri, 17 Jan
 2025 11:30:27 +0000
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9]) by PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9%6]) with mapi id 15.20.8377.004; Fri, 17 Jan 2025
 11:30:27 +0000
Date: Fri, 17 Jan 2025 12:30:24 +0100
From: Stephan Wurm <stephan.wurm@a-eberle.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com,
	WingMan Kwok <w-kwok2@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in
 fill_frame_info()
Message-ID: <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
References: <20241126144344.4177332-1-edumazet@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126144344.4177332-1-edumazet@google.com>
X-ClientProxiedBy: FR0P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::9) To PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:204::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4948:EE_|AS8PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b564c5a-d47c-45ba-dca8-08dd36ea5716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0JMS0pyUHp4RWtRMXAzNFZVR0pxV2R0c2wzNjRoQWFIcElNSVZhMHUrQ01P?=
 =?utf-8?B?VG04cDlVcVJXTXU1bU1hNnBJTktZbHJHRmVwRkhqMmF3WGdSYzBqOG5ldzZz?=
 =?utf-8?B?QnY2ZCtlTkFkTTFkcTlSTG9rMFRqOUFsZUJzbi9SUlFTWklqK0ZoN1RtbFFU?=
 =?utf-8?B?Q3A4aWpMVVJmeDRsQnhzR3N1dk5MbHBFOHBqWDNjOVNVNG1ncWFmNzBmN3JC?=
 =?utf-8?B?Q0pqMTQ4dVRGdlRZTGZUempqMWo3bTRvalh3alM2MWtpRVZ4end1N1BCazQ3?=
 =?utf-8?B?dXVDMThjd05QOGpFUnhSeXRlQnVXVi9qanVxL2pZMWtGTFhpU0Z3dlU0NVhu?=
 =?utf-8?B?Wm5uV2FGU3FjVXBPbTJKRS9rR2VWdVdRYzk4a1ptS1RGREpMU1RiSWVRUkFQ?=
 =?utf-8?B?TVJDUXdHVnpzL0h4V1hUUGg4U25oRnh6QmVvRDhPUzEyNTVneWtsQjloZUZ2?=
 =?utf-8?B?WER2RysvM1liZkl6QnFkVDduQm9PWG10S3p3MmFvRlNDeTZxdlc2UDV1VFNr?=
 =?utf-8?B?Tjh4bVhJbXZTVUs1aVNpK3pBRFljUThpSXRlNWhSTkZ4eWxWWnVSR0tlZEtR?=
 =?utf-8?B?NjE4cm1DVzhzTFpyMXNXZ3lxQjhmV1NXc0xZQTFwT0FtRFNSUlJJUDg2Nlhh?=
 =?utf-8?B?VzBEWHlzbGtZZGpwVy9YRnRIa2N6TmJIYjlLNXhRRWJ3akJKWnZIRktRRjdk?=
 =?utf-8?B?YlllNmE5UXhlUlVxTHRYa1hvVThlQTNKTFd6cFVaMHdOdDBvejdJM3RObG9P?=
 =?utf-8?B?Wi9VUHBQN3dPT2wzZlhkNE5xQUJpc1MrMC83STRPTHBXNGVQaWd3ekZhT2RH?=
 =?utf-8?B?TElPRXV0SitxR1ZaM2ZGS3JmWFFGSXlLWWR3VzNhUm03ZGdxeXhxUWpyRW1H?=
 =?utf-8?B?bXdCNnh2MnNROFVuZFdueVNLY1RmSUhPVXBkTUhXZTBkb2Rvbi8vZHIxeU9Q?=
 =?utf-8?B?ODlEWi9aeWFpY1JvTHFEZm83eXlVUmtkSUE3eUFzNVJsZjRvaEZmQUVNc2t3?=
 =?utf-8?B?aVFDY21zM3BtNXgvMWFjV3lOU2I2S2hSNTdyeCsrK3J1UTRHLytBNzlmUXpo?=
 =?utf-8?B?MUt3bzIrVjVHaG02TEx5M3pkeVRpamZ2dkhYM2daSHd1K3lOWDJpc0cwdmFi?=
 =?utf-8?B?ZkRWWEN3dzdSVjBCcnUyRnRvejFhcHVMYmgvUU1oWHIyUkhDOE16dEFneThT?=
 =?utf-8?B?MjlZT0d6MCtuUW80ajIvNjMrTWN2dGtEOXNMMzVXM3Y2d0VjNU42dWJ5cjFk?=
 =?utf-8?B?eHRXYWRHM3FRSHdUK1U4TkxpczUvRGM4Z2V5eWxjRmtXVW5CSVUxMlN6TTcv?=
 =?utf-8?B?dFpuNjc3dzIvaHVRWWw0TkdNY1J4eHAyNjJtTG9qWVIwbEtjYy9nZFJuUyt6?=
 =?utf-8?B?bGFaQ2lSRWFLc2c1QXArVllKWVZ1UG85ZFZMUFFxTFRXMnlFa2tLZ2JTME1X?=
 =?utf-8?B?UVlXYmVwY09Wb29SMm9ESkhxQXBpZEVINk8yWE5PYmZpeFhidFRaaEdudng1?=
 =?utf-8?B?WkkxUDlDek8zN2NHL05mOUFaNVlMTWJYYVkzYTJLTXlLUkxqYnl2cy8xZ3Bk?=
 =?utf-8?B?QXpBd1lBRHFicWthTXNTbjlCeXlJQUo5SWE3Wi9PSkZpb0I2TnNOVkpPNjVo?=
 =?utf-8?B?TmVSNURnUHVRK3J4MXU5N0RjSVoyUDAvdWRvU05WSzVUUmdYbWV1U2ltNDVw?=
 =?utf-8?B?ZzN6YzR0aDUrUExxTStwN1VTMWlSK20zdmpZdFprUHp0YXFZMnBkYk12cTkr?=
 =?utf-8?B?MEgzRDJ4R1VSVHhrWGxqTVhsR3ZIT201SnQxamZ1d3MzZFJKY0l2cithTS9s?=
 =?utf-8?B?SDhTN2hyaE85WHEyRTd4SUN0aUZRSVFQQW14Um92SDBxTWtEV2dkd241b3Nn?=
 =?utf-8?Q?x6oSsZgvJvrTJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzBKOFkvQnNLTkRyQTVNcjNPekxaYS9RNFIxME9mMURWclNidE1rckxQRVRi?=
 =?utf-8?B?Z2dmcDJRN2VISFE0TlJmN2UvZ2l0SjM1Z0Jkd1M5V3F6aENsUUY5WDN0ZTZl?=
 =?utf-8?B?Vy9xZTBmUTM3LzdXUDhIQlAyTGNOSzFTbUlIbHVVZC9yUXp3OXIzMWtzRk1E?=
 =?utf-8?B?Q29jdEFmMkVDdmxpWFNxTXpWOERTT1ZPbTlYZzk1RkxWOGdOMmh5MDU0SWVC?=
 =?utf-8?B?a2dSbHc2aGJtd2x5cGpYS0R0SlUrWXpoYS9waVNlTm03OWNtN29RMkx1TW5t?=
 =?utf-8?B?OE02dzk1dm1WRTVUMENwcml6SmlvcHk1WHB1Q2dMYTRHVU9CNVJDcko0dVM5?=
 =?utf-8?B?b3YxVTYyYVNjTkVyVlVla1B2OEZTcHJFVmpRNVlLaVREOTFrZUtXUW1lRnBQ?=
 =?utf-8?B?VE1QYjYyK1RyMmlYczNTbXlWeHZ5RWxyZVdvTUFEN2MxQU1qNjdUQVNoZ1VR?=
 =?utf-8?B?QlJVYW96d0NqWE56Tms3N25IcHZVd1M1Nld3MDd2NXVyTzNmZlBMYkt1cktK?=
 =?utf-8?B?eEFJUW9wOTFzcmhYd3YzS2lnSDJ6L1lTTlRPQzNzRStxY2xyVENoSXU1cEs4?=
 =?utf-8?B?dGR5eGgyU1B5b25NN1RSRFhwSDRDU3E4SlJteXRlWEtuV0xNSTVoYk1ablFO?=
 =?utf-8?B?blZTSllONXBkZUJsQlJhakZYblEvc1F1dXNFbUxZRGV5K2ZVMk9VQzJMZkpO?=
 =?utf-8?B?NTlkUWgvaW9RQkNxbnk3c0dWSy96NzJraFVkbnNZcWdTUENLcU9XcU1CbG1M?=
 =?utf-8?B?ZklUaDd2cS80MFhlT3NLSlN3SStuMzdDQ0lCYWM1cHY0TzJGdExrNHQ5dTZl?=
 =?utf-8?B?STQvOWlqZXd5VThLL1BpN0ROZmlFZlY0MlBKZSthNVBZT0V2cUZaT3pzY2ZX?=
 =?utf-8?B?d1NqUUQxQ1BzeW9pTWlzOG1DcUV1SHFuekpRL2ZyU252Q2tIaFBsNkxCTGhu?=
 =?utf-8?B?QnJlM1VCRkpIOXlQYlJhOS8waytsWFJzakNLWFBTUTR6TU4rU0VxL01TTkFt?=
 =?utf-8?B?bGw1TmxXSmk2dnJCeEFadm1MQzZwZm1pcldZNXlsZWhCamVVWVMzU1NPUWw5?=
 =?utf-8?B?Vy9KMmFrTG1BMWJmREhUbUtPam9keEdVSVFtTTF6ditwcUN3WGIxK3VIRVpJ?=
 =?utf-8?B?elp5UGdPRDhsNWVDbDFiVkNKZUhySTBCYUkzN3JkT0Z4MlMwNEVLaVdPYmFP?=
 =?utf-8?B?R3pMNmFNMytUaFh6Ny9zV3RZRGFkNXE3VVVBODdPWVVHUGxRLzZCeWVkTHFk?=
 =?utf-8?B?Yk1NN1ZtdGpjeUVTT2pUc0FLd2xoUy9JczFRR3c0TUxPZEVQNlRXdDBwcm5Y?=
 =?utf-8?B?L1JBUWsvWmxDQi9LUjgva1FxQmx3azFRR24yYkxvYlVzT2xhWVgyWkJpdEQ5?=
 =?utf-8?B?V1pRTmlkdmp1V3J4cDR3a0ZjbElXZ2JtWU5aUFZVS1dDVG83d2FydWtKdEF6?=
 =?utf-8?B?R2ZkamJibUhGOEwxcjYzSmpUbUx2aGxRWjJKV2Nxd2gwS2hXNFdtc0JJb2tm?=
 =?utf-8?B?Uksza1hScW1OOUJKcGRaTUpnOFpSblg5d0g1cnFTRHVLWitZOE9hcklJUS90?=
 =?utf-8?B?NDFnM0s0R1FST1hBeXBWQSs3M1NUellHWkpTSU5uekViTTR4d0xkRTBXcU9M?=
 =?utf-8?B?WnJwWlJBaUtxbU1kc1JnQnZLUURDa0c0SElCMmJLa0tRMWthM1RjWUN1enF5?=
 =?utf-8?B?NzByejNjVUNjaWVNQ1lSUHExMlVyU1JwNmpwMEw1TVBTRmdoNnlVUFNNYnRI?=
 =?utf-8?B?ZUdid1l4bDc0aEFJU050OC9uREM1TXd1QW4ydVRnRUlKZ0JhQmdCb251aGNi?=
 =?utf-8?B?RGl1d2ZFT3BjQUNUeCt6eFRnTDRISU5sVzZJRVlPSlJ2SVZBbE5oSHZybVNt?=
 =?utf-8?B?Uk5lQjUrNWtrUGhqeEYwUFVwb2NwOVBDc0RhZElDazdQdlRoQmZMN1VlcDJ0?=
 =?utf-8?B?eGFFWUpSSmdxVGI3L2dqeDhYRlhkbjdZZjNUeFdBNVJVZEhPVGNTRUxBc2Jp?=
 =?utf-8?B?UDNIRDZHdkM4d2ZvYkxWRGJpTVBJc2ZFVzdKQ3Y4cGQxR3pPQzBucHpuUXhx?=
 =?utf-8?B?czFKZXk2TVpFb0NzbXlmYTRQTWtLS3FCcERZdDJpYXRHYnRQeHNCTjRld1Bk?=
 =?utf-8?B?dFdiZklVQWRXS2NVNDFOTnNuME4vbW9mcVlQWjZOaWIrdGppclc3QWpOMkRL?=
 =?utf-8?B?VlBQTVI4dHVpZmkzcG5aUjVlRHR0Z2NDSlRYUFhoY2lORkVVbGdZeXozUSt5?=
 =?utf-8?B?ZTlLREQwYmJ1TlhyNytzVzlrVHpnPT0=?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b564c5a-d47c-45ba-dca8-08dd36ea5716
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:30:27.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHTUhrZYMy0Lh/ZTMx/+qwYhFqIFM+SV0eLP5hXaw045XTJNzoDkZO+qVvpnFyliu60Yn32c7+BRZPkwnt0UpGA/FBUso7aD/R+EYPsDbBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7352
X-cloud-security-sender:stephan.wurm@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay67-hz1.antispameurope.com with 4YZHbV3D7HzRlr1
X-cloud-security-connect: mail-vi1eur02lp2043.outbound.protection.outlook.com[104.47.11.43], TLS=1, IP=104.47.11.43
X-cloud-security-Digest:f33bcbc85a82ccd60ed610d9f3d5156b
X-cloud-security:scantime:2.414
DKIM-Signature: a=rsa-sha256;
 bh=brErExzOHNabk0CSQkJ1caXkP+Gt3vH7Sgg/pPYiSEI=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1737113451; v=1;
 b=oK/RiNc1KFC9vOCt2aasq1Kg3qMhNFiKzouV6P9zrYJIOORAKVlBMCiBx6szuVFuS1zRh+o8
 IAxsl18orUbRz/PeINq44ve46PD35/fnnnSbbccub0+BtvCti8fqnUIu82EEzqio1WYuzQZ9ZLd
 NCQFoZRAG07GgYvgy4Pac2fls4b/4gVUEk3EvTFhPdUCUGGAaaO18G8uDGHH0mobpoHD0VKUwke
 GjU8PeFdbHjTLsuPjiPfenaC9Bi+b7ME2IJyXJavArMTuRpQG6iCH3vCWu08+28rGYnxpd8zNuf
 Xwb1Og4n7km1jowJ1jit6OjcMHXtFIS4y2pzS06jG0Emw==

Hello Eric,

Am 26. Nov 14:43 hat Eric Dumazet geschrieben:
> syzbot is able to feed a packet with 14 bytes, pretending
> it is a vlan one.
>
> Since fill_frame_info() is relying on skb->mac_len already,
> extend the check to cover this case.
thanks for addressing this szybot finding.

Unfortunately, this seems to cause issues with VLAN tagged frames being
dropped from a PRP interface.

My setup consists of a custom embedded system equipped with v6.6 kernel,
recently updated from v6.6.62 to v6.6.69. In order to gain support for
VLAN tagged messages on top of PRP, I have applied first patch of the
series (see msgid 20241106091710.3308519-2-danishanwar@ti.com) that is
currently integrated with v6.13.

Now I want to send GOOSE messages (L2 broadcast messages with VLAN
header, including id=0 and QoS information) via the PRP interface.
With v6.6.62 this works as expected, with v6.6.69 the functionality
stopped again, with all VLAN-tagged frames being dropped from the PRP
interface.

By reverting this fix locally, I was able to restore the desired
functionality. But I do not iyet understand, why this fix breaks
sending of VLAN tagged frames in general.

Do you already know about this side effect?
Can you guide me to narrow down this issue?


Best regards
Stephan

