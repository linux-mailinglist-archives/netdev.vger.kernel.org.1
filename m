Return-Path: <netdev+bounces-98026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5368CEA65
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 21:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDFC1C20BA8
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BBD6F077;
	Fri, 24 May 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UC82gvEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D405CDF0
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579394; cv=none; b=nSOEERdF7kbt1/SU6P5Y2/bztjlr3zOdaqN1YngFr+HY0w3c15TdzphP2W/01JroTYKdGC+PmeibAioqVlMdNGlrcc7T6T/zm3ZgukWdEdfp+ULW7ByWI9UKN5iqpQjPBM6VQVfwG011uhKTS7kPz80JGzbpMb6XGv4hZGGsxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579394; c=relaxed/simple;
	bh=HJBagJuG1zng10ixqnK3bOcoIIg9Rh+Y800A1x539vQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b5k0R8qTsoq1AMQZJF0MopIT0g1LeOIqgu/49bxKj+caL5kh7zZ93R8gafvCX52SraHAVpbZrp3kK4LdoBpl+wQ+al8b0A55zMqKDdbZT0ttMacbeIcQFkrFDKl0Ykud9pkhCMOWJYLP0YEhmgpgc6MrSk0t2eiC26v1em9DhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UC82gvEE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df77195db65so1128581276.1
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716579392; x=1717184192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NjVlLbP+kmbzK1MilNFsjZIVbl/zLU3jSGoRPY3YR1A=;
        b=UC82gvEEF8bQhACyQLi/zI8pQ06fN2q9U8W2J3kLaD5M11RXQBkSGPah3j0jMKjCyY
         CSo4uaR+z4EbbuiDQnspvq8800LK/FbA2Q5haSa5ojLu7G8nis+mo3kFjSvOqGTg+EF8
         rRYPV92eEZvsXYk1VY0mMFAF4ViZcYE1QUGjtCyWDyrC10uDuGh9fSJrGFS1q1kvW7MT
         MdqMdNys0XHYXvjDIf2K6ARSfIMG54TsSNa2CtmjSYYyW1pI9PuSrdkdOIdBQJdQLGYQ
         py9ATQfI59wo1wYqNUwHW3OsE1rdwWLuxtpgv4Jn5lrnyGt6N9veCgWK2pSSac4eOt+w
         J3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579392; x=1717184192;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjVlLbP+kmbzK1MilNFsjZIVbl/zLU3jSGoRPY3YR1A=;
        b=CUXHbXvAZw4YLEz2kjc+SiyTFTWuCnnpunTr9bSLSMCRHpBQE+T6nE3MtDoEbaeLMo
         488iJhzsB8eUtqkZ+URQL2WwWdEzntm49CGORnIUqtdSses8EvHk94nvrEtPSDx+LroV
         VASDIzNanT48ht5eV5zVjiMElV9nMPOquE9j9j8BXyc3sEv/aAHN8sJOS1f3wsvEaPYv
         n9q3Cb9NOFQEun9dlR/XX5oy0bDTPdkQ9gf4d4zH5gBUqbjmRM43xuEtPjUEDMHK7XwR
         m/fnfF/vgFCTjTzKysSLjPA7WZeLh3THao+TIu0U08L0tcRyH5hhvPVxLB2sUnY9vIM8
         tRaA==
X-Forwarded-Encrypted: i=1; AJvYcCU9znjNY0arZ/Z/ZBJ5lMsyoyua/24kry71fcVxjV8Yhu5hZ7q5tUL2JgJZjENs/GenXlMUeL+io7dV8yHdCUiK8ti1LlAS
X-Gm-Message-State: AOJu0YysuZRHk1CpGvp3ztGdxTU81sJD9KD8elaUIphzC0xtORhNAHzh
	bc9BLAocoI1nOXFPnoNdzl2yimZ4iPh5oG1+8+335044YqsVPqbQt0glBeOfJiODbTJHaHDTJQX
	+oTjgCH3Wlg==
X-Google-Smtp-Source: AGHT+IEQziFpb55GuqnWGaJS8nFCqY5BqR+eokfPfsS2TqtXOEXh9Qx7rJELSn7QpoIE3HjlIBK2U5p2UEIcRQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:150b:b0:df2:eaac:d811 with SMTP
 id 3f1490d57ef6-df77221f771mr300242276.10.1716579392185; Fri, 24 May 2024
 12:36:32 -0700 (PDT)
Date: Fri, 24 May 2024 19:36:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524193630.2007563-1-edumazet@google.com>
Subject: [PATCH net 0/4] tcp: fix tcp_poll() races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Flakes in packetdrill tests stressing epoll_wait()
were root caused to bad ordering in tcp_write_err()

Namely, we have to call sk_error_report() after
tcp_done().

When fixing this issue, we discovered tcp_abort(),
tcp_v4_err() and tcp_v6_err() had similar issues.

Since tcp_reset() has the correct ordering,
first patch takes part of it and creates
tcp_done_with_error() helper.

Eric Dumazet (4):
  tcp: add tcp_done_with_error() helper
  tcp: fix race in tcp_write_err()
  tcp: fix races in tcp_abort()
  tcp: fix races in tcp_v[46]_err()

 include/net/tcp.h    |  1 +
 net/ipv4/tcp.c       |  7 ++-----
 net/ipv4/tcp_input.c | 25 +++++++++++++++++--------
 net/ipv4/tcp_ipv4.c  |  5 +----
 net/ipv4/tcp_timer.c |  5 ++---
 net/ipv6/tcp_ipv6.c  |  4 +---
 6 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


