Return-Path: <netdev+bounces-233851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F314C1929B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3543D565389
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215132274F;
	Wed, 29 Oct 2025 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhOUqMRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730A32ED57
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726394; cv=none; b=ehRc3xCg+D3ArF4p9146wNYlHcrbEIQRdWc/hkcIJAcGSlmzuVKoR6uS3pEEvpPpJhNWj6qlGz4bgkEf1K3AIRBdswmzEnWSXkdyLsBr1Mw8Sp0ZQWJMmrrewmyhkRqdbMRssh0jXtkVHXgF7CmzlDKsvxLa9Y9wh+fAcRGD1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726394; c=relaxed/simple;
	bh=sF2dC0yEoZfqsMqlw23WcrsBb8sQVqBQWtlJoeU/pAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzktLAUd4xfFx+OIg04Geoxzsa50y5idUXMcxQOTOsUFqsFkh89rAgWoNZyjG2s02Ze+8m1PI2IO4kuuFdV/wo84R/DqIkk7dvNm//6jsa0/P2QoYdAQuzcplmqOEwb2uA2JCGTdoqIcJTMYM4VRfDiy1QwMFQRSCRN3t9wPFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhOUqMRB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso1005125b3a.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726392; x=1762331192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn0tHntcIm9TXsQwef8sNUxYfqf9R0uILDPExZJh0QE=;
        b=AhOUqMRBS0xyASLrnCRYf2ZPSq2eR/Raby/ourfh6kYxEsV7ujJHtGrmXM+ULGpxqt
         rT3kuYxau9VH8bVDKI2NqtsgnebKxoRrMdVBgGd2DCPBHlLeIXWRg64u3Jehw28MOyOn
         KfhTzGlXHSGMwcaHkaIUhJ7j/v766QFjOdjBRAqcelELGsVsfRb1KCf/jCGwokFoHMSM
         FwlBEvAuqYdBjkKVgmIYPwYArQmPKeoC9drjm9nLGR3LFBmTw+1d1f7UKtlnO+0EDCWi
         Yyz58rdzOHR5blTztCaZpw4otDtfDWzegKjf8tnMlmb3hJXHh0RARiXpkKZpt7rCjSW5
         5nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726392; x=1762331192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn0tHntcIm9TXsQwef8sNUxYfqf9R0uILDPExZJh0QE=;
        b=HjWN8ugO7XAJVKsYnPiHaLj6dpwr/byLBZvdXJ/wIwZi4VQG/+4Wd+gDDrkPdzEeCp
         HCYAQUURDnmPbfSSADtWdedDfyyaBeecWFq43P+T4JQ0bO7m4Z8SqF0/h6Vj4xQUJ7Lq
         kee9BDmGeFAQEUFJwkJDBadTXMD0bmS3RC6uEqVxc/kzaXuaGKqPjVC12xgzOFe43vci
         7lhXsHyqxdzmIoQmKNLkngIGGED8agjYL+YztOtXqN+q0edzgv7XeaZfBwVqZc3Pfbfg
         SBFYY4c40gkcpdZhR2F2kjO16LLx7p83uV6p3AYDx+YQMbj3pA3IJBtwLbj5bR5L2lKT
         in6w==
X-Forwarded-Encrypted: i=1; AJvYcCU3/h996H6ZTGXomb2jbPSlIEFE5tLASgAKuT+Ekw8DG0IFBZ5kHSUd7bWvzzzQ0EycukxfFCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxollBT2KTAW0tE28t/h6zBYGaolwpXuXyAfuy0i1sMA/dv4xsw
	wWcjngfXzMyl2Dham3ippWCiwA+p6FHEoumGX4+JjZwRtxGae78kvEZB
X-Gm-Gg: ASbGncv89aMBJXoli60m1G5mpMUPVoN3xVnWfZznjnRKs5HaQNRHlp+P/qvWnAQM9xM
	bF7D/T4oI3XLzjl/rqriqBP2vYK64Py742c+xBHPrC1RwW5ZpcnLpkuOf/6cifiGsFw4AMVP1Zd
	/CGGRwP34fVE64idAa/9u0viOV+OX7aloTh/zcNm30CnY1xGNrGIyhMi/rdTN+up97QZf3z7sMA
	5goRpMW8L46Sc48mEuDKM+yWt2+x0IsKTBNMvw1yAw4dt4VYiAaQpS/fzetklEAigZxY+WRghM3
	ssD5uEEAcFqdHSB4OqOUwB1yRCteX4Gvw2n3iMeTAkkcNZQRm19SeNaNZ/ESwmRpOMqy/F/wXwq
	N0XUe1ZM64a7Sg8QyJs5HjqoKGQv1WeOe9gR5l7+Q62ap/iiYennvnSIgglJA4uD6Dl7nhYIcsu
	cZrsP4z8O1R1A=
X-Google-Smtp-Source: AGHT+IGaPtjJNURBFreVhHociDTVO8Qt3Z5yfA7jdZER+9HScrmDJ5QCPbGQTLP2IHCC1IeBVmLIIA==
X-Received: by 2002:a05:6a20:4328:b0:263:4717:53d with SMTP id adf61e73a8af0-3465381698fmr2495369637.48.1761726391775;
        Wed, 29 Oct 2025 01:26:31 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf6accsm13075614a12.14.2025.10.29.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:26:29 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4EE824201B81; Wed, 29 Oct 2025 15:26:19 +0700 (WIB)
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
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 2/6] Documentation: xfrm_device: Use numbered list for offloading steps
Date: Wed, 29 Oct 2025 15:26:10 +0700
Message-ID: <20251029082615.39518-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029082615.39518-1-bagasdotme@gmail.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=bagasdotme@gmail.com; h=from:subject; bh=sF2dC0yEoZfqsMqlw23WcrsBb8sQVqBQWtlJoeU/pAs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmM5zUM9v13EGe3tvn6LGGFpkSJcNtu3neHdaPPH9v+T /f7rjD5jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExkazYjw4Ir2UHbpfU4bh8I +d3Xec7o4ZqlBavYLjF6bl0TOSsmKpaRYWKL+KoWH+3XKvIPVz+7vPilZoDbHRmPd2W/N7U5emW u5AUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format xfrm offloading steps as numbered list.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 7a13075b5bf06a..86db3f42552dd0 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -153,26 +153,26 @@ the packet's skb.  At this point the data should be decrypted but the
 IPsec headers are still in the packet data; they are removed later up
 the stack in xfrm_input().
 
-	find and hold the SA that was used to the Rx skb::
+1. Find and hold the SA that was used to the Rx skb::
 
-		get spi, protocol, and destination IP from packet headers
+		/* get spi, protocol, and destination IP from packet headers */
 		xs = find xs from (spi, protocol, dest_IP)
 		xfrm_state_hold(xs);
 
-	store the state information into the skb::
+2. Store the state information into the skb::
 
 		sp = secpath_set(skb);
 		if (!sp) return;
 		sp->xvec[sp->len++] = xs;
 		sp->olen++;
 
-	indicate the success and/or error status of the offload::
+3. Indicate the success and/or error status of the offload::
 
 		xo = xfrm_offload(skb);
 		xo->flags = CRYPTO_DONE;
 		xo->status = crypto_status;
 
-	hand the packet to napi_gro_receive() as usual
+4. Hand the packet to napi_gro_receive() as usual.
 
 In ESN mode, xdo_dev_state_advance_esn() is called from
 xfrm_replay_advance_esn() for RX, and xfrm_replay_overflow_offload_esn for TX.
-- 
An old man doll... just what I always wanted! - Clara


