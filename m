Return-Path: <netdev+bounces-271122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJcnMDuswmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:22:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 241EE317EBF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8D031EC473
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E04035C5;
	Tue, 24 Mar 2026 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUMJrE0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B64035C3
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365022; cv=none; b=bqVEJlhGok5kI1vtbIqQligk0X+0HBcdcqp030Y5hmWW4Lv8tdZiuZ8xCU2/56MtQ28WtNC/ydGwfQI6pKFEIkV7BdfglhPqqSfG95CR7H0WS7dQZyRRZWsFhzkYOJ7KKnttmgcp6T8EkZ9JHWyjg2naRcbZTQtYLyBGl19zaGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365022; c=relaxed/simple;
	bh=ib3wyEGlR79opNT1nABv1QanaqC88LZe0oi0bVeWURQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQxWSJCEUnu6zD+8Vlx0OuZfq7M+BYErFZDhuqaQZDnmakxp4lSbtSjHc881hS2PdCGF3QcpL9Vr7B9cZMfmzQwFWG2HvuendLT21FXcmsur/Wp/BGOEolihQIVoV1SR1OUFMpPsue8AdEjBQbukB/4kcxx0OnqlE5r95Sf2Dw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUMJrE0T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fd27754bso11569135e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774365019; x=1774969819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYbSq78G2exSO0aI2hMc0wmTNWOPJ7RmgrWGquTbdv4=;
        b=mUMJrE0Tx9fonfNMSp5PjNudmax9I23/aSfUELIBxZtdSdsB6X7w7VZc1JN2uqn0Mr
         CdOHTy1jta5K83t7aEUzDPFx2TXDE5eb1ljxssQ9WtbdfeyVjTCPbSKddUr0jLUuiKJk
         mhTSgh/GMpRrc9IlGx3zdxp5JCQ4TYEWJb48eG5fQysfOrhg95tEPUKhTEsfJf3IOiBv
         QpY2CKgr/Xl9E5Fqle6mUdREnhWQbukSjPUn/9ohK1f2Cnpm+I8ECCWcDpdV/1dwJiRb
         3g2dtt+IsCR4fKogJrK9mmRcHJjJGkV2zd8KAzU/rPCLK/bYj1Iy0N5KVlcA3Zs9pVT8
         nkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365019; x=1774969819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYbSq78G2exSO0aI2hMc0wmTNWOPJ7RmgrWGquTbdv4=;
        b=n2Lc2lwP3ba79WuuwvZ78LGMgSsspRzdB0l9DnBMmMcLTKiyNzhOXxKFMKhO8d4uHE
         hfsYV63y87lTpigPjZ/QI8y7tS9qR8I0bOGfgA9xpZjF8KsfooK5WeNd6NnqJFCkp9J0
         0K0+TeAf99OsKmoiOqi3wf0yuGdmAmRfbc1eUzWCm8eh2FhxMLXIZH1Im+iDy9G8R+rD
         oiWWdXd+189ZB4nqHA4jp0RBOTl8kr79HRUmhD14x765mZI8C6NgOqeEC7fyLgHDh2l2
         IgJ5djseY6X5oleO0kNdRuW9bPoqYyaWopO1xNNGQHQ9sa2Frvrh+BcsRPqR9Sy1tQ9o
         10Iw==
X-Gm-Message-State: AOJu0YxMAgWpq/1bzLFUsMD2rufv/+DFvGWLW8xBNCKgz4GRqUPhOBVB
	3RtpkBgDXaRotd4kW2jIYgrj66Ft1RwWIk747KG8+Qp9KcAjOJnqNVySUWTDj0NxLQ2ewue4Tb9
	+jZkqWA==
X-Gm-Gg: ATEYQzzxOFI2Z1pGWUooh+tEgUQ0CimbPXHVQp1DQdzioVfyWmu9409kqNUXMzyEFp3
	NzX8kEyLVssBrxklFr1iWN8154r6qxhOaEttYW79yawhzZixh8FhqxFn4vH41Sc3+JXaGSbloot
	q+Aj3hMMX8WPKbikyw18Q1jlka6vz+owlpV0UzLbo6pvulK2Dg/asKeH8zGke3/AXCb7Zcnydf3
	vMCYgvWkkyipRy/PSkxopOcxNFLnruXP4Z51Jbxzzp0NzkTuho2c9ZDfQO+Nqj8bPDdXSmZKQN7
	rk92U6SQtyc/fwwWRXRbb3/R1eqDv0pf73fSpaUseR0ff4hrVuE1gGRUPimvBupTYVELfc2QZ4n
	UdTWULB0YaB/M1xdx4fzb1FXJ8xz49JvjFzvA0OBbu8G/QYxkmTz7inJQagFBsSxotVGXHrwi+u
	CRjKBwFwceU8HThWgEH6LzUeBFV7krxK6WOfyipe0LpUeWOAbW/VuN2jGa8/POzRCchbWyzM+TY
	aKaR3IwmCCS5IKN69CWxFI=
X-Received: by 2002:a05:600c:3b12:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-4871606dc4fmr1519055e9.26.1774365019085;
        Tue, 24 Mar 2026 08:10:19 -0700 (PDT)
Received: from pickles.copeland.me.uk ([149.40.2.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116abe8esm60052425e9.4.2026.03.24.08.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:10:18 -0700 (PDT)
From: Ben Copeland <ben.copeland@linaro.org>
To: jiri@nvidia.com
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	Ben Copeland <ben.copeland@linaro.org>
Subject: Re: [PATCH net-next v4 13/15] net/mlx5: Add a shared devlink instance for PFs on same chip
Date: Tue, 24 Mar 2026 15:10:14 +0000
Message-ID: <20260324151014.860376-1-ben.copeland@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312100407.551173-14-jiri@resnulli.us>
References: <20260312100407.551173-14-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271122-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.copeland@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 241EE317EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jiri,

This breaks probe on AmpereOne systems where VPD has no serial number:

[    0.839394] mlx5_core 0000:01:00.0: probe_one:1952:(pid 10): mlx5_shd_init failed with error code -2
[    0.846302] mlx5_core 0000:01:00.0: probe with driver mlx5_core failed with error -2

Returning 0 instead of -ENOENT when no SN is found fixes it:

--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -33,7 +33,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
 		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
 						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
 		if (start < 0)
-			return -ENOENT;
+			return 0;
 	}

Thanks,
Ben

