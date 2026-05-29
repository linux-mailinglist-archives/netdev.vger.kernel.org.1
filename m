Return-Path: <netdev+bounces-293117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DstFZSRGWrVxggAu9opvQ
	(envelope-from <netdev+bounces-293117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:16:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF4F602C15
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83CF53002D03
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6E32B135;
	Fri, 29 May 2026 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZujMBiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FC1E633C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060531; cv=none; b=SuZQnYMgsxXFaJSR7YZWIi8lQwesS1CxDNLadaeem6f4GkATNca2AZDsIaITJMtCnuoKKLmc8DrDbRtRMKl6FA6yb65JcbYgaaCp0NNJuk3puIaNMCoyKmfd8V7wjIHT3f2SMO7eU3E9D9wuDYcZAFWSvbvk86d3k+tVJBIWKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060531; c=relaxed/simple;
	bh=WMDFjbQ1IsgxxBmTUVMs5PZRTemd28Shd5aoPXAI/tg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y9osABexmAu5w+8DpWeWiDfk5/lBg9boygbbfCaejHTQOJlyv2klycSroQQZ7pM8JuNsnlLnquRUw28l2GIeWjDR/PZ/uD3BTDT3MTaFqKJPfD+4Bq8FM7gd/2tL17r17Y1QyTWCVHVFo9rpj95aj+E9szplHBmdQpouOMNs/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZujMBiT; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e62b6163c8so2070827a34.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780060529; x=1780665329; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8U27PrRBYOTBggCy2kOuybL8Sqy0L0L2agZLGzQ4W+8=;
        b=eZujMBiTZeALWjDcVzqJJahwU3o9YhoBh3aOYfKJeB0Mvp4URKTYsZYWJtbDMiFY+O
         2jJuMPExHTIlZetb2p6Ko3n9eMNp14SvEaNoYbnnNAAFHYRHYWXCeOLyN4P9WBrWDDs6
         NPffLTUyj+D8Pp7O4r0iBMobLCeKFFsQ3E0eXW9kTRw9fSBWJF9HoChFxRMdB0cuvxwi
         /Z13uCp5NjWMYZSY6gisQ5s30yr/igZpuVftolpJC2pn12/2F6VafNbSBIIBDtyxAA6Z
         na8AOBZ2IpbIzURK3C301o4D6VLjXwXma/4PzNIzM8JAqy21jfzI6PaTpaviBnka9vD2
         p3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780060529; x=1780665329;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U27PrRBYOTBggCy2kOuybL8Sqy0L0L2agZLGzQ4W+8=;
        b=n2uO+0ewTgYnCLLiuvj7bExUVucESMm0N6adO5F4de0CDBPqTOmp/D7eLLeOX0pL6W
         JMwvWNFl3mSOGNRnZU65/iepVdWUekL5ueCf/sRUIxbZ5dsKqr2do0GXKxgsVI72S2iO
         3olZtMblG1Ax9c9n//gFu83zH/+9vJQvd9853OwkV8I2h2VEY5aEC1/iBjwOAPZoPn0r
         n0JMgABNg6u6aJT6EdSkqs+zgNwSAbAs7wyrz8rZcOjWniLmfDH1GnjHdI3LwmRLAd/H
         lPsK3NDfBYpuEFQd47gn+57KdvjsEvd5FGG2PD5zc0Rq1tAQUQzOTk7CqaWw/8D1QyK9
         2xyg==
X-Gm-Message-State: AOJu0YwMebZp0jx6O5JvNAHm8GOYn2pIuPfLOK+gslSjVzBoRZRrst5i
	Vne0OWU4G4uD4QVl7BUa96D5WSR68L+ApiP0R3CRzk5nn1LJ2uyu0Fp/
X-Gm-Gg: Acq92OFg84S97K1V0FkRIS5B1lhn284+lbx3wf7W/WdZCLpDCCVI1pADi/VBxCcqiEn
	Kd77KpKN9uV+l50zplSbXDBkKF80zNIlgP8f/lP0zexug1TOv/fbzmq4uluOkJDH2Pxc5vlFfBz
	JmS8hJrFXOkjmyX0KIs54IpQTpSxiLU3dQP4wtq3UCyBuAYZrscDbJhxsh8MmACLfd9XmBDHRi2
	kBAxUow2I9Q1+x5UXBYh2T/LrtGrRfNgcT8BM/OuOD7a3pZW+9ETxiudOTrEe75KWp8Uh+IEhmC
	PRmv+jTM6oEVPZjuEktaSd77aNhlVDk11OyOOVBF5EakVA8vFjO5v0p/dX5osbLymC/rYazvMoE
	IU0jwd7m2lIkKANx8KXbRsmD7XWEOrOQxNkIEvZDgk9LQUDKXt0BinklfjJ8ajTZpV37ItAOATj
	54SUNW8VHzl8DsESulemi621EdItVaZ6Y=
X-Received: by 2002:a05:6830:3748:b0:7dd:5a21:2246 with SMTP id 46e09a7af769-7e694e5c7b3mr1858386a34.25.1780060529098;
        Fri, 29 May 2026 06:15:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d69b20sm1407562a34.22.2026.05.29.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:15:28 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net v2 0/2] netdevsim: psp: fix issues with stats
 collection
