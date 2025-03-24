Return-Path: <netdev+bounces-177208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C5A6E48B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3D07A2D31
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E251C84BA;
	Mon, 24 Mar 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoRdWqV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F31B3F3D
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848579; cv=none; b=HA8TW+ugnS9jn44NPYHg2nRpPiLTU6sRUIWwfv7f1UrjytBegmL6vsFWDzNVvynTpPoUvaomuieXsnZkQURDDd4scUzQH+IQidtk3/ggiv5SoXBEB57Z8Ud4WK0SwjoxcqbkVzgGCuBwp1xpDJcOaN2eMfgCNfnaS0zaXkNLvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848579; c=relaxed/simple;
	bh=4QaB/zFefHS9qorcMx2AIZujv59HahdXXIW8Nc/cHGk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pOP/INdcO5sxwPahnFmRPWUAbwQigqotO/i4aB8/JopYHW38N0IkOh86aCBvOe7D70HQUCXJDMgND27PSBOWfRQOxeaja1kuiJ3I9TcNnEQaBVDfeK8D2QVoVA5Tk4bhrH5zPU45g5aOfaHXDpTwAm5uOf/XT1P+94TEKS1rhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoRdWqV+; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-476aa099fb3so154569871cf.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742848577; x=1743453377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5VMmCqW1MYF7Xl5HG/7gEpm76AHYSum2fzGrlnD9j0w=;
        b=PoRdWqV+LQHPmbvWYhz2R+NiY0jC+bNqKSuu0sDhgLwWFv449o8xfgn1YypfwR/UUN
         q0AFC77PQUcQfj5mXvGORiRM6jML/1KA5Nj1tMnIgiCWb+hQOe3R2QbfqJfz0wKGLZYN
         xgXZr1oiZ9vtv0g8SJAGAejSbYQ6L5UTGfqK9HiLH3fQGGjDXFkcvvqSaBW/v3Td3O0J
         NWihcJw1H4P34xehdbu59WZOf93KBQOHUP9FBnyWBpLZtwrKXqlvJDXGOS0pg58YDNMn
         PAPeGadDS0JVDSUKTrNeaGOXG6+DWQ7oN0Qn7qxnUBpP+myEDb4TZCy249jpg/+xb/rv
         +2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848577; x=1743453377;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VMmCqW1MYF7Xl5HG/7gEpm76AHYSum2fzGrlnD9j0w=;
        b=H8T+YZmJdIp6Ruw/5a0QBvrbODn9qlrBEImddhbgnSw9fBi88DmPWZZO+Y5i6ib9P5
         WcIplESYjh2hIrwidf4YZRjocCNpaWEs2r5CV2tDuAXfTJdafAZuosIQaaCkVXWENI+m
         lzjaC1Xdk38f1TvuOaVxM+W4zozUrE8sSgNcpiFN9Yom7IeQlicz4kK0HxRVzMhyCzek
         o+yYYGq82JNXHyUbQDuDwr9hCzsnwjmEv3CtBtZHAiGBZuHn2csrdm6BEZUYl9Ce7izV
         HUNCRG83J6ael/JGn9yXmG6LeTWcPhbEHQHE8/jHf5t4+iZgcP1ldMhkisJm6X7OgDLy
         u12A==
X-Forwarded-Encrypted: i=1; AJvYcCUSb+5KMJ77vQ1wolWIwWLwXHRrWFOmAolm3hGZMH7tSX8Jli5ob9P33bckPzdC7mwJIPiPTIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPVUAEFbd67eTHIdO8gkL/8IjpsOGGmv4vbQdRqftahYIFDGI
	RtT3Q/yqDOYcUYqQH/oy/8QQ640zR30LSal1CuCSuH3oZKxG+3Y9I62wE9+D2zkDlJkGKFfgl4f
	oYm91JHVwbA==
X-Google-Smtp-Source: AGHT+IG1st45KwYkVMHkL0DpGSFSFfoOiNgHXPvI1aaVdQGDSNdEsuDmETeMXL6x5IynYaIXoHCYdLpZ/kw4rg==
X-Received: from qtbcc14.prod.google.com ([2002:a05:622a:410e:b0:476:e0f5:2b75])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:102:b0:476:b06a:716e with SMTP id d75a77b69052e-4771de48984mr255768231cf.34.1742848577049;
 Mon, 24 Mar 2025 13:36:17 -0700 (PDT)
Date: Mon, 24 Mar 2025 20:36:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324203607.703850-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/2] tcp/dccp: remove 16 bytes from icsk
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_timeout and icsk->icsk_ack.timeout can be removed.

They mirror existing fields in icsk->icsk_retransmit_timer and
icsk->icsk_retransmit_timer.

v2,v3: rebase, plus Kuniyuki tags.

Eric Dumazet (2):
  tcp/dccp: remove icsk->icsk_timeout
  tcp/dccp: remove icsk->icsk_ack.timeout

 .../net_cachelines/inet_connection_sock.rst   |  4 +---
 include/net/inet_connection_sock.h            | 22 +++++++++++++------
 net/dccp/output.c                             |  5 ++---
 net/dccp/timer.c                              |  8 +++----
 net/ipv4/inet_diag.c                          |  4 ++--
 net/ipv4/tcp_ipv4.c                           |  4 ++--
 net/ipv4/tcp_output.c                         |  7 +++---
 net/ipv4/tcp_timer.c                          | 16 ++++++++------
 net/ipv6/tcp_ipv6.c                           |  4 ++--
 net/mptcp/options.c                           |  1 -
 net/mptcp/protocol.c                          |  3 +--
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |  4 ++--
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |  4 ++--
 13 files changed, 45 insertions(+), 41 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


