Return-Path: <netdev+bounces-212003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B5B1D168
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 06:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99367220BD
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 04:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759C1D63E4;
	Thu,  7 Aug 2025 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVj0tKcG"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9C71B425C;
	Thu,  7 Aug 2025 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754539754; cv=fail; b=YS9dtvjhZ7T4vhwdy4HqXR72FGGA3DQ3RMP0mvN9zgYDzKcDO2ISyATzV1tBHhCSpLcOBlfdd5vAguTENc2l0JWP/0/M7hVs9z/nLeu2rCuxSBr4J7V6Wi1DHvPvHJd85dHUXAzplnWlLbDpEuVMK6e3ZZZTJPx+hQzUc1XQ7q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754539754; c=relaxed/simple;
	bh=f5LLofqDBvOpQEOCRHIA4tCkT3dfs40tGK0r1pnsoEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZaE5ncKYvHqvyw+OXtWXXdbsmmXX1a+iv23camBZRXnLeAVD11ryv7RuINx5IjBwCeA4jEpGdFuwd3UovskW8TlywisoxLgAWDTrWg4JpNmdSm4yr1jnV6Mo+LGHjcZ+FdRiMcrQhuMSt8jVF6aUDWdGvN0MbZnCddi0CImiGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NVj0tKcG; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI9DfG6F36sQvR5TXOElnilVOTXcMEKteZfAWTCpU96FCYmFEIsa5FVW5c1UFPW56/8iLwg1N0vpqDbCHH8hWpkIQ3eD59XlGxmtIK0LqzHcBPIQ+UyygGg+SvLS631Bj372jssoHxhwsWBFkPiLePmIMVWVsxIvhriE1aFk5pfggP3pimA0/fJLvre1Z0/i2MEty1TVTuY++aA+MEvoh61nQTq0EQR+Ct5q+cuRv0+oFbQaH4dgwAw7KzNr2fatbByWn3axEU5B+1znkIA1rebnaFyr0l8Nw1HIZTXOSd2D4sRdLzj+qdNtRWnau/mUqHUF885BsZ7p6ajqfyuK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKYCWVe5wjxo6uiMy90g4/+7L1yLg4irLZURNGzlg88=;
 b=tldMQO5DWra736Z1Z0C9zCUz3y6oKgTwSMOIjGYvVGd/hyOq/Q6JsC+DgyUaohLZbqCl8rwM2ZO7mDdNa3wAWNM1KNZkrjA7IOSXttrC/5GRPfJHIBmbTdwphk0lpOk9obf6rjbxrtJ8tEjDwpB9N7G6SyOAJaRxrUBzyJZV4W2iwz4/9DsNcdLCi4LTNtNJlf4gsKvxca3u13OFDAdQy6MlWDDGMN/vtq1DzTB1PV1GamBR8ppTwpZyLn+UPc0nKyZlQd45bPmXsu6vib5yYftSMa702SFtcbyIjshhhWaX5l7gtGp3OnUoI3CvUYq+7mweDFWfJ4IFKPCyx4zhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKYCWVe5wjxo6uiMy90g4/+7L1yLg4irLZURNGzlg88=;
 b=NVj0tKcGSUUTrsiKmj/vf4gu8LCr+Yz86KvgEjwtgFmFYPj/N1gUjgdZ+DRdnL9UFZKdYqC3BmVJR+BOUT65STSKMJlW2hxmKYCcUS0gtquKCVDnAyCp+N/SGYHdcnMlINyE+SazusBh5hAJ46le3/6XnERg1CkOmaZGxxIprQZzbwAed+l9bv8FxxVW1TYVGLE41/UMGOL3jJefjWS/3m/dF5MCC8N6zj2Bye2oYReDn8I7Et/sRNvOkhW0lMvWrgk3cH/BAj+QJSvtx5ONdhZTxJxo0E5FVWByfYGmYkwdU94jY2UhddmzV+rxpqXxA+gmGtFhMJ58nKp5VEke9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GVXPR04MB10520.eurprd04.prod.outlook.com (2603:10a6:150:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 04:09:07 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 04:09:07 +0000
Date: Thu, 7 Aug 2025 12:03:39 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, max.schulze@online.de, khalasa@piap.pl, 
	o.rempel@pengutronix.de, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] net: usb: asix: avoid to call phylink_stop() a second
 time
