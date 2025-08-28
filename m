Return-Path: <netdev+bounces-217594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE3BB39238
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 05:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF850462D8C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A5129A78;
	Thu, 28 Aug 2025 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="TDIXW2Vt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2D2557A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351890; cv=fail; b=FqDu0pNHFhEwIFzdcesJ2URo6zMCPKYomZ+6BDGpE6IQHSLDxn3KrwP1kGcT1lVJ0GEs3pMx1ZK88lxkVrD6aklrO4HXNp7BgL33XV2hgg9YGMbcFu2nKluSOndgjhNSCjZBTAfL6DoVjtGkmpoIsJj1QGFZJ5j/JbTxiZuF25I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351890; c=relaxed/simple;
	bh=cnu1yLUFfCvKVq7WhBawwcd9/byKHpRCb7xxbvExwu0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HaK+62TFbZ4QRf32O5sJiIbRSCWE951mJ5H9S9KnWaWf7mZuumjhDJ3tWSc+OdCs6roT2eFHya3/6K6zeHZeMeiTRX26O4qC7BnUuVj2YClAa8bN3cQnmdok1H02GwwQltj5JQO7yBwImFKOygkkfaz4+MHF4RygYLV822mS+QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=TDIXW2Vt; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166257.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RNdsC9023576;
	Thu, 28 Aug 2025 01:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=campusrelays; bh=cnu1yLUFfCvKVq7WhBa
	wwcd9/byKHpRCb7xxbvExwu0=; b=TDIXW2VtgqqUH7qg+XcXyrTbK5rf5gB1H97
	K7BgjIQLaka0jUV1fx752WakyndlJMVPgEljhW67irk03b4Sv0u2XrvtwKc94yMd
	qsWNCdHSBYBK9e56CGnJKxxFBqaOoSgrybfnhD7bi2lxj/9tpsUuHq673VMd3s0a
	8RWpDUUQH59rH43KRyh4ztne2lrvAEUp+yecms280lZef16hGyaGssIzS21a+MVy
	jwuCGCMnr3G33IzlS5ZsuIiLERyPeXA7ELI7orkMRTOrfz8YEl4xW+W8NRUMSUhz
	Og/HjrXh9HbK/FiiYmrMQBVDsFhn2P6xysElH7rxoqXGdwJAa+w==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2098.outbound.protection.outlook.com [40.107.100.98])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 48sckqg3qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 01:12:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3+JXoRkx7cOeX3oszVBfRUzZK4NBnVAxHmrA/0M1aMxIPLehIjcPH+8HhzaVab/xxiMNc+wJpsWbVMiyVkYBXc/o196I0S3DGuSn6UXfxmtuf6UnI6JVLRg70qE0nmgFiGjc5DhM+yh/SbXjV2ZmgtTamUX6U5DnwxS+eedPjZuToNvGPhUN8HaOYNJh1cGSE++7YqCDZ0HMrnPGXWiO5bwGfZvd3RZ/6gxNrJsLFq126nQTBE+aC3edNSUaYgXwv/YGuP9Kx79HKDfnqP4ykKOLa8BeuGhRJHMaa9CF1BURhdzjHcsFUrbqxujOdEMnhDPVWcOcwZ2DnTpzIPL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnu1yLUFfCvKVq7WhBawwcd9/byKHpRCb7xxbvExwu0=;
 b=M98+QmKR0ggXHgMdctxrW5Uzm1NsG5WWiyIYRp/7zrtfuTsJfJ9/s6nDqjj1kzl1lkyTMMNOPd2PJuGvXiR6oKEFpkUCCdnqqvtKVnjOWpO9joA4wsVqUyV5qciC8k9j3V0Fjqh/3BIQZuLU9xSg8vghi9DY+bW7uJ78gSZ9AufiUaA3Oa0hEx8CpT3xNQKbyyl2eQr1fQwkwEpSY2v8fYdGgpND2SjC4IIM1zJuRtvgV19pfCpkNeCOFAqaHCNyP9Nl229QFwZqU4D7p1lq1xcc/3ByzqIOwcSX6tG/Djw6w2b8gz/p76ZycBamLIWOr5CyNFLg4yTRGuL9+kkhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17)
 by DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 01:12:44 +0000
