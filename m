Return-Path: <netdev+bounces-176036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C3A686BC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C4A3A6179
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A2250C06;
	Wed, 19 Mar 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sQ86AXgy"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13915A85A;
	Wed, 19 Mar 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372792; cv=fail; b=NH/Fqwxr6FlM+qSFzMFdTK6OwXAHzp6NTc2jQFuudjmZhzrvzyOUqXv8C/WRimxX53dtXsSZs8ojYTmRmn9a7LAirWiIzNmNmkyg9I43sH3jwyJ4XiUMmS1ImHWquYDEFlAyN1MAlfd+1LlutqYaJj8YRAxhisfMMlenRP5Dgsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372792; c=relaxed/simple;
	bh=xL7EW6tNS6Luk1u5iwsL5vyPkCfMzDleQdUTFnB/zFs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LUHyO5yZ7HutThq5JYVzI376IKhOmmY6ppN0IFYgFDXFJcwQmpe71zOkAh8KYeHdqIYDuHwMBhSTZQPb0q3P99ykFgIAJNeapJhegWppyZ7VSP9q4ExpmQHlI89A+wQfWGz4oDjBrPNxUO16GqXnoPkiwhJJ+AiYU7gHhnGovvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sQ86AXgy; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYLU1Yh7SjZLRYonDe0u+e8c2YTjxJMhyDTdVOmYgRMgTSQ0H+o2qjlaN1HKL7/EfI1wvSVV76y2drQWZNsPiHT8xB3Eb3G0sQAV/Ept8jT+rHzdumy5X/cHTAtoDFexkf7aBeQBqO+5deSwGf4/jMf+3JSXGXEDwyYBMsTN/vW0+3DYpSy6owCXLumP6HfcqXZsdf+t2quejh5idUaKViwOKUBwvNn+mYDrY61W3siLW8gNhnHCAbfFX7vVDdThCx6Rl81npTzrcAuT3iyGJWiJoO8bC4UqOp8NlFmihFhEyOUrv15gCiEWj3ROlgqwmykOUWjtmyYbC4tb8+Vz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGw0r9zNwR5kVI9kfMqUheMbfUGBm95yisv6YC9MbDc=;
 b=H1ahmX7Lcf6QCypDH+Tdwm5T10bUEO9httiReaVm5RhilSp3sXg2a0z7bDj8RXNbQJ5z5k3mbtbwcyxPh2p4CyoFXJoQM6fJlsQmAhT/6pPI8iuqushCzHREp2ZqIS/PcMXWegqvSuyubm/upmBQUz3XysWfvuR2OxolYdakHRSsqko008ggCkmCzGifsNjOnvqObDGw1JIdRnQ+MZjZ0hWlgtb9VnlvzjRRAFkQj12KwQokhCpz0W+Dubinr7vKC1o+gJiPumvFlppyABSbL4xcAOzDp4g1wwR79RvFQ3eG0vv6QJ01tonYqqL/bpEj4E+f+XjJDRNDbFmVG4i4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGw0r9zNwR5kVI9kfMqUheMbfUGBm95yisv6YC9MbDc=;
 b=sQ86AXgyZyQLpBCLBwoqPZib8UgV47T0kHrmmhWfoeZvEzpK251zgVvrRHDqW7y7aegrYawtMS5Nar4HmxFF8UG2A6MLFE43+mbhEilpa2HUS9DRzG2Kg3g/ewLre0jqpzMscTiRSDILuAWV9UqoyfMgu1/BObMMppJM3t4p5RHdb1BWIPtKwxBFf+NHBmnajtTwx9fGsXaGRwyBAugr8qF/K1B7yNRruxFhKJljOACKP/hnpuRLuyVAvKpabXm3SyjUpch+PPrzePZLcMARTlEoISnVIO6Ni+KY+rJsohfidv6Gwg/6lh2221t5e8TbQPn5eujDNM76K1fbms8Kdg==
Received: from SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:293::17)
 by ME0P300MB1423.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:247::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 08:26:21 +0000
