Return-Path: <netdev+bounces-73910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4E85F3E5
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09890B26135
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875F3717A;
	Thu, 22 Feb 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="fkohUpNk"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB11B59E
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592687; cv=fail; b=EcPE0tbFjItoMCZEBoLPgwFjTO1FRuNhqW1lYvZO3IwOdsVtI8h8WS5atGo1CVrjPa7aUpjj7qLbC5+7+ZRskjkl07qhekF9Yo3wgIa2XgE8XfOpgAaaKGRd1pSTgBvImQdVmmH25FdeZkO8jdmoTzVMKvz7WJNjKWexvoeXOYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592687; c=relaxed/simple;
	bh=5dzK3SHIM8ncaz2GzLJSykiHvLKHuz3pOvAUqhI/nJM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TJ9ypoLvikAM3oTPgT3W4zti0SeGPCwAeq2M9LHzSrql2ycf1v4fL4+QvfYPNlrndJbxV5lTC6jPSRIlSNd8IDi3yYdLqvvguxR0w0YrSCcklK4KoKuGBfPE0y+2b+dam/OoiK6/Sn8k4q9otj0WctB+lDiDLgzyNfrDDD4h8XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=fkohUpNk; arc=fail smtp.client-ip=40.107.215.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnOboASEoMXVpBz+fIi04HLsMwCsRtv8wwPr3NsibypMoOHqi0RWIFrePhuYqy1Q1M1ij6NfB2JOWkAHkx1UOcT6R0q1Kuq3jGfLmRqt70E3JdjE4HkxPiQC9t9pMpQvJ0u5GsoQ7Y8mBQfJZKYXMz9Su7237P8YDNeZoHlKqnrX6ZXQLHhhDYuupzygmbvXRx83GHvn4kooZ3JRq+JOi2h1VkBmPdrkXx3ZEK+bMVzkFGoLi8TMo2jkaWjkse+ltpkzLW8gwKxzoiEzgno2GTrcY9DdwJWv/T92z3dVzVDPmKXblyzQFfLGFt1OBN5xZc4Z6uSFVhguk0ihfSDvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiiZOQY6MsYZe7B1ekYXeSxjsT5koXMHE1xQJjFyOUw=;
 b=GtkS4oHApzTNIjXwq4hXxoxPtuH9RDf9PLmSssldVzH56+SshgKGVHxwkhLxoON/qCeQhaTbJEY13DsIdtItVvEW0qAME3MASdMvz36BhzvbKPp5B0WS/56M2QrSywLX6Q5K+3g+LhmrVZGWZKoq/Xh/aAV+x3N14vqSOc91nKr03qaq2xsPtB+z+uYhnj2kSPpoxQjOT2taygTde2I5pdPmGBm3L8t6AXVHf41VeF4naV9tVaQsViMDV31/00XCByn3jnZLIgscaGDPUUQ2tMzWfhR+i1md+T217Ay/Tp8ZvRyJWqD11/V86qOhkxxhNO2cSNe6A9d/CM+pYHtarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiiZOQY6MsYZe7B1ekYXeSxjsT5koXMHE1xQJjFyOUw=;
 b=fkohUpNk6MpA2xAWgku3R0S3xXx6IaeKr7rJjzJDmAx+x7+eeOV02l78B/iRknoMWhg1vhaejJ58vo3iL+5qk9gBWCo7Zc5aAlolWFk5vV1SP8xgGUifRPingxIRdtZYIHL5oVTb4jzpQ76y0vzL+RCKKV/rvHtv5NJgkJtcWO34MQBa2WOmktOFIxQs5rpXuSQEulKGHeJaW7G8ptc1FMxDN5qlIMULIL0YdUXuM9Tq14JtgsM54gSUxgS/2a96rGskxXQomTiorBuEiQpZBnsu1fPx1CM3ClT7k5ckwEmhfCHUlBjE/mvHw3XV2fuiKK/NLlmKkufmY87GjaG2Ww==
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com (2603:1096:4:14d::9) by
 SEZPR04MB5947.apcprd04.prod.outlook.com (2603:1096:101:66::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Thu, 22 Feb 2024 09:04:36 +0000
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5]) by SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5%7]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 09:04:36 +0000
From: =?iso-2022-jp?B?Sm9uZXMgU3l1ZSAbJEJpLVhnPSEbKEI=?= <jonessyue@qnap.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
  __agg_has_partner
Thread-Topic: [PATCH net-next] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
  __agg_has_partner
Thread-Index: AQHaZWtNDF12TJHYYEeyVWmKAhc8pw==
Date: Thu, 22 Feb 2024 09:04:36 +0000
Message-ID:
 <SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@SI2PR04MB5097.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5097:EE_|SEZPR04MB5947:EE_