Message-ID: <e3oew536p4eghgtryz7luciuzg5wnwg27b6d3xn5btynmbjaes@dz46we4z4pzv>
References: <20250806083017.3289300-1-xu.yang_2@nxp.com>
 <a28f38d5-215b-49fb-aad7-66e0a30247b9@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28f38d5-215b-49fb-aad7-66e0a30247b9@lunn.ch>
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GVXPR04MB10520:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e92867c-4a7f-44e9-a419-08ddd568274f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|1800799024|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jJPHC9aFTUFmjxuUYO/YOtFAahESyYwdtWBzPNvpP79w4bwRu5sPb1xjdeAN?=
 =?us-ascii?Q?of+4mhJfsy0lq5kPwshCBHotFy0m9z7X+StckXZr8DSzhAHba0DaN0CvBXO9?=
 =?us-ascii?Q?TWfaJCO7eA61/T4x8PkZFMeq9iZyRn+WK7dNYlCRrDX1mNXhd+TU9J6TYVlO?=
 =?us-ascii?Q?BKCklMwZ8vAnAuSwSXKca2/wEu6geyTFCj3a682pZ8L/l13cQLiRbpspcB7M?=
 =?us-ascii?Q?ShxPclFWqVf5Rx2RWIgfOw9xgvqWGSYDt//3Tw8DsaDPjfiLHQOf/F4rbkQ3?=
 =?us-ascii?Q?kz1jc0K0f16zOG+D6bG4W9TVvtCqBZGz8DEpuIJ302i9zPt0rH7lsmxvRNUF?=
 =?us-ascii?Q?Om9lLNeJgp0fFcev1oeUfP1OZO6FN4kxJJ9rUh0ZkD1FjUcnSylxZKLM4Uoa?=
 =?us-ascii?Q?qJBeFyXtPoGAEBhN5iFRftRuD3kyd+OLXmozGTHqu5deEDOzF3V8C61mNk0q?=
 =?us-ascii?Q?wUD/W8qGDroTsBTnInk/qAcFrSknWcm+XJ9dwDCsZO7O9WvGflRNPQa1NYRi?=
 =?us-ascii?Q?cnxINOYvk5+ya70KFOBbsoCKoZcc9VG5hUDBGoUAGeCxlS5ismJaObN9UYDe?=
 =?us-ascii?Q?ys9eeypVdPVuJMMRAhapq3m9DjoVpUa0pIl0Hnw28UtQpE6KEy0CSJWyGf8B?=
 =?us-ascii?Q?EPeTNTyyYmeKYXaQCpqRf7MVL26DWOv6VJnvlelyym4j/2MGrlrtEI3ri6HS?=
 =?us-ascii?Q?klvijRfZHPQFcxg+04dI4EyXOt/a27YZDdJ0kYa7xOq1liwRwVLPptrO4AB+?=
 =?us-ascii?Q?rIJsX8zjNPxpAYy76W3P92KfXN+EsiZWuL3pjtrqqYoivVOIXX9UZzlQ958d?=
 =?us-ascii?Q?dWN9mZvjiE6LYcPa/nasJp0Ya1Abv3VIOP25B7NM3VH56BxM4R1s31aHSGKv?=
 =?us-ascii?Q?pUiRJudSGy1hnLD4GNVpZ+MID8LQOaBZRrcNQuDd9VdPjnGGcoJih7UZnBxk?=
 =?us-ascii?Q?DtHhCD3/4tJXyyuFl8iOoZPtjSUO/9gXzYQlPqVwskHUGz69N/7W2MRN4HyG?=
 =?us-ascii?Q?QNeS8NXLQujxS2XpfqcbPfly4FEdzD0mRCu6EC/+lMCldhuMqnAOwFxeKpt2?=
 =?us-ascii?Q?s7eKpnaNNjS5bdyPa1A9zu9i0vPwBnWFsp70FTRr0XLUw1v4/QaB6UQ8aU3Z?=
 =?us-ascii?Q?O09qoT4ae1D7baVTY+6t89gpCBDnjSkdiaAP5PN1BBDHqIE9Q7rf/ghXnkPR?=
 =?us-ascii?Q?Wbv73OT13sk9bZCX9AJUYsbqCs07ld5CiqmaCXOujg6dA8oXhs2YvUpuM9e7?=
 =?us-ascii?Q?yH1eWNzr32eY+NTYOFwuRw9fVNZx5CKL0eqeJ9191sE/A7Vjyv0sJKhGQ9uE?=
 =?us-ascii?Q?fw7wsfo5DReOUE8m+RjyS/zDrVhjQbkxH8gQHuJ773FL+ctGMYw2JIcjbzqa?=
 =?us-ascii?Q?wT9wqDn7Zsyw04BuBAIc36DDgLPgRAqk8SkvFuFHu2afoqQNEszmqi28JUVb?=
 =?us-ascii?Q?9840VTtd3nRxYTuniYjgdqprgd+Q7Ji4+SY8Ksw7wcmO03fuutZVNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1QLrLFWfjTFW75Udm08JELfFUi+qTkwMSO7H+eQ//atw5KpfGzRilFtiFlo9?=
 =?us-ascii?Q?S+hYzhXP22tHuLta4LkRQ/biVqYFa6L5a9n7Rl6g2FjsceyT0jWK7AkfpDk7?=
 =?us-ascii?Q?7PKG0QqzsGsrjhVoS7OBchMiYDlGi/Ht/b9CBOdws9kTD9mCTRwtyHxUNmus?=
 =?us-ascii?Q?EwRGym7psBeMowVxRRlmG8AFI+DezbJ2WWlAnP99ZmRqf74sYI62LZ+IvrzV?=
 =?us-ascii?Q?Gkt4DDOhGe1NfAjQrNpqJdq3OhKlQMjoZuReiRKDuw0fVIT7GqS/B4f9R31J?=
 =?us-ascii?Q?S2Z6WcpY3bEPCkzCWkPWp0WeXYteFY8Q3KsMT70OtZqL0W37jxS1bQDupFeQ?=
 =?us-ascii?Q?b1RBA2DP0zp/YHvEn73jLFStQzsi5SPcgijmhowZ9o8SHAvtP52JUAa6U/L0?=
 =?us-ascii?Q?qJKJP9had/1gpaIDrJETpaF2WPzqR3N9FDUfUZkoV/Z3kfo0EjqTQpHEMBKG?=
 =?us-ascii?Q?D6ICciXLRNY0cLjknSPdJWgoVN0IrSh4uewVu7qc5lW38xGxOJKwcTo4iP8w?=
 =?us-ascii?Q?iPJjY8H96aUrgBJMT/iUDzxxLsM95vJAcxok39lzVQ9xz/yXIwV9Bx4l2Iei?=
 =?us-ascii?Q?zBW8XrB/EnoWh/2+JpqgftOGrHTBtIWSYbjKXsFpIvhcsDFEopKbU1aN7gW4?=
 =?us-ascii?Q?OUmjTggs4BbxsqsN9YkD9Os8iMQxE8GSdx1P899pEMElqnvjgKjBR99o6Nzw?=
 =?us-ascii?Q?+cuWqjylehOyc15gRnqPJ4B0hbRIt1NQPG4sEGhFyj4E0yojLFc9MR2WjiQm?=
 =?us-ascii?Q?T12HsV9pXtBzZwwmLk1X34ByfmN/VK94WhPCYwVYiBKZoZU9NFgQDElCdMV/?=
 =?us-ascii?Q?qJR0E0NbPvHnA3mw9AJHRJrjPNfcnwj1MzJfQ29oH9vQEYtDz6vTDP3aMrlp?=
 =?us-ascii?Q?hOnEVXhrgLUbRJBFYKpygMeT58Q2W5xPYnexxno07zOAQlFsjjiqEUqprOt9?=
 =?us-ascii?Q?XBj4ixGow4tNAtAPHEpXIauW1XzL8EjqAPkoDQUYWfjZOTDqv2MhBSe1cvBx?=
 =?us-ascii?Q?3srPm7Ff2SGZ6zgIPKwdEAUeZnji56dQ5uHbymeShrhpGTvec/zkdm55lVRL?=
 =?us-ascii?Q?5QkG/vqtgbsntBCWhmOKDrcZKmPVfOMOXuqo1AIEaseNaUKJ0ZyPjuxihT98?=
 =?us-ascii?Q?enZx78gsPOdqO1SLJi8pC0DNk8CEJW0zO0e1/LgQFnj9IDfztpdBdF9CkgyS?=
 =?us-ascii?Q?O+0A8Xq0y5s3JIWdubyW3XlBBepLX/OPUhIY+m8iED4oqJS2ysqb1eUpty5s?=
 =?us-ascii?Q?JP0EudF+M08qVAiThN6d7XKNS4TSn7tkRXvA7jFeTihclAUJgSss46g6ixsm?=
 =?us-ascii?Q?y4wpGdfqrvi/MiHSBqda+bIaxOuym/7kisNlJCGWd3TSys9Gcm19QDNFhYnA?=
 =?us-ascii?Q?fxeP7oQTZu+5MGokDgg38zx77yEaMy3ierecLBfVwWOflQP3QNVm9fNQQKFH?=
 =?us-ascii?Q?QkNt37FGc/F+F1++bq7e6Gn26J1lITstJrLCyF7PIfxzRGofjoGyjDTyXWmp?=
 =?us-ascii?Q?ypmeK02/1vgkMis7SLPALokcIQwX2RguXKtfEj7azt15LH2uCMHDzWcLmpfD?=
 =?us-ascii?Q?U5eNE0WquJqux+MUQtmIYVQsk4uNrt3ar8VAErYn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e92867c-4a7f-44e9-a419-08ddd568274f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 04:09:07.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drKOwECIvlC9S7/b0OMKn4/eGRKCWlbzIWhHNmPI92dZ8uIWa9mQlWm8001j3PTXOcgVcEptePEP7tLC+t2Dpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10520

