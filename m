Return-Path: <netdev+bounces-264843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLDgKQPwqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:17:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E5223A0A
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9856530BB29B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFA3B4EBB;
	Fri,  6 Mar 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S478bMVz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371CE3A5E92
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809946; cv=none; b=QqYxKFoxWnt61Yjhx84g2el7SRmTykqFW4iuI43cuOIRkOKzDvnZcGxpQz5Yh0qxPZf5UBCtJDIpgY7MeB4fyRn0JhiP4vFE2MBp6oE/R7wCiVD1W4wuCsKdAQhOExUAixzbA3f6yyL2IaFGIF/VjWHZQgViTMSjSkFEScXZFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809946; c=relaxed/simple;
	bh=CcuZ7x50ZbKdcWsboDu607FONGcuWckEDkzKf2XwKPE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HH8jDwMlGJDoZKzkbo3mrhmVeC59s8TIuLCZPRxYWm60UaOknQKt8XMFBSLEmRvhXx1lQqSI3bwbbMbUPP9bIMQIsUkrlUTVByIoMGZI6ufLPAizvm9Btz3Leg/DNVX9aHuq22d+gcKGGElZ7wIgk/Ks6ZCFHs8h9oSNOLTbE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S478bMVz; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-660f37136ecso164773a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772809942; x=1773414742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNgeuUKd8p8B9I58yFkmfYluj9A7gTGoDlArKOHyv4w=;
        b=S478bMVz+ES03W0ZeAtWkRfC49YuVa+aFcfkogkf4qBxIZVOMRXNia7DwVay2RyUBY
         DBLzw0wmQctVztZFYacEkf8LhhvMdT8nTh+EjPIWYT8DgwRKUjBVymzoNCEMnl2sLsWg
         RRErtB32JrVX2i/zt0/dkqUAjrlSpXJwkIPDpvO/cXL0Yu9LNNIyQtGlM5TVkB2tZJsA
         HIh/Td9CD8C3tx3qepT9OQe4kzgW3IM4ui46eBY8VFG4Fi4s8UmBNm5Y2tQM5YCpD1eA
         SFwM/Zcj98hWtsewnoBaPjOOFKF7VWc+ZZgOhMSGnnTtnhF4lVwA6OTZTexAqHBFIgaQ
         9UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809942; x=1773414742;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNgeuUKd8p8B9I58yFkmfYluj9A7gTGoDlArKOHyv4w=;
        b=bHdrIz7gbMCGZtftwjfs4vpAmaAMT9MQq9DoJrhVSZhNzsv2F3qKVpFclYGsIdRXra
         gtMDHeyF4nhyWrIbElT2rbbpdKjH8UpbKUQf2Awg4HY0z19yFRlmJ7XCi7cAe0bAO61r
         1rPyPQydd9paXqXPpfKkEUiw8JarhiQ+t1uKovAUdJfHqZNKGsDpI6launLgcR9aPykp
         Y9GfWPz1GjNCPlka6NLi0jrx3pEInFgRKcSZZBtVz0qhETtOn36rIXe4d7q1WXyTZM+L
         56R4lMXMipOknEwAoiOUkZ0CzvDI4x1thIF2Usf0WR2uRzZ6Nn1ylPOGZIWuKfvzjqxL
         mMww==
X-Forwarded-Encrypted: i=1; AJvYcCWZQQuCOHkBJWEzau6AZO5+8uuAW8KcRjtMYRXaJdcu1OlFuMOPjJ6gp6KEYh5BRZnG8vIYk/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33Osp3MQrv0okv+VMlBA9gWSy8gPgWM9INCevPYDxCXLpOSZr
	10zwBbsL0zKzsNxI5uPZqngFFy6OwqJMLww8xr4U8ZLPCdA1OJE1PpsmEI0n2RdNarFckEMNu+n
	cgVgEqjOa8Px/280u+A==
X-Received: from edew12-n2.prod.google.com ([2002:a05:6402:a20c:20b0:660:a45c:2039])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:234f:b0:660:f98d:227e with SMTP id 4fb4d7f45d1cf-6619d52eb37mr1422637a12.23.1772809942299;
 Fri, 06 Mar 2026 07:12:22 -0800 (PST)
