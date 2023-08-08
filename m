Return-Path: <netdev+bounces-25607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0A774E90
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE5428198C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF11171A1;
	Tue,  8 Aug 2023 22:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52200168BF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:48:36 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8810E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:48:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so77484917b3.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534913; x=1692139713;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6IYf4nshxor0R0BfWz4JihwJzXUnsgpsQ8Bx+FCm50=;
        b=v/F4rK8C1c6Y8YTaAeOsPAc5rlC8DfTsdhN2NcOQy8xZRaoS9cvitj9HgolcvWE5XN
         ZCiP+oEC5RA+WP6fZlEU1CnM2RNWG7JAxRMbaAZFn9uJ6EZdyRVTLnMIFZmpJ0leHpqh
         7spA+UxF93A8SpFyC9uM2L+GVmrc2Oz7NekmEKSBkf/D0u4FLjt9CTUbtd+8gtFhaZz7
         k18znWmvXCXpii8KvsTYg2aJQtU0osYwWxLYMWbgCMw6nzwrDCkx//Fl2Uaf3ok/PA19
         fBUF7829XdzW7mM47blfRSu0JxMy05t+IbWe2W6Sq0zG9sswyCnMVFGIHsZd252DX9zq
         QYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534913; x=1692139713;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6IYf4nshxor0R0BfWz4JihwJzXUnsgpsQ8Bx+FCm50=;
        b=XHkF2BedXjnrhHxZ8LIXolHzhlrFraW8GO9LFkejV9IXminKEaOsaiZ0PgkjlLdhrm
         aaLuwSVUEVdxH9GIL0kEexZgXphuOgTYtkCSbNVdG/GgQd7Vs1slDF2ZS7/Auezz/kRg
         knfJ1bSIztktauRj3NRi+GxJLJNprbQ4Y2FQR58QvmxqHXpJP+bDkFLdDA3nBmdMZGro
         27HLo//FO0jaHuwO4eojgISDZo6H+8FCE2XsUM+nw4dTRrCFAtF8GHUxtmlGvjpZ1IGc
         RqJMoP2hMmNRoCpc/oULFoAOvLN7DbmmDHA3OMZstjX0/RER4BSewW1xyLJv0+de/CFk
         78mQ==
X-Gm-Message-State: AOJu0YxJwLiZtj0Bi3ah5hh1rb9RmsSjmF2q+2yaUAxf0D+5lp8MAe4q
	vVw5cc+nixogWYh8+EYGUZnr/jFQqYrTb6rLOw==
X-Google-Smtp-Source: AGHT+IGCKCpjw+qQSDFPyaaHwnCmIRgOXWU0/CPaXzJcAH1H2D2px83oqOo3PmhmQlTBWJHjAd9H6SpIq9/Lr6ycUw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:aa0b:0:b0:586:4eae:b942 with SMTP
 id i11-20020a81aa0b000000b005864eaeb942mr25570ywh.4.1691534913334; Tue, 08
 Aug 2023 15:48:33 -0700 (PDT)
Date: Tue, 08 Aug 2023 22:48:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACXG0mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3bzUEhBOy8wpSS3SNTEwMjcytExKMks1VwLqKShKTcusAJsXHVt bCwBxh7PoXwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=1704;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ZOPiCy7w2pT1kz3c5DhiCZiV+zTmBFI8xyOrhaHPkq8=; b=35hLj7PJ6DP6/IdiB2Ylc5Y2G6xQ/3oI1SXKLWZ4BpDIns5/qOxf/7y6WjAKgN2o0Nv1hmmKZ
 7RXdFr4FcSnA1LghMYnhNj8402rOA1pYEJ9KZdZBr1W0Mso8AV+M+KL
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Subject: [PATCH 0/7] netfilter: refactor deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

This series of patches aims to swap out `strncpy` for more robust and
less ambiguous interfaces like `strscpy` and `strtomem`. This patch
series, if applied in its entirety, removes most if not all instances of
`strncpy` in the `net/netfilter` directory.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
---
Justin Stitt (7):
      netfilter: ipset: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nft_meta: refactor deprecated strncpy
      netfilter: nft_osf: refactor deprecated strncpy to strscpy
      netfilter: x_tables: refactor deprecated strncpy
      netfilter: xtables: refactor deprecated strncpy

 net/netfilter/ipset/ip_set_core.c | 10 +++++-----
 net/netfilter/nft_ct.c            |  2 +-
 net/netfilter/nft_fib.c           |  2 +-
 net/netfilter/nft_meta.c          |  6 +++---
 net/netfilter/nft_osf.c           |  6 +++---
 net/netfilter/x_tables.c          |  5 ++---
 net/netfilter/xt_repldata.h       |  2 +-
 7 files changed, 16 insertions(+), 17 deletions(-)
---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230807-net-netfilter-4027219bb6e7

Best regards,
--
Justin Stitt <justinstitt@google.com>


