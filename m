Return-Path: <netdev+bounces-110733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 270DE92E00F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83EBFB20B61
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 06:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92A83CDB;
	Thu, 11 Jul 2024 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQ6za237"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F461C14;
	Thu, 11 Jul 2024 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679185; cv=fail; b=Cj3k77jbqXuXwnB9Mw/552BIoV6xMg3pNMtIY5PtzNoAnBq6aF6e+SDh0zHol3wQkGjvKSc4vH7JHshNTU2GkZQ2W8ezgDTrxpfBTvrM5j1XYFLlDvL9QIrg3SiSokEO6W7Dw0P7b5Bn3Al+MET1HXQBnuduzo+VsMpmcmRjfbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679185; c=relaxed/simple;
	bh=iZGjonRx1qVZYoH1NGmPnyEDheOxs7UtbwTlL/6L60A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=apjvjJmr1iq/pAbSlvWFADCynMDVU0orFExqEjnP8PpcO/Y0/LhJ8bu/15ux3qxirXlylHgpVUbdyOBASklL695U7sdvfY8DCIYjC6r32gSAkXFiiUS64yvu+IObx4l+z7IBkUIqpoeO/d8zps/sWU9I3zhvw0zw9SctbiV5sgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQ6za237; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYtGLs0Q8AuzYxZK99roTkzVN2oQyZvtg9Rxb8jdWyUCsQlnbR532OjjQzDvCoxR32q8pl3FlIp4cZoofp9JL4glhOjooP716hfzkJ+lqvyPfzGQHaXSUwqegbJUCBvkSVDYEIHKSAVUtnS2JkDKQtlYrNysV640dmLfj/l7cQItM8cITaY0riUC34G5xrPzEEVjyTvNbh86+DpNhweGcI7x1QtGklBicK3pE0x2L3Ow2CN5SO3gCtd68dhBGIHnUgNqxHVzKHllnDpe27fT+I1ceshJmielSJ8khje5zjJvEQLQXUF6e3Ohee5Kwr4FLaJ2ocgHFJGcmnFntYhadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUCSAc25WxMBnJKF/qdhKJXZOnFf6J6+1VzZnRufLPY=;
 b=KZGZnM9oOAYbA6ZN3/bbDd1HMVwVf708CdklaMvM8uq5WGmjcMMR4VeaWkiHJ1Wmz0XFDEdMzwhBlOgEPl65gFHQAcLBTQCKLZknE64hJQZNmQtjYimXlm4prUjjBWX3A3UvBdwEHTEdJ/l/TnK+aXbyvpJzmYOsZ3Ibom3lN933+nV8l35f4rD3mO/3SmozcoIXKCkMlrckQka7fCaRnbVT02G74+77+h2+hoRG7c3zrxAApUVrFs0dArLtdp5/ug4YzEcG8uMmslzqXv7nZQLEozjHVuynXEs+yImqFXo8xVpXD8xLKAq3zrUIbYDc6q8mO9Ymf1C1M+qcqSWBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUCSAc25WxMBnJKF/qdhKJXZOnFf6J6+1VzZnRufLPY=;
 b=mQ6za237e/GBIC/VQsIBznHnU0PrPIJ3gdtM2jNLmI7r7QJwW2yKKuStjgiT6zDUepVeCnfwvcxOrjvd/7YAG5AVBcxKh96RM7rvY08V27qOaqdPkpufiIj8VO4ExR43GFOesa5D34s+m5xodyKROAxw+r5jEU8HAZT6IRDogc8aUPPVZsDUP4HGZEDW8ZVD1YxijIcy/qquidMl2owrWa2bAmT2ubaOCCIZKOMQ/+wjT5IdIvoNn76yJYGLJiIksCOf3BPQBCazAcvl8ByKX8iGgcvngSLLWIO5QIhj7OdlHPSkKogVEwKAFXc5dhWhWrjll82Yc4jjrgjabVzG/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 11 Jul
 2024 06:26:21 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 06:26:21 +0000
