Return-Path: <netdev+bounces-143079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A741C9C10E9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F1F2842CB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA2D21A4C2;
	Thu,  7 Nov 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJa0EmOF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102C218585
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014605; cv=none; b=KQDo/ImZnQSGb0yTN/R0eM8rNA7WeiMnk9mK/mfHmZmQIe1I2H8hrbr9wg9KmJgthNrRowEneNQjaNsqEOPmZLXGXySoI20OzGqPkOE7vc4b4h7RUBh08VE1zYXS4MzN6J9J1pS952bD1Z+EFXnebcNB74V2JzteFZudNQCSBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014605; c=relaxed/simple;
	bh=hiLF67ZB3WMU8hX4LaHsXxF0Pkp+AKd2y1OkKzs23ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gX85dHajwBTWbHi3fw6oMUo68+Gg/3BGnu+6WVgfEwU4ehu6vuzxl8NcBF6u6X6D1GPIZlKft7JcoNHzY+gV3TWt6uuc3Ycfl3gTC/e1VLn9xA8TlcP6tQRNVzdyKrYDjbAL2FO2pPP0/OX1OY6ZU52e77tL7esyZma9rZ9V+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJa0EmOF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e36cfed818so22348287b3.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014603; x=1731619403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6k+P4diOLJqi5qBWB1cI5BvWrqmmxwXAHcITy5id4XU=;
        b=vJa0EmOFM2pai2ANMhzEIr9wzti7adtD5VQ1slkq2pc+aMhCGJRn6MHWUcUS01pTPr
         q5GsCJY6HnbLx8S9dVwJ0IuzFcAAj/G6ud8piEMRW3Mh8LetO/Vh97Ekrs6HYO0ksNMD
         kEz3AE5wCUf7DKmb2pBnxn9NyAb39UR+c/hxwKbpRtbfxdPyJa/DO9Tr1JmnPlsfmen4
         AORPOMEwr8ZxJ8SW/vbBLSMDgAt/pxw+X6NEYIr3O5Orbn4/stTdi3WkLy8klHABaqN/
         yHE37XGbMKC7SJLzBUe5/NLNXLrGk9BhJg7ItwHNRpIggCcA/4GSFdOn5lafUgdWM9AQ
         JIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014603; x=1731619403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6k+P4diOLJqi5qBWB1cI5BvWrqmmxwXAHcITy5id4XU=;
        b=mPUW9c1bCpSgB833p28gW3FtSSowgA7VmCEwDngPdUtmwmuU6TfexQ6AukHcUfSNi8
         E7iyGNVnaoTLIc5X71impI5z0fH1S6kAoZTrixIEzRzszLiGE/c8d7RQrxJawa6lMDeu
         vXDEd0KTv3n/WAt26lRigf5h29HP7JEj8x2rjBrs8uYvTWSQXaKPWzZDsK6j7J12eZ/m
         rocEGC5Nzok19pxsJaslbf38F9wEabE3pdMGJEzri88Cf2iDbBbHjEU7aTAyrCFLjN0B
         5+nDxzL2YxmjsmDmK9xFZrg+wJImEqZzYIlPjwPQm/M/sbYTMIyHKBT1VYiwq57T2Mfz
         XRYg==
X-Gm-Message-State: AOJu0Yy3Re7l4mZwlFTcOQ7TxfhZO2YpN+QgEJniZ21Uqd5vb1jnC0RK
	Z5xmhCdTy4070ED4rkvWx55+9Zdv6iJ0PhTzH84+10crj1vHxiB4SHaTFdfXDU6KrjC86K9Me1u
	v0pkxbnOdtuWd5NGKpFagQSciFufGmxurKdh+v8baZDc6o/Kp8FBYkfPr6TCJlbfNBUNNNfLAvn
	8lY2wkpaxWHPHCZoWpFgtZ5UcswBkghmrWdqj6v9szVxMe1SH046eF1mXduCY=
X-Google-Smtp-Source: AGHT+IF7xrqtzpYezRtSKaHI3uuKF4iJovh+7+L3DoGZk9NlkYM7SwDne1PSukpRNI4o5wYpQPfuw2lzr3HDcb/9AQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a0d:f4c5:0:b0:6e3:2693:ca6b with SMTP
 id 00721157ae682-6eaddd64226mr13067b3.2.1731014602472; Thu, 07 Nov 2024
 13:23:22 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:09 +0000
In-Reply-To: <20241107212309.3097362-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-6-almasrymina@google.com>
Subject: [PATCH net-next v2 5/5] netmem: add netmem_prefetch
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

prefect(page) is a common thing to be called from drivers. Add
netmem_prefetch that can be called on generic netmem. Skips the prefetch
for net_iovs.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d..923c47147aa8 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -171,4 +171,11 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->dma_addr;
 }
 
+static inline void netmem_prefetch(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return;
+
+	prefetch(netmem_to_page(netmem));
+}
 #endif /* _NET_NETMEM_H */
-- 
2.47.0.277.g8800431eea-goog


