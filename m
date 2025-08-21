Return-Path: <netdev+bounces-215593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D69B2F64F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4681CC79DA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF1D2EAD13;
	Thu, 21 Aug 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="emOzK0LT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7274305043
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775003; cv=none; b=GPM+q0Det1zBO2tROBxKuk6DD5uMiD3kjyaZmHucpMzPONVihoA7rEJ2XVKkHxE8/LatYWhAYgbw8whpV6kYqR5BCgT7lGqBe11gv4RNujmNbPSqlzjbs+bFguUBbRl1PbKZrxR/mmIWAZdtfQ1fNBAFQf9cO4wiQYlTkstYcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775003; c=relaxed/simple;
	bh=3RlZSj4ygi3yxZvCh2ME7pHE4GTKWmg2Iq4Gsz/GWzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWbY3tO1kZiJobHzfgAY3vGCxtJmUMhE07wXCEFCfOeasflMOrsm2Ggml+2lVwU3Lv4mef7xhrCB+eg4w8Ttym7Ahoi+rhSPEXONiDzrNCMqe79VO0cYChf7ePHClfCPQaMs2qNbRZaKCCMksgOLr7kC8Fni6weYes3UJX+IjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=emOzK0LT; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-244580523a0so7799285ad.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775001; x=1756379801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C9m78DY2oo0QEwB+fU7Tphb0IaeTBYjgFM9rxi/RnM=;
        b=L0UbLooTRpSTF239YAbWqaOinMnMuNH22sXDNur5YX9BOcEEn71PYVFh9b8qhvxKno
         D5JN1eN1o/5mb2SINTOVSyxnv8yky+F0Pe9IW8O9XIzBGvyYe1X6bnBVdWtf+/vw6I5J
         x4QRaucihkI2kkEap4tQ99ozSQpsjK1h6WbNBDAfmtmdfDJbClTTwZiXfQUqlcwFqZUu
         0GvCYgwW8MOR3fHJAhLMWiZKFmeGZaSCk7oFnGxXXfGuPj4BbcCZtM2vXFY1VtetMLVP
         hX2YfwgfRRdFjCLEcnNkhm68OdpPCLvNUhKxMMQFxJqh6eDhUpO10mmR8rAhFK+8L6tt
         qSTg==
X-Gm-Message-State: AOJu0YxpwFDsQ570Rv1zj89RlQMI6urSdI/erYnOXNQ9y6pi5bO0xt/Q
	CtkFPMKfk4nJAKiNWeiS9iobez18z2X8oS1MIhzNaCzdRwkMsiI7cTDhytlti9+if2f7acfOsJc
	+aPb/dUqI762OQj3yevNZ9jCVDRwxb3ivwZJQjBQE71f/Nrz6XHetChUeS9Uj9CK5QYAkSjjC8b
	PLYY4JbYI2uHsvTOyky085vKKheuNkVPAbSk5+d9CrBMenlQAoMEvZZPBuL7SW0p2gRTPkbec91
	pe55DjbMfk=
X-Gm-Gg: ASbGncsqoGNtk1F8Ps0LGjkdrCi101fEcCMKL2qDjxVe3R2f0RfD+AFCV2VMIzWhqzv
	zAUR4iDLENhRT6ZpDEYuEwy6glNxaKSghSLH1QuzQ3Xo/9/MTBf7EBlZ709ZW25quU7HybfjoQh
	I5YMP6rWgqU9GT3sTtqu0w08UwkmLO1ACfHJpiKbJFZX6NklIxaXnvpY7zKfYLPGKO/H4nGbAzh
	DdaWnH91ZhkduNXsVOQxLsACev7N7fqcuufJdyx8sR1zB+YzJA/8xwr6wKpK9bo0JV0k8BEEja4
	jUBFVHR+4UT4wL05abCyepRPzm1mYuxr9CfORUQJTOoW2bOc231B0dujX/fPSfKyKuc73LPco+9
	05Zb2gRe/AJL6W4RgPOPJRyacQxCtphl2/NUqv1zbAEngNIiaW4p00XwUe1EWYbUIdR6EkhIN
X-Google-Smtp-Source: AGHT+IHve/lxiqOyBrzU6VQcatGJ/T+oOaoyPH9AZEhCm4p+fdctA4YM1wR4YhCO8FO/G2WJ7/OL/Age60JC
X-Received: by 2002:a17:903:2f44:b0:235:ea0d:ae23 with SMTP id d9443c01a7336-245febef497mr31811605ad.6.1755775001121;
        Thu, 21 Aug 2025 04:16:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed4ae05bsm4755185ad.76.2025.08.21.04.16.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 04:16:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457efb475so11191895ad.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755774999; x=1756379799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/C9m78DY2oo0QEwB+fU7Tphb0IaeTBYjgFM9rxi/RnM=;
        b=emOzK0LTBmRoejrIy8JkjknOAM8iUuMWXQFJT1UvdaB97zc7hYuF7rp9rBbPzXxb8+
         WI2LQDpgjuJ7ej55EQoX1qzh+blkZOjQO+GNGRGu8jPxZa6DEFl5DXuaIN5CULjBiO5Y
         69I5hKXxTqSBo7TwcrZU3KQXn0jLD74+USDGw=
X-Received: by 2002:a17:902:d54f:b0:246:115a:e5e6 with SMTP id d9443c01a7336-246115ae81emr14311255ad.42.1755774999356;
        Thu, 21 Aug 2025 04:16:39 -0700 (PDT)
X-Received: by 2002:a17:902:d54f:b0:246:115a:e5e6 with SMTP id d9443c01a7336-246115ae81emr14311005ad.42.1755774998952;
        Thu, 21 Aug 2025 04:16:38 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245fd335ea1sm21363285ad.110.2025.08.21.04.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:16:38 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	shubham-sg.gupta@broadcom.com,
	karen.wang@broadcom.com,
	hari-krishna.ginka@broadcom.com,
	ajay.kaher@broadcom.com
Subject: [PATCH 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
Date: Thu, 21 Aug 2025 11:03:21 +0000
Message-Id: <20250821110323.974367-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series provides:

- implementation of PTP clock adjustments ops for ptp_vmw driver to
adjust its time and frequency, allowing time transfer from a virtual
machine to the underlying hypervisor.

- add a module parameter probe_hv_port that allows ptp_vmw driver to
be loaded even when ACPI is disabled, by directly probing for the
device using VMware hypervisor port commands.

Ajay Kaher (2):
  ptp/ptp_vmw: Implement PTP clock adjustments ops
  ptp/ptp_vmw: load ptp_vmw driver by directly probing the device

 drivers/ptp/ptp_vmw.c | 110 +++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 22 deletions(-)

-- 
2.40.4


