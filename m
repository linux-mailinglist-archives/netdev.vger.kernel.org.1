Return-Path: <netdev+bounces-285223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UETmNK5j/GkqPgAAu9opvQ
	(envelope-from <netdev+bounces-285223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:04:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFCF4E671F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72647300F61D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0633CCFD4;
	Thu,  7 May 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3d0aMF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA29371887
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148060; cv=none; b=hGC4PJyB4ZqC66n2YsrCzGR+xGSH/FrQfeLjAu5uAMTjV/HtL2FspQJwGUHv5sT7fO7I3U8t/WZ4IACb7/EmWEb8TDZS7STv77b2I7K5W/8L3OLt6MpAedX9TmFaylHtkU5Qklm8sbhXCbVHcpG78WMYLWhQKy3XhxzOjjsvhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148060; c=relaxed/simple;
	bh=Fad51TK8t7LXJcIA8vGRouxTYYfBGTrwnyV5+Q+CSjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3DzbtfTrh8SRKsN8a9rIz5Xcftx4J1ziY8koODj64s091owkGQkHlae6Cz9aHw255LQ73AmCQZCUjxKjnitMN4GEWiOO+s6mQvVZu8ZznuT/06MXRuDUVYoSIongkpeeLRVx2kxAG8pJa+Lvv/6Lv5UCA96ck/BQGQlMKgV/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3d0aMF3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-67b7e7d4a0fso460648a12.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778148056; x=1778752856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WH9SSo4GccpYaiPiSUekopeXssDOSRO2Zrgq3dTy8No=;
        b=C3d0aMF3a0gwoBemn3idDP4vDkLUb/lP8/iw1mz3GBLmpTHoybBqVOyiIU5E92FLsb
         4nlRNpZYZS0ap9VVmtb9yqCpJCXbONG8RhiUPsjb2S3zsmKj5dL0gdJLq+XnJzyVjrzH
         N7HvaNiHSpIG3vdTBr/EWGkdssNOGz65Z4l/Dlvf0c1e5G+g+8Q/PC6SAdE5WdkTCx4k
         2fKPTzlqsXPt1MSGnIekKLQvImu4ZW8E5nODUNwHgYP3qBJvclzvdx788zCWYKJIqT3h
         QkCqrvsobTVAZbUfDOPja/J9bMrJHDlS0Oxqk5INen0N3sa71yG2MCf6JTCQ8ilJDryf
         ZVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778148056; x=1778752856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH9SSo4GccpYaiPiSUekopeXssDOSRO2Zrgq3dTy8No=;
        b=cC5Tj8Te6N/kY1FfeVdKnoejgmTsPICgxpoMQTTBcB1caRdOiZC3+/DnhsTB8TKWCp
         sj8IGTKcxzTyUlQRDEwJ3rC8MgTPYTZ6pAOu9JqQeIdSLv/CgmAtEKMihDftW5b1Be00
         QqF473p+oLyK6I/HfIKjPScHHI6FX8YhodJSXd5PunnZj+38TpGAl9gNd5AjTiy/1yxl
         HTtAHPxVg3X3akp6sRTLpBb56qVApjNX7hwGoZ5/Zeg8QreICzUNgmWsrqAy0GbrjtdZ
         bxoUz2NuxRCsBPQ9pY7jn9v+ZjQbtfkFSqNpJaRbrTgYEsBuaaobK7fw6oqjDX7C3C7O
         qVbA==
X-Forwarded-Encrypted: i=1; AFNElJ8DaM39zuLURbyQlkW1oNAJjKB3Be2V4wuMiHvqQoHNt/O/HAsprlB2h6glvzxRubvns6sDfu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3EruEJ5RQ2kwPJcuAxVgm2SuTvqlnzHMXZ09Ha+JbNHORdab
	QySgeHgnybErTJg00+HoElM+pOAvzg8ZrauPL2iRsU+yoUs5M/lvSsGzHv7T4GyOvyTBCJc1Xzj
	MtExBHd0UhgXtBBe+TA==
X-Received: from edcm9.prod.google.com ([2002:a05:6402:4309:b0:67d:50a7:9bdd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:50cf:b0:670:64fd:2301 with SMTP id 4fb4d7f45d1cf-67d642b0556mr3796978a12.15.1778148054012;
 Thu, 07 May 2026 03:00:54 -0700 (PDT)
Date: Thu, 7 May 2026 10:00:52 +0000
In-Reply-To: <20260505171637.17e20b98@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
 <20260504-binder-netlink-v4-2-601b41cd25b2@google.com> <20260504165858.4882730b@kernel.org>
 <afmz-dgqXjuIntRM@google.com> <20260505171637.17e20b98@kernel.org>
Message-ID: <afxi1OLZI1EksKmP@google.com>
Subject: Re: [PATCH v4 2/4] ynl_gen: generate Rust files from yaml files
From: Alice Ryhl <aliceryhl@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: DAFCF4E671F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285223-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,lunn.ch,gmail.com,davemloft.net,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 05:16:37PM -0700, Jakub Kicinski wrote:
> On Tue, 5 May 2026 09:10:17 +0000 Alice Ryhl wrote:
> > On Mon, May 04, 2026 at 04:58:58PM -0700, Jakub Kicinski wrote:
> > > On Mon, 04 May 2026 09:04:55 +0000 Alice Ryhl wrote:  
> > > >  tools/net/ynl/pyynl/ynl_gen_c.py | 139 ++++++++++++++++++++++++++++++++++++++-  
> > > 
> > > No. Rust. In. This. File.
> > > 
> > > Just commit the artifacts. I truly hope that this is the only Netlink
> > > family we will have in Rust.  
> > 
> > There's no reason to react like this. I have not ignored your concern.
> > Last time we discussed this, the discussion ended on splitting the file
> > into ynl_gen_c.py and ynl_gen_rust.py, which you did not reply to, and I
> > actually spent some time working on that. However, I felt the change was
> > non-trivial and I wanted to discuss whether that was the correct way
> > forward before spending more time on it. Therefore, I kept this patch
> > as-is for now and noted why it was non-trivial (sharing of CodeWriter)
> > in the commit message, until we could discuss further.
> > 
> > I think you are probably right that just comitting the artifacts is the
> > simplest way forward for now. Especially since Donald is apparently
> > working on splitting up the file for strace [1]. On the off-chance that
> > a second Netlink family is ever added, hopefully Donald's work has
> > already completed and we can easily add this support in a new file when
> > the time comes.
> > 
> > I guess another way forward is to commit a copy of the python script
> > with the Rust support to drivers/android/binder/ and I can run it
> > manually if the Binder yaml file is ever updated.
> 
> Could you _please_ do what I'm asking you to do instead inventing your
> own solutions. Just commit the generated files and leave the script out.
> We lived without Netlink code gen for 30 years.

I will drop the patch in the next version.

Alice

