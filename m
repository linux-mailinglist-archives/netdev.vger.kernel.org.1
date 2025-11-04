Return-Path: <netdev+bounces-235314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B1C2EA99
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32303B8E2D
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DAC1F5834;
	Tue,  4 Nov 2025 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QFwkR32S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF841C84D0
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217871; cv=none; b=TR8yxSkzPtP4iblGqHGlzyEE1RaD6h2vDYBgbVtbK4vW5hriAZKEfKRimsOy1dG6PonTvz6nw5MqNtuJFfAXdCaZ3ZzQRybv0qDd3pMo+N7BhA5BYq49o+HFNBD0c7ciisclaVZF1CQYfTxr9DckTEvc3G+ljTEeYDKJUduOjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217871; c=relaxed/simple;
	bh=bXQgJXk3T8VM2TBm/75fiBuHBif1F9xmf3qiy+3Y1Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aw3QzbVf0V8vvJCQGY3qNT2nGC9Ln8zu+mdfB2YSYDMnuFwfwKadLJWrVfdOysEMH462YvQNphG96i14GxptlW+/HJUAYCsb/Mgo67PS41RcxHLv9iv+lyyoPaL5gxtRZMyqfIpITu07DpXjwcOMP4jDSQ9WIAk691O+3XRIbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QFwkR32S; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-880439c5704so24123276d6.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217869; x=1762822669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG8pOE65b7RLGwqHtSzm+QlAf6aMjjQt33X5sD3kvZ4=;
        b=nUFyYktCO4EAhiUoRGO2dDcOuUstsyRkfD3WZoixyVVwPhxd77pC9XdBfFhkvWMlBL
         AkPipQu9iixHHxVW1pvvpxCA9IIimfPyZ6WHFHgns2Otad0nSHjApj1Kuj9dgh/PGKIi
         jcHL5VubFzgggbAaniYW+65xJbnHk3tnh1w5Ui/kgsxkNOiAB5eHpzxgtMr7NAvQ+Rug
         6PC0XKTUGyainaBURLydaZhaE3nN/8V85Uo4FsjeXmoUWCpmQ8A6AhaVECgjLrcaSvIF
         vuUSm0Ar1ZxBPqROeV+lPk9onk21chkO+I9oa7nYsgsm2fFv9tG6MO9UmrrJvTgBZxG+
         d3FQ==
X-Gm-Message-State: AOJu0Yxeu+1JwMA3aPVwHWLQDn8zRIgc5ZaeHs+l5wPeUV8OEX0YY1if
	Jhgf2mFADbLUmdYZDwlk60GORNy5PmJPi5dhDLt4LJQt6DgzXWgrZlm6HBddbQwfhJ6LsKYdoXn
	KASLvdUkOSQa51214BIPNio1KVu9aZDn0VT41lya9k4V89rENuIUWWnIJf5bkMDwMo97uJHEGsU
	Nlo002ynl86zUeJLZlW5wbjVRCZP563FtcOdPO+wrElXgduIocwvu9jRVT95J2MyPSbCRd872Ek
	MLN44HTRZU=
X-Gm-Gg: ASbGncvCEJW3caqMJ7y3dYCgD6GYDYAQ9X87SxuJaKnYuOwyxNLxxpsV7waLUwI2WSH
	GYqxNU9SCMUt6fFSgp1JoUh/2AnnuIq77cLN0SCsZPuqfM5oPIfYAZC+35nJl3BsUbYPsyXpqfd
	PfuBMkgLnrOO10qRJd90jDpv4VTPrAAk9py82jvJR8wtEeiwjcNUme+muSM5BZ79IRrYszjTcth
	4TuQmg8OWMjnOhfLn0o4lJAx9a/Kwhqj4OFgDkK1LqALRB8tUdtYJPFLnKNkyGqP81aXIuo8Bv0
	s/py1fcIU0qiQdkczyyMGon0Hg/SeH1ECxnZimBeGecQNDvqfLiy0dk+VC24OsMDgJ+iGxdhvvt
	VNw4EWtO+jDBVSAs7474M1tES43ChCLUhfLbt53mmDyJRm3nVxksclPMrdRC0xX+JMNEcqSJHNF
	pmYfS4ZarIEApwoyLg1jaYcNXdX2Pe41Q=
X-Google-Smtp-Source: AGHT+IHtPYIzgT2XNfT1DVwkkckNtD707S93asAr6mQdt4YdabL+80tZrG5OVMWnBTraqQiyevaewJrnKPPv
X-Received: by 2002:ad4:4ea9:0:b0:87c:fbf:108a with SMTP id 6a1803df08f44-880544bd4f3mr78740036d6.10.1762217868922;
        Mon, 03 Nov 2025 16:57:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88060e4a723sm1495476d6.20.2025.11.03.16.57.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 16:57:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340fb6acc39so2680085a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762217867; x=1762822667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aG8pOE65b7RLGwqHtSzm+QlAf6aMjjQt33X5sD3kvZ4=;
        b=QFwkR32SEQ3pFJGmcemJL8ep7wRDtaT1jDmtW+4dUHqOYzsytWhnt+UGOpCA0JG3cW
         +kGEZlpE05P9JB3R0sKTprIXO53+Mnw4kABimFdy6VywJivpGRFuLrRJI5xUg7UsTu9W
         zFVUO/YM+L3cDSL+v6EufaPR26AiQSG5v86uw=
X-Received: by 2002:a17:90b:2ccb:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-340f7d6e39fmr9244631a91.13.1762217867022;
        Mon, 03 Nov 2025 16:57:47 -0800 (PST)
X-Received: by 2002:a17:90b:2ccb:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-340f7d6e39fmr9244607a91.13.1762217866646;
        Mon, 03 Nov 2025 16:57:46 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm2474553a91.13.2025.11.03.16.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:57:46 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/5] bnxt_en: Bug fixes
Date: Mon,  3 Nov 2025 16:56:54 -0800
Message-ID: <20251104005700.542174-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Patches 1, 3, and 4 are bug fixes related to the FW log tracing driver
coredump feature recently added in 6.13.  Patch #1 adds the necessary
call to shutdown the FW logging DMA during PCI shutdown.  Patch #3 fixes
a possible null pointer derefernce when using early versions of the FW
with this feature.  Patch #4 adds the coredump header information
unconditionally to make it more robust.

Patch #2 fixes a possible memory leak during PTP shutdown.  Patch #5
eliminates a dmesg warning when doing devlink reload.

Gautam R A (1):
  bnxt_en: Fix null pointer dereference in bnxt_bs_trace_check_wrap()

Kalesh AP (1):
  bnxt_en: Fix a possible memory leak in bnxt_ptp_init

Kashyap Desai (1):
  bnxt_en: Always provide max entry and entry size in coredump segments

Michael Chan (1):
  bnxt_en: Shutdown FW DMA in bnxt_shutdown()

Shantiprasad Shettar (1):
  bnxt_en: Fix warning in bnxt_dl_reload_down()

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 6 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 5 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      | 4 ++--
 5 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.51.0