x-ms-office365-filtering-correlation-id: a7bc9e10-1419-4c0a-a21c-08dc33854b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0Hc0xf3AxIVaey4Xvwtcy1pYUHfhiYxF3OSAjQUsk1amtLBbb7Fdms85/uSWEmselUQpIKWBtKb4ocpOrvQMrrty9yYe+TNlpjfHPyK/Sos6nS0qwIsyidH/L4WAhYBU6I+Yzu00D1jDwpnlC+dQq3stGxU2ACvbiNaAcRg7CgVYBkp8a/KTGHpJp+UBSpMKwZgsyg9pGcgWKcZSMUUlj4WupJrfdycnSoDowm4jetBaXtm9pyXhwshHNAnulL6xyjp3eiK/uAyKh1Jju3mpPgua7EQyzF9tQFyP6FzDeboWSSDVa1WEHyqjr40awJ+yQ6HAyQ2ukl/urO1dz3gXgTGDQuJI+1zw8YLW9f+mFwKfbhBRrcA6mK+cPEY8wPpflDwXu5h4UbBqKYpqW33uQHBduzZldvZwiGpX7pZYHnVROoA/Y//YbkonHEXyB4WGijuj/qYRB7KTpmxORISL6VTHeKpit2NTnV5lAzhyl22MO7o0+1tBEDtFw2rYuD/StwhgfOGjmev7vMfWpNikiu5LI2Iw53J7B7c4chlX1XpoKIjeBoRLXeVzt7XSqOzKXAFa2kVviicZo6HETNOjhntizCv0W3IgrXK2PxIEBeTwpLpLvEHfi1m+YrjCgt/7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5097.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NnpEREpuSGhSYzR4VzlNVXJJL1RyL2RxUWFUSnI0cFpOUzJHb2MySVZv?=
 =?iso-2022-jp?B?V2V5OXVEUFl1ZUhpd2o3Yk9IYTZDTHQ4YXhJaDMxeThPc2hCNnN1ZFc5?=
 =?iso-2022-jp?B?RVhvN3ArcTZmSG16TVcxWXdMVkxoak50SmsxOS81QWdMYUcxQVVFYkxs?=
 =?iso-2022-jp?B?RXdKa2tyekRWc1J2VUxqUmJvT1pxQitnZWpYcXIyMXdlVDlTckNFaHZN?=
 =?iso-2022-jp?B?RG56eUdONnZCUERwYS81RHBWdU9qeTVkNUdGUlpnMWVSNllFbXdxQzYv?=
 =?iso-2022-jp?B?VlZ5V015c25YLzJWUmpnUWdPSUptZklzRXFQVFNXYjFoaUFpenZqck5Q?=
 =?iso-2022-jp?B?WUE4d0V2R0ozeGZnY0ljK1I3bE1QN1Erck50L2VZMlgrazJJTEpwT3RD?=
 =?iso-2022-jp?B?RDI0T1pORFhuSzZpb1p6cURMN2FGMU5URHVSM3F6ZmQ0ZmRkbmNScjE3?=
 =?iso-2022-jp?B?cG1lUTlHOXY2L0JKRmtVRkdGN1JZOFFvQkdXQ1R4NVVjTTVqcXFYdTNt?=
 =?iso-2022-jp?B?R3FzcTRXbjBIMjZ4UWlCLzBJV1k1V2dwMk9PMDZuV2I0VFFUOWlwNmJE?=
 =?iso-2022-jp?B?bVdEL3BMVVdsNXAyZmNPc056MTN0cUdiTTQ5WHpzeGN2Q1hRK2I4eXJH?=
 =?iso-2022-jp?B?enBoQ2NSWjVzSlNTTkN3ekQyYTlhb1V5RERpQU9nbWlSQmJKYmFvRWVj?=
 =?iso-2022-jp?B?MkN6RDdoc3M3SFlhZXRHRERvTUI3N0ZFeU96dHB4bnlNL01XL0ZKVzhz?=
 =?iso-2022-jp?B?enljS0VJbW91YUpwaGRpNHZja3pZMVVtQXBYU09Tbzk4WWNaVmlNT0VY?=
 =?iso-2022-jp?B?aXU4dVBEajBaS003VWlLYUx5dzVsaTM2V1E2dmp5M1ZMZmE1SnhyTm5Y?=
 =?iso-2022-jp?B?bmFQRFliVU9LT0tqdVlQV1VtQWw1TWRVcHlqWHIya2p0TWZ2d0JVVFNm?=
 =?iso-2022-jp?B?ZFNlMzZtOWNlWVBiUzFQZUFzWklRMXgvNkV1TjhZZlIvcVlRclM4eDI1?=
 =?iso-2022-jp?B?ZFoxNUpORi9QbXZsWFBRRCtQUmcvQnl2a3FnUmE1dGtCMjRjMzV3Q0lY?=
 =?iso-2022-jp?B?aGNoRVplYjljWi85QnREYWF1a1hKK3lRQnR1eUNwVHVBMTlFQUtkUDZF?=
 =?iso-2022-jp?B?NnYwcHFaaGMwV0NxOFliR3lCUDh3ZGl1cWsveEEybkk3N1JiaEY3eE9m?=
 =?iso-2022-jp?B?NTExdGhHUi81REMzcEU2cnJ2TUxHOHZCRFBtR2o0NGp1QXd4bk9xSUFH?=
 =?iso-2022-jp?B?a1RvSnN4S0NiYzdRbWtoVU43NmdpUzBYdk9uQS9QeDRONTBrNk81S1FZ?=
 =?iso-2022-jp?B?VGdob2J1b2FSdTI3VGo4Z1VkM1A3OEhSSmg1bXR1TkNQSnd3dXYvMjhF?=
 =?iso-2022-jp?B?ak9yQnE3OFNzbUxNODRiZjd5RFBzRnJPWUd2MTRpQnd6QldudjBoWnRD?=
 =?iso-2022-jp?B?Sk0wWjEwMW9Nd2h0S0p3eW1NMnF5NkRjMkpSSnB1QXBtNmJIY3R6RnJn?=
 =?iso-2022-jp?B?UjM2K0lYR1JLQklHaDJhZGI4eEd1eEJwQmZLY1dDZlJldVhPUWNBMWlU?=
 =?iso-2022-jp?B?VmxhQnQ3M2grRlc5M28weWE0WWUrcmhoUUVLL2NqaFE4K0NGUWZKZUtK?=
 =?iso-2022-jp?B?Uit2U1ZnV0lQdnFJbnhtUEVMVS9zRUszQmt3bGRuMEtuT24wdjh0TUll?=
 =?iso-2022-jp?B?ODFhdHdVbytsajl3ZDdaUDFnMVp5Y3FSR3h4RUlGb1RUdlVMTWY2YWxW?=
 =?iso-2022-jp?B?Skx2WlgzWXRXcnNUUXRmdnRtTXNZb3A0U0ZUNmY0WGVkVTVMWUVGakhY?=
 =?iso-2022-jp?B?MUFLK3NpSnZ6WEhhUXpSNkdXWDgxcUJQMmhCdVBJS3FoREZxTzFKNzI1?=
 =?iso-2022-jp?B?R0ZQQkYzdUI4ZEtreVAwdEtMWlpGSmlsdmtOTWpmOC9EVkp3Y3k0dGta?=
 =?iso-2022-jp?B?enhURjdpRmJRY21jeFExbFN4UERPWHdyZVE2MVpXaWZtY09lMjRlbTQ5?=
 =?iso-2022-jp?B?K1NjNjdBdDR0RitkQU10QTJOck0zUTVLNjBSMkN1QzMzYy9tczF1b3JD?=
 =?iso-2022-jp?B?ek1JQmtTZlVNVjdzM3pHejIzNmc3UHV4VGhiWG1NWlN0SzA5Y2s3ZWp6?=
 =?iso-2022-jp?B?Uis1Mlh4RksrTUlaT3YvTWt1QzZpc0hFVmlDdjJnTGJINXdrbWFCSEw3?=
 =?iso-2022-jp?B?TGdacVdNbVVqRGZFMWpKOXR6RldqVFd3NmFES1VkMTJIbjBzK3E5SEk3?=
 =?iso-2022-jp?B?RzVFK3QwTDhjSzFtall5MnlSQmZNY1pFaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5097.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bc9e10-1419-4c0a-a21c-08dc33854b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 09:04:36.7983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMtI9zH1Sl+fElv67p2tBNk3yzrY/ZWhanvqcjDvO5xsKamrYJXMsA0yri1yG/j2XCwt1ZAGf8LDdVJhpy4fDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5947

