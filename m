Return-Path: <netdev+bounces-148425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4A9E1821
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F24928645F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CB1E0499;
	Tue,  3 Dec 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uV4ME+gR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB11E048B
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219122; cv=none; b=hQOVN8/yalsyD8ASPAkG//3x9kbn2YLwntng0dbRbeJtgRursGzUJ2okeJTMopqbZfhbI6+oTclK3vYV2wuczcSuwI1AxvgXWH1bM2fXxfYbc8dH+WUto2iW8T5/FnsbUlHUNkwYxlYzF7n5yoOuB87cWFqricWXbKtTtI765nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219122; c=relaxed/simple;
	bh=RJ4dlBGD3salju0V5qaXj8Hlpmx2bDBn5RHAXBda2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FCLpWOj9PtGbdv9msLhc2gt7SptcJoXIIREUsmyPB9wFZUGcrKERU2CML3G75hAhT8VYrgKuwrK8QifHsTlBIfj1KWgEA9Z046AZXFk1/ENDb6J+2f7w+VKa0eVagtSLoKYnKqaxRnWo0blBZX7hG9suWr7/zTOLRM+PFvhEGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uV4ME+gR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a766b475so48688685e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 01:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733219119; x=1733823919; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I1Ptmv2KxZJwio/UIsOX+BhzfGwkhQGEzNHEKVRFKU=;
        b=uV4ME+gRVBtdJasDf2fMwONsoRGQM5JE1tp3+s+c5xfAVh5yqwY3NGe0x9w1ch8Xsk
         wQZZYyiZiqi/WOgXQiv8X8W7Y4hn13uZRQaHX0fOmwg94V+jIA4llTy5fA8LXnSFDuSw
         JKvDa0Ttcqn91PKjU6UNi8az4afbfH9bUyq0/Yw1MNUNugheMzK8Y4a3t8TCJswHZZg6
         RdRxxAZ86ILTnfJm3nhGg6nsjDAfDP1zMahUaEwnBtbGIJ78jz1WdLnGVrJIKosfsE6J
         yqDpErgO+YhsHYSaNcyuqgcTrqYuVLKvBJTHo7vLPmKkXO2weeqSnHSd9mwL+F4BqB/P
         dHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219119; x=1733823919;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I1Ptmv2KxZJwio/UIsOX+BhzfGwkhQGEzNHEKVRFKU=;
        b=fHBsNg9zEWKBZGIwSfn32CNjPU5uKWxMjoIDaZE+uPq1La7Cm/3dt3afxYccl1YjQD
         aLW0yJcVTlta7UzGbrV98xawyrg6jk1AaSHLLYOq5jomKkhQxnlk4cmvPEQW+7os03Wq
         HUpVrDgyf+cj07IpsaAJQmSdeYahUu94l+acrnRRB5MjFYQ0sSHf2u4n9juVvtmDQQSa
         nGg/pRRcu1davdWyz2OelfOrlhBydWgre/g6mrG+JuZHUN4qeYhVl/bSFl7Wk3miuMZz
         m9PX59s0p9Y/aZcCnLSpMwqqNOZ61YD++ylgINV2A7pyO+3all5Z1ewQor7XFxSdG8aW
         DKRw==
X-Forwarded-Encrypted: i=1; AJvYcCWazVB7NS/aBmGFToRdMJmf2j7eTfNcpys2I5TP+0sCgaGpwFqV5yJzX6mzXWvMOiXJxnrYU0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzW4UetUQIr4SBvBPfcfC3jY7EVAYiHWSBJYz6C30xaBQNZuwW
	CbLsV4fO28h1eCsnKhEE8fiiz+qy7wtBRShl2LNgWcYh9UItOjEEhTJXnfQmV7o=
X-Gm-Gg: ASbGncutoZ5WSM8qzhcDTg+Mikis1UtBO/gU+DRqTMf9IlE46U3WFQjxkgC0hBF2b54
	YzJPZpVoJO74hbCLBId3Zcfcs5KDBX5LvPr1KKbFJhYIKaMb79HzSHItxpmuRuiFUJ5C+NJnDx8
	vAjvhV8KY9QPjZCYYc2P8OmrV9Owu6d1m2q8swo8p5yeHeH9nrMxEPJf/xjNDtMyGTrRd0QeJ1B
	rfVoXzaNm+mfh/lXz/5/494uVQOOsRBitbLGTTw6ptfpedCzdripmo=
X-Google-Smtp-Source: AGHT+IFdpiCjCQ4owJdmqakSIReYwoM3vo6fpku4tNVal18DsXpYtsSKHcj3Ceq2fZLtSh1NDS08JA==
X-Received: by 2002:a05:600c:19d3:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-434d0a23b36mr15900425e9.31.1733219119326;
        Tue, 03 Dec 2024 01:45:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78007dsm211772455e9.19.2024.12.03.01.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:45:18 -0800 (PST)
Date: Tue, 3 Dec 2024 12:45:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <Z07TKoNepxLApF49@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The dr_domain_add_vport_cap() function generally returns NULL on error
but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
and if it's and -ENOMEM then the error pointer is propogated back and
eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().

Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
---
v2: Fix a typo in the commit message.  "generally".

 .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 3d74109f8230..a379e8358f82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -297,6 +297,8 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
 	if (ret) {
 		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
 		kvfree(vport_caps);
+		if (ret != -EBUSY)
+			return NULL;
 		return ERR_PTR(ret);
 	}
 
-- 
2.45.2

