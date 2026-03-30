Return-Path: <netdev+bounces-273328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEenAYXsymkkBQYAu9opvQ
	(envelope-from <netdev+bounces-273328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:35:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7943D361812
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8C033054703
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA33A63FD;
	Mon, 30 Mar 2026 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgLxC+dU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971A3A451A
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906389; cv=none; b=pc0TXbW19vhmjK924OvA6pAUE5X/Pd7GsrsuaBlTXpKGHD/WZ/5FwdBbYCBNvYrNDxASxo9hLeSheVik4O5mUUb8E527llWUuw4eSy3h0ILhpLN4h/5d0BzbtCjjHID1yx8eVx+nzbgQm9mhyLtxgwEDmfOqvGts+3IYFt13kT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906389; c=relaxed/simple;
	bh=kMcZjPsOMrDkhR41RdpNe609HpL2qZ9sTZwgMq52YiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erO2aB4iwGla5VEWtr5SUtg7lza1baEGyvOC/lXv61ug0eU2mkeZ/8x+t1rGMR/JM0LTWYlX7YGxMThwT8HTfcju9x1RtWdMuoh7LoedyR7zKiavx6c8Tk6aV8sC3jYDb1+aIYXTYJvBg5/DosgoEp2+c6q8s/Z5Nwbqj0bFHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgLxC+dU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfa33a983so1131522f8f.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774906387; x=1775511187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xBdx6H/Z1jGCptYLlq0P8qy8OL6OaKAaFg5bJOcmtsg=;
        b=XgLxC+dUH1Wn0OEePd1wpRNA3mGoY1KeKezxVoXDNt7RB5VtopftB4VParxrcBgv9r
         TxyRA088fRdk4K6yqxn73MoSDMBT5bztb/Jco8fR9lwVdFC4Ngf73VwoifzRenmuFERt
         nj9mpHTTSdQ4Mls/OCpQ3xm9vX0XYCziMem6R81ERTta6JHhFVGr1EIkVaplaR7rrLxS
         6fYcUShlLknFisUjSCTYUYTv4CkPrKdVhnCJ1pOUI3D/DY4D3iRaugmRl0tbYUl44j4q
         IID5v5cZW7U+ZTLq99X0hJgzFKDRulr+hRjq8BH9CZCoTYKzaLa8HdW7/QCci+pse2oX
         pgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774906387; x=1775511187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBdx6H/Z1jGCptYLlq0P8qy8OL6OaKAaFg5bJOcmtsg=;
        b=IlO3GpB7qS96xPFmzdJmrqShA2/aUjVXFZz91g0bbTSD94mwTFeU+kOu5P4/7xgaRa
         V+MgMydaMjFsdOLdUYZn+EHezoIu6I3RtvrUw8WF3tXxH9S/DiokoVta+h/Z9NvCLXNx
         gypVBhU3EOj3kNqKVM8pmzr9Rr+R01fPBzLaHgI+3EMhvmyvjii+1EEAdzNnI4UqMBQs
         h4x4SX8i2JOXqt2hIqatu0dphs5gT+FVOWLxt0aMFZz1FSUOTmsG3USW/jJMWET9L2LH
         iDtIFdtiV8rUdmkTODdeSPyUo+Mmg6L4GO072qQ7e7b8hgQqCNp7+4BIXN6RQQdzMlVJ
         CWEA==
X-Gm-Message-State: AOJu0YyukCaHi5HctumJzQ0Mcca5EXcLxfL7Pw+MMpHIPIpahSnLu8EH
	6PLajhU2jLAYIirEOmcKV+enLmczswfN1fP66vvfGP/Nfcyq1zIAYJyJ
X-Gm-Gg: ATEYQzxjf574hSFyHH2k5QKziZ6iGXAF4AAViRElRohk+N9/VH90w29+bN/zN71K/3r
	zccJAIhwnkcgxDzWNYNxRcoM6OXApttS98NORa26d/gg6xRvWc9Xf/uzyhJsjXFV0yZmqpb6ACp
	yYb0Np5eN7cW93R42AYgZnYWipGIjtoINYruTSl9HkET2SgXNnLXsvDyPBRR4SfZWO3x2vO3koH
	YCZar8+OLF4uaJldWp1K00MM1vOvJ02O4tiYUiiSqsALxY1FOH9wSZN6owZTxpt71a1Iq25dCcm
	XTXcEYOwKMyDSJamckl7bXo/m7mKhgCq6gElopKrCUN3ddJWoxMIH68VkesnNpCzQXwQKe4UjnS
	4qJHwNLpOGHVXz9R+NyLbj1qvqZRPe6pCrW5wtFlMQg0Xw0iAELH67kujorjJb8yIFNV5XA4pBc
	ivaP7oKO/6kN22wNl+o7BLx7svhwOSgd25ghCycB+lYvvcr5H82OsXLXwrmbPLvsqRVg==
X-Received: by 2002:a05:6000:40cd:b0:43b:8f29:b08f with SMTP id ffacd0b85a97d-43b9ea46662mr22538065f8f.30.1774906386448;
        Mon, 30 Mar 2026 14:33:06 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e9e18sm20855869f8f.9.2026.03.30.14.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:33:05 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] ppp: dead code cleanup in Kconfig
