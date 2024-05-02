Return-Path: <netdev+bounces-93010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2218B9A21
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 13:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17B71F218C7
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AFA62171;
	Thu,  2 May 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNqPS+5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5354F91
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649872; cv=none; b=cb62gcmTF0q/huK8w8JEM0QYFD0mtkwr6wjAQU+YZZHDh9BVP+f6BVammhQtzQMuZRDtl6JzIHG0dGmKQ84n2m10aBLd2TYezGR0+Dv/awDusuOkKH2XapM9zw/hL4catGjH6NHWueVmi/UxgaT9bbeytaESYnc44awe9Jj+GgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649872; c=relaxed/simple;
	bh=wUGctZvjWBtIavNEbLIdydlfR8OlRdErhuAgq/Gv/A8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=clWFyzDpo4rRpRbM6mfvRRMCfVcWZzjtcggTdKe3oZ6wVR8jJkc+shuZCN9iudivhwXsKto5iydX5myPBaxNg1Q3+42BuRx2ONXNu8IjjYBGa3/VbY5lri2D5ZNiwRrxiuA9p7/UhhWkpsh8a+985qtmVxy8G3fRbPw5z7SPiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNqPS+5C; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de610854b8bso6350105276.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714649870; x=1715254670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vf3E/wOc6domfOAyA3epZ9ppwRAR8a+oGhXmKuUDnH8=;
        b=GNqPS+5CBmDlX3vlkcFV/A55t/oD3X/2+Xd2ClpBw///H6yjHFe1l5OBCfluPH5eoA
         Xk/4dALUhf4+GIoOtOF0hOdmOUOYJ4QZPiaoVMGfxtEQ0X/WXPc8Q0USSFHjBvqxgI+I
         cdPoPmxQx7fTnyJrkEI/QgMq4kTSgoOoUjXocC0l2gvztMVr30J/9i3pc4HlS66Zwdwh
         RXHKdKOez1ZzErAtkaGborAxJ3YRf9T2+FuTSjeZYu3luTIwD0/3tqsyvYwtY2mWzzPj
         w0EX3ueP5Hz/kno8hVk77zAJXgjP0bzR5o8zCzEWXCBQl5Bfgy6KSAjY6i0roMGAt9c0
         wg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649870; x=1715254670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vf3E/wOc6domfOAyA3epZ9ppwRAR8a+oGhXmKuUDnH8=;
        b=tdd8ONMYFLO7x1YIHkKHVGmGVwGwobKto8WtSm72KNSpqILwD3YPfi6h+ZRwwZqnIT
         rvBTVEwwqZdxpGfbYVbi8Pi289NfN8FbFUlGalaWx3LuCEXx10NRjPRfLuSwwLTSfDnZ
         OaGxDV7y0EtUJKEvEtgPQTkz78VmxguvKLecjfj9Q/X0/qRxL4Zgr+aNcxdH8nECVtUk
         Eyd30mlsewJ+y8VNTKqVeSoqAKwbRnxq8b7F9cyPyVJA3KEGo3l+Gz61q6ZdoPtD3Rgf
         d0hSPBZoc9JEM6h6zPHBAl4uApZe61t6uxj+UTeKe+Yfq/ttghgFzPN5jogLGHC8a5nT
         W6yg==
X-Gm-Message-State: AOJu0Yw1ZhHxF5znSyrwNpcUei0Qq30qCA/Q4moeZrv/O6wBqfAEDHzS
	EjxBNStx+y7JzNY/sry8K9+Q3jGeAf+/h1gUTCPXVzHatj9RP+saE94wSp2UUr4KFpUfgObUDFH
	Vn2I2OtsMrg==
X-Google-Smtp-Source: AGHT+IEJnsKE8HSQpiaQ/JhpJiZ4WbN7D0rApuWZE20LRxbhhrPsZhKMMh5txbhfEBrBeBka9/gjoOIBs8QT7A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c713:0:b0:de6:1646:58b2 with SMTP id
 w19-20020a25c713000000b00de6164658b2mr532025ybe.13.1714649870382; Thu, 02 May
 2024 04:37:50 -0700 (PDT)
Date: Thu,  2 May 2024 11:37:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240502113748.1622637-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] rtnetlink: rtnl_stats_dump() changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Getting rid of RTNL in rtnl_stats_dump() looks challenging.

In the meantime, we can:

1) Avoid RTNL acquisition for the final NLMSG_DONE marker.

2) Use for_each_netdev_dump() instead of the net->dev_index_head[]
   hash table.

Eric Dumazet (2):
  rtnetlink: change rtnl_stats_dump() return value
  rtnetlink: use for_each_netdev_dump() in rtnl_stats_dump()

 net/core/rtnetlink.c | 61 +++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

-- 
2.45.0.rc0.197.gbae5840b3b-goog


