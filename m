Return-Path: <netdev+bounces-279974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJIpDFrm5mkl1wEAu9opvQ
	(envelope-from <netdev+bounces-279974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:52:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE84359D7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68AE730166E1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF278265CD9;
	Tue, 21 Apr 2026 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp6ezImD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E1175A9B
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739890; cv=none; b=q6voZP1Ebi0ZP5VsHFPuRRRSNG/77C3TR9TAkGXTV7uiedE6lqfsQ7/5jbzLh1Fz+t77YPB0aD/jhu/YLUJ+5cmOmWxKG9U6kc7Brn/lq2BOSthaFsYOiwSvziA7xNBDvOIMJqwgysHV4NzdbgONQ8Fm6Iu6/pvqVZJ/n1BTLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739890; c=relaxed/simple;
	bh=VqSBexJMNIHC54WdCID6u/xPpx/3eQos31xFOQdy8sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZWEl1bVwBxKmufY/LhpCYwk5F/aqNBWsTKvCIl7Gtf6yMPB+CT7/RDRmL9Op45diUMrDU7df+1np4PgEQK8D4oYSMe6vTzZTjdech9/868lyGoN9WyNa068czTe6c2t8tKi1QgTGNHLh4r+MDmCG9ynpf+rnBZw1TfSfor644M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp6ezImD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso2736798b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776739889; x=1777344689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpaxH8+vQYVlcVoYKktqzw1Wuz9BvpJGipAw/vPCovU=;
        b=bp6ezImDvVc9Z9cW1v/Tk+O7IU486/vJ7kpwQLHpgTOOu1lyZAGBTCHSi7M0jnQ5jQ
         zDbmk2SZ6ooRPZ92w708eRu7kfNdBbHznDmuVBgpOEHy/2XqUCyewLgjs8ogrlSH6olP
         BhM6QRyQNjCEbr4MtUaXeJLBQE3q4d+EBtcmEdrlASqDKty5Bf4ZLWxADKQ2n2F+/HwT
         kmsJCU622x4gg3vCDOEe1oTwH5zidwM2QZMVuUsPRAXXE1NMzgoaRlysyZ8KrZWA01r+
         OwTWjZr0RzVUI1w3py4g4dKjTNxJ1iELz94qhlFXdnjKUH7YfQUR+SFMB2cUXR8o+1q2
         CtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739889; x=1777344689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpaxH8+vQYVlcVoYKktqzw1Wuz9BvpJGipAw/vPCovU=;
        b=FFehUR1gsYKvdKwKKaz8ibVe0eeZA2g/MYqlE0WeQ0m1cqybVZrsDrVIeTUAC0I5+5
         4RCmtqmUp5U22oPftPMoKGfyrhdAKwTRU3qHZZ1FIKkj8P5sjio6ncPv3bYj6PHZhZeW
         nX9uKQRucfeu70GEgToOtvTlVMDuHmvEUne49ogIyQJQDS2t+lrc1umWAJD2isGpdWSm
         FSZWgGj7N6FHAcEm/p2FjqUKsKSPDtZF32COzAf6UIfamoWmRmrv3zmOKGRrWNzFxIGW
         W9Ecw+m37N29wmUMJv3/LIt/p9T0v8FB00/+MQagOfb3ZHFcTbjQbs/9NX3SaM9Pq8Vl
         +Ljg==
X-Forwarded-Encrypted: i=1; AFNElJ9ItyAuMpYVCd09M5ChQDNc8CamO7qRA4j0tBxOSNXJrBblIZZbBqDtXnXanZFLIjpIvaJTQkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPHBr0d21om36KtpmLqcaV+B8jbZhnZGZ3T0K7bxbcTKvLk3no
	VJ1KipCZQiu+7q+yaDpGwFulQRZcdpJAEwPwvSTzA24c1eeHxzKkZ0aD
X-Gm-Gg: AeBDiesQhqqWKkNSiMFsq+e9mhK4GGeydyhs4JrgPlZaKfCvXQko0vEmyubt449waXM
	P1gWbr0UUkWJTiWYyONeCIbw9UPvy1R+1ZjW//SmJlfnJ+ouKcg8WyS8IjHns7USoec5JOO5JyG
	g70ujMuHG1TwHLtGYigtq+gVY2Mo2CtRLxB53U3W8FtyOVoDxCfv2iFoyp4cOsN9X6WSVSk5cPn
	DTu4P5zzDLWZOajw5FOLCWlSsGyipvZtkSAn6LMp1xN2UCjdiP0j44l2Pn0CO+z0ATa1SZKLHTd
	4tPo5SS4XpwewFlcOpBRHDjh8YIxCVFhmy7NntnPXyn708tSJz0Xqzsy/smTsgMbiac1LXZVU6l
	3IU7P0QaDUhMRiHET980Kw8gBAxFphv4cmWB4GWnSeVJ2J5yxL6m6vCcKdksnVh1bN8+xvK9EDB
	pHnlmJ+5xF3E8e+nrlyDj1kJ18O6StSvFnJRLUbFSAAIyfJ/1h95Z3gbabN24O2CMcUbOe
X-Received: by 2002:a05:6a00:3cc8:b0:82f:1b50:d2f2 with SMTP id d2e1a72fcca58-82f8c8335fbmr17014982b3a.18.1776739888830;
        Mon, 20 Apr 2026 19:51:28 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm12823502b3a.20.2026.04.20.19.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:51:28 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v2 0/2] Bluetooth: ISO: Fix KCSAN data-races on iso_pi(sk)
Date: Tue, 21 Apr 2026 11:51:20 +0900
Message-ID: <20260421025122.55781-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,holtmann.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,brighamcampbell.com,linuxfoundation.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279974-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[suunj1331@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FBE84359D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Found while auditing iso_pi(sk) field accesses after a KCSAN report.
Patch 1/2 is the reported race on iso_pi(sk)->dst in iso_sock_connect();
patch 2/2 covers related races on other iso_pi(sk) fields accessed in
iso_connect_{bis,cis}() and iso_connect_ind() that were found by
inspection during the same audit.

Changes in v2:
 - Patch 1/2: Use sa->iso_bdaddr directly instead of caching the
   bacmp() result in a local variable, as suggested by Luiz [1].
   This avoids reading from iso_pi(sk) entirely for the broadcast
   check.

 - Patch 2/2: No changes.

v1: https://lore.kernel.org/linux-bluetooth/20260418053239.128190-1-suunj1331@gmail.com/

[1] https://lore.kernel.org/linux-bluetooth/CABBYNZLBoU3byfK_G+=sTkBx3wNwEh2X6_7dG4+4LFtrc3Skpw@mail.gmail.com/

SeungJu Cheon (2):
  Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
  Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event
    paths

 net/bluetooth/iso.c | 56 +++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

-- 
2.52.0


