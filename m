Return-Path: <netdev+bounces-289363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A6LEfwxDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:48:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC657B9BC
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E941303FDE6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7147DD79;
	Tue, 19 May 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="l7ML3shv"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1C47D957;
	Tue, 19 May 2026 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183899; cv=fail; b=fJkDBlrrq22cDT4EMWC4EJd/VuvP2WDLpTtatlUN06ensizrmlD/nwwQVPYAX59yUT+Zem0YUpJZPLiszOX8/28ijcIHcqyyDa7MW3K+PsK0caYAGpaMZUr3zxHg2Ew15/fos4gUqYpMVqwsJTjFjmzrdLqXtJe+uoncKtjqMKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183899; c=relaxed/simple;
	bh=2aZZ+NCt4ac2AKirQrdf5L5hsVtKN8XoNRnQnngBQUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L0Gztv6CVLW2y0bEbU09FGKN055lKXjsSlbq5aCc2SGlVDoJX70HPDd8OACxGA6V81yNsKlu7fpnRJFvou8d384K20nOj4mwvuJRjdIPuICPuO7V9kYbGO+sO51A2vMINX82TS1SzGstPVwpOrC6jRr9zAKDBQ2BmRYlrkYQ0zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=l7ML3shv; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7/A5qsSXz/gtCz0oW1DEhSOhhVQSdbsvuizSF71DtQK/4e6wGlZ0zvK6w5xDdf+otqOYMsc7WZ0uaUaCZ4PhIr+KhJHuymvHlaENo/AJsZcl6mxlkI2m6xSCFFpkAkV6v1sbIfx7V6lB2BSrfRcICqoZehNVhH3fOq+5igPIN+MJJ8HzP8EhYMe5bGXaaKHoJNfF8Ge1srbaC4y4M4wLC/rIwVUiSCtcmQ67UP7zlnST2o0DbDCUaCPbSshy9B2rZqe2oX6oHsti4ractsMBC79NkkYwH6bGZpb6SCtWarxvtLzA76IzxjFLFMreahEQDC9EnrIG7i2c/SCMVP7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgSRh1FfKHsM9LdjlVge12tmSBSbx+UxJlgcC/kBykA=;
 b=QYknUqBKia5SvJ0PLKGAmsyh523LRSrYp6XW9rKrs6RPiglNu3qP579+AkQCsy5Ttb3gnW7cMLFBHtpyGNT8vEmiB249rKmo1yeAKfd5s96Zw5cn0cuA9Ut1mtuBkHWNd8MZB/STn7ComPGUd6Mn2J01EM3xcTevak0OZa1CvjS8vRtqXE1nNKe+BOLDEZROmD9wXg30rJQczzn5mjhXaRw4leaAmhSzA1/+wYz3dj0LLn1nZ9WsGvycGAPv9Gs6er9Rd2SQFXOxqD/ny+1msTiWukpBzVqYpbygO5zN/xRZceo1Nkm4QPieiQoUe5cNgExpRSF7xgLM1OZMOfCVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgSRh1FfKHsM9LdjlVge12tmSBSbx+UxJlgcC/kBykA=;
 b=l7ML3shvEk18GDIz+fYwpasXXQ9kwyqhvFkHNFDLiEI5JmNzNBwjCpVDrHVoJRTziUlcxoKp1i5/psP3Wps0jrpbxfzQViPR8pqyFt4iuDg3hGeh1EIftZPIM3ui6Zbch5+159zXdb2u4FpbftjLBZJ+NkS00V2a5IGQabWhSb3vXmJrpYvY2w+sbBhvGdRDYAFIHm6xSCvU0GveUGkY3i2++W2kmkMpzW8syJRrjjqqdYfCanP9vbZx5yh8LI+PeaRVuTzw8BXzCNq5NMP4q+/3aJJnFwrqUqryQctgkvvLQg4jRFWbflxZjW7KMHsPvlgwv4n0DwppO8CMrb9TpQ==
Received: from DU7P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::29)
 by VI1PR10MB3503.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:44:51 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::36) by DU7P251CA0009.outlook.office365.com
 (2603:10a6:10:551::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:44:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 11:48:43 +0200
Received: from [10.48.86.79] (10.48.86.79) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 11:44:49 +0200
Message-ID: <81ef6f52-0127-40d9-bd34-1ff501153fe9@foss.st.com>
Date: Tue, 19 May 2026 11:44:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] ARM: dts: stm32: Fix mecio1 hardware revisions and
 ADC/GPIO mappings
