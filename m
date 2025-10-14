Return-Path: <netdev+bounces-229226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE124BD9802
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 436E8354AA3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A271313E05;
	Tue, 14 Oct 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwMl9ymu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40514313E33
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446836; cv=none; b=gbhmX8HvhpEw6TsqdcktlzWNQWsNK4shqHe0JlZlI2ebDna0QD5ZxNLzkZdU0IDCs2U2AtUk4AkDcMMNfXoYoaGQC4T0rO2iY7KFuU2BosMPb2seRT73k8QMfam9ANkhUJGauR7VqViUX6jGxgYuMnKD1DOM/OGauoRNjBZK3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446836; c=relaxed/simple;
	bh=8sl8zh/edgEOL187hvVRKslTd9Ju8bi2edrvqaXpJ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK7yyb6WKVISk19dgsjb9j2pRri0It6s/S7g9pZ4PkYxdnf6TFRDlghkRNn9FkFBIi6Zy6MDJBQMaUxwN4chNyPySeBzoNjnXigZAidy7V0pt5e8Te0gIYd6ZyfuhwpXWGsxhESEAzF40RxeqiichqhEhADjx1vOL2R4YAaAfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwMl9ymu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426ed6f4db5so467452f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446832; x=1761051632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eHv7iWS5Rns6GMFeZ+EPNWQuD+MpI0tmNw4Ue2Rubw=;
        b=DwMl9ymuaASIc2CqbtCQf1Q0NTrmkTfrESnUsQYjUkvV0ApahXP6xW0E3QPOnporiB
         0PzYsKi+aSTzgtqgkViD//LVF5kcoRy79xtjDQtem0iW31PWu8X4j3EX4bZGQS/X0t6v
         ShL0duq0RxfW7nnAt1InePAj9lJ624pP5V6KOL0KCVaL2rD9Sltea1c7IYiGOB4uHi4V
         iqDVPpFCYFaZcqFlIVlFwngwdvZ5FDZJQb75DT9tTTuRxqQOlkL+V91CqKE0wUPFeAPy
         eQ72Miuckzpc/GWI957KVCx6ESACBSlevvFz1LagIDXRt1/dAbbRufmAkBFIGE9dayfn
         YSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446832; x=1761051632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eHv7iWS5Rns6GMFeZ+EPNWQuD+MpI0tmNw4Ue2Rubw=;
        b=lGPX+H5k1EXnRwq6YLta1GEvGZXvNy6oxT2kJXiyeouwvhB0VTxI9uMlkI7Z9OBM7L
         I3xPwzJKUuaj5myKKxnuNYVrgxCk0lRqUX5A+j+pOpNnb1+wnlF6aFnuW1PH3iz8euMO
         rABdTqEr5WRAkKRQI9/fmtBBGR1GGxq7JXt3P1z9PA71kCMFcSOyfe7pmJQbWzjFZknN
         IkUVl97OktPjtOArYRmG+9PyYAx/HfU4gnDsguRiiUpw0y6FBuQWd3iIFy9R/GitrEnp
         WIALCRIFy8DPz9EFfr2nlb0R//8aQ3OnYDwbFqaFjliWYdfDhS/VTfBJ7FMooLYgf4xK
         SPyw==
X-Gm-Message-State: AOJu0YxDyt/LBi+zqf1JRKOz71L2X/on5P8iP7aJO0emrBYRaXtmgAuL
	UnOgB5oiAwdx3fXIGwExSSLTRsH24kjbGH/gDIjruSRjWnMMAK6bPbssyNygEDFN
X-Gm-Gg: ASbGncuCFJ9cTqEOTIaoSuASYxeyXEmJMAMGgIJ/LP//+3xNnVZ2mNnYL2J0MrdTwn9
	uaAgyvxBg2C1shZI3AVplP5aB2piXJe1lJQ4nfx+71nN5rBIOPXoYhsd8K3X/ZDNRPtrWRhXVym
	AYBd6/UqmWECUEEWuD6kcgiSSRk6tVm63V8WNudwhGlKxMI52kvI+ZB6w3a2G8fn2Nva6GiEtKY
	LiEIZ2BCMUZngPN2o0nVf4QDxw0w9FxZ6esLFc7mK9M0mhUy9nAYmXCeKkX8Izr8PtVGbqMTpgL
	iTHJg3fH/7NBuV2g0Iwhiapl17txjzShs/s8Pn+d5NBxO4kH9EMrx6Fb/HVSn7MFTU2ZqvoQex1
	DICUaQSUM6I6lAxjBg4bZ50mWQzIg9DaCF7g=
X-Google-Smtp-Source: AGHT+IHTVOrXrZfK+kAqvvmeegQqbXJ5u1kSQeQq4d6GAFTvHJqKybjw0WNnBMaqSNBLp4I965jdvA==
X-Received: by 2002:a5d:5005:0:b0:425:8334:9a9d with SMTP id ffacd0b85a97d-42583349adamr13032753f8f.1.1760446831885;
        Tue, 14 Oct 2025 06:00:31 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm23296494f8f.15.2025.10.14.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:00:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/6] net: memzero mp params when closing a queue
Date: Tue, 14 Oct 2025 14:01:22 +0100
Message-ID: <80f18e7ee9bd50514d7dca31b5f28c5b0b27e3a5.1760440268.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760440268.git.asml.silence@gmail.com>
References: <cover.1760440268.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of resetting memory provider parameters one by one in
__net_mp_{open,close}_rxq, memzero the entire structure. It'll be used
to extend the structure.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/netdev_rx_queue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..a0083f176a9c 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -139,10 +139,9 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
-	if (ret) {
-		rxq->mp_params.mp_ops = NULL;
-		rxq->mp_params.mp_priv = NULL;
-	}
+	if (ret)
+		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+
 	return ret;
 }
 
@@ -179,8 +178,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	rxq->mp_params.mp_ops = NULL;
-	rxq->mp_params.mp_priv = NULL;
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	err = netdev_rx_queue_restart(dev, ifq_idx);
 	WARN_ON(err && err != -ENETDOWN);
 }
-- 
2.49.0


