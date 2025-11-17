Return-Path: <netdev+bounces-239125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F8BC645D0
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 382A44EC4AF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A2331A7E;
	Mon, 17 Nov 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9AbPNQI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F403321B2
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386087; cv=none; b=W5NNCBGJqudTmM48O7lwa7d+DsqEPWNAoZltrHxdG++xwB8Fw+8fo+evb7nXpd/8/nibqWnQuMClKfQgE2S65ZadAALgt9Mbg1eeKboOqxoIpsSF5TkuWUOqiam3xuve6wyenEs8yiEyPqaIa0bpqi+p13206vznIhB2SyoPdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386087; c=relaxed/simple;
	bh=xuSXvN7Twlta8+kFiKEmi39jOrRyIqwxCDIA5Nf2hfg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q9ZWnektKy4AU4dxdDmCgVI4HqDLGXrHvVWA0COQbZ+gO1TFi2M+DZgQQeRc/QAcx/G9hJKXCIo0ZcDEWUpvFUzJRmpnAi12SuFQHUjBjlIbgMUsvF5fYPTwPlIqnxjJP7vjpnuc4I4w9GeuaAXuPb9EObdbRjPnyVYR+kAwmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9AbPNQI; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8a1c15daa69so1412988185a.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763386084; x=1763990884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YkPBlZ99mSg6BHCkMS1VbkS792zlY57mJH7RSu9Whfc=;
        b=c9AbPNQIXOoM53dLZVu26xJSe+2g3RuTk8gEuvK4Gzh/kLzCNCI1LPmqjdKWjYAcmG
         8DYLhjI/dn4TNudSWvqiZzdfvrqmtF7Z1R0M++SUlswQ6dRyKPa4ZnMjwm2x8Ody+zwC
         yh8PGhWah52sReGRVFv9IeaU94F7fb/7jJmscGeAS/7alsPKhY+GIHvATH28XFAm/xJ7
         Q5QErOASfFqb7qE/UqJup7sHoHa+HCyn4E4D+uCfb/9mJeEB70Eh04MGh6zmU++ERMoj
         sXUGOgQo1EzV5ewLWwINaVonbB5hBXheySibHbrSiXJ2HXK4kyvxR1FLDHabQF+Ktn5v
         C9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386084; x=1763990884;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkPBlZ99mSg6BHCkMS1VbkS792zlY57mJH7RSu9Whfc=;
        b=G3thTwL8EtKbRgjbPCz6pU9qB7010L8Iw8ZY0UhDjjmW/hhzV6uYXxQTdfTGw/EjOx
         1ecvKZLyiDnqzjJQX/Q+laB3LEhKnobpZDXc8JWwL4aUZEOvSfP4imAhR2RWXUiGfoCI
         D24QPv3tPO4l3m2Bzp8d9h+LL7csCgZmJfQiMaQHhIhRtwnTM4YtNIwKEpVV2evC6BDu
         FbIbB9mX81xxkwy6pryv36z0IJ7NlXf/nUE5Dn16lur9RE1Gsaj5FKiKXnPGuPTcI+fL
         ikFURAPx4iHqAqj//VthRLTgSG7ZGASMYTZrl+J1cnrJo1/AqgN9gAyQHJ7jU+nL5DF+
         7mKA==
X-Forwarded-Encrypted: i=1; AJvYcCXSuu6qqP8SOrxH1wMmn24PIjmqJDLhyb3+8EnUr6nq/qM+crkxsIsQ1xYa56Gclz5FJtq+oPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlRFDC55cDPoofLHpoKoAzXTtp+1EgoKMtmVTewtcMcCZPzVI
	FZ1kiEf0LnSRdGh01vKbRhYd9bEsjbrj9728bHvAZmT3dma3dkxM6daERSlPoJ4TmTmSW0qxnqA
	EEyt75P6u9Wy05Q==
X-Google-Smtp-Source: AGHT+IHkBS4P4mPgzcEfZhoX+bGFuokuL5VbHlIWSf+HworK8a2alJO2mjxgHtduiBULAK8RAV7xR9f41VdQKA==
X-Received: from qvboo33.prod.google.com ([2002:a05:6214:4521:b0:87f:bcd9:e4e8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f6a:b0:880:4bf6:21d0 with SMTP id 6a1803df08f44-88292658ac9mr179224406d6.36.1763386084198;
 Mon, 17 Nov 2025 05:28:04 -0800 (PST)
Date: Mon, 17 Nov 2025 13:28:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117132802.2083206-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: tcp_rcvbuf_grow() changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First pach is minor and moves tcp_moderate_rcvbuf in appropriate group.

Second patch is another attempt to keep small sk->sk_rcvbuf for DC
(small RT) TCP flows for optimal performance.

Eric Dumazet (2):
  tcp: tcp_moderate_rcvbuf is only used in rx path
  tcp: add net.ipv4.tcp_rtt_threshold sysctl

 Documentation/networking/ip-sysctl.rst         | 10 ++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst       |  3 ++-
 include/net/netns/ipv4.h                       |  3 ++-
 net/core/net_namespace.c                       | 11 ++++-------
 net/ipv4/sysctl_net_ipv4.c                     |  9 +++++++++
 net/ipv4/tcp_input.c                           | 18 ++++++++++++++----
 net/ipv4/tcp_ipv4.c                            |  1 +
 7 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


