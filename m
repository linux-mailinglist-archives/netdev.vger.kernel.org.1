Return-Path: <netdev+bounces-179753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B5A7E713
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E843B2348
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2716210F71;
	Mon,  7 Apr 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1C11VZzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294420E329
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043774; cv=none; b=YTXCyEQ+wP6bVLrBPzdG8sMPI57oj5r/4+jqEKrRgAiQarEueDikDuJ/8WPgM7VMZNwchgDC/WZeRbWxlnfqoJSATZljSwSqThrEWD8zXgjv67MspdIOa9t1JzCdTTLVRl7bHvLegEC6tBuy5tQ/83LqLJFa7YPO7B7TjaM6+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043774; c=relaxed/simple;
	bh=6oGWa1hgsn56BnmXY8lh+XdlBOxxoOGhxwAoHOpKV7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dw4mQbXMy2t7ouz/KrVBQOzyOzbyIk7jEbxfRqWhEcdtON2ckyD2iD3KROpUp+8l/ELIO2Pp+HDh9Xhb43F6oQflq/n3hgbXA7lx5+FlgfEy8mrzlb763M7lVQOwfyM52MhBglvlnO48IEwmeXzw3c552lZwle+8nMLQPHhJMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1C11VZzg; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c54a6b0c70so403794785a.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744043771; x=1744648571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3wQWvb/GTNY1poV2c8iFfAgG3PPjNTSAEhWqHMxW/E=;
        b=1C11VZzgoW1zBREQPbbeN7tQW8lTWupdLC8c/T1fk0H6yIVl+5KkTLa7BiW/kpNUUt
         Drbr92vZe0gOfp9Oyk6FMEWTSLRqtw3AdZmKnECzZrdSKOidJXf16KmpURZnYDXGyDdk
         ajQA2ncMQdFR+BpM2Rgr0nzY9zpcfLxcnnNpnlQdW9caJUVi5nTMHAdbwwao2UrKY2wX
         lCKyRDrKBlQFcVw1wZLAlJNEvg15a4S55KzRfep2pEfuMeunRsUhKBXPFod70EnyGClE
         G/2n1x4/1fHAIxsrdDiKEK0IW2Vp8SUvIt8GndEVA2VSJQfBUnllZPKy7BAhcIYuRkmd
         mhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043771; x=1744648571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3wQWvb/GTNY1poV2c8iFfAgG3PPjNTSAEhWqHMxW/E=;
        b=mwZk8Z8mCmNj3ipfHPseElNoDwQpd40kIc7ausTnwC9WWcfEulSgCTPiRmFU7u8RO6
         gs6g5yj2tGv6Krjhl8dFp4C8WT2wIxYw0ahJs8EOywMzsFXg+u0OyIQbQHOi5ytLYaRK
         lvNTTa2I5064KGmgI+QueaXsUyMa8+iENHKd9iXoeE2p8KqDNN5aivmNMkGgYb9I0e/i
         WyV9F1vUGXM2C/JKbcu0X6zEvHGeqPXal8jWEUi/LJzyqmzKCm0Xbd93CV17mLVS8uZL
         /r0tfEcHsslLoGsdTQuHBxn+uj3/6YaodxQMfQbBrAdNkCV96QxhBl4LC8NyIgEVfBQE
         1tZg==
X-Forwarded-Encrypted: i=1; AJvYcCVADsIIIasEww/NWss+w7DVstzhYGZJ2fxIRCbun9cmgvW4of1fgIiKo4IK/Fp5V4A43nsl91A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13PAM8ZXbyr+1xNbHz7lCdVn8nMcy8Rq8cDTHVhiaw8nDBlmd
	hzLqUrg0ZaFaFns9uf0hakJMpo5/VDPVIp6l45QnIRjfI3QKI2e+Nh/az0kRnfglz4o6zgnQmiM
	46QSv7dXRTw==
X-Google-Smtp-Source: AGHT+IFYC1R4FsqdadZNQ1mI5/mbRkKQRk+VGnAUDwlFcAbv7/zEgdH8LfcQdl3P0U3JAtcXQ7Rh9tmW58uh2Q==
X-Received: from qtbca5.prod.google.com ([2002:a05:622a:1f05:b0:476:7693:1cb0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:101:b0:476:add4:d2ca with SMTP id d75a77b69052e-4792598c43cmr162766091cf.24.1744043770865;
 Mon, 07 Apr 2025 09:36:10 -0700 (PDT)
Date: Mon,  7 Apr 2025 16:36:01 +0000
In-Reply-To: <20250407163602.170356-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407163602.170356-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407163602.170356-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net: add data-race annotations in softnet_seq_show()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

softnet_seq_show() reads several fields that might be updated
concurrently. Add READ_ONCE() and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c        | 6 ++++--
 net/core/net-procfs.c | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 969883173182..4ccc6dc5303e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4953,7 +4953,8 @@ static void rps_trigger_softirq(void *data)
 	struct softnet_data *sd = data;
 
 	____napi_schedule(sd, &sd->backlog);
-	sd->received_rps++;
+	/* Pairs with READ_ONCE() in softnet_seq_show() */
+	WRITE_ONCE(sd->received_rps, sd->received_rps + 1);
 }
 
 #endif /* CONFIG_RPS */
@@ -7523,7 +7524,8 @@ static __latent_entropy void net_rx_action(void)
 		 */
 		if (unlikely(budget <= 0 ||
 			     time_after_eq(jiffies, time_limit))) {
-			sd->time_squeeze++;
+			/* Pairs with READ_ONCE() in softnet_seq_show() */
+			WRITE_ONCE(sd->time_squeeze, sd->time_squeeze + 1);
 			break;
 		}
 	}
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 69782d62fbe1..4f0f0709a1cb 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -145,11 +145,11 @@ static int softnet_seq_show(struct seq_file *seq, void *v)
 	seq_printf(seq,
 		   "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x "
 		   "%08x %08x\n",
-		   sd->processed, atomic_read(&sd->dropped),
-		   sd->time_squeeze, 0,
+		   READ_ONCE(sd->processed), atomic_read(&sd->dropped),
+		   READ_ONCE(sd->time_squeeze), 0,
 		   0, 0, 0, 0, /* was fastroute */
 		   0,	/* was cpu_collision */
-		   sd->received_rps, flow_limit_count,
+		   READ_ONCE(sd->received_rps), flow_limit_count,
 		   input_qlen + process_qlen, (int)seq->index,
 		   input_qlen, process_qlen);
 	return 0;
-- 
2.49.0.504.g3bcea36a83-goog


