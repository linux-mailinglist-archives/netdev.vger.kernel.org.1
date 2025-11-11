Return-Path: <netdev+bounces-237509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22600C4CAED
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B716A18859D0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2942F361C;
	Tue, 11 Nov 2025 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crRcL/Ix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051B2F28EF
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853530; cv=none; b=uWZOkIMHw3k59uW62AxD+lKQuaP37CkrG8S+SubvuzKLbx6cYcbbHik6gGFZAplRaZQ8j7XPJ6TsnJSUzCVoG8PoQVZgrZFVstHy0NfDInH8Cb6HYVCVK52Dy3Yp+ipIE/rYtMRzP/Kei6qPNyGYQ7mAZtowf2b579OJP41gZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853530; c=relaxed/simple;
	bh=Mpa2VgXh02Cw+kjVb/D0JI1fueyM91iFmcFTkpp8/ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X6O1jhU0FibYBXjjPWgooEA0dMhiZIq5ZZCjXHIWv/+tA7MIrh0C+Ac8I4AHkmwqSLaPCdt4F1CL1gJ4+wuJkx1mCX3eeH0Ze2UPMWU8M7JsygK3DKsQeTIiUtl+Uo3l9EA/qa4qLDVqgHrHDwf2HO1fXbRNQdxJWX7rjMwROKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crRcL/Ix; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4edb366a926so27064381cf.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853528; x=1763458328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JDtQNhsweIy/ZhBqDeh6Zf26D5O569SFFttC/9hVm/A=;
        b=crRcL/IxzCG9NAMiTxiW1tCFhHUBZSCOC322RBZBHsPJgD+NpJsqTY30C/VMSyAaLE
         WbgPHmyGv/j4Do0Uvk/BKCsWYNP3fncLkUwfqDx8rwfo9a36g+pyK5DbIKLL53Ry9RWn
         pfiAYHPM1Vw+gAagoUlaV6pQYRJgIFZI8pLBgLFLa4hfrM2ypo5k3AwA1yBwtPpgULCH
         Hy4xkmvEpNwy+WQ/mWtQVJDLK2SPsakMT1VcxTBy6KHj1SWlXZaF8Ty0Bg4hfy+riRyO
         4THkmA0VNTYygjmj8Zf/RotRkInM5aiod4q1u9JDjWSjNYGI2aFU1P2kEh1vjVrGjISn
         3SMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853528; x=1763458328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDtQNhsweIy/ZhBqDeh6Zf26D5O569SFFttC/9hVm/A=;
        b=EywKSeHy63rvAq8fHFI/MDcxW/w7sQS1wUF+kWumuBR9S0fcQllolLU5XPnbVTesdX
         8rG7Nx89F6PdXoUDfs3ZQDBUSNdCncQzHefv1oZVUUQ1s3sXzW9hNQ996ZSneirRSVA/
         6jz2+bDXJz/Fmzt9bpPh4MggL7xkfI8W5yS+H8J1lH+51Y8+blFOCRI8caBzBHPFM7tq
         TgTJaMksuLgKm9nfFkMRQDHKmkK4hjnht6ZFmL/kxFIeZd02tRUz0Fao4lOypuZrLzae
         hzDbzT1mzfuOqdDVGh3O44hbR69YcT6Y2ydKS9vm7nwVz+wVOclbs3oKm6KGWxcI95od
         hwUg==
X-Forwarded-Encrypted: i=1; AJvYcCUPocLc1CeH+zlmUpr83XqzljeMbp265GbeiTzyWTqFdgaLRbPa0JFDqFmY2zoQBOQF3Yuz3Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZdOcwf9E7Ccyz4lOJ2MfmFgRraVnWKlWJ65j/RVW+UxvbK6V
	FcyAK4JWxTpnmllW2ZZp83jGUGkCOyVyaSSexB4l/9+qOWQQ823mZ/BrZQ+5Uiwa865Tom8FbPb
	f703yMOd+Q5pj4g==
X-Google-Smtp-Source: AGHT+IFsenyrymBbkOjo6F/tX1pAcHisYTZx8ctys1y8HD8erNisb1dFLo/ziTVrb5CuT6xi3TA3egjR+yksXA==
X-Received: from qvxz14.prod.google.com ([2002:a05:6214:40e:b0:882:2f2f:a04])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5945:0:b0:4e8:bbd4:99ea with SMTP id d75a77b69052e-4eda4f7aa47mr118984351cf.44.1762853528387;
 Tue, 11 Nov 2025 01:32:08 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:51 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/14] net: init shinfo->gso_segs from qdisc_pkt_len_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Qdisc use shinfo->gso_segs for their pkts stats in bstats_update(),
but this field needs to be initialized for SKB_GSO_DODGY users.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 46ce6c6107805132b1322128e86634eca91e3340..dba9eef8bd83dda89b5edd870b47373722264f48 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4071,7 +4071,7 @@ EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 
 static void qdisc_pkt_len_init(struct sk_buff *skb)
 {
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
 
@@ -4112,6 +4112,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 			if (payload <= 0)
 				return;
 			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+			shinfo->gso_segs = gso_segs;
 		}
 		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 	}
-- 
2.52.0.rc1.455.g30608eb744-goog


