Return-Path: <netdev+bounces-220292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E00B45497
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14001CC05B3
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80892E2822;
	Fri,  5 Sep 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RupOLh1+"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C82E0B64;
	Fri,  5 Sep 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067872; cv=fail; b=HnrCl2D2PFpSsv9t9ZfG9T7b2wMXYCs5zTR9HRqrLz5hsrCttQqdAC6FdJqESCQrQJmr16QFTm8ZuE6TS8DBSgv5EeyMIvaFjBxUjTA8JIg11ya0eE5ph0R1PkLI2PyRZ9mZP2NxmKNl2psdf43J8gTmYUX+D4yQqZZ+NcUo93w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067872; c=relaxed/simple;
	bh=NjoPdB4vAmDL2gXzGVdwThij+7HKsiIuEjxgasUIZKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uEnpo6k4x9yQ9C/aREFSbSGm3YxedAXfQ8OdSgLIG++lZeBDWJU6affKsuO2k9URRKBnct8+oeMVl57GuPp1K3TJZscg0mSekehz7Vr9hMXK4Zg+FHd4gIdr98CQjWoqX1KXG16ybxuPi+JKA4+exFPLzrcNigbcP3RMdUnM6e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RupOLh1+; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9frZG1406OU0E0LD9CNLy9h8dFmh4ZiRG1MSBlk2Dtr1TPJVAWp9qXGxZ8M3L8KPN3HnmdKMokPyb3way3sgRYSmqgYj9GPyPwBrbWgbcw9MXjyq3Y6aMCbSwAwtydW16rTdlYBehoCbeAoCUl0eTM+qtoLXC8x07Tj6DkCBd0wytEcTL8YfzOfKu+6RRRYWRmVryZDs+89jswxUE44Avo85ZMkjQdEqzBiKsx4UpMhsPaqJm8mwgYfX3pz64gG1wztfxnxluIawnESRMaQESizjaubmfWRhHdDPwQl/TXXjfWrQF9FWFOuAmq3nQ8MgFunXh/m0uoKvCn4vbpQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZiJVmtITuuZDOSLChl9CfR/+sdsRiEqTlIoxgdGu6g=;
 b=Gvy4fIAMCpbw1UGujcalKo6Viw5mCpBzxEKVA811ZxjTJ8z8ceEVKtA+TglLRrhkXC2H/SEgS6vHKGhCLFzSlxDteS3VuKOOiM/ujfhyQbQ2juOd0Ueo5aUAN3zgbrm2wzWVElReX8jOb7KnK1sHw9wKdrOYIaNR1/lmVeTDgekN9lxoUtPRC0zEEfYrC96uxbFq5LtQw0WYKQzAEJkGmOi+o+acgv0OYEOsx5TG4ybkr8YTYArw6SUvjdsgCSEB8VkU7huDFrB7kQHYY/UIhL/rrbcJsloM+NJJAKtE8efq7qVp6ZrvcKU5r14txnUNAygt0b+AcJ0TNzsn0cLtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZiJVmtITuuZDOSLChl9CfR/+sdsRiEqTlIoxgdGu6g=;
 b=RupOLh1+LRGGd/D16KyWDfdx+bsX2ofoyeWj1cSca/iDQMLLiJSnWIdztkdhgLfvyUkIbP7hLQLxd1AGbuxac7S1NNwiCgYHMVNgC2uM15NIULNgng0DYKo1umbtqRZtvHbneAYBlb0MAkngR3ARI6Bd+CCFG23eKUaWNXELv/QMDHiQwWymcoZz2lFInfcy8APKvHMiJMXHWmjKrTawk8ti+1uzn2E3jfcjWtG0KBGQ8Gm8aOgccVQ5Jn0SHdAiPpOaXqjnpZdSTAzVsWWJW6qeoYFnFifNyLyiansSMhNAYWlfw9Y5fykBhiFupOiYQmbrwHOgrlCFPL41B94+kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by GV2PR04MB11688.eurprd04.prod.outlook.com (2603:10a6:150:2ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 10:24:26 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%3]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 10:24:26 +0000
Date: Fri, 5 Sep 2025 18:18:34 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: usbnet: skip info->stop() callback if suspend_count
 is not 0
