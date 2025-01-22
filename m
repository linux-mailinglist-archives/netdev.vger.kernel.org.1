Return-Path: <netdev+bounces-160397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5FA19890
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA14516ACE6
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C12153D5;
	Wed, 22 Jan 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PeIWSVKa"
X-Original-To: netdev@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020079.outbound.protection.outlook.com [52.101.196.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370220FA9C;
	Wed, 22 Jan 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571082; cv=fail; b=AIMOvgm8EdocnoA40ZDp87tKi7xNwseRLRfhF/cGz4QKWItHERmyfpiTwYfNGETrp1NmN6xBu8rKVDKPN2flaIn7PWOanhlOehDVtwqd1xs0BlqArJb/6p5k1msZ7l5GQhL7vkMGMjUSDvfba5UW+q2AHnRHw0M0FJD5TFTrp1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571082; c=relaxed/simple;
	bh=7wrJ0VcsvEQU+roPOpb43+US3bL6RzXvm33KVwCWRb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iFMhUYE2lj5Vggv/N527efO8JeQzQaSGl23JWwQDD2CHaBCRduVXMigi4LiLdzPNgoI3BsNmVATV9txX35XdF4P8ThHUB5P/uzNZsvSNRtDYHDQLrzL+zQhMsMIg1wzZpx/28oGHCC0G70suRGL67l1hEat8fCd/aPIY3X+WflY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PeIWSVKa; arc=fail smtp.client-ip=52.101.196.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tt0RjRygZAstapUa5InVej2KSeom+0VVbk3Hc5DMpl9D1LQlrUetowoa3dFz10YDtLefqUqvSQVZP6JS/7FaC+FCAF+yf2gPE/zkuuV6soI0zvEaDi2+r5kfZfkVTaU+Pe412a3GQy/SLUFyjoudKeSQHg8iJabcUpTwNL759Xcbe3SlPcAPclxPFyMR8kKyl9QCsJOhjrIXZSEWxYbTAijEARsIk8tB66gcgx556SMOqAYPUcgbNVkN0tRsIeYIql0kfyJV41V/aB1PXnNu+ymCmkdhAvS2rOpoF/0eCvxgC6oQQfdGXheCc4mR65j0EIis6rZHPCg8+vPAcmjSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qn7zj2li6QVFyw2kMLD3vSMUEYSXTEZYI0M/Lpb9GU=;
 b=yYrNeXRFLt+zeNuJS/fJHG4vBAxkn6bc+CbILk2CKkD7UBI+WRjsUbB/ea72bbUpfkQ/qji7h1qwuFlQxektoVcCOBjrLj5YoenQAmYSXukTKPBsRI9MVPlDaJuoX9MZW2q7ICVTbZ1+k20wwqgLcvUIXiUX8ts8AgK7BCp1g0bSkOhut6g0BSf99qoRMErFvQp9z/scM+l7tWDKTAfS1wN+gDSXTqNY7CdCXv7v1FEJvtHJAby0vJWtbSXCc/Fr7wWA2P7xJkeMgYUNaUzLkgo/jPlioy94iD+FHkCp5Cz3TnERcJVqMBT/BBrkHqckS3oZzdJ91qWonZNzqohpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qn7zj2li6QVFyw2kMLD3vSMUEYSXTEZYI0M/Lpb9GU=;
 b=PeIWSVKa2ejPV+MZKjtuwJ0nURXawiG2+oe+F0/whifBIHdtJRqfnaIAFpudBnyp0YgLj/BheZ2kEQYlvvIshHsTBr/i95Cl9LNhs4VatjJ56y9vwrBhMCRbJ8sy70tABqtfYHQJAJMY4SW7Z+yLyq59SPT0RYRO8D0WcmB/Tos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 18:37:58 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 18:37:58 +0000
Date: Wed, 22 Jan 2025 18:37:55 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
 sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 7/7] net: phy: qt2025: Wait until PHY becomes ready
