Return-Path: <netdev+bounces-173930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369AA5C40C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F87D188C628
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8F25BAC3;
	Tue, 11 Mar 2025 14:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07B79EA;
	Tue, 11 Mar 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704030; cv=none; b=mQMlCkp1+2bm8ssnquaTXLWmuJx9Ld9CJMpCHzhAyGqaGw5u2l1pj3xvQ1lwz0HCdRE4W8PMZe/s+21/1rUhPtHO1P/1dDoh6zbuEYBh7X0WQEK7H84kw+tmcA6AJXHKjXoY4gmo2FEChu18pPYZzmE+XfGPnZjxiQuQBL2wwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704030; c=relaxed/simple;
	bh=bdpQuWOogWUPU+LgodjEDpZ3ZW4UKjg9rQLjtDiWfkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bd4mXzxfZsG/bt1+ZNggnlPPnAIbN+Ajr5KBp1evG/Y59oM4APhfAIebVT7LBuSlcfECYkTt/JZF0QXlWgGTzqQNsRjKahx1dTc50XadCH2BAFE51J0s1gE2BdeDtFburtUbap+sJyFWWM64+6FH9Ti74a/AhipLrNsMuIOlogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso7589256a91.3;
        Tue, 11 Mar 2025 07:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704028; x=1742308828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGNuY196QhTC5kCQhQIas1dZxtdWGaoWAup+oKiawFo=;
        b=k3d8QUaayKh/CWCsSoEMbz7Y+vwx4baiq3Ok44EkuOqbsLiZ7ZZn+ZgzaC/St4VJ+s
         IGrYxcQTv1gGZiheBOfEIBwnN+XFFhIXUZDu8nkIcgJBJFsZDDhQ3UP7fxEKMNJZ9KfO
         WKm6XMynX4LLZ5XIoK6zVgjlWUG1wPdZ06RhGfW1bTfKes19cAgSnCkqHLOx/I7prHcy
         bNEATcvcBj9ki/XkE1N6RP2OYmMkuhIWeW/2xca7/jfU4PGSRC3czMl5Lc738Jj8lDyD
         CJxhT+3wP0K3O00ki/sEDe8l6xdStrw/H0C1vJ/PXEqA+mPjt+GjIjcJ3wxzpWxj19pp
         wd/g==
X-Forwarded-Encrypted: i=1; AJvYcCUSyvgJmTzU0PLTD1UPdcsgFXe+m1Hb3GUYyc11+K68xRXJEVVxbke80x/YBvkaNuDIy10FmrL0SZTMTO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYNm5TzpKDfs7jQ9ijK7Dwt82pc1f1Ln0hqJ5fyN3NpqromDR
	epkXABYLS1OTdF/nbcB92kr9UGjxAIY089AhLHIwzZHRgIzG5nnhwbV34u7WZg==
X-Gm-Gg: ASbGnct70ZyzTJZjB58144LtQcAF1U3JeZPNXlmVJoCfq3Amf7r1zIJv/K24veNMk/M
	oBS0wmzNAkpiyvaxM91h1Hp1ybYkoi8+4mDsz6lmMPVBUXhldVNcoUDc3S9hNTL7X8H8WnabDBL
	l928mUYapmPchUz7HIk5EeshW8F1wXyCLkLawF3kq/wyFqtBDRAo1iYFR3H31GphOjr6+21DlFc
	if7hKxLvbtlbh99ZZVO9/+Qt2RbcO3oagkUkRY+x9pbNouLGKSBDoIRm6PbtS9Lp3n4xCIJK/R+
	JBLXuhDRDZDkjzkIx8ce84k0zwuPs0sv35eTwpSg/hnGDr0hXQZktjU=
X-Google-Smtp-Source: AGHT+IFvn53gcTq8I5rCxoVqGBE6hkhvplWlGFZ1Wl5BqiIXMH147v8lMAX+V93uwTwHnl2v8LsWew==
X-Received: by 2002:a05:6a21:7308:b0:1f5:6a1a:329b with SMTP id adf61e73a8af0-1f58cbc548fmr7756611637.32.1741704028036;
        Tue, 11 Mar 2025 07:40:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736a6e5c13asm9270443b3a.157.2025.03.11.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:40:27 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	xuanzhuo@linux.alibaba.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v2 0/3] net: remove rtnl_lock from the callers of queue APIs
Date: Tue, 11 Mar 2025 07:40:23 -0700
Message-ID: <20250311144026.4154277-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All drivers that use queue management APIs already depend on the netdev
lock. Ultimately, we want to have most of the paths that work with
specific netdev to be rtnl_lock-free (ethtool mostly in particular).
Queue API currently has a much smaller API surface, so start with
rtnl_lock from it:

- add mutex to each dmabuf binding (to replace rtnl_lock)
- move netdev lock management to the callers of netdev_rx_queue_restart
  and drop rtnl_lock

v2:
- drop "net: protect net_devmem_dmabuf_bindings by new
  net_devmem_bindings_mutex" (Jakub)
- add missing mutex_unlock (Jakub)
- undo rtnl_lock removal from netdev_nl_queue_get_doit and
  netdev_nl_queue_get_dumpit, needs more care to grab
  either or but no both rtnl_lock/ops_lock (Jakub)

Cc: Mina Almasry <almasrymina@google.com>

Stanislav Fomichev (3):
  net: create netdev_nl_sock to wrap bindings list
  net: add granular lock for the netdev netlink socket
  net: drop rtnl_lock for queue_mgmt operations

 Documentation/netlink/specs/netdev.yaml   |  4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  4 +--
 drivers/net/netdevsim/netdev.c            |  4 +--
 include/net/netdev_netlink.h              | 12 +++++++
 net/core/devmem.c                         |  4 +--
 net/core/netdev-genl-gen.c                |  4 +--
 net/core/netdev-genl-gen.h                |  6 ++--
 net/core/netdev-genl.c                    | 38 +++++++++++++----------
 net/core/netdev_rx_queue.c                | 16 ++++------
 9 files changed, 52 insertions(+), 40 deletions(-)
 create mode 100644 include/net/netdev_netlink.h

-- 
2.48.1


