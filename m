Return-Path: <netdev+bounces-237774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68DC501D8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E023AB86A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5D14B96E;
	Wed, 12 Nov 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="QrHWTJUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BEF4F1
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906684; cv=none; b=DZavoZSDfP4V3N/ximYrhrdtEBz0xKOjtRJ3w07itC5x7Ycg78t4ZQJwvFNdWQTkgTKhCuTtezYz9lcK9V5iDq3Z5tAA4u3Dh1tdFm4+dDhTBAbkvdV8yBxt427P34+bVhKP76k9OV8pJQn/lqcAVjLFm1WDkJ/Ly9NNjbq4ZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906684; c=relaxed/simple;
	bh=nydomGCTej8FhbWIKBiBsoAslA7N66/2N1kQCjZFXnQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s6RbiZqitbps1URoG9l+z3+1EesjDT4eik3ZrmuErwd8ahbZd4GQ+orTC8dS1ZBHgZM730FWE0B7e+1IISgRkUcyuGWCtWzvSJEHAs6oC8Y9Klb3bWMaZblaMfON9P5DbsQ/uIQ0nOqiWlMgvEEQG2vU9yg+LDf4Hd6my/+HBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=QrHWTJUn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3437af844afso295892a91.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1762906683; x=1763511483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Omo6ybPydVJzdXhFDw2zJFM6pv6urNYoxuOsmNwy9Bw=;
        b=QrHWTJUnJuKx4AnQwKdnVrjJj3ZSwCUlnQmdcdBQFMH97PwVGgooEhnc1A9LTmGhW0
         CyUGkOQrraGmy6oyI7WYnXptxxrcSz7uDQGR6MVoAHxhFupl2zNWOEukkPTvvJ1BdsMW
         JQPMk9sRGLYickwfOHA2JhQF1Q//A6l7GQ4GqECG4DBm+qXnRfoCSQLnaCeJolPQYS8Y
         nhbW2jmXen2kjwobRew8t/yQVN3pYormy4KhzyaOVoJdISTxE4l5KutSFG2+5z0zat3R
         CI6uEZXGDEDnLEWXnxlPI/gMen64ef0yBfCKDQD4gnuuKziAqRAAzJ3z+cUzLJ6YfQOr
         BVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762906683; x=1763511483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Omo6ybPydVJzdXhFDw2zJFM6pv6urNYoxuOsmNwy9Bw=;
        b=vvcJF246uEDYmT6mCpIXTpksMzE1D9TbjXhIj1RlDh+nh6TM/cFiwXyBM96cc9yDq+
         JA/DYCs91UDT6/DlxSuprH0A8S0Qknw8qSnJz3wEZ685UwAwzk4Lc8MpNLoT/tM90qQ1
         a/s6u1iMWs8aBwlkJ3+xi2U4NH1WYHBvh2eaH6i8gG0LLFCCbYNt98a/25txJShBaz1l
         WihILoNTEtUPANe1Qep/XalBHRsak/E3NXgu7EjKKTglD22KNNdcn1HTEFiLC2wmt3NU
         S0jAOhppjMRHgoOaG7+5+E81E5C91G7P0+ZjYQU9tACO1zQ10CA89HqQapLHyNPx+NdV
         vVTw==
X-Forwarded-Encrypted: i=1; AJvYcCX/BILoxM/53V2/7P9bug5IPBjw10uvRwhPKLmEoJnv+fnKsB7PSEYOWr9LO72qeesWu3RDhbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yV7BQvNHKu1lJcss/cF576j+K5UldsqwJ2o1IDzu4lVoXyA0
	ZGcfpktjaZnJcCZyg70Qk9cjPFddMqECpisrXJFsu1nHfDS8VbkdXycWwblXkQdAVfl6d9ni/Rf
	YLGa26A==
