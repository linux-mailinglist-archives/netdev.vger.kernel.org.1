Return-Path: <netdev+bounces-100734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBCE8FBC50
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300A31F2319F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7E914AD2B;
	Tue,  4 Jun 2024 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dEkiBsQm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3513DB9F
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528307; cv=fail; b=DfVf1rFZANjzR1zquudrRX6t7Zw1n7SwRWD5gFMuJ/0eHOAHI/FD8XQrVNgfT1Rfw/r1USLo3b8/6eivQIOoDONylMRbI7LKbO+PN1XmCtGyLWYML+gQRiJ+Hfj1yvOMy/npK0Fmo0yEoCq8EK8YTaZWgOkSL6wrP3bFZ711hUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528307; c=relaxed/simple;
	bh=YNFFKtj8rN8Fj/08q8Cg3Bahq2Rr7e9/GaYXXvs+oBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nuMXndNWA8+LHg2YJMR8xsUOKByf/qlla4YcPWyvxynFkPqnrYrb1lgvxXt2k+AmwTLOzSmhgR0lhfDS+QNVQ3V/xA0ovbMAfluIJ7PjSUHx/qNAPVVBCbFTJtsfb8oZFDgxdAlpoo8dHypEL2wrPXImbD7UO2t1MYrOK7+P67s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dEkiBsQm; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKqHX6Xi1LW5W5g2YutlB5Sgc5wYyH3eYJkPwtuDnzSKtk+WjhwYP8Qp8KQIa6EOw7Ej+/Wgkalz10BrPEz1z+9+I2l/DOL9G2+dTYT8iexxxxp4hwh/eopim9RQWcTzTQ/H1T014Mz1krpWmBYpHZFVs277gcOMT506HyZUgP3NldRteEv8ppKi5RtxTrT2FORxrl0TmX8xukAaL3ZAFyFGuiCDjrt/MDlHEYcbFQKhTeJ9UG6XGN2Xp8noa4Y4d4yfS+NhZDC6B505nNdpMvRtJdA24xkHXrtIhchaOaICBty9LFoNfuTS3zT3KV1WlWk4lrorm2w/+sRwStylbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q8fEKaL4JIY98wMyZcs+I8xkRxF5wgSHyhhLF4du2A=;
 b=MXse90TIzCzM0moeuNEw0iuZ/u7WIhYaBXW1KhfUnX+MtPraX/tr21PCcbUbvGg7Gj1RZkga4RVKnramLz1poriTegIiknJQNeQ+kU7eH1NkZu/lBxNSQPCxafJhSwT2IznvAcDhEHspgBYBmuXNfN3HdIxDiGgKQr21HXSj5AaQUqtxzo4hjyhtzJbWV141yb3N7brkalCN+59nYEWPqs2hTkz4MFh7KYtynKq4YJ5kyfk+N8iiobFvpw4onufI5EgDD7OIODKiAyCrYIU54f/Aiwdl8m1gtzZQdMl0O9WGdTjDNmh76YLqJM2VND1zA5IWXOY24cPpkeAy1YdWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q8fEKaL4JIY98wMyZcs+I8xkRxF5wgSHyhhLF4du2A=;
 b=dEkiBsQmrTW2S4uueUja5ofvV7NKKVR/2/0fmvHGF8pCuViq6YZ9svEUJhNb4kQ4pmS4yRsmvVhnF+G+jWdVT87Q7Gk76UomiMukclGNauIELpha0KyXhfelSVfgTo99SvbH1yacNw6mp/GbfZrvq0p6RA4wIdkio6Z2kTmnTkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU4PR04MB10433.eurprd04.prod.outlook.com (2603:10a6:10:55f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 19:11:43 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 19:11:43 +0000
Date: Tue, 4 Jun 2024 22:11:39 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net] net/sched: taprio: always validate
 TCA_TAPRIO_ATTR_PRIOMAP
Message-ID: <20240604191139.r7xp6qmyud5dyoie@skbuf>
References: <20240604181511.769870-1-edumazet@google.com>
 <20240604181511.769870-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604181511.769870-1-edumazet@google.com>
 <20240604181511.769870-1-edumazet@google.com>
