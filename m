Return-Path: <netdev+bounces-15368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC2D747326
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D9E1C209F4
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93F96138;
	Tue,  4 Jul 2023 13:46:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1D6124
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:46:46 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB246E6D
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:46:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso36243045e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688478402; x=1691070402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3ZEHKXTVG/Gb9fOd1FQSYBQN3ni6h9P0p7yh5ic6CY=;
        b=ESheU9hFBk0h6N2kS+nTQir6IROjqSLFNKvaku+9x/BZQfYeMpNwijF2twERuTtmDM
         fgRkYoWq36XNW0YmbegWWzmrjG3Ktgyq/6lEyzeN+qgUt/6qjjr3LZQD7fBk95cPN+Ra
         6DGS6AHyLLSR5esqoXXK6DB6mpuDOQFsTyQONNJbZHAnBduijy71ljU/fO4QbkLPAfSw
         Z2R9mmxZOjVPFQOaENy8NSBthTTiypoWAxhjr67rJbcPRvVftLMWC1CaYbz/58yv1yyv
         YzcUFTy3fLdpd4RieBkCfhtrsMfXU8sSkEC3HU0YlWIz/vG7t7FFnuOFfCT8J34NQWYV
         w8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478402; x=1691070402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3ZEHKXTVG/Gb9fOd1FQSYBQN3ni6h9P0p7yh5ic6CY=;
        b=DM5KGgLf6VYNlH7Hf7TvMm353FlwVvR7uD004NTyr/z/1hSntpjsXPu9DNlp4EJmDW
         edobMaggo+wl0lqHW4XmGBpysyRc91+loSogCeRas7aEt6SNXK263UEb2/RQKHlmDpCn
         RXDGSu8hHhG2VjSdS57UtFTvKT07T9oNQsgqfbg1X5LyccAynIX42qN1KxioH7fsPLnE
         2wxenhG2GnTWC5duu6CIcmy6JXRttD7eSDuNK/B+s4202550CivwS6VFIHgTPNIZVlws
         ZGjHqTeV7U5BuwsWaxRkhocfM7pq8oua40Is3r2UCOiSSZ08pyusinJ1IwO4IRzdNPBr
         Jepw==
X-Gm-Message-State: AC+VfDzd9IRDvTslTlgMJ2U7xvv4OsmEEhsTWL0Lbi8KJ3Jcxz+bMLgk
	lgXqnndRkuruwjPmfvkUrlOtFg==
X-Google-Smtp-Source: ACHHUZ6KIjf5+rG3djA315MFSZFS8jV5nrHiYXmanlyO83a6ak9oOnYyWW9Eqtc+I8kqI0UWLB4fKA==
X-Received: by 2002:a7b:cb8a:0:b0:3fa:97b3:7ce0 with SMTP id m10-20020a7bcb8a000000b003fa97b37ce0mr11388577wmi.26.1688478402274;
        Tue, 04 Jul 2023 06:46:42 -0700 (PDT)
Received: from [192.168.133.175] ([5.148.46.226])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b003142b0d98b4sm9274680wrt.37.2023.07.04.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:46:42 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v5 0/7] Add SO_REUSEPORT support for TC
 bpf_sk_assign
Date: Tue, 04 Jul 2023 14:46:22 +0100
Message-Id: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK4ipGQC/32OQQ7CIBBFr2JYi6FAi7jyHsYFg6MlUWigkpqmd
 5d2ZUzT5c+b//6MJGF0mMhpN5KI2SUXfAn1fkdsa/wDqbuVTDjjgjWVoCnQiO+EXYg9Rc1tzZt
 KCURSKmASUojG23Yu/d7OuIt4d8OydiHQ3anHoSfXQlqX+hA/yxuZL3x9MXPKKCjbaCNkWRZnl
 0I2T/T9wYbXIstiSyCKQDMF0gIo0HpNILcEsggkWlSNYkcA8y+YpukLGbAabVcBAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>, 
 Joe Stringer <joe@cilium.io>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We want to replace iptables TPROXY with a BPF program at TC ingress.
To make this work in all cases we need to assign a SO_REUSEPORT socket
to an skb, which is currently prohibited. This series adds support for
such sockets to bpf_sk_assing.

I did some refactoring to cut down on the amount of duplicate code. The
key to this is to use INDIRECT_CALL in the reuseport helpers. To show
that this approach is not just beneficial to TC sk_assign I removed
duplicate code for bpf_sk_lookup as well.

Joint work with Daniel Borkmann.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Changes in v5:
- Drop reuse_sk == sk check in inet[6]_steal_stock (Kuniyuki)
- Link to v4: https://lore.kernel.org/r/20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com

Changes in v4:
- WARN_ON_ONCE if reuseport socket is refcounted (Kuniyuki)
- Use inet[6]_ehashfn_t to shorten function declarations (Kuniyuki)
- Shuffle documentation patch around (Kuniyuki)
- Update commit message to explain why IPv6 needs EXPORT_SYMBOL
- Link to v3: https://lore.kernel.org/r/20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com

Changes in v3:
- Fix warning re udp_ehashfn and udp6_ehashfn (Simon)
- Return higher scoring connected UDP reuseport sockets (Kuniyuki)
- Fix ipv6 module builds
- Link to v2: https://lore.kernel.org/r/20230613-so-reuseport-v2-0-b7c69a342613@isovalent.com

Changes in v2:
- Correct commit abbrev length (Kuniyuki)
- Reduce duplication (Kuniyuki)
- Add checks on sk_state (Martin)
- Split exporting inet[6]_lookup_reuseport into separate patch (Eric)

---
Daniel Borkmann (1):
      selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper

Lorenz Bauer (6):
      udp: re-score reuseport groups when connected sockets are present
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: remove duplicate reuseport_lookup functions
      net: document inet[6]_lookup_reuseport sk_state requirements
      net: remove duplicate sk_lookup helpers
      bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign

 include/net/inet6_hashtables.h                     |  81 ++++++++-
 include/net/inet_hashtables.h                      |  74 +++++++-
 include/net/sock.h                                 |   7 +-
 include/uapi/linux/bpf.h                           |   3 -
 net/core/filter.c                                  |   2 -
 net/ipv4/inet_hashtables.c                         |  68 ++++---
 net/ipv4/udp.c                                     |  88 ++++-----
 net/ipv6/inet6_hashtables.c                        |  71 +++++---
 net/ipv6/udp.c                                     |  98 ++++------
 tools/include/uapi/linux/bpf.h                     |   3 -
 tools/testing/selftests/bpf/network_helpers.c      |   3 +
 .../selftests/bpf/prog_tests/assign_reuse.c        | 197 +++++++++++++++++++++
 .../selftests/bpf/progs/test_assign_reuse.c        | 142 +++++++++++++++
 13 files changed, 658 insertions(+), 179 deletions(-)
---
base-commit: c20f9cef725bc6b19efe372696e8000fb5af0d46
change-id: 20230613-so-reuseport-e92c526173ee

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


