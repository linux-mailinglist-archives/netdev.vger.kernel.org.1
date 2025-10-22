Return-Path: <netdev+bounces-231515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C99CBF9C5A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03823A8436
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE9C214807;
	Wed, 22 Oct 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx9rxgF5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD55322A
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101728; cv=none; b=NzhP1Rb/+WkAZT3A2Gb7kLBt7RjTL57IfysCt5WqadwhhADgR8uuaxcZQzsIvgHcgYkskfVK6DiI1wAks4QFlMZUMZTwo1XB/3WB41rOx4Y1tPzxlOtKgRPwm2iH8pf0w3Z/88dkxI8S9AQy7uzYyWnpZfVqbspGqdpGaNv5y10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101728; c=relaxed/simple;
	bh=ZrtvSK7jB4iwBAh0fO0oro7IBTovy7isMjxunmOiW34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebkYaaRLGNZe87qsk4sOouQxBd8oPg74DFq2cdh5NmgTpw3Ca9BQrAjkhRtrzJKvxSktSBxulkiOND2eyVfQK6iejdxyZ7pj40IIEts9RsSx7rrofpjYFYYiKj9P+e/UbS0I4hBIjeCHvkDrQYneLs8PO1jfVLy+7/hqg+9NuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx9rxgF5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290c5dec559so50849355ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101726; x=1761706526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPky2Dr4hSQM4X8209nAybku8lFOdlCo9dChOXhSn7w=;
        b=gx9rxgF5yCDjzfHU7IuloYnk4no07vSFSDB76rb5CTSw8jCH2EBYLJrHjNAV+QD8Zk
         DThIgmboZ42Zd0iyuW2o3eu0ltNkRU/ZQpKbK+gWeJ0ivYRn7hQgfNnivaa232FTiDLy
         Wq2jGJTm4u9h1HrU/YiusxYdtJBULym0/eqxJeAtpNbR72w4Kmd8H9d56N/MTXiaD86D
         C+rU8NozMGjYCmenkhwMAmoiyhWLptWnklR8B4PYaunwltsV6C7Ex5SewLufPVGeJsls
         3D6pPH9e80ZsCdv9pSZZRjSOQ1qiFETnvn7x79HW5+fNJ6+un72OK5rsDrcvcnlrirNs
         q2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101726; x=1761706526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPky2Dr4hSQM4X8209nAybku8lFOdlCo9dChOXhSn7w=;
        b=Sg8JCqTVF2XVRu0E7JsoWKA6pt3VkR5O0ut+9+Utz75+UhqIxCSIwrWfGGYv66K9On
         tJCNHtdbvtB3TMclVvpCca1V5lqeHWhj9jxtvE9klOnghQHTyo94qOEAZ25/1H6oya5X
         aqkOQFngYsv8egszEGXgeDuG214Oz8smiXtuXmlOxlY1Z6mvh0xavf9BQU+U0EEzMsw5
         BGz3b//L7k2DnjU2BXyvP1eL0Srq7aC35CxutxSJTevMoyATUcEgj0qWl91BT8SHwgTx
         0mRnf3csVnmldRnTYSvXjFcIgOWliAjV9iEMmV5I8uoR57XodTM3ndc6Jb/Y+twIeNrt
         +u3Q==
X-Forwarded-Encrypted: i=1; AJvYcCURM9ig0WRZjVYDHgoNaIK6DKWGXe9EaIydedf+5oDdT8+9fLKQXvhXCh8dxY4bmhC3c+1bMPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3Ht/uQoFzpdvwsebm0y5/LJsMh/TgT78dJeJV5vTvI3ou8x8
	2tf0LCed4jGyKrkZ3cE5DXlFZX2LQNnicbUN4zHF6TjVC91Zhqb/jLX2
