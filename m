Return-Path: <netdev+bounces-256733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPj8GSNpg2kbmgMAu9opvQ
	(envelope-from <netdev+bounces-256733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:43:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A52E9379
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E626730F6222
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4E423165;
	Wed,  4 Feb 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgH1Sw+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12E421EE4
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218409; cv=none; b=dQk7k4cPdjXd440mTPIRFFU4790qc/YdiVTff+XmPcUfow/tnzKJzGQ62Xn32Ndow2dnsmf1k3JdNmVLPgRt7O1qqTpK1Cyg6N4vZzk0a9rrPylsM3rItVOB4kG8ZHQ1WXCKJtZKVb7ufbbGM+S8ME+DnpJvMzDoTuBnKGvPvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218409; c=relaxed/simple;
	bh=KwwAKDopHJRILboAztm5XFNPGYVwREHQpS8M1jc01Js=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dRfkFfddlMUeMhbJQU9vAg806uCG1lS/6NZ1p7AZZPTdMekN2mIQKrmRotEMaIfdQB7kkTbwAlh2VIMfI51CjV2jT02j74OSgyLa29aBoPZW7GjWiqGUQRH/uP/7EGiXH7gDt2BhXCdKiDb0yvcdgTWCISfbqzPqK/hFiyAr5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgH1Sw+Z; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7945838691aso14367187b3.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218408; x=1770823208; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1I7Mk9Hd5K7WwRUz0geICz1s9Dm05KM3tUh5w1KEMTc=;
        b=dgH1Sw+ZIWUdnbONrvvmk1pCcMofW/HNjGrLHxko3KIqjz8MNWs0j7X9tsQw8+rD2g
         hwKEa/y1fzqLfiQ2GBkFvkWJHprQbKY8TPoMagHCKSytZfQK0oCvwmWj3xF5MCsnnkhC
         XT9C6ojorOUZy5NeOcLc8G6tFl90sW6SNCN96m0c2MXUJUyCLWvl8UniBShkjI/4mgt6
         a2ChzLHZ1xIRHxh/RJcPu5BAKlqBCj5291U+kVVBtYnAFJrlfPfpMEF2aHc0d3QyxdnR
         rMHn0J74oZLeVWKYXY4/eWKOH5erDLp14wUMiPQK6YJNNF6TTPvQ5eBAalvqfBcXQkHv
         rVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218408; x=1770823208;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I7Mk9Hd5K7WwRUz0geICz1s9Dm05KM3tUh5w1KEMTc=;
        b=gY4QJMra8CVOdAL8ulEpuIyUtLw0zKPXlZRVj1DQ97bbsLNeOGpWM+7P7D217u5NZU
         66uLf00gejtl+rk6YTSZTqAiElU7cbjqFVJE0jeJ0vvOvfCCKvE/USDsmNriyCBs4L5I
         +uCJmIOggz+8AaZqRpYZJ5nwG68obuIGhmLRNrWO7i+9FWjmiV6M6lC64YP/OP7VjxQn
         CMyIsI5hfU4fBo2YRrr3uc+mo1SWLnJkLwO+Sq+/S+tfLREOdru/3Afp5MT5VSvgAShB
         lHFAh0JGqyPt4zK60foTsEn7C+pzeisQnVnkdgQ368aLDXUmZL7yBj72/4BVrD0jPTSq
         Xhtw==
X-Gm-Message-State: AOJu0YxBCywHHNNE+0H/1xvCZDNhbgstolDrvfAVzVoDfbbBb8kcUY0E
	xugnf5IXOU3e9pjQbaYR0tK/aLMDf576wjz4/4Flbq9vnBzeNc0XvW1R
X-Gm-Gg: AZuq6aKMKi4/kbNHFiC2R6ElQFckY4bH0LEBN8g6w1fLxBGPOQBDHNUU2hFoJtP4151
	BmxRorCb63lnZt/d3IxDppuE+5JGXbN+UL8HKgFboRrZTa1DGSZFuPB1MZdf9t7FmqFNp3yG+y/
	hbJfAA/mR+ogdJkc1DV8kV0p96nW/IZq2WIS5fNrACFvYy59NIRyfcfsD6aqZYnFAKySY79HfWg
	rzIgzVmm0ei9XhrJ8S3arpExT9L+Dv/2tMXyRTvo+652/yywV8ze9sqoaiYfc0l868DwpmbVyAN
	zSGb5sRR2ykssswoaoi6+Md0YklcadGMOveeTFRsrwgNzntqisWvjknt7s0fs0UK/4GGJe+UOIp
	pJBqGG8H1CPcWOpJP+b0GFOkYD/wS8r93xALZ2I6qnqpTmwmgrBvIAZO4vbMIAT8Y8bP39UgsWM
	e42w7c1uRoefBdfHq4Bw0=
X-Received: by 2002:a05:690c:7207:b0:795:905:c00e with SMTP id 00721157ae682-7950905c893mr14361537b3.14.1770218408089;
        Wed, 04 Feb 2026 07:20:08 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefd00b5sm23148567b3.43.2026.02.04.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:07 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next 0/9] psp: support rekeying psp protected tcp
 connections
