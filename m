Return-Path: <netdev+bounces-159153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27EDA14877
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 04:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326317A0371
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241A046434;
	Fri, 17 Jan 2025 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVvugehg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07025A645
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737084057; cv=none; b=nnbT1xuSJapnVnxAjjotB2W6PZy6gegCKK57P5uv0yVUWej6Sf/zPkiSpKyZ6cep9cf4xNLjoHHg9fA6spwHuZhqmxyqu4UkoBSLQ7YFA99Sft010ZnvQ2ZuhHPm073p+zmvjKmIPY3wdpSf/QuYFz5LWLUOZked3IaMpuNeiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737084057; c=relaxed/simple;
	bh=tk0Td0mT3UCKTwfWfB24jqy7yGvA2xz0TcYAyfiKntk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QT5jsAnNiOiWbWa/XXDeA9MEHJXspNrdQPDYFtjgzv+5xjZH/twYfgqI890u4GF/cLw2pBRVhNCfJiov31ywZKP16Fzfqv0oDvk+qOn+fl8WF7xa8CGWZhpghM+NrzFo4M7UXeVmj8fPjYEE0sucqF++GSEOVXkjquUbol/Qmfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CVvugehg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166855029eso33155435ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737084055; x=1737688855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmGSO1dAuOcJ0TE4flbT5/edisN8oiao6RNJkH950Dc=;
        b=CVvugehgrd+UFCJfoWAGN7jwbligHo+XGv8r+lPo8loeXyAWx6ZnDOF29wxcTCAgaP
         vY0kaJtOJjC116thSniMRImzv6UknJofY1FeajFeAoLQsHxH6TIC8RqWPOLvFHhRNy/X
         FsrC0XL2yy15s+HOFR/Wgh8xDZ1F/HpQzz0iQhPEFY6bp7mFvADuHdaWQmgMP+XYlSoR
         gUdkBMnHsIp7QYyhvSAUOxNTa13j9QSBGS0idjhpdhPjVyBwzk8exb0+vj7R7uQUBi3K
         MQ76K+e+zJZGsc6ocYCfKN90eOapxtxhbs8JBrWTE+wjbOY4fgkcJ5dOsV5dvmWtEwHN
         3nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737084055; x=1737688855;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmGSO1dAuOcJ0TE4flbT5/edisN8oiao6RNJkH950Dc=;
        b=EYsPn+MSlbO2yYPuGIPbHC4r2pt1ISyZUSDa2pvQWMaTtiGTqi8BmwjlecnlRB3WtQ
         anDafpykcDjD/Dju5LXIty+GVSVDnUn/YbhvKmBQ8cXgxzJfs8IXwsIRZOgOICBdN+z1
         RljQJeKYWxVodHQdMUkfrCkKWuVV1U3la8422Oaovmr0+ei01MUuGUAM0UXh47+SZoNU
         hv/v3YbTCu/kpYKYe6BeeIcv5WVN3oAl29pHMQxk1biq6pktBkI3AxNN8s1Sfov256S+
         +cM7k7p9/wg+gFGKtUxosqrrvaKPvANxLlljYOE+UO/lPatyIKrz5V23FT+mZbKKRNZr
         oPQg==
X-Forwarded-Encrypted: i=1; AJvYcCWCYESZ+S7EpqVl1PUuMF9zzAMaAqamZwvv2RoRJSVHs+jZEIIQLvse9/2MEq5sp/iVWlKknCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AUXkbHPIHDHysbm1LY/fgWhS7/USQcLjXiZVwQCZSkyPOAkW
	nEsWVtnxwjdcw3A8aijb1Yg3+r4tpOwub2Upw3+BHsbsNIdipmecaiWNeeOeVKUYki4lSxWgqFH
	yNGjttj1wj7lGoAzdIZWiWg==
X-Google-Smtp-Source: AGHT+IH81JWuBLXxkXPazbb1VnotP/r9RcC9hhR89Ph5NA0FO5wv9htGhxzhosSUyrubwE4EbHvIMZK/iFzbTzdBMA==
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:7fd:483d:9d10])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f690:b0:216:4348:149d with SMTP id d9443c01a7336-21c356228a8mr16566725ad.53.1737084055006;
 Thu, 16 Jan 2025 19:20:55 -0800 (PST)
Date: Fri, 17 Jan 2025 12:20:39 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250117032041.28124-1-yuyanghuang@google.com>
Subject: [PATCH RESEND iproute2-next 0/2] iproute2: add 'ip monitor acaddress' support
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch: https://git.kernel.org/netdev/net-next/c/33d97a07b3ae adds
support for netlink notifications for anycast address join and leave.
This patch series updates the `ip monitor` command to support
monitoring the address changes.

Patch 1/2: `iproute2: expose anycast netlink constants in UAPI` is
added to make this patch series compile on top of main. Once Linux
UAPI headers are synced back, we can discard this patch.

Yuyang Huang (2):
  iproute2: expose anycast netlink constants in UAPI
  iproute2: add 'ip monitor acaddress' support

 include/uapi/linux/rtnetlink.h |  8 +++++++-
 ip/ipaddress.c                 |  8 ++++++--
 ip/ipmonitor.c                 | 18 ++++++++++++++++--
 man/man8/ip-monitor.8          |  5 +++--
 4 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.48.0.rc2.279.g1de40edade-goog


