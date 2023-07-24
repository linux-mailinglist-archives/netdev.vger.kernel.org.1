Return-Path: <netdev+bounces-20480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2062075FB37
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AC828146F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC690DF51;
	Mon, 24 Jul 2023 15:52:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEADF46
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:52:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2139.outbound.protection.outlook.com [40.107.93.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350658E;
	Mon, 24 Jul 2023 08:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig4As3TsgxRQtOz5ffJwHgpyKXG0NBEeMhKvCtUKwgo6Hof+RTEXAB3rqEmkDxU5iNgiQ0dLdy2yEpgyMa+w1duoznSpE9JSItkPWBgMod+XvtObV5IJioQR3ytaiewWZNLYSEexUzljTALus/B71XYRZ+6JpqDtYgPYC5vmy3IEjAxCtHCBZjclubDLhUZY4PdTyei7Ocul2bX9izNpTtaMO/UCDHQY2TPiLTkcnFDuYdC/QMa/oNKyDqtvF47nmGPfu3RqJeOas5nePM508QZt5cwxJ8vMkuBtJ4ipKS80CIGkO5SrY078eBcQ3/kLwxHM/OzpnEQEKgk+qAMvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5yCcbyqZZVFvOtDA0tfZvF9jzIsfLLfpSAfYk+ebrs=;
 b=iw2Fhm1jexMlgZF6oEUgI87bwA596Yg9RMkrXFY6b52e3QJrr/mAsL13Ofzp/kg1bE0FxxtYhfUSL9prQEuoyK7B6dxTg4mWCVRj3NSO6AU9j7vmKNRbX9UzIjvK18WKcUMWofdtDnwTFhdIuV7gMhjAMObMaWEeP0RX/H79AXGnMoRJH6K745bbraK2P9oCZs9FsD8WIn7Dk8kMou2VvlM8d3gurxDcM5lFoBg7THeRvu+gMRk/B5xeI1NPWS7O/ngAutZaZsIoq43nXbIv2InhX9MA7gmr0/u0hSlzhLoXK//FCq6q+ZSnTYneBF48VqQtJa5BjHHcqoplppWsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5yCcbyqZZVFvOtDA0tfZvF9jzIsfLLfpSAfYk+ebrs=;
 b=q4quv+qVni4XlcU+tVGZU2i/v8CE+2mvUqlwk0nZzxHdkPA1jWO9TAKpX8vzu7LYE3eg9heU+FXR2JhvYtyQ0Gh4hot/PHO7sxf0wG9SISRUNEnUZiQxTS4Pc/G2unPO6oFaH6+QUYi3boXPU87t9yQqlm0tjCNQfo8sdmeyjaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5724.namprd13.prod.outlook.com (2603:10b6:a03:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 15:52:41 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:52:40 +0000
Date: Mon, 24 Jul 2023 17:52:33 +0200
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
Subject: Re: [PATCH net-next 04/11] dpll: spec: Add Netlink spec in YAML
Message-ID: <ZL6eQZ1yKpowjFeO@corigine.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-5-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-5-vadim.fedorenko@linux.dev>
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: d9241247-ab0f-42b4-f8b8-08db8c5e02cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vlQIyby0Kynq+EXI1+qN2N1TYqJG0roJyk9ZgZOOG8p8ZIaY1LYlOR6joxYdc0HxFvflxIzET09crCV3YmXkoOlzzF8otAkz0Xk+lFjZahHOu47rnPGTzjF8WcXr9g7Xi0aOjuzSwFbPbdKX6HLY3GhFJEhQL+7dVfA9bxmMgXbhoqvm0Kl9I95DXkiQVwyufaX3wCN7xz6myPxGaJb3HD9VEQIvuyvQM4nGEdwOarWU62cJT6kZB00iYipTa1eWkiGwxASxndNSPYnQylCvWd8utkaYDZbo6FXFNpoTEZjWqXcDGzYZSJoAEQE2IQJour7jbr7LgTlup1KI+OE4o/9Cbs4iJOFCvT/cfAk4l7GguwyB0UwwYvi7fZe0WK4UMhj7dUjkXE/iQfUSmp9KntmLnl5s9djx0RLODl/n2jsAUheJoXX8cW3u5CRWWFdU47MblJ0Nfnq3C0lKqdKk61l8sUJuRKVX7H6w9CWfThaB6f36CUUded+6Rg+fSh59sNo+Sabz6AbC6KSq8rD9KZHtVgDo8/a4u5DqDMdBl5P4S2ceVTODuBa4iUG3yGPpq+yPdHemmX6sKSQwlbRvKaSCq0vqyh2hc9s8To9N3oE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(346002)(366004)(396003)(136003)(451199021)(5660300002)(38100700002)(8936002)(8676002)(44832011)(7416002)(86362001)(41300700001)(186003)(83380400001)(2906002)(2616005)(36756003)(6506007)(54906003)(66946007)(66476007)(66556008)(478600001)(6666004)(6916009)(6512007)(6486002)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HsAFOFp9SipuigeNiP4qBFnO0R1u27nqPyu2pR3/fGyl/9ynL579NNSiWhCf?=
 =?us-ascii?Q?fBvsJ/c+ru5rGT8xQBbMLUXwM5xWV7BwkivbP7LfV0VkOfJqpmrkhXR4DGvV?=
 =?us-ascii?Q?TqulWsavmO0UyQj8rmkicW4Rxbed61ZgwiUDgwU93zmIB3jwtam3N9Sd/Pn7?=
 =?us-ascii?Q?w2yTku8qPjHLaVvrlMR6EAcY7AxyhfTaoISLqKp4xLE/qXyNT6kvPjPBoWzp?=
 =?us-ascii?Q?Es9M+IKd/87m/oydz+uMjYGCK5RZW4EBrvBxBi2vlITP1zJuF1HjFLGPNHTQ?=
 =?us-ascii?Q?xXEWAZDoW5oM9xVjJ8XxUxdk/D2Lo0X9QeJ3wXVwZwusQ04gb3p6g7JEv8es?=
 =?us-ascii?Q?GyfwsOl/FoUjACgU8Cp8g5P+1eAllER92d3spebZfTbWez9Rj/xv0jl57wrC?=
 =?us-ascii?Q?qE0tJ7jRM5OH+rJ85B6L0D88831UpYGCUB20OjihrOnWOvhX648kG+PtobIp?=
 =?us-ascii?Q?IDQP0YaxgZaPZB1bqpHtt7forf3zFExPx+x28bHU7dakev1A9U0dLwpdrFpS?=
 =?us-ascii?Q?eTRX1dVPBPWJDRYxnWRF648ZQIsNfDE2DZWrjusfD2jb9/EDIWdHetPPZvfB?=
 =?us-ascii?Q?JQ9WkXv7nQN9qagLVC2nnQmLpkXhTbzmzWfWKIJ/utL5KQPnKl0/SJqvsP5x?=
 =?us-ascii?Q?aoPNGwJOvTAvr2qRayDEq5KuJbMBnT4tGYMXGHIncZhtQ06txy+3HvI3SBr2?=
 =?us-ascii?Q?YdZS/x/oWg9c0Lr1KaRATXjhSsojzpTFDpywxfsnnuz+UfEc/Z8z5Dk7pZtf?=
 =?us-ascii?Q?gi4LT7zU+Eltmza1y71ngSmZz/ucYKbolemr/R5Oa72uDvyby6Jrs7V9Iicu?=
 =?us-ascii?Q?R9rai6Q7YX7rqG7O5YNb4dRlEgco5iEqDRD7Z7ERJI2kebzH4D65iKkUPCer?=
 =?us-ascii?Q?ZX+3GhtDaNctixqzhXBR5YHZApmcg26dcHGm4gqgr8OTrvmodwsuQqQrA7+C?=
 =?us-ascii?Q?AIQWATT7hzAQjeS8ZLFuEaA1Fj5woSoEGRSrR/rcgyHq/I34280nfZ2aSqWV?=
 =?us-ascii?Q?rr5+BMyShhiJdXxtBAnBgeAoisExqKZAvmUjEwfG1RvMntmEM3j9D0kwoVuU?=
 =?us-ascii?Q?ndKHo9hL7DwQtfac56JjaB4QNJ+SmPBLJcT1OjKUzGmlRLStP4pHVp+KW4IK?=
 =?us-ascii?Q?StWmSDXbPbC/NCg9qf1tb6VReullvlxQnuZ2A6R6GhzAhc6nxnth6NT9aFeU?=
 =?us-ascii?Q?KKDM4YQttlsIYBJJzE5y5g38nw6Tlgxkw3Vwa9b4SOwkj60GPR7IqWBwM+aD?=
 =?us-ascii?Q?n7LwHaWV1zai1QLmPwRhJISldSmKfzNCeL68aZJg6JukyT37hPFXgJF4kwwA?=
 =?us-ascii?Q?aFr5SV9TajixNwQGljRpqMUvhdoMGZmIEt+IndAekQvGwmGCbz5R2IhlvfGa?=
 =?us-ascii?Q?z0avbvQscObtM3KqaUm+STDnk6xzi4EP9ibf36vXKbNTAKtjmFSxN46mcjhP?=
 =?us-ascii?Q?S+fUAP8KdCxweRnDIu1lw8KguLv0CH6napzF722vO9ucOzB+VaT09Vs2KOn4?=
 =?us-ascii?Q?371ji58sQOqeAeKIRxI2arGqWR+ip80xDnMfx5QJRdpoO4BYNmR+ioFsh9Mf?=
 =?us-ascii?Q?pwa0hI5BgAGG4Z/hv/H9JPqJY9UQ6txw7wRVR7C0v2Jgybi0Abha8ShJHCPy?=
 =?us-ascii?Q?+e+VelHcseuFMrmi6n1RhyTYpqelVwFZcL99IF2Eb9zLZguxYaA1piXPaJog?=
 =?us-ascii?Q?/LwaIA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9241247-ab0f-42b4-f8b8-08db8c5e02cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:52:40.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVeThM+xnAeNIDdrx8vK39J/UXL3urmxlVDI9pbxX9f7PMe6WGobTy5di/Co4R+3oMMCXuKirX1PekjKa7j1+V0Z2MUXLTeFpkcOfNjBDx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5724
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:18:56AM +0100, Vadim Fedorenko wrote:

...

Hi Vadim,

Some minor feedback from my side.

> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml

...

> +  -
> +    type: flags
> +    name: pin-caps
> +    doc: |
> +      defines possible capabilities of a pin, valid flags on
> +      DPLL_A_PIN_CAPS attribute
> +    entries:
> +      -
> +        name: direction-can-change
> +        doc: pin direction can be changed
> +      -
> +        name: priority-can-change
> +        doc: pin prority can be changed

nit: prority -> priority

...

> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h

...

> +/**
> + * enum dpll_mode - working modes a dpll can support, differentiates if and how
> + *   dpll selects one of its inputs to syntonize with it, valid values for
> + *   DPLL_A_MODE attribute
> + * @DPLL_MODE_MANUAL: input can be only selected by sending a request to dpll
> + * @DPLL_MODE_AUTOMATIC: highest prio input pin auto selected by dpll
> + * @DPLL_MODE_FREERUN: dpll driven on system clk
> + */
> +enum dpll_mode {
> +	DPLL_MODE_MANUAL = 1,
> +	DPLL_MODE_AUTOMATIC,
> +	DPLL_MODE_FREERUN,

As __DPLL_MODE_MAX and DPLL_MODE_MAX are (rightly) not included
in the kernel doc above. I think it is appropriate to add the following
here.

	/* private: */

Likewise in several other places in this patch.

...

> +/**
> + * enum dpll_pin_caps - defines possible capabilities of a pin, valid flags on
> + *   DPLL_A_PIN_CAPS attribute
> + * @DPLL_PIN_CAPS_DIRECTION_CAN_CHANGE: pin direction can be changed
> + * @DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE: pin prority can be changed

prority -> priority

> + * @DPLL_PIN_CAPS_STATE_CAN_CHANGE: pin state can be changed
> + */

...

