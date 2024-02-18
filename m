Return-Path: <netdev+bounces-72740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6ED859779
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 15:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64B4B20FDE
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC054E1BE;
	Sun, 18 Feb 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enio0REF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD416BB4F
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708267801; cv=none; b=uwCNKdB7HV+xgTS9dBVaVlRkx8uMVWBCEZxnZI8yqm0YYkAxjiI+bqzyNzmHi9rBmnp/JeVLwqp78ZlV+MkPGzMqaljtnhrwvLFyQFM5ljVA7TtmG311m6oMZnBkngMUdcc9VSeLf2JyDC6cOhoEnETIiiUNZ4mpd/p3pAu81dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708267801; c=relaxed/simple;
	bh=WLMYSGCpNp8/zg1BKSTK26sVHAKfc1DHDv5mlGNzDr8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Tb6MdocGDqWyagq1eZtpl8HPNU3BTOTcZRSeyDN0ya6tGeA2xlRCQGADrVmIuuXhHsfk+8J8qv6/wskJ5c2RtJQwaF6R+XcVTSVl44O6vny04eJw4RyyrjbTgIY5q5mztkfj4iBGVzduQj27lJsiFPmHEIzwHaHZ02Q4pgUel20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Enio0REF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d2710f3acso911834f8f.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708267798; x=1708872598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxyQHeWnX0zSiQNiHF6ERyJOy4oM2y+3qaCkp17mERo=;
        b=Enio0REFF1smsFdesGYPl9MtJuQSj0tht8nH7CPtGnIa+cikHixx9ryinUZnRQgpVv
         m5cNAct7i9KtYBrFvBzQnV+zMOmaeNEEV57MWZGBswiKbcrzB61Y+ZMSawaqhONHZn0t
         mZiADYJvDaMHgoa1BXJm7FJBAsktmTFYh5KTQM7V0v8bV6TkhlaPoxq0i63CaCIf+mgx
         U1UZ20Ib91F0a5bhJI5Q33qDKa8Dqw52m0jNwM9ZBj+Uv3n1FFCboJlWHoFSqZkiuZmK
         eW8r6nJh619CHtSMa0MVvH8CimUc8D9fjm5gUvM20ztdAlKdld7424V7XICyWPR6TDA3
         hgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708267798; x=1708872598;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxyQHeWnX0zSiQNiHF6ERyJOy4oM2y+3qaCkp17mERo=;
        b=fcTyohALw6niJ3wa8hJu5ZtqzVS1T8c5FaAJOYTlikhlpuHo88KURzGxzfCqNPaqwx
         kctydTTCWrHUvExPJF//ui1SnoeCSc5UbNFhymNnU60exloi7nQnPUMUVLMms6R2lAck
         n0uPyoYnsZ+q/r+4L0Pqp8vgyf4yMCrYWnuGr28iNdO1LBK1ShuNB9drLijdzQQkd2DL
         X8vaMoRIbhUenFi2vK1Glic5v1DsQozFYUZdry/JHcWZUU4a6m6zMPejlnBQrobb62ok
         gcvwAlqtuZvmk8WbKR/JaKXX2M8Ya4zfK9t4Zc1CXYjmGZP+/AUOI4QMIKh157eNdtuA
         U3uQ==
X-Gm-Message-State: AOJu0Ywd0xZ7agRbIrvl363hEwR2v9cw4FDEvJjnL/1Vu8/wEuQcyXN/
	O8b3ljczpgX2f4TIhtuoy9Xz7vgfJyP1/aWRzUuIYhKZlX09oHvd
X-Google-Smtp-Source: AGHT+IF6YzW6GKCJbuf13xEl9tqFfqd38kIGt/N9vx/teAtpuqf3o8jLt2tT/SnmvAgsLIKdkU3x5Q==
X-Received: by 2002:a5d:448b:0:b0:33d:2872:2437 with SMTP id j11-20020a5d448b000000b0033d28722437mr3129012wrq.31.1708267797762;
        Sun, 18 Feb 2024 06:49:57 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9e5:d800:2cda:54d5:8742:3de1? (dynamic-2a01-0c23-b9e5-d800-2cda-54d5-8742-3de1.c23.pool.telefonica.de. [2a01:c23:b9e5:d800:2cda:54d5:8742:3de1])
        by smtp.googlemail.com with ESMTPSA id b17-20020a05600010d100b0033ce1ef4e7asm7544120wrx.13.2024.02.18.06.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 06:49:57 -0800 (PST)
Message-ID: <59bd00bf-7263-43d9-a438-c2930bfdb91c@gmail.com>
Date: Sun, 18 Feb 2024 15:49:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] tg3: copy only needed fields from userspace-provided
 EEE data
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The current code overwrites fields in tp->eee with unchecked data from
edata, e.g. the bitmap with supported modes. ethtool properly returns
the received data from get_eee() call, but we have no guarantee that
other users of the ioctl set_eee() interface behave properly too.
Therefore copy only fields which are actually needed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 51685cd29..7a07c5216 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -14200,7 +14200,9 @@ static int tg3_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 		return -EINVAL;
 	}
 
-	tp->eee = *edata;
+	tp->eee.eee_enabled = edata->eee_enabled;
+	tp->eee.tx_lpi_enabled = edata->tx_lpi_enabled;
+	tp->eee.tx_lpi_timer = edata->tx_lpi_timer;
 
 	tp->phy_flags |= TG3_PHYFLG_USER_CONFIGURED;
 	tg3_warn_mgmt_link_flap(tp);
-- 
2.43.2


