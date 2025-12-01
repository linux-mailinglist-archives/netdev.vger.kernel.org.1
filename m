Return-Path: <netdev+bounces-242874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2536C95964
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B013A240B
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34571C32FF;
	Mon,  1 Dec 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QsnSp+v2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCBF176FB1
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556151; cv=none; b=JWxKjdwrWHqosnvP5oWOmH8jnGkodYRqmPETksDbhGn+ytAnPPLd8kfp1PjE3EpIMpf+KrvJu1CU8Cgls4U+GAKDiEuXlBgmsDa0k7BDynq/M6pxn7NUimoBqP0Z+UAkOUv4zHj5NF2uM+bntgNTluhLQIoW7s4F994UY7sI4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556151; c=relaxed/simple;
	bh=27Sfh9+aBERE8ruAoCRbdkTBnAJo/fnGhUC/lJC7nKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZBoJ1pwWAThJ3gk/RRZXy5nBlbD6DXBsnrwHYrbnZPuFePEql6cCDJT08vg6geL5mBG3SbKvY+lVytlGz3u481+n7wMINZWKberLNsGcDBdUoWHvCpq8+PNwVOV51CzmiEgM3SHFEq/WO0d++ZzofDeuc7a8jTRGrT8RP6Bog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QsnSp+v2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D00C4CEFB;
	Mon,  1 Dec 2025 02:29:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QsnSp+v2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVzsYY4H0PVmzfadH2enbFWXCBq8esXWoBEch+fUf8Q=;
	b=QsnSp+v2ikkms4TeDK1kho22xv0MoBXcGIRpH228bqtb3L+CLnlMrIIxzyg6gXXscDU0Ng
	X191e1FwIkH9L5mx8lwx3ZYH1qPv/+bhVJdVRz2poGZ2gJw/Eubzge8HnE7YRoppUsUXem
	cll75vEVs2afLoYYaeAx5h64YJokHNM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1fdd985f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:29:09 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 08/11] wireguard: uapi: move flag enums
Date: Mon,  1 Dec 2025 03:28:46 +0100
Message-ID: <20251201022849.418666-9-Jason@zx2c4.com>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Move the wg*_flag enums, so they are defined above the attribute set
enums, where ynl-gen would place them.

This is an incremental step towards adopting an UAPI header generated
by ynl-gen. This is split out to keep the patches readable.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/uapi/linux/wireguard.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index 3ebfffd61269..a2815f4f2910 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -15,6 +15,20 @@ enum wgdevice_flag {
 	WGDEVICE_F_REPLACE_PEERS = 1U << 0,
 	__WGDEVICE_F_ALL = WGDEVICE_F_REPLACE_PEERS
 };
+
+enum wgpeer_flag {
+	WGPEER_F_REMOVE_ME = 1U << 0,
+	WGPEER_F_REPLACE_ALLOWEDIPS = 1U << 1,
+	WGPEER_F_UPDATE_ONLY = 1U << 2,
+	__WGPEER_F_ALL = WGPEER_F_REMOVE_ME | WGPEER_F_REPLACE_ALLOWEDIPS |
+			 WGPEER_F_UPDATE_ONLY
+};
+
+enum wgallowedip_flag {
+	WGALLOWEDIP_F_REMOVE_ME = 1U << 0,
+	__WGALLOWEDIP_F_ALL = WGALLOWEDIP_F_REMOVE_ME
+};
+
 enum wgdevice_attribute {
 	WGDEVICE_A_UNSPEC,
 	WGDEVICE_A_IFINDEX,
@@ -29,13 +43,6 @@ enum wgdevice_attribute {
 };
 #define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
 
-enum wgpeer_flag {
-	WGPEER_F_REMOVE_ME = 1U << 0,
-	WGPEER_F_REPLACE_ALLOWEDIPS = 1U << 1,
-	WGPEER_F_UPDATE_ONLY = 1U << 2,
-	__WGPEER_F_ALL = WGPEER_F_REMOVE_ME | WGPEER_F_REPLACE_ALLOWEDIPS |
-			 WGPEER_F_UPDATE_ONLY
-};
 enum wgpeer_attribute {
 	WGPEER_A_UNSPEC,
 	WGPEER_A_PUBLIC_KEY,
@@ -52,10 +59,6 @@ enum wgpeer_attribute {
 };
 #define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
 
-enum wgallowedip_flag {
-	WGALLOWEDIP_F_REMOVE_ME = 1U << 0,
-	__WGALLOWEDIP_F_ALL = WGALLOWEDIP_F_REMOVE_ME
-};
 enum wgallowedip_attribute {
 	WGALLOWEDIP_A_UNSPEC,
 	WGALLOWEDIP_A_FAMILY,
-- 
2.52.0