X-ClientProxiedBy: VI1PR0502CA0006.eurprd05.prod.outlook.com
 (2603:10a6:803:1::19) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DU4PR04MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf02bc7-e0f2-4713-8655-08dc84ca2b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w0xDHer7DHYANfM5Dio/vCaE+Hj2lZ6IuIzFhna8bGND0IJBZ48hMBCBKt+6?=
 =?us-ascii?Q?JU7Mo9r3D1HPYlkantQ30GE+7NXU2GiFyQjw0IeClIIJ8wooy3pqptE9/x1s?=
 =?us-ascii?Q?dO68kwfnyVfJkaMPKQL+qpY+Bz65VuyyP5hs8e1vngmHpm/g88w2igJvUMnl?=
 =?us-ascii?Q?/AXkniv1/EWMqT0sskvUOhg2b8QmkU9G9i6YlIQ4kLBksryRzokTYeDEXm60?=
 =?us-ascii?Q?OCDU/NaUJfJmFJqTAWYTP+q+/AKAlt0rAgzs8SpLi2x1evogkohYVqgAva9X?=
 =?us-ascii?Q?avBFrCia6M0yVFnm8kh3GhB5hl5xP/7Dp/N6x/lh1QBiiHA6jMmh8JR90AMX?=
 =?us-ascii?Q?AByyIwXacFbztFbimmotQSHXBTysqPdqRRbv/+lyiseobBLrAviH8z66IMBQ?=
 =?us-ascii?Q?LaYUS+q5A2aLb+wz2gYcHOpIT4ivLv261OePbnTWfOews1qFEaNL9al3z5zy?=
 =?us-ascii?Q?cCpBhhgAftwrHDA0xTBd9HaRLgZoOgOJte7cYwagnXHXMD3FrH/AQLQvXFyQ?=
 =?us-ascii?Q?9OlkAwpPq2/9Fy34Hw5i0u18/19r6v7q0SctWQqTUWjO5Grd9TMBuxN89zj7?=
 =?us-ascii?Q?o4uh4zZ91+zqFJ1Ln3c9Sa/CFpiwcsQdgPqrgOAn74KsNar8rrYWHhujhi7c?=
 =?us-ascii?Q?dWGFTd/EYSzxFLK9KozvYxs7M+B1UV4GkXGuevpKq+XDL1g6POHQfXEtPref?=
 =?us-ascii?Q?SfXjXqEMMyjhO8aIJKKs6TennbhGXZpJ0X2qXa6BYgTPeZHE5q6EdNT2Ispy?=
 =?us-ascii?Q?HMryoBYsJSWesogbA6en0IIMUc+6fRFd+8Ux0F9eC/ZW9h1S3QHCyblpJnsV?=
 =?us-ascii?Q?H7PZUXxb9DmoHECEB8fcHVsbiWB7lswWboyLC4V1FvZzQrihJQ2UoWM89IuZ?=
 =?us-ascii?Q?4pYXd2nDAakAlrfm8wXNmkiC8yAOvyRAEE8fsVxtXdPCD+diruvMnn5tha8W?=
 =?us-ascii?Q?leBvJc4191pGoXtY+FECehbO+D4H/R99IjOFu3BhyoU2/RaUs2w53IAI6y7X?=
 =?us-ascii?Q?Exa2W/bQ9IgLZSWz1kjBGsmVTiNs25q47ryV9uGX0+hgjX6EU7iYUVnFj8Z1?=
 =?us-ascii?Q?K7PjrLhTi3v4hmBYn2Ox6m0Jk/tgfp/v3YbVw/l88D9FzwOoGZa2uGuKhnbH?=
 =?us-ascii?Q?27AkPAwHk3H1M4CU29SEFX25eZippbSYwCeG/O8992XWC+uCxSXgSZbSPm23?=
 =?us-ascii?Q?4xv4HrY07bLmohns9gWWVb9JmRTj8giDAXz9ISsUSRHRFKHaFtxyFm2BJz/S?=
 =?us-ascii?Q?E2cTkGDily2YW4+FTM0d3azaYvbPglnVKsiyY3DsTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWIYc+78z6l0HzrM+i7RLecJ8josFAzQXq43WO0wNDI3Mhk7l8UZaKZougn7?=
 =?us-ascii?Q?PRa3wkHCvf9lnZ7PcuWeUVO5AU18Ijg/AUprMuLma8m+tm/n54ugiOxL1hsP?=
 =?us-ascii?Q?uQavBqtUwVM4VC1/BYcIbyOHpi9ApG5a1YZCYYLa7cfeAiifhiUfz0vLdIYX?=
 =?us-ascii?Q?LPmU9qnCQtd55C8tjD2ORPnXfL0wFeL0GlaOnm5QNSNoUvOLuwdcw5Sike6K?=
 =?us-ascii?Q?RyVkTzN7m9CSfQnKgGuM0AYYSEckAHMH577iiKjKlM2R8Gr1UslAKskT5lyY?=
 =?us-ascii?Q?uW3aMZzJHXvZbYDIRGENqaWOo5Ncc+/zn35MNrDJznd4L/3oP9/2Z099bnqd?=
 =?us-ascii?Q?igwmPmEcxkAFafMAtfGU6YzU30wCS/vgLat8RZWHhD18relCSKss06e+JFVY?=
 =?us-ascii?Q?pXZzcXyGo4pwPJEiiOAQp9S8GhqyrJYJ+e7apzagHW/UrI3EcgXVMPpozMHG?=
 =?us-ascii?Q?XkiadEwL9+pD/ydSTvzUqn8T+RqB+pMT6tldCkVH9iZzRhTbR0dC+b8L0MNF?=
 =?us-ascii?Q?5oy2fAG445XjuALA0AwYmmIcAsVZfNTJGsjZ/apupQLUZgmtW89rx7CHs5wb?=
 =?us-ascii?Q?gxUOZhuWCyDbhbzNN0uC1QB+9yO0kF95KoxTasgQ7jrL5NL9ymJijNnm/7fo?=
 =?us-ascii?Q?+dcij2ow9jpcbuR1N/W42w+d0x6a0ItvPaZyIye7jSmfQB0bS9/0F+6bPYzC?=
 =?us-ascii?Q?7LXEYN2D77SPwFRMBqBnGgFdolwnqyvGpOLZ9JAo4xb2KUTBcU2OENau3AH7?=
 =?us-ascii?Q?mFCj6elGRNJK8LKCZ0RWXurN8gMuAJfWrJK8OUXWmtkAOxw5JqbW6n4HfLfV?=
 =?us-ascii?Q?ReWuO16w7DR38NyRnfcZ4pWwGSCWmDxyITj2SjxI9TQOQxwAGBvCVLrIsHPL?=
 =?us-ascii?Q?2doDCxv0H+qUb9P5KpVNAnX46ZBiT4STAVAAS7bCvCAegHsarih34YtLlTCt?=
 =?us-ascii?Q?9FXPJ8uIQCzmb87BvNZsWEwWL8Ui+nrjolIdlRXLT+2fivfJy37mu6dMZ4O4?=
 =?us-ascii?Q?TRD5+oE31kXznKiozMxladkCiO76cmtU7nej/stzRmIfiHBYglvfdC2DkZp7?=
 =?us-ascii?Q?mJs4PvidmqKdQap0w62Om6Boqb8MX7vfYv91Mr3lwtCkBE75KYeTdV+KfgXg?=
 =?us-ascii?Q?cYat8Cum+spULzmLbKPllhlLFHoGUIP7xOV2Rp0GUPzPOIA9pHKUaWggX/cA?=
 =?us-ascii?Q?3V2ckwM46uMY00vwfwqiPWaYAq8mDKotcRQiTqSpthmUgpZLX5hPpfbX62jV?=
 =?us-ascii?Q?NMkMH0qkCiXNWSDOh3lUF8zYv7ObaWWX8lEWKdczq9w34jguQPrmAYzZ7a37?=
 =?us-ascii?Q?SkMiGbGfUXo6yVR6MkNQapqVKUyeNXDATdDUnY8W4opsamUPCYEu9WHEDa+F?=
 =?us-ascii?Q?zaj+uCApSyqrBMWTK8NWftlCXkuxLitgasKviY0NZHSEADXTB5WkIB/dbXI1?=
 =?us-ascii?Q?WMXFiWh/lNW+ddYtUegVld+HcVpeYAUH3bxgQJV0qE6DjPJ3KF71h8o3ErL8?=
 =?us-ascii?Q?1ODG3lN6phglt3b4RSzX3dzUWm3aXAOLX8Evkws6gHebOgJv74DjzANdqIy1?=
 =?us-ascii?Q?QVyzV3VeVUOXZHwKM12O66oSYecU0liPSqItNKVROTUuI0E11Q5aVv3vXQHr?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf02bc7-e0f2-4713-8655-08dc84ca2b8e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:11:43.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8cg1L5flTaoCxIpv3kU6onYdcWcDQpVherdg0GsTRzNjaBwe1/Zn2Gh1zI6YGMzB18ElbNXXi+ELXYII155lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10433

