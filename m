Return-Path: <netdev+bounces-191366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7447ABB33C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 04:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C382172F2C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 02:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24171D63D8;
	Mon, 19 May 2025 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLYImH2B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709351A23A4
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622121; cv=none; b=mLbyC1E0WUzTGlJdKUUwTkdi5+vLMxaCO85F9t4IFMtTvMq4fJWadfs4ai1HaG+sUIBh2ZKxgwShL0a/UIbs8VGM1+vA91td0ebR0s4fXZpzIoe1BDf7ogGAWqKJOyH/PjJb3rj8Krd114OhrhwRwsdDH+S1UwDwW3/+UsrG03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622121; c=relaxed/simple;
	bh=MLOjAAPcplXLjt0idgSdbv1QlkinDsa4uGJV0cja2/c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SpSHD0S7CpxdzrGJ2BlAb3iZ7KQJVYjkyKg+/lO0t9zGu8UJa+jPW6t7c546BONVQJVtpxE0EHgxrBKoiNRR+bro2VdxIramrT/1mNDLWdFxOYoQ0+7vgs3tWJPpLbjOgQCU/2K+us4slAC6822hxqlIEohG1AMnhg8EbFBXKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLYImH2B; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23209d8ba1bso11506905ad.3
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 19:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622120; x=1748226920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T4x7wNdRetlNSCsQonq8ajzFu9C5gDJsZscn/CMz2O0=;
        b=PLYImH2BhdshJHaFILfr25Wwx/NFCumVkTQtZ7brzNAGLG3XTgOEGTDNFwIi3qyk5I
         1pt6uq1kmL9BhcUKu99OK3lPreW0tle3fUei9N8BIR+XLaMVg6DGkKkwN18PN54Dk4q/
         VgOWN0mFEd4QmmT2oPNZop4ldWL382HtFtVhkIsrHVFqIke8eIyUCHKr/MkmCCxsDyYy
         /7B6gnHjhA1U6epa1MU9mCRem8Gy/3ObKR18h3OQvCZRyYSn9L+mVl7zFwN9IAb97G8+
         ENTSD/a/HcC1Ffyn/S0c1fb92MoN5GOZFVNd6jot4q+8jFNEy3ewVHFzDFx6UNqx1PxY
         FoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622120; x=1748226920;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4x7wNdRetlNSCsQonq8ajzFu9C5gDJsZscn/CMz2O0=;
        b=siUWJZqxY340vJMmFjNBArbeN4RXUrf1CoZ/ZIygfdRWtPsAaYDXFy0SsC4M/nfCve
         6WEzgscvXcKe3iYhQQA2N1YT2UXVLGUfgEgj3eEPnWjm8Q+zLGG5JlN93ahUyQLKOR5c
         v6hiI5TzbY7ZvPgQuUdbUkT58jRoEbr5OxMvi/UcaJgwYmdg3+T3dIX2Jrty6X8ukINl
         Wa5ph69+GBlEtOg6z95A5KhnjZDEyN8vpyNDOZY66M2/ScariP7/H+/MoOMJ1spxLJW3
         FOw9Pv2lF2sy4riu1bphC7po4V0mfiYkOVefcVTkt/XiT4FHjPwLyKkTT8r/0XONC0A5
         pZUg==
X-Gm-Message-State: AOJu0YxcRhE3VnAyNQ6rR8cmwEtg7658n3qn7ux0dWHJ9UbZv2yuGgLs
	+QCWBb+m5RxIwFASwWKir5rPhOQ5sDRooU9uqcZwU+dyXkMoYw18ir2/cxMCZus4eKuzPb9Ug+Z
	HM85COmJYqeSQbvWvnrTnDCBDWQtDSj2fX8LTxvzqLgNYE/BobUKDhMhO4H0icXiptL54x1WyGS
	R2p/jVTm3LGIu0SxiIjDbMJkJ/ttninsPYFx6w+AR6jaNYiehvhrdYW+Torca1dFg=
X-Google-Smtp-Source: AGHT+IGmupnY76hX7BcuQdiL3IIli6yYr7kfdGnKxgi2woWXJy5arAeTwD4OJxOiun/hcxLuZq62u/OigAgXEhe0bw==
X-Received: from plxe18.prod.google.com ([2002:a17:902:ef52:b0:22d:c61d:a4a3])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4d2:b0:231:faf5:c1d0 with SMTP id d9443c01a7336-231faf5c3ecmr138087165ad.24.1747622119492;
 Sun, 18 May 2025 19:35:19 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-1-almasrymina@google.com>
Subject: [PATCH net-next v1 0/9] Devmem TCP minor cleanups and ksft improvements
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

Minor cleanups to the devmem tcp code, and not-so-minor improvements to
the ksft.

For the cleanups:
- Address comment from Paolo post-merge.
- Fix whitespace.
- Add improvement dropped from Taehee's fix patch.

For the ksft:
- Add support for ipv4 environment.
- Add support for drivers that are limited to 5-tuple flow steering.
- Improve test by sending 1K data instead of just "hello\nworld"

Cc: sdf@fomichev.me
Cc: ap420073@gmail.com
Cc: praan@google.com
Cc: shivajikant@google.com


Mina Almasry (9):
  net: devmem: move list_add to net_devmem_bind_dmabuf.
  page_pool: fix ugly page_pool formatting
  net: devmem: preserve sockc_err
  net: devmem: ksft: remove ksft_disruptive
  net: devmem: ksft: add ipv4 support
  net: devmem: ksft: add exit_wait to make rx test pass
  net: devmem: ksft: add 5 tuple FS support
  net: devmem: ksft: upgrade rx test to send 1K data
  net: devmem: ncdevmem: remove unused variable

 net/core/devmem.c                             |  5 +-
 net/core/devmem.h                             |  5 +-
 net/core/netdev-genl.c                        |  8 +--
 net/core/page_pool.c                          |  4 +-
 net/ipv4/tcp.c                                | 24 ++++-----
 .../selftests/drivers/net/hw/devmem.py        | 52 +++++++++++++------
 .../selftests/drivers/net/hw/ncdevmem.c       |  1 -
 7 files changed, 59 insertions(+), 40 deletions(-)


base-commit: b8fa067c4a76e9a28f2003a50ff9b60f00b11168
-- 
2.49.0.1101.gccaa498523-goog


