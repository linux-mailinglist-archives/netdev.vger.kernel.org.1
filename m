Return-Path: <netdev+bounces-283756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOP6H0th+GlJtgIAu9opvQ
	(envelope-from <netdev+bounces-283756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:05:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D14BABBB
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA8023019526
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700EC357735;
	Mon,  4 May 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbGhoHWR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD680355F4E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885509; cv=none; b=Bh6LHoOavMKvgS4yawr25r88FZIksMOfKRZ3hYWK3ShAvgjX1EuAy0d/rkwKdbACFA77ZDK2cfcOUVYULNya7cGj4v/6UEWrZXqxM/ifAIsoSyCZq/6FhKJjaH3VYvDG4agOaTKLtnj9aRf3J9hYDsONevl2HYXKkNiKLWqkLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885509; c=relaxed/simple;
	bh=iYDSjpyrmYJ0XNK4JWPtR8zqN6PA3clAZvrF4MoM3Qc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bJZIzh8vALhq6ox60kUhDw5p9lx/PdVITYdprEJbZ014DQIvhQdBwH6xk0W2SmND8evVOdHJtdcTB0hnEEX7E3bBr0ZtuczYlqNiVAEomeD7bE+gYwD0XbVRHTqDcpNO2uKx0n7w0YG/kB2YrO2o4nk4bQIVuTrrrd01C5Ezr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbGhoHWR; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8fa5744b82so64926066b.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777885506; x=1778490306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HSYT+TCPOAljq6RSU1b3HUH3gEDf2uNueIFzfeeqqdI=;
        b=XbGhoHWRXiYryXrjocrzlV2vm3eUZwjstrCArTVPzuKGlM7E+ERHGtC9okf5tfWzBp
         2nmuNLug26FOKyEcqQmtj2aO2ArEN8th7iw+mEMg1UqtPO2pCszgTTANsXMH2IHggx3B
         KC/dNTTfw0dEi9PlCRM6DfqLmecPptHKVAnnz8+rhzaGXV98UIGw0xeVosLCMzVWYDWR
         PVaYr3FfhiHLexped9ghuv1heMSZ8/EZ/XcTbdAlZfd7yB9SP8EFZhhOumbKn7vneMT+
         /czsgypber6DbKcjnt456sOFYAZYr9cIOgRJqzDMEmCTRb4STGWJi/D9Z2heKk5SYjfw
         f2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885506; x=1778490306;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSYT+TCPOAljq6RSU1b3HUH3gEDf2uNueIFzfeeqqdI=;
        b=angC/X2QKJW+rSy3hrZy78SS7rPHMZRXEiwMoJ1pwyf4qe0qqaxpMHzwIkPnFKAYtw
         mI4mx0A62/7NP7b1saHoTn/VTqUCUv/LEksjfcCT9fRSiSMlNSxyzlJKHhJUIWZKX8ET
         LtRw+k2txkIOLXN06Ar8n2BDFOY/bS8lvDGzwZGbxZz5e0oLWetQ5HZaYnwKUU8OaSpr
         kB3WIroo91e3VF7rscgnE75kxjrLSItBXPODIj3VP/RA6buQowAcar0+cYfVaADXg2FC
         D+5go+Zk8vEVrigiqXa0n3uV1IkmyM+d4CjKX0wdarZrAz0rc8PCbnhNTgdPCwn2cU71
         lzSA==
X-Forwarded-Encrypted: i=1; AFNElJ9jeDdNXMSWZRCimo2NwoMB/azRY2wm3cENvIe3rXHycy+J9IGl/nHUyCGkWTmq1fDFFP/5234=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9K1zAsYSywZB0hSGbJEzyAVBi/RuKf/t26cFOZ78BzlqeVq1
	RnUtrUAIlHx+l6H/n7kGBQynnH5eHs5q3b2vtO37mNGxMyzzub+Njzs3Al0GTLL65pgwVujYN8G
	Anfm1KzYc6X8Hovot8A==
X-Received: from ejbwy11.prod.google.com ([2002:a17:906:fe0b:b0:b9c:1e4e:80ab])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:5c5:b0:ba7:7f6d:be4a with SMTP id a640c23a62f3a-bbffd1a82bamr432486666b.26.1777885505826;
 Mon, 04 May 2026 02:05:05 -0700 (PDT)
Date: Mon, 04 May 2026 09:04:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADVh+GkC/3XNSw6CMBgE4KuYrq3pE6or72Fc0PYHGrHVgkRDu
 LsFF2iIy5nkmxlQC9FBiw6bAUXoXeuCT0FsN8jUha8AO5syYoRlhJMMa+ctROyha5y/YKMYpUS
 zUucCJXSLULrnPHg6f3KE+yPtdktZu7YL8TWf9nRq/+73FBNsCwNaaqN4yY5VCFUDOxOuaNrq2 eIFUSvPkjfEcpZbKgWXK8+/PJUrz5NXQsNeFxkH+P0fx/ENK5QgB0IBAAA=
X-Change-Id: 20260306-binder-netlink-c82110b2fb74
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=iYDSjpyrmYJ0XNK4JWPtR8zqN6PA3clAZvrF4MoM3Qc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+GE7W+xXwpvE2YxyHtFfEpV4u4LIUAuEC3iV/
 4TrM14Ilx2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafhhOwAKCRAEWL7uWMY5
 Ri2xEACo0XggOIoueiIMPhB1mLWZh1ZGOcNI4WefdD9Eko3248j5V2vqpzJ24mtdaI9cX2xlFJm
 NaYXjGxcZ88EooTzHqREhSsc4JN0oIpz8gZN/zOr3xGlGB6Z9zQIzCkJ2MwoyBvuN6NUr4l+f+c
 m1bkrXeNqVlYxE+vnQ69A1cE+ucC4IHRnamriOud6EOttcQxQJkMYNIMjX+L4OsQLy/As2x5l7l
 EoAsEcQ3TeWCWdIIHoyT0Yx5U0A1JpxQUv8T0DXM3TV+N1oAUFTphcktvVjsHmH6mBEvC7PKSsW
 nuVU5fwP6vR/Inn25sOgc88Um13iU79IMrZobgi1JqGkOXGjcb3S8uFQlaPBsi5uEzyicEKrMMp
 q8wycf2HRh5Q7BpDavle0zym3CU4b7OfpPnwQmvrOhutxRQ3vxpDvDZuoMJnojC1CJC6qq8Y7Tr
 CUR0EGEOUee+kT+TavCmOThuPdfAwRE7e+vh9y+DKOFFKHJSJA4AdSZrGAj3keFxBzsBYkrbPKv
 BOuD0hC/pOLNW30QfP5QYL38WbXyHkdpJJc1EwfpVULRcWdr7qNpDGQxGr2IZ/t6Psmz0Qm6k9/
 Pv13ZU42dY/w2J9O6Zl4orR6rJBKbtiIMNStSqj5le4XBg3i58PlAlcSX03o6s3cIdpfYGB3wSf EtfTb3us7ZMWKog==
X-Mailer: b4 0.14.3
Message-ID: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
Subject: [PATCH v4 0/4] Rust netlink support + use in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: D78D14BABBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283756-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,linuxfoundation.org,lunn.ch,gmail.com,kernel.org,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,google.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The C Binder driver exposes messages over netlink when transactions
fail, so that a userpace daemon can respond to processes with many
failing transactions.

This patch series adds netlink support from Rust, then implements an
equivalent API in Rust Binder.

As Binder only uses broadcast messages, I did not add support for other
kinds of messages.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Fix typo in 'report netlink transactions' commit message.
- Document that some methods are for const context only.
- Rebase and pick up tags.
- Link to v3: https://lore.kernel.org/r/20260415-binder-netlink-v3-0-84be9ba63ee2@google.com

Changes in v3:
- Fix spurious 'return' statements in Rust helpers (Patch 1).
- Sashiko review:
  - Fix ynl_gen to handle empty multicast groups and correct multicast indexing (Patch 2).
  - Fix transaction failed reply logic to report via Netlink inside reply_inner() (Patch 4).
- Link to v2: https://lore.kernel.org/r/20260408-binder-netlink-v2-0-c0d327d15435@google.com

Changes in v2:
- Make inclusion of to_pid conditional too.
- Add note about file name in second patch.
- Make it clear that the sk_buff wrapper is netlink-specific.
- Better handle bitfield in patch 1.
- Link to v1: https://lore.kernel.org/r/20260306-binder-netlink-v1-0-daceb5bc83f2@google.com

---
Alice Ryhl (3):
      rust: netlink: add raw netlink abstraction
      ynl_gen: generate Rust files from yaml files
      rust_binder: add generated netlink.rs file

Carlos Llamas (1):
      rust_binder: report netlink transactions

 drivers/android/Kconfig                    |   2 +-
 drivers/android/binder/netlink.rs          | 113 ++++++++++
 drivers/android/binder/rust_binder_main.rs |   8 +-
 drivers/android/binder/thread.rs           |  10 +
 drivers/android/binder/transaction.rs      |  40 ++++
 rust/bindings/bindings_helper.h            |   3 +
 rust/helpers/genetlink.c                   |  46 ++++
 rust/helpers/helpers.c                     |   1 +
 rust/kernel/lib.rs                         |   1 +
 rust/kernel/netlink.rs                     | 336 +++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h                    |   1 +
 tools/net/ynl/pyynl/ynl_gen_c.py           | 139 +++++++++++-
 tools/net/ynl/ynl-regen.sh                 |   2 +-
 13 files changed, 697 insertions(+), 5 deletions(-)
---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260306-binder-netlink-c82110b2fb74

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


