Return-Path: <netdev+bounces-231613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63436BFB8AB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB6A3A6496
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B0328B54;
	Wed, 22 Oct 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b8H4kUzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446D320CBC
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131236; cv=none; b=ldrMhbvxSjjCxJF6TIgnyyiFCpEnTk2Tcsl5SiXuq7yHhxGlv/fqcH/33BEngrFchrNop4IGCr5QDp6airxxGoYIieNeoVfz3/XMXvPP1gW+VRU9lUZLjQOO1K0v7UpW1cUlLMvJVQxcNg9TzrMB9qJzjvzMJDXQtN6xWKeWB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131236; c=relaxed/simple;
	bh=ZY4ksHec6wJzWCalGrMOvAU5kA0Tf1c5wcS05kGhWVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xsz9SqIL6nhUoGPHYuWHn6pZ6vECIsamCktOPBak9e29OEujmgK3UT22jtiClN4xAwGnmKJyge+rx2M6z8/Tq6b3pZ2s28/1BpouZ0A1ikglesaWpjb82lR5BW9ZyO6WGD5ZRksKBMKEO3k1cHQjNZCS7pkgRKARIbEaYEDHiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b8H4kUzn; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3c8fb195c23so4067808fac.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131233; x=1761736033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2jSL7X+YIPN8ymI0EGsh1TEga+mDeE0bn24UOno88E=;
        b=En7xNMkxJ3+7pMSB4tOpsx86sKBo6OxaGFkKyUXXaRJzGAf7oMylFb62pZrJGeb/LQ
         s28pyF3uX9DnkWATgMhYrYL73LpgUIPL+XEPalJxMSfCkJ+DDUPJWrDilRoPpl/HHp5h
         MIbRpS2EGIqm7jFPPcTdJDx8/6Ay/BbjVO0fnNtspTTEEbszrLI7uvNaBZPqBCdOxNPc
         9X614tsGjnwxz0YFESf2nIsrQI4NHxP7fNMc/0o9y5HXtvARIB1t4zQNtvy/O/RAGRGo
         /0A9gH9AQNURDhNR+5JfdpNYBiAX7DyMCDeqmQGxwX1RtQ8aEHegybKfBIWS1hxxjQRS
         R3/Q==
X-Gm-Message-State: AOJu0Yy9E7hkEo5g3ykCEJanBBD8f/tAlH8doH5iEe8GrHL/81Ycpaxj
	u617ICzYlI1x65odtux22DWLPc8/N3X3GVIXATt6BgfvlCc9UduQv/5Id3R0gLPGVoi9cYXCx+7
	7YTpHQyyhX3/6bImGpYrXJhwd0Ej/KyvZmcR+rkkJMJtwEswtgkqGhriAg+OUZed4/R0nONXFdg
	DMo8VrPe/yh0rA144TBU+DM8B0EThex0zvpVPgJEMcV3y5mIAw/EXz2BIHoH4iJBDQg7CYIhBnt
	9Ak3PuBMC0=
X-Gm-Gg: ASbGncsBfZST7UwRcAYa5HWWsBnn0NwWdXo7yCv1dTDOX6Wv782J0bXmOU6x1mKzTAU
	TycIH9VraMCtI9v+YSS34bIVZesRLtvwJjSaPWutafw2b0wyT0zZwSacw5GlLGbOQGBBT5mEltx
	ig/r4iK+hJXbI0oDr/YGf8s3DwPlJBgFq/ARqgTJ4wb1dUergINQUfYazpd8HyxByt29FywO+4W
	+J5CIzxO9I2YjAg5pFKmcTO/dIT3adjAOlsmue1ZPuAC5grYvNip9RyjnbpLgFaBc71MwMwLTGX
	kxaD1PLyqLbnwb4fMPM8h6I12BOQLteQHfpxBt5ws9e0BNPuCNEYDQOqHmqEdddtqr32ngB//2u
	d9cSRCykdbqbY1555dBX9MHxbUqP6UKpcyerZBvMxsM998pjoX7E6yohEP3XBoarPZ+B8OvLeCE
	QkR7rHrjh9LNASASBMnmLyT2/AxpJ7P6Y=
X-Google-Smtp-Source: AGHT+IHYjwyH7GxjxJ1yS6XeNNBhDjFyze9l1e1SQx4XsRLzqat0sdVWWL4Qw1d4kwfda8lO8pmwqZR0TqZU
X-Received: by 2002:a05:6870:548a:b0:3c9:74fb:a719 with SMTP id 586e51a60fabf-3c98d11ed8amr7546003fac.39.1761131232587;
        Wed, 22 Oct 2025 04:07:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3c9aef0a5ddsm1453291fac.5.2025.10.22.04.07.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:07:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28eb14e3cafso133944235ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761131231; x=1761736031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2jSL7X+YIPN8ymI0EGsh1TEga+mDeE0bn24UOno88E=;
        b=b8H4kUzn3LR4nBn5WgN0jxYsNNWyc/rAO6CMXtrdr4pme/cKfK5Dgna3BycP51lBNd
         5rBTXA71hiujrDqKNzBhQpJKL24O3BelmMPTPHLdAv0C1lhg1atiU77dfu8MVmdQfJzQ
         57m48BNn2jXULvdZDDXz+eP0VzUaZq7iZcdXc=
X-Received: by 2002:a17:902:d58d:b0:269:9719:fffd with SMTP id d9443c01a7336-290c9cf9775mr254082085ad.1.1761131230998;
        Wed, 22 Oct 2025 04:07:10 -0700 (PDT)
X-Received: by 2002:a17:902:d58d:b0:269:9719:fffd with SMTP id d9443c01a7336-290c9cf9775mr254081735ad.1.1761131230496;
        Wed, 22 Oct 2025 04:07:10 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm135964955ad.52.2025.10.22.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:07:10 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	richardcochran@gmail.com,
	nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	jiashengjiangcool@gmail.com,
	andrew@lunn.ch,
	viswanathiyyappan@gmail.com,
	vadim.fedorenko@linux.dev,
	wei.fang@nxp.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	cjubran@nvidia.com,
	dtatulea@nvidia.com,
	tariqt@nvidia.com
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
Subject: [PATCH v2 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
Date: Wed, 22 Oct 2025 10:51:26 +0000
Message-Id: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
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

v2:
- [PATCH 2/2]: remove blank line in ptp_vmw_init()

v1 link:
https://lore.kernel.org/lkml/20250821110323.974367-1-ajay.kaher@broadcom.com/

Ajay Kaher (2):
  ptp/ptp_vmw: Implement PTP clock adjustments ops
  ptp/ptp_vmw: load ptp_vmw driver by directly probing the device

 drivers/ptp/ptp_vmw.c | 109 +++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 22 deletions(-)

-- 
2.40.4


