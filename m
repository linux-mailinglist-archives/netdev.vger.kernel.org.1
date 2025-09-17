Return-Path: <netdev+bounces-223996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAACB7C6AA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB55188D31F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF69374265;
	Wed, 17 Sep 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dDJUuv66"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B783431FA
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110469; cv=fail; b=Zxm9FcjG59n1IarD6AblXR4tMisXLBUMHSxlf7VYECdiwYyGImD0G8yZ2fpJGmqn/wFWvQxKzHLLSKdCK0kVvOSrUDYbDY/FSx/1moo63vNzgUDmWnzW2X9ePW9nKoGG7IpMGXRLSE0aa2xJbCPIFYjoiT6RRg/1kt19bzaCH8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110469; c=relaxed/simple;
	bh=Dm80VekatVGoQ9zrws5lfo44P4V6BHpO688QTAi3r1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1hBrFai6/Y3xYi8j9aTryi3jYGycQlcGL3iC7IF2qka1LFJt0todg2oLoCSEJXklotBfzbtyP6AC47GWNuF+Py4U+5DwIZGImBKsMNnr9nYdMSSxCUUTW1rYTovHvO3m6JbLZgrvEn6Jt+/CWw7aMQoSpC4f+CeSmhShhUtblk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dDJUuv66; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTmY4VVlGqZvcRAsucnUJzOkXDbfAqcacWBvv1w2IgSqPSRQ8qf5S+NbcZB+J0BGYxl7VziyQ3VdUUyPJMc0omsbJUpbFK8ux4VHXjerVM9TRuylmO9ElGjaQduicUdKUYkal2fJJWL0uGOB+OR9mrAgBp1MwNkUpXAMIEoofsFjgGZWyZzVAwHQCEowbOkSXStoZzDtj/Y6uBKRMJqLonGEYnKeO5xss15ljwV7Prxh330jVSJGSnJamN5wIr1K6HGrzmztnZ0Y/N++0z6yKpKhFnLZGQ8rZugB9dND+yH2nk74gjKmE7IO41/O5+Pzt+h6SiRgadKiZRiq6qZchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbIJZch+Jt5RUfC3StQlETWI0JFTPjGFmfwzb+Ts5Hk=;
 b=YtY85ZptS0rikbNwHoGGPdB0SuCHzMkGZZLiqcWvEenb51xIzaElnesJ3JME1BMAqWBLOf+VeDRnfumHC7x5/TW+Cux7eTg6Kz8FxQ2iCpWsl5vm08kpPNawpOIeEeIA08NPChfcYZE2Jy+1I+Gws1iAqm6XaAvpV5Kk4zWRaDtdr+IR8t+UIdCMC4V4yCLV2bQUzTzMNJPEO4dyZumVUR8KRl9KSDd2mpyg8nX49GeexxvPo3cnYKHf2gY/gJQlXCZIoAdthyMnrbexmDUteWGv4CoocGAq7AqxOnGlRTDpF0sOQA3ciFR1pTTN0dppZ/pi3byMkCEBsaBuaMfeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbIJZch+Jt5RUfC3StQlETWI0JFTPjGFmfwzb+Ts5Hk=;
 b=dDJUuv66t5Mk8ojTAZGVsVdt5UvtFPwVAqY49nAh68Kg1KeYsOLlAj1ieL4g2cPzDhEb2NKbC0W6TVR/Iw/L4YaPjkNi2vKcszWUTlDJh/NEVuU1pqDOCsBP64gHBpYYtbMavqmWzxLblPJM3re8YN0YbzhL4sjqmoe4GHZiT9WmbAcTlMKTvESW2Sc0k5HKsyX+Lo3AFt/h7X90oPBy1pLcIqyAlRdrIsuxmpYtU65NdDPZ7BfRcLLbVkpjJG4quPXQ6K3RFyn2wnzFtSbr4918pIq5fkKsp3N8JSPW52KKZojFCJWVJ4CfvGicK0971l54Ri6V4Wl+Edm5sh0WmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 12:01:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 12:01:04 +0000
Date: Wed, 17 Sep 2025 15:00:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org, Andy Roulin <aroulin@nvidia.com>
Subject: Re: [PATCH iproute2-next v2] ip: iplink_bridge: Support
 fdb_local_vlan_0
