Return-Path: <netdev+bounces-259353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKe5AHgZlmkSaAIAu9opvQ
	(envelope-from <netdev+bounces-259353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:56:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB35159428
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77884300461F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F0347BC6;
	Wed, 18 Feb 2026 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS1UWHRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B6238C29
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444593; cv=none; b=PWZALZfzxXb48aGIny+qM2jYUMGmsh/8eEcyVfZT/CRRnD71zE6cPp89O6qgtgD3H1NfZtO5jsAXQyjW8ctZaCgJE13kz2P3mJdNO8aAdA/aeWAoC3Z8EvJegPB0jUxnAzHc70mcXJ1eZhpm1lXtV2H/9FIWy5l5Cq44f05cwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444593; c=relaxed/simple;
	bh=vBUAyAbacjfaRDxMQvWcGcFT+qxiW9zxnAxYnB8luFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=APmSHVcLnzbhiVkqd2ogmf9gupMYl3Fxy9iDeYNHg4klGImNhyN3jm+kA/HWgNo4Z60rXczAI2h0WHAWQktZpHsiT/kRLfS+/hk/q8lwY4QYo/mb+l3s6etKEop5fuARZQgBzl8Exs5DGIP0xjWv36u8+7x4vf+XgvPYuoFzBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS1UWHRN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c713a6a6f8so27506785a.0
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 11:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771444591; x=1772049391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wD8Ttwe5Tegj8OFrv2Q7m/YBq2wmzpAVQJC0WJWjYy8=;
        b=KS1UWHRNb9ZlAhRfC/s9nNN9vTufJ3/PEazrIgBD1cSnx6RlBR0EwANWc8b+ygj5ja
         Bw/jPsabpbezWAaDwFrzqONTAK9KvEFz0oY6GAOHaN5m06Ef6Z1vVEbS+2TYb+/TJ49G
         TWn3JP4GgQdlDD26/5rETLevAB03FL6qNAotcZyT3laarXKVMaXDhsLMjssHmpPM0+bb
         qFjKghutzChmQy7PkwpIO8xC0gHPN/aONYNumtsProyvVGx/MYOjXqEnkTBT3f3ngY+i
         v1zSnWXt8Ka81MvoDSGl1ot3HiC7pJMjCqv7LQj5LLyI6pwFjeQDve+tsvxErOfv6Pdz
         TRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771444591; x=1772049391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD8Ttwe5Tegj8OFrv2Q7m/YBq2wmzpAVQJC0WJWjYy8=;
        b=K9PzrjiMwHeyB229t20AADOn5LiQ1Xi7/5+TOTyiB9MG+G8x9CF3zQZsnPMNLVJ/Ql
         3lsUWzGiOvB8LDOffJ6ZQUtAFB1wy5+38joMfQE9YqqM3iZ90K2wAADLNANJ1dn61UJl
         VK643uGdIyPhtvK3AgNAKGx9vWrKLzX38IkwLVfBxKl01081TX75ks5WIcivqyDcTe8B
         cqDhr1Ho+8g87SRFlxN7buChWf88T0xJUCrwyNtKiuDudM6bsI9hEjrSx8Y5n5IO1ZX7
         mEHQFt4c3rXvBCUVDqOEF/yg6R3FdqVeBmKtpyskwo3m3QDib/2SMZAjPaX5EvHrWgv0
         EhIg==
X-Forwarded-Encrypted: i=1; AJvYcCUtt/TFLn2IPG87jF4kTW8Rwaccak+qw2Lk0NstiYWjLfhTjn3TxpfzcsWtsQDQkRIfXpkiYik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQln4sT+SvGo0bSSPZFqhIgakv2m85TDanS8BP888iGjQi1D9
	WbpkArRUa0PAA12dnMPq7LPvUPq7J6Lv4nBecGzxt241wNKOusm6UNEHgC4WYQ==
X-Gm-Gg: AZuq6aKCzGeIJscdh79DK7iX5oLFlxqkuuO5ufpCqhLBLu/6iFMr15Rkwz+7GbicCb9
	SAwz5OtuJadbI2NIJI1Pdt69fdvfrCCcn2FklH8uz5z/3wJve8CD+7jeQ4b5wHlaCPiEKhTdHEb
	j2UA52OKx6CpGcMc+FQhUyXT/blk5MWhTjMZrmRkeD0a//T7/eObxvXweyGfx8qUwiXVqcFYIJd
	vwEf19Ms6hQqU/ExwpWZOpHtH8AdRzNfwXp3JX5580sMQaPQxdku0rI+3rulOfKykutLU2eW0xf
	flqSQeYNmSa2ofK+LSc4zEyad6kN9PKYWS7wF637r01CtmPGP4WhgYK/ABqKQkvrtbcwnB48AbQ
	AGOSuZ/sTU6JDi+wEnRUtb6yQr5+8n0loQFxzJm8EpS7afp8TBaA9OpKWkUCKB94xQkizN5Ab+r
	5JPPywa0y/uaNUgHcREtzaxb/5LQ8QWMNd
X-Received: by 2002:a53:b118:0:b0:63f:b605:b7f2 with SMTP id 956f58d0204a3-64c557eae43mr2160180d50.10.1771438271298;
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22fb1d22sm6051799d50.17.2026.02.18.10.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net v2 0/3] vsock: add write-once semantics to
 child_ns_mode
Date: Wed, 18 Feb 2026 10:10:35 -0800
Message-Id: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwAlmkC/33NQQqDMBBA0auEWTsliWKjq96juEjjWIdiIklIW
 8S7F3KArj+8f0CiyJRgFAdEKpw4eBiFbgS41fonIc8wCtBS91KrK5YU3At9wnfkTBi8IzSm7eb
 edCSthkbAHmnhT1Xv4CnD1AhYOeUQv/VUVE1/0aJQoVXLo5WLNoMdbhtle3Fhg+k8zx//dlzIu
 gAAAA==
X-Change-ID: 20260217-vsock-ns-write-once-8834d684e0a2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 1FB35159428
X-Rspamd-Action: no action

Two administrator processes may race when setting child_ns_mode: one
sets it to "local" and creates a namespace, but another changes it to
"global" in between. The first process ends up with a namespace in the
wrong mode. Make child_ns_mode write-once so that a namespace manager
can set it once, check the value, and be guaranteed it won't change
before creating its namespaces. Writing a different value after the
first write returns -EBUSY.

One patch for the implementation, one for docs, and one for tests.

---
Changes in v2:
- break docs, tests, and implementation into separate patches
- clarify commit message
- only use child_ns_mode, do not add additional child_ns_mode_locked
  variable
- add documentation to Documentation/
- Link to v1: https://lore.kernel.org/r/20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com

---
Bobby Eshleman (3):
      selftests/vsock: change tests to respect write-once child ns mode
      vsock: lock down child_ns_mode as write-once
      vsock: document write-once behavior of the child_ns_mode sysctl

 Documentation/admin-guide/sysctl/net.rst | 10 ++++++---
 include/net/af_vsock.h                   | 20 +++++++++++++++---
 include/net/netns/vsock.h                |  9 +++++++-
 net/vmw_vsock/af_vsock.c                 | 15 +++++++++-----
 tools/testing/selftests/vsock/vmtest.sh  | 35 +++++++++++++++-----------------
 5 files changed, 58 insertions(+), 31 deletions(-)
---
base-commit: ccd8e87748ad083047d6c8544c5809b7f96cc8df
change-id: 20260217-vsock-ns-write-once-8834d684e0a2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


