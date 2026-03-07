Return-Path: <netdev+bounces-265182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wImlBlGWrGnsqwEAu9opvQ
	(envelope-from <netdev+bounces-265182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:19:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651722DA7C
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32795301D041
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA07303A32;
	Sat,  7 Mar 2026 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/roz6EM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC062D9499
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918350; cv=none; b=mRgrIhYTcBD/cpy+pB07SKrJp8j624wzHeR7i5pNMsUlBplgqgKzQU764zbR4tU57TfwddESm2E8yPNGJrQnERtFiVTEeJcHhBGvkHWuM1yGpVS0WPHd9vfaC5T/lBMj2RHbm0qB9gwhBT1p5PSs8tue3p80eL7PYU6GoZ5Iu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918350; c=relaxed/simple;
	bh=Y3zExc2To8gm5Uokvv2lsc3X4xX3v+SfgtWbXGtWm9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QkBfH97y4BflhrKbgPNvpVxyIR49SnRK2mQ1I/UYnqL+XeIFM0AmbjKuEQ69xhwKkfAyZ9WbtUb568WWYj2+u7LPdwFl6ai3u4FTeQ0yJapzllV6+FfN5RGQdvKS7KrMm9/IJmLXoQ4CcZ/wnMX7kaPmARUMq11vezajHiS/H34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/roz6EM; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-439b50dfca1so5340933f8f.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772918347; x=1773523147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXKay9MbLzhkCn+559OyyxJkN2o62vFz7U9PKE2/DIQ=;
        b=A/roz6EM2MtDLG3CP6UEkk9VxMsyfOhUAcdetF/3G5ChQ9V0MpJo9yOy94wPAAQVqM
         UqgiT/bpoMsTS2iO21QMgUC9OCM5Ah8qnaIILZP23xlVkXWV6Rsa0y5RmSrKbyg6vH4z
         ye0szfHUNBrmzC/ToZrjhbuFxioJgheFY7y4yASKXAxUaQ9Zn17IYYkdXVAc3KDQMLXq
         PExUmhIJqfXtDR/6RREVqoiEfT/l1d2MAQkcLcOTzlMbVyV6djafx+lhRb+zs2Y+Wssl
         AVgraTvNkTvIB6RsPpayMstXMJKImuXBNjXyv+jZy/BtAjS8Oa07/3R7pMO8UCzlIitH
         MK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772918347; x=1773523147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXKay9MbLzhkCn+559OyyxJkN2o62vFz7U9PKE2/DIQ=;
        b=gynCwoUkZhjKqsdiO8Q8biEFYqPHe9p1iWNWsMYcBS8cG3BZjeIDHBdZZ5wdBsnZyQ
         fFnw8wKw165hbwgmmVLcC+ilvu3acC6nv8/XdAhufiQZR/TNT0WXDQfImxbC2oTFkWOO
         lIhSBZ3FP8cips7s2ZusnbI/FoWo+4vbe0edYFG0AZFy7YGwRLQA9TkdKxFhSm7y4aHp
         ulfKP9hKOophAR15EuRA2SKcrLdlbBFlE4cbrLv8+y9UiDBE5m1vVfKVPfVSi12eoHqR
         peYYdg75ODuO65+yDKTDQFW8PJFDjLJCN+W40uoTsJcClBg9s13kO2/Ldwn0WSFTSvhY
         2dqw==
X-Forwarded-Encrypted: i=1; AJvYcCWkYtH6zz5/57XMnPZ1Ocn+axNIbSJaHqYNT5WFNyzBkuy8QGuDKKwVFiojfqWjXemGM37VIBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQa3Bx9/Qi64gN/f8IVUzxO/UUN570p9IZ/+WT7UjOvFVJphQz
	jErkv0fcCGTg5pjWFqGA/Zbd6bBtanmnLc2Wm1D1HDvSCgwq0942L/mggitckbSucypudASy39h
	I3785vuVwP1RAg9XmIw==
X-Received: from wrai9.prod.google.com ([2002:a5d:5229:0:b0:439:c5a3:f5a8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:186b:b0:439:c040:cc8a with SMTP id ffacd0b85a97d-439da35f6acmr11648580f8f.32.1772918347381;
 Sat, 07 Mar 2026 13:19:07 -0800 (PST)
Date: Sat, 7 Mar 2026 21:19:06 +0000
In-Reply-To: <20260307104131.4c1d0de5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com> <20260307104131.4c1d0de5@kernel.org>
Message-ID: <aayWSuOM59uojtuG@google.com>
Subject: Re: [PATCH 0/4] Rust netlink support + use in Rust Binder
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
X-Rspamd-Queue-Id: 7651722DA7C
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
	TAGGED_FROM(0.00)[bounces-265182-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 10:41:31AM -0800, Jakub Kicinski wrote:
> On Fri, 06 Mar 2026 15:12:12 +0000 Alice Ryhl wrote:
> > The C Binder driver exposes messages over netlink when transactions
> > fail, so that a userpace daemon can respond to processes with many
> > failing transactions.
> 
> Ugh, now I regret letting binder use Netlink. Should have seen this
> coming :/

To be honest, I'm not entirely happy with what Binder is using netlink
for either, but it is what it is.

> > This patch series adds netlink support from Rust, then implements an
> > equivalent API in Rust Binder.
> > 
> > As Binder only uses broadcast messages, I did not add support for other
> > kinds of messages.
> 
> Please no duplication of existing code in Rust.

The plan is certainly to get rid of C Binder, but it was unfortunately
not possible to get there without a transition period.

Alice

