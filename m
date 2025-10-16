Return-Path: <netdev+bounces-229946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E78BE25D2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70DE54F9F0E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B21318136;
	Thu, 16 Oct 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7sFHNFp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA531691C
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606769; cv=none; b=uTF30zgBVnvHLWXsC8V5bvQvtEC7SSEF8gN1h9tM+yif6/o/5vGqqd+9D7roGG4a8KoxCcfwx0+SEQycC4BQHexWkELLGupxaUUPkd82j9/2i3KbR54jFUh/XnO+cEiapDa640c12Keawxif04p8dWzrTEbuRvrC3yBE3xQkXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606769; c=relaxed/simple;
	bh=iBze3ddOIKfLFzK1PdZekaZ25CQzX4/eyJkqv/S9OE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKLkYgOvY4tnoLvOgmKrvzw9xB0ewpmUpiWWIr9KDtd2ZQSXNkfu1rJGPXEPom9uYqTIuryAeC7tQ/UpFg78Fh9gjUfxoumPkM3Mp3QPOckR9c9SmsB+8sK4t9uo46FLq2hehcZs2SBEYW9yUYSY2Igyl49L8FRKoskCoxHod+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7sFHNFp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78125ed4052so729195b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760606767; x=1761211567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qk2LA4WjclYE0CKmbUH1V37mhz7MI29tST0rKIcgrs=;
        b=c7sFHNFpNu3v0X4f8ofeTAqwCvknT8qwOus8U1fcSkrAQg/uRWnP3ZgteZlCVUfULX
         i1T/NmU7qDf1tE2MS8Uuap8Cy40p2EdhhyRrL2UUQMnwQyzLOl03bIo9bMiOc2Ebi5nD
         ZeelpYRHMf7B4SGCtC7CJkq+kJ6kiQf/V3Npmh1+jF8nd5ghPGLYwVXaeBRKhHUOWJ5r
         t035Y9AK+eQ5QXGDTdxjRSjhSIcNWvjhlxbQjF3GYWHZ97SMPt4fRbz0Et4KXkQyDgc4
         A5xmwwTfVCayW1ZRXbagqpMNa3p6YMKzkLGhwckTDBh77x+hpMWrOiPax5JrBORwNUqy
         ZVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606767; x=1761211567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Qk2LA4WjclYE0CKmbUH1V37mhz7MI29tST0rKIcgrs=;
        b=SclYZRqlD4WAJmFChJUO1jVBQoZsrxDgV6MszdCIedubk/OMoaSg8JZOvPqpOxN3mq
         csvEurY51UASeiASKSk1n/VjKHjncH/uxLKAF8qcEpnmIHOMl56uvSK0D1h2sINFe9aj
         hILh5BwKhdaUHhqMyDNwJe7Du0i8YQDZO8fl3XbIrM9tpknqWg/y7IZa90V7eXUWhCHs
         Bna2xSbqnui623lM1ySO+Cv9qRMlRgjCP8dapkXYrtZwLUtzTBp/n3EUzbPw+DEDSD+P
         /eSWLu7cHyeI2TB89Y9dzxb5KZDh1QVbgjDBHn3Z7altYNQuz0VkjFBWYcueFdsOCylW
         NBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtxTat4ZXbjDspQLKW/RiZ5JNGjpXyR1A2NHogupd91F9vwGwl8RwzqoO2YBkyRXlzc+jaCZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRM3XKQHDqnLOjEPLgOaJH3kKLlKOWqqL1uvLT0WSyfpsfNDdz
	KpTl+8TxTLPP+4j1bNASCRtv2UYl39MSfV48pgJusl+9/mQzOpa7w+MP
X-Gm-Gg: ASbGncvDiU90B80tXcJ0S4E9T3V+L+RgGpFd2n8+2i2qFOwxFa39TnD1Z2ANiAivkIJ
	9My8wYn2fexehG09NW/zp383iMMIYoy3nY62uW/3Zv1ujhJ3QyU0KEUaBq2wFSLjtw5htj5cLss
	+WMM93qeh697MB0/Izb/zKpWlBWndYVl9F8mdg52vu5+PgeU/oxC1NjBsJBZBqaKpM0FAvjgEwn
	HPGpLaMDPwTjYLK7NuQ2AT1JjWR9bViPwrBLL9Yq5/raBvKqhLkaBEI28HlVLfN22NFiuf1xvDP
	sB2vS32VqCE5/KGXvs8ZlzlxhlwaVyzYmZjeaPs4CjGdl5bEEQ941FSJAgu65PsWFiwP9w9hObI
	ZAA2WwoZUJ7XTg+wDyH8vcwdXgdlByTKfvWC8ppU5jg2yJH1IA4lcUtaPLcYmQSUUQmtquEGPzZ
	ouLgmrL19DWIR94Q==