Date: Wed, 04 Feb 2026 07:20:04 -0800
Message-Id: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKRjg2kC/x2MQQqAIBAAvyJ7TjBLib4SHWJbay8mKiGIf0+6D
 AwMUyFRZEqwigqRXk78+C7jIADvw18k+ewOWmmrOmRIQU64kHbWoMEZehkiOS7/ZQNPWXoqGfb
 WPg9D4ZBfAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256733-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2A52E9379
X-Rspamd-Action: no action

The PSP architecture spec specifies the need for rekeying connections
in the event of a device key rotation. After a device key rotation has
occurred, a new rx derived key needs to be generated and sent out to
the other end of the connection sometime before the next device key
rotation occurs.

Because PSP connections involve two different keys at each endpoint,
one for decrypting ingress traffic, and one for encrypting egress
traffic, there are two types of rekeying events that need to be
supported. From the perspective of one endpoint of the connection:

1. rx rekey: we need to allocate a new spi and decryption key on the
current device key to provide to our peer.

2. tx rekey: our peer has provided us with a new spi + encryption key
pair which we should use for encrypting traffic immediately.

In the case of rx rekeying, there is a period where it makes sense to
accept packets authenticated from either the previous or current
spi. To deal with that we allow a socket to keep a chain of a max of
two psp assocs at any time. If authentication state does not match the
most recent assoc, the previous one will be tried.

In the case of tx rekeying, as soon as we install the new tx key, we
have no use for the previous one, and it can be disposed of
immediately. The only catch, is in the case where hw uses a key handle
in tx descriptor state (as opposed to inlining the key directly). If
this is the case, psp core needs to be sure that any of these
unaccounted for references to key state are gone by the time it tries
to sync a deleted key to hw.

To deal with this race condition, the series includes a driver api for
implementing deferred tx key deletion, where the driver can signal
back to the core when it is safe to dispose of old tx keys.

Lastly, some test cases for rekeying are included that go through key
rotations and rekeying.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (9):
      psp: support rx rekey operation
      psp: move code from psp_sock_assoc_set_tx() into helper functions
      psp: support tx rekey operation
      psp: refactor psp_dev_tx_key_del()
      psp: add driver api for deferred tx key deletion
      psp: add core tracked stats for deferred key deletion
      mlx5: psp: implement deferred tx key deletion
      selftests: drv-net: psp: lift psp connection setup out of _data_basic_send() testcase
      selftests: drv-net: psp: add tests for rekeying connections

 Documentation/netlink/specs/psp.yaml               |  14 ++
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c | 101 +++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.h |   7 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   1 +
 include/net/psp/functions.h                        |   6 +
 include/net/psp/types.h                            |  39 ++++
 include/uapi/linux/psp.h                           |   2 +
 net/psp/psp.h                                      |   7 +-
 net/psp/psp_main.c                                 | 101 +++++++++-
 net/psp/psp_nl.c                                   |   9 +-
 net/psp/psp_sock.c                                 | 213 +++++++++++++++------
 tools/testing/selftests/drivers/net/psp.py         | 133 ++++++++++++-
 .../testing/selftests/drivers/net/psp_responder.c  | 131 +++++++++++++
 14 files changed, 685 insertions(+), 80 deletions(-)
---
base-commit: 9a9424c756feee9ee6e717405a9d6fa7bacdef08
change-id: 20260202-psp-3c8e2f65c5c4

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


