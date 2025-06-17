Return-Path: <netdev+bounces-198682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B91ADD07B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D38189AC95
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA82F22FAD4;
	Tue, 17 Jun 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2rqk0BR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E042EBDE1
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171379; cv=none; b=lyT/1VgCCmkwrvCVRcjQ3ZJjbf9j9pw9jmncKdmB4FNo2VEHNS/PoqBo5LzzdlMnJztvgwddbyMyg3xjL868v81raBJ+KtbdurmHGbI70RfNcCG9yOUPwC7RYEFFKBgKCYWY6O1NwR0p9bL9A5CODz6UUD5ZpU3girjCn7A+3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171379; c=relaxed/simple;
	bh=S8HYvxTqeZ7r9i7AAfXJjhNKMdRvxq3YNI89CR9B98g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjdXkAmEUiNjIy0MG947k27/ldH5woAhhKusqY8YIxuC18TigwxcX4/lSLOFZcLeXdJ/tusAG5VYezN0k5vaYtvRoDAuwLdLLyO6j+fOYenyM8ic+PLDFhBXjmW/WGqwGtjwQBVzJKUSH0gnJLnWzV46rS2MFfNIlgfUPIVqtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2rqk0BR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60780d74bbaso1596731a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171376; x=1750776176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCtcPIZevXn/wsBH1v49v/fZYOdOVBa0MB6MKc1RQ2M=;
        b=m2rqk0BRa8IRef5jvwnu/wsa+rZ/4mN97/Mdpr+cVoSGTDqvFBrZDEogCYbASXPdC2
         VG42tWOOjRUpD/CCsvZBxD92k9qI0UoHLjG9X5Zo/GIQv6GIAfVDnG9yX9ys80CD3JQ8
         geIvw6e1zhBmTDsrPQWQqWib2ue6aGvojBkgBuEHY4oD191dU959oIGIjVfVfphyin8n
         6G8KaMle67avYwW5VZzf/qDFXtQqRV3r8+N8aiXbJ19BhFdnkGPXQQMCVZptgpvgJc0M
         SKQGzQQgDrf4h4q+7ZRmre8U9YdV2woXol2xC9w0uBgHbnRIFgbk034nP+SFWkb9Hwyu
         xrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171376; x=1750776176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCtcPIZevXn/wsBH1v49v/fZYOdOVBa0MB6MKc1RQ2M=;
        b=L7+l41RFDmSlNQYI1BvJPzzCGKvL3mckISyRcpqunAFZ/vn0+Wn4DLhuCvNOjPsnwC
         TmKij1c1mPKZ2YfcInLwexhuse2UadTJbP+k2pRmHu/KnZryqmHgrh7mGHjd6fTdLg+S
         AJddmnuWBIsqJURlNt3NAZbrwyP097Cx5FinjWwntY8LMLEjIUiBoZGDOCSZ8DF6ULEE
         uFA6VrLsipg0HcvNiUPqRqgZzST/Hur0R41EIHTV6TRNdo+FkEEFJ64bF+Rk1oMRn3IU
         2fk1dfKaUmM8iAWRRr7zSqRZgPgCBrxv4mIOwhJY7cZHs+6ViMXa+srcogy/g5PZyO/c
         xJow==
X-Gm-Message-State: AOJu0Yxju05bliHKZ693X/NvVI0k8XzJriAQt5UniK/sn+4jZ9wrz10d
	rc0ZjIRrKbN0QGWpZtFUQlUY4pkRIStU8UXztsA1gX5o6odOD5UmvgTv
X-Gm-Gg: ASbGnctEVN+5EfzSnxLakTs2JMadRQs7QEIVjyuH1ImLgOEITgwXjjsOZHgkCzvcVZj
	T4pgWq3fi8KRiDxMbeKNeE/sZOagXUGRlZVoAFq+Zg03V5FF7XEj6aQNbF7Js0HTRft2nOoGt5x
	FMRqN2XeuO4EDteGwnnEIBkJgO1yXUTKG/iuPb4pVxNcILfn22ltxfyB/uIjGb0O8dvvNl0I9C5
	2BmYv60eMtTEQsB/vxMwaw+q6HblqrUQEst+Ua1W2/Vyt5Wf8IKEJHBfREg2dloew7uckYnTNFo
	LvnMRLD7n7aAzT2F6fcyPjK9y1dbOHn/rVF4vpG6cKBBuOovk/ERz8Z+Z2RkbfrKI6nRGyN1ipP
	BWlxz+ZhLGiedYsm9jxqKZlY=
X-Google-Smtp-Source: AGHT+IEtq2Q/6v672bT+43FyurJCupcvKTWS+WFy30fZjeI9Xa1nnv/2iUs0RFaVLAKlJ16Gb45LMg==
X-Received: by 2002:a05:6402:254e:b0:601:470b:6d47 with SMTP id 4fb4d7f45d1cf-608ce49dba2mr13520855a12.1.1750171376458;
        Tue, 17 Jun 2025 07:42:56 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60900cdd4f1sm5205441a12.2.2025.06.17.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:56 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 14/17] udp: Validate UDP length in udp_gro_receive
Date: Tue, 17 Jun 2025 16:40:13 +0200
Message-ID: <20250617144017.82931-15-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

In the previous commit we started using uh->len = 0 as a marker of a GRO
packet bigger than 65536 bytes. To prevent abuse by maliciously crafted
packets, check the length in the UDP header in udp_gro_receive. Note
that a similar check is present in udp_gro_receive_segment, but not in
the UDP socket gro_receive flow.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/ipv4/udp_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index ee12847a0347..93e1fea32e6f 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -794,6 +794,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	struct sk_buff *p;
 	struct udphdr *uh2;
 	unsigned int off = skb_gro_offset(skb);
+	unsigned int ulen;
 	int flush = 1;
 
 	/* We can do L4 aggregation only if the packet can't land in a tunnel
@@ -826,6 +827,10 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	     !NAPI_GRO_CB(skb)->csum_valid))
 		goto out;
 
+	ulen = ntohs(uh->len);
+	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
+		goto out;
+
 	/* mark that this skb passed once through the tunnel gro layer */
 	NAPI_GRO_CB(skb)->encap_mark = 1;
 
-- 
2.49.0


