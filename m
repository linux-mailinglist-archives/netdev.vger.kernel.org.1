Return-Path: <netdev+bounces-242082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E76D1C8C21B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D5334E76A4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015233ADB2;
	Wed, 26 Nov 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bQxUHX9e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C1340A57
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194264; cv=none; b=IPL7Pn4xl221FUaHqCgfptdc1GZV9BONL01e4AqEzpS8aA3Q5yC0tR+vf5sfM09LmpabZU/WN22WeJ0Wx1YhAJVzo+NfAbip76r20xAdHEC9NZApq0cX3S4nOlBsso6lw6MCitp5XU93NmLAY/5XK9IYTAwq52oPlpID/taeeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194264; c=relaxed/simple;
	bh=YZjPjO8S3kj+h6cw3ah9tts8ojgv/ji/IGKi9eD1kEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efWEwsxw+bTvUdydbM8mnFCDZl9Rknh8wVMIk9AgVpaf1s/pUT1dA8UwvhRFlfJUlykJC9zAd77pbdAvFh3yuTj7tbMVPbFQo98eV+vRAQgEGIYdYoOvMQ+3BLIP8DF20TZ0Z21AZ8nkOJREea9PAN/cFkvU12+1WJSvhyK0LeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bQxUHX9e; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-43476cba770so1383895ab.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194262; x=1764799062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyTEnuVrwK5TlKsOUEygeaova9g/2Dm1go+KhLgo/OA=;
        b=cuPFDap4QLbpHcY4cKsYw3FD3uAfRTLXyy/3Hj7XPriSjUSTRGlWomJ5HqEo0YZcAV
         Vu4BOHsDLxYBjrP7yHAOPEBARIFMEwBZT0nA+sXNaNIEBXHwzFnkvy+dMzVbxKe1FgoI
         xwt/5M34ckIAbMOwWG9aC+A3SqPQCL0YUR41XCpaca3+oZVUC5XFdoPtWAEcoZ8ClzPj
         63TaJgc/EULQQWUNVovQdcvQuvTD3+pgxxQ3wrW9Zo1ixYqqdyu3l7ihB6KUQqRDZqJZ
         QkLPsJkpvPHQiJcUXTlZT/6zkGm909vaJn2vPIsbjc6gjEv5eXmjskWpKdNYJVfoGxm4
         24rg==
X-Gm-Message-State: AOJu0YzDzx99fZW8AIRuquhrBIqM97LYqgrPtR9pDgzENmusEl9a/yH3
	ngTLm7zqFgkWzbgLJIzocyewRDuoViEPHcOYAiGyQfm0ddtvm2VP4SHtld/di2gd1fr2xFjaWU6
	BSWmJAwjvlwxhBE1I9deotQhvjRyJek18awiliBe4DVomaOSUf0i15T9hdaAE6lW98XElJgskc5
	7FYMpVNHAujTNb4R45xxG2qqmLm0+yB0M8ItYHvfbruAEfffWJrtq1pMfiPKoP337rlSyw8W851
	lu401NtF+E=
X-Gm-Gg: ASbGnctAe+enotB+t/HJ9M6OZQOJn7Rc1rUX2gzHI8a+vXODlPedUMgYpLK9TeaVWui
	htvR+NbeRzQllxFN+QrhaNwLKUJVf0Z5dUOUGn0wuNBRmxJbqGvikdvw5xHRjoHHynuESQ1kDas
	OeEzPo7f5J9ZMvDB5F7+JcUCoJ2ipNtPh2VYyNK+DD1lZ57Cr6dOYCpjbvcWouzL+O1ch3akSWD
	m6pvyJ7TMerRtst/9BZjwEHaMw5rYu37FXY+n5OXf0lguoKoaOFLsj5spo7WdIUZmPfF7aFJseR
	tczK5pEUFqVK7dDGVL5HDjj468iPeIriSdwJmJ/h0a/kAEpRddhI7prlHoMI6EGQdOFkvilPPWl
	APdn/vjmfWcWv06RaqupwI5J0LeE8Q94UsL/PCYk8A7oKTQRBNkuXgD0Zlh8R5igOQICZKS7SrQ
	CFlYTwib1wn1oSeBYDFNCpScisWar0XnRC8iP27qlblIXR
X-Google-Smtp-Source: AGHT+IGgvN8NBz6SfQ9l9aOkrGq7GkZpOHcZHxHCZ+BqyNDKZhQUV8/BMVx1BY7sCfi6DjidRUu1UAoOVfVA
X-Received: by 2002:a05:6e02:3e89:b0:433:8109:3eec with SMTP id e9e14a558f8ab-435b90608c1mr218030775ab.8.1764194261919;
        Wed, 26 Nov 2025 13:57:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-435a905e86dsm18273085ab.14.2025.11.26.13.57.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:57:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b24b811fb1so47686585a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764194260; x=1764799060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyTEnuVrwK5TlKsOUEygeaova9g/2Dm1go+KhLgo/OA=;
        b=bQxUHX9erBYq3MBG+AQP1Q7grOBgAu1d0pHP74V1KTZGQYJ+S8fp7R5F46zC0u2fp2
         9lrvWwIWWWfkqpYXCALCuOUJu8Z0wDnkJiT0gr3XvMgxbt5QmeFUA9tiqP7r5CdZjNGG
         Wq9KH8/CZFFPnZTTtL5FMSB0ItjLd0UpR2fOI=
X-Received: by 2002:a05:620a:2a03:b0:828:faae:b444 with SMTP id af79cd13be357-8b32ad1083bmr3280623985a.20.1764194260495;
        Wed, 26 Nov 2025 13:57:40 -0800 (PST)
X-Received: by 2002:a05:620a:2a03:b0:828:faae:b444 with SMTP id af79cd13be357-8b32ad1083bmr3280620585a.20.1764194260082;
        Wed, 26 Nov 2025 13:57:40 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm1473933185a.37.2025.11.26.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:57:39 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Gautam R A <gautam-r.a@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 2/7] bnxt_en: Enhance log message in bnxt_get_module_status()
Date: Wed, 26 Nov 2025 13:56:43 -0800
Message-ID: <20251126215648.1885936-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251126215648.1885936-1-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Gautam R A <gautam-r.a@broadcom.com>

Rturn early with -EOPNOTSUPP and an extack message if the PHY type is
BaseT since module status is not available for BaseT.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Gautam R A <gautam-r.a@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index baac639f9c94..efb9bf20e66b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4623,6 +4623,11 @@ static int bnxt_get_module_status(struct bnxt *bp, struct netlink_ext_ack *extac
 	    PORT_PHY_QCFG_RESP_MODULE_STATUS_WARNINGMSG)
 		return 0;
 
+	if (bp->link_info.phy_type == PORT_PHY_QCFG_RESP_PHY_TYPE_BASET ||
+	    bp->link_info.phy_type == PORT_PHY_QCFG_RESP_PHY_TYPE_BASETE){
+		NL_SET_ERR_MSG_MOD(extack, "Operation not supported as PHY type is Base-T");
+		return -EOPNOTSUPP;
+	}
 	switch (bp->link_info.module_status) {
 	case PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN:
 		NL_SET_ERR_MSG_MOD(extack, "Transceiver module is powering down");
-- 
2.51.0


