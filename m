Return-Path: <netdev+bounces-265187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wINqEOqYrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:30:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2522DB5F
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FA42301CCD7
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C736F41B;
	Sat,  7 Mar 2026 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpInvjh8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E833AD99
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919015; cv=none; b=Tpw8XMJvX+55qCrW0xZNV3yMCdcth4CNqILTrlAyLBn9J6b7LGIaxphrUT0K2RkXzy05coOiJ8Tfk7DE6B6+d5LX6Q7dek7fyQ+EeiIqF5XKpuV165/1bad+zyL+RO8LzMW0Odqpw8tXwy8ZaoNoc/Aj1vKkXNuauW0CTMKA8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919015; c=relaxed/simple;
	bh=5blZ65rb52lpa9/KLUc49AAPOcoeZtUgQI+crtdIS4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=muLeDVYxwYMJOoQGH+60cC88wIqGzb0tdDDsWxgcDFrEDRIHi2ibh3odkzc3vdmCrf3dVz9J/MwKp5LuU2uPKEu0yCRJI9D1dTBUQ+ypz6woJLXBT6EB51x3rk3AvHVcUJoBrSHs8RaHQILjNUajgVjtye7C0fOVzrnkYk/FEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpInvjh8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so446915e9.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772919013; x=1773523813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrqxpHngCov/LvVCWNrhiPff2zJYB2s6GPlhyApK1cM=;
        b=hpInvjh8seVsmn2NdXieKNpeQv9ZC1ZZ1MPHY59EYJ+uTwkWJb8x1ih/O6X6ek5Eih
         6D9ulRSIKj+ZpfjdkYzDXPopfvu7NGDY75a2RXsLcC0WcQlbA7TXAaPrMYlMjwk7AwNF
         V09wA0il/FUF3F9G0tbPboYfqjmlzi6D1xGaCQAU9ybArRwI8E86is8QlviZHtqJII4n
         UaqoTWC75jBLeXVw0zPxQJtN8iVP1LXyzRVXRSYATilBcLy3r7R62OyyPMN9XqophMec
         DIVrjULX8NTyOcexQMtaUizmZAJDV0v2mRxKHQESmgETETbsirFij1ACDQUmuSKp4Pzp
         fnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919013; x=1773523813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrqxpHngCov/LvVCWNrhiPff2zJYB2s6GPlhyApK1cM=;
        b=YVYGwjmNnF8w47lbXKYVNcLGLzyyuj7/6EOwkxKyZGUEKdGBCSpuhJ9w2fKALY2w3k
         x+ndA8h00wLT8QXMQwXEz5jBzP1etFwDt16Y4NvLxjp9lYfJWqVjM3OXZs42WTcitAUV
         +aNGFqFIk6Rpb3or6Vuw0auf75cXMy9am2iORp9TWlNsLP4+RlUrWam/gOcBkMfI/sk0
         HVjo1SUfggdg3OeTECeUANzJkbTjxC1G2FR5hWwbhhhlaxZFxyUZweFxXEm0F0ZTyFzC
         Bu6/wZnCuVU8+ahFElZs7UxgEJfxN2llf0E2h+qKGHMBl8x+Qb6TYMyl918oh35M+iyD
         2UVg==
X-Forwarded-Encrypted: i=1; AJvYcCXPI2PMzHax14XS22oKcp/HQC9icwk1PHbjo1lgN12AXEfMSx8tIZdbaa5xWwOHkGcuw27WSwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUccpxp3ZvuXBvniWp8EezU4N92kFZQKllvhIiTQaamP1v9yRb
	tFLDVkWXZCSRl/UWwrTLq7zbb0u83xcdEy84Lxep2CPqi3S75uHg+8lPyQkrIddIfEan0I1hJ6V
	IoqPmv7uaufOzpi9LUw==
X-Received: from wmbdv11.prod.google.com ([2002:a05:600c:620b:b0:483:7c8d:ed1d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5253:b0:483:456a:514b with SMTP id 5b1f17b1804b1-4852692f158mr110926015e9.12.1772919012662;
 Sat, 07 Mar 2026 13:30:12 -0800 (PST)
Date: Sat, 7 Mar 2026 21:30:11 +0000
In-Reply-To: <20260307104155.108d5d69@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260306-binder-netlink-v1-2-daceb5bc83f2@google.com> <20260307104155.108d5d69@kernel.org>
Message-ID: <aayY46dOBAJdFVKb@google.com>
Subject: Re: [PATCH 2/4] ynl_gen: generate Rust files from yaml files
From: Alice Ryhl <aliceryhl@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 70F2522DB5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265187-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ynl_gen_rust.py:url]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 10:41:55AM -0800, Jakub Kicinski wrote:
> On Fri, 06 Mar 2026 15:12:14 +0000 Alice Ryhl wrote:
> > +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> 
> The name of the file says gen_c ...

I see there is also an ynl_gen_rst.py file in the same directory. Are
you suggesting that I create a ynl_gen_rust.py file instead?

Alice

