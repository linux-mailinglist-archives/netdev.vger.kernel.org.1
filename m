Return-Path: <netdev+bounces-234823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0079C27B0F
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3575034622C
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56402D060B;
	Sat,  1 Nov 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd4W8sSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B528BAB1
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990483; cv=none; b=WdaPJvUah7lXlzuUbn0G9iGXphp7n+T1U1OqsiZ8Ybq2yHDp8ADENk24NOhTgZyny/AEffGpf2EiPXqM9TvR3d6+gt8J4YzWLNlA1a2gDASDGfB3EIQtl+BP9muYrq8XsqPD56tpQZjGwxlW/iJ5oo4djqYx+3e4qr1deQ4C+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990483; c=relaxed/simple;
	bh=GTa5PMbqingrx9UUvDQwwryRQXi1hbUYeu/uDR+oix4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj3hoIeaADGzk7CwZ9gumtdUAnG0nk1aAyAg34Qy+gzf2ELo1gJa/fEPiGpdR+kyFffZcXt7NtrE4aSZDDpqjTG5kZjSZGDJqSZiKRPokXrT/9qfVVm9NreLNeZVcUOSIZwr+g1Chjx5E1TjBmdFNWsbbH5sOVic1C3cL0A1duY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd4W8sSb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2956d816c10so542445ad.1
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990481; x=1762595281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjjrDgD3WOpxSbQxw9z6dYOn0RSDkCVjfKdY81mup90=;
        b=Jd4W8sSbOIwUQnCojzItd/DQHSJ3ozqbsRZdBoZALQd77rwQT4g9x1uQvW62f9s6Zs
         VQU6vyUQDywSL3Sd6Ax+HGKZS89YdmlDmeeHBQDnwyteyJlnRLElWZgR5piBpUIred+D
         hRbJFQXA+P04Mzqiduh5v9xcta9PXxOcMFRb/mNA6wxn/m7uDU5G1XSumXJDF00R5ae4
         vuD4won6tIB24+N0vWVFWYnCsmbQ9kdEjPesqTg4yJm0ms8RcT85/zI4AZlgLHmrU4mX
         emGA1BiMskEc+DTgbSFeIHUiOnQIBR+ZCWtHaSDPQK6JW4XiQNCH/j0/ytNQzoFSfF3M
         YXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990481; x=1762595281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjjrDgD3WOpxSbQxw9z6dYOn0RSDkCVjfKdY81mup90=;
        b=ay5HOzLjBPqlfOsjrQ0tdl6aP39HNYxk93nhzRoNzugZRuhV1P44bpMDSlOouDlyYP
         vGmaR5ID9IY0yCmkf7k1qau94S3DIIQydfwzoHHY8Hsrbq+ChRMzQeKlRGJRZC7o8S6e
         lMYx7gsmxUcYX+Z9mdfxOlgC6daxMknqqqWrzqxAl3PrnXdoa/gEbPUPaQUwJCA4C4RI
         DkUHyiDNBtftkdzKTDjkMSSx14NeoUpWD1Kpfei6ByMRC73tWsNCrPdIUXCYSNx5ejrL
         3BzqlNRRz5lO47R+rXlTNK+cjlZ/dkixqXFz5Nft8yNMRwtEtW/4Z5eFgNgR4QwwcjSK
         ufQw==
X-Forwarded-Encrypted: i=1; AJvYcCXheXcr/8DWQOg8qLpikra6kV4ZFZfu0dShzPFGBIH3RMkcGfvWQupLQLGgJIvfPrlmzXsur28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7s9uM95JvKnjD8yo4EjUWP3f3asOs/wd5OTMFFDxsCsLk08A
	deJ6eaZWj7eXdIE6qtfpZhbaIWB6N1S1cFiibUiZkpMQsHOLi7r7lGax
X-Gm-Gg: ASbGncs7jGMH3ydJgUlwFKFVK42Ow28WdU6GHRpRK21OdeM5qGSJ+upiBQgCRezlBFM
	PpXFbW6Y1OKF6LWJNIRaEXaUPjfRmlH19fDdbrNRZGzeRMN6iV9fYHzHtkH3y91OlJg5fIHObe8
	C4o880CSej4rzdm6HeQoj/+BoFkLW2QvOuT3nOOkaC9td1SR9JrEKn1J+QktTibBBvJ9lCVgL9n
	33vLF/j9vUEWf7KiXO9V1cMHRuRnIri7AHQFMvAX/icW69uiqtjJZIzIDjF1kNENFcO8N66ptj/
	TZrHABRxnufMgcv31e0DJowT+hj/DzbrBG/2NeEgQftnaxenfUxED3VF9woYCuLa6iFlI/9fQzy
	xBiMFsV7fZ8LqMnXv1UX8S9Acr3dDi2TkQwVzKUgXyiBabvmt+MMY+K7PjElwSsqerk1kN00pbr
	zzEU/9jP8Yidg=
X-Google-Smtp-Source: AGHT+IG5sgTmPbr5SKGt4RZnfYGQcR5jMn0NQ+QLpl4Gj+BxopLRKO/fYUff15QKvawPU7JdQEXTEg==
X-Received: by 2002:a17:902:c408:b0:288:e46d:b32b with SMTP id d9443c01a7336-2951a3b7984mr101577005ad.17.1761990481194;
        Sat, 01 Nov 2025 02:48:01 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268a629csm51068175ad.30.2025.11.01.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:47:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BB5E841FA3A3; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v2 4/8] Documentation: xfrm_sync: Properly reindent list text
