Return-Path: <netdev+bounces-202507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16290AEE1A0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE413A6655
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFD128C5DA;
	Mon, 30 Jun 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xx5XbX/j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90628DB71
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295362; cv=none; b=oiUcPVoV96fom9jbLAM5189FqF0Jy35v47/i50jr8j91rO2MXltTfRIsNhGdZ+3PM9HtgwMq9qt6gkwxcKiGYiqHlces2dYYyQ49G9wXdzyfdoskweQHmiZ6Oo/skQnUOzXKtjU/WCma29/e8MKmIClkgsHDssM9j2iWc1EgZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295362; c=relaxed/simple;
	bh=7JE3/zTuFsdK18Qj0ytha0rL9JEyz2yJs29Jlr1Oz10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MI6uxFE/CD2rW4Fc5/y5qJooHl0FRgycLiGZ3IywZvooY19faENIV8dap/VD0cHqaGWUWtWrOZcKF01D6ppUCiV4L49b2N+0xXQXPewpEyFzSUFu49c4Rvxh16zTvvyc0Q3Z2ZD0EfSWm+JryfM5S63ImDg0M5eKTNLkau57cCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xx5XbX/j; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so661151866b.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295359; x=1751900159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1kpOesSXlO+zwvIVzaNY3+mGeXYR8L4I5ZHqTGx23Q=;
        b=Xx5XbX/jwNVH2HZTOXsFGX8GWFe8dDK874N7KW2DNrFVKRazdO2PZErR1jRL6YrDag
         KEOsKEQqw8VAt3RPgfrPzz903k98e5SM1BAKNGta1XUW8IMY28xrShuwZjQxm3ame8ub
         QMdkJaJm4C0BnF+w0ZP82BEobFvYojFBb7Pe328+cwYkkH2Xa9c9m4Pm7bzK/7xiGM6y
         biEF6//T0V7XP/XdnlPnOayq5SIMW09PQD2PeZtrgCp5cMGa8Q6LXkja+RwhOZT+fFG0
         4QBe1YD1W+LYU9vZGimHKmXFC+NQGaHL/YXHpPuB5WUcAUj9SWEHUgMDLinU9fdNJfJ0
         bu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295359; x=1751900159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1kpOesSXlO+zwvIVzaNY3+mGeXYR8L4I5ZHqTGx23Q=;
        b=OrBSQrErCko8cjJ44EJBnKZl7FHoAKjN2+R1/pZOnaJaPoFhzVGYweqnbmrXuaVPrx
         LNN5rTVjuT5dk/yN5ekgN0vhwAlqg+pFprn/LkklFB8BQF3jpINAmZEAt9lwYil0QxdR
         rgSaQQG1s9vK7Mbf8/2ReTldsihrvz8yffhKtjEiaBmB4jVP0v0xoz8hRvwXT3QONBK7
         TE5UEuUJlWbnHk5mN5PbizxadNcJT4ywe291/z3mzOFuO4Vundh7csOuvQDOhEXtzgxN
         oyMRoWccB/7Fw8m/HQBYqB1CWPRND6C+LotOsiJATEkPSIiNqmpoWmn05vyrthXAK5Z2
         wRmg==
X-Forwarded-Encrypted: i=1; AJvYcCWFwF3RkmPqf8PM/ypVlMoVFs/w8DPaN0bYYiNVSfar0TfEkHlyXgJZH9d2TIDD4GVMK3Dahso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIrzGWSzo4H7sza4wa1cx4TfoQcgsogV3dPjgz01tvHhZf1Bc
	YsL+Qf6nDnWa6WoO34fctQ/J+vLxGsySfjomSTl1iJ3S0j69wtwQGmnrc9qmGhwj+5A=
X-Gm-Gg: ASbGncs2uOq1rQGBYgzcm6jD95O65DY8ZOtDOY9Pr1H4eRWEWDrgnRb7T2NbxmJ9S2f
	LAxPjBjcYs5VTlUcshqzSJPYGnKY3fEiZyEMfC87D4/Q8KcQlabjXEecbH64VHxAeRunDLOjdXu
	SOp4VQsK7t07CLtRRQDKlWA4CiJfDPRlx21JkyobTt7RJte4ZjhVR3koVCUD1igiwHRJUG9yB8t
	V2SDDpXVfDj0peQUllM+1vQ2Ever7GlfN2noSuqElQh5J9C2+8GE1SQczy4ldT1pG/G8Fgx0i3R
	0/1eX08+hedzvQejPiIqozL8AhLpdDo5HoY3+9ig23HM+Y2PnHm1LQ==
X-Google-Smtp-Source: AGHT+IHcHR1xY0UZjLvtYNSXxH0/Z467o845yTpPG1RSgcI9vsbWJprfICNKfzAuj22cLyJg1+cqeA==
X-Received: by 2002:a17:907:7f8f:b0:ae0:a359:a95c with SMTP id a640c23a62f3a-ae3500f6720mr1249738366b.34.1751295359329;
        Mon, 30 Jun 2025 07:55:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3a36c4940sm66054266b.79.2025.06.30.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:55:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:38 +0200
Subject: [PATCH bpf-next 05/13] bpf: Enable write access to skb metadata
 with bpf_dynptr_write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-5-f17da13625d8@cloudflare.com>
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

Make it possible to write to skb metadata area using the
bpf_dynptr_write() BPF helper.

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f71b4b6b09fb..ab6599f42bb7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12005,8 +12005,15 @@ int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst, u32 offset,
 	case SKB_DYNPTR_PAYLOAD:
 		return ____bpf_skb_store_bytes(skb, offset, src, len, flags);
 
-	case SKB_DYNPTR_METADATA:
-		return -EOPNOTSUPP; /* not implemented */
+	case SKB_DYNPTR_METADATA: {
+		u32 meta_len = skb_metadata_len(skb);
+
+		if (len > meta_len || offset > meta_len - len)
+			return -E2BIG; /* out of bounds */
+
+		memmove(skb_metadata_end(skb) - meta_len + offset, src, len);
+		return 0;
+	}
 
 	default:
 		WARN_ONCE(true, "%s: unknown skb dynptr offset %d\n", __func__, dst->offset);

-- 
2.43.0