Message-ID: <20250122183755.753fbee9.gary@garyguo.net>
In-Reply-To: <20250116044100.80679-8-fujita.tomonori@gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-8-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::31) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3183:EE_
X-MS-Office365-Filtering-Correlation-Id: 5144d2da-af94-4341-24da-08dd3b13e4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ze7JzfyqoyUMJ9Mja6vPBFJ6XvSby72iwjLH8OVlLAcPFkiD/EPMq91ixOAK?=
 =?us-ascii?Q?kyRneCfRZYoDM0c581FQ2W0WdPMBt5q41jLBb66ugt+7pXN9OBcP9Qt0X4u7?=
 =?us-ascii?Q?HuV8BqENVpDcgea5rNqst8RpnLQFUrfZe0ACJQhFN/0ho+y/FVvzUGOfR8af?=
 =?us-ascii?Q?orGz7quY7k6MmMSnHdFSX6v69rgKb97uvBEZLRnWIzq9kZR8dmlgweOZ5BTS?=
 =?us-ascii?Q?jYPp7PzDEWjZzcPtNuAA7hvlU8lz0oG2Ns7WgfHaMlvUjVX8A4IOmkUztNQP?=
 =?us-ascii?Q?HW1VYDTXLyJkBvidw500jsEEEHH6TMQfKCcLMhQW20n836UGeYFIFa1qXBhN?=
 =?us-ascii?Q?22SaGqBWjHIFFe1KiCPeTqUqeYHXZsQk/IpN+Wjy7dZXymbMoVe/ibDmMKCy?=
 =?us-ascii?Q?KEOwwFY+/Wt/1jxXsqvo/2Yjp4jaaT0eYL2kQVqgYjyBAgPpv0iLReb6P4mT?=
 =?us-ascii?Q?w9nyTDt2D6AtsX4SOaioGA08Sjpae4OSC6jbQaOhugg8ib2FQ76DDS7yiJ+2?=
 =?us-ascii?Q?ll0kLY/RVM+d5Mde9KVAdbC82KR6yiza+J7w5iYuhwNMdcu+9SNUaDiA0sJ+?=
 =?us-ascii?Q?oEdfke1SeGxIJg3MaYBPE1D8Cb4aHY31rBe6iMmckXWMJ4/Jw1xCx8UiWpod?=
 =?us-ascii?Q?VKYQAoHz18WYzw2atgpP16+SWfk71jPhzUe9TYE/lmAOaemDnsLMsdk+/93x?=
 =?us-ascii?Q?eFkAI3nA/h5cyeuOPXJgqSddPR1BvblIdkjKpfedMzfh2jVqRaAGzwLVbjiw?=
 =?us-ascii?Q?5i1PcPHBYy8T6KymvpTrOeUVdYrNodzsDK/lJhm7eYCMeUG9iT5mTWDCzT1Z?=
 =?us-ascii?Q?61wkVfjysnwRiW/cA8vnIsnQUmj9V2OFlI1VOxDleXCRfIz1aZN1vm2J3kP5?=
 =?us-ascii?Q?YbuAYujXh0SSVXYdELx6L1lcQe3ETUo6QV2X+rVt1/uK16x7cdSc5lF44gX/?=
 =?us-ascii?Q?b022pHK973nrSya7mHZUP/wbBH2pc7DJnN9R8rUIgYTIkA8H8HUCBoWE4syh?=
 =?us-ascii?Q?mlvflK0pGFmCVZjY4Q2b4h8i7v9+/qECZbjQXiIeC8SGH9noH6sHeeDIQod1?=
 =?us-ascii?Q?Qjs49XNpy8Eaglb0D1uTNQOPJdEHbtqgvhYUw/qPKjbF796uW0CKPMdinkMd?=
 =?us-ascii?Q?6dAXmSamWb5ZnZIfnkiHZSsmhOg5Ed3fYHpMymaZwDcYhLN+PeTNhdneVkMI?=
 =?us-ascii?Q?qjBHbL+pRts2GscddFEcGUItjf48kLSEDF8ffLa4BTYBYD5xEobjY8UZcODD?=
 =?us-ascii?Q?XqfdT6Dr8LbsHlBsCANnKTERvNdm4t0kmtVEhrNNg5azJiIs36D8QcW4s3vS?=
 =?us-ascii?Q?l0EmPonWLy0OdZmAYlItVdWV3kRhnGQvuFAMo/u9tsvqwhM0/iOcIs5hJtGe?=
 =?us-ascii?Q?78k3SAQsNdyV682AfFIhXW6wYl3k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEy03wGgWw40HuF0py35rEyX6rPvvyP0lD6dxi3yL0yrhI2ObrkbFQ4gSe/H?=
 =?us-ascii?Q?IVuih8fsQpK5KY7TTOC8/EhjjAIW5vUGLa+I7ZLM6Zmj+6T2lwziFdW39Zrf?=
 =?us-ascii?Q?qXAXXQvI07HNXQlfLv+oywLQfwCJR7lMWe6hc3Kg01HLhNIKREccfvmBCVfL?=
 =?us-ascii?Q?+ARfSjqVEoIunpEmnsG9soSbVtCl4jHJnL43kFNxRZ9gm5Ty+EmwRZZMPPnQ?=
 =?us-ascii?Q?f7V7PfVaNG+4F4xZKu/hUh8xEEEO4Lx9nqVrh5EZeucoySgK7uBAxdQCXhaO?=
 =?us-ascii?Q?dhxUDfW5/NOAVTAyRXacBFH8n5tpQ+Fz9ItgZk0MnMVeiHUvXSIfac2euVnp?=
 =?us-ascii?Q?rUYMWtThLBkfoRVHK7RT5lOpxkFipnyVy54ikszRTHVGfkC2HYlstxWpu2tS?=
 =?us-ascii?Q?DLGI6ZSUscssjEde9o2XTyyRcvNiCbVET1b6jnKXuSSZ2LTlQAWYYyNlgiel?=
 =?us-ascii?Q?ta1CWtC5sIxhqE9BZoou7CMzY6rebQUifO+JLgf49e+7whD+mDdG734IG8na?=
 =?us-ascii?Q?X1ynpJGVtRP1EoW/+hCZn8aV4KFxE7DOpFOjkNzcKn2NgkLzlbsu23AuCSvD?=
 =?us-ascii?Q?oF46wIIpof01fST6cgJvJU0hgcq0JekQFk5xb+1YaAVeaBtayGOY4ctfnQy7?=
 =?us-ascii?Q?01RZ0DDPmVOGYn58APGZfq3RrH56xW5Fes1+7mrOvf31f05diZ4QrRgpToT1?=
 =?us-ascii?Q?UMG9kn9VcNJLey6kNP/7GZX1enTer6dNrDOWj8rxP+OM6Qhx7K0OoU1sSpWa?=
 =?us-ascii?Q?wuxQKkwWO32ZfuIJvSy0B7+dYnKNjFc8ZizWoHCL0WwU+9ZVILKNVOxUlVJy?=
 =?us-ascii?Q?JDvR2JZqW30SdybnpF2kNUmTTsaOpOrhaQURrNKiaZEYgxbULyEA9EzT3Cg4?=
 =?us-ascii?Q?sQY/teUUTzVIAyFRo1Por5uJbgDoGnRRrpCAC9QIE/4PqS/7zRUSBU7u++Fi?=
 =?us-ascii?Q?vMyTS5oggM7ANgvIRMLo0mV7uN0rTa8QGXHvwH0pWl3fSzapQNCxxwNoUuqi?=
 =?us-ascii?Q?9RHaJOhLlSYrq+sbi0PIrTayAc4ICIpo9t6CDb3CyxS1pE3eX171eMCf3wa4?=
 =?us-ascii?Q?Eeh6+g3flBK3zqKcQqheS7CcQdoonG2kkXDSdGaoyUzL3iDtwDZKJzQJiCLA?=
 =?us-ascii?Q?y0UcOBqX7hn9oclLyBlSmLvmFQDfLMgfE4U/UE+17BxmDGI7VOdcISH9Qqid?=
 =?us-ascii?Q?JM3a9iUpV08ylajK0LQaD8AKh0BMmYq0zitQYWUYA6MsIVrftBKOv1cFJb/r?=
 =?us-ascii?Q?Qcl5c9iG7REgxm6r7FDxL35NiGvBPIJhzBkb0/+lrtNtV/ocjDBo56lcZ18e?=
 =?us-ascii?Q?QVL2zMvPdPUHQe1AUKVSmy/9ytfDbFVxBeQP9o84aJkyQnk82KRqpFnSXvMf?=
 =?us-ascii?Q?ZqBFMxEhheNze/7ekWf/BG0w1OMK2d2/+WvbVDRr2QTBhOZhgnwC6BMo2w2U?=
 =?us-ascii?Q?nrXj4UhKmVq+VgzjjKhhyLMol2Tcayid6SfEOB8ExVMPLVbWxd8DJ9B3nFDb?=
 =?us-ascii?Q?q8MU849F+jAI2JK9VJxSizXW5orXpB6qokdbKgGdtm80svfJiBZjgZ9r2NMi?=
 =?us-ascii?Q?J+0qslpWu9J2DoU+eFVt2FU63ua2IXn8STZgv2FZIAS/hX3dXns8iTAp7pG8?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5144d2da-af94-4341-24da-08dd3b13e4b0
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 18:37:58.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RF69mx2ZoLI/QwQxNTmQzEOZsHgrLSIqdl/NupUTOFGe7WuXLdXPOwKM9JXLFUCqxXhFAY7HjC7caOCchC405g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3183

