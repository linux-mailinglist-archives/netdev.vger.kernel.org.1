Return-Path: <netdev+bounces-248199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD4D05410
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A1D13096D40
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9F318EFB;
	Thu,  8 Jan 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="IRNXBzzd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6182EFD99
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892558; cv=none; b=o9TOzYytlIdXLih+/MoWBQL2V30Ts/jBUnqaTUvCe6pTIzNLX+wbjQ2GHcB7bg74vJG4ggL2sF9pBm3rzJa+x/zx/VlgftHH3cTjeooWlqZbuYxKC8mZ8rZeH/LKujZulBtYFqpMpi138l4FgOUyB4QiaWt6ASAGHOMFIp4Gkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892558; c=relaxed/simple;
	bh=RXgpGF7LKCzAubNFKcImJKqDqFnSFfnfDO9ijjVBd4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inBr/Q6JI+bNUUOVFptePPuKTnH+ohr+GvZf6EqhkA1RSaiPw51YVcHXWUg+mG5sN66r5yHZbGbMeVbzPZisAgJAbZPjsZZufopY70YIKYVMc+2JaWyPvJtmpcaMpXUtsvOoMTiD8JZbtOotOx0mnLgUNpfpqcBM2w59qaauZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=IRNXBzzd; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1205a8718afso3406351c88.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1767892556; x=1768497356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=659dAkT3NL1GCNcNqLJ6QZGdeRsETYik1YJoRtWdV/A=;
        b=IRNXBzzd3KV2w3iqS+CKNG8sJQBKf5nzOej3YoBLN5jzTR+pmK+3kZXXlyHDXzb/Jj
         a+p8XaQiOwlY3bqX9HxzSsi+pS0KTBspuocgVXlnuzWbAPumaTUE3fl82lNH/qji4xGV
         flE6d6C4qY7xlR2atQPguL8Zs6lh3d2slmWmwoJAp9nff3tGlP+8GYh37XAJa7Ej7nMI
         eOOFTwXRxAGMhH2bQkEPv98m110xYU6FpAcNlMQAgkfpONSk0aWiSjGCD2rKURr4PsQd
         rgttOLfjkU6RZ9K6JImYG+XQgIX0x++76V701uGrq1loT8HXt67Lrb8oDe00qOj0u8qx
         8u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892556; x=1768497356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=659dAkT3NL1GCNcNqLJ6QZGdeRsETYik1YJoRtWdV/A=;
        b=SJufyzmtCTioahH3OgLTusX+FhFcPxxwdDVtKNr4uFggfdSgCgQ5U5ig3reqKPQvte
         l3W/lsbkyM9vFSXHpWBBsNurzMHWp7HNztUM3G0YG1BJfH/ruCOobVkFOy4mBRHkd9io
         UxnbdLea5MLb+rLj+TB60jmpCxvEVl/yqLTBYFfkhn58QmphxHCw1gjOkcqcxw/yJLeS
         BRXUFDYx47+wHns4X1qf5+1kntgHEn4DvyHK98eLbwLSOTRImFjQ7bf1qvVJ6BCiHo7i
         /e3XW+TzE3uPnpkQigLqPJeh7eLbU6/vqb+yOH+nscemes/HDRu7y2FajuXUzoSSoLVE
         M9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCR5mAsBzzdD3QvAiEWaY+L1gmJ0ZugJNk8nBrhpqQIAGrCUOqW72Ki8T9cu6tsbaKskk0hdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBs5n94GNGdz4Gkffo7Th8EsdUCflnyYf0ovGoh1NDfqY3llXO
	zb6/Rn19n7hcOi6AkYp3ptv7qDhCu7sGKraI4Sk/5TyzK9xpypgrR1AO5k+0X8ReJYDRYILI2eq
	GcTk=
X-Gm-Gg: AY/fxX4paGCFqXnVZzG1sz9RlNymA7dyNosbU4nL1W8i5DPvIfUu87ljWlQfvJ+JjVs
	4/fRxiS/tVykGaw3Yd43CJkn3I9UAgID2KovVQGKW46wFo+Hb2milvNqH0jVhBmQvwai1Li0/oZ
	RzZR9BK9hBEeP4qJtModZqHfZv06B4yfDhk5/cji89Qif475Hm6zZJHrsPmuWiY59oy0tdcIzKG
	EuGcV3ekOaWxAyN6WHFOeG52CYFbpiqeJa31i5Etl3fjQg20h37jxjyjtL3BNleNnOOH82M+JV7
	yK6OnGO4PCY8LWqKaF81g/WzUcVvsu+BVdH4yPfiag5tOhnobbEeGt14hWx5TqqbQFtu0BZ7NNn
	F9gu9kbR4/wPUN1jkeHrKbrhd8P9eopdWU4PUy2qeCswiU294Mqbr8PSd4lU7GBKFGUkWwlVUKl
	4QchUOVoeLt3codVJUwuOslk/x5hkUX8KEyxWDdobRPsUTG2BmdAe+KTUw
X-Google-Smtp-Source: AGHT+IHQBMTsLdIbbTcjrlSquOxiNJuczSuuQs1Die28Wcin3kgDyX002tBRKoJelWUjcfco+i4qDQ==
X-Received: by 2002:a05:7022:2216:b0:11d:fcb2:3309 with SMTP id a92af1059eb24-121f8afe9famr6125412c88.4.1767892555697;
        Thu, 08 Jan 2026 09:15:55 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:812d:d4cb:feac:3d09])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm14029259c88.12.2026.01.08.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:15:55 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 3/4] ipv6: Set Hop-by-Hop options limit to 1
Date: Thu,  8 Jan 2026 09:14:55 -0800
Message-ID: <20260108171456.47519-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108171456.47519-1-tom@herbertland.com>
References: <20260108171456.47519-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Hop-by-Hop options limit was a default of 8 meaning that up to
eight Hop-by-Hop options would be received in packet before the limit
is exceeded and the packet is dropped. This limit is too high and
makes the node susceptible to DoS attack. Note it's not just the
options themselves, but a lot of padding can be used between options
(.e.g. up to seven PAD1 options). It's pretty easy for an attacker to
fabricate a packet with nothing but eight unknown option types and
padding between the options to force over a hundred conditionals to
be evaluated and at least eight cache misses per packet resulting
in no productive work being done.

The new limit is one. This is based on the fact that there are some
hop-by-hop option in deployment like router alert option, however they
tend to be singleton options and it's unlikely there is significant use
of more than one option in a packet. From a protocol perspective,
RFC9673 states:

"A Source MAY, based on local configuration, allow only one Hop-by-Hop
option to be included in a packet"

We can infer that implies that at most one Hop-by-Hop option is
sufficient.

It should be noted that Hop-by-Hops are unusable in the general
Internet hand packets with Hop-by-Hop Options are commonly dropped
by routers. The only realistic use case for Hop-by-Hop options is
limited dominas, and if a limited domain needs more than one HBH option
in a packet it's easy enough to configure the sysctl to whatever limit
they want.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipv6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 723a254c0b90..62ed44894e96 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -91,7 +91,7 @@ struct ip_tunnel_info;
  * Denial of Service attacks (see sysctl documention)
  */
 #define IP6_DEFAULT_MAX_DST_OPTS_CNT	 0
-#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
+#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 1
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
-- 
2.43.0