Received: from SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM
 ([fe80::c7a9:a687:779f:a9cc]) by SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM
 ([fe80::c7a9:a687:779f:a9cc%3]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 08:26:20 +0000
From: YAN KANG <kangyan91@outlook.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Simon Horman
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: general protection fault in llc_conn_state_process 
Thread-Topic: general protection fault in llc_conn_state_process 
Thread-Index: AQHbmKCYKRkPYFFaZkeMYG4Td4YUuA==
Date: Wed, 19 Mar 2025 08:26:20 +0000
Message-ID:
 <SY8P300MB04214534155F05358161B402A1D92@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY8P300MB0421:EE_|ME0P300MB1423:EE_
x-ms-office365-filtering-correlation-id: 1c2c3e9a-080d-4c47-f81a-08dd66bfba69
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799003|19110799003|8060799006|15080799006|7092599003|8062599003|461199028|102099032|440099028|3412199025|41001999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KGvOgJv1kej5aaBw6BSWaLAzrRPFtT4KAFkY+ScHrr/Bf03H78UWUrgSfj?=
 =?iso-8859-1?Q?EWd6t4ZXmkYxdzbLGiKJIbvPkYJ9DHveqjnGerFlL+T3X/MxYauUxIhCav?=
 =?iso-8859-1?Q?3yFw53fKeJGKoPRZK8DnRL8/dEwY30E6qXkGEITD7zTlhHQvWZj/byY0eb?=
 =?iso-8859-1?Q?lNOLkTYuukn0WphGu+k/mpPpGtxG58kKmdLkzkoNV3AcQSS0UuI9OlzNDg?=
 =?iso-8859-1?Q?6cfe4fvro43iUuggq8U5CIMLvOdaL4591ac0WO9IRhmkla3I2TwUwx0pnj?=
 =?iso-8859-1?Q?Fgm97us4CMysaCgViuHLiPj+/GZN8yMJpTnFMHxnPDu4ISdAS6v3k4SPac?=
 =?iso-8859-1?Q?j8gYY9l9eFzDAhCkMIEYxmqbVuBF5z3fAD1Aws40UMrPtBXmM4YPVilFg8?=
 =?iso-8859-1?Q?qT61mewZaIeHJ6XwXsxu9FMJHkBvBzabaFJaEiq6EYXAO51ghSM7VzoSvz?=
 =?iso-8859-1?Q?bV5FgKIXyttruaoMk7KBcG/Ymh85wSLFPlDWKzH1Hkb4fFyc/whFYjKNaj?=
 =?iso-8859-1?Q?Hwe+jldD+z3l5jR7zTZqtBMAhlfIB3QmpKZdA6M08NlC+5RZCCwRXdprqK?=
 =?iso-8859-1?Q?dPxLsjf/uDZnqv7yK1BfAyFWNNiD5kZaL/PyX2bBHqeWt6JykcobqtyHV2?=
 =?iso-8859-1?Q?WJSEGqCLQl0ADXg/BnzZpBEDPt2ii/b8jbABiWKj36iRbOOOxAZX1eHdVT?=
 =?iso-8859-1?Q?nD/r6Sx5nqmIsSn50u8yIVXN5ich02TgsklLDAL7Iuk8TWruzITwh3QBor?=
 =?iso-8859-1?Q?1B3KlTEVQugshi4FE4OcIfHcYKAdbMO3kVKgAq6UvYHsfMV1FOygRfkFA2?=
 =?iso-8859-1?Q?SgiTABu+Sv20egctbQUSNVePUIhgM7A3FwWP+muOpFWkcm0lgx/QKBJK/0?=
 =?iso-8859-1?Q?fMkeG6qYqk42VsQFcNwxlVQEHpbR+vSRxihjVjSkw9yUZLcTYyCxr9YdUA?=
 =?iso-8859-1?Q?TEtF0Sy0WtExz7o/ppHJolZAvdo7B7D1gxfAsBkUqeOLka11daQimIt6jO?=
 =?iso-8859-1?Q?MO0Z70fMVkmzxZTg4CD3GbSLjQe6Jl3ZfNitSpAv4lG4kdcNbZGS1obNqo?=
 =?iso-8859-1?Q?I2j+gzeor8uj5Ax4BJLB9vkRPmqgKcdanwuaJDvsDI7cZJq+/JY5BKLLlZ?=
 =?iso-8859-1?Q?j9RqVPfHD6gHYIK1JfphsSrhhCYedDM8JnaPyJ/ZfZbzfxMLfMPXuj/jdY?=
 =?iso-8859-1?Q?MrXHk+gTcyFrzcDv+l6Px6jCNQ10il+wobI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?X4iD5LTM86z79qk0eUEqcfip+/8XGh3zWwMh/W1RdDV+EPs1gbD9CesBpy?=
 =?iso-8859-1?Q?OMGAvPSsBo9EOnlgVPv+flKUbLKa23owx4nvTBXoZdPpbdTTuON7GLgDsL?=
 =?iso-8859-1?Q?Ssizr+cujZzEf5OLF2GlFvtAsFiHlV4It/reeHGyOcCo691y5whruNTeFj?=
 =?iso-8859-1?Q?4JIhWXvh1i/HuGvuCQscJ9tMNs7sHY6lpuvMpzwBMsykgfSgG229NDF8NW?=
 =?iso-8859-1?Q?/l+hKgvs/t9+H3FmdVS1hslH+4rmm2YheRaYMgIIxQAGgloADd4drs98mZ?=
 =?iso-8859-1?Q?s1Y4ulWF2R+4F7lUrfXOpVAkhkkm7yW2lEzUHZzsdz/3G1wzgsxUv8+nWz?=
 =?iso-8859-1?Q?UCD2X1zrkmjAgiYRiWddhsVoBPe/hAK/xgelKue914XBmQ/qEfZPnhfecz?=
 =?iso-8859-1?Q?6MwN9IWsRb6u8MJj45X9xD6ElQQay95rBXhEA97glZCKZ7MKbazlx5YmWi?=
 =?iso-8859-1?Q?lFEoc5KNiU3UYH8ys8AbjHcAPlr3PkE6jEv8JCcZ352sXgl31bANld4d2e?=
 =?iso-8859-1?Q?qxBYYTmir3pFU8CvdlGNFcss1lbmtL6zsomeeADY4g6cZbfn4EzhRN5hSi?=
 =?iso-8859-1?Q?5ZsBABKpjmAVXbpVExNH7JZKXMuXYD92YWtEYCGtipmlcrnVWWQX8V2c1F?=
 =?iso-8859-1?Q?HQY626/m7gcxdfFkxM1cB20i8JyqKTy9UUVlpG0Os7OMnLn9DNKangXmNG?=
 =?iso-8859-1?Q?s4gildHm6G+C1PMxpz6rPeehqB6qg7QG/6uPs4kqttcDkU2IWcqU0gkfT9?=
 =?iso-8859-1?Q?AROQxhtvbsOC3LbvifpIgQIKJ5HM16fuKSITxtXEts6OGk7cVl/AZr+H+4?=
 =?iso-8859-1?Q?gmUvvgCygz9VGe2WMERvR4eKp/VImkp6g7zo0nrRFUZ9BAdpn5V3uAErz3?=
 =?iso-8859-1?Q?ucKNrKpYTaVXGrGkduIARMpHo+UMZvuY9iwJ375RofE/4nSV0GOE73rXpB?=
 =?iso-8859-1?Q?sDWxmVJRuSyZN9+dDz+fBGDqsF9IdnynTAnBSce/J9WVJWvD6cRKOrWXXW?=
 =?iso-8859-1?Q?gezD4Znkhqsgc8EqQ0Rl+veG81AxMyJhVIUVOFLHoa5++a7StIkUH294eb?=
 =?iso-8859-1?Q?lAkORA48JvLLIMZjk2oYbYHPdf+cHb30ysfWiHm4i3QuDVzpw2d1QAtW/Z?=
 =?iso-8859-1?Q?QB7eN96Ky9C2SjCePDKiCXev+YRkh1UlQOrWvU9Gcr2WmW+De5sM+DvTYR?=
 =?iso-8859-1?Q?q6FgFsHw/I76tlQtb28g+YGBkQGXJUEznn19yMs5Dww/THMPa/BOQzjO+T?=
 =?iso-8859-1?Q?h4sR6Ha8fVpd8qjw9GqENmreXZPyJPR5NnapayA4lE0PBWqpQIvli32tSb?=
 =?iso-8859-1?Q?txi92zIkHPuOKuSTTr+fCB9ZwS4kxr8SmZ4oYdpcnIGYWD0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2c3e9a-080d-4c47-f81a-08dd66bfba69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 08:26:20.8609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1423

Dear maintainers,=0A=
=0A=
I found a new kernel bug titiled "general protection fault in llc_conn_stat=
e_process" while using modified syzkaller fuzzing tool. I tested it on the =
Linux upstream version (6.13.0-rc7) . Although I don't have repro, the cras=
h log is sufficient to describe the cause of the bug.=0A=
=0A=
RootCause Analysis:=0A=
function llc_conn_state_process in /net/llc/llc_conn.c  =0A=
    	case LLC_CONN_PRIM:=0A=
		if (sk->sk_type =3D=3D SOCK_STREAM &&=0A=
		    sk->sk_state =3D=3D TCP_SYN_SENT) {=0A=
			if (ev->status) {=0A=
				sk->sk_socket->state =3D SS_UNCONNECTED; //crash, sk->sk_socket =3D=3D =
NULL=0A=
				sk->sk_state         =3D TCP_CLOSE;=0A=
			} else {=0A=
				sk->sk_socket->state =3D SS_CONNECTED;=0A=
				sk->sk_state         =3D TCP_ESTABLISHED;=0A=
			}=0A=
			sk->sk_state_change(sk);=0A=
		}=0A=
		break;=0A=
=0A=
Bug occurs:=0A=
=0A=
  Thread A                                                  Thread B=0A=
   ----------------------                         ----------------------=0A=
   call_timer_fn                                          sock_close=0A=
      - llc_conn_tmr_common_cb                    - llc_ui_release=0A=
          - llc_process_tmr_ev                                |- lock_sock=
=0A=
              -llc_conn_state_process                      |- release_sock=
=0A=
                   |                                                      |=
-sock_orphan(sk)=0A=
                   |                                                       =
         |-sk_set_socket(sk, NULL); [1]=0A=
                   case LLC_CONN_PRIM:=0A=
                       sk->sk_socket->state =3D SS_UNCONNECTED;    [2] cras=
h ,NPD!!=0A=
=0A=
Fix Suggestion:=0A=
Using lock_sock & release_sock in  case LLC_CONN_PRIM and putting sock_orph=
an in lock windows.=0A=
BTW: in case LLC_CONN_PRIM , Is it necessary to add sock_hold and sock_put?=
 =0A=
=0A=
=0A=
If you fix this issue, please add the following tag to the commit:=0A=
Reported-by: yan kang <kangyan91@outlook.com>=0A=
Reported-by: yue sun <samsun1006219@gmail.com>=0A=
=0A=
=0A=
I hope it helps.=0A=
Best regards=0A=
yan kang=0A=
=0A=
=0A=
Kernel crash log is below.=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Oops: general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI=0A=
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]=0A=
CPU: 1 UID: 0 PID: 27544 Comm: syz.7.2138 Not tainted 6.13.0-rc7-00006-g712=
2647c49bb-dirty #112=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:llc_conn_state_process+0x9f0/0x1870 net/llc/llc_conn.c:141=0A=
Code: 8b 98 b0 01 00 00 e8 0f f1 79 f8 40 84 ed 0f 84 b0 0b 00 00 e8 71 fb =
79 f8 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c=
0 74 08 3c 03 0f 8e 6a 0d 00 00 48 8b 44 24 08 c7=0A=
RSP: 0018:ffffc900001e8ca0 EFLAGS: 00010246=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff891f2831=0A=
RDX: 0000000000000000 RSI: ffffffff891f283f RDI: 0000000000000001=0A=
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1024df062a=0A=
R10: 0000000000000002 R11: 0000000000000000 R12: ffff888121e90600=0A=
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888126f83000=0A=
FS: =A00000000000000000(0000) GS:ffff888135e00000(0000) knlGS:0000000000000=
000=0A=
CS: =A00010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000000110c4052be CR3: 000000004f53a000 CR4: 0000000000752ef0=0A=
PKRU: 80000008=0A=
Call Trace:=0A=
 <IRQ>=0A=
 llc_process_tmr_ev net/llc/llc_c_ac.c:1445 [inline]=0A=
 llc_conn_tmr_common_cb+0x44e/0x8e0 net/llc/llc_c_ac.c:1331=0A=
 call_timer_fn+0x1a6/0x620 kernel/time/timer.c:1793=0A=
 expire_timers kernel/time/timer.c:1844 [inline]=0A=
 __run_timers+0x659/0x8f0 kernel/time/timer.c:2418=0A=
 __run_timer_base kernel/time/timer.c:2430 [inline]=0A=
 __run_timer_base kernel/time/timer.c:2422 [inline]=0A=
 run_timer_base+0xc5/0x120 kernel/time/timer.c:2439=0A=
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2449=0A=
 handle_softirqs+0x1bf/0x850 kernel/softirq.c:561=0A=
 do_softirq kernel/softirq.c:462 [inline]=0A=
 do_softirq+0xac/0xe0 kernel/softirq.c:449=0A=
 </IRQ>=0A=
 <TASK>=0A=
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:389=0A=
 sock_orphan include/net/sock.h:2029 [inline]=0A=
 llc_ui_release+0x411/0x8f0 net/llc/af_llc.c:229=0A=
 __sock_release+0xb0/0x270 net/socket.c:640=0A=
 sock_close+0x1c/0x30 net/socket.c:1408=0A=
 __fput+0x3f8/0xb40 fs/file_table.c:450=0A=
 task_work_run+0x169/0x260 kernel/task_work.c:239=0A=
 exit_task_work include/linux/task_work.h:43 [inline]=0A=
 do_exit+0xacc/0x2ce0 kernel/exit.c:938=0A=
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087=0A=
 get_signal+0x222c/0x2500 kernel/signal.c:3017=0A=
 arch_do_signal_or_restart+0x81/0x7d0 arch/x86/kernel/signal.c:337=0A=
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]=0A=
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]=0A=
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]=0A=
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218=0A=
 do_syscall_64+0xd8/0x250 arch/x86/entry/common.c:89=0A=
 entry_SYSCALL_64_after_hwframe+0x77/0x7f=0A=
