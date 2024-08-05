Return-Path: <netdev+bounces-115868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16FA9481DF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577E31F21567
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26315F3F8;
	Mon,  5 Aug 2024 18:42:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [24.116.100.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB115A874
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.116.100.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883352; cv=none; b=BRpY9TqiBYZVU/eqMi+nMLHE5GyJiIC/j10YfpaOKkAfJ/GjLUzl6ydiFXTbstCd1oHKCW0UxZDHkswmY7sQKXYq/9IaQaUWWAPvkyL+ixu30WzvRl8s+70ipQ4Fdv0BWHEzCRzSWFn9WDsPoLiozmthsQHrv+K7UEm6vmC0Nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883352; c=relaxed/simple;
	bh=0jO9N31rcLhmvb7pRmrv3GHU6IFZPiaNIXWzruWUEfc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=rFzJRn30QltAqnIa2CkLan6lTkkfhvF99gd+oMd1Yl9Yyl3lpYQG5Wc/AT1i34bUjM7xfQ9vTQ1cbYMUrN1+f/8tKm7b5Q7sPJUF0mVx3Izb5Vt6aEs6lTP+2GyYYX4XSzAv4Ch2s5L+FjwRVwBdv5nSGqQpjjlUJgnJFxAvRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com; spf=pass smtp.mailfrom=redfish-solutions.com; arc=none smtp.client-ip=24.116.100.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redfish-solutions.com
Received: from smtpclient.apple (Macmini2-6.redfish-solutions.com [192.168.8.9])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.17.2/8.16.1) with ESMTPSA id 475IgU1U311658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 5 Aug 2024 12:42:30 -0600
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: TAP programming and "br_xxx: received packet on br_xxx_tap0 with own
 address as source address"
Message-Id: <629C1F6C-152A-4BFC-8A07-9F4E5B439325@redfish-solutions.com>
Date: Mon, 5 Aug 2024 12:42:20 -0600
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)
X-Scanned-By: MIMEDefang 3.4.1 on 192.168.8.3

Hi,

I=E2=80=99m working on an L3 (non-IP) tunneling protocol that then emits =
the decapsulated payload with L2 wrappers.

I=E2=80=99ve got a TAP interface on a bridge with an Ethernet interface =
also bound to it [the bridge].

My question is, which address to source the L2 packets out I=E2=80=99m =
sending?  Do I use the Ethernet interface=E2=80=99s address, the =
bridge=E2=80=99s address, or the TAP interface=E2=80=99s address?

I=E2=80=99ve tried the latter two and in both cases I get some variation =
of:

br_xxx: received packet on br_xxx_tap0 with own address as source =
address (addr:xx:xx:xx:xx:xx, vlan:0)

What is the expected (correct) address to use in this paradigm?

Looking at br_fdb_update() it looks like I can=E2=80=99t use *any* local =
address, because they=E2=80=99ll all have BR_FDB_LOCAL set, won=E2=80=99t =
they?  Maybe I=E2=80=99m reading this wrong.

I=E2=80=99m using an embedded Linux distro that=E2=80=99s still at =
5.15.19 so it would need to be applicable to that version.

Thanks,

-Philip


