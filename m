Return-Path: <netdev+bounces-152118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 260D29F2C0B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC947A2A4A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64E1FFC41;
	Mon, 16 Dec 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHTz31hz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE791CB51B
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338229; cv=none; b=IQ3oN3lw3WgZeo12Jw7aSXLEqHoedm7xa6TNYI2NOv0gsMypo+0VhYqIQwVX/tk5O7K/XWeEd+ayUsKCCyYm4q1I3W35/VW7BI5vpGeuARACltwyFYX8FnvrjqDXM7vHIvkLNieQpcoKyU+qzQSMfisFMPuM8y2F4HcnDrBRRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338229; c=relaxed/simple;
	bh=dtVWKlkbhPkFNpfftBtq15xbnTnw+4JX29ve0YxSxY0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vD27p6ApWb5AY8qrLQoaoT2dho1/oJHlAaiLypfnoi1YVkyGORpTsJdJ/LXmNbrLrCfz4v8t/omZUDoSS2Gl0DsOm96gcTaAGiOOa75eHihWyqxHpWR+1XF7dgdYlvm3PppiQpUo9goN2hBGfXGmkJhwDnU/EPT4tuAzTS9m8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHTz31hz; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d8f0b1023bso43748616d6.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 00:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734338226; x=1734943026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZVLUko23C4TFbn681BzNmzT441se9W69wg074YvkRqk=;
        b=yHTz31hzhRsAJdw2lN3ulVXVpHR5DYzJS+UQvgdLHrLBl8fklRURY7Re3eaLl9gwAa
         12KypIXxSOV7+tndqHc+o2ZUsNYUQZIyKO9TDBr/7q/5iKXXkNOg8eoiyzSi0xD1+gNC
         A8f+2KbVHJkqHZX6UH2c7YIpqalbA2+z4rAEmc3fEISen+mqHeH3VK0JK4BRAjqRvj7n
         cV+wyIAZwrWEai1y5X717imbkM/KhC8nDXkfmVEXtwL36NLl0Nl0W03f//M6abQ+1Ekw
         lIkgSJyLcAO+E3nldsK/sm2RodB5AkoZmYDu4ypsC0bSerq7BIFfHCOtFPmbWQgb8oGK
         EJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338226; x=1734943026;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVLUko23C4TFbn681BzNmzT441se9W69wg074YvkRqk=;
        b=YsAlrbwn81MGIyXxie4lrKGUJxAVtfh++Co/u/5rdoiVT7l8rjRiUyxvDk0/ewlw19
         cGXCWMbmlQrNJXRH6rJKdjRV2v+3uV/0tcCNU+xXqGNm9ORYaRh79B1Sav8/ew34h6j0
         +IALAISDtQbf7mGwZIysenXW1Uht0qpkflDiqA11qKZHnl4atkhkuxdh+D8PVdF1O6SY
         NHhuNCYMycKhWSln8ObbzgqlUoGhbImmz2/WWOngLqVanQO01B+G/hsIEACv+nlVa2x3
         I1aUQW9WxsWsPt3ujT706aYyxl3wt3A3t+Mq03L15crP6BvlLG4vABM2LadCdhTMnjyE
         DcKg==
X-Gm-Message-State: AOJu0YzZX0el1wahvtbHyczNGgi70ONLZfdHCgHz1S0CMB+NXyfssTXl
	0oqXik+fL2KbYKJ9fZH8vm2ZHLhiXslxhl/2pjYNlr/16tW+GgXxsCgW8l8Q4+/AlQlUy8JdxkD
	dXbXUYC/eyA==
X-Google-Smtp-Source: AGHT+IGBmF8HeJX/kpYS+xHvxoqZEV98UqYj6VJLPYT3j8kJ9wbrRcNQA/K4heccRfRjPFA/YWBmNIlqpWdMKg==
X-Received: from qvrk2.prod.google.com ([2002:a05:6214:1022:b0:6d9:122d:a689])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:ac1:b0:6d8:9815:92e2 with SMTP id 6a1803df08f44-6dc8ca5a4e5mr232872586d6.15.1734338226382;
 Mon, 16 Dec 2024 00:37:06 -0800 (PST)
Date: Mon, 16 Dec 2024 08:37:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216083703.1859921-1-edumazet@google.com>
Subject: [PATCH net] net: netdevsim: fix nsim_pp_hold_write()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

nsim_pp_hold_write() has two problems:

1) It may return with rtnl held, as found by syzbot.

2) Its return value does not propagate an error if any.

Fixes: 1580cbcbfe77 ("net: netdevsim: add some fake page pool use")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/netdevsim/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0be47fed4efc5664c436c91669de5d7c13ef3411..e068a9761c094e91c584d0b29a46166ec31f42d5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -635,10 +635,10 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 		page_pool_put_full_page(ns->page->pp, ns->page, false);
 		ns->page = NULL;
 	}
-	rtnl_unlock();
 
 exit:
-	return count;
+	rtnl_unlock();
+	return ret;
 }
 
 static const struct file_operations nsim_pp_hold_fops = {
-- 
2.47.1.613.gc27f4b7a9f-goog