Message-ID: <aMqi98APC2YXu5xn@shredder>
References: <9d887044246a656e15d05df716cde77e9d9ba64a.1758038828.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d887044246a656e15d05df716cde77e9d9ba64a.1758038828.git.petrm@nvidia.com>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ceec57e-e8d7-45a6-9078-08ddf5e1e0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2Z3PFePm/jCsZ7a+VC5UOPKWh7Lo7c/3hqjE9wp42UGoH3C6ZbqPig5fZyJ?=
 =?us-ascii?Q?VhoN9RcT9Ke/5dg/6tcSa9r4TLbDUfiKX5vjDNnEGY86vK1VlSyEza2FEO2J?=
 =?us-ascii?Q?iDXslbsPTmwRsPlGTi23z/H9iWXtv1hqXI/MpIYe1tIAljpFxEMhsIqFpQJB?=
 =?us-ascii?Q?ikXrfp03EqLpoeFuleFs5rwEjkIZTJi2AbULCcmQJRU7gmW6ikf+5rakTHYn?=
 =?us-ascii?Q?E+H94yVdp5V5D6qp9bdEa9Lt6uEH1z4dPzNYahFJVdwSzICx9LmPTcr5GTMu?=
 =?us-ascii?Q?6ucEPOOtDqmp06uNreapmpge93TtVKslJ+n2gWEPW3A5PR66X7Uow22SZDuc?=
 =?us-ascii?Q?HAijlPQo1iq4zIv2kEE5RRrtoi+ekDsN6bDvLs426qqnVnvf2Smmrqc9pGZP?=
 =?us-ascii?Q?o/ooNishLvqGPlougY8HGtzCDv89v1IcYEOL52B5t5m9DJkqrxp5qGQqPNXG?=
 =?us-ascii?Q?WsJ4aUc8J1kvHXmTqeCTbIkuOJ3vWggnVAjaDlNg3jDy/4+q3xuEcichJHIn?=
 =?us-ascii?Q?GmCwIdWIoXwsXsl4NYj66J7Dfk44AASZPjl3qnNcAp7zWcCA8k6JEt7YRfVX?=
 =?us-ascii?Q?OgmC27PCab3FJzqng+P6bZhMbvLl8rZRG2SGmB90W3QnZPKCD06TgNBCTxmb?=
 =?us-ascii?Q?s47ka8l1OBxI/rN/OW5m2vzmVHEx467KOmsGKkh7To0ht4EVk5GR4omUMExZ?=
 =?us-ascii?Q?iQNMZCxGGbrzK5X787QD35Czrqilu7qDDDLoAT8Xder6Zk/ulRiheFs5i+Bt?=
 =?us-ascii?Q?iZvrsJIuuYNzKghk7hsJQKJy1DcTmIug+aEIVTTBbRTbJk8uS+jjf5NN0zLT?=
 =?us-ascii?Q?YHbbX0tzGCVvjx9jcoHlM3iwqyOH1RtdAgWH0q4hAfBJiV8pdnmw2OmOjgMf?=
 =?us-ascii?Q?73RVoSIhtRPVhdU/kMrnwtjLNupRLlMkaos83IKI1M37WYvfEvg/vtzweM6B?=
 =?us-ascii?Q?HkU7s6CRDV2Sbsg9gpR2qglnlhgLoLOCj2Nd0QbsUiaTjQF5C3K3QOY+9Ge3?=
 =?us-ascii?Q?p31GfQuKw77wdIoSM+5LfIfYamiTL84qdy+U0X3k2qtI7AcvvTuW/0dH72tI?=
 =?us-ascii?Q?JooXmNZ/TeogL+6cjAZizwAJFaduVtnSjhdJTON7limpL8wR/EKwJYhzsLCH?=
 =?us-ascii?Q?uENa++JuOZswIqm58S9rnyipdvgXap3OdljKz9DzZL9Nh61XxgGyQwYYbzTU?=
 =?us-ascii?Q?tOF9/RlUsdYhTmOd/LYcBs0Q2HcwBhM8bmK1a1FYOJlWOuR26QzzPtL86j6z?=
 =?us-ascii?Q?Rtg2zoNH1bNCJbqvuzVcBlBiody7t5f2K0geFwD5ruf25qMkTWdfLHozFTd4?=
 =?us-ascii?Q?S0IUw4zH9HUmDvk8f7018a1gy9a972WrSBYZ2NJhNovrZL1F1ocyxlF+/Rh3?=
 =?us-ascii?Q?v6P0Er5i3dFHpYHmODWtnDVbgyS6qMaRlYNkZ0YVZ+s3J4YgHq61yptJ8xk+?=
 =?us-ascii?Q?ri8mgwVYpYo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iUzBAnLVZ67v5iANrxhrT140TkzatTZsgkJazASQ5J7bA2g8gq6DxsOp85Wz?=
 =?us-ascii?Q?Wjie+c+F+Y5YIIERhkJezW5DQT6tChMSeXoMOnMW9ouXb7LPppIeYShc+8rE?=
 =?us-ascii?Q?SY0o68mT96NFhHLalYdjGZ3Dc1uSKf4qZYB3wZUlYx2NmoCNsCKFjF4/DCW+?=
 =?us-ascii?Q?pwlMx6guLyQ6hnxAOxuGxvulG8gQ4dKoiYWy3TndRVti2fuOlDE2Ny6DOrQQ?=
 =?us-ascii?Q?eCJoKZbUC6mx1O2VRqlPLyNQFvVI0eYNqw7pLHRwTRS58Vld7K6SxZ33Y+wg?=
 =?us-ascii?Q?GdoRkPiMXELrDahnuErRwPLFfwxCG5Eg+S/8pT/WADmVH6v5pTj+WtU/Fycf?=
 =?us-ascii?Q?GyUTI7JmEi+MC48zaIWTlMoQMjYiX08m6fNt3oUyAmATCXb+KjPKyGkvIDZB?=
 =?us-ascii?Q?VdVRPRTDYZLv7JacYWFYEJSI1R9eNIZAymYA+K5lc+rjwXFslB6xLYFM1+1e?=
 =?us-ascii?Q?aryHH1DYKwAVhBCKTbwwLPSeGL2MC5pP3fLobdhjGFC1jO+Y1C3y5+kSrCde?=
 =?us-ascii?Q?RdFIZLROWX969/frIPzQlgBTdlWAr52BSB6snUx8+xbeYRggCvb/0geLJL0l?=
 =?us-ascii?Q?7kd/5E9tit3BzkZDosOhbKShQKUwPhhDpt0N5GBTpEijF3ubX0yCJXz7aip/?=
 =?us-ascii?Q?ovXgiYWEvmNjvF7ZcfZYHEMcYmjQeFXw7PD+6VBM0RupM3ePtfvZBXN697xM?=
 =?us-ascii?Q?5tSWeyDioBKsArhCPgd6Hlp+ek8Ospe8X2ZjDWBuEZywFupn0FJ62L96sipx?=
 =?us-ascii?Q?Ioij+Na5jzeiUmCCDoOXJ54cfZ8/dv19jd4pCI5hvdLMG1gh65Kaz2DyGHd6?=
 =?us-ascii?Q?Wv9LlmYM7ocQiPpfT+g2ow0p6Z50qRoXhfHlTddAaugZSLhRbVdYzJKjqksl?=
 =?us-ascii?Q?FViKs4X41j5SutWBn45Wm3q+Bvs7rvDjp2XsS+qZgKJC6HcCkjDS2N/d3SoJ?=
 =?us-ascii?Q?SDMG1qyU1VT3JbsGxZ5UpbT3YAKy6Dk0ZbtCpB5vh0hY3moa/RvxJUyZ7vLH?=
 =?us-ascii?Q?7+iuQVPl7qslcm44FaawITG4tc7K7sm15eFTdueB5Yg6dNKMXGY5VD88Ay2V?=
 =?us-ascii?Q?biuDB4MAC4rDwIY0xXGyZsN0aJeA2OtcTZn15gHr5TS4gooiIXl4+/vKmXc7?=
 =?us-ascii?Q?Xv2/V2b87hyY+jn4B1ThgR6BVVuMZU0xg2xgNB4yY2gIXetF45zfcXF9N2Qm?=
 =?us-ascii?Q?MZn3zbActzw4l+aEvbi3u87bfersbm+wFjHHja/bGcIR+H+TESa52NDHC2Qj?=
 =?us-ascii?Q?asLSqyy9HVJREjc8Hml43IwhsDJutAoT7SFSD22EsTBRH6OqGrJx/WedqEjR?=
 =?us-ascii?Q?OAZl9NfAb138ABxB/ZOkebUnsq1O7xXq/AsXxjM+nmp1GscVZlTd2qwQMqHZ?=
 =?us-ascii?Q?sjMhdZBnMlVJAlU2DWoqx5x6CU3R8nvwJ6oGrSPR9SuI5OTyUhuUDP58F8rd?=
 =?us-ascii?Q?VK6QwsM3BaUWBDzJPacn6jCx/Jb07qk7iJGUMfnd+C3XLNCVdd9JZqPCfhT8?=
 =?us-ascii?Q?9J0sJU/deGhm9vKNmgISDLYa5vwi3somOZh/s3j7rmr6oW+U2hiZNvkCqKeG?=
 =?us-ascii?Q?hFaQTFq1n1/6DmcG81VSkFbMcro7DqgD44ND7GoU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceec57e-e8d7-45a6-9078-08ddf5e1e0d7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 12:01:04.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27JnjZHwuM2q/hZ2OOX1+DqUGqAVZ0H0Eg37ciUQtYmh34rUFGGpy/nRcttmwRuce5HbwjowcBWgPzJMOnnAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217

On Tue, Sep 16, 2025 at 06:25:46PM +0200, Petr Machata wrote:
> @@ -635,6 +648,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  
>  	if (tb[IFLA_BR_MULTI_BOOLOPT]) {
>  		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
> +		__u32 fdb_vlan_0_bit = 1 << BR_BOOLOPT_FDB_LOCAL_VLAN_0;
>  		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
>  		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
>  		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
> @@ -661,6 +675,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  				   "mdb_offload_fail_notification",
>  				   "mdb_offload_fail_notification %u ",
>  				   !!(bm->optval & mofn_bit));
> +		if (bm->optval & fdb_vlan_0_bit)

Shouldn't this be 'bm->optmask' ?

> +			print_uint(PRINT_ANY,
> +				   "fdb_local_vlan_0",
> +				   "fdb_local_vlan_0 %u ",
> +				   !!(bm->optval & fdb_vlan_0_bit));
>  	}
>  
>  	if (tb[IFLA_BR_MCAST_ROUTER])