Date: Fri, 29 May 2026 06:15:26 -0700
Message-Id: <20260529-fix-psp-stats-v2-0-3a194eacf18e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+RGWoC/12NywrCMBBFf6XM2pEktZG68j+ki5pM2wH7IBOKU
 vLvhuDK5X2de4BQYBK4VQcE2ll4XbIwpwrc1C8jIfuswShjVaMNDvzGTTaU2EdBaq2zXtnWKw1
 5swXKhcJ7wEIRumxOLHENn/Kx6xL9cPUfbteo0Plnra+XwTRmuI9zz6+zW2foUkpfnfWToa8AA
 AA=
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4CF4F602C15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It has come to my attention via a sashiko review of my net-next series
for aes-gcm in netdevsim [1] that there were preexisting issues with
netdevsim's implementation of psp statistics.

API usage issues:
1. not calling u64_stats_init() on the u64_stats_sync object during
   init
2. not serializing usage of the writer side API during stats update

Logical Bugs:
1. We were incrementing rx stats on the sending devices stats
   counters.

Fix the first set of issues by removing the u64_stats_t api entirely,
and keep track of stats with atomics. Fix the second issue by charging
events to the right netdevsim object.

[1]: https://sashiko.dev/#/patchset/20260508-nsim-psp-crypto-v1-0-4b50ed09b794%40gmail.com

  TAP version 13
  1..28
  ok 1 psp.data_basic_send_v0_ip4
  ok 2 psp.data_basic_send_v0_ip6
  ok 3 psp.data_basic_send_v1_ip4
  ok 4 psp.data_basic_send_v1_ip6
  ok 5 psp.data_basic_send_v2_ip4
  ok 6 psp.data_basic_send_v2_ip6
  ok 7 psp.data_basic_send_v3_ip4
  ok 8 psp.data_basic_send_v3_ip6
  ok 9 psp.data_mss_adjust_ip4
  ok 10 psp.data_mss_adjust_ip6
  ok 11 psp.dev_list_devices
  ok 12 psp.dev_get_device
  ok 13 psp.dev_get_device_bad
  ok 14 psp.dev_rotate
  ok 15 psp.dev_rotate_spi
  ok 16 psp.assoc_basic
  ok 17 psp.assoc_bad_dev
  ok 18 psp.assoc_sk_only_conn
  ok 19 psp.assoc_sk_only_mismatch
  ok 20 psp.assoc_sk_only_mismatch_tx
  ok 21 psp.assoc_sk_only_unconn
  ok 22 psp.assoc_version_mismatch
  ok 23 psp.assoc_twice
  ok 24 psp.data_send_bad_key
  ok 25 psp.data_send_disconnect
  ok 26 psp.data_stale_key
  ok 27 psp.removal_device_rx
  ok 28 psp.removal_device_bi
  # Totals: pass:28 fail:0 xfail:0 xpass:0 skip:0 error:0

Dump stats on both devs tx on one should match rx on other:
local dev:
id=5 ifindex=2 stats={'dev-id': 5, 'key-rotations': 0,
'stale-events': 0, 'rx-packets': 1226, 'rx-bytes': 39244,
'rx-auth-fail': 0, 'rx-error': 0, 'rx-bad': 0, 'tx-packets': 1931,
'tx-bytes': 2478908, 'tx-error': 0}

remote dev:
id=3 ifindex=2 stats={'dev-id': 3, 'key-rotations': 0, 'stale-events':
0, 'rx-packets': 1931, 'rx-bytes': 2478908, 'rx-auth-fail': 0,
'rx-error': 0, 'rx-bad': 0, 'tx-packets': 1226, 'tx-bytes': 39244,
'tx-error': 0}

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Changes in v2:
- get rid of u64_stats_t and use atomics instead
- Link to v1: https://lore.kernel.org/r/20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com

---
Daniel Zahka (2):
      netdevsim: psp: update rx stats on the peer netdevsim
      netdevsim: psp: use atomic64 for psp stats counters

 drivers/net/netdevsim/netdevsim.h | 10 ++++------
 drivers/net/netdevsim/psp.c       | 27 +++++++++++----------------
 2 files changed, 15 insertions(+), 22 deletions(-)
---
base-commit: 422b5233b607476ac7176bfa2a101b9a103d7653
change-id: 20260512-fix-psp-stats-e96c6d069d01

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


