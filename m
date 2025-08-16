Return-Path: <netdev+bounces-214255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CACAB28A44
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5057C583612
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C418DF9D;
	Sat, 16 Aug 2025 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0CKPJTS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941F374D1
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314431; cv=none; b=qxgYfA08R28VPNpcS5zvN0+no/X8LCaPx89xVqQI8FKqk8zvDcieBzpab3K+Ah9dziiP3jnkR7fyhxs8NF2AnvkWiNYWJAyNeXs67Y38++b9mHOGtX5Ff3BjscT483SaNOxj/pinIdddcN3uhekaVttLO/cmbrV7Ng7dJFy8aDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314431; c=relaxed/simple;
	bh=a2JSw+DHVe3QfCBuggx7+YZaLQTcPVI6HXtIH8oetNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0pv9+Oef83jPg+W716AIks9KsFRwQMFYd8xBAeYCIAqt/ltzv893loByJvD+EqY1rrczC/N7sEgH2qYYR/oKXvWHHhl/QhQbOzKUhdmqFoRytuTfbo//WhDa+ow9fgFLRxIa3Km5NRe+uouJXQvXYsjfQmOthzSogG0Nwzt8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0CKPJTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA33CC4CEEB;
	Sat, 16 Aug 2025 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314431;
	bh=a2JSw+DHVe3QfCBuggx7+YZaLQTcPVI6HXtIH8oetNA=;
	h=From:To:Cc:Subject:Date:From;
	b=l0CKPJTSFYj+Dg58ZcBtg7Wbreofhwn5oK9GTytn/hnFmWSc+SQUV1UOfX0qJs3Hn
	 0qpYqcOn7mgQ8217j24W4zGzgG4UJ9J/+RwDPxq4HDVdAeNG1W9zXJTGxPtRCYml/L
	 zTvzNf32bRklYBYMgeO7FJu668hZ89+Co89KM3iiUKf1mHfTQlwgAAhKPC6WwIGmw1
	 ZcZydvdNDvetwSX10noE1594RBQeOtsh5NoSX6Hc3WBMlSHDaQeN7j2NQEB2Z4Rvdn
	 xYgQFxYgnI5fcALuLa4IQJnEFGAusoW3ndlYeS8nuksTm0fRo47CXm24YWb+jFEbyr
	 MXxeXDg5s/xgQ==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	David Lebrun <dlebrun@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH iproute2-next v2] man8: ip-sr: Document that passphrase must be high-entropy
Date: Fri, 15 Aug 2025 20:18:46 -0700
Message-ID: <20250816031846.483658-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'ip sr hmac set' takes a newline-terminated "passphrase", but it fails
to stretch it.  The "passphrase" actually gets used directly as the key.
This makes it difficult to use securely.

I recommend deprecating this command and replacing it with a command
that either stretches the passphrase or explicitly takes a key instead
of a passphrase.  But for now, let's at least document this pitfall.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

v2: use better example command for key generation

 man/man8/ip-sr.8 | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/man/man8/ip-sr.8 b/man/man8/ip-sr.8
index 6be1cc54..cd8c5d18 100644
--- a/man/man8/ip-sr.8
+++ b/man/man8/ip-sr.8
@@ -1,6 +1,6 @@
-.TH IP\-SR 8 "14 Apr 2017" "iproute2" "Linux"
+.TH IP\-SR 8 "15 Aug 2025" "iproute2" "Linux"
 .SH "NAME"
 ip-sr \- IPv6 Segment Routing management
 .SH SYNOPSIS
 .sp
 .ad l
@@ -32,13 +32,21 @@ internal parameters.
 .PP
 Those parameters include the mapping between an HMAC key ID and its associated
 hashing algorithm and secret, and the IPv6 address to use as source for encapsulated
 packets.
 .PP
-The \fBip sr hmac set\fR command prompts for a passphrase that will be used as the
-HMAC secret for the corresponding key ID. A blank passphrase removes the mapping.
-The currently supported algorithms for \fIALGO\fR are \fBsha1\fR and \fBsha256\fR.
+The \fBip sr hmac set\fR command prompts for a newline-terminated "passphrase"
+that will be used as the HMAC secret for the corresponding key ID. This
+"passphrase" is \fInot\fR stretched, and it is used directly as the HMAC key.
+Therefore it \fImust\fR have enough entropy to be used as a key. For example, a
+correct use would be to use a passphrase that was generated using
+\fBhead\~-c\~32\~/dev/urandom\~|\~base64\~-w\~0\fR.
+.PP
+A blank "passphrase" removes the mapping.
+.PP
+The currently supported algorithms for \fIALGO\fR are \fBsha1\fR and
+\fBsha256\fR.
 .PP
 If the tunnel source is set to the address :: (which is the default), then an address
 of the egress interface will be selected. As this operation may hinder performances,
 it is recommended to set a non-default address.
 
@@ -52,7 +60,11 @@ it is recommended to set a non-default address.
 .nf
 # ip sr tunsrc set 2001:db8::1
 .SH SEE ALSO
 .br
 .BR ip-route (8)
+
+.SH BUGS
+\fBip sr hmac set\fR does not stretch the passphrase.
+
 .SH AUTHOR
 David Lebrun <david.lebrun@uclouvain.be>

base-commit: 0ad8fef322365b7bafd052f416fc972bea49d362
-- 
2.50.1


