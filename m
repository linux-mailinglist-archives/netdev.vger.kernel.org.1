Return-Path: <netdev+bounces-293124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG3WNESWGWpPxwgAu9opvQ
	(envelope-from <netdev+bounces-293124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:36:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50753602EFC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBAD316A084
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C444330305;
	Fri, 29 May 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmFZl64G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258F2D8393
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061371; cv=none; b=B5sDe9gA7Bce43Wz+lEIQ2DfAfFvqgGG16UTKOldwAlGoQ140UtTfgDd4Vs2eEMw8ENXBeGJSJDS5/Fe5Zj2ZWB3wTplMh3YubqjXj8Vp9EigF4KymGZLqmMlN8jXZyjd3J2+hbyI++VwNxULqk3UqXmMPapjf7we1dTX9b7T4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061371; c=relaxed/simple;
	bh=jQS5w3juKxh/8rsWEVFsuUj2CrwmODGzA/KyT3vg3gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IBQfEnEuFJu4IBwjnv5VDY+jTklBGrc3FdseCkNPiwGED9pYqH+d2jghwGZ/D/hjXJ2KbK0cnoZlcPqWO1KRvSQpCB98ZHQfR6Y5BIgjcsAHJXreKObOmFMTfE6jXdF1OItjJ9f6W5HDTTj/tsHvwg9CtLnTSYljzQobTeYvwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmFZl64G; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fde68e420so105478535e9.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780061368; x=1780666168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPbFopuJb3xJlIvAFVS2VoE+RIwABLyaYMui6R01KkA=;
        b=FmFZl64Gc7i49EyjzIirjWG2i/yTFM7NMaC3UUKBIJJClZNNSvXkZHrB7YB+GYqKPz
         GcwkGCjmLzrvKO+CR2XiW5EI+iI6MSo8+/GQd7fuHmboxNliLYSN3cC9htXs7Jhf63HV
         gdftUykQf07FDQflQs6x7kqfIjYB2Aj60uOMKY8IFlknYvZjvVdPmF5H9jvfE3bG25o6
         6IOMhcmXZLfYC95eNvG5XLX3qz9nRrXbmZIISdTM4UgYEGgQyO9h+vINT6QDvy15tK7g
         F98braQndian39SJu9D78orsWNvUGOEKPcGNXuTpakl+nMOHSdm2JeoXMeA9pjr++p7w
         bnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780061368; x=1780666168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPbFopuJb3xJlIvAFVS2VoE+RIwABLyaYMui6R01KkA=;
        b=SbqdpTexe09clIKGubB7Yv0hjaG/gN4+T1H2nwZM++5yrsCueqp9WwuxPHBmS9/k7k
         iMM5SlH0lZYntXwnqrECFCFzdWfYSd5i32zRrv+zf5vIsyS/oSYHCFo8UZzyoJBB/zH6
         j91gVgoEM0/upFdBkkOLCtMPyKsyTrVJP2aeR41D3rRI6Pn4xb0DZ6f/iM86spa9RuAJ
         CRdZ2qeZLSKQOTtEL7wdI/6FOnMPw2bCp5pXzP9ngPCzfFce+opCm+Ij77cuLDG/PM/H
         J21uohOJro/Fc4dZDWiD2Tu7SNuKMdVsyW3yP8+FR8Dj4TV69DvgNL4yz898isQEGu2y
         cs1g==
X-Forwarded-Encrypted: i=1; AFNElJ9kxrNh23jOeVy0hqWbr6JfGZJ7OMwnXs9PRFDfB4C5JP4OHWTzCl2BR1aqWzxgAAyu2Mp+PyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8RP00AgpeOs/RR7idG+mu6bKk05A4UcdXTsNBfaNqtaLZNgwW
	4ROGtQE0F1jFpXYXOd940GrHOrHDz1gBhMKWQUHspNmDuf2ULLAxj8OIW0Tyt9xsfXLchREcvs4
	7zoKc+qn3jtWnlrtdtw==
X-Received: from wmla10.prod.google.com ([2002:a05:600d:238a:b0:48f:d328:60c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4589:b0:490:50e8:45c3 with SMTP id 5b1f17b1804b1-4909c028fccmr57511305e9.0.1780061365120;
 Fri, 29 May 2026 06:29:25 -0700 (PDT)
Date: Fri, 29 May 2026 13:28:38 +0000
In-Reply-To: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=jQS5w3juKxh/8rsWEVFsuUj2CrwmODGzA/KyT3vg3gc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqGZSqiLJlV643r8T6gfx80O09094kuKPpWw9NA
 E1PXS3vroWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahmUqgAKCRAEWL7uWMY5
 RhBwD/90l0syKd+gZ1Z71dZ0oWqW+27vPX2QWMsTCj7diDQn408Q4NI5cWOxyYmIy19+bbOz/by
 MuUe5K1VYbw/5ifmAf5o77bZyisqa6EwQwLm2cNGrV8ErTf2uPngM9LDB/yRVZybATAeuMLeodA
 GJeof0Vo0m+cKrj6UoXmBEjiY5NbMXKjOnwdtmTQRvMhin2569HK7Dic++xoUUwv/sE09rZADrS
 cbfcLEBsv0ACIh+R/Oksnyz8Jq+GUjcBBt+nlpUWmHuCuYbN3OSiY6MaWodtWN7DbAOU4IGxpFV
 kbzWtpb4hoZeKQ6eKlJoenHuwLA0TlX3sIYRAwOkMtcpmRl9fxEqMn4SZxt2wJFb980pEzpOppL
 7mD9POOAt/wexriuoQ5UeVn0XxWx4zPxlWmRrF2Y+FD9MN1CDQ982dqfrKVTwLfFVAV99viGtEb
 CJCqlfUaImTMmYjMDKVLe2KAiDFLDPKX8EKLQNmbQcHV3+69yysD3SgJlQAp72k6LNvwGmm5t8C
 EsQ/pQajhXT/HGp57F8EHAz5RZIA414UOnFuQyZ/3d7nR3HchfBCp9JFspdNNuXr5W6wBHhrUg4
 2eikaXLsYTjTN5pMuAowxS+OYjHmwQpLZYUwN+cVTq2eKUEqaPxKG919gMEXr2nkLVQSy2UuDRb A0CcsEogqS3u2MQ==
X-Mailer: b4 0.14.3
Message-ID: <20260529-binder-netlink-v6-1-92dd74b6a32e@google.com>
Subject: [PATCH v6 1/3] rust: net: add rust/kernel/net to NETWORKING [GENERAL]
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
	TAGGED_FROM(0.00)[bounces-293124-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[net.rs:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 50753602EFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To ensure that networking code can be found in a single shared place,
add it to the relevant NETWORKING entry. The net.rs file is moved into
the net/ directory so that it's included under the MAINTAINERS entry
without needing a separate rust/kernel/net.rs entry.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS                        | 2 ++
 rust/kernel/{net.rs => net/mod.rs} | 0
 2 files changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61a229670b3..08bbe8e0a74a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18612,6 +18612,8 @@ F:	include/uapi/linux/sctp.h
 F:	lib/net_utils.c
 F:	lib/random32.c
 F:	net/
+F:	rust/helpers/net/
+F:	rust/kernel/net/
 F:	samples/pktgen/
 F:	tools/net/
 F:	tools/testing/selftests/net/
diff --git a/rust/kernel/net.rs b/rust/kernel/net/mod.rs
similarity index 100%
rename from rust/kernel/net.rs
rename to rust/kernel/net/mod.rs

-- 
2.54.0.823.g6e5bcc1fc9-goog


