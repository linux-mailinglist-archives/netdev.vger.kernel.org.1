Return-Path: <netdev+bounces-285312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIVlFpKH/GkaRAAAu9opvQ
	(envelope-from <netdev+bounces-285312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:37:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 572444E84B3
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A0A13008081
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A172D879E;
	Thu,  7 May 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MuJ06Y86"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722386DCE1
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157452; cv=fail; b=jW4PCvDUnBN/4twtsYjL/WdmWKOHqurrMZxM+ysTxkQB1tOhHgRFbWPNnEQwk5n6TzBjRYHS4djdvHtJfkujryoCBE0oaDg85k36gxIUVSLKWD9mhhSzbcpC3bfpeVWUDZHdltQwAHP2whsntDa/7n58riNeSgbTXZLRdPhZck8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157452; c=relaxed/simple;
	bh=ud6nFhkjXmz6xty6ti1XsaKMA32COGyv1L3mNQHmMxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDy8+JIR5zEJ+s311uNE7r4Evg7ER44+WRkXo9I8qx9L422UgdHMnZxdiNRUHLG22XRbrGlzrz7zHSlXrHIIqJnPH5Zjfd5c3l9/uzABI86YgrCZREw8FbfitKImgZRzqULPQiPRJ03A73w38NNi6ZESidVdHz1ERlQlePoEHx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MuJ06Y86; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzDb7So1x5VEvpBCUGT7dmvw2+uSp2saUEMydGkQrKC49PpkcJOXrFbDOFrjyCr0Ri9o6SKzh5i9fRo49juKZA5Imm+hLziVUPblWsk0bQSBW0qKHy+nt4WTry4/6tmXo/k2x3ylvDvL2EML1Ud+pdWaDBnBg8bXCe/LBPXWEuC2l8RlSDSIzTXb8mM2yEkMyHj6S5sYVFuNzBS+NgKMtbt5w0ZFnCTHiTA+aE4xA6aEd0H9l4uyGuICxI0JTXJTRdMjlJ6t6M0dM63b0Rv4/2zc1xk6KurNYvWx0bgcthQIAKZd4Kq4k2Sl07LgWBc03JvqIA31Omw0RhlXfykXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud6nFhkjXmz6xty6ti1XsaKMA32COGyv1L3mNQHmMxg=;
 b=bxAmzV1bq/YIA/HKwO+FAHf8K4VRL66LTYE5RKUO4IK+VsERC6UEcYtW+q4vJHpCMEZtiz0UQJOhU6/e4+snzD9z+8Cs3GnUB6NAScVHKZjXtC74vQ3fiYRcmOncUs5hAeCtx4Y20zMH63RzqMYj4C0A5IfAdYWcWupLusmSUs+uWlka/yoo9THcOTH2q9ooTFULVQnF489HQl6wBVDns4ArPmVTg6S47S9EXPQ9ooUliLPldHM10MJCwjL3/Arun7nzq+oXbz8qOUvJysavu9L+r3CTUtiKixhqS9qDraqqLT+RBaZWEJRcqbFVhD8l7sr84Wv7GLfi/+b7ry5CAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud6nFhkjXmz6xty6ti1XsaKMA32COGyv1L3mNQHmMxg=;
 b=MuJ06Y86O9K1dbIncDBJ3OqyMcvrCmzVxpgaQ1SL5b4lCYBLj7m1iLblHWScmugoWtCHDbz3rfMsvF2CwJegBzrQ2bE1hvooUQqAFhjxv66M0leGePY2tPi5552K1N/NGj0qCM1pf6Q1lRolZNdkCQLEgU3I2levgQk8SCk79LmMaRY8vpTgcMo8gJifECNQPB/sCDeSyB3DAuBZ+H/nen8H3EibptAEEF8WC5cjemgv/Vn904A4H2WfrnzXOxrG+wf5tU0qKgEHhcqcrzYcZlfbC5fXLQ8n/n5ovSy7rO7iV/Jm1ES3HbiH60hpgSkFydc0I4xO1vrN+uZNmwMg+g==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 12:37:25 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 12:37:25 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: RE: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for
 module EEROM hex dump
Thread-Topic: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for
 module EEROM hex dump
Thread-Index: AQHc3hdcxkfOfhDidEaoBf2siAMPrrYCeAAAgAAGq9A=
Date: Thu, 7 May 2026 12:37:25 +0000
Message-ID:
 <DM6PR12MB4516FAE7C203C652E10BE801D83C2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260507114721.3409128-1-danieller@nvidia.com>
 <4chkrvenxrbc2tylrbob6vdo3uyjzbwbhbup25yvnohrccvotv@fd7rqasq4btv>
In-Reply-To: <4chkrvenxrbc2tylrbob6vdo3uyjzbwbhbup25yvnohrccvotv@fd7rqasq4btv>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA1PR12MB8310:EE_
x-ms-office365-filtering-correlation-id: f0441cf2-8750-482b-b8a9-08deac35648d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021|3023799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Hi/cQSXdK8Boyu/cgUMz4XH1c8lNAisjBTu55JFhR6D5aVInjGPt/72w37EXdmR7t/1lgl1mqZl8jUmMp/MgXhf3gunC/S2rhxymT9SZIlDUtkU9r/c8z3Dh31vVOUr+blHDOeGztEqISL1EfPXYK73Bpgqpgjd1LlxmC7tc3KjMtXv1/4hRMGy2kveYlLnEwMT82byjoq+3oqRfxx6FE/qfGGrEy5Lp5/tnm9etx4Fs3b2SS7LhuVllyXU7eun1inLV+tm8MB2inbXa9fP44LSzFMSE8bZAA20snmmPbn+ZSNRp47WGXNrtllW9ylAV2FoG+UIw31vHF/H72THJiMLhj3No8ccuvWuUeAo1KDawsmWYLv20X9o9NYUpRnD0iwtmQC2X/Hsi5irNtP8zFv1iM+KILH5/HQhHEf4JHw9faMEVc4mcS5jsrV/1tQMoAZoRVbkFu2lWYkzTyuHGybVm0Oa8GjmGzfX2kT/64mEerUHnojhjOGE4IWT5O6hJqN8TZGhFIf9Dj+m+1YSvi2YQrHM4W+sCbSMywcwk8EDqZaltqDwYW30mfgHkvS3SPKPRXZDozoN5Z9MXfjVn2uMG2xxbYQ6/PGimwR6FDlEvWbIEQaLuHFE9+d7QM2G5IBfMTYNvp51QjctX7N/lCCnZGgTx7cCrSVmZfek8DdJBNafbmoVGsQlY6TGUZKcNQJY7ZLV0Hn2LdK+E8uA+4f7z12iIjIEMmxWtsJJwq/OZCLK0De+qfTtgmKui7Pw9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWFuMHpZWkQvUUFsSVU1U21JbE1OYnBnSUxDUmlWMEJRR0JaSS9VVDJjY0RF?=
 =?utf-8?B?dzl2RzVPakFqSzZrOTltUDZKMmRoM2pjbnR0aFFCazg2YjZybEs0SGtFelVF?=
 =?utf-8?B?MVR1SzhVQlhMT09la2VrYTdScUYvZnM3cFRESTZwcGFLUGdDMjZIdVBWRk1V?=
 =?utf-8?B?a3lpcmtvRHA0dUpqa2JSZWtSdi9MQnROSWRoMGh4NWlMVFR2cnREOUpldFBq?=
 =?utf-8?B?cXhvNzBBa2NKY3dWdFJXL2pnNHdjcUN4L0MxKzJCYlpkUzNENGtBYlZVU0t2?=
 =?utf-8?B?VGdHTnIyTmpNaHBWZTJaL0dKTVNBQzQ5Nk82ZWlBdVNjLzNJKzFlYlFId1U0?=
 =?utf-8?B?bllVVitBbHRadmlpdkJBL3VmSnNYNjBBODF1QkFVcUxXemZUNUdOSDJNZEYx?=
 =?utf-8?B?VXFqa1dXblN3cWxZTWMrM0ViVmZlSXdESU9jUmdkNXNUMXNXQnFXWDBKdldI?=
 =?utf-8?B?MStId1h6eTRycHBvWnNVS2xQeUp4a2NvYndFbGNGa0loSVRWbHp5cG5WZ3Fu?=
 =?utf-8?B?aFh0YlFVaGc0WEJMd09oU0hQaFlYME9oSmJHM1RGaFprVS83alFpUDl4a2c0?=
 =?utf-8?B?VGp4SVQ3YmdBVm9teGFxQ1ladDZOeitSVjdRM29Ic3N6aTkrT2VHWHpUWFhu?=
 =?utf-8?B?eDdYbGpTTC83K3dWNitBTTJwdVFFeUlIVVk4ZlFPSUNPUk1ldFgzdVM3MGhM?=
 =?utf-8?B?MzhJSytNS3hKcktMN2VMMkZuOFg5b3l4R2MrS3RIcGRXdWRFUjlYNjB3MFNZ?=
 =?utf-8?B?SVN6bE1mdXMwNnB0bUVNNGNmVjV0N3BKSFF3eG1KbkdYQ3BVdkhOOHdUdzl0?=
 =?utf-8?B?NGpGd2hZb1kzVDIrcW1PaGQ3aXlJaU1TeVpLZFZ1eVdTNHFIa2JCdlNZdUxu?=
 =?utf-8?B?S29IWmNhcnNLTmk1VnRwcEJ6Tk42aDdvblJkdnJ3ZmFjQUFpSHlYeks3aTJn?=
 =?utf-8?B?MTdNOTA4V0ZsdGZyZEVRWE01eFZLS1BmZy95aGJySzdRcDlnVENsSVhHRklz?=
 =?utf-8?B?SEpEekpqYTFuTmp0VThaSnVVS1FvQVNLZGNUTW1lRW5ZN3lpL2wzZndVS1VS?=
 =?utf-8?B?NmQzWkNMQTl4NGN0eGhJNzRENlZOMytISjZMNjBoaFNDM2hJbC82bzhVTXF1?=
 =?utf-8?B?ZjhzNDZHYUQ1R3RSOTdaaTVhNyt5alFlT1cxb3Z0VUdQbWhaS1dRQWNZQ2gx?=
 =?utf-8?B?VVErdnlDeDZNaWM1WU03Q2ZZMzRNSEY3OVQ0MWNOK3FXWUV6QUpqYmpHSFZu?=
 =?utf-8?B?U2pMUm5QUUFpWll4M2hKcFppWEQ4WG5tM0ZWQ2VrREdBdWM1ZFQrMFRrSzcv?=
 =?utf-8?B?ZCsrSWxiYWZCQjdqYjFQanFvblh2a0FHbFRMOVNPSWJUSXY3VTBzc0IzQ1FI?=
 =?utf-8?B?OTZxR2I0b1V1ZkU5aDhmQTRsMGNRZFBGZkhWYjZTSDYvazZjRkhnam1ERTc2?=
 =?utf-8?B?TlV6NEdCSWl2Q2lKMjNEVkl2bzlOOU8vSEtPWEZLellQekErRnhOYnJmTk9j?=
 =?utf-8?B?bEw2bDhEZERqM0hFVkN4UlNoeU5JTEpZYU41UnFTbGxpZEZKR1JWNFpxRnpt?=
 =?utf-8?B?WWxCS2xpTVROYlhoT1ZQZ2dXemdYak95Tkk5Q0srVDltTi8wUm9PZW5IekdM?=
 =?utf-8?B?OXo0c29BSTFaSERBclVIVGdvV2JFalJCVG9iVU1iZTkxYUFQNk9FTVBReDNI?=
 =?utf-8?B?WUZrc1FCZk90OGdqTk55VHBNdWZrMFhYTFp3TE9EbWtrNXBJdUMzOXAxTldn?=
 =?utf-8?B?MEZPTzlFMWtWRHZUS09HakpKZzhGSkpzTmNYaVJZalVtbmpoTUMvYTRHcGFB?=
 =?utf-8?B?aHlMUlBEVDh0cnJGSkc5Tm0xY0ZqdXdkV2ErelJFckJERFljK0pYR05NU2xl?=
 =?utf-8?B?YjRZa2JrdlZUaEtMbUZuWGRLUGdQZkVRdW9Pd3pnYkRZV0ZxZ0wyVE9XSDhU?=
 =?utf-8?B?M1FUcmpsT3dzWFpNbE5KOCt4Nk0xcy9ycGRQZW5KWlFacTdiS3psOFVjS1I1?=
 =?utf-8?B?Y09ycFFOTitPMGgvTnB0ZkNhb29ibWxIRzI5bnlMZXRkRFNSS29qNmZJbm1Y?=
 =?utf-8?B?VVRwT3lKcCtqQVRrVVRqcUxDR0hXUmtaSjdzWndJSmhUNElIeHdzT09qL0tZ?=
 =?utf-8?B?M3ZMNXFYbThyckFqWGJab05GeCswaC96OSt0bUQrK2Vkc3NEVG41YWQ1N1R2?=
 =?utf-8?B?NmFJYmpWd1cwVTZDeXNJZ1RCbHVJaDNlUlg3SWJ4QU9qUjd0enpPVFJXTHcv?=
 =?utf-8?B?cHVWUUg0VlhjTkRiWVc3T29qWkdlVFNObkcrQXI2RlFBVXVLTnJNOTBqU3F0?=
 =?utf-8?B?UEdsVWRZbmd4Sjd6dnJnbGtYYU5GTENBMXd1WVcxNVlsRTBPL3gzWjQ3NmJp?=
 =?utf-8?Q?U0WV3Q/TluVyE1cDTMIZlq41wetkHxFfMqvdhC5yoYlEk?=
x-ms-exchange-antispam-messagedata-1: FOGCY/lA6qxdzg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0441cf2-8750-482b-b8a9-08deac35648d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 12:37:25.3090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJnRe9eFlDuS4EvsciQOAOjxZbDyogqyp0C2lYI8rXrWICex/Ik7gFeonn26IHS1Xvhj37sNUWBSuSOZD/HprA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
X-Rspamd-Queue-Id: 572444E84B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWwgS3ViZWNlayA8bWt1
YmVjZWtAc3VzZS5jej4NCj4gU2VudDogVGh1cnNkYXksIDcgTWF5IDIwMjYgMTU6MDgNCj4gVG86
IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29tPjsgUGV0cg0KPiBN
YWNoYXRhIDxwZXRybUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGV0aHRvb2wt
bmV4dCAwLzVdIGV0aHRvb2w6IEFkZCAncGFnZXMgb258b2ZmJyBvcHRpb24gZm9yDQo+IG1vZHVs
ZSBFRVJPTSBoZXggZHVtcA0KPiANCj4gT24gVGh1LCBNYXkgMDcsIDIwMjYgYXQgMDI6NDc6MTZQ
TSBHTVQsIERhbmllbGxlIFJhdHNvbiB3cm90ZToNCj4gPiBUaGUgZXhpc3RpbmcgJ2V0aHRvb2wg
LW0nIGNvbW1hbmQgY2FuIGR1bXAgbW9kdWxlIEVFUFJPTSBkYXRhIGVpdGhlcg0KPiA+IGFzIGEg
cGFyc2VkIHByZXR0eS1wcmludCBvciBhcyBhIHJhdy9oZXggZHVtcC4gVGhlIHByZXR0eS1wcmlu
dGVyDQo+ID4gcmVhZHMgbXVsdGlwbGUgcGFnZXMgcGVyIG1vZHVsZSB0eXBlLCBidXQgZGVjb2Rl
cyBvbmx5IHNwZWNpZmljIGZpZWxkcyBmcm9tDQo+IHRoZW0uDQo+ID4NCj4gPiBJbiBwcmFjdGlj
ZSwgYm90aCBvdXRwdXRzIGFyZSBvZnRlbiBuZWVkZWQgdG9nZXRoZXIgZm9yIG9mZmxpbmUgZGVi
dWdnaW5nOg0KPiA+IHRoZSBwcmV0dHktcHJpbnQgdG8gaWRlbnRpZnkgdGhlIG1vZHVsZSB0eXBl
IGFuZCBkZWNvZGVkIGZpZWxkcywgYW5kDQo+ID4gdGhlIGhleCBkdW1wIGZvciBmaWVsZHMgdGhl
IHByZXR0eS1wcmludGVyIGRvZXMgbm90IGRlY29kZS4gSG93ZXZlciwNCj4gPiB0aGVyZSBpcyBu
byBzaW5nbGUgY29tbWFuZCB0aGF0IHByb3ZpZGVzIHRoZSByYXcgaGV4IGR1bXAgb2YgYWxsDQo+
ID4gcmVsZXZhbnQgcGFnZXMsIG9yZ2FuaXplZCBieSBwYWdlIGJvdW5kYXJ5LiBUaGlzIGlzIGVz
cGVjaWFsbHkNCj4gPiBwcm9ibGVtYXRpYyBmb3IgQ01JUyB0cmFuc2NlaXZlcnMgd2hlcmUgdGhl
IGV4aXN0aW5nIGhleCBkdW1wIGRvZXMgbm90DQo+ID4gcHJvdmlkZSBVcHBlciBQYWdlcyBiZXlv
bmQgUGFnZSAwMmgsIGxldCBhbG9uZSBiYW5rZWQgcGFnZXMuDQo+ID4NCj4gPiBUaGlzIHNlcmll
cyBhZGRzICdwYWdlcyBvbnxvZmYnIHN1Yi1vcHRpb24gdG8gJ2hleCBvbnxvZmYnIGZvcg0KPiA+
ICdldGh0b29sIC1tJzoNCj4gPiAkIGV0aHRvb2wgLW0gaGV4IG9uIHBhZ2VzIG9uDQo+ID4NCj4g
PiBUaGF0IHByb2R1Y2VzIGEgaGV4IGR1bXAgb3JnYW5pemVkIGJ5IHBhZ2UsIG1hdGNoaW5nIGV4
YWN0bHkgdGhlIHBhZ2VzDQo+ID4gcmVhZCBieSB0aGUgcHJldHR5LXByaW50ZXIgZm9yIGVhY2gg
bW9kdWxlIHR5cGUuDQo+IA0KPiBEbyB3ZSBuZWVkIHRoZSAicGFnZXMgb258b2ZmIiBzd2l0Y2g/
IElzIHRoZXJlIGEgcmVhc29uIG5vdCB0byBzaG93IHRoZSBmdWxsDQo+IGR1bXAgYWx3YXlzICh3
aGVuZXZlciBwb3NzaWJsZSkgYnV0IG9ubHkgd2hlbiByZXF1ZXN0ZWQgZXhwbGljaXRseT8NCj4g
DQo+IE1pY2hhbA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4gDQpUaGUgcmVhc29uIGZvciBr
ZWVwaW5nIHRoZSBzd2l0Y2ggaXMgYmFja3dhcmQgY29tcGF0aWJpbGl0eTogdG9kYXkncyBldGh0
b29sIC1tIGhleCBvbiBwcm9kdWNlcyBhIHNpbmdsZSBmbGF0IGhleCBkdW1wLCB3aGlsZSB0aGUg
cGFnZS1vcmdhbml6ZWQgb3V0cHV0IGhhcyBhIGRpZmZlcmVudCBzaGFwZSAtIHBlci1wYWdlIGhl
YWRlcnMsIGJsYW5rIGxpbmVzIGFuZCByZXBlYXRlZCBjb2x1bW4gaGVhZGVycyBpbnRlcmxlYXZl
ZCBiZXR3ZWVuIGhleCByb3dzLiBTY3JpcHRzIHRoYXQgcGFyc2UgdG9kYXkncyBvdXRwdXQgY291
bGQgYnJlYWsuDQoNCkZvciBjb21wYXJpc29uLCB0b2RheSdzIGhleCBvbiBsb29rcyBsaWtlICh2
YWx1ZXMgemVyb2VkKToNCg0KJCBldGh0b29sIC1tIHN3cDYxIGhleCBvbg0KICBPZmZzZXQgICAg
ICAgICAgVmFsdWVzDQogIC0tLS0tLSAgICAgICAgICAtLS0tLS0NCiAgMHgwMDAwOiAgICAgICAg
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQogIDB4MDAx
MDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MA0KICAweDAwMjA6ICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDANCiAgMHgwMDMwOiAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwDQogIDB4MDA0MDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KICAweDAwNTA6ICAgICAgICAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCiAgMHgwMDYwOiAgICAg
ICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQogIDB4
MDA3MDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMA0KICAweDAwODA6ICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDANCiAgMHgwMDkwOiAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQogIDB4MDBhMDogICAgICAgICAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KICAweDAwYjA6ICAgICAgICAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCiAgMHgwMGMwOiAg
ICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQog
IDB4MDBkMDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMA0KICAweDAwZTA6ICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDANCiAgMHgwMGYwOiAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQoNCiAgdnMuIHRoZSBwYWdlLW9yZ2FuaXplZCBv
dXRwdXQgaW4gdGhlIGNvdmVyIGxldHRlciwgd2hlcmUgZWFjaCBwYWdlIGlzIHByZWNlZGVkIGJ5
IGEgUGFnZTogaGVhZGVyIGFuZCBhIGZyZXNoIE9mZnNldC8tLS0tLS0gYmxvY2suDQoNClNpbmNl
IHRoZSBmb3JtYXQgY2hhbmdlcyBzaGFwZSBhbmQgbm90IGp1c3Qgc2l6ZSwgd2Uga2VwdCBpdCBv
cHQtaW4gdmlhIHBhZ2VzIG9uIHNvIGV4aXN0aW5nIGNvbnN1bWVycyBhcmUgdW5hZmZlY3RlZC4N
CkFyZSB5b3UgT0sgd2l0aCB0aGlzIGV2ZW4gc28gaXQgbWlnaHQgYnJlYWsgc29tZSBleGlzdGlu
ZyB1c2FnZT8NCg0KVGhhbmtzLA0KRGFuaWVsbGUNCg0KPiANCj4gPiBFYWNoIHBhZ2UgaXMgcHJl
Y2VkZWQgYnkgYSBoZWFkZXIgaWRlbnRpZnlpbmcgdGhlIHBhZ2UgbnVtYmVyIGFuZCwgZm9yDQo+
ID4gYmFua2VkIG1vZHVsZXMsIHRoZSBiYW5rIG51bWJlci4gRm9yIFNGUCwgd2hlcmUgdGhlIHR3
byBtZW1vcnkgcmVnaW9ucw0KPiA+IGFyZSBzZXBhcmF0ZSBJMkMgYWRkcmVzc2VzIHJhdGhlciB0
aGFuIHBhZ2VzLCB0aGUgaGVhZGVyIHNob3dzIHRoZSBJMkMNCj4gPiBhZGRyZXNzIGluc3RlYWQu
DQo+ID4NCj4gPiBPdXRwdXQgZXhhbXBsZSAodmFsdWVzIHplcm9lZCB0byBvbWl0IHZlbmRvci1z
cGVjaWZpYyBpZGVudGlmaWVycyk6DQo+ID4NCj4gPiAkIGV0aHRvb2wgLW0gc3dwNjEgaGV4IG9u
IHBhZ2VzIG9uDQo+ID4gUGFnZTogMHgwDQo+ID4NCj4gPiBPZmZzZXQgICAgICAgICAgVmFsdWVz
DQo+ID4gLS0tLS0tICAgICAgICAgIC0tLS0tLQ0KPiA+IDB4MDAwMDogICAgICAgICAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+IDB4MDAxMDogICAg
ICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+
IDB4MDAyMDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMA0KPiA+IDB4MDAzMDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+IDB4MDA0MDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+IDB4MDA1MDogICAgICAgICAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+IDB4MDA2MDog
ICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0K
PiA+IDB4MDA3MDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMA0KPiA+DQo+ID4gUGFnZTogMHgwDQo+ID4NCj4gPiBPZmZzZXQgICAgICAgICAg
VmFsdWVzDQo+ID4gLS0tLS0tICAgICAgICAgIC0tLS0tLQ0KPiA+IDB4MDA4MDogICAgICAgICAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+IDB4MDA5
MDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MA0KPiA+IDB4MDBhMDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMA0KPiA+IDB4MDBiMDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+IDB4MDBjMDogICAgICAgICAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+IDB4MDBkMDogICAgICAg
ICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+IDB4
MDBlMDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMA0KPiA+IDB4MDBmMDogICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMA0K

