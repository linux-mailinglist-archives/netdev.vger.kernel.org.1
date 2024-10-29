Return-Path: <netdev+bounces-140120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534219B547F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859FC1C22671
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7120823D;
	Tue, 29 Oct 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWGMu7nG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E1208965
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235331; cv=none; b=VxQddYrCwolH3kUvOqyjMMgI0BBiCpJZ1+7r5jgGKtRqLzw8mHPPt0ZfGFXrHVpU2N5TT1KM6cF2Y+S2twKd1jGdmohsUenohNli+lc3r7f07XL39IS6E3RzQ4RYdzn0baLn4cma9y3CXcMCyUHdCU6SdKjkrJD3xhJnFEiDm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235331; c=relaxed/simple;
	bh=UnbV6MuNFExLfF8+2aKHw1foBqeANBQ10VftomuflNY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EE5CaCqSQlGrjdIQOuZfZt8lX1954GZ3ySUJpnaOqOYDhVU/Z6ZTl9+y9uTp6vYqsI9WGffTwivOCx+IPq6shLiVcQMfWZ5DueU7J+CIZRqGR7QvRU6inKlpdHY4Zi6xIAs2QKcWGOhkIRskjNp1U87sBOSplQ1XaeOI65ps2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zWGMu7nG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30cd709b40so900468276.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730235328; x=1730840128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=zWGMu7nGrUOogZZ/lb4mNSun6MEFISABT+LPCGwJnh3VmIXEDPSUcPBCpudhYfef7T
         w9+cWd4cfeYqsuEcqbcSnqkukHMSL7o2CPnHdWA+Fd+eGxG+NftB+nCyAc+05NUX6bTN
         vZhMcBuGdH7q8EYaTMhX5tKyAequroK+ID58w4gBi0fndiNdmZYMZEIKniw5JOHDdY75
         6oQXSQ5Agdg363fqC0fdjziaHsHP5siYzw+UHsezcJioZOeajugph5aQZo7r1jhDnHKW
         2qvhZMp7t6LMiiKmE/ubIvhyLLtkD4+Q/EUeb6Nd79m69k3rI2I1ijyxytzTas7bs9BW
         iBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235328; x=1730840128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=An8sa3mZsh6LbapjNQUuI8UTXoOaooSRSKEf9XuL82J2u/iBS2zTWiEUkSwDXEu6ZN
         IiQOTt6EgX3qtliKlmQYxE5cyOBO7ny4Tn37UtDFRVl3099qCOVILO6mna/1pJmHjacI
         fcgn7GNTjKEpQ/K2r7pNDAnmNYlX7qwn0A2ByEAsWSBEMNR3EvnyzvqoNPA6Vjd4DdrX
         umIiwHD5ax7QILB6Jr75y9jKSU0KgVhUV80q2IFegSStylxZVv9Y8dRoc0hzkdamrSTB
         jcnbHir/7PqW07DWAAfXJeIuy125KoaUaCgIl47zeF/kDrd2HHZVO42eoXrXWeKpy+iC
         6diA==
X-Gm-Message-State: AOJu0Yy4eUiEFot5w4try5U3op3u6eFSj+W1NFYNdbcnh1E67mWJOKjM
	kTxjIEv4FvKbBhZ8avIYsHieCrj+xZHtlgL/+Er3KN8k3C04vANT7CiPgPx+5ZlrKnEAIojiywX
	QoDALSFQ2DHQdtN8qFMAz4/E7JAo1NoTL2NUQeCRlypRPBS8javgtmGRHcdgsjBoJjE7WGEZwVo
	bi/gomVBmSyefhnhcPgZYT3NrbE7nDwHJwDQF35+4TviLg0o6mYWSyYlT0EHQ=
X-Google-Smtp-Source: AGHT+IGMfp/9F/7aUtKW5hZyYZvd/DuF+kw8AKC0A40gzCalNS+sh1n16Gs4wTxRQv6s5eZbUKL1UJCRgHCh/HWnXg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:ea48:0:b0:e30:d37d:2792 with SMTP
 id 3f1490d57ef6-e30d37d2919mr5935276.0.1730235327817; Tue, 29 Oct 2024
 13:55:27 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:55:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029205524.1306364-1-almasrymina@google.com>
Subject: [PATCH net-next v1 0/7] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

A few unrelated devmem TCP fixes bundled in a series for some
convenience (if that's ok).

Patch 1-2: fix naming and provide page_pool_alloc_netmem for fragged
netmem.

Patch 3-4: fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

Patch 5-6: fix syzbot SO_DEVMEM_DONTNEED issue and add test for this
case.


Mina Almasry (6):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  netmem: add netmem_prefetch
  net: fix SO_DEVMEM_DONTNEED looping too long
  ncdevmem: add test for too many token_count

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 include/net/netmem.h                   |  7 ++++
 include/net/page_pool/helpers.h        | 50 ++++++++++++++++++--------
 include/net/page_pool/types.h          |  2 +-
 net/core/devmem.c                      |  9 +++--
 net/core/page_pool.c                   | 11 +++---
 net/core/sock.c                        | 46 ++++++++++++++----------
 tools/testing/selftests/net/ncdevmem.c | 11 ++++++
 7 files changed, 93 insertions(+), 43 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


