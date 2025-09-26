Return-Path: <netdev+bounces-226742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 256DBBA4A4A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5101B1778CB
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886632EB842;
	Fri, 26 Sep 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSvoFIns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B572FCC13
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904299; cv=none; b=CtVbLtetFzLt3x57wdcqJk2OcmH5ePfatu/zoewA9xOyHZ43fhNtdVZ+6jtjvXhzfjj6uXXbH2pjWB5U4mLAGTnxp9ap8BV/uMknxqyMceZZRITstkPixZ5yRUzz80B/oBjB0dt84TX6V8v2Ru8mvE2yxoh2Ud1s4nOJ3TSjyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904299; c=relaxed/simple;
	bh=KyIgAIxM0qzJNyrH1RWLJvoc6grH8XPidN8Kgedl2v8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BFXhnHljrwc0JQwd8i+y/EyJXqKxrafFuLXm2Q/TfUOU1f90kreUmcrTmCc9YQ++s7GBTl+VGBCHGp/5uF6XO/RCgUrTuOkpQP7FnvhypmeSPrxp0MBJ8Lmd5ApUkpa3GkuTLYoWqYcl/PPXhYNAd8WRQaOGo4aaQN7oeXHyEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSvoFIns; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-73b4e3d0756so32280697b3.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904297; x=1759509097; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JlXCqcp4O5lDJ89rheJ6jBvAKlTWM57IAWl7u/6lrJM=;
        b=nSvoFInsgros12W2dpIeNOPbL1XIT+RBSmR9p2GADv1J4W+QH2XrwzWPeo2qrKl9oN
         n34ybXcO4erBHhRcJ6cxkRiH5n85kLcLJsuLzp5Y+Q1AEnJm/Fy+TNSD0g5QpAT932gH
         Ggjf4PhQlnQjXu0xvhUzcT61MAStNQ0J82iO1u0YkRkpyrQDsFIUFLHOwi9oSKQ/zeDe
         4EwtKVa4OVjp96Q7Nie3KqJ4LK2wOuexaxIms1Of/sawKB7i8BUul/pqfF5+dRuKawe9
         L2uia2FXdznPaTgZT6t9Xzz5SQ9lEK6YyiQ6+XPTZJps2xl/QzDoZf70QlNPm1XhDALL
         TMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904297; x=1759509097;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlXCqcp4O5lDJ89rheJ6jBvAKlTWM57IAWl7u/6lrJM=;
        b=J6MS9kPvcbimMZim0Lvtn08Ib28MRxxJNlN2SVKItuJMGNRu1Er0UMDhNUK4l5bRjf
         +o/zHTt0SONZkkLNK+vuIl6ADOWe6e2ostUpeoiGlwaBV9S13QZMVPBRYjN0QB/Lj0Kk
         +684J3+kP4Mc3XUS2JcBmI900+RbnO9qFK5i1L3T2WEUaZoOeuc7ULThZDp+qs5TFTbY
         q3fZaAqFZk+6vh0IUug0dg7CUnq39tWvcHIn5ay9eTKVGX2EzcVahuUKhB8WVH8BUr2d
         ZvNegK42ou8/xe2nNmN3XyreKN/3Czu1+Cj8POVtZwNsPmfwO9H77d27Z4KDM9jpRRWM
         ojaA==
X-Gm-Message-State: AOJu0YxCQxh2Y3LjR6hUvYtMmhDYs5oPHjY6hQSRO3eDw8K03SSMFcBG
	vYoR/ErJO9lH1gJwj0efzwfj5X5oGExBSnpFfSsZSwM7z8J1yYn6+SFjkQK4X3/i
