Return-Path: <netdev+bounces-230722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75437BEE548
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED971882D9B
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725112E9EB2;
	Sun, 19 Oct 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SICaXqsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9FE2E975E
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877954; cv=none; b=GiCcopEm7lCQrrJXjbJr9YLxemRcB7YolLc3NT8gBwS9+rwZQScabRFM1d1DwdZvT8q0D4GXxSzD8mbq8vzKNtCQFwwl3mAfWi8cwUYZ73JdBYRoaFl8w+L/Vn/AxVoycZKiiwLr/r9muZdpb8OLh1ez8KdhSU+KnPXOdrjie80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877954; c=relaxed/simple;
	bh=VdhgCh5igynXOF2iMev16IWqabCaW2VmlB5DgdeCH70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGqZ360dMypr0MYkkAJ9pEXnUp8kyJbXDookLrnpStcKbYWqcNAYRQUrdAqtV4RkUcLI4fHzTjapZERFuEtmiArrQmZ51A95TBRxBKQ6pAAUYUizKJTIAZfWehiQ51IJEjD85rkLYj6/lFHiWyveQbLxlscwmB992FcoaPdgihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SICaXqsN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b48d8deafaeso760748966b.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877951; x=1761482751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEP+YuEvAXyPRZ3cLGjoIMoos2zswfEJ5lWYwj65gVY=;
        b=SICaXqsNKCnhAkMq8pfRxgHek6Udfs24qr2GA3Fc2TVM/NJGtz9c8wGe9GRbozHYng
         NmjYoy1hwzeJpgbB0Cu5dFmh4byeE/lbY3iUfsC/RvyWVSdTM9k3PMAEwWZ7eVRTtlGZ
         fG/pXg2rOgqQ5958bkkCyArmq1dqARUl1aK1JgWj+ig99PqR1m8BL8LTvFzSvo8U/Eof
         iBBIlOXyhwyT6JVnxSeGe0ydEflhgyoxS1MfHHuGNfX+JwSMcNI/Sx9jaAdltmFIlgQd
         kLNEv7noDeMHezevt1ifturkfWzKNhHhm7lJEn3EAaxAwh8JEymOjunB2G3ESiA4mT8i
         ptJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877951; x=1761482751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEP+YuEvAXyPRZ3cLGjoIMoos2zswfEJ5lWYwj65gVY=;
        b=o9GY9E3nuoj9uKrEgMBzgTfgxVg/tB/iCZuc+yaEKs3OssL/wOfhNDndrHUoLPVHyY
         tS6NDKcSvfZsG9QrtXuzNi7AzxU86z4IMmuJNbLL8tCvOEgLkISuOgu/H8ys3cDmlFlI
         9T7WdluZZwrVha4n9RmcS7fmpHSLWswxI2z1DaycX4uqur6EyIdjthS6kHYJIbZu4bl3
         //DqZE958RIAtHg4FouDZtKwFBw/cWtpQxmiOfSDMjT3WxpjPDmGCh+eA91DlnuO72yE
         F2EBtX2aqABrwjasVLvmzbb77R/dP5HRvBBv5wvym++yK6UMv+pBl1KJmemBpviIEHOr
         aU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlRisdsxvSyQLC2lY61ZuDc/hp7DgvQHASQ9QYqsJOxYvjSniubkIRydq0KddMIaztRHxOb8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbsGgGlS+JO3IRmqFt5+AOKRSTGqLZA5GW1aVHRnZW3oCxO52
	vONjGjiwVOFyrXSANmxxh/TFyXV3G7eeyfp2Xl0OYiw2G8Hr0JZy5WCMTv9+wSYiBiz+vj+v7s2
	VnTxF
X-Gm-Gg: ASbGncuzoA2zTDW+SGhhRl1IQBXR7Og5R86pC4n38Zk4xL6cpt0B3CZQwnD6g7VuLCa
	oUeFPFo0HvRLudL/Uyjhie51fDI7HJfiaKMAU9ALNQ15FMAVnSI28c+FSoR4AUPPPlBULXbpeeF
	Mih1RJ/xvocs8I6szpjmtjdHAXQQlMF1p+Mf+/60KGwkk+zs7hdHzmnwezDHHLKDuNys6ujBISH
	p4BBkl6PeDY6hLIS5FrZiXxT5xzGnB4wx2XFzfzH4E+aZ0Y8034kUbBKe+koeT4+pxET68eCNXu
	4ajTfqA/jJbQw+JQCB3YelbCl44YNEWdV+tLBir9UuZsh7cMRtDDk2A98sVPUQMIN0JlCBJB4Ql
	iHrgscDNfH4LokevElJEH0ujMU9RocdaFfs6DKwiL0CodKL9DG/W9BcxO4bTwKLLHBv7+gVSlkd
	XklEvsQQnRV+Bszyq8EyaTNENI5F/TH1LRFqkbJ/ZzcRTWJ65x9tns7s8mHBo=
X-Google-Smtp-Source: AGHT+IHvHElXlhRSAxIGYDBNoBZ81YTQ8vkZv8qr/x43uzbFp9jlLZe7kbQzgqdtZp8ZX04/DT0Rug==
X-Received: by 2002:a17:907:988:b0:b41:b0c4:e74c with SMTP id a640c23a62f3a-b6473b51bebmr1187777466b.33.1760877950768;
        Sun, 19 Oct 2025 05:45:50 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebf49fd8sm506207266b.83.2025.10.19.05.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:30 +0200
Subject: [PATCH bpf-next v2 06/15] bpf: Make bpf_skb_adjust_room
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-6-f9a58f3eb6d6@cloudflare.com>
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

bpf_skb_adjust_room() may push or pull bytes from skb->data. In both cases,
skb metadata must be moved accordingly to stay accessible.

Replace existing memmove() calls, which only move payload, with a helper
that also handles metadata. Reserve enough space for metadata to fit after
skb_push.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 76628df1fc82..5e1a52694423 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3253,11 +3253,11 @@ static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
 
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
-	/* Caller already did skb_cow() with len as headroom,
+	/* Caller already did skb_cow() with meta_len+len as headroom,
 	 * so no need to do it here.
 	 */
 	skb_push(skb, len);
-	memmove(skb->data, skb->data + len, off);
+	skb_postpush_data_move(skb, len, off);
 	memset(skb->data + off, 0, len);
 
 	/* No skb_postpush_rcsum(skb, skb->data + off, len)
@@ -3281,7 +3281,7 @@ static int bpf_skb_generic_pop(struct sk_buff *skb, u32 off, u32 len)
 	old_data = skb->data;
 	__skb_pull(skb, len);
 	skb_postpull_rcsum(skb, old_data + off, len);
-	memmove(skb->data, old_data, off);
+	skb_postpull_data_move(skb, len, off);
 
 	return 0;
 }
@@ -3489,6 +3489,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	u8 inner_mac_len = flags >> BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
 	bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
 	u16 mac_len = 0, inner_net = 0, inner_trans = 0;
+	const u8 meta_len = skb_metadata_len(skb);
 	unsigned int gso_type = SKB_GSO_DODGY;
 	int ret;
 
@@ -3499,7 +3500,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
-	ret = skb_cow_head(skb, len_diff);
+	ret = skb_cow_head(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
 

-- 
2.43.0


