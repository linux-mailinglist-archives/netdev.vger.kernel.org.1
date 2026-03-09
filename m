Return-Path: <netdev+bounces-265629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCI9AjL0rmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:24:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E34F23CA8F
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EF3F302F73A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284B3C2774;
	Mon,  9 Mar 2026 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Et6WcKsC"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF23E51DF
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073167; cv=fail; b=Lr0F14BVNkczXt8eVG7I/reqeLFd5NZNEe7RNvmvbax0UTy+WC/7ypc7mnQU7QdqmlWdYt7rr/hU9SY1Ahc/ZBTD6XtCkRpfeAAso5je/V7oRuPLzTHwXCESRfThAVt4+VbePxC2iwPNXwvyS6jTnspSpiVisbNWE4Wd1NmEVAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073167; c=relaxed/simple;
	bh=biVFWiPHQqffUgAMgPslCMRR0swUiYukiftTnCwWBM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jEWrMa8aKHXtz+xb/MUqEFC5rzDOCgN4Mh3z7a3dNfQQ2f7+9LNPcSd5X60Kl/ibObdoPo+B0AkN6huednAHElSNUi/R6snfLvLr6piIhPk4m510e1YQuHA73TYrcUOUIPrOivGWo1VCug3LYroGM+znHE0F1aLOj+BmPs848ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Et6WcKsC; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G57pp+7uvh2Ih09QInLxmAdM2AvmyTmleyFZp2xVpUnjyrLxtISdfQfsjypBOSNypTf6AKN0S5WzTS0UrO5KvpAPK2Z/2LyEk2jRFpnJL5SCVuA3LK6J/dXjvRzieezPdKpzFsv6nWJNGC20d1KfSQZQnkGFYhdcQKRiq7nv/Z8od5VhR2oCtwSiMZju9lXDBB7uXgGVIpj6dmbXI4YkScKjcmf6H07OAMHbxoUyfyg5AhNgKzK0csyh6t+50BYF6e5gOxNR5mmiCx57jDfxjkl1dxv1f+Yub0XRM8l+pqXxqaKKNrnzlXYQfxuvKistFLQnFB3sBmdrEjmt+YujSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biVFWiPHQqffUgAMgPslCMRR0swUiYukiftTnCwWBM4=;
 b=vUZ6zjjkVvF9dvDnSbXtpTAYW8Hr8+hIoNxOwIqMP+5sza88ppYx4Jq1IyozKRGySFKme0m5SyY4neZZ3QnL5s3DnRp9ZZmutI076i7Gi/qktrWdVK9uc/zD0ViF5If9HceKmzWV8xQMF9Ef8FLgWhj2+C4TUoK65y80Twe28zTQZq2IJp5+uz8sdlprE93m2/YggKonbKwHfYcMYNBaolGTAnqHw9Vh7HjhVEH6ysnUH/RsPcDgS3cuD6RvuCo21C832ujoFq12KS45/3eZFNC0XIT8pHt4Wrx7ifzj6yU+6v0tUHfejQvau4eeoQnfu8tpfAe2boCSIF07waQbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biVFWiPHQqffUgAMgPslCMRR0swUiYukiftTnCwWBM4=;
 b=Et6WcKsCSHGdpRiSaFcULq24bSSAoHBaKKHzl/qF0973ZyK9wd+vc04TUhOTQbFC4W76bueCu0DBB0JM6V9vyXq5Y2NDnaQLiFule/ZrT80XA9tzhZuBEqWtpnulZGIGvWXQvPZfmw2qADJagq4/XpbeeGnRxaHyZg7yFwFEJAIWWOgofjTWylKeFZuRTT1b7am1kE/ArcDR9iafXDSjtZd5whqqSamtNdkqRfksscihsBfRDgdAWRB/SSnx/+XYfscAiv7WeQVibH9/XV6D5+aZrOIk2+45kMTPMU7kLNQfrsSSG4AFbhP2ngZED6ITs6N21HEyPQzaKQRGqirTRg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by IA0PPFA8EB66EE9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bde) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Mon, 9 Mar
 2026 16:19:21 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 16:19:20 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in
 offload mode
Thread-Topic: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in
 offload mode
