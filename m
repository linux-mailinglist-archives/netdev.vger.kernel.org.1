Return-Path: <netdev+bounces-291322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIZ8IcdMFGpeMQcAu9opvQ
	(envelope-from <netdev+bounces-291322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:21:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0B5CB064
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45DE8304B69E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9BC37F758;
	Mon, 25 May 2026 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzEdWEh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7F384242
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715064; cv=none; b=hOVM8Sv5dSJC0DAtvKf+YB4ar2UYlLZrqzXtY19iEsKqJUJCFpxXX+9Ew90/sxU3FLlN0eTfgJCJnD2JiTNFkOr2i6Z+n5veE7uK2LDkfeAizp2ZcmEK7bobnyiouQPZbSyKnfZrl/NbWhyLnNVcUJOmNrPUZIyHNObfv0HvfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715064; c=relaxed/simple;
	bh=4If/o2OX+ZW8k0516D2bD5teniSCcga6VoMuSFlNDok=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QY57KfFaP+1aDIONDeMClFJ7cL8deBULd2VOHCSCduDuxnaWVlNw4S1rbuYGRxuh87DjUzDxVnXHX4nScQuxUZ6ZMyE+xq8Mu96up7OVWsibJjtrOdQJkgpnBya0SFLlJlIYXovit+S8b6ogok4Pueoe6Jh4I+y4unuYH+4m2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzEdWEh4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so19385865e9.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779715061; x=1780319861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Eb3AbcCjLSWMmgt2DoqhcidSWGufXOejNAXiyWhMoM=;
        b=YzEdWEh4r6XMOcsF4FwOLG2/NsP+2iVzFOw+KIL/IwYvEturRNEwkF27Vk9cLjVz5n
         NKq75BSesmc3FfZFN+RSPVm5lHh3zLgK6zVEsh/cMybT99NZbwdHHvgqb/VqPSASRngP
         TsZ2IOB7VxQ92rsQPSXxW4/SKJWB9LITW9/NzQnN5CqRffAaXcTnZPB//5i5dt4E/ZLY
         suZ/qbBjXwJyHYt2vDQnAIdc9GXvTm+FIGKHV/DG+ZqEv2oBoEdPM/mf34MLqrjLEUQ1
         lFi0JalQMGBh67NOvdr8be3+9Gs+5mAEqBrmtezKlsmC2i3SHyaGNG/tcvAozGw7bsRm
         Aczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715061; x=1780319861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Eb3AbcCjLSWMmgt2DoqhcidSWGufXOejNAXiyWhMoM=;
        b=B8dw/EZ4El1n9B2e2y6hq0ko1hgtPJsgJycZcPX51C9eePHKJMSaUKwW6dF0XTWBXA
         Uln+PPWxDcTLwQ3JCWNulQWs7hO4xq72hM5uLYTgPYSQ+fPZZv1GxFwbFkhSyIQyfWnS
         TeTCfL3x74FUEjYbA9RlBhhcHelruU3ROUpI7jrZk/rxZvv6RVG3Uih68TobF45mER78
         B9+yWiZbOhsUTp27fhTBkP/Cy2/fBS3Pp1TQinH3GofKbpV8iTFiLF6/3yDuqJ8oRmzD
         sYv8xwKyTmvTNjzwXDS7uGPU9Vta/z/panolXjDor5BjHjH3f8qKalY0vS4UOtTX1+9b
         Vrfw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZTZ5yst0JMJl2U1ajXEb3TuXah6gC5cld67isOvekBhnKwm71CnNaIQ2UbHeRklttkxpL+dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEQgvJ4f9CsPVbuj4RKrIRZ9t8PKKpBHDoG3RacgpKJiJzS2O
	xmpo+2K2OvNyC1V02bKA37Fr6EdAcAa66gTrqowfdfuR2erC/vNFJ1umiJZN/2LyVBnV6waeLZN
	NKqsb8Lt712xZGRCR3w==
X-Received: from wmfu8.prod.google.com ([2002:a05:600c:1388:b0:488:a71c:cf48])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b41:b0:490:4a1b:d8d4 with SMTP id 5b1f17b1804b1-4904a1bd912mr200379925e9.27.1779715060904;
 Mon, 25 May 2026 06:17:40 -0700 (PDT)
Date: Mon, 25 May 2026 13:17:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOZLFGoC/3XNwW7DIBAE0F+JOJdqWcBxc+p/VDl4Ye2gppBgx
 2oV+d9LkoNToR5npDdzFSPnwKPYba4i8xzGkGIJ9mUj3KGLA8vgSxYI2ICGRlKInrOMPB1D/JS
 uRaWAsKetEQWdMvfh+z74sX/kzOdL2Z3W8hDGKeWf++msbu2/+7OSIH3nmCy5Vvf4PqQ0HPnVp
 S9x25px9QbaymPxDrzGrVfWaFt5/eSVrbwuvjXEb9Q1mrn+N6u3YCpvim9AkVHOo6W/flmWX/y l+pWCAQAA
X-Change-Id: 20260306-binder-netlink-c82110b2fb74
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4If/o2OX+ZW8k0516D2bD5teniSCcga6VoMuSFlNDok=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqFEvtyopGP/gLT9uM3cPVnpxwPjd5bSnXLBv2o
 0UWs0CXKMiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahRL7QAKCRAEWL7uWMY5
 Ro0VD/41ifg3qJPvQVMbsWWWTWn47LNLJ07zFc5y4n9ruYykcrUDjz3suMr6IFQazmk/mxi6oeH
 4/oyTjrrmIwgsUr/gqLU1AM9bJGQQ8zszSzKrE9ur5qZlhOMEuj+rd8RARfhuXd5HtTaxFBpZaN
 5UmtAmn/PMIIN8epM7Jrhiv4+7em5cbPdu3gVPr0K7JqDJ4VJ9MeKUlYvVLZSYkH/xUN3RwiR8S
 f+6LGgDln/ljJxH7mu6Bn1x8jS2v1QSVsvMphx0WB8DfltZz497tWFbF8MT8t6zIYBu5F67pheC
 5dYPyIyXL1z5Y/lkNkGU+0HdfryiPoT7BxPVrJmOUsb/3TcJvhDjCXuqSw4TZADxEDIrV04Tqn3
 aIg5TzLJTK28mgKAeDBf8+mwpjTuP2A+CXLvH7y7rZbOKjUh1raGbRhKtc/lp+swDIKlZCo/A5A
 WJtILkNSSxswZ9PHkS0HsVy+CgBqLHEmet3MpoVBwhejw8IqBIuwPH+ZXHV3AKH27lnPyWAXpjT
 HHbl2oHuaOfJfn2L4qifw0yHfhgMMLlotxaveATDWyhcBvJRzzivvnOI+qNLqUhk5Q4EIFSXxlh
 9Aq9pdFW9c2WSkpCdGUgTF4IijCuSVD3skJhutvr9vk09oyiBi04ktDOOJYJph9IYNmmt65fred 9H11VebIOfa/Qnw==
X-Mailer: b4 0.14.3
Message-ID: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
Subject: [PATCH v5 0/2] Rust netlink support + use in Rust Binder
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291322-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.927];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EAC0B5CB064
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
Alice Ryhl (1):
      rust: netlink: add raw netlink abstraction

Carlos Llamas (1):
      rust_binder: report netlink transactions

 drivers/android/Kconfig                    |   2 +-
 drivers/android/binder/netlink.rs          | 110 ++++++++++
 drivers/android/binder/rust_binder_main.rs |   8 +-
 drivers/android/binder/thread.rs           |  10 +
 drivers/android/binder/transaction.rs      |  40 ++++
 rust/bindings/bindings_helper.h            |   3 +
 rust/helpers/genetlink.c                   |  46 ++++
 rust/helpers/helpers.c                     |   1 +
 rust/kernel/lib.rs                         |   1 +
 rust/kernel/netlink.rs                     | 336 +++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h                    |   1 +
 11 files changed, 555 insertions(+), 3 deletions(-)
---
base-commit: 5ad28496055858166eb2268344c8fda2c26d3561
change-id: 20260306-binder-netlink-c82110b2fb74

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


