Return-Path: <netdev+bounces-231707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F8BFCE95
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80383A0876
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E215320CBA;
	Wed, 22 Oct 2025 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HidtJuHx"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D218D65C
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147341; cv=fail; b=RXOmLF14Sz+YjfNRa1zYsEYG4KlDk+gdxvIseJVRFswfo3PzevJbLlaaJYn3DBYQqNUGrUE3LcbIv3CuCZxX9WkAMZNK2HUDGqpo6CpUsOIpFI6iByobAJzNPM/VCfPdXyq//MRqqO2hggnUn13RjowiyET0jUlTLwcj7H2LiCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147341; c=relaxed/simple;
	bh=8qhY44/OlQgrjpaPvrSxEZdMuGi8r/tjmnqa9TztUFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ljADKxaxFYOQco3xVoxYxIeXOdXsQGaCFxb9zvSLIsQRcQ80y+TFna9WHe4Wqor4+CRcQKdyXqRfB5OZqGuQkXgBOOEohTMOKYrN4oGk/Kl706SLK+vBAu0+Ilv6MsVcb1QmqdcHiOKs2fc+ZZR/hLjwwdL/zszMEyETn+zdh/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HidtJuHx; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWPY2kF3MCRNiFE1+bwMNsySo7P+KuFbYBVHeg5dUzDdm5sFNbYRrwO3SU2//X01uACDlPxFwWt4n+J1zTYFJkJF62/Vaa/YJsPf0aIFjRFOS/2zbtm2bgPjFdaYGA/WFlJgCiJp0cc5IJDLFRid6VHhhEeKxJl29JWWwKOTW07lTHIWBSQHbycH5WqvZfodI5VVb4AmF9INSkvTyMsHCsKt+af5YA7s+tD9s9zN9PfkVMoC/DtO1DApu7qEHIR7PmaA2sCNadqZ9U9M7NBeibd/zgBByFUisbmO9xXFHV4NCU5FoyKZROyVqZrIpyS/BvDX2VxtK05kaX4tvivG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72yaMo9XKoHxQKa665ox4bsYsABi0S+f9Bq6iML0btg=;
 b=PPdtfXi6orrSyHzIDMXLsy+8LdxSBG4UhsqYWXvaFvHJfSJq7w4pBdioMU/HX1Ud+5L5s6Bl8Hp12Zq9WRhZSJKW1l6DzuXy5QmmOZ1+eQ9VC3XLjYU7B6TaTbkhNt0huRHdT8mOaE9xNokQQ5vpTYPa9IOwtwF4dXETRLHO+P9U0q/o3uO4G9Qaq+gdNdAcUeloBjtSaJ3wRX39dGb2PmM2bUjvLRHzf7ypNqlFoS+9KgEE2reOujYcWGimWTa9AEuBGspB6vzWDtsnB51lqOr99Jne+IXMdmEBQfi6lHr6NEy/B8CxMyt68aNp8c1ZBqr7NbxlH2Pjkj25mGLJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72yaMo9XKoHxQKa665ox4bsYsABi0S+f9Bq6iML0btg=;
 b=HidtJuHxGgiL/l/H0gpYoLwAet3dstHAH//AziYj/7xuvMOyiPG1dpVKf+1820RMSPsyK2t4pmeWw/7ksm+vc5NubzGms8OajGnZgPjrHmi4QAo2/9mUSJC3kKDKjA8TYbecs0iMnDlNLx1H38a8UBXfkj6PJsqTsL4rN9WJ6lylBiONcUddvg0lZ54+gQJ2RXz2tCrTzuDQKuN6UfCk01/+KZf/Qw4g8j7Arapahfv8t8uvkCChLpcIY3C265qrC0jZlLRdM3uHA7LM+saMuAYZfECfN0jWSl+CTjhlTYf3mccLC6F09zDkkwmArEb2cNMD94YVx2lq2heT0dBBZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 15:35:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 15:35:34 +0000
