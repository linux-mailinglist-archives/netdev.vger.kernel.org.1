Return-Path: <netdev+bounces-249009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC2ED12A5E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 170CE302FA73
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89435770E;
	Mon, 12 Jan 2026 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBnaka8D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOTXesEH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750EB2DB787
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222534; cv=none; b=aeoQx6OQgLAlXSP5BwCH4joSeHtWr61v2nlHr1J19IRn0dGSoJBUxvRU9grjzeHspxbD8WGJzfUCd1a413stDAyFbSI5qH2sNNhInIqqeRXALKYJxbIC10jQEy3nUb3CxMrcbGzpDBkugwiNLD+vBjBIQeGBONNP6EnqzyHtRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222534; c=relaxed/simple;
	bh=V7UrOAgbBjKbnTlNQ87vW7Z6nwRklkpYJYPGjtD9Pw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuOapwMwQ8wM/g85AjWnBZsV4EJE1Pje/uqSaAHUi0cAcyVNWz273jweHANtodoeVGNjmhW9Sux5UjV+PFkD0qNHw3o59pYdpmcRCtekxHECOr9RPQ9F+1v7qPF4a4JLDBff9/jwPTKi8m9oEBt4uoJINGs3mKWt3hfdSJ3KXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBnaka8D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOTXesEH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768222531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/ujfx9fRHizDfrh38x0NK7m/HfIxQpjC07mOPX7fVQ=;
	b=iBnaka8DhyCcaVDqUJFHaJsnBy0r4y88zcbubtbsTFREkHP/qMwh2Cfq4e6BzULWjJV6uH
	8LnQcDO0arweAfDciCEA3jcZ9HKMWILO2k75xrVhxW3NS6ilW2uNX6O4VJ6+vE1u2KRDf2
	dHvIcr++Wj6GbDiIWf0IZN0tmZzARRk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-BxZYLeviOZST_gDG40tdvw-1; Mon, 12 Jan 2026 07:54:46 -0500
X-MC-Unique: BxZYLeviOZST_gDG40tdvw-1
X-Mimecast-MFC-AGG-ID: BxZYLeviOZST_gDG40tdvw_1768222485
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64d1a0f7206so6699475a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768222485; x=1768827285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/ujfx9fRHizDfrh38x0NK7m/HfIxQpjC07mOPX7fVQ=;
        b=OOTXesEHgTZrDgmW1E8LbtzZM//1wQEKtW7OCr9r3fEaXZVt/hvQBVzlc6XjtYsMom
         dkCZ8By6+k2PG5ZCTe3bAEXifpgujPWyzSUYEYG8Uh4DJVp464hyii3J9Caao458gEin
         wzvuNcZviQb1bD3zledX24EAIJDge4yftjESfXwwWZQ0oCMB6C3ij4KTVQ6ktqHkfaYx
         CzWJmOPxgIXtxrLFUHXEBPCRNhWCnFshyfqgbcs8da9nrWtAIsdTttHyocbxh3lrZQsd
         1VeXjBt/f5wpE/6a0SBsOxmwC4QiOTBREfI+FpmRTQJtXiF3mEW/qldt8J3oZK4UfEAZ
         iumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222485; x=1768827285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/ujfx9fRHizDfrh38x0NK7m/HfIxQpjC07mOPX7fVQ=;
        b=qEuHllJ9oQutHClnba6XA4djdbNtdcpwXyaATqcl30OscAWKXzz//O6LbI1nzEQpPT
         2hBD/4FMknBY89NbQ6BOVrb4wWwaI3lcMyKj7KYwzkyD3YVIdQ7tO1zaE53/BRo8fTvC
         WSsgRkKGcvkFn8vF7T27bQ6i2daflM2MUb3fyih71RMASrlvWk2Y152rpRgxDEdp3+7z
         6HyZvnJ6Fq3Dpd6digxz03VLL7LEKuyXsDVLqy8rE2wSWA180ck18USgzqO2ObO6Uq0g
         k+bgV483Pz0P2ftrU7u9+axRRMbzNIU+kADUA04MG+8OhmFhts75xu8KanzQdPrx7kv3
         jIng==
X-Forwarded-Encrypted: i=1; AJvYcCW0g8Sun0BXr4bZPW7wwQtg5/MjEYLAt8/sLzEuRFt4st2OTTmjVev1TDtDjc76/bagWWqK/6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAd4fElbCMiTpUF2UIBeAMxpbJanPmFs+stmcZvXWocQauumUU
	+Ki1QyxcsO6lB3cnKRfgDWY+b1fDEkTdMI1WtCMATMZzMuWqZzgS95MtrzDHZ58d8AmJY1dTV4i
	66DHO6ZOgcutw4LSPBN8Pxdx7FmjF0r5bwpykiCROjB/ISjO9dtW7PxwrmQ==
X-Gm-Gg: AY/fxX54g5jhldS3+XCERHbSOlXcP4O9qwPPR/TlCxNQgaiZ7VWv23beq+XWGu3f+tG
	r9GUGSnHHsucWAR8vejQ2W2TtDPOIaqO502naPjOr97Iu8Yz8TsmL8kUkZrVHa7qR/UooudyIY0
	NcQq8sxDFihndHpYtkV5fJaPizQ4qwzIQVq7BDPph3Vxo0lhGp0G2h0sIfKM58EdoDEfUVCPGot
	Lqkky030iTq1KlZy41hPheS8epPMMfsp18zyg5cg8E9Azpsgy7X4MhMfmW95WzdMAcJJUD+UlrG
	WsOa1A1cNnIplu/m+0g6BtV4xJmMjuPWAeLGReR6xSvUmwX22iCnBACTu0XAkQhd3ceusZTo22d
	bOY0S8e3palGBNFSJwzJeWRPieXjZOwQpCx41yd2NcF0EXTkMjM4dRV49bsE=
