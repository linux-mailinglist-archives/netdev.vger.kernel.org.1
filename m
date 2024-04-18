Return-Path: <netdev+bounces-89389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE448AA2B4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415191C20DB2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE217AD9E;
	Thu, 18 Apr 2024 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Hx+ihtG1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E617AD92
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468424; cv=fail; b=Sz+fLrj1hSKBuD1n3iDJvi9fBgytmuOSiVcpvezKh7b+BYlsPlg7WCw6CIGHKjiVdtE0yGwCxDntToL69vkKmV2mXbTpbT1KRrL87V/EW5s/Z3c88X0Ckhp0cRPnN73xwPzlr0OEcLfG2GspOu78JaTJjPkkiOxZDSYpAvFLDHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468424; c=relaxed/simple;
	bh=hu+t62gGpV8+e7usHD58lazpP2apbpYeolYcV+tDkec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhpdFBw4cER38zhtE8pwLJ7anTM+P6sccw6L0wHVd9MNzRznsu3gqxn9+oBNmdWzo8mcrNoGG6krAZqk0VuCd8NR5l8xilSW4TX1OdENEadfhih1rauJZj/pASr4GDr3NJhhj03IsSfXJnSWb7oUZfTJEO+gH0+U8IlYRg5zaa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Hx+ihtG1; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43IGWb3I028328;
	Thu, 18 Apr 2024 19:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Lp4XETDFoxWMQl5pwQF2/IZ67gGi53SDmqJ6WOMb3nk=;
 b=Hx+ihtG1tOQshfrp4KCX/GnYad8ntapbwRY5rc+uqXjnsN1R1/b76QOM62ZonqnQYBu+
 PiwCVF88i3bI095zi/p5LPxgVLvI5e2QemiDLJQ6vO12rzeTkS7V2phDGrJPh/b4Pk1W
 s87BSlHDxoYykqbZzT5aVhi5cC5kCe83JciYfp54Q7QVpEJ3RXGmhFCLtfqL2R7v26qp
 DRZ5yhq8GYqIMkH9GJou0rlovWLKdu2+3Znom2Q35ZztoZv6lKoQEFtfxIEdDSZ5YYnr
 o9A/Z8tt2YCjT2pKQBda5syZHkCzeu3nzRg4NrfHU865FUnYQAjPaJt9u25OdguS5GUe Fw== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3xjqfnra30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 19:26:55 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A12F812E9F;
	Thu, 18 Apr 2024 19:26:54 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 Apr 2024 07:26:54 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 18 Apr 2024 07:26:54 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 Apr 2024 07:26:53 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZd/RopLNZZYHFBklbJg6+dGIvqIsfoMR+ZcWeu5YsXQXh5cUdnJEyC7bvbOWfrqr/FSFZA+BCtmJWu7/MGHo6snkNelOIWD/tKA440GDZUpcsYHcpPw34Zq6UWOamRltWgKOntUI1Zvr6W+PQWxakd5tP+pVEtoNGKx6Lp22LjUW/SZ/XtSOvlNDpf5NTvyJvDF4rQ5PTPOIcML06omv13NhViJH5Z5oMZ3auSaB4gCSjnhAUWKYDrl+Psig+e6RCn1QEoo4i6A6kf9pWibVBZD3F3GAe03QY194ZcyW3aisFLivjdXBnr+6GYrpeuQOfUOzGqKLFQuewVn+Mjmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp4XETDFoxWMQl5pwQF2/IZ67gGi53SDmqJ6WOMb3nk=;
 b=m4iJO7KCyGbnZnOAyEL9/cJJAnbSybzsc1zMV3uuFDOc+qYvzI+Svc7jAEXsCpUC27Nrj4JoqstwQyVABkH5Hma96XDm0PV94cuc2ADfrSQVt7u+jemIy7fb0DFdccFGjYkVHYqqikSxZdKBCtoKbWloKokrG2mUYDsgeNOygCr6W8YtQvcwJaf0pymaVt4i2Se33EAVwBHgPNeFhKKwMJZdYIslf49BLTdfeKtBkzLVYIbdd54dCbblcMh4AmuU6htrFOhyq2gqRQN8dtxR78rNLTk9meSs9KpeEEkV1OJYIC7XFQTDxV2rYu9S8aB1XN6Q1hOy6/eSM9E3kEnK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:84::11) by
 MW5PR84MB1963.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 19:26:51 +0000
Received: from DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ef0c:b3ba:2742:2d90]) by DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ef0c:b3ba:2742:2d90%4]) with mapi id 15.20.7472.025; Thu, 18 Apr 2024
 19:26:51 +0000
From: "Tom, Deepak Abraham" <deepak-abraham.tom@hpe.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: 2nd RTM_NEWLINK notification with operstate down is always 1
 second delayed
Thread-Topic: 2nd RTM_NEWLINK notification with operstate down is always 1
 second delayed
