Return-Path: <netdev+bounces-72472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 268BC85840E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6311BB20A89
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93AA131725;
	Fri, 16 Feb 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehRfIoyK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7924130ACF
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104271; cv=fail; b=i2UQ9YvM8BRD5N96N5kFpAqHXhUD52+qcSLohzzwCe0sCeWs45ISLu/pm4sn0KJkj0D4fSF8SL4PO1CwovaYCYT0JHlKqpfVfbYOVMmDS5K9XlEJqPYQOZnL3QXetBex2EhTKMq53jWo5w++h6Wj29ghO4I1QwZXYs347yOV/m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104271; c=relaxed/simple;
	bh=7gyq+31Da2Q49vuFefWp4ISEIFAv8SXQI4wNEoVzwwI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hlY7mIWUbph4YB1/T6JkB6YzKe6K3La+5voKBYJKGRFy2fLx9us0ldpE+fWgqESK7RuoHbi3kPZuo+Zo+G42Wfsaua1JhF0VeuCG9IwdcZr9A9Agrly80JZJ3nHGFqgqdfCv1MmzTTDOqrgbnBxJW7IAr6XgDOYpInLvB5WLv8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehRfIoyK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708104270; x=1739640270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7gyq+31Da2Q49vuFefWp4ISEIFAv8SXQI4wNEoVzwwI=;
  b=ehRfIoyKm2EKnOt5N7z/+dIo6IIrPeTtdgOdGXj5neqTihSPJhM2yRJu
   2Qhp9s0+jXqHw/KFsqFyILwQ0fS/sxSMsrVljDeFpXf13ZDiUre0uF/Ry
   b/PypJlvwaRiJqGtdHjpjn2cpMam9enGfrikoyXXRhOZqrWLWgutPDTJj
   A4kf5tb1hD3VwNU9p2IHZVTmm71XYX7ckq1MQkDrg5VX/ZcIaUkBDzSm0
   C+ETB4o5EK/gPXn/U2cBssixeCuQVxH7RV3/iUaIfK/Q2MHs9uOIuMrOV
   Vn21upMrB7RytLkiMEUanyDBYHeLU4+QvIj5LPvuDgOuryc4wvLLi8vT/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2094985"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2094985"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:24:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8525734"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 09:24:20 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:24:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 09:24:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 09:24:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn33xch0bXIImksz5tfzea/QyJjILGy27vJc8XmpR/l/ha7vQ/7fIU+HFxxAtGKmyf/JG4Lu4P3zwPV7q5OLwnB9dLHSEwThdIf8yJAf8It0rp1PZErZXvPjKXLi59mU9cafAlPFVlWa9siZ7svfYoFZ3E1PTaySpvSNmsm5k+DGzHL+onrDlcMDwPnMQ4Xhr0FqZCQVlB3DDpsfVgWGM/EKxoD67NfZsRWiPZThQENkJWJnTnEF9Nhmc0jo1UyV7SwI+rzDF7YtotFIQPG71v0X88yV4BMGj4JSjplP9LCHD0IUxF8FUo0TJ5JQ95dAGOF5aSLaQACgPPS9MFVmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lppvc5zf3tQLU5NpqwFE4bmZNJJKVv3b0ycPPUojxZE=;
 b=MM+W7PqpXDyWxsqJP4Y6x1z3mXY73aRi7R5GR1SnMtaUHWrJ04ME+M9skAJRWSStjk8jctQS3n0tJI5c7dJSQaLnq5F455juussqPACAvRN0fAGkP8Gol2l2CUgP9/cu1X+MfEoQe7cxHKgv/B8ALzxZfGUjvRj7dzACpEuU12cf2JBmJ2lrHylwmzDZ4GKDLTnbguPq0EmDERy5mthUFbQL07ZX4JbG86rH+hXzv+5c+NcZ+KVs+knfHfZ8yf6DAzGh9n8OYZg7iRxkyl9nO4lOKyPCrIGQvAQlie/Q/tpnjJYF3u2UseqXdm9ca8+2T4jrrluMeAKg48CZnRnnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7649.namprd11.prod.outlook.com (2603:10b6:8:146::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.39; Fri, 16 Feb 2024 17:24:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 17:24:17 +0000
Date: Fri, 16 Feb 2024 18:24:07 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Pavel Vazharov <pavel@x3me.net>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
Message-ID: <Zc+aN4rYKZKu3vKx@boxer>
References: <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
 <87wmrqzyc9.fsf@toke.dk>
 <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk>
 <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
 <ZcPTNpzGyqQI+DXw@boxer>
 <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
 <CAJEV1igugU1SjcWnjYgoG0x_stExm0MyxwdFN0xycSb9sadkXw@mail.gmail.com>
 <CAJEV1ijnUrJXOuGW5xnuCvMTtaC1VKhOXQ0_4iJnqR5Vco4yLg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJEV1ijnUrJXOuGW5xnuCvMTtaC1VKhOXQ0_4iJnqR5Vco4yLg@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 738cbda7-cd47-47cb-5fad-08dc2f141a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsBSpOItpzr5k5IXEoF62+XC8wA1LdtkDzW6AVsOrujmtSjaDkqXVFaqN63m7aku5ix4mqgUge/QVeGb9HRwaLTpxj5sF5BFemVugTsoVzeT3zYxZCsrTURdK/zUzrI15LO+JKNf50tyWb92fQQzhNAx/eu7EAj46+4jyoGD3U67jIHPaqw3yJ9DjH8Pp3MDQbH24tsHDoYLMS882gf1oVqXtCiudTmGsf1MxUwKKXBZbb1xnhWCqSpTD0HWzXp+xTHpdnTMub5aX85l4U62MR4hK79tgFD8wm42gqHvI3X2hVv7cXylOUgGnbUtQJcqfA+PzkuxJc8CTPUL5yyzezYIeFpU5V+UFiwQ5GkPoesww3Y8gWNPz8mC57nhrmaW8suosPq6qM3GNaD8aiU1m62Xr6RF7WxtfmtDeT2Yr6DDJpZqZ58SMppi7FNr8x7W1/OMU8QDLJVQNkxz39xWAlx9FP7NcK3L3BlVxEvbyLrC83QvEGXM9ltxJdukeQd9wNRd4hGE3gsapOBjid6+4Igoj2MZSLP1rmkBfVGQ41NNxblOx7EJnQBxJM3k1ZEH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(6666004)(6512007)(9686003)(82960400001)(2906002)(38100700002)(86362001)(41300700001)(33716001)(83380400001)(30864003)(6486002)(5660300002)(478600001)(44832011)(8676002)(26005)(54906003)(66556008)(4326008)(8936002)(19627235002)(316002)(66946007)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sdr+rhFmrvqh9yXWTKIBxA9T9FF8Qwb7WiJ04QxpBchB1dC+wZsE9LKGsyIq?=
 =?us-ascii?Q?Y715msTm12aoeK/SzVaFcI6fQQom6wKAnkjf4aU9Qm8noqTSIDS4gf7WrAAd?=
 =?us-ascii?Q?6xjSfM9uhyeMZuUMydVGLR9VRo8ktuB7sJDs2oSO6tn7t2YBznnwD42MJ2IB?=
 =?us-ascii?Q?QKtDalbcW9r2iSXG6X/HP5sPrxpGZpWUW2qoPRSIJVP5kKTJdYq+kQfUWp4r?=
 =?us-ascii?Q?IW2odDLt6yrTcEKNMP7m/SQqh2qZatQxWafCkiF9zpFvg/RZtWNFGWjEG0m+?=
 =?us-ascii?Q?uwkVa2Fmi+rlnnF5utk/eOKMQH5VUxM9B80D/FReV5Y5rO71tBIiViN6CKec?=
 =?us-ascii?Q?zscptKg6DoxU1Kr5OONewGCILPjPeoYmsijN5EgvB87+Ynz41DB4Tcj67XhS?=
 =?us-ascii?Q?vsiOGbLDJM3dvH73PC+DArrMPAr+pAfSWV7ZDOsboIHXbfgdCdQBDOqW59dZ?=
 =?us-ascii?Q?0ePRNLAgCiWZ9ECpqpyUWAZm1O+RKdu0WNO7nguE/AypLRBiUP2vqWu0GZVT?=
 =?us-ascii?Q?VU2H4qjs366Z8qohi0sMjeXAIepBmM+ozf+00ZjCK9EZsBa/l/9UQhzqpiTl?=
 =?us-ascii?Q?CxB1BI9NsLkb8RXvSmQtySGwKRJudtvlzuLfH7BJstqj8URfwDR8Az/qDrRE?=
 =?us-ascii?Q?I/pSYrMepMPH9fmwsCeOrcdVSWkoUtCCxBmtqLtvW64HtdTJ++9weRTKYKQM?=
 =?us-ascii?Q?gMfGWQ1nz8WaRDMfo9ezLv8Sbn4Mj8XN7HxHIOugjG7FXggc7yFXmtLOPjNj?=
 =?us-ascii?Q?OePg/uZN+/EJhCGKTSOehwq/RiPfNJ3Wv2dJMQRxhidlz6Nh8jUslBudEt+K?=
 =?us-ascii?Q?UvoVJdiG13/YnRkuFR9e+8XDdTAFmO0vZv+xCgKK05nE7S26bbikFnupNWyY?=
 =?us-ascii?Q?Ex3YEypv7TXqw38qlPqi9QXCks8kePzcII2d7W10Fw+2XY6PWuHK9qmrkcG9?=
 =?us-ascii?Q?xWyWfPjAimdNSn0XL0g4lhltSI+ULEOGPZG2KEcr3c2gzLEqHM6yQI0zUpkb?=
 =?us-ascii?Q?3cUIUIJlHUoLJoCbEekQlit6/80Tyf9rF/Th0xRzCXzCIfurs5TnDjybeEek?=
 =?us-ascii?Q?p0w4eDF20iMnVpS3mr5gcBCn5Y0AIh4I+fPfkT5xBbD9uW5R1ftpJXtdjvIm?=
 =?us-ascii?Q?wMu6jLYp5ozGXupBTxybtOhwE2pcJOedn6GrRwK4zKzue7M+TwluP+rAzXFm?=
 =?us-ascii?Q?uxdQeH4mYEu3V3GV+LdBRRHUsaqyR9AnU1oYmINEnHYxiQJgZEdkOMYIwzhS?=
 =?us-ascii?Q?qoqAExJNgu0VmzYfqBp9QpbQdgHYaUIvtKDgil4ggrWqzlC8btBZXsZHbOgF?=
 =?us-ascii?Q?eppkEMVT9FN7DBUBiqBUpybswvXuPDZF43qKqD5qmHvTScX/PknYjpean1h7?=
 =?us-ascii?Q?sf9F+Blk3RCf0hD8mpIDo7djBN8WqHW3LZ1fS1vhYtFDhSjI9gc1+0SFxSDx?=
 =?us-ascii?Q?9apu0zLg+5H6SG6HtDMXALTPpgexwzD8uzodMlJGdBaw+STgls7qtiSxTSTv?=
 =?us-ascii?Q?WJLGeVWpIkq1OguK8rcQifJUyUaqD6S1U1mvPjRTwVmAA6uaTkS8VHeuf8Mm?=
 =?us-ascii?Q?N4ZgkIY9WPpibMZT0p5kUDt6rTHq9VNfswuTzF+fDUjjRfdsBcoAznvh41Da?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 738cbda7-cd47-47cb-5fad-08dc2f141a74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 17:24:17.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWEuoQAqELXdqMXHxYWF8Hukg7fj+NzJ3pHbiBpis+GVrruML4XOV8rBU58lChX/dFypx/I9fXGhEofnsHLI5ailixC38OL2hX5Ahm2eb8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7649
X-OriginatorOrg: intel.com

> > > > >
> > > > > Back to the issue.
> > > > > I just want to say again that we are not binding the XDP sockets to
> > > > > the bonding device.
> > > > > We are binding the sockets to the queues of the physical interfaces
> > > > > "below" the bonding device.
> > > > > My further observation this time is that when the issue happens and
> > > > > the remote device reports
> > > > > the LACP error there is no incoming LACP traffic on the corresponding
> > > > > local port,
> > > > > as seen by the xdump.
> > > > > The tcpdump at the same time sees only outgoing LACP packets and
> > > > > nothing incoming.
> > > > > For example:
> > > > > Remote device
> > > > >                           Local Server
> > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/12 <---> eth0
> > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/13 <---> eth2
> > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/14 <---> eth4
> > > > > And when the remote device reports "received an abnormal LACPDU"
> > > > > for PortName=XGigabitEthernet0/0/14 I can see via xdpdump that there
> > > > > is no incoming LACP traffic
> > > >
> > > > Hey Pavel,
> > > >
> > > > can you also look at /proc/interrupts at eth4 and what ethtool -S shows
> > > > there?
> > > I reproduced the problem but this time the interface with the weird
> > > state was eth0.
> > > It's different every time and sometimes even two of the interfaces are
> > > in such a state.
> > > Here are the requested info while being in this state:
> > > ~# ethtool -S eth0 > /tmp/stats0.txt ; sleep 10 ; ethtool -S eth0 >
> > > /tmp/stats1.txt ; diff /tmp/stats0.txt /tmp/stats1.txt
> > > 6c6
> > > <      rx_pkts_nic: 81426
> > > ---
> > > >      rx_pkts_nic: 81436
> > > 8c8
> > > <      rx_bytes_nic: 10286521
> > > ---
> > > >      rx_bytes_nic: 10287801
> > > 17c17
> > > <      multicast: 72216
> > > ---
> > > >      multicast: 72226
> > > 48c48
> > > <      rx_no_dma_resources: 1109
> > > ---
> > > >      rx_no_dma_resources: 1119
> > >
> > > ~# cat /proc/interrupts | grep eth0 > /tmp/interrupts0.txt ; sleep 10
> > > ; cat /proc/interrupts | grep eth0 > /tmp/interrupts1.txt
> > > interrupts0: 430 3098 64 108199 108199 108199 108199 108199 108199
> > > 108199 108201 63 64 1865 108199  61
> > > interrupts1: 435 3103 69 117967 117967  117967 117967 117967  117967
> > > 117967 117969 68 69 1870  117967 66
> > >
> > > So, it seems that packets are coming on the interface but they don't
> > > reach to the XDP layer and deeper.
> > > rx_no_dma_resources - this counter seems to give clues about a possible issue?
> > >
> > > >
> > > > > on eth4 but there is incoming LACP traffic on eth0 and eth2.
> > > > > At the same time, according to the dmesg the kernel sees all of the
> > > > > interfaces as
> > > > > "link status definitely up, 10000 Mbps full duplex".
> > > > > The issue goes aways if I stop the application even without removing
> > > > > the XDP programs
> > > > > from the interfaces - the running xdpdump starts showing the incoming
> > > > > LACP traffic immediately.
> > > > > The issue also goes away if I do "ip link set down eth4 && ip link set up eth4".
> > > >
> > > > and the setup is what when doing the link flap? XDP progs are loaded to
> > > > each of the 3 interfaces of bond?
> > > Yes, the same XDP program is loaded on application startup on each one
> > > of the interfaces which are part of bond0 (eth0, eth2, eth4):
> > > # xdp-loader status
> > > CURRENT XDP PROGRAM STATUS:
> > >
> > > Interface        Prio  Program name      Mode     ID   Tag
> > >   Chain actions
> > > --------------------------------------------------------------------------------------
> > > lo                     <No XDP program loaded!>
> > > eth0                   xdp_dispatcher    native   1320 90f686eb86991928
> > >  =>              50     x3sp_splitter_func          1329
> > > 3b185187f1855c4c  XDP_PASS
> > > eth1                   <No XDP program loaded!>
> > > eth2                   xdp_dispatcher    native   1334 90f686eb86991928
> > >  =>              50     x3sp_splitter_func          1337
> > > 3b185187f1855c4c  XDP_PASS
> > > eth3                   <No XDP program loaded!>
> > > eth4                   xdp_dispatcher    native   1342 90f686eb86991928
> > >  =>              50     x3sp_splitter_func          1345
> > > 3b185187f1855c4c  XDP_PASS
> > > eth5                   <No XDP program loaded!>
> > > eth6                   <No XDP program loaded!>
> > > eth7                   <No XDP program loaded!>
> > > bond0                  <No XDP program loaded!>
> > > Each of these interfaces is setup to have 16 queues i.e. the application,
> > > through the DPDK machinery, opens 3x16 XSK sockets each bound to the
> > > corresponding queue of the corresponding interface.
> > > ~# ethtool -l eth0 # It's same for the other 2 devices
> > > Channel parameters for eth0:
> > > Pre-set maximums:
> > > RX:             n/a
> > > TX:             n/a
> > > Other:          1
> > > Combined:       48
> > > Current hardware settings:
> > > RX:             n/a
> > > TX:             n/a
> > > Other:          1
> > > Combined:       16
> > >
> > > >
> > > > > However, I'm not sure what happens with the bound XDP sockets in this case
> > > > > because I haven't tested further.
> > > >
> > > > can you also try to bind xsk sockets before attaching XDP progs?
> > > I looked into the DPDK code again.
> > > The DPDK framework provides callback hooks like eth_rx_queue_setup
> > > and each "driver" implements it as needed. Each Rx/Tx queue of the device is
> > > set up separately. The af_xdp driver currently does this for each Rx
> > > queue separately:
> > > 1. configures the umem for the queue
> > > 2. loads the XDP program on the corresponding interface, if not already loaded
> > >    (i.e. this happens only once per interface when its first queue is set up).
> > > 3. does xsk_socket__create which as far as I looked also internally binds the
> > > socket to the given queue
> > > 4. places the socket in the XSKS map of the XDP program via bpf_map_update_elem
> > >
> > > So, it seems to me that the change needed will be a bit more involved.
> > > I'm not sure if it'll be possible to hardcode, just for the test, the
> > > program loading and
> > > the placing of all XSK sockets in the map to happen when the setup of the last
> > > "queue" for the given interface is done. I need to think a bit more about this.
> > Changed the code of the DPDK af_xdp "driver" to create and bind all of
> > the XSK sockets
> > to the queues of the corresponding interface and after that, after the
> > initialization of the
> > last XSK socket, I added the logic for the attachment of the XDP
> > program to the interface
> > and the population of the XSK map with the created sockets.
> > The issue was still there but it was kind of harder to reproduce - it
> > happened once for 5
> > starts of the application.
> >
> > >
> > > >
> > > > >
> > > > > It seems to me that something racy happens when the interfaces go down
> > > > > and back up
> > > > > (visible in the dmesg) when the XDP sockets are bound to their queues.
> > > > > I mean, I'm not sure why the interfaces go down and up but setting
> > > > > only the XDP programs
> > > > > on the interfaces doesn't cause this behavior. So, I assume it's
> > > > > caused by the binding of the XDP sockets.
> > > >
> > > > hmm i'm lost here, above you said you got no incoming traffic on eth4 even
> > > > without xsk sockets being bound?
> > > Probably I've phrased something in a wrong way.
> > > The issue is not observed if I load the XDP program on all interfaces
> > > (eth0, eth2, eth4)
> > > with the xdp-loader:
> > > xdp-loader load --mode native <iface> <path-to-the-xdp-program>
> > > It's not observed probably because there are no interface down/up actions.
> > > I also modified the DPDK "driver" to not remove the XDP program on exit and thus
> > > when the application stops only the XSK sockets are closed but the
> > > program remains
> > > loaded at the interfaces. When I stop this version of the application
> > > while running the
> > > xdpdump at the same time I see that the traffic immediately appears in
> > > the xdpdump.
> > > Also, note that I basically trimmed the XDP program to simply contain
> > > the XSK map
> > > (BPF_MAP_TYPE_XSKMAP) and the function just does "return XDP_PASS;".
> > > I wanted to exclude every possibility for the XDP program to do something wrong.
> > > So, from the above it seems to me that the issue is triggered somehow by the XSK
> > > sockets usage.
> > >
> > > >
> > > > > It could be that the issue is not related to the XDP sockets but just
> > > > > to the down/up actions of the interfaces.
> > > > > On the other hand, I'm not sure why the issue is easily reproducible
> > > > > when the zero copy mode is enabled
> > > > > (4 out of 5 tests reproduced the issue).
> > > > > However, when the zero copy is disabled this issue doesn't happen
> > > > > (I tried 10 times in a row and it doesn't happen).
> > > >
> > > > any chances that you could rule out the bond of the picture of this issue?
> > > I'll need to talk to the network support guys because they manage the network
> > > devices and they'll need to change the LACP/Trunk setup of the above
> > > "remote device".
> > > I can't promise that they'll agree though.
> We changed the setup and I did the tests with a single port, no
> bonding involved.
> The port was configured with 16 queues (and 16 XSK sockets bound to them).
> I tested with about 100 Mbps of traffic to not break lots of users.
> During the tests I observed the traffic on the real time graph on the
> remote device port
> connected to the server machine where the application was running in
> L3 forward mode:
> - with zero copy enabled the traffic to the server was about 100 Mbps
> but the traffic
> coming out of the server was about 50 Mbps (i.e. half of it).
> - with no zero copy the traffic in both directions was the same - the
> two graphs matched perfectly
> Nothing else was changed during the both tests, only the ZC option.
> Can I check some stats or something else for this testing scenario
> which could be
> used to reveal more info about the issue?

FWIW I don't see this on my side. My guess would be that some of the
queues stalled on ZC due to buggy enable/disable ring pair routines that I
am (fingers crossed :)) fixing, or trying to fix in previous email. You
could try something as simple as:

$ watch -n 1 "ethtool -S eth_ixgbe | grep rx | grep bytes"

and verify each of the queues that are supposed to receive traffic. Do the
same thing with tx, similarly. 

> 
> > >