RIP: 0033:0x7f189f5a6a2d=0A=
Code: Unable to access opcode bytes at 0x7f189f5a6a03.=0A=
RSP: 002b:00007f18a0330f98 EFLAGS: 00000246 ORIG_RAX: 000000000000002a=0A=
RAX: fffffffffffffe00 RBX: 00007f189f7b5fa0 RCX: 00007f189f5a6a2d=0A=
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000006=0A=
RBP: 00007f189f639f8e R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007f189f7b5fac R14: 00007f189f7b5fa0 R15: 00007f18a0311000=0A=
 </TASK>=0A=
Modules linked in:=0A=
hpet: Lost 3 RTC interrupts=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:llc_conn_state_process+0x9f0/0x1870 net/llc/llc_conn.c:141=0A=
Code: 8b 98 b0 01 00 00 e8 0f f1 79 f8 40 84 ed 0f 84 b0 0b 00 00 e8 71 fb =
79 f8 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c=
0 74 08 3c 03 0f 8e 6a 0d 00 00 48 8b 44 24 08 c7=0A=
RSP: 0018:ffffc900001e8ca0 EFLAGS: 00010246=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff891f2831=0A=
RDX: 0000000000000000 RSI: ffffffff891f283f RDI: 0000000000000001=0A=
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1024df062a=0A=
R10: 0000000000000002 R11: 0000000000000000 R12: ffff888121e90600=0A=
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888126f83000=0A=
FS: =A00000000000000000(0000) GS:ffff888135e00000(0000) knlGS:0000000000000=
000=0A=
CS: =A00010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000000110c4052be CR3: 000000004f53a000 CR4: 0000000000752ef0=0A=
PKRU: 80000008=0A=
----------------=0A=
Code disassembly (best guess):=0A=
 =A0 0:	8b 98 b0 01 00 00 =A0 =A0	mov =A0 =A00x1b0(%rax),%ebx=0A=
 =A0 6:	e8 0f f1 79 f8 =A0 =A0 =A0 	call =A0 0xf879f11a=0A=
 =A0 b:	40 84 ed =A0 =A0 =A0 =A0 =A0 =A0 	test =A0 %bpl,%bpl=0A=
 =A0 e:	0f 84 b0 0b 00 00 =A0 =A0	je =A0 =A0 0xbc4=0A=
 =A014:	e8 71 fb 79 f8 =A0 =A0 =A0 	call =A0 0xf879fb8a=0A=
 =A019:	48 89 da =A0 =A0 =A0 =A0 =A0 =A0 	mov =A0 =A0%rbx,%rdx=0A=
 =A01c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax=0A=
 =A023:	fc ff df=0A=
 =A026:	48 c1 ea 03 =A0 =A0 =A0 =A0 =A0	shr =A0 =A0$0x3,%rdx=0A=
* 2a:	0f b6 04 02 =A0 =A0 =A0 =A0 =A0	movzbl (%rdx,%rax,1),%eax <-- trappin=
g instruction=0A=
 =A02e:	84 c0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0	test =A0 %al,%al=0A=
 =A030:	74 08 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0	je =A0 =A0 0x3a=0A=
 =A032:	3c 03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0	cmp =A0 =A0$0x3,%al=0A=
 =A034:	0f 8e 6a 0d 00 00 =A0 =A0	jle =A0 =A00xda4=0A=
 =A03a:	48 8b 44 24 08 =A0 =A0 =A0 	mov =A0 =A00x8(%rsp),%rax=0A=
 =A03f:	c7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 	.byte 0xc7=0A=

