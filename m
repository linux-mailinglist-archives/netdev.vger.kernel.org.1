Return-Path: <netdev+bounces-90343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C98ADC8D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 06:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 623D2B209FB
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 04:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080961CA82;
	Tue, 23 Apr 2024 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="g0ve2lUr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EA18AED
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844860; cv=fail; b=l9WxdeDJljgI7ntauf+48hWpiHqSa6jZbSLTBvHRFZ2mylGahyUe6d4SeWssq7Gz/K/B8NVl6vqcdp4gUh24oyb4VbASkJugL0w9YxYQvRGaoLd4X0A/QfI5DQ0h51w/dNXKg4S2StU91mRrGsuMwfp4JYglP+SD+2PIaezEJtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844860; c=relaxed/simple;
	bh=TRCgu9BhTEC1DF04NB++xzmkh9HKFEPtASCv9ZSZO3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGF+F6l2saf42rxm90fusZLdZTp3k4i1H29OAelJdY+CQahKnyPjQlvaw8Kbjy4lviKtbDGEBcMFhLY0le2qrsehdwTS9w3bfTkKmRRpZ7ATa3ieQRyU5gW3HIBoNLFhH2jIxnDq+rzwrHbRgU+beJTZ88/V00Fklq2MO06DbpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=g0ve2lUr; arc=fail smtp.client-ip=40.107.236.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXXpfeokAjvDzgBgRU37vu8Ia78mbnT3xOtnP0BLpKLusLoMq5OXOPD+Uu8cKGldQmgOqTyzQ7WyW41go84IFchY7J9Pk5N0yuGigDnAJseqdex65+QGRN2CaHIzYzUk4cH5RleRmPmQtlSDyGBaoWwhfWkemBVL1cSBgpTcAe2Xm3HhDeXeMWGtWfESLDta5pAGc+fZBnXOz+KosGpgRi8HBk6lXR7a5Ni12ZAQPGEvJcy2oD9xgxBADhVEEgWtsCjtfc6nIBTsavOrXjPHHP4+bFuXNopAQHzxWzXHPM6XOeZyqZWdwAraDaSvar4RJZ98EqYbqNp2wirnWw9HAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ft5Mw8Ine5A6xqiqHs4M0y5MMlg2wpuXIdpL4yoNuE=;
 b=PvLgZeSA8zD3yqjd+WUkzRKqz/u9C+tHRC8SrvHOwqvO02ICtetlLBpjUNX1FDqNwLOJ9SaHQfUnS6LrItijSKpno2wmBiFQAzC8qyXj0WfBDGyxFQMCdHJwbK2OWknYiua5RG3A8dyrfib+u0ajgC3H8Mn7xjmcisB9HX2yZNGd+H6hqcWsDtwsVMMihNN5KP5EnDzsolIVXA+wrmwGJyp7NkMWG/28iD5Zh3xTK7IZkYbopvhH1IRmaVcgVExhhxoPJegKgv7mFTBRq0QAizz0+xEE8NEsqCXcBvGMVaAGF9oD9uxv6PE87dfB9JQxGPRmS64Atc+XVh7DRD5J0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ft5Mw8Ine5A6xqiqHs4M0y5MMlg2wpuXIdpL4yoNuE=;
 b=g0ve2lUra2D3V4a0q5GaZTd3X+8fQ2lb520xh1aUzrcJyLv5YqZeh1GJAyhbCVtoYkRtnMsxUkTgB4yoIjELSAGwgFgRhSZX3IPT6u2dNBEA0m67jpAMbURLOGKlOmfHabwvg8cD5KNfDM7VaYN2QgnF7xUDohN6FCdb/2CbFeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by DS0PR10MB6031.namprd10.prod.outlook.com (2603:10b6:8:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 04:00:55 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6%5]) with mapi id 15.20.7472.042; Tue, 23 Apr 2024
 04:00:54 +0000
Date: Mon, 22 Apr 2024 23:00:51 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: Beaglebone Ethernet Probe Failure In 6.8+
Message-ID: <Zicyc0pj3g7/MemK@euler>
References: <Zh/tyozk1n0cFv+l@euler>
 <53a70554-61e5-414a-96a0-e6edd3b6c077@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a70554-61e5-414a-96a0-e6edd3b6c077@lunn.ch>
