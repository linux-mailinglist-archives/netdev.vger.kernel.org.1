Return-Path: <netdev+bounces-88373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB088A6E8A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E77280D51
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67412CD91;
	Tue, 16 Apr 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="KM+dvJos";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="IT9oNyCB"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA412C7E1
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278317; cv=none; b=hdeFlCGEUae6RMLdNI+Xu0a7Um0gUQOiIRrrB5Lsr2fo42yltdgmNefdZ1n3CXmv+SDUEkDJ/+0D8G0BQuF5lTMDGGfV/T0stk0vc2dST9d/0crfKh8IA9Saqkyg+/JiqFMu8P0jEpdKbepqQs+QtAamaNHA8elQvCMgXeqbmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278317; c=relaxed/simple;
	bh=96hTXhnjz3+qC9NcBQKd1cwyF6KwBKsFOlcjKcmpKm0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Mn0BXYEbqhnjiSdDQfm4r0347GN09YCcuuAJRO9w6zvscZWQlYoEpMF+zF+pciDkFxELL66k0vnoNqpSAtnUaTvx4jdep30WF1reBn7Ot7+biPutOs3Fga2SMLjjH8Z0ti7zSlt20BapocZJkX0sDo56QDLDV5ItJFt6aja4df8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=KM+dvJos; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=IT9oNyCB reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713278311; x=1744814311;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=bRHMPFJkgj9s4CRZ0AbiPt43T8yGr3neVD8RYhzVyFo=;
  b=KM+dvJosOmmiPGhQqFFFeYKc3dUoXoaZQGQfD/XbOt4AAKvkhkURa4gX
   mQ3GXpsOaqXOHH1E1z2j4SS08SMgL0BJRcflXwJouT3SXSF8ffeCHGbK3
   4ChX27wzBoARjOHyskzNPBcP9plLHFptNC0TlQUn+4RyzUzJugNC//3kQ
   Pw9xWgMsila0fio5xQ7jlzGd6aDVjCdWboMwO42N80v6VY/clkCiu/V2/
   SwOgYUCNuEhOI2ayrdfv4VzxDUxqFZzw2I9KfsBcLid6YC0fXSSwCyb2Z
   deaPSrtSSIGf8lqF9QeSa5OuqEjR+01zGXjXI+5yBte9BTM7wFSLfUsJv
   A==;
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="36446808"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Apr 2024 16:38:22 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FA10161669;
	Tue, 16 Apr 2024 16:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713278297;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=bRHMPFJkgj9s4CRZ0AbiPt43T8yGr3neVD8RYhzVyFo=;
	b=IT9oNyCBUyBXYXGlQOpJ0DjFqGDQU4EnMc10LDXcFeUWZSHHPFW8XdYkfnlRvKHaDC0kqP
	HSanJ7r3I+yPHHXwCuZPtVduYZvDufsrOYbUKvkotPVdguo1CvrF3jhHdyh9nwhnVCBKb5
	yiF1osATblLN/nuZMVXI1lWN/p5AaInGaMha8Yq8U9BNc6YFbIL0hrveP1yKjTTPODgDwE
	l5dXeENlbxxQ7YFJdoxVw7uuvRDnC+3KyHvqbF46oeF3why6ViVcn0NsJySIMtCoTKK+WI
	/S5adm3LPoBJ/uEvfrtIvkZthwc3e0K0WD0SgZrHgyFsOo7XUB3CrmskxMuBGA==
Message-ID: <1f22520948180e55125fdc686a0de8a93c317e5f.camel@ew.tq-group.com>
Subject: Regression: Commit "net: dsa: mv88e6xxx: Avoid EEPROM timeout when
 EEPROM is absent" *causing* timeouts after kernel update
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Fabio Estevam <festevam@denx.de>, Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Michael Krummsdorf
	 <michael.krummsdorf@tq-group.com>, netdev@vger.kernel.org, 
	linux@ew.tq-group.com
Date: Tue, 16 Apr 2024 16:38:09 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

we are currently updating an i.MX8MN-based board from Linux 6.1.y to 6.6.26=
, and we are seeing a new
error message during the probe of an MV88E6020 switch:

[   11.330629] mv88e6085 30be0000.ethernet-1:10: switch 0x200 detected: Mar=
vell 88E6020, revision 5
[   11.395525] mv88e6085 30be0000.ethernet-1:10: Timeout while waiting for =
switch
[   11.496618] mv88e6085 30be0000.ethernet-1:10: Timeout while waiting for =
switch

As it turns out, these timeouts are caused by the two mv88e6xxx_g2_eeprom_w=
ait() calls introduced in
commit 6ccf50d4d474 ("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM=
 is absent"), and
reverting just that commit fixes the issue. Our board does not have an EEPR=
OM connected to the
switch.

I've added debug output to mv88e6xxx_g2_eeprom_wait() and found that the bu=
sy bit is 0 as expected,
but the running bit is stuck at 1 forever (even when I increase the timeout=
 to something excessive
like 1s).

Any suggestions what the best way to handle this is?

The 88E6520/6020 "Functional Spec" seems to suggest that the old behaviour =
(waiting for the EEInt
flag) is more appropriate on these models, but I guess we should only do th=
at *after* the hardware
reset, as something else may already have read and cleared the EEInt flag b=
efore the kernel probes
the switch otherwise... Maybe something can be done with an explicit EEPROM=
 reload (Global1 Control
register flag RL)?

Best regards,
Matthias


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

