Return-Path: <netdev+bounces-75230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C32868C17
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577741F23475
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F213664F;
	Tue, 27 Feb 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1QJh79I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F954BCB
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025856; cv=none; b=FItfDr0nEdg2gLkTymUG7BkkhMfpaE+zv1PpPwILL0SiVcj3aFVTB2qOUxE186cxgjO8wNV9WHSIl38raJEwT3CUswkU6Y/BxuMKnt/leMHekpsp10qv9Da9mFfWkzVuq8rEW2VWXx5wmH1uCe7FiutEkFB7fwpQXJUljJ1pSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025856; c=relaxed/simple;
	bh=2j11WNDCbMP/Q0C1+ZcUTH8CdCZYBiVeK5Dea7hTJjI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D7Q5vo0bTXCT7Dp9+vBRFzI8mV2JMrop91cvvELnxn4eSGsCxBHYHCxOEmx84clDL0iJvp+OZtHYxte2f/RnxsttLCvYTw+7M8iHa/a0mHEN978yD2CBeZZcvE9DfjdJxOuihiWHXIXyCBNFiYVIqaA7Tuf1y4zSCf4sPbBIJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1QJh79I; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608852fc324so66891607b3.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 01:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709025854; x=1709630654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=miRC13GqqOrvpGd86p42R3CvaYaBTlmadH6DwSNw91U=;
        b=S1QJh79INSdy+yM2vHVmWoJtWhzj06hftX3cAjk9odupKf7IV+boAawOBKvg0DJILo
         PCPGVsbGZ+cTVSbOD3DLTV4eSLV4yEbFX6H+vxwkcMSneDrLio70UZi/OPvz33BqyWip
         ew6W/D5rhkb82KNtHxj/Y1Ag8Iw0K+FzdgwlKliFHHMr9Ww0ZnjvDRvDDRJrSbrun4Jr
         51Ls6trmuho8C5ZsfJ3CbdM9GbRWcF1N0l39fUSAs4V50SF6fY117johZGHyewjGDjSy
         dGnE3X81VCPnsMJmE9A1IJ8TeqavABCuHoz8I4P/QB2diXYQY+GDUtwQB2LuerfAmLTI
         X5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025854; x=1709630654;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miRC13GqqOrvpGd86p42R3CvaYaBTlmadH6DwSNw91U=;
        b=SfJMSdpD0rMuPajvq573QkhAVuoqI6MXx89mcddeh82jYZIkSl1a4ULU1157JMMp8M
         ZdN+kkouXiPj5KbGlhaWJwvWn6WY4huJDkhNM3ugHDC2UzxYVt242ieZgz2VgbNEBmcq
         0QEZnZ0JdecSyD1rG/hGU5li8O6Dd1Rh0VdJjdNDT3+K03Lo8j0v3m9Yv7h+KtOnegFA
         A56nxxOF8CCZI1r/tjvUCOOT6fOGCxTI+EgCKpjJCdmMIOuCuWdkr81q0ERgX34S+9eQ
         ZjIM0wVopnhUemrvmrHdiIeDf+p0milC1LgYd+GDwUMlkimXkoBDTzpHFnijCopYbnS6
         ldFA==
X-Forwarded-Encrypted: i=1; AJvYcCXXL0CvuY0xvPQ8+OG3ty1Av4hbEU0cfPXIO7GpXA3i8H3wxgW1Rpzd/WWueTdZ0oIhyFaTT562jzxLrLoajW5st+1tOlYF
X-Gm-Message-State: AOJu0YzSKyc7K4uf28GAA2j4ORmZvRk+RUmDnnC3HuCqTgqjUViQtRAT
	lpQo9HcDEHxEvCxClCl6SaDceIj4E/gnYzha//zzB289+s9SAPhhRjno4UCxcxWQh5BygE/NTNi
	drlLeAqTHwg==
X-Google-Smtp-Source: AGHT+IElQT5lLqPJQnz3NzU4BF3hwJDErG8JykRvY+fSH2Ee4DD3kbcM23LeKf/KY2J+vvQNOiCgxy3/PCbLgg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:d8c3:0:b0:608:406d:6973 with SMTP id
 a186-20020a0dd8c3000000b00608406d6973mr388047ywe.5.1709025853851; Tue, 27 Feb
 2024 01:24:13 -0800 (PST)
Date: Tue, 27 Feb 2024 09:24:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227092411.2315725-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] inet: implement lockless RTM_GETNETCONF ops
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series removes RTNL use for RTM_GETNETCONF operations on AF_INET.

- Annotate data-races to avoid possible KCSAN splats.

- "ip -4 netconf show dev XXX" can be implemented without RTNL [1]

- "ip -4 netconf" dumps can be implemented using RCU instead of RTNL [1]

[1] This only refers to RTM_GETNETCONF operation, "ip" command
    also uses RTM_GETLINK dumps which are using RTNL at this moment.

Eric Dumazet (3):
  inet: annotate devconf data-races
  inet: do not use RTNL in inet_netconf_get_devconf()
  inet: use xa_array iterator to implement inet_netconf_dump_devconf()

 include/linux/inetdevice.h |  14 ++--
 net/ipv4/devinet.c         | 147 +++++++++++++++++--------------------
 net/ipv4/igmp.c            |   4 +-
 net/ipv4/proc.c            |   2 +-
 net/ipv4/route.c           |   4 +-
 5 files changed, 81 insertions(+), 90 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