X-ClientProxiedBy: MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26)
 To DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|DS0PR10MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f3cc1e-9e84-4284-4ade-08dc6349f94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oc5E6z2nnPs948WqpRz4brTfavC/ffSCipB/R9ezcRW4lVwtY1xJ/y3pSapi?=
 =?us-ascii?Q?Fu3OIURN26jYT/GRybakJTC8gLPjltMUGvaH3MZyxiD2xDOStcalY4J6pEVe?=
 =?us-ascii?Q?EJ+FVDOagwbYEznUI7Vq1UtWBi2QE2T+n/zCQlRmN5i0sWud9hpSdIKot+tU?=
 =?us-ascii?Q?IhPQHpvycknXmOvOaQ7+ReMa6FjH3NEZWfsgsIibSyU9gliPs/wzNapglA4R?=
 =?us-ascii?Q?arZdsaxraQwmOydex3rixjV9JVuyAWsnKqeFk6PM+N5OZl4JjPXgfn07hPfT?=
 =?us-ascii?Q?pnbghtmU4a6YoidGF3/rn5MzFaTz8KJoaejbf/ekDzF7iWkotzuNSQGm3+2t?=
 =?us-ascii?Q?0+US7YBjKkLH3AbR/+F8FClz4lVbNFTuspsuU7kLPF8k64SAnKSfmQjfJo1e?=
 =?us-ascii?Q?LcGqqmhHibSfIfZ0Iu9HvDIoG2pu/MEZFtFMYKldoYf2WFZtwbaLSDRDNT8X?=
 =?us-ascii?Q?7cGvq/tD0PjUsJbtyJchj1GlUfgninqARwDv6T2MgWFAe2PckEfKtaelXXmG?=
 =?us-ascii?Q?B7hFyfDc3btQBXv5PRsCVZBJ0lR5hqcQKTSmuBYNH0rCdvVZ0pqziabOroy0?=
 =?us-ascii?Q?At7yeqImOYuHLtS5yAbhLvVuEx+srCnp0R+0kvhZE+MJi8+5QrKxIMIgwh0s?=
 =?us-ascii?Q?rnzFL1Cw8a2uJSFP8uQKH4i6whdIdXslSA0hQydrGb5L79vWuXlh+0Kcf+Ne?=
 =?us-ascii?Q?hcCqHe88KPMmRbl5kZbsPrNmjNr6aZDW8Az6sdiXmDdh7iw388qlwYSb0tWA?=
 =?us-ascii?Q?nuGLFbiqZefTcx25u0eMM193JxtjRsEKGgyXNy6hoaMBUp5rEmrJ6Xdn2iy0?=
 =?us-ascii?Q?+8wwkzhmQfvTzumTdwrzusk6vfoh8x3LqJDCmDCPyTuFPJjY20422dmArV+D?=
 =?us-ascii?Q?bf0fokVMbwl0hzOK2lS1Ul4EPWzU/eyV5XM1bgkHqSEFu3aQT1udfzlyiPHE?=
 =?us-ascii?Q?cT+3BnKWuEV9Pxxglxz9vL/o4+/SrPEU4ApZejQHhDZ57whdPcPh4Otdl5sS?=
 =?us-ascii?Q?tOrgwyN7zE1cCSdtdLsMAe6/U6fgixQwKvroj9qZKEQ/U7SnK2bPtdUErD+h?=
 =?us-ascii?Q?JFIyvyIbLH/9TaT4Oj4xNWinb9iI5dJYcYgw1G1SG+ukcPf8yC2kpsdTnfv3?=
 =?us-ascii?Q?zM1xHl47xyqIeSox3EkU5hdiEJQQHtkeZy/OrEjJPz6vmA8N0EuCX59/JEH4?=
 =?us-ascii?Q?GEE8xAxmdyEmq7RmGd15wF/IXmz8YRsreqEvGZ+ws0An6LNeTStRSoYGokk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X6almyP5rPRgmv2Abf3+vN+UvSFN5UiMSm4lJus007CcLNah1YAVtyUQcbZk?=
 =?us-ascii?Q?dWP8zgOtsVHiaWfBdjKNY3b/hqw5IWTqddwReBTokX8PGJBi3UdZSWYmenpU?=
 =?us-ascii?Q?HldwByvKaM8oc/YqA+e3Mc7qtIqyFerNh1ud34a5X7f7vOtzg4VNK4f97vrY?=
 =?us-ascii?Q?fnYPC4FJqnDPdkQ4TOSSB65ctMHjkIFQ8pjaUk6H5kTCNP64wGL9nuXrp62h?=
 =?us-ascii?Q?SgN8SncIbuj6AWK362rk+h7i5fh1kiwNDGwkCRLuO/+NwtWWC2iAM55SntGV?=
 =?us-ascii?Q?KZbaEnd3gvM0/gqQgp2aaGiBy2bJTMLlbWhG18eVN+8e728Ba8dVpdoWV3SV?=
 =?us-ascii?Q?eRwGZ5u2jn44E9KHU6bOLhyCSDgbuJQtkHVpbusZR/gGyv0avT74UFqHTZhV?=
 =?us-ascii?Q?yW8W4psJ66cIFt6xRk1eHOvEmrJ8DBHmj9M/QDLWUnZmHxgaAp9GKiK/RNh9?=
 =?us-ascii?Q?PWYIVXBML7i7/HVl1VlfC75yzhNZzZF11Kf+kyqUtP+48Y+1Tr14IGHN9Q+y?=
 =?us-ascii?Q?EnPDLPioDypglwI+fIJ7QBzMZT+ChVDDDH74fcSpYLJnjrFK/BpQKJfPYA03?=
 =?us-ascii?Q?r6fjXXp9Ra9pv+fkwTd6ilWC9TS6INzT2AJTtJ2h7whAAy4Ixxr+hpwNnz5q?=
 =?us-ascii?Q?BUmjJE5kKlJWzds57BsuADGwcdYzsyVvzuX+P86CGMq1xTr73ylt+hJ6DNSD?=
 =?us-ascii?Q?UNpo42/dDV8x7cbC4LQvwVJe6LCQTrlzP4B99EkxPPBpMRJt6GUDkiEnuzpw?=
 =?us-ascii?Q?n930c7M6JgzSfa62LTYgk9qNXyUm0RVExfWu/hcz8qnXFHgAifHWX2CTFBgT?=
 =?us-ascii?Q?K6n9EkONfkW5Qd4AZZSQ+ZCvzaXvRHBJfz5h7sEi/1dYdJ91FMKKz1zsVxXw?=
 =?us-ascii?Q?rQi2xcX93AU6m5bjd1gZnuiyXJxrn1BnZekzI8sltbW4las+5h2H85QVIjng?=
 =?us-ascii?Q?MGvITUPgl2X7gh40+naQAAmf8zgiy+PTabWhtBh7Tw+ADcLXAWejCqgmfSx6?=
 =?us-ascii?Q?cNP31vn7S9b4Zy+RIQwZLOfuHSahv2UHAAkDqLDWQA0l91IIaCezjKhpELWr?=
 =?us-ascii?Q?A34wLevVKrdgVovuvdr2lHiCMlwur10ZGO8ytCO/WiYN3RMt73OhI8u4GFP+?=
 =?us-ascii?Q?bxE17b4/Ph6lCE9n8FF9AENSUYE6QC8HdUAIeWGo5MG4URJuiXv+t8sBpidT?=
 =?us-ascii?Q?t/VYl3vG++Rny4bhnJtaXmFIfEScaowDzGyE5hU6E+nDEDjTeY6a6jFFaIvM?=
 =?us-ascii?Q?Hgp0UiMfM3jYp6H0S0dphwl/ba/zUBVSLkLU44YAT9oM57TiPl0SnR4Pix2z?=
 =?us-ascii?Q?gHM3aM+X26QVVM7q+TqXEFvcc4XAYsw0BW9N6FCVt9ZiSInx+0nMXtvrWADg?=
 =?us-ascii?Q?TQfwt1M8GGnxMupadqlbPr8zjuJZFfWhKXgf2xpUS//xkZWC83UXtoj0Vgo+?=
 =?us-ascii?Q?V9h0K0l1QmC0gMFOvNJz+9U1gDwAaS7KNS+1iRNv4ZM8dQZr0rXU3oy61y2P?=
 =?us-ascii?Q?kWTfuXx7pbg7n/z0meONWcKNSUveHMZetyxbuz5Ci55sg39hKF4QHxy8sDGC?=
 =?us-ascii?Q?4oybWnygAZXvmveOn+S+DKViMx2v8Eh+zJT/iiJsdKxEcn//HTNl5GaaRjEZ?=
 =?us-ascii?Q?CRSR0WDR6CqvbfHxEjhYUjU=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f3cc1e-9e84-4284-4ade-08dc6349f94e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 04:00:54.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+UaDILTBz3CNTZuEi1ko8yhEKY7F91rUGTLwWl4tumj1XuBCXC7kX6AwtwTrpJNBfAY1bnmKNJeV+dvP91aWpFHBrxdSgXbtEiJa0apWBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6031

