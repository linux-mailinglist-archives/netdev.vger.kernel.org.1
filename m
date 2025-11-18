Return-Path: <netdev+bounces-239613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D04C6A3E9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B7F3F2C1D3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B031B829;
	Tue, 18 Nov 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGT28uhb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673835BDA9
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478748; cv=none; b=PDqAfB5WffEsqW/di5UVLocYrxX4+g6/Gp52CvpUGs0PLoaZMutK2/Jgg8gYxb4Fex3LK128ctW3Jtw5ng5NLhEV/pSD0KhJXLuA2ixW7VHZt7rVtSsvBIvqwjEB7o/ioh9qKOPxGCK4ekXBhNZrspzNsmQPBaAwRI257b42f+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478748; c=relaxed/simple;
	bh=Nhe5Vyvd7g3uc40woC2LCvlNdBNdD0TtLzwI7IjsW8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oq8FUBgxscJgJh9dUBUxMLTnQcDLzSqnm8I44GSfCHCJYFc2bEJG98M53Vxfjjoo5OSL1MEdl536Ek+IiGKhQxa70DW8ua01KJdQv3SJ43wiGXx2PHqRvlQBFbdmPvtJsGy3CyCzlO/Dp1XpQZnGIKIGrqntt3EBRcmqA7NaZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGT28uhb; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so6322038b3a.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763478746; x=1764083546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4U8n227WVJ+/s5DuMdAgZErEGsun6YIE7b8NKGETq30=;
        b=aGT28uhbx5qo6AW82uvbQUF0y6cD/yodOULr6hVSzRs4BzQEzonyYqSzjgr08IOYJM
         NgMoq5NskKuLT4zDgaMhUQ6Zxbmb5Ns0APzHoiENWEYX24g00QNjeshry+h3tmGzvQnm
         YY7jHF/bBgvU8ZqO54iF1drC7hqkCQfWGc9LxV7rqAVhOoQ20nwuTRdPi+YUwrGVjnEX
         a1Og7S6so9oeF1+etPemEKvuvWvsXYjEpgMGm/vH16+QFSBoHTKDzDaMdb3DSKL/tBBa
         HY8FN9T8scZLhpIJsoJd3TSv4UFXnwtsmRuECviV3CCF6d8YGSjaHzBUJi8QMuE+9Lnr
         aaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763478746; x=1764083546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U8n227WVJ+/s5DuMdAgZErEGsun6YIE7b8NKGETq30=;
        b=h7COzTeTzrB4M1Q+0aM3wP2AkGQVT9hC7vzZQ+fHrLXAkBYnwO7Ms2P4MqP2bkLqjH
         XPD9H/2eW3yTuahJV2hb7AFDnt3qjimGSPHnb8X1AArSDRS8NH/lm4qDBrq0EMA1gmUK
         +0/+fLUKvc4srRtvUG+a3DdBWO8IYAg/WKW06hURHNtmIBPmrzFu4I/K/qr5kjIO6VMT
         5gnK0mTpoomDb+KearFWRhOFFrqnqgje6Hln19i/l+lntWu91h0I+mNfhmIs4vSMPJKq
         KeAxa2YQ7+xULZ3rS6AZZees4d3w9xBGwrDjcKo5FG9x82egqJOqeJoE7lB9bkgnlU+5
         nmsw==
X-Forwarded-Encrypted: i=1; AJvYcCX/FEHKbQcQ60fttV1c3REeCGW/CgfzJ8OLyUNkaQDmYwgNC7z7rB4JoLPOzvZZNam0IS1OMtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0pecB8EetFS4bHY6qeJfjbslQZtraOPj7bRI4UvMvSZxrTMH
	AuAA0zahLaUp9BWGcD8WS+nAbqst11FABS2TS4AR5kce3VuxKxt30qL3e33ccAll/xhATQ==
X-Gm-Gg: ASbGnct7RhiG1AqBUnjVuJohYLTxVChvxOAuELnJE5xzGDgggvsJ9sna+C1qMQdWiYH
	TRydfVEO8CzgRRAu3yW/IxgL8HiBW0Axn7Y+KdijASWd1FuszFjMfXl1U8yLzkNJApGch3/DTZY
	3io4376oWTP8bH/ixfhgFjV1KrI0MK8a1Jn+I6QesBNBiO+rJU8rEhN1wFxsNcP47zo9wK07H+1
	8q6ovTjrU6Dh3dvggQE26nmpiIyh+wfluF+7R0lyqWufAhO6dnVXOX9NkHKg2VGPrAKmlUlQJXA
	FeTsf4HlR27twGByWySi3sG5pEJTnD9rt2V3YWBw1TaoJTk/xGcKzEz59mwcnsVwTD20SmLSi3e
	c/ljVqB1uVq4v/JEiwug43dPfB6a2JOuhsZphXaCQm2exy2KU8nXtu0xHXQHeFL/OHzhAu7zBFn
	NAywUCEqnIeO6KB00D3QosH0o+wikGzB3Qw/Vbdl+WZQ==
X-Google-Smtp-Source: AGHT+IEujV1fUJ8lZnQHc6gH+zbAny7hB+uRThe/ABbVHlvWbOoSDuT1svWqm9T3c6BG1veFPuF1wQ==
X-Received: by 2002:a05:6a20:939f:b0:34e:eb6a:c765 with SMTP id adf61e73a8af0-35ba1c8bc80mr20038159637.37.1763478745965;
        Tue, 18 Nov 2025 07:12:25 -0800 (PST)
Received: from DESKTOP-Q6PJO4M.localdomain ([221.228.238.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba438bed8csm14148847b3a.53.2025.11.18.07.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:12:25 -0800 (PST)
From: Slavin Liu <slavin452@gmail.com>
To: stable@vger.kernel.org
Cc: Slavin Liu <slavin452@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [BUG] Missing backport for commit b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")
Date: Tue, 18 Nov 2025 23:11:40 +0800
Message-ID: <20251118151140.89427-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I would like to request backporting commit b441cf3f8c4b ("xfrm: delete 
x->tunnel as we delete x") to all LTS kernels.
This patch actually fixes a use-after-free issue, but it hasn't been 
backported to any of the LTS versions, which are still being affected. 

As the patch describes, a specific trigger scenario could be:

If a tunnel packet is received (e.g., in ip_local_deliver()), with the 
outer layer being IPComp protocol and the inner layer being fragmented 
packets, during outer packet processing, it will go through xfrm_input() 
to hold a reference to the IPComp xfrm_state. Then, it is re-injected into 
the network stack via gro_cells_receive() and placed in the reassembly 
queue. When exiting the netns and calling cleanup_net(), although 
ipv4_frags_exit_net() is called before xfrm_net_exit(), due to asynchronous 
scheduling, fqdir_free_work() may execute after xfrm_state_fini().

In xfrm_state_fini(), xfrm_state_flush() puts and deletes the xfrm_state 
for IPPROTO_COMP, but does not delete the xfrm_state for IPPROTO_IPIP. 
Meanwhile, the skb in the reassembly queue holds the last reference to the 
IPPROTO_COMP xfrm_state, so it isn't destroyed yet. Only when the skb in 
the reassembly queue is destroyed does the IPPROTO_COMP xfrm_state get 
fully destroyed, which calls ipcomp_destroy() to delete the IPPROTO_IPIP 
xfrm_state. However, by this time, the hash tables (net->xfrm.state_byxxx) 
have already been kfreed in xfrm_state_fini(), leading to a use-after-free 
during the deletion.

The bug has existed since kernel v2.6.29, so the patch should be 
backported to all LTS kernels.

thanks,

Slavin Liu