Thread-Index: AQHcrXtpmGA/fY6jDEuE2Ksy/FqtSbWh6vSAgAR7CYA=
Date: Mon, 9 Mar 2026 16:19:20 +0000
Message-ID: <d68d087152e11b2aa9948f84339a5e164a666d5f.camel@nvidia.com>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
	 <20260306115353.28f322e0@kernel.org>
In-Reply-To: <20260306115353.28f322e0@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|IA0PPFA8EB66EE9:EE_
x-ms-office365-filtering-correlation-id: 07c57071-fc34-4095-c6dc-08de7df79ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 jbx9MkZnAozuewhyIrkdbPsKL6/jq5oX1Lnl5laOVD5PnvXBaQ32Rm3OdQaL84OWc6Kbdx88yMKR+yIBnYzPkfXOO/taf1LCtF/9LIUhWlDY8uqqaX46tqO+zjl0p0iDLPhymuicJKf4zlRCqcS18PCRB3g7YbeM5AVHils0E60g2JYxcKOTsYa1cQJKyRDKNv7puBitKDl8S0ByrvodzCQJA34W0Ucnfamch0lQPu318Kmwy6qaU99VCmb5PnvpDb34EpI6VHo6MqeqADZo0mEMTOEilKsp3tAp8rUeX6rIdn52wTqAaIU181NNysCExOATplOVaH9lwMXA6QISgJx+kzA0ZsVLJYv2243mWDyMcEJk4x3FLi2Ealri63MkWKhwyOxe3bsA/1UGuvbI9RE2NXFRflZIznHHiI5hbl6DuujIeqhNsTsBcvBbDjKkuHz+kCJoal/7qBSWUKfXB8UmUqLVIZA6QV+lyjb9Xt9TCBlg1VrWUFborm60xfWK120HkVbekVxW0jBtQR+soro8Mj2D4YeB9cRCwFLTZhqBKMA2bVAfzJ9Z9W72K69KOcwdDJWUjs22DLlaochbLhph3Iq9DJ78cK0xf3YJvJk+rblggHte8a5fBKH2E1125MTxYWUaukkeAChV61gtdggqaMMWLxn4b00E3DoXWlJ0LilVnHY0LICv7oeyYWgXVaFxBgSOACNGZoHTMdRT6bEmQQOf3IrzuazQfOj4X19Icsx8pKfxUuknHRyrYWk4NkHEW7FHzxfvz34hnDzPwOb5gBsLhihVgEUHcneflVU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1drOWxkRVBMNjhiNXpyRHU1MlZvR1k0enpIRUdibWlFOEZyZGNoRjBJdDJD?=
 =?utf-8?B?WGsybUlRVEZ2dUtzZ0dhRFQySGVIY1dINlRZNWw2a2xVL2xVUDNSbHhseTZL?=
 =?utf-8?B?SkVWMXd0d3VvMmsvZ2ZWcngxbVFJZ001ZFdGQ1ZNdXFDb21acXpKU200dVY5?=
 =?utf-8?B?ZHM4R3d4V29ibi83OEtNT3dVQ0I2WWJoc2JwMjQ2TktMRlc3ZW1NSlg2bmFK?=
 =?utf-8?B?WkNnYVAxWWtVa003S3JJZVB5UjExMzFUcGttdjVtSEVYUGZyZlZVeDU1azR2?=
 =?utf-8?B?d3ExZzFaSzM3U01kMEVUeE1Tc0JWQ3VPVXZwWU1NMW54NVdXZDl6MFpxcW5t?=
 =?utf-8?B?SnJkb3AwUzJxVjNQZEhLZTcyeGt0NzdsQ2VRZkRwWEk1cFVXTDZKS1NSbXdv?=
 =?utf-8?B?Y3BFMmtOV0MwYjRhZkZGbWhIOVNTUnlodHdCU3poWmY2ODkxcDB0cDk1K3Iv?=
 =?utf-8?B?Wno0N2xGaXJocDg1bzFNL3c1clJKZTlSSzRyam13WE5JL3VxelVsQlFRVlhZ?=
 =?utf-8?B?Q01wT2szZW00cC9iZVhRUXpEYVptb0xMUGxQV0dtaVFTUmo3L0pid3BucDY2?=
 =?utf-8?B?ZHFCYkRyWStNVVNtM09PUXFUUkJXa09KOFRiTUc0NnBPaDVJc1J6NU5tVXFB?=
 =?utf-8?B?RUttUFhFc2hIVHBGYUlTd1g2d3c5d3NMSjdYRGVMdGpCT0NYeWs3Qyt2cDd6?=
 =?utf-8?B?WGpOaTZMTm5VbEE1MU1YckRlbWU3Y2NvNDJmaVhKRnNabnlmMmF2SW8yK2dQ?=
 =?utf-8?B?amQvOEhPMHpmYmNxMGd6T3RVTFBqQlRjaEhUemxvdmZnbTNzMzYwMWpOaXFm?=
 =?utf-8?B?anRnTXhmUWRCVTgrc0EzbS9WRVVqdTlzNnZKbnJWVnRzRTVTY3hwS1E4SlJa?=
 =?utf-8?B?MUF0K01DeWJjK3pZRVFmQURwbkkyYTlJRXR0NXY4YkV5TTVCbWFkb1Mvekx6?=
 =?utf-8?B?SitEOGIvNXM0L1BpZ0JSY2o3cEFReXFISmVxY3BJdjJWeVc4WEZqT2l5K3R1?=
 =?utf-8?B?UVgvRFZIays2dUN2RUNGQWhwSmVlL3BXeTd2cDZaaHZWbTdTNjdNb2oxUWZB?=
 =?utf-8?B?S3Qwa1VhZmM5U1pzdXpTNXQ1eE1VcnlEOWFxZW5wNktmd0NGbTRDVHovQWdn?=
 =?utf-8?B?UFBsMm04UmFKSWJwZzQzZDRxZ0pya0wrOEFPdjNVZVh4UklraGhRU0M3QWtX?=
 =?utf-8?B?Wko2SS9yTGM3SEdPYkhiR1B3eHBjaUw2TXlaeHcxcEswWWUxZ1BZckxDbmN6?=
 =?utf-8?B?ZW0xWUJ6UXppdDB5dm41cHZWUlQ5VmdWeENWb0N4OTU2QXdHL3gwRkpldVVo?=
 =?utf-8?B?SkFwNmYwUU80cE1hWkVoUFhJY2xML3pwNWRKNXA4YXg1L1dXdGdyWUVPa2F6?=
 =?utf-8?B?bUkzbVNmNXIvYVVyL3hjNUM2OWR4Rlo3ako3WUU1dkNGR0pFY2NOeXpWczBG?=
 =?utf-8?B?c0dOWmJrcWNTQVJnRlI0RmFiTTlJU2RUS1pIbEtiNVVoSU5NaUJnakcvWG9Y?=
 =?utf-8?B?VC95ck8ybFdLOXI3TzRzbkRHanVLYXFabEpsakRnRVhsKzhpUllFdTFTTno2?=
 =?utf-8?B?ZjNxZ3FGN042Q08zeWNGR2NNQkV1V2VRdDFUVjdHNzBYaTB6MHE3bEp3KzhB?=
 =?utf-8?B?ZFY4c2tTd01UOCtFeEtLR1A5RklOK2hvYWNzQ3lRRUNVY0xHUDZFcHlxamNW?=
 =?utf-8?B?blNENkFRMGQyeStPMHJPMFpjdWNBZWx6bjZoSzU0YnZrdUk0aFgwckRpRVcr?=
 =?utf-8?B?Zjd5a3V4OXBEQkFYYzVsNTJCdnRxK0sxbWxOZUhtQjdhMGlNU1NqcjE1bzNt?=
 =?utf-8?B?UXphVDU5ZlZ5N0xzTyswNTZJeVJqRmNTdlMzeVNsNExYNVNjdTFWYlZ0K0k4?=
 =?utf-8?B?WWVLWTk3YlJ2TkJsT2NmTFcwaWJ1NytjZ1ZDd0ZyTHEzeEl5M25UODRqMFBP?=
 =?utf-8?B?WWIwemd3QllhcWM0a1c2cVZHckdCVmJqaDRCbEVlNC9tNk9pbVBST0VqcHA1?=
 =?utf-8?B?bEhsQitTcXEwNGl5SmR0QjRQRFVMclNsZ2NrbHZBQmVRL2MxYVNzS0t3czlu?=
 =?utf-8?B?VGcwT0dJZkVWQzVDK29aY0hTWG9zUGxyZjNlcFZ0dGhocGNIMVlRaTZjMzli?=
 =?utf-8?B?K2hPRk5TTnNSS3ZwcnF3VHU2UWZuQUVzazZHYXdZUndZZVcvR1FyVmQvSkh3?=
 =?utf-8?B?MmlaREVwKzE1Q2lCYSs5NHp4MGYwU1Nna1liTVpqV3pMRXk4NjBORDllb1M3?=
 =?utf-8?B?RzUzeXZDaTdadXRIdk5kK3ljdVlPalZVcjFYVXVJVVZrM1VaY0hRT1dHOUVq?=
 =?utf-8?B?ZFpCdld4STF1WUlDYjk3R3pNbXppSUVDd21KU3E3TEVxK2QzajFJQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <983E36C74A67A4458325C330F563690B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c57071-fc34-4095-c6dc-08de7df79ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 16:19:20.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUxrXkmdl7Y33eJ5+QWbjDYkSXib4ab4SarZOB597coAFjofpaRk8MLxhO81uEKiit4tflkYv3mD+2KRwIQauQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
