Return-Path: <netdev+bounces-258773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMOlHmTakWlpnQEAu9opvQ
	(envelope-from <netdev+bounces-258773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:38:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF91013EDFD
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C99A300CC18
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D12C234A;
	Sun, 15 Feb 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcO6PAQG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD43277CA4
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771166306; cv=none; b=MXbq+iSsvXlb1lFE9hm2P8+Zt+KwhDkDHUA1qftQdg0DBTRKUOJ6S27G7ryOL6Sadh0Pa7vWNPrP6a8i2Fx3tYyfzxuehHZP2gMya5ChADJDgZBT6PtOL8K7qbhHwyPXa+o1L5UrrlBXN7obx/5CklJcrRD/Vb3OLyiVBw1soSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771166306; c=relaxed/simple;
	bh=Wd9bVZLzZdLdCFvX7VM2/EOv11A4D9K1ZgZHqeUbDf0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MTBAt3fmKlCnSKi4LDw0RvQ7p1Rp22dq+U7uQElBLuBIlvSa3R1KwnzcuvK5J6uKD3mCz8EzMmhUgfr5bG6PLrVAj2A1I/IL4RAkI50zxgdwgXFkXbsQBXQe72KtA5lfWvzoW89L997YA2mAEnxZv8dqi/yy309CbR9d1KDsCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcO6PAQG; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c71655aa11so1585444185a.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 06:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771166304; x=1771771104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lD+UUJbjVGxWu+cO9I99VoBlg0cYRrQSWMxbmuIJzAA=;
        b=ZcO6PAQG4mF3MSH1NZVEhhbRP2xn4ahZX0ZhOCcHibE5Fy3JHPoJu0HQaxnkip8Vyq
         Qhhso9SdBa4Qc//apE1ohr1E4uTxFMwLolo8VpbcGtVoPP4cbQ7E8mVTSIawgUyJ+hKu
         UfBnqFfYo/cauoewuT8c5Y0MYV5m1O0t/fAURu/U/FDgxQoLV/Y4O9BORj0n+s97cs8f
         9VvCtBG54QRZfTTNalwW2dCN/STBV3VQdFYHFi40otjVAZlzEDA4Ui6X4Eg/LFduC+3U
         ApaHWwqYcjuYgCVgk46qqfQkThn9ka+vk/GaCvA+wqAdj80wbW8UHXkzQYM/9y15/yvj
         /bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771166304; x=1771771104;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lD+UUJbjVGxWu+cO9I99VoBlg0cYRrQSWMxbmuIJzAA=;
        b=s2V4JsRuxj0449incq2RGWiXAWaUreB3tcAMeW763q1zLnlETrFePvbeRdetDF8sLE
         rwB0eWfHf2U6F/Da8LxSnim6sGk+N4ir9P6LGL1wy/PusiGbvmBpdNiRAwJHmBzNG+ti
         VdploxXWLYUq/peCxvunksMVpZCnx934WRHm9bG8bs4yQSi/qywVTf3M8L1IWLH04mPi
         Fnjc77kvA2bIXg4LJfIFK+i7FMLotm8t6/o5S4lJs4ZzK3BLQQDp3+UI5ZgKUsiz3aj8
         B6xcM0TcWCd9mz8UAsVOLAiq8JWfLWxTrl4mg9T1H5VuDfMjKDRKMXVHH+xRGNRsiprk
         LAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEk56HGaXBx8oBJoCsFkbJv3BYKNXoJtR5FyeR1nqMmbGN0RW3J7EgfJAkMffVdcmCagL6AV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhw7o3tMO6L5Y4nLrXN2pbHcDgEQ70MFEP/69eZPQEZl47oe7V
	DnBuAQpPOGwomCp4gT6pLwJpHKFUpqrusXSBwZ6hcfWCBhi7zKhD26QpJmmvsPQBlE5XohmPA/c
	fxq94UIh1LDSwKA==
X-Received: from qklv11.prod.google.com ([2002:a05:620a:f0b:b0:8cb:5ab6:5a6a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4709:b0:8ca:a950:238f with SMTP id af79cd13be357-8cb4224b3b5mr877484585a.10.1771166303516;
 Sun, 15 Feb 2026 06:38:23 -0800 (PST)
Date: Sun, 15 Feb 2026 14:38:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215143821.2330791-1-edumazet@google.com>
Subject: [PATCH net 0/5] icmp: better deal with DDOS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CF91013EDFD
X-Rspamd-Action: no action

When dealing with death of big UDP servers, admins might want to
increase net.ipv4.icmp_msgs_per_sec and net.ipv4.icmp_msgs_burst
to big values (2,000,000 or more).

They also might need to tune the per-host ratelimit to 1ms or 0ms
in favor of the global rate limit.

This series fixes bugs showing up in all these needs.

Eric Dumazet (5):
  icmp: prevent possible overflow in icmp_global_allow()
  inet: move icmp_global_{credit,stamp} to a separate cache line
  ipv6: icmp: remove obsolete code in icmpv6_xrlim_allow()
  ipv4: icmp: icmpv4_xrlim_allow() optimization if
    net.ipv4.icmp_ratelimit is zero
  ipv6: icmp: icmpv6_xrlim_allow() optimization if
    net.ipv4.icmp_ratelimit is zero

 Documentation/networking/ip-sysctl.rst |  7 ++++---
 include/net/netns/ipv4.h               |  9 +++++++--
 net/ipv4/icmp.c                        | 17 ++++++++++++-----
 net/ipv6/af_inet6.c                    |  2 +-
 net/ipv6/icmp.c                        | 15 +++++++--------
 5 files changed, 31 insertions(+), 19 deletions(-)

-- 
2.53.0.310.g728cabbaf7-goog


