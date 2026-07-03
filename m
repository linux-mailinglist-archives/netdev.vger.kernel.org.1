Return-Path: <netdev+bounces-304364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v6hnH9pYR2pFWgAAu9opvQ
	(envelope-from <netdev+bounces-304364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:38:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C10356FF1F7
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:38:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vaisala.com header.s=selector1 header.b="q1/iAper";
	dmarc=pass (policy=reject) header.from=vaisala.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304364-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304364-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38F7301A382
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF537C916;
	Fri,  3 Jul 2026 06:37:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023079.outbound.protection.outlook.com [40.107.162.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10C359A70;
	Fri,  3 Jul 2026 06:37:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060667; cv=fail; b=C0jc/SyVqhmbB9kKSmzhPUcQ38nXjLVAk7wdZILuUbNxDQfkK6i9/Rik50P4e5mA2cpcqDunxbp7lHw3AbRQi6sJ1AqhvEa3XRegiIwMlsUY7cq8vy3Ejm5sqnqWpG/RUyG8dSQEcks8ormVL8ONbMJGrpa7d4iOEg85v8/NWpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060667; c=relaxed/simple;
	bh=Mv/PWKGD4qBb2RjKOU6yYxClwgUFQNC84MIWXnwP82g=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=gsI/QThpfLhgHL57lU3XyeYlk0macbBprErJ4cG/1m/HX53JoQd882J9CCDZ0wW0P7cJ7XkGoAza7nhiQhukzrik2Df6TgGgFDBJm9iY20Y6RmK58Ew9jmXZQAAufAvmPQa8UkXfYsGrypscHpE6uUWAxUWwfaEm4MFx4GgBTHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=q1/iAper; arc=fail smtp.client-ip=40.107.162.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS9W1QPkivx+D9hKgF8cUD9aaxaZyDw3S2kzTCNUZkVDMan1XjZDOCUfx950/Cl5obRuLvPe8T+Nz837trV+nK1IlPD0oFxwEK5tFY6xHo/GJkUeSOjOf2O3A96jn3K52L67t4bijnmbyMLtjEE/u1mCOTPFSaF6zbpXWZbIS8FY31zzxqBJJ1SBSPh7zflOsk+4su0I2g+55wdEGldygSCMYypDOLDEbXg4gBCs2rcxNLnusitKlvj8fIrTIDwxiXPFoPknwydm9u5APRym1FOIYZ9LvXauD23wKCfqarmSV/6Vkrb4QFxsIROe3dogqtNtP3ds57Kpb47vsJmCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASd2HM17+qPGiN8y0yqf62LvuVKf8H+Hwxkol0mzQvk=;
 b=I4Tx+fQeY9eBOY4R3kcjtj9aE42+Y6P2jacseihrDm9fu8U26j9uhXXKm1vewMdpoeozL/cZhrBxg50aZPvk8MWbDYA50Eesr9wlQ41VbjSSfkn/D2B0Y4WrtGNS8gcD1iRwnpjN+lcZTg+88w0Z31Sh8DzkZ7YUh+t62VbC51qtPvEL3zYJAfsd+da9g4mi6ahk2dgenKXPYEUf07BMWob4IWWbTGmpe0q/dDLUjOIwzPQwpKj+V+rAUiFcAPVcovC4dnLQquL3WOcnuDxgHXqYdsHPpnoqBPz7k8YUY9GXH+txlwu2sBGJSSyLuXlJ8jv9h6QcmmP1/ulmuSShTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASd2HM17+qPGiN8y0yqf62LvuVKf8H+Hwxkol0mzQvk=;
 b=q1/iAperWBrv58xl385OKz/jcy8r43p5MrLyYY+hDPyPiHhl1SA/mNnco64upT2yESsJawt82DvovWVAZFU4hg8vd1VYR8ZgWxevEg2FMu93dsAbsso/D/uDNXX6dmcilpImRKhjL2kyIEODmr6r5W27br4irjgaeoFmNkSCmnv6Kob8cr2C8Dpw7SH7E+nEG1C2VahWBQZTZj6DBJh7e+thR7ZFrX9xRYzo8g5+DpsZi8stn8vAWD00dAkBjpX8Zd4m4Ktb8YXWgrpxtMdYUkapQZQAMEooD2qf8ClfldacEvqUtHXL3Ssi0EM0caKwQlMrhDuqzo/KOZz0o1b1mg==
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by PR3PR06MB7132.eurprd06.prod.outlook.com (2603:10a6:102:8d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:37:37 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:37:37 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 03 Jul 2026 06:37:28 +0000
Subject: [PATCH net-next] net: dsa: microchip: enable SGMII port for
 KSZ9897
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-ksz9897-sgmii-port-v1-1-387e7632dd0b@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAKdYR2oC/x3MTQqDMBBA4avIrDswsf72KuKiNWMcSqNkgkiDd
 ze4/BbvJVAOwgqvIkHgXVRWn2EeBUzL2ztGsdlQUtlQS0/86r/v+hbV/URwW0PEqrP2Y4iYTA0
 53ALPctzTATxH9HxEGM/zAnDWCVVuAAAA
X-Change-ID: 20260703-ksz9897-sgmii-port-48ddb100e015
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783060656; l=1740;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=Mv/PWKGD4qBb2RjKOU6yYxClwgUFQNC84MIWXnwP82g=;
 b=5GUJTbMxogcSNkAuZEoEki+Ij7GNJlc7ccTLCDnJSH0+0LBC311E/tKdiMvL2ZjQI6nXJer6y
 4k39YhJLyunCLuF4xcAe5xHIVwTq0LsZH2UPVccAz5sTXMsM/b2KGYG
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0005F70E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::386) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|PR3PR06MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe614c3-0670-49b0-a4a8-08ded8cd9288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|52116014|38350700014|5023799004|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ozQUWpF9xgR3gMS4sNXzPfiQ9hkRyTIPh4JpFdgce60Y3zsrsxWpAckVL2VDbXG/wcWzbO6/9v+EGFIqSx09BXwMOQV8UJDxo6JCqOjCaSjk+qLaWbe0fc/q9kzEOt2qWBbsJRVEtl3R7nMsbEGBXbyGG25HqIwXm0rCDm9x7x9tpXG8a2+miFCzm2OhSWm6imJWqub8VBdmk2+sg23m8op9WsIrhy5ChcseRl56ac1H9pszM+EQAP/TfYyUAlZmEIjHrUDndVJWniimk6vow7rd8h0gHPXUZxBQMgw5zY84g2n3Uh+u+epYupEXOAsVY8G5evRf0EJ+FYd50oGGJMKLZAf0hyhTdIRViXP1UwCqP0bB7rBD+D3V8iyPXp5B1n4pTQGh/tTfr79l1gBWfvD51TXbXzVy4G637qBxnr+l+9mjerOGLzT2UcEPS/SkK6zGlHjIR4ZT8mh0POZIgYYVk/iIV7+xWRGA+TdbgUuyi6X6lp7K9iJRnaQBh47uhchNcTnuxJjlfWO9P/uPsDlRFZwSjOwzzQA5+mXqLsl6tZpG8R0Lw/qL3yfvmb68Yz881CYXzNhgjhPkcOK0FR7Lvbq9kNrAmpXLIfGC0vLninzWd+L9ZNBq28l75OAQg3vDwuRAvK+DXsDWfH6qNtrQ2pG/ocBCltUmfmQwGQwc9eqCUz3g1t1v9NYvXTO5oAunQ+BMg8oWA+Btee3Jug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(52116014)(38350700014)(5023799004)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG1KQjVuTWR4Mnd3NW9JcGhEWWt6NlBSSzg4U1kyODVGcXdSeGZ6bCtqN1Ji?=
 =?utf-8?B?R2ZiSnIxWG9QZm9YRk96L2tGejFURW5pelMwcmRlVWVIZlpONWxtdUVxNTdX?=
 =?utf-8?B?T2dTUG1jeFJTUElkZlE1TzZWU3NjK2pKeXJFdk5TbEdSdjJLYlJtdjRUd3VB?=
 =?utf-8?B?N0dpendkbmdJMWJpbmRhRGdLOVJzWGE5UmltQlZ3U0QrMTJYeDhocklsYzF1?=
 =?utf-8?B?YnFjcm5GNmphbHhSam93U0ZGdm04bEVVb1lUMVN3V29hK1liUW1UTjNxQjNN?=
 =?utf-8?B?clRCSGJmMVpaV0l0ZVc3ZTdhRnN1WDc0RmxXLyswSkpKeHVidEtFYWowalBH?=
 =?utf-8?B?WHV1d0RrellxOEVFa3g1MEpMQktpbGlWSG40b2RpY0p3Rm44Y0o4WkpFb09n?=
 =?utf-8?B?cmFMSExaVzF0dmk1UGNyejkyZGRrUEtoSnNmT1o5dWw4Yk1kT0VTajBLWlFU?=
 =?utf-8?B?VjJPSVVwbUdxZDBQc0VPNVNmT0x1OXZZRjhxc3hBNHVyNjRTaHBLOTViS1hC?=
 =?utf-8?B?d1NVejRaUk5rbGljQytqTEtORGZJSkZHcnZ4dDBLNWJWVEZGMXZKOTEwQUEr?=
 =?utf-8?B?T2gwbVBaR1F2enh4aWp0eFE5TVEyUXoyZjFzQjFwL2R6KzNXWEtwaWJsZUNr?=
 =?utf-8?B?SGRkR21Gdk5yRUdacldsSU1LNWRtdjJOeGlLZVhFQzVvb1g2V21tU1BiVXdp?=
 =?utf-8?B?WmJ4enBJQzYxU2VGMlJDV3YwVTZ6YncrM0JkVWxjc0ZSL1BhL0dpVEZrL2wr?=
 =?utf-8?B?dTYzUW02Z3VjRStSMXlvdlpQOWRoeWg3Vy94dnF6NWMyTHpuQ2ZoWXpBeGJ6?=
 =?utf-8?B?NllCUFY1VTNvYW00a0VoMXFSelRDOFovQjVaK0xVMzFPOUx6WEx5S0gvZEww?=
 =?utf-8?B?MkJhaXlsYWNVSFJRVUNGdVAzM1JUNzFOUFJPOXlNQmx1ckV4SUJSa2dsWm1P?=
 =?utf-8?B?NmFvdkw5ZE9KQVJYRFFiYlZuOUk5ZGxhT0ZoZDdtMEREeWg1YVZ6czIzSXBD?=
 =?utf-8?B?djgxT1gxalp0SmtoaHhicXZITGNJTEdTa0I3MlBXTVpnTUp1cGJuYVVpcSs4?=
 =?utf-8?B?Zk5ONzNYYmNyQWFhU25kZDljYzN0YWdHY2ZLYUoyTkdpdndCRWZTSk1NY2Ev?=
 =?utf-8?B?SnRsR3hWcW1CSWVuSEVXWGxlQzB0aHNvRmM1MkFsQzdGV1NtdStTTGtOSnRm?=
 =?utf-8?B?QUs2WTErbE5TclJBbm9TNmpodmtPVS9rU0JBNlppdXR6cTc2aEtSbzhleEdO?=
 =?utf-8?B?ZVNKV1RFelpsb3VzZXBadURhSndOakhlSzIreWhNQWRobW5MU0pKbExaL1Zt?=
 =?utf-8?B?ZHBtMlBiak52TGQ2RVYzOXBGcE9mY01oeVJtVXlDS1c3TWgzak13c3NVZjdS?=
 =?utf-8?B?bHJpemNPOThMQmtDVk9UdHRqSzAyRnNYamJKQTNsS21HdTZCZE1VQWZ0NFdF?=
 =?utf-8?B?Q24wL2t4N3FvYStLcys2cHdmVU5salpoMUJnTDdRZC9FcnFDb1grUTlsRnhv?=
 =?utf-8?B?WHBJKzRsYVlDSHNCTTNTdXFwMVVaVDlEZGh5S0txajRZczJBZ3RHU3FkNXk1?=
 =?utf-8?B?R3ZuTTQ5TmoyN1d6ZHlLdDhIZUJ5ditaR205QU9iR1M0RENscTZjMitrYkdL?=
 =?utf-8?B?MENyQWd4K2pqTVdwVkFGNGlhY3BucHl2M25EOENVaXExcHlKak4weit2ZlIx?=
 =?utf-8?B?TElrOHB1VFNWcGdMWUtmNzlBWks4K3AvczdJZHR1UDFOYm1ZYlBOV3A1NEpa?=
 =?utf-8?B?NEdHTEMva0FJeEZ4VGR4ejdjYVFnTWtYWnkzYjE3UnVPS0NMbXNleDNHMU9H?=
 =?utf-8?B?WmJSZzZieVZxRCtDbDJncEMvNFNoL2h5MnRSckZQY1ozSWN1K0VvSFhIK2RP?=
 =?utf-8?B?bTV3dWtDck0ycEY3QUhnTlFjZzh5Wnh6dkpJT0VwYWpteWJDQWlrZjRiU04r?=
 =?utf-8?B?NGV0WGQ1T3ptaGJ6SlFqTDIvRnVEeFpqVDFGRXpJZWlRaWhtVmlubll5emox?=
 =?utf-8?B?YUIzRVZkQys2cEdWYWZhRU1JUTlIdFZxd0orQlNHU1dablMwRk4raThWUzls?=
 =?utf-8?B?dDZ1dzJpV2pPTFkvc1p0SlVlblVzSnB0Sjd0b1dBRTVGVDQ5MTBXeGxaNVFR?=
 =?utf-8?B?VEFGMm5WeTQ0R2UxQ3hxdklUSjRYTGcyTHJYcVNkek5yblB2dmFTVi95NUVJ?=
 =?utf-8?B?N3hIUStMS3UzRDdMSTl6UWlkRG9QUjd3SlNMTDJBekhzTTJyZ05nd2tvK3BW?=
 =?utf-8?B?MmNvdmU3TzJzVkwrNndkSjVwN1V4N2VUdVBXZS8vUEphdFBtdC9TeFZkeGxx?=
 =?utf-8?B?R1lBYzVIU29wakJuZjVjQnVKSGFKYkErVHB3MEVha3c2YTFlaWlLYzg0Y01B?=
 =?utf-8?Q?9GjmG3yV0sBl/JQs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe614c3-0670-49b0-a4a8-08ded8cd9288
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:37:37.2229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYBb41p71/bd4r7B81NewahrgES+bSPR6edRfSD8buk5iu9n2+XE7s6LuNb/OuA0YryOcQ9+EbMrN9BLOnA0fGZP27XtVfBsOUF/iqkSM9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7132
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vaisala.com,reject];
	R_DKIM_ALLOW(-0.20)[vaisala.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304364-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tapio.reijonen@vaisala.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tapio.reijonen@vaisala.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tapio.reijonen@vaisala.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[vaisala.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C10356FF1F7

The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
entry never set .sgmii_port. As a result ksz_has_sgmii_port() is false,
ksz9477_pcs_create() is never called, and ksz9477_phylink_mac_select_pcs()
returns NULL for port 7, so no PCS is ever instantiated and a
phy-mode = "sgmii" or "1000base-x" link on that port cannot come up.

The KSZ9897 shares the KSZ9477 register layout and operations
(ksz9477_dev_ops, ksz9477_regs) and reaches its port-7 PCS through the
same SPI-indirect XPCS register window. The register-identical LAN9646
already enables this via .sgmii_port = 7. Set the same for the KSZ9897
so the XPCS instance is created and 1000BASE-X / SGMII links on port 7
negotiate correctly.

Tested on a KSZ9897 with a 1000BASE-X fibre SFP wired directly to
port 7: the link negotiates at 1Gbps/full duplex and passes traffic.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d1726778bb488e424aed450fb02c8fe4b332a1f4..718c72206ab451cb4c5e88fc91a5eae4892518b7 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1591,6 +1591,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.sgmii_port = 7,
 	},
 
 	[KSZ9893] = {

---
base-commit: 322008f87f917e2217eeac386a9410945092eb2e
change-id: 20260703-ksz9897-sgmii-port-48ddb100e015

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>