On Thu, 16 Jan 2025 13:40:59 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Wait until a PHY becomes ready in the probe callback by
> using read_poll_timeout function.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/net/phy/qt2025.rs | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> index 1ab065798175..f642831519ca 100644
> --- a/drivers/net/phy/qt2025.rs
> +++ b/drivers/net/phy/qt2025.rs
> @@ -12,6 +12,7 @@
>  use kernel::c_str;
>  use kernel::error::code;
>  use kernel::firmware::Firmware;
> +use kernel::io::poll::read_poll_timeout;
>  use kernel::net::phy::{
>      self,
>      reg::{Mmd, C45},
> @@ -19,6 +20,7 @@
>  };
>  use kernel::prelude::*;
>  use kernel::sizes::{SZ_16K, SZ_8K};
> +use kernel::time::Delta;
>  
>  kernel::module_phy_driver! {
>      drivers: [PhyQT2025],
> @@ -93,7 +95,13 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
>          // The micro-controller will start running from SRAM.
>          dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
>  
> -        // TODO: sleep here until the hw becomes ready.
> +        read_poll_timeout(
> +            || dev.read(C45::new(Mmd::PCS, 0xd7fd)),
> +            |val| val != 0x00 && val != 0x10,
> +            Delta::from_millis(50),
> +            Delta::from_secs(3),
> +        )?;
> +
>          Ok(())
>      }
>  