On Tue, Jun 04, 2024 at 06:15:11PM +0000, Eric Dumazet wrote:
> If one TCA_TAPRIO_ATTR_PRIOMAP attribute has been provided,
> taprio_parse_mqprio_opt() must validate it, or userspace
> can inject arbitrary data to the kernel, the second time
> taprio_change() is called.
> 
> First call (with valid attributes) sets dev->num_tc
> to a non zero value.
> 
> Second call (with arbitrary mqprio attributes)
> returns early from taprio_parse_mqprio_opt()
> and bad things can happen.
> 
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/sched/sch_taprio.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 937a0c513c17..b284a06b5a75 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1176,16 +1176,13 @@ static int taprio_parse_mqprio_opt(struct net_device *dev,
>  {
>  	bool allow_overlapping_txqs = TXTIME_ASSIST_IS_ENABLED(taprio_flags);
>  
> -	if (!qopt && !dev->num_tc) {
> -		NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
> -		return -EINVAL;
> -	}
> -
> -	/* If num_tc is already set, it means that the user already
> -	 * configured the mqprio part
> -	 */
> -	if (dev->num_tc)
> +	if (!qopt) {
> +		if (!dev->num_tc) {
> +			NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
> +			return -EINVAL;
> +		}
>  		return 0;
> +	}
>  
>  	/* taprio imposes that traffic classes map 1:n to tx queues */
>  	if (qopt->num_tc > dev->num_tx_queues) {
> -- 
> 2.45.2.505.gda0bf45e8d-goog
>

Correct, the mqprio qopt structure should be validated whenever passed,
not just if dev->num_tc == 0.

But... what bad things can happen?

Whenever I try to trick the kernel into doing something with the second
mqprio, I get:

"Changing the traffic mapping of a running schedule is not supported."

