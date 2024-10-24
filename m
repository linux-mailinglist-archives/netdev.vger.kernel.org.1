Return-Path: <netdev+bounces-138875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700889AF47A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF872810FF
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D492194A0;
	Thu, 24 Oct 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHQCm88X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3002178E9;
	Thu, 24 Oct 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804325; cv=none; b=UpaNlZLO+EfxdhFNhPzg+Uvm6zPd0Rld7+iiYI0QUa2pSICBgp9ZN7Ex5tPjzYLCDwqCHNb3i1xtpL4DyhjcrWJdkUGu+vD6rQYNwwVw/lig3gZB+QjHOXS6K4S/P9BLUQfKNLeukvQUBULxFvT4geQDXNG1HuasShklLdUdYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804325; c=relaxed/simple;
	bh=skvSucgJHkfhd6K1CWJn3ZKM/xtDS72Rbn/Rvvv+hHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lezpfJlLZ23vBo3c6VNbjR53mThwoAszsoJrfdcF1cqy42/CN0djRs/pZR5vge/Ipl8Dcjg80YU4+A3Ckf6HRU9T96caqKYohCTggL+odi9OF9/X57v2wdnGFaPsYdgyafPY1vNK4YV0Nm4cOJg6bBuJOlNwMsPZzbmyiml2ORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHQCm88X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3784EC4CEC7;
	Thu, 24 Oct 2024 21:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729804325;
	bh=skvSucgJHkfhd6K1CWJn3ZKM/xtDS72Rbn/Rvvv+hHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHQCm88X6Vexv159+xnuhmK9UXJFhnFW7ywaPef/T9++JauCEjr9Q1BodQ+nJ9Xlq
	 E1C6mdgWMGzQjOHbMSl1LKC3xoiKuAZcUJfeJFlbSPs6PLHR0VFiVjA/ywigJn5uaf
	 p279NQW297JgFl0eT+HeySQ8/74vOLfyZQ3AuocVYPG4f6PaGoHz4bteh/COewRxbc
	 OAFzB5rfdNz2NuLEzSI0myZRT/qlUnnW7vXcPufB6Wmj6X8Jga5+mJ9/hEq0OTngh2
	 obh2WMPKo+J4l9+O3+mmhG5mojCj9FC6Lqd7ODu33Lsd6cCqg+RCKoynmG+J29JrWD
	 t0v/LvMRqN+3w==
Date: Thu, 24 Oct 2024 15:12:02 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 2/4][next] uapi: wireless: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <65f90d60460f831a374d9cd678ba38b31fdd4f93.1729802213.git.gustavoars@kernel.org>
References: <cover.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729802213.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Address the following warnings by changing the type of the middle struct
members in various composite structs, which are currently causing trouble,
from `struct sockaddr` to `struct __kernel_sockaddr_legacy`.

include/uapi/linux/wireless.h:751:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:776:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:833:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:857:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:864:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/wireless.h | 56 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index 3c2ad5fae17f..d8744113fc89 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -748,10 +748,10 @@ struct iw_missed {
  *	Quality range (for spy threshold)
  */
 struct iw_thrspy {
-	struct sockaddr		addr;		/* Source address (hw/mac) */
-	struct iw_quality	qual;		/* Quality of the link */
-	struct iw_quality	low;		/* Low threshold */
-	struct iw_quality	high;		/* High threshold */
+	struct __kernel_sockaddr_legacy	addr;	/* Source address (hw/mac) */
+	struct iw_quality		qual;	/* Quality of the link */
+	struct iw_quality		low;	/* Low threshold */
+	struct iw_quality		high;	/* High threshold */
 };
 
 /*
@@ -766,15 +766,15 @@ struct iw_thrspy {
  *	current BSS if the driver is in Managed mode and associated with an AP.
  */
 struct iw_scan_req {
-	__u8		scan_type; /* IW_SCAN_TYPE_{ACTIVE,PASSIVE} */
-	__u8		essid_len;
-	__u8		num_channels; /* num entries in channel_list;
-				       * 0 = scan all allowed channels */
-	__u8		flags; /* reserved as padding; use zero, this may
-				* be used in the future for adding flags
-				* to request different scan behavior */
-	struct sockaddr	bssid; /* ff:ff:ff:ff:ff:ff for broadcast BSSID or
-				* individual address of a specific BSS */
+	__u8				scan_type; /* IW_SCAN_TYPE_{ACTIVE,PASSIVE} */
+	__u8				essid_len;
+	__u8				num_channels; /* num entries in channel_list;
+						       * 0 = scan all allowed channels */
+	__u8				flags; /* reserved as padding; use zero, this may
+						* be used in the future for adding flags
+						* to request different scan behavior */
+	struct __kernel_sockaddr_legacy	bssid; /* ff:ff:ff:ff:ff:ff for broadcast BSSID or
+						* individual address of a specific BSS */
 
 	/*
 	 * Use this ESSID if IW_SCAN_THIS_ESSID flag is used instead of using
@@ -827,15 +827,15 @@ struct iw_scan_req {
  *	debugging/testing.
  */
 struct iw_encode_ext {
-	__u32		ext_flags; /* IW_ENCODE_EXT_* */
-	__u8		tx_seq[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
-	__u8		rx_seq[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
-	struct sockaddr	addr; /* ff:ff:ff:ff:ff:ff for broadcast/multicast
-			       * (group) keys or unicast address for
-			       * individual keys */
-	__u16		alg; /* IW_ENCODE_ALG_* */
-	__u16		key_len;
-	__u8		key[];
+	__u32				ext_flags; /* IW_ENCODE_EXT_* */
+	__u8				tx_seq[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
+	__u8				rx_seq[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
+	struct __kernel_sockaddr_legacy	addr; /* ff:ff:ff:ff:ff:ff for broadcast/multicast
+					       * (group) keys or unicast address for
+					       * individual keys */
+	__u16				alg; /* IW_ENCODE_ALG_* */
+	__u16				key_len;
+	__u8				key[];
 };
 
 /* SIOCSIWMLME data */
@@ -853,16 +853,16 @@ struct iw_mlme {
 #define IW_PMKID_LEN	16
 
 struct iw_pmksa {
-	__u32		cmd; /* IW_PMKSA_* */
-	struct sockaddr	bssid;
-	__u8		pmkid[IW_PMKID_LEN];
+	__u32				cmd; /* IW_PMKSA_* */
+	struct __kernel_sockaddr_legacy	bssid;
+	__u8				pmkid[IW_PMKID_LEN];
 };
 
 /* IWEVMICHAELMICFAILURE data */
 struct iw_michaelmicfailure {
-	__u32		flags;
-	struct sockaddr	src_addr;
-	__u8		tsc[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
+	__u32				flags;
+	struct __kernel_sockaddr_legacy	src_addr;
+	__u8				tsc[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
 };
 
 /* IWEVPMKIDCAND data */
-- 
2.34.1


