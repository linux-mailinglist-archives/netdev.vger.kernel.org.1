Return-Path: <netdev+bounces-189282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5629AB175D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61479A0584A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE7A21C177;
	Fri,  9 May 2025 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="X3HDCPsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96221B9D6
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800868; cv=none; b=oI4jO0BPXfNIIdaz4Y6PiLX/lSRJNGxBgjp3jwBjVuwGrxkUWE4C1UrrWhBTdM38MWpgE5pdZiFAvP3OVRGuIkrdPRtRaQVIVjDa9XcdDh3YLebpMYKLY0C7wNJlh+OiQ7aRzsPv1ofisYPDAzuziqJQOUljpydK2AcrvLoeW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800868; c=relaxed/simple;
	bh=iqUbRb8f7HP2kARWAeSygZ4/bVOjQyagvWbIoVfvADw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvdquiP5C2mufpGSo2zwyJGorXkq39+tYLOKn1HTR5e6rNLnkdB3Po93fL6ZPm8vjDfLbwsEfInC52Nzbcj7Ok1CRX/KMYAPw8DSeFcwyssQYtypE/ycEN+tK+5Qb0R3GFDRqhakiCO5IuQv56lOT4mZNMW3427VCVnR5K0xQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=X3HDCPsK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf257158fso14561005e9.2
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800864; x=1747405664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuUFnkTkAmIMC556LaqyK23CqoJ/98pRDS259XMrELk=;
        b=X3HDCPsKOlAGZAdgy0faaJXyYmVdWjKSrlE3KtiVS1Ff2zoyZC9kRmVTvu/M5Y7Mu0
         zy5ExURhuE5mwI3skvzRMTzng5HTOYpPlgXzV0ZpCzYoVcpPlmxSyMbROGoBUO7+EpRy
         w3HzmxisBPqhNxvRDYsuyumxUYZ49Lh+pKU1Gbed4E4oisWrcewePS0+trJK3BLRfmUl
         dv+UH+iybhV7Pe5069z/pFNyWCS3QWfuSI40E7t5xRSN1w7W+sj6rvwpDT6wN+nT3qLZ
         kZEzZ4ODfsAzt0EEmRrqHqaCUd8/dHw4gxj6++jvb/t5VgJ7Q5TKj5fZUpe6gmj5fhLi
         UzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800864; x=1747405664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuUFnkTkAmIMC556LaqyK23CqoJ/98pRDS259XMrELk=;
        b=XsdzMdjpNCiXuU4uU2ennpvO+m/wBdrSI+LWNbJjF4szkE38ibHp9KOKLs766IQ+mx
         4AMUrFu02YVEI33rZhZ9mYL3Q/ZRzBeJ//zCiU4dI3wt5i4p3JM8O4AHoDeB2uS5Pxh8
         75KQFTo8jRYulujyIEX4ZvXaKhmk/qrK1OIxjkNQLdOnHljnURFWsqni6QdizwAw4Wz/
         4aRaSxbCGTVGbGkut9WsUXmeV3wsivEIA4inYaXUcTGotsmxtl+UYaLCj0P93Gbgv6tF
         OaRvkRwJ0rms/OSKaVumnXPdTo+VJnQw0km0AWH1k3aJtk+eWQRX5bgEIZeiNDnolK4g
         zM3w==
X-Gm-Message-State: AOJu0YzCIPqWbJOnCo/E+GpctXb7Af7cqaC7e3eysSw5wrUm0+yPzAms
	Jso3uQ9IvSV1yW15WAxp6gAjAg0nj3c5Ci0fWeJ44gjhsj9c4coV+vC7SqMKScf4slEfyBaxawU
	gqcBR/Al3XlZtWDNkMKj4YeF/tw3P21jHpOK4K/Wjs2VrfNXkq1KwkOldQ7Mb
X-Gm-Gg: ASbGncsLR2gQb7WRR1olzDW86FuzKljlKy+UjFZOS2ezXoGkChUf44OOkj4nDioBpxa
	eBxy+LnG+wB72XK8mCOnDNejq3hMDkl7RyEQAVTVWppwcXFOgp+WNYZUZic2Z4e+kQQ+PcH1FXX
	ZfFx5VBF3k+Sv8hFa5B4bT1NqYbwbstrObrRBBmZCLJfET4HyLuS1jJuLpeWTr/2eh66KD5gTgm
	k8fsC+5fSclf4rTOVHNG9Nh4wT6TBFvTaV2NAtIe99BvbojXMxepkNsmPtILh+Q0KLrOTx1eGq6
	bcjwcvw2CCOUniTMsoMyAurIDJqdmCHvPHcvwYaNb3pfvuqvYXQw6ekT5CVzITY=
X-Google-Smtp-Source: AGHT+IFHSKGyn75J9rKnEWiE2Je6lxuCg+ROsgbt/HUQDKvjMHEyYSdeXcfCiWUIdeLHHlGInarG5A==
X-Received: by 2002:a05:600c:528a:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-442d6d6b6ecmr30357695e9.18.1746800864005;
        Fri, 09 May 2025 07:27:44 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:43 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	Gert Doering <gert@greenie.muc.de>
Subject: [PATCH net-next 06/10] ovpn: fix ndo_start_xmit return value on error
Date: Fri,  9 May 2025 16:26:16 +0200
Message-ID: <20250509142630.6947-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ndo_start_xmit is basically expected to always return NETDEV_TX_OK.
However, in case of error, it was currently returning NET_XMIT_DROP,
which is not a valid netdev_tx_t return value, leading to
misinterpretation.

Change ndo_start_xmit to always return NETDEV_TX_OK to signal back
to the caller that the packet was handled (even if dropped).

Effects of this bug can be seen when sending IPv6 packets having
no peer to forward them to:

  $ ip netns exec ovpn-server oping -c20 fd00:abcd:220:201::1
  PING fd00:abcd:220:201::1 (fd00:abcd:220:201::1) 56 bytes of data.00:abcd:220:201 :1
  ping_send failed: No buffer space available
  ping_sendto: No buffer space available
  ping_send failed: No buffer space available
  ping_sendto: No buffer space available
  ...

Fixes: c2d950c4672a ("ovpn: add basic interface creation/destruction/management routines")
Reported-by: Gert Doering <gert@greenie.muc.de>
Tested-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Gert Doering <gert@greenie.muc.de>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 7e4b89484c9d..43f428ac112e 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -410,7 +410,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
 	kfree_skb_list(skb);
-	return NET_XMIT_DROP;
+	return NETDEV_TX_OK;
 }
 
 /**
-- 
2.49.0


