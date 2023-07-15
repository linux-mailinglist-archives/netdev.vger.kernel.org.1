Return-Path: <netdev+bounces-18073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEDD754835
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 12:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C835282110
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CB015BA;
	Sat, 15 Jul 2023 10:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E07F6
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 10:33:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2131.outbound.protection.outlook.com [40.107.94.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28ED35AA
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlXNBiNr3DcU2WO+i4wPKw4lorWr+x3GfUgPBoZkAtX+9W2EfEPhqd7ZoU2/SowsvxPy4QpZr1jWiGvnOUBNHe4TI9e6jWt47c4NmVhElHxOuoQConYGjuL3Amwu7OEaW5DBb90i8dmB0UWffTiCYmi099DeQDvCpgWHLxHLCpkPZgEONZGwkcAjjQm7gQSrkXMpU6sEd6yH+PmtyEXZODSweO+B34pIZJ4m0kIEvleQD5rAyQYJUBo8u97TxE/FoSoM/SQTJLSJMRGtsns417pGYyLp/oXlPkS1Ee3s16Ak5N5099aocjB0QWPuaIt65Am4TiS9wzyFhiAcZbAYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ynqgXwlkdQwNIcUU8JVuSTVyrgNAbYaMBFTJeT4tvo=;
 b=LA3kkCEYzm/ixmcRqC1yLpvW3Sbf35MrNY8qLNfI2b8mGgiI1+KZq/3ckbav5Jv++zBL8HfT9CaSuWa9gx1o6angdyQsVL3oJvnkiRYu2mq8dJaFBi3tpxBPc27uNXplcfdispeFiVKSCzQiG9VfQzRhFu1oKMGQ0FMrxcTeDwAysfab+amyZNle7JVikrqR3V7fiTHdyIz5ebpYlH1joXX9NRROptpfN4e5EO3JSQTKUcxPP/U/R0eNEfByalop20SRztm6JLeV5WSosJ1F6O5dHwebzR2jYfFzFL58S/Dbp56GjAGQ1JvrHmqncvZfVyelQblZlfwO5L6KDua4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ynqgXwlkdQwNIcUU8JVuSTVyrgNAbYaMBFTJeT4tvo=;
 b=hJDY9FX+yO9ovBU6vouiYcN1lWO98YMkjy1HOCZn+7mq4o0ZCKJQN14QzSB6+6pdtk+XsX3EaF/u9JCW54gDsNe3GmB1RYdOyFM+O/JYHwLRpd/jyyWtzaPrBDTHLNeBKqVTIlo7IgDh3L+JqSCNAzZfXcZ5ib3b/0qg6gLto+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB5130.namprd13.prod.outlook.com (2603:10b6:610:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 10:33:00 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 10:33:00 +0000
Date: Sat, 15 Jul 2023 11:32:51 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
	smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
	borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 13/26] Documentation: add ULP DDP offload
 documentation
Message-ID: <ZLJ109eXtIge6eJ9@corigine.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-14-aaptel@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712161513.134860-14-aaptel@nvidia.com>
X-ClientProxiedBy: LO4P123CA0242.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d0f325-e6e4-4026-1d2e-08db851edc6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YMpQLWYmuoNbxmem/3+Ut1zlEzJ0JRfK6/9cGsAoJriIkPV0p8+ebSGZHhTqsaEfO/neEc3Xe2vIJGdwrzcjMYEHCJpbWq/AebP9Na1LbW4DQ73etdjejVEj+gD5BshSQRSVG433p06pW64cIE4cobRbnBWRVy/+zL7DzR/o4m0feIUwM6yBvrHHT7cqwbP5CeDCn3A8bk3VO3d9zoy6OentjHBXmm65iz24IHu9aKzsoxhaptmSViNXJtH2IefrKGOC3LYdg/7TJTsUcF7ds08cAgS1OMrS0vV/NsQZG8MEsDWyyy0oEXoV8oHAuIL5dd1aqZ0ZhYQRTQ6JMU0PE1PcRPfxCWd8i//oWAteMMQ5gx1Yc9g+nEUgJlTAJLYqwTXqMkY4V4s/RzhHiSRvyK6HmtUyFtPVV9eSCIkC72dfr76sAIVHO9/R+mznUcV02ugt70bLtQ6JYoCSjnv2qgY3r4LrPSu1sWJy2IwCVR6ZwHNcbj/3r9QkrdKJ8u5w16nlkrIrrzVwP7VRYVv2DrM7zdSbtwr2eizFDcFtOIL+uqO6S6xrBTgMA024jZVx8IICTwSzBwzJjFBWw+0bkiCbDoR6xfluNhs7I94qtvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(136003)(376002)(396003)(346002)(451199021)(26005)(6506007)(38100700002)(478600001)(7416002)(5660300002)(44832011)(8676002)(8936002)(4326008)(66946007)(66476007)(6916009)(66556008)(6486002)(6512007)(86362001)(6666004)(41300700001)(316002)(2616005)(186003)(36756003)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FurAxektySl60J4y9/TAjrhuLhXZ5O6xR0BDHpp/Y4FDcqEOVxaxMQ4wmDB0?=
 =?us-ascii?Q?RTpDldTmkLnFqONhF51XcumqpYRnbmJLx92CYpIffQt7gKma7CwKOfJDj/fx?=
 =?us-ascii?Q?SsA2LYg5GfjHMnI5tPrHWyO0qAxCFuDtF29/bFFRWn0neKdI5zxOFHZ1A3ah?=
 =?us-ascii?Q?in8liIkVHQUAJ+MGQv8p3j9N4Pel9617pnUUeCA/d/ZuvBetUmeYR1BZZ4uG?=
 =?us-ascii?Q?pIQ5qptcxWipAipIcf9M6SVNRreM5Fg0I32zJchNQZkj1/gWl9sl1SGFGrXi?=
 =?us-ascii?Q?gnwlalPpns8JSt8BKpKaK5nFbCKscRW3MOX1V4NymrAvWaAe8a35Z+jHsGjv?=
 =?us-ascii?Q?0f9YGCfekUcWiIpj2yCsk0ce6NGKNSG6eC8wTAdR/BXgxTSasrBbmMO057Mv?=
 =?us-ascii?Q?1llcuENIz6nHY87yeEwTQ9KqqCrK90fxlAi9V24zNbypiHIAo/bKpNfOVZl3?=
 =?us-ascii?Q?f+rPhS3bBG1NaHdweegzxLlAptyaA96hkbi5efx4FnVT+k3ANAfjEdgzBWqv?=
 =?us-ascii?Q?0hOHy5Z2nOfHHF7qBXw1rZxLcLsNKBOntjCh/wUaVXLo70a77LP55OmRhnZT?=
 =?us-ascii?Q?dHPfSWkU90lc0UtNEfP2b+1fXPULiDlfNMcTTdZwbHDi5CVaA0Za/x+82c9s?=
 =?us-ascii?Q?Gbk5uodfx4SMqyRMBHAgnF4BXVBr8eYXrg7StsjNEjhkynmmVJL2qbK8eXiD?=
 =?us-ascii?Q?1adirAzXABoaLGnBoa2nphVUDae02r3JHrkgEV7/vf894bWrXeEE6nvxVAMD?=
 =?us-ascii?Q?hSkZ3E+i3i4boMLLKutBYJPPdt6bD+aFkHpzVZjQzlH8W+NJGYAf1C5b2tcf?=
 =?us-ascii?Q?bDv5WNhG0eqYnVAakT2amUVyrZMA+f74/Yagd8oRUNSeh8/3kY4qT/f7a6qG?=
 =?us-ascii?Q?B2L9iTCuZ1lkQeO0BBEuwgJcsSro+XiJiZFflpZEuXXIAvHW2Tio8sv4EdZd?=
 =?us-ascii?Q?qgJt6x27xXLzH9Ilfwz8jMyUp7KOPbf1hnzWk511HHrYNb9KyX1vJoDh7YWi?=
 =?us-ascii?Q?XM+Qs7yJwzWEqJHNkDC/CneLN49ID0+ZP/hdq3qvBSvwubGDrmdzwRZdoP6V?=
 =?us-ascii?Q?xP45c5kcZ30h22j5w6ElDVa50gmaDMrEyybFALmWWcCjH/QeN4kG78QYTY9f?=
 =?us-ascii?Q?nLlyOKCfFA+pReLHhPTAiGp2l6dLMlu+FDME7FvTTNZ4e/dNE+8G6Y5v4LHX?=
 =?us-ascii?Q?I7R3/YG/gPSYDibgQqXKbQRqTvACB9KYAgil/ZmbD15x1gBLrSHN9wFG2DiX?=
 =?us-ascii?Q?c9r0h6rbftrifRfdDm7DqOVsJBVs26i2YM3RTxBGxtyF10sBSrCR3zuTpmZt?=
 =?us-ascii?Q?x0N9rDYX/vAo5ZbokyYH4cSD/BR6NkjBSkOCDfOms+Q0Rmd2CgMiG4r/ENR5?=
 =?us-ascii?Q?q4JP/vErJQnJaSzQ0GD6WEwXgF+8QusUwjue1ZD0Kg7rGlAfc//0IEydZZ/9?=
 =?us-ascii?Q?07Oo5LgHGynZOdlDGXMmIg7F4NM6crNV8JCduWkSPFHs4DgS3aFekqi7ZVPg?=
 =?us-ascii?Q?gEzI+xtlbHFoQ34G31cN07FvFaIx6U3V3fhsC4QNSKBJwPzLX+tJ6lfoxI+S?=
 =?us-ascii?Q?T9+k6d76V5ybNYQ0ryB2DTRcrphTLKdYVSJv3a0H4Q7RGgJXMd6wyh1J6BgM?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d0f325-e6e4-4026-1d2e-08db851edc6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 10:32:59.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FpL1hYUPtf5TEYScDhy3pf/r/VZzQZN3zK2FtLh/4hhAC6b5dLMeYBt4BB8qHJB4tl5FT2pMOgWmG/VCUujkrgknDr9oQFSdj4sjBhZmTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5130
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 04:15:00PM +0000, Aurelien Aptel wrote:
> From: Yoray Zack <yorayz@nvidia.com>
> 
> Document the new ULP DDP API and add it under "networking".
> Use NVMe-TCP implementation as an example.

...

> diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
> new file mode 100644
> index 000000000000..b8d7c9c4d6b0
> --- /dev/null
> +++ b/Documentation/networking/ulp-ddp-offload.rst

...

> +Device configuration
> +====================
> +
> +During driver initialization the driver sets the following
> +:c:type:`struct net_device <net_device>` properties:
> +
> +* The ULP DDP capabilities it supports
> +  in :c:type:`struct ulp_ddp_netdev_caps <ulp_ddp_caps>`
> +* The ULP DDP operations pointer in :c:type:`struct ulp_ddp_dev_ops`.

'make htmldocs' seems a little unhappy about this for some reason:

  .../ulp-ddp-offload.rst:74: WARNING: Unparseable C cross-reference: 'struct ulp_ddp_dev_ops'
  Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
     struct ulp_ddp_dev_ops
     ------^

> +
> +The current list of capabilities is represented as a bitset:
> +
> +.. code-block:: c
> +
> +  enum {
> +	ULP_DDP_C_NVME_TCP_BIT,
> +	ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
> +	/* add capabilities above */
> +	ULP_DDP_C_COUNT,
> +  };
> +
> +The enablement of capabilities can be controlled from userspace via
> +netlink. See Documentation/networking/ethtool-netlink.rst for more
> +details.
> +
> +Later, after the L5P completes its handshake, the L5P queries the
> +driver for its runtime limitations via the :c:member:`limits` operation:
> +
> +.. code-block:: c
> +
> + int (*limits)(struct net_device *netdev,
> +	       struct ulp_ddp_limits *lim);
> +
> +
> +All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits`):

Likewise, here:

  .../ulp-ddp-offload.rst:100: WARNING: Unparseable C cross-reference: 'struct ulp_ddp_limits'
  Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
    struct ulp_ddp_limits
    ------^
> +
> +.. code-block:: c
> +
> + /**
> +  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
> +  * protocol limits.
> +  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
> +  *
> +  * @type:		type of this limits struct
> +  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
> +  * @io_threshold:	minimum payload size required to offload
> +  * @tls:		support for ULP over TLS
> +  * @nvmeotcp:		NVMe-TCP specific limits
> +  */
> + struct ulp_ddp_limits {
> +	enum ulp_ddp_type	type;
> +	int			max_ddp_sgl_len;
> +	int			io_threshold;
> +	bool			tls:1;
> +	union {
> +		/* ... protocol-specific limits ... */
> +		struct nvme_tcp_ddp_limits nvmeotcp;
> +	};
> + };

...

> +Asynchronous teardown
> +---------------------
> +
> +To teardown the association between tags and buffers and allow tag reuse NIC HW
> +is called by the NIC driver during `teardown`. This operation may be
> +performed either synchronously or asynchronously. In asynchronous teardown,
> +`teardown` returns immediately without unmapping NIC HW buffers. Later,
> +when the unmapping completes by NIC HW, the NIC driver will call up to L5P
> +using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops`:

And here:

  .../ulp-ddp-offload.rst:283: WARNING: Unparseable C cross-reference: 'struct ulp_ddp_ulp_ops'
  Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
    struct ulp_ddp_ulp_ops
    ------^

> +
> +.. code-block:: c
> +
> + void (*ddp_teardown_done)(void *ddp_ctx);
> +
> +The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
> +in `teardown` and it is used to carry some context about the buffers
> +and tags that are released.
> +
> +Resync handling
> +===============
> +
> +RX
> +--
> +In presence of packet drops or network packet reordering, the device may lose
> +synchronization between the TCP stream and the L5P framing, and require a
> +resync with the kernel's TCP stack. When the device is out of sync, no offload
> +takes place, and packets are passed as-is to software. Resync is very similar
> +to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
> +
> +If only packets with L5P data are lost or reordered, then resynchronization may
> +be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
> +are reordered, then resynchronization is necessary.
> +
> +To resynchronize hardware during traffic, we use a handshake between hardware
> +and software. The NIC HW searches for a sequence of bytes that identifies L5P
> +headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
> +type can be used for this purpose.  Using the PDU header length field, the NIC
> +HW will continue to find and match magic patterns in subsequent PDU headers. If
> +the pattern is missing in an expected position, then searching for the pattern
> +starts anew.
> +
> +The NIC will not resume offload when the magic pattern is first identified.
> +Instead, it will request L5P software to confirm that indeed this is a PDU
> +header. To request confirmation the NIC driver calls up to L5P using
> +:c:member:`*resync_request` of :c:type:`struct ulp_ddp_ulp_ops`:

And here:

  .../ulp-ddp-offload.rst:321: WARNING: Unparseable C cross-reference: '*resync_request'
  Invalid C declaration: Expected identifier in nested name. [error at 0]
    *resync_request
    ^
  .../ulp-ddp-offload.rst:321: WARNING: Unparseable C cross-reference: 'struct ulp_ddp_ulp_ops'
  Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
    struct ulp_ddp_ulp_ops
    ------^

> +
> +.. code-block:: c
> +
> +  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
> +
> +The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
> +The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
> +a request is pending or not.
> +L5P software will respond to this request after observing the packet containing
> +TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
> +software calls the NIC driver using the :c:member:`resync` function of
> +the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
> +net_device <net_device>` while passing the same `seq` to confirm it is a PDU
> +header.
> +
> +.. code-block:: c
> +
> + void (*resync)(struct net_device *netdev,
> +		struct sock *sk, u32 seq);

...

