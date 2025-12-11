Return-Path: <netdev+bounces-244364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E80CB5805
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D39302BA89
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB952FFDC2;
	Thu, 11 Dec 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2JsjMNs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB63002B5
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765448381; cv=none; b=fPdunP6nim8luP3lciL8U/1ylSR8wuRvac/2q8KX6RxJwLXaynI3uCHtop8UzR2qVtrDRzflG7HpyBdIQixYr9VgMc5HeprizSx2NsFKHyk5OxqVF4/8vU0OQ6NHVAvzp1wtrnGHuTs4l7i8/xT9IW0+g9eXCdWRNLuhjs23YbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765448381; c=relaxed/simple;
	bh=2De4h1EvQ9PAGUZJo8VyzNdU/n79s+aks2CEPDXhKMA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rJUc203PwZKQH9YdeJUdtb7BtuXt8Fjea4N0VfUPHAvC9eNij4wmjF1+NGHUNNgPU5PAn2Yb/yK6Hl2u52s1bAmDv8u983peQFIX2MmT2/flNLY4XN5xz8SVLc0AXhfkQN2WnMXqGMq1kuAdaN1cVwLszJ1IPQrObWpD/Gq6LNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2JsjMNs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bf493d248baso1431663a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765448376; x=1766053176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+jHhxdvBq8eCZT3ysFIAELCk1258bcdcN+/mojgVUE=;
        b=p2JsjMNs0Q8Lo4CEGdsJ8815717Jbax7i5zdCKFMBSvDTUT3XXoRuwXTZlntAe+qy3
         DAcOxCaHNiX6+QvRi+vjKMozYCfkuxA5o8JeHhdriz7PE5OqQDHrqOR9rqh+j+B7q8mF
         hQGbIrnblvwIFLTVelYPehsrJhqIEmaXg7sqQfY2yBjyZs/owm07JPnHdmSp+6+Q5PlR
         AenV9EC21iQdtqbLqFAjjFyjekJ1twF2D1gsv73srlahVylIfNGEJQDo6KQX0SCSdkXR
         DBtFw2YKJdyEbLNReow8/dTLwjuVHYMZ1qnfuKvL5Scin32oFp5APv/IKmqvNQuRjp80
         lbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765448376; x=1766053176;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+jHhxdvBq8eCZT3ysFIAELCk1258bcdcN+/mojgVUE=;
        b=D8FWU2Ln5fTgLJ8gWGJpI6bVtbRqDMar9xqUdYRbdvSvsb3zYN4Nz450mcrL+01FrR
         8armL89NUbIHX+9shV/HQIDDgV8S62A14vaWTHU/bkZ70JJSMwrfBMejR4+oT6uZXkMT
         zSYDnvZ3+ZF+4bDCIfgH8kkKmHTlzmCWV2tWnRlu4QqSZ0sfWOeLX4BvuOwNnNRr1zGl
         iQDjW/fnNFZGhftWAcIidKw/c+TLYbeChrijAUgK/3l8UkKZaiXH6+kJW6XVxvZYLTGS
         Cjn1Mjpf9flsyzS6l+J9Et72eMqATq24tMvmZ8NcU2lnJFdFL4T7LBKeYDo5gAlOC9DX
         H5/Q==
X-Gm-Message-State: AOJu0YziK742oyb1pj/5YZE/lk2fmwZ9Hkff4BUbDPfVNiFIkH6fCHAN
	DqCHNHW9sOUH2aR85bW1Ffd91yx9jSpH4CW5KMGW4epR6kKItJ2rT7SbHRsUXeYsiTt17W+CSW3
	S2TPcdBO3Bfogt6KV1+e+HyD9pe1zgbmOgxczC1QNun00gjI2PRWwGiBTPqnQyDrJt3x9MqQK+Y
	pHJW8f8Sw5+ujI4i50Thgwi6Y1CUzw3WlFIJSHPxyuIKGoG739kXm6lHFmFy4Ng8I=
X-Google-Smtp-Source: AGHT+IFiswqXvWXe8hZfJsXbQvgoiKk1nQLxrSGrBb4XVpZ93PMZSPnSs98Cf6Nfhq+HUwPEj/jEXs15x1wpEidaPA==
X-Received: from dysb44.prod.google.com ([2002:a05:7300:8b2c:b0:2a4:536d:bffb])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:608a:b0:2ab:f56e:bea6 with SMTP id 5a478bee46e88-2ac055a0933mr4821559eec.39.1765448376075;
 Thu, 11 Dec 2025 02:19:36 -0800 (PST)
Date: Thu, 11 Dec 2025 10:19:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251211101931.2788437-1-almasrymina@google.com>
Subject: [PATCH net v1] idpf: read lower clock bits inside the time sandwich
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, lrizzo@google.com, namangulati@google.com, 
	willemb@google.com, intel-wired-lan@lists.osuosl.org, milena.olech@intel.com, 
	jacob.e.keller@intel.com, Shachar Raindel <shacharr@google.com>
Content-Type: text/plain; charset="UTF-8"

PCIe reads need to be done inside the time sandwich because PCIe
writes may get buffered in the PCIe fabric and posted to the device
after the _postts completes. Doing the PCIe read inside the time
sandwich guarantees that the write gets flushed before the _postts
timestamp is taken.

Cc: lrizzo@google.com
Cc: namangulati@google.com
Cc: willemb@google.com
Cc: intel-wired-lan@lists.osuosl.org
Cc: milena.olech@intel.com
Cc: jacob.e.keller@intel.com

Fixes: 5cb8805d2366 ("idpf: negotiate PTP capabilities and get PTP clock")
Suggested-by: Shachar Raindel <shacharr@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 3e1052d070cf..0a8b50350b86 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -108,11 +108,11 @@ static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
 	ptp_read_system_prets(sts);
 
 	idpf_ptp_enable_shtime(adapter);
+	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
 
 	/* Read the system timestamp post PHC read */
 	ptp_read_system_postts(sts);
 
-	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
 	hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
 
 	spin_unlock(&ptp->read_dev_clk_lock);

base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7
-- 
2.52.0.223.gf5cc29aaa4-goog


