Return-Path: <netdev+bounces-241212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543BCC81900
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556673AD786
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00D3191A9;
	Mon, 24 Nov 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dHtONt92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D6317706
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001760; cv=none; b=QTMvWHH7Itt4LHqhhBlqwqOfSlU0Ycpd19mgPhJOsp/ooTFCmApSztVCNN/DQ3+YrCLBE8w0iwlhFnrgqeB/7fg/huTZPL7gK0f2fDq2KQpbir+clwewpYqtWrxMwNvoKcRkQcdARMsJ8zeKMaJzTJ+5j5MzIz7my7WRmDxDN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001760; c=relaxed/simple;
	bh=vTSKYdEKalEEC0tYawisXPYcDqtHT/RCHD4qS7kEMbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jds5UYy+Vz2lslzrCewORJAOajuLFh022iRPlt8sSrh4sz3SMfnYAyQ7Qd+dwJiWWwwRXyNtoMjDPIZctMxXaNilXO0vRl09UHf5WoRsuTCGX+4W3H8X0mwVuK6A0fqhtbAXL5iQYNXUV7IkENaVjV+FJlFJEQtzCmFFo0cavxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dHtONt92; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324054so670216366b.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001757; x=1764606557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=dHtONt92wzI3JXRmoAYIHucF9RvpwaRgs6jQ+dMQovp/jhzuO786iecmO3sw4DASQE
         JemWWuTGp0cjG/o5KBjuYe5O2jdURXXI5hezo3uKlVTUaK8ATYM8rNptqlTceqYXinFb
         /smHU/0gAX50kUsniVa7WSp3+02JdKVAyKjj9TwNCnquGQLYlnW3rwX2fKDHCe/YPOAY
         ZVJUyEMY5v0LtlsQcoWEM/+8wopdXcrzJGYYcc19OyiqKdPloPFeDG1oWZggls1Ng0w7
         hB11vBaYzQ+HwK5mDw9GYY57WXPRhfjYFNYkFdVI9eOhA6KKMT+kh7nGHejKft8d29DS
         QSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001757; x=1764606557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=KFMmvBAirQwymZ2rA+hP8WEDKgZuQpPPqnNFO4fXKpUPEjXbV7e5rBuYNL8pAL8iCX
         KjI9Rks4+eLgjKCOX+exl3c2cERKhYC7AZub9UZwk2vnTeRcfq8KfuYT7w+VoCPdDsWa
         L79Fec/nQGtaq+HaPM5j+iHAvWrnmcRvtyhxONyk4ko0AmqEwRlYjBhcNeUwoYnVY3DA
         zaL5bBrODdebalVZWZiAO7GMSh4YQVDhq1yfxKDdMf9x9RPN3dHbwWm96Y6tbGIyyBqN
         PG2+TmbUixpjT6x0TzD86uakW5LilYt/vrfrFKU7Y4oST3Kna9PvJp4bFyBkTUPzpM78
         qa7g==
X-Gm-Message-State: AOJu0Yx7DfePD/25uY/mQJoimoVE/01GO2QgYkuCpFhA7jBwWNAfI+Nd
	vlw/IGYfgczGIxL3dSg9HOmdIIIWSlV1HHL2ly8T8xO8Ps219+8InVmdWE5TGpvksro=
X-Gm-Gg: ASbGncs9/IlG7IxWjqJ/U/aOk9PWy2QoOOcc2Oa0gCdru1MulguwrEeoBMrSDx8Tdlf
	L4Jdl3nuiMzcLcqwXBP2zOX0U9xLijIKQ860z3n3ui5lBogA4BaOoxKBa4yS8+yWJvQocq9EUD2
	+aS4UaDGPoY1UELRVcGJ9cO44WLPzcfzfN+6bmO8LgQMP+wzdVtpuA95D7DsRLCnSj5vOGoOOoR
	hOtknByi6bTqzTCxphn8+sr1j9CBfX7oV4F8eteBkjemcG3NQJb1ezeMl3LiDM6cSFbHMwDV+jO
	Sx0FOPI0z1jN0FNNPVYJOQR7Bj4CgHJkRV5qGrE8kG1HuOT21LEwFEFUuaxS0xNyrnkV1X9otCs
	tVqjlthked9N7eeJAsTeYFsiT4Q0Df04UCRMQrPTER2y/Gi7Pa1CVzyNllOu77VhvCId3xMV9uW
	F8aPG7cZjd9tpkNLHyFui8Y5rc9RJsdSb53XhlSkYJaqHvck6Br62SeqJJ
X-Google-Smtp-Source: AGHT+IFjSlYcMZ90WNlywxV4QME6/MJnlcnxBFfR0BbSYGWFmqHRg2YN/iBVBTy8/WuLIIhuoT9sQg==
X-Received: by 2002:a17:907:7ea8:b0:b73:78f3:15b3 with SMTP id a640c23a62f3a-b767184c07fmr1253974566b.47.1764001757284;
        Mon, 24 Nov 2025 08:29:17 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd5bfsm1354364366b.9.2025.11.24.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:16 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:42 +0100
Subject: [PATCH RFC bpf-next 06/15] net/mlx5e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-6-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..20c983c3ce62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
 	skb_put_data(skb, xdp->data_meta, totallen);
 
 	if (metalen) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	return skb;

-- 
2.43.0


