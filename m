Return-Path: <netdev+bounces-129482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5D98416D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831A9285919
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6809176ADE;
	Tue, 24 Sep 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="zYFb+yGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466A175568
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168486; cv=none; b=tRtQ3XZWF87/dvGSv+G7eYBqasLiJZxh7/Mo/9dWhZZXyKm/bi4YaHlY7gI8bIwmmhD4g+dXtWq95OMDprnTgdsZzW4/AhL7jLXLBWav7SReRbt01QXH+pnewhfkuYgN9roMsmBtJ2UFh1U9s4lpHl8Qu/jkYtp5V1WwTy4M+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168486; c=relaxed/simple;
	bh=ewPtrkqvk7tD3P+mpp0by+kAXiz3ZKe4MhDOXA8p8qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Ns5FpIsWoGSaDJHGy8Kvh6Bh0AMlQN7sjA1oX2X6cAw59F/jXD88J6kmuVG2RmTEnSrLpxO5JjEdP1xBxodEwVYVvXHSdVB7voelpYw+c1OfcYo/Y+NrNmYx5TFkTw5oA5EoMobQFguqdEcrQPGrfw6gzhP2aeHa9FIfcNl2At8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=zYFb+yGH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so8095763a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168483; x=1727773283; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqdM7AXxfnozdS0h/go68YV5to8QygcNOYorhOUDEHE=;
        b=zYFb+yGHY7hDTToG5WBFWR+RrE9rxARBX9dwK3FqcSTWPy/dFaxkqQF/jzIkWNjKaj
         bvv29kIq/0OSOhQUs4zsMSlfbS370rB8dRZEJhJIwIpAfTX/rE/uGVZF+Bkh1ewIGOxt
         K6PW/7XV5/kcDRei6HqtKkOYgPMIfo1vMxKubwwtGMDnh+cYbwLQgUL/cu30fhYTQjZe
         YV0tPZ40sEFrg3GzSgPxZLRiwc/YJQmYteVhWAC9PL00kchIsqUAd3zmo+FTwcbpaB8L
         O/vXdhEGHBDGICjaVA0CSIhvuIpM2bSayPkqQQ8XSActDLWUKPmR8916zbsr3iR8I5X9
         molQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168483; x=1727773283;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqdM7AXxfnozdS0h/go68YV5to8QygcNOYorhOUDEHE=;
        b=NeFOVcjCzkhYKyno5RxQtA+kKsKqv2uzpH30wo2ISm0VEM9cAz+iZy7n00hscwtkpR
         c0ipSPxsh0LN7uwa3FNFiiN77FlGVJp3cVR0zJvr9gnyLzhk1DLN6HSMSws+uCwAXgxw
         zmRJpuYCMqjU4JCoVjcoVk52YOKaSiufNcjDGB22X4DKK3LkigFpR6waqPWSUQwVQtBZ
         J51yhHoGr37gikxkWBapKGOyX+NqyFfpfD8fxAdk1jObd/umFApL4XNhYIqRhc1Hp/Ve
         xrR0GJrFJTZ4GmFzlk6AlEoEk1MMJfggC7ZZrb6B1u4uS/liIAbN1CuuKATU8Y+H6HcC
         sEcw==
X-Forwarded-Encrypted: i=1; AJvYcCWMPwuutns+6GoReNmenb5efqIs/EiINYkQf+ezoSrDnm6BrwrPG2xMegZ2oGBCnR6lykPMP+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YGf6KB9pX1jFosnUsvYQgtrZM9oPBoKohnM9h2aei7/u3/Cb
	KKlLlk8UgTh8NBGvRg/BjWZ+GuipSlPot4Q9b5oTGMISk26Tn/FowxEfq6cewkA=
X-Google-Smtp-Source: AGHT+IFYf5KaP4Pzb9vgh1qbbep/BjQkKcAMhxJhINPSfPa8KAAu/uVDRcfMAnuh0Cd6Ah0QYwKNXQ==
X-Received: by 2002:a05:6402:34c9:b0:5c5:cda5:9328 with SMTP id 4fb4d7f45d1cf-5c5cdfa04e3mr2809831a12.4.1727168483131;
        Tue, 24 Sep 2024 02:01:23 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c5cf4c52aesm526635a12.59.2024.09.24.02.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:09 +0200
Subject: [PATCH RFC v4 4/9] tap: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-4-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

tap used to simply advance iov_iter when it needs to pad virtio header,
which leaves the garbage in the buffer as is. This is especially
problematic when tap starts to allow enabling the hash reporting
feature; even if the feature is enabled, the packet may lack a hash
value and may contain a hole in the virtio header because the packet
arrived before the feature gets enabled or does not contain the
header fields to be hashed. If the hole is not filled with zero, it is
impossible to tell if the packet lacks a hash value.

In theory, a user of tap can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so fill the buffer in tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 77574f7a3bd4..ba044302ccc6 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -813,7 +813,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
 		    sizeof(vnet_hdr))
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
+		iov_iter_zero(vnet_hdr_len - sizeof(vnet_hdr), iter);
 	}
 	total = vnet_hdr_len;
 	total += skb->len;

-- 
2.46.0


