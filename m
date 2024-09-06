Return-Path: <netdev+bounces-125872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6096F0AE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B03284657
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE321C8FAE;
	Fri,  6 Sep 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mv4tGFhm"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321713CFB6;
	Fri,  6 Sep 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616669; cv=fail; b=lSM0tC7K/m3uAxTL3CG4VmlwCzuQ44Ll2orcWvOc/fF+J9uamdGLk9AmL9ihBKuLZND+XTxy7knPaCewuVVOIM5zHoGEJMiGm/BpR9U1WM9hSUGFjpxfLXt+TjaJt6k1h03/kUwnZ93M9GpkpEc7RHoZFr4ZslgAYRWiqOwlkuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616669; c=relaxed/simple;
	bh=OkR1adp2NEzczvFdXagMwE1+8PluH2KiXO5nbxAN/N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DDqpnHiC2Fh7kFFB8sqnjZHUggrkhL7qtIQiLjPUhAy40nqEoQ2zXSYMl5FM0ASw3ZJstgjS30kPZiJ/VO722cnYq115Qz9J38qIyIunx/LLvGxCvSAoQvK0TJvmTmmFrB1SG/ekvZoRK3IUDN62U03CoVKuBtJ1QHq7dupcarA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mv4tGFhm; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmABKdx1Sr59oLAIPH4QSp4oUfAt8RlDNMS6ICpRrUayiGXJ95kzZLIYDLB/7IUb8q3JH5CFK3chsybkgstX1AdZoUledaeFmr9KA6ge/hBBIrJYsEs7OpT5qRW+uGl3lXQw450ehkcDLy6KDnTsSbhFL4VkzEkWCSY3XWXqbuTqKh9ex5k0dIctjlnyen1W9UZI4XGsFMloNWIv787QIkdg3+HtlUJMV2CXKqbTdA8bA0ZLiLlWzhKoOip5K9li55qygi88cpaOJU7LWL24B2vFlKvJZlkvdlR5Dq09/pxoY+R7J+N3ecK2ZmsHrzWs1buP+lQVGzJlXRehwZIltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twY60t+tLWokzm/LNQH+qRDjazQlTNtEsiDCkT7B+KU=;
 b=dYEaeQ1rRvGqdhp8Dds9LwPDidLaW/TehVJstLuMsC+LfwgbQuHXxcWbY4MEdo3VqmMH28UM6RXl2rK8uAM2aL4w+FiDd2jzfhr3xVTISN1pEDtGeKWysBzEP8oJqATGDRGdV252uKuxsSUtXzdVmtm7CbWmAd7u7SGxxZ0Ibhf3U3kjlkWKHdd1l2ATyNauKNi4Jr7vDxhuhcerLBQxZEKc3KelsIbrEwc0xduLHXXBM4A2gtDYPB2BWygPwjeKWrHoeQUu2I1RLPrOuhLx58941vweNo+hKvJSw4m25HO9qXJcRNNUizeo4GYIK3hjFc7hLREwThO0cki2Mqyz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twY60t+tLWokzm/LNQH+qRDjazQlTNtEsiDCkT7B+KU=;
 b=mv4tGFhmsa/Avrwbyfyyzxl7Arv3ImzA93jxzUo5cCnCWtdeIJnfPnL7t/cN/2tzdbNgERop25uaPU7zO6oHJQgkoSKr2bwEBKjpdtR29dQ7lq4Z+tj3giaN8Z8huXId5u8MnNAjjFRMlMIlpXniMt01sPCJmyNHNpm+mHnIlr9W5WXTXprWHdlOL7akJDsFwI1Y1mZnAk9uakotG76YKzHgeBCX3z0K7mxnrBofRtMPgQ1MXLG1lZLHfbUscKAjyCtmWjrevU6pVzY4A4+4Uy7qIutyTaGL037VTgJfodKE795ySZ0kXDRXdVsZ09sQH9kEofG9LRcTE+fZQcrnsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16)
 by AM0PR04MB6995.eurprd04.prod.outlook.com (2603:10a6:208:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 09:57:43 +0000
Received: from PAXPR04MB8877.eurprd04.prod.outlook.com
 ([fe80::b7b0:9ee7:cd10:5ab8]) by PAXPR04MB8877.eurprd04.prod.outlook.com
 ([fe80::b7b0:9ee7:cd10:5ab8%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 09:57:43 +0000
Date: Fri, 6 Sep 2024 12:57:39 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: junjie.wan@inceptio.ai
Cc: "'David S. Miller'" <davem@davemloft.net>, 
	'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>, 
	'Paolo Abeni' <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dpaa2-switch: fix flooding domain among multiple vlans
Message-ID: <wtdu5gfrg3drgobwejrpv3gyl4x2wnnskzjavynlcmjawtcmio@kfrz7anzohmm>
References: <20240902015051.11159-1-junjie.wan@inceptio.ai>
 <kywc7aqhfrk6rdgop73koeoi5hnufgjabluoa5lv4znla3o32p@uwl6vmnigbfk>
 <000201daff5b$101e77f0$305b67d0$@inceptio.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201daff5b$101e77f0$305b67d0$@inceptio.ai>
X-ClientProxiedBy: AM0PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:208:55::33) To PAXPR04MB8877.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8877:EE_|AM0PR04MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de1ba85-4c8c-4444-cf76-08dcce5a5944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PP5sGxktxDWug3H9XeOde3a/o0vip1wrjaM8JF2RHswwM1gBBd05OwQYafA4?=
 =?us-ascii?Q?A2G8nMpaCg08AIFkQEr9z6ChOvPr0iu92fGx5lgEj9btfrEYzuTz4I6mZqet?=
 =?us-ascii?Q?tEOs3Y5ECDN1NrlTMotJUVKCjbM3Bcb16tDxLOjrx8XRUfUvUejhkaoHDbyl?=
 =?us-ascii?Q?XAXpRgsuncRxfY8y7UFbHKxDTRcIcnYNGOSfL2AYQsyAaMyDnKJQCTrhpi1M?=
 =?us-ascii?Q?RWLdn4JSgHUaLHdTmr+286WcJFkEn6tV0FU7rWpDs4ZCzo5MNSLlPL9lzeZi?=
 =?us-ascii?Q?O257NKhubpo11bRzxThR5+rsHQXpZWcQN/bUdUUHLQZ2YidK7y9HsS91shHK?=
 =?us-ascii?Q?Mgw3DBB8G01wHiFnJdp2EFdrcMVuetPTwcMo01j/2dI3mhdUpIIWv7BgysSE?=
 =?us-ascii?Q?Ez76KU1DVlTIKVKSQcrwjFPlEDKs4LYOVyAhvTAhVc2ZVTzoSGJekC32X2Z5?=
 =?us-ascii?Q?+/w7fVQZAt0kIYjvSVZlOKhrmWAauquZ9FrMXoG6jjByOo8xOxUP9nfeXNMs?=
 =?us-ascii?Q?1aGZldE3rN0F2vGJSSu3dX0KvKUoKKli1O3LYHrIk8IKSrNMLRC8IPMg2HFa?=
 =?us-ascii?Q?ijfFmiSJruOFzrTqrPCBj7auzxJGk1+u4lq8/8roqBcJuEPteqo0H1B8uLpL?=
 =?us-ascii?Q?b8Cjz9SqoMUpJTCF6veoCP1UfPSDhOcXgwPwaxTqe60TqyorRKavZfw//mft?=
 =?us-ascii?Q?CLmoS+IfAbaPmY47kg5RNUt1tj0/5Uxr9gjQ5P/6dCOwrnQgVmTXi4RIyZxA?=
 =?us-ascii?Q?D05L0CQ2JoV9SKQpRK75l3kLmrIWRAByNhdcCDZMduRPc4DkC6WFXrcax3tj?=
 =?us-ascii?Q?ryD1MI3RzDZ6FPX4EP6nZe53HygE3JQTKqvuWW7lM+2vNA4Ud9F0IsTbPR1r?=
 =?us-ascii?Q?qXh26pL38tgllPfC0f0XH21uK18uynkuftYld7QumZAJ7sIJmjKJxdbggjAn?=
 =?us-ascii?Q?TshP+d8OLjXPHppPyESL47pCrDJFCq2iZT5snN35BucMoY77eanwt1+LICyM?=
 =?us-ascii?Q?Z1JihJfW9yEjSV08qgNLDQalj2MgP+DNyRuuAfQRLq67LJ6AoZfmiEBjG1fp?=
 =?us-ascii?Q?Cf9ke8tG4itlfwgsJeGzZjBUZ9AUFhijzWiQaPR9hDlW2mmfbqu/acbba8d2?=
 =?us-ascii?Q?rGre7g1ZHd5x+WvGqSnLLechhiZAuFWwoflhruO2i81vt0XUfTtAg+PcdvNR?=
 =?us-ascii?Q?dTg5bTKi0BeqgsGZ35baNV7R2c/qiXfh8FubuvHJ1/jzcG/NMwjmRd/BhQsE?=
 =?us-ascii?Q?7vShskdJIBgt01PcU2oGAVSM4DhCK0pkpaACPkDsUIWXQQ/HyOT9ETl7MQmO?=
 =?us-ascii?Q?h/3e1SHCv7po/OCcRVdu0BlY0FEGbiCSWE1873BKG+mv+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8877.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIAT53fb1nIJ0j8ny+CIfVzaVkcAFd0vhz6Z5zUV5wq3E4I3gP7EZb8KzLJh?=
 =?us-ascii?Q?EwaH+ZH98QrDTnui4o94YU+zjqUzN9uIrahoHN4fG5tSDuUfKLgq115xlUrJ?=
 =?us-ascii?Q?UVGeV+NsActf6z1jIcDX+BSRGph9SmTgme9Qr98i9YFqyLP+yysrGG/w/XUm?=
 =?us-ascii?Q?5JqRltkXvWsaXSr3qwUi0nIbjE8vKfBCTxH5tTPWY99wItWXgmh+MBa+3GJU?=
 =?us-ascii?Q?P63WNqufgpf+8zA2UU7CMcZ2ZHYl89FvvL43n6ELsmjBDHdr+3rHoA2rHpkG?=
 =?us-ascii?Q?O+x1xGd31+cmssDdJetSPh+boyD9qll5tZnFvzkVz0mqKLohBaSMehqggcBp?=
 =?us-ascii?Q?FDflpK1JqOt/NtDFYSWU9p50/LR11GlVsByq1T7Z6SCgILtIeobzGZkkcbOr?=
 =?us-ascii?Q?QepnA3GeCop8R6FvqTbj8Am4GyaYavEKmdcPEtKVOnAt9pR6/arMgHDbplo8?=
 =?us-ascii?Q?AjN6PEjrPSEmtmtCsuHh2+F1ep3gMfU9bNC1NR+TGcY5+oaEtLDUj1Pv4nWH?=
 =?us-ascii?Q?s7joHyh35v5dHCE7ZS7Kyk03tempqnzY0liEgPQ+6RapQnqcoeEyTsOOXTqX?=
 =?us-ascii?Q?0EtBvdsK67BdL4lRsxh0d7pBWs7nk5LFV3EUOcKqR/xf7vXh3Eu05lLiGpiy?=
 =?us-ascii?Q?pXb314NV5Gat+K4T+OYp2QpYQ3Sn6M8evPvQStKuZMoFUa0z6NWrzpXKneck?=
 =?us-ascii?Q?i9/v91WxVz4A2oHZeuBM1nyoKvWlFfL3SCg0wnEj+rVuMihbiOXKskLAxQWf?=
 =?us-ascii?Q?YfcjDuu2MpX0gDUXKgoxkp1dx9E20u6TV+jDdmXunfekFH71BeC9qerRQyBW?=
 =?us-ascii?Q?srBji5ggMdifSFe5DTzLPi8y3MYkN+4XS9s4iwIQdWtDY4r8sXyHI/foya5e?=
 =?us-ascii?Q?Q0BnAGnh0YzarXDXc99V+5toqMNt2P0Y+qIhTZPD8YM3PtKS0jTPcNS30ayN?=
 =?us-ascii?Q?OS335cJewhUJTYLLVuuPcCIgJLGYBiZ6paIa9gm7vEA5X7sN+jP+6dcFUV1N?=
 =?us-ascii?Q?fH9vcX8FhBm7/DN9b/7x/7Tzjz4eyGyL3NracTo93IvOqkbdIZbBGbi1FKV1?=
 =?us-ascii?Q?okLHwwlIgDl11vOQXVqrrKB3kemoNAz1Ehp372Ptf5B/mr9Zxx6A8ovPI2q2?=
 =?us-ascii?Q?XOGLLPzD8psB3zM9PWuWF3DBQ6egjUiNHF0Fd5YnM142zww9yiUFaLSpDwdh?=
 =?us-ascii?Q?s0TTHXltlI5v7iFamNcS+SHmc261ElBMuihirDF+WSwYNwiW7ePVS7clkJmf?=
 =?us-ascii?Q?gIwIDVOFdQgUx2ZnrNPwmnasdmtYZ/BQqFTuIW2/cduUaeGRuQqnA5EKxbx+?=
 =?us-ascii?Q?9nHLlPgtqYe6oJTgjgSLfdhNT4w+oy8Y3elq3ntd8pmnVdBJtzbLxNZzMWwI?=
 =?us-ascii?Q?yULO8+2YbdTIpzgH9t8jA2Ja66hK+jQemD6FNJC4qnsL5pD9YMMvTUQ03NYu?=
 =?us-ascii?Q?2pGtCopH8aoaFMXRoACRWdKK7u1rf5/Q7jR5niQCEbCCIuLuoTtaj1nP8ij7?=
 =?us-ascii?Q?L5Kj/U/HR+zcP5K18DhDMYs3H3skjsGdiA4l2M1SR45Ypyoi8vK2jguGlj1F?=
 =?us-ascii?Q?fTVjgbDLyRpre5ONZRLdvw6YBiTjvuTb9X4caszc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de1ba85-4c8c-4444-cf76-08dcce5a5944
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8877.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:57:43.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QehErAxkCuMxu531+qskaibqHOjW5yQc1EF+8znyFiQt3KBcvE3L6zrVDJmD1xivHgK8KIqp3QHl8Kmewzm8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6995

On Thu, Sep 05, 2024 at 02:15:53PM +0800, junjie.wan@inceptio.ai wrote:
> Hi Ioana,
> 

(...)
> 
> I want to check one thing first with you. For dpsw, a 'standalone' interface is not usable, right?
> It is just in a state 'standalone' and needs more configurations before we use it for forwarding.
> If this is the case, can we just assign all standalone interfaces to a single FDB. Or even no FDB
> before they join a bridge. And if there are no VLANs assigned to any port, bridge should
> create a shared FDB for them.  So num of FDB is associated with VLAN rather than interfaces.
> 

When a DPSW interface in not under a bridge it behaves just as a regular
network interface, no forwarding. This is the default behavior for any
switch interface in Linux which is not under a bridge, it's not just the
dpaa2-switch driver which does it.

We cannot use the same FDB for all switch interfaces which are
'standalone' since this would basically mean that they can do forwarding
between them, which is exactly what we do not want.

> >
> > Maybe the changes around the FDB dump could be in a different patch?
> >
> > Ioana
> 
> Sure, Let me split it. But I'm going to have a two-week vacation from tomorrow. 
> During this period, I can't work on the patch. You will have to wait a bit long before I return
> back to the office. Or if you like, please send a new patch for this as you wish. 
> 

Not a problem. Have a great time in your vacation. We can continue when
you get back. Also, please feel free to contact me directly so that we
can sync and maybe test any potential patches before actually submitting
them.

Regards,
Ioana

