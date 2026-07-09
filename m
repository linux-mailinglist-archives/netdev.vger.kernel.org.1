Return-Path: <netdev+bounces-306370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O7bDOX4KUGo6sQIAu9opvQ
	(envelope-from <netdev+bounces-306370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:54:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C54735943
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:54:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=UNPLxzRf;
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306370-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306370-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FE0303E9D1
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5B03B6C11;
	Thu,  9 Jul 2026 20:54:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35593E0223
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:54:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630459; cv=none; b=hpty8QJPyEe4X9SDN9J0K/fy0qXn5Slan3vRc9HS2/r8gNv1PXpFdM4B4i5enJ4l4/u/5nz4PgUdRKo5oTynWyzIJ0P5Kz5jacN0B8IJOqB7v83jjFZ3lkMZT9rie+yU1JIHbT6a2T6Bb9GPzOy/XHdDW0TFgcLoDCpHU5quC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630459; c=relaxed/simple;
	bh=DN45JNwbLOwiHnKDTjLPOUjmsCP4IR6MvnRX+EnLOJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E73MO4KvfdZLuceyRtFckjgJmd+zBZrD2CKw9hGp6AJoB7jc8zzTbdthDqzc7bwPQzZxOsjV0FguHcE+VoSXFQe0KxPmHMVuYViZTy8X57xNo5CkuSgx91fCfXhkBekr3V0dJk4ro4L6LfEWi2wxnIFWPAsJ8cMbmsuEzhvaLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UNPLxzRf; arc=none smtp.client-ip=209.85.160.41
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-448df16ab34so87166fac.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783630456; x=1784235256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0inhRMc8bQBgsG69KIZ8p4jcIVm+QaxkOqEz8+RjbL8=;
        b=UNPLxzRfq1W1XnRCuMiZKl0wt/04uSBVexCGWoFfygbqhetAkKoCMhUVcAgtOkJO0c
         by9myERlls2/S/g90lANmdhjXu/mFFB97/Rr/cL/5XnHCv+PooIDEZGMjFfg/H/lT3zN
         HBhaqRP5cfV6cWT2/mhQcjzq2ADeIA4blh8+Z9viXL0PEl3Njho+5O7Wlq4k56s0f8Yu
         dScPhV26DEz30IMJwNuSjwSLR10blzNzuYBDWU7RIe3JQkVlOtTbobjU8ndYL25+lq98
         XasMSNmR1Vj5htjNps6FSZi8qhQ6LrneMUi1IIhbPWqprNZ9eg9iVk/nOEFhraLXNkSg
         VEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630456; x=1784235256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0inhRMc8bQBgsG69KIZ8p4jcIVm+QaxkOqEz8+RjbL8=;
        b=oyyp8R1DhO2BbjgmpAiN0Trn3lLEIfuDwv9+zQ6uvlY2TB/pS/KHgZhe6XHRdYrhGC
         HYvQ74U8K5bHCHKVFBoZTT0/L2j/9cE7WZnO2q9jvyFa0t+/r9ntaOZli/B3e8lmMB+I
         93Z+OIAN8RfjIN0Xtwg02jr3Z3roX5YY8KesRaDbxaagTiYeQ/LcmgRPJlB2DhMvpfdb
         BDcDJ0nSR3WOXNHVNm838E5/AzzA1i4QnbOn5iI47t9VBzZUomgCJvvtKqHZGrAe5c5J
         Xb/9pkPAsQowJeFEokpwFk5I/5qmsDrmlV5p7R+Ebs5jmiYRaN6dkG7PGrGnm4UZ0g4h
         gL+Q==
X-Gm-Message-State: AOJu0Yzs5ZRxDaevHHx5U52HM2o6g8QlsUJVSQ3WARMdkfk91RtERHV0
	SAt0Zo92ycA4BA76CFyJzxNO7BRb5H0mCpd95eLNR/knaGi6VBwRr3vkNDY6XYVdr0M91/eoWrN
	EV5yNDOW4M6ePFGOhs4wp9ufovvTpFi95OJzVAA6b5DLqStlrjD0z7pQ/2w6oStSvggJ4QF26TF
	W4bUmfeA4EftvYE8M5wwZmRczmSRYffzP6ltIHTuuLSXaQ+7w=
X-Gm-Gg: AfdE7cnzQt8ChE5CvSiePnRi+q1CSGrRFVPx4AhO9P0tdUOh8aarC+iONtZKjarczGM
	WqWmcN/o1BxnfqdWxVLoDoxpIBX3k1pJrkuEeTt9Ua2ZW/H181kjJoNVteqKv5hyPPX0Hc6LPqn
	vdxBS5O0o4ecSDqAZmS6fr+EoMz/bCBvRlw63qgffqTFl5fMOcqS69FZIdkQDnCKBlhitEULnDc
	IhUP/KL+rYDIEltwnb8RBcqzg2+VBuOJxk8v7a2ALfGEP7Xg555rlVAR5GPxb++wScn8qW0R5Bt
	1Yj5N4S036OJq7HacKeyFyOfVhGD4fCIRtt1xIXJJqoLxd8K8s25WtTXgluTIRkFkh4xKTUnt/U
	4VfYmJEWh+4H4yoB8P4prJkBshSypyvyy2hgLoTy5fHaubV2OI446Tej2jh6r3yW/t3jw/wIc1d
	qva31lNuRE5VDz/yjbre1yuqrZoZCPF07tFmcwJ+misNqbabysBgK5hXg89BAAJDHQJRR6VZTww
	i4/b0Eq5xnlfYZQQ4nFgQ3PWaa2qrhhjKlnTEkiGOXwApIdBlX1faS8lpaAhTZZY2s9EK3D6Rik
	/db8TIncT8tPkkb9Ae/7MUHHzO/gvN93Rg4=
X-Received: by 2002:a05:6870:d622:b0:44c:a4cf:ccde with SMTP id 586e51a60fabf-45163cfbe4emr6059684fac.38.1783630455313;
        Thu, 09 Jul 2026 13:54:15 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm3059283fac.15.2026.07.09.13.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:54:14 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v15 0/9] tls: Add TLS 1.3 hardware offload support