Date: Fri, 06 Mar 2026 15:12:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMzuqmkC/02OQQ7CIBBFr9LMWhKgLZRexbiA6aATlSqgMTHeX
 aIuXL6f/Jf3hEKZqcDcPSHTnQuvqYHadIAHn/YkeGkMWmoje2lE4LRQFonqidNR4KSVkkHHYAd
 op0umyI+PcLv7cqbrrXnrd4TgCwlcz2euc9dHh4tyZM0Q7KStNEvwHtE4GqWWzmGQagge/nvm7 lczipp9Kh5rqxac4iqMNmOPZox2cvNdwe71egMgCnLx5AAAAA==
X-Change-Id: 20260306-binder-netlink-c82110b2fb74
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CcuZ7x50ZbKdcWsboDu607FONGcuWckEDkzKf2XwKPE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpqu7QS+EBip3jp/+FTU3T2JWZR6ADICZPOsdmg
 GX6y1VAWNyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaaru0AAKCRAEWL7uWMY5
 RlEND/94nBpB92nkQCNYhL5zc9F/ix3geujcwe59JVu9odMGgAlbpTa4Uhu2NjAvLe+bxNglfbd
 +7n5SBL31D4pGLcfzAzxALxYtkUJCK/kmXigXm6Vyqr+tAmaXDWOUt1AwQKlgkajPcWAF2htKTN
 JqWtO6WkR8YeM0fovzxqpwALD90/TLGjf9rBZT2YzpRD4pxCAkOZmdWPQBye6fu0Yb1E6vNfRBo
 oIT1CASQGepK2Q5pwkz3bXMphZNlfuwAD8wPKrWkPadj1qNRVqTHo6/vsPZawb3c1Hthfxi/a9f
 TNngwXKLzmsO5/s69w00uMfX8xjYhkQ2sNP5hk24Cv69JPe1b+JWrd/I6+2FNMv9Siiqp7W6ac0
 DahFznH+IfjRlsbzkGYK9heQGonmSQRjA9WSUr4bahD10hSnztoORZCTKCizdgkRpuI2elL1UCL
 Kgf9Iw5dtpbUE89291zn9JFpvLUQhZgHHxZjLZpi2mGX+r1ybeBqRvyKUglT119ExzQks8Y+kr1
 cfCNthpa7W4KeuUTuixtnx5oMSH8Ai8oWZ86JZ6qPC9LvK19CjWxiFljb0/zZM2ZfsXrhNGVSrj
 xlYTpmozcCcDDAn0Z/w5uWkPceGp5UMe3TnUf2bBBPQr3+0j7WufDgjvc0VSurZXMS2spYL4AOa 8LR391uks/Gu8oQ==
X-Mailer: b4 0.14.3
Message-ID: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
Subject: [PATCH 0/4] Rust netlink support + use in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 697E5223A0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264843-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netlink.rs:url]
X-Rspamd-Action: no action

The C Binder driver exposes messages over netlink when transactions
fail, so that a userpace daemon can respond to processes with many
failing transactions.

This patch series adds netlink support from Rust, then implements an
equivalent API in Rust Binder.

As Binder only uses broadcast messages, I did not add support for other
kinds of messages.

Depends on:
https://lore.kernel.org/r/20260306-transaction-info-v1-1-fda58fca558b@google.com

Available in this branch:
https://github.com/Darksonn/linux/commits/b4/binder-netlink/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (3):
      rust: netlink: add raw netlink abstraction
      ynl_gen: generate Rust files from yaml files
      rust_binder: add generated netlink.rs file

Carlos Llamas (1):
      rust_binder: report netlink transactions

 drivers/android/Kconfig                    |   2 +-
 drivers/android/binder/netlink.rs          | 113 ++++++++++++
 drivers/android/binder/rust_binder_main.rs |   8 +-
 drivers/android/binder/thread.rs           |   9 +
 drivers/android/binder/transaction.rs      |  38 ++++
 rust/bindings/bindings_helper.h            |   3 +
 rust/helpers/genetlink.c                   |  46 +++++
 rust/helpers/helpers.c                     |   1 +
 rust/kernel/lib.rs                         |   1 +
 rust/kernel/netlink.rs                     | 267 +++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h                    |   1 +
 tools/net/ynl/pyynl/ynl_gen_c.py           | 132 +++++++++++++-
 tools/net/ynl/ynl-regen.sh                 |   2 +-
 13 files changed, 618 insertions(+), 5 deletions(-)
---
base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
change-id: 20260306-binder-netlink-c82110b2fb74
prerequisite-change-id: 20260305-transaction-info-62653c65f789:v1
prerequisite-patch-id: d324a8e3e611b7be5837cfb01c27625e657804c6

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


