Return-Path: <netdev+bounces-228816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BBDBD475D
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE9B8504C48
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD330FC12;
	Mon, 13 Oct 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xgv4Ddiu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037430FC07
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368962; cv=none; b=q+XKYseRb0UCpmbWjO3EZoyRVHO0NHXy7kLVY6uOQdIaDathYME8OpzKYXggAt6zvUfMyS7tYb46obhnnuY5Dh+EvtQsA7wcutvb/xSABIkqpCrXdbpbJ7rBEZGi6vTtUJfPpUmmuFT+wnRDHcx+r2Ca5wpb4foMx8EHnKcehic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368962; c=relaxed/simple;
	bh=IrGcc/fUYm/awy/FFZ4qpvnOt9+H1F6Hd3xkzVvJdWc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s6MesOGaQFf+1yBAgtKvHIkE1DY1+pNz3mKffIs0JPIY2XD4LsWhETTicwFxHgKo2PbbZd5a7SW2wTxPV6GPjk1BcAYR0WPw8G/iD1LU6Rp/V+mJ7SMKkjkH5OV56h3NhQiiUNv5luVyhHGIzKgPVevsmxlI6mkMyLQKOd8jqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xgv4Ddiu; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-78efb3e2738so229036736d6.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760368959; x=1760973759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iPlTcMR97wTpj295G35svJne+HxDAA/5taUo7lkfVUM=;
        b=Xgv4DdiuaCtcHlk26rpb93mjxeP/eKdOPrVogVJrc7XcDAH2N/qqx6P0yyp8qKofd5
         aWcnBHVO+GduibTpFj8mcUfB38mtUGRsHceFKaqGieqeg+4474+jUl0luzxx8oiqGw+d
         Ph4jh2hhXviePo+MZK7EughfX8ST6N2LfBlK5nY0LJKkUzNjTZHTU0WD8Zq3ek80GScn
         u6CY0Weoixjw5juOA6LL+hNDgC/TWpzhJxlUZENICTBVxM18RW0qWKY3HRLEfngrEW+z
         FCaJqTymKzUDX0mtxJRZGJviXZkBjRtz87rHJgGEsDtzfSknLD694dB9FkxNhOXco/wL
         +cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368959; x=1760973759;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPlTcMR97wTpj295G35svJne+HxDAA/5taUo7lkfVUM=;
        b=DB/D8OphI8uDsJM/CMRXU86Ak+NRB0NnNRH2gce4hPGV04bBwhADTaMjnr0K4qBRRZ
         wSTXDiTeJmG5Wp0MVZIoPt08VqsKebFSNxKLb8FRwigMccFe47OBacDoJ0dK6VbdaEzz
         dRLeKdQ3pSDE0+9QdWQsvB29BPcG0CmPsPJuwJWOgbcv/ZTEG+58MQDpRtwlYruR7IuQ
         rwbQWNYeFzGy8GqE7RiaUN46z1QU1QfnqNN2/Ru5TvLf/ZKM9w8xsxT9XE9usSWKD+Mp
         pK2LuYQxz8+0BhmmAHUZ3pEuVLPiNCSKF2m9gsUIFbBwIoQ6mHKwUiupl4D/P8Ttv5CF
         6m0g==
X-Forwarded-Encrypted: i=1; AJvYcCUCn27puIfXVSvFon+kUB0exxj5PsZqihtzXf3ZHDjEbyBt2tdPDIvlruTFlkw4EwpMGPzJb70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78VTCvp/9Z6NPSZWxrtG682VVHdxS7Qc43/gFf6b9zXkDi4Ya
	2KGBVrp7f0nqib5fEjTgu3Tqp0KmhcuoOh1ee9CLxq6iytm6UR/dy0NR/sYvCpVxrbBr/hsedvV
	U4+J8J3uLGjiH1Q==
X-Google-Smtp-Source: AGHT+IHHDQlyWrLveSE3nBNaprg+a9VLpxG+uBfNa+NpkYJbhL+MMBFSOW/NEstzaUX+zCur1t+sU6hm2VHn0g==
X-Received: from qvbrc4.prod.google.com ([2002:a05:6214:4e84:b0:877:d57:1ce8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4e21:0:b0:87b:b3a2:6727 with SMTP id 6a1803df08f44-87bb3a26daemr227595846d6.45.1760368959356;
 Mon, 13 Oct 2025 08:22:39 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:22:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013152234.842065-1-edumazet@google.com>
Subject: [PATCH v1 net-next 0/4] net: deal with sticky tx queues
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Back in 2010, Tom Herbert added skb->ooo_okay to TCP flows.

Extend the feature to connected flows for other protocols like UDP.

skb->ooo_okay might never be set for bulk flows that always
have at least one skb in a qdisc queue of NIC queue,
especially if TX completion is delayed because of a stressed cpu
or aggressive interrupt mitigation.

The so-called "strange attractors" has caused many performance
issues, we need to do better now that TCP reacts better to
potential reorders.

Add new net.core.txq_reselection_ms sysctl to let
flows follow XPS and select a more efficient queue.

After this series, we no longer have to make sure threads
are pinned to cpus, they can migrate without adding
too much [spinlock, qdisc, TX completion] pressure anymore.

Eric Dumazet (4):
  net: add SK_WMEM_ALLOC_BIAS constant
  net: control skb->ooo_okay from skb_set_owner_w()
  net: add /proc/sys/net/core/txq_reselection_ms control
  net: allow busy connected flows to switch tx queues

 Documentation/admin-guide/sysctl/net.rst | 17 ++++++++++++++
 include/net/netns/core.h                 |  1 +
 include/net/sock.h                       | 29 ++++++++++++------------
 net/atm/common.c                         |  2 +-
 net/core/dev.c                           | 29 ++++++++++++++++++++++--
 net/core/net_namespace.c                 |  1 +
 net/core/sock.c                          | 17 ++++++++++----
 net/core/sysctl_net_core.c               |  7 ++++++
 8 files changed, 81 insertions(+), 22 deletions(-)

-- 
2.51.0.740.g6adb054d12-goog