To: Oleksij Rempel <o.rempel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
References: <20260318105123.819807-1-o.rempel@pengutronix.de>
 <afwfpST_NNAWSo1l@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <afwfpST_NNAWSo1l@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|VI1PR10MB3503:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e040ea-af87-4495-cc03-08deb58b45d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	l4dTY11ExQrwwApWU5xE4IiGGE7fwCMAOgMHEm/9GXP2IXnOXqarXDN70BtPN4ZGVyyTxLU0Sp5r8Sl4b4GaEjNTdJmpYI4tOG7PROXwSHe5by0VHL+zhBSeXJf8hYMRxHWwyB+F7KzWqUhrQAgIsqwXwxQJcloqA1Zm4gqpQ8HNk5+l0SbqzwdUML4f8CRyhjvgWIAtq6vjVD1a7BgzXOVBOJhzJl/6dUO70vhPmH3X81zRi2WSNn+I3d2JDivgDIqbCCjmtdI65sW0qcaGa2O2e6d9cna4Dp9Nynhk1sheuLaZHw9Xc6FqJMRtEz027Z3QOcQWIQaLq6msWjyASlX5fpARBUu10hndt+LQUfc9PIZu3hCcDA1gKeFdoYhrWh7Jo/Z6wom1u4FnxArH8KjG0B6ko/D44h/H4yl/5XlFSD9bbD3Zfc3K1u1Jkw+gMJcwthAYFPVvtFSEJxVwVD/Kn5fMzuIzWcaPVnlozMqkr41rqBfDEH6VqGewUY+W7GytPHgp81vgz10KWERWh0mQrwvdjYgiyyrKKKno7OEQIR5hf4zwh1w5HWhkLJMuXxTtC/pdP8gakzCa4LMxDEFfqOCnRY33ZOmnaMdkgBqwGjJRZSIJztQE22aISSyeaNJyvVeoWIOOWfF2UJvPcKiCsT6/Fiz2J0MhEFWUnhH+cIHHbLrbvilpkUC/WyaZHDholBTj6gZK9XYInJ85+g0uxOTep2Phgr4c386+/Ss=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7HroAz8CJ2rI64ME4DBjusbmhmNNrLwUhZzl7VK0hmKmsDnSsZndaAnOj+ljtrKk0lj0TqaGRZMTBUmURCp1MfoWtbGUw3m77sx/juHDf9fHPSd6U33F5uni9a8GCnLV5FTb6DFz/WvWgVPoQVvdqFnEZ9JuFJUNBpPjj50iO/o5ec48Yen/rQ01W8CfhpdCo3EbnCz2dRdwLtsKKtNArUjstjkamZYi228kOgMzuqdgA9qW+XScEm+IUxPE5M7QV3kU0RFGbkhw6FfIrrxGSkeNFrEv3zgw3zbq6/MTwCJIVXoPbgnYbPMaxLqkKI4NrrfOHUzuwu240sK2Wrc1IKMKDeAtNcGH7SpmsrQMrkETU/E5RfkKkACLQmMwPcy0+L3y8CdiyzXpjH1Xx/g5MpJW4A5PR++8TUW0EYB56XzlyYvJlwni3AwZThOZcTi2
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:44:50.8919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e040ea-af87-4495-cc03-08deb58b45d7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3503
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[foss.st.com:server fail,sto.lore.kernel.org:server fail];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandre.torgue@foss.st.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DEEC657B9BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Oleksij

On 5/7/26 07:14, Oleksij Rempel wrote:
> Hi Alexandre,
> 
> Can you please take a look at this patch stack :)
> 
> Best Regards,
> Oleksij
> 
> On Wed, Mar 18, 2026 at 11:51:16AM +0100, Oleksij Rempel wrote:
>> This series updates the STM32MP15x MECIO1 device trees to properly
>> account for the physical hardware changes between the R0 and R1 board
>> revisions.
>>
>> David Jander (7):
>>    ARM: dts: stm32: stm32mp15x-mecio1-io: Enable internal ADC reference
>>    ARM: dts: stm32: stm32mp15x-mecio1-io: Fix ADC sampling times
>>    ARM: dts: stm32: stm32mp15x-mecio1-io: Move divergent mecio1 ADC
>>      channels to board files
>>    ARM: dts: stm32: stm32mp15x-mecio1-io: Fix GPIO names typo
>>    ARM: dts: stm32: stm32mp15x-mecio1-io: Move gpio-line-names to board
>>      files
>>    ARM: dts: stm32: stm32mp15x-mecio1-io: Fix expander gpio line typo
>>    ARM: dts: stm32: stm32mp15x-mecio1-io: Move expander gpio-line-names
>>      to board files
>>
>>   arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts | 128 +++++++++++++++
>>   arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts | 144 +++++++++++++++++
>>   .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 146 ++----------------
>>   3 files changed, 288 insertions(+), 130 deletions(-)
>>
>> --
>> 2.47.3
>>
>>
> 

Series applied on stm32-next.

Cheers
Alex

