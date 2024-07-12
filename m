Return-Path: <netdev+bounces-111009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9845392F410
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC9A282AF4
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A38F49;
	Fri, 12 Jul 2024 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pgeR7gtP"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020113.outbound.protection.outlook.com [52.101.56.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822115E90;
	Fri, 12 Jul 2024 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751806; cv=fail; b=jt9+bgdpKdSMhy4zw1lGECKxFm1hafmRscEgn+Bh5aIQJh4JUFs17iODI/Ut/myRskwKdbmIwz7aMK3JGAUa2BPlm+OgxQCxBTAH3dAc1AE1OiAACH7B0Ji+rfyaIUk/l7PSVK8ZELsKoynCiJcx9nPcEZqSNU4r1pmSLwYb+RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751806; c=relaxed/simple;
	bh=RBcV04PB+DF6Pg1gpsi9WX4+PWwIsc9nRVbFtK10enw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2k+EHSSHiv/nnLxL8416+m9iBVPDa5dLOl3XP6fTV3gMafimK7VHZKf6bI4vi+OTKblflSs5D2ornFEeeMJxD3PUP3qQLE+ySscTmBhxMUVPD1UGql+pOxo/YqU2p6lhbpXGXV2HINMeWB1lfihYQPKF3FnraWvDHCcwIlg+gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pgeR7gtP; arc=fail smtp.client-ip=52.101.56.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neieZLB6jc4DHQR7cU9V7odsSR+oXhO8NdKDfURkfYqDBYcPK1P7bWnq8qnZgAz0SKvASJz4NG9GUW7L3tvgi5iSD6eVE2l61tmRxGZQs3XzI+1s8atxaNXp9rnjKNgcZuhJKyHhhlsrYK1KCkN/Zf+pJivgE0Mme0GQO0RRgEgBTqWUDNu8EIlimJQiEjf/T43/yoXbxcgORZSppjD+FZNkrQZUJqjkWDmruKD9a+TPtyfhEtARP9o5KiBd22/CS+QZ2IPHfLAo/Z89qU3brNNTK/RFtehhhKnpKpusS4G8NNLRA2b6yf0xRFPFXDISn98JZ2FeJugtjG4xFzOgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUmvL4jfMaiVyDSy+Lh07r1M1t6TA9C+yMUTpASKCVU=;
 b=C1Rfbj3M/nX/ivsxTxyxtJqAvtmxl+0qBOLVCQl4+zmw5sDxyh3+zD2VICJBtYd2BdaVLjhojQce7h8N2HfnomVvJuZXqj8uHvXJ4izzu50c0loY/JtqmHEkC/8ejiqypuwmGyx3d8c1kOl0nld2evCprou0RDd6Xz9Smb1hibzGs/Zon1IC6MfRbqnM3KUQvgWBXKWqJ/xe/Cdrep6xTAajir+mfPsPH7ySj4No3qAnmzCcPMzkMwpxTkOYZdyDc3igek98/7MdfdxBCLD9+Y8Dz2Ae+/P+WUeZHhgZ0QU9vwCn+1tpNtVwdm5m3zsexSCTAJ7Dx4sBsexLsaUimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUmvL4jfMaiVyDSy+Lh07r1M1t6TA9C+yMUTpASKCVU=;
 b=pgeR7gtP5zjHp8eRCrCzbJMHaYDdtqeMSRodEns5MpMJWr12hQjatGJly5EHA2VBnSyZb7Suv5gXfMGaM9WnltoFXLaxZ7ozGdx/slbl7nsxBJN/nWKBtaE+WfrLjR5CHkZDycEDjmy/Vk1zs3jqPbmMu67bBsS+k8INrojUia8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BN0PR01MB6990.prod.exchangelabs.com (2603:10b6:408:16d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.22; Fri, 12 Jul 2024 02:36:41 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 02:36:41 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v5 3/3] mctp pcc: Implement MCTP over PCC Transport
