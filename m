Return-Path: <netdev+bounces-42995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132687D0F6B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489FEB20E7E
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5687199DB;
	Fri, 20 Oct 2023 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uDsKaG7H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A90199D0
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:10:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459969E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuvoIOzDFHopJvHYtVDfpvBALRsGINyMRj6RxAM54NPSz+Gj8wHuhjMEj3RbhWfOo/Vwb3ODPCZpdMvxL2rjFUMD5RXbN8IYxrVWG8dsdo9c6sKNt+z7YmdxN0LbIr7aSu546WdpONTESv/Bn5fzmeAsuEXGGaN94/5BlcW6K72fnNU7pUH6buZXXs5/uQcS+dQjlbYNd7MgyEMV7KX0lBuYiao3v+xqKJLaiD6BMssxvM7CmsXirHUpSAkRgX7usnH0kF6WNqOxcJi38A+sLiRirFfxEuTQ3f/AvyjttpUWDqXntnNXGji3jHOEGuJVDPagCOHaDIp2hruUpiE9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZL9En+/w5htpGlWyrnnnHQ4G6qanrzJDKXYrIMPBdg=;
 b=ih+hR44dqQKCwUcCeEtSc0AwQcAd/iBL7cU6+A9gUUOhsGda36ihKhTXcjAoqRem5RuVe8aEtGrhM9t/M2mNJwZ6gj2VIHERm5K9qFFRRpszKtMeZWkPnKZ9nPmQWagDDDIrsBWileovu5SZ+URHIzr1mojcUnBpW/F+8rorr0aNdtkIgQwBSaj/bk1W/wnxS089ztXsxzEIlPzRwcIYf1yKtF9/F1/tcBjIgxQNPtD5sBhI5YiDPJW7cqeUFoTiv8S8PwaxFXJ+L0/hOUHAGEf7mPPVUBvVR6s++jLDH0p9ZlYFq+NVKhm48C0x+DcVI1QQ5ESM3p8FlDZLrp5aCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZL9En+/w5htpGlWyrnnnHQ4G6qanrzJDKXYrIMPBdg=;
 b=uDsKaG7Hu7/dPUEgiICzOMDsrPpqZ+B3mjCfBhD9elv5QRKSe114NJ/ur34/wuJAc9XytZvJMreDB3k3NGkwo1CPo51aBeFgZAmT8hrr+FjY13g0zAZYQ8ndkwe6hgVToUj0lfRRFYkPXdFuHADcNMufHzm4Q/L0Runjjmq4rrMF1Sh3CJF6U/vDHxu6PK2uqP3EvcsVXrbznJXQoUIhOpKUn3X7J7o7xCY+neGExy21GG6m073e0l54uy5OyivqpBw2PWGO35S7WRGYkcBYig7i11HZ12X3cj8OPqcb6s0WzMWeFBGqkQiSDRG/9J5xfcRc5t5NrnHt7wsxU+OzVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 12:09:59 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 12:09:59 +0000
Date: Fri, 20 Oct 2023 20:09:53 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH iproute2-next 2/2] bpf: increase verifier verbosity when
 in verbose mode