Hi Andrew L,

(I CC'd Andrew Hanley, original author, for visibility)

On Wed, Apr 17, 2024 at 09:30:58PM +0200, Andrew Lunn wrote:
> On Wed, Apr 17, 2024 at 10:42:02AM -0500, Colin Foster wrote:
> > Hello,
> > 
> > I'm chasing down an issue in recent kernels. My setup is slightly
> > unconventional: a BBB with ETH0 as a CPU port to a DSA switch that is
> > controlled by SPI. I'll have hardware next week, but think it is worth
> > getting a discussion going.
> > 
> > The commit in question is commit df16c1c51d81 ("net: phy: mdio_device:
> > Reset device only when necessary"). This seems to cause a probe error of
> > the MDIO device. A dump_stack was added where the reset is skipped.
> > 
> > SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> 
> Can you confirm this EIO is this one:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ti/davinci_mdio.c#L440

Yes, I can confirm this is the EIO.

> 
> It would be good to check the value of USERACCESS_ACK, and what the
> datasheet says about it.

The register value is 0x0020ffff

The datasheet is https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf and if
you search for 14-260 you'll find the bit definition table, but there
isn't much there for that bit...

The patch I threw in:

--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -437,7 +437,10 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
                        break;

                reg = readl(&data->regs->user[0].access);
+               printk("davinci mdio reg is 0x%08x\n", reg);
                ret = (reg & USERACCESS_ACK) ? (reg & USERACCESS_DATA) : -EIO;
+               if (ret == -EIO)
+                   printk("ret is this EIO\n");
                break;
        }


The print:

[    1.537767] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6, bus freq 1000000
[    1.538111] davinci mdio reg is 0x20400007
[    1.538372] davinci mdio reg is 0x2060c0f1
[    1.549523] davinci mdio reg is 0x03a0ffff
[    1.549551] ret is this EIO
[    1.549806] davinci mdio reg is 0x0020ffff
[    1.549821] ret is this EIO
[    1.550471] SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
[    1.550592] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720

Without the mdiodev->reset_state patch, I see the following:

[    1.537817] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6, bus freq 1000000
[    1.538165] davinci mdio reg is 0x20400007
[    1.538426] davinci mdio reg is 0x2060c0f1
[    1.558442] davinci mdio reg is 0x23a00090
[    1.558717] davinci mdio reg is 0x20207809
[    1.559681] davinci mdio reg is 0x21c0ffff
[    1.559996] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720


For sanity, I went back and confirmed it still fails in 6.9-rc5.

Since I'm just using a Beaglebone, I was hoping to find an online CI
test report similar to this:
https://qa-reports.linaro.org/lkft/linux-next-master/
just to confirm that I'm not the only one seeing this. My search was
unsuccessful so far.

I think I'm getting a better understanding of the problem... maybe what
is going on is obvious to someone else's eyes at this point. I'll have
to call it a day for now.

Colin Foster

