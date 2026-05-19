Return-Path: <netdev+bounces-289265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLK9DqPhC2qzPwUAu9opvQ
	(envelope-from <netdev+bounces-289265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:05:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7208577185
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DC6030221C8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DED2C028F;
	Tue, 19 May 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQuQ5Eol";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyYOPHKn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828016DC28
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163552; cv=none; b=AE58G9x13b+tcO8sP1T4ZC+SYIZ+th+4J63WLH0lQ7k/UsDyeShmIMy2v4HVmzewfD5HnaBOyFkBXl/I3a6ikREGpvBhPeQvP10mVoZ8Ew2G5LPTR28feUt7c7Z/qW6ah1cfixngNGLJbqxQZ/jfCyvDFyd+bDDQ5GdXB1ESEuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163552; c=relaxed/simple;
	bh=9wzbHp4shxKFJZcvsx9HwOuka3VvuH1DUff+EQY4jOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4rzt2u6xUkZ3vZ6UcWVuiV1cCnQ6IC4v4+wqNrT7rRtB0n7X5ITe0BgYtCXgsBUx8fghjsVL/kJA8mG4ghbG5UblI9ZW72TfrhZBfvwDqkwUaoMjMvqdEdUSJN8oUeFm494zBGqINLbYj5qoWCyn+dRx8YAH9heSiEhpg7J4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQuQ5Eol; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyYOPHKn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779163549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1PWpBmlSY8l3hxO5apiC06YW33tZ7GfnGoImctCsrXQ=;
	b=BQuQ5EolFWDlsjH6iX7WZm1aXkMfzkmU9TnimQTMNN/IKoqHf5k8W/nK04vBRcjvXYwCCw
	zp0nRFK3r1vhlJ4sHX9d24Yawli2CReTM3KH9czs60yPXqhgUCj53NMScV4zTFZLrN0klr
	zbJc5lxFjmcLKbBzPolel2rOeDvYJtU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-Fgs6p9ALOpiBbqZ3aFQnog-1; Tue, 19 May 2026 00:05:47 -0400
X-MC-Unique: Fgs6p9ALOpiBbqZ3aFQnog-1
X-Mimecast-MFC-AGG-ID: Fgs6p9ALOpiBbqZ3aFQnog_1779163547
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd33b4921so21886455e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779163546; x=1779768346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PWpBmlSY8l3hxO5apiC06YW33tZ7GfnGoImctCsrXQ=;
        b=hyYOPHKnqhTv5QcgsXgfrepnXEjGA87qVh5W0CZ8cKEsv/Q8Pr0jnaX5YGwNOnmgsL
         PLwn6WQmdEYlyIm7To9dh53dk3AWb2ZVjKXhgZWMg02rE3emCpe+VDHvKcfEV84qFSvo
         oZqyxj7T7WpLBcUvCWGLtQPsS87ax3VlAqimLy6umqapW5DLveiaWJdTT8qR+BpZTqic
         EYAyhDNeYgLD/DvJVE+XI6HzVaizYDFRteZB2MKAJ7kvAsGYVHz2z70PFym4+nCNYZNz
         jPDn6o4X8cWIIr7CDQtKr9wO9pXY45AKf6tDTPqRedk4I6RPMLC3LVfvyBGAaqJoNoWg
         Yl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779163546; x=1779768346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PWpBmlSY8l3hxO5apiC06YW33tZ7GfnGoImctCsrXQ=;
        b=amtT5UdHjsTwBdA5aBwZMJg42w7bF4YUBupr6ozlAJALkQuTN0XqtKPF8VCUeebnHe
         aZrALY8O0FlxjLSnLgWSv26IYIMcaKSmRLfUCm+AGVDXrf+GgcXng1inZwVPVRbiMPpt
         TS/9FOze0XirALEtJfwSV0tYKzD2708ZT4OM5JrXI+QXSPMBoB9k37PaqVVXcEGeo2OJ
         Yapt+RCmNVPJ1wAYraMi4gqqPVQjaLxKRpBicl3OVnZUIZdgx4ymgdrPYOzZfQU1u1MD
         6tnNoRYdv0Mg4WInKz42g/VPRs0cqb01Mcmmj9an8LWtHiDAA1zKJ1km0vRpLlV/aa9U
         XgdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qf8vwdwbytQSlj9u/G4F1z8G6wcctWL+xC0Vn/TdkcDmgbRcl6x9o8oqiCsQostQ+wllEPnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4TRojLuFtzrwXQhSRIdBMxlGdsZQG22c0VV+wNpzF7d+66eYp
	NHUtN+RZYp4jrbsHr+lGYHVvafTqWHJRFqV19f9MCoAmVbDJsDpEKvRw/olpF7hJmyIS8tA1N18
	ZTuHuHNDqVFEqV0xQwhiaHoUmPLBcZoa7+JP7m9c7Zd5XXwDNB3LYbwzn8A==
X-Gm-Gg: Acq92OF8QQjJpBA6S5tny3N5XC7QtSwVY+ipZA0C58K6hfohzR5H/aFAkK4ntl7Pf6I
	TbGL+msYi6k0GeJC8vQgNjWw0+h+N8vK1WQMYaVG9grnBLrA0Wxg3t+yJM316CJFpbq26wMfbR8
	ClheQtc0PfWBzaKYwJD0MqsKRNiZtCpMVm7+nNWacA6OFG2PyGKOgKFiDNbmHASQOxtD3gxSXhH
	fAPePxmh1OC+ZTfaB99CuxJBQFkS8YP+wjZE+Ndpgfunp4r+7WvMbU8ZIp7eyH3zb2FkOPWrSd9
	FkIcw0on0ikrQqthAhiKemGdTcrOPcyWwk/UjU795EAM0jJPSyjDI0Zd0rZy+Pupt8wKtrwYM/p
	5qwHMkqje1BNMWMupFP5WdusfQxvLQBJZW1+rIW+rusIDNef7MekgI7yUVT7F2zH63DkDP2Q=
X-Received: by 2002:a05:600c:5296:b0:490:31e:d6f4 with SMTP id 5b1f17b1804b1-490031ed905mr156949725e9.18.1779163546556;
        Mon, 18 May 2026 21:05:46 -0700 (PDT)
X-Received: by 2002:a05:600c:5296:b0:490:31e:d6f4 with SMTP id 5b1f17b1804b1-490031ed905mr156949385e9.18.1779163546211;
        Mon, 18 May 2026 21:05:46 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm45793554f8f.31.2026.05.18.21.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:05:45 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: drop obsolete 3C509 NETWORK DRIVER section
Date: Tue, 19 May 2026 06:05:32 +0200
Message-ID: <20260519040532.277078-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-289265-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[lbulwahn@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A7208577185
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 91f3a27ae9f66 ("drivers: net: 3com: 3c509: Remove this driver")
removes the 3c509 network driver, but misses to also remove the MAINTAINERS
section 3C509 NETWORK DRIVER.

Simply drop the obsolete 3C509 NETWORK DRIVER section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dd58a16f06a..f986eb688ae4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -68,12 +68,6 @@ Maintainers List
           first. When adding to this list, please keep the entries in
           alphabetical order.
 
-3C509 NETWORK DRIVER
-M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	drivers/net/ethernet/3com/3c509.c
-
 3C59X NETWORK DRIVER
 M:	Steffen Klassert <klassert@kernel.org>
 L:	netdev@vger.kernel.org
-- 
2.54.0


