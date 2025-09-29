Return-Path: <netdev+bounces-227166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0055BA97C0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF253A2551
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0163064AA;
	Mon, 29 Sep 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOzvmmEU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C12D3EEE
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154926; cv=none; b=eXxBF2Ebi/+NBHu0d/Dsq+amMITNEzKm5Whx2UXh+nxh88S3iKooPEm2g+vAS+wjS3WEaCwp4ruNVOHpqzoJXzHN/Z0QyNBEGUArioBhKfEUex9AJw0Q6kd2ChyjXhxCIrXU4WD9bPP0XBeooXh/3y6deroDlajp9bNSWZJZVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154926; c=relaxed/simple;
	bh=M/Xh2uIGYzmZvSLYUjB9CWCuvk7pIzFtPtz8K0n19K8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=losPEEueCBLnjkvYVW0O33XmwYv82U2NhCo+GRnP0ylbThh5EjJvoH/ClRutzu/R3aJqpS8hWyOUvgVihMw2e0pnGiYKz0zor2bCV/H2X2B+AkuX2RtWxoiOjYUZRrewLsQbtJqZI7FphBpke1WlLQDIUlbVeo0/HlLbfp48sBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOzvmmEU; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4dec9293c62so62049811cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759154924; x=1759759724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/gQThJPiZR/uh1stYEHLRPfRvTMLiV1z4tELnaASjfk=;
        b=SOzvmmEUmo/1++mhAufkhhM4uoepSnzoqpkPbhjQlzjrZLlyq1nVUmoBQ9gmeURuu6
         hJ4S+8N6iWUm/G7m1zWi6mUBPPhs7vn/Bjcm1MxWuabgP97KWDHPZv+/5aoUWTnw55mR
         Ol3+TLOYl1NxHco4lADbeLY1hLZdXUYBttjDQ4tzgi+V5SVmU0lQ9uhB6ciIfqLK9TUf
         Nfjl876FWLFQvBnZNnW5C2fK79CBiAuZWoePBsON/F0xtW7UhXfZNtBfBxvNi4Ip3Ks8
         6S6tGWS9Toml4F1nJ2ZtthzRdkA9zDa/v1Go1ff7luSfAkOcMSfbpLhnRRcBqTy+B27g
         Kf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154924; x=1759759724;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gQThJPiZR/uh1stYEHLRPfRvTMLiV1z4tELnaASjfk=;
        b=wzz9PA5Qkd6xghdDs7R99fe8cFaWh7C+Aly8P0mABj0U+WG0w06BfDZI/ijSXg+/wa
         Qf+7jNQ0csVi/Uqyv/KsxiEb2wOPI3q20Nx4EJQleTWgMmTHyc5oHn///QJn6xjEHSwb
         AOaVD11khJoPYYcIuS2QDogjuWe/JZYWMf4/aGQ1xQIPP80O1Z7jnDZexyFwuDxiWnH5
         WqC5U/YUqa5cFUC5OUwa8tOWFWHF/pYl3JpixS+M3Jc6bRegfFHtkNGis0E7S3HtEFy/
         0bMlwadORUKCOzndvcKplreAtfXBhCRlmoT+fvkw1EXyWRkCwDKgUGqtMZDK+TsIez9K
         B4KA==
X-Forwarded-Encrypted: i=1; AJvYcCV0DCGMSgwb9XjKq+YtKRLt91C5NVVP2knsKnstJBnTtQX5yjWugCYqUZ8fyNvhBqmGs+J++xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOV2F1+RBI7O5zkGJ6cZ1b9kdy68C5TFdr9qvpPNJPf2ySBBr
	voVVWTtHEU2y2Fx1gSr1xd3o9rN0vECniq+aKbSPGKfSDxX4ayt8TcINj9QprG+mcml8J7yBEuM
	yqXYr5SENwr2piA==
X-Google-Smtp-Source: AGHT+IHyCh7ZeDsGllCTL0g72q15tgKNOFg46lKQ3m+ae8/h3RcE2PXPTQYM3hzKB3Skr2B5EhtsZji/awLDTA==
X-Received: from qtny26.prod.google.com ([2002:ac8:525a:0:b0:4b3:8d48:9922])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5a10:b0:4b4:8ed1:2241 with SMTP id d75a77b69052e-4da481d8d9emr197268321cf.15.1759154923915;
 Mon, 29 Sep 2025 07:08:43 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:08:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250929140839.79427-1-edumazet@google.com>
Subject: [PATCH net-next] Revert "net: group sk_backlog and sk_receive_queue"
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, kernel test robot <oliver.sang@intel.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 4effb335b5dab08cb6e2c38d038910f8b527cfc9.

This was a benefit for UDP flood case, which was later greatly improved
with commits 6471658dc66c ("udp: use skb_attempt_defer_free()")
and b650bf0977d3 ("udp: remove busylock and add per NUMA queues").

Apparently blamed commit added a regression for RAW sockets, possibly
because they do not use the dual RX queue strategy that UDP has.

sock_queue_rcv_skb_reason() and RAW recvmsg() compete for sk_receive_buf
and sk_rmem_alloc changes, and them being in the same
cache line reduce performance.

Fixes: 4effb335b5da ("net: group sk_backlog and sk_receive_queue")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202509281326.f605b4eb-lkp@intel.com
Cc: Willem de Bruijn <willemb@google.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8c5b64f41ab72d2a28c066c2a5698eaff7973918..60bcb13f045c3144609908a36960528b33e4f71c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -395,6 +395,7 @@ struct sock {
 
 	atomic_t		sk_drops;
 	__s32			sk_peek_off;
+	struct sk_buff_head	sk_error_queue;
 	struct sk_buff_head	sk_receive_queue;
 	/*
 	 * The backlog queue is special, it is always used with
@@ -412,7 +413,6 @@ struct sock {
 	} sk_backlog;
 #define sk_rmem_alloc sk_backlog.rmem_alloc
 
-	struct sk_buff_head	sk_error_queue;
 	__cacheline_group_end(sock_write_rx);
 
 	__cacheline_group_begin(sock_read_rx);
-- 
2.51.0.536.g15c5d4f767-goog