X-Gm-Gg: ASbGncsAkF5W421WJ9z/ZdmfJE05AeHIbUUM6cwNRbz6O5k1kRErHtuWxkOef9y4fb/
	07qbZibA9Cfo80s9pqRvRs8LHx7Bb6dae17W4eN/Jb6z85gAxDwzinybMQUDCsmbMoTphz5d28H
	F16DGnV9oyl1F006N43K8cL+CbMeihhCEXKvyafzyb6NKwwWyI3mvgDgVin7i4E820FzECrW9ky
	mwTNScUbCoCyMyJLTnnW6J381f1qVGcSLbZd+KckVRwpuTD6m7o1T5hJylRT5Gz2pf/+sJCuHNL
	jgmA+C6dLTGNAUohW4fvdyKhJabddt0UvcMuQQycg3MgU8RDxSPpB36hg1NypiZIlvYhjnlxeKV
	OlFoyCFIajsoCVvpi7JSXcw==
X-Google-Smtp-Source: AGHT+IHLAOwZtKUjfY6PvnBzBbjrOGiLNSxJKSjdJ+qMor7UEuBJ1lHtFVCmE2wktnsfIJhA6x/ESQ==
X-Received: by 2002:a53:bb88:0:b0:615:14:8320 with SMTP id 956f58d0204a3-6361a873d23mr7191618d50.34.1758904296400;
        Fri, 26 Sep 2025 09:31:36 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:46::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c7ac669fsm11661537b3.58.2025.09.26.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:31:35 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v4 0/2] net: devmem: improve cpu cost of RX token
 management
Date: Fri, 26 Sep 2025 09:31:32 -0700
Message-Id: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOS/1mgC/5XOTW7DIBCG4atErDsVYHCgq96j6oKfSY1asAUUJ
 Yp89yJWVndefhrpeedJCuaAhbxdniRjCyWsqQ/xciFuMekLIfi+CadcUsU1FJdNdQvY1doHluU
 Ho0ngsUWMUN0Gdf3GBL9bqRlNBK65RXYVXtKJdHXLeAv3UfwgCSskvFfy2S9LKHXNj/FKY+M+q
 pry09XGgILXYmaztlJK+h6xmle3xpFq/MAzdp7nnXeK+uskrRdy+sdPB57P5/mp81QJK2brjVK
 3A7/v+x//QnhrtQEAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

This series improves the CPU cost of RX token management by replacing
the xarray allocator with an niov array and a uref field in niov.

Improvement is ~5% per RX user thread.

Two other approaches were tested, but with no improvement. Namely, 1)
using a hashmap for tokens and 2) keeping an xarray of atomic counters
but using RCU so that the hotpath could be mostly lockless. Neither of
these approaches proved better than the simple array in terms of CPU.

Running with a NCCL workload is still TODO, but I will follow up on this
thread with those results when done.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- rebase to net-next
- Link to v3: https://lore.kernel.org/r/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com

Changes in v3:
- make urefs per-binding instead of per-socket, reducing memory
  footprint
- fallback to cleaning up references in dmabuf unbind if socket
  leaked tokens
- drop ethtool patch
- Link to v2: https://lore.kernel.org/r/20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com

Changes in v2:
- net: ethtool: prevent user from breaking devmem single-binding rule
  (Mina)
- pre-assign niovs in binding->vec for RX case (Mina)
- remove WARNs on invalid user input (Mina)
- remove extraneous binding ref get (Mina)
- remove WARN for changed binding (Mina)
- always use GFP_ZERO for binding->vec (Mina)
- fix length of alloc for urefs
- use atomic_set(, 0) to initialize sk_user_frags.urefs
- Link to v1:
https://lore.kernel.org/r/20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com

---
Bobby Eshleman (2):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: use niov array for token management

 include/net/netmem.h     |  1 +
 include/net/sock.h       |  4 +--
 net/core/devmem.c        | 46 +++++++++++++++---------
 net/core/devmem.h        |  4 +--
 net/core/sock.c          | 34 ++++++++++++------
 net/ipv4/tcp.c           | 94 +++++++++++-------------------------------------
 net/ipv4/tcp_ipv4.c      | 18 ++--------
 net/ipv4/tcp_minisocks.c |  2 +-
 8 files changed, 82 insertions(+), 121 deletions(-)
---
base-commit: 203e3beb73e53584ca90bc2a6d8240b9b12b9bcf
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