X-Gm-Gg: ASbGncurRd4Bx9djPCJMmWQBY/O3Y2m4+TcRSMe2PORPSpbj9/r6ijnvrPAnhY4sySC
	OZxcW7Ouqhgd3R2kMwADYw/aHGkEjLGKRHf29GkwB2y8gRBZqk2UYnYLN0wcB3iba6dJzJd+MJQ
	Z19QtuE5ErA/9b6NUmtYVrsyfEVM3d78VeLxokFwmZ333sC98LktZG2KI+fhZAfoyL6c0jYNLfx
	PpxJuvtQohFHs7s6Y9ZebyA62Cxk2ua1yvI5uInZ7gqEdlBxcKNQXUpK7nRwkKUQUqhHmHjwj/Y
	F3IpJdHZjzAzcxzqXjpcRZOv65HtqAdpLrSSMAuJiOIwAGAsWcebhKeWYaMGrx0/cKgvV+dGoz8
	eEt4QxfjBUXjn22+2poADYG8sd1OFf5RXiodE26VJneVXQZsW/+EelqRdmEx+M9y6WHldqG/8ot
	06mtS+HqUJNm5AYadcY+0PG9aAz1PMu7SxozOiQML6JmU7JdDCqECY5Erp
X-Google-Smtp-Source: AGHT+IF7iVwqZstoC/2kV6eFeIO6k0us+d21yWbsT7LuZg1TRenwW+/lWfJq8EEPztERRDqx6fuuIg==
X-Received: by 2002:a17:90b:2242:b0:340:c151:2d66 with SMTP id 98e67ed59e1d1-343ddec68b4mr1270254a91.30.1762906682556;
        Tue, 11 Nov 2025 16:18:02 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:8c01:13c7:88d7:93c8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf1782bed9sm754222a12.27.2025.11.11.16.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:18:02 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [RFC net-next 0/3] ipv6: Disable IPv6 Destination Options RX processing by default
Date: Tue, 11 Nov 2025 16:15:58 -0800
Message-ID: <20251112001744.24479-1-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set IP6_DEFAULT_MAX_DST_OPTS_CNT to zero. This disables
processing of Destinations Options extension headers by default.
Processing can be enabled by setting the net.ipv6.max_dst_opts_number
to a non-zero value.

The rationale for this is that Destination Options pose a serious risk
of Denial off Service attack. The problem is that even if the
default limit is set to a small number (previously it was eight) there
is still the possibility of a DoS attack. All an attacker needs to do
is create and MTU size packet filled  with 8 bytes Destination Options
Extension Headers. Each Destination EH simply contains a single
padding option with six bytes of zeroes.

In a 1500 byte MTU size packet, 182 of these dummy Destination
Options headers can be placed in a packet. Per RFC8200, a host must
accept and process a packet with any number of Destination Options
extension headers. So when the stack processes such a packet it is
a lot of work and CPU cycles that provide zero benefit. The packet
can be designed such that every byte after the IP header requires
a conditional check and branch prediction can be rendered useless
for that. This also may mean over twenty cache misses per packet.
In other words, these packets filled with dummy Destination Options
extension headers are the basis for what would be an effective DoS
attack.

Disabling Destination Options is not a major issue for the following
reasons:

* Linux kernel only supports one Destination Option (Home Address
  Option). There is no evidence this has seen any real world use
* On the Internet packets with Destination Options are dropped with
  a high enough rate such that use of Destination Options is not
  feasible
* It is unknown however quite possible that no one anywhere is using
  Destination Options for anything but experiments, class projects,
  or DoS. If someone is using them in their private network then
  it's easy enough to configure a non-zero limit for their use case

Tom Herbert (3):
ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
  ipv6: Disable IPv6 Destination Options RX processing by default
  ipv6: Document defauit of zero for max_dst_opts_number

 Documentation/networking/ip-sysctl.rst | 38 ++++++++++++++++++--------
 include/net/ipv6.h                     |  7 +++--
 net/ipv6/exthdrs.c                     |  6 ++--
 3 files changed, 36 insertions(+), 15 deletions(-)

-- 
2.43.0


