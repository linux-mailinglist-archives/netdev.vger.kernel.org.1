Return-Path: <netdev+bounces-289665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HY0nJ5sDDWrXsAUAu9opvQ
	(envelope-from <netdev+bounces-289665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:43:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D22586539
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78A90304A16D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6221ABC9;
	Wed, 20 May 2026 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaVwUlk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B814A60F
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237784; cv=none; b=BzWOat3/wnTBisYGD7HdYR1pZVQCFHnjHAfnuw+ustoAHCFfdLuR/IKjGR0wXIQPO+TQN/CGJewkNjB9VsPu+WlUEMZwCdGJWdSWvsWhHZhZOsaHdxr8zPwmhIOLypUCMm+NYJE5gzuZ8a4FSfutYIsT0F+QDQd7XzXY9G82cFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237784; c=relaxed/simple;
	bh=WMicqqE67ul0vJopAceY8vMx2lsESDQwi2nHwp0/MwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gy1SEeyrEZYSuFbeWz3/srg6ga8FJo34VjWDqztBlKlgU0w2o/+aL4CjfSpEcu5yOSkcpOQp9GW3zmbGrPh7PF97h5VKuSNS97DqyOSdpBhKlKtF9zWy1nCUKdf8Psc0J4cxk18ixO//sUOBDlxhvruklCOHI4b+ljhNvHbJHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaVwUlk3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso2197606a91.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237782; x=1779842582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6KfxgyTszx0aKCDT6/DObZfaaYFv6TITrxlgwGLf1A=;
        b=GaVwUlk3x8DjGwvyt4MjzW0mIxh9tAOuZz/PFJGB3gqMIv8vu/8/O1GWxPWJFSNfmc
         HOJu0ebrubxAIbDE/xz73w7gArO2hMQDPPmI12a4BF+4uPf1wEBkHHdTzHEaOmBxCL3y
         8oHvWSZvnrrMiaN0QmsxMF37k/7rBBJN4IaBCRX0C06k330xAWNAEsRtWYm8I3aVUa3C
         z1QpKtL481bUfan85Hc7sPrHTdRsSB6PrkAsp0M2j13Wv7bWqEq6PDBvt3YlDo6/0boW
         ZYbv9bIAS8nHjufhJhbjmFVvGt9I1Sc/+gvzPXKZ5Yrnrsqp2rWwAVN+ZJar5TejGoP6
         tcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237782; x=1779842582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6KfxgyTszx0aKCDT6/DObZfaaYFv6TITrxlgwGLf1A=;
        b=dcVxZH+tOsEWm5DTGzSiuZcHHr0kwCZkx94JG+TpxRJbUufu5uzXNwVORaVYou2wtf
         hXHCMmeKlC1KUIRLtsoiYSFBmPljtnKcQ5vmtme+0owBobOm3juCtz/T7B4S487v5yHU
         CW/6x8De4N/qTpqlm1UE5bEAGr35uGuC7GyzTD5tFjwq2Qbo85rocnV9zawuxbxB9OvX
         MNwk5raGkSnACNCbj2Xu4BuShPebmMb+xNqbhrM6lrlZxse4AIB8Xly7sQtNfnbTmkXg
         XVY8vBDVLUYCuXR5Ab/0BPLjrEVHmqXuU/73VWq2r3VoenQyU7euJ2cUr/ZXel8gHbTl
         DAZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oTB8xNU9nr0s0gyYuwl5Vg81s5fFnxRq1avkO7NJcGCJfBl21EslY1dNo1+8bu8hC7Sic1Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBeIVUNo224qN2SrZ4lOUJmbvFyQItjhu+sTKHt2hirKNSxKr
	hExJPQUwVQ/AJcBtTLVF+OzH2CmOhvqGfGzkpZnZR+3KtemzH30siBWm
X-Gm-Gg: Acq92OG8TUbLlAiZbE4HR9kVqXtvySC/1/kaNXioLG3Xlq4ETS2cOvO1YYh5k5VGRoW
	qH4hPe1KgJcZEnpUiYKKXMRjudGW6+eIEXscehNCFZztMFzPNIIoYWhoVRTRCRDA9wbQZPVsO1H
	/fbFA/FzQqjA5GiNh6AjM932Qyt2wTC8WYZBkN75buLtJqzj7e9z8JaubkgXIAO0BxPtboEnzTt
	Kq4iPL/yvCZt13yZgrrt3Zos9Gnhyt2qzbVpGVrd0/A1fx/ubD+zzIxuIvjqechpWosNOzGkOS1
	f135UWTBulMtLN+UGjAIisipAfZnBFcp2z9R/vbgEIJZasIxjC5xKhQoexIOAx4nPOgp8EY69k4
	ckHnZFfWOzDIGr8tovMijkvHXWUoGP10x8ji/xfVQaBGEmqMj9pOimxrSrR8ANSLejWJUyHLXqF
	SvKzH7WMOH4lTSb2OIpGdT97HWlnojG82LOY27gou6ieugTuTNFbt3bph7pQuTzYMbNo/yxDgUr
	3g+AdZ1GZXPkTbEhKpPf8UIq55lUksCHDfKBLBJWg==
X-Received: by 2002:a17:90b:38c9:b0:369:9469:aeba with SMTP id 98e67ed59e1d1-3699469b41cmr10628387a91.1.1779237781689;
        Tue, 19 May 2026 17:43:01 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:00 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
Date: Wed, 20 May 2026 08:42:39 +0800
Message-Id: <20260520004244.55663-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 35D22586539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

The series is the product of previous review from sashiko[1].

1) META
patch 1: address TOCTOU around metadata.

2) PUBLISH of CQ
patch 2: make sure xsk_addr->addrs[] can be published to cq when
         overflow occurs.
patch 3: keep cleaning up the continuation descs (more than 17) and
         publish its address when overflow occurs.
patch 4: like patch 3, but only handles the invalid descs cases.

[1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/

---
V4
Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxing@gmail.com/
1. correct the description of xmit path in patch 3 (sashiko)
2. move set logic into xmit path in patch 3 (Stan)

V3
Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
1. avoid breaking previous usage of sendto, and siliently handle
overflow case (Stan, sashiko)
2. add one particular exception process in patch 4 (sashiko)
3. adjust the selftest to make sure it passes in either virutal or
physical machines, which includes add usleep to support physical machine.

V2
Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
1. adjust selftests (Jakub)
2. add READ_ONCE in patch 1 (Stan)


Jason Xing (5):
  xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()
  xsk: drain continuation descs on invalid descriptor in
    __xsk_generic_xmit()
  selftests/xsk: drain CQ to wait for TX completion

 include/net/xdp_sock.h                        |  1 +
 net/xdp/xsk.c                                 | 44 +++++++++++++----
 .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
 3 files changed, 63 insertions(+), 30 deletions(-)

-- 
2.43.7


