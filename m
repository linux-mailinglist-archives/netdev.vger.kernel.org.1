Return-Path: <netdev+bounces-196848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9931AD6B0B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D343AAAAB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696623643F;
	Thu, 12 Jun 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zkoi2uAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA0231A51;
	Thu, 12 Jun 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717485; cv=none; b=D0i2v/0WFy8VcZOWsVcrElLjOia2oSEmp6gh0PVEhIMo1/CHhpDq1oUkrOCtmPyhQoqCE3C15LuW/SCrK6QAY0z4iH0YG1SoxW17xpFwK9S5UenvjnK96Ft9U/S49XwikuFLFcGA/svCgdNb4RWP2iFh0I/0xM3obEqf1jVeDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717485; c=relaxed/simple;
	bh=zg+59sq5JrM1iZpeU3fLMf1TIaG4fqrubLIAQkPukLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0CIQ33vK9vjZm9l/ntVdbiAKhqf68zIpVEPp1SxSPatIlU6Wow3RvwaIz64nwQoSPUA29UV7a3OmFyW6Gw38SVIVVWu3X1Ogbfm1e6V7vF3BByTPLluB4P4xAvoir2WI5ivQZwLl4AZypqJolRyDhtimyIIOLmOP0EOYhMNkc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zkoi2uAo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so4996605e9.0;
        Thu, 12 Jun 2025 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717482; x=1750322282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omJJLvAMaBfP3FeeT/uE4GuAA6QHfdygJUFvpjEt87w=;
        b=Zkoi2uAoDHLdG4rlQv/KEFtnMoI73MIGn8UVjNPd5GusNj6XLSz26KuEvQm9XWclOe
         llcHO/3z/mmGLGmiRpQd6JViG++Ws/ZTtqWaKE+6uvxLLD8YEeZ18LXm1Vxy7StWrhQ7
         jE0G/ZtExsDOFnSb+W6r/QMplTbKC0pmZoRq787jlI7AGBOwI84pWDik4Lh05KY4j9B4
         XenGibnr4AGQf2Ocdas/1QZOF5qITlJxmpFL+CogzkoCETy4AKsVYPniAMlh8VLFn5FD
         3EEDLcCXRju33QahSVY4jYm5FBT5hmavuU5cZsh4OyDMZmp/62Uc5vmwFGGrkQNAgxfw
         1Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717482; x=1750322282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omJJLvAMaBfP3FeeT/uE4GuAA6QHfdygJUFvpjEt87w=;
        b=gJd95WtNgfBtQ5t2e9adtGN26COYUdHzWCm0NCnNIf0aFM3XEMR0B2OFBhwIy15VLm
         BMb93QDnzHjKEQ+CxOwgM27nbVG4C37JXsfgAZfsnTaKEQMQq7R+08YhLDunz7CzDElv
         OPDT1ojrTFRex308D2gXonLv19baJtFpNauUCuHSbC4GyB0QIdom1VLozIpEtE96hALQ
         C8URcgFfQOOauP7bLqymczF0aLpTXD3l9gvK9fuBjrW6ITWgjCVUOj7DVfo1iBURt6vu
         c1myItcsZJC+y2ldurX5j3GCqVeDqv40ryTuY2kuNJIUAfAJggOzz6RNE+wssLFpV9BG
         HZJg==
X-Forwarded-Encrypted: i=1; AJvYcCVXqJTmsutrIs72e5OfcLMTLT/+XtaooUbHqqGY3tslqVgAFY6SZ8B+IsXaPXr4Xr0l/LekqPTBOsco5/8=@vger.kernel.org, AJvYcCWtVjezuz/O+IkIbw+UpGJdMFyhFp2Et4LUkj1H6Ns3bh+iILmuOHj68XssbEFzzxbo1NvtIPBb@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPQbaco5qMJ2vjm3I19DrfGdlKKKHl62LeAW1JlchIkYwZeD2
	kAhK5aVoe7lLr5HP/7Az/rrAde6aApwK3FYfEsUZH2y7Zz5SdaQRnOHT
X-Gm-Gg: ASbGnct6PXEcfs7xiV1pmroIU7+h+eopadC+yafCbkuUuuaMKAJ74nWTynCvhCl005p
	cqkIfHzgosPs1JdU1PWlHrZPwcApZJkwn1uRpZONcABJns+V6aI7icVH1RZJ9UzXgnkOatixmzf
	1Ulv0l6o3ipZ7kvS7OFCiaIju390hlq6GmlY2EwaISdhXk1k8uK+MykyAY6ojPU0VgrKI0J7T+n
	2SkcHDzURVTG+3QEBTjPqv7JWp9X4YicIXPPt0HZSabz9rmkCXvkkKbl18/WjqB5GVIJF3A/8yT
	HxS07m1+o6LExjlj43MbnRludDMtMhGYxNqwata6V6dRi5hvoE8gx72Qn0/U2ooN3vdseZlWsUE
	FxEEG62TF/wpYH0uwtd1R6Qbr/+x/SnI6kXs+Yprvx22HR0IwiGmlm8KOiEKH3mxzSjc5kt3fQm
	btgw==
X-Google-Smtp-Source: AGHT+IFyBM4TmXlFNWlUaBSvTo8QyAIeMsVmvOe3CPdW+3KliwiDkG3WIklKpdI8FqC6MNU+uMskjw==
X-Received: by 2002:a05:600c:818c:b0:441:a715:664a with SMTP id 5b1f17b1804b1-453248c0ad6mr49114335e9.20.1749717482127;
        Thu, 12 Jun 2025 01:38:02 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:38:01 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 09/14] net: dsa: b53: prevent DIS_LEARNING access on BCM5325
Date: Thu, 12 Jun 2025 10:37:42 +0200
Message-Id: <20250612083747.26531-10-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement DIS_LEARNING register so we should avoid reading
or writing it.

Fixes: f9b3827ee66c ("net: dsa: b53: Support setting learning on port")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

 v3: no changes

 v2: add changes proposed by Vladimir:
  - Disallow BR_LEARNING on b53_br_flags_pre() for BCM5325.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index f898ec1a842fe..1ecadcd84a283 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -593,6 +593,9 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
 {
 	u16 reg;
 
+	if (is5325(dev))
+		return;
+
 	b53_read16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, &reg);
 	if (learning)
 		reg &= ~BIT(port);
@@ -2247,7 +2250,13 @@ int b53_br_flags_pre(struct dsa_switch *ds, int port,
 		     struct switchdev_brport_flags flags,
 		     struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~(BR_FLOOD | BR_MCAST_FLOOD | BR_LEARNING))
+	struct b53_device *dev = ds->priv;
+	unsigned long mask = (BR_FLOOD | BR_MCAST_FLOOD);
+
+	if (!is5325(dev))
+		mask |= BR_LEARNING;
+
+	if (flags.mask & ~mask)
 		return -EINVAL;
 
 	return 0;
-- 
2.39.5


