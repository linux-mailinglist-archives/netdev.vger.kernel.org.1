Return-Path: <netdev+bounces-120145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C6958708
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07215282062
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973718DF6F;
	Tue, 20 Aug 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TO8OqmiV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CE28FC;
	Tue, 20 Aug 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157213; cv=fail; b=CtarOd18YrZXmUIUYMlEtjg9z2OmwqJctGbFK5lPcwR4dYYfd/gBLzvDrZsEKlTyhcdkklxYHea3roolz+Zpt4XYuITEca7R8hjnFVxL6C4TYLaCOPuwVdY9llCqY/4aVrKlmKGzIOOxuR9CX46zLVMgyihP6lh1E5Lm1PgjuH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157213; c=relaxed/simple;
	bh=hWKp5qRhLGCqsjNuuX1bI+8au2DQvvM9wzV0KUEf0Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CL31weE9o+r0cnu9lSodmlzufDKxxsk9/FjjyYZCd1P88k7l2kieeo4mZ1RilCAwtmv4lIyLyoQTD2K7+4mf+zM+PWG7vHqp/iofzDM36g/ZIv52HEsz62EfHBzzLhkOcCrhL+yLfY4w2B3yqvl1E1DBy5osO70kL5+sefGl6bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TO8OqmiV; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiMad3AGKMAcE/dkTm9dH5yR+ljSmjpV5gxoPZHWrFIq7bbss4jlyi8E5aHB8vUpB0eiouAhV6daT7qPHCDND9oj8KyR5vFFdVxFA+wvsDJXnhE4hImvQMAivCqoo8r0VeBRy5zvteIj0FQi61OWxe2av9z0+tTuYZWzOcgtesHY8odwMzl1wpE9wxNmhdLrJlUFJlzfVmM/3/An/Elhr8T1KtC74W8xS0jVVnOpFAxIpmDKVdF2xbG6PGdMiyPaA7jQXf0/0RjCTUh8Wosv4fHd89cS0lb6YieYpzgyLPPeSn0ojwZYtok/EcGPSK1SXbAIY1ukSHmxi0abobNj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhcOe5vJCHcKyRfT3d3CN88kiW2pipBNvJ41ig+tniE=;
 b=Ti6eLvSIPl0UwQC0XFfiKfGLmAjXJi1vUV8XBZU3vg6EY4r0u4P9EDO5vbT2B/MA5mJcdVU3vJvlU3D4X0O9Whcl7YPk0n6PWzrpzGVw+LiWQPR0S7/R7kmUEQt5DbxWcOGjNBwb685ePGjerxzmZrxCB/Xdcoewama8gGExwi9lOtUv24H665Kmz9srGnG36NCQqQt47HGqKQTajTLd5B9cPaK6Kv51E6TIt3pKQvTTq7gaLRr1S6M2t1Yr1Da0UzZ8nRgOeC6gdCBMyUnpXd9fdmpUc4vIXnz061yGwgF8qfL4QKhFlIH286rXyrnO/R7RO78Yllu2QEnM5lCvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhcOe5vJCHcKyRfT3d3CN88kiW2pipBNvJ41ig+tniE=;
 b=TO8OqmiVT17ygDDjDZ2gSmE8Y1BiYLES8NNMmmHFLvp30pChS/cmhCxo50f51icIc78H9yStt1wGQgqQ2Jw/TlGiXXexruE+IEmmNQfo6svmCJN54D5Pb9RpAwmtU++kqqtrcyVO+EHiU0bSxtEyA+JxTMMdR00U0G93vPJ9USB8HLBDAbsIUmqCSjT91lhLlWr4pB3AdwS1ATzes0Mc5OJY+y5C5CPy+EXI6/K+VDAvhJGJ0kN5JtN59Fdo71IXN/ENV4hnHTSk0SSUMPOpnzKOz/KRCeybGDsbI8X5lrJY56pLc1NOX0Qg/7atkJKLBzii8hs0V5nc0ZB1PiW1ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 12:33:28 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 12:33:28 +0000
Date: Tue, 20 Aug 2024 15:33:24 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dpaa2-switch: Fix error checking in
 dpaa2_switch_seed_bp()
