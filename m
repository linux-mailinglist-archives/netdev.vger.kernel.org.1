Return-Path: <netdev+bounces-295108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MetGLx47IWoLBgEAu9opvQ
	(envelope-from <netdev+bounces-295108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79663E1AA
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=X0uB4kZq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295108-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295108-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614143082E73
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB223E0242;
	Thu,  4 Jun 2026 08:34:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87973DE446;
	Thu,  4 Jun 2026 08:34:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562052; cv=fail; b=M6MQrkRgOvZPpJ/R+6EHb7T8hRZwBEfwbg5kA5KpinPO1qjRWTzC+CI3YaOzc5d8z6rD6U2m7p4DUOyRclVRdMEDk07g0eCZFT7/eL1ppepPevkHFAxS64JUdMftD0xCm+GlJSgKK8SOXr02Udgoqdiza02ac7n9BM5Fb78Nq+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562052; c=relaxed/simple;
	bh=v9dxslsTPqb3WtvX0rHFQRbfj3DDkbQiXwf6feW8Nbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGUNOckuI+Ca8jt1dyMPgOvLm2jttoRHAhVK6L3aGJBLMzdbNTZ+LuCN6c6VIx6Anmi05N6d2cea10johUI0UDlnaUQA8poM17kjeki/fz+2iq/wDBIrbjTzf6Uqpw4GQ/CV839InPXLsJ0YediraDQdEl2hPr6jdP1Xe1AmM4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=X0uB4kZq; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MC1mdBrkKe2bzSwQRqa+Gcp2HlmfSvxOO9Ba0U6LgLW6W5KSWsIfO1wy2b8yksIdR1cOJ72ttaVDjXf2DkKSySAL12S7dre30wF6jeMMLshT3fitKGzc/zxebe+OP5/F2DWLBUDXiwfeBy/Cq5Ky1FNvbINXcqVER/ohg87M2Xc+zSPY5AgrWra4ByPICwTPzBYMDnyWgKpMarXCFvmFhVhMU4SLdXr1Evr2q71PunWGQfOA9PE+8+5YFfF0J9rlFN+FRIQnxWppqs0O5YUkMtNmsB/VbN0wIDxtOMcl/1OiyVFJXIEQOC/fhTMmMTxIznX6d/E0LDmdnszElBI0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=bA+4ZJj9s/C+rSetIxnnj+2soCQ5vJ6BMMdOaMlhDx22oVfuvrs6Wv7qpgeOcF1YClOjxumfycS/jwp7aMkn6sFSZPaJfhrGiD+dUG5zjNGnr7D/04AKS5RLq754rKxZlkFDbknwVQdPY3lPRORlCI/sYlNdLvgMwYC87mtea/Jjz7STkhFp0ldlERMwyT6zIf7glTtkiLTQO6MLJLc5Ux3e4LxvljR8bL2rNV3qV3ZaP1EURBbsapsxQ5zliSNC7zQlPyN/6Y8VmPNjRcbRiPSiXVOwg6KTU8tTAp4T3qc/1QTMzQI35rJe6P/uR9l7dhDqHmjgOQcHYekYBRDEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=X0uB4kZq8iialpU2gtjc7lhPouWZJvdJYV3O9kupxphg7Q8ySoG7bR16nMq+noFW54+ztm45PYqQbpIyt+eOV/Vzm2VBz7+FRRdHBrHWJRji3dlqJiiFoDym4c/5RhWQyk+MyNhCukN3nVlqRHHcSVuIqhQFlQIyCw4io56YS8Jw3xoSabs9HFGReTNKKMbA2bjVeNvdyuaP+jQqtk6DpbP8eskNNlqbFKMjYaGCpCeeEXav0FYkRlzAvumJinmMJ3DWPjvlD+zfv2rfky3l4CuY5V+ejG2uVkth/QfLRPebDG6aTlp/SC32vwkemGJgrTuzL//JeiB/SZKOPoZvmw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 08:34:08 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 08:34:07 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] net: stmmac: reset residual action in L3L4 filters on delete
Date: Thu,  4 Jun 2026 01:33:50 -0700
Message-ID: <20260604083350.1701-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: de953fce-1c30-4e91-7a74-08dec2140389
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|6133799003|18002099003|22082099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	ZbwFFXK5uMO0UGMU6IdvqmwcJ/qXgamcU5yH+tR9GWDPzwEHoeyDSjTDYvAdG6/VU1pdKPh72owy9KOximzKxva1HFsHC3OnydRKART6wvqFeih/c17810zW8s1WidMG0QQHbDmJlZETuBiEtX9G+XiE7rDnmt95w6MmgTIL7FFr6XNrgxMERAOsgqKzPmBywfrM8TyHjVq0Zzpa5kqpnltWt4zxmE1j3lfYeA6phwDtGjqK7sa3uPIe86pnrB43Ht5Wzxlz3uPCJSz/YxGqWJmMHsyKuuGnmIFmzwnMKtmfghv4QQQ8XCBmTPR1hw4RMa7h7wW/eaRFBJtUct+UOw5XRCrxLp/FDVUgc7P8aGVUBWiHeEzv4LDVDtDJF2WLRA+0wd/B6op3W/b8BzxMlhvAUTyKZe2zTC48G2XH46zNMrYCMqJz+GKTKKMuSf3Z0Nqy3Pdyr77GzhFfZ+bNZU7mDpIPe1EbL4hDzn/uwJCzPESEITR8gT1TS5GKgLknX8w/d/Rg+t132RdnoBKgVHWx0O+MpJV1XVZR/U4lYFLqpIAHNdzDgRWXHAzdNoKFFt2oc8lyc3FvQdnIo77+omN1kU7iNCaok1Irywt7k1ddxqR7vWL/oLx28Ytz15m7SfDIO8kjxfTlnhjx5rnw0dzdDZP7+/3QVEkBxNdgCk70xnaJWwUgDNCzSDXXtyFY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fB7C0fDWZDnz+7ZYTsddFAKse02E9NX61y258kffvsSUMDqmaPlAhOq1+6PN?=
 =?us-ascii?Q?XjSzUrrI72n//zPPI6Hw2L94eWqRyO973MfevXYVFGOpqIP77Eskx8JMpEV8?=
 =?us-ascii?Q?PHO35U/024nsZ++cfDsEeLuLXYYpmpwgbzpjjhaLgLTI4A0yQ2qGSiiFwFj5?=
 =?us-ascii?Q?Qtv1nMwvNE1HofYHgzQxuqXgZvHAYnV9pWlew9T/FbCaR8xFuzUz/3YYXWON?=
 =?us-ascii?Q?Sv6HHH4QkQCrsFijPwJ5xuMUkvicAHYd+w27VJeh1csJXeIQaFe6HV78wJ/H?=
 =?us-ascii?Q?hvNXBxZe09Pe2noJDrMuaiT12c1ZRu7G+nxvo8cmv97GZgniMR7W3idrbd/Y?=
 =?us-ascii?Q?IeG5vnH4doEjoQMPALp2bnPQw/7UlZvje0zGZymRSe5WSAQ7LXbuqLjzFl5T?=
 =?us-ascii?Q?boYtKtX3tW44tWTkne2Bj0hYgRd/eBdeBXFLQIxN4QF3QNEODyhyRTMsuDe5?=
 =?us-ascii?Q?2yYAxJXi+WmHjpNoemrDz1LRcXQTOutVQxYK++bUiNEnImxGxabgNL/XB2fX?=
 =?us-ascii?Q?V5huJyUTWHfs96j5N/BHC3XweIjwB7LXEajNylsvGh2aVCUy9leUOX3m6XwY?=
 =?us-ascii?Q?FRweQ6Hn9EInVjKDn8RkklNBE0I1nQ08s/eQwy++ZScLi/XP4kTB2wh1iTPc?=
 =?us-ascii?Q?aBBvbrAJMfUer8HQkAxG5XVCqZGrkYacmEIlSiV/LDYa1i3u5cCSMMKKiDTa?=
 =?us-ascii?Q?UCCoQ4Nckt/UWuBwH3znyofz3uRK1g5o8RQApIM6bt2fI7HA6QqA9qs3XwGY?=
 =?us-ascii?Q?J6JS01RUFNYn4reX1br5oaOOPKopws6mPWCNNzrxNgmihpaeKshiDw3c+WXP?=
 =?us-ascii?Q?64HRN8e/3cIFoTHDYFBMzpgcTo0VYqMNLYJ6fxz+JN8qv9iQh4oIqSkV6IVA?=
 =?us-ascii?Q?slxfNOlbch8qXXnUPn2pbLA89C5zNYlxM0rFn1oHbPtUow1g897lHMRJsr8G?=
 =?us-ascii?Q?gDoQBzdLmiyPUhFD+75XkZreTauvfrlQsmSERGEHKoOKA5nf/Q1gOLzBapg4?=
 =?us-ascii?Q?pl0lV2VEcW+m6VVERQHpPyHg17KjSl1MhKVMf0GK7dhoFYVRodV3bjlvJjjM?=
 =?us-ascii?Q?QbRx/KLq8Y6PE9XNmAuaFssd8QjCYINCkyvI4lC8U/adVq2HXt3yuCRIAQTb?=
 =?us-ascii?Q?LzqnzZ9ytsYu9Zvq5l2TACxjwVflj8q3RgnMdHoe9OIIloUJT2jgM/mYjF0j?=
 =?us-ascii?Q?KmftO183+V/qHa/rmDxeqVlz2APyG151WwQFGeItBR5/wsi/aGodI+/Rqhfu?=
 =?us-ascii?Q?B9oUoV4hz1dFBtfmxdkoKH1QQ/037cwSHL4FnaenU5eEZ95HSE7Edmxgym1t?=
 =?us-ascii?Q?bGsJNbR4AGc50j9g/L9r82boSTgjnhQUBOj5pCDdu/NSnVAlo0fV5MREJsE3?=
 =?us-ascii?Q?3DVQc4/8yZBRxnzj3TgDIjLygOOZKTBzb60je19aBNJP17oPFg8rAgHCZM+m?=
 =?us-ascii?Q?d93P8slZYpHxlOh7Gia66JVrTSJLmm9BeEF+DTLpXUtC3JwS4+9/n7DRlt14?=
 =?us-ascii?Q?82HN+Pvl0A4SW6m72kuqwp4xurn1FxGEE3YlOX8ftPmWzXjUCHVELkMvjnba?=
 =?us-ascii?Q?ffFhlz43MGZBEP9St5gLwsmAytlhA23bPqJbbaoMT0s4ylGCXlTFU7vVIZZu?=
 =?us-ascii?Q?IcFKBQa7ruwqXiofqhtMIjRmKMee3baEp5QiNt+oCKS1tGzJnPBufGW+BZ6e?=
 =?us-ascii?Q?EbKWo30CRlhPwQS19tJQextWH6CRH11pcZZrWSIUjpnBQUWeoPJBwpjk7cg5?=
 =?us-ascii?Q?c/DO6+g3SQ8m3dCbdpMIPu3Fzpa2xgJgvOE4hZCGqfqMivtow5+rdSVd+OCm?=
X-MS-Exchange-AntiSpam-MessageData-1: oNe/iVG+ifOj1w==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de953fce-1c30-4e91-7a74-08dec2140389
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 08:33:54.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejnifdZ1dZxoy7KWAgRPU0J7i9XZWezqjqV6yPD1DV2XjTNmI3yy6DHUaDSnr+PV3SLqSNmTTlGM1HvHlDIdmFw6d5AN8hJEJQX4UumWOQeJJ/K+IARBCFaMcirxSuDDjDUQOR+mjS96HEc+A+H7fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295108-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C79663E1AA

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

When deleting an L3/L4 flower filter entry, the action field is not
reset. If a filter was previously configured with a drop action, that
action may persist and affect subsequent filter configurations
unintentionally.

Clear the action field when the filter entry is deleted.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 869f84756ca5..4f9758eeb86f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -653,6 +653,7 @@ static int tc_del_flow(struct stmmac_priv *priv,
 	entry->in_use = false;
 	entry->cookie = 0;
 	entry->is_l4 = false;
+	entry->action = 0;
 	return ret;
 }
 
-- 
2.43.7


