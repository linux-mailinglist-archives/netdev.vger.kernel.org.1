Return-Path: <netdev+bounces-233634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E06C16A46
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF6D1B23B20
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1134FF7D;
	Tue, 28 Oct 2025 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GAukHt53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5FE34FF65
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680443; cv=none; b=hcSS0nrgCJK7Eca7B9K4Ee+KRCoQLbxi04WHXVKDvb6a58V5D8Q6zLq2S0w8pb1h7sJAUjWySBKt0JS1oSHBVk8CkBvDAwRHLFkaivq4fsskdMi+qTPsIGJSDFx+1OzTQ0Asol9fBzztvtR1xnSYB+MydSlJXDwdwOJy8LCKOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680443; c=relaxed/simple;
	bh=j/LqWusUCK9sOp3p0jzhu7TmQ4AvKFKdmQdZVT0RRf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnrcckZaxsib1m4dJqo8PF8PUpdkmR4hne76lVxoEcQ+NbdyMsx6aHoBdAGgUNLXKgLuF6o5sIvPIDZgO57kvRd/DzSlyGEZex5q3Gjz8OdPn3/TC/IA/9Mge+NDUqehx3BYMW8ng/nv2cburWcrrVbN0AL9AMIb4F2GVZwc4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GAukHt53; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1524242466b.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761680440; x=1762285240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j4dV+Z34jHCGa85T3/teZEERcF9TgvFhBFwhiQswAY=;
        b=GAukHt53um7FAbZBwZzUqqTJRtJWBrr7QiHCBPcyqHWzhY/MSTSWRz4gRvzT6U3i0A
         volgPqlPDWv1+SzV6lG7wOhD6oAGnatJI4CQc0B0GoAr3UInxnjejMc3un4BJEd/wmRt
         i4yWMlJlyT6SqEE6Wl0FQMAR+Eb7+zBhuvcQUZjn/X4TKzy4bsCPru/rj0j0G2aLCgm0
         LhJzcMk2o2fwc3v55Vi+VeKDEtfmKOOXc75BvuwvBTfRS8MsGRFfiQlGfbLSGYUJogcp
         PYb4WoKOsyQeblEolXtu4ZBsH7U6wzr8LuwZijL5PNONpTKPxmmgLjnZYQXzH0ieAh6r
         /IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680440; x=1762285240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3j4dV+Z34jHCGa85T3/teZEERcF9TgvFhBFwhiQswAY=;
        b=jhX5hhlcsCDSG7tl7w6zBbZgRbH5314bU+BF4JNlX+16qbQ8wZykPwp1wkwStA6bZ2
         kmkR01vL0kId4ANIyl00NtwGEUc11gqOi0ktvdd6KnJNd31uw9MEmcvRV03EvRB9N/Wu
         LmX1a7x/8RfRSnqF+D65KoFAw0Oe6e42QtJNUL2ASuH9S/iQjow6EtRLj4JIAft72k/k
         0n4UGil1DQb6b97mIj985XuPh2PbcqIEucU5WJIPAlFA3u/wdxMiXaNgVN50PHetlxUc
         8HCyr16PIxvWR4AwgCiA+KGNIkIzCVqD1R8upgPX3Vd8BMTZYThDbZhR53Fw+OOw4N5l
         C4lA==
X-Gm-Message-State: AOJu0YzyQlctAYA5SIsHdLXo7yjiOyw+75VmWFRWcVEOnVb4rR2q6ro/
	vlmOjchqh+BHKhbtQLCYbK3N1RXNzJJqCdO1GTkR3w1V5o5xJEZwUWbLVGKK1kY3VFv9wFt57zR
	ft9XNCrn1Q9Rsj2X2rJM45humhZQiOt2omCr0C/yifZaKUKSIAUeH+KfTlNuwD3OK111XN/uVPQ
	lyuaYe1o+NygHXWKhq5DRW8SsOCrl49V0RrszEfuwjwA==
X-Gm-Gg: ASbGncvep0+s+XJox79KVVp7EbNb+VVVaC+l1D5dUAo28wcpGg/eUvceuvZwaPxd8z1
	bF3NFGKDg+3Xnhpes8L4Hx10VQ7jiVt7aEghv2GMWwjpO4f/JF4PbxZX+FqrZAXwDarw2khAHwb
	oc03QzsN1ZW8qBI4XAeSKNXqkkzlQKB9hdz1/ilVtNAN4OWqSANOLE0Iyfmq84/T6oTiWWzucv6
	ktUxf9klLpEO9hJ2EMSxtzd6wrrhqKitS2xgkt72AAjQi1kYHFbobyGikW5u1mRV7V9H9tvKiZk
	0GPEBQt/g6DdP3CF/RmTCjwREj0yDPQKXGv74dAnDbiBXreghmSJpGQJEBs4oQ8Z728smGl92C+
	u6uvoUWM3A2MY9P65WOYVvCkZ68fYh/VPC7Q1lpZICgqWcDP4yuL6WYPcaW8bf6QTX2DROlgNYy
	Zh4+ypYJfh2c9XwSdsecu6jmZQAw==
X-Google-Smtp-Source: AGHT+IEJRYGO2o2wT/fRp+Z+2s/oleRoc9e45sgE7CbZ7wctJuvjS7UU3xLGNlxgupkLoWLXXMrQqA==
X-Received: by 2002:a17:907:7f14:b0:b3e:b226:5bba with SMTP id a640c23a62f3a-b703d326675mr20705366b.15.1761680439964;
        Tue, 28 Oct 2025 12:40:39 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b6d85308039sm1194743566b.8.2025.10.28.12.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:40:39 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	ashishk@purestorage.com,
	msaggi@purestorage.com,
	adailey@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug severity
Date: Tue, 28 Oct 2025 13:40:11 -0600
Message-ID: <20251028194011.39877-2-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251028194011.39877-1-mattc@purestorage.com>
References: <20251028194011.39877-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a user or automation runs ethtool -m <eth> or an equivalent
to mlx5 device & there is not any SFP module in that device the
kernel log is spammed with ""query_mcia_reg failed: status:" which
is really not that informative to the user who already knows that
their command failed. Since the severity is logged at error severity
the log message cannot be disabled via dyndbg etc...

Signed-off-by: Matthew W Carlis <mattc@purestorage.com>

 100.0% drivers/net/ethernet/mellanox/mlx5/core/
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index aa9f2b0a77d3..e1c93a96e479 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -310,7 +310,7 @@ static int mlx5_query_module_id(struct mlx5_core_dev *dev, int module_num,
 
 	status = MLX5_GET(mcia_reg, out, status);
 	if (status) {
-		mlx5_core_err(dev, "query_mcia_reg failed: status: 0x%x\n",
+		mlx5_core_dbg(dev, "query_mcia_reg failed: status: 0x%x\n",
 			      status);
 		return -EIO;
 	}
@@ -394,7 +394,7 @@ static int mlx5_query_mcia(struct mlx5_core_dev *dev,
 
 	status = MLX5_GET(mcia_reg, out, status);
 	if (status) {
-		mlx5_core_err(dev, "query_mcia_reg failed: status: 0x%x\n",
+		mlx5_core_dbg(dev, "query_mcia_reg failed: status: 0x%x\n",
 			      status);
 		return -EIO;
 	}
-- 
2.46.0