Thread-Index: AdqQ7cAMWV93xDQiR2asZ6QhL+IuJQAKZGIAACtltAA=
Date: Thu, 18 Apr 2024 19:26:51 +0000
Message-ID: <DS7PR84MB3039BEC88FB54C62BD107CF6D70E2@DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM>
References: <DS7PR84MB303940368E1CC7CE98A49E96D70F2@DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM>
 <20240417153350.629168f8@hermes.local>
In-Reply-To: <20240417153350.629168f8@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR84MB3039:EE_|MW5PR84MB1963:EE_
x-ms-office365-filtering-correlation-id: 5d23b6d0-bf46-43fd-9aee-08dc5fdd7f9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+uLkCvhHmRrZTZCheg25TsmRK+cVw3wPZKnry9KviF3yUc3kphJLwRnaEskaq+jqGtWhkEbjBQAwdaPUuDpA60oI/79nnoSyBmiSsS6gBqD3p0o8sh8WQynL13UUeea9xjNSXHk1TZ8nIyduoYMRtcIAPnAVxfCMGEP+DokH1E+RUTPWd0j7S+6ZkvYM1abt/NjA+DC7AhoJzUep75wexfnPXEF/AHAhzuzu8n6H7k558TL7GTJjvALEWkIr/ds4bCmDNq62wG8V+aLfkQqlPPhIc39bBhf/Uf96QQ3sj/3j+hIce7haXiKFwzZF1uMX+nj8ztycNmTauaz71JCv/9OcN9y9PJH54iZ35Hx+zfC2H/O617+O9I8VP8OKL+TiIjK5TiSzHREc1uMWN5VSPV7xp4PrTXbdB8s+kdP9s1157OdxcE33wIC/YWS53m/WUk1Nrdia+mPfZtlptkalZ1edzYCBAhLk2oRN+Gg/l5KdCwXcyO5FubjiAkKIUBRX2uV740d65KhiUWNASuAULRwBZsI+x86/S0HkT5IPDJVu7vzrsFW1tN0jWWNXCkLabr1HeLD8S66ZtNuhwu6wmwb8frWLH2BfWhtIi/r9QOrrGRi1EP832UWKbJe3C+mpjO/sSWjMI5K1SBSo/GC9GaRmDv44EJ/0s/1BVNlxerfD0FuwbutPc/VP4WHAgGtaZ1irqbJcSsK87HIOib+Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SpRRJ8Onq1ICMXIRAvnV2sd5PVnOraXEYIIvIojmjcjDPhUT0JkpC6QQTQs+?=
 =?us-ascii?Q?WqfiIJpM4QE03k767gfrGezmDczPAFwzD4w93NFyRWztRgaLUalOFzWjOy2B?=
 =?us-ascii?Q?CtIJSvdipIEG2qeLXmRzaQBPDaKE+I4p9cb3+xiy1m10LYIsswuNBuH1KFwH?=
 =?us-ascii?Q?OtLpfWIifrSk+jSEE3dBKmuPkWJUD50C+os6ERzoYcrmYCR7hEPDhmFuNRpb?=
 =?us-ascii?Q?NSd5XjqY2mz2Vg5Dze12/HD8Pgs1JSKue8vs+ubEzm+4uNMklqjJggoORn8E?=
 =?us-ascii?Q?KMc7/ddhjMonP29Nt8/7MAV6vGUAEDqpdlEZ4Y8YMv4X59OT1MWgWjvxSHq4?=
 =?us-ascii?Q?9heVpLWjwB0YMSvlASJAEtYmFYPqPSbyHWDNy0p5DynoAniRlt5JpzNVT3xZ?=
 =?us-ascii?Q?SUas6/3itSDXJD7sRiLJX5Qr6iN94Gsi54l0th/doQ2xCnKYcbGwiHMhoVLh?=
 =?us-ascii?Q?KkOipOwpQev2cfYdCMmzB+EeKL/39CVZdp4zi9uv5xOsBeZkltBOQlwIyjvl?=
 =?us-ascii?Q?Brpd87v8Utc1SXjgz5K/sVcq6e36bi/wc9hZ8UHQeX2BYz1mD4F2OYSWWF8e?=
 =?us-ascii?Q?CQtsRuaeTjfliqKKdq6w5ucQgcivbXuZCkcdwzPRCl6OF57EvDJTvsestzi4?=
 =?us-ascii?Q?IknJfl/2YwjGmORGTlXDmL8NZT63A5Mg0QKe5RnDS6oQaSBjY0R7xQO6iFKT?=
 =?us-ascii?Q?8xvrqVCqJXNifMFvKPfhQcIT3/fDdjBHrf5JFzJEZzHbXYgaOI3pHodyr8hD?=
 =?us-ascii?Q?Nfp69X5OC5dxGSfBC3zbvEAhPZnKnC2hlbkKmRnndoAEIIAmF+ajRt8xj5iG?=
 =?us-ascii?Q?aiXPQ0NdsZXESECSDlP+FwzCWxWIC3INCS3W8SQ94jG/hYmmx5f7+LW3tagl?=
 =?us-ascii?Q?ww3m40N3M9KqXo0e6fVqQl6VFq90cnfQKKAz8n1Y6t+gn+7yrnvZjFUN0zij?=
 =?us-ascii?Q?tr+RQKGLY3oAYFemnGpExfEy0ikwv36AbUAMwF8iXHqQWzJUCgTWty3hFRpE?=
 =?us-ascii?Q?11cPNWO0pZ5F+w4JUxqL1vzDA96blHorh0vFGkoUGNp/q1oaFdD8ntjapvNF?=
 =?us-ascii?Q?Hb0mgfy5segN3c4BlJc82AfaaLNQ8WdpojS8UZK1WThO5z2Rab+C+1TcMoA9?=
 =?us-ascii?Q?L1w0EhMvyBIxL5SrvaYtji12V0BFpT2MukEPnOO+c0XFh0KOviPKe5Vpjxns?=
 =?us-ascii?Q?0eKUTKOqRAVCRLR1BYTJSScRrKxvGeUCd01OdC7j4KGCvT3JRV/W6eD9wYTj?=
 =?us-ascii?Q?bS6d73RaDlJ/CadAxxLkcB9IeUXr8XIWufs6j9fiixSKqaNTT6qrhbVecGxl?=
 =?us-ascii?Q?Ne5LgP20TNdJ0S2L6BibxSseUCfMGAzN6V9pZQ4iZv55IhJpIphY3sAhdOG3?=
 =?us-ascii?Q?z3O4s1ICtCFNOgi32EZG2nvJtaN3SQYBHrZiFxPlum2sZXEGX4LI7FqI7Zwi?=
 =?us-ascii?Q?OmokouLV/afk8Y5qf6XUOtk83Kgjj8o/hPpDCw4UXgmcTfRdV8pmliZgN5Ro?=
 =?us-ascii?Q?QlbW1PIcvNXf2zzwmZXv+/RtbdnVqQklTAAfN354x1j8aVn/v5JW02U67HtC?=
 =?us-ascii?Q?dhojdm6T3zlfTU+t8jalNZz6rxQhuJ0nrO5Vo7Uj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d23b6d0-bf46-43fd-9aee-08dc5fdd7f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 19:26:51.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxSEzudYP8WAsbD1+itvquIHd7uofW14A+OpmuqrcTLJdCWHC7Z0tUMi9BU09+X72bh8rUtSL6X/w8ngTrPa4qMHEne/ysWDi8cQkMqj1zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1963
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 9qPPkxIuW8c4bOVwrULW9-pLz05sk0Sd
X-Proofpoint-GUID: 9qPPkxIuW8c4bOVwrULW9-pLz05sk0Sd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_17,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=904 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180140

