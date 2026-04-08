Return-Path: <netdev+bounces-276501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN5XMEhK1mkFDQgAu9opvQ
	(envelope-from <netdev+bounces-276501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:30:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E33BC10D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B83330E7522
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13C37F74B;
	Wed,  8 Apr 2026 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNQ0//Mu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEE3806DA
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650856; cv=none; b=AfHQGsO0w1aGJbIWzKT2Fj/Btodm7xIFdAmoRpu6fpMIPZyTkVtbZEtPDXEcQckasEn/NewnzFcEmuMX+esax6ES/7LYZFD+p2zsVpPGXD62NhxJlEfczr8kXtiwtIppGyfAvFcIeSCyhgECXjkliN5oimBg0VaItmYuN8jH2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650856; c=relaxed/simple;
	bh=/j2Ri30R3UVLJIjKWTRLhE4aI0iO01+XNfUHuzYN73E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y9A+LBmoB3XtG4fae7FAXF+JOPokmngylMoZaeiYj6dOf9ms+KcwSKfJyOF9lXe14W7fpGBEXp1RUga7L+rmQn34P0I5TEIFF0WjN9JPQASCfR27dhF5el8BHnq7mWmlkxWbJ0EtQIZ7y0zW/WqzpYlrPDUYiP+cjy5PihWjfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNQ0//Mu; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43cfb72377bso4112264f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775650854; x=1776255654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tf7zvGdKL20aTK6IWM9ZuguGM2GoTZZWvgxCZM7A7Fo=;
        b=iNQ0//MuKFjuHDPUQDLiHloYDPp0jjCpC4F8ZvK/u/+6nayBtk26iRVMSymOcvn17a
         ZAlNa0N0Z0SqzrH1BDvEgblcPIPkOysFIBfZN3qLObnEZ6eVvNUuBVE1O/Tau5EgR1p3
         IB79XoK0xytISoxaTb6xomqKAr1hyrqeldbd7ObDUTkH2Qh0sOdZuONq+0tTjgUMdcJe
         RBcm+TfGTQcL7s+GqTaklQS7HZkAaju52xwDseUhX4UDUgDGYAFsA176bZlOv+NWoTGQ
         cM2yahv6zBa24m1eP+O5u6lVzbbCqImeehQJP23q2DVrYIoDTBwFlHSxN2rpG6uY6qHq
         YWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775650854; x=1776255654;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tf7zvGdKL20aTK6IWM9ZuguGM2GoTZZWvgxCZM7A7Fo=;
        b=ANPukzEQJMNu+jH3AEO6TE2kxS6Cx/VLeCeQq0OFGk75srWjh+paiaR0m1zmh9gkfJ
         WxnJ1E0I/d/kaCYveWA/EVG8yPyiXUovkmPZ86uK/GPCTqB6HUhPicVqf21ReP1IkvHH
         vaVko5PF14G1hvXD21Rafk+J5GugXR0Zefy8GvqKyz5NcGGZ5AuefsKgwJl9SMD3RmxD
         JZ1jdh/LFStDzXzdtd+gpiCJ9QnFv8QC0Q7GS5PMlm31v8omJgS0GwUjTgVoHbp/fv15
         TVp5fzQTssQtHuXAmWaspdcAUInLlyON1RZFW3QYpYvmn2VvR8antKWgks+//g8lObDr
         GnEA==
X-Forwarded-Encrypted: i=1; AJvYcCUdcL3M0eARSurhh3iA7DFDtdILwg6sLGP4jw0TMkhmKEtpQwI/hQolSS22nXHPPqRyHxJzU9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxuxqehy5TpVnlMpWjqm0KWXJKjycFC1akfVMbfq7PCTGevNt
	FdT8A7TBfMAhuaDvajKQqRVNOsrrn7K/kMZbh5pJ8kXaZaA3D6tPe+iW6KvFnfiz0wbD4UvMvMv
	qEOP7cJxbg+0IpldKfw==
X-Received: from wrbdu6.prod.google.com ([2002:a05:6000:d46:b0:43b:490d:df34])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1ac8:b0:43d:604:56d8 with SMTP id ffacd0b85a97d-43d2930fd69mr32444215f8f.49.1775650853570;
 Wed, 08 Apr 2026 05:20:53 -0700 (PDT)
Date: Wed, 08 Apr 2026 12:20:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABxI1mkC/3WNQQ6CMBBFr0Jm7Zi2KBJX3sOwoGUoE7HVFhsN4
 e5WXLhy+V7y358hUmCKcCxmCJQ4sncZ1KYAM7TOEnKXGZRQlShFhZpdRwEdTSO7C5paSSm06vV
 hB3l0C9Tzcw2emy8Huj9yd/rJgePkw2s9TfJj//aTRIFda0jvtanLXp2s93akrfFXaJZleQN2T +9DwgAAAA==
X-Change-Id: 20260306-binder-netlink-c82110b2fb74
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/j2Ri30R3UVLJIjKWTRLhE4aI0iO01+XNfUHuzYN73E=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp1kgf75NbJF+aQXk3HqxmyaU7yhcX09pLE/5jB
 KoPepAvoxOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCadZIHwAKCRAEWL7uWMY5
 RnKsEACTIUHqmHNXr9Re4NG9KdJ3eejor5hPdME6+y5kfp9efZ3txg+8ax+vjPyCUqrzS4Adcz2
 GhBYzk9WBzQR18q8Fe6C3MmsTf5yfE4OxTend715FAVnsTbUWYODiTZF/vFbL5mYmr2un7n1+D3
 mfmL8B/JuBG7Omqc+Zk11erkZ/YtpjgnbgqY5j1i3EI1n88LrVt42ICXUSQqhGRspPxPoH352Gv
 YUtmrIAqSxCjf+WRRq/brK6nRM1TdRUMSdWdBh2ourAOVoMAXO5beLRTmALZwx+6DifYBBUpCka
 /72LLP2TwW+6Dhva3O+CH/QcMvQzCRKxQgaqEHlylHB4rasZKGbLKNkjM0+DbFKT927kUZLcrXf
 khZEpKxzfFffezmasfpqOmAFqn5f0Z6LiBDpBdAEPTbVOhoKmjdNxF6048Xa80bCPC4vliAupcy
 rsdjmS6U4bsejkYfe/k04eo0BMakZDsLaNBq3dND4w2obfxDG/zVMCbthgs2sivbijUJmANIRT0
 /xlihcOGl5o4rOBY8L4Q1L0c1RgZ6ZQlX9T0I4AGG33pWK/+K82BV1Qu48CqW16qGTgdw8jQQZ0
 pg0UX16QFDHzNQiupHkUSxAJo9dNiy2l+XKsKWNCyO/Ssu2LbW5ONquYab2+8TctneU1T9BEJPn ZVhy4MN3qzSmwKw==
X-Mailer: b4 0.14.3
Message-ID: <20260408-binder-netlink-v2-0-c0d327d15435@google.com>
Subject: [PATCH v2 0/4] Rust netlink support + use in Rust Binder
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276501-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netlink.rs:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 372E33BC10D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The C Binder driver exposes messages over netlink when transactions
fail, so that a userpace daemon can respond to processes with many
failing transactions.

This patch series adds netlink support from Rust, then implements an
equivalent API in Rust Binder.

As Binder only uses broadcast messages, I did not add support for other
kinds of messages.

Based on char-misc-next.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
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
 drivers/android/binder/thread.rs           |   9 +
 drivers/android/binder/transaction.rs      |  40 ++++
 rust/bindings/bindings_helper.h            |   3 +
 rust/helpers/genetlink.c                   |  46 ++++
 rust/helpers/helpers.c                     |   1 +
 rust/kernel/lib.rs                         |   1 +
 rust/kernel/netlink.rs                     | 329 +++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h                    |   1 +
 tools/net/ynl/pyynl/ynl_gen_c.py           | 132 +++++++++++-
 tools/net/ynl/ynl-regen.sh                 |   2 +-
 13 files changed, 682 insertions(+), 5 deletions(-)
---
base-commit: 0990a71f678aa0f045f2c126b39b6b581844d3b0
change-id: 20260306-binder-netlink-c82110b2fb74

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


