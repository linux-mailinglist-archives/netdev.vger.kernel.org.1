Return-Path: <netdev+bounces-134417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64D9994C0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 23:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF61C22EA6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3B1E231B;
	Thu, 10 Oct 2024 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGfV+uR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E219CD1D;
	Thu, 10 Oct 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597276; cv=none; b=c+aDgiEE9kVh4lZl4DSu1dsiZyOeC2m8atANhc2om+6yR/sMQCkhVOIjQ0pWLYG0eMGT05hHW1qbd79fSKoI38khl555kw3KYGxxdartjQvckclgYd5eSG2NwBEC511lKvcKvE6k5/WLpugsNfXVSG02O7HwpytqV75TDlz8gVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597276; c=relaxed/simple;
	bh=YxxwULN3jsVL2YDiLyYMuOtvbkrMujTfd0dCdsQRtE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUXJ+5lkmhvjfHJ0fLArHHn9tFajT2grMMH+87cQ09pIql/5oGUnJ766hwnNAftcCYdfygcLrwmQ6+I68l02JvnCfJXySEUMAcNEdfpeLx9UKjumInsloPU8NwIU8fdGwqmYavbKDcfVAx1h5htN0/UeQEJOH1erDRTyXq6l+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGfV+uR7; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6e232e260c2so13583127b3.0;
        Thu, 10 Oct 2024 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728597274; x=1729202074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM0QJYJDC1/d9edGNpZLBo9wu9FFQhHsu7p6s59BFkA=;
        b=RGfV+uR7XhiyduS0w3/TGUcu0ALsPUFE7JrwI/G1WqgfeIJ5C3Dq1zEMt8D8rCm8VD
         btHJJBrvvkpIEBSig5jqIdNZ9VKG/A+PNWmFaF9hLTF5jeGLwYjfG2Kms5e6+TtxqF4E
         v3GsBHfn03BlSFGFH0jld3GDDfrhoFXVKzqMhA213WXLhQWxbAbp0fHmuXJgRUpNwRul
         xLraLvI0OZGiXc3YRKtxqxs/xuZXYR1ekR7y1J/TUPBp3UuUQXOpl3gfjdp9/mvg+dlq
         RWgLHoWkD+loW8/Vc8he6Rt9PPTpzoQCV7K+NVYFJfPmFd9by0cga+DksqQ1kOhlyvqj
         i4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728597274; x=1729202074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM0QJYJDC1/d9edGNpZLBo9wu9FFQhHsu7p6s59BFkA=;
        b=e6fm+VOV/OnRXqLp40zvycgrj8JHe2BQTi/CwzA2Xvph31DnI5g8kxL+qeH0iw6EhG
         hkdzfCmxZLRMmusniv/DgJWjhU2p4QgWL7Eoc3jLHJwGZkA4uTTC/v7Ko269R+WS6dvL
         POe/aqnYHuEkLd9Ka+DoWaKzdud5CVR951MXZNOty2QM4s+KYch/avRLGsZ6JGS8Mt+q
         vRfjO5Rko2cq0V8+lm2KUdanIk/dzEo6Zh+NoiK8E/XAiOvpXcyF4fu/1dXUooHCtBw0
         JgukA+XofNnc1iZY4m3MhtM2NsXzqKr7snuiCBM4DpBWqzscVyNexzAWDWkYlmFXFKAx
         o4lg==
X-Forwarded-Encrypted: i=1; AJvYcCUScn2qE1qv8hVwLSHupG4Pfht1dbS5I0PBSXO0OCxGJbylfwAnk71rdcfKiVwKNCKSF1+2bUjx@vger.kernel.org, AJvYcCWKgyIHScs8xcLGXUFRZFftL8oAy1kDs8qCPuKg2dxkYXC4SYHVfMsW4M3/oydP1LIjQz7BkBra21JC+vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyqk8n6fL9LG7JB5/d0yJWhTtinfXwf4fDgCUP4heZw9gVS+uu
	7HRlAXGkoXHVdvH7lcVumbKVSlRFx37+OL22JsRbh07dHT7cbWK66Ngkn6paPbM=
X-Google-Smtp-Source: AGHT+IHObHEo2XXWXYgzR8WvXVZ11p40KQnn86xOIy9bHgxt/Qqgxc/u+Jf/Nhzi7CINHsCw1TM+iw==
X-Received: by 2002:a05:690c:2b92:b0:6e3:39b6:5370 with SMTP id 00721157ae682-6e347a00c7bmr2914587b3.24.1728597273945;
        Thu, 10 Oct 2024 14:54:33 -0700 (PDT)
Received: from dove-Linux.. ([2601:586:8301:5150:3908:7240:1fb2:350f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b89c7csm3656987b3.36.2024.10.10.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:54:33 -0700 (PDT)
From: Iulian Gilca <igilca1980@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: igilca@outlook.com,
	Iulian Gilca <igilca1980@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: net: Add option for random mac address
Date: Thu, 10 Oct 2024 17:54:17 -0400
Message-ID: <20241010215417.332801-1-igilca1980@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3287d9dd-94c2-45a8-b1e7-e4f895b75754@lunn.ch>
References: <3287d9dd-94c2-45a8-b1e7-e4f895b75754@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedded devices that don't have a fixed mac address may want
to use this property. For example dsa switch ports may use this property in
order avoid setting this from user space. Sometimes, in case of DSA switch
ports is desirable to use a random mac address rather than using the 
conduit interface mac address.

example device tree config :

	....
	netswitch: swdev@5f {
		compatible = "microchip,ksz9897";
		...
		ports {
			port@0 {
				reg = <0>;
				label = "eth0";
				random-address;
			}
			...
		}
	}

	...

This way the switch ports that have the "random-address" property 
will use a random mac address rather than the conduit mac address.

PS. Sorry for the previous malformed patch

Signed-off-by: Iulian Gilca <igilca1980@gmail.com>
---
 net/core/of_net.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248..8a1fc8a4e87f 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -142,6 +142,11 @@ int of_get_mac_address(struct device_node *np, u8 *addr)
 	if (!ret)
 		return 0;
 
+	if (of_find_property(np, "random-address", NULL)) {
+		eth_random_addr(addr);
+		return 0;
+	}
+
 	return of_get_mac_address_nvmem(np, addr);
 }
 EXPORT_SYMBOL(of_get_mac_address);
-- 
2.43.0


