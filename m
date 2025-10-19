Return-Path: <netdev+bounces-230716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7EDBEE52A
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75DE3A30D6
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AD82E7637;
	Sun, 19 Oct 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IwvSDmXU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3538DD8
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877941; cv=none; b=p5rOzjDdNUuEjN0DBoVk0yDZNgTyM/YZIcOGR/D8ZfnGkRRUoK84jvq6tthDfZPeNpvxxqBPTbIGViopctPXF+ZnDsIT9/C26ZgND/fvjlyJDZd8ufTcxicz4scRgSPfF4pk/kjBU6IWl2/NU7wmvazHmbi2zdsjFM44VxE7SQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877941; c=relaxed/simple;
	bh=GjUl5p7WYCvSIxPoWwpdkPGP2x6l5lB78cRtlz5MC5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k0IMWAqmqO5hr/wjkhcbbpL9ZofPx+pXNVdcE2Yq3NTtu5zqIr6JJ/qIlYcF0Uri/ondHFlvR2Dd7a5ssvsInrN06ouyRyxkzkJoGMZsALdfPjKy1P739IxdxP34/3K0jeudGOQuA9lSWc+OaKDKkbvle1RSMVGC1JAahbTmXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IwvSDmXU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4539dddd99so587286266b.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877936; x=1761482736; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPesFPw/mEXNA4diiwfx+Q6fda27v3D04HEPTNdnNkw=;
        b=IwvSDmXUFC6emO6SLl2HGwT3O5ihrGJ7cCHTGmzkPEJJw2A8+y/tpGE8VfRMYfAre7
         xwz68K7QrM+1xsjxtspVwQdhGHOB4bzcYpYCsx89jOhvA9h1VCpbSKjkkurPJ4We0EsL
         CGQUt89DZaQbcCfaAmJc0xgMUJFMJNhf3h3eFE6/UXYIFddVcjk8IpdaWLM5LFgBSKzf
         mjDBS0bAwUFbHIopn5sIhBBwXDQWFHmIqVea4H+evXbMDB24uLRDBpYdxS4QgGISpFuu
         E3rGpvgh0O2OUIcuW+XbS+5bkZzPAtZc5z8GeqG4T5N/l8oMLvM3Z2kz/lJPowBqDXRj
         oRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877936; x=1761482736;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPesFPw/mEXNA4diiwfx+Q6fda27v3D04HEPTNdnNkw=;
        b=slAM05wUoxI6zSp1i2S3nvSQLKiwjuTX10xL2Skf5BGR4JTH9lZ8LUISVo5L9s33G7
         NWDlm6igaamIIFmjXoxgsSSjGDbhEtt5LM+6TAytjpXkNZLO+AYDY4TcdPbQER1m9ptN
         DlHMwXCk6xMYS5JkuoPvEx2MQBx45EFfbJ8EfOC0NKc2/qUL901w1DtIUKAJDv4ixm5B
         bDw+x7f3Y1asNAdYeqtuyPffIP26n8lBhIRsnHCBC2UxqAbYx+TjMtiZ06FzXkfkLuwW
         Qwn/FtcN/lWYDzoBKPNWYL8se5s5ONV14i/w1JNHCZZMcowpUkLIaYALsv9u1ObFCWVL
         4KOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2lpnB7xnce5NCadMhx8EYDmxlMLcAmIHG9mgKwuVVSydyyYNLT6WSw1h6ObX2FBlbhlhYLA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVImlwoP/O0uuYwkDqdCbbltJgxfjXtrEh6TLsICcNE0Re5peW
	6JQ1xDtd6YiF+CZnNUDc/3V/8HTvrJeFN3fN1fIujH3Sq4B1TOxi/KqeDRAvWLb50/8Rsq8VzT8
	kRu6E
X-Gm-Gg: ASbGnctnb47t6udBOJatsNjvvSIQbtPlo5rIcrv7fe8UwcKKdz0dNjf4+zP+1mOTw7K
	6pWWJ+o/wq91sF8aezAz8cCo8EY/yS+lIlDD9rKMonfFTPjaBmxbWiV4yUkXQhX4p+LBp6C2vRD
	/P9ibsdJ/iBtufugALDF4EAI1OpwxbiGTTzyTLR7aDLeaZ1qjsyti/BSVQmq8/7/YMW/cDxdQIW
	H2QkI6fnQzBzvg+fO4etXuZmeBlWdlaCKN0ruCzA9zW8jY4kTdqMkskfUfTYSsMIC8Dr+npCu+l
	99eUCSz4TN9uNV7Poer/NKHUIn08AbZak524AUItbuVaC1R/tuwE7345qp+oitOySIjWqSCIZf6
	2bXWdntiWJ2gfeSr5gj66nwtvh/LqPWuXr2+DzNlxoHNz5HeTJvjwhPp9gqmwnJ29blhhLxg9ik
	zXX6TV8M6kfDEvmck9Lpu6nV0M/KtbBZavs7NdJQk4fY7LMKmJ3/D0GBHQQkU=
