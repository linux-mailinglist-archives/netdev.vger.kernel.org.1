Return-Path: <netdev+bounces-186973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34846AA461E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A54E1BC7AC9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913F21ADDB;
	Wed, 30 Apr 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YjUeL9fU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE4213E89
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003512; cv=fail; b=V1PS0HWYNCY86uvHqPZm2W4eXR/4TQ1WJca5sykbhB0LHH++bXOjbKmdwoo8FPNPU0jQBVb0vr+Q+rvhHpG8U4KCxbGMAqbhkoUah5hWbkoiWO8Sn0YtqGLyRcBVTMtbhvTHH47ZWRjhWY3nrC0/i90Z4GFqB/hJ7v4kDDO4Jo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003512; c=relaxed/simple;
	bh=f5q4weTsTqTkk7U3R5f4fHVDaKtwDTqqY3GqfoZsK0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDU7KutHpcWwz6EC3mUpZhY76Qg48SrUqTJDlVdnT0GCc22r9aE4946cB2j7JXsl3DthMt8OEko2/II8TM4e4x22HVGUgLNvTybq71cgTeaAziy+y8xjWEiZyrgj7Mx8rgyft6+qCL0rEH2d9ZgO5a2oi4bTOt6cSPhr7LWLIRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YjUeL9fU; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHK4XqtNdnkrNA8W1EMksjjS4Q5K04ziQqdAX1q3a6lP+CoRVScAsmrOKbw6inAG3Zt0JNq2bCRne8Xfd4M3xrii8oyrOUHcGvFnFGv0FqSVpYZoIb9oMVEBG2WaAYQt705ff56ehnbAiMIPahvpSDdyT+eDSqgKZUcG5yqaNQo+3fzzfB6V7/xXx3WVfyhbYtzLmNwgy838wj/sWlQ3cvAhemOU1KAGK1qQdXdVP+U0iY0GDXBbR4ooO0jaOyJ/cOun+QfRUm063dBEEQX7nd1OlqcwEjNRQ2ZNNwZ6femkGs+WevNgwUIUM2UaDiQmx2Ja0Zp39aOarBHwzP5+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2cB9pJeodBh2jdlfxerlysdx+w39Lrl//2mbdV57ko=;
 b=dqsLHsZqu6Nro4sMx8D/vowraMXtI9aw8YLldOH5nD+vZajKhjymcjHzgCfXCxkZcU4vjGL0p6OnLlDWe8xWHC9zBf+Q3rMN3V+rYaYJfaQvDvnBCHSq/6WMH9DaqZ/eLynwa8pmYNSyVfCfQueOtnGs335H1yg/p+KlBY00EVV7d1DouCY3jP82TxC24aNe0Ku13UhSBsqkwdVj+E+9vJ9baPoj3+JWlnZr9g856uaXYqfEvGfw+hcFGEDr9sfOgZzoUaxDugrh9xQpCiP6eQozw8+r72zr6hPfX5C9c0Hvpyd394Dhpqrjhf80daA2V4rEw1NhYEzJSEjAhcuRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2cB9pJeodBh2jdlfxerlysdx+w39Lrl//2mbdV57ko=;
 b=YjUeL9fU2aGydfWyF56XbULClg38H2v9aVpKomFcepPAvuVf4Fje4QeM4zx97jRRfyjy+lGymixy4KU+bpTZZiqPreFfW8rhYLxEocZL8qP8DumoCTpZxklc6A6rYWeCncvdepBNeZV6nmWy5WRZy+y6rplWVxKMT3weHDAS1Rc/dU5dJNrn3h8k/Pltzr/mBwZrbiNE9VidAgC4aQaO6NpHViQCUytwR764t6uB8iEKvzCa1ZTPp85ueuf4LGcd/2+SJxebsjqBTwsEmyUJd/U3AbrBqku+l/fqpYeWSzD3DjTRfMq/PMVgr/JMHp58cULlUnf7QPTlL8B6l7X1kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 08:58:23 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:23 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v28 06/20] nvme-tcp: Add DDP data-path
