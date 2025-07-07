Return-Path: <netdev+bounces-204496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E904AFAE80
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83C47A8E86
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656F9286420;
	Mon,  7 Jul 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4SMkM+vp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovS+C/Dp"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39782797BE;
	Mon,  7 Jul 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876426; cv=none; b=Iv06gR5JDeNrWZ2C9Cq5FopNiKVSSVv3IlE6Bqt6xQPgtEFNvttw9efMb+4mJqlWWUdpvmI+Hhl23gTU5cFstfMQ0qmFrvsA9sozar+XMJY4ZZqQy8xX53svT51J2gejc8Tmcpy2xSuZMZpDzfpc5lUbJ1dVAnHJwKS47iCutvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876426; c=relaxed/simple;
	bh=PVP9P0dw8wxt1bP0c78vvn95h6iB5pgs++Ty2SeIgII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ELk+Mp30jZ2xVV3gX75nb0cU6K9daDkWBOJvuc9j0seU1bmpOqMgLEDuFaGaDxwiX7bMiCzT/dzXLR854rT5PT1r/wkf6IanrxlCpRDB47u99HrDqn0MVjeQOrUB5kQxQhosakS6+ljIy73FM5YsuCaFCChHYy+OVOKsX6V7iiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4SMkM+vp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovS+C/Dp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751876422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tdeuuuv5RzshX51gqQXTodCPiOmRUkc2JHQIhxwgmjk=;
	b=4SMkM+vp09HiBPhsXVFawL2eXfJFIL7NEcMG7F9DVjlmRr7bl1F1MnUKuV12Ve//Rq4nlc
	XCtrcC9qonMdAx2GP4msyOTah7GarjCylS0YxJE9K4fNZIc1npDtNmKvcP1Zibu1WkojDF
	6hB6St20GsvspPLtnAMDB4hTCDIh1BwQQjkKBZiAXy3AYapjaa/h/E1i895EE5/usobSXd
	Yb8teRLv9Mg0ERVrs4RXFnjoBJnW7IHnMmToZmqn33O4ZOAmg8NzqBOuZ9smxTyTIYXTuj
	zrzAlsU0Tk9X+PBwZdnz+UrQNZODv/BkP1ZdjweI/YW/CWTTpheXVtMGHBu80w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751876422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tdeuuuv5RzshX51gqQXTodCPiOmRUkc2JHQIhxwgmjk=;
	b=ovS+C/Dp0JAN5lInXc9Ffh6BfI4issn8g/D+0btxN5YcDDuDSqzmXj5R9pQt/tqcZ34ERP
	ByqR8Af5rfZfhsCg==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Kelley <mhklinux@outlook.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH for-netdev v2 0/2] PCI: hv: MSI parent domain conversion
Date: Mon,  7 Jul 2025 10:20:14 +0200
Message-Id: <cover.1751875853.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series originally belongs to a bigger series sent to PCI tree:
https://lore.kernel.org/linux-pci/024f0122314198fe0a42fef01af53e8953a687ec.=
1750858083.git.namcao@linutronix.de/

However, during review, we noticed that the patch conflicts with another
patch in netdev tree:
https://lore.kernel.org/netdev/1749651015-9668-1-git-send-email-shradhagupt=
a@linux.microsoft.com/

As this series has no dependency with the rest of the series, we think it
is best to split out this one and send it to netdev, to avoid conflict
resolution headache later on.

Can netdev maintainers please pick it up?

Best regards,
Nam

Nam Cao (2):
  irqdomain: Export irq_domain_free_irqs_top()
  PCI: hv: Switch to msi_create_parent_irq_domain()

 drivers/pci/Kconfig                 |   1 +
 drivers/pci/controller/pci-hyperv.c | 111 +++++++++++++++++++++-------
 kernel/irq/irqdomain.c              |   1 +
 3 files changed, 85 insertions(+), 28 deletions(-)

--=20
2.39.5