X-Rspamd-Queue-Id: 5E34F23CA8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:replyto,nvidia.com:mid,peer.sh:url];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAzLTA2IGF0IDExOjUzIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gRnJpLCA2IE1hciAyMDI2IDE3OjEwOjAxICswMjAwIENvc21pbiBSYXRpdSB3cm90ZToN
Cj4gPiBUaGlzIHNob3J0IHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIFZMQU5zIGluIG1hY3NlYyBk
ZXZpY2VzIHdoZW4NCj4gPiBvZmZsb2FkDQo+ID4gbW9kZSBpcyBlbmFibGVkLiBUaGlzIGFsbG93
cyBWTEFOIG5ldGRldnMgb24gdG9wIG9mIG1hY3NlYyBuZXRkZXZzDQo+ID4gdG8NCj4gPiBmdW5j
dGlvbiwgd2hpY2ggYWNjaWRlbnRhbGx5IHVzZWQgdG8gYmUgdGhlIGNhc2UgaW4gdGhlIHBhc3Qs
IGJ1dA0KPiA+IHdhcw0KPiA+IGJyb2tlbi4gVGhpcyBzZXJpZXMgYWRkcyBiYWNrIHByb3BlciBz
dXBwb3J0Lg0KPiA+IA0KPiA+IG5ldGRldnNpbSB3YXMgZXh0ZW5kZWQgdG8gc3VwcG9ydCBWTEFO
cyBhbmQgdGhlcmUncyBhbHNvIGEgc2VsZnRlc3QNCj4gPiBmb3INCj4gPiB0aGUgbmV3IGZ1bmN0
aW9uYWxpdHkuDQo+IA0KPiBJIHRoaW5rIGl0J3MgdHJpZ2dlcmluZyB0aGUgd2FybmluZyB5b3Ug
YWRkZWQsIGluIG1vc3Qgb2YgdGhlIHRlc3RzOg0KPiANCj4gW8KgwqAgMjAuOTczNzEwXVvCoCBU
MTk0XSBXQVJOSU5HOiBkcml2ZXJzL25ldC9uZXRkZXZzaW0vbmV0ZGV2LmM6MTIzNA0KPiBhdCBu
c2ltX2Rlc3Ryb3krMHgxMjgvMHg3YjAgW25ldGRldnNpbV0sIENQVSMwOiBwZWVyLnNoLzE5NA0K
DQpSaWdodCwgaXQgc2VlbXMgdGhlIGZ1enppbmcgdGVzdCBhZGRzIGEgYnVuY2ggb2YgVkxBTnMg
dGhlbiBkZXN0cm95cw0KdGhlIG5ldHNpbSBkZXZzLiBJdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8g
aGF2ZSB0aG9zZSB3YXJuaW5ncyBhbnl3YXksDQppdCdzIG9rIHRvIG5vdCBjbGVhbiB1cCB0aGUg
VkxBTiBmaWx0ZXJzIGZyb20gYSBkZXZpY2UgYmVmb3JlDQpkZXN0cm95aW5nIGl0LCB0aGV5J3Jl
IG5vdCBhIHJlc291cmNlLCB0aGV5J3JlIGEgc2V0dGluZy4gSSdsbCByZW1vdmUNCnRoZSB3YXJu
aW5ncyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpDb3NtaW4uDQo=

