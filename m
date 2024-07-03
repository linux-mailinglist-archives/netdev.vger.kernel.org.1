Return-Path: <netdev+bounces-109060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDA926BEF
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91EC1C21C5B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D183194A51;
	Wed,  3 Jul 2024 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="b39GvHbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E21946AD
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047024; cv=none; b=G9B7K/dASPOCPv/k0CNETHJphDQdMIgICy5wR2A0TN9RQoQbEr/eY9LZInQzXXmRzt7V7jncX0bbQFZ9Eqa2UnJeRNxd7qwXnlhFDLQn6kN9/LfPOAScHWJGNtLVp6Uk/ioYDEiGjAcDF1Z+qMnadONgGMcWWmzYJVYQTFZMsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047024; c=relaxed/simple;
	bh=vHw3k/vnc0AvDY42UtMhOAkPoRPw+6C2GmDPX+qMpQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tRuOFU4m7nglCBZckNR45dImzHHrhKAli5xYtVvQ4Ln0MbOEnJObATXmvcqJS8hbcOw2+O45mvlspCyyR0Gkr6zCKescpoi1C00JgmqLJJTNWojhNdpRC2PfzHVhQVWVZf4UHbFDXcN36I6CXfu36QniX6SunGLCuphkq9sVcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=b39GvHbn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7594c490b04so847886a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047022; x=1720651822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVi8l9klyfMSdBgsqxGLAILZJt9Kry9cOTzZnzdmEuc=;
        b=b39GvHbnoYVbJYpaaRyr00zD90YiyML7kUaBZFtYD+w0Bd+/6KDCtqEzXfZlZsst4V
         Dmy2XJ4GwlKjxdY9PFbmyg2yNgo9qerhf75WaOr/qmvDXN7iO9BfsXKPlDomN17OfXIm
         cWCsywHNmaZZpbDAJzDc6ZXKuZoCkdmy4hws/lPpqrT64QYdvQ8xQzFBwJmIaec6MyDQ
         YorQTqdOxEnEpjwSM3RYB4xtKST54COnd9KZAmahULCUe0eopPmkt4ILDT7ggEEeDmpB
         x+1uaWfSre/ZRdVEm0EjHj7YvItMH7/ujMgKLDvMUI7KHjmn9cdofKvpdPCTQlLySeCT
         oM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047022; x=1720651822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVi8l9klyfMSdBgsqxGLAILZJt9Kry9cOTzZnzdmEuc=;
        b=rAcqC8cW5ZipAmR9CJvMme+WDVVAhsc0G4SDD6amNrh16bZtJ1Uw75+qC5AUpaPLIf
         b9oH9S1SU7PMzHm6c9oync0wSxeETyksTgGiJq3nUeNnOjMYYqC+KGy6CGKw3G8szS3s
         0z+KH2gQP3u7Hj3rRAitol1qNALGvdaG2UisWKSwWbUFRGXM/tpZBxWq/IAba727H6cM
         FlbjVi9/lsN5JCGpLiYd7vk327YMoy9SGeb1XrCNco/UnoYm81AwVohkBb3e5XJbfv5J
         kIRrQQUXgAb4CSPlbyE+seT/fAyS5mlriSEtmZ4HcQWujoe+p3joE1qtLP3lhsrA0EnB
         S9JA==
X-Forwarded-Encrypted: i=1; AJvYcCVJYtVc2CzsGvMFfusms4hnPhQPRE48pZkalePI1lipWOBxul8BuPtoeu6Lax+hzUYkZUWugl270Go+z24pb7loqVVgyeWc
X-Gm-Message-State: AOJu0YztrQsSCGbwLLvYkouBzSTilQctHMe0meMRMxBtqgloxSkZNaBf
	ux9ASE2vgyB3UEBiO++6dGlxRAi5rh69sxf4tvrZAOZMjtpilykmCHlkv5Gh1w==
X-Google-Smtp-Source: AGHT+IFht41aqWqSjVGLHDI9b0xQXkAqs9V2n3rCUh6l+b23xLlNxGl5rysxtTyVbIqkQCviw+yh7g==
X-Received: by 2002:a05:6a20:a988:b0:1bd:27fd:ff56 with SMTP id adf61e73a8af0-1bef6243146mr13268444637.58.1720047022496;
        Wed, 03 Jul 2024 15:50:22 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:21 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 03/10] sctp: Call skb_csum_crc32_unnecessary
Date: Wed,  3 Jul 2024 15:48:43 -0700
Message-Id: <20240703224850.1226697-4-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703224850.1226697-1-tom@herbertland.com>
References: <20240703224850.1226697-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for CHECKSUM_UNNECESSARY, call
skb_csum_crc32_unnecessary to see if the SCTP CRC has been
validated. If it is then call skb_reset_csum_crc32_unnecessary
to clear the flag

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/sctp/input.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 17fcaa9b0df9..aefcc3497d27 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -124,14 +124,12 @@ int sctp_rcv(struct sk_buff *skb)
 	/* Pull up the IP header. */
 	__skb_pull(skb, skb_transport_offset(skb));
 
-	skb->csum_valid = 0; /* Previous value not applicable */
-	if (skb_csum_unnecessary(skb))
-		__skb_decr_checksum_unnecessary(skb);
+	if (skb_csum_crc32_unnecessary(skb))
+		skb_reset_csum_crc32_unnecessary(skb);
 	else if (!sctp_checksum_disable &&
 		 !is_gso &&
 		 sctp_rcv_checksum(net, skb) < 0)
 		goto discard_it;
-	skb->csum_valid = 1;
 
 	__skb_pull(skb, sizeof(struct sctphdr));
 
-- 
2.34.1


