Return-Path: <netdev+bounces-237680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7FFC4EBEF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 110074E8A1E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558935F8B4;
	Tue, 11 Nov 2025 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvg0QShI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B635F8AA
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873959; cv=none; b=cRUUEeOj7ZMHofdzUW7hxiu2Hqs/b6DQc4amugmf3+IX/w7XWkwDwltluAGXl2dqUL6F6QcAHBE3dQ6Q++/5TIBOm8LXek+Gq5+VR0QDrKo/dkgTh6zJmzTEVZYt3CNsF8xpzvsuD9h4mwpxkOpZxu5MLwQ2QNpPDgNoU8kPx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873959; c=relaxed/simple;
	bh=79OC/+FRv2DJBSmzD5tzI2NUzkyGf6LEhQqlvzyTndI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VZGMMgAd8i2tklZikg3kY/Uiv87bczqPyISlZNPvSWZN3px//acUqrMYUzNA4HOxrKTQQModCe0EeRVjmFJZm2cEaFN9jG4xooL1dlFcHN19kJ3JzAxe7jdLxTmMKeqJlQM8XM2ZlZWkRiZQoH2RzzGeYsuDdAz7qBGg+LUjEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvg0QShI; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88050bdc2abso135474626d6.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762873957; x=1763478757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yp0KzIAbRX4RNvIKY0LsBbBAAPBH7tRFuwc0+mDIspI=;
        b=cvg0QShInF3orSl7IxzJ6S7fNmoQFB9GxuoGHkpcbUJIKdFVb74PZ6PJ7zQ3hQrnot
         01VuCVvzBJSV1UPiwRUSwWVF4Njv+vTV4ZZlQR0KowBcPsvHbkB+gcUsDwCNtrDK+ZO7
         Yhy6HWLMr2/JKvKO9Z+YM/VcIVNlQcNNtH8YqqqEMD9TnqO2qzK8bdKYa1LwfYT7fsf1
         16dJKiIrmdJBi0awmyjpg2aVw6201+1J083pzdXmgwR7AwKCjhlkgS+NgWdXGrBH01LC
         4nuaXSONKrcnnuIj8xaOPhiUqiTDLTQJSDqBKa3u71BID5ol5VznZutus22pCpBfx4IS
         KWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873957; x=1763478757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yp0KzIAbRX4RNvIKY0LsBbBAAPBH7tRFuwc0+mDIspI=;
        b=YogMnmsN7Op19L4YuT7gBn8Jpoa9P3cCv7WoTOW04T+w6hJT4MvRKv6vPlcfZveJjM
         yZaUnJk/91BqZo2iT9rCbE4Q2UCp/mr6807if8mzI/ZVcqNfjErm+IKEZakEcjpOM4v1
         22rp9gnwo2PubHRzdRpl6gNTdNoJOj6lXpcsLIe8zLzL+lhAiB5ucAaYS26nizZagFRh
         2nVJyx+itMoRnsvUJ0z/uwwByOeKoFpDdhLbfJKSmjoh3p9KJKvHgo7wBn48wRtWpz+f
         FOpXcGktxoavKP9Gag4cTP8N61XMCi0XWmAr9Cmpmev63+dep4y/hRWWpiyFlhM5jtar
         W91A==
X-Forwarded-Encrypted: i=1; AJvYcCXDddqt6hk6jjTrfk1sct/CY6QO1A9GKy44CFyKxeHJK9SfcbxJsc+s/XC9Hj2snwo3wwqNeA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzvkLGq6jy0wKO4kZw2aDCMXIdC2O2rhF9Q7sNCyxUO03fWvT
	s/nQS6vwHz+3D36S7ZL0k0qhTqp9ZOLfaFO86CGIzLi0y4w+Bt3ER7K2bGVQBqdmG3vytkZm1CD
	7ed2CT0bpZfdoUQ==
X-Google-Smtp-Source: AGHT+IGXUOfw4hrYdgoeecFeBbBjgMupa4tR7oHBcavDdww0XkExBf3oGFzGzzRbbeyBg1YoiRbe8kpfsdfUTg==
X-Received: from qvblb25.prod.google.com ([2002:a05:6214:3199:b0:882:3ada:c127])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:20ef:b0:87c:f97:7acf with SMTP id 6a1803df08f44-88238703304mr211849196d6.62.1762873957305;
 Tue, 11 Nov 2025 07:12:37 -0800 (PST)
Date: Tue, 11 Nov 2025 15:12:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111151235.1903659-1-edumazet@google.com>
Subject: [PATCH net-next] net: clear skb->sk in skb_release_head_state()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

skb_release_head_state() inlines skb_orphan().

We need to clear skb->sk otherwise we can freeze TCP flows
on a mostly idle host, because skb_fclone_busy() would
return true as long as the packet is not yet processed by
skb_defer_free_flush().

Fixes: 1fcf572211da ("net: allow skb_release_head_state() to be called multiple times")
Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4f4d7ab7057f16bcf88f29827a45a9f4a8f43d5c..f34372666e67cee5329d3ba1d3c86f8622facac3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1152,6 +1152,7 @@ void skb_release_head_state(struct sk_buff *skb)
 
 #endif
 		skb->destructor = NULL;
+		skb->sk = NULL;
 	}
 	nf_reset_ct(skb);
 	skb_ext_reset(skb);
-- 
2.52.0.rc1.455.g30608eb744-goog


