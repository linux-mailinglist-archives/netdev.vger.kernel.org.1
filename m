Return-Path: <netdev+bounces-161906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC96A24890
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 12:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63CCF7A30FB
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984914AD38;
	Sat,  1 Feb 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6/3ElUK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14220318
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738409668; cv=none; b=Djr0ZrJJYcwZHjLglvGqaGdsBjYog+Z730lWBYzRf7e448SjjeNdA+GDWdBWQbhhBsO0IgBbmnz41dtBAhRazVQk4qWnCxs9EOSIjtVZnIoDgOHrv5YMVpBuUwD60BNmlVAc1TPfGI2OtxTmM9Aot4Viq48H8CitgYsXw4EoWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738409668; c=relaxed/simple;
	bh=RzRsDIhH7hgOhLgeQJyIbaJx2sH1SuLVBC9YcSS6Mn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IfKuDyijXgX1D+n7SxuWL4b6Y/NBw2sdipid9WQFHPI1+qR8UrAFpq8aMo6nShyiqL4PeQ44NPOPIQlqmJd0ivLTqeuUTys+NARF85NZ/EIznN5TnqGuZGuL2tDVpz6dYWrtDb3pCC6OfMyIIe6TmkDD9Df8kJX+oyIXLH0OLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6/3ElUK; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e181fb288so1617757a34.2
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 03:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738409666; x=1739014466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xTMuQRO/evTzf/IZeTCGlH4eG5HsRuLUAD3URYWiMQ=;
        b=d6/3ElUKAsGQScuqircf775WqnvtHoK74muwyCxXP5pzExzrUP0Q0L4UhcdhIXCRF5
         DwFZsTaJoHsZNHYyUMspC1GOH6fXnvGseyRP432MAaX1f1xm/oQmru3/udFnQxDyx34E
         /yvQIgda4Y7EK6ZjX0o07/r2v2nTOcnJ7Gh4rFPAgobCjM/76/P+DxQStJgkTlxpcfLq
         nRiBsKJe0K3tFOkRs3APIdc/9tAJHORTNCzpRB2x1xsKwEfKKH96gBPwIWz/QybA5zaV
         cuKe/PI1M64OIhK8vsPRxRaBKtauUjbDHac07ATRmwFJcCXqoidCLdmDsXD6wd19NlY+
         goQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738409666; x=1739014466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xTMuQRO/evTzf/IZeTCGlH4eG5HsRuLUAD3URYWiMQ=;
        b=e+Gsvz0qb/VjGf1/kZz/8k9A/wdz+fbVJdDidbvmjJwIB52AgGC8/cCvYrftq97lBW
         QTgCuvHeXFDQrWK2oDFOsVZbIHEyZV59jqoQKqBlKC7Cz34OXPFfzKAOGSSD1vPe4Kz3
         Fg/J4PbMyua7Gf/HOeDYxcfulztKO6kWxPUvMVEidjq0MM4s0BYzEQkOIYg90shldqVt
         UBbb+zhtuFbM0mMy2rkOSwc2dtEiQtIIS517Tv0VW17CkJuHgJHuEwVoiV6NWJV3pkV9
         1IbDiq76Gwd2ufNcMYKGckrz8MGzyzIYdugd7+mENeHikxrh3SevXbIFG91AQgvqochT
         3hcw==
X-Gm-Message-State: AOJu0Yw7zJ0kyBTMGxHLMTBjAE1fVlsm3HOpruGvYJ+RmjelXlFMkTiE
	hrSieBmYJwq2SNqtGkWQs64thUzfExFOMl7XXBy5jdiSJCUbHSU=
X-Gm-Gg: ASbGncsp+28EIzdCJOjZtbxNVcMsXRgPuaw3fOyMtjiKAnPd1Z+UKLyX+lJI7ku3Au4
	CYeooGTGk2/LsCZ0Jso5QVVe87VNxXqtla3uwRPSLAoRG1SAuX8CQDVigdi87EtevAQ75qcGoZ4
	9D7dtmAjXYWdMVTyvNlVNJlZSxu/fUkOhbUhfaWqkt+yQOV8BBLKhipEL6n4OYEEOR6FtEs0JQh
	0HQ5UjonQDE3i2SvXQpA5ema5mydLhtGqWcwBYsQmWo5bg/gNERToVrMAHn+/WnUYeJdgB+kNMh
	maO4eNdToXoQZRNmXg==
X-Google-Smtp-Source: AGHT+IFNFPww7cAo+JfUIaKHTj5XwNNGs2rMdlcG7rPYL3wgpqfF4aOgQz+ZsIr4nUzpNeCYf145OA==
X-Received: by 2002:a05:6830:90f:b0:71d:46e8:b30 with SMTP id 46e09a7af769-72656758bfamr9320419a34.1.1738409665779;
        Sat, 01 Feb 2025 03:34:25 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617eb5dasm1506634a34.34.2025.02.01.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 03:34:25 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>
Subject: [PATCH RFC net-next 3/3] vxlan: vxlan_rcv(): Update comment to inlucde ipv6
Date: Sat,  1 Feb 2025 19:34:22 +0800
Message-Id: <20250201113422.107849-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201113207.107798-1-znscnchen@gmail.com>
References: <20250201113207.107798-1-znscnchen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the comment to indicate that both ipv4/udp.c and ipv6/udp.c invoke
vxlan_rcv() to process packets.

Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5ef40ac816cc..8bdf91d1fdfe 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1684,7 +1684,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 	return err <= 1;
 }
 
-/* Callback from net/ipv4/udp.c to receive packets */
+/* Callback from net/ipv{4,6}/udp.c to receive packets */
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_vni_node *vninode = NULL;
-- 
2.39.2


