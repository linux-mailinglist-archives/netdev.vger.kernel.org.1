Return-Path: <netdev+bounces-161104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C89A1D667
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D5E164D75
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E21FF1BD;
	Mon, 27 Jan 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSLjNTZw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB861FECDF
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983636; cv=none; b=ZEVbOyZ+BwnDgQaI6KfSUgqR0PrxKC+tvF+Nj10w/JwhNAR+G9EiJHTFqUPwWcskSH2QrHUFZISTz3BZezbgTJlD6/GjDrRGkzkNDcV0U3oZINJ4ueepj7xanJ8EnK2OnUm4QPm4S8otwVZABl/peN4Ku/6mE2wt76iR4CtEgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983636; c=relaxed/simple;
	bh=UG1uWB9PPsdJVySf4XB80nqQdIhk5TQ8Trsvg6yxuvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cdoM6BJkbijJxI8n+/E6z+wfIro7ABeMVL1JRgZw7okgnAVc+mJB8PMcqo8379h2bU4OjRlrZ49yGg3UXmmdoJxZ7YQb86m+dCpWQtqpBfvUzjVx2Nm086kLMAwq0QH3112Bh+beEgqUw4bcKpC2+lRuqYx+mMxyCsEgrl4iszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSLjNTZw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737983632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fcUM4E5/zqehZHkTb/+XMPrTsEhKyeNv3Vdv9RdTApE=;
	b=PSLjNTZw2wDC2whzo5r8R4XdzbUtuXTze4J/u8SPcfWsoWtrpl8Kva8XWYkejsZhmMiCmT
	23FemoPyDCVIac/rmMmo0idsAFCPsFzARroHpr+JM1KLGkQJNtZCTEbQnV45cyDwYIB9Kt
	t+gfHhrG/sPEFxqIM4hVdyqLoIf8mio=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-0WxOoOAsMjq61uIsLBi4nQ-1; Mon, 27 Jan 2025 08:13:51 -0500
X-MC-Unique: 0WxOoOAsMjq61uIsLBi4nQ-1
X-Mimecast-MFC-AGG-ID: 0WxOoOAsMjq61uIsLBi4nQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aaf5ca740aeso391283266b.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 05:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737983630; x=1738588430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcUM4E5/zqehZHkTb/+XMPrTsEhKyeNv3Vdv9RdTApE=;
        b=hFIgcWaGSJJo/BuPoOs+sAraAK2J23fOVz9rqxc0tPoWgYWtqsSe0c1nlbxincvaAa
         ORTmiIowyQdLokpS62VrzNTMtYRDXFRUKDXfR7r772wcmSMaarmei8mGvMJUBJNwDRRk
         5rHF3RRBcy1M5b92rSUs1Rs+yCj4DoTFv0JQyC23n1V1ZDoVAjUtv9NyT2a0lT6C9a52
         dZawOSPMWd6W7T064Jf1F7QhFKZ/si8AnyvtyrZi8Fc24SDkme3pj12ygJ50RLs5cGjm
         HpMiHIu2VRzpLGdm6YVlX8YKfiMNCMNHjjuKxXG6TuwdXP3/4wwgdm3SZGnu08oSOQKc
         knMA==
X-Forwarded-Encrypted: i=1; AJvYcCV5r3Bob3l1UF2Vp4FoBDt/N53m0dwDMqX1bgw4S1koWS3Q2/HxshH0Yt9T0n7ApRC8kf+cgM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGVg0OcZNnUhQpmpbhLZJ9pxhAObjCu1q4Y8WJqgQaMnoKGLk
	S6t8luUdwaPPOxXZsMXQ05n3XoExN7PrBhqix6T5VBRCnnnIX58jUGrlCtb9jnWAurH8PdfADyS
	fCSGZ7wXD8F2woQ7kp48MQgozsHqbTGa/xMNVfTTTKRxOS/c5l2wWwg==
X-Gm-Gg: ASbGncuToPVznYec3rZATEiHmGShXrIzGteot9aUANX9oCnM8ku3kqEbjdXFWL9OYjU
	Xdv18TI419CiZCp0MqmSKMsqT42KNbHAKqF7FWSu6yR4rn+SgQWj9urjT3TJpRZ8YHkof/jccoD
	DEj0m0ROveqkhanCeEkf0ze67/si+88hYuSvr0XATlnKqTamgCy6Qrg6vZS0lRUMmvmBWc8j8U0
	hwLa2pkbOU0+f1Y41UcTnQ52PJ6D+GvAdoSe4loHEuTH6eDJwjsmavy3KyaD/0C1ZX3G/xNX3hO
	PVy05Bv3i9xk++SucgT/wDXHLWMyCQ==
X-Received: by 2002:a17:906:4e95:b0:ab3:9fda:8de6 with SMTP id a640c23a62f3a-ab39fda9d0fmr2873613766b.53.1737983630021;
        Mon, 27 Jan 2025 05:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVolCeZJHuXjqdhHG/qXr2B3y0CAjTQR5vG/mpSIuxPZT28Ss3xWkda9FoT57ev6ADNksOrA==
X-Received: by 2002:a17:906:4e95:b0:ab3:9fda:8de6 with SMTP id a640c23a62f3a-ab39fda9d0fmr2873610066b.53.1737983629669;
        Mon, 27 Jan 2025 05:13:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69051b1ddsm357596366b.180.2025.01.27.05.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:13:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 05397180AEB5; Mon, 27 Jan 2025 14:13:47 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 1/2] net: xdp: Disallow attaching device-bound programs in generic mode
Date: Mon, 27 Jan 2025 14:13:42 +0100
Message-ID: <20250127131344.238147-1-toke@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Device-bound programs are used to support RX metadata kfuncs. These
kfuncs are driver-specific and rely on the driver context to read the
metadata. This means they can't work in generic XDP mode. However, there
is no check to disallow such programs from being attached in generic
mode, in which case the metadata kfuncs will be called in an invalid
context, leading to crashes.

Fix this by adding a check to disallow attaching device-bound programs
in generic mode.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Closes: https://lore.kernel.org/r/dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de
Tested-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index afa2282f2604..c1fa68264989 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9924,6 +9924,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			NL_SET_ERR_MSG(extack, "Program bound to different device");
 			return -EINVAL;
 		}
+		if (bpf_prog_is_dev_bound(new_prog->aux) && mode == XDP_MODE_SKB) {
+			NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
+			return -EINVAL;
+		}
 		if (new_prog->expected_attach_type == BPF_XDP_DEVMAP) {
 			NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
 			return -EINVAL;
-- 
2.48.1