Message-ID: <zmxxhhtk7uqpchkwtzshq4quxts22l7a3vgijgvxk4ip7jf3pt@a4u4f45ka5x3>
References: <20250818075722.2575543-1-xu.yang_2@nxp.com>
 <663e2978-8e89-4af4-bc1f-ebbcb2c57b1c@suse.com>
 <ajje6wfqyyqocpx2nm6nmw3quubmg5l3zhuxv7ds2444hykgy5@xbi7uttxghv2>
 <ttbjrqjhnwlwlhvsmmwdtzcvpfogxvyih2fovw7nl5bk7hfqkv@4cfkfuuj6vwr>
 <4bca61b8-71a0-4a8b-b02a-a8e6f5a620de@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bca61b8-71a0-4a8b-b02a-a8e6f5a620de@suse.com>
X-ClientProxiedBy: AM0PR04CA0039.eurprd04.prod.outlook.com
 (2603:10a6:208:1::16) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|GV2PR04MB11688:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a1dcbb-48fa-4f20-7e28-08ddec66637d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N0O0bUDKncTMo6kogvQcSol2flu4toY3JocPGcLLBfEcJkIbebRQpSu5GIwX?=
 =?us-ascii?Q?mDbLYru+iCLYvrj6oUT6Vek1+LMj7B0NO1ICeYrtlXOYct92IfFBiUUmDPNc?=
 =?us-ascii?Q?f98taZUp0o4aUeCex74wJf93wLJrNimuyVQp36l1oDCEZkxri4e8rijfkuSe?=
 =?us-ascii?Q?LiLO8ky42q96WoKA/duQNE7F0ab7YOvy19GumbOj+RLgOLl2dJQBiwEGYUrE?=
 =?us-ascii?Q?EzPZ3MTqP4hNgbEUazqwv9apnaqRpT5iJcaKrQlnkREbqtlMfpdudNBvSDky?=
 =?us-ascii?Q?xmoZZRRc9wp+XSPlTfZcUl/rEqKbe/mncel+koy1/HJbAjCKKTTy+La7nvGE?=
 =?us-ascii?Q?Zef3/0y+t61okm9AojekV2pP2p7PHpM4xW+pUjP0gYlMqfW1Fdvmv4T8gJCE?=
 =?us-ascii?Q?DIPe1JUaLiCxfzVMCz/TW9LLo5KDOy15+bJ9qPKQSGUN+hmMEWW1Gkut7tAa?=
 =?us-ascii?Q?3+w5VhGksVzkJLwKMBo9SoGpuGkY/qRdXYZfvhQrfYv+y3Vylut6izunXcFQ?=
 =?us-ascii?Q?jJqbh/kTifcJgjp+ELwya/Dt8pKWxdrvpOuLqEc6VKix5j0ZmVJzcXBDRNWx?=
 =?us-ascii?Q?b/BaFPD9A/BTPWZ+mNNQgE8wAlh66X3WvENimg2QDBSK8odbazgjMbwPx/GD?=
 =?us-ascii?Q?R+sK7fynjpbYUTmlD9TkLMOP3OhI8ZeWDNaTwztTuvJdA71TjdDggYKP5R/Q?=
 =?us-ascii?Q?iUMZXi/LEirqHOPfYxxQT/xNKaHv2kWNGyChvO5aNtODiWeKw9kirxU7fJ2n?=
 =?us-ascii?Q?lXmnCz5Z+aw8gpa4biezRD2GVAGOibzjxMbrtNzA/911EubXwGvrb0bMV3k/?=
 =?us-ascii?Q?sv1sAs16HHl+oqXdcw5Lp4xz2Ux931I1ym8KrVW/C1un4dw9dmcAxp81XqYK?=
 =?us-ascii?Q?OMW2RXfGAPkGRJoS1H2YGem/RlGloJawhvb1JYma0ejS7w+d4DbqEukVosDi?=
 =?us-ascii?Q?tV7tWkKXBVGHjms9P3zgXajM4o+XBW1Vf4g+tVltD0vHttIp+3BuXScNVwoV?=
 =?us-ascii?Q?VEWUlCeydKiYGJQ9egR5E+cU1v06B5txDSVpLKxT3eEZpt6m1HePNLyPyniY?=
 =?us-ascii?Q?HbzlMa0AQSEQpvhp4tp9YqCtKD4Sqj98ZH0Rd6LB40JoCfJFT6pNNFt098IR?=
 =?us-ascii?Q?I1dL4daN9Efz3R56uzXtiwRHQbTmv9nt0MencakxgfLcp2gVhMQvNBg00kJJ?=
 =?us-ascii?Q?b6lcB8mZVzEgROWcob/zCeDHlizLNvF6BIgfym7qFlBdUpTvO1Rbh1NvutpW?=
 =?us-ascii?Q?UokzE6pDHiqWgS2hC495nWLzwRsI+xzInha1hZNCJItcbK+XVBEF/VyqoUlL?=
 =?us-ascii?Q?2DmoXHjwPTf9gHFJ7OB8TfsTVsUQIUrZjtu89JB8JjSJlYYfBwmvjs0pk0Ee?=
 =?us-ascii?Q?eYS/QvAENSBNvUXyN0+BC3otvFcUnDXWKvggGMXKNC5UTQmVmTcr1LtYMIHQ?=
 =?us-ascii?Q?aeKomBQWuMkrb/jnK9JaV868l+ItwoDVnYRqdj//UxJtTicLZwkJfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQs7oJgQeXkLoq5kBSB+2cJxZdk1Gj4L4iQSEfQIU6uubJB82857fCIBnWbw?=
 =?us-ascii?Q?FBDkK75rvKF/rPo3zMOFeWLL0hz8U6bj6+oW+9e0ajnAdhhDFkUpVU23U6fx?=
 =?us-ascii?Q?BFBUuP5wClr9FLtORNijCU4EixZgbS1s/pSkmqV2AtgwwF2aD5Coa3T0R6LC?=
 =?us-ascii?Q?5619JhR+WxSz3m0J6AUGEk4/irmRYeVqwGxr+b09HohUuG9Zl1AMU3xBH2Im?=
 =?us-ascii?Q?3ay7MeuxREE491lcGa3rvFquykgmaF8IxKa7WYObAuI3jmq61qNWS+zUCPgH?=
 =?us-ascii?Q?Rea2z6xqKGYKC+Njk15O7QEOAVkU4bqeKm5tWcJgL8Uo342U4gR04gZnckW9?=
 =?us-ascii?Q?ALCyd1L68p7ubkqvbnjNTyuDKSQ3QascB96ODSHuqbcBv1xSa/07RFyElLF5?=
 =?us-ascii?Q?aWkXQqEX/liFvl38z+Wf2eeDAJmFcKCgljminyebNbjt/MyHNdWW/VMtMgad?=
 =?us-ascii?Q?SrgbYnJoOyj9+jqeq5hnRI5SE9yDiKvzfodTn6wKZ8lzoqmqaXqmAKIhJk5X?=
 =?us-ascii?Q?G4AQOuuR/OvNIx1X+pgPVy2Ty+7YcTBZ8JgAoyHh4wNzv0qiirLlHGcCeBua?=
 =?us-ascii?Q?KKxl12gjb3pZXaCYD/bkxk4UIUPUpjCbDe6gXlbLcrAcm+7PNaODZHbTtXAA?=
 =?us-ascii?Q?7XPVoUF3LXzPPfNW5UYQ6s91M3nzsi+9PA6M7cb13SzDvXfVKEwm6Hi3HJ02?=
 =?us-ascii?Q?b3GmCSER/Lnd/Fdll9gV2teVvcvilqUP0F6O116Ccyb2PCxEFyEvAwXJ+m22?=
 =?us-ascii?Q?qGjc5B+kFNQhwSBenxQNW1l8hif0/8yZfLCQSXYxl5Ko0BQj5dzrdDqMlPBD?=
 =?us-ascii?Q?78cT6Q/uiRDcZRrVkVgcL9Kut8gqXUzxAM5mkwh4iZvqCH7a1Bn0kK+X/g1B?=
 =?us-ascii?Q?Q+bPspxaHuHiwRFiST0DjF6k93JN3YpjTFSGygp6LGk5sGgNcah1Ezja9qAF?=
 =?us-ascii?Q?vwu+PUELW2uHye84QltfFP08rHHV/H55jlIo7a5Vzw8GmkMV6g/BCbajx8zD?=
 =?us-ascii?Q?3rssUZXkXyfcFdA7WCk76L5DghNyYJ8UvCmrvmFGVk0Q/sIhYqsM+ZriJ1OQ?=
 =?us-ascii?Q?zkS8jYkjxtXUXEprIXgbzmIwtYXUtUpCNmlQ6md9VOtMajNC362xMiuNfR2O?=
 =?us-ascii?Q?eZ2uXtD8np4Xw46v5umwdtkQ0438rMAG21VKogZ3iJwxPcQVdraRfTvrv4Fe?=
 =?us-ascii?Q?SUlQCUCVDerY1KO6GiCKfHc7R+p8OO/Ye+50oyN8KtAIsDPpkpuLeHCwer9K?=
 =?us-ascii?Q?94WXNhjdmVswAZBtljovj9Wxlcmqj9x2RuJADPC712THKdCh89bx/VO/G4xx?=
 =?us-ascii?Q?9yIKmyzQVGgWTFgEQIXfEBGoD90GHNvvhph6yWk0oJ6ZZX9QWn2njI5UeDjw?=
 =?us-ascii?Q?dF1Ip/t76bgsYRnMcgWDMGvvF8I9zE9D2P9wgrIcRtR/EXqb8y93AMa/b6qr?=
 =?us-ascii?Q?GQ5zdHQCfjhWt4HJjg0Vyn4lBolTy/DBQER0so3u+1nG6cu1WaZFHOXOxgmf?=
 =?us-ascii?Q?gSkLfAplA/KaO4iHs9SzLZvyfxX0dfieVoTHdyqkk2vqhfYo2c8xof3W3B9U?=
 =?us-ascii?Q?TLJulKQ8x06hEVlD10vExXAeabD4piuX90du6Tx4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1dcbb-48fa-4f20-7e28-08ddec66637d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 10:24:26.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxp+zMNC5hF5eA4H8JQ98Yi7e2HhhZl/XIgOEt2zA7d7V1z64zONmk3TkMyIRM9nwoakvlqJGE3B9yNb0lscaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11688

