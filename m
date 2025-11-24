Return-Path: <netdev+bounces-241214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7269C81915
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9543ADC03
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966CE3195FB;
	Mon, 24 Nov 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ty0MqThK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BE3191AD
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001764; cv=none; b=ERg9ubXi+Zlb5DKaEjMjqYicOqO5fuur+yLWctjJwRX6YVJv5kAJuofmpv76cc4CmwtRKIkZ9G2Mo0ztafPHLmkaPnj7LaPBpDg2kTXFTZP8SGAOThLQF5VV3f0ORKHzvPwvsyHPN0dcpl9ZGcFJnTk0F7p1UNAqaH2q+lR1XRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001764; c=relaxed/simple;
	bh=siAN2lprPGM6krWgoAADuuRHXk+SkrIZe41bcexqBzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehrFIboiuE5VhE9ANW+5nE2BHECtFMAcd/WjlAUMeECeQweJlTJywwCuyH+v/XtrNxtBPltcV/OTajLHzqY0IAflZtsV5BE8SAeShKxQnOKkDNc27XE+Tb0+8/s5gk5Yw1nq+GznU1cdYnxIRI/Vvw4pznBKH/Y/tN14ONZLqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ty0MqThK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so7906464a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001761; x=1764606561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6N7Aw7VCdEi+8zUwkNv8471tkOa9T3A0JD4hDqceMBU=;
        b=Ty0MqThKqqFbIUKMy77LcvAZlOqZn9qNodfhAcMM7ypIcaM3+37AJ1rFbiX4c25aLe
         nV7GLl3sAP8CtyAJeZUW6PmxczAiDeKnLdnuwZeN7Z4n4/52jAj00ZZ9dcCqy1X+Owbb
         WXI72VlAEwldVdD3u0siy5+tuf2WejBcDO8xBfUyUWotsERy0e3WHrLn7AjidUz4QgWn
         gLFp1nRaTkyd/bCeWBubdjisbS4iKr2JhY44ZGSBpJGAPT7RRu6FxB5d/dafl7cO4YJq
         vm6yLbN3MgqOeqjUQBVxvqrREGYoHq2E7jSskwMP76qXv/WL/1HtxF3JJ8ZXqe4xGetu
         spwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001761; x=1764606561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6N7Aw7VCdEi+8zUwkNv8471tkOa9T3A0JD4hDqceMBU=;
        b=mr1Fdb2ngaAZQudkjK8E7/KL/zRGfiB23A4HqfpZbK4FIU6gj+WP3o8CCOq1rgdtO1
         puibZIMYkG4THl8JUhae5OpkyRzBPWXN328vl6Jv5SChq0LUtXhNZ3NwZOOH7pQIwXQ7
         d3iFZa5USJ7J5FsyexkNdWFqA2iEqPLD/kmenW0vYlOzPho8YfdbF1zeX5XIlRph9Nf3
         hq0UQyuDzWbHCAHtIG1zASjvOcGUTCXzomDBuZ0+xSUY8JpmvtvUFct9xOLVUBhEiuRK
         7yi3CoelURbS7W08CYZE7y3slISx2vGD55MflPD21xO9VfYZRIf0zfp+ci1QVNRR9Ch6
         YVLQ==
X-Gm-Message-State: AOJu0Ywh583Zl/v0g4lSLvFCecvZF2PfeM7iZM0lcM825VCuFtoG64tP
	iQv3+m9R8OwCNKGUCozzmoAgdE1/lkC12Z/RNIlgH96Y/vUSVXMWV3KBZyaICTrTC+DduLkVA27
	EIImf
X-Gm-Gg: ASbGncsmI+ieu8dcv8O6Uet4Rzymb3U8rXQMYWRB0INN8mRxz0E3awksuFNnCbVCh7Q
	ocQQ9ZSQxMLXBnTnu+WCtUPHJhm0OzA7R5MWiN643owi+LqeoLKsD6wHf9xJxTjVXMauysqYy+e
	e03Af+JRW3q7h6qz7iF5r3g6dDMoZ6Gldszauh5ICGkberVO2NNlvUWYnv1YX4YFnmnJcTTxnVL
	1t078ZfEy1RUB6cTUQpAj+wY9+TwIvcsCdos1swmOouqcB4LWRA9dOmALgaqTfSbC7Dr1+BdPhn
	F3+HGC5Cv/2TXTzaHgpdZMA0yyOHSSdOiol84bFlT5R0coRbWTgvPuFN9tgyxlreiuuHq0g3xO1
	QOqOq6IEU/LMd4ROydzRlZ5RmoQbtkJZsjt901/1m+KCFQk3S0SmQt05a6cKRPdfvdsuk5eGzaj
	xAjSQP8V/P78flq+FFG/SXvj8DCr/d4bEWZBIdIME4NlNl+pHPQ2+NCSwY
X-Google-Smtp-Source: AGHT+IHVoXb2rKmo9YLPEb6/FmaCqZgbpJAvVWTZlimX0ihtCH8UoPWxTPwxU/fkG9oCvS4Nl5p/1g==
X-Received: by 2002:a05:6402:4310:b0:63b:ef0e:dfa7 with SMTP id 4fb4d7f45d1cf-645543492b4mr11307240a12.6.1764001761119;
        Mon, 24 Nov 2025 08:29:21 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453645f2easm12373165a12.33.2025.11.24.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:20 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:45 +0100
Subject: [PATCH RFC bpf-next 09/15] xdp: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-9-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
points just past the metadata area.

Tweak XDP generic mode accordingly.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 69515edd17bc..70cf90d5c73c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5461,8 +5461,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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