Date: Sat,  1 Nov 2025 16:47:40 +0700
Message-ID: <20251101094744.46932-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5939; i=bagasdotme@gmail.com; h=from:subject; bh=GTa5PMbqingrx9UUvDQwwryRQXi1hbUYeu/uDR+oix4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms13Lb2I51F8/KKf0g6XPr8eqTnq26xtVGkc/tKtl/X HpYZv6go5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOZqsPwP8+1NHHz0blnTx3X NW2JmTazMfq0dRpPudRi8fLstLLtjAz/w8xP5nFvqP59RpNtS0Pis7zdVydEPPvfPPX5wmKtiM3 zGQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

List texts are currently aligned at the start of column, rather than
after the list marker. Reindent them.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sync.rst | 77 +++++++++++++-------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index 6246503ceab2d2..c811c3edfa571a 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -88,23 +88,23 @@ to get notified of these events.
 
 a) byte value (XFRMA_LTIME_VAL)
 
-This TLV carries the running/current counter for byte lifetime since
-last event.
+   This TLV carries the running/current counter for byte lifetime since
+   last event.
 
-b)replay value (XFRMA_REPLAY_VAL)
+b) replay value (XFRMA_REPLAY_VAL)
 
-This TLV carries the running/current counter for replay sequence since
-last event.
+   This TLV carries the running/current counter for replay sequence since
+   last event.
 
-c)replay threshold (XFRMA_REPLAY_THRESH)
+c) replay threshold (XFRMA_REPLAY_THRESH)
 
-This TLV carries the threshold being used by the kernel to trigger events
-when the replay sequence is exceeded.
+   This TLV carries the threshold being used by the kernel to trigger events
+   when the replay sequence is exceeded.
 
 d) expiry timer (XFRMA_ETIMER_THRESH)
 
-This is a timer value in milliseconds which is used as the nagle
-value to rate limit the events.
+   This is a timer value in milliseconds which is used as the nagle
+   value to rate limit the events.
 
 3) Default configurations for the parameters:
 ---------------------------------------------
@@ -121,12 +121,14 @@ in case they are not specified.
 the two sysctls/proc entries are:
 
 a) /proc/sys/net/core/sysctl_xfrm_aevent_etime
-used to provide default values for the XFRMA_ETIMER_THRESH in incremental
-units of time of 100ms. The default is 10 (1 second)
+
+   Used to provide default values for the XFRMA_ETIMER_THRESH in incremental
+   units of time of 100ms. The default is 10 (1 second)
 
 b) /proc/sys/net/core/sysctl_xfrm_aevent_rseqth
-used to provide default values for XFRMA_REPLAY_THRESH parameter
-in incremental packet count. The default is two packets.
+
+   Used to provide default values for XFRMA_REPLAY_THRESH parameter
+   in incremental packet count. The default is two packets.
 
 4) Message types
 ----------------
@@ -134,42 +136,43 @@ in incremental packet count. The default is two packets.
 a) XFRM_MSG_GETAE issued by user-->kernel.
    XFRM_MSG_GETAE does not carry any TLVs.
 
-The response is a XFRM_MSG_NEWAE which is formatted based on what
-XFRM_MSG_GETAE queried for.
+   The response is a XFRM_MSG_NEWAE which is formatted based on what
+   XFRM_MSG_GETAE queried for.
 
-The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
-* if XFRM_AE_RTHR flag is set, then XFRMA_REPLAY_THRESH is also retrieved
-* if XFRM_AE_ETHR flag is set, then XFRMA_ETIMER_THRESH is also retrieved
+   The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+
+     * if XFRM_AE_RTHR flag is set, then XFRMA_REPLAY_THRESH is also retrieved
+     * if XFRM_AE_ETHR flag is set, then XFRMA_ETIMER_THRESH is also retrieved
 
 b) XFRM_MSG_NEWAE is issued by either user space to configure
    or kernel to announce events or respond to a XFRM_MSG_GETAE.
 
-i) user --> kernel to configure a specific SA.
+   i) user --> kernel to configure a specific SA.
 
-any of the values or threshold parameters can be updated by passing the
-appropriate TLV.
+      any of the values or threshold parameters can be updated by passing the
+      appropriate TLV.
 
-A response is issued back to the sender in user space to indicate success
-or failure.
+      A response is issued back to the sender in user space to indicate success
+      or failure.
 
-In the case of success, additionally an event with
-XFRM_MSG_NEWAE is also issued to any listeners as described in iii).
+      In the case of success, additionally an event with
+      XFRM_MSG_NEWAE is also issued to any listeners as described in iii).
 
-ii) kernel->user direction as a response to XFRM_MSG_GETAE
+   ii) kernel->user direction as a response to XFRM_MSG_GETAE
 
-The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+       The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-The threshold TLVs will be included if explicitly requested in
-the XFRM_MSG_GETAE message.
+       The threshold TLVs will be included if explicitly requested in
+       the XFRM_MSG_GETAE message.
 
-iii) kernel->user to report as event if someone sets any values or
-     thresholds for an SA using XFRM_MSG_NEWAE (as described in #i above).
-     In such a case XFRM_AE_CU flag is set to inform the user that
-     the change happened as a result of an update.
-     The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+   iii) kernel->user to report as event if someone sets any values or
+        thresholds for an SA using XFRM_MSG_NEWAE (as described in #i above).
+        In such a case XFRM_AE_CU flag is set to inform the user that
+        the change happened as a result of an update.
+        The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-iv) kernel->user to report event when replay threshold or a timeout
-    is exceeded.
+   iv) kernel->user to report event when replay threshold or a timeout
+       is exceeded.
 
 In such a case either XFRM_AE_CR (replay exceeded) or XFRM_AE_CE (timeout
 happened) is set to inform the user what happened.
-- 
An old man doll... just what I always wanted! - Clara