Date: Thu, 11 Jul 2024 22:36:26 -0400
Message-Id: <20240712023626.1010559-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
References: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BN0PR01MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c6d535-a0f6-4318-6352-08dca21b7653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SXW+A4pRUdvtgjc8pIHMbFdfzKnmvT3ptDTikIHI3OHZfQaqkNBjmBze5nQ0?=
 =?us-ascii?Q?ydJNuRCcuZ2S3n+39IcnW9v/0/1RDGeZevpAhX0iFtoVqX8TX3HjdKXoHe5D?=
 =?us-ascii?Q?Xg2Ox2CuuXEk30gbGuhf1r51+S5bDorfdy84YLWxQcKFL8P3UXpr6N74Rwh2?=
 =?us-ascii?Q?B6fYYqcfesVYHl8LaQ6cyFkVw1keiR+YIvILTwS9hLSC2jn9brsNU7g2GN8F?=
 =?us-ascii?Q?tE22LJ45vN0mPNMvdk3Ad6yDyu/1dfyhgbq7Dly61z0nQZ3kcpgyZkEHG3yz?=
 =?us-ascii?Q?6Qngz4pbsecnyd5UjP2TUcv3CcnIqqBBl1wQ2Lf1ti6fSztpxKxsK+xT7v6u?=
 =?us-ascii?Q?I3kebvetQ4TW+BZL3R+QCbPb30x+PHNf8oHXu/VtXvllNbvGUEtY+jR89Iqk?=
 =?us-ascii?Q?G+nlosVPwmQnq3sgxdkCeQkhpvLXRg21hu6g+syfmEVeHnr+k3odYvuskCTd?=
 =?us-ascii?Q?yhi52CnSGEE0IqyVdYATbdRe1RdQ3j3hLWDMTGTEvJ4qPL2EAAL/2GSrBnXi?=
 =?us-ascii?Q?fRApKuOkExZXolEkjlCn/w/vd2FUCt7b2EUpgIHlbWCZYqafdV5Pt2CsnBQy?=
 =?us-ascii?Q?+hFO7T15RdDy+qyawjagPkWsJS6ZGfRzhoGsbGuAO2v8pET9fL3tAWo7aZKR?=
 =?us-ascii?Q?9Gutvc6WuYeltcum5exMzraY0LOS4Y0OahC93HTR7WKDKrTabyi3lxcYK79t?=
 =?us-ascii?Q?j3pf+HkwnnQYir9wXA++OPqnTsSAdNROYQMdj28G4mi8tFk0adnY0nMMsgrh?=
 =?us-ascii?Q?wS0UlFEbSwPRhDI5PLNk0J8zzOUmC1GDTb3d8IQIO8Nd1pZHVHYyxZQ28Ldx?=
 =?us-ascii?Q?7hE6WWcUTJLkyc4FfsyPrid8nKNFaaLgNXRNHcdGYrmenyyFMOnM5LymAcX1?=
 =?us-ascii?Q?YkfhxjY/Bv/reQ0LhfTV/YolJ1RAneQc1zRT/Fhu+acKsKSMg0+R/enbJ+t3?=
 =?us-ascii?Q?8+ga/OF0DchVWjvwEvZfT9Ofi4QdpL97l/t0oAvZO2eJ1CQPJsvoBtNYJn9g?=
 =?us-ascii?Q?NbYhRSqBURu6nhinLJfHz07JvjI/K9Nkobth0gxM7bVljV96HHFj95Me24l3?=
 =?us-ascii?Q?pv54NEcYGZAv86fjdfH8Yb4Qd7SYj0vbsefJkyMFdgXEoETF/5i7M1fZFN27?=
 =?us-ascii?Q?VACuaGf7intAeNb7VFStxUgOXvoqso/IoQD7qK+njurKAP7N4ZGZvvveAHGo?=
 =?us-ascii?Q?EjQAjzkYlq7bgZHzCALdv1xLog2PSrPQQcX3DWg7ai16fhzG9rVVPLKg735u?=
 =?us-ascii?Q?smJJVTaX1GaFmCmxG5t1iuftroYWb1uQluqLGvVt8KxMpoB+CO6izQ62r3DM?=
 =?us-ascii?Q?0BoGGdZVW0ZLpTyacPGEQlZPPK/dUqFxvjKdiKadFGTMyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ik0Xw0qDK6WbsNOy0knejjqBI8TtyifYhMyFzRH3nq39ZknhSd8GpngEZ3Q5?=
 =?us-ascii?Q?Hv4O3ci50XfW+mqcCjIsTvJWszFW2ZpwXzKa4gzmPN6iMGAhAAtd/M9kMcyE?=
 =?us-ascii?Q?gahSh09pkTz7imm+79p9wUQ8vpx0d0s++Yov2yx98rFzwBRsPh7u/YyCvavc?=
 =?us-ascii?Q?lqsmtI4RzfA4NDbxQQqrDj86nEURVnaUNRSx49hEEsAY/Q8IEN/NYDQ3CQ1+?=
 =?us-ascii?Q?BMpIUZ/PsRDBudjgbJsL7x/F//0bNyHhh8SxJbAVa7CTNwshsZ8vDbHq1Dqp?=
 =?us-ascii?Q?LD06DF7i14VjTYlOXRoSxLVhzJXslx7QGlLsLLS1iS6jc44SIxKm/KqQhtvL?=
 =?us-ascii?Q?4OR9JeKD5/5uqpkd6O/YxpnsHQIyK8qMq2iOcIRLVMqkTEyHxeczBLCkYzwB?=
 =?us-ascii?Q?VN6t/o1XREF5Mga6X8CCp7G9vqtuQzOOnyqm7p7ZrsIMCaeQQdBp6OiY5rTS?=
 =?us-ascii?Q?Ir32FRZQb20fyE36DU4HOEjgWNh96g4ik3g8S9dcx7jNnSGli2PGEvlQG2se?=
 =?us-ascii?Q?fj37tmt+g5ko1s3VIaoeHUc5EKABo8fs3siKAJAvguMSYdh+UtXpDWj/U71i?=
 =?us-ascii?Q?94Gomt/uQAcNr6TSE+r9H4WJxRUknLvbyUxvMlEI2tjG3G4oq2t7kNTBBdJ5?=
 =?us-ascii?Q?t0YTqmqn9FozaxBlgq9N32WihEg7FF6y/yvK8PzqhRkNTAkiN3CylBIRhOiZ?=
 =?us-ascii?Q?TimxlPYrfSZD+ITndGeEm6iOPQhfjZrgqVDF9JyPSYkkGbJ3Vt5lUwiMKDuz?=
 =?us-ascii?Q?8/bJ5DEo1SSot0y8zSjTCVpK46m/lDwtgPOd/fEtcUdzzdvV8UCRrXd7fvEu?=
 =?us-ascii?Q?kmt4A4sa+dU3aclderclVUoqMbUwZzsGwvleEsPQd0RFg/6/ugI82nTy/YC7?=
 =?us-ascii?Q?BJoS70w0QCaFAzDb8PW1ZjcSly1H5RxFcvPpfMWR3ZJcXLThmj4/cuTmwy26?=
 =?us-ascii?Q?apGfYdsmfYqJEWYF4a3pBGrGv47YrOM2P8ANYxe6jtSEaEgeKufN2/isnep+?=
 =?us-ascii?Q?8ony87TPx7xTvQDLn/963uncc0Wc0kh+2goLYC8GxTGUOHWgIOZd33FmxNRu?=
 =?us-ascii?Q?aiAlJrNhNlsdWIETQutsuL1m4trK/7I1uwGTxRPzCrJnncvGO3xvv1jPEBfc?=
 =?us-ascii?Q?lPUk5sdcD71lHiyEeFTndp72bCbnWZiQvnM/orzLbNHdhp/3s3nMVPeMkb0k?=
 =?us-ascii?Q?dyFBJEVa/tpELNq8RLRZ58kpMtpmmDRrMwn7cys4GfKjnoyv/NuwX8P8f3SH?=
 =?us-ascii?Q?6fYT9KieOm537sfSgJrJU/Q5f/Sx+LTHHVdIlF4jYg6mWinT9Uu6iH20NmYz?=
 =?us-ascii?Q?Y8wdaAIw3q7WiuuIeVKabM0LuG7Ym1sHHH2w8zTdETxM2bOtiRGE6LnLiBi3?=
 =?us-ascii?Q?FoGiwFx2+AStUoVSobMpXZEsDZWdlXVP0J+Q7QBrhRsh+oMSaS32cjYRsV/8?=
 =?us-ascii?Q?AU7QU+xJ49qv5vftT1WvyxXMHvrUsUquGSfP6pFTOuXDrc2F1Br8p3qp407h?=
 =?us-ascii?Q?me9m7LRG3OH2FMnmmrkWBZto2K7eqIlVjUVNy+K0+dbJnNo/7lvQZ/n2FSuP?=
 =?us-ascii?Q?kxjTEv3iFroRXzgXcdKMuZdLjZR++11kSl/ZQArvMUrYCl4iomnq6gxdGMnt?=
 =?us-ascii?Q?VMKq5s0ikSbckPez1YlXYt1N3x7C9mlpN49LlWgzFNaxRihXW+Yodh7fTvnT?=
 =?us-ascii?Q?eTXNYeWfJrY2pk5fDdFomrFPOwo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c6d535-a0f6-4318-6352-08dca21b7653
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 02:36:41.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnyzVfCdGXim7q25h/QuiYYXY3tzmIrmK72lNK9nrF87KDfsKkPTXZTztX1SsBONecfntWsUB5mqq+io1MHYv5f94zL1qapXof9rLd9BCiPT3Av4gQbnuwgERusvoeAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6990

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 325 ++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index ce9d2d2ccf3b..9958b162af65 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -42,6 +42,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	select ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  commuinucation channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index e1cb99ced54a..492a9e47638f 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..055d6408e1d7
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define MCTP_PAYLOAD_LENGTH	256
+#define MCTP_CMD_LENGTH		4
+#define MCTP_PCC_VERSION	0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE		"MCTP"
+#define SIGNATURE_LENGTH	4
+#define MCTP_HEADER_LENGTH	12
+#define MCTP_MIN_MTU		68
+#define PCC_MAGIC		0x50434300
+#define PCC_HEADER_FLAG_REQ_INT	0x1
+#define PCC_HEADER_FLAGS	PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE		0x0c
+#define PCC_ACK_FLAG_MASK	0x1
+
+struct mctp_pcc_hdr {
+	u32 signature;
+	u32 flags;
+	u32 length;
+	char mctp_signature[4];
+};
+
+struct mctp_pcc_hw_addr {
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to PCC outbox buffer and registers
+           Note that what PCC calls registers are memory locations, not CPU
+           Registers.  They include the fields used to synchronize access
+           between the OS and remote endpoints.
+
+           Only the Outbox needs a spinlock, to prevent multiple
+           sent packets triggering multiple attempts to over write
+           the outbox.  The Inbox buffer is controlled by the remote
+           service and a spinlock would have no effect.
+        */
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct pcc_mbox_chan *in_chan;
+	struct pcc_mbox_chan *out_chan;
+	struct mbox_client outbox_client;
+	struct mbox_client inbox_client;
+	void __iomem *pcc_comm_inbox_addr;
+	void __iomem *pcc_comm_outbox_addr;
+	struct mctp_pcc_hw_addr hw_addr;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->pcc_comm_inbox_addr,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
+
+	if (data_len > mctp_pcc_dev->mdev.dev->mtu) {
+		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
+	if (!skb) {
+		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
+		return;
+	}
+	mctp_pcc_dev->mdev.dev->stats.rx_packets++;
+	mctp_pcc_dev->mdev.dev->stats.rx_bytes += data_len;
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_dev->pcc_comm_inbox_addr, data_len);
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_hdr pcc_header;
+	struct mctp_pcc_ndev *mpnd;
+	void __iomem *buffer;
+	unsigned long flags;
+
+	ndev->stats.tx_bytes += skb->len;
+	ndev->stats.tx_packets++;
+	mpnd = netdev_priv(ndev);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	buffer = mpnd->pcc_comm_outbox_addr;
+	pcc_header.signature = PCC_MAGIC | mpnd->hw_addr.outbox_index;
+	pcc_header.flags = PCC_HEADER_FLAGS;
+	memcpy(pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
+	pcc_header.length = skb->len + SIGNATURE_LENGTH;
+	memcpy_toio(buffer, &pcc_header, sizeof(struct mctp_pcc_hdr));
+	memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
+	mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static void
+mctp_pcc_net_stats(struct net_device *net_dev,
+		   struct rtnl_link_stats64 *stats)
+{
+	stats->rx_errors = 0;
+	stats->rx_packets = net_dev->stats.rx_packets;
+	stats->tx_packets = net_dev->stats.tx_packets;
+	stats->rx_dropped = 0;
+	stats->tx_bytes = net_dev->stats.tx_bytes;
+	stats->rx_bytes = net_dev->stats.rx_bytes;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+	.ndo_get_stats64 = mctp_pcc_net_stats,
+};
+
+static void  mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->addr_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+}
+
+struct lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct acpi_resource_address32 *addr;
+	struct lookup_context *luc = context;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	struct device *dev;
+	int mctp_pcc_mtu;
+	int outbox_index;
+	int inbox_index;
+	char name[32];
+	int rc;
+
+	dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
+		return -EINVAL;
+	}
+	inbox_index = context.inbox_index;
+	outbox_index = context.outbox_index;
+	dev = &acpi_dev->dev;
+
+	snprintf(name, sizeof(name), "mctpipcc%d", inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+	mctp_pcc_dev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_dev->lock);
+
+	mctp_pcc_dev->hw_addr.inbox_index = inbox_index;
+	mctp_pcc_dev->hw_addr.outbox_index = outbox_index;
+	mctp_pcc_dev->inbox_client.rx_callback = mctp_pcc_client_rx_callback;
+	mctp_pcc_dev->out_chan =
+		pcc_mbox_request_channel(&mctp_pcc_dev->outbox_client,
+					 outbox_index);
+	if (IS_ERR(mctp_pcc_dev->out_chan)) {
+		rc = PTR_ERR(mctp_pcc_dev->out_chan);
+		goto free_netdev;
+	}
+	mctp_pcc_dev->in_chan =
+		pcc_mbox_request_channel(&mctp_pcc_dev->inbox_client,
+					 inbox_index);
+	if (IS_ERR(mctp_pcc_dev->in_chan)) {
+		rc = PTR_ERR(mctp_pcc_dev->in_chan);
+		goto cleanup_out_channel;
+	}
+	mctp_pcc_dev->pcc_comm_inbox_addr =
+		devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
+			     mctp_pcc_dev->in_chan->shmem_size);
+	if (!mctp_pcc_dev->pcc_comm_inbox_addr) {
+		rc = -EINVAL;
+		goto cleanup_in_channel;
+	}
+	mctp_pcc_dev->pcc_comm_outbox_addr =
+		devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
+			     mctp_pcc_dev->out_chan->shmem_size);
+	if (!mctp_pcc_dev->pcc_comm_outbox_addr) {
+		rc = -EINVAL;
+		goto cleanup_in_channel;
+	}
+	mctp_pcc_dev->acpi_device = acpi_dev;
+	mctp_pcc_dev->inbox_client.dev = dev;
+	mctp_pcc_dev->outbox_client.dev = dev;
+	mctp_pcc_dev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_dev;
+
+	/* There is no clean way to pass the MTU
+	 * to the callback function used for registration,
+	 * so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_dev->out_chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	rc = register_netdev(ndev);
+	if (rc)
+		goto cleanup_in_channel;
+	return 0;
+
+cleanup_in_channel:
+	pcc_mbox_free_channel(mctp_pcc_dev->in_chan);
+cleanup_out_channel:
+	pcc_mbox_free_channel(mctp_pcc_dev->out_chan);
+free_netdev:
+	unregister_netdev(ndev);
+	free_netdev(ndev);
+	return rc;
+}
+
+static void mctp_pcc_driver_remove(struct acpi_device *adev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->out_chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->in_chan);
+	mctp_unregister_netdev(mctp_pcc_ndev->mdev.dev);
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001", 0},
+	{ "", 0},
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+		.remove = mctp_pcc_driver_remove,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.34.1


