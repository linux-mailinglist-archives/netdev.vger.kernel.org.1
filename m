Return-Path: <netdev+bounces-268094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EP+EHXXt2kwWAEAu9opvQ
	(envelope-from <netdev+bounces-268094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:12:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE84297B83
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88AE93028E89
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71189352FB0;
	Mon, 16 Mar 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LBd+wzDC"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F81D9A54;
	Mon, 16 Mar 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655627; cv=fail; b=VUvsuo83Ka4bEISYwRplSghu3yAvbnVV+V4w2PKj1B9izmbwefBkFsah+GtD/UnxHnIAzyVo9yoNDQ3BhY9Vjob7jRt7tpQ9tAJcrhkzmq9yJuscvFhXPqbSr+6iVvP08Se21PxIG/eJweydBhxo55VfaEoCcACjZSvUyrdaWmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655627; c=relaxed/simple;
	bh=uHC+ahLTz+AA2crX8r5jHYlui1TQ4EU8eOY3AIwb2Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pyeq0igzFR2hi5qyLCbMxB+7z9YlBkth7MR75J8szATHk8qhOaVOn9rMJaGD6vyDF7nSmQAfT/zRPokHHAyKfMCzLybjVHctA88P40Pcpw9ci+s4t73NDLEC7ygQCEIkxC3hWgEIlK8ogIeFHQPpksxHPiwCtv+gG/v+dFm0E3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LBd+wzDC; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpj20NCFkAADf0yLfRziyJRyo8D1+5Ct2Uc8+dXMIuHdGQ3DoKC2UwDJLm9ShuvytR8vFV1fwAz1ZC2j4b0wOO+YSZ2pqfVPTNFUv0DeAZTzEJ4eBT3cntdgSjinOuJFUt7jha+sSbw6tIfvW6wuS29q+bRgP7UM8bPVpAeW/hvH8ixS9c9LdV88weo4UAkcpJOaIxgNhskwhuA6Re3z4rB8IJbsHiLYB7VOn8J9ZOxunxWfCRGLNdmzylNd5M2qqFdZuR/mWgmm3ql+I+62Qygtb1YIJXcAzaimZIWX+eK9TmRhShOKw+4a/QgGQRf3747DNsmjlvC6YUyxlaU5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4ELkv4EPn6qeJLdHjZSFn+VoUyxgOIoclCGAnRiDHg=;
 b=M3FetOg/jY2RhMiLFSTVQm3L+gTO73pzZiUp1TaZiIfOpDNTTT0DSDD6umez4NE0cuTMOIYiOaiSf6lfAAsUtGnrrxq89gyHzGKo5DcgUiX2Lwy7E6dmLy6onFjNpzqgDYOo+A27DyVgJxZrkCgP7un4yPSRgovo0i5DDwjgTfi9FZThAXM3cPeQCOGOmlX6L5p+5fR6L2lVnBj+zP4cB8thnVVIMtatkc0xmKTGx7ylYuwJ20Cc3Py01KusqyviEsefJ1LvKzHqlDLHH8Xl+3+Q07LyX4sFgTiR18AYWVs4oaFmtKjuZaULlKGR0KfFEJG3giIjp2PV3svQ9gp0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4ELkv4EPn6qeJLdHjZSFn+VoUyxgOIoclCGAnRiDHg=;
 b=LBd+wzDCAjxHcsQGXI7z2LCTc8zAvI+FETMazhfIS7ujuqKzaQb0VA9eiBKDV7fFXvhrdodLiki2ISTmhm8GSESi940/NJhXJYFL7BCoYg5KVQ1KszV0ySee4E5nIG6leqC+6rbADYThLAOnB4IhQwJQMfpBRzBf6Mck+Z/nqasVmNRrQCpGEz+eJH7d7xHeI/vFXtV9vIUsJZdyX7dxkkoJOrXEuDkMRn16L0/4kh/PQVrD8eXgGMhvsBmRjN/29whmMkzT1TSJoHXMU0pYTArvAvtEWj7bE0qCeeR9jDWLW4qAJ3nq9H/cBLDWlWLZ7NaaObIACb/FKsdnllBUyQ==
Received: from AM6P193CA0137.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::42)
 by DU0PR10MB7998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 10:07:01 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:209:85:cafe::f4) by AM6P193CA0137.outlook.office365.com
 (2603:10a6:209:85::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.22 via Frontend Transport; Mon,
 16 Mar 2026 10:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 10:07:00 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 16 Mar
 2026 11:09:17 +0100
Received: from [10.48.87.194] (10.48.87.194) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 16 Mar
 2026 11:06:59 +0100
Message-ID: <45710ac8-94f3-4272-a672-6c5accd7003b@foss.st.com>
Date: Mon, 16 Mar 2026 11:06:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: stmmac: fix pinctrl management during
 suspend/resume
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Linus Walleij
	<linusw@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<antonio.borneo@foss.st.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
 <20260313105718.359614-2-christophe.roullier@foss.st.com>
 <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
 <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com>
 <abStv0IPLfkKMD-W@shell.armlinux.org.uk>
 <abfHUrOpHnjv3GGW@shell.armlinux.org.uk>
Content-Language: fr
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <abfHUrOpHnjv3GGW@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|DU0PR10MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: eea36ce5-2632-45b7-aa6d-08de8343c3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	W6eJAlGvcqs1saBdvqsRJ7HgpSOr5QaXw/rnp2m/c1lfH2BNvPIxTUjqRPt9zSB62LFqiq4cRoIuzMR3ISOMW49ri+XgyAxlQ+p56JEFYgGdbhbWFP4vPzJ8ygwLi+Wai8qTptMUbiD6i/VHeJzgSEAYSaqq+mpMRvj4NvZy2ksK2I6OJxul1ygknSVhg/TBvt4eortIvuDAVG9WOUNvwK6tegsH99Ov/pM4EQKIb/LJgVjXfgB39+72cs/mSpDuWB+O+JuwJTpdyom6ZM8mFqql4pr8GTsfp2t5qLDXR4zCbrP6EuEaNanEJhgFoVV2pX+bFOa+q3HreFA6fPX3nhxIz1hgpr4htHNhDKgtiSuZy2h8q36DNUEuqoe0+BvdotmvB0wIi1vqoC1+jsFuZTc/dUNtXCbvsxAvjyuCzay7JlDVjynNPYbdj8E6M81mqKqwjBWSgmmy3S++sGs7qwQ/M69ZzA32cesDArcILbA9HzBn3GjOmFLfacs1MydGnGfCi1sZZDeJKgiCpNHK+rN6wSRYIBtcDlfa+Vqt6vb2iWQK1jLqstbW1IYoqz+SX18ynE8wVqIUOf4OAPEGYnufrLia3/W6SOIkvKY+nnQK4PemFRSQA8Gy7xwiGOs/f0dXLsdsvC3ZQeAPHKejTK6/756YeDm4nuBV/DdMZ71IiLE0jP1Hftovjz1I2L4rv63vLlYCuf1LE3aaLHP4+I8tQI5KO+NTEfq8DOVluYfU39+2Kubq3xbJnoJjvUj2Dg2oZBf0TR1ZiOcKaeEf0Q==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i2N+T3+bPVHAwU/8WeNMzxFcsMkfjRaptbAuPPqlQVo+GOfHT1XHoSZlsPwDXFtbXTCBpJe1Y0JOnuZNHFj3iTV58MZg3xp+egOhpoCOuxrV4aZnRrPjRQBT9rmMiq8Wablg0oaDoZvwNTbOsi8/mP+Nl40w8hHgHbc8MHkDTdcIUdo1hZ+Z7sYL7L2I1Ae46BRvTZ6vyE4p9hs6FqRVoFdbvgazkV2I1zWWkg/WzURW0e0vJ5lO7PcKg9c4kAPyFp6MPAjDs2hW4l/OlN8LmmuIZl20mwzVUykejhYgtr1vwvUA8zMbFu6xzhPM/XvOH3N7UnQP+lSGfW0JK+nivdneNGTxCn47cSJlWwVIGOWPpC8rzV/fSySLeNfBaOJ0PPBcxr1YF79R+GWRBIrdn+a54OC0KRaSAO37I14PuWKXgbGCl0K0Pd1VPyoKTFLB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 10:07:00.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea36ce5-2632-45b7-aa6d-08de8343c3fe
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7998
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268094-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,nxp.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,foss.st.com:dkim,foss.st.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.roullier@foss.st.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: ABE84297B83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell, Linus, All,

Le 16/03/2026 à 10:03, Russell King (Oracle) a écrit :
> On Sat, Mar 14, 2026 at 12:37:19AM +0000, Russell King (Oracle) wrote:
>> On Sat, Mar 14, 2026 at 12:44:56AM +0100, Linus Walleij wrote:
>>> On Fri, Mar 13, 2026 at 12:08 PM Russell King (Oracle)
>>> <linux@armlinux.org.uk> wrote:
>>>> On Fri, Mar 13, 2026 at 11:57:16AM +0100, Christophe Roullier wrote:
>>>>> In the deepest low-power modes, the pinctrl configuration is lost
>>>>> and is never restored if the interface is down.
>>>>> This commit ensures that the pinctrl state is set in all cases.
>>>> Shouldn't the pin state be restored by the pinctrl layer?
>>> What we have in the device core only applies "init" and "default"
>>> states, and provides these handles for transitioning to "sleep"
>>> and "default" again (like a state machine).
>> What I was meaning is that - for a driver using the "default" state,
>> if the hardware loses the pinctrl state during sleep, isn't it the
>> responsibility of the pinctrl driver to restore the state rather
>> than leaving it in whatever states it happens to be when the SoC
>> comes back from suspend?
>>
>> If that is not the case, then don't we have a major issue where
>> drivers using pinctrl but do not issue any pinctrl calls in the
>> resume function are buggy?
> I would like an answer on this before this patch is merged, because
> even with your reviewed-by, I don't think this patch is correct.
>
> For example, if pinctrl loses the pinmux state across suspend/resume,
> then this patch only solves the case where the NIC is down when
> suspending.
>
> It does not address the case where the NIC is up but WoL is disabled.
> Also, what happens when WoL is enabled at the MAC, when we expect the
> NIC to still be functional - which means that the pinmux state must
> remain active over suspend.

For me this case (when NIC is up) is already managed by the driver and 
function suspend/resume:

On stmmac_suspend :

==>      /* Enable Power down mode by programming the PMT regs */
      if (priv->wolopts) {
          stmmac_pmt(priv, priv->hw, priv->wolopts);
          priv->irq_wake = 1;
      } else {
          stmmac_mac_set(priv, priv->ioaddr, false);
*         pinctrl_pm_select_sleep_state(priv->device);*
      }

On stmmac_resume :

==>     if (priv->wolopts) {
          mutex_lock(&priv->lock);
          stmmac_pmt(priv, priv->hw, 0);
          mutex_unlock(&priv->lock);
          priv->irq_wake = 0;
      } else {
*         pinctrl_pm_select_default_state(priv->device);*
          /* reset the phy so that it's ready */
          if (priv->mii)
              stmmac_mdio_reset(priv->mii);
      }

BR

Christophe.

>
> This is in addition to a more general concern that almost every driver
> in the kernel is likely broken if we need to switch pinmux modes on
> resume to ensure that the "default" pinmux state is restored upon
> resume, which seems to be what you're saying by giving a r-b for this
> patch.
>