Hi Andrew,

Thanks for your comments!

On Wed, Aug 06, 2025 at 05:58:18PM +0200, Andrew Lunn wrote:
> On Wed, Aug 06, 2025 at 04:30:17PM +0800, Xu Yang wrote:
> > The kernel will have below dump when system resume if the USB net device
> > was already disconnected during system suspend.
> 
> By disconnected, you mean pulled out?

Yes.

> 
> > It's because usb_resume_interface() will be skipped if the USB core found
> > the USB device was already disconnected. In this case, asix_resume() will
> > not be called anymore. So asix_suspend/resume() can't be balanced. When
> > ax88772_stop() is called, the phy device was already stopped. To avoid
> > calling phylink_stop() a second time, check whether usb net device is
> > already in suspend state.
> > 
> > Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  drivers/net/usb/asix_devices.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> > index 9b0318fb50b5..ac28f5fe7ac2 100644
> > --- a/drivers/net/usb/asix_devices.c
> > +++ b/drivers/net/usb/asix_devices.c
> > @@ -932,7 +932,8 @@ static int ax88772_stop(struct usbnet *dev)
> >  {
> >  	struct asix_common_private *priv = dev->driver_priv;
> >  
> > -	phylink_stop(priv->phylink);
> > +	if (!dev->suspend_count)
> > +		phylink_stop(priv->phylink);
> 
> Looking at ax88172a.c, lan78xx.c and smsc95xx.c, they don't have
> anything like this. Is asix special, or are all the others broken as
> well?

I have limited USB net devices. So I can't test others now.

But based on the error path, only below driver call phy_stop() or phylink_stop()
in their stop() callback:

drivers/net/usb/asix_devices.c
  ax88772_stop()
    phylink_stop()

drivers/net/usb/ax88172a.c
  ax88172a_stop()
    phy_stop()

drivers/net/usb/lan78xx.c
  lan78xx_stop()
    phylink_stop()

drivers/net/usb/smsc95xx.c
  smsc95xx_stop()
    phy_stop()

However, only asix_devices.c and lan78xx.c call phylink_suspend() in suspend()
callback. So I think lan78xx.c has this issue too.

Should I change usbnet common code like below?

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index c39dfa17813a..44a8d325dfb1 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
        pm = usb_autopm_get_interface(dev->intf);
        /* allow minidriver to stop correctly (wireless devices to turn off
         * radio etc) */
-       if (info->stop) {
+       if (info->stop && !dev->suspend_count) {
                retval = info->stop(dev);
                if (retval < 0)
                        netif_info(dev, ifdown, dev->net,

Thanks,
Xu Yang

> 
> 	Andrew

