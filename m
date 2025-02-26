Return-Path: <netdev+bounces-169954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785BA469DE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F453A1A3D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D67622332B;
	Wed, 26 Feb 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxnCkLhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93844258CE8
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594885; cv=none; b=UOuh1FtHEx2+sCWNLRsVrjbsR6F6TGp/HDoBbBEuNyT/u/+uSnGi1nCKZpsB/UwKuIaz8ngJwXdUY1IfHFBaM99sdHhXG9n/e76QgJp+z8Qyc1Fp3J/fIwQdOJanyK01BPqu1OZdC7+r6r4ttpMQPirZv4kxpEcCm29ARKBw3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594885; c=relaxed/simple;
	bh=71/qp1BRWGS4umIwgiCl7B3AdmpPWBZfOi0UfDElAms=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R6HmorlC4VdZAqzMHb9/vmItmpna9c54SSTbByxviVkbh1zvpgDVbI7Yc/1/nYUosYx3xcCN1emAgMFRygrdIYTa8tEIJi76T0WaP44M6davffoqKcpBHy4K4Vr+LQYSN/+VvacHgwJUO28lqL19NIrxuY3ZLbDbNTaqfYJlweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxnCkLhe; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-47206d76457so2024881cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740594882; x=1741199682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fW4YdVn9yoXliO2nzHX3v1xMi1ssQutXprG866Co++Y=;
        b=KxnCkLheJzOIDXv2wq8UryWCE11ujO5LaHxzRVHvslFuzzCMJuN98eA8exseFtss9G
         SEF6L4uvZGdYbwp71K30RZLKChjjImn/OSV3ro2bCXo/JHf4bYR8hhagy2cxe4+Mt92i
         tSpe15CEs4zDBK3PD9/4PyBzXqvhqdEqW7sgR4WujCN2MQT0oe9HHLWik4CFSWZwmdGV
         LaSIsRfEfQpslhNmcjFL6ft9EKRzry8g5GdXOgqAp3i6AeWnZw6xRCkV0o5EAXpYRgoj
         MEBxfGAJ+uNPTa8yG7nyx3o9e0VyKkHcG/pk2Adg392zYg32FV7z2z4KeuoMiKJLnUo/
         Cgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594882; x=1741199682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fW4YdVn9yoXliO2nzHX3v1xMi1ssQutXprG866Co++Y=;
        b=EiRxx+qXAXizUanmOphthapfrmJl9iMtJUSN5zTv3CNEPOVwC87wR8NCjctEE8/gJq
         ZVXvL+xJrzmfGiGdScrbPGxAqiqTJfb4rgXUrkYJ4IRVP/sglVdt/OsRarLVKj7OMGYZ
         3Z2V4+Sf0CHceasYhfdoc7t1d1TO6XKjpGYaIpT5/2y/mJ6p90FyT/8gr2YUX9QE+LdQ
         1OhAZU3nAthcLcLFmrx+wdRp5oo9SSYh4wWgmwdh8vjT2bUdFnhTDTn0n7qL2I+3NJWv
         n73LJUHdl3ABqT/SJ49KLA760cl+WJuq+CvEsuSbjPBCC00zrVuvt6tA9A8Z363T4Sn6
         x3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWYpgXUZ8/skAJACgXoF0C/uQ5guuvFZxyoMnhyz/sJCqeAqY+x+qHNdj9rH63cmobmfpDsG+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7qGr9eCurZRCaip99TkDLxcREqBt3AcTitYrxIz3rIKaLjFHC
	rYLTo+MOHyAI0EgXwa7owTu5nzf83XBMAwh1hfzb4SGIy9nrsdeA174pK4gqO2vnXHZ+ZHZuOUP
	n4ZyHhINzaQ==
X-Google-Smtp-Source: AGHT+IG5KX6dLCZcojpKXqEl1UEv3qanHunA9NK8ZL6q+OmaGvY2X7Fxg4QnQm/H6TSnwpEvRxZI3hZqujJB0Q==
X-Received: from qtbci23.prod.google.com ([2002:a05:622a:2617:b0:471:b425:55a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:164f:b0:471:b0c0:82b0 with SMTP id d75a77b69052e-47381316fbfmr59810161cf.4.1740594882472;
 Wed, 26 Feb 2025 10:34:42 -0800 (PST)
Date: Wed, 26 Feb 2025 18:34:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226183437.1457318-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] inet: ping: remove extra skb_clone()/consume_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch in the series moves ICMP_EXT_ECHOREPLY handling in icmp_rcv()
to prepare the second patch.

The second patch removes one skb_clone()/consume_skb() pair
when processing ICMP_EXT_REPLY packets. Some people
use hundreds of "ping -fq ..." to stress hosts :)

Eric Dumazet (2):
  ipv4: icmp: do not process ICMP_EXT_ECHOREPLY for broadcast/multicast
    addresses
  inet: ping: avoid skb_clone() dance in ping_rcv()

 net/ipv4/icmp.c | 33 +++++++++++++++++----------------
 net/ipv4/ping.c | 20 +++++---------------
 net/ipv6/icmp.c |  7 ++-----
 3 files changed, 24 insertions(+), 36 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog


