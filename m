Return-Path: <netdev+bounces-201215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE9AE87FA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72284A8161
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A32BE7AC;
	Wed, 25 Jun 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8QL6c5y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422C2BD03E
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864989; cv=none; b=pKvtfc2s+EYx7Wlx1hGCbgZMjbJ0cL2H1u40l65SgSQI3AbLwo8tlXuEHaHQkCxxauEAr0jj8AFOgBPe0fzckkEwOHcnU4RjbzOc99hM9lyNwPe26wt4zANJCHnkVbQBRDF5JvrImylUlSUqSDdtJ2zyezfTs3zraAEULgfQfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864989; c=relaxed/simple;
	bh=a47eZHNrHhm8bIT1UsXDpMZVMqM2M/J1nRMDkPp4vj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U0pkcsItIxMNb0M041MX3bJBqVWqlAauugVy5KYfnxyEm9LpWT8XfYsilSLKJWYeiNisq0TAZxfZDDUbJ29j2DiRQgBz8X+NwYpS8WRXkPThHyZofcUTcOzW9c4rJ+Wnw+mJTppN/bZcvK14v5g1XRX7VCW4BXCIqPKZ4Hs/X+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z8QL6c5y; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c27166ab3so4325011a34.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864987; x=1751469787; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gzYs3m3F/c7eB4Inj/8U0D6uQl5hfC5e5tB1ISacj4=;
        b=z8QL6c5ymUm2QCKobA5U/ljErhFTSOq2eZzBh7i+MQiI35m4HkFZxK4AWQucZjO9xd
         kR4L+X7pK/99kttJZmvX5z+TMjdrmjgW+N+IpmvCMoB0RwoThpNXlSy3qgZofflkFU5T
         Md7rud0cTXfyuwJ4DHL7mQoja27T2ZiNnwK17MmjWZhUZw7cQIEBOKIqDv2MQsxexsDt
         IsOwNXA2BQps4aJZ59nMUueEieg8aX6vHdlkHTmTt7hWsseze19FEj5IDIfSQ3A85NO7
         klPVKO5+26wo1Tp0WmlUDFtg6kQN8F8icZFn72slk1V0+MsoCj3Ana6IQJwibcNSijVW
         i6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864987; x=1751469787;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gzYs3m3F/c7eB4Inj/8U0D6uQl5hfC5e5tB1ISacj4=;
        b=jyRD4g7neKGpgnTZmwkhUrwRvgw1yOQz240xOgnni7im1SBsNLmH7OVK6D8JbE9e4u
         TS5XO6RFmJAxgBf6DsCUO5pfk/xZoaUTb1Xqpj3oxhptgY1cB4D0b+6CaboWcBa0oYSN
         zMjc+riSZwLGY5Ki7KN2bNv1mcpOLrXemV0EuczgS0NXASZRBcR7I5jOg726tIf2PJ9u
         FPjRfrVTSwmoufrCvFz7sWeVVfwxd2hKKv7HEOhymS8QR4383SkNl0xojD9vCwcNTmOq
         9HPwSMCcKj1hAOYMpxMUTmYSaEqn9Wgo/FUF1BTnqBNaCp5mzL5GwcheJg1TWoCvcn+L
         aPrA==
X-Forwarded-Encrypted: i=1; AJvYcCVPP75GuemAaSzqi2gegA5x8Ku7GmVBHsVe/QlnYrrkdIhTx2s+l7Fo4Kj4hJ36tzXI5TmxUQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkiUf2MllVKeK0JRtx9wzEMMdJvi8VUfYNPqmHR/PYMSNPd96
	fa8TXlZRn7JDYItO/TtnHsKHP8ijJwrlN/u6K9FW7hN/cb0uvLjDw32ZTOxz5wURFqk=
X-Gm-Gg: ASbGnctsLEppLbZwliex6mB9+Djuw4bmk701DprEK2ek9sMflc8oIt3I6j8PdFCPP1o
	FLb/EwrNBMP+MNJ4hoWp8+Db//Jw9VXd+pbRBIl4j/naCt1zDx5yoYHsUNWy9fOu59X/r0K6Eof
	kICcDeVnNWewg1HTUqvPZd80R/NXaUDfuDDLh8ro1jaQT1zgJtGy0Hc2q0P+syNT2oVYgxquGVl
	zvrWvVHEXOtWE4Q6gs53ximw0O94F6zRQFp1ugvGXfrBzjv+yv+PClOtZqNAk8KEAXNOlvsz0Zk
	vUUvjqRywv1IYngWFVBO7v8s8gDciSH3TCsUXs3X15/eBAdgy7K6kWAhyJh7jOHwR62XVg==
X-Google-Smtp-Source: AGHT+IEd8+YjM8LYQGmqEAU6rFmznZBC4Qrv0XQ+XpbkPlvJZEhO0r+n9pOweQCLkeKUxTgosdHpgA==
X-Received: by 2002:a05:6830:3e8d:b0:734:faee:58a2 with SMTP id 46e09a7af769-73adc5e9b79mr1827733a34.12.1750864987275;
        Wed, 25 Jun 2025 08:23:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a90c92335sm2258295a34.36.2025.06.25.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:23:06 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:23:05 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] octeontx2-af: Fix error code in rvu_mbox_init()
Message-ID: <ee7944ae-7d7d-480d-af33-b77f2aa15500@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The error code was intended to be -EINVAL here, but it was accidentally
changed to returning success.  Set the error code.

Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 7e538ee8a59f..c6bb3aaa8e0d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2458,9 +2458,9 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			 void (mbox_handler)(struct work_struct *),
 			 void (mbox_up_handler)(struct work_struct *))
 {
-	int err = -EINVAL, i, dir, dir_up;
 	void __iomem **mbox_regions;
 	struct ng_rvu *ng_rvu_mbox;
+	int err, i, dir, dir_up;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
 	unsigned long *pf_bmap;
@@ -2526,6 +2526,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			goto free_regions;
 		break;
 	default:
+		err = -EINVAL;
 		goto free_regions;
 	}
 
-- 
2.47.2


