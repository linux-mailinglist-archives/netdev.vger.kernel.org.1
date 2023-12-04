Return-Path: <netdev+bounces-53461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344BB803130
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2041F20DD9
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93624224FB;
	Mon,  4 Dec 2023 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qjOtgT2M"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C2127
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 03:02:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt6NEqb21k0ns/iLvwn57kxXM2JPqBPMMzFZGM7cS2dx12zxxjPMscgRu1WJSW462PuMP1FcgpzLLKggH5xEi8jqoxU3mBlYbY6quKjudaI3wq/srMGawe+iA3wnYWtQWiZbDO3e0bPwtAxcqai3omrIvcL5frpstuR3YuKtVf7y2t04KUcw20JxfFI65NV8sx1q29PKqztn1Ng+gM8nREB5wFgWeDeVcf12G23zA87FxqnfZPy4Fv5Tu7n5rh5uSZb4GYbITYSR6NhccMt/Gmh0r0fvGs/Cr2tBVd5pia23K8sO5X2khCtS1mcWThJiNH7UT7e/5X9iLxE6a19ceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2cztyqmRfMz9NRk/MnJGed+E78AstEp+Vn1KgsdmDc=;
 b=XlonCVzit4+Y8b9jxTfE/UtJNk3PiAXW2Nw9buTGl1mQOio665IrgbW+e8L1kiBIEBsZiBWU9b+Sfpfdp1IjWROCKZ8XHBQNN5QE4CP4qt6+sZA2JfYa4d1r+kLuAqnSGwf8Bh7RyGtvPb/nVvnjZl5CFMJkFNAnpiQtnx4OvQaugPfYJ2vF+rO5/3e25gxFquvSL8K2q+P5W1ahjf6pUDjIVH20+yX1Z/JD3fWr0egtdzGZAiYVk1/G/j2ir9HBzXWVo4ht4prnlUQpuKFsCeqcH/fyTjMjgREyFBmxD2w0oI+Zirgzkyp6itypD4UaU/VyqsViuPrw4lHVhUgITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2cztyqmRfMz9NRk/MnJGed+E78AstEp+Vn1KgsdmDc=;
 b=qjOtgT2Mwxo9vyoGS+P4DO0z8OTCvaBEvO+pzhEEy66NzU63m9h+2lm37KijUZOwguXkY8GpfGx+hjGBl8l1H62hO+i0k96o5oIVhU2h8oTMW5tAioakae66N+26HEn6ANvYIOEXdSLpOsoJIQeUufbNgo0Kcpi4nSrITPYRbOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9310.eurprd04.prod.outlook.com (2603:10a6:20b:4de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 11:02:53 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Mon, 4 Dec 2023
 11:02:53 +0000
Date: Mon, 4 Dec 2023 13:02:49 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: "Varis, Pekka" <p-varis@ti.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Vadapalli, Siddharth" <s-vadapalli@ti.com>,
	"Gunasekaran, Ravi" <r-gunasekaran@ti.com>,
	"Raghavendra, Vignesh" <vigneshr@ti.com>,
	"Govindarajan, Sriramakrishnan" <srk@ti.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH v7 net-next 6/8] net: ethernet: ti:
 am65-cpsw-qos: Add Frame Preemption MAC Merge support
Message-ID: <20231204110249.nwayybk5q4uhsgsa@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <c773050ad0534fb3a5a9edcf5302d297@ti.com>
 <96c4f619-857c-4a28-ac86-5a07214842a8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c4f619-857c-4a28-ac86-5a07214842a8@kernel.org>
