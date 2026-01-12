Return-Path: <netdev+bounces-248895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD6D10BFC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB302306116C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910D319851;
	Mon, 12 Jan 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TCIbV5o+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FD311C05
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200540; cv=none; b=POPXJQUUAH+KKXEyVx5IllMw+UCEJPsYUaIz/OGwkipLllqWjoBnJxjeGDDKTAzCySpFoL/jJLhckWeOZuI9OXBfKaaYFYo+lg0D4l3a458SdsOi9nc2IjsPLKTzwap9wOg4P+HFOE9QucwwKc69AoLg6+Qj5v43BDtd5bZiy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200540; c=relaxed/simple;
	bh=PORkVXvg63BpdFWitYBmyQs8mKiAi/bQ6d/kl3dALsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hI1k2vYqIFH4B8SLLljHGYAzzGMLY4VV0Cxa/ihC9PpfRF8VSjYlCoRf/wiwZj3yNyzzGELbLBXDH/EHAboeSN00wTZk52u+Dn69nhjxFtF18AQcfgeZHr8WzqsDXgkJ4CyOQcJLE6DZ4mp3ZwtLlRHUT7iCr4s66Kdt7MSw/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TCIbV5o+; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88a2ce041b2so7175306d6.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200538; x=1768805338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5BtvNEFgqWL2yj8vB56uvRZyhnBjlOJonajbEim00g=;
        b=qhunJD/cJVeW8DRI1uEjcugY/3jLR7WcG4lsboULzstbSf4mzTyo0ReKcrdzwsyYsq
         9HJnsH26dDp3kd3NRbRcVRzenFg99jqxTRI2Rx1FSlkcco6LBf54kTzxBJVPEJavWdEw
         Q3EQgueUmRjRPJ3JXSPIw36OEsqLKVHiIcXu9Mdhxwd7TApaFJ5DMgO3HU1nabQWG+4K
         5AIRY1pLsuTiduFEVTy8V3BLsGd0FFTPmb9qxG93c1IcPLXfjYDAAxKESgr81MQhtX2T
         965Ze9i29UR5cFgkXGm5oqeAEZzp0gYBR6XeexnagNHLDHtdDoYfirSKcSWOPglhtqav
         +A4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0DGs97Gkm/FYKtE79wPqhRQ7X1Ar+nK3pCau1fwqUH4AfYkSlu7l9G7oiJVl17fa42sIirMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz050TaIjwhIZigt8Noreh8rJzCUFUJ6YfNx8I6pw6IuPUzL69G
	oStzQ7Cl9Wcfb29Fl7yUA9tgTjetCr6pairZGI9+NkZ9v4e3VdWXAd3ql9WuQnTKUPpf4Z1dfiR
	W5Fj6tyYWeh1etjg5Mvh2Iyuy5pfEcXoO9iea02uUmVbjyeP5QcDgoxKsqcgEW3k8FfdIL2tkgM
	38VrzG6w0gDlD8RMK9/sQTAZ20g5Xo7WUQ/IGUpoo6h6bnrD+vG905M0TmPddDBYqVRa6H8pRT2
	EuFmvjMLb0L3l54A0b3DdtuTYFWoX8=
X-Gm-Gg: AY/fxX47wuoUhrlQsDbQqJ5U/gpRkupRYu5yLz/fKtHAhFR5sXejvsF8U5drGZYzsA2
	GUtNNKE5HPquzP8jLFXxNAJHYtkRK7HPdKQk9RbJH28fZucgPC6u3Rm1h8StdqA/73NthEeNMRs
	M7UK9XLb8fg91CrmK6+dLJbyP2UoxEXYo0FWTA1vJiHViLbZRyBDpSoei2rME5K67aX7hEMSdiC
	7LKpz83PiMSBd4ydS7ao5C/8g37516fHOf8OCRoSBWCkQ3ioG2+Y3EENUL7pfI1J6KjOVB9/2nA
	xAXw5UA5BG1ZZNuYhUf/EFAnfovfdQafvpa/ZUJIdHHbY7JVKBDYj7eye3qXFQY0vA5qOmvjxN6
	HnWbW58mpgM2RhL0rFzQl3DLn33L3wU4FgE2Wmyq9SmOSWEkBjLjFFecEPNDI0i4ooxb8S/eAL3
	7hfCq0CH8SO30TOEu1GJQYPbdyYgbbIRaxfvo6cE8ZBuIj7vT+Xn7z0xC63cfgA+6t
X-Google-Smtp-Source: AGHT+IFmFg9XNo2GVt80RN3hIu0wMHSIsaMs/B5TOAEOCrrM/rgUq9EvoPy486QknbpRTQc6Z+OCI6oOIFpG
X-Received: by 2002:a05:6214:415:b0:88f:e332:1539 with SMTP id 6a1803df08f44-8908410ba72mr202782986d6.0.1768200538156;
        Sun, 11 Jan 2026 22:48:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-890770a4c87sm22217266d6.9.2026.01.11.22.48.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:48:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed83a05863so21217341cf.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200537; x=1768805337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5BtvNEFgqWL2yj8vB56uvRZyhnBjlOJonajbEim00g=;
        b=TCIbV5o+ui8Szxs3PaHx240JMR8a6FA4i4yPwhh3UnxJsbVpiRelieF125D9PW+zqL
         OlhUsMv2SloUdfVuXD4ycE3rFGrjkIGLIQ0rL12+dH/Z6puFPEegSiw3bLvI8oy9k7Lb
         fy63YGyzk/gjyRzM4mzRH7zgsYsFp9Em+Cq00=
X-Forwarded-Encrypted: i=1; AJvYcCWvBNWOOocrIOBiiYGELvC/ZFdMev9ML2K2lJx8sw7mtiy3Zm8oTN4h1EUXr4hhXVotLQYAkYk=@vger.kernel.org
X-Received: by 2002:ac8:57d5:0:b0:4fc:989e:f776 with SMTP id d75a77b69052e-4ffb4861697mr202473841cf.4.1768200537486;
        Sun, 11 Jan 2026 22:48:57 -0800 (PST)
X-Received: by 2002:ac8:57d5:0:b0:4fc:989e:f776 with SMTP id d75a77b69052e-4ffb4861697mr202473711cf.4.1768200537162;
        Sun, 11 Jan 2026 22:48:57 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm131125426d6.23.2026.01.11.22.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:48:56 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v6.6.y 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:45:52 +0000
Message-ID: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 17 ++++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.43.7