X-Received: by 2002:a17:907:9723:b0:b87:fc5:40ba with SMTP id a640c23a62f3a-b870fc61ea2mr392028966b.20.1768222484796;
        Mon, 12 Jan 2026 04:54:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTp5OSOsuyPTMRe4k38M6nE4/+Im8kgtNw0qudOBH1k9hgAUwyjKyKRD7tIQGL1L74hJziAQ==
X-Received: by 2002:a17:907:9723:b0:b87:fc5:40ba with SMTP id a640c23a62f3a-b870fc61ea2mr392025666b.20.1768222484256;
        Mon, 12 Jan 2026 04:54:44 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm497062466b.16.2026.01.12.04.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:54:43 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-riscv@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-s390@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [RFC PATCH 1/5] net: make configs NF_LOG_{ARP,IPV4,IPV6} transitional
Date: Mon, 12 Jan 2026 13:54:27 +0100
Message-ID: <20260112125432.61218-2-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
References: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit db3187ae21bb ("netfilter: nf_log_ipv4: rename to nf_log_syslog"),
commit f5466caab9a8 ("netfilter: nf_log_ipv6: merge with nf_log_syslog")
and commit f11d61e7957d ("netfilter: nf_log_arp: merge with nf_log_syslog")
deprecate the config options NF_LOG_ARP, NF_LOG_IPV4, and NF_LOG_IPV6 in
March 2021. Its corresponding functionality is provided by enabling the
config option NF_LOG_SYSLOG instead. To allow older kernel configuration to
still function, the deprecated config options are not removed but select
the new config option.

With the recent addition of the transitional attribute for config options
in commit f9afce4f32e9 ("kconfig: Add transitional symbol attribute for
migration support"), deprecated config options can be marked transitional,
and new options can be set by defaulting to the deprecated option.

So, turn NF_LOG_ARP, NF_LOG_IPV4, and NF_LOG_IPV6 into transitional config
options.

Note that transitional config options cannot have any dependencies, so the
config definitions are moved to the end of the net/Kconfig file to have no
implicit dependencies.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 net/Kconfig                | 21 +++++++++++++++++++++
 net/ipv4/netfilter/Kconfig | 16 ----------------
 net/ipv6/netfilter/Kconfig |  8 --------
 net/netfilter/Kconfig      |  1 +
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 62266eaf0e95..5bb1b98e8023 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -544,3 +544,24 @@ config NET_TEST
 	  If unsure, say N.
 
 endif   # if NET
+
+config NF_LOG_ARP
+	tristate
+	transitional
+	help
+	  This is a backwards-compat option for the user's convenience
+	  (e.g. when running oldconfig) to transition to NF_LOG_SYSLOG.
+
+config NF_LOG_IPV4
+	tristate
+	transitional
+	help
+	  This is a backwards-compat option for the user's convenience
+	  (e.g. when running oldconfig) to transition to NF_LOG_SYSLOG.
+
+config NF_LOG_IPV6
+	tristate
+	transitional
+	help
+	  This is a backwards-compat option for the user's convenience
+	  (e.g. when running oldconfig) to transition to NF_LOG_SYSLOG.
diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 7dc9772fe2d8..dfe29cedcc2c 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -76,22 +76,6 @@ config NF_DUP_IPV4
 	  This option enables the nf_dup_ipv4 core, which duplicates an IPv4
 	  packet to be rerouted to another destination.
 
-config NF_LOG_ARP
-	tristate "ARP packet logging"
-	default m if NETFILTER_ADVANCED=n
-	select NF_LOG_SYSLOG
-	help
-	This is a backwards-compat option for the user's convenience
-	(e.g. when running oldconfig). It selects CONFIG_NF_LOG_SYSLOG.
-
-config NF_LOG_IPV4
-	tristate "IPv4 packet logging"
-	default m if NETFILTER_ADVANCED=n
-	select NF_LOG_SYSLOG
-	help
-	This is a backwards-compat option for the user's convenience
-	(e.g. when running oldconfig). It selects CONFIG_NF_LOG_SYSLOG.
-
 config NF_REJECT_IPV4
 	tristate "IPv4 packet rejection"
 	default m if NETFILTER_ADVANCED=n
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index 81daf82ddc2d..60cf6269523c 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -69,14 +69,6 @@ config NF_REJECT_IPV6
 	tristate "IPv6 packet rejection"
 	default m if NETFILTER_ADVANCED=n
 
-config NF_LOG_IPV6
-	tristate "IPv6 packet logging"
-	default m if NETFILTER_ADVANCED=n
-	select NF_LOG_SYSLOG
-	help
-	  This is a backwards-compat option for the user's convenience
-	  (e.g. when running oldconfig). It selects CONFIG_NF_LOG_SYSLOG.
-
 config IP6_NF_IPTABLES
 	tristate "IP6 tables support (required for filtering)"
 	depends on INET && IPV6
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 6cdc994fdc8a..c7f9fcaf6028 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -98,6 +98,7 @@ config NF_CONNTRACK
 config NF_LOG_SYSLOG
 	tristate "Syslog packet logging"
 	default m if NETFILTER_ADVANCED=n
+	default NF_LOG_ARP || NF_LOG_IPV4 || NF_LOG_IPV6
 	help
 	  This option enable support for packet logging via syslog.
 	  It supports IPv4, IPV6, ARP and common transport protocols such
-- 
2.52.0