Date: Wed, 30 Apr 2025 08:57:27 +0000
Message-Id: <20250430085741.5108-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 35677b41-2373-4c80-aa09-08dd87c529b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1q4gR1300E9YLY0H471AkN2UZ2JZaACgxexZ3BhEs9uwD6rLEGR9rJun9jNl?=
 =?us-ascii?Q?c/b0vCq/MTeobPCqPn3GR9wMszdhcpuD0l4Yql3MIESXMOGh/FrOrRg8ePvY?=
 =?us-ascii?Q?mBQscmb72VsxrkEEzo4TvaSvgCzU07FdZbVMLHkNFyChFxMthG/hW9mxxMkO?=
 =?us-ascii?Q?9CFwza6kNuaCBAAVsNGP5DwuZTdmI0rWdWBAxr3xQHqz+ec7UaLuZrTrmbtK?=
 =?us-ascii?Q?Gu8BwulcigEFJL8FEcVk3cIusucId9fL6afd8GH3yu+TMZYMr5syEZd5E5X7?=
 =?us-ascii?Q?+YKZmYwaUblzbHqwDlgKzEDQGn9qf8TquMkDVao5engYg0EALS6oldeLH7Ga?=
 =?us-ascii?Q?yOvEhSMPwG5wzyuB9H8XuT6vuDDQSwi7zvagIxQ9kVBaIrdPlu4hH1dN024y?=
 =?us-ascii?Q?eTFxLCL9DjUQJKh+6gi7psoVPxQ3HYJPjb3lZRfZ27DgOGK04VvnO+ZjSKh8?=
 =?us-ascii?Q?Ga4Bnv9MwUpz0WwQ/rPgfQrBfRrHu4bUQxDkMXf/ZBoi8oSfGqkTYxFDA/DY?=
 =?us-ascii?Q?z1AUL6soDWBS2uTNyeqyUIFHovoE3a3G/8n29OPshy/34HZqSX0CB+836qeT?=
 =?us-ascii?Q?S7vFBTKRcVzy0Fktam3POxhNzztJzgkds0uwM4rGi03sp06svLk731x62tN/?=
 =?us-ascii?Q?ER5ihsRAPGrarriZVIJdCbm9NAkn8X6pnSUpEB2eKn1NddzYCZ7uvCHN3+s+?=
 =?us-ascii?Q?aYdx7I0VbTRHPZWjhzT/Yl9X8bTjulLphWWQ2EOpuRYjx/rndTL8mG6RZv6H?=
 =?us-ascii?Q?sJaby6t4OABQRpFFfC7hcx7k9yKas4rXY+zLb8lysmXm4z1ay/fX9N9V+5B5?=
 =?us-ascii?Q?MOhk2OyKoNh1hvqdVCu3xYdUdBKtIZIzOTUuLw28lAlqUr9VcMSIaxkTulK0?=
 =?us-ascii?Q?YJfeWLzN5ot8hBXQBqzhvJBnwJ52YJ/OtWqdFcWT/7/WZJXrUDtVbRsAG+pV?=
 =?us-ascii?Q?WTWyVcNIKqhhM/R+RuB7TD26vx7Ktl5V05z+PNR1GxZtvUE59OnJhEb+1Lqd?=
 =?us-ascii?Q?nJ6ok75sQ1JLhFvs68mNr69MaujFHI2YkPc+/Po1cYw3rQ9JJUSHr26D5cPa?=
 =?us-ascii?Q?Ir2SmpjKlcpAWFMk811j/rgDJPbchWNFQuDNRqZOry9zqhVQIiPV2AwjmlyA?=
 =?us-ascii?Q?gWOHIr3p59bNwIC25V62Bt9oyIHIT5ZBcXSMAqlrCaoFiCj5PBuUlDLvFG+9?=
 =?us-ascii?Q?IaKuI7DE29ek3W+xrbr+GcaLmRSdgNezqCTESV2Wyc/9k0kbI1id6jjMipNP?=
 =?us-ascii?Q?F47gi7MYrVmK5I8hEWT6MUQ8dIkCbZyP0mU/sVPMrnVNRWaxL5TMddku3c+B?=
 =?us-ascii?Q?FegfbUfs1Sbz5Ok3N0ibhyX2eIMPSsy+eAWo3SSEpTuZfQ4kEBlQ00Xy/dhQ?=
 =?us-ascii?Q?y0ZYR5ZHikoUsxKFx3wxv3hj5LMyujmudzAS36becwm8e8+roA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GX/i64lKnfJarHbl2FRQCJJ6//PoGhDRJECGCordAOHuyJkn93ZHrgTo7bGu?=
 =?us-ascii?Q?r+J7/nes4mizh934apbOCeFb15OQFp/+eGajChnyEWbJ/lnIHBwhyVB2X/9v?=
 =?us-ascii?Q?LdcoWHLvcUmqRbViw/2Y6kGQenMYccGhvWExpUKwZQ3muNlSUiE4rCKJSfFi?=
 =?us-ascii?Q?ZZP2PYu76wEPy+Q/EtilS062flK1OyeH2zIa9P6Vua7eT70pAi1SkAxk8I1i?=
 =?us-ascii?Q?CwHlx1fSNlzL7sNRNoAXSxozDoS+9i1YTOnPwRaBZZ2BTY1lkSpLKB3KLbyd?=
 =?us-ascii?Q?W5r9L1kWlXZzB1o9RCBNU1YbEs+2+t8Q8Pvk1PXWpzY6rOjFLLiJ6JZ7J7IJ?=
 =?us-ascii?Q?O1JeTccSj5CuJ/Zy43k/Ii+sFzh54BtCNzwsJ8jLidOB3wRifpErdvTLpgVv?=
 =?us-ascii?Q?/rTSoFa11/TF5g4Mwkrr+Hq7vzhTZhbDYDX3HfBEM175ccy1P4ZdxIbTaOgQ?=
 =?us-ascii?Q?8QUgTEUtYMPiOVQCFpeL3jfrtafQV/d52MDbq/0Ph+kYb4quYbnpJtawcOxS?=
 =?us-ascii?Q?E6y2NtcpACuNo9jCIgCbaL2d7sUMzNu/cuLMm7cByVNKZjxCz1whiGyNdEHT?=
 =?us-ascii?Q?JUsB6idC+XU8ro2vku3FBrOyyIefwkqsOd10UysJKoo2Q7hT1iuc4vZPZo2e?=
 =?us-ascii?Q?K45wksZTyiRBBeEI02etLu64Q8u4UvYalwo9v4NyrMQMrpRzT97oxngxH6AX?=
 =?us-ascii?Q?1QRlfnGtF+fz6kjjDCNNhsZ0PzS1XJPxYeH+hXObtOjmnlJgaWiyYG8BVuQF?=
 =?us-ascii?Q?/USjYk3ohHdKtrYemK7TQFbUSgcDzTzdN6CBfL4SncblEflELy/UN0mDGrPD?=
 =?us-ascii?Q?GHezhh7xbZ30i12KwXsF7Scz89sLtOHbiX1ZriUVT31TsF/PTD/wgSunCeF5?=
 =?us-ascii?Q?LqVIA4K+bfIXanyW9UxbUeryz0WG4aMcPzRpjFZ5wvA4/mosxwZNJDbXQnsV?=
 =?us-ascii?Q?JPrzfhMS5Q+RysZ9zrkd/XzKPX1IYIfGxadxZ5CxkuorlvCO4qIIkR7dAfdE?=
 =?us-ascii?Q?fIA9LNlantDH1fb1IZfrvBYZk5Sr2krsDxDBqfyjunSaBf9fhUtlotALjzbX?=
 =?us-ascii?Q?ujUbckulNcbVyIrIRgkjuw+gg2z8M8aB8mUK36sQ6k8dAooqP1VCceIHAwIX?=
 =?us-ascii?Q?Ra/4iX3OcQOj5JWxN6qw1+GS9kYuhj52oTpYCkbsVb30k8DqhPomISBER2zZ?=
 =?us-ascii?Q?Ja+yBjJ1e85p7RtQJmr8pMAETDHQhzlHAnICGoh4UK4Kh/a2u4OMBID2SVcv?=
 =?us-ascii?Q?NhPaGoBaazao9EmVJiwCG0iwJpb2gEVNI13h5h1unOWMi4pJiaHRnei9bgOr?=
 =?us-ascii?Q?FrH5Cl/m+hS9gz1XPOYyUQEXEhF6UR2+NgjxFQLFzBzjXrkGeeU03PNXVhhZ?=
 =?us-ascii?Q?NsZ196Q/afPj5IAS2eX//JuKIylyTo70mNUpB3GpZEdH+eRHDSgLgI/ZyTDq?=
 =?us-ascii?Q?invcfpq3FaslUqkKXA/8qIl6sQ8TSqnmpoDfu5QHypBPh4A9453ne5UHzJSZ?=
 =?us-ascii?Q?vWvj4EWfgJwn3Oi76CkMAz2s3rNElI0jGJiL11ZO3YF36C258m9m6nkm2w9H?=
 =?us-ascii?Q?+tbiqauYSNPB04UHPc0+HknJ2YilC+47+wXYr2Xh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35677b41-2373-4c80-aa09-08dd87c529b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:23.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35b2xazQEuKQLSv+yCDj3/0AzhoYsNV5mpHiD5qwebtuD6AtyPHwxt3CauVOck9CDEWCPZa1C2JxFsOLurykzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