X-Google-Smtp-Source: AGHT+IG1PdmRmxoRDMSi5DK2MpnEmPqGVIP2q7n1nkEAGkLjqVGAPOgqQssfSdw9ZAOJvcdpLJzgcg==
X-Received: by 2002:a05:6a00:13a6:b0:78f:6b8c:132 with SMTP id d2e1a72fcca58-79387c18f0amr39958615b3a.29.1760606766779;
        Thu, 16 Oct 2025 02:26:06 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060a38sm21903407b3a.5.2025.10.16.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:26:06 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 761B640C0938; Thu, 16 Oct 2025 16:26:02 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] net: rmnet: Use section heading for packet format subsections
Date: Thu, 16 Oct 2025 16:25:52 +0700
Message-ID: <20251016092552.27053-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=bagasdotme@gmail.com; h=from:subject; bh=iBze3ddOIKfLFzK1PdZekaZ25CQzX4/eyJkqv/S9OE8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkfdp4z4zP/tXdvtJUyw70JEnz/uQySsze9La/wfti74 g9H0oK2jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkNwPDPzML4VeKWoEz70nO eHasyOLtJ82FE1y8245+yzv0qrr060mG/17LJ6TLhfvMj5rMJpKa38DaOOdChJ31ZzPZ6ouC5ao nmQE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format subsections of "Packet format" section as reST subsections.

Link: https://lore.kernel.org/linux-doc/aO_MefPIlQQrCU3j@horms.kernel.org/
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../cellular/qualcomm/rmnet.rst               | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
index 289c146a829153..1115606496b67d 100644
--- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
+++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
@@ -27,7 +27,8 @@ these MAP frames and send them to appropriate PDN's.
 2. Packet format
 ================
 
-a. MAP packet v1 (data / control)
+A. MAP packet v1 (data / control)
+---------------------------------
 
 MAP header fields are in big endian format.
 
@@ -53,7 +54,8 @@ Multiplexer ID is to indicate the PDN on which data has to be sent.
 Payload length includes the padding length but does not include MAP header
 length.
 
-b. Map packet v4 (data / control)
+B. MAP packet v4 (data / control)
+---------------------------------
 
 MAP header fields are in big endian format.
 
@@ -106,7 +108,8 @@ over which checksum is computed.
 
 Checksum value, indicates the checksum computed.
 
-c. MAP packet v5 (data / control)
+C. MAP packet v5 (data / control)
+---------------------------------
 
 MAP header fields are in big endian format.
 
@@ -133,7 +136,8 @@ Multiplexer ID is to indicate the PDN on which data has to be sent.
 Payload length includes the padding length but does not include MAP header
 length.
 
-d. Checksum offload header v5
+D. Checksum offload header v5
+-----------------------------
 
 Checksum offload header fields are in big endian format.
 
@@ -154,7 +158,10 @@ indicates that the calculated packet checksum is invalid.
 
 Reserved bits must be zero when sent and ignored when received.
 
-e. MAP packet v1/v5 (command specific)::
+E. MAP packet v1/v5 (command specific)
+--------------------------------------
+
+Packet format::
 
     Bit             0             1         2-7      8 - 15           16 - 31
     Function   Command         Reserved     Pad   Multiplexer ID    Payload length
@@ -176,7 +183,8 @@ Command types
 3 is for error during processing of commands
 = ==========================================
 
-f. Aggregation
+F. Aggregation
+--------------
 
 Aggregation is multiple MAP packets (can be data or command) delivered to
 rmnet in a single linear skb. rmnet will process the individual

base-commit: cb85ca4c0a349e246cd35161088aa3689ae5c580
-- 
An old man doll... just what I always wanted! - Clara


