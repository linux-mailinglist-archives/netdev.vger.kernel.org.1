Return-Path: <netdev+bounces-260245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAZNE4nXnGn+LgQAu9opvQ
	(envelope-from <netdev+bounces-260245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:41:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE7117E7C3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA108315EBD6
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736D37BE8D;
	Mon, 23 Feb 2026 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gERp3q7x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D337B40E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886336; cv=none; b=LEgeuNImI6RFqaXcPI+ZqOhLk2njWoUxm3jpwbGeIMWw8CyUfyB1nNgraINdYEE+Rp9pePfuujW3w0K1poB2zL7O0UKQVtv2+VfpdP1jb0t/tn5ma9BHmdyCAsUf0sp5QExfmbRbxwMfJ+rTCck0rUQ0v6oSuOxLZYMRVgq8rJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886336; c=relaxed/simple;
	bh=/bIC/WtvmzO2UMatiyKUHoqyh6+HwZ1czcMSAuZhOrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mqy6jYersEt7Docyyl2c+706s6/YV0kmB5xDA1BoblbsU/gENqJN/olPQSYgUEa8pYiBApFMmHcryrgAvwFRu37CyM6tEduktTYmimFWgu8wb1cGaUkhjjwY5BP7LWkJjFpKkrQL6fRn5u/PYLFKptRxI2UatabqKry5Y3Ro9ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gERp3q7x; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad2a2851cso4038531d50.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886334; x=1772491134; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9UtgbHB88uVfe270ruZfCUS90+GzEIoaTA2r5lSx94=;
        b=gERp3q7xOYJbbS9V0A7MtyaZ19GS8AOYoDFRpfMu6yIdJlI9OwlsxpmRTmItkxifF7
         sXKQ+nGlpkgZwNGVQ6oC8kQcWQ8jWJYaQq0fk8bOLBVYtYuyEYxdA7KemEcNsLWjk8B6
         gJHo1Ef/zKoHnd6Z35YIpFV9SMrwaK3rVxETxp1g6y6dTlU0vbg3yWX56snqgZ6r7lA4
         DX73BbDlw3BIVlCuRZrMr+drKKYMYRE7gTBxo5+JcZWvY9MPaEjmsRoekRVnO3t3a0Up
         DM1XPmnHRnVwqIN/VtZ77/qVXm/ZhNy0bgHmFhWwV09UXVekxfc0No5Hm8I4pVMdGLAY
         hdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886334; x=1772491134;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9UtgbHB88uVfe270ruZfCUS90+GzEIoaTA2r5lSx94=;
        b=RkRERI0Hic4Y9NbsmwXc68qRPNLk+XL55DfFEQUPXQixg9YCai7tQ/PvXrkcmUC/Nj
         NJGFudB2NF74ntzVKCKuFeh1LAUklMmee4FyUrKbjjo3afS7Xym8ejwjWO/pXcqAfaBQ
         qv0kbMQfjhOjbVfyA3LhWtVJq7jhaa2meZW5rkV/36zpAFaJ9LeeGHiiBHlPaJHeg1h2
         QWwBzlDqySwm3rR28EevoGsPRv49Dn/v4QAzmCSMn89J0DRsWomiB7+MAU/oXzoO3nKZ
         rdHThIVmaHjuzYQnZ/lDrY9ssmoByqUojBZJNjVajQW3E5bDW/HDXJGhsNR4/zTgNnkB
         O8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWNofH4LsKSpSWONUu/WXZCk4uqXGhB/61hk8wnTsfTU1ZK2QsypUDgct6DPIskYZt8L9fKZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTuucVPUqXG4vWkTWHUxbX5WfSb63eTRjc75NpTDNd55zbt1Ej
	5h4d2EfptWtbZdg67+mvPXvkaU1Rwj7+rVslVlZhlNZ8NmqU0mIfRpsz
X-Gm-Gg: ATEYQzzCBgBIxU9hB3D/TyTkUE+EGS15pQzfNxTeDKxj5DSdTXEazuBlW4KQS+Tfx/M
	8cUYeT/xSNs5vGpIO2r0kM4ADWV+6v/EhaXrmF9t99+LfC1ELm5Ik/SoFEI4gmNctQyFN75u3bk
	MVyZ+X93PgA215IoYJOAdRlkL7ZB1hzH9gKjrqEOIPz0vRGtAB4iB2HdcF00G4E7JGbJAaDamTP
	OSnrxeMz0u07otiK9L2yqXsDccH6UzG//TMZAd/0b+98ZnB/LF7jw2DhP/S2aSZx6JFPYbJJt7v
	WamJeuejGuKHR5JcDYhpe6M94HRSJH01RGfm7vBpzznogmjujPUzS8Kjy9PAnxhz9+L1aN/tgxQ
	AfG+R0F2MRSYhmPGm124/2OcNfKZq4mVr44A1RaKnc8p9MSqnm8Zzr5+FRK+o4uGpSrpF48EidS
	I5Kr7bWz5SzcYcMYZpS9KKFg==
X-Received: by 2002:a05:690e:408:b0:64a:db34:8509 with SMTP id 956f58d0204a3-64c78f6f039mr6063230d50.66.1771886332926;
        Mon, 23 Feb 2026 14:38:52 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a39bdecsm3726462d50.22.2026.02.23.14.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net v3 0/3] vsock: add write-once semantics to
 child_ns_mode
Date: Mon, 23 Feb 2026 14:38:31 -0800
Message-Id: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjWnGkC/33NTQ7CIBBA4auQWXcM0B+hK+9hXCCdWmIEAwQ1T
 e9uwqoL4/ol31shUXSUYGQrRCouueBhZG3DwC7G3wjdBCMDyeXApThiScHe0Sd8RZcJg7eESrX
 dNKiOuJHQMHhGmt27qmfwlOHSMFhcyiF+6qmImv6iRaBAI+Zry2eptNGnB2VzsOFRuSL3hPpNS
 OQoNHW251PPtdkR27Z9AQT30fz9AAAA
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
 kuniyu@google.com, ncardwell@google.com, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260245-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmtest.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 9EE7117E7C3
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
Changes in v3:
- Simplify code be reverting approach of using only a single variable to
  represent both lock state and child_ns_mode state. Instead, use
  child_ns_mode and child_ns_mode_locked.
- Update documentation to clarify the value-dependent behavior of
  child_ns_mode writes (that is, same value is ok, different value gets
  -EBUSY).
- fixed some line length > 80 checkpatch issues in vmtest.sh
- Link to v2: https://lore.kernel.org/r/20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com

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

 Documentation/admin-guide/sysctl/net.rst |  3 +++
 include/net/af_vsock.h                   | 13 ++++++++--
 include/net/netns/vsock.h                |  3 +++
 net/vmw_vsock/af_vsock.c                 | 15 ++++++++----
 tools/testing/selftests/vsock/vmtest.sh  | 41 ++++++++++++++++----------------
 5 files changed, 48 insertions(+), 27 deletions(-)
---
base-commit: ccd8e87748ad083047d6c8544c5809b7f96cc8df
change-id: 20260217-vsock-ns-write-once-8834d684e0a2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


