Return-Path: <netdev+bounces-61586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED9082455B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313901F204E0
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F82249E7;
	Thu,  4 Jan 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eS8X3DQ0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845B24B29
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyNefSTYJlIVs1j1JD7MKjIberBWKeyMiUaDiqSwOvRUVTpiX7as9amrj58lcP5/9OaSYOXo/gBM1ibwPEuQqPWysEerhOJeDwjy1LCyknrhXjMZqzLGaabR26d37BjAxsTiUBaoyMXzFZ3tClcDj5BoHqiCbZs/mlrRDzraOgriPTSnY5zJu7IuwbGJW2+F4KLGS+NKiCCDJhy7VidI+6NTQq773JVqSh+jERHFBA4/K0OACeXt/GuoHT9CMaH0Rrkaa8cLeILiDPMm4Lr5tgV2/HWcLZsAe2QVUUbexLNV7whYmWX2+fAiW9neoTnyPneb+0O0TfSXOZ0SA1H/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6HEjRrDHKHrNRHzT8lK8+NPfB8g+bruVVWMmt56Qbc=;
 b=RElIMrPniD5hXBItXbXK5+kXc0FN1fd36o//vmLgtfoipUcWqWxDqDJyF2RQEUxRUkHJfKyhjYojP4kyXLT5OIcrX9cxSPA5bz9UGUCxYDAu777zOXhny+SmRq/5GjUMm4KdB6QVCmS383QxqeTlyVrQ6YVIapmktOQ1z6lrIimaZSYDa9E9GpQ4UuHXE9B+VFq8SUNgngBXR2a7P2TgC/FQ4J9peGd9L+67t1QnKnRNbkT9x7H4uwgJIS85lm5OG6Qtg3L40JEpOMLhpc/omrfOkiLPjL4oqNWJpPLeLFBQiKAJ9seYuRTlgR9xDZy0E/V5sSK/ZTRIyXbNmguD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6HEjRrDHKHrNRHzT8lK8+NPfB8g+bruVVWMmt56Qbc=;
 b=eS8X3DQ0+OmuRbqbPWGfYPEWIchogDkr12cDKw5f4DXFXSxW8TooWfUL55HMOAgOZ8VAG7Ca4mMubYplKoGs9AzALI7FBpCjfUiOpyBHYeHv/zo/693397V2kbSMLmJIOKfWCRrbPlTf20bBw1a5tar7INvqsgVHuWgcqp3jvdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PA4PR04MB7520.eurprd04.prod.outlook.com (2603:10a6:102:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 15:49:30 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 15:49:30 +0000
Date: Thu, 4 Jan 2024 17:49:27 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation
 if its OF node has status = "disabled"
Message-ID: <20240104154927.dq3bsbzu55qefsqo@skbuf>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-6-vladimir.oltean@nxp.com>
 <ajlbpd63vpgkyvzflimq7qbzrdvgqizbg6qwj32qudd4ibgywm@ckdcvnsrm23u>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajlbpd63vpgkyvzflimq7qbzrdvgqizbg6qwj32qudd4ibgywm@ckdcvnsrm23u>
X-ClientProxiedBy: FR4P281CA0280.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::16) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PA4PR04MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f77faf-e98c-4395-17dc-08dc0d3cbd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sRSUSi6HGjh5N1cHXPqmVRYQu1PCOcS+G1i5z4RcR74fDZiymK3lsuOA6Bypwdi6VdimYk/7h+WV7tn+7SnEVqISEe8fqezEJPN4rvJsc+JNRDSmQ8noYxAcS/vLtAg611E1TiKOR6IdT2zfYFhUkjM+mW2jpWdZ8BeD+5I19FQoT7LnZ1UnM7nKQyynwGP4HORMUlfVPcgA6qvZDDf+IaYOTVK60euZryYA6fJg0PaWSqKsgjczlzNfA1lV1r+EljlqTX+F+x867brELoajehi+octnG8Mi3kEbhJ6qBD1vLH1lj7zlW+c3U8duVKBcdTHeFKL6nrRcREb9C5mLqtKkFjAUqd8w7IGr3TFWqlCNMuNvcLl45ELRMURfROzAzzVJmLEsJfom10Pjs3+g7mqeH2/0j1gCHdd3KAVeERCIqpSmsety37COrbJWmBB1F0ibAfoUfEwY6dn3uywYWXeLs3UwaarIvUG7T6zR6Y0MHdaRbLrycSw4dYxPp63yidIBT9IAGz0chBdcYZV58o7dqsGoTRm2qaYEk5I/UFNZN8IGjzYe8EiJUmQSkVBw7mWolxYedJ0A23l1C3TYI+KwuMRAto+TJTRUEvtoedQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(6512007)(66574015)(83380400001)(38100700002)(86362001)(2906002)(26005)(1076003)(6666004)(4326008)(316002)(6916009)(8936002)(66946007)(8676002)(66476007)(66556008)(478600001)(54906003)(44832011)(9686003)(5660300002)(7416002)(6486002)(33716001)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW5iZlMxTEhKRjlYK200VXdvQmxLZldYZHNNNTJxSVdzY3B0WVVRT3liUm8v?=
 =?utf-8?B?cWNKTXpUTlFTSHNoNjlINUNmakpvQzRiM1hEYklML2lPR0NJSWFkNUhQc3Zy?=
 =?utf-8?B?S2ZyZmtqTEFPZVU3OHFQZmpUZkxKQmtMb01oeGs3RERUUXZpZGxOaDEzRlBj?=
 =?utf-8?B?Z1EwTHlGNHR4dWFkb0hkOHVkNTVQU3lBSjRTN3pLRlBjNzY4eXByN3lOdTIw?=
 =?utf-8?B?d25kTEpEZk5FMkM5L2ZOUGlpOHdvbWNqSDdlMzRPOHhQeTl4ejJzZWQvWGRp?=
 =?utf-8?B?a3Y1cVJYYTMrRHFjS0ZWdm5OUVhycXZQVmRidUl4dlJuZVl2V3N5cm5EYjlP?=
 =?utf-8?B?M21sU0luRmxTUlpvZ2kxSlFWUERZaFZVLzc3eWVSbW1GQlRDYW9VUnBJS0VK?=
 =?utf-8?B?WFRTbVVBUUxnY0hRa2RYYllwcWJqK3lCYWFUZTB1YktIcE9HMTFHZmJwT2hG?=
 =?utf-8?B?OFZ0YkZOdy84aXBvdFFzV2F5M0MyV1Zod1BRWUJ0VFY0SkI5WFg0eEIrM1pl?=
 =?utf-8?B?RzRCZi9yNHpGcVhkMDlUSkVhbWxiUEhiU0IvOHpiWXdWTmtmYmdHSVJHOFlp?=
 =?utf-8?B?ME11bWcrYmhITmFRQ1pucUVoekVSVWlES1FqZVByTmR2TW5pK0lxUjU5SWFK?=
 =?utf-8?B?d2d5S2FPWEo0ZThxdU9FRDZGbGl5UVFleU5tNkRyRjNMb1NaQnpRNUszUC9L?=
 =?utf-8?B?VlhuVzA3S2k0QTlhVTFnWmZHOTQwQW93NDhJQ2N0ZmZCU1g4cHN3MUg5TC9Z?=
 =?utf-8?B?YlppdFJNLytSRUFsNTdrSHRGNjJkV3lCZTNPb0U4MzRwcGlBR2I1SFE2aUZx?=
 =?utf-8?B?STFsdFNkUlUwSlF1WU03QnVMQzlSUVBqOUgyK1NqTUVzN0NtdTZFRzJocldI?=
 =?utf-8?B?QXAwV3RoVzBmdjQxZEs0WFY2VTZ3YnFINk9zQmlvbDArdVlxVWtWdjFlRk1X?=
 =?utf-8?B?andUTkt4YlJOUkNvdHJnRVZMYUd3N0VrMjRSSnd3WUY4cFZEMndCcWdDMzJp?=
 =?utf-8?B?L1YxczNYdy9MT1E5emtnTzlhU3E1WG5tRXRGMWlYOFRVT0gwL2ZHTW9zcGdR?=
 =?utf-8?B?ZlpoNFR1R1hVY1hyRXJSS2ZPRXVia1QvTm1jN2dLZUdrYXFpeUpDMG9ZQURJ?=
 =?utf-8?B?bkR5bW9YbXJNZzA5RUVPNnlienVnK1RmdHpWL2VHcnc3emtYOWh4eW5MWXBk?=
 =?utf-8?B?Q1ZFZWI3bzNBeVFocmt6MVZjYjI5THUweWJuaE8yVWJ5dW05VEFkdnM0c1Qx?=
 =?utf-8?B?alFuMFNRd0diVU90VWxydGdrSkpheGN3azhjQmtLZVFFU210cXJXdnNHQkg5?=
 =?utf-8?B?YXhML0FrTEdhZ1J5b0pBeFJIQXJoQjk1eHhuUFJoQU9BeHVyK2o3VFlyV3pQ?=
 =?utf-8?B?YkZSVVovbUxvMlUzakNSRWwzV04wbEVzSE5HMWdaZDBreUpOZWpFeDBzYjVj?=
 =?utf-8?B?ZTM5TFdzMkROVitRNk9RUlVSQnJ5NTY1TFB5NW9yZzg0bUg1NnBmWnQxbHFP?=
 =?utf-8?B?YUVSRE9PZGoyWXRNdlZMYzVtV3BLV2srYWlIUWNVbE5Fb28veFBXd2VqMTEy?=
 =?utf-8?B?UDkwdGJyc3BtZDJqelBlSEZ1czY1WUxqMmgwQ241M01XOTI5cEV5ajVKN1ZY?=
 =?utf-8?B?blRmSVBaZUJjRVY2TjhkV3JaQWJtYlZraHZLaUlOcGZqekVYM3VkZ2RkZnkv?=
 =?utf-8?B?dEVMSXMvWFhHRGI2VW45L3lNVkhhRzBQOVc3Q2xIOGJvMzFscEsyV1VhcFha?=
 =?utf-8?B?akcxejI4ZERQWnNTUVpQOG1QSTFOUklTT1JSUnFVQTBzV1RoOXNvcnA2U2JM?=
 =?utf-8?B?MzJPeVM1aUpub3ZvU2duVm03UFQrSzRJR0dEeklpRVUzVVBvVWxmWGVqU0I4?=
 =?utf-8?B?Si9nS3RMQk9zUlNsb3pvejRJNUVCVU14a0R1NWVteE5UaVo0U2JxdGFEU05a?=
 =?utf-8?B?dEpHVEo1YldoMWVHeGtuRWdrZ1JDeDBaMzdWV1ZFekFmNHpiaFJwdHJRWkN0?=
 =?utf-8?B?eXhvUDFHb05tb1RPQWNvWHUxa2hQdE5OK0NoWUZsNlFqQkIrNi9tVXpvL3Fv?=
 =?utf-8?B?cWtVbVVxamhtcUxHZDc1MTJsaVNLU3J6T3ZTSnhhUEV6TDZqNSs5bThIbVN6?=
 =?utf-8?B?dXhHRWxYYnlwSlhFY1BUblhRUmI4L0VNaU9waTVrOHFydmlVYldLTWdTcUtE?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f77faf-e98c-4395-17dc-08dc0d3cbd4b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:49:30.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrW85JiZTfE+5M32zEjA0TOD4qJLYb/tGQrw1mbwcNBuqOIFJuaqBhtoo1M9Vo1atIkg0ezdZu7PUEdhCDCSsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7520

On Thu, Jan 04, 2024 at 03:44:48PM +0000, Alvin Šipraga wrote:
> On Thu, Jan 04, 2024 at 04:00:32PM +0200, Vladimir Oltean wrote:
> > Currently the driver calls the non-OF devm_mdiobus_register() rather
> > than devm_of_mdiobus_register() for this case, but it seems to rather
> > be a confusing coincidence, and not a real use case that needs to be
> > supported.
> 
> I am not really sure about the use case, but I always thought that
> status = "disabled" sort of functions the same as if the node were
> simply never specified. But with your change, there is a behavioural
> difference between these two cases:
> 
>   (a) mdio unspecified => register "qca8k-legacy user mii"
>   (b) mdio specified, but status = "disabled" => don't register anything
> 
> Was this your intention?

Yeah, it was my intention. I'm not sure if I agree with your equivalence.
For example, PCI devices probe through enumeration. Their OF node is
optional, aka when absent, they still probe. But when an associated OF
node exists and has status = "disabled", they don't probe.