X-Gm-Gg: ASbGncuFVBi1XERmJmXavjjZIaFGkRBC7dd8luhR7aLndhAYivGODb2nNAkwNKAGTRr
	SNWxlD24HibLp3E7cVyBaluuxvzpSZ7kdsvxbSeN57Zypyadf95YfqIakcowEHPBNTRHPC+NFfY
	mH5KOEUAk6bFqfWxHaWEYjIyb6brHDkSgXTraVAZYTa8nRaFqoARLPkVg0x7PCblo1U5as+WCfA
	K7jxT46Qo63tgJwkpRYQJS4l2hjfcVDq1mdBNE9L2fFthD4c0TPAbfNqtTJUT/qiHyzI2xub0t7
	BLfmu0V1dYTPsGIfzIHJhIpwqOcPfEFjA0DkV3gYpdtYeaRUWKk++Gi/ElW1uzvzF3tKcK/xocx
	9UHAvdcYZsKJKn/TmZfL7hK86A6HYtbw8HNfYU/ch107ph/Ds4fCHwHKHfBiv3khB1Mi7gVET1N
	PygMSspM08jyz/
X-Google-Smtp-Source: AGHT+IF3djNIS7WVATUe83XXRS6aA9D+T77xapsJjzDewNLTQQ9xMPqmOrivckESaDuZU7VdzZJBJg==
X-Received: by 2002:a17:902:ce0e:b0:28e:9427:68f6 with SMTP id d9443c01a7336-290c9cd4d59mr232428945ad.27.1761101725760;
        Tue, 21 Oct 2025 19:55:25 -0700 (PDT)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7e19sm1005066a91.3.2025.10.21.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:55:24 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CD5934241829; Wed, 22 Oct 2025 09:55:12 +0700 (WIB)
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
Subject: [PATCH net-next v2] net: rmnet: Use section heading markup for packet format subsections
Date: Wed, 22 Oct 2025 09:54:57 +0700
Message-ID: <20251022025456.19004-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2656; i=bagasdotme@gmail.com; h=from:subject; bh=ZrtvSK7jB4iwBAh0fO0oro7IBTovy7isMjxunmOiW34=; b=kA0DAAoW9rmJSVVRTqMByyZiAGj4Ry2gyX0MRLPqbia0igTNfutoOdLbqzUVsP6RDDWyvmEPI 4h1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmj4Ry0ACgkQ9rmJSVVRTqOUtQEAm58D 549RYpDUAIN5+kudZXDIlihx/ZkYhjQ6/oWP5ZEA/AmNkHNiuXMpFU8YZ2Pcj+h2TTsRJsO5IhK agiCrIGYH
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format subsections of "Packet format" section as reST subsections.

Link: https://lore.kernel.org/linux-doc/aO_MefPIlQQrCU3j@horms.kernel.org/
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  - Keep section number letters in lowercase (Jakub)

[1]: https://lore.kernel.org/linux-doc/20251016092552.27053-1-bagasdotme@gmail.com/

 .../device_drivers/cellular/qualcomm/rmnet.rst         | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
index 289c146a829153..28753765fba288 100644
--- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
+++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
@@ -28,6 +28,7 @@ these MAP frames and send them to appropriate PDN's.
 ================
 
 a. MAP packet v1 (data / control)
+---------------------------------
 
 MAP header fields are in big endian format.
 
@@ -54,6 +55,7 @@ Payload length includes the padding length but does not include MAP header
 length.
 
 b. Map packet v4 (data / control)
+---------------------------------
 
 MAP header fields are in big endian format.
 
@@ -107,6 +109,7 @@ over which checksum is computed.
 Checksum value, indicates the checksum computed.
 
 c. MAP packet v5 (data / control)
+---------------------------------
 
 MAP header fields are in big endian format.
 
@@ -134,6 +137,7 @@ Payload length includes the padding length but does not include MAP header
 length.
 
 d. Checksum offload header v5
+-----------------------------
 
 Checksum offload header fields are in big endian format.
 
@@ -154,7 +158,10 @@ indicates that the calculated packet checksum is invalid.
 
 Reserved bits must be zero when sent and ignored when received.
 
-e. MAP packet v1/v5 (command specific)::
+e. MAP packet v1/v5 (command specific)
+--------------------------------------
+
+Packet format::
 
     Bit             0             1         2-7      8 - 15           16 - 31
     Function   Command         Reserved     Pad   Multiplexer ID    Payload length
@@ -177,6 +184,7 @@ Command types
 = ==========================================
 
 f. Aggregation
+--------------
 
 Aggregation is multiple MAP packets (can be data or command) delivered to
 rmnet in a single linear skb. rmnet will process the individual

base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
-- 
An old man doll... just what I always wanted! - Clara


