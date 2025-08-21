Return-Path: <netdev+bounces-215647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F53B2FC5A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB3681D07
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77222E402;
	Thu, 21 Aug 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGk2N7XA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95C2EC551
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785945; cv=none; b=Yp1oS7imEU6GhctE99QA0vrEJFTCSqxVAG/AESgd+rlxhlzwuA+5gInSsjlLJvJMdRAz9HboQNwEuuWQyKLf3ybFrw4+PrwrvC7bnovT/BbK3F8A2lWz75x83DCWFdyOF/1FQNbyuLY9FDRlQcC7Ngg8+gW0htBoPFqa56zoP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785945; c=relaxed/simple;
	bh=6xF82VyN+oTiJWFjcaV4OJQs7JKYXYANgE4CpxIQ5wc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gx6/Hz3kknSG6YiKpoucpnI1TlXrSKzlubedw5N94/gBLLKuYbdacv0sBIDOg4D3xyUaFDzWzmUW2sckuXE2C4QmpQRIP+Mp9TptkE1+UPKnfGi77vdq9EJN1okNwsEc66/9C/9AVpuktiwoEvCh+Wsl+fNSdIHrQzDsvYUZarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGk2N7XA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e931cb2a9d4so1343805276.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755785943; x=1756390743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jkmAz7zGn6zpzjliAxY3FcjhuC0qJGcqFJlmPHKUzuI=;
        b=dGk2N7XA/Uz8faqDspOgt5NV2BqxdenisPicCejI/CMOXH+ECmgNFcf4zrNtbsYGym
         JF5LBAsSXRuvVg1QZvT7k08KUDk9leq+fGm8wnk9sDyjAd5EONJJnXDJxnwbOMLaeBMx
         0u9zIO1pRKJJOEO8EtyyiBj7TeQ+0+t23hUxxEdAomqXIVv8fqWHkMiUFWLMZtqgz2qU
         JvjC/x74f4K8c6CmxQixn+CoZXX412AvT1i2+H7mMon74oCVEWHHozO1Z2e4F3tV4FP/
         U8x4HfchFypmU/cv/rhr5wfsA3Jmu/tGYGzvmZ4GOy0GLm2rVk0D3j/u744mRj1U5nPl
         xzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785943; x=1756390743;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkmAz7zGn6zpzjliAxY3FcjhuC0qJGcqFJlmPHKUzuI=;
        b=J3OsM+4dTUdMOTJkgFFIHi++z6z1Qf3fcJ64sUqDUcPeKRAVoYXOEQSXKMga6dPC9i
         wTesAvXM0c3ETP3niJ0p452IWRachFmhJPF8UX5Olw+ZzKec8GEqvRFDy4brPEGKywTU
         nSbSnbuEobPEr/lRVJalLkpLNceieQAyA02VZWfN86FEF9msvKAY4uKuleX4R6ZeTZeM
         Vg7SeB+3kVVblpR9TAWFm8sgH+AFZcP4SWOGyD8eUnzazmWB3cwFO3J540fBoaGXxDBs
         B9vFudo5PRqSdrk7q97CtXHc35uYMfcvf82Ar91RFGzG3FHYQnUXHgL13UFlLfRNOLp8
         zMUw==
X-Forwarded-Encrypted: i=1; AJvYcCWqfYjN/3WnrtaFBPvjGdS2TeW/zyA6SfjqF/agGmCfEL1FQWQ1Um8j2+J9FyV1qSGGcSFAk8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFDIgh4TJW9SNX8pVQvgdJhb6sDUSre/S0FM936xOtc5gWVgf
	d80RmbJPzOeOKyLZ9wmIoUZ9oUCqCS+TVDQsK7Wga77d7IbzQw4zH2mWbbDEWaAIa4k8YkdElP/
	yd9rsCek4WjfKKg==
X-Google-Smtp-Source: AGHT+IGFLSM7Tz9vyfk7HIxSaQv9KOTjKYpOAQEdcw7WvdEQZ6hnWRy5FbXgMigtGuqNZ9x9T/rejrX3XwAa/g==
X-Received: from ybbfp9.prod.google.com ([2002:a05:6902:2d49:b0:e94:3e2d:dac4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:120c:b0:e95:1a49:9735 with SMTP id 3f1490d57ef6-e951a499a28mr572295276.43.1755785942948;
 Thu, 21 Aug 2025 07:19:02 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:18:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821141901.18839-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: user_mss and TCP_MAXSEG series
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate data-races around tp->rx_opt.user_mss and make
TCP_MAXSEG lockless.

Eric Dumazet (2):
  tcp: annotate data-races around tp->rx_opt.user_mss
  tcp: lockless TCP_MAXSEG option

 .../chelsio/inline_crypto/chtls/chtls_cm.c         |  6 ++++--
 .../chelsio/inline_crypto/chtls/chtls_cm.h         |  2 +-
 net/ipv4/tcp.c                                     | 14 +++++++-------
 net/ipv4/tcp_input.c                               |  8 ++++----
 net/ipv4/tcp_output.c                              |  6 ++++--
 5 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.51.0.rc1.193.gad69d77794-goog


