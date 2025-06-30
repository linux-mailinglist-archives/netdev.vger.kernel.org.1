Return-Path: <netdev+bounces-202509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D4FAEE19E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03585188FD23
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0DE28E572;
	Mon, 30 Jun 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eXPjpdUa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0E28DEFF
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295364; cv=none; b=nefiwxPacTdmqLXAOjY3W2gP8iAAzSr9JYAmmRp+z2KjdL269Zet/nXG4vGh5VdG2WxdJ0Y47zQ3/M/wLhUhzAvLphk6fEaYHWj8r5Pp1NKH/Uz7KLi+dAQZyphLB+X59pJ9cGI9x+K1OWwg1MPTEYw1eSa34sjkTrsLxUds/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295364; c=relaxed/simple;
	bh=a3ROTLqAavkp4rwfffb8mrqANhf7FzXtyeXu16Yhpac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7cXbElMkscVa2USazZaOXvVBydWeVfMumo2A5VT/vtT3WZNXKmodm19IRtwJVuNYrui6kmTJueGLkt4ulJ16QbWbfs1yEU+eAerTB9T+FReWwJ4k9pISVyxGw1eRh4WJsZqcqTTVqbrNWJLC8lKBwplFNTOIJHkNeTaWFy2E44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eXPjpdUa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae223591067so393492966b.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295361; x=1751900161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD26vKIyNfL79HGbpDEINEAFFrRHmSLhjJgTVN9WS8Q=;
        b=eXPjpdUaQ/Jt3viyMeIsItSLO8b9ayRfwssZTkZ4Gx+ikKV6eBpbxTqdFaVa51f6BO
         4l2y7nSenGqgawwIsHJKytL0Fb7KE4SM9p/xiNaxjRyNlCZiKQCe2pF+Ilzrx67/trzp
         6OkGnk0ZaNju8e8QtY38jSRYRtt52uoRf56ugbfnm1JqO7EcXy/+Zet8OZjMW+dBq4wE
         NijTJH7ue2NiQCJWw1XSyvOAeh2KrMd6Tlu0E6XVV7gBdA6l1ObL6py5zFxhJrQJL1gy
         3Oo8Q3/ShWLo9kBMmlaVDMBsLqMEt97jGgGqYgjAvu0CyYZb+iY9nZlohrDK//YGSHu5
         npDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295361; x=1751900161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iD26vKIyNfL79HGbpDEINEAFFrRHmSLhjJgTVN9WS8Q=;
        b=S0/yyujI0qjNgGX5h/CLeiAxOUxvddmC608eG6+MV813RADaEdngaJXKER66FkTDeS
         wqKykdBvfkgv7K5FdWOOm4Y0IM9zbtDRjCpUknitzA+lE8jisS686mY/sXvzvMiI8oTs
         +juFXAy1V9TlHF+gwXVX9AWIAUU1n8Y9fAol+9kRWpE3T0MEIIxewoHICIZvoOOqRHo3
         8yt7B5p7KcPUmcMEu26xXc3gsAu/ZZjcMLx5+f/VCPy4kiUsgW08WyIU5Mxri68YJmjo
         gpWBgewq1dBvULOcmuDPVMmrB0EITDzGILoQjn9AIDeWCsdiHXRFyLC22JHSiC9y7CCv
         b01g==
X-Forwarded-Encrypted: i=1; AJvYcCXBQ+7VUkoEBLQVUcerWNP/jPg5xY8r4467ptiL+cEFvBdUGCn2GAQhl6DaZXzl7dN0lFgkvIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtEV23jqfKyfuesC2tI2r65JpCU0Mt2TE8EiSTN4jBp3XiLgW
	e1Ihxev2WqUjvukYYNdOJMHp5eOKM0xGasjsY36AjRrdLDCA/zN0nddGZ6CfEZj3il4=
X-Gm-Gg: ASbGncuEqNOSSsN9M34vuymb5oH8QyD/SlmL6BzyEnBBLDvIaYSqcl8cY8w3/e5YK6L
	DVcjik3YM9Ah/92fuRZ47Veru3D2KRT+AsxB9AzbS4ipm655M9vEO9bt4jG34tdzyargYFcJyNO
	QuWUgVF7M4JxpBQdLetleVUBDrxjqa1gDZHzUcdn6uDtSEUeMHo3v3WXSujzzB+jmvLZ6V7Qo/M
	htWmwk/svucXx+3VwXwkZp1fqF3iYO4myqA/yWFa/72mpZQ8z9bZDYYSXcoCDUXbhuGBQcG6AIA
	Kq6/z2RgoaJJM/l1UedyBkBFX5d3qDYYzn6ICdJS8eYmeMFM178dFg==
X-Google-Smtp-Source: AGHT+IE/Zb4rMlxmPjOzNJkDM1x0qOLrMzF1G2hhd8OLqR9/IZ6Ax0J9kuqbvn21eDwI6nQWBwUXDg==
X-Received: by 2002:a17:907:968a:b0:ad2:2146:3b89 with SMTP id a640c23a62f3a-ae35019cefbmr1245806366b.47.1751295361273;
        Mon, 30 Jun 2025 07:56:01 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659fdesm692689966b.69.2025.06.30.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:39 +0200
Subject: [PATCH bpf-next 06/13] bpf: Enable read-write access to skb
 metadata with dynptr slice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-6-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Make it possible to read from or write to skb metadata area using the
dynptr slices creates with bpf_dynptr_slice() or bpf_dynptr_slice_rdwr().

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index ab6599f42bb7..020da46f93a7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12033,9 +12033,14 @@ void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
 		else
 			return skb_pointer_if_linear(skb, offset, len);
 
-	case SKB_DYNPTR_METADATA:
-		return NULL;	/* not implemented */
+	case SKB_DYNPTR_METADATA: {
+		u32 meta_len = skb_metadata_len(skb);
 
+		if (len > meta_len || offset > meta_len - len)
+			return NULL; /* out of bounds */
+
+		return skb_metadata_end(skb) - meta_len + offset;
+	}
 	default:
 		WARN_ONCE(true, "%s: unknown skb dynptr offset %d\n", __func__, ptr->offset);
 		return NULL;

-- 
2.43.0


