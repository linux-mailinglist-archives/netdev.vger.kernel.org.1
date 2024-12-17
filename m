Return-Path: <netdev+bounces-152614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4B9F4DF8
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9117A7D37
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5EF1F4E36;
	Tue, 17 Dec 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pjz0UkYV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4B20311;
	Tue, 17 Dec 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446356; cv=fail; b=TEcakcrPUEeaM7O4X4xa4m2mLwb4o1yA7HUeb7kPk+h3NylNylxUu1tcxJvo28JB/7HGeK7oxQiS78k0OhpSn21kPnteam5xfHdl9dSrw5zfk5617HHC/BMv0QJZWH0Xj1CmGU9SODO7E52jlSKE6ug63Gs7Gz7JyoKpa7CuD7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446356; c=relaxed/simple;
	bh=GpoZ3uWThmQPwUuqi/T4XuMX/MaFiIIYLprzAk3IPNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RsBwVNFwz7EUbSFuXC8fn4l27k5i/h00cmdXidTUn4XewrEkjBvlu/246Foz/gs9y81eXRvbk4xqELfEuE8LgZg0m+BPZ9XWyB+ifywzB+arCc25wQJx72npn2wHQ1iQjqGwQKKg7f4Z2rlGZOC3jTCbmw+vB1qnj+fyoBHMaqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pjz0UkYV; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBQHPabdszj90gXXpavkPXjGmhikMJMUDZQCn+x6JRbLVf+9T/vi3kUARdsXyD4YwQJAe9uwh509nn4/xwwA8KiXMwK+W19Ke+6st4sTSFDzPJJ88ttqLbXzl7tn24tbP2g7zIpqKordG5IhKGrtxr6GC8YjCeENpauTGX9WjCGgF8gOVs5J3I97Wph+p1b0NjDTf6ppbKj8LSkg37gckU1FmoXcbZnV4J9gQvZ063uM2HIMkSMSM64oqKrjLv4y1nMaAogTiIVK8ErkEPdbJuppFvhMu8cbXMxub0IoEaQfLf8UwP5dZiE9VvzIQsxTfVemY1KpkLwjvvUs3BFNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecMQX2G44Q7sn+D0s2bDxpdKGFIzuVEdsQOjAX//5JA=;
 b=RSUBpUE97iMjf/JVf0VuT+265bTC/cd1aWfQqy/cA8VZzZMF3e0zNXYjSdp/xTMQpNHUdcFycNMOC4GsRaksPbrWUew1FVFw5hPLrfszoxaUpUBsk1AUbAaQbjUm3HOTnT155ZyL+0Qh9rkM7wXmN/UU2x3s1DixVh80evLYF52ifHOLRGtWtglnixPBnxhmMoZv6zAY7ZkZuPkz13LrX/qkuZlVePQVtZg3bFGepIfwUHzVbGORT1jrULBULM5qvXwiY8oDnur2ZN+M4KWWjTE3qJ6uBdnIGb1SKpIi+myUh1PvIa5uw++CX48qlWske1gVzDvgZTNBsyTPD5kqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecMQX2G44Q7sn+D0s2bDxpdKGFIzuVEdsQOjAX//5JA=;
 b=Pjz0UkYV/Y5a4dpah4Uy0lqP4PiyDzjoqnUJDJdbKhc0cZ7u9XIjE+l58NSisDjpjQI8bkNUKtySesieMuh0VCpAX2FimQMHdby/XSxCJZA2eE1F7g4s2IpCHQ0mfXgsX/9uKNcbzZDWKR0r+X9qwSdJ8st0va8QHu3Ekxh0ywelrLjdEzdlw7gamCtns6S7XWWqM8MzHtMxfuNPep+YqUK5/vLzGdEFdrh94R7UpEcq6TnV0fit9cDgNrvjOLgbLKPKJVFGD/ApZ+DqCemnEOXReo2iXKiFebcLo21dqd5ALrYIj1BT03BlwAAanMgvjy6lylUJ6RU8mOYTtO5zzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 14:39:12 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:39:11 +0000