Date: Wed, 22 Oct 2025 18:35:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
	petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net,
	fw@strlen.de, ishaangandhi@gmail.com, rbonica@juniper.net,
	tom@herbertland.com
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <aPj5u_jSFPc5xOfg@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022062635.007f508b@kernel.org>
 <aPjjFeSFT0hlItHf@shredder>
 <20251022081004.72b6d3cc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022081004.72b6d3cc@kernel.org>
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: f678f216-d655-4b1b-aba6-08de1180a412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZ1usWG+oX25eZQflIQUSb1qr06l4F6D2jGXxxKbjQOsi4MykiXZiYY3kr+I?=
 =?us-ascii?Q?mv8raeiWBVNxmAx3ajO0UNSUCKyGhE6xZh0I/IETIxjXoaHQHfMVO9ObK5JT?=
 =?us-ascii?Q?+09rxl9IRMfZTpW0+IIyP1LdletrVP3RjVlUyWU4JxKzhJh2lmdejLzqkpKD?=
 =?us-ascii?Q?Ry4f7LEbSoZMOAScD50LHrcosPF3Yp/6RJJFN1xCj6SjJTILPjCwlEa50Gi6?=
 =?us-ascii?Q?ym/UdcF/FQ8z4mITkCIRndDqoU+Kr4XEEPraVH3mmDvBk5e8uTTK/BFNdxs3?=
 =?us-ascii?Q?G06JryBAEXJD256mTZms4im2V3vS/iWwXhefMm3PW8/QCBZ6WoV/cHAi5cQ7?=
 =?us-ascii?Q?Pj1j8WGG4tzOmWHZy4wRCfT+kmO3yAdcGDhjzn8aNtlfn2kx6PRMYBYERFpw?=
 =?us-ascii?Q?0sSsGKTaKHjmurCF2yhSEKeIWSg9IWTIvnVArHakUiIJWFnDGl7sFm20XExA?=
 =?us-ascii?Q?JbcIdsVZA5751PuebktYjSfKjCra71Ctc0S3dv86EKKfHb7ZqO6FIlyaR4q+?=
 =?us-ascii?Q?u6CmhwdH8/pzSEL+kxmpmqwKjgfXk6OTyUWuDY6l80OKLA7rXW78hX5PJifW?=
 =?us-ascii?Q?CA/bTxy7Ugao1shYgPd9MCwyPLo318oTT3nCtb/JHVKaBI+yyW1PIKVXEDLJ?=
 =?us-ascii?Q?oWVPpsnl8HR4DWimqxiWTPRgjsRzL0spmst1WAOBrQ1kv1pcbqSSKM0AB4Gg?=
 =?us-ascii?Q?Ljvrxss6U/9Ry9Hm+HdZSoGttucbKn2ITHdkRKm7PVBZ+h9aBwRVMoh4YlW1?=
 =?us-ascii?Q?7emHn9qNBPz9RfA0xwrLdbgGIvW+0XNJFcL6reteYJth5rle/fkIlemA1E8Z?=
 =?us-ascii?Q?/bNKaBs4G0mbU0Nu90rT2J3ByiSokE11+xEVN3jRiH8WAQjqWORkb0U57Hy+?=
 =?us-ascii?Q?vcLBhCX/E341bkt0C46WBRgdz9TKjflX5Ew7KfNPRqk2+91dSKjsya87VhcH?=
 =?us-ascii?Q?4wDddj6ELxFDjiiq3Wdr6gfK2AMwyrgiv7H2UVtOhMFGP/GsQ9c6RX0JnVX5?=
 =?us-ascii?Q?vs3GtLvqBXe8taLCpegYE0iCPSos3pnTZJ1gflSzowzqoj1fz9yz5yPZc3Ll?=
 =?us-ascii?Q?dSINlq9TdKNjMPJb6sE0416TnawjcTvBJhcVj+AFU+dPuMbum1+SNjczf+y1?=
 =?us-ascii?Q?vKDtqRyKnXupESnlIxaKNR/072JAcgocMfcOymW8HtgrXIhkdati1VowhE1x?=
 =?us-ascii?Q?YPPT8FjND7L99MhaHG+cxVSFotXp7jNHYQQpyVLfAGc1H92OhfUSuqKgCAuh?=
 =?us-ascii?Q?zdRKEOqhbXIwJeUvHoUJ8tPmL2HnsUMcu/rL8ESBikBIw+9JuD/jWCX3p2jA?=
 =?us-ascii?Q?udkWf4G/m+N7PXixCWTmOVIPNbYC086IqGDMlKX03ePEuCyIWNmyKQWIGA9a?=
 =?us-ascii?Q?crRqlqZUOMX9FVPtC2hIOsrUfeJBArlwWGpj0is3KZz1L97ldP8mod1lNIlY?=
 =?us-ascii?Q?YPwFamsi8XOYFW4qA4NglgkyLqrhvlhq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ujZUXbXFyaO2bREcwuglRUOUe8oyJRzQcMuCNtbPBwAjvYQkCjE+uBpEJCCL?=
 =?us-ascii?Q?L1IU2nTmfUfWXQJ7smjr13CC+w0+uUCYO0VnKK9trm0uF7I85zVC71n6M/Gt?=
 =?us-ascii?Q?XzbF2mo/2V7gfFSPM9LhWCeYhOq39fnYBhWW15usReZO71ReDtiSqbxyc8Nc?=
 =?us-ascii?Q?NECGvED24mTTnX7w6qiGG7frOVIBNQ4VW28ziT+3+086KZfjmnAT14VZ5miP?=
 =?us-ascii?Q?/0r/w/5eH2ggWBCT8TzB34PtL5zuktyz2XSU4sUM8UFV9S4oaMTdC41+Ztxl?=
 =?us-ascii?Q?lO0Kfp/vhz1Fxt3KK6IXr00O6T6omtidfBLsqSTzUvG3Eow/B2RTOTfHK1bU?=
 =?us-ascii?Q?rO+U96opsHA2IBlYvPN1kq9xavroWotBL7o21Wl6WYhIsKNM3Uf/HkMlZnwb?=
 =?us-ascii?Q?0Eqb47WQ6zqQMubIzL9SYuyIpRRGUW/1pTxe46n5gb+6P0LJ/S3j9nbgnKjk?=
 =?us-ascii?Q?+RgeYJVBmE8wHOO6fpcyhn78eKmBAyfFAWtsqhvWgrHuCpNfgJtmykd6RrBg?=
 =?us-ascii?Q?m2W6O03aytvBNLXFg7r1nkdRMJ/TRcTK7cpdxtdDWstde2ZFX6Xi6koS9sVq?=
 =?us-ascii?Q?pSc7TRO+PLym6mYTWP/d4rDmIWiH1GlpBF+QlfNf4rP3NqdyKMUToJpNI121?=
 =?us-ascii?Q?7nYwTTQ2emm4rxpPJ6Ha1di7BfaIPjuJbPqkLw1ZOgdteOuTvKNBUZe6Bi7m?=
 =?us-ascii?Q?ZsZD3Ko6+t4RoFDTKZopUYy64EVXAtMTGjpK2gFUFcbw1UKVuCLGHMV8ddkw?=
 =?us-ascii?Q?H/YrAPh7GTsksV4SVLZNdiwn6oejjICKGsKlvTptFnUEvdGKN+jbMcOPCu7Z?=
 =?us-ascii?Q?ZjXja9hCZx1N4DBwwCqnOoYKsjgOAa4Q9GPE+iktUKVimhFQQ/Eyxh2NyQh2?=
 =?us-ascii?Q?nDlSPhilnoCFnCQCaiDCy4VTVZJyKRi+Pps+O8NJURF5bcbgIzHmnvoJCoJe?=
 =?us-ascii?Q?foajPZtcEIrf38HuaGfKodaytsBKx7FUrIxWCl+Sgu8v/hbQxad0hrj20/sK?=
 =?us-ascii?Q?pLHtFcyh4INYZSSIdRAd9fqREdOlW9DfC7Ag5QpzxSJQsR2WwhkcW54jlCHj?=
 =?us-ascii?Q?78mWTLhAfl6qo9Hj9BQsQNqwRjnlF3IzzEya7qJSfl/ZF2tYRLYhvMF/IUQP?=
 =?us-ascii?Q?ZtKjKtCRTqDm9HmxOsMNGbtbYuCMjdkAsbwaQ+SCcpE1t1Ey4bAgB7J+xv3F?=
 =?us-ascii?Q?U1DSkSBMCKxs+nIMKlYxVr7tdzli3HYujnV/l8D35251czJZNudjojTHFq8Z?=
 =?us-ascii?Q?AFPzI7hztFd1Si48sMhDyD4YHF1pqk7XEboz3ejTu6xDGsTxwG3pURlSDPd5?=
 =?us-ascii?Q?vZmlg1sOSSuobcxNkbXdvx6RRvk4cmB5KzFwQWvrMuBr0pFuOPB4ifqCXDdi?=
 =?us-ascii?Q?EZa/P9MqWN8I6gnOhchEG3pX3OfFuIA0gOVENpSFQ1qtrK2e/atj3oIKvWP9?=
 =?us-ascii?Q?1YV7UeFxCgJo/ov+qJ8zoK2M48SS0NYlwbb+ENQ43r6v2xAnBlU4nqwMZrDB?=
 =?us-ascii?Q?G0gb/ACxIVtOeBUVw3JLJztRh78qGH4gTZJ0rf0rY1/Tvtxq5HTVrgZcAU1D?=
 =?us-ascii?Q?EPxyRZQmPgwjIDaKj5T5nMznMIqID5CZD8NAYgpN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f678f216-d655-4b1b-aba6-08de1180a412
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 15:35:34.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fun7WNavwOps+MOogGLMocGWfAOSqp6FuHQtqnCjhpU4kxBCiT7rJoK/Lt7jaCdLW2X9MQ4u6y2E9B1CPbgBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

