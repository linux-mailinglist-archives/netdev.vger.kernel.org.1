Return-Path: <netdev+bounces-214248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B72B28A20
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C7A2A3D60
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1D157A48;
	Sat, 16 Aug 2025 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtI7BiIg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECF3596E
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755313383; cv=none; b=mTfYdlBI2Zhh5ZSS0OxWyX+C8XPzQiZGveFv1tbNBKkww4auG5dHzsibbYb1zoFmn5mOAJD4DxYVrgBl6hiKmK5F2kJBh4g4ecjyTlNjR65Lp5MTU96j04uQudKwhU81ERf6g+PL0KeHN6E2uKRZfjA7Ow16VXKRMIbr6J9fdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755313383; c=relaxed/simple;
	bh=Nk395VXn2zlmjzTchXt67uthejIzIBLKI60SmbGEHEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJOZrXXX7keTExT5kqwrDcsOPAO8PSz1CWG+JTdmDPt/AMstBsJNGO0posUO3xEbueZ3GrcGeF9B5F4jiRvzS7nYFYfW3rOQbOMpUvOo6RMcZyqmkh3OXcjRcgp+Hg3poRH9ymWlyf/sPpZnHJNU55w6B9Y4Unup64nXM6Eu3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtI7BiIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10B3C4CEEB;
	Sat, 16 Aug 2025 03:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755313382;
	bh=Nk395VXn2zlmjzTchXt67uthejIzIBLKI60SmbGEHEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QtI7BiIgAg9g+eV2ptrVQMf+e2sTw1IsYi3GiXllLtykjApQID2qMDHC7/IHE+rpA
	 3ULP5N7aMKJgaL5tc2l4Lk/dm6xx2kCb0fp4MPw2uhK8kEe84ZBL5UxV7+CpxMSFfc
	 lB0t/IVrcXmnRqxGMwla0+q+8JLjkOu6ljpo/Lu2vwuxC+NzeMYVix8e9yfhRCFu7V
	 jpO+xkgmB65oSPxtq0KSN+r/rBmd+EpbAav97bBgX8aikotKPLke9w5hWTwtaFBsq6
	 ZJ9jVMFlLTTehjeesszpmUA+zUuTwcq0fQUbYP04ZgKwHwEupgxqmH2pEmu/F8Efcc
	 BS/F6FK8QsjcA==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	David Lebrun <dlebrun@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH iproute2-next] man8: ip-sr: Document that passphrase must be high-entropy
Date: Fri, 15 Aug 2025 20:01:29 -0700
Message-ID: <20250816030129.474797-1-ebiggers@kernel.org>
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
 man/man8/ip-sr.8 | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/man/man8/ip-sr.8 b/man/man8/ip-sr.8
index 6be1cc54..78a87646 100644
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
+\fBtr -dC a-z < /dev/random | head -c 32\fR.
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


