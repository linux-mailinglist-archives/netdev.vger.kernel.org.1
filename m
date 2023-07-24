Return-Path: <netdev+bounces-20506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276F75FC3D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C22F281654
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D95D514;
	Mon, 24 Jul 2023 16:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C898BFD
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:34:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2103.outbound.protection.outlook.com [40.107.243.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C2122;
	Mon, 24 Jul 2023 09:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXmdQ27zI9/Uaepgcz2eT3U6gWTq6mOeDDD4XWvoU+uFhaeuYsz7vct4wchDPxa+ACVrREsYhAhFiPK/nwItBRTgvu6Y6Ob7Ud261+qKfa/cQURymHodhWp6Fb3wdepWm/CRi3vDcOqlfJzk4KYS36OwIUoSdWkAS7f9rGuQTFePNYF5CkHXt9MIqx3yg4fM3yRhy8CNixeh1PQnNOVGpB69faVDuw8S+orgv+tUzYhmMRHZqo5DbCth7OJ+xGrr2dpFcCvJMTTqklj/a3jEbE55yLkffR7EoKwMLSO594GevnHKZZb6avTQ1JIv7xihw5TDNMW815p6GfFHHZrLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHuUovrk5KMlpTJR2xtXCCnQN0rTruUIKAN1DVZ8Cpk=;
 b=PdPUdoZmUNbRdG9oaus7HMGGwoJ8xS4NmH6D401ewCaERd2SJGsK2yIHnXBWa+00KL5RgS65M1vnxCMFkK9TtsWsfMFYRnijIn/StA16a6EL1qsQMeyTwsvTQlqIFCl9Egzf12lgazP8K3YjhrR785EWJkSW6IbYp/DFczoUmi5qxyQtPhKlTb0sdJ34UlMWetKFWdlZpHWRp1bdqOtM8QFPYJXc9KQz4Kh7dKopYv6eqIq2n0xvRu6YDyIsnVwDDi+AyNL4hJk9mIDo3eb5ZOB8zbUSKFW2FiCFHXNTr5X0YG5sa24iOYNNM2s46Ihy66GrTyqU0prvIwPTuzzgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHuUovrk5KMlpTJR2xtXCCnQN0rTruUIKAN1DVZ8Cpk=;
 b=eZl7TXGx002D9/ZDqqFBiIecUwgU55YEoxpt3ilRHsZ/jDtmWztqpwwJkW3ijb9X2dp+TpQ/wNIYD2huC+wdMGiPfvvlh/nRAiLYp0P2TX2iMfvpZTu8LZgkCTbi4NYR0yZ+LKA+cxAYTtS05/4sun0AW5mlfANF63tW+oFgCqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3781.namprd13.prod.outlook.com (2603:10b6:610:9a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 16:34:13 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 16:34:13 +0000
Date: Mon, 24 Jul 2023 18:34:06 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH net-next 06/11] dpll: netlink: Add DPLL framework base
 functions
Message-ID: <ZL6n/g97lrtLH7Ev@corigine.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-7-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-7-vadim.fedorenko@linux.dev>
X-ClientProxiedBy: AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3781:EE_
X-MS-Office365-Filtering-Correlation-Id: dd945b55-e098-4c1a-8031-08db8c63d066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cje80nTOMO0VoaYSSxy+XVKlOS9fGfEJgyDkRLLPdTHA5rYscN7ddPDsBnaNnEYIfyOQt3KQXwQd/P/DBXZhaoNI0xclNkYW2TppNZou0LztiqPlO0iKSK6nB81i41yGbAzrR9I4dEptbLRRgnnP1i5JqrFVTL0A35uv/7OXOMIlZp1bd20I1uZKi2ozgnKlXEQJq60UbWIRrkDH69XuLch7xgQSaXBX1jVv0KTfDOvvSe5D3imags70YOReIvJlQ3EWyzuKboqjfQqvpEhu/Nh2M8DbHZXBBGr3LW52eB70tYRaDGoruKHGphFHahy9/P2n664lYJ4sGDYmebToq9btrn80YuZlcmcu1BLOeNw82LMMgi5ZnvJNsRTkQ0A+3EwsADWjHM3aEHbYvj9fIU1ytASCX0Bw4ESEblvtZjifZJYczKAMWH8z74KRRjSHqpHn5ECE8Y8nqWcv7iCYP6C9ETTojrwN8FfXv2flE6CxHJk/bmR/rcZlO+CmAsVHX4y64QEFNu6woTOyeTgTAE8RKVIUeERxTTHyFCR3V3WAqDMtnFKWiFeqMVaICwm6cuGFNsryZQUXakWIU/SKXMMc02OfDihuoWzf5M595cs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(451199021)(6486002)(6512007)(478600001)(6666004)(54906003)(83380400001)(86362001)(44832011)(2906002)(186003)(2616005)(6506007)(66556008)(36756003)(38100700002)(66476007)(6916009)(4326008)(66946007)(41300700001)(8676002)(8936002)(316002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V8X7dCGTaGfJDyoJf3AnRg+VFimWfqQG0Dt7nLOvZ2nhqYW6fvwpQbg7tkbz?=
 =?us-ascii?Q?Edmcs1aOSFvp/vQ+LWwEEqKTNnt4ZdmERBjKVScZcXmQeyBzzrSOgQB9DSRj?=
 =?us-ascii?Q?qxaRvHoeUYLRML3LS42/MB81DjvgkX+ppLS1B4NX8lc9kCDC0rCvp0NKs0mu?=
 =?us-ascii?Q?/dsFIFSPm989N+tLEs5crLq/ms8dU1AW+dXLEupvSOM4Ch9sWp0ymOLmpWv8?=
 =?us-ascii?Q?bqZUdos7jQoyLlRNK1Ndo4uBr52OjiqwRAyPlIyH32bVz7guYqkYqFSA4EuU?=
 =?us-ascii?Q?WvtwIbcKGZPZhZH4xTbxPZv6V/gdLpoxZVRoan7oOGmRYBPfxi+j2vjQ1Yvc?=
 =?us-ascii?Q?0h1TYRDVVggELcWbaNq0fOwKN0eGi8vlm6HiY8kHJS7X/5YDon6NGV9mAa2z?=
 =?us-ascii?Q?xCu22JvXtS0ak1qHYUxHoY36ouS3T8h8oiMLr7vJ9cwtsICOIsHOXrtVjejj?=
 =?us-ascii?Q?OYfl4BQ+xmK3w1evEdDgCKqTj7lRFV9nKaSVrdkgfq33wpoeilFI/uMYUkDi?=
 =?us-ascii?Q?AbnoL0EiaDx7gcrCI3h19qcempRrn+pwfUZAp1bOkHr/sBrP9hPTgwWze7IL?=
 =?us-ascii?Q?khol11ZXnq1hKT3SqrZUkCH54EzL2tU/ZedVVTIc+g15plMHd7yJ8DTEl1r0?=
 =?us-ascii?Q?m2k9vkdIhdovzsTvSXos+ay6CcfkwXj59f9OAtnfzzE2Ng5sTH5vGwwcWGrX?=
 =?us-ascii?Q?0Zsf2YDNrVQmTWAEq4vSh51GRTSYUs4CYUw/A6jtTvbJyahYQUlbMb/KvW2v?=
 =?us-ascii?Q?3gdUSTiOCsYXjOMhiQ+SC1WRM8u+rErq6j7rSGEriJ9RAc6wmCufP3PjxAhK?=
 =?us-ascii?Q?xQzJZraXMZZB52Ukc0vXtzDsPzSCogIdRmes51u716di5Ja5zZnr4mZZ84wj?=
 =?us-ascii?Q?0DPtp1/Msk9CPVkev77yo1xMEvUegfFqkfrYxshpCu/8T1Cxtyop9zFeHJQS?=
 =?us-ascii?Q?/7sL3Qg3RBh3MTJEwqT0GvQPF+MKdLHStyYUQQl6ZIcK3LO/y6mVywgjiewP?=
 =?us-ascii?Q?GoY2oFER5PtO+gx6BzkQpcKtafQcOArzR/3hhJ8A16Xz9Qheu1VIQeD4cG5q?=
 =?us-ascii?Q?mrt4E8mXJq+zeS6j78TUdt5/GsGSI135GDGEIUfF9sAdeycrfrxr8Jff/t16?=
 =?us-ascii?Q?VValydhKkpZe3Opi5+bxi9qqwIhrJUtNI1vQeu0GUXMgLJHU4RAniAgoUygI?=
 =?us-ascii?Q?LU/TL5oco+OVSxPJYk9vv7bqx4bDP5AhrNKscIDsv5qpufKfC642YD70X+FP?=
 =?us-ascii?Q?5DCwQipQ+Vq464Hp3X0teTQB/2EU1+a+XQjKXZQFnQ4AI+FVVQyXlEALTpwB?=
 =?us-ascii?Q?CaKuHyZCn56HsglGsN3kdx0pRIraIUzmFKYCgiMc7LIqwxYmrWtkwjdVcqmm?=
 =?us-ascii?Q?7+/97MjThGSaWp6TXU8CgZ8c8PHbkb2Rw9PhSh08IM6zSp6dBMg0s67jan2C?=
 =?us-ascii?Q?Cu0AHsC6TjrUN4eO+zEM7xny9uz0GFE6jJMj/xjAiWNj05WfJfzUO0fZgt9s?=
 =?us-ascii?Q?+Hm1nB0ZSxDiVF/mqSS/NNr5Cge1Y3cwqpbyNsgwLJbWD/glmB6sI107LpWU?=
 =?us-ascii?Q?TkyFhELyW75IEYYnNLR6Uh4k0vqewoCJ8djtkDYZ2msgdCLsbxfIAthnG8mv?=
 =?us-ascii?Q?sPhYaE71MJKvFC+36oW5B8ey35Xb3osW4qgpYrHfqbMY/9eXW0MUiblP1Gba?=
 =?us-ascii?Q?f4s2/w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd945b55-e098-4c1a-8031-08db8c63d066
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 16:34:13.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH0sMPUoFrKmugSrk9LG3tt/k36RYAv9TxzuRx+1O7GpoRk4ZWuNuBRCwBRkVyLz0pCqJ+b9aDWXs7QyuMdL3QwJUrPRFvqR0al6TBQd9EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3781
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:18:58AM +0100, Vadim Fedorenko wrote:
> DPLL framework is used to represent and configure DPLL devices
> in systems. Each device that has DPLL and can configure inputs
> and outputs can use this framework.

Hi Vadim,

some minor feedback from my side.

> 
> Implement dpll netlink framework functions for enablement of dpll
> subsytem netlink family.

subsytem -> subsystem

...

> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c

...

> +/**
> + * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
> + * @msg: pointer to sk_buff message to attach a pin handle
> + * @pin: pin pointer
> + *
> + * Return:
> + * * 0 - success
> + * * -EMSGSIZE - no space in message to attach pin handle
> + */
> +int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)

This function seems to only be used in this file.
Should it be static.

...

> +static int
> +dpll_msg_add_pin_on_dpll_state(struct sk_buff *msg, struct dpll_pin *pin,
> +			       struct dpll_pin_ref *ref,
> +			       struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> +	struct dpll_device *dpll = ref->dpll;
> +	enum dpll_pin_state state;
> +	int ret;
> +
> +

nit: one blank line is enough

...

> +static int
> +dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
> +		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> +	struct dpll_device *dpll = ref->dpll;
> +	struct nlattr *nest;
> +	int fs, ret;
> +	u64 freq;
> +
> +	if (!ops->frequency_get)
> +		return 0;
> +	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
> +				 dpll_priv(dpll), &freq, extack);
> +	if (ret)
> +		return ret;
> +	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq, 0))
> +		return -EMSGSIZE;
> +	for (fs = 0; fs < pin->prop->freq_supported_num; fs++) {
> +		nest = nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
> +		if (!nest)
> +			return -EMSGSIZE;
> +		freq = pin->prop->freq_supported[fs].min;
> +		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
> +				   &freq, 0)) {

nit: The indention of the line above isn't quite right.
     There is one space too many.

> +			nla_nest_cancel(msg, nest);
> +			return -EMSGSIZE;
> +		}
> +		freq = pin->prop->freq_supported[fs].max;
> +		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
> +				   &freq, 0)) {

Ditto.

> +			nla_nest_cancel(msg, nest);
> +			return -EMSGSIZE;
> +		}
> +		nla_nest_end(msg, nest);
> +	}
> +
> +	return 0;
> +}