On Wed, Oct 22, 2025 at 08:10:04AM -0700, Jakub Kicinski wrote:
> On Wed, 22 Oct 2025 16:58:45 +0300 Ido Schimmel wrote:
> > On Wed, Oct 22, 2025 at 06:26:35AM -0700, Jakub Kicinski wrote:
> > > On Wed, 22 Oct 2025 09:53:46 +0300 Ido Schimmel wrote:  
> > > > Testing
> > > > =======
> > > > 
> > > > The existing traceroute selftest is extended to test that ICMP
> > > > extensions are reported correctly when enabled. Both address families
> > > > are tested and with different packet sizes in order to make sure that
> > > > trimming / padding works correctly.  
> > > 
> > > Do we need to update traceroute to make the test pass?  
> > 
> > It shouldn't be necessary. There is a check to skip the test if
> > traceroute doesn't have the required functionality. I'm testing with
> > version 2.1.6 on Fedora 42.
> > 
> > If it's failing, can you please run the test with '-v' and paste the
> > output? I will try to see what's wrong. I didn't see any failures on my
> > end with both regular and debug configs.
> 
> bash-5.2# traceroute -V
> Modern traceroute for Linux, version 2.1.3
> Copyright (c) 2016  Dmitry Butskoy,   License: GPL v2 or any later

It seems my check was not enough. I only checked that traceroute has the
'-e' option, but while version 2.1.3 supports ICMP extensions, it does
not support those defined in RFC 5837. For that you need at least
version 2.1.5.

I will change the test to require at least version 2.1.5. Can you please
update traceroute in the CI and see if it helps?

