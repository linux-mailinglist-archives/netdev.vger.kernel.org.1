Return-Path: <netdev+bounces-194843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F10ACCE72
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7733A6F5D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4D2571D9;
	Tue,  3 Jun 2025 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPw5WHp1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F42566D7;
	Tue,  3 Jun 2025 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983758; cv=none; b=XoJ7sj9oRqjWZxlP4R3rirf86VfSifiplZdhM2QJv0DtW7STz14bBkDgw7g+YHDQVYqxFBp5KJgel2YF7Ow+4q8WjG7JSqvqF3HNSfTwhsT8tZBmq/5Px8ohsmJ7G813r6Tm6Dcu+bC+qNBwDi26ty+Xggs+0be7t0CI+06iPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983758; c=relaxed/simple;
	bh=MEpMRmHfbUf0z2aluN2/rCAnMZy6tF6+/xET0oFe8ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmC0g7C7Svzb3vYsg+FpPv5fyoGCSYUWMQyewebu7KEQ/flxOrljMRyuel5OwKCs+QQcWMNg6FtEhMhG9YMrgCjYf69JagrezRJh6H4sk5TpqsXRUEhAoDPD4ES2kIhT9ShqFySQPQQUjScj5u6VQuBHZhkH3HiJi5TJCqMwnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPw5WHp1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a366843fa6so3235798f8f.1;
        Tue, 03 Jun 2025 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983755; x=1749588555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk8Gsi4l437183PilLuaTkLSSJsiFmwPmRwiAB6KZT8=;
        b=VPw5WHp1w/BMGEMhevqvhE7ZDzlQLbsFHmhSp0JWgZtHtOzzj8TygVDOKIscvi1SDI
         OOBd2CisjYT4Gy5sfqegAXyx6PPt1RBEOfP32rT/GUAQmeudTQ4ELoqsmfcsXng85GUG
         0zklQ4St++eiMnWshQhETv0G5m9OSy9WLyqimDkRKcAvJETFMeVGlgLg91knY2FnaTAt
         Yu3ODvUUe/1WICX7nf3ByT0C1JpfM99dYDKJZJrShxQbbAyplm2QHXyYfcySUEpJds9/
         MdnNmVK6Oj9EIzllHyb9n2hn7xS+k5P/JQq8tzxAvsgWhHAkbQfQYTET0Zf+5AY4+OQ9
         Q+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983755; x=1749588555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lk8Gsi4l437183PilLuaTkLSSJsiFmwPmRwiAB6KZT8=;
        b=n3URfTbwSRxtmfie+wsXYGwCLSCabbjdfezCmwE5OPHYppi05FHwEBHZpGxjvVp/UE
         Yc2gTN2rysi5Fw7R/hE2zI3GK4UKNPBJOevgwHcx0NUtN7P0/FntUQLvqPL7vjYVgHAa
         NY59fMdqaVt57hfmFB4Lwu0g+zodJToZ51eDVGZU9CjE31qFPeh3imiQrOlG86c9Y9m/
         nLA//cf9hfyS64I7DSlGZXYAoUE0hnaalNuwq1sQYiWO1fVnO1RAKoxnLneoRbfc9tx/
         wX0g9DdCtt/j+7oGhTbvFvUw2hLlje7sTdSSW1fxz4OlGwjE2r0nXdIfJWQXSXoF+ak/
         jAOg==
X-Forwarded-Encrypted: i=1; AJvYcCU18RV1Q5r/ZhOAjtMQ8FSSGc8XgpnUoHWdcVxmGj2U7HHCH22kJZo+vjr9ewNFi5ItOG51afHT@vger.kernel.org, AJvYcCXIkgXmozptMcNdoneUQ8LhOXisIhF+XK+PlPb+eOmdI5d3rD0j9/wgLG7rtE/qbsMcQfdZnHEXC+AbF/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYp+ut4qvUT5CFj2JDOBCW2X4DRtO7XbGjk6cm876xpnTopAdR
	C606yCxV/Y151Crp+F9VVYNU7NLNc/3OtPlLPYZCffb5zfzTopfZ3YtZ
X-Gm-Gg: ASbGnct1E+ZmzXvJ8XJ03Vx6fTO1tOlMkHI7YSsSe4UmRovXpTyQi8/dnnnqn1KVEUk
	SfQrd8SZD18aEiCb7naXZlmyOztWnsIDYe2S5YSZx0WgTTSqaPPlzSGuHgVOPKvUVI9b17bjHHG
	c5kS1XvoEaLRZThVNExt9VayQIVeLqOUGixdFFZs8f5A6ISHRf1znuCsJ2s/jsXgLXP7Mm06jb3
	teCzhEsSjPyGvVtbkk7Ijo2BHDGYNZyqtiLlSDcx4q3ebvbPd6xA//Jces3Ls4/yn/1Lphcz4Wh
	rx/SCKdnK2rvh+0SHiaRUvRr8pI2HpUNQEqb8bvbBjijPLa8cG3ScaHcV7nxYBKQhANR+LmYEqG
	yn/3jBdYhvHU+kYp3x4UZC5ERq61oumGoCpStykMGD+URFwKoC7N/
X-Google-Smtp-Source: AGHT+IEAMALaVZQj5zk38pcjkcVnrX/m9ol2RvR0lla0OhPgN40/AYjwYiPCy7faYp9SGUmlW7StlA==
X-Received: by 2002:a05:6000:1a8a:b0:3a4:e8bc:5aa with SMTP id ffacd0b85a97d-3a51d8f698dmr201446f8f.11.1748983755431;
        Tue, 03 Jun 2025 13:49:15 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:14 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 09/10] net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
Date: Tue,  3 Jun 2025 22:48:57 +0200
Message-Id: <20250603204858.72402-10-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CPU port should be B53_CPU_PORT instead of B53_CPU_PORT_25 for
B53_PVLAN_PORT_MASK register.

Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

 v2: no changes.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d7148f0657563..a9b19451ffb30 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -542,6 +542,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port)
 	unsigned int i;
 	u16 pvlan;
 
+	/* BCM5325 CPU port is at 8 */
+	if ((is5325(dev) || is5365(dev)) && cpu_port == B53_CPU_PORT_25)
+		cpu_port = B53_CPU_PORT;
+
 	/* Enable the IMP port to be in the same VLAN as the other ports
 	 * on a per-port basis such that we only have Port i and IMP in
 	 * the same VLAN.
-- 
2.39.5


