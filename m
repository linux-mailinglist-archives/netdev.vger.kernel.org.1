Return-Path: <netdev+bounces-137472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604DD9A6984
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EA2284547
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522FC1F8EF8;
	Mon, 21 Oct 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNGss+1r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7F1F80B8;
	Mon, 21 Oct 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515764; cv=none; b=nO/IgvG1aQOqdG7o6FPxAb9dDL/b/LDWnswt+6MUrB62A2E4voJ0LI0z5x4aouKxCVLJ8B2onSYIPYIxbwsARa8iI08x0HzBIvTexRNGWDSI6LTZ/dI1bOlvpyM38JKBM3I+wBPULIiuZx0yLl2tBabdxFQGRfNliT0wyVuwe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515764; c=relaxed/simple;
	bh=0ujrSrrsk4eEz6QYJ+XA1EBRhjgv4z3AQ64pKfocAWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AImayr0AJcNIUfPu2vsiwEd6OdwQH144WdiaSnI3vfOWqrp1okVKZNBES/IYdub8A367wq0CMz9OKY0ubVR87H4BNmg+HzyYpqmawy49zp8nLTOR5rohBn08/bXtQ33t7DUQzlfa680msJiEAeK/t2BGRwwk+tzIP/wlg4nCVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNGss+1r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d5689eea8so2984729f8f.1;
        Mon, 21 Oct 2024 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515760; x=1730120560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfnoFTnTvSIM1scMxITWklvMR7Mwt4ccSZX9oAqnsCk=;
        b=BNGss+1rGIP2roeyO1PNItkZYpsaD37ShDo7VuHMhRjFfb2XXuXsdQpEU4DN/wy0hv
         UtoFPLPU+3YNNWzz+5n4r5RneGrgR5Z7ffa4FQjytVGDvt/OyyEvUWeRXZ85KBlMxG/R
         VzgSURYYNo8r0dXVEgYfSjDkJnsxMR4G8ghB7zqHEjq/BKfm7nuv3KLvsYmktMvt5ZEh
         fx1NqyqDnAX3AHZnrflTKAC856kda4h9A3PXjXR9PXyF4Qi0waUnTpZa78bnDEHnMZix
         R48bxyOw96pN4hsK+wj1/KAFonTYcPSoDrReSqrE4MTw2KzkftIl9OKNTlHorqoHuDP6
         0BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515760; x=1730120560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfnoFTnTvSIM1scMxITWklvMR7Mwt4ccSZX9oAqnsCk=;
        b=tpbAIuCftlvWEVIzjhPvkOJ8Y7HOACeiEFzXIZD0osFh9UG0CkkHtMCuVUPpUAJg0D
         rCfW3G+cCUfsU52DymwYua8nVgWQDKU+9YmAepiVEO8cKISBIjvODACGnyHHhKJrOp6m
         LOguAuVgStUilsKsUjl38Yu76s81y4hFY5f1sXG2p/ZS9mQLYuP2KQ0UiPTdLtNm4Z/U
         lidiRqXLkOpVMNlOLqsEY6Q5EYbjUssjQ5DihSxj26kdtPow1tATaSDGGK465K0lNrQJ
         nv3AqMgDZODALbbzJUFOVHlrx3SWvJJwYk98luFrPPkkLu+WjE92sxUK6Jb1TluswN/k
         9p8A==
X-Forwarded-Encrypted: i=1; AJvYcCURhmjn5kgwmbglDn78JLGTQKhUhzkXXNgEI9xvHsdcUnQVgNRRyS2cIys86nXHpVJ/XBmayvbf9CI6@vger.kernel.org, AJvYcCVJvtEw8Ow1MfgkSAPx/gCK0WnTxyh6Uua3T/1VxjtoC4RVjdG1PxyiNquQKtRa+OdXKAAMHYzA5ff8rXmB@vger.kernel.org, AJvYcCWOb9K2fx4VxY/cchJTC8g70ocpXND2okCmyoacszltBaHeiUR6FhcUIsU1paEmaL4fMs9fMjf9@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRSZj4n9RvBabH2qp67Xuw6r0CY5YNRkpzGDFqZQwZR7XGoC4
	ii73Yl6rZWVa+gw2IgVIL740B/ayIJqXFfAEJOz0bLp8udhkbpzG1nQuxw==
X-Google-Smtp-Source: AGHT+IGB42B4JCPKbsU6DhqCcHXmAdx8avXYx3w3bO1ep1Vh+9tpxQ/1zXAJPC8GmiQYGfm7GeIHiw==
X-Received: by 2002:adf:f781:0:b0:37d:46a8:ad4e with SMTP id ffacd0b85a97d-37eab6da681mr7028762f8f.15.1729515759989;
        Mon, 21 Oct 2024 06:02:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcfdsm4295329f8f.103.2024.10.21.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 1/4] net: mdio: implement mdio_mutex_nested guard() variant
Date: Mon, 21 Oct 2024 15:01:56 +0200
Message-ID: <20241021130209.15660-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021130209.15660-1-ansuelsmth@gmail.com>
References: <20241021130209.15660-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement mdio_mutex_nested guard() variant.

guard() comes from the cleanup.h API that defines handy class to
handle the lifecycle of a critical section.

Several drivers use of the mutex_lock_nested()/mutex_unlock() function
call pair hence it is sensible to provide a variant of the generic
guard(mutex), guard(mdio_mutex_nested) so that drivers can be better
supported with the call variant "mutex_lock_nested(..., MDIO_MUTEX_NESTED)"

Example usage:

guard(mutex_lock_nested)(&bus->mdio_lock)
scoped_guard(mutex_lock_nested, &bus->mdio_lock) { ... }

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/mdio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index efeca5bd7600..3f0691dee46a 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -8,6 +8,7 @@
 
 #include <uapi/linux/mdio.h>
 #include <linux/bitfield.h>
+#include <linux/mutex.h>
 #include <linux/mod_devicetable.h>
 
 struct gpio_desc;
@@ -25,6 +26,9 @@ enum mdio_mutex_lock_class {
 	MDIO_MUTEX_NESTED,
 };
 
+DEFINE_GUARD(mdio_mutex_nested, struct mutex *,
+	     mutex_lock_nested(_T, MDIO_MUTEX_NESTED), mutex_unlock(_T))
+
 struct mdio_device {
 	struct device dev;
 
-- 
2.45.2


