Return-Path: <netdev+bounces-63141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5982B567
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297031F240C0
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691756464;
	Thu, 11 Jan 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJpqdSKo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E667524AB
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-680139b1990so109526426d6.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705002559; x=1705607359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UU24CyUllNWEZc0HSA09IUivf5QA30f9lF0pR+FVKw=;
        b=YJpqdSKoSN8GdncbqecXEpfhTuK7DBCTDYaVkc2o1cbTw7QC/lrajDbx2sMePtEAEh
         9Yv8SjOcBzTuJkbhXvkUFgY2S1YvIiQRT4xjuCCL9NEaM+Dhqw3HhpvXcm3OqySNkvGA
         YLYzEn3sLgSAx8Nu3/pa30fQnMGJ/nqik1wEHYE+elmW7MJTcJ9MXvOd6V4EOBSDco2m
         oL0foR0scXoh6uPBws1AfgX5UVdHcURpDONV/TTiBEEu/Vpd9uhBmN1rXJVvHmZFjgC7
         R25tMYNyCPmuZc7T+trEElVw7aOGeZcC9LGhbR6ZOH+jke0E/l+89JjeRnJ+CgtaRzIh
         /O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002559; x=1705607359;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UU24CyUllNWEZc0HSA09IUivf5QA30f9lF0pR+FVKw=;
        b=gKzJsh9MA0hBYYsk4rPxvfRTEYgGwaHqClYpPMJDmgkoRCZBhkKLLJac7czY38bbCV
         FUeW6PXlFlhdjh8bb0T1TRQMCZcctCxy1Nk5Nov6aHCXr5fR7DYg5Cq8chHt3I7sCZBY
         1NtaMp8C054K9C8TIlcCkgG6g4FRNV6DLr4UpjddyKEk/ElfiFULhb3VLzF/AiYiFzxX
         +32wpK+kdn0tyz/LrHLR+OIt8KXVsrPgCjuFmbSHm10nhvrex7sjj6N1TeNizOWV0ZMq
         JUyWCc1a7XQRYLTuBg0Xa63mQoWwykjmCuy6pCjtn46BKIA+U1AqozrZon29n4D0XOTi
         eyhw==
X-Gm-Message-State: AOJu0YyTcb0VItoeiv5YVf84/IlQZE1zN8AkcoOnHiNMQmS0QRL+W5pn
	61AzPeLhE6WS0GgqbPci1g75kW9I34uMZk/Sc9yU
X-Google-Smtp-Source: AGHT+IFUUYGP7avDl1lN3//EoZFfplneyU6EcXgMS55vxAQ9QmCG57K49huOEy8gwmUx2z7LS47yReuQJeVGpg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ad4:4ea6:0:b0:67f:a0a5:80b8 with SMTP id
 ed6-20020ad44ea6000000b0067fa0a580b8mr645qvb.13.1705002559314; Thu, 11 Jan
 2024 11:49:19 -0800 (PST)
Date: Thu, 11 Jan 2024 19:49:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111194917.4044654-1-edumazet@google.com>
Subject: [PATCH net 0/5] mptcp: better validation of MPTCPOPT_MP_JOIN option
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Based on a syzbot report (see 4th patch in the series).

We need to be more explicit about which one of the
following flag is set by mptcp_parse_option():

- OPTION_MPTCP_MPJ_SYN
- OPTION_MPTCP_MPJ_SYNACK
- OPTION_MPTCP_MPJ_ACK

Then select the appropriate values instead of OPTIONS_MPTCP_MPJ

Paolo suggested to do the same for OPTIONS_MPTCP_MPC (5th patch)

Eric Dumazet (5):
  mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
  mptcp: strict validation before using mp_opt->hmac
  mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
  mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()
  mptcp: refine opt_mp_capable determination

 net/mptcp/options.c |  6 +++---
 net/mptcp/subflow.c | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.43.0.275.g3460e3d667-goog


