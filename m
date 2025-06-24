Return-Path: <netdev+bounces-200851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EC8AE71A1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C28F188A7D7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C2259CB3;
	Tue, 24 Jun 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy2R4rWT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358CA145355
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801143; cv=none; b=oHtBvkFl+5zxVh99QucBW7iOBpQNjt44wKUXhREFxgJ1Z5bNhOP0LUod6KWFsiXHwW8rnJZg4wJtjoIbztSGhT1e4d6ojPLwiDORrvpTnBOC6UR2NpWEHMMlqoehBSUrshrVXBieZHEnyhiLvZpAzoRy9ZGQL/BoOTL7gfMHTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801143; c=relaxed/simple;
	bh=zf6lL9O/C0j35Qmm1WLEQqccTFwpDjDRz3G69YzELLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcnHzbeH7pUPa0XM/VcAuCXS3nR4RCTzecPjYshdONJwkG6vquon/fX9Q6aaBXerZua51M2oTMr8Jc1N4htz+kzjEJlDGvlbqzANP/A2eBl+/g+08azPd0yeAB3yEXJcgeB/iXe4RQ33LOCPoiZG5QmmdwnvVByI01WtykVSS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy2R4rWT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453398e90e9so40149875e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801140; x=1751405940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1F5nQGZbl4VPQ74+liK5lGLKNJHyaz7vdOkoN0pqdcI=;
        b=Gy2R4rWTaFY5a/VcIIqKEZsqNNeh+V1xAfXpETEamjnZuT4z/gx1OWJfTr4bO1RCg8
         qdsHHn2QiXzd+Rd+c1KhDFthtr31X0aIGrMMzvXM2pXYkF6SAcUzZTP2uuqBBY+B3nL5
         kgU9VYmthjL5hZrr7EGQO+Cw+c8wDr8XZ8nuRbpumYZiJj9LNLvS14nLb2EV87Pbqtjm
         tYhR4te6GVkXovfPQiEpWq4B81U5IUfV4+07i0vxMA+n6TG2j00awA3PgQvVsVdcbvzP
         NzpGx/T1cHMWUN044MJgxhZMhSBsE7TBpoTPiz95s+8JemKvx26SayQGd65NwRef6ML8
         tlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801140; x=1751405940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F5nQGZbl4VPQ74+liK5lGLKNJHyaz7vdOkoN0pqdcI=;
        b=DfDUNhkXjLqS/BSeqhegA90TSrs/NTygd/6AmUmkVpX5sYM5vBFB6hJ7ngtYFuP4eu
         7MQOpk8iJvbSbx2aEcPj2AUBFO5y55ltXIlD7b200D6FgZ5jsEMM2mIfnlBwpISxg7NX
         W0XKr0MiuK0ma7RascbB1LNFC5Gs8EdmHd+bhIMGxMSNAZL9Gj8p0VumKd74S/ohlTKr
         LMXqMGMs2GAjcX5J/qRnYPWlUyFtMJw2bzO4YfkG80t2IHKHawm5hjf9JW6exQcptq3T
         XzmcLXIbl9OcVxcdRm8JFQI+shAKap6J2IA70BGcKhlZqlM0zB8PZwwBjgUM6SWGefkw
         pY7g==
X-Forwarded-Encrypted: i=1; AJvYcCXHvVcryfGGLO4ZEyKF2lBsRAWpSXYXLg/4uvyQoL8nQEKigC+JWwhfL3+t9Cfixeiy+j+mNIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUM9Ggz/dtZpX1RXzVUhjBA3xajF6bZ5XR/r0I2y6/BKrCpjCk
	7J3jeQl004ZQ3+PZZCdCiTUyCZJvZDZ4vilIxFT/g/hO2mWWBmQaGUAD
X-Gm-Gg: ASbGncuJuu80v4TCXB0JHYnUupjz78RaWeI2nW4f4aaMHoDXwgvSQJQrvjTDOCEVeIS
	A1SXYDdAcG2bgVo9Joa1hGHKp5Yvn8JPD410RLDql+wVKYdkFR0Ge3M8GJgwcsOgIRe666GbSMl
	hmYR27H0LQpFA5YiI5q/Y8CXhPQTvjXboj6BjYKtlbgpkNEfbcGQFUowK3ngPVHOmSWu3fhNPpt
	JaJk7uu1N2LTLJDOrpmIevjNXRsGOgA2W+xZMxi3SB2T/nntDlHSDyfJ9KTnrtDmKCVm7XWzmo3
	Yr0eq5gn/J6mHpzF/7xSzHEh9Ngr+ifqukBTtS89PJMmi2CV1pFKJNatIJWF6jc+gyMDeIaWdNA
	V
X-Google-Smtp-Source: AGHT+IHky23WMOGQIhOL21W4CXxROJMEkaN3ZNcUAtgJXLlg0cZbKnAiSFMWZpn9lyAPMWDjKRH0aw==
X-Received: by 2002:a05:6000:4a13:b0:3a4:f723:3e73 with SMTP id ffacd0b85a97d-3a6ed604257mr215724f8f.16.1750801140242;
        Tue, 24 Jun 2025 14:39:00 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234c9c7sm851415e9.10.2025.06.24.14.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:38:59 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
Date: Wed, 25 Jun 2025 00:37:55 +0300
Message-ID: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series introduces a long discussed NMEA port type support for the
WWAN subsystem. There are two goals. From the WWAN driver perspective,
NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
user space software perspective, the exported chardev belongs to the
GNSS class what makes it easy to distinguish desired port and the WWAN
device common to both NMEA and control (AT, MBIM, etc.) ports makes it
easy to locate a control port for the GNSS receiver activation.

Done by exporting the NMEA port via the GNSS subsystem with the WWAN
core acting as proxy between the WWAN modem driver and the GNSS
subsystem.

The series starts from a cleanup patch. Then two patches prepares the
WWAN core for the proxy style operation. Followed by a patch introding a
new WWNA port type, integration with the GNSS subsystem and demux. The
series ends with a couple of patches that introduce emulated EMEA port
to the WWAN HW simulator.

The series is the product of the discussion with Loic about the pros and
cons of possible models and implementation. Also Muhammad and Slark did
a great job defining the problem, sharing the code and pushing me to
finish the implementation. Many thanks.

Comments are welcomed.

Slark, Muhammad, if this series suits you, feel free to bundle it with
the driver changes and (re-)send for final inclusion as a single series.

Changes RFCv1->RFCv2:
* Uniformly use put_device() to release port memory. This made code less
  weird and way more clear. Thank you, Loic, for noticing and the fix
  discussion!

CC: Slark Xiao <slark_xiao@163.com>
CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
CC: Qiang Yu <quic_qianyu@quicinc.com>
CC: Manivannan Sadhasivam <mani@kernel.org>
CC: Johan Hovold <johan@kernel.org>

Sergey Ryazanov (6):
  net: wwan: core: remove unused port_id field
  net: wwan: core: split port creation and registration
  net: wwan: core: split port unregister and stop
  net: wwan: add NMEA port support
  net: wwan: hwsim: refactor to support more port types
  net: wwan: hwsim: support NMEA port emulation

 drivers/net/wwan/Kconfig      |   1 +
 drivers/net/wwan/wwan_core.c  | 240 +++++++++++++++++++++++++++++-----
 drivers/net/wwan/wwan_hwsim.c | 201 +++++++++++++++++++++++-----
 include/linux/wwan.h          |   2 +
 4 files changed, 375 insertions(+), 69 deletions(-)

-- 
2.49.0


