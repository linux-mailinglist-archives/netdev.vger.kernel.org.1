Return-Path: <netdev+bounces-279125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P2EDzkx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1BD413E9B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC1DA307A516
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A134B1A6;
	Thu, 16 Apr 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRMgHX8R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6D349B0D
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365847; cv=none; b=lOD1UwrrcQTbTvO+5hM7zQdFFwjSj9KpzRqSr62ONtEHga2Hihjb62PSIqF+cduCMnuqnk+FDTQ9nyVCQiiN1f35ddVoHnXbKhTLTxq/grskrXXnklTRaoB9nHwSs9vnzg4yDp0fDlaiPPo5IhrNBYMR9XVpXHkW6UbyiSO6O+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365847; c=relaxed/simple;
	bh=Ew0xXpehQz7Go7vQ6dIvOdiSol/5CKHYJVj2Y82Gw5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLLD7F0hZ4PBY6BZwvyIlYhVrTlnXcuVUkGzJW3CKaTNdOKJc0gJWU6QMYon4Y0a5UU8GkBsH9wehLvJHKuxRxwhlEU4I5Dy2SNm/J0gJAOFmlv24Z2BU8ra7rHevXyrVc77ZHNkdHPPMlvc6+BLnWz4jcIFaZz0xnkEVb5/0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRMgHX8R; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7dbdcb85067so6998673a34.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365845; x=1776970645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcG/sXIQptFMlSqk7ATax3dU8Pu1lA/HCdBKrg9gnPg=;
        b=hRMgHX8RmQ9v+dj8UruOe7ezdrVnYyqIBvZMHQIcr2OXCLxsgiuAzWMiEiem4iEqtg
         Fhp8dFVIpJRA+uE22ffB7J74IrD9gpr4oRMIFfoNYVIQ/hyxT4XXy3RGK9onI4EuRiUE
         38B0bZWpEEAwW7FBkXQmZg6cXjNPehE0Udt8D+ghXBwHeBlMOxfIIJSNAo+wQbPWB0gh
         ktGzqmdzht6FkcY19XpNaZUD7bvGjrJhZQtU0L8nerobuqSDj7HOFDCUbvEFVHMZxOf0
         QTG+TeBDCyD8ajBUPKjRYnoInWgAUHX2z8f6mpB/nama3pdiuy9lH5MF9aWBVNDt1emI
         vX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365845; x=1776970645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcG/sXIQptFMlSqk7ATax3dU8Pu1lA/HCdBKrg9gnPg=;
        b=U8C/sZJIl/YoYGDg0oqCtKo1RfBe2tn80yO9RdUXUanW+Sl/DYurqaozDzUXGbQniD
         g4ScLtRmdfWMPZs1lTMMIrf7LptDJLX8i5i0/XxnrMfIHOK7PSUxTwjvO8qyqX6qIBG9
         oDjnxDLDc2QgxUoy/N/0M8Y+GsRjKz7s/CfaP2SHFolOWGXCAJ+dIpnbLoxGMDOXwgFv
         MTSvb089aN4XOqj3BzI1OSOMFgSM6ulMq8idORELcpcaCeh6xEZorvk1VSJggHAJXgAr
         91oN1ytvX6AR296PKakeK9YOlifHXEQ9Vz+buCNyQoGeO+ta9LtouZH7v4zXFp4BNaKF
         VX1Q==
X-Gm-Message-State: AOJu0Yy+xytzL80eQSZWOgrExeAhqwOjv0Ra2NzLVHshYp5eItsAikGG
	D6a+GN4BzzNkrtxrlCnaWrsGRdWYqxP5Ob/vej5xVu5HwqUSKXz83W+8m16f/Ahs
X-Gm-Gg: AeBDieuPU3FcFcxX6J/wnX4rKn/qc+MbGUhyPMaJVTuTloREuCa07W3X8cYktpGXM1d
	l/IEgJeF+6gZd/vRCZoOrs09QfdMSKnMY9I6rooVvSpxq8K3f7xbYQ1LKN9xj4uF8uiZpW5Zzvt
	nhNgN2uwCbcGyagRY75qDDuULx3ReP8kD2DTRRC9X6hUs7ufubmqFxv8RzVGdJU2yTXHq8ZRLfZ
	ovhoxG9iJwcuhPEyX2I5QbPy0FZ9pvNxYAZh2DknY1v2wbiv4RUB1mWHaEt+fP08sauYhsAJzHk
	ziz0521Y7Lkzjq1We0ArZsr/lh0YzLrCm0Gcyjlb8NB525D9+Bh6VT13P9kpnsB1yRcRiqIjZjc
	Lfnw/JNYWAPnOEpUfut3WPplvtjmxj3b4sOCr3nttH6sTm6G3dOT1Rc2L/II6Ii+xzlP/IBcDlw
	Twr++JZQLFqBTv4t2YmkfFBPHXAPQW
X-Received: by 2002:a05:6830:3143:b0:7dc:3db6:ee1 with SMTP id 46e09a7af769-7dc9271a310mr323773a34.27.1776365844751;
        Thu, 16 Apr 2026 11:57:24 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc90a7d777sm534466a34.12.2026.04.16.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:24 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v8 11/15] dummy: convert to ndo_set_rx_mode_async
Date: Thu, 16 Apr 2026 11:57:08 -0700
Message-ID: <20260416185712.2155425-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279125-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:mid,fomichev.me:email,intel.com:email]
X-Rspamd-Queue-Id: 9D1BD413E9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d6bdad4baadd..f8a4eb365c3d 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,7 +47,9 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_set_rx_mode_async	= set_multicast_list,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
-- 
2.52.0