...

> +static int
> +dpll_device_event_send(enum dpll_cmd event, struct dpll_device *dpll)
> +{
> +	struct sk_buff *msg;
> +	void *hdr;
> +	int ret;
> +
> +	if (WARN_ON(!xa_get_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED)))
> +		return -ENODEV;
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +	hdr = genlmsg_put(msg, 0, 0, &dpll_nl_family, 0, event);
> +	if (!hdr)
> +		goto err_free_msg;

ret is uninitialised here, but it is used in the error path.

This is flagged by a clang-16 W=1 build, and Smatch.

> +	ret = dpll_device_get_one(dpll, msg, NULL);
> +	if (ret)
> +		goto err_cancel_msg;
> +	genlmsg_end(msg, hdr);
> +	genlmsg_multicast(&dpll_nl_family, msg, 0, 0, GFP_KERNEL);
> +
> +	return 0;
> +
> +err_cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +err_free_msg:
> +	nlmsg_free(msg);
> +
> +	return ret;
> +}

...

> +int __dpll_device_change_ntf(struct dpll_device *dpll)
> +{
> +	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
> +}

Should this function be static?

...

> +static int
> +dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
> +{
> +	struct sk_buff *msg;
> +	void *hdr;
> +	int ret;
> +
> +	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
> +		return -ENODEV;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_put(msg, 0, 0, &dpll_nl_family, 0, event);
> +	if (!hdr)
> +		goto err_free_msg;

It looks like ret is used uninitialised here too.

> +	ret = dpll_cmd_pin_get_one(msg, pin, NULL);
> +	if (ret)
> +		goto err_cancel_msg;
> +	genlmsg_end(msg, hdr);
> +	genlmsg_multicast(&dpll_nl_family, msg, 0, 0, GFP_KERNEL);
> +
> +	return 0;
> +
> +err_cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +err_free_msg:
> +	nlmsg_free(msg);
> +
> +	return ret;
> +}

...

> +void
> +dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> +		   struct genl_info *info)

The indentation of the line above is not correct.
There are two spaces too many.

...

> +void dpll_netlink_finish(void)
> +{
> +	genl_unregister_family(&dpll_nl_family);
> +}

Should this function be static?

...

