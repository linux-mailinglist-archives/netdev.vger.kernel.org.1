Return-Path: <netdev+bounces-252813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOD/GxBXc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:10:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBE674D21
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F57B302C5C3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48140330657;
	Fri, 23 Jan 2026 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CdG7TnVH"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1A21ADCB;
	Fri, 23 Jan 2026 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166386; cv=fail; b=EyaDlML0FU7LmZiBsA4E5Igue6qJiEEGHg/0rRBq79+76LbL2xmZWNdo2k9hwZaNJWXE9f4Zq1mFDDA3b7/dkWRf9RlI4SCmiuZ9jpqhiCuKH9WKg2ORMROQAvqf0/yBbR70M7qy2ot9sp351TnN7w3lGKzDSvo6BHgIxI0jE9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166386; c=relaxed/simple;
	bh=CwnxDPQH+SHQyLjjJ1sKBnjDShhHVltRoHl8AxsKUiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PNVNKqVgxkZ6G8FDH7DkR8unl5HVdPl7DtJ9p0/psojoTI5pN+zSS8HUU2OLsszZDV69rzxzqcdLA8zVjTqTfdOxXDXOPWAwYakx7Z/YhOitYt2oHVzcf8J7di8sJPN9NdjK40movw/fsRoIa9inFbtjIIPJqDw4KV0lBZ3sfEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CdG7TnVH; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQsKFI5YsUueAPzV3c2wQSyEc3WgYwjthq4AkiGoO0p+4q6uDPGTeIPHZVi72ahkyBM+o4PS8z7E9yfrcQEZHZ/Ul1HF17WLhnepHkD++FOcAKAZnCQi68GwNND/6goPr5d5lxcwWzlWpeWJNW7KAQVTL5u4S60hA7qgPbD3Nq6wt5Qdn3KiEnIQgCd1ky8o4MJ5r0bNwdieDHCIJwSZtmrfEsnBzSfwU/IjAldIQVA42SSRhvPzAdrG5VO5fgBFu6frXaW6I0S4s46rghUzR19Tnx3FKWLdrZzTLxSf9DGGNJ68oB8V9txEnmhhMuT6WFOFdIf6l/sMZHiI/VeluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7tM0Djk+NbuQUSZH3NvHPMhohN5vkzh1fE5hjbG46w=;
 b=d6JpYJbfVy+bDdoHtTQ9HhBYc/rs/cMuB65Sxg1jkymdjcUGMl33KNcpPNe4a9B/W4YZMQr7XjKfI58PniUgd9YEOPLUDIIuLytVYHNv1rwpR7OiBCi5rSmaNccJgDdW51s/+O+9frSuX8DqoD0uDXwwOhAIn0VBKtCFhLBS3ewI8g5eIAEucobBcp8iHQEgC+C2eDDuz2yckD9gqaGhxvr4e89fdDLmsxTpGvzFsiJB55OyWePWPcQBlpXOP4YJOArmJIrZBlav47jJFNK5pNcEyAvsjMkS48D+UKdFZS06f2zs1UExr0ZvSFodVRY0O1+b0QPgutZaYwUI3LN9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7tM0Djk+NbuQUSZH3NvHPMhohN5vkzh1fE5hjbG46w=;
 b=CdG7TnVH6D+6UFr6bzoMuyS9SUc+LZz11z9+lmM0Mo2/G2uJurK9mCzO8fbB3IwXW4ztg8tVRzV0vcH1OUpFZYF63+ZLDyWtbqnGENna/whihTsf7IIXnsdQi7CcocNJswovp8ZXDc+fZznEJDkAfhjSsIDUAgxp1gS4otc7FTMwH7i6jAwthu7oXYiE9d0nKyzC9wlxA8U+ugX3Gtu1OEA4wgIhzYBPiUl3fCoRbMNmvwUuPic5Xgz0CNrDFSoZYwpfjz9jvTv1unB+XYwI484UUooT1ImL1Hs4XtJSDY2GchOCiDC2alVbr+crCENZeCBK96khjYoih325f3J6Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:06:21 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Fri, 23 Jan 2026
 11:06:21 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	linux-kernel@vger.kernel.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH phy] phy: enter drivers/phy/Makefile even without CONFIG_GENERIC_PHY