Date: Thu, 11 Jul 2024 09:26:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: psample: fix flag being set in wrong skb
Message-ID: <Zo96-sAzGw4T5iAG@shredder.mtl.com>
References: <20240710171004.2164034-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710171004.2164034-1-amorenoz@redhat.com>
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 570dcfba-5d04-4033-049b-08dca1726137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XooGUbNJ1w9r0v0EBkQfN78u54MxV0gSpeiJaB874e7WU5RhneIeRr991aHA?=
 =?us-ascii?Q?ohXBNfhwbI8lAS45+4knn72/nYKuGj4yji78e2gyKSeR7E6g3hH92Iq3zKnR?=
 =?us-ascii?Q?3oWOC3zc8NqljZExC/ts8kXZSIQawI6vLsjtDOLfzjUxG14grWkTnDFX7dBh?=
 =?us-ascii?Q?0b1wrHHCyXnhQPTZ1sXpG1wQ5uRa1IXBD1oCiG5d/667DOXpWiiflFy9SafF?=
 =?us-ascii?Q?PIgVnlvoiC8qJZleSGjr4E4LRCxhglAEfg7l1Dc3nQ1v5PZeGkpxrJX3aq/5?=
 =?us-ascii?Q?jGSGtcZWtItNeaikmMBHsfYD84QllU8FUIhF4fxi4bDSgb98+uQVq95Tp5pR?=
 =?us-ascii?Q?XUd00Qc8xLHk+VZolSC+MxZfoqeR/MZz90+a7k/GXQGySSPXZ3BAWQ5V/jae?=
 =?us-ascii?Q?pkdr42mOB/x6TT1q471I4U+fdqkvBRNxHxeGH/z3sTZeJFi1vnnQqgsFi1s3?=
 =?us-ascii?Q?iq80nJkEdgdDU5Y2aBR9eXZ8o3QViIgxC+adiP53A+djBbs7Kv+m1llsJtpi?=
 =?us-ascii?Q?vFdpLiAwGNlB55hcniekv9BtX9V4PtoEF8VGBg54FQeguQ17u1sizXmTeeyc?=
 =?us-ascii?Q?SuGUBj2SbG1eYq6iCkOrH8bMVWcblyul6u2ByNAkGizSVcD3xiNxbo0JxZ5i?=
 =?us-ascii?Q?ipzgCWPlaydqrmpGUrxt7BDdbZPvFt5wgfUwbAvxe0oMHJj8HpTOollvZms9?=
 =?us-ascii?Q?Xi2Jaqrb572USc9iXI5Rq5nMPOeYdhj9Lb4V392JnW5x8VBLk4B1Zhel2qrP?=
 =?us-ascii?Q?c6iEgljYQRmDCDwr7byvYVRIZdJupvd+2JWYJAT9vJV1puLYN3chSa92ca/7?=
 =?us-ascii?Q?1W7NSO5WUzOZfj/MsjOl1fdFTHfE/tCs3c2CifJbp29UaT3rzGSl9WADJW0W?=
 =?us-ascii?Q?8+e6UXWgqowderISEk58PlYdmNsDxB4EDmeWoWsBFe5R6rVDSfK+dnAyy/vI?=
 =?us-ascii?Q?K01mtCNTexGaZ81MAyQQmwWgygFo567B0MXpV3iUL6mozsXJSmV4lONQUfk2?=
 =?us-ascii?Q?kkTcKq0AIeqdr1zYEpH+0ABmnUA8a59unpq+59JpjlST0tm36SOeYOfowye1?=
 =?us-ascii?Q?eIk5xr80XbFMgjQXrTgeYIRC+cTZIbKE+7szEYqcv1lJTKTBajKeB1y7P+da?=
 =?us-ascii?Q?cCRfCpz4EDnONh2Px6VYeDnZTzsWwQoOF2pLshmhu01WNe7Ea8NPGxebcBCI?=
 =?us-ascii?Q?51yXPPghSUReOt1Vcx/mEQxpbT8rjVBC8Cb9Vd6SD+ufI/opFzeUb15Q3b24?=
 =?us-ascii?Q?/PTR6sC4csc+D1ZABiP1hhoEorc4n8L2MsP4la1QzqdbN2Q0UM0XJZxYOsk+?=
 =?us-ascii?Q?5aeVJ1OSWsPzx7RHvDwZ+FrlRTccq2t8gNY/5zimhn9x9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/fiZaBMJtptwYcxzBVb7mL26xaPWMDjIBCPHABczB7bpmL2mnDITj2m588R?=
 =?us-ascii?Q?qMR7Gs7sQ8U2mA0uI869MvIPbc8zKtbwDcjmVb9eDZ8OqX96e7x5YR09e9JG?=
 =?us-ascii?Q?YmplLpybT7w5yE5FFxKcSpe4qKR76Byqo5pDEwIU983fGKnw/DFJAs5gd4kf?=
 =?us-ascii?Q?vQ+pFiverKIAOuNqoAMfWXUNqySlJbjvJTNGzQ4lsm8oNdpfBC9XCmNJSGwy?=
 =?us-ascii?Q?ngBhN2VbYXXulsjqBJwtxyf8xRTYCnZuvwnBWiiI4M4iQZiPLCrb2804e1qn?=
 =?us-ascii?Q?OG53fKKkrDQR71OlqBzu43llMNR19j7A//xbq+WjGUTgZp4mWFtQDzcjYM7S?=
 =?us-ascii?Q?R2fEUcUN8ivrmFRkxY5fpApw+tA/PtlUI645sbFStass4hlKZUO5rIqrU8Xx?=
 =?us-ascii?Q?vXsDLnphtOUeIYJWua9fbF6AKN255PmworJY8eyCX4aarhXtcIeTVBpUrWDg?=
 =?us-ascii?Q?+Y03fQqNc/RTa5JEXjr406cWMWvXOw12WUHfZm4YM6rFO3asjDSIz/U9H4Vb?=
 =?us-ascii?Q?FRs6YNSRLm7bmKDIWlr1A26BXUnafbcRkeINutXaxH9sNl4iYgrC4kZT43+a?=
 =?us-ascii?Q?IlMSaod2TvYlUIAclewBRFDdNUIj2u8h7B+Q/T8NVxtQ9yqReIWOeDLB+QHM?=
 =?us-ascii?Q?5znxJjG4N8VqGlohYg5v44yD0H3AOyHQaFBUERTnrpCAjJMkQUUCjfRnmEKq?=
 =?us-ascii?Q?XqaE2cej8g1172hyg9sMgtSkOzDQs6Yv+ua5gtvD8u/IXlTwERKWMeq+prfP?=
 =?us-ascii?Q?jYpmYbmFYFrReqRGctEJTqNuftaKE9nKNgKBmgvZ+z8OZSjWHYsokq0qH9lN?=
 =?us-ascii?Q?keDgPpwF/b34kVagxvhWHwW47Dn8U8DwXTVN8tlmQo/xPvltCtxNhbsERIYO?=
 =?us-ascii?Q?fLuImRx3YDDh5FMhKLq5KOEQIa8q9DwU0NRvVRf7IZrLFxUwmnDiZCvQSj0C?=
 =?us-ascii?Q?+WdgnReLLKeGRB3Kvr8Uvman1D3RXOSegjxVmHvxJcdP57nz3UoSCMCslOoi?=
 =?us-ascii?Q?dKLy1DVk+MnVJIocuLfzu3iOtN0tAbuAT9MgIxK470nYVxa9WxgqV0Cn33ag?=
 =?us-ascii?Q?iwCwMRa9mD04il3vGsYKj/f5XyQc5khec0XkoEgjy0XBZzMfjGdquup88AeQ?=
 =?us-ascii?Q?39WZEAIIw2ICrC61N2YM7TM4AlvgrvjyCjjt78TnNy3+JcU3rZL7SJdkh1UZ?=
 =?us-ascii?Q?jcDUGhs4VTgnTZDKWKrnBWf2COjx1/2v5VWW0EcPDQPyYO5TTsJ3wXlepgta?=
 =?us-ascii?Q?TXLFS2dY0MAUl4MCiXV6V9dS8IwcviU7OjP5+RTfQN7nut5Dtyb6namoxH9s?=
 =?us-ascii?Q?Zh1PQ3FdSQJEPaHnagOCAThYxgWF9qJRMqjHs2YTvQb7b96t1TgkTbIK+Cbs?=
 =?us-ascii?Q?v2yKQsqdbYvqZgrb3hCIiF0on8tp7jBN167U1DB7XQJJ2Drj0ajk++COd1qy?=
 =?us-ascii?Q?rigS13BRAjovJBg46NOKs3pYl02Pk4iS94htRUWL151wyjEjapP/FoD3UuCc?=
 =?us-ascii?Q?oywlvNbr1uQrGBKuKwBA6sRi3ZKtRlD2+8hj4IXQxdV3MGZXuGLTvK2pU9WR?=
 =?us-ascii?Q?Uq3GRtVxYTXX/YM0hI1bWEyhoJ+lYrEOoqIMOfJ9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570dcfba-5d04-4033-049b-08dca1726137
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 06:26:20.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMzi4EZaF3BJ60htkSyQ4pdQqN8n8D6nueFY6TUlw+1adZYjZGARqWMXy2cmAnx87FgzUrzOpapbmYYIhEs2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476

On Wed, Jul 10, 2024 at 07:10:04PM +0200, Adrian Moreno wrote:
> A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wrong
> sk_buff.
> 
> Fix the error and make the input sk_buff pointer "const" so that it
> doesn't happen again.
> 
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

