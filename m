Return-Path: <netdev+bounces-230719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113DDBEE54B
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE853A7C79
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CED2E92A3;
	Sun, 19 Oct 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HSifWoG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468C2E8DF7
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877947; cv=none; b=rhixwxnOrn2e5HbAnA2C5U2DJrMAXBBx/kAvnebZt+VKVAOWZNg3WZlcr8ykjUfRxmFUCen31vQjAt5qZ4gHPSyZeRHKgkGGajZrlwl2RoPWCzXi7nmFCMY8CQ3HhKBmqrH8qHb3O5+tdKamcsyRvktZRs/W9ctO7fefWIwCqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877947; c=relaxed/simple;
	bh=jphV3hLYyJpq5wHhzxxIdaldllEhemXAkq3l8pQxo6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzi6J7QOM3Y+TWUKTSgoASLHw1dJBGOP9a9UOVtngPryjBTUreSOHR2YS348wunycK2LFaAcHDk8I8h8I3swcuLOOoOOonUiioeYtB/wU16PpxAPY0NKXJe7rifGe6/F0Kmcnt4sFY5lQV5KTxqb7eKos+/I4wZugG8IFULY/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HSifWoG8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so5682343a12.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877944; x=1761482744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=HSifWoG87oYzSQPt2+pXg+u5vyI+8Gd7ohQIkKMzV5RqarNMQRpIaQjPsaib1ASG7E
         cffFffENi5yYcmkcMWZ/tjVaVT5TLqJ8bPQqe0zhDSgh1KgyMBnB8rF2fBJfcrbG2ThR
         s8Z9bTbXikk7aJvOZJ64elTgQu6wiqk3u9KkOru7+w0TRj0q9phQ+6fOc5MnF+SVASIr
         x0xweUtYnx+Lad0D1yFasJqq9XMIJr5MOU7DDuqRUrSsvZ4D8GeYHmc3r9BzO25ii8J5
         hM13AJAVLhMYDwV9nee+LCSGYFIVm2UyzhEPVG8sRV6VCGVaV0i898zDsDnroNzaQBeG
         pkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877944; x=1761482744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=I0gK9CSP7n5+B88ZpSfbFkb63fLO/LxZHV57cCFhHYJdlkr4wfgS56kp4nWq2VHwD0
         YGZI8EPuo1jTI0LQLenA8WoviDMfK+uFss9WpGstbGiN2vJsBh5hLZM7kprYL1HpX38u
         fv/1bE9exEQDBzG+1xCfXJ7sgX419WKu5a1P9lLxu8hNNkmeeB/YLk54hJ8zQUSDrl3S
         uLV3ZRjZcR/izOX9mYkwps2VrJvB233m+m1DabUk2OcIg8GgNqq+37FsaKIBWjlCh5O8
         XSSU6SZTa0yUIvYsAaerBdC2aDzq+YohPe9Pb3dhC81T1kzRVUS81VfEMQysvmr+Q6R+
         l8+g==
X-Forwarded-Encrypted: i=1; AJvYcCVr3nwh7/nHTNakPgxUtghfkeB0HPeG5sDjfsEFqnkXfiywpg0zFd8cFi+pDKEvDjvgrudKLYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcNvAFgbv21lodJXipgnx4/ircJ2ldxMxhD6XwTCxHe+Vwrv/
	73QmhCcpfmWNd8GaUVgMYujjkYV+EPGnP2DeX4Ob+7lOAb2OVlkudEU6WbWiFCVKTSO2ZZYGCNQ
	iA6A7
X-Gm-Gg: ASbGncuILwNtved44yNsf/vkzcNnvkGDgseyzVhUAvbSe7j39jCdj0GO0sh7+XNm6s1
	iVs0Jf3qtxnKMEtEnBrnvCCZ3Q7CkSuGGEvXwlCqFj9xYnHqKnvXgvRNwDdnitI2ORkOwt2MGLq
	ng/NlfooYqNSqz7wGY9ph43W+cORZOPggw2E2jpa+5net4miUX3f2oOdGiTWeXnROVDoaNeZtTK
	vrY3XYONA85BaELXrNTzAh31IPMB6y4UrcXSdsG0P8Dh94kTUIE1h6JE7gUld38lOPK5OqNrZn5
	7uu3EpXu+SoiSTNSNKLzc5ab8lGDA050PH2qmOwlOXDzABgCnPu0beoKmpZm37EWpmitOtIE41l
	FtBeFaXHuwNSSWOgXzjVkJERgye3Idy4C6s3fC2Eq6mGVBVqYNEfWztXWTQ02B13eJWCpLcY4rS
	hXnbbWPPU1DKpyuk1FBNknR0M2XXIRdPmbuElWbAQNGvYO6+cFkNCW1ZQDaUw=
X-Google-Smtp-Source: AGHT+IHDHDKD/znwzM4+iLDwiLkJjDAADYiTwF+sD9fBdMI4F7B5OeZOPbxgdItweF+UzOxae/2P2A==
X-Received: by 2002:a17:906:f849:b0:b49:86ac:9004 with SMTP id a640c23a62f3a-b64764e33d6mr951788166b.48.1760877943744;
        Sun, 19 Oct 2025 05:45:43 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da33c6sm482809066b.2.2025.10.19.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:42 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:27 +0200
Subject: [PATCH bpf-next v2 03/15] vlan: Make vlan_remove_tag return
 nothing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-3-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

All callers ignore the return value.

Prepare to reorder memmove() after skb_pull() which is a common pattern.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 15e01935d3fa..afa5cc61a0fa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -731,10 +731,8 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
  *
  * Expects the skb to contain a VLAN tag in the payload, and to have skb->data
  * pointing at the MAC header.
- *
- * Returns: a new pointer to skb->data, or NULL on failure to pull.
  */
-static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
+static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 {
 	struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data + ETH_HLEN);
 
@@ -742,7 +740,7 @@ static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
-	return __skb_pull(skb, VLAN_HLEN);
+	__skb_pull(skb, VLAN_HLEN);
 }
 
 /**

-- 
2.43.0