Maybe I'm missing something, but could you please explain how this really h=
elps to not keep FRR busy?
If I understood this right, the link watch code does not ignore events but =
merely delays them. So any link transition will be propagated whether its s=
cheduled urgently or not urgently.
So FRR will have to still deal with each transition keeping it busy with or=
 without this change, unless FRR dampens flaps on its own?

Also from a design perspective, would it be better if FRR's issues with rou=
te flaps be dealt directly in FRR code itself? That way, in use cases where=
 FRR does not come in to play, such a delay is not causing other consequenc=
es? Are there more such situations where such a delay is absolutely require=
d?

Thank You,
Deepak Abraham Tom

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>=20
Sent: Wednesday, April 17, 2024 4:34 PM
To: Tom, Deepak Abraham <deepak-abraham.tom@hpe.com>
Cc: netdev@vger.kernel.org
Subject: Re: 2nd RTM_NEWLINK notification with operstate down is always 1 s=
econd delayed

On Wed, 17 Apr 2024 17:37:40 +0000
"Tom, Deepak Abraham" <deepak-abraham.tom@hpe.com> wrote:

> Hi!
>=20
> I have a system configured with 2 physical eth interfaces connected to a =
switch.
> When I reboot the switch, I see that the userspace RTM_NEWLINK notificati=
ons for the interfaces are always 1 second apart although both links actual=
ly go down almost simultaneously!
> The subsequent RTM_NEWLINK notifications when the switch comes back up ar=
e however only delayed by a few microseconds between each other, which is a=
s expected.
>=20
> Turns out this delay is intentionally introudced by the linux kernel netw=
orking code in net/core/link_watch.c, last modified 17 years ago in commit =
294cc44:
>          /*
>           * Limit the number of linkwatch events to one
>           * per second so that a runaway driver does not
>           * cause a storm of messages on the netlink
>           * socket.  This limit does not apply to up events
>           * while the device qdisc is down.
>           */
>=20
>=20
> On modern high performance systems, limiting the number of down events to=
 just one per second have far reaching consequences.
> I was wondering if it would be advisable to reduce this delay to somethin=
g smaller, say 5ms (so 5ms+scheduling delay practically):

The reason is that for systems that are connected to the Internet with rout=
ing daemons the impact of link state change is huge. A single link transist=
ion may keep FRR (nee Quagga) busy for a several seconds as it linearly eva=
luates 3 Million route entries. Maybe more recent versions of FRR got smart=
er. This is also to avoid routing daemon propagating lots of changes a.k.a =
route flap.

