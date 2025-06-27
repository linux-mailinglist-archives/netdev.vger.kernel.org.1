Return-Path: <netdev+bounces-201725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF4AEAC60
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8280A3BE733
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380C13C3CD;
	Fri, 27 Jun 2025 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="hPHvf8X0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A48CA6F;
	Fri, 27 Jun 2025 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750988448; cv=fail; b=d9i8H79pODAtFf0uXIoM28at+qOorngxDNZBEMqJedsbBhTLawfwHMYy6N1An6NlD5sze+eATIh2o2/N+YLh77fF7I3F9Mlz2JyYAfzcLRjRI5WREuVLVXebIE5rZnTVv+FRYg3ZBRfkm0WeQYsGzhR5DIk1AF5m4FkYvLSF9ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750988448; c=relaxed/simple;
	bh=zdv+fNKsRrVNTZCtHJ/09M4eBjMGtyKuLtowEuPpYGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pv20MIWpQn3+QmFFK5u0aKl68DByDS77+0l04AmWT5py8Vx2rzpvA9s/40pfFdjkEBbHoC5+XSopYcyJGNNXGc7BJ4JwvFrXAI3OOXSuGvBWWsbqmUQ1odyvyCxdYtLOwNJ0olpfMWYBjbScK0oD9P/ujgt/TQDSqt/q56jOEBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hPHvf8X0; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUmpYn41uTu0wfw66uj4X4Q8FyEfw5ssEGsV3yX8iVMg69Dqx4crNy72Aw+YkP2/jYpDSM7f2nxMN/BNUbfIu0Y3f0pYAAY3DhNHi1IsMUE8DcfkltsKRFfhiqokIfW+A6NMX0heiXuvkFv2S1nA1599ylStTn9E3ImmUjGrv+KZefTovy1C5TVRv6DGhiusl5H0R9q6LjkmctnqZuIBg2mGNgIsqa61EabjghYYS3e4W48L63vEY7DBE5vD2s9wqLtnHHxGYyguaW7PT93Oox3AlmLW7Tls/MvC9by+MMAAtVhIRj4HxWx040heMcb66gLxqFIx2Rf6a/38JT5DfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQL+UyEQ2v9hRR+3G//zlqMiLrTwwAI9mRrQtS93Rsg=;
 b=BDo3igDbdRAL0aPcGH0gj7uKyrcvMjMFLDhIVvnbXciKVmNELq3QFDXbLf9rEA6Qi3fIR6Cp2eIFSHo3l15zIjtZf7MTj1w5uBAZFxblljUGEbK39uuq2PeUgz/1OaQnL2S1Fhlq0fJQQwLxhXLAYP8VtbYq4O+GcmygBnLEuL297dQPB/5RdtyokLxNeJR7IQfOrlmLkazF87icFQs2oTck45txLLdwwQ3R2Ta6g0OudCxWRVEgx69skxEb0LUXf8F6ZjzR0Y91jJz77iWlbrqCVlFz7MDQ6DwtegytR17aRLVaSUS9xdymP7eBqgBq5nwVvFMSfKhDYvCpgB9j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQL+UyEQ2v9hRR+3G//zlqMiLrTwwAI9mRrQtS93Rsg=;
 b=hPHvf8X05KzsKgshEzrCiUipIoAXvfSFflHE1EE99pKeo6lV8bo7Ybt3lBqkqixlxli7aMyt1M7BMxHfQJ0VZh2Hk+LFHoZbF6yy3VIkOUiriG4Cz5VCOBdNnC8k5PUqEYYqVxFlPBmPZKMXHKFdxmybFKwPUrAaDVLErHME3Y/vVepbylYYM8vcqBijLh9Ek2PRpRi/5Hhu7FUFUqR+Ku1aO6t7sEVwpZJtxsZgLiiUo1FKjpSPK25sTOuzfbx+E6N8Etxr2wdwFmzfQuApL28zpIrP7aHzNXGNVT1e2l4wyn1Fw5esBwSUHb8lsD8YjqC4GuQvc5uy06m0P4smrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BY5PR03MB5127.namprd03.prod.outlook.com (2603:10b6:a03:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Fri, 27 Jun
 2025 01:40:41 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 01:40:41 +0000
Message-ID: <fe705ffc-9a4c-462c-a1bf-e14c55cdb2cd@altera.com>
Date: Thu, 26 Jun 2025 18:40:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
To: Rob Herring <robh@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250613225844.43148-1-matthew.gerlach@altera.com>
 <20250626234816.GB1398428-robh@kernel.org>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250626234816.GB1398428-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0068.namprd08.prod.outlook.com
 (2603:10b6:a03:117::45) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BY5PR03MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b6e0ed-62de-4310-d4b3-08ddb51b9ff7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUZrL1VqVnh5RzVtY2RIMDRFZzI4UDJlZ25jcnBBNHppcmNiTE1BV1VuZlhM?=
 =?utf-8?B?WC95QmJvZk9nbDhtMmkxQ1l3UXFWc0NIVkdFeVBiRXVkSzVhbDRQQkJYMnZM?=
 =?utf-8?B?MnNOOUsyYmZTN3R0UldpU2svaVVyei90UVYrMllRcy8yRkNCaUlOeXFaMWZY?=
 =?utf-8?B?L2YvZjlqOUFFbzl6bDNaakd0a3E4bGVFYWRHbXhIWXpTQ1FaWXZMbTVjMzc4?=
 =?utf-8?B?VlFVMGx6RXU1M3VuR0FMcDNUM0VubG5qWWpTVlE3aWJWM3dub0xFMkduZTJL?=
 =?utf-8?B?blBOTjJKc0k1UzNoaVpGL1V1STFpQzZIdHhJaENQS3FzY0VxaXFwV2NhN2J5?=
 =?utf-8?B?aUxYZytFZG55UGF5NVZuZm9FWFRhUkcvV0d5SGdZTUFOY3BzVU1GQmZpTzA3?=
 =?utf-8?B?cnowVUduWjZxZDlSQUp5RVBQOXFUaWxOcjZQZDBHbll3cy9nV1B3ZVZPRXZl?=
 =?utf-8?B?OXBrSGVpOXMxL1Vzb3dWTHpiK0dWWW5lWGZ3OG96WFFSSnFYY0Zhc1lqMmdB?=
 =?utf-8?B?TDVqdWNJd01XWDJxOGdKQXRKbnhHeGlCTXdBVVJvY1R2ME1lQjdFQVJoVjZ0?=
 =?utf-8?B?dC85OEQ0VFV1ZlBISGhiVHcvcmFIbFdaanpEUkV5NzlBMkU0YXZ2UkdvRGpO?=
 =?utf-8?B?U2RUendYZ3o1b1lEWm52bGdiS2R4L0J3b0NqbTBoVVZrOCtpNWhhbE00YU5y?=
 =?utf-8?B?eXZaSXI3dS82MFhKaHNFZytOQ2hGM1VhSFROSTdtb2VOY0o4SXdMb1I1Uyt3?=
 =?utf-8?B?MmFlS05BaUErTHJVcXBvaklRNEVwdWdmUVZVWk5PVjZKTlN1ZDM5dTFVQWE4?=
 =?utf-8?B?QUxRRWpzNDVqNExubUFnazBBN1VwQmxqMEdRVXlBT0FJUzZEeFYyNDdBdVVS?=
 =?utf-8?B?M2lyb2dwRGx5TUF6TndBVEx5U3U2d000OHdtSWlYVlJJUUxxTlYyRi9qTGhH?=
 =?utf-8?B?S0lmSWo5NVIvYnlTeUpuQXR1Um5sZFZycjZHN0QxUS9ST1NUd3N0NmNwSG14?=
 =?utf-8?B?eE1FVjlYMWhtU2FZa2Vwb29aMGlSNHUrazBYTnR1WXA1cURhOGRQSFhhUjQr?=
 =?utf-8?B?WGJJaGFQNm1rV3NkUVptaTFHcFVTQ3d6bWMranJ2a2s0NzNMVUI3UEh4VjRx?=
 =?utf-8?B?U2k2b1lYOVJtaVkvZ3BWMVRiSXdMMFBCTS9vKytwOEQ2V0UzZ1hzc2QvaW1E?=
 =?utf-8?B?NzlVZlZFbjFjc1ZGSjdTcmpzdXJrWWlGQ0k5Z21UREpvZUtFVmlZRDRPcHdT?=
 =?utf-8?B?c1pVOExCNkRSVXpWRTdidTVNSDVMeXdEZHFDMnNjdHlzOXZqUnVPZlRFRDd2?=
 =?utf-8?B?SmlyMzN3L05wQkc2NXZ1eW51MnR4SFdYYkg0OUNudVgyWUgvcFpHVjNHYnYv?=
 =?utf-8?B?T29PdG84aHR2NGg5czBPUE5qbXMyN3YrUXRzWkNTVERCNW9CeGpYYjIyTys4?=
 =?utf-8?B?SGkvYlc4NEZlcnpSZ2UrMHVYQVJ5ZHJ1V0ZPYUVvME1HMUIyS1MwNXVZMmx4?=
 =?utf-8?B?Q2p6TDEvOUFpeEw5SXA4OXRoYXRhSzM5ZFE0YjB3Y3lab0d6dkI4Wjl5V2JM?=
 =?utf-8?B?QnNLR0wwdmluWkZJSXVsT0txczlVYjZSWU1Xb2syQVJ4bHBvaVZ0TzU2WUN4?=
 =?utf-8?B?WXZCVXFNTjkzc1I3TklFNk9jbTRPWTNDWmIxUDhzbTRFQ3J4OXdlQXd6K2Fo?=
 =?utf-8?B?U3RVOXpDS3o4VXFMdHVUazI4bGYyTHpPdHJXMWJLYnJqSmFtYmhjVDFiTDYw?=
 =?utf-8?B?Q01BVEhYNWRSdklJUjFmS1UyNVB5dGFSSmNKZXMwSHhEUEFDNE9JZzMxSmt4?=
 =?utf-8?Q?44PsW89Kz2yfVE1z77KxFBrg+QySI7ci25AxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHRlYTdmOHFqQ3NHcUxYOEl5NjJ4MDVUZDlXMzBhUktJTld5TTBCTjBMMGxl?=
 =?utf-8?B?Y1MyYzBnSHlNWTVKSm9oVFlLcUlCcnpKVGNXa2VWdUVyOEZMS3BsWk5MbmFF?=
 =?utf-8?B?QlZ2a3J2Y1dLVGVXcWJoVkZ0cXdzR0lKcDJ0cnAzODcvMG1FLy9tWTJRYjQ3?=
 =?utf-8?B?T2R5WHZaM3I2ZVJQdU5Fcmd6VkZMWGRDQzZUZHRDL3NpUWk3VUd4K2Urb3da?=
 =?utf-8?B?bmJWaXh5eE4rZ1ZGYm9xYnAycnpHVXJDTXJvMS9YdE9kdm5tVmZod05rbEo1?=
 =?utf-8?B?bFA2eDlFUkk3Y0VKT2IyT1NBa1Z6YzVUMFRmaXJFanh3UVEwNEtrNmhpZ2Nr?=
 =?utf-8?B?MERrbmZDMzl4Sko0aEZXZ1Y4TVVQeUhzRURrWjU3NWpGVERyWjMwQXFkTXd0?=
 =?utf-8?B?dGdmNHRwaEtmTXJoVW9lOG13aFBBbE5VazllUGFKN29jRjJhMjRFbW5vaFhw?=
 =?utf-8?B?b3I3aHRmM3NaaGNFYzFZdVBkdWEwRGliTm1jemZHRmpqVkwyOUxYU1lLSmpj?=
 =?utf-8?B?ZWZnMVRzQ3FPc1NXUGl2U3BUeW5FbkR4cm9LMTlaY1BLVkRvcXlrQXFvWFpL?=
 =?utf-8?B?djA0VkIwY2F1RzlrOHd6RnphNkF6U0JyRFJoSVRsUkVKZ3NTWkNLNFFhL0lD?=
 =?utf-8?B?UDIvWEtzNHU1Wm1IV3IzN0k2RXptQ0p5Um5DM292S3h2UHdqd2grV3l3VlFT?=
 =?utf-8?B?L28vKzVXaDVuMmRrZmI5dUhxbkplK0xBV1U4Ri9XKzFXZVJiaTlxU1pMdVZR?=
 =?utf-8?B?algvaWsxYkRFWVdoM25HYS9TRHR3OVkycENvTmplVTJNdEJNdTNCaUZrdnBW?=
 =?utf-8?B?eE5hRFl6b2x0bkl1WWI2TE9jWUNZTzJJb1ZrM3BqZ1VyU1lTYnVPOGFDaDBl?=
 =?utf-8?B?ZmYxS2htZ2ZMVXJkQlFLdjZpR0h3RVY2Wm13VWtMOXFUenR2MVFFUjBEYSsy?=
 =?utf-8?B?YU5Hd1lUY1BSUytSeTBoVmtydjNmclpkM1BBcVRlY0NtckxiSFovMDNyLzZU?=
 =?utf-8?B?TFIrU0tmdXZxRis3REQ5Um5tU1dsdlRxZkprcGx4N3lEZDR5bWpvcVQzNno4?=
 =?utf-8?B?bHRrc3JSdktHaEdQTG1ydlg1TEZLV01qd2Vub0paZWdnZEVQTjA3Skc2K3hy?=
 =?utf-8?B?NzNpNC9vcDNEUm1OOW5PKytkWDhvVC91b2cyVm5rc3lLd0w4bHBZUlZvMHZR?=
 =?utf-8?B?TnRNWmNyTXB4eVBwblZmTkFMMm5aL0hRb2poTFNlSDh2TmNtZVpQd1FEd3Vi?=
 =?utf-8?B?ZGZhWitWWDQyYlkydHllU09GNDFnOXQ4VnJudEE4d0RtOGtOVnBaSWdjb0xh?=
 =?utf-8?B?SDNPMFVwU0JlZzY4VjZNUXNxZEI0aDJYNGFhZ0JtQXIrVUdNY0ZiSUFXV2F1?=
 =?utf-8?B?Y05HdFZ2bXJZMW1NSEVWakNYcHluUFFIM2E4VjhmdXRIU2JlOUxiRU1yL2s3?=
 =?utf-8?B?R3JOeGJQdE9YVitTV004am16SFUyTlBISUF3d2RlOUdtNG9HSmJWRnBZYysw?=
 =?utf-8?B?TFJ1blJhM3BoY1dkR28xK0h6eS9aeC9VWXBGN2NkU0NHUzVsbytqamwrcVVL?=
 =?utf-8?B?QW5MWDhJdjFaK0k5U01lWDMrcm5QcVdFeUZSc0doY1NYTUg1c2EvUTUrM1Mx?=
 =?utf-8?B?K0xvSHpnRzNIeG5rSkFnNnVwOUplOGdpTktvb29HanlFWGtBWjJvN2hQSXZK?=
 =?utf-8?B?YTJPaTUvUTBkOWpwMzJGOVJGV1dhemtOYWtRZGVLaWdsUlpVcVVIOHkwa2tK?=
 =?utf-8?B?VUhxWnVxMm9BL1JrVDg1TnJnNk5tdExUa0ZKU1Y1MEFZeThxNUFRTzlSY09l?=
 =?utf-8?B?OTY1d2pXaWZ1MkRZUlpudHU3ZjNmK0RRMWRRTnhWYjIvZHlDWVZPejRBMVVM?=
 =?utf-8?B?dW1lZktjNndjSmVQMjJaanhLbUxQYTJ1OWdKUFdYdlFpdDFKeUtBTUdteDBI?=
 =?utf-8?B?NlZyMXVmTUJEZjI4OFJ4bXc5c0w1WGxrQWxhNTZWem13WjFYaHVReVJqeFVQ?=
 =?utf-8?B?UVgra1NlYkVXazVrSHdVck9pOHQvL3ZoNXYxVDFXK0RGTmROeVowWFdIb1NW?=
 =?utf-8?B?cHVJSTRiNzRTOXF0SHhFbnhBakFsWjFjSEo2dGJvNjhUVlJ1RlNIRk1qYmQ3?=
 =?utf-8?B?S0J0M1dRNUxrRGJCZGhvUUlJd2xxa0l2amZYa2tpcVowdHRZNmhVS2RxcEpv?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b6e0ed-62de-4310-d4b3-08ddb51b9ff7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 01:40:41.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmSkRF64J8+np9WPB/CxFliUQuLkTZuPd0IVD5KIEbTpxgyvLYStAjRz+iybVY5Kue4XsPWFXHT2edOeG8Sd4IfY+dzJRP02vzwrIvjmG1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5127



On 6/26/25 4:48 PM, Rob Herring wrote:
> On Fri, Jun 13, 2025 at 03:58:44PM -0700, Matthew Gerlach wrote:
> > Convert the bindings for socfpga-dwmac to yaml. Since the original
> > text contained descriptions for two separate nodes, two separate
> > yaml files were created.
>
> Sigh I just reviewed a conversion from Dinh:
>
> https://lore.kernel.org/all/20250624191549.474686-1-dinguyen@kernel.org/
>
> I prefer this one as it has altr,gmii-to-sgmii-2.0.yaml, but I see some
> issues compared to Dinh's.
I am sorry for my part in the duplicate review. I just rechecked the 
output of get_maintainers.pl, and Dinh was not listed, and I should have 
known better.

I am happy to do the work to resolve the differences and resubmit with 
Dinh as the maintainer.

>
> > 
> > Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> > v6:
> >  - Fix reference to altr,gmii-to-sgmii-2.0.yaml in MAINTAINERS.
> >  - Add Reviewed-by:
> > 
> > v5:
> >  - Fix dt_binding_check error: comptabile.
> >  - Rename altr,gmii-to-sgmii.yaml to altr,gmii-to-sgmii-2.0.yaml
> > 
> > v4:
> >  - Change filename from socfpga,dwmac.yaml to altr,socfpga-stmmac.yaml.
> >  - Updated compatible in select properties and main properties.
> >  - Fixed clocks so stmmaceth clock is required.
> >  - Added binding for altr,gmii-to-sgmii.
> >  - Update MAINTAINERS.
> > 
> > v3:
> >  - Add missing supported phy-modes.
> > 
> > v2:
> >  - Add compatible to required.
> >  - Add descriptions for clocks.
> >  - Add clock-names.
> >  - Clean up items: in altr,sysmgr-syscon.
> >  - Change "additionalProperties: true" to "unevaluatedProperties: false".
> >  - Add properties needed for "unevaluatedProperties: false".
> >  - Fix indentation in examples.
> >  - Drop gmac0: label in examples.
> >  - Exclude support for Arria10 that is not validating.
> > ---
> >  .../bindings/net/altr,gmii-to-sgmii-2.0.yaml  |  49 ++++++
> >  .../bindings/net/altr,socfpga-stmmac.yaml     | 162 ++++++++++++++++++
> >  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
> >  MAINTAINERS                                   |   7 +-
> >  4 files changed, 217 insertions(+), 58 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> >  create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> > new file mode 100644
> > index 000000000000..aafb6447b6c2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +# Copyright (C) 2025 Altera Corporation
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/altr,gmii-to-sgmii-2.0.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera GMII to SGMII Converter
> > +
> > +maintainers:
> > +  - Matthew Gerlach <matthew.gerlach@altera.com>
> > +
> > +description:
> > +  This binding describes the Altera GMII to SGMII converter.
> > +
> > +properties:
> > +  compatible:
> > +    const: altr,gmii-to-sgmii-2.0
> > +
> > +  reg:
> > +    items:
> > +      - description: Registers for the emac splitter IP
> > +      - description: Registers for the GMII to SGMII converter.
> > +      - description: Registers for TSE control.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: hps_emac_interface_splitter_avalon_slave
> > +      - const: gmii_to_sgmii_adapter_avalon_slave
> > +      - const: eth_tse_control_port
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy@ff000240 {
> > +        compatible = "altr,gmii-to-sgmii-2.0";
> > +        reg = <0xff000240 0x00000008>,
> > +              <0xff000200 0x00000040>,
> > +              <0xff000250 0x00000008>;
> > +        reg-names = "hps_emac_interface_splitter_avalon_slave",
> > +                    "gmii_to_sgmii_adapter_avalon_slave",
> > +                    "eth_tse_control_port";
> > +    };
> > diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> > new file mode 100644
> > index 000000000000..ccbbdb870755
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> > @@ -0,0 +1,162 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/altr,socfpga-stmmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera SOCFPGA SoC DWMAC controller
> > +
> > +maintainers:
> > +  - Matthew Gerlach <matthew.gerlach@altera.com>
> > +
> > +description:
> > +  This binding describes the Altera SOCFPGA SoC implementation of the
> > +  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
> > +  of chips.
> > +  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
> > +  # does not validate against net/snps,dwmac.yaml.
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - altr,socfpga-stmmac
> > +          - altr,socfpga-stmmac-a10-s10
> > +
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: altr,socfpga-stmmac
> > +          - const: snps,dwmac-3.70a
> > +          - const: snps,dwmac
> > +      - items:
> > +          - const: altr,socfpga-stmmac-a10-s10
> > +          - const: snps,dwmac-3.74a
> > +          - const: snps,dwmac
>
> You are missing the snps,dwmac-3.72a version.
Yes, leaving out the snps,dwmac-3.72a version was a conscience decision. 
Please see TODO above. Since I was stuck figuring out how to address the 
reset-names issue with the Arria10, I thought it was better to leave it 
out to keep the Arria10 schema errors the same rather than changing the 
error. Should net/snps,dwmac.yaml be changed to handle the stmmaceth-ocp 
reset-name, or is there something that can be done in this file to 
handle it?
>
>
> > +
> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: GMAC main clock
> > +      - description:
> > +          PTP reference clock. This clock is used for programming the
> > +          Timestamp Addend Register. If not passed then the system
> > +          clock will be used and this is fine on some platforms.
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: stmmaceth
> > +      - const: ptp_ref
> > +
> > +  iommus:
> > +    maxItems: 1
>
> Dinh's says there can be 2?
I don't see any dts or dtsi with 2 iommus, but more importantly does the 
hardware support 2 iommus? Dinh can you comment?

>
> > +
> > +  phy-mode:
> > +    enum:
> > +      - gmii
> > +      - mii
> > +      - rgmii
> > +      - rgmii-id
> > +      - rgmii-rxid
> > +      - rgmii-txid
> > +      - sgmii
> > +      - 1000base-x
>
> Dinh's says only rgmii, gmii, and mii supported?
The example in the original text lists sgmii, and there was some good 
feedback from Maxime Chevallier and Andrew Lunn on this subject in 
https://lore.kernel.org/lkml/20250528144650.48343-1-matthew.gerlach@altera.com/T/#u 


Thanks for the feedback,
Matthew Gerlach

>
> > +
> > +  rxc-skew-ps:
> > +    description: Skew control of RXC pad
> > +
> > +  rxd0-skew-ps:
> > +    description: Skew control of RX data 0 pad
> > +
> > +  rxd1-skew-ps:
> > +    description: Skew control of RX data 1 pad
> > +
> > +  rxd2-skew-ps:
> > +    description: Skew control of RX data 2 pad
> > +
> > +  rxd3-skew-ps:
> > +    description: Skew control of RX data 3 pad
> > +
> > +  rxdv-skew-ps:
> > +    description: Skew control of RX CTL pad
> > +
> > +  txc-skew-ps:
> > +    description: Skew control of TXC pad
> > +
> > +  txen-skew-ps:
> > +    description: Skew control of TXC pad
> > +
> > +  altr,emac-splitter:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Should be the phandle to the emac splitter soft IP node if DWMAC
> > +      controller is connected an emac splitter.
> > +
> > +  altr,f2h_ptp_ref_clk:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to Precision Time Protocol reference clock. This clock is
> > +      common to gmac instances and defaults to osc1.
> > +
> > +  altr,gmii-to-sgmii-converter:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Should be the phandle to the gmii to sgmii converter soft IP.
> > +
> > +  altr,sysmgr-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Should be the phandle to the system manager node that encompass
> > +      the glue register, the register offset, and the register shift.
> > +      On Cyclone5/Arria5, the register shift represents the PHY mode
> > +      bits, while on the Arria10/Stratix10/Agilex platforms, the
> > +      register shift represents bit for each emac to enable/disable
> > +      signals from the FPGA fabric to the EMAC modules.
> > +    items:
> > +      - items:
> > +          - description: phandle to the system manager node
> > +          - description: offset of the control register
> > +          - description: shift within the control register
> > +
> > +patternProperties:
> > +  "^mdio[0-9]$":
> > +    type: object
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - clock-names
> > +  - altr,sysmgr-syscon
> > +
> > +allOf:
> > +  - $ref: snps,dwmac.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    soc {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ethernet@ff700000 {
> > +            compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
> > +            "snps,dwmac";
> > +            altr,sysmgr-syscon = <&sysmgr 0x60 0>;
> > +            reg = <0xff700000 0x2000>;
> > +            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "macirq";
> > +            mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
> > +            clocks = <&emac_0_clk>;
> > +            clock-names = "stmmaceth";
> > +            phy-mode = "sgmii";
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > deleted file mode 100644
> > index 612a8e8abc88..000000000000
> > --- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > +++ /dev/null
> > @@ -1,57 +0,0 @@
> > -Altera SOCFPGA SoC DWMAC controller
> > -
> > -This is a variant of the dwmac/stmmac driver an inherits all descriptions
> > -present in Documentation/devicetree/bindings/net/stmmac.txt.
> > -
> > -The device node has additional properties:
> > -
> > -Required properties:
> > - - compatible	: For Cyclone5/Arria5 SoCs it should contain
> > -		  "altr,socfpga-stmmac". For Arria10/Agilex/Stratix10 SoCs
> > -		  "altr,socfpga-stmmac-a10-s10".
> > -		  Along with "snps,dwmac" and any applicable more detailed
> > -		  designware version numbers documented in stmmac.txt
> > - - altr,sysmgr-syscon : Should be the phandle to the system manager node that
> > -   encompasses the glue register, the register offset, and the register shift.
> > -   On Cyclone5/Arria5, the register shift represents the PHY mode bits, while
> > -   on the Arria10/Stratix10/Agilex platforms, the register shift represents
> > -   bit for each emac to enable/disable signals from the FPGA fabric to the
> > -   EMAC modules.
> > - - altr,f2h_ptp_ref_clk use f2h_ptp_ref_clk instead of default eosc1 clock
> > -   for ptp ref clk. This affects all emacs as the clock is common.
> > -
> > -Optional properties:
> > -altr,emac-splitter: Should be the phandle to the emac splitter soft IP node if
> > -		DWMAC controller is connected emac splitter.
> > -phy-mode: The phy mode the ethernet operates in
> > -altr,sgmii-to-sgmii-converter: phandle to the TSE SGMII converter
> > -
> > -This device node has additional phandle dependency, the sgmii converter:
> > -
> > -Required properties:
> > - - compatible	: Should be altr,gmii-to-sgmii-2.0
> > - - reg-names	: Should be "eth_tse_control_port"
> > -
> > -Example:
> > -
> > -gmii_to_sgmii_converter: phy@100000240 {
> > -	compatible = "altr,gmii-to-sgmii-2.0";
> > -	reg = <0x00000001 0x00000240 0x00000008>,
> > -		<0x00000001 0x00000200 0x00000040>;
> > -	reg-names = "eth_tse_control_port";
> > -	clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
> > -	clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
> > -};
> > -
> > -gmac0: ethernet@ff700000 {
> > -	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
> > -	altr,sysmgr-syscon = <&sysmgr 0x60 0>;
> > -	reg = <0xff700000 0x2000>;
> > -	interrupts = <0 115 4>;
> > -	interrupt-names = "macirq";
> > -	mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
> > -	clocks = <&emac_0_clk>;
> > -	clock-names = "stmmaceth";
> > -	phy-mode = "sgmii";
> > -	altr,gmii-to-sgmii-converter = <&gmii_to_sgmii_converter>;
> > -};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c2b570ed5f2f..d308789d9877 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3262,10 +3262,15 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
> >  S:	Maintained
> >  F:	drivers/clk/socfpga/
> >  
> > +ARM/SOCFPGA DWMAC GLUE LAYER BINDINGS
> > +M:	Matthew Gerlach <matthew.gerlach@altera.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> > +F:	Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> > +
> >  ARM/SOCFPGA DWMAC GLUE LAYER
> >  M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
> >  S:	Maintained
> > -F:	Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> >  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> >  
> >  ARM/SOCFPGA EDAC BINDINGS
> > -- 
> > 2.35.3
> > 