From: Boris Pismenny <borisp@nvidia.com>

Introduce the NVMe-TCP DDP data-path offload.
Using this interface, the NIC hardware will scatter TCP payload directly
to the BIO pages according to the command_id in the PDU.
To maintain the correctness of the network stack, the driver is expected
to construct SKBs that point to the BIO pages.

The data-path interface contains two routines: setup/teardown.
The setup provides the mapping from command_id to the request buffers,
while the teardown removes this mapping.

For efficiency, we introduce an asynchronous nvme completion, which is
split between NVMe-TCP and the NIC driver as follows:
NVMe-TCP performs the specific completion, while NIC driver performs the
generic mq_blk completion.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 136 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fc9debd64900..498b524b8eef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -129,6 +129,9 @@ struct nvme_tcp_request {
 	struct llist_node	lentry;
 	__le32			ddgst;
 
+	/* ddp async completion */
+	union nvme_result	result;
+
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
 
@@ -136,6 +139,11 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+#ifdef CONFIG_ULP_DDP
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+#endif
 };
 
 enum nvme_tcp_queue_flags {
@@ -372,6 +380,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
 #ifdef CONFIG_ULP_DDP
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return req->offloaded;
+}
+
+static int nvme_tcp_ddp_alloc_sgl(struct nvme_tcp_request *req, struct request *rq)
+{
+	int ret;
+
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		return -ENOMEM;
+	req->ddp.nents = blk_rq_map_sg(rq, req->ddp.sg_table.sgl);
+	return 0;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -407,10 +434,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 }
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	ulp_ddp_teardown(netdev, queue->sock->sk, &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
+
+	if (rq_data_dir(rq) != READ ||
+	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
+		return;
+
+	/*
+	 * DDP offload is best-effort, errors are ignored.
+	 */
+
+	req->ddp.command_id = nvme_cid(rq);
+	ret = nvme_tcp_ddp_alloc_sgl(req, rq);
+	if (ret)
+		goto err;
+
+	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
+	if (ret) {
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+		goto err;
+	}
+
+	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
+	req->offloaded = true;
+
+	return;
+err:
+	WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
+		  nvme_tcp_queue_id(queue),
+		  nvme_cid(rq),
+		  ret);
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
@@ -519,6 +604,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -536,6 +626,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{}
+
 static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
@@ -817,6 +915,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	req->status = status;
+	req->result = result;
+
+	if (nvme_tcp_is_ddp_offloaded(req)) {
+		/* complete when teardown is confirmed to be done */
+		nvme_tcp_teardown_ddp(req->queue, rq);
+		return;
+	}
+
+	if (!nvme_try_complete_req(rq, status, result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -836,10 +954,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
-	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, req->status, cqe->result,
+				  cqe->command_id);
 	queue->nr_cqe++;
-
 	return 0;
 }
 
@@ -1093,10 +1210,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
+				  pdu->command_id);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -2941,6 +3061,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2979,6 +3102,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


