Return-Path: <netdev+bounces-265210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGVvDMGrrGldsgEAu9opvQ
	(envelope-from <netdev+bounces-265210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 23:50:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EAC22DED2
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 23:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD215301ECCE
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC4A29C351;
	Sat,  7 Mar 2026 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3lp3Sag"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924E261B9E
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772923835; cv=none; b=CY6KnQsrcGpA1untUJwDz6DbgG7KB6THdgD7pnjJXAHAR7Yv81qocNbxIp7ZZRhGsuY7o5EsyVeAbuCTIu495bp4YYGCGFb7yo7qdk9V6DHivJ0+OgZhquGtwKkk5ZFdIpeb/BE3rdC1R17rBwf6SeDvIsNbWRXCtSejfI+KUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772923835; c=relaxed/simple;
	bh=DR7iCf5iCuY1oxdfXKGg1i5bjdnpv/6wc+i8qgFECKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pmtP2cTXyiVUQHRmwT3mTZV9sGdpBNsnNdpUSBHJYRkdCuN0Kc+xNuXKs6AlE6PWis8o+xYU1WMogaFrLB4s1r+XVfL5rGiIDlFN+zmrGJP5TsLJs1GxBL1l539r5GI7xZQhfSSl2BOq2H/2ARn3dfiLft0a1Q0A2Olu8MPhevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3lp3Sag; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837b9913c9so85782905e9.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 14:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772923832; x=1773528632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2Ga3PqBJMZ/HRtk4qSHoFPMCGwKdMPoOZIGSkIVk3w=;
        b=c3lp3Sagcksko3ht3N+8zjx9JMpXLtOfz33uofA/RgkOsUlD0uV0RUzA2Bu19qr6E+
         NcYxjWE7OaW6l622558IspFLeo+9oxtzXPu0AYdIm3XThqKbJhcz/VgbvNH4Kg3oW+Sd
         Z8JeXn135QLSUWSdqAhURJjeGxn69kjht2aqiu9Sbw2hyJPkimTfdQtRY9+MdpWYcEAk
         K5wz9KnnqPFyBgIVB95xC5yEwki6n2RLMJyHUcw2yuJSr/7O4oA4KrJNStx5bhHnunCJ
         D6MVy3EdH3wuKA/FQ3gEpDcfz7j/Lgf0/nyQI6xm1COLUX0onVGwgVCXkxbgTqQIC6lR
         /4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772923832; x=1773528632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2Ga3PqBJMZ/HRtk4qSHoFPMCGwKdMPoOZIGSkIVk3w=;
        b=QK0OEjDTM7totXGFDODsb/XetcjVgHNu+sR04N8v1EP64qtdauVQDGtWcUhw7ECjJE
         3RS9qRA90xVRRPMmumMW3fCb9hPikemMXngUZ7VJfSNtYOrGl2m+ix3K9GyhXlTj8Oa+
         uf6c0FXYF7pX2EUMmid6IIjgbNDRUlGH1roNBDNSpkB/D/tJuqmf0LL118NMgNoVDZ0Z
         89C/uAif2cPUrl8IgL3R9ZfE3hJ+N1O/UqJ7O46cmrmDXdi4mElKne7LbtOb+uJEFTjC
         4Eg/B0MNOs5mWUYkJdYmxEhak3hv6L24xyeyy3s9lO68kTfdf3ELrkkuosUE0yPsRb6r
         fbWg==
X-Forwarded-Encrypted: i=1; AJvYcCWjgp5BaG5J2TZnvkthLoAbXt8Od0ps75pypkIveWCbXVXjCMeYysdaTACGIBlala/MzWZKflU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQIv7Bgwi62Y8DkZPRAZqSARvbKRFoz7O95xaT5wsik8yVQlI
	4YtLVOcIwV95rFUnSRFULcAG/IDJMSgy9FUE6fTWaIsb1VEm89esE3zCs0b0N3ZNeU8HS/fZpxZ
	2Klj7OtZt1XPzIVuRwA==
X-Received: from wmdv10.prod.google.com ([2002:a05:600c:12ca:b0:485:2d79:6c74])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37c9:b0:483:612d:7a9a with SMTP id 5b1f17b1804b1-485268bf171mr105914175e9.0.1772923832367;
 Sat, 07 Mar 2026 14:50:32 -0800 (PST)
Date: Sat, 7 Mar 2026 22:50:31 +0000
In-Reply-To: <20260307135941.51353a4f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260307104131.4c1d0de5@kernel.org> <aayWSuOM59uojtuG@google.com> <20260307135941.51353a4f@kernel.org>
Message-ID: <aayrtyPKOqVGpich@google.com>
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
X-Rspamd-Queue-Id: 85EAC22DED2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265210-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 01:59:41PM -0800, Jakub Kicinski wrote:
> On Sat, 7 Mar 2026 21:19:06 +0000 Alice Ryhl wrote:
> > On Sat, Mar 07, 2026 at 10:41:31AM -0800, Jakub Kicinski wrote:
> > > On Fri, 06 Mar 2026 15:12:12 +0000 Alice Ryhl wrote:  
> > > > The C Binder driver exposes messages over netlink when transactions
> > > > fail, so that a userpace daemon can respond to processes with many
> > > > failing transactions.  
> > > 
> > > Ugh, now I regret letting binder use Netlink. Should have seen this
> > > coming :/  
> > 
> > To be honest, I'm not entirely happy with what Binder is using netlink
> > for either, but it is what it is.
> 
> If we're both not happy let's take this opportunity to find a better
> solution?

My understanding is that userspace is already using or looking into
using the netlink uapi that Binder exposes here. I don't know to what
extent; it's not used *that* much yet, but it may still be tricky to
change the uapi at this point.

Alice

