Return-Path: <netdev+bounces-166954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B49A381BE
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099C07A3B87
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A3218AD2;
	Mon, 17 Feb 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U9//xUlT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNEERyUV"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02C218AB3
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791892; cv=none; b=VNvg2c/ZriiykhxhyIUY59Yae/19DtkGsqy8kz8bTQupdwiToI57gYNDnvulzKSsB8ORq9srSGmSx32mzYxWc0LSKNSaL9CFxMODSI3d2AfvnDQbqsDaSqmOmG+dgL9g9fKPP8YgEF4seGmJsUrlQmxg3pYkCCeTY26lDJX13hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791892; c=relaxed/simple;
	bh=rfeGsFA8Y1AGZV6BheQkFnS99s84MAbp5CZXXbJOP2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aRgEVyuk4PUVQ+GnoXtDxsCflPidYHo1KzmKflQE52+rXQYk0gnVIiyM2SxA/NJEUzRi7e/H2W6sP5VcUFVjspP8BtToDXrm2IuyNaPeK06lzRgtJWGSPNlR0sBLWzz/rUWSoGGZMHcYsl9CwM1h8E9a3O2L3uAjWT0ZZrHLQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U9//xUlT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNEERyUV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739791889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=skZjnxzf254qvqb2PN3O3vf3KobgIyRtyxWiiP82TmQ=;
	b=U9//xUlTWYUDheBTHlh/hkD+q3RiCuC7EypbUvWw4QZQ9iRFO0Sty+U4tFj1rHkeOprHx9
	Xl6E/VdEAODnZvM2cH8lBOAzjLNnYK5AQZJjahPIArX/pj6qwuj93WKYBHblp60xTgtmAX
	cPDTI6FVlEn9rCMaIQjGWNL5hPrqThhD+BF7pUXdti3K/TlCL8jfULz1Pfxyew9GTAt0B4
	Sa8YaJAr+HyVkG14u44EVqPGI3AucS9xl/UnVhzAPQU/kMp54sfmWWgeFH33IZ3Dlj350B
	kQ1RffwLOMczsAYBNsBwXcdBE/LuwrO8QJ+r7uiWBRHZP6Wb7JTW/QyVBryCQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739791889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=skZjnxzf254qvqb2PN3O3vf3KobgIyRtyxWiiP82TmQ=;
	b=rNEERyUV+H3AQ9DM7XBj0TmCR1ogSUI6FOH4J1n7rJhdvh8485p2bpNi7MiYguIW2Tz0mK
	IDW60A1wFhciJOAw==
Subject: [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
Date: Mon, 17 Feb 2025 12:31:20 +0100
Message-Id: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkes2cC/z2N0QqCQBBFf0XmuY1x0aye+o+QcJ1ZHZDVds0M8
 d9bNujxcC7nbhDYCwe4Zht4XiTI6CLoQwZt37iOlVBk0KhL1HhS0pmH+KeyZVNQQWw0VhDXk2c
 rayrdQd6DcrzOUEfTS5hH/0kXS578r5bjv7bkCpUhxurckrmQvQ3iXrMfnaxHYqj3ff8CnYYMR
 KwAAAA=
X-Change-ID: 20250206-igb_irq-f5a4d4deb207
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=rfeGsFA8Y1AGZV6BheQkFnS99s84MAbp5CZXXbJOP2k=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnsx4OgMEBr+GGjPf1Frgiv5FMDzDDsl46Ievri
 6eLbRF7HsSJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ7MeDgAKCRDBk9HyqkZz
 gqh5EACJ68/Zi7N6WJetEjLQapT9LS4+I9K9SVXouh+UPVS3stj0D30RTMxwfYNWvLBYextSYd/
 kN96dT2CQlmc2n8uopEiawQ+Ha2YTAT01BdD7O/pJQuC20I3D9AfvVp2lCf5npf+61q4FF36HAl
 3rvJik6CAib1AMRYqzUkyvl5wz0BCuCsQEtkbQ/wBjt5oVCQoqZzj76tT6oCUnvZwubtoXaxAR0
 GaNqrfeqDVKA92ZeM75MhqjqOPmxBgAnWwfEIBj2vqK/HND7nZ4ySxSBpi7kcPxIzQ0PJTu3/BM
 h14E1Kjrj4C/gt3MpkScp9lw5FWYEO9QEsrBx0/fkJx7Yzcualcss2S2Ie/AjBTGg4dA7x4+RGh
 gEno3oWzZ+/PhxbSFKQd7LpbG6mgNzuU71wg8gpLM8bTa0vdgPq6nH1XUctVZDjnlP7Gp6aG9ow
 25/O6w/Q9F+QDuwffhWb030XhjWk/z3/ZNJw6a+xUffOYMJ1Esa2gL2Qu5XY8sLSRUxNXDidRK6
 Gk1r8fFUJwZPFNcfD7YbNtFxqHsxGtjC1hovCi1j8hYiSIGhXeXzviQPBh0gJAIPDB4Vh9r8j/i
 EmolxSq8C00iu6yq1oQeAptkkeXQh5dfsFucJZGY0KZqVo+6se5tseHH9XwhkZC3rt3YKUgtYcT
 QZIsMgtaGJlSIVQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

This is a follow up for the igb XDP/ZC implementation. The first two 
patches link the IRQs and queues to NAPI instances. This is required to 
bring back the XDP/ZC busy polling support. The last patch removes 
undesired IRQs (injected via igb watchdog) while busy polling with 
napi_defer_hard_irqs and gro_flush_timeout set.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v2:
- Take RTNL lock in PCI error handlers (Joe)
- Fix typo in commit message (Gerhard)
- Use netif_napi_add_config() (Joe)
- Link to v1: https://lore.kernel.org/r/20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de

---
Kurt Kanzenbach (4):
      igb: Link IRQs to NAPI instances
      igb: Link queues to NAPI instances
      igb: Add support for persistent NAPI config
      igb: Get rid of spurious interrupts

 drivers/net/ethernet/intel/igb/igb.h      |  5 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 78 +++++++++++++++++++++++++++----
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  3 ++
 3 files changed, 75 insertions(+), 11 deletions(-)
---
base-commit: 0784d83df3bfc977c13252a0599be924f0afa68d
change-id: 20250206-igb_irq-f5a4d4deb207

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