X-ClientProxiedBy: BE1P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::8) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e08f5dc-8a07-4382-702a-08dbf4b88fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	91hE0XcIJBnWEevS7jR0nJZg0KvULMAAXwwOdhV75umQs+sa0MzaB5VjeA3bkk8ah7pjwU6N6RrPX+jO92Y9xxLmFpsvzJxiPAOGFQt/0bR/o3w6F2uCIWC7EGenTw92Rz/c/6sknWjYuW427kacxnQv1HsiKxTxzAckbq/IVTnL5Rcz412nC+d6a0NlpwNCJjImrBzB+cGZgsC+F4cFD1SX1sSGhiAGoITF99n9j0HRvsM/upu1eibORf85zOlKUn/aDCpUAyiETx84uD4QUgL0URCQp9AIDWdFW/mWkfGNRmakOzhFhwJpdMGrSnl7i0Ndb9/Vh8wP/8Z8gdvEb8t+ymTd8VR3aZg4oUqNRRsmvDiYwtnFEvqEg/KVjibuUkMiT7JJBayLqHx0ChGp6AlPqWp5KLm5C7kejBKSB8Pz/neYpIcdHnUjfCNeCJWgz3PTm4JNmb+qTXk0L1+AyeFgtTFEmQRuKqonhJxxbvHwct6D1yjexXmtf4BaQtDgdq/kgwb2JegSVncE9ggQW1W9knisw+HiWVUNxS1eTtg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(6916009)(44832011)(54906003)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(7416002)(6486002)(33716001)(38100700002)(83380400001)(86362001)(966005)(478600001)(2906002)(6666004)(1076003)(26005)(6506007)(6512007)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2K0QTT98ysvast1ZEJ8/76tyhUoBac55vmojDYXrSvo9QALq/4zybDtsK4kp?=
 =?us-ascii?Q?fjbDCMJNeovaIQ4p5ofprGxyduSUDByWqGymCT9Clo9t2KHUrInmXlk0/Y39?=
 =?us-ascii?Q?xJykMdJQC8eGP9xE5HC1KFcvEG8cEs6t9mt+NlaiL5F70A6T5gXokOvZx9qV?=
 =?us-ascii?Q?YTwvKTT8S7RjqXb0ESStv3dMVJSVyYS5Dpkjqn1aR7XlVRB3MQQ1OiSBcBcg?=
 =?us-ascii?Q?YnF6pP1Sf73FyVqLyzE7Jx39vj6XnLkOmLSqD/70M4ILSTGiIPMEjFnNXiMm?=
 =?us-ascii?Q?YhAse9HElxCHAYiUzg9XR7ins1Mw6vXlWL8AEoFyf7EiiSg4AToFD7DbnENN?=
 =?us-ascii?Q?zMkOScO8VzN06vnH0Yg7c652CRT6I4YgZVA066Jh5eyU4MPYA/bBjW3VV4qw?=
 =?us-ascii?Q?mS/ULSXOAIYSYUiFbFNqZ3/P8A4RYmb0Dfzge+Xk81mlReuKj8P7Ku6UrwSR?=
 =?us-ascii?Q?cLtBtKZvrEZ8GlcPUOK/jSCC7pR5U17rMX71DAQD0Jutp7QJGtAzbbDcFN5S?=
 =?us-ascii?Q?9ooWqbnDmTsVLLnBvKmoRFXSYHQcq23hXXWAekSaRyEMvwVjvO90P+SeTsrN?=
 =?us-ascii?Q?MA13lIVcZigBEvkO7a+cuWv9kmdTe4+OpZlrnfWB4aWPtiWYAljh3Y5M3ER3?=
 =?us-ascii?Q?VoGF2U1kVAzZo5P5ifgybRKLa/XJm/SjuS8HzMx3WQ4RBKAsk2FEHY1Q7SDM?=
 =?us-ascii?Q?ywD5pODpi1aJA5plcwlRGHgyTuYu2tmjk6Pm0TEgfGP/xFRWviN4HHOFXExu?=
 =?us-ascii?Q?wGc5XF80Lia/mejtrtShu2Th1R8yhdJlKKG8IBBxwfIHI0AFuwAyzsEAdoJi?=
 =?us-ascii?Q?f5Rd6vlRN3nAQhOAEGDgV8h2NMibYPkURGrkiY3eIEKBMb7aGWJe6tDe2HIg?=
 =?us-ascii?Q?Tue80ObJMH5lzNNe2JA99u18ByZjZ8c/dKLgtuM6aazFGxhyLdB01VQwuE+4?=
 =?us-ascii?Q?vmKAu1U4++UqkVZW+LEYVMK6sxFkemrkl3E4373MWO8eunIswPjW63FurXbE?=
 =?us-ascii?Q?YE1hoNn6/c5oo3N7VWImSDQvu3cux173QAQpjeQFa4Km09CEsQSSBAS2sPlC?=
 =?us-ascii?Q?g2jLqFzkXOVzWqSylm+4bRvs0i6BdDuYAPUkJ+2A3bd3mHXJM6TD/NT+0mIr?=
 =?us-ascii?Q?9jLEL2JGoid6nt/WepjXXHNb66mF6UCbMQmsMkHr6p+YTpr+xPqHDFBxYWP0?=
 =?us-ascii?Q?8Gia7W9QH9iRMDgVjQpEZOfWoqWyZKHiVwc/QIpsKO97MkMPoRCQgJFxCwD0?=
 =?us-ascii?Q?sPLZmswh8Nk77pBs/EH2tOlPv5lLIqiULYfPNS3U9mCeXbxgC0cKJKCaBkv/?=
 =?us-ascii?Q?ALyGEp5mVOr4lvf6fx5THhcdY742pm7SWcMJUaBfGx5FTgWEnjgOW7vshNZa?=
 =?us-ascii?Q?dk9bWXIT9ExFqLaJXfHOJ1wOdLdC5xDYXXYYI7MqxNlj1+OOF0PZexvQ3oAp?=
 =?us-ascii?Q?r4jDVb8yBLxxChtZ3XgIpfTVuAQFv38wLiV+DKyuWTuGmM6v5IhBh7KMm8Jc?=
 =?us-ascii?Q?qWjh2bJcEwS4aI+CrSx3miOUjqigCJBuI16XyIaNf/GAP9grFCbUvLq7cgBs?=
 =?us-ascii?Q?3B8TLrilimfT2wquuCu6kV9pFfGNRd/IkPVZPl+AbqcPxSeNyr2FRGKtjVcL?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e08f5dc-8a07-4382-702a-08dbf4b88fe6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 11:02:52.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOg7ce0IoIHIWZgzn2KMFq7B/K8HtBZLzzRYiG1hK0H0kT8YWE3LQbRdO3wuEtSAKNusrIWUtQAkvXNu4LSYGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9310

On Mon, Dec 04, 2023 at 11:30:53AM +0200, Roger Quadros wrote:
> >> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
> > 
> > Should be 128 not 124
> 
> User space setting is without FCS.

Technically it's called mCRC for preemptible frames, but yes.

> >> +	/* Errata i2208: RX min fragment size cannot be less than 124 */
> >> +	state->rx_min_frag_size = 124;
> > 
> > /* Errata i2208: RX min fragment size cannot be less than 128 */
> > state->rx_min_frag_size = 128;
> 
> ethtool man page says
> "           tx-min-frag-size
>                   Shows the minimum size (in octets) of transmitted non-
>                   final fragments which can be received by the link
>                   partner. Corresponds to the standard addFragSize
>                   variable using the formula:
> 
>                   tx-min-frag-size = 64 * (1 + addFragSize) - 4"
> 
> Which means user needs to put a -4 offset i.e. drop FCS size.
> 
> Drivers show rx-min-frag-size also without the FCS.
> 
> e.g.
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/mscc/ocelot_mm.c#L260

Ack.

