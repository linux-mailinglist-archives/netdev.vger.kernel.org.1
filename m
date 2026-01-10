Return-Path: <netdev+bounces-248746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F067BD0DDDF
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE539307A54C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278562C326B;
	Sat, 10 Jan 2026 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b89wQ7Nd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE14A0C
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079139; cv=none; b=mhyJAQ/zF9l8UZZPUmbv9JK4mnl6nBz7053clo15awts3F5uQ+6hcw6Kod9aaIGsBMXgzXDp2x2T6+4mX2qLdv6DTHVdkstwCd2ZH6QQp8Nkf5O8IU4bIkCsq8PD/f0Mmio/ni97QO2UjE9z0dFlB7cEVBJlXl3YoZ7/Cu21YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079139; c=relaxed/simple;
	bh=YYFkbgvHW4ptRZ3yNdkkSZwpQMcaeTni1eEXsRHp1lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTTxmUSolDDBLrCK29LhtsdUzoasT6jCuUi/uvZpUFQaMpJYDi8P7n+/4CxbcXBJMlHlqJgyg3srfuhlFjCLZiRpaIUURnOTV9UnyXwBabCfYDxnPAAT+Mu+iyWGRtjZRPMa9jtWuYZzn0cWZJEzTEnCtGURDR3Ft60dblBxmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b89wQ7Nd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso7371391a12.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079136; x=1768683936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJGe4F24ZVfayrOmF+dW97eXhP3gCrceZMdfXokyiw8=;
        b=b89wQ7NdRStyFOGmSJCzk56eWd0V7i8uIRjgF07pV0S14YytTnZvLn1CRLy8TlNj1w
         4SW0HOGJkzQb+2zicB2Udj9v0re3Yh0K6F9EBmvQ6d4Dh1C7GP6r6h3AVY2WdJMOqMM/
         bqZIiheq5qjb78RdvNx5DeES4KT3DIQqCf0KjWlWyT5YFgiPeS4i+LRezDD1YZKCuFpy
         85lOBk0OMKEvPK9DwMIpHf4eOZrTKeKbpVqTMpMxdyflNh8Am/ApIh5sZk1JIom9P7Nl
         GAev2N06i7FPAS4BO5Dn6nlS/ZsGMOq/r1vOqQ0Ue1fyg5Ottj2xa/SUZIOv7Abk13RH
         G+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079136; x=1768683936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gJGe4F24ZVfayrOmF+dW97eXhP3gCrceZMdfXokyiw8=;
        b=wwcpkiQHOIzCDMyTAjq/JdRj+QFFZf6ddB2ntk4itr5NvigOnDhVprz/oH5paCDs/7
         dnWIsxv6k22RW27cum9+zDbXs3MLMvaxW1NXCgNZTXWEGQiPaxG8ys3q1pVETozXd3qm
         hWzLtUDcPVqh3WvAtBbYJLqDc6hzQgrxO5mDNXo8Y1yVsytMm6HTDl8gIlPut1hPzhOH
         Mjdh/0iTrLwyrOagjAC/ueTecv6hVmI6VJCJg0EeIED1ZQE9zblZJ2eMJLK1tfeVDKLh
         RNtKPvBHh5zpNOEyAiL8+hQMohT8wYJ/C2OJ9AnIl574cJeeoOQwnWwKl3kcsCXVljKk
         WvaQ==
X-Gm-Message-State: AOJu0YxbLAnaC0xTgMEyYjSqrAE9ZNpGqFe640TlVlh9GnETR30ZqdMp
	ueduLZ5Ox36mQDB1+R5NILFx46j93jU+YbDhkQ5CBbxeyZAO80L+93iq5GrTMuBSh1o=
X-Gm-Gg: AY/fxX5anef0yPj9/EcGbnxxKyJCO/XJveVVRizXhSQZzepxcCS7rwLt3QhI57uFpPo
	Jkji0yn0s6IKFhXx66471A4iYMvK2k4lALt4DtdoY+CjIXOr+G1o3PZAlL1jNZXWO38O1iN8L1g
	mWiItswL2EYQSBCbF6vWgPHe+Q1InRpjGLvBZidAQsXgxzM3RgsDrInLF2UNvk5otZCSZ4faYS/
	YxNAjkyvW4cSbs1pBFL5MI6MuysA+JOoAjORmNlEv6JqoMz3985J6sKXCcu5G4gx1Km4EK/sA6f
	kvBCC1r0ZP4ZpwB5aZQ+NbDzoeZ+4mJqXxMU9bH70IQp9av9IQtomFE6R5zd3de6mYOqUnVRQbR
	g89PoumQ07ZXlxK3O3Y/AwbjEs0rIK6UB7TWIVXnXmwFvrfFku99w42ZWgLK8sVS0yYw0rGC7rY
	o4HR7mMUGApq1W1WJOFfVwOt+78ShcBB5uy/cGHlEDtGb+QKV0j1hKoFvB/4VkiyIYvBNbHg==
X-Google-Smtp-Source: AGHT+IG5ojyykHKJrNS2iqi01P/vtltLLnJRqU4cDTs8uiHP43TabkDLYPv8nJjlhqnzI9Nx6i13Jw==
X-Received: by 2002:a17:907:97d0:b0:b84:22ab:a830 with SMTP id a640c23a62f3a-b8445233534mr1342410266b.18.1768079135871;
        Sat, 10 Jan 2026 13:05:35 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a234000sm1495187766b.4.2026.01.10.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:35 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:24 +0100
Subject: [PATCH net-next 10/10] xdp: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-10-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.

XDP generic mode runs after MAC header has been already pulled. Adjust
skb->data before calling skb_metadata_set to adhere to new contract.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c711da335510..f8e5672e835f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5468,8 +5468,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		break;
 	case XDP_PASS:
 		metalen = xdp->data - xdp->data_meta;
-		if (metalen)
+		if (metalen) {
+			__skb_push(skb, mac_len);
 			skb_metadata_set(skb, metalen);
+			__skb_pull(skb, mac_len);
+		}
 		break;
 	}
 

-- 
2.43.0


