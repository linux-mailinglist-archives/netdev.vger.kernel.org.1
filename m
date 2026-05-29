Return-Path: <netdev+bounces-293123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OKxHCGWGWpPxwgAu9opvQ
	(envelope-from <netdev+bounces-293123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:35:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2C602EF4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0ABF3133CCD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385DC33263B;
	Fri, 29 May 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKo8ncPO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A6330B30
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061364; cv=none; b=q24pdXdDmT5Qc7MaRFXgja6rcCjf8Uu384D441352SqzUu41N+zs4IpcJ9vnesxAapdJotdP/eJA7tHSoZnyVMNDJo1dlupFDGLxdnT9ShGV2ldvLgYVaJO4Sr4kCr/akLwG2qCRiDen8ptAvnegRq8iT76R4QXhiUYzDpjbs3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061364; c=relaxed/simple;
	bh=/iJHCtlUB7ZZdvLrVonfY3NnlAeU/QaU7QZAo5L5qNM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l2sV9cG/ZcadWOeUNEp73VLfEMkxW6pf1RxmsO83RBh9W9oRrzQmN7nfxuO16a/sufZUuv2P84SReXtytu+OQtNSxoitLt8biQNqhDPMqt7Ae27952Q9801YDTLGwR4gFCqp7EyEgY3NCt+jbhZ4WDSOu8OJwrRXqMqEpk/Nvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKo8ncPO; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45eee55b597so900173f8f.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780061361; x=1780666161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+CWotcliT6zQIjcAHTd32KhZWmuLac4qETbDggcx32Q=;
        b=JKo8ncPOdYISSHVBt3FrDJlDugHX4iF5AvypHNimCFydl7YwxihlmUdUTNlCQwA39O
         NpVf+5r4VkzVZVrfqCIwy35X5KF9fNlCkrpR+4Mi7nqVsjdjVmlpmT/L7yd8DDKFv25w
         7MGp5Uii3zug3CrckIotp+vdOqkLxGKIfklJyaDPitj4S3+4PvH1lMGl29XNs81Mmmjn
         oWJEtY74D11tWmk9V/otZJF/FlYbKUoTtVqTunhFOYSgAsULY2H8DtzEo0cxznx7QmKP
         uZ3fffGCEV/RTpOSdt9JZ9tkmoQcW33wyQRU/JeCorhmeRXmW4DhVXNah8L5IBlvl1eP
         0lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780061361; x=1780666161;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CWotcliT6zQIjcAHTd32KhZWmuLac4qETbDggcx32Q=;
        b=gW1iZ00jNV4+r+2q7ZNgYai9OPlpr9SsQFLjUo2qgRx0OB8+1f8eX78yptI69hjG3S
         38QUDWXsk7u9k453CCK+xLhDniEnOg423nATtsOjJqKu2O+NU3qG7McwuFBn7PdXR0bt
         0nnx6sdoiRxn+kgb4vOxuyYfFXjY/cx14wZ52qMNyNgCpczdaNPgpyIT9PmCaLhU3j3P
         8wNqx2MO9G4EywFx1dMrDNLNd8gBtn6QdXKNtIBnBEGOJisafgXgKOohSOI0AUOSNbja
         Sk5pNU7oi3OOOrsBjgJdUWTNl78EPizbGAhc+djerbO+m1/Ad7OQN241cF9ZeUyYg5j7
         y0AQ==
X-Forwarded-Encrypted: i=1; AFNElJ+55YD2my8MXIj7FD4ZHcp1wVYx08jwCAdWqUQIpGmg8nNmI1FszhPRjX6MyYR9H2592iIEqG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLZjNIUB1cQ7TU2lpykNDxKTgcVp2AVazhXf/FqneyJ1Kq8nW
	FeSkl9rcJHHhIZTfdluNXvU+vrtSNKhRlXuiKcz7I/InSSVqPKJnJzWjI6PT9pyE09s44/TflBM
	RVePAAq/SMtDz0ixoBg==
X-Received: from wrbdy6.prod.google.com ([2002:a05:6000:e46:b0:446:d23b:d96b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:ee8e:0:b0:45e:de0a:1773 with SMTP id ffacd0b85a97d-45ef1463a9amr4136473f8f.33.1780061360817;
 Fri, 29 May 2026 06:29:20 -0700 (PDT)
Date: Fri, 29 May 2026 13:28:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIaUGWoC/3XNzU7DMBAE4FepfMZovf5p0hPvgXrI2pvUosTgp
 BGoyrvjlkOKLI4z0jdzFRPnyJM47K4i8xKnmMYS3NNO+FM3DixjKFkgoAMNTlIcA2c58nyO45v
 0DSoFhD3tjSjoI3Mfv+6Dr8ffnPnzUnbnrTzFaU75+366qFv77/6iJMjQeSZLvtE9vgwpDWd+9
 uld3LYW3LyBpvJYvIegcR+UNdpWXj94ZSuvi28McUud08z1v9m8BVN5U7wDRUb5gJZqbx881v+ 2+K4FxhY1E9Mfv67rD+dvlEjCAQAA
X-Change-Id: 20260306-binder-netlink-c82110b2fb74
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2872; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/iJHCtlUB7ZZdvLrVonfY3NnlAeU/QaU7QZAo5L5qNM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqGZSKRFumD7moMd4a4uIjwu3BirqEdLijHukCI
 0usj+HExAeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahmUigAKCRAEWL7uWMY5
 RiA2D/9poDQsb+q/Y0X70eC+zLhq6AhyWHathtKG54Xr76OejbANXjK+fKvB0e/ZTHkSd6Z2mCc
 RTz8oQS88TOxEeC8UOCDZGGmSDiE4En1vIJX1mCPnR0iuWDu/HCdUndfjXCjXSRQM3h/ys8zlNV
 zXeUONdbTMa/7u7wQf8bnSxLf1zRhoq7kMS7zJoW3Zp4LS/L1XQBbWQKsh/8eYuKJTgT8UXqbeS
 M0+W1nyLTHO5by93+/nyBLtbEBM+6CC5O+f2AsFTGy5acapGnAUVp5Js9Hf2Bacy5biSreuyBtD
 rtdv+vMdhzn/RHM/s7BSnoyi4hiSqOcNIcgT2z97VyJtOxVw7Z+hX0NFWFGCzFvtwq2umHho9sZ
 u9pWD4wOCJUZPdG/56ggJ0SPMeRxHeEZI+CPgVjOtnP26b11jQCyrXDCMRF90UnTHz2vyHZfa8u
 wTlIayeO6pA/TkWSy7XOjNKT6TACg7dQmGt/94aSLiMPkMMMQ4oIcuxM25CTGwfylJm0eMt4nis
 ZfwdY+Nkc1PIIBu7Jh1CAlyX3HqbN3FqJqV/Ph3/26PE4NuCDtwk3DPmF4uBDO+Zrm3DJUOInMC
 YD7N82psjjfHgGpPBKijuPMAxYK5xee8mtSBS9xzM1Fvm2yLS7RRTwn+H5NbqMOYgJKSsxBu1KD j+9QYQA9dsd2yvg==
X-Mailer: b4 0.14.3
Message-ID: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
Subject: [PATCH v6 0/3] Rust netlink support + use in Rust Binder
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293123-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netlink.rs:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,net.rs:url]
X-Rspamd-Queue-Id: C7D2C602EF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The C Binder driver exposes messages over netlink when transactions
fail, so that a userpace daemon can respond to processes with many
failing transactions.

This patch series adds netlink support from Rust, then implements an
equivalent API in Rust Binder.

As Binder only uses broadcast messages, I did not add support for other
kinds of messages.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v6:
- Introduce MAINTAINERS entry update for net files.
- Move netlink.rs to rust/kernel/net/.
- Tweak info.reply logic in Binder patch.
- Link to v5: https://lore.kernel.org/r/20260525-binder-netlink-v5-0-a90e2923ebeb@google.com

Changes in v5:
- Remove patch 2.
- Squash patches 3 and 4.
- Link to v4: https://lore.kernel.org/r/20260504-binder-netlink-v4-0-601b41cd25b2@google.com

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
Alice Ryhl (2):
      rust: net: add rust/kernel/net to NETWORKING [GENERAL]
      rust: netlink: add raw netlink abstraction

Carlos Llamas (1):
      rust_binder: report netlink transactions

 MAINTAINERS                                |   2 +
 drivers/android/Kconfig                    |   2 +-
 drivers/android/binder/netlink.rs          | 117 ++++++++++
 drivers/android/binder/rust_binder_main.rs |   8 +-
 drivers/android/binder/thread.rs           |  11 +-
 drivers/android/binder/transaction.rs      |  40 ++++
 rust/bindings/bindings_helper.h            |   3 +
 rust/helpers/helpers.c                     |   1 +
 rust/helpers/net/genetlink.c               |  46 ++++
 rust/kernel/{net.rs => net/mod.rs}         |   2 +
 rust/kernel/net/netlink.rs                 | 337 +++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h                    |   1 +
 12 files changed, 566 insertions(+), 4 deletions(-)
---
base-commit: 5ad28496055858166eb2268344c8fda2c26d3561
change-id: 20260306-binder-netlink-c82110b2fb74

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