Received: from DS0PR11MB7768.namprd11.prod.outlook.com
 ([fe80::3232:c728:db3c:3211]) by DS0PR11MB7768.namprd11.prod.outlook.com
 ([fe80::3232:c728:db3c:3211%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 01:12:43 +0000
From: "Ahmed, Shehab Sarar" <shehaba2@illinois.edu>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>,
        "ncardwell@google.com"
	<ncardwell@google.com>,
        "kuniyu@google.com" <kuniyu@google.com>
Subject: [BUG] TCP: Duplicate ACK storm after reordering with delayed packet
 (BBR RTO triggered)
Thread-Topic: [BUG] TCP: Duplicate ACK storm after reordering with delayed
 packet (BBR RTO triggered)
Thread-Index: AQHcF7jMeEHO9sCN3UOj7LIWAJRiDw==
Date: Thu, 28 Aug 2025 01:12:43 +0000
Message-ID:
 <DS0PR11MB77685D8DB5CEACC52391D4E6FD3BA@DS0PR11MB7768.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7768:EE_|DM4PR11MB6407:EE_
x-ms-office365-filtering-correlation-id: 5e535374-e132-407b-8d57-08dde5cffdd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ohKb/D5coE1oGyTeMBia8cJQydsIEzk5xkSreLr3gKRZyskQsla3GZ6PKK?=
 =?iso-8859-1?Q?OR4kv7nDsvJXx81HMsoqmjjzS8n/tpgAd6Nw/s5Hg+UB93Fkj0Hvv32za8?=
 =?iso-8859-1?Q?zXP17REw8Fb4cQNPXXE9LK+InkNyfmLbdvJ3n9hXAqPE/0RecEXa7mxwVY?=
 =?iso-8859-1?Q?xdKRAzI19LjAds7rZnNiIZUOQHW48OTmOwemYgvpXEjyqhjh/qy3c+/rT4?=
 =?iso-8859-1?Q?C+wJSRnpuDBOwk0Q+ZawK3Zpto/BT+mfUH5Q+1lAsaMISEIDjXo2Rqz1ex?=
 =?iso-8859-1?Q?ggflDP6NqWKwkrVAMnpmwGIXN5QZI46Ctd6MI99YwUh5b96i8F5OXWFbKR?=
 =?iso-8859-1?Q?urGVC3YnQcJeS9ltQF1mi6m5alc9/lik2LAUA6Kd6yD86+Aid+Ux13pkf/?=
 =?iso-8859-1?Q?QOo2dT6bJPJB6470hVKpVwE39dQ0Yd1ZMPvP9ZCUd9YQk5LaHG5PKBd/gW?=
 =?iso-8859-1?Q?4B+FnUSGDBTwATO9uUlvke1tKDSFOAMpbj0DPQy+fuxhAWxk0eM26FcV57?=
 =?iso-8859-1?Q?PV0xXX/QTrHbHgPV0GZq0hXWgDVj4SjqTP+kodqEZER0AnYvFPw5wQBzHZ?=
 =?iso-8859-1?Q?cim8gSvliXoj24t5j4+DWwQ+AOyW43ocTarU7B3zBOZJa+gQvzEMVO89s1?=
 =?iso-8859-1?Q?9Epf6ACeMpYlpbTCdlMl+8K+Vtvo1SoEM62e/uIZvK3/EARMbF4lf5Ddyd?=
 =?iso-8859-1?Q?6rcliDQfSDgsGVPxQ7GPRYGif+ztfPgCg7zkLZDyBH4u6oZhiJ699ULoIM?=
 =?iso-8859-1?Q?s7I9cPECu3NklBprV2CQujAF7kFgW8vOiYCgEsSsOXttSSQBUPOinrCwHl?=
 =?iso-8859-1?Q?HBq9Kg7DlIoCtB4BPitkrAZB7KPxuRc6fp6DZJq4gtNzAPb5pWBaA18med?=
 =?iso-8859-1?Q?yIuwEKurPVTj4gkf8ohTYbAE+UGwizGbQmKDjZtQSUMGZ4okV3G+cF7an1?=
 =?iso-8859-1?Q?ULJTPv5Z9PMjcPY6fWG0TeYwe07TqzCSGj3o1auBLjqyBLsC9ueXaw6f6M?=
 =?iso-8859-1?Q?KfRcnr4QRQ2wbTQj/+VU9r0d1YQjGw9uu9jZsDpP94JP+SZAHtyc+k6H+H?=
 =?iso-8859-1?Q?oRUmwBYKHBf9gp39xp30o4cCecBbUZPO1X6x+VEdwx+lFIGET+CzxlYQ+8?=
 =?iso-8859-1?Q?2/Q6OFnSA2SC4wpx4K9xeV5+zmkVwR5L5DEyyj4v9fWySaXj4mG2JgO1ZD?=
 =?iso-8859-1?Q?TARGlO/cdLzRzhfqbgsoRr1JQH2eJ5FU8L8XfGtboj5J93g5kEMAP9jl61?=
 =?iso-8859-1?Q?wnrTUqWudA/Hg29+AKJZcl6g7aBoXpagpQs4Q0d1lcOrF7bkMBSFOP8m5u?=
 =?iso-8859-1?Q?Ok5uMzir4Kejwa0fCQH4IDvc+2hX6gT6PTnmqa2fEIkDDlP8GJQUPpHOw4?=
 =?iso-8859-1?Q?VfYFD/sHnohtvJpLlovc4J/3SHnb0uDYalIY3iLpDfXGr4aFNcVuuYnxGO?=
 =?iso-8859-1?Q?byTbMQwcU/h3aEDLHavUXzMWHodR2YJtU0l31vUa3WRezs64xloMhaYs8l?=
 =?iso-8859-1?Q?I14V0MG6g5B3Ia3ngRVPLAHaXQFfomizXb/AVwAMU19g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TqjmLR2QfaoJ5uiVUbNt+UxzZbMxYRdVPjEAZhQSyZ8VwYVJOUq7guoCX5?=
 =?iso-8859-1?Q?+baSzYo12hk4tIgPKffmXO4YKsRROGgv/eKslF1ztszLx/mFZFHk5Z+XZg?=
 =?iso-8859-1?Q?vsHbIFpwqfcf5uTm3wYugjbqX+g99iVmXd09qH12q5oWbVI7UlJAFhDAQp?=
 =?iso-8859-1?Q?9YaGagB51JszNjbRKEBipT/5ltPMXUMJJS5BJVg833MkvvfznsKdIIFx/J?=
 =?iso-8859-1?Q?LSMd2jphRe7TCbJKKRET8XPy0z6yS501/OVyyiyRo1TfJb0tVGYJdPlidP?=
 =?iso-8859-1?Q?rvtqel+Cu5XVzIHu154/4twMCmAZMJsPmbKO00Yo9MSAs/SaudyF/Jb/Bl?=
 =?iso-8859-1?Q?CooBnpubzR+XhL3ARczWsnPs+3crm7v6pdGlTvlD4rZDl0YJf8E1Jlcbyb?=
 =?iso-8859-1?Q?AXG0OOUxRvBpKQlOQnwxiMFcvyXb2bdSItlYBRai4H3xgvwRVsuxjGIIP/?=
 =?iso-8859-1?Q?pw9ciKJ5zuedX/iDfJkqyqW9DgZ9mLhdVY6jJUHNxBd8yrBKCgiVas+1fd?=
 =?iso-8859-1?Q?uvSUtheYE2pnh6vr21cbYbcjWePrU1CJbJtMmkDgMT5D0+9ZTSHYSVCyF+?=
 =?iso-8859-1?Q?LRsgGnVzQZ/G23XZqLBDp0d8+Q2ZCG08S0NcTBBry/+Nt94XdcKa2kJxht?=
 =?iso-8859-1?Q?Gx/nFWLiNeLufJ1OqnALPDk+e3yMZkC0s9umpMpTxYFIFSxD/XZIqBKAgD?=
 =?iso-8859-1?Q?iyhg47hiWcspwyDvAzW13NoOz+WZfh1PQuYsQF0zjjNdAII3cz9L8lUZUF?=
 =?iso-8859-1?Q?2e+s2/slKde3KfaNzptMD6riyE2Z2DrxmZ+1pI3llmlRm2pwZd4gLs+E1m?=
 =?iso-8859-1?Q?5XpJZKgy8p2lvq3rsc1j8y/+KBSk5jL5UVeF5NkjKabLSEAIscpdl5/jiw?=
 =?iso-8859-1?Q?zzKnnsqXmOjDCW/VCB3x/JM+OxIwcRv+RJHE+GJOuqgeS+KQI+xyZkGrzC?=
 =?iso-8859-1?Q?2QDiEaoXiktSPUP3bCa+m+zX3u21O0OoVdJXHGrylqB6j6bRnU18nFLOST?=
 =?iso-8859-1?Q?b+ZaRJYet+M6ZD/MAbwQffWm03zrEii1AyCmHhLhE3hSr0pmSI5gU4uWuf?=
 =?iso-8859-1?Q?224zus9qMRjZq/VWU5weYimYjG6hnalIdnSMmCzbeIQX9qdpo9zpmGLmAg?=
 =?iso-8859-1?Q?+3jLKBGD+tomvVKSGCdHPDeEpq7niZXWfzp2ZkDZdwwdWAYxA3OET/lV7U?=
 =?iso-8859-1?Q?jrvaHJznht9Vw+nvbAp2RnsQO5ITc5BnJMnij5O2QPE2us+nWrCaOlYoHF?=
 =?iso-8859-1?Q?MY107NhbTOVRQifMexZxqXglVor8Pc5AHWQFBNia64vgxwnaLishOolfKc?=
 =?iso-8859-1?Q?1/rPyQf0owEaK96VM658hZtoyjRRepXo1W1UGzMqTJWnRCXRTkxgOhB8Ff?=
 =?iso-8859-1?Q?ymkElVeB0r9sOyDfwUjMe6M2iQkflm5nmQ3/2sHzW4R5fZ6kpKOGyvjVJV?=
 =?iso-8859-1?Q?zXZVtRjjIUQcx5Uc+c5A/66dgGaVMbp7q3zJh9Ku5qJPAcH4BP6iMxNGRd?=
 =?iso-8859-1?Q?Ua5tZl2orXGObw1ukSwLg+wUVahrKsdVB15eooRSekzpc6z8PyFVLONX3f?=
 =?iso-8859-1?Q?Qi8ehfn49MBGvCjjdwhb86NnQxYvesufu2HtqHbopj+QSOaS7mV/TyhDOz?=
 =?iso-8859-1?Q?xwmcsXd/N48xX5okgTsSIQVRdIqdV0uoEY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e535374-e132-407b-8d57-08dde5cffdd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 01:12:43.5597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKDG0YlHf3ctwm/ukOmMjf+9DLCMikzbhcWRUh3/rf/ZXqBNmkelZnya8nt1VdAOHrGhBXiLvO0HfkrV5ATe/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6407
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEwNSBTYWx0ZWRfX7L+k6G7ed3Sq
 r6mW/T3rGnIomPoYEJDuLbMFD3fO2Fe4b9W+tnTb/k8Q/ouHHjhrixqu3rliY6bKZT7Td+4w0QO
 ifDiDhhIcWqS75g4lBloJ3ivIFSqR1e4diyzCHipTLEASTSX9MYZF7i6UOiEC6CEmVtFDu+Jq9W
 eE6iaKr/fsX2z1QljRuV0KjSY/tLoOVmAya+DHF6bxRQSJZmA738cflNGMnDIkfB609TuI8nc98
 XxrACBR6xioeh4PzuJHLfVBoCr2EO3B1cZCtTokN+aN2Zs6bzhrN17Ao31BXhuD19Na3C48eoaS
 mx0zUPAf1pSHhFsDoD4fs0IvWL4KSOKkL6+fyKp38TdYIhMfSliHj6mxGXlgP5Sb9cmPeamxU9A
 C7jHP8GU
X-Proofpoint-ORIG-GUID: lOaO0LP6jT7lIFvPLDMsdQjDiU5QuBtv
X-Proofpoint-GUID: lOaO0LP6jT7lIFvPLDMsdQjDiU5QuBtv
X-Authority-Analysis: v=2.4 cv=HLjDFptv c=1 sm=1 tr=0 ts=68afad0e cx=c_pps
 a=1lLUHseZXy02fOJDnAts6g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=x7bEGLp0ZPQA:10 a=r4lgQ_5M6CoA:10
 a=xhYva8U-rXjhHIqx4WYA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam
 policy=cautious_plus_nq score=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508260105
X-Spam-Score: 0
X-Spam-OrigSender: shehaba2@illinois.edu
X-Spam-Bar: 

Hello,=0A=
=0A=
I am a PhD student doing research on adversarial testing of different TCP p=
rotocols. Recently, I found an interesting behavior of TCP that I am descri=
bing below:=0A=
=0A=
The network RTT was high for about a second before it was abruptly reduced.=
 Some packets sent during the high RTT phase experienced long delays in rea=
ching the destination, while later packets, benefiting from the lower RTT, =
arrived earlier. This out-of-order arrival triggered the receiver to genera=
te duplicate acknowledgments (dup ACKs). Due to the low RTT, these dup ACKs=
 quickly reached the sender. Upon receiving three dup ACKs, the sender init=
iated a fast retransmission for an earlier packet that was not lost but was=
 simply taking longer to arrive. Interestingly, despite the fast-retransmit=
ted packet experienced a lower RTT, the original delayed packet still arriv=
ed first. When the receiver received this packet, it sent an ACK for the ne=
xt packet in sequence. However, upon later receiving the fast-retransmitted=
 packet, an issue arose in its logic for updating the acknowledgment number=
. As a result, even after the next expected packet was received, the acknow=
ledgment number was not updated correctly. The receiver continued sending d=
up ACKs, ultimately forcing the congestion control protocol into the retran=
smission timeout (RTO) phase.=0A=
=0A=
I experienced this behavior in linux kernel 5.4.230 version and was wonderi=
ng if the same issue persists in the recent-most kernel. Do you know of any=
 commit that addressed this issue? If not, I am highly enthusiastic to inve=
stigate further. My suspicion is that the problem lies in tcp_input.c. I wi=
ll be eagerly waiting for your reply.=0A=
=0A=
Thanks=0A=
Shehab=