Message-ID: <ZTJuEaNWiHrQw-mg@u94a>
References: <20231018062234.20492-1-shung-hsi.yu@suse.com>
 <20231018062234.20492-3-shung-hsi.yu@suse.com>
 <5a7efbd1-f05b-4b49-d9a8-ef5c4c6b8ee0@kernel.org>
 <ZTCD2v7RuQojbkn-@u94a>
 <820ce6d0-4c36-59c9-f26b-e79a04b56a1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <820ce6d0-4c36-59c9-f26b-e79a04b56a1e@kernel.org>
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: f97816ca-874b-40c8-40f7-08dbd1657b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4zW9QBZj6J9YFT0sgFFdBj9xBGEiuVWV3S8et7Fd+/VUFs9WhWiWjAW+RQhuW32l9FBjrhLFRwreUWEBpCY8SvHNUozK0Owd+40teWomrNKcDjI+IAD3K4MuxYfLGetp9yH2GnW97HCQMHwKFS0vu1ib0Ng5Cx7K5aiX8Ujw9+MOqMtPngCCfGFUAkGOPeLqmofEPiS97UCjgqyvTrj814A8VXkBiun62sDdMTzRNWLJ8UL3pt9KHczy+oOY0svZKn/hNpoGH3hcEGatBM02TSThGkMO3A1+N/s7oszez1wJC4EgrKNAv6hQ2FZiKJAMuljKWp0tNMpNm+z+9+HaFkvVQIQU3X9JaR800TIMchjspc4muW0DZutzzLltJPH9bSA6gRKfh9XIWsef9vvkx5LMBmu0Nqiwko9JOSLwgcPtH9rnOzsQNhBwJqftxjn1+sW0H0hkLCM35V+KY1j6OOX6GUdcBcXwOTPQh1lM6BQXJGxj8k6qlf4XLkHqUi0CMns8Ui3GSWfQ21tqs7DHnbszSWcCGPTYuEBiMPi2uepFL+imMB3VvE34bzGZOaaX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(8676002)(8936002)(4326008)(5660300002)(2906002)(86362001)(33716001)(38100700002)(6666004)(6512007)(9686003)(53546011)(6506007)(478600001)(6486002)(316002)(26005)(54906003)(66476007)(66556008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlNiNlRoRTluRFVVS25SMHM1M3NjM3RNS1BUaU0rOXJFV3RUUnNmRy9WT1h3?=
 =?utf-8?B?YlliSTFZb00wVkwzcHE5aGNDaWJHY2RtcnZmeHdxdUFZUkMraFNoTTdrbXE3?=
 =?utf-8?B?YnFINXhvblRlYnF2cVd2VXNnRktmc2llMmRvWDNWNUpYSDhWbWppekpFYndu?=
 =?utf-8?B?ZGVCZ25DSjMzSHh4OHVSdG5Yc25mTFZpd1FReWJpV3A5QlZzdFIzb200Z2Nj?=
 =?utf-8?B?M3NwMm5qRGxYNCtJdWJOQjdrZzNBZnVVSmRQQ3QrWFM1ZnlGNzJEWFBzdkJj?=
 =?utf-8?B?K0loZFUrRmFpcUcxUzdNd1FGTjI1ZE9XaGh4UVFMTFZZUk5Uei8zSzFEZ2hX?=
 =?utf-8?B?M2llZkEzVC9oS1J5bTdPeFRzWkRzenZYSnZPVFJUTHNKdis0NVM3QmQ5eWFX?=
 =?utf-8?B?NjhnN3hOR3ZmZmRZUDQ5OEt5YTJ2ZFFrOXFqb241KzVmenpuZjB6R2U4cjZL?=
 =?utf-8?B?MG9MY3FWdTRuaFE1L1RuUWlEMWxRNXcrMFFvQldJWWJQU1VGYTlicVVsdTFy?=
 =?utf-8?B?OWdXcG1PUWhOdUg0VE16MzIrRHkyazRzdldxTWpqSnN6Q0lxYmpHMVVDRFBT?=
 =?utf-8?B?ZkVtRzVYcmFlaWFNNndGMTBKaENNK0RnN3MwMndiYjU1WEphMzRVZDY5ZEI4?=
 =?utf-8?B?Q0JHOXp5WlJVVzZhTnE3QUtuTkVBYnZydU4zN3YveG9LZXZKd3YzZ1lMQVpo?=
 =?utf-8?B?ZzFhbVlxNGRHVUlqdGE0V2tVZHlWWnY0dFdTS3g0Y2pwYjR2aEtMWkpnUEYz?=
 =?utf-8?B?NjQ3RDF4SFZncWwwZ1V3b2w0Q3JuYlRlbms1Q0ttakt6RGh5OGpuYzk5N0Ni?=
 =?utf-8?B?NnhjZHpLRzRFa3RkeUxiYnZ4Z1l2TitBV2N2Qkpac2ZDWXI3bU1HdXV2SURn?=
 =?utf-8?B?N0lPUVlOYldHTlQvQlBRZ0RFeDVSR2JlVStXbkdnTldKekNNamlXbHBhK2Jt?=
 =?utf-8?B?dDlITHkvOEppUkpialV5Ri9qNjJraUVIN3hVL1NDTVRCOWlXNFZFZDlFSGR5?=
 =?utf-8?B?TXZRQi9heS9xaVNuOFN2ZGprUHhGVVJ5Nzl4bFgzc1pMRmFDWTNUUXE2dUJP?=
 =?utf-8?B?cExBWUVwTEVodXp6dE1vNklncUpVTVh4OXNta25RR2w0Ym5wMlptMTFBUW1l?=
 =?utf-8?B?UkY2SmZERmw5K1kwdjQyQzZoRzh6US9TVDdnejNoc0VXQU9YVUVmUkdWVUF6?=
 =?utf-8?B?bHFSeXZJMlNYQkh0NXNpR0dWWk9jUmR5eC9yOWZvY1FwSEt2ejZhaHBGY1l2?=
 =?utf-8?B?OS9OejBpK00zdlFpTGhvcE5iUnRrS1pieXA0MTdtSUdIZ3ZOMzBuUjVQU1Fh?=
 =?utf-8?B?MjZPS1hpckZsTXpCMjlrVEhnaUxpbXNsdnRlMnBuTndCTWY5eG1uaWhZTHRK?=
 =?utf-8?B?SzViN0Z1U0lac1ZaTFRVNUxLTCtYZmZZSTFYMVdwZ1gvYVQ2QzJlUE43c1R1?=
 =?utf-8?B?RXBYV1laVVFpZHkxNVZKVjdwUnZqNHd6YkpoV1lnMmRKQkNCamg2UWJmWDh1?=
 =?utf-8?B?ODU4LzJLV1VkazdKZVk3dGJmRHBwUjhENG1CdStRRWtuWjJHYno5WUR3SHVE?=
 =?utf-8?B?ZUZTYWQ5TWhldUFVbDM0bTVid0FRSGh6aWFoMTllQTcwV3pON3pLcFo5enJY?=
 =?utf-8?B?QUFGZFZCajRqUk81Q1pJMUxtWnp1Qm12cFZRQXpBajIweEZZclZubGhvd09M?=
 =?utf-8?B?aUdjaVllcU9LQ2hTT05yUDRCKy83K290ZWY1ckhyKzRmaEF2WXdpYmlZc29a?=
 =?utf-8?B?ZGRnbzBUMXB2amNjdGtHUVlhL0lpTDNDRGlNQ3lUajdYQW1nN3dkaXR3SUFN?=
 =?utf-8?B?aGRnek0xNjh6NGc4SndkTmMxYm9SNnAvQWVna0M5SjBxd3hrRVJEVkFOMjh3?=
 =?utf-8?B?ckp2QTVtcTNCNEJXNTR2aHRycWhSTWFEU2w1UG1xdnpCbmd0bjZQcG82R1FJ?=
 =?utf-8?B?cVdqUEoyb29OckV1T2FPV1dFa2F2bzhWMysxcnhXOGpWZkN5KzBYUjlpZ0Vt?=
 =?utf-8?B?R2lTbTgxV1VFOWZSMlJoQmV4SjdYRzNzZ3hLMFFIMS9kdEd6V0txVUhyaHpi?=
 =?utf-8?B?eEM2QnNMWis2anhqWjdoNnZaSllpSjhpS3UyVlZmQkU3TjhvazFrY1N0cVdz?=
 =?utf-8?Q?ykJ0KHTp+qVplBRvdNf8yGfn3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97816ca-874b-40c8-40f7-08dbd1657b32
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 12:09:59.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWCe897DgCQ2Jxd6CIDEQCOhd4prv7hLN7o3fTujDkGpPxwQ9EL3bk36BD3kubopMTYqcnCBVJo6h2kJ+EIUGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890

On Thu, Oct 19, 2023 at 01:44:34PM -0600, David Ahern wrote:
> On 10/18/23 7:18 PM, Shung-Hsi Yu wrote:
> > Ah, good point. I was trying to separate out libbpf-related changes from
> > verbosity-increasing changes, hence the first patch. And there I add the
> > .kernel_log_level field within DECLARE_LIBBPF_OPTS() because that seems to
> > be how it's usually done.
> > 
> > In the second patch I tried to make log-level changes consistent, having
> > them all done with `|= 2`, which isn't possible within
> > DECLARE_LIBBPF_OPTS().
> > 
> > Maybe I should have just have `open_opts.kernel_log_level = 1;` outside of
> > DECLARE_LIBBPF_OPTS() in the first patch to begin with.
> > 
> > +#if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
> > +	open_opts.kernel_log_level = 1;
> > +#endif
> > 
> > Followed by
> > 
> >  #if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
> >  	open_opts.kernel_log_level = 1;
> > +	if (cfg->verbose)
> > +		open_opts.kernel_log_level |= 2;
> >  #endif
> > 
> 
> that is less confusing for a patch sequence.

Thanks for the review. Will do this in v2.