Date: Mon, 30 Mar 2026 22:32:58 +0100
Message-ID: <20260330213258.13982-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273328-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7943D361812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is already an 'if PPP' condition wrapping several config options
e.g. PPP_MPPE and PPPOE, making the 'depends on PPP' statement for each of
these a duplicate dependency (dead code).

I propose leaving the outer 'if PPP...endif' and removing the individual
'depends on PPP' statement from each option.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/net/ppp/Kconfig | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ppp/Kconfig b/drivers/net/ppp/Kconfig
index a1806b4b84be..f57fba84fe55 100644
--- a/drivers/net/ppp/Kconfig
+++ b/drivers/net/ppp/Kconfig
@@ -37,7 +37,6 @@ if PPP
 
 config PPP_BSDCOMP
 	tristate "PPP BSD-Compress compression"
-	depends on PPP
 	help
 	  Support for the BSD-Compress compression method for PPP, which uses
 	  the LZW compression method to compress each PPP packet before it is
@@ -56,7 +55,6 @@ config PPP_BSDCOMP
 
 config PPP_DEFLATE
 	tristate "PPP Deflate compression"
-	depends on PPP
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	help
@@ -71,7 +69,6 @@ config PPP_DEFLATE
 
 config PPP_FILTER
 	bool "PPP filtering"
-	depends on PPP
 	help
 	  Say Y here if you want to be able to filter the packets passing over
 	  PPP interfaces.  This allows you to control which packets count as
@@ -84,7 +81,6 @@ config PPP_FILTER
 
 config PPP_MPPE
 	tristate "PPP MPPE compression (encryption)"
-	depends on PPP
 	select CRYPTO_LIB_ARC4
 	select CRYPTO_LIB_SHA1
 	help
@@ -96,7 +92,6 @@ config PPP_MPPE
 
 config PPP_MULTILINK
 	bool "PPP multilink support"
-	depends on PPP
 	help
 	  PPP multilink is a protocol (defined in RFC 1990) which allows you
 	  to combine several (logical or physical) lines into one logical PPP
@@ -109,7 +104,7 @@ config PPP_MULTILINK
 
 config PPPOATM
 	tristate "PPP over ATM"
-	depends on ATM && PPP
+	depends on ATM
 	help
 	  Support PPP (Point to Point Protocol) encapsulated in ATM frames.
 	  This implementation does not yet comply with section 8 of RFC2364,
@@ -118,7 +113,6 @@ config PPPOATM
 
 config PPPOE
 	tristate "PPP over Ethernet"
-	depends on PPP
 	help
 	  Support for PPP over Ethernet.
 
@@ -164,7 +158,7 @@ config PPPOE_HASH_BITS
 
 config PPTP
 	tristate "PPP over IPv4 (PPTP)"
-	depends on PPP && NET_IPGRE_DEMUX
+	depends on NET_IPGRE_DEMUX
 	help
 	  Support for PPP over IPv4.(Point-to-Point Tunneling Protocol)
 
@@ -175,7 +169,7 @@ config PPTP
 
 config PPPOL2TP
 	tristate "PPP over L2TP"
-	depends on L2TP && PPP
+	depends on L2TP
 	help
 	  Support for PPP-over-L2TP socket family. L2TP is a protocol
 	  used by ISPs and enterprises to tunnel PPP traffic over UDP
@@ -184,7 +178,6 @@ if TTY
 
 config PPP_ASYNC
 	tristate "PPP support for async serial ports"
-	depends on PPP
 	select CRC_CCITT
 	help
 	  Say Y (or M) here if you want to be able to use PPP over standard
@@ -198,7 +191,6 @@ config PPP_ASYNC
 
 config PPP_SYNC_TTY
 	tristate "PPP support for sync tty ports"
-	depends on PPP
 	help
 	  Say Y (or M) here if you want to be able to use PPP over synchronous
 	  (HDLC) tty devices, such as the SyncLink adapter. These devices
-- 
2.51.2


