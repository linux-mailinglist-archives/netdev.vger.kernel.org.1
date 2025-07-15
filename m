Return-Path: <netdev+bounces-207287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6450B069AE
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C786580029
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDAF2D5424;
	Tue, 15 Jul 2025 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aq0P36/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8862D541B
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620494; cv=none; b=aPGL2l4VooNVGYeMP5rkVRDxuhLSnSTQrHxduUXxyToWb0XekNkglZSIbvHM8kSCVYlu3WJ3EKqe5sUn0uLaiWeCRd4tJWkb/va0uJMjTqTFp561CuLAn+tpc/If0GFhZLX+4zQRH+IL/w5nUfXFIz6wRL9Xq6kU64ZIBkZDcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620494; c=relaxed/simple;
	bh=C0yIBGjgQuUwh2cILUg4KfKwRH5Zo3VTXMZAiLB5IzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y37FgSlzqjkBUYLyc+Bq9oHdl7taZ9jG0AZ1khBEZQMydroaJ/kAaJmcTEH0s0pBswqGFHNWh86nByl9eocs3UiHoDiWBXaATYwdX6g0dRPsxTw9/bc5VrxX7wT/rFTqnM/An/YDymL0TaOH7pcD3D1WsK2p1LHtHlikxRcjB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aq0P36/V; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73e58d50fe2so785407a34.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620492; x=1753225292; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4SWITf8rdF2+7Tku3l2OCdj3WOMyrXJ2wvElW7xvwI=;
        b=Aq0P36/Vw14ZTOSZP7VIoVXi0jFTCXxSroHDH9b1wV7v8QYZs64zqWi1W1JNVwADNZ
         tzJKbkbCaG2wczXIw7esS3v9YoRn1c+XrXrH578lawGjfqxViYMUlqv8aTuVmctyw0pN
         3hbX7LBqwQ2sXTiX3HiqKDQjOZIOS5I1q5+EgdKDizdV0HnM6Te5jiiw0ouhUAXT16bM
         uJT0EUXj8I9LkO+6k6KTxe/2eo3WHRSloo37tZ7qUyVwzUmmPDR/ekiERhxn8nUF46BA
         ix5d3m0XAx8s7bqczDZ/0AlMX9oe4NZxfO4ph1bRKC8GkeDPG6M1hXLP1ECisprPC/hP
         xR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620492; x=1753225292;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4SWITf8rdF2+7Tku3l2OCdj3WOMyrXJ2wvElW7xvwI=;
        b=G8KoMVXgPVAGeLtmX1VykofDTH7ULFwJ16WkzxqJ3/vNsOIfwIi/NyuQMNRWUfpcrE
         /Fo9kGAkvTgEoISpPqSzlGERrm8rFdKF459j1M6q9JHaRk4/K8duCWKmr8TxEJ3x80zK
         qV8FuurOwAmdx2zSQ5A3K0lhtfew5eRIuPbYdeNYrDkbHOxbV26rv1KYF31fjvdaUl+o
         oP6HJa2Ty7i7avixBjRkcVeaWWCeaFk9097ehK2grteIHfGghC4xuvB/XlIbYeICvYEu
         08VdRTsAnPCMhuuXNggT6Pv9T9+zQ5qEVXe/FJdQl/7WPz/g9zX9qpo+SgOLFQQjrQR1
         ODRw==
X-Forwarded-Encrypted: i=1; AJvYcCWS7BhzWaWTXwsQpVWSv0n7Z9VQ9RiOXLrwnEi6z95S1x6RolYZ0qVL3qMnIh997/TA/ECl8Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54kVeJFbUYlK7yVS6aJoXXogS0rnIdsZI6qxW6qlx0vJ026AL
	RwIztL0R/+wcDIVEIitpCAyNG9lYlFpX3KfuNAdbY7ojR52wsFgtBUiPtFQPRT2zBmPrpoHJu5L
	uqj00
X-Gm-Gg: ASbGncs0j49jDpZzwhaMKwe1x8PYIrI3EVtFqbgDkh4sDoQppxRym22DSWJ+f4bgsQy
	OnF8bOEbEgpMhasvdbqs4hFLZYxVF5TEeElqhPqk8qIlqXIDKhGwjkLvG+q6UpPpLli27btsxEW
	ZsLxjsGiL/3BQL+6esxzumT4x0lqHE1CP5JGyLAZR3fxdrjN8GeWg3TwUOKdwZgHF8lwBLLDa9G
	mjstreESqmibPNLMJ/qq5Mv0S4m9vTtQsjUjBTf0KF8OzZi8hmoUAIbONGeFz7cIGW2d5Y1y5k4
	ESfegzIqp7nukctFIqKeoFZq+KkA5YR8jGOVkgzAOwvk5fk2fq9oMaZIa9KY2f/P2Q9yfL9j4VJ
	TkjHFQPpjirCnLcozQCYOFhU0PfD3mUUF+PPQ1pc=
X-Google-Smtp-Source: AGHT+IE8Nfeo8scY90CqHg5efo6nAkc64loFfqqe2YK8azM++ugsfehXsqpsTS6+ghhEcDe7uWrOaQ==
X-Received: by 2002:a05:6808:3c49:b0:401:e721:8b48 with SMTP id 5614622812f47-41d031f1f01mr437628b6e.8.1752620492132;
        Tue, 15 Jul 2025 16:01:32 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41c267defd7sm558510b6e.11.2025.07.15.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:31 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:30 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: Fix an IS_ERR() vs NULL bug in
 esw_qos_move_node()
Message-ID: <0ce4ec2a-2b5d-4652-9638-e715a99902a7@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The __esw_qos_alloc_node() function returns NULL on error.  It doesn't
return error pointers.  Update the error checking to match.

Fixes: 96619c485fa6 ("net/mlx5: Add support for setting tc-bw on nodes")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index e1cef8dd3b4d..91d863c8c152 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1405,9 +1405,10 @@ esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
 
 	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
 					curr_node->type, NULL);
-	if (!IS_ERR(new_node))
-		esw_qos_nodes_set_parent(&curr_node->children, new_node);
+	if (!new_node)
+		return ERR_PTR(-ENOMEM);
 
+	esw_qos_nodes_set_parent(&curr_node->children, new_node);
 	return new_node;
 }
 
-- 
2.47.2


