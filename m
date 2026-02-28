Return-Path: <netdev+bounces-262076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E8PrESduomkn3AQAu9opvQ
	(envelope-from <netdev+bounces-262076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:25:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615851C0405
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B635B3027126
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6724466C;
	Sat, 28 Feb 2026 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9LkYrUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACC3A1B5
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772252707; cv=none; b=UJ8Hg0bMgtuSezd8Q/Alti756aHVgRcR1j1cM8W228++iIMuCep801UTETJVSJasmCMAoDj12GUuJZejVKXF9tvWJVg7BrAUWZtqyFwQ0sB/fPMeLr8KK1W3MpFVVuO0UJBdQ099iBZJA3r/Z4+dxKu+AxoUxEOIVXAyw20l/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772252707; c=relaxed/simple;
	bh=UBoeHyrRIBTnTRV7Rcs+GqsEoTLxXho/BZuZ6mGsAs4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F1Uh9NgCGK/SbQDNKvxz/w+mNV259h1jsiYII2dLnDeRx+bzq7u53ShlrJak5ofjr+0P7HR7OfugTPQ6VFJXsJr8Ra7N6xxEiTf43sScaT+1g3P4mre8D5Er3JDdkXvWfdg797Zq5SMul+yZaV1xDWoNZBxT1KNUOJTqH1rEL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9LkYrUn; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb4d191ef1so340919185a.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772252705; x=1772857505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XEyXbyxcCDgFQuoHluFKQb04pq6RLhvqlNkVLiO5Tos=;
        b=s9LkYrUnoADmSQAjgKmSOZWyHZKX6HWepjvv0m+tsxiLNQ5qIVrBq6L6tv4jM8oJ28
         TFTG98fGVuZ14EmWzP0K6K1FA365ICTlmBZj8eCCwPIe7p7AwJ1GP9OWQlRvhusPUljY
         082lhJaAlNNAVDa7NizcmCugQ+T8vbsY0RC45J3XXYGBvPPkhYA+SWADGPL2tgfubpAt
         VYgE6CsTK8othDH1RqWGAiUOvdJgFr0JpvC9O93N9vf4mtnXSdZ6+3r9DbUt6hbJ2UMw
         eFwaSt6ST5RKgwC1LUuTLrXHawCpONKqVd3X9l3Br/CvjhCV0PkttEW7PjyUlcdPEadx
         t+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772252705; x=1772857505;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEyXbyxcCDgFQuoHluFKQb04pq6RLhvqlNkVLiO5Tos=;
        b=VeMASvTWat1HOGQ/KVT62hYZTtjxOIw/w6qwBdSvI+XUN8WCzqLUDPNEeBF0GhZLRq
         8sCY2W/w9PJ9/wAmBaCkYFV/iDHUDDwH54i1ADCCRUWbofebdr6Wrl8SxGiTIe9S9zU+
         J/oLh5C6dt7EqxX0i347kwZrkd/xFNrIygRcrSvcsgpp+jaW6VemVDjLvk+m6NH7H5yF
         dJ9NZjyslSCJtNkT3cuvWphCRXNZ54O1kcuxwC91Liz1qmagbcUwyLJTUCfenzkdnKLD
         PVRXEb08IDQoWF19nHS3mGQYLgBSG36xsPKINCInS6OKMBSf51Va4xHKPYXN8fqQtbPw
         eHGg==
X-Forwarded-Encrypted: i=1; AJvYcCUyuZOE+43eKmQsoCKOA7ugaK3wbLQk3UeN9FR7xoC6IfiX05TwOkP8lEl40QICDgFPownlkWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtjJjXEyS4ANZ6mEeHV8FkMCNbqAtjWaTa6KC/n9aCJGm4aot
	PI3/h4IOeYXxOtwxHNtjuOxyQ4P6IZXpHj6DFqWe9mmpDGLxTLdg/vNboNP3u6RwNT9wJIttWLT
	jz8BTYNWr+Z53BQ==
X-Received: from qkph15.prod.google.com ([2002:a05:620a:284f:b0:8b7:652:aeec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4410:b0:8c5:1fd2:e9ef with SMTP id af79cd13be357-8cbc8e98257mr670630985a.28.1772252705050;
 Fri, 27 Feb 2026 20:25:05 -0800 (PST)
Date: Sat, 28 Feb 2026 04:24:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228042503.3726451-1-edumazet@google.com>
Subject: [PATCH net-next 0/7] rfs: use high-order allocations for hash tables
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262076-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 615851C0405
X-Rspamd-Action: no action

This series adds rps_tag_ptr which encodes both a pointer
and a size of a power-of-two hash table in a single long word.

RFS hash tables (global and per rx-queue) are converted to rps_tag_ptr.

This removes a cache line miss, and allows high-order allocations.

The global hash table can benefit from huge pages.

Eric Dumazet (7):
  net: add rps_tag_ptr type and helpers
  net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
  net-sysfs: add rps_sock_flow_table_mask() helper
  net-sysfs: use rps_tag_ptr and remove metadata from
    rps_sock_flow_table
  net-sysfs: get rid of rps_dev_flow_lock
  net-sysfs: remove rcu field from 'struct rps_dev_flow_table'
  net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table

 Documentation/networking/scaling.rst | 13 ++--
 include/net/hotdata.h                |  5 +-
 include/net/netdev_rx_queue.h        |  3 +-
 include/net/rps-types.h              | 24 +++++++
 include/net/rps.h                    | 34 +++++-----
 net/core/dev.c                       | 51 +++++++++------
 net/core/net-sysfs.c                 | 62 ++++++++----------
 net/core/sysctl_net_core.c           | 95 +++++++++++++++-------------
 8 files changed, 167 insertions(+), 120 deletions(-)
 create mode 100644 include/net/rps-types.h

-- 
2.53.0.473.g4a7958ca14-goog


