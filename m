Return-Path: <netdev+bounces-107029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC1E918B0B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBAD1C231B6
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E9190473;
	Wed, 26 Jun 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AVo3ukSr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0F190468
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424313; cv=none; b=pXko1+owKzFcEfXpAV/Cv1lDdV8OlYT6K1KBzXUG3/oAEhnOHdF0JS4JhwuVArKNtD9C5TzXOA0dMlecvzR0EzCODd+7oBkCus1DZ7WYOcWC73BItxvsf3svsiJctqLEpjg5PfzG2QxsUhdhDznL2thjVlpzKWGBBU7uDdI6iEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424313; c=relaxed/simple;
	bh=GDlvt3XGGPoXvPc0HXeLhSECgoYrzvJXmylf8iosmH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=De1nzDmL1PzmPhDPqchwyitAez0kC6+/dtsCJwPrTobTDNDrjOLFmcb5KFNuP528QeHRfFrdyRrbewDBL0R41LLgCegnVnjZ9imHbkkVBvAcZKJZ6JVZls2w+DTxvG8QVJlwoA8sHqMbCh+ls4lDdqre6THEpWTrXZFmbGveeBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AVo3ukSr; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so694904a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719424309; x=1720029109; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8bcM+qz2h9oQBi32Vzgh0SCb1FZC6XKYjZp3fS9w/8=;
        b=AVo3ukSrRPm9JVNlLruRPha+YcOhXz71MCc/cT/68NYffHnE+TYDbrC4d/INdGO7ui
         0HN+3pRUFOWmrwX4AIlWZaRLmALKkXaHGNSFzZdfKcOWGrWXt+iq0eYt0bo5MuGvXhgO
         4QnHnitvxM8dKZa2zytK7OZQXEPEqAHnaYA2NMXSSpWlBfgmjFpwQUjcwk8/lcYkvkTB
         FSNlnMaV+4WrBWHWXQSEy5ArfI6OGfwo1zS6UtXDJqwHCGitfw4obl0OECXJfv0CbHNo
         PzFtbQji/Huyvjlv3pXsqcjhlU5cjYy+1If6WgEvDK9qppLPZfHCcw5nq1SxuzopLsZA
         UgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424309; x=1720029109;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8bcM+qz2h9oQBi32Vzgh0SCb1FZC6XKYjZp3fS9w/8=;
        b=SGolhrU2uKnhpL1ky6KLUBh1rYf7IjB1OwvU2DqdceS79hIPSFKOlZF7qYGp/O5NaY
         fb9HguZY3vH+0xR4cvKZGpExmTjoQSTbJwtcQSBdKYDsQtn8wLtgg1lCb588lBkyADUl
         KjCFqHH/7GQTbsIOiiIamIbE+x9EdjrPA5XpJt5GH703uHpoU3QruNLQro+G/mlt3sSp
         zeffZfzON0nkU2suWdPvNXnyZR6dmzW8s0CozQmPtGONEZOU/9wiK/Tn1Q3eWfBmiQcQ
         H+k+pnbJxhtOxPUtCupNjk5/17eLOoCLqQ7qPfCYKzm2dN54yMVqekLUfCBLtYA9mbMm
         58uA==
X-Gm-Message-State: AOJu0Yw0b1gzaLz5wdNkdGhxFN0QaALHZvoEt+peFzrXLdND+WmkF+lu
	vZlEfPa4VuSm0PNA5H7GEonSUDE59CxL0LNcoaPl0hFYxCQH3y38/fXXp3i40N66fdzkbJBxIzb
	4
X-Google-Smtp-Source: AGHT+IFygVpXSHI1tth3P/8qgOkaM9TbcrvEeDBYRB0yOXHQ6nZXrud/WgpJYJ+U8+PrM090Oargdw==
X-Received: by 2002:a50:c04f:0:b0:57d:3791:e8e4 with SMTP id 4fb4d7f45d1cf-57d4bdcad8dmr7624787a12.32.1719424309319;
        Wed, 26 Jun 2024 10:51:49 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30f3002dsm7288970a12.71.2024.06.26.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:51:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v2 0/2] Lift UDP_SEGMENT restriction for egress
 via device w/o csum offload
Date: Wed, 26 Jun 2024 19:51:25 +0200
Message-Id: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1VfGYC/22NQQqDMBBFryKz7pRkai101XsUFzEZdcAmkqhYx
 Ls3ZN3l4/HfPyBxFE7wrA6IvEmS4DPQpQI7Gj8wissMpKhWDRFO4tcdVzcPKaCmhhxT1xhWkCd
 z5F72knuD5wU97wu02YySlhC/5WfTxf9PbhoVOrrVtb4/TEfmZaewun4yka82fKA9z/MH93OvR
 LcAAAA=
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.13.0

This is a follow-up to an earlier question [1] if we can make UDP GSO work with
any egress device, even those with no checksum offload capability. That's the
default setup for TUN/TAP.

Because there is a change in behavior - sendmsg() does no longer return EIO
error - I'm submitting through net-next tree, rather than net, as per Willem's
advice.

[1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/

To: netdev@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: kernel-team@cloudflare.com
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Changes in v2:
- Fixup ip link arguments order (Jakub)
- Describe performance impact compared to regular sendmsg (Willem)
- Link to v1: https://lore.kernel.org/r/20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com

---
Jakub Sitnicki (2):
      udp: Allow GSO transmit from devices with no checksum offload
      selftests/net: Add test coverage for UDP GSO software fallback

 net/ipv4/udp.c                        |  3 +--
 net/ipv4/udp_offload.c                |  8 +++++++
 net/ipv6/udp.c                        |  3 +--
 tools/testing/selftests/net/udpgso.c  | 15 +++++++++---
 tools/testing/selftests/net/udpgso.sh | 43 +++++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 7 deletions(-)


