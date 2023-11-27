Return-Path: <netdev+bounces-51487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C10D7FADD5
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 23:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59DA6B20F88
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029AB48CF4;
	Mon, 27 Nov 2023 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CiibMHzq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BDF18B
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 14:59:09 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJsRPA011172
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 14:59:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Mr2JccOfZeButj5mG/EcFKJoUhgdxFNRL8lDn1uHwlU=;
 b=CiibMHzq/NybP944XDdX4h5ImGKMxQiKYbA+5JyRSdBOC2jSmBwewCMFlBMzOiinORsx
 GZAEChgeDfPx+MuOLO81FzftEgNdEfrhZpk6LeKcxGTzzAsHLcZ4U1iw5FTZ6CXR2cM6
 G2KL6uYWz+EYkVPaAZOTVjI3vNe2oReeuYWGKuJ5yEdX4QByoed9la/5fSbQlbktm41x
 UYCCWPj8upQNb+1vokw3C9GhWRmzUtdjUM1oPUgvoor3YrCRNBQ1BYRbHO9gb2CDauLW
 GudWr+edpmO+iw0V1MpoY5E8l+ohf9jVvZhfL3q5mroE0uBTD8q6aJFD0Z4Khj8DBdJ/ JQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3un1pa1599-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 14:59:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajhW2AwRxA8G/I222NGowhQ4j9HAYDCEMrmo34oFG+xO5gBfJAMTD961g/rZSkJTUCA5dsbM+UjHTY5b5S8JZ+DOuYGtTshJkEazajLlNfc74XDcpMaeJmbBDFhkTsEf08noyC4/h4WOOmZpL1qMXSAuBRqJFr6wid3vQw7QjIniH7al+4lRpgxbLAjM6xq2suzzdhvDpGLm7BQGIO6dTaqmrDyQiAUdLUwlY7Z0rYGo1hv1I8+LXshN/f1p/0oOWxehSzDHP1p79RwXvqAmaTrSmsOjgsRoKTkX2gMCQDFRJqe00v8mWML470AhtT8c81PvovuHGITXK9sgAzXKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOb19adhVjdDuvFKpVz2C1WltWjVn7cykCoItKJMK8U=;
 b=KIZvvIf7Pb9g43lfvWZdHHPcEtWLV7hk8wXwgWMXzVcPRhy/FTpRcUpVSNpNR8Z8VnsmTWzwwyAcMz9M8XnD8deSUXHQwWPzAJyB6wnfNtuie8n50TyE8VTb2vZWLZlQhjRYfFz+eXnCYxgS14EGJL5PKGf3jTDLamrkNFFbztkDJxwgH9+efKNAWfwK0bc+lSLappqfaVYxvK7O/A4fIFhipsx4LksQAFkjaaramYdL3BA6b5n38V3//udrkbYW3g49uTijR+fu+C3ZE7RJ39JFg6jMq+VbG1EoEr16GZB+SzbHJ8Hw5klbGdgn0aC2Gm42pw1i9tL8gdKSRqeNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5187.namprd15.prod.outlook.com (2603:10b6:806:237::10)
 by SJ0PR15MB4472.namprd15.prod.outlook.com (2603:10b6:a03:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 22:59:05 +0000
Received: from SA1PR15MB5187.namprd15.prod.outlook.com
 ([fe80::8e8:f2f9:bb50:328a]) by SA1PR15MB5187.namprd15.prod.outlook.com
 ([fe80::8e8:f2f9:bb50:328a%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 22:59:05 +0000
From: Neil Spring <ntspring@meta.com>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Neal
 Cardwell <ncardwell@google.com>, Wei Wang <weiwan@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net] tcp: fix mid stream window clamp.
Thread-Topic: [PATCH net] tcp: fix mid stream window clamp.
Thread-Index: AQHaHiFAQHaNVihllUWpFda+BDhZWLCII7IAgAASUgCAAAwXy4AA2GcAgAWKzqY=
Date: Mon, 27 Nov 2023 22:59:05 +0000
Message-ID: 
 <SA1PR15MB51870B8E934E9132044CE58DA3BDA@SA1PR15MB5187.namprd15.prod.outlook.com>
References: 
 <fab4d0949126683a3b6b4e04a9ec088cf9bfdbb1.1700751622.git.pabeni@redhat.com>
	 <CANn89iJMVCGegZW2JGtfvGJVq1DZsM7dUEOJxfcvWurLSZGvTQ@mail.gmail.com>
	 <ebb26a4a8a80292423c8cfc965c7b16e2aa4e201.camel@redhat.com>
	 <SA1PR15MB5187F56AEFC6B6A581E056C5A3B9A@SA1PR15MB5187.namprd15.prod.outlook.com>
 <3f549b4f1402ea17d56c292d3a1f85be3e2b7d89.camel@redhat.com>
In-Reply-To: <3f549b4f1402ea17d56c292d3a1f85be3e2b7d89.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5187:EE_|SJ0PR15MB4472:EE_
x-ms-office365-filtering-correlation-id: 4de65b4a-59e5-413d-cc5c-08dbef9c749a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sAKZYEUbBHDdr7bhk/eJgK39WlGQ1npBJ7/nfwpVQCpN63QMLYhhtZ4tHXE0ZTUnlbHA43ANLBeC7h6J82KwxMp4kA070CNLly/FLFKVnQ/HOb5jJDjxagnLqZpGpkA1N1zSE9yaPO+R1NwYOSOFfDAGwGwVdb0DbBKJH0YSTuRb2pNRxU3JYmNlrZA9gemh1b4/qYZr7efhh5+az7RCqz34xUKPV/oDKNbw/3YzY6qV1Xl0b109K9DdEBA7zrUug4HWYBMJLZpZ/aWTI1JkT8lVZiUL1t0J7jzhvUUTm4l3zmPcVl0gmNdulP6Y0dDl79krZ2VaGBO5W+yoLJ0+AalwDcx5iJ2avrO2r8tegOHE5opdoX7SvrzwPT0qUxUk6Md2iWx10sBoLW8f/9x0cog/FXwwuvhP9RjZTpqzM4DQWGXa1bAXW9Y5S8vjy2NZkdY9eliasxcE0r07OJcKB0VTxNma5YNkLEsbolv86igFoJUfdS+JHFHfH3x6LB0HqWZyCbS/DpAa6KELlNrFrkEEmVpGCd54xqTW7PmYX/hdnyC17xlLS+u1wsUf5t6un/x4EZ5JrDBz9V5E1TobV7q6nSbUesmnC/IC7ngviGQEVCxJxojzaCQuVh4CUYt6wxc0M13bFEeY/qZAH7mO7g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5187.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(4326008)(55016003)(4001150100001)(2906002)(52536014)(66899024)(8936002)(8676002)(7696005)(9686003)(6506007)(53546011)(86362001)(71200400001)(316002)(66476007)(66556008)(38070700009)(66946007)(5660300002)(54906003)(64756008)(66446008)(966005)(33656002)(76116006)(91956017)(110136005)(478600001)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T1NZbldSQXc2R2NlY0dKT0RxaDMxWCtNV3hkbVZIbUVKV21EajNEK0F0eXpx?=
 =?utf-8?B?SENqNElzaXNiSU53S0g0OGJEQXZTc2FtYVJHSVh3eS9FY2luOHdEZUlmWFVj?=
 =?utf-8?B?L3F0Wm5Jd0Z0L3N6ajlNb0FTSUs4cDlwVFA4anE3VFhjRExjL2JYQzVEZFpZ?=
 =?utf-8?B?QUFaOFRkdmM4LzEyYkU0djFtNVlQV3JobGNzeGU4MVhYUEhNa0JlSDU3a1RW?=
 =?utf-8?B?UzI5dHNGQXNXRE0xTXNrb2lrSjBVZDFsNE5QOTYzWDd4QzE4eVBqWi9rNjV2?=
 =?utf-8?B?UUxBOXlmZE02WmljMnRPelFvcC93ZHZvdUtHeUQ4ZVFGWlBLQ0xCRVkraEdj?=
 =?utf-8?B?ZXE5QWxxaFN4eGNaWnNnYlJ4eTFIYnpqUzBiUHhzTUdWUU9BbElRZjZTd0c4?=
 =?utf-8?B?OVBrTlA4YjUwL0N2S0NvRzk1STlCNXB6RW9LTnhFRGFGR1F2QzlyNkJEMzIx?=
 =?utf-8?B?cVZMRkxRdXVoSEFPekNEVXQ2RTlCRms1MWc2ekgzY0VxRHlvd25vdlovc2ZB?=
 =?utf-8?B?d2ZYSDRJVGw5RGZkTWVZNmVnWnhvUmEzdHhJbG5xcFo3aldSVWppRGlQeFpu?=
 =?utf-8?B?bkpwWHVEaWNzR1JiWTFRRW00RUlVY0c3MnpqQXZmb3U2ZDI2Q3R5OEIvSXJp?=
 =?utf-8?B?MVprKy9jVkMrTjAzVXorQTJaMnM2NzVJbnFjbUVZeXZYMkRsbzdjcS9VZHdW?=
 =?utf-8?B?UTFnY0NWaUhYT3BUMEN2a1pCT0hwV3RvUVVudGhZbnBuUjJkVXI3Y1d4bmxB?=
 =?utf-8?B?MXlzb3RRZG82dklsU1FLa3ZpSHVTSEpYS3plZ0NjaVFkREppN0pycVJNcHJn?=
 =?utf-8?B?YjR6T05YM1BVOVJEeTJxVERuZ2hydDVVRUU0UGVUckZWbGR1YzZkc3FhUlBR?=
 =?utf-8?B?RU44QlpEbnlwdHdvNnJoTjFpR1BwTllhM2J2cjg3RlB4TlUzMDI3V2o5K1Fv?=
 =?utf-8?B?SlUvdTIxYmhpS0xvbzlzMS8wOTkyREtySnZienlxV3pRZ0J1alpRKy8yaDJR?=
 =?utf-8?B?QWxTSW9PbFRzdFJ4RnQ4cFNkcENRaURGQ3NkdHA1WUM0Q2dLd2lmQ1NTZ2l5?=
 =?utf-8?B?bjU4aFhLZlVYcmNNSG16L3FpajJZWVpSOW5YQ1d3YWhmUUk3VkwzOGt6RDdN?=
 =?utf-8?B?RmRUTS9OMjZoOUk0QXBPTkVDdkdkOEtpM3l1TUkrUU01bDVmREhIWHFpb3Ja?=
 =?utf-8?B?WHQ0bkVJV2RibGxhdU1oWGt1T3craytIemd4aE96YXNJc1NBeWJoRmg2a2tO?=
 =?utf-8?B?ODhuSjBqc2UyaUxMZER5cUh4SlZ3R0hlb1N6UFhYTzk1bWwrbEVuUXExK0sv?=
 =?utf-8?B?YkFHNUl4dDUvaVZSUmF2VlhSUE5OTlRhYlRFcFBPRURweWtNRDR5ajg2Q3dO?=
 =?utf-8?B?Y05zbmozazdsRTh1dXYzOHlEVWVjSW1JOWlIMURuTktXUzBJNnNOUC9ZZ2Rh?=
 =?utf-8?B?K1hEVldZTmdzdjhBbXJDalRWdlJVZkhrbGRFclZGVE43bk9JQXFWL2ZYakxG?=
 =?utf-8?B?SlNJdk9yaW93U3RqUkVsS2szWW5IU3lWWnVLOGo3Q29TdlMreVp2Q0FIQkhS?=
 =?utf-8?B?Mi91bVAwRXRFcnh3b0x0d2JMSi95elQ3N290WkxzaUg2blZiVEpJT0dKT21w?=
 =?utf-8?B?WFlIK2dOWmNnZGFPVXpPSklITnZXMnJZUVRRQ1VzajRERnJ3ZXlVSVV6YVpw?=
 =?utf-8?B?NTU0WDBXM2FnblU4UDdTb0xmZGlGTjdPelpFMUxuWWhWdkJScGpmS2hyL2w4?=
 =?utf-8?B?V2lvd3MrVjBYb25vOWNhQnNEWDV0SFBjRGpBOUludVdLNVU0MzZ3aS9KNzFX?=
 =?utf-8?B?TTJNUC9nVDU3ckRnQXZNSEpYS3Bydi9zQmdRNHVwdWxPbXdUMXZkWXlKV21F?=
 =?utf-8?B?ZkNSbE1wUFFpSkVqNlFyWDBqVUJKaCtKUUtzbFpHNWhGR0MwQ29ONzRIbUYz?=
 =?utf-8?B?ekI1UHMwUmJva1VXQjFjd3ZIRStBbFUvUXNXUkROaUgyekNaU24vR0l2UDhm?=
 =?utf-8?B?djJqZ25TN09sUFduMmEvNzUrV2UvUlBzUzlPYlYyVUc2cXJxSHNCd0lnM1V1?=
 =?utf-8?B?d0VUbHRiWVZoSmJiN3BEdHNnamtkM2EyZG9zcFhZTnNPR1NFWml0dkp2dDls?=
 =?utf-8?B?YnpabnJvR0tqYlV4T2NNSjc4WGJMdGl1b2MwajdDZTVPWFJKSVJZUGZaQzhG?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5187.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de65b4a-59e5-413d-cc5c-08dbef9c749a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 22:59:05.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05/MFAx62WiFuKhp+9YUeZY99PYEslcfTkjBwi8oeWCh+fcdMHpR98MUF/CupM+62W8mBdm9oTVjZ1EdDozZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4472
X-Proofpoint-GUID: 6BKuGOlEjI3Yty6GKQL5qNjg-J9LXs2J
X-Proofpoint-ORIG-GUID: 6BKuGOlEjI3Yty6GKQL5qNjg-J9LXs2J
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02

PiBPbiBGcmksIDIwMjMtMTEtMjQgYXQgMDU6MjcgKzAwMDAsIE5laWwgU3ByaW5nIHdyb3RlOgo+
ID4gPgo+ID4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiA+
IEZyb206IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4KPiA+ID4gU2VudDogVGh1cnNk
YXksIE5vdmVtYmVyIDIzLCAyMDIzIDEwOjE2IEFNCj4gPiA+IFRvOiBFcmljIER1bWF6ZXQ7IE5l
YWwgQ2FyZHdlbGw7IFdlaSBXYW5nCj4gPiA+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBE
YXZpZCBTLiBNaWxsZXI7IERhdmlkIEFoZXJuOyBKYWt1Ygo+ID4gPiBLaWNpbnNraTsgTmVpbCBT
cHJpbmc7IERhdmlkIEdpYnNvbgo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldF0gdGNwOiBm
aXggbWlkIHN0cmVhbSB3aW5kb3cgY2xhbXAuCj4gPiA+Cj4gPiA+ICEtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4g
LXwKPiA+ID4gICBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIKPiA+ID4K
PiA+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+ID4gPiA+IC0tIQo+ID4gPgo+ID4gPiBPbiBUaHUsIDIwMjMtMTEt
MjMgYXQgMTg6MTAgKzAxMDAsIEVyaWMgRHVtYXpldCB3cm90ZToKPiA+ID4gPiBDQyBOZWFsIGFu
ZCBXZWkKPiA+ID4gPgo+ID4gPiA+IE9uIFRodSwgTm92IDIzLCAyMDIzIGF0IDQ6MjXigK9QTSBQ
YW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+Cj4gPiA+ID4gd3JvdGU6Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gQWZ0ZXIgdGhlIGJsYW1lZCBjb21taXQgYmVsb3csIGlmIHRoZSB1c2VyLXNwYWNl
IGFwcGxpY2F0aW9uCj4gPiA+ID4gPiBwZXJmb3Jtcwo+ID4gPiA+ID4gd2luZG93IGNsYW1waW5n
IHdoZW4gdHAtPnJjdl93bmQgaXMgMCwgdGhlIFRDUCBzb2NrZXQgd2lsbAo+ID4gPiA+ID4gbmV2
ZXIgYmUKPiA+ID4gPiA+IGFibGUgdG8gYW5ub3VuY2UgYSBub24gMCByZWNlaXZlIHdpbmRvdywg
ZXZlbiBhZnRlciBjb21wbGV0ZWx5Cj4gPiA+ID4gPiBlbXB0eWluZwo+ID4gPiA+ID4gdGhlIHJl
Y2VpdmUgYnVmZmVyIGFuZCByZS1zZXR0aW5nIHRoZSB3aW5kb3cgY2xhbXAgdG8gaGlnaGVyCj4g
PiA+ID4gPiB2YWx1ZXMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gUmVmYWN0b3IgdGNwX3NldF93aW5k
b3dfY2xhbXAoKSB0byBhZGRyZXNzIHRoZSBpc3N1ZTogd2hlbiB0aGUKPiA+ID4gPiA+IHVzZXIK
PiA+ID4gPiA+IGRlY3JlYXNlcyB0aGUgY3VycmVudCBjbGFtcCB2YWx1ZSwgc2V0IHJjdl9zc3Ro
cmVzaCBhY2NvcmRpbmcKPiA+ID4gPiA+IHRvIHRoZQo+ID4gPiA+ID4gc2FtZSBsb2dpYyB1c2Vk
IGF0IGJ1ZmZlciBpbml0aWFsaXphdGlvbiB0aW1lLgo+ID4gPiA+ID4gV2hlbiBpbmNyZWFzaW5n
IHRoZSBjbGFtcCB2YWx1ZSwgZ2l2ZSB0aGUgcmN2X3NzdGhyZXNoIGEgY2hhbmNlCj4gPiA+ID4g
PiB0byBncm93Cj4gPiA+ID4gPiBhY2NvcmRpbmcgdG8gcHJldmlvdXNseSBpbXBsZW1lbnRlZCBo
ZXVyaXN0aWMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gRml4ZXM6IDNhYTc4NTdmZTFkNyAoInRjcDog
ZW5hYmxlIG1pZCBzdHJlYW0gd2luZG93IGNsYW1wIikKPiA+ID4gPiA+IFJlcG9ydGVkLWJ5OiBE
YXZpZCBHaWJzb24gPGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT4KPiA+ID4gPiA+IFJlcG9y
dGVkLWJ5OiBTdGVmYW5vIEJyaXZpbyA8c2JyaXZpb0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gUmV2
aWV3ZWQtYnk6IFN0ZWZhbm8gQnJpdmlvIDxzYnJpdmlvQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiBU
ZXN0ZWQtYnk6IFN0ZWZhbm8gQnJpdmlvIDxzYnJpdmlvQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiAt
LS0KPiA+ID4gPiA+ICBuZXQvaXB2NC90Y3AuYyB8IDE5ICsrKysrKysrKysrKysrKystLS0KPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
PiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNwLmMgYi9uZXQvaXB2
NC90Y3AuYwo+ID4gPiA+ID4gaW5kZXggNTNiY2MxN2M5MWU0Li4xYTliOTA2NGUwODAgMTAwNjQ0
Cj4gPiA+ID4gPiAtLS0gYS9uZXQvaXB2NC90Y3AuYwo+ID4gPiA+ID4gKysrIGIvbmV0L2lwdjQv
dGNwLmMKPiA+ID4gPiA+IEBAIC0zMzY4LDkgKzMzNjgsMjIgQEAgaW50IHRjcF9zZXRfd2luZG93
X2NsYW1wKHN0cnVjdCBzb2NrCj4gPiA+ID4gPiAqc2ssIGludCB2YWwpCj4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICB0cC0+d2luZG93X2NsYW1wID0gMDsKPiA+ID4gPiA+ICAgICAgICAgfSBlbHNlIHsKPiA+
ID4gPiA+IC0gICAgICAgICAgICAgICB0cC0+d2luZG93X2NsYW1wID0gdmFsIDwgU09DS19NSU5f
UkNWQlVGIC8gMiA/Cj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBTT0NLX01JTl9S
Q1ZCVUYgLyAyIDogdmFsOwo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIHRwLT5yY3Zfc3N0aHJl
c2ggPSBtaW4odHAtPnJjdl93bmQsIHRwLQo+ID4gPiA+ID4gPndpbmRvd19jbGFtcCk7Cj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgdTMyIG5ld19yY3Zfc3N0aHJlc2gsIG9sZF93aW5kb3dfY2xh
bXAgPSB0cC0KPiA+ID4gPiA+ID53aW5kb3dfY2xhbXA7Cj4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgdTMyIG5ld193aW5kb3dfY2xhbXAgPSB2YWwgPCBTT0NLX01JTl9SQ1ZCVUYgLwo+ID4gPiA+
ID4gMiA/Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBTT0NLX01JTl9SQ1ZCVUYKPiA+ID4gPiA+IC8gMiA6IHZhbDsKPiA+ID4gPiA+ICsK
PiA+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAobmV3X3dpbmRvd19jbGFtcCA9PSBvbGRfd2lu
ZG93X2NsYW1wKQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4g
PiA+ID4gPiArCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgdHAtPndpbmRvd19jbGFtcCA9IG5l
d193aW5kb3dfY2xhbXA7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgaWYgKG5ld193aW5kb3df
Y2xhbXAgPCBvbGRfd2luZG93X2NsYW1wKSB7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICB0cC0+cmN2X3NzdGhyZXNoID0gbWluKHRwLQo+ID4gPiA+ID4gPnJjdl9zc3RocmVzaCwK
PiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo+
ID4gPiA+ID4gbmV3X3dpbmRvd19jbGFtcCk7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgfSBl
bHNlIHsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG5ld19yY3Zfc3N0aHJlc2gg
PSBtaW4odHAtPnJjdl93bmQsIHRwLQo+ID4gPiA+ID4gPndpbmRvd19jbGFtcCk7Cj4gPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICB0cC0+cmN2X3NzdGhyZXNoID0KPiA+ID4gPiA+IG1h
eChuZXdfcmN2X3NzdGhyZXNoLAo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB0cC0KPiA+ID4gPiA+ID5yY3Zfc3N0aHJlc2gpOwo+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgIH0KPiA+ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+ID4gICAgICAg
ICByZXR1cm4gMDsKPiA+ID4gPiA+ICB9Cj4gPiA+ID4KPiA+ID4gPiBJdCBzZWVtcyB0aGVyZSBp
cyBubyBwcm92aXNpb24gZm9yIFNPX1JFU0VSVkVfTUVNCj4gPiA+Cj4gPiA+IEluZGVlZCBJIGRp
ZCB0YWtlIHRoYXQgaW4gYWNjb3VudC4KPiA+ID4KPiA+ID4gPiBJIHdvbmRlciBpZiB0Y3BfYWRq
dXN0X3Jjdl9zc3RocmVzaCgpICBjb3VsZCBoZWxwIGhlcmUgPwo+ID4gPgo+ID4gPiBJIGRvbid0
IGtub3cgaG93IHRvIGZpdCBpdCBpbnRvIHRoZSBhYm92ZS4KPiA+ID4gdGNwX2FkanVzdF9yY3Zf
c3N0aHJlc2goKQo+ID4gPiB0ZW5kcyB0byBzaHJpbmsgcmN2X3NzdGhyZXNoIHRvIGxvdyB2YWx1
ZXMgd2hlbiBubyBtZW1vcnkgaXMKPiA+ID4gcmVzZXJ2ZWQuCj4gPiA+Cj4gPiA+IERlYWxpbmcg
ZGlyZWN0bHkgd2l0aCBTT19SRVNFUlZFX01FTSB3aGVuIHNocmlua2luZyB0aGUgdGhyZXNob2xk
Cj4gPiA+IGZlZWxzCj4gPiA+IGVhc2llciB0byBtZSwgc29tZXRoaW5nIGFsaWtlOgo+ID4gPgo+
ID4gPiAgICAgICAgICAgICAgICBpZiAobmV3X3dpbmRvd19jbGFtcCA9PSBvbGRfd2luZG93X2Ns
YW1wKQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gPgo+ID4gPiAg
ICAgICAgICAgICAgICB0cC0+d2luZG93X2NsYW1wID0gbmV3X3dpbmRvd19jbGFtcDsKPiA+ID4g
ICAgICAgICAgICAgICAgaWYgKG5ld193aW5kb3dfY2xhbXAgPCBvbGRfd2luZG93X2NsYW1wKSB7
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGludCB1bnVzZWRfbWVtID0KPiA+ID4gc2tf
dW51c2VkX3Jlc2VydmVkX21lbShzayk7Cj4gPiA+Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHRwLT5yY3Zfc3N0aHJlc2ggPSBtaW4odHAtPnJjdl9zc3RocmVzaCwKPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXdfd2luZG93X2NsYW1w
KTsKPiA+ID4KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHVudXNlZF9tZW0pCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHAtPnJjdl9zc3RocmVzaCA9IG1h
eF90KHUzMiwgdHAtCj4gPiA+ID5yY3Zfc3N0aHJlc2gsCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB0Y3Bfd2luX2Zyb21fc3BhY2Uoc2ssCj4gPiA+IHVudXNl
ZF9tZW0pKTsKPiA+ID4gICAgICAgICAgICAgICAgfSBlbHNlIHsKPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgbmV3X3Jjdl9zc3RocmVzaCA9IG1pbih0cC0+cmN2X3duZCwgdHAtCj4gPiA+
ID53aW5kb3dfY2xhbXApOwo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB0cC0+cmN2X3Nz
dGhyZXNoID0gbWF4KG5ld19yY3Zfc3N0aHJlc2gsCj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB0cC0+cmN2X3NzdGhyZXNoKTsKPiA+ID4gICAgICAg
ICAgICAgICAgfQo+ID4gPgo+ID4gPiBQb3NzaWJseSB0aGUgYml0cyBzaGFyZWQgd2l0aCB0Y3Bf
YWRqdXN0X3Jjdl9zc3RocmVzaCgpIGNvdWxkIGJlCj4gPiA+IGZhY3RvcmVkIG91dCBpbiBhIGNv
bW1vbiBoZWxwZXIuCj4gPiA+Cj4gPiA+ID4gSGF2ZSB5b3UgY29uc2lkZXJlZCByZXZlcnRpbmcg
IDNhYTc4NTdmZTFkNyAoInRjcDogZW5hYmxlIG1pZAo+ID4gPiA+IHN0cmVhbQo+ID4gPiA+IHdp
bmRvdyBjbGFtcCIpID8KPiA+ID4KPiA+ID4KPiA+ID4gVGhhdCB3b3VsZCB3b3JrLCB0b28gYW5k
IHdpbGwgYmUgc2ltcGxlci4KPiA+ID4KPiA+ID4gVGhlIGlzc3VlIGF0IGhhbmQgd2FzIG5vdGVk
IHdpdGggYW4gYXBwbGljYXRpb24gdGhhdCByZWFsbHkgd2FudHMKPiA+ID4gdG8KPiA+ID4gbGlt
aXQgdGhlIGFubm91bmNlZCB3aW5kb3c6Cj4gPiA+Cj4gPiA+IGh0dHBzOi8vZ2l0bGFiLmNvbS9k
Z2lic29uL3Bhc3N0Cj4gPiA+Cj4gPiA+IEkgZ3Vlc3MgdG91Y2hpbmcgcmN2X3NzdGhyZXNoIHdv
dWxkIGJlIGEgYml0IG1vcmUgZWZmZWN0aXZlLgo+ID4gPgo+ID4gPiBOb3QgbXVjaCBtb3JlIGlu
IHRoZSBlbmQsIGFzIGJvdGggd2luZG93X2NsYW1wIGFuZCByY3Zfc3N0aHJlc2ggY2FuCj4gPiA+
IGxhdGVyIGdyb3cgZHVlIHRvIHJjdiBidWYgYXV0by10dW5lLiBJZGVhbGx5IHdlIHdvdWxkIGxp
a2UgdG8KPiA+ID4gcHJldmVudAo+ID4gPiB0Y3BfcmN2X3NwYWNlX2FkanVzdCgpIGZyb20gdG91
Y2hpbmcgd2luZG93X2NsYW1wIGFmdGVyCj4gPiA+IFRDUF9XSU5ET1dfQ0xBTVAgLSBidXQgdGhh
dCBpcyBhbm90aGVyIG1hdHRlci9wYXRjaC4KPiA+ID4KPiA+ID4gVGhhbmtzIQo+ID4gPgo+ID4g
PiBQYW9sbwo+ID4gPgo+ID4KPiA+IFRoZSBwYXRjaCB0byBmaXggdGhlIGJ1ZyB3aGVyZSByY3Zf
c3NodGhyZXNoIGlzIHJlZHVjZWQgdG8gemVybyBvbiBhCj4gPiBmdWxsIHJlY2VpdmUgd2luZG93
IGFuZCBjYW5ub3QgcmVjb3ZlciBpczoKPiA+IC10cC0+cmN2X3NzdGhyZXNoID0gbWluKHRwLT5y
Y3Zfd25kLCB0cC0+d2luZG93X2NsYW1wKTsKPiA+ICt0cC0+cmN2X3NzdGhyZXNoID0gbWluKHRw
LT5yY3Zfc3N0aHJlc2gsIHRwLT53aW5kb3dfY2xhbXApOwo+IAo+IEZUUiBJIGNvbnNpZGVyZWQg
c29tZXRoaW5nIHNpbWlsYXIgdG8gdGhlIGFib3ZlLCBidXQgSSBvcHRlZCBmb3IgdGhlCj4gcHJl
c2VudCBwYXRjaCwgYXMgdGhlIGFib3ZlIGRvZXMgbm90IHBhc3MgdGhlIHBrdGRyaWxsIHN1Z2dl
c3RlZCBieQo+IEVyaWMgaGVyZToKPiAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYv
NjA3MDgxNmUtZjdkMi03MjVhLWVjMTAtOWQ4NWYxNTQ1NWEyQGdtYWlsLmNvbS8KPiAKPiBDaGVl
cnMsCj4gCj4gUGFvbG8KCkFoaCwgdGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dCEgIEkgc2Vl
IHRoYXQgdGhlIHBhY2tldGRyaWxsIGFsc28gbmVlZHMgc29tZSBmaXhlcyB0byBhZGRyZXNzIGNo
YW5nZXMgdG8gdGhlIGluaXRpYWwgd2luZG93LiAgOigKCldvdWxkIHRoZSBmb2xsb3dpbmcgYWRk
cmVzcyB0aGUgY29uY2Vybj8gIAoKdHAtPnJjdl9zc3RocmVzaCA9IG1pbihtYXgodHAtPnJjdl9z
c3RocmVzaCwgdHAtPnJjdl93bmQpLCB0cC0+d2luZG93X2NsYW1wKTsKCih0aGF0IGlzLCByY3Zf
c3NodGhyZXNoIG11c3QgYmUgbm8gZ3JlYXRlciB0aGFuIHdpbmRvd19jbGFtcCwgYnV0IG90aGVy
d2lzZSBpdCBjYW4ga2VlcCB0aGUgbGFyZ2VyIG9mIGl0cyBjdXJyZW50IHZhbHVlIG9yIHRoZSBs
YXN0IGFkdmVydGlzZWQgd2luZG93LikKCkkgYmVsaWV2ZSB0aGlzIGFkZHJlc3NlcyBib3RoIHBy
b2JsZW0gY2FzZXMgKHRyYW5zaWVudCB0aW55IGNsYW1wOyBjbG9zZWQgd2luZG93IHdoZW4gY2xh
bXBpbmcpIGFuZCBwYXNzZXMgKHNsaWdodGx5IGxlc3MgcGlja3kpIHBhY2tldGRyaWxsIHRlc3Rz
LgoKLW5laWwKCg==

