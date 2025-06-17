Return-Path: <netdev+bounces-198801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E91D3ADDDD9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A590189D6BE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D92F0C66;
	Tue, 17 Jun 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="llwU1GOl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1C2F0C51
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195275; cv=none; b=kjXNqA+nIDBUEDG71M7ont0BX9hwvJaEUbKCCG0i8YW2LigipPvEMngmpYqok7COIIKQhrcpqnzU/2qLXXilU1ND7UMfcJYRGct/oJjbIAryFvbrYCc8Cu1Am06kz26G4iuxQLbDh50e3p8Cl+2s0wJ4he1xbdpDN5IIhfXee8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195275; c=relaxed/simple;
	bh=ghAlQ8swgyvg35n8kIto2l2q8/TqHbqUK8up7gWveKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJJqQi8R+fO0pJXSf3Y5JVNZBaPnZY4DVRabbwLJe+5fZ7g+URqHctggpQ9HhHhAeQMBDIkZ68JMQO7cS2NvMEllU1Zbp4gyJSaQNfH8UJtg586T6ReucXhIEN2gVseWvLEgxcfj5xe8ViacbUAJ/nf5Hhw5pNx9ViIpI9Dtr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=llwU1GOl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7487d2b524eso3246939b3a.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750195273; x=1750800073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gIz4H+2pv9KQZOljDt5KCA3lWDXWg/fXMu/yNzlViw=;
        b=llwU1GOlPY4VobZ5kL2n1r5CjxSt7SV5LAHi73ZOa7pdeNtALjZlGISfWM/ooHTUUm
         VrDASJHxZ2oGWls3ITMzkzRZWhCsVBLuWGW8vRJDHwICjSj0tY4L+SgtgHPScitQC9V9
         ZKm4Qq8CEoWQujypLJNujUPFApOOqUp3LddAqCr01D9y5TTcKyF3SLrXXMx5k/vYJIU/
         +TBVXPYRzWH9VM5aBOkM3PbYXQ4DM9ye6AgWUNv/ap1m6bydx/lMDwQXwL78iBQYh55N
         B4u0BsvOh7pqN00e2DVJvvWGJqhW7rSfxCDzr4WEkS9bMZPet9njppKxysCVDmAzXUj/
         dfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195273; x=1750800073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gIz4H+2pv9KQZOljDt5KCA3lWDXWg/fXMu/yNzlViw=;
        b=NfPZAgBMAPI0sBssfVpZ+crqraa5RCQH+0Tl9uYk/iTxufHWl1vZXwgwgcc/8Inbs5
         GiVWFrS37Y8yqwBrEj4/LcDgeaq3umbNgx6YB76vBuL2L0/r/+jG31QWZ9GtwSrIfsgE
         5GMBtxsq63DsAipXIrDPwFdQZilZgwHbKMNKBtU7KXXBSebOtNqCSTTwZfzBqL1GIE92
         Xq2AYb6nGpMfn2xnVuaiKRif4uOTVOXjV7MJRRK+QgBTJd9mtSLqN+2f4Rkl4sDwE4x7
         ZQvILmDTLmO43Oj2U9VVZQAgAhnGmVMf+KI+3OcZJoU1+7hFxhtVlYeXswzXHsHTDG/i
         xULA==
X-Gm-Message-State: AOJu0YzHVchAUWwbI75s04WSTvGdOqSGDzOFZ3Eyl7AAQj+x6x+ww4+1
	EoDonlbL1EsO6L8FZf3RXSf7NkxwQ5VnqWwOAe3jhiOhliRAnf0S4pLdCBQpcT+xS3vGEIP3cM+
	svcbJ
X-Gm-Gg: ASbGncuhxXbUy8JXVKQBtYpSGDiWANH5GVOHvMzsM5Qfnng8ZDYBalJIYinWbqr4JNA
	RKD+QBL6vzEIe5SJK0Hw8ySnpf9cio+SH7SEIrTjBne0FSsnMHfkcFGKn2+nyHr5H/tyz2W90mK
	E8/vD9ubYiB3bfxW/FpRo2v6m7e2KFxLHCOGB+Bh3kqnnuLdq1vLvjJsuZjFNfaK7r314F8BP0K
	JEYCWgCUsJvzqhCdRMbZDxefiLAVcZtryQuHxsFJT3co/aIZwPrGdVWGZr0hEQP0UswOGnI00Bs
	P7rfyST7RtbP63G8h649Af3nUlaBKDfmZcucFBxzg6nLeuPk0SGfDg7AkZQ=
X-Google-Smtp-Source: AGHT+IFjJYJY4HUnRemVKkvpiXWB9kScTBPZwW7E27iISmUbRxII68iwE5TffemguSIHj1oFVvSnGQ==
X-Received: by 2002:a05:6a00:1142:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-7489d050d66mr17450589b3a.22.1750195273209;
        Tue, 17 Jun 2025 14:21:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900ad24csm9739582b3a.109.2025.06.17.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:21:12 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v2 4/4] tcp: fix passive TFO socket having invalid NAPI ID
Date: Tue, 17 Jun 2025 14:21:02 -0700
Message-ID: <20250617212102.175711-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617212102.175711-1-dw@davidwei.uk>
References: <20250617212102.175711-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug with passive TFO sockets returning an invalid NAPI ID 0
from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero copy
receive relies on a correct NAPI ID to process sockets on the right
queue.

Fix by adding a sk_mark_napi_id_set().

Fixes: e5907459ce7e ("tcp: Record Rx hash and NAPI ID in tcp_child_process")
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/ipv4/tcp_fastopen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 9b83d639b5ac..5107121c5e37 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -3,6 +3,7 @@
 #include <linux/tcp.h>
 #include <linux/rcupdate.h>
 #include <net/tcp.h>
+#include <net/busy_poll.h>
 
 void tcp_fastopen_init_key_once(struct net *net)
 {
@@ -279,6 +280,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 
 	refcount_set(&req->rsk_refcnt, 2);
 
+	sk_mark_napi_id_set(child, skb);
+
 	/* Now finish processing the fastopen child socket. */
 	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
 
-- 
2.47.1


