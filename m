Return-Path: <netdev+bounces-206887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D1B04AA7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330021725E5
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9627990A;
	Mon, 14 Jul 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dsSsWqMQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B107277029;
	Mon, 14 Jul 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532169; cv=fail; b=dNIq9HTNiDE2edN5dsXFkyJy8UBaPSPbZapqWpVJ0Z/1AMggthl76P5cmR+pIrwaGnXlkBNauO5o2FT5LO6XLCH8VHbTMzEqfkACzeRCa2RKIo1IrS4Z450w2+pjyq8Ny/IqmDrxvyRlio+aThdIABUgsyG/gCT/BjtcqU+mIno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532169; c=relaxed/simple;
	bh=vD7U0W8jq9ZBES2U5CpLtq4qU8xFQUXx+ipIqFfZ5zM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XVWV3s+Mn8wG9qeNfTRsthsOoJa0jDWRt3Tz6xbRunrT2STr8HGDf0CLbGQtO7kZALFNoJgOyXk9VVt+akmoqrgMSPDNHF3Ttc+xQ5pngiQXKuZFTfgglc9IJSOLhYUJSJh4BPDZ/+rX5f83+m/8Xte4wY0GjDvAjaHgeHAszXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dsSsWqMQ; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvKiw8k3StcXlkWIl+Irj9NWJa4pvh5jd/GufFPNSEj9j9xEVIMBXlPkTEQ3bKQr/qVpC+V9p5DPEHeMPDxGZIPcPEpZ7Sw3eNxlMWRj86ewTMM1RsXkBHMTZIPZs16MsQmUcMsNednLVj//a++DBKFyMBKVILZBtq1knwy9SgA4jyR8zILahpFYSWW3eZMPRij6q/6/8X6kMOUEuURzIpxgJH2uAIaTO6BQkQ23iLdt8fNKcqKykFNRKyJtnm/DH26miuCQFqK/kVy0O++2EYN/k6aohe6Kc6KZ5bWdFvp1ZJygytmUjRPx4uTKb/rbmTH6Uj3oI/mOJHMfCXTqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snRm24SVJ5kq0lciU/J2jDkWcEb5WuJwDZjvJuL+zhA=;
 b=lf81xAKvg2q/Qs/T6WTIBWIWpR5iOKFRvEYUeDEf/CX6vGQ2Ly4fYpKiHMImigDxYKTYJmWgcm/ssiPoAqcdXitV1VQD9Pz+pW/Qky0E6/UcxQd03ME+KMpzlqCYwRZOVJ/ixDeTn92zqMg7CfiUNM4ty0QMX346BjmT5X+CbvJUTe7zb1Zi0KMNWqpA+dvFOr/T1z0PjbfJvgPbF1msDRUh8hDo0O3LcAccNTa2qqDisW7Wlx6O8PJ2p2QhIyS6JfnPZBMW0IxRFxn1leqq8Z4KAAx6t3AZFq55aVuUTffwFoDKEYG7vRgh5UTJfbJYnVGrpIMeL0nc3QQVV0OwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snRm24SVJ5kq0lciU/J2jDkWcEb5WuJwDZjvJuL+zhA=;
 b=dsSsWqMQfFWbIHU0jsb+o0JfiPkLSatbTyD1nPQS9Sv36MBBC7QuFZoIDb85PjNmNvj7Q2P/sl/4uwJxfrsAPWVteN1WIBiCcJeqK54kQMqZzGvtDGuHmYaDBKcSRgIWXnIcDG0Wp9oLSo7ptVec2KvzVcqyDuGA9WiFex/ND/QONum3ng4ZkIXYHZtvvjARrMrfQVT9XivSG3yUaqBjRzolmeEaLfwGFdrV9qrEapPSyDaWrb7BqPVVbtcKornQdWXQFh4TBido18B5/nmfcCHowvexHJKBUMmneMeS5kyWOa3W2p6SfQjvXiPrYgGtWmworo9SridV2LZfzwT3Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA6PR03MB7831.namprd03.prod.outlook.com (2603:10b6:806:430::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 22:29:23 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 22:29:23 +0000
Message-ID: <baed95d4-c220-4d3b-8173-fc673660432d@altera.com>
Date: Mon, 14 Jul 2025 15:29:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the
 Agilex5 dev kit
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, dinguyen@kernel.org,
 maxime.chevallier@bootlin.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
 <20250714152528.311398-4-matthew.gerlach@altera.com>
 <de1e4302-0262-4bcc-b324-49bfc2f5fd11@lunn.ch>
 <256054d7-351a-4b1c-8e1a-48628ace091d@altera.com>
 <86e1e04a-3242-482c-adb0-dde7375561c1@lunn.ch>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <86e1e04a-3242-482c-adb0-dde7375561c1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA6PR03MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 14621544-335c-47f8-98a5-08ddc325e222
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3VwV2c1NmJKMmJ4Umc4YzlGTjhyREtWVkN2R3g4a2xoK3h5WlF3U2dDY0ZR?=
 =?utf-8?B?WVpHRndOeEtpM0tzb1NFQ21UV2FPOGxLc09RRDAxbmxPaVNGSEVSWEl2R2dV?=
 =?utf-8?B?a2pSeHRKL1RseXlvdEoxNVRhV2RjNHVTdnA3NmZySzZoeklxRU5ZUmEzSm9x?=
 =?utf-8?B?b0w1Z3Y0SWhhUVBmc0o1Z0w3UnM5bU5CK0hhUmR3N0NVL1YwVDRwM0JORWwy?=
 =?utf-8?B?VjNGTkZkd2R5cWtSTFdBNFV3UUk3OEllenU3QUtDNmJzdkhVOHVGak56Qksx?=
 =?utf-8?B?TFhRMjRreURHWTRkQlpyV1ZDS3EwYmhncjNnWGYxLytVUDdrTlNrTW5QL09y?=
 =?utf-8?B?WCtXSWVqQTJsZ3kzT1ZwR01hSGFNbHJHU1gyUEZYeGNGeW1rNTFCeXdFQU5R?=
 =?utf-8?B?WEN6SE5BSXdFWWRZa2dPSDlXRm16M0JmamtHQmtiUjl6ZStFdWw1UzB4OUI5?=
 =?utf-8?B?MGtSVnBHemxOM3Rlanl2MTFOdzBLOVAwTG4vYXZEcDNCNmxxa2tPc0Y5UDFP?=
 =?utf-8?B?S0NkNTNucUNkSWNDWTlBTUdnM3VKSWZpcis5ZFJmVkNBNkptWkhIa1ZkQk82?=
 =?utf-8?B?Z2wyVVY4aTFUUXkyR0dhd3ZGK1ZtNmFGVldhYTJuZm8ycHJFSTJOV3M5bk1U?=
 =?utf-8?B?L2dxeUVYLzc5aDFBc1BIblFvOXI4NENXY3BzeVJmMVc3VDVNRXhlMGpkKzJ5?=
 =?utf-8?B?cEk5Z3ZqYzY1cUpoR2lacGFta3pSTXFwcGxHSWpLR2xFSEs4VEcxeE1SSTdO?=
 =?utf-8?B?dE83ZytIRksxd0pXM0xNYk9CSUMzUlRyeENWTWtTV0g5a0R4WmdvNFpSdHpB?=
 =?utf-8?B?R0JiL1hhQnlRaWk2Mm1UN0J6MnJEOGxxbHYwYk5BRHMxVUlwT2ppS3Q3K1lt?=
 =?utf-8?B?V3owY3FKakZ3Y3BUZWhDZXNqS2lEbjQwakMwdlZZSnVudzQzYzJocEJ6VHFH?=
 =?utf-8?B?TzBNN1VlZnloQWtUWXNHd3hmek5sZGk4VlFVb0VDN3o5eVorb1NKUUF2UkZ1?=
 =?utf-8?B?RjZ3UUV6NXFzK0JncGFwZ3FPTjBway81L0Z0NzBhVVhNQUVXZDJtK3pOL3FN?=
 =?utf-8?B?UkNxTUd2OVFPeVUwK1F0SWIzTlRnQlFZZUhtQ00vcGJsZmNsT1lpdG9WclR2?=
 =?utf-8?B?Nnk0TEZNZTA2SHpCM2VHYkhEdlplNmJGVFVaL1hPMFZDUDZFUStqTFdqVitK?=
 =?utf-8?B?Q1Vwc1V5U0JGTXVVRXVOSTBSbG52MThpTTE0S28vbzN4U1lCTGtpbitVYnB1?=
 =?utf-8?B?SEk3UTVNSkpBOWFTZnA2UUI5Z2tjUU9YU21aSjNQcEZ3blhIekNZMExhcmZP?=
 =?utf-8?B?T2hGcFBGT1RMY2lua0d6YW5taXl2dnF6QWN6a3d4OFdyenllVjBkYnZBbjlW?=
 =?utf-8?B?am9FeGhGVUJuU0tXQWh0azZvNWNwQ3NuWnBmaHRUbVZLWGZsellYanhjY2Zs?=
 =?utf-8?B?M1dXRS95MDVJVUpQU3hHMEFxbm15M2EweFM3azljVGtOZ3F1eVE3SjUvVU1M?=
 =?utf-8?B?cEtVN01Xbnl3RnRwWGN2MDU3NDhaZnJZMEN2alVHZkEzUGpaVi9PSGpDUTNP?=
 =?utf-8?B?Ri8vQXVmQWNJdnlHT3hqNGh5YWtVc0Q2czNBN2pPMnZYNjBRWW9KbjZQNWZF?=
 =?utf-8?B?cUxXK04wRDl0Y1pSeUhLRnE0eGNBVEFKMEt4QWFEamtGM1ZoeVBER0orRUlN?=
 =?utf-8?B?QTRpU3djbm9WSzlUMS9YbXRPbTBhWHZtd2ltT1VReXlVekxvcjR6NGFZSm1C?=
 =?utf-8?B?UWZ3ZzZzZHhUUFVkYlF3N1lubXNyRm5SRWxXeTMrcVhaQnNPOE1LWU1ZTGl0?=
 =?utf-8?B?MFU0NC9ZbjVGWkF1bUZYTzIxdGdoMTk2Lzlwbnl3NXgwcGd1V2Z0TkMzMGF4?=
 =?utf-8?B?dXdsV2p0UEoyN3Q0SnF0eVN6Y3pDblJzTW9UR1laeUFwaHIzQ3krSHJncHhI?=
 =?utf-8?Q?eb8nTIOF0Do=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkprc0NicXdEaGVtMll2YkFiaUthWGRlVm5rOGs5MGxlVlpOVUxMWUdNTWJw?=
 =?utf-8?B?TlVqU2hLdUNoSDBOczBnOGtaYXBSMkY1ODYyTThueDJYVTc4dXBXWElkalhm?=
 =?utf-8?B?YTJvU3AyZmw3dnVJd3hpM1dZNzJCZ1JtaS9welBjeC9RZDVnbFcxTGxvaGpT?=
 =?utf-8?B?V25rd25iR2lLamhrNEgxUGV4eFI3eWlObjR4aGRMRkI3RWRXT21QSUk3VSt4?=
 =?utf-8?B?d3dsbkw2R2pwZ2hsR0R1UndnSURzVEFLMU9GdmwvdkJrMUM0MHRTSVJmVlNS?=
 =?utf-8?B?Y3p2Q3Jjb3RFdkM4SERxb1JYZW53NVcxSFJObnNndmI4Y3oxZTdvYXV5bDBX?=
 =?utf-8?B?ZFdJb3JjM2JRM3BCazBOQ1VxalMxM3g5dThkSDhlSVM3QXFwQnRrRnNHalhZ?=
 =?utf-8?B?Umx0b3FFTm1laDVsbzZwWDhQU014WWgxc2NjdTF1M0c5MW84TExVdWJEd1g5?=
 =?utf-8?B?WG1NeDFTaytTbVMzQWE0WStiTDlYUUlRV0ovaVFvdXJWYThvNTZSWXNDS3l5?=
 =?utf-8?B?TXVCZnF0amtvSFZkamdPeVVuY0ppbXhXUnZHeHYyaDY3cU12UjNrWXZ0YWJQ?=
 =?utf-8?B?VjFtTy9IbVlpbkFJNUh1b3RZV2xjZGZKUys2blk4MUN6Q095NEJXbWpad1lH?=
 =?utf-8?B?YzJlZkNyVzJ1Vnlrb0k0M0hyRVpuLzBBbFRpRlpZVHE2RjdaeWwyWFlsaitJ?=
 =?utf-8?B?NFJ2N3NzMzdUZ0poZXZxb1VZS0owd290Nm5xZmJhNFpsZFpOU1YzVUd0Y0dO?=
 =?utf-8?B?NzRqcEgzYXlLK1Ricm9kcW9nS2R4R0ZEL3BEV1RFcm5SM3BPbzBJQjBnOTVP?=
 =?utf-8?B?N2dRM2g4TzNtQnlnMUd5RTQwZE5mUlBxanMzSjdXK2Y0ZHhGMmFFTHBveTht?=
 =?utf-8?B?ZGRQd1dzYlZxYzZvUGNrR3pUanVoSlhyZnNwK2JZZ200cE1ETEZjeG8wY3Bq?=
 =?utf-8?B?RmpoRStoOFhkNmRnTXRYSmNEbnJRQVA5cG13eHF5bXV3cVFSYkd1SElSRWJm?=
 =?utf-8?B?YU03QitOaitjcXhhSi9tcWZJd3kxbE9UOFUvTU5KUExRS1laeURnd09ydHFh?=
 =?utf-8?B?a3JHQkRKbitJRk9iTG1FRHdqekRFNFMxZlptTXNLV1ZKbUwwdGx1WWtjREt3?=
 =?utf-8?B?T0lXTkZTaXl3N0xYREZLeUk4S0praXlNUkNYcncvTnpqMGdiMzNlMkx1Wkky?=
 =?utf-8?B?UmRKekJiWFhYWnl3MUZWa0JVVy9udDJCWmpGaThiaGpXcHFnc09HeTJVUUIv?=
 =?utf-8?B?NTlsQ21DQXh2dVpVVkZyaE52aWV2dmlUY3hEalNERUhlaUhxR2hLaFpLMXd1?=
 =?utf-8?B?S3ZGRXhkT0VScjJuQXZseVFROWV0N1dETTcxaS9CeWZTdGVLUFhEUGxLMmlo?=
 =?utf-8?B?MmZ3bk4reVJadElXQ2tuZFk1RFBzVzl1MlRzMUthaXlMdVdEeGtiekdQbEUr?=
 =?utf-8?B?YkFQb1JrWThvd0IzcW8zUUMvVTU2c3Y1VVVwRWI1S1dWeDVTZHV3WFE5N1Ux?=
 =?utf-8?B?alRrbVFGbFlxZGpHMDE3THQzUmxtNGlBeG1pZEpteVVpeFhiRFhMa2ZoYUN6?=
 =?utf-8?B?Ujc4eFNuRjdlM3EzaW5teE1OOWhnUnczK0U5VVVISHp2UzFJZXhRNmdSTGt5?=
 =?utf-8?B?Y0FqYlYvWHpQNTNBbVFXV2d0OTRDOWZ2NG4yOUpOaTJweHVzU0xWa0htOHdY?=
 =?utf-8?B?Rys4R2J5d212MWJGRlFkWCs1U2xncHdoL1V3RjFQRjJsTitMYzhHZTVlalA0?=
 =?utf-8?B?TTZvdHBkbDR3VHJlOTk3cVNxb3NTOTY2VkJMc0ZwUGZaUEM4MDEyVkRvREg1?=
 =?utf-8?B?anZISC92V2FzVEZhVWJMKzZBZkp0eGxDaS9vWFp4SVlrRVZ6ekY3bmRSQjBP?=
 =?utf-8?B?K1N0SmJPakVDQ2JERHJvYkpqMU1kS0tJNzZHa1UrdGtyazRmc3FJaU5PcmRV?=
 =?utf-8?B?QVBCTDFyeXg1WlhvWFlPOXkvUGVnTW9xaERWc0pSL3Nocm80WW44eWJUNVBo?=
 =?utf-8?B?TmpoNUNJOWhTSUU4TkZQY1QwNkFiWmNTdEQxOCtSK1ROUGQzb1pIQWIyclNn?=
 =?utf-8?B?d3VyelJVYkFOanNEaDhRZGJqRDUybXRXc2VlQmYxTDdhamt4UFd0OVJucytq?=
 =?utf-8?B?bmlPUDBORHFBUUFkOWxFZXBMSE52cmYyb0FHRXkyTTJYQ0taSC9uVG5TK2hr?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14621544-335c-47f8-98a5-08ddc325e222
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 22:29:23.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkGdBUN9UW/XOT9/0fB0tjMBCankeoYOgvT5yVN/RqIrcY4356Igk6OYywa5+ixS5mk3otwNlz3PuE7XrQ+DIl+guK1UbQVRtlZcqYk050I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7831



On 7/14/25 11:52 AM, Andrew Lunn wrote:
> On Mon, Jul 14, 2025 at 11:09:33AM -0700, Matthew Gerlach wrote:
> > 
> > 
> > On 7/14/25 10:25 AM, Andrew Lunn wrote:
> > > > +&gmac2 {
> > > > +	status = "okay";
> > > > +	phy-mode = "rgmii";	/* Delays implemented by the IO ring of the Agilex5 SOCFPGA. */
> > > 
> > > Please could you explain in more details what this means.
> > > 
> > > The normal meaning for 'rgmii' is that the PCB implements the delay. I
> > > just want to fully understand what this IO ring is, and if it is part
> > > of the PCB.
> > 
> > The IO ring is the logic in the Agilex5 that controls the pins on the chip.
> > It is this logic that sits between the MAC IP in the Agilex5 and the pins
> > connected to the PCB that is inserting the necessary delays. Technically the
> > PCB is not implementing the delays, but the "wires" between the MAC and the
> > external pins of the Agilex5 are implementing the delay. It seems to me that
> > "rgmii" is a more accurate description of the hardware than "rgmii-id" in
> > this case.
>
> Is this delay hard coded, physically impossible to be disabled? A
> syntheses option? Can it be changed at run time? Is the IO ring under
> the control of a pinctrl driver? Can i use the standard 'skew-delay'
> DT property to control this delay?
The delay is not hard coded. It is a synthesis option that can be 
disabled. The value cannot be changed at run time, and the IO ring is 
not under control of a pinctrl driver; so I don't think the standard 
'skew-delay' DT property can be used.
>
> For silicon, if the delay cannot be removed, we have MAC drivers masks
> the phy-mode to indicate it has implemented the delay. The MAC driver
> should also return -EINVAL for any other RGMII mode than rgmii-id,
> because that is the only RGMII mode which is possible.
The delay in the IO ring can be disabled, but implementing the delay in 
the IO ring allows for RGMII phys that don't implement the delay. 
Currently the driver, 
drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c, and its bindings, 
Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml, allow 
all rgmii phy-modes.
>
> Since this is an FPGA, it is a bit more complex, so i want to fully
> understand what is going on, what the different options are.
In this particular instantiation, the hard MAC controller is directly 
connected to pins via the IO ring, and the FPGA is not involved.

Matthew Gerlach
>
> 	Andrew


