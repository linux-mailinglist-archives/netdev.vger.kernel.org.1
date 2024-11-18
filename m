Return-Path: <netdev+bounces-145801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080809D0F66
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D3D1F226E4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384B194A63;
	Mon, 18 Nov 2024 11:15:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE21EA73;
	Mon, 18 Nov 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928530; cv=none; b=IwkxLUxPNfyYnlJYIX8wC9jIt+wmHbMl6zTVg3Sc6YuLEYBpbYkaM6YrHW7Zu7oP1IvKXh1AhGF16xy2czwX5OeirN67Y0gdlZiw9V9mlECDmBL00eNDdU/wCj6eu3PmBKnO5FbQRiIVcqK1qBK8A6SZeKIqODn0VnFhIj10Wi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928530; c=relaxed/simple;
	bh=Fm7X1rCptseYOQiiHdn+GV/CEfNvRsjcmulihtwd6HY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=svtcLmE7MdTdqiBq1N3P8Sp24MWT1dF9BjWg81ijrKFMTtlHPtS+pkMHZ+Us6v2mMtvmCloiT10MClofxqEPNX9oUSY002ewg+GyGFB+TkIIYLseyzk5QUQDCexcZbliZNurrptL5T3fg3fq3sFgdTSVXvAN5y3Ez8kF7XWmX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso1401449a12.3;
        Mon, 18 Nov 2024 03:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928526; x=1732533326;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wc8nCj4TtWo7FA9cSZQ0Nu/OW7rY/eT8fw4KumJRGo4=;
        b=RTYnz8ReIE4E5C6UhHepGwHvlpHqF59MTQ4I1TiRB9N4WydCRiLWm48kjEBw8Oc6jT
         StKnDXD88xvXcb/XGet6q7cAxolYFupBKMIzYy9N1UEqxvhESnxnOr46qMPLAi2EygoE
         5jrevyXT72mRnls8ijuhC7E1az9HZyjtWO/u1bL4Z6hFeTp9fBgzH4b0SLHE7cllBbWl
         A5Z5joEUCXQMJ3duGUYe5vQYvCGMR9VROgjWg+f/GbrcKX3lzos7p70Bez/ZU8Jy28vB
         XBFHUa6gjM98cSn2Yi3I5kki6DuKucDG2duDvJlEJRL21UTSt1E142SYpmeHH1jJ6WYg
         Ah0g==
X-Forwarded-Encrypted: i=1; AJvYcCUkssM7TRfjgQz00ziTIVDQ/pp6BBKyo3g8URhxTcPq6w/Dlpwt/Ho1NP7pPvl/Lmvl1+F3K7yTpoial8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIrCaxVnDFmG8oVpgRsbolCl917BWmpC+4JIUViyvtw8jdndm
	5+7V8/SlEaPS72l4+ILGL14UztrMXudyYws3mr9FYYJI/0/sXDjxTGyuFQ==
X-Google-Smtp-Source: AGHT+IH6MC6KGNivA5kwCnNlP05Ibmy/yfYeZZQl/Oq42vvjhyBR3dzRoLPk+kA0NewKoZetw+kNmA==
X-Received: by 2002:a17:907:31c2:b0:a9e:c4d2:fff0 with SMTP id a640c23a62f3a-aa483527166mr844880166b.45.1731928526328;
        Mon, 18 Nov 2024 03:15:26 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df779afsm526330666b.85.2024.11.18.03.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:15:25 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net 0/2] netpoll: Use RCU primitives for npinfo pointer
 access
Date: Mon, 18 Nov 2024 03:15:16 -0800
Message-Id: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQhO2cC/x3MawpAQBQG0K3cvt+m3MkjsxVJHhe3NDSDlOxdO
 Qs4D6IElQhHD4JcGnXzcMQJYVg6P4vREY5gU5sxc268HPu2rm0YTiM926rImfuSkRD2IJPe/1b
 Dy4HmfT/WCmIAYgAAAA==
X-Change-ID: 20241115-netpoll_rcu-eb1296511b71
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, paulmck@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=leitao@debian.org;
 h=from:subject:message-id; bh=Fm7X1rCptseYOQiiHdn+GV/CEfNvRsjcmulihtwd6HY=;
 b=owEBbAKT/ZANAwAIATWjk5/8eHdtAcsmYgBnOyHMErtDbbsgRv7aBSysHxC9Yoro18RyV4IKP
 I3b2qvmEv2JAjIEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzshzAAKCRA1o5Of/Hh3
 bdc6D/dZwS2S3pxXkN5wfeusbymKpKl6epvnYa/pl3WJRSbh5e4kqNE+NG2HxoUD3QO29EqbCSk
 e0zVZUCj7mEYJg5OnwcEtByPsp+xYobSXomdM9dOy3CtVXfcnw58ztjukGItv4CtyJATWqNvGV7
 5BeTwI5anP65Rm84SD05QbK+7hw8SM8GHG66659uASymBzLX0MSMQUpy4kyTX0L/G1J2xdCm5YD
 VqhKefrmZjqayoAmBUoSQN1DIMr8wrcODxGADdUB9a3W7qmEmpf99Cgux89DB6KvUa3p1pASsC6
 6lpISEzC2krM3hNr/ddPOhJIgg+3/bfoST/F1yUE5eXQx078sPa32MN/5xmCuNMh5ks/aHy3KI5
 LVAS5FL6FaxGUC5yj/vCQ1P9DFy/InpkzZ8OyWcgAGW+325af713+h5unzE8iv2dzFjes1s8orR
 FUb2HZKBf3Nk2ZZszuAAuZ8N6xNMLodsaERx1ZEQ4X/tGkx5jVSa2S1tw3GSyoIVAmFKKr+fKN+
 /NZPgi50k4+iVGUmnHMmqyyw/BSFirnEhY6eZJskZe7SGT2IvSpwYGUQskIhVB6HsoMJSuG20Dz
 U5JPufRYbBCKpXMdudaOfnNYmkQr4zDMQHDNcdXVmUT29DNsoSp7MyrIiFWbD8uiBTCIYGQd8lX
 X8VjDgf/o9oFj
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The net_device->npinfo pointer is marked with __rcu, indicating it requires
proper RCU access primitives:

  struct net_device {
	...
	struct netpoll_info __rcu *npinfo;
	...
  };

Direct access to this pointer can lead to issues such as:
- Compiler incorrectly caching/reusing stale pointer values
- Missing memory ordering guarantees
- Non-atomic pointer loads

Replace direct NULL checks of npinfo with rcu_access_pointer(),
which provides the necessary memory ordering guarantees without the
overhead of a full RCU dereference, since we only need to verify
if the pointer is NULL.

In both cases, the RCU read lock is not held when the function is being
called. I checked that by using lockdep_assert_in_rcu_read_lock(), and
seeing the warning on both cases.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      netpoll: Use rcu_access_pointer() in __netpoll_setup
      netpoll: Use rcu_access_pointer() in netpoll_poll_lock

 include/linux/netpoll.h | 2 +-
 net/core/netpoll.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 8ffade77b6337a8767fae9820d57d7a6413dd1a1
change-id: 20241115-netpoll_rcu-eb1296511b71

Best regards,
-- 
Breno Leitao <leitao@debian.org>


