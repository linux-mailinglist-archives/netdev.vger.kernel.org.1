Return-Path: <netdev+bounces-237510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2420C4CB38
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF80A422BE1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AEE2F25E4;
	Tue, 11 Nov 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="en67bjli"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBD2F28EF
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853533; cv=none; b=jK4l6UpY40UzzXM0+6PT/jy1HkorNakzWtoQZ8kp7pAaN3lgGYAzKn4pcYLyLmUcX6MdoHzqpS47XQtBWE9dNGHxOR1d5ZxlgFaNpPEJVS0vgE0SpQKTWhmb+iMtpQYC6JTPru++aUaFzIw9M8QbDIDxC/luOCHSNhKDuPc9uvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853533; c=relaxed/simple;
	bh=bgYXhN7DAZ+WgOnGmwljraXrwchhc5KA4eO0HAkqfPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MmaWQhT4nMPBM7z0zntzWGvjiaUO6J4D5r310EYj4TpJa04MQMvH+uKn2DyZkS4U4Bqhgzf3l+9m4nVAg9oXdKFDU50JDNi+eE44s+TzVxPhPdaNHSHKAOnEcLt4tPU2eFxJKcwpWdOhewEu6ByMMonss8Ue/Af0da2IhLOTZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=en67bjli; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-787e3b03cc2so38202237b3.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853531; x=1763458331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9k5serns1lzAV9o4e1nMiPmvbwZmqLdVPACTPKPTIww=;
        b=en67bjliT9HDCPjE7xKPSH7n9aM8elQbNfu8B5GOPe7oViqkglGnYpfwTTdZ5FyOc5
         nrTKyxDL5wlBD5Y++femXDm9/39XKC03ZZOPmTh5yq9ZDGt7PkLaYnUJWbSU1eGxz2/I
         GsbtUT0kgcIj27TEzsC+doe5mor4PoqSbe+1ZBfdDPg4WZA7ec7p9J5LA6/ZNO2zgCxj
         /GLnHa6qFo9t5LAswGf6l8xRBjey/h5cAzx1qpnEMrED+WCaXdLZj4DrSjpM3V61vhSg
         sLNzzRsDf0PuWO/+aWnsVr21avIqPuJ/VizfTXZDkGOxlPbfD635xnHHiiafG+GPsU/y
         mzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853531; x=1763458331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9k5serns1lzAV9o4e1nMiPmvbwZmqLdVPACTPKPTIww=;
        b=Flix4y5dkrmGofr408cZB2SaUgytSaP4sqA+wpY/fynmgrQcDo7ouL+yn/2wYALYrm
         2SM1YW7bVfsOcwVdK5kPTlTxoRcRe4u9dnPDNzmqx8dYRFHuUSFOp6qR7luJiaSaLB45
         jqpD7awlrOHxS0MVBDGxf89uYA8pvDZGI4thei1IWf6fu9UL0wDyrwf37ACF2NuKFyjx
         Gn/ibkU8WXStV2wfioGEA073ukWNfENacP1GxAnxpxWtyMdgT3xDV/3akXgsiASCvZp+
         Jfag+AVBXiWx7XjGDYtjOKOT7YZeLekoeEsWRwCmspDpIBPygeHXUQ0qtfpPfxjjyzxs
         Qy4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4uP1GyRkSP4dY8aTQZ2h1EAg37YndZY4LyrtqVPde70ZqzYoKMM/OT7DqhWlDSiFjRDWbUco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkphJ2eDEXj4TQtHLS7KNyjP5NE5XmX2A3xkaHpffL2CD8oU+D
	jsk3CkAxFx/8+iMFRWVKdKAl3TW4WQu9nHMG2xsb0CPhrSI+OpjDHZi5HYgOAzscsua1CIeMQPW
	baOPenE1sUUfCjA==
X-Google-Smtp-Source: AGHT+IH3eVfK/nSyeMLLrL573+WSR50MiG+tNE24GUWgLG58N8cuoftPscQLHtzCORb15v02hHBUVk08whrMfQ==
X-Received: from ywbig19.prod.google.com ([2002:a05:690c:6993:b0:776:15fa:b9a0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6104:b0:786:5fb0:3c08 with SMTP id 00721157ae682-787d547235cmr111292177b3.63.1762853531270;
 Tue, 11 Nov 2025 01:32:11 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:53 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/14] net: use qdisc_pkt_len_segs_init() in sch_handle_ingress()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sch_handle_ingress() sets qdisc_skb_cb(skb)->pkt_len.

We also need to initialize qdisc_skb_cb(skb)->pkt_segs.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 895c3e37e686f0f625bd5eec7079a43cbd33a7eb..e19eb4e9d77c27535ab2a0ce14299281e3ef9397 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4434,7 +4434,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		*pt_prev = NULL;
 	}
 
-	qdisc_skb_cb(skb)->pkt_len = skb->len;
+	qdisc_pkt_len_segs_init(skb);
 	tcx_set_ingress(skb, true);
 
 	if (static_branch_unlikely(&tcx_needed_key)) {
-- 
2.52.0.rc1.455.g30608eb744-goog