On Thu, Sep 04, 2025 at 09:52:03AM +0200, Oliver Neukum wrote:
> 
> 
> On 9/4/25 09:26, Xu Yang wrote:
> > > >    	/* allow minidriver to stop correctly (wireless devices to turn off
> > > >    	 * radio etc) */
> > > > -	if (info->stop) {
> > > > +	if (info->stop && !dev->suspend_count) {
> > > ... for !dev->suspend_count to be false
> > The suspend_count won't go to 0 because there is no chance to call
> > usbnet_resume() if the USB device is physically disconnected from the
> > USB port during system suspend.
> 
> Sorry for the delay.
> 
> While you are correct that a physical disconnect
> will make the PM call fail, you cannot assume that
> a physical disconnect is the only reason disconnect()
> would be called.
> It would also be called if
> 
> - the module is unloaded
> - usbfs is used to disconnect the driver from the device

I understand your concern, however, it seems that only disconnect during
the PM operations then the suspend_count will be non-zero.

> 
> Hence it seems to me that using suspend_count is false.
> You need to use the return of the PM operation.

And a non-zero suspend_count itself is also a PM operation result, isn't it?

Besides, the another way we can determine whether the device has been
unattached, like following:

@@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
        pm = usb_autopm_get_interface(dev->intf);
        /* allow minidriver to stop correctly (wireless devices to turn off
         * radio etc) */
-       if (info->stop) {
+       if (info->stop && dev->udev->state != USB_STATE_NOTATTACHED) {
                retval = info->stop(dev);
                if (retval < 0)
                        netif_info(dev, ifdown, dev->net,

So if it's already in NOTATTACHED state, no needs to stop the device too.

Do you prefer this way?

Thanks,
Xu Yang

> 
> 	Regards
> 		Oliver
> 
> 

