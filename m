Return-Path: <netdev+bounces-248743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80526D0DDD9
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3993C3037CC8
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1618729AAF7;
	Sat, 10 Jan 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DBNT229l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B92C0296
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079138; cv=none; b=dpOz5sAXNo56BcRhxLbnleSvRZ4CK5IZh8sBtCsSVgeoSX/A+waTqDv9qACTNrzW8qNnZa2ZQzxc6csFapAthTSLIwh9Xrq3hbwVg0WMY4WEJDY1+3ub8nrE9tKvy0z3/df4u2C4cQNxGZdZGmKt6pDnIliz3eLcmEO8h8TZln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079138; c=relaxed/simple;
	bh=ScmD128+xpbqw69NFH/JoFUcpX6jwb7UjOYs0lYQUDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnMmzhavH8v1K9fXUyxb8Q2o6VPhCJkTP0+BDvVzy6VEAPF58Xj2UDE+0FaNypj0/xucHuba0bEK4T3iaCMqPuMM5flW2glMKvcc/chhdvSdwaE4TXSRUMQj+d603R224TlwwmoSVQYcM1cqusn0ZSWfA+xPHKB6SaJ1fo7dtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DBNT229l; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b86ed375d37so107058366b.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079132; x=1768683932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYcerOXvT20TAZxV32Bgec2U2gzBl1lA7Z10rFU3rY8=;
        b=DBNT229lu1Np6sGwYn/sIMmOFXN6dm1h74VFfc7H/6XdBBTJZsmnfhmzUHLL6Hx6UB
         1jqs6dLeSCNsCjHN+Aa/1XEOU2lOlplWZBC2dMOfK1IYl9aeEBIM/d8Sx3oQK3yvRSdK
         jt+JEpSm/0qNejMhCYk55Cf1lsGzYeeJ1K8uquWuinUJDKEexCCtpBb5nZf0puVyO8eK
         NysUSam7QFIEuorQAD1J8gBTJtIhyxKwE2BOzmXoFzAwgECmWdNxJx74DzAEZoICrx/g
         Mnja2HJ4AwaMKUZm65ipo1teVak2w/+oojZxBlimrbZdkbUkXjBL8DSDvey/8I2X0gSQ
         bBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079132; x=1768683932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JYcerOXvT20TAZxV32Bgec2U2gzBl1lA7Z10rFU3rY8=;
        b=JYA0uJJf0gWxWXBVGqVzk2nueTZJH1s93lS7xQf7ACBTXfA4WLs8kK3iU5aJ6YQokU
         ulKslPHWfWlUTzH94kCXtszlsiVwQFJiIuhThM1jb62NxoAGvdPhDXiZFK1cFF3zNn7O
         5j26Tj24VvbJZdBLKNC52I061KKcdyXNX3gIOTg09mH0lenaHAOqWB6+xLZXl/zNeHtz
         eWjBjBWIR4+lQCYK9U9dDJEWe4q6wKLKHN7KT+frCV410/YmgtcAU4EmfKI7ba/Vz0t3
         HCx3Dx7fTiL4ColpYSyiiSUI0JYZdFsw/GhprDmBcFhhHpdLEuzxOpQwbVgqXlQ1cKXw
         B9gQ==
X-Gm-Message-State: AOJu0YxhrSIZP5pBUxSjxL0BUP41ujk0bATr95uSeKM7t3Lst7NsYZHe
	gwggR23e0H7tpFRJUFcdUz1KpfIZUzO2e4x+gCopDHyvHezmn9dh/bv42sSLbcbHxs0=
X-Gm-Gg: AY/fxX5SI6tRg8uc1KPU5rfoAkR2l+rhzpIRFOReEPAmL8rnSGttQJ799igc4q25UF2
	8rGVHEftkxKwpfxEcS6miTXxW6wrEmgn3lJj8V6Y2yKTU2yWu3euPdlvZ6LiBsn3+lBo/x6LOfB
	Ms38Qigv1uzGKevovzB77KLDcmsua8kWd/VPhwa7OfgBdskEX0V4WxcQC+tDYHhY6cQTgj0I48e
	8x1klPuw4/W9c2O0FsLy1DgtCryfXcWcl+MnJrSj5OvzcIhbKn7iHgZ7FNXqmz5MKAi2zwa/ry6
	S3rWbguei+QeUZxu65jBDsjAb0yd0aXUL1i53YYSR0Bj7C0kKuPEcxXZcSAAF5XPewnc2ljvBcj
	YHjStwItSKHGvZQnKp9+O6oQgnBDrJIhximQx9WzDSUpty57YMdLTpTt82n1mBqHBfRBqd1i/a2
	hVE3lpUZJoVISp8wTzEI9XxDw+4soSycm3RmUeHTuEjLWyQ/yXoV0+x0WD+C5fuLYTo+9Lew==
X-Google-Smtp-Source: AGHT+IEFuKrUoamrVGukylQDbXiei94tsX9UTPR1SSJ/HUiay/bcZTQi78J/wZJ2myAmZPltA3HFYw==
X-Received: by 2002:a17:907:72d6:b0:b73:42df:27a with SMTP id a640c23a62f3a-b84451edb4amr1195769266b.1.1768079131992;
        Sat, 10 Jan 2026 13:05:31 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c3f89sm13718558a12.5.2026.01.10.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:31 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:21 +0100
Subject: [PATCH net-next 07/10] mlx5e: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
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

Adjust the driver to pull from skb->data before calling skb_metadata_set.

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