Message-ID: <6jrlnhkyjpiyodoycu34bhwnltexwhcqz3idtxb2v4kmpugxyw@dsaul6pbszl7>
References: <eec27f30-b43f-42b6-b8ee-04a6f83423b6@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec27f30-b43f-42b6-b8ee-04a6f83423b6@stanley.mountain>
X-ClientProxiedBy: AM0PR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::28) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d90a3d2-5416-4b97-c90f-08dcc1144aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9EjPIqwJWyTFQAxUbVN+VqPc3Cq48Fyu01Hl/8De3qbxPFwqhDOZmZC6inR?=
 =?us-ascii?Q?Y6meoWK1tJwx60V4hXZCIc13CZaaM1i39+s4uXya1Oc9E8zxDlijqs499QA3?=
 =?us-ascii?Q?WF05YNT39PIdmIMdXXZWEOWYhMPV2lZ+jzJN4cbG+P9Ra1DkyxcshwfSB7EQ?=
 =?us-ascii?Q?eJRI1pKkLPwBULbl2jhVkPYrJ7+oscmFtpHaNIu6zJfnInYi30jVdWTcPg1x?=
 =?us-ascii?Q?ZmkL/g8ZFXnvuRnb/Q2qoLCNv/ti8bj3B52QDjBtxx9hYWDIVqV+DAPkwM/A?=
 =?us-ascii?Q?LGIDXQBB7/ggLdpDjnYrhwALwPff+oksrDYgEZ9E7U44SOyVQmWB9ZO6nWRi?=
 =?us-ascii?Q?+c0cQ8/rxg/K8m8ikMCiFpAwO2S22CxCy7CRHme1fanFk2IBKGpCnT1sCPds?=
 =?us-ascii?Q?rol7q3eg/YOCJlourhoWMXzBD4y2Lc5VH6+o37MUuFNmAVI67UnPzRwAW5SL?=
 =?us-ascii?Q?zHsQgzZCgV9f8A8DrrhqqqbTtDR8I9Emf/I4lSlVnI6o2ptiv6oRVMuFm6PS?=
 =?us-ascii?Q?grzH3lgZguV/lby37mTTxK1aDQX8n4iIzWDSwLxVy1Q9dIh4Ej+EEzYgEp5r?=
 =?us-ascii?Q?bF/kihSFzHdMkMhGgcRMaejmnCmj1SIK7+ll7NnTWLdQs32XvLvSZDVsP1Hj?=
 =?us-ascii?Q?P8vR1HaZXqHnLxqTCReTkAK72x8gDI+HUGMtBDRxkFZSr6IApItdu2soRz3E?=
 =?us-ascii?Q?ENwSJxQ8Ylgy3oHQVQ3DRSHaKO6wuABksMSRxw/he/Dar0wlPUcj+wrdw3sn?=
 =?us-ascii?Q?kDPBmcGS4EiTX5m3lcqvAITaX998e8gt/8oPE4WpvGLviWnC8vKE90l53Nq8?=
 =?us-ascii?Q?EBaeVBnWQIpLoEHjG35ZWSUusAXQfk8JiH2Sy4QgDTXV2S01zl/DCkLRYefb?=
 =?us-ascii?Q?zLEXEX7EccY0D/kHCEYc6lvRwTDK28fEdSkHGh1e9ajmGNu3PX+k7u7jsOFU?=
 =?us-ascii?Q?2uEyfO+fqXVEmdgBl62HG6qvAAd6VoG7jlURLuUhOJnFT4Y922a6t9jU5pdm?=
 =?us-ascii?Q?Uv548H/CMcsramtrZuuuAlI6+8TIQRNES/UuSVVH0l681j8ieU9XxPkPNOFg?=
 =?us-ascii?Q?NSXDLS8b1Zpea06SeOsRfShK52zd+vFdw7hrtO4kBG66F6P9FegMv2xSL2KA?=
 =?us-ascii?Q?9MIYVFssPkKqEjF8Jutb+R8lUN1l6YCPLvbXlrHFtbc+bvgmqtZCuBDONNIF?=
 =?us-ascii?Q?tyzZNPTtRkpEu3Z9IFJOw+0ERow8p++Ad/UHHC6z9rXp2IL7jI+zTE940FIn?=
 =?us-ascii?Q?Hn35YufAPIWOpx1IL9F27oP4HlONHXUvAELL9xydLU3EItpjn8kdRswvy4Us?=
 =?us-ascii?Q?qXgAU9JMMxKBFNvDDaPYHWQwIgm/XMTHqZsJTrPkrCzr7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dkEHk5Jl9IezT/SMIGKiUQ7PBdHf5UMVu3kUzKYvDAOufjbkaOopmYbOqykI?=
 =?us-ascii?Q?Ts3KjD+PFlZ0eaJkMYY5cUvaYkfZEKNSjQQ3jyDx2xlulS7uFLtYiTGHJAtG?=
 =?us-ascii?Q?C2jMo2DbhncDmopVYStZb8c8h4lIgn/YuT5mVCXGJrJGtBKDUnYwIEvj85EQ?=
 =?us-ascii?Q?Ef9Qgk7VvukElhB6oQrA4IFLmJrtAUCXNu70oVqJAqVw0nUJPPC2QSSPX39V?=
 =?us-ascii?Q?pkqYmekRzbN4UpdHgNAZWkihS6boqCKaDExbWzqeQwoPNaCm5KPKs6UMt+Bo?=
 =?us-ascii?Q?1hvjnYeP8gDyeOwrZDtF4p/lkS+1Z/CxhDa0+SIDNqx5/0spvPuqlDUUPzF4?=
 =?us-ascii?Q?W+kctDkqXTFKQQzI/tiB+HPJ7miwTh7vxHKL6ae9vS69S6EPrj1qqmHvh//g?=
 =?us-ascii?Q?FN32/R7zgo1pBunEp5Bc6zJxT4E8yIKJVkp8/9cy4gyyUybRFRst38xqgGd2?=
 =?us-ascii?Q?Mx06lFd8SFNUy0CnBuUZtBKKDPDo5KHZ2ox+xDukt6VRT0xbsCZEm/gZfg7E?=
 =?us-ascii?Q?Z6OEduXWBlvDCIwS8dmPh2VWkC/DxYX3l/jJvq7aky7gt4JetjkwG9LeZuyD?=
 =?us-ascii?Q?moXNywYdtEi335jPWJC9UrZtSHkp+df7o5wcoOyIW8bisjgVmRdPhrw1fG4I?=
 =?us-ascii?Q?CztWEhmB8PIRa4x4Z6TjL29oHCm8+nDgUuVGi7kc50tF2yPKNPPq1bDaiZwm?=
 =?us-ascii?Q?AE71/ofCBx8dzfoqiMcgRlS8bhf7ZbRupV/X6rOZad5p4kTe7CyobCDSkhic?=
 =?us-ascii?Q?Rgqyoc/Ujh9amLVyeXfw7R5qdwU/v9wZiEvT/loDMRqfKCgjDLOVikao/EcS?=
 =?us-ascii?Q?78HsbJ7LFOVqJ8EMpEocj0QXB2UJIx6L0aMZmwAa81KitohJuzjeBpo3Iw3r?=
 =?us-ascii?Q?tBA6FPYsSVRqDycVLw5ew4ga+h/sBOU3LAS9tjgNmZmm5smvbje2I2qkXj/p?=
 =?us-ascii?Q?QBFovFeX6FuRc/k6wFlP5Nv4Jp/xLMWVVO+k7wY8sulOARD0ljsaBCrmy02w?=
 =?us-ascii?Q?PG4NpeZR1Itd5px8ErfOFFjgooSWNAjN4IBzu2arblZWnr6LTa6Zfr5siLxH?=
 =?us-ascii?Q?VrRubsZ07TvbkmeQnHHQGLa/+2KIj9sn6hULTOKk4pPyrjw+i6Pw6JWdvOgU?=
 =?us-ascii?Q?c1RTDZHsvdoYwBuTE8mwjCaeTnTOCq13jSZv18PowIJLM/UQLdIr6gpbH5Qm?=
 =?us-ascii?Q?PNKp4U6l026tIF7YYpXySL7rnTCA+83x1KDwmJ2ngdUahTUo597WfGoWy4Vx?=
 =?us-ascii?Q?soawmcQwL9zP7/m/CU6RV5ylboKXQChH1eeB1jeA9BRp6G9B7xjArhLr2llM?=
 =?us-ascii?Q?rNREVZbZkSnUr0YeWzrEBwzKeA0WXGguVzN/Id7xR+XWKxw+f9yv7u167ETV?=
 =?us-ascii?Q?PzvwlzgO+2clw0Ql+Agxi8PrGQyfFMI9PN2ni0UJkN6oRcfY9YZCkZVajh+r?=
 =?us-ascii?Q?Td+TkSy6ydu/ZCHQlAZeTmyTY8EnrCV3Cpv4IBjZWU9lu16fi+DRCgc+MFYS?=
 =?us-ascii?Q?C3BV/C4uWDNZirEOIzh7Czw14bwVmBMQIR9GaZh9umJ2xPLgx5WJjYtOaf6w?=
 =?us-ascii?Q?nl376KAcPczmY+rgixcX41BkQ+SO5JyLUxj3ttWE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d90a3d2-5416-4b97-c90f-08dcc1144aed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:33:28.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86vAwR1i0utUCoX0MpJRtqPlsCxR3JVT8YkK9Y91tGumKEZ9DyX0eW/lo6lr8F9h5V91jYvQWzDbcOLWCrnSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794

On Sat, Aug 17, 2024 at 09:52:46AM +0300, Dan Carpenter wrote:
> The dpaa2_switch_add_bufs() function returns the number of bufs that it
> was able to add.  It returns BUFS_PER_CMD (7) for complete success or a
> smaller number if there are not enough pages available.  However, the
> error checking is looking at the total number of bufs instead of the
> number which were added on this iteration.  Thus the error checking
> only works correctly for the first iteration through the loop and
> subsequent iterations are always counted as a success.
> 
> Fix this by checking only the bufs added in the current iteration.
> 
> Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks,
Ioana