=0A=
They are verifying the same thing: if aggregator has a partner or not.=0A=
Replaces macro with inline function would look more clear to understand.=0A=
=0A=
Signed-off-by: Jones Syue <jonessyue@qnap.com>=0A=
---=0A=
 drivers/net/bonding/bond_3ad.c | 8 ++------=0A=
 1 file changed, 2 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.=
c=0A=
index f2942e8..eb3c2d1 100644=0A=
--- a/drivers/net/bonding/bond_3ad.c=0A=
+++ b/drivers/net/bonding/bond_3ad.c=0A=
@@ -2036,9 +2036,7 @@ static void ad_enable_collecting(struct port *port)=
=0A=
  */=0A=
 static void ad_disable_distributing(struct port *port, bool *update_slave_=
arr)=0A=
 {=0A=
-	if (port->aggregator &&=0A=
-	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,=0A=
-			       &(null_mac_addr))) {=0A=
+	if (port->aggregator && __agg_has_partner(port->aggregator)) {=0A=
 		slave_dbg(port->slave->bond->dev, port->slave->dev,=0A=
 			  "Disabling distributing on port %d (LAG %d)\n",=0A=
 			  port->actor_port_number,=0A=
@@ -2078,9 +2076,7 @@ static void ad_enable_collecting_distributing(struct =
port *port,=0A=
 static void ad_disable_collecting_distributing(struct port *port,=0A=
 					       bool *update_slave_arr)=0A=
 {=0A=
-	if (port->aggregator &&=0A=
-	    !MAC_ADDRESS_EQUAL(&(port->aggregator->partner_system),=0A=
-			       &(null_mac_addr))) {=0A=
+	if (port->aggregator && __agg_has_partner(port->aggregator)) {=0A=
 		slave_dbg(port->slave->bond->dev, port->slave->dev,=0A=
 			  "Disabling port %d (LAG %d)\n",=0A=
 			  port->actor_port_number,=0A=
-- =0A=
2.1.4=0A=