Date: Fri, 23 Jan 2026 13:06:00 +0200
Message-ID: <20260123110600.3118561-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0136.eurprd07.prod.outlook.com
 (2603:10a6:802:16::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: d25e13fa-858b-47c1-a511-08de5a6f7093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|19092799006|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xIG6seNrez/yksSRaTvuKVJUmmHu0jTTMYtLBsx4BrvGNhKMdl2gRIXFRJc2?=
 =?us-ascii?Q?uwvzx24QvhBVA1inlHieE5YredXiZe6U/yRBkt2Z+XS86mRphKNu1P6iiX47?=
 =?us-ascii?Q?I3pjgRQj3lau1KT2flK1akK5pqmq1TkrRQLy+Zkzhf/54RO0EsoI9n+AQlHP?=
 =?us-ascii?Q?qM8V04l0JiDPsKKK5SxcVdV82wAEYEEz3+AYAW55ZWtf9d2zhOKZ0m7DzrKQ?=
 =?us-ascii?Q?B/IK0WH7yL5pV7rPuFIsrE4ZOEAJ1WJWNy4x3kh7ToK30rFO7sjnurXEvPNN?=
 =?us-ascii?Q?wcboSeuPgToYET2QdwVbmlzzHo4fhX3iOTzw8WXY/y5MnqJZdlgbCUk8r6SX?=
 =?us-ascii?Q?NyHxtMHcja2dYvGX5V+JE6It2Bjh+TtQDfodbpaDZEWWLju6jdGpuBesnQRN?=
 =?us-ascii?Q?MPiE2Zei8vnUKhuYPTDEiKF9DipYNzy6VfbgDTkkBSnGQCh5ReE1uyTyUs52?=
 =?us-ascii?Q?3sTEJF8pEtJVMemd5Unrf1Fihd4UmLsUn5HF4yRPXpgf1AwzWje5GOzCB2Ya?=
 =?us-ascii?Q?gqt0cynoOZ9D6yam0xAcm60+jzoo/qE4/Lr80Ny3Jy4BIB8qv/IqwQ+9P6je?=
 =?us-ascii?Q?xAXsKufxppxeFI+ij2dFvpwVhDfggH9xdPp6LlJHb53nCWB5GDKXg2WqnRUZ?=
 =?us-ascii?Q?DTPRb/fHpO8PctSeVQ8tVGgVWdqANcbbBmmUl2Ch88OwunOlZtyheknvbJrl?=
 =?us-ascii?Q?zX/lIHnPuvIQcH5MOyZzMgRJfJU5lySjdS7y6hbuHs94oCxNzyZOFgvCS8hh?=
 =?us-ascii?Q?wxkxFFYVTFqSCQgbUAkhH0opAmbfCQN0OwltTYZmCNrqjhm7AWRkPmx0PzCp?=
 =?us-ascii?Q?eCpq0XKTNZZhVEt2hyHD1npve/7IOZv9LFdO1WD2knhkoJ1BsuYjF3z2UYcf?=
 =?us-ascii?Q?+lqpVSxIGWzfc03vPTMagqEjjQfawednnygfzBlKfakDrbHWv0ezSTLG6gnJ?=
 =?us-ascii?Q?ZaSfzJmPqWUevF32ZOJHG3t4xQm+YBwAz6yTUqL9A9bzbK2vJYN8SEj9DcVI?=
 =?us-ascii?Q?z6rZZpPTw1x7sJCJixwfe+6t3aertE3FG27HK/E+5S3IKECzY+f5CEXuuOuC?=
 =?us-ascii?Q?+MiEMJyFrbjM2++rR6ex1KSQKFqyT4JwYnJqiwvU12FrA2yx9dZxBE3dEQbx?=
 =?us-ascii?Q?hzZ5E9LLkf4MMm/tRndX8lN7zo412hqnYHlg/zT07y3xRFpFGOXvhJGsw3zf?=
 =?us-ascii?Q?dGatfKZZsBGc+HLx5R5C2Rgad5E18Jx1fOuHM03pmBv1Nh4ZdhUxjbr0d96u?=
 =?us-ascii?Q?HrcnPEwHzX32XdZJDTbC4c0dV2CRkJiInrPGsI0M2aGSJW8ucLJhTU6BfAjd?=
 =?us-ascii?Q?cI51uJY98ppVCmmtm98AY70IErx2nPdJw1pbcEoXPRo5lJwxqdKTB24T3+mn?=
 =?us-ascii?Q?uM/gwZYrAbYvMyu8eJnyOEi0QvkI3olO0e8ZsaxGxk3IDqsaOG1TmhWDVlX7?=
 =?us-ascii?Q?+a0CCVEdjg8r9j/ju7SJpg++02X9adGb8/tIeGdpIsKiDtpPK4hX+awGc1GN?=
 =?us-ascii?Q?Vzmqs5RT6ThGnRzND88xUsSwWNJet4UN0vPJ8r6mlPrQJzUEzVzWK5UepELX?=
 =?us-ascii?Q?+b5hB3tSfdLJBaQgzyM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(19092799006)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ljs6lHwUxUImhsqLJcWBGWRPCXKwI2ssBLTm9bEOl2HXQi3hhOKo5+g1VQxG?=
 =?us-ascii?Q?foJI/Xc5jTYQBernRRfs6qMqHNWrrVgRLKhfCEWfKVL15JRUwh0c5vhnFoai?=
 =?us-ascii?Q?Dot1vyCpt0Ozq4onJt+Hp2+LOzawP3pVQB4TGkVupMaO49wL+yYSwfdmo+2E?=
 =?us-ascii?Q?ZYvvvwTMcWhYQNIZWUc6bmUtn7I9osI8Bqoq9YnfH9Dy1uLdiT6B6hdNzgYV?=
 =?us-ascii?Q?Jp2HVJlerUGzvoAyjRbhFhcfiW2krdW4YDg/I4GcykjNF5GRWpvAlT5H9gYH?=
 =?us-ascii?Q?A3vIlx4NCq7FimwQYw/dj+hDb29QETi9MSTxpzGfl07fyA2R2nWowcPc3g+Q?=
 =?us-ascii?Q?Juyrt7Gl2UN5vdTsuTiOU91XzcBioeTDFMfAQ+NaQUOpPRA9WGky/U60Alqr?=
 =?us-ascii?Q?2UPL7FROh69IA27wy0g5LyG6VcieX6BXPQtxpOMneHeddwS/DhZMa9IUL1no?=
 =?us-ascii?Q?8rgJefkTInWAP5uLLuwrUwGaWL06NIJdGsH5WPVvvD6T+FBE0L3DJn04aO3n?=
 =?us-ascii?Q?xbkKMs5d0oMD5gTp5Ecup1CAsdd4EkE9mkckhBGa+5/XweZfHRx8mtbSM8d+?=
 =?us-ascii?Q?GcAQEQ9MLLkDpmeCPTyBiiNUCUHY/rZOY0YHNY1EhsdhjRe7h6h/Y0wnF8oA?=
 =?us-ascii?Q?9iH+umESDenJQLqzpFyJilgoF1H1MDRre+XBcqOKi12mKiE8qJL8KARsPyEi?=
 =?us-ascii?Q?U0MXBb/8F+QI0rZQi2yt42cBQAfnj2WhX9AUV4dcTGddXKtlT8sx0AD9I+b9?=
 =?us-ascii?Q?Kq2radn6Su6wRuH37IuInAgOmpVnXeZt6/9ocw0oj0/Uhc9/DH2+nQ65TbA+?=
 =?us-ascii?Q?6q4osA1jJM0Og+JXSXpMHwjEJCDiINNsMJdTAxuWqzQkxMf6daMuAEVNciVh?=
 =?us-ascii?Q?0qaOoxj5SYxkV6IO1bsLs8rjkT/XXiMPo4Mtz9xuzaix2nrcz8dScpwhcce6?=
 =?us-ascii?Q?tcmocTbk9VoTyYAqL0uaErsBixnfHz/0Ej2I63QVqFcyQamRoO1AJEVRYDx4?=
 =?us-ascii?Q?Y06hVaT3XieRNFEHhOgJ/8GVUtojpHx9HN0SmIrPRsnqS9bp5Km/mPlTL2Ve?=
 =?us-ascii?Q?Nd5WmwVDUGcZFZKQkR2Nt1DQLkHe7CcacVlNjNTgdLHZaREnT3Cn58wmHfWE?=
 =?us-ascii?Q?n3uaVs8qyPOw+5BunmGFG1j7iFuFDkdXY0F9p+N9SCrPsR9oGW1gCZ5E0CdN?=
 =?us-ascii?Q?VXUW1c6gc+NP5dPeIg/5o2Gb8bDBxEoxR/HkUxLapgjEbFRvcdhZAfXWLYHq?=
 =?us-ascii?Q?1Vg/vviZAnhFFSOdww/9wEnD2Fn97OTMlehmeqTAhxxRhNjCL2enVGVMgPfU?=
 =?us-ascii?Q?D1nvGC/83C+HfAYMOujCy1KVvK+7X+2bWUIcBiY/HZV4CLuzbgsYTbOzIvgk?=
 =?us-ascii?Q?vSTHCsG53MaqzBCTgvzDqHoLYnVA93RfdR7e+/UZyCEGi4QUlyG2HsTjuGwW?=
 =?us-ascii?Q?t/0UrhJZOh/OEdTU/VnTgrzyT5L3yerVPpZNQIh51fBdsn3OJsDp0qubcCO9?=
 =?us-ascii?Q?ZpiuAzAAlDtsGuzeZhxVMhx8mwsVtMqbzMJ86ZIfULGBdx37xv3tzq2d3fqb?=
 =?us-ascii?Q?fXXBM1ykbmP/k4SCDNicdVM/hl6crrxhEAosySSeESyRqaiad/PNEMBjHrEb?=
 =?us-ascii?Q?cJ7QAg9XyUQYvcggfw3CkbG4jXaGk1azw/br4F/ymEko2a2qxIdZNWKjyV5l?=
 =?us-ascii?Q?0to3eGS7ZEmGUnNklcfmNha8saFPHmwXeXsTgwbCfRQ8wi9hb5ZEd630OO/s?=
 =?us-ascii?Q?CZBWbFLaH43uteYE4R52R8CXFl34b5mQ5o1rcxnkxpZoRsJw8QF6vZbfO12h?=
X-MS-Exchange-AntiSpam-MessageData-1: L6FkmxJP6ulnTWTuGpp8GK7SiLudXKBHDRw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25e13fa-858b-47c1-a511-08de5a6f7093
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:06:21.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnQJCe4hVAc7DhN2gvEMfHXa0BWmgOJWet108rzvv1jIRL1OqOwD0jz4n4BAi6JRwQN0ag1vAa8NesKDN7fPew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252813-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFBE674D21
X-Rspamd-Action: no action

Kconfig option CONFIG_PHY_COMMON_PROPS, which builds
drivers/phy/phy-common-props.c, was intended to be selectable
independently of CONFIG_GENERIC_PHY. Yet it lives in drivers/phy/, which
is entered by the Makefile only if CONFIG_GENERIC_PHY is set.

Allow the Makefile to enter one level deeper, but stop at drivers/phy/
if CONFIG_GENERIC_PHY is unselected (i.e. do not enter vendor folders).
The other stuff from drivers/phy/Makefile except for CONFIG_PHY_COMMON_PROPS,
like CONFIG_PHY_NXP_PTN3222, all depends on CONFIG_GENERIC_PHY.

Fixes: e7556b59ba65 ("phy: add phy_get_rx_polarity() and phy_get_tx_polarity()")
Closes: https://lore.kernel.org/lkml/43ea0202-891d-4582-980b-5cb557b41114@linux.ibm.com/
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Debugged-by: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/Makefile     | 2 +-
 drivers/phy/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index ccc05f1eae3e..53fbd2e0acdd 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -10,7 +10,7 @@ obj-y				+= cache/
 obj-y				+= irqchip/
 obj-y				+= bus/
 
-obj-$(CONFIG_GENERIC_PHY)	+= phy/
+obj-y				+= phy/
 
 # GPIO must come after pinctrl as gpios may need to mux pins etc
 obj-$(CONFIG_PINCTRL)		+= pinctrl/
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 30b150d68de7..93715ea0d010 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
 obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
 obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
-obj-y					+= allwinner/	\
+obj-$(CONFIG_GENERIC_PHY)		+= allwinner/	\
 					   amlogic/	\
 					   broadcom/	\
 					   cadence/	\
-- 
2.43.0


