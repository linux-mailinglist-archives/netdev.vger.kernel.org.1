Return-Path: <netdev+bounces-241850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2988C895EB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107FF3B1D85
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C732248F7C;
	Wed, 26 Nov 2025 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="y7AwWwa1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAE2741DF
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153977; cv=none; b=R4N/zO7csk3unrD4VvUFaPNgE5/YjmoCdPEsZNFgGzi2DdU5wSIBhtynYmsoQ3okFNvB2RkoSjLtGWYXVB1kwa5LH3N0/NXz+Wa+PblgrH4sGuISYt1eX43/9zQd0sqe2rQ884SCu+8deG6ll/oKXJMwA/BkZMQxFqxujj0Epdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153977; c=relaxed/simple;
	bh=CyfsR14nED7MvaWWZdVEZINFCeL7PqFzWD+KEi5SoY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQui+uAI2sokBaPrZxMpS/10U63adcQFCtFp+hTgHHrcl17W4WfJnuXGfEGTA4uoxLGEaj1qhuuDPxF6pI+WnBkQj8XcIfTHX/O9iCoTyzRkf+92P4ocx45jp1+eV3x6iDTNzYjYFzRu5aecyDySFnoTnu3KxcIbPOUJaUJloEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=y7AwWwa1; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a56a475e8so60582881fa.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1764153972; x=1764758772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujz+iQZ3aq/Eu2hONyHsL8Ecg6vhJZ81zHq90HSGIsI=;
        b=y7AwWwa1YlU7rC8pzhxaNlvhXbBVPqmiGKN9Xq67FElapdH2GVaUepQjamV1gV/pn9
         zy5BLzH7pxhc22B6seeeMqogqXEtGeEtUsz2XIrzFSqkGyuvQEJkWobXnTsu7kYnJEf4
         qIKOKQa+LZOuh4PlE8qYeyYyPqIndRrmdEk7RNsEB+iByPc66xyea9Sa3I2ZSrelpU2o
         c2ghNTkaifOIgHI4ESlNfUUF/EdtqU1gDBpC5lUMV/ixnGS6EHAGN18PkBlPbkdF0vk/
         bt1xAXvCuBFEqGg1XhkWhVUxWDIYRo0VGAHkEH0r+01puoDmQE7AP/9jUhpNo/NWhQPD
         i9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764153972; x=1764758772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujz+iQZ3aq/Eu2hONyHsL8Ecg6vhJZ81zHq90HSGIsI=;
        b=be6z5hfubXCd/RoWUBOEI8SkX92DsGMH2CIdfcakKr+TrophFuOIBWN3D88s47mCM7
         Vvi3VPJ7cQ5e1nOWVhvGEnAqCVLTU6G+JpvYR2a/Uh+6GxYje3rTmi2hqsd6XRCNVr3w
         w7LnWCvO372TVkDacL+g2XhCABea1vE4rD/bQJQvyC0S1+YQ11WbKTSuVKaCWdwq2JSR
         ggQ1XTZ2reUKwFVnZh2hFourukiPctaEGlE1BnCFyJDC4QHvmNYCIXY4KIFr7Luezw13
         BY3PRAQa0PJjBFf+729ANyvVA/W22kGfsnF5uFdfgECoxMbCZTaFdXINuQGNLx2mLmql
         gpeA==
X-Gm-Message-State: AOJu0Ywcq5En8Tpuv6nRGR5H7g+hjF3txme/xxeScdbccn1IEejZeaMA
	AZ8FqrbgdPP5Q27jzCUOdZs9e1quB11qz914BJ80j5JXp3IOc/wrUmvlfrPuh7b/7n6kdUhgUYA
	AFMryK/Hh
X-Gm-Gg: ASbGncvBV/+pnieP4B7K4RSaueXP0ik0kGmgy3BkICj1l/NQLq2wu3u1VgKaY+9QcYu
	KhncmxrFKbCu9YkdME1NQP7kJVU0D2Ld7puxtCj5ob4JMtTS+e4ViXixNIOWb5Oth16nEktHzaa
	fdyXf9RbL4f9osK7XSgH2wca3C6sE12/8cqJVPgGggGtltrazssm59fVHqnfq8R6ZR2em9IDCW2
	cn/i60H7rLzMvOlXdMIRaqZx/39qVCtlEwcpsZdkfGHq3jIPlsCYytBKf3Dz2UEC6Hp6BskFxeX
	7hDK0INaeEB5itMBb9zjPF0chnAeegM2vzCY+7ucf712kx0C2x11b2qX+fTRjw7qyfnSmNJmFRQ
	vEF2UhCbc/bF7Aw+D2OsgLTdxjyO9Pf3TEg6BKfZ+hDYFRBLKDhSH3ysG3Rlm/ssJyotTiRyH4k
	1qESa0nOXfrRkWfDGJhAyNKbnV4HrIC0iAhu0ltQ==
X-Google-Smtp-Source: AGHT+IHV4NJoDgpYQn/p/OIs9fXgEtrHCXvixk5XgByH3mJPfB4RceqYh5UKXpB1J5NvcM+BGdDNkA==
X-Received: by 2002:a2e:9215:0:b0:37b:9a1d:dee3 with SMTP id 38308e7fff4ca-37cd91a992fmr45052241fa.16.1764153972348;
        Wed, 26 Nov 2025 02:46:12 -0800 (PST)
Received: from localhost.localdomain ([5.8.36.109])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b59f01sm37275861fa.17.2025.11.26.02.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 02:46:11 -0800 (PST)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net-next] net: stmmac: fix rx limit check in stmmac_rx_zc()
Date: Wed, 26 Nov 2025 10:43:27 +0000
Message-Id: <20251126104327.175590-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra "count >= limit" check in stmmac_rx_zc() is redundant and
has no effect because the value of "count" doesn't change after the
while condition at this point.

However, it can change after "read_again:" label:

        while (count < limit) {
            ...

            if (count >= limit)
                break;
    read_again:
            ...
            /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
            if (likely(status & rx_not_ls)) {
                xsk_buff_free(buf->xdp);
                buf->xdp = NULL;
                dirty++;
                count++;
                goto read_again;
            }
            ...

This patch addresses the same issue previously resolved in stmmac_rx()
by commit fa02de9e7588 ("net: stmmac: fix rx budget limit check").
The fix is the same: move the check after the label to ensure that it
bounds the goto loop.

Detected using the static analysis tool - Svace.
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---

After creating the patch, I also found the previous attempt to fix this issue
from 2023, but I'm not sure what went wrong or why it wasn't applied:
https://lore.kernel.org/netdev/ZBRd2HyZdz52eXyz@nimitz/

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b90ecd3a55e..86e912471dea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5258,10 +5258,10 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			len = 0;
 		}
 
+read_again:
 		if (count >= limit)
 			break;
 
-read_again:
 		buf1_len = 0;
 		entry = next_entry;
 		buf = &rx_q->buf_pool[entry];
-- 
2.25.1


