Return-Path: <netdev+bounces-96679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFF78C71DD
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10141F21F5A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 07:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13D25765;
	Thu, 16 May 2024 07:14:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44018027
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=202.241.206.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715843693; cv=fail; b=GPrgllgDcSsWunINfcmqXQim/CZA3UbJL++ovA+oP23NA4EFQmJCJeTlLSD4JE9yjMoecnkqTdV2scUaqgtknc+ko/ZkXV4MSsSHNb3ugvyAMzE0ha/TH9WHSJfoeruog8VO/ofy6wz6gHKj6f0XCOWzuCKaZPsztHx21djTV1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715843693; c=relaxed/simple;
	bh=+YmgGqc2uC+bJxlkdr1dENdetQwQsNBMbmcuZQff0Lw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a1iBxVdh3kEoAw/PRiecHfj2VLlF8fozNU60tKrwWun/KBNbqytDhi9pF+Ac2kynNEsTZ5Kd47so2IDoOJh+d6EtGKyWb9OPkk14yhlz3zwvMXEcMBeGMIFSKNj/gk5KrtNJ1VZznXdER2YC2IXHEVeCd4CpNHUAB0O2y2hw0RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybertrust.co.jp; spf=pass smtp.mailfrom=cybertrust.co.jp; arc=fail smtp.client-ip=202.241.206.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybertrust.co.jp
Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <hotaka.miyazaki@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id QQHJ12108A;
	Thu, 16 May 2024 16:07:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oeuck78rYURIk2EX1Z5Ao6EMLvVCe/aT03THb5fjqY4Fcf+Oui28pK0W50BYVmAV5LiwmmpfpS5ypWNZFQAvzHmni8DjBQ/d7f8ydK24k2mHCNlHMbAjMghUOgl/Wi+eKcImqfte3EUfalv2M4M9pJ2z0MxwM1hceQmlHJB7D3+gG2V4+5Rop8rEQyNeXzFGY64t1Nq7AM6Q7WWEFv3unYvxhMenvlZ3J/mCDn1e3wiuUTOTTaQ3RbQvddvk+Qkw/1Qca+4Hm8VOYir3qKgFYR1DK7NoTNEt56Tc+4mcmsKIICbsRdS2RvX6SKUzUMUdX+BDqA1fRyFGe4WQx3pWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9G5K6D54KjbXJnpi7Ox/GSqWGqbhdqTMvUyKSiGTnOQ=;
 b=OPuYhGoUh/Hq4e2cjFMltaTYjKmZDBCA9AL/NpK+TTfHaOCmeQ2kgI5a2gNcA33Nnt0NjT2Ptag8UduoKz1KFSn/YGP6hjfqbZlX5yNdwbZ01alEmZ5PpdfLPJh6zoAdrZ4j9r5iN/CS+GURaeCzWf58ibGCoRexr6FluIPoPMeQ50Wtt9jTnLArbJEABLF7zp/wb3+WX4jepY01itslbEr8NygqbpZjHlzQmXMOV66Wlz4Dl2oRAWndx54GV8ScGcr8wECEr6HG8rqW49c6777Mf3cz7rVX6wEcj+Vz9WevdApEz0ANeG8LRJF1IlA9bqfBlT+PF7PjWxiVtjcjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Received: from TYAPR01MB6409.jpnprd01.prod.outlook.com (2603:1096:400:95::11)
 by TY3PR01MB11369.jpnprd01.prod.outlook.com (2603:1096:400:3d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 07:07:07 +0000
Received: from TYAPR01MB6409.jpnprd01.prod.outlook.com
 ([fe80::9b64:837:58d8:da1c]) by TYAPR01MB6409.jpnprd01.prod.outlook.com
 ([fe80::9b64:837:58d8:da1c%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 07:07:07 +0000
From: <hotaka.miyazaki@cybertrust.co.jp>
To: <netdev@vger.kernel.org>
Subject: Potential violation of RFC793 3.9, missing challenge ACK
Thread-Topic: Potential violation of RFC793 3.9, missing challenge ACK
Thread-Index: AQHap19c7aYOO8x4mUKwp926Su4Cmg==
Date: Thu, 16 May 2024 16:12:30 +0900
Message-ID:
 <TYAPR01MB64091EA3717FC588B4ACF045C4ED2@TYAPR01MB6409.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6409:EE_|TY3PR01MB11369:EE_
x-ms-office365-filtering-correlation-id: dd047d7d-a074-4a30-3989-08dc7576cc74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?L3FEL1NVUGlOb1I5NVUwbG1iOFcxRFNLazVJekgzNDBGNHRNSzcvUi9S?=
 =?iso-2022-jp?B?K3JjTkl4WFIzMTFmT3I4QWF0RG1HSTJpbHhLZUcwdis4NDB3TkplbUhj?=
 =?iso-2022-jp?B?QmlCcE1DWi9TT3duWElIUythK1VBSERDMHFUWmZadGxyRmdZVEtnNHd0?=
 =?iso-2022-jp?B?RnJwcWZSM3RwNTdEeVVPMXgwSGMrcTk4MFU1TTlqVWFhVklDaXNTQXp2?=
 =?iso-2022-jp?B?TXkrZmVKdk5zV2N2VFhVeXIyeUdoa3lpajJzMmJwOU9PaXhJYm9jejBp?=
 =?iso-2022-jp?B?R0RjTnRsaXoxTmpuTCt4bVF0R3JjMDBrVGxLZ2dZbzdyb21RT0h0WCtO?=
 =?iso-2022-jp?B?ZG9GZWxjZ3FuNXFJYWVVV2RsVWs2UlllVFBNUWk0aDBUcSt4YXdXSlEr?=
 =?iso-2022-jp?B?K3JqNFFqRlhzZHloRzlVQmZ6RXVPYTJHQk8yZENKZitVV3N3RzFpMlhE?=
 =?iso-2022-jp?B?NkEyTER4ZHFSNUJrUlFDWkFNWmd3cWV1R1YwUGxsejAra0JmR1hFSEYz?=
 =?iso-2022-jp?B?RWJKTEhOM1JiR0t2dk5VWHNlcnZFOVFKczBIZXhpWFJnUzU3Uld2dlRL?=
 =?iso-2022-jp?B?VE9pWFNQZndPOW9nUnhsNHBKQ1cya3BsemlwT0dFd3dwajlPK1ZWczZh?=
 =?iso-2022-jp?B?eHJuYTN1UmswbHZRUHJUUUp2dEhBK2d0Ym9wcjBPZk96ME05Y3ZMeVRO?=
 =?iso-2022-jp?B?MXcvZ1J3VDFUZnZNUHh6aFZWN1crbVhydFFHZWFaQU9wQUpsUG04RmhV?=
 =?iso-2022-jp?B?bm5FZUc1T1Y0QkFrcVg1ZDNWTnJDa2NEWDVIWFd5SkYyTm1LMWF0ZXJo?=
 =?iso-2022-jp?B?UXh5TzErQkt0YnpCejdxVXJCbkZ6U1VHSjhTTXM2cys0VndoMWJPbU41?=
 =?iso-2022-jp?B?QmpMdjlmUUZwYnZyNVlMOWVzU0FTN0l3anZhWU1NdWQ5cDZQYWNsdTJs?=
 =?iso-2022-jp?B?a09lOTVyZzk5NC9XM2E5SHQ4YURlanhnbHU2NmFqODRNZWR5RmZqbE5q?=
 =?iso-2022-jp?B?QmFzejVrRnpqa05ROXAvcnNFamM4SWVzSEZqRnBXOXIvVzczaE5taFR1?=
 =?iso-2022-jp?B?ZTJUZDZTaDJDOHB3WUhuTFdTejlZbzhDYU5rM2ZXemgwRVNJcVI4bXhS?=
 =?iso-2022-jp?B?eTZIRnk4RXJiTXBkck03VFVJWWN2ZEptVXE3YUhraXhJYVVleU1leHlp?=
 =?iso-2022-jp?B?T1hqS0NiK3RYMEM1MUovVU5iY0ZBTnJNZGpQbTlyWjRJSklhR0NkdGRv?=
 =?iso-2022-jp?B?VmdKK2taVnVyb3dxODZ2T1RKOUNTRzY1S0tVbDR5SU1MOXVveU84dzRw?=
 =?iso-2022-jp?B?SWx1SUMrRiswLzh0elFXR3pXdjBsTVdEeEcrS0FCR0RZKzNQRTJIRWJH?=
 =?iso-2022-jp?B?bDNzL0JEUTBUVkFGWkU2RG5XTHdXWk9tYkkvN25UQk1mU2lyaTI3bEJp?=
 =?iso-2022-jp?B?T3pKSStXb3E0a21OVjVEKzI0RlZtRVoxWEFwY2tTdGEwNDhBT1h1Unc0?=
 =?iso-2022-jp?B?MG5RVTZlcmpNSHNGQUt6c20xa01yeFZVR2wxT0JoelNTbTFiY3FheXlK?=
 =?iso-2022-jp?B?ek1DWURHVUdHQi9rSFFYdWlSNHpXUS9zQ3ZSZEo2K3d3YXBKSkRkTGhV?=
 =?iso-2022-jp?B?YjBaRjJKeDYvazlmemd5dGNkcXY0RUI3M01FQ3ZSbFY0WnVrT2Z6cUlC?=
 =?iso-2022-jp?B?elRldEp2RzNOY1I4SXJUcEhuN0o3bVFNV1hpNzVjeTU3ajBBUmlJZlV4?=
 =?iso-2022-jp?B?OHNUVHNvR3RITkhrNEd4SG52dFVuUG9HSTYzWGF2cGtjQ2tTMFVhdUJn?=
 =?iso-2022-jp?B?YXpmVlp2RnFneXZwRURKUFJKaElmZGJ3SUpvS05YRE96SmlhNytoSWJR?=
 =?iso-2022-jp?B?NjFCRm9Ec21acHJMSndHa3pNenlHQk1kTjRXa0RrckVKczhNYlN0RnRC?=
 =?iso-2022-jp?B?V1cxZmpGS0lOczBGUzR3NzdGZythZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6409.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?V3JXVEF3eGVIdmtEeC9sejYwQ1dDSTZvbUNEQThlaTczSDkrMUpnK2lG?=
 =?iso-2022-jp?B?cUkvbmljTTFIZUgzVUNmeWk2RHBzZkNWRVdxMVdpSXU2bDY2OXpjUG1U?=
 =?iso-2022-jp?B?VW93TWxBYm56Wm8yZ2JmdllWZWJ1VU1GUkpWajNoK2RyVisveGhCamQr?=
 =?iso-2022-jp?B?cUMrVXpwY0tYSUpsd2xrcnpOOHptVnJmZ2NCWFBPeXVyUDhRZ291RnFC?=
 =?iso-2022-jp?B?bHdNTUF1QlZIa3hMc0traElKeWRaQ28vc1FjRzdsRU9udTYvbWQwdGla?=
 =?iso-2022-jp?B?ZGpuOWdzMUQxMTd1Ymo5L3dCS2JGWXlxdFZrVkNsZzEwdVduME92Nmlz?=
 =?iso-2022-jp?B?NUdqOXJVSVdPNDBFRytaWWNHaGhwQk9OSVZ0SkxkcG55cFBBWlo5OHVH?=
 =?iso-2022-jp?B?MW5xM2laV1RmNEFPalhXVGdOQlNyeGVhRnFZSnJYMWYvQW9NaTJuR3FG?=
 =?iso-2022-jp?B?R3M5dVNFOVM5UUZ0QzlvTW1lTmJyMU1XTk9xYkhOd1AwLzI3dXNGai92?=
 =?iso-2022-jp?B?amhycWtnSFZzVWNzalFpYkVNVmxUcytMTkQrWnBLUjFqMmhVSGU4MElw?=
 =?iso-2022-jp?B?eFpjaG1pOGh5YUdMVzVETiswamo3a3NkWE9pdUFaSDczZTV5bGw3R3pT?=
 =?iso-2022-jp?B?Z1Blay9wN0FCaXE0QUZmZER2RnJqVkZhK3lVeWVaWHFWd0J0VHNKN0xT?=
 =?iso-2022-jp?B?NkRVTSszSndURkNxUXFXZFREeVg3TXdDRWQ3SzZCNzZ3c2dMcGxJR1pM?=
 =?iso-2022-jp?B?R1lsK1BJbEtFOVozOXorU2RKMmkwc3NIV2d6dUo0bTlEb0xGVlpsenNv?=
 =?iso-2022-jp?B?ZXZpalVVT1lVOEFRQkVhbU5jejBoQTRDeElXVUxzaHJ3Q0R2WU5zVTVI?=
 =?iso-2022-jp?B?SE1uQkUyYld0SXZneFA0ejA1OVlqU3g3TGRQK0RERGxabUtGUGN6dUNy?=
 =?iso-2022-jp?B?RXY3U1RMOWwrTURRekE2UDBNWFNyb0czNDhGdDBqWm1KOFpSeU84Vmxy?=
 =?iso-2022-jp?B?dGpiSTVRNko4L2tCYXlBWlNGVzNVZW5RS2gwbXN3cm9BTEtWSSt3cFRR?=
 =?iso-2022-jp?B?WmtETlExdkNkNnNoN3lmNVcxeGZhM2ZrY1RUV2xBTXFuTGtpYktITzNW?=
 =?iso-2022-jp?B?bDM3enpyK3lDQTh5K1JlbldtaXF4bndHWC9hQlN5UzUySmZRa1hPREFr?=
 =?iso-2022-jp?B?SnYwU1p4Wlp0Zm9xNVRBR2tDcnVtTW10N0ZkSzdsT0V4OFN5eDRxVzZy?=
 =?iso-2022-jp?B?SlUrQ1R2OVZWcWl6YlRLb1VkUjI3Nk90UUgwN3JEZHVtbFNOWnMrMkhz?=
 =?iso-2022-jp?B?V3NIQy9VdU5GSjdvZU02MjNmb2JJOFl2a28rQ1hscVNkTVZ1UkFpRkdk?=
 =?iso-2022-jp?B?ZHA2QVExYVRBeFJoUmNwaUs0akIwck54OWNOSnA3QTkwanFWY3JFdUJT?=
 =?iso-2022-jp?B?Qk9GMEE5N3ZrVHc0ZTBTK1d6RmVwblFaSVVLWmhOaUpJcXhhTERLdklp?=
 =?iso-2022-jp?B?VGNYMGZiTTk3b1NsZHkzL3o1TVNmNktDK2MvV1Q1bnlTY3hlYnBrVDNl?=
 =?iso-2022-jp?B?YmFISm1jUHp3NEh0SW1kSGpIWEFwdjVTMENGYSs5dmpuM0dzM3M1azJu?=
 =?iso-2022-jp?B?dDg3bnFqRHVweURPVjVIOUhTbnJrNkJwOTVQYzNYV1RuZjRhcW8xUHFx?=
 =?iso-2022-jp?B?Y3hsM2dEd2dpd3Z0bytzU250MDF5N0s3bE4raU5JMmFxbml2bG5ScHRn?=
 =?iso-2022-jp?B?OTI5M29YV3VmN3RLUTZ5RWszM2YwV01NVzhkMnN0cXl6dGI3SXpQYzhm?=
 =?iso-2022-jp?B?N25KWjQ3TVltUnd1ZHFMdHVwWldqcmxoYlFQU0hqQlpJcXVWcWNZZVRv?=
 =?iso-2022-jp?B?Z3EvQ3JUVDk2OGhscEZNMlcxdzQ1Z0VXbGgyeEN6RVcwMlpKa2p0MjFj?=
 =?iso-2022-jp?B?RVdlNXRPZ044cXlUM1RxT0JiYlRpL096K21aNkVYRFFyTnBQVjFJcEtT?=
 =?iso-2022-jp?B?dGRuNXJ1ZnNpVm9STERUNFM1NUIwZXhqY3dPeVJmYzJ6elZEOVJubm1H?=
 =?iso-2022-jp?B?S05oUklTY1ZuTkZHUlBuMzRXajR5b2daYkNmeXhLSTNXUC8vbXhpdWJu?=
 =?iso-2022-jp?B?UzI0ME5UNGJkN0xqS3FGRjIrNzlDcTRRMk81Uzg0SW1kSUg0NHlpbWRB?=
 =?iso-2022-jp?B?ZGpNQnk1a01oV1ptZFNncERVNE03dUhMQWhvaGhYUldpUndJYVFSVXEr?=
 =?iso-2022-jp?B?a1ZJVWR2bWVGUXR3c1BRS1M5YXNRQ3ZYRm10bUxVZHpNREJWK1NMZGhF?=
 =?iso-2022-jp?B?VVJXVFp6ZlQ4bm40Q3lHTEo0Q2N3L205aVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C32uK+PnUdw0whoIEP1Hv1/jLlse6tOsxVR4+GwzSNh6vBuMMEsnK4ojLJpgU8Oppzt4u9xuThzL/0EANJefQHAQ5xSThohd9HXwyUUaKBCZ/WstqLSVJCRWHjQ+CO2Y0BpblMBFqBNAnt08TZEvTJCZYU0HF96BnhjZoNzTFAMBfOoNFVHvzziY9So91PL6yHIXIdABH9sj5xpvchzPoLkC7QrfOa/lS97KLL5rzLbxIClNDyLtFLpR39BlsyoDbBxuGPxH73t/MIx3rYCUUaEZKtThg2zqBIwX9dfg9uO27KySJRh8Iv4UPy997xfS+wQJXcKs1yzXxYJfoR5VuStaEyZNy7zGDOP/eJBLud+zmnVx1mZ1PC7UE3ndVDLffuc3AI1v9g8tNM5AS2pxAV04hkInhmOWOa2PVMJgYggrkzY2NoQtmFm0D/2YSGhsXfqba70LzFh5Nt2wUqhiWpAr2FChbfi4/5oPLX6v/FEybDEU7G4vAlUORQfZSbXwquoJPV/NeXHitoF63zKMj/eg5+4TCmwd62c7MqeYq9TbBeM7ORBd2sbWD9PmFhf1bLHdr+wxvAwpfMHvR/3D42pNtRzYjoSOWf9iJMJK8pFzsNdhSdaBO8+3PpuizkXC
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6409.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd047d7d-a074-4a30-3989-08dc7576cc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 07:07:07.6283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZdcXEKLI/cQm8NmE9ugh56ixD4SHLXCRSbb6qdOVNE69Stg0bUNTSQR/E1BFEb/ybUIwHt4yv0hRhpFkNC9UhokkydTsVrHwqralR4uX3ToiZiNVzPSa7oAyCzjih/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11369

Hello.=0A=
=0A=
I have a question about the following part of the tcp_ack function in net/i=
pv4/tcp_input.c.=0A=
```=0A=
	/* If the ack includes data we haven't sent yet, discard=0A=
 	* this segment (RFC793 Section 3.9).=0A=
 	*/=0A=
	if (after(ack, tp->snd_nxt))=0A=
  	  return -SKB_DROP_REASON_TCP_ACK_UNSENT_DATA;=0A=
```=0A=
I think that this part violates RFC793 3.9 (and the equivalent part in RFC9=
293 (3.10.7.4)).=0A=
=0A=
According to the RFC, =1B$B!H=1B(BIf the ACK acks something not yet sent (S=
EG.ACK > SND.NXT) then send an ACK, drop the segment, and return=1B$B!H=1B(=
B [1]. =0A=
However, the code appears not to ack before discarding a segment.=0A=
=0A=
Does anyone know whether the violation is intended and the reason if it is =
intended?=0A=
If that is not intended, I would like to fix it. What do you think of that?=
=0A=
=0A=
I think that the following patch would fix the violation. =0A=
The fixed code is similar to the SKB_DROP_REASON_TCP_TOO_OLD_ACK error case=
.=0A=
```=0A=
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c=0A=
index 5d874817a78d..a0ed2f671912 100644=0A=
--- a/net/ipv4/tcp_input.c=0A=
+++ b/net/ipv4/tcp_input.c=0A=
@@ -3877,11 +3877,14 @@ static int tcp_ack(struct sock *sk, const struct sk=
_buff *skb, int flag)=0A=
            	goto old_ack;=0A=
    	}=0A=
=0A=
-   	/* If the ack includes data we haven't sent yet, discard=0A=
-    	* this segment (RFC793 Section 3.9).=0A=
+   	/* If the ack includes data we haven't sent yet,=0A=
+    	* send an ACK and discard this segment (RFC793 Section 3.9).=0A=
     	*/=0A=
-   	if (after(ack, tp->snd_nxt))=0A=
+   	if (after(ack, tp->snd_nxt)) {=0A=
+           	if (!(flag & FLAG_NO_CHALLENGE_ACK))=0A=
+                   	tcp_send_challenge_ack(sk);=0A=
            	return -SKB_DROP_REASON_TCP_ACK_UNSENT_DATA;=0A=
+   	}=0A=
=0A=
    	if (after(ack, prior_snd_una)) {=0A=
            	flag |=3D FLAG_SND_UNA_ADVANCED;=0A=
```=0A=
=0A=
Thanks for reading.=0A=
=0A=
---=0A=
=0A=
[1]: RFC793 3.9 on page 72 (fifth check)=0A=
```=0A=
   	ESTABLISHED STATE=0A=
=0A=
      	If SND.UNA < SEG.ACK =3D< SND.NXT then, set SND.UNA <- SEG.ACK.=0A=
      	Any segments on the retransmission queue which are thereby=0A=
      	entirely acknowledged are removed.  Users should receive=0A=
      	positive acknowledgments for buffers which have been SENT and=0A=
      	fully acknowledged (i.e., SEND buffer should be returned with=0A=
      	"ok" response).  If the ACK is a duplicate=0A=
      	(SEG.ACK < SND.UNA), it can be ignored.  If the ACK acks=0A=
      	something not yet sent (SEG.ACK > SND.NXT) then send an ACK,=0A=
      	drop the segment, and return.=0A=
```=

