Return-Path: <netdev+bounces-104671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D790DF16
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470111F233F3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470FF176FC5;
	Tue, 18 Jun 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=questertangent.com header.i=@questertangent.com header.b="ApEL/fnl"
X-Original-To: netdev@vger.kernel.org
Received: from mail.questertangent.com (mail.questertangent.com [66.183.165.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7A55E58
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.183.165.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718749451; cv=none; b=J0gWW6FOH3R3GuyMjZ1tEMqGJboagIvxeiaK1r/I14KzcoH/45pABrKLqDfpPkM+SqxAGG8jSQPUnGXYxnAIOXCXp3TtL03/N70wxo5N4RYisTLurDi2eHxu/azpuZ2ze9a5ez0v115FFZgcVTwiSB4gvicMUOjs1GeA/aCjwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718749451; c=relaxed/simple;
	bh=jxYGm7o5gw1oW4E33/AZ+pIh8J0cfPfmK77Ynjs6E8U=;
	h=From:To:Subject:Date:Message-ID:Mime-Version:Content-Type; b=C7hpNgTGnutlAYjT7yTaHMz/ygu4nbimVfanL6Pb4o2Q7es1DqaPG8XcVHXRogBjWAX62HagwIyj8C5Anq5EGpDwhQ8DnsJBM32wBsAhs4t31hMQEzySFRej8RCnNB3NXuYIymAfGA6ymPnTFzSHxtLIAMJHZHryG1BSv1BcsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=questertangent.com; spf=pass smtp.mailfrom=questertangent.com; dkim=pass (1024-bit key) header.d=questertangent.com header.i=@questertangent.com header.b=ApEL/fnl; arc=none smtp.client-ip=66.183.165.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=questertangent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=questertangent.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=questertangent.com; s=mail;
	h=From:From:To:CC:Subject:Date:Message-Id:Content-Type:Received:Received:Received;
	bh=jxYGm7o5gw1oW4E33/AZ+pIh8J0cfPfmK77Ynjs6E8U=;
	b=ApEL/fnlzPure3GViNqiczCqFm6uv9CAqto13qrpDB70cO2gfqTQag8gwfiwWdDWabMG/P6FTEakX/O6v173h3IpXIVdS3FrbYkLCnhKx+qpltrHbqOmsT4WbVCMyn++qhUMSUnXAHLMfCD10xwu6yKY44hKoA3AG+t1vO+tWJo=;
Received: from Charlie.questercorp.local ([192.168.0.16])
	by mail.questertangent.com
	over TLS secured channel (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	with XWall v3.58 ;
	Tue, 18 Jun 2024 15:24:08 -0700
Received: from Charlie.questercorp.local (192.168.0.16) by
 Charlie.questercorp.local (192.168.0.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 18 Jun 2024 15:24:08 -0700
Received: from Charlie.questercorp.local ([fe80::68fc:5b30:7b2d:12fd]) by
 Charlie.questercorp.local ([fe80::68fc:5b30:7b2d:12fd%4]) with mapi id
 15.01.2242.012; Tue, 18 Jun 2024 15:24:08 -0700
Thread-Topic: dsa: mv88e6xxx maps all VLANs to the same FID
Thread-Index: AdrBzjOGP697USYbSWy1pPiG62r14w==
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
From: Peter Rashleigh <prashleigh@questertangent.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: dsa: mv88e6xxx maps all VLANs to the same FID
Date: Tue, 18 Jun 2024 15:24:08 -0700
X-Assembled-By: XWall v3.58
Message-ID: <b22a2986512849b7887943e5850fa03b@questertangent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

I've discovered what suspect to be a bug in the mv88e6xxx driver. I'm curiou=
s if anyone else has run into this behavior and might be able to suggest a w=
ay forward (or can tell me what I'm doing wrong).

I'm developing a custom networking product that has three Marvell 88E6361 sw=
itches connected via DSA to a Marvell CPU running on a custom buildroot Linu=
x (version 6.1.53) like this:
[CPU]---[Switch 0]---[Switch 1]---[Switch 2]

The product uses a mix of bridged and standalone ports, spread across the th=
ree switches.

The problem I'm having is that all VLANs (both for bridged and standalone po=
rts) are using the same FID. I've found that mv88e6xxx_atu_new() always sets=
 FID=3D0 even if there are already standalone ports or other VLANs using tha=
t FID. The problem seems to be with the getNext operation called from mv88e6=
xxx_vtu_walk().

The VTU Walk function sets VID=3D0xfff and then runs mv88e6xxx_g1_vtu_getnex=
t(), but the switch does not respond as expected. Instead of returning the l=
owest valid VID, the register value (Global 1 reg 0x06) is 0x2fff, suggestin=
g that the switch has reached the end of the second VTU page rather than sta=
rting from zero. This seems to conflict with what the Marvell datasheet desc=
ribes, but I haven't come up with a better explanation so far.

Any suggestions are greatly appreciated.

________________________________

This transmission is confidential and intended solely for the addressee and =
for its intended purpose. If you are not the intended recipient, please imme=
diately inform the sender and delete the message and any attachments from yo=
ur system. Please note that any views or opinions presented in this email ar=
e solely those of the author and do not necessarily represent those of QTC. =
No employee or agent is authorised to conclude any binding agreement on beha=
lf of QTC with another party by email without express written confirmation b=
y an officer of the company. The organization accepts no liability for any d=
amage arising out of transmission failures, viruses, external influence, del=
ays and the like.