Date: Thu,  9 Jul 2026 14:53:16 -0600
Message-Id: <20260709205325.1591196-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,broadcom.com,purestorage.com];
	TAGGED_FROM(0.00)[bounces-306370-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:andrew.gospodarek@broadcom.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78C54735943

Hi all,

  This series adds TLS 1.3 hardware offload support including KeyUpdate
  (rekey) and a selftest for validation.

  Patch 1: Reject TLS 1.3 offload in chcr_ktls and nfp drivers
    These drivers only support TLS 1.2; add explicit version check.

  Patch 2: mlx5e TLS 1.3 hardware offload
    Add TLS 1.3 TX/RX offload on ConnectX-6 Dx and newer.
    Handle 12-byte IV format and TLS_1_3 context type.

  Patch 3: Core TLS 1.3 hardware offload support
    Extend tls_device.c for TLS 1.3 record format (content type
    appended before tag). Handle TLS 1.3 IV construction in fallback.

  Patch 4: Split tls_set_sw_offload into init/finalize

  Patch 5: Prep helpers and refactors for HW offload KeyUpdate

  Patch 6: TX KeyUpdate support

  Patch 7: RX KeyUpdate support

  Patch 8: Tracepoints for RX KeyUpdate path

  Patch 9: Selftest for hardware offload

  Rishikesh

  Changes in v15:
  - Added tls_dev_rx_rekey_fixup callback
  - Addressed review comments

Rishikesh Jethwani (9):
  net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
  net/mlx5e: add TLS 1.3 hardware offload support
  tls: add TLS 1.3 hardware offload support
  tls: split tls_set_sw_offload into init and finalize stages
  tls: prep helpers and refactors for HW offload KeyUpdate
  tls: device: add TX KeyUpdate support
  tls: device: add RX KeyUpdate support
  tls: device: add tracepoints for the KeyUpdate path
  selftests: net: add TLS hardware offload test

 MAINTAINERS                                   |   2 +
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   3 +
 .../mellanox/mlx5/core/en_accel/ktls.c        |  10 +
 .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
 .../net/ethernet/netronome/nfp/crypto/tls.c   |   3 +
 include/net/tls.h                             |  90 +-
 include/uapi/linux/snmp.h                     |   6 +
 net/tls/tls.h                                 |  22 +-
 net/tls/tls_device.c                          | 876 ++++++++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  68 +-
 net/tls/tls_proc.c                            |   6 +
 net/tls/tls_sw.c                              | 133 ++-
 net/tls/trace.h                               |  98 ++
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 975 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 295 ++++++
 19 files changed, 2498 insertions(+), 196 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