X-Google-Smtp-Source: AGHT+IEt+M49aC5QEvJTTVznZrz3M40EqduyXEn85X7sLX7tS2hGJd/jTumAMfb9gAt5VgoZTFEq2Q==
X-Received: by 2002:a17:906:c116:b0:b46:8bad:6970 with SMTP id a640c23a62f3a-b6474939520mr1134427166b.36.1760877935894;
        Sun, 19 Oct 2025 05:45:35 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526233sm498562766b.63.2025.10.19.05.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v2 00/15] Make TC BPF helpers preserve skb
 metadata
Date: Sun, 19 Oct 2025 14:45:24 +0200
Message-Id: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTd9GgC/2WNQQqDMBBFryKz7pQkImJXvUdxMYmTGqpGkjRYx
 Ls32GWXj8d/f4fIwXGEW7VD4Oyi80sBdanAjLQ8Gd1QGJRQjehEjfGlceZEGDZcKY2ouRG6Jtm
 S7aDM1sDWbWfyAXq1uPCWoC9mdDH58Dm/sjz9L6u6/2yWKHDgVghqSUuj72by78FOFPhq/Az9c
 RxftB/CxL8AAAA=
X-Change-ID: 20250903-skb-meta-rx-path-be50b3a17af9
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

This patch set continues our work [1] to allow BPF programs and user-space
applications to attach multiple bytes of metadata to packets via the
XDP/skb metadata area.

The focus of this patch set it to ensure that skb metadata remains intact
when packets pass through a chain of TC BPF programs that call helpers
which operate on skb head.

Currently, several helpers that either adjust the skb->data pointer or
reallocate skb->head do not preserve metadata at its expected location,
that is immediately in front of the MAC header. These are:

- bpf_skb_adjust_room
- bpf_skb_change_head
- bpf_skb_change_proto
- bpf_skb_change_tail
- bpf_skb_vlan_pop
- bpf_skb_vlan_push

In TC BPF context, metadata must be moved whenever skb->data changes to
keep the skb->data_meta pointer valid. I don't see any way around
it. Creative ideas how to avoid that would be very welcome.

We can patch the helpers in at least two different ways:

1. Integrate metadata move into header move

   Replace the existing memmove, which follows skb_push/pull, with a helper
   that moves both headers and metadata in a single call. This avoids an
   extra memmove but reduces transparency.

        skb_pull(skb, len);
-       memmove(skb->data, skb->data - len, n);
+       skb_postpull_data_move(skb, len, n);
        skb->mac_header += len;

        skb_push(skb, len)
-       memmove(skb->data, skb->data + len, n);
+       skb_postpush_data_move(skb, len, n);
        skb->mac_header -= len;

2. Move metadata separately

   Add a dedicated metadata move after the header move. This is more
   explicit but costs an additional memmove.

        skb_pull(skb, len);
        memmove(skb->data, skb->data - len, n);
+       skb_metadata_postpull_move(skb, len);
        skb->mac_header += len;

        skb_push(skb, len)
+       skb_metadata_postpush_move(skb, len);
        memmove(skb->data, skb->data + len, n);
        skb->mac_header -= len;

This patch set implements option (1), expecting that "you can have just one
memmove" will be the most obvious feedback, while readability is a,
somewhat subjective, matter of taste, which I don't claim to have ;-)

The structure of the patch set is as follows:

- patches 1-3 prepare ground for safe-proofing the BPF helpers
- patches 4-8 modify the BPF helpers to preserve skb metadata
- patches 9-10 prepare ground for verifying metadata after BPF helper calls
- patches 11-15 adapt and expand tests to cover the made changes

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com/

---
Changes in v2:
- Tweak WARN_ON_ONCE check in skb_data_move() (patch 2)
- Convert all tests to verify skb metadata in BPF (patches 9-10)
- Add test coverage for modified BPF helpers (patches 12-15)
- Link to RFCv1: https://lore.kernel.org/r/20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com

---
Jakub Sitnicki (15):
      net: Preserve metadata on pskb_expand_head
      net: Helper to move packet data and metadata after skb_push/pull
      vlan: Make vlan_remove_tag return nothing
      bpf: Make bpf_skb_vlan_pop helper metadata-safe
      bpf: Make bpf_skb_vlan_push helper metadata-safe
      bpf: Make bpf_skb_adjust_room metadata-safe
      bpf: Make bpf_skb_change_proto helper metadata-safe
      bpf: Make bpf_skb_change_head helper metadata-safe
      selftests/bpf: Verify skb metadata in BPF instead of userspace
      selftests/bpf: Dump skb metadata on verification failure
      selftests/bpf: Expect unclone to preserve skb metadata
      selftests/bpf: Cover skb metadata access after vlan push/pop helper
      selftests/bpf: Cover skb metadata access after bpf_skb_adjust_room
      selftests/bpf: Cover skb metadata access after change_head/tail helper
      selftests/bpf: Cover skb metadata access after bpf_skb_change_proto

 include/linux/if_vlan.h                            |  13 +-
 include/linux/skbuff.h                             |  74 +++++
 net/core/filter.c                                  |  16 +-
 net/core/skbuff.c                                  |   2 -
 .../bpf/prog_tests/xdp_context_test_run.c          | 127 +++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 358 +++++++++++++++------
 6 files changed, 434 insertions(+), 156 deletions(-)


