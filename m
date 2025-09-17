Return-Path: <netdev+bounces-223817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D208B7C6DB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4AD16436D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C67DA93;
	Wed, 17 Sep 2025 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuGiBwQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF091C84DE
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067822; cv=none; b=k0j9ZTLIIL/+Vzq7UA4W1GaEkl0PEN2AuxH++lzEcut1Cf3qb2ZOskVjEeqTYGODjoz8NTY81mCNnWTr9Di3ovStcDFtrnJg3iOqk7P6UQ4FVxiz7asoO9Jdc/1j0UK8gdpm/EDW3TT91pqLe78IiE8S6aNnH+MKQ9MeBSTGYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067822; c=relaxed/simple;
	bh=z7CCUcXNRGOSwRx55UilEXeZ7ji/KjYa3aBI66esJBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGg5/xHNhLwCsZzolEiqE0rDPEwK3vOYsIMceRAFUmll6hRh9Y0kFdZv/Ct0hrYc89D0RSRA5JDcxoCzjMTBGBh2M8AoDVJsOxrIL/q/VNuDt2YV0iPxYXv7d4O+5bz5dxivcAv9DVTE2HMU8BvOHOFxuv4hHX/xivxg7UEzLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuGiBwQZ; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-60f476e97f1so1994567d50.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067818; x=1758672618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1dbg2IUW/gjxWay8VnxqBQUaNJkg2EY3rMaMW38x1g=;
        b=JuGiBwQZQOyUF4HGmghLL9rZfR7CvcMf6ISflUmmGEFhFqmlPG1+CjEEj+iTwDQT/o
         9ySqs4Bz/r3w5KFHKmJ6SgYRYKMxBEs1aP2FJMVvhQTo2ZJnIuO5ZbvqUXDCxFfyk7+r
         FUezHiikXH4ebH6Xfk3eLGp6gJFbuU4kEEnktxMSs9a+N+tIdJsfHR7MBjw2nNzhNDOm
         paeB+Om77ccLb+HQk7vEomH8lPPGVtf6jNcRsIyw8CErojltwier8zGgujibAQ8wPRYu
         J9HPI9U5sokECSvazAGMpDcReH/QDvBCEdVDGzw6jj9zbgj1Vm4d/c8alUtHPlFf0MIV
         +nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067818; x=1758672618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1dbg2IUW/gjxWay8VnxqBQUaNJkg2EY3rMaMW38x1g=;
        b=KnlSYh6W/7S+/i6mas/5Ikd1BAXqVHZcG3C0tURMiTdgRfCHFCMGcVa2g858XxceX+
         nxGn5TQJLesYDmU4pC52Kjagzhg4RErWZsbsra1DCAOjumnJBpWfvhdHFmI/AQFKRDn5
         +8WuV57t53nbNR3sThV8KEMtX/4++UAQ61WPYwX0sqqy2oclta2UAH+BoKidu4aYQcdq
         7JH8ERXCJNaENOYKhtJQPrfnw9oQqFYaz82EpzruiJw8ovyoLfsIhq7yunkv5BcJCcV9
         nEs+CmFxSovFsty9ksuzdhHbEjM0P8bkM7lEPicHVkfMBsEbYw+K+6ROHXqEaYJaGeFz
         CsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaXlV3ATUWJnJBebkZQDx34hnwdQjiPYIbOamzgdvl368XJnFwmjCb4/8SZ141MfJSBItjAgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXhuTbACpRp9698VbfKwguVBLMUIkeHRYYUwHNN8mJg2lf+YM
	f6vPq5QeuoS3JCWXFZIwhzUnYC6GbU2uZXjYRr5GLngBHMBJ7SFzVygQ
X-Gm-Gg: ASbGncvX7n0zWDPDwzaqvCZONHG/OOInK3zXZUnGIe2ZyHFQolcNVJM5bEqxNnABSIY
	xWAJcO5ha9EESU+d23T0olgVE1roUen/pOYmv7UUmbl7Ekls94yc2YYCiqcDx6UtPoEMhCQIggA
	lAnpX3AnTusazWHFciDWhXP02AII7SEXxVcsbFKhcP7f/EglW8qeeglflUTN6Wg05brB5fFZpHZ
	WaRcISJWJ12UgLLDuJ7vijjCWIqvEKF2ExjNvraG/A6TGOvQBeKwuPuZDwxTgrNHlKiwbAGAUJ2
	qHXa5vZzJo+4l/HSVsI/daTqGdUxVZPlPbip6C/3k+SzvZVfKhErInZaArY8b2+1UxJEUUn82RQ
	R55ZaakNCVtzudGIBiM2t
X-Google-Smtp-Source: AGHT+IFyBQY3nWCBR/EDLTT2eZbVIHaUp4hHedFvbFA96KHoGYn2V3MyQiYLY0PUUEXvSt25VszwbQ==
X-Received: by 2002:a05:690e:418c:b0:600:c2be:313e with SMTP id 956f58d0204a3-633b05dfca9mr281145d50.14.1758067817673;
        Tue, 16 Sep 2025 17:10:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f79697b3bsm43330837b3.52.2025.09.16.17.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:10:17 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v13 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Tue, 16 Sep 2025 17:09:46 -0700
Message-ID: <20250917000954.859376-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917000954.859376-1-daniel.zahka@gmail.com>
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Implement .key_rotate operation where when invoked will cause the HW to use
a new master key to derive PSP spi/key pairs with complience with PSP spec.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-16-kuba@kernel.org/

 .../mellanox/mlx5/core/en_accel/psp.c         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 372513edfb92..b4cb131c5f81 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -827,11 +827,34 @@ static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 	atomic_dec(&psp->tx_key_cnt);
 }
 
+static int mlx5e_psp_rotate_key(struct mlx5_core_dev *mdev)
+{
+	u32 in[MLX5_ST_SZ_DW(psp_rotate_key_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(psp_rotate_key_out)];
+
+	MLX5_SET(psp_rotate_key_in, in, opcode,
+		 MLX5_CMD_OP_PSP_ROTATE_KEY);
+
+	return mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
+}
+
+static int
+mlx5e_psp_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *exack)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+
+	/* no support for protecting against external rotations */
+	psd->generation = 0;
+
+	return mlx5e_psp_rotate_key(priv->mdev);
+}
+
 static struct psp_dev_ops mlx5_psp_ops = {
 	.set_config   = mlx5e_psp_set_config,
 	.rx_spi_alloc = mlx5e_psp_rx_spi_alloc,
 	.tx_key_add   = mlx5e_psp_assoc_add,
 	.tx_key_del   = mlx5e_psp_assoc_del,
+	.key_rotate   = mlx5e_psp_key_rotate,
 };
 
 void mlx5e_psp_unregister(struct mlx5e_priv *priv)
-- 
2.47.3


