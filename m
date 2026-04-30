Return-Path: <netdev+bounces-282690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDKPLOkL82mSwwEAu9opvQ
	(envelope-from <netdev+bounces-282690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:59:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C949EFDA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78E3C3007B2D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8C3FB055;
	Thu, 30 Apr 2026 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="NqAPLnZz"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F103FA5FA
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535938; cv=fail; b=gJPOoDOUhabAsmo6fUVSj+aLYSoZI+dFKuOD+LvMak1Y1Q/mQgevDjxTOLqVMimBbgYFDGyDI6Oer0hiHITSUB74M0hsoguQbRmYQ61X+cXepahDkfZ20UtD0yxhZ+OSTiu/lBD4E+gIf4cOkmpjc4w38C9D9Jpvr/9/tehRM20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535938; c=relaxed/simple;
	bh=B74dXMqSws6PGf1GFw1ovRdz5Dzmr6FOygrfVCojCtY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dn8epZrwQTohQgxNURTjnx6zanRT/SlyrSAlRTkouQ2DX4+2VjHn52IEcTx9Ar0VEz+kigaexaon9sDK0dzBf1V+ILe6fc5nCAIizVJh8tk5tNKHxPMzT+7F01eOFahSD9C3curSPgWdUqHbHu5i79wogvL6kKbeJpY1k/a02ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=NqAPLnZz; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTfjJ0LXoHVE/89EskVTVOVmWHY3AfEWZliRcq096EcASCpwOcADz/tzTPxrdDLXMP6/vG7sUfpjWymnn7Eg6CXv6Ck6/ltctDHN8hknlfCpxcZ93IfUbDQc+xEkVlq4PhQlFpmcNdox64YlPfTfa0p4AhpD/1Cy1Df4CD4rKGnM9UH2URUSYDluoVAmKAsTQL5oBjTpnJ3MWPUqQONtVVK5hhpS7+5ZdFTFfXWcH8MKf2Vx32RS6UUagL0rXmEEPDXe5WR6x6NtLLi5FW/qQXTBST2o25vJMGdZLg4zab58+0TQmLP35eWYleSqoELsgshqA6C2JZt8t9jDsa0VTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/8lx8jS+Gb+Jn/6glIXlGnysme/I9z8oJzRHEGDTGk=;
 b=P0zJ2IKLA/gEGX2jyHuejTtEwujaqGPuuxpPXD2P9XRUS2qU3DQK1M5GtPHlv0Q75vaQlCAE0fQY7BxMQB/h0pcqXLr63Qzhk6GIlvmBErwCAK2skhGxxlBg1lhOLEer0k7ujy8lQ5gdycjMdzAXYFKat+XYKf1TI9YORJnU1T/y7Igse7dpoNpy3cJYcYY7cM4R1QEdBj7SYnYZFJoKZi5+7A6OLsaQWsU/q0scIxEPway1zriATTHq8NujDzKYliiZ8fc/ZGIKkovJEO1jvXHp9k+wKZ0hbcdJH6L8wEa5f1wZwXwaRxdqQExDNzhx6XzpcZZeO3ac7zKCNx2NJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=l3harris.com smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/8lx8jS+Gb+Jn/6glIXlGnysme/I9z8oJzRHEGDTGk=;
 b=NqAPLnZzG8dawoJdGH23oermCSX7ATz1C2lcI67thx8cw7TFwanvdbR9uzUrtt0ejJDjpIhnaSgeyy6XqZ50lP/mAePAnYhfWsJT56dvSB4CdjrgM+i7rfxPTYLD75GBEE7jg4xCkUkoycOUvk5IkjS3nWIKrkvz9WucMhnoajw=
Received: from AS4P250CA0007.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::11)
 by GV2PR03MB8749.eurprd03.prod.outlook.com (2603:10a6:150:ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 07:58:46 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::1c) by AS4P250CA0007.outlook.office365.com
 (2603:10a6:20b:5df::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 07:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 07:58:45 +0000
Received: from n9w6sw14.localnet (10.10.8.26) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Apr
 2026 09:58:45 +0200
From: Christian Eggers <ceggers@arri.de>
To: <matt.becker@l3harris.com>, <Brian.Hutchinson@l3harris.com>
CC: <arun.ramadoss@microchip.com>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: Attempting Yocto Scarthgap prototype using
 0001-net-dsa-microchip-ksz9477-add-E2E-support.patch
Date: Thu, 30 Apr 2026 09:58:45 +0200
Message-ID: <10847188.nUPlyArG6x@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <BN1P110MB057898FE6C49EDDB74498DD3C334A@BN1P110MB0578.NAMP110.PROD.OUTLOOK.COM>
References: <BN1P110MB05785DBEC19BE8B70CAF5E2CC35AA@BN1P110MB0578.NAMP110.PROD.OUTLOOK.COM>
 <BN1P110MB0578F752C4DBA7B602F7661DC323A@BN1P110MB0578.NAMP110.PROD.OUTLOOK.COM>
 <BN1P110MB057898FE6C49EDDB74498DD3C334A@BN1P110MB0578.NAMP110.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2353589.iZASKD2KPV"
Content-Transfer-Encoding: 7Bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|GV2PR03MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abe8dde-0ea0-4864-24d9-08dea68e4e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|6049299003|376014|36860700016|4053099003|4013099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xGrmmsNT5TcE7qHsMzPU+BYlcOtl9uTOWtX/atiTcXmIFtns3uKGn/5w2HViXxcJzFPMpw12pRXJ+519mnqkE5KKUuDJjczDjRE2Vi6hd6sIkc4/mHg4z+x7+Zm3QIRnWQoFYPE0VX08A8xqWC+WKXH4Ath73RRQzkOJpjJE+EKUe6243C0lPUYNJIxw31w7XR/o00jrRv7ZSAQ/67e/8fJ2jNOQHiP9rT+/YFzPmC5JeyXaKZxBEjwMOIJ2ueLlgipgWX9I9DqqKeZsNPKMWfbmkh0DarGNyTFtwnZl73Un/bO+5ifgka4j4LbyUKAU/Zl86O+FUEc+DV58Yzc7j9gSwBGwy4hTvf62MrFoaklolWBkU7zGEXav9TEjK3nEmaNAW7u0sJtHTtO2MoWOIFSA/CjjWN8adoS6r9nw7lUvViN3tjumjC3tKYFJlrOOACHqhd2E2JbzsOtyXJJ8hRYZSPjnSepoVOvBFt5Yr0KKJ/lS8SKfZouR6lNIkFDXFo+Cl5sc98xR+yeuKdvlPoAKLODnqdFhKW2J+mvrfwcm6UHf4FaQqVoBhLq71Jd18PfQDb4rlg4QhgsILFlMgy7iWT5xqpQSQZGR68CJ6Fx/qMuunsekIU7lX+emBxVRW9VDpqnBn8TgTzgmjWFf6oFzNo9486FTnb9k1dtrdhE0dZMaMkZkDCqrrqP8Axle4uH7gXONr43kKY5VI9lzRY6dlmWxSli2jXKTBmgghyoTecF3Iz0VWfbDQ3sMAm4S9zt6Tl4ydTjuEL51JFKc/A==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(6049299003)(376014)(36860700016)(4053099003)(4013099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RqgKi4L1QkFG1XwhERKiFUfTXO/lmRzeGmgiEfvjsp7dysB4gWCm37mrIh/9exWAU8CqQT4DQxy0RilojBS2IPc9RhWmR1x0hL2pMZDHUVERutf+U0R6t4X4NC/HQYcB0qFJbwRS76eatEvT3cVewC4Kr+e/IulT1r7c5qU8nk8CErmxLWUNow6NRzJIEdSAUqUJmzXGi3/If+iLOSTlpSTOyKunb+oCCIusAvUL5H+t9z9Srrvtmph7nfnU69nxa3f5f02ok/Ktw9kkNs1NUkxkBKQVA55wavV0rShhseqfVR6YX4LsfkocppeWEGeRVQDzaEej3U1tYeNmzJs6tkW5z6dM29J9Ub6B9VWlpn+SvmNXHi+M5RUC8qO+Fhy4jdcLyzrJYjvSLsfbL4JMChlrK3Ffx/YK1lWF2XkKnmy1Z0+1FaElgYYeqrhIN8Pa
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:58:45.9574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abe8dde-0ea0-4864-24d9-08dea68e4e28
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8749
X-Rspamd-Queue-Id: B81C949EFDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	INTRODUCTION(2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arri.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arri.de:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282690-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,l3harris.com:email];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[arri.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ceggers@arri.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

--nextPart2353589.iZASKD2KPV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

CC: UNGLinuxDriver@microchip.com
CC: netdev@vger.kernel.org

Hi Matt, hi Brian,

although I did the initial development of the KSZ PTP patches, this never w=
ent
into our final products.  Because of this, I am quite happy that Arun from=
=20
Microchip took over this and made several improvements.

The E2E patch was originally rejected (AFAIR), because the KSZ applies
(unwanted) filtering on the PTP messages.  For E2E this means, that the
KSZ hardware filter needs to "know" whether this node is currently master or
slave clock.  As there is no (and probably never will be) interface between
ptp4l and the kernel for communicating the current master/slave state, there
was no interest in merging this.

As we do not use PTP in our current software, I have only forward ported
the patch(es) for being compile clean (see attachment).  But I haven't done
any real tests with newer kernels / ptp4l versions.

Unfortunately I will not be able to spent any time on this for the next
3 weeks.  If the problem still persists then, I can try to have a look on
this.  If you find the solution yourself, I would be happy getting an
update on this.

regards,
Christian

On Wednesday, 29 April 2026, 21:27:12 CEST, matt.becker@L3Harris.com wrote:
> Christian/Arun,
>=20
> My name is Matt Becker. I work with Brian Hutchinson at L3Harris.
>=20
> A few years back we received & applied patches (net-dsa-microchip-ptp*) f=
rom Christian for our embedded board (imx8mm Arm processor + KSZ Microchip =
part). At the time these patches were developed for Yocto Dunfell (3.1) + L=
inux Kernel 5.10.69 + linuxptp-2.0 .
>=20
> We followed up and reapplied these patches with success on the same board=
 when we upgraded to Yocto Kirkstone (4.0.x) + Linux Kernel 6.1.38 + linuxp=
tp-3.1.1.
>=20
> We=E2=80=99re now attempting to bring this same board up to the most rece=
nt Yocto LTS release (Scarthgap 5.0.16) + Linux Kernel 6.6.50 + linuxptp-4.=
1 . This is where we=E2=80=99re running into some difficulty.
>=20
> It looks like most of the patches from a few years back were already merg=
ed back to the 6.6 kernel level. I only had to re-apply the patch  0001-net=
=2Ddsa-microchip-ksz9477-add-E2E-support.patch as this was not merged back.=
 It seems this change alone might not be sufficient. Our Scarthgap board is=
 now able to select a grandmaster clock and it is able to receive adjustmen=
ts. However, the master_offset values are very large, and PTP never converg=
es.
>=20
> My suspicion is that I may need other changes to make this work on this n=
ew OS/kernel/PTP configuration.
>=20
> I was wondering if you might be able to offer any guidance:
>=20
>   *   Have you ever tried bringing this functionality (net-dsa-microchip-=
ksz9477-add-E2E-support) forward to a newer Linux kernel and/or PTP?
>   *   If so, do you have any unofficial patches we might be able to try?
>   *   If not, do you have any other advice on a path forward (e.g. change=
s that might be necessary outside of the original patches)?
>=20
> I attached an email thread with myself & Brian that has a little bit more=
 detail.
>=20
> If you have any ideas or help you can offer it would be greatly appreciat=
ed!
>=20
> Sincerely,
>=20
> -Matt Becker
>=20
> matt.becker@L3Harris.com<mailto:matt.becker@L3Harris.com>
> (585) 369-1184
>=20
>  =20
>=20
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient and may contain material that is proprietary, =
confidential, privileged or otherwise legally protected or restricted under=
 applicable government laws. Any review, disclosure, distributing or other =
use without expressed permission of the sender is strictly prohibited. If y=
ou are not the intended recipient, please contact the sender and delete all=
 copies without reading, printing, or saving.
>=20
>=20


--nextPart2353589.iZASKD2KPV
Content-Disposition: attachment;
	filename="0a4fdb38cfe8eec90a2149cf529da4da7a1f6d25.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8";
	name="0a4fdb38cfe8eec90a2149cf529da4da7a1f6d25.patch"

From 0a4fdb38cfe8eec90a2149cf529da4da7a1f6d25 Mon Sep 17 00:00:00 2001
From: Christian Eggers <ceggers@arri.de>
Date: Tue, 12 Sep 2023 18:39:54 +0200
Subject: [PATCH] net: dsa: microchip: ksz9477: add E2E support

Requires manual switching between master and slave mode via sysfs
attribute.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 164 ++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 7ef5fac69657f..81b386b8ebece 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/ptp_classify.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/sysfs.h>
 
 #include "ksz_common.h"
 #include "ksz_ptp.h"
@@ -383,16 +384,19 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 		prt->hwts_rx_en = true;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 		prt->hwts_rx_en = true;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		prt->hwts_rx_en = true;
 		break;
@@ -526,6 +530,7 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 		if (prt->tstamp_config.tx_type == HWTSTAMP_TX_ONESTEP_P2P)
 			return;
 		break;
+	case PTP_MSGTYPE_DELAY_REQ:
 	case PTP_MSGTYPE_PDELAY_REQ:
 		break;
 	case PTP_MSGTYPE_PDELAY_RESP:
@@ -900,6 +905,155 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
 	return 0;
 }
 
+
+/* device attributes */
+
+enum ksz9477_ptp_tcmode {
+	KSZ9477_PTP_TCMODE_E2E,
+	KSZ9477_PTP_TCMODE_P2P,
+};
+
+static int ksz9477_ptp_tcmode_get(struct ksz_device *dev, enum ksz9477_ptp_tcmode *tcmode)
+{
+	u16 data;
+	int ret;
+
+	ret = ksz_read16(dev, REG_PTP_MSG_CONF1, &data);
+	if (ret)
+		return ret;
+
+	*tcmode = (data & PTP_TC_P2P) ? KSZ9477_PTP_TCMODE_P2P : KSZ9477_PTP_TCMODE_E2E;
+
+	return 0;
+}
+
+static int ksz9477_ptp_tcmode_set(struct ksz_device *dev,
+				  enum ksz9477_ptp_tcmode tcmode)
+{
+	u16 data;
+	int ret;
+
+	ret = ksz_read16(dev, REG_PTP_MSG_CONF1, &data);
+	if (ret)
+		return ret;
+
+	if (tcmode == KSZ9477_PTP_TCMODE_P2P)
+		data |= PTP_TC_P2P;
+	else
+		data &= ~PTP_TC_P2P;
+
+	return ksz_write16(dev, REG_PTP_MSG_CONF1, data);
+}
+
+static ssize_t tcmode_show(struct device *dev, struct device_attribute *attr __always_unused,
+			   char *buf)
+{
+	struct ksz_device *ksz = dev_get_drvdata(dev);
+	enum ksz9477_ptp_tcmode tcmode;
+	int ret = ksz9477_ptp_tcmode_get(ksz, &tcmode);
+
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%s\n", tcmode == KSZ9477_PTP_TCMODE_P2P ? "P2P" : "E2E");
+}
+
+static ssize_t tcmode_store(struct device *dev, struct device_attribute *attr __always_unused,
+			    char const *buf, size_t count)
+{
+	struct ksz_device *ksz = dev_get_drvdata(dev);
+	int ret;
+
+	if (strcasecmp(buf, "E2E") == 0)
+		ret = ksz9477_ptp_tcmode_set(ksz, KSZ9477_PTP_TCMODE_E2E);
+	else if (strcasecmp(buf, "P2P") == 0)
+		ret = ksz9477_ptp_tcmode_set(ksz, KSZ9477_PTP_TCMODE_P2P);
+	else
+		return -EINVAL;
+
+	return ret ? ret : (ssize_t)count;
+}
+
+static DEVICE_ATTR_RW(tcmode);
+
+enum ksz9477_ptp_ocmode {
+	KSZ9477_PTP_OCMODE_SLAVE,
+	KSZ9477_PTP_OCMODE_MASTER,
+};
+
+static int ksz9477_ptp_ocmode_get(struct ksz_device *dev, enum ksz9477_ptp_ocmode *ocmode)
+{
+	u16 data;
+	int ret;
+
+	ret = ksz_read16(dev, REG_PTP_MSG_CONF1, &data);
+	if (ret)
+		return ret;
+
+	*ocmode = (data & PTP_MASTER) ? KSZ9477_PTP_OCMODE_MASTER : KSZ9477_PTP_OCMODE_SLAVE;
+
+	return 0;
+}
+
+static int ksz9477_ptp_ocmode_set(struct ksz_device *dev,
+				  enum ksz9477_ptp_ocmode ocmode)
+{
+	u16 data;
+	int ret;
+
+	ret = ksz_read16(dev, REG_PTP_MSG_CONF1, &data);
+	if (ret)
+		return ret;
+
+	if (ocmode == KSZ9477_PTP_OCMODE_MASTER)
+		data |= PTP_MASTER;
+	else
+		data &= ~PTP_MASTER;
+
+	return ksz_write16(dev, REG_PTP_MSG_CONF1, data);
+}
+
+static ssize_t ocmode_show(struct device *dev, struct device_attribute *attr __always_unused,
+			   char *buf)
+{
+	struct ksz_device *ksz = dev_get_drvdata(dev);
+	enum ksz9477_ptp_ocmode ocmode;
+	int ret = ksz9477_ptp_ocmode_get(ksz, &ocmode);
+
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%s\n", ocmode == KSZ9477_PTP_OCMODE_MASTER ? "master" : "slave");
+}
+
+static ssize_t ocmode_store(struct device *dev, struct device_attribute *attr __always_unused,
+			    char const *buf, size_t count)
+{
+	struct ksz_device *ksz = dev_get_drvdata(dev);
+	int ret;
+
+	if (strcasecmp(buf, "master") == 0)
+		ret = ksz9477_ptp_ocmode_set(ksz, KSZ9477_PTP_OCMODE_MASTER);
+	else if (strcasecmp(buf, "slave") == 0)
+		ret = ksz9477_ptp_ocmode_set(ksz, KSZ9477_PTP_OCMODE_SLAVE);
+	else
+		return -EINVAL;
+
+	return ret ? ret : (ssize_t)count;
+}
+
+static DEVICE_ATTR_RW(ocmode);
+
+static struct attribute *ksz9477_ptp_attrs[] = {
+	&dev_attr_tcmode.attr,
+	&dev_attr_ocmode.attr,
+	NULL,
+};
+
+static struct attribute_group ksz9477_ptp_attrgrp = {
+	.attrs = ksz9477_ptp_attrs,
+};
+
 int ksz_ptp_clock_register(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -951,7 +1105,16 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	if (IS_ERR_OR_NULL(ptp_data->clock))
 		return PTR_ERR(ptp_data->clock);
 
+	/* Init attributes */
+	ret = sysfs_create_group(&dev->dev->kobj, &ksz9477_ptp_attrgrp);
+	if (ret)
+		goto error_unregister_clock;
+
 	return 0;
+
+error_unregister_clock:
+	ptp_clock_unregister(ptp_data->clock);
+	return ret;
 }
 
 void ksz_ptp_clock_unregister(struct dsa_switch *ds)
@@ -959,6 +1122,7 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 	struct ksz_ptp_data *ptp_data;
 
+	sysfs_remove_group(&dev->dev->kobj, &ksz9477_ptp_attrgrp);
 	ptp_data = &dev->ptp_data;
 
 	if (ptp_data->clock)
-- 
GitLab


--nextPart2353589.iZASKD2KPV--