Date: Tue, 17 Dec 2024 16:39:02 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] psample: adjust size if rate_as_probability is set
Message-ID: <Z2GNBtGznUHusxNm@shredder>
References: <20241217113739.3929300-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217113739.3929300-1-amorenoz@redhat.com>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: be2b44af-cbbc-404f-8fc0-08dd1ea89271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EcsOZmbocDRZLEjDi64tJDUvRjMwRNvRPuvjGJ+9HF9FStYTVhzMCPvApLUQ?=
 =?us-ascii?Q?O0Ec27SCBZ0/9uztBiIs5EjGVhye/FegtWeHx4kFShGHCfFOsqReWMgoKfVt?=
 =?us-ascii?Q?CjE7ZLuNShQ5eDeAPN30YovuQhFZELSUFqsw6NTpFNDelg1DkKZCBoqAdb8c?=
 =?us-ascii?Q?gbiXKEgo8JHOdpuk4x/X267et4boEv3ZbicY2BVX5z6gAfqP0D4N6WGbJiG8?=
 =?us-ascii?Q?i3VKWz/7otzrhRxByrwr6NT2uFwkFhYGSqGYK9K0uana5i5VHHOjMBcxvMX+?=
 =?us-ascii?Q?IlKssC3BXd5WsYg3k9PywPGCA3wbrBQlNaHP7DZnB4V4OIXt9bV8uCfEoDaM?=
 =?us-ascii?Q?zRKhw13m+YumZ4SFreoCBe9nsKiVIyWCQI9FpRZYQr9hRzfut+4Od3twCAyV?=
 =?us-ascii?Q?Xk8TCjGMX0hNX9fTgbmV5V2SSFypsEqgv1q0Y/CnKSen+yE8qer9Q24kd1JE?=
 =?us-ascii?Q?IMbgO+OPbyy/z0WwV+swW2smWwn3yRg6HX5qJ6JzDDcX1XK+agDAT0JUqGOT?=
 =?us-ascii?Q?ywshczdVkC5QO9t7THOYbeqA9A+zfvNXXhxfrVG9ty1+Y3GQPw90wC3VrWBP?=
 =?us-ascii?Q?fYyWADE8fIvhNwipsMWIsaS18cvmiYULMYggoWRg4fb970/OQOc22wtNaWc8?=
 =?us-ascii?Q?AUl62ffDRk7f/eNKT5VzzHDHk3ewxR//sxMObRaw5+0V3s5Pt5uO+P+6NfSP?=
 =?us-ascii?Q?Kh9+9zRdRV+q1BQh9xnijVsMwJTyDDZUvDKyx+WFIKI4kkXng+B3cVj6TT1S?=
 =?us-ascii?Q?JX93B6r6Yqn3S6Psd+fAA0eDUeh+fgIzUZaxdrs9ch6G1/a4QI5dxZ07/P4R?=
 =?us-ascii?Q?9tBbdFjrwkect71nGGLfDN206BrvKqQM7OPuoh8NWwEfflDnh8fW7gU4SlQH?=
 =?us-ascii?Q?blz2bnB4t3YSHorViXTapVvLnJv7aYANsH+IAfvu0SsvB7jcCYLHrkzkarUt?=
 =?us-ascii?Q?xHzzjRkP+50ni+2PpJn/3C5TE9NLRptOGHS6vmJbj8pNZUO4VDSjeiBOqZlT?=
 =?us-ascii?Q?zzsQ2jhUjyIbA/iIoFmujIGaALb/GT9fFtWOe1PNdFPhvhSYT4rXc+tWitYJ?=
 =?us-ascii?Q?J6DwvK1wndb3Nj4t6ttJm7S4UNDtA8OQZwLjMlHDnHhDHIrYO7SnYGQ8TPad?=
 =?us-ascii?Q?bdNi4sWJUSQ1k7BBM9ZP8wrTe8jlK7UwNOk+OnI/TVrpQXZ3ZxZ0plReuVBg?=
 =?us-ascii?Q?5kMsL3y5H4RkiTZNaGEdVLbyxwmiarJNbhiExqh1ggkFZ0rjTjCSnIqBSEs4?=
 =?us-ascii?Q?DdGqYT7lZMROQZ3iUEaDKXGZeEGf0mGCIGjeZN+vw7akjV1U/ztTjJhl99ai?=
 =?us-ascii?Q?jRuHM6x4Y2cvogZWamo9g1kE86MYyLrEURliuDNJLpwnaJOFaW8rVE4UP7jW?=
 =?us-ascii?Q?1BIvVxgRh1HsN4LncXyTmYtYndtd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oALEN5qU/ianS4kZJlHiuU1slQUDBkFcnNq9I8GuGcolnSQ0h4DkgRWCPEIu?=
 =?us-ascii?Q?SEUsfvgHlGCCn4fnShuo8lNuiCIch4iRomEfID29Q+Rm1Ol2Fvri/MbTv8//?=
 =?us-ascii?Q?nUK7Ws+msDXRJFM1EBHWHwurGo2Ik+v4e3+gUhT1XgiXYGyOVU9HEj6s6n+y?=
 =?us-ascii?Q?eBW4PzATm7TCiA6P2vMYOfGxxHzXyoJKsO3va6a1Gz3GiWGJwcx7+BE+a0+I?=
 =?us-ascii?Q?z67CYg28LHEqGY0ZCRWeVYRGQjdFTByL6Xc6pjmEuYl7Z+yHAZ2kyKvRtlB3?=
 =?us-ascii?Q?yBUcCIxe7cfdZexs01AuwnVhLtOl0+WPGCQTb4hJPFgmDAnQ+vl9dFPbAeGa?=
 =?us-ascii?Q?ENMpIdVdS93Pvh55f+j78dpNAdUe3vPCXsgpT2O7+S12tdvJIgyZvpuvwXg0?=
 =?us-ascii?Q?ffXQ0khE9+fj35+jHuhaY7fJCLyWgT0rOyVReytZMBTK/+Pm+ea8Ai8Fyjkj?=
 =?us-ascii?Q?1YoPlOGVPViFskFIONZII1DoEf8F5LvRHfNdZIgWyKUJzArGcL4AW0u4DuoA?=
 =?us-ascii?Q?n6HNJUErEy2oK2/M/SApBtlV8PjbjxDpuFh6M3SMgdK43QC9EwPpizUYHNA4?=
 =?us-ascii?Q?PuChuVUZ348bEd5uU9yV9B7Sr1VBqBVsquxD82AeG7tWlVHHmOJV9ctQfWMo?=
 =?us-ascii?Q?SGCJro4kQt/1THyxWRT4y1rxeqQYMEtdbXXZJiRxe9Wj7VGCFegZs4iFpsGI?=
 =?us-ascii?Q?q+Ujd8lxIme2/eaJ/0iQnKXcWVfQNA12dbAscpdNAKeCczi5qW6svWm+Cqaa?=
 =?us-ascii?Q?Uh74cMah6KEwLgy9S/wsHQcsgZ1M57dlAOJhx6LrUbcJEa7lD/1nd623tfSK?=
 =?us-ascii?Q?NKfmfoOv4SWQnUFssGZO0TkZrqsVJFxPV3HL6XdVK97BBYdoHCuSsR2YK+k/?=
 =?us-ascii?Q?Wz4RFmnA6Id5RXCt8t3eY1DgPHeBOBkn77MXgiKkEdHTutKDPcDJ9MAxp7vz?=
 =?us-ascii?Q?1B9Lrrbr5UMebO135jTQm8by5jHKbyg3YeVz7VfNxSbx2vwr5d/t8aQ8QtLu?=
 =?us-ascii?Q?TZtE2aCVeG/bhqY/fr69TH8HlNvlZaTboqVuipHQ8daClZMJ5yFJOfsdCBVU?=
 =?us-ascii?Q?PPs1q18kX6K52QOEg6/7CeazE0y8nfx9Oq/ugHtJ7D7d6V/mYGji+XCywI1a?=
 =?us-ascii?Q?wSvHSZ5O6dcFDrSrJZD+fKbV3wcPfXjOecmedIq6Tc8q+n4YH7EX1c5mI5gZ?=
 =?us-ascii?Q?hBckMrs2OZ7HHaR2KSP+CTFn+O8z75Z6PCBoYa7aKr9/bfrc5N4z8IIayYdp?=
 =?us-ascii?Q?+FuPvdoLcDjLW9YbO0ldx4bmnwxDavAmi59Eahh+PsAqsT5Ezb5QNJAv8rDb?=
 =?us-ascii?Q?5yMeeh7nTXGPXMi1FalCWF05odrF+Z2J8MWkmBMl0sXLfQoVrBo+SYLcG0ed?=
 =?us-ascii?Q?qFtNfOuWC/Y8/b9K6dd9JEsNZ3eQhd+qN0mrL39nHJ3e/LXxVzkEgFbta+mg?=
 =?us-ascii?Q?chDUYX9+Nto2iceAxHd6+X/jsOT8KDQzC0ihafFFqYEium8+f3UIg00jqpqb?=
 =?us-ascii?Q?3iW6PMkkfyjWLlh8VYrzsSruZVXqMs+HQuVFU5mWvHIDncHa7yw5focJRBQ2?=
 =?us-ascii?Q?HxfnB2k1zVYWFHmlPtrcjSh5F6HO1zWZg7w9zJdp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2b44af-cbbc-404f-8fc0-08dd1ea89271
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:39:11.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PM3RFLdrc9Vi4Dne+jB2GaEOAB4KS9tE8sckn2ZIid4HhE505NOVishXluZ5ZJGTUwOL7z0ZGIV8IuedvPljUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286

On Tue, Dec 17, 2024 at 12:37:39PM +0100, Adrian Moreno wrote:
> If PSAMPLE_ATTR_SAMPLE_PROBABILITY flag is to be sent, the available
> size for the packet data has to be adjusted accordingly.
> 
> Also, check the error code returned by nla_put_flag.
> 
> Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

