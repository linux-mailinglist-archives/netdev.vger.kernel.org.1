Return-Path: <netdev+bounces-197660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B8AD9881
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50924A09C5
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7028DEF9;
	Fri, 13 Jun 2025 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0yO8Df7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BF28E594
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856153; cv=none; b=tFts9wTney3W7jq0M215fRY1swt14smE0QkfkBWULh6a1DfAf59WMCLVeFLqDv3yq7ZoQFkvXcdbPHmEbi3EHl+r9dh8cnIKKoK3zu0wID6feABAmf3dScqLk/38lJC6mSr+d/Rcd8E04pdIo0vUDYlXq71EgG/8XBLz25JTPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856153; c=relaxed/simple;
	bh=J0LKIHEIdojKyxZbmiNTd76CxGw5pJ5EghHsawREc1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmSiReLuhjhIpYXOgLzxLYOwwiLQP+CadsQQIRiZj5lQ+CnTkjGejk9AdBk6nEw6hLE9pppxhYqTVF90uBChObQvfj8O6JPGxiBLIMonIDK5Lr65UPgwJzxtZ5gvfnFb8PNClPO5hI3ISH02tmD/G/LCKPel76W+86av3K2Z+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0yO8Df7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c921ec37e5so34378685a.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749856150; x=1750460950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fFRlNjl9GKzfq0vtzMG+m4QiwvBHWFCmSbIidDRRnA=;
        b=Y0yO8Df7kGk/tFR+0eAN4ywoxAP33RY8vHCnUgCEPzq97EKzBtwuCMRXTt5T/fS0Ao
         Hhkv42/oh6KwOgqlVwk18iV5+A78e5Ff2peWplnR9BDIhzacIXZaR1z6qe1lmBcZMvUh
         NSvyrmjm3t51S6M01WdijqOARWDmrNFyrnReqsd9ol5AgadarxHIHM+fFX9TK9qCjDow
         PbfZqcJnIxJRMCT42myZ/JDhXue/mAmkgDnIC/AqISUwOSKc1a+AJsiDTbk38ul3Zdwp
         +c/hkDAx0MoMqeiPoPwQSmRlYMLEu9AtzKGNd4mRMebqypIzjB0WXi8b9EgCaO8Zn7EZ
         jhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749856150; x=1750460950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fFRlNjl9GKzfq0vtzMG+m4QiwvBHWFCmSbIidDRRnA=;
        b=j7WXibch+WEX2rS+kRlf80YwxWTt05rB7lU1O44foun8nMQwU3vhKFV/SvFiEeyr0x
         u1rN30izkbZzjc9nF9nDCq/x2VyCAYW/1bwxaFo8gyS4cyQyXviiGKWuW6RnODoixnfZ
         cm8GwTYcKvDPzzZvcoGsZpmUGNHfRS5H8X+m8j6T2gUpKebFph1aM+/sg0cXAdDUjngy
         cRinzC8ZnjI57w2Wy6UeLxkXyxFflhkbkkwOv4TQhlDmgZfIJOJqYIfqJuRdzmxhAkd5
         TsURAUDu2mUekhyR2ihbI1TGk36TaJ/cpGuenVzdqlBFmYYycvsnVhVqEqzvmV27Es+e
         3DbQ==
X-Gm-Message-State: AOJu0YxGJ9rNKY7SHwW0FPjmMQvKP7HWMUscHQ2TBOy6/20FVYT0fpJZ
	c4Nr+nJkbzUILjwc8UqzBe9JizAAS5zxJmXnvSoqQcv06jdlspAeszPVPHXHzA==
X-Gm-Gg: ASbGncswrhqHzN78be+DnZboOT6YafLA3QpLQmLuY16MY540/d5Ll8EcszJfgpOVSSl
	olQKoo/T26kERwRbBrqZ4dPrHmrV044p82PMA4y4m734Xbw6sO4zVaSIwZcgxn/kk7u9DM0aGrF
	cenvN47XzFtzEDyB5mOvYgckE3nu5+uvyJzRu2xHzl22T56e97Wx9qOw1DVBVKA2ADOEgzsijqk
	mA3ZUQqLnzUMkUMXVROiPAY2iaGbwE+qxwGi9PRmEELHxFfX7s9LNRtlpenTmaeBNA+P8pItTw5
	tnvGTYa1r9Sv0olSR32Wpn25A/225/nY31baxbmng/ZA9hhHFk83LJMbqo/JXzDElhW9Vssa9n9
	0m1XD
X-Google-Smtp-Source: AGHT+IG0bSUqSjW7EyaYj/mtjr4Zlj5j/RLI7xOavwbgnwVaLdccfytUGGbDt4CoYAZBkpD2FAdEfw==
X-Received: by 2002:ac8:5d47:0:b0:4a4:2f40:d720 with SMTP id d75a77b69052e-4a73c527a20mr6862461cf.8.1749856150447;
        Fri, 13 Jun 2025 16:09:10 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:315:8d12:28c7:afe9:8851])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a2f4fc5sm23122651cf.26.2025.06.13.16.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:09:10 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>
Subject: [PATCH net-next 0/3] tcp: remove obsolete RFC3517/RFC6675 code
Date: Fri, 13 Jun 2025 19:09:03 -0400
Message-ID: <20250613230907.1702265-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

RACK-TLP loss detection has been enabled as the default loss detection
algorithm for Linux TCP since 2018, in:

 commit b38a51fec1c1 ("tcp: disable RFC6675 loss detection")

In case users ran into unexpected bugs or performance regressions,
that commit allowed Linux system administrators to revert to using
RFC3517/RFC6675 loss recovery by setting net.ipv4.tcp_recovery to 0.

In the seven years since 2018, our team has not heard reports of
anyone reverting Linux TCP to use RFC3517/RFC6675 loss recovery, and
we can't find any record in web searches of such a revert.

RACK-TLP was published as a standards-track RFC, RFC8985, in February
2021.

Several other major TCP implementations have default-enabled RACK-TLP
at this point as well.

RACK-TLP offers several significant performance advantages over
RFC3517/RFC6675 loss recovery, including much better performance in
the common cases of tail drops, lost retransmissions, and reordering.

It is now time to remove the obsolete and unused RFC3517/RFC6675 loss
recovery code. This will allow a substantial simplification of the
Linux TCP code base, and removes 12 bytes of state in every tcp_sock
for 64-bit machines (8 bytes on 32-bit machines).

To arrange the commits in reasonable sizes, this patch series is split
into 3 commits:

(1) Removes the core RFC3517/RFC6675 logic.

(2) Removes the RFC3517/RFC6675 hint state and the first layer of logic that
    updates that state.

(3) Removes the emptied-out tcp_clear_retrans_hints_partial() helper function
    and all of its call sites.

Neal Cardwell (3):
  tcp: remove obsolete and unused RFC3517/RFC6675 loss recovery code
  tcp: remove RFC3517/RFC6675 hint state: lost_skb_hint, lost_cnt_hint
  tcp: remove RFC3517/RFC6675 tcp_clear_retrans_hints_partial()

 Documentation/networking/ip-sysctl.rst        |   8 +-
 .../networking/net_cachelines/tcp_sock.rst    |   2 -
 include/linux/tcp.h                           |   3 -
 include/net/tcp.h                             |   6 -
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_input.c                          | 151 ++----------------
 net/ipv4/tcp_output.c                         |   6 -
 7 files changed, 15 insertions(+), 164 deletions(-)

-- 
2.50.0.rc1.591.g9c95f17f64-goog


