Return-Path: <netdev+bounces-151674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B313E9F085D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108AE188BD5E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10E1B412E;
	Fri, 13 Dec 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqX9myFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDC1AE01B
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083254; cv=none; b=VoUgzoL0S/LcDBz+Em9J0xuMbTuhhEGlP0B3dPmpaDpoP1UgjFK8HguEHv4ifly/zfq5BjV6DaxtBTB7hmG0kDdcKwkmVXdpSArSlzg/83Y1th5Sa9qWwpb+DiKKPC5uM569B2xIU1Gts57yWH0NWUcymxLBEKkfazp+wTaPbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083254; c=relaxed/simple;
	bh=QftEkgPw/0GI0tdyO/fV+/Wq6wLc69fz7Mk4V7VnBf4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qFCIz3WJ9LIxqv9WbZXeQmFcXX8budc5RIdXTm/+HF8vDGLtnM4UzE0Rez1VOrLzZf6kozzEKDSEDx2DuDry3YuXxiYaVsbmCHhlKnxRFa+eNw5ZRP3/sda5abDZGpOSY3RxHLnNgDPACCKpEsvdM5YFEL3YBNpOjkAi/DV+VGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wqX9myFf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f249f3b2so1977159a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734083251; x=1734688051; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdxFYaYZsFwA6EnsM4K6iSZW6gjULgohyiFusWzHRuE=;
        b=wqX9myFfGq1RC5tbQJD7JL0OKd4Xbtx3irGbR2FR7CjeHh5YUUoLRZf/3G4Igx7EgD
         YS2F7+bDyBoAbimKmbco76d1K03ooFDYvVO4rsUvZZhlpnnQgA/L4CX+IGC7UsZCvGuP
         B6uOLcit1bxqK47Np9dp3jYtJQJ+B5FbeNwmOGmconQjCwWjxcRidQSSq+6titNrHvF/
         tGGmITnkGYO2RN06J6vJZfdJywPzv/6jFNlL6lgnicWJghJ1A1AlcFS+gSVcN+4YeeIZ
         Q7gbXzQgaMBhB7eHhO7Ye6n8YWq8zpxG0lfwui74XS1IxZs4epXQwwhQvIjTrLg3EhuQ
         g70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734083251; x=1734688051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdxFYaYZsFwA6EnsM4K6iSZW6gjULgohyiFusWzHRuE=;
        b=R6nU75U1xZ9ImlzGqsq10CErO9FkwGipJn/q8ymMaYTyxVK89CrzsznPcMHTLMPBCG
         4jwLEC3lP0knzCCp0cTIUsRkDxTZsI8thcfy2CtHb7jmUZA537PWtBqC8qrWfdGmj8V+
         yJDme+AWBZ4bQTc/zgaUyNsOC7f6D+Z1t9AKwlYIq8yLP9ok+uC1/dL3fN0FXDmkVPsv
         2rIpfXAIR5PHgUveP8BuhKIg2mn/fDEHYESV0sfbdO/c1RM8DI33rIxluJ5lReI2vv7l
         OV6P2R08hh0INyGMvFwXNg7Bd3S/WN5+PoMpaI2FO2PvJBHM/ZU91mfilvkOSasWyFUR
         FJvg==
X-Forwarded-Encrypted: i=1; AJvYcCUWu/pq3gslvJMQ5gJMIgUgJM8p9l7oRKxj1hWBEUqJ14k6+6j9eNORPNseJC9ti4qhLbpeap4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/W98VO+nl5FbV3O1+sIvacOZsIbzqJNdeX/Cu3mGBPvxwB4lT
	hN+Zjh+DnxfHd1BO2OHkRUjUxkQ0MH6FlFpPRL5IAKFXl/rgOM9NXWPRQNfVZa0=
X-Gm-Gg: ASbGncvychKRiemlbyJsOh4wrxKYfnxxRYZ+ySEgjJt6NsI2Cu5Sn3cyEeGLtu7y5ZK
	bXRuChS844MyW/nstfEVLrh2EL7va3a/S+aia6Ve82NXcuDrRu8+4mCy4e59RfuASgu3Xk9oI4W
	pM6G1Pqz9XRpauuFxFBox+v8PRxACnUO+Q7xQRFz1TnLQJmjxKFC1twYop1m5/AKxAP0l+PrmpT
	o3xktjw+CHaqNDbiJ1GZMWTnf6Emk+QKxmRSFKr+0MwbK/2KDjVV07wCrjzjA==
X-Google-Smtp-Source: AGHT+IGltlAdrz0s/05wujMEiapProTMuSaTetpEvSQ5pgYx7uxayECdPRY4Y4KRwu3RO0NYkPh3qg==
X-Received: by 2002:a05:6402:390a:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5d63c3db8d9mr4114411a12.24.1734083250584;
        Fri, 13 Dec 2024 01:47:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa671136c3esm814037566b.7.2024.12.13.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:47:30 -0800 (PST)
Date: Fri, 13 Dec 2024 12:47:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Atul Gupta <atul.gupta@chelsio.com>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Zubkov <green@qrator.net>,
	Simon Horman <horms@kernel.org>,
	Michael Werner <werner@chelsio.com>,
	Casey Leedom <leedom@chelsio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH net] chelsio/chtls: prevent potential integer overflow on
 32bit
Message-ID: <c6bfb23c-2db2-4e1b-b8ab-ba3925c82ef5@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "gl->tot_len" variable is controlled by the user.  It comes from
process_responses().  On 32bit systems, the "gl->tot_len +
sizeof(struct cpl_pass_accept_req) + sizeof(struct rss_header)" addition
could have an integer wrapping bug.  Use size_add() to prevent this.

Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I fixed a similar bug earlier:
https://lore.kernel.org/all/86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain

 .../net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 96fd31d75dfd..daa1ebaef511 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
@@ -346,8 +346,9 @@ static struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
 	 * driver. Once driver synthesizes cpl_pass_accept_req the skb will go
 	 * through the regular cpl_pass_accept_req processing in TOM.
 	 */
-	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req)
-			- pktshift, GFP_ATOMIC);
+	skb = alloc_skb(size_add(gl->tot_len,
+				 sizeof(struct cpl_pass_accept_req)) -
+			pktshift, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 	__skb_put(skb, gl->tot_len + sizeof(struct cpl_pass_accept_req)
-- 
2.45.2


