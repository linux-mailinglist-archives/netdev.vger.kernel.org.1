Return-Path: <netdev+bounces-261541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K1BAxGXoGnhkwQAu9opvQ
	(envelope-from <netdev+bounces-261541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:55:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BFA1AE0E0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 138113048125
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69DC1E9B1A;
	Thu, 26 Feb 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E8FngZFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f103.google.com (mail-ot1-f103.google.com [209.85.210.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36636215F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131624; cv=none; b=UhKLNLwxkZjJ2bcBFpptM2ohrlfdjzYNk0XMKXgJFARdBgCpwXYKdG2a7vGMaC2JYfi6VvE5pWH7SuDJi1+XuZA9Q1s1Dw0MfHxbpBdO58fpJcGzoeweAKyLOYuq9fKGmKPjuLrZl1N/z83DNjoiDgc5R8fyKmgKUyHmB7ycbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131624; c=relaxed/simple;
	bh=8FWsUKAx0XQu6h00AjRIWTiBlRzwTZCXgH3YD1OhsR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmEME4UIADreQwKZ70zkpf8vFDotVMWP1CSu0JJY4+VQAYg3wK6YSxGS+AvQA808XhbnTBpRHd3raWdpYs6pmPt919JV1wxiPx9OWv6mEDPDVvioGvpu3Y1vjtovsC42RGpjph++y0J15Ucc91mLHeJ449uLYe5XvsI1dbgsVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E8FngZFt; arc=none smtp.client-ip=209.85.210.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f103.google.com with SMTP id 46e09a7af769-7d18d02af68so910569a34.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131622; x=1772736422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFEviAmcaNb+8G40CA0bDZoCBrqK5bbiSG6l9u+wjCE=;
        b=J1tF1VARgVeet8TJX+WdyA5OQ9EQphQaED0cD//0UOpyezVR55R7HkrTz16UbX0hva
         O6YXeYZ+qVeWCA4rI8CYb6PEXUJ9CITtHovtdJteMHjtCZO4+xJPilRXA7nlrbTzCeou
         shAtmo4XYE1uAWY1ABwr+2kxQzv0dLh+eOTttR+4Kwkn1ISpePvuB74zyjjzDOBK9iVj
         9YKTABzNweTpJ7Yt9wwCTG0BDfECNXT653QPYw3g/26AqEM1n54WLONvYXjYKrMIg0g5
         +BXffJ4i7V/SLJozITVAkFZxGRv5eLOC+EeEqULzycwpc8RpvKqjQMgc/8B87OIKv/kv
         3iRg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Q4V5Azn+4w2W1OImJ0KfPMc7rWdlCUWV3e7pFuXzqeY6/mZIiWtDGsca1JqnK9All3gKf94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsuhPW+ABpwJ4hL6XN7g/PJx1HxvEQKhvJMLHWaDkfn+hjPrz
	/U6PrLf035Bia+epWfr3PyTG0dBoujGCtJJ04ynvWLuDHRuybqdJWPr74cQYB65sGppVy25cqua
	O/R8QDNQvUPYWmHCECO6cA4D7anpAmtlh0LxjdKtVampCaHTz3YomSCy558pSRKSX5SEtMkx5Ol
	TuI4sEj4lkidnnaO6a/935Gv8w+8ZbuPKfiwjnFU8xkHcZ/4NuqKRZ6Vjgx4i4OhF4/1YNpfS8+
	v3IG0BPkCyhiN8=
X-Gm-Gg: ATEYQzzU+frwBOQZuWP6s9ZTrOw6+VPKm3wyzR6sNUEVKLFkL1jH/rrMnH5SnrfJUE4
	8bQ63RvV5fp3b4y6QdGQDzjnju+z08UVYZMTjQ6ypZXJS4UmaLSMOdCMLMV48sdaEDZSVZeawqD
	DOmXey6UG4JfPUGxBuTAiRJm55nBvBlPNMshwrg5KFCDC8Sc7h2RJ6TyEazMzu78Eix3a8gt/Bv
	moLC6AZyx/ANGRdrrrYxQ2LRlsj9yeFpJlbs79oqZ/PV4d6Nv/ENrYub59FY3p1sBB5/G1SQQxq
	mMjkjXsRhU8qs7LANAEJnWfU4JShX/i+4em2zbwOCyM+Ic5gaoFw31kE0FAxyOzS0fiLiMv30wP
	z2KiuJ8pQsYSvKPbQ/coyRB0BhXycrK2D4kJEhbZPVfb2w/0mtuBzObxso86rUSPYBqCmnX115g
	L0u1hADonzeEeHp+/VR46KsPqkK/EA8TtXoOUmfzCPpIZB6uAEfMI2/WM=
X-Received: by 2002:a05:6871:726:b0:402:17a4:96b7 with SMTP id 586e51a60fabf-41626e056b5mr136837fac.22.1772131622248;
        Thu, 26 Feb 2026 10:47:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4160cfd4478sm375202fac.5.2026.02.26.10.47.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:47:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70cff1da5so723754585a.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772131621; x=1772736421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFEviAmcaNb+8G40CA0bDZoCBrqK5bbiSG6l9u+wjCE=;
        b=E8FngZFtMMFzbYk5MVNaIDe15eDGfkZr5xXJu/fBWnGbYmlRq92YQP9RnJnDxDJJDM
         5AKuL2OY1jzwLCwciAseF8OJn88Mv14VMSgClrjJgqW3KeGkzVQviAG3MevDi9CqH0gd
         YgDtaVv7GJM6I1ZZHC0lZL7j3qeARpe82OnKQ=
X-Forwarded-Encrypted: i=1; AJvYcCUuMEJkyihqlaBgPPgRUDWxw6n3eNc/FL49vzSifbT2OQk/BWnD5mEZpwIunhHVZ9TcWx38jio=@vger.kernel.org
X-Received: by 2002:a05:620a:4151:b0:8cb:4543:c5cc with SMTP id af79cd13be357-8cbc8d8658amr36385a.20.1772131620905;
        Thu, 26 Feb 2026 10:47:00 -0800 (PST)
X-Received: by 2002:a05:620a:4151:b0:8cb:4543:c5cc with SMTP id af79cd13be357-8cbc8d8658amr32385a.20.1772131620238;
        Thu, 26 Feb 2026 10:47:00 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f5c41sm255721485a.24.2026.02.26.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:46:59 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	daniel.zahka@gmail.com,
	willemb@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next, v3 0/2] psp: Support PSP Tx on logical devices like VLAN
Date: Thu, 26 Feb 2026 10:46:52 -0800
Message-ID: <20260226184654.3180648-1-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,gmail.com,redhat.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261541-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 79BFA1AE0E0
X-Rspamd-Action: no action

This patch adds support to allow transmit on virtual devices if the
bottom most underlying transport device matches the PSP device associated
with the transmitting application socket.

  python ./psp.py
  TAP version 13
  1..29
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
  ok 29 psp.vlan_basic_send
  # Totals: pass:29 fail:0 xfail:0 xpass:0 skip:0 error:0
  #
  # Responder logs (0):
  # STDERR:
  # #  Set PSP enable on device 3 to 0xf
  # #  Set PSP enable on device 3 to 0x0

CHANGES:
v3:
  - Enable 8021q module in the net/config for vlan test
  - Guard against a race between psp_netdevice_event and psp_dev_unregister
    by using psp_dev_tryget/put in the linking path to ensure the psp_dev
    is still alive before propagating it to upper devices.

v2: 
  - Simplified the psp_netdevice_event() to return if the upper device is
    bond device.
  - Handle the scenario where the psp_dev_unregister() is invoked by a
    driver before the unregister_netdev() that can result in stale
    psp_dev pointer in the upper devices. 
  - Fix the vlan_basic_send test to run on any lower device and not
    require nsim.

v1: https://lore.kernel.org/all/20260121073517.3323332-1-kiran.kella@broadcom.com/

Kiran Kella (2):
  psp: Support for transmit on logical device when the underlying
    transport device supports PSP.
  selftests: drv-net: psp: add test for VLAN sub-interface

 net/psp/psp_main.c                         | 117 ++++++++++++++++++++-
 tools/testing/selftests/drivers/net/config |   1 +
 tools/testing/selftests/drivers/net/psp.py |  81 +++++++++++++-
 3 files changed, 197 insertions(+), 2 deletions(-)

-- 
2.45.4


