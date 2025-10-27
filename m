Return-Path: <netdev+bounces-233297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBDCC1130F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853671895A67
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254E2D5A14;
	Mon, 27 Oct 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJboMH3C"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868A21576E;
	Mon, 27 Oct 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593837; cv=none; b=Fz5z6slrWrOyrZSWy/hwoYSzJziU6X2WC3diIeNRZ/RMOqypx5vHEHD7GR3wDxkasqERSZI5E/vgXkI3trnTG9+XolLLwEseOItwFPwEZL6+bpF9bkCb32ZQmlh7R9tNheFk8pmlNonQ/hSK8ftys5z2ncj/nlE36zMPNia6odA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593837; c=relaxed/simple;
	bh=FXWMy8I5Mg64Tba4DqwmP2O/F44S7/SL5KQ7cjD+FFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQkGdrVUJ78ueNlhrA41B4eZC0UvMyTRIBzFJoBEWgECpvMCn4aE4nq8KafTkOu4z40bvTK/2eTnLF+Ospp39aWo+QrApQYRxPF6iJ4lAqnaWlrwe06RGXY9k21JojwNbBnFyvczsGaIcr3HDG+PSNOAK3DUEO9yJhwTI1UGguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rJboMH3C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OUeGYoPHNs62uCqJ5pjVhz5EO6V14o61GpjtJFSfqK0=; b=rJboMH3C6c65fDZ2aAFg9X7O3c
	dGRHEKq823u9rBU2GypE3vXe6fI/3YgNNvLur7ozBDMNGv4sLHmmfrH2FZ5CF5IM9uRBQ7KD+hiin
	Pjqk9x8L31+U2UAg791hI7m3J8Vm46ITH28a9djhiipHd3+zGIFWO3/hq6zCpIu1iZTOzYLJzTfVk
	O6V2u7byX40xjO2KCTqjOuAZe7g7qN1VK9mfgcrzP118T9CRWqrJawwDMU6BNaGBdeuJDpFXYa6od
	x+p5cBx3IYxX2KwydjPirhrl90pcmQYq6tHLRhQNhCwU3hiBAJdXD114KP12mINO3dHKlz+fm8DpA
	Ye7K7lKg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDT1k-0000000EgXD-264v;
	Mon, 27 Oct 2025 19:37:12 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH net] documentation: networking: arcnet: correct the ARCNET web URL
Date: Mon, 27 Oct 2025 12:37:11 -0700
Message-ID: <20251027193711.600556-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arcnet.com domain has become something other than ARCNET (it is
something about AIoT and begins with an application/registration;
no other info.) ARCNET info is now at arcnet.cc so update the
ARCNET hardware documentation with this URL and page title.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/networking/arcnet-hardware.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20251024.orig/Documentation/networking/arcnet-hardware.rst
+++ linux-next-20251024/Documentation/networking/arcnet-hardware.rst
@@ -73,10 +73,10 @@ splitting," that allows "virtual packets
 although they are generally kept down to the Ethernet-style 1500 bytes.
 
 For more information on the advantages and disadvantages (mostly the
-advantages) of ARCnet networks, you might try the "ARCnet Trade Association"
+advantages) of ARCnet networks, you might try the "ARCNET Resource Center"
 WWW page:
 
-	http://www.arcnet.com
+	http://www.arcnet.cc
 
 
 Cabling ARCnet Networks

