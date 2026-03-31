Return-Path: <netdev+bounces-273401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD6wA8kSy2nsDgYAu9opvQ
	(envelope-from <netdev+bounces-273401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:18:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8958F3629AB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F08530358A0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8BC15C14F;
	Tue, 31 Mar 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UgeUQDax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC3175A74
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916292; cv=none; b=i/DxCEQkJAbB8zPEmHNNR3XTK5D1+lEd/iSJMxrv7fL7SDEEc9XI5pXTHaW0upCwLEUemXX1zkwh+flAGaERu0FPQNOzDyOBNTsILRRwT/wHE13qTq4PHcLGY1jatnzAKzElRKlkZnBRW14OVGjB7kRDhlDAIRYgnThqkqxZqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916292; c=relaxed/simple;
	bh=6wUl8Sz3m/KO5jdOLnEAnGGXTbE9en47y8rgN97XQGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uExBnFExeCi6rP4z5Mvstv8idseBhAW/nMpOBDO4wtWKcRkRfV0K1dAGWwwZkzny/rLUvrDMo0gLQRIgR2+nrYoEQu6RSdxvYgZuEaqq8SeefZ92lU//DvcIwPmvzR+YLiOwrG7XOkNtP8Dsu/lfq2sb5yJIaH7a746fbKkzJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UgeUQDax; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so2388746a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774916289; x=1775521089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tir8tYzZsdvdQe2Y3Sf5wYOGCREjM5L09WG7qVnCWNg=;
        b=UgeUQDaxYtErsiNiNmFJIqvb6hfvShvmsSvNndt41FREco1pKLwHVU3/2Q6puslkJW
         g9MZKgUSuXGTUVJLyDLkZ0A6FdW02V4V3GNvCs1HrAJ3e+le32ISmYwvV+XcfX5e5PMa
         K/sLTlI3xuTYL2KLhtY5IqvcllQCc6hVDq9mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774916289; x=1775521089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tir8tYzZsdvdQe2Y3Sf5wYOGCREjM5L09WG7qVnCWNg=;
        b=VgMCexZDNywXCunzD1qKceuas5cSQXXMA/dwlBBT63dab0j9RcId13o4zanF9aSJef
         Lomb3zCUMWQIE/yW7X51y6JIF9AF+CjWOqnkawQ7GkuxRNx3HUGn3z1eTVW5wIPjJt2q
         3NpExleTZM0VrknKSObOmUttX9hPmkYpPUlyz3tdyRuifbnfKQwcUUs4ASpbWzfxbvYW
         smC2ITBAnSppR3BcC9eraLi//dM2vjTZ+MSLHosYPTxUNdpg+A9VtMjo88PY0FeRCnCA
         211+dVMJ2s9eh7ZqkcCXBZcpPXuX+dKZn5nmckwdsnDXDaXv83PXuIuNRL4sjadQUu5Y
         DQbw==
X-Forwarded-Encrypted: i=1; AJvYcCVew0IfABkuotqHoQHPJ13J1VvnWBOXDXjNmmGb4xA6D81K8SYL7PwMM6xW65uhrbzAQ2no82w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9rJvBewVhDUQkqmA3+OvJ2/RtxZ+c7zm82b3oeYNeQxzWU4C
	3ZqevX+ujb/09Z3fz/4NgiolbiPCsro+yB5yIcBxhhMW2+tgU3pQXtf2Y91VQZHnWm1BPEMLPvV
	9jPv8o5M=
X-Gm-Gg: ATEYQzyd+vNAHSzPeCMvPbr818f8EG1+7SoKQC0y0q4tgmBn4Em+zPF3GN+IeYpiSBB
	pUvNGQMxTZZmpSfikR9yBUzmMShgNrkHJU+guqlu3PQ6kNE7+TpXzegp1c4VASysKgr7UnEP9Py
	YvTy2jxL7fGHy6bmFRNU2ebP5/HuEAf5KXpmWg2N3ucI7NedOi+h4QBTacYF3zvnC7DA9fUATC3
	hkH4gp3kk2i2DXVvhsKOMUW5kl3BmA/dIFJX7mwRKM2Cz3B1ms21SBaQlW7bH7A0JKOR1t8GTWX
	4R0LpoP3VwrDrHZ25BaIJiA16QMC/NT1HkXKi/UgH4LKal6V2jbmQqHaXX4zB3eoA3TMSr0oCW7
	n6YiMKTGJBO1MxLQgT/JXK3Pau2ygpJmJzS25DAfE002YmX30bo+tKeKYrD7dtp9h44rMy4YYmG
	Bq5ztw8MSEGyx0XBFs0rlHkJgFgwjZyY5etJ/LLBF0rojf4CA6nrTBU3JumeFR01BZvIzBzbXc
X-Received: by 2002:a17:907:a0e:b0:b98:4799:e6de with SMTP id a640c23a62f3a-b9b50980cafmr942396266b.48.1774916289198;
        Mon, 30 Mar 2026 17:18:09 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae50e8asm335994466b.14.2026.03.30.17.18.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 17:18:08 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so2388724a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:18:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7dRqc/KEkxuyFSsFhUGuTmD8Q7PhzOSup+IhkcayiK+XXqZGlg2+l1tE3UtrskIFZeeoEox0=@vger.kernel.org
X-Received: by 2002:a05:6402:4346:b0:66c:4366:3217 with SMTP id
 4fb4d7f45d1cf-66c4366346emr280074a12.7.1774916288569; Mon, 30 Mar 2026
 17:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326131838.634095-1-dhowells@redhat.com> <20260326131838.634095-5-dhowells@redhat.com>
 <20260329121208.6092419d@kernel.org> <CAHk-=wiJ6gEELLviexdmSHnyjVoG7MFo8Qwhd1zxs_tCnL-=gQ@mail.gmail.com>
 <1179840.1774867765@warthog.procyon.org.uk> <CAHk-=wjDKfhS5TvEfrsOgBgAvFMPfAd3wT=Um2AQb4txHq5sAQ@mail.gmail.com>
 <1317861.1774914607@warthog.procyon.org.uk>
In-Reply-To: <1317861.1774914607@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Mar 2026 17:17:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wji+mTVj0vkSRJc2p38B5HaMp=oo+aUNA7CwuiguM+EUA@mail.gmail.com>
X-Gm-Features: AQROBzCw8GXLOeNuPbkp4sgcu_wDqPonncg2z7A4jKKak2u69PJv7yB-cJ3CIOI
Message-ID: <CAHk-=wji+mTVj0vkSRJc2p38B5HaMp=oo+aUNA7CwuiguM+EUA@mail.gmail.com>
Subject: Re: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add
 on_list() also
To: David Howells <dhowells@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Marc Dionne <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	John Johansen <john.johansen@canonical.com>, Minas Harutyunyan <hminas@synopsys.com>, 
	Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com, linux-usb@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 8958F3629AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 at 16:50, David Howells <dhowells@redhat.com> wrote:
>
> If I don't delete entries in rxrpc_destroy_all_calls(), then rxrpc_put_call()
> only needs list_empty() to guard against the call not having being queued yet.
> I could have a flag for that, but it would be superfluous.

So make *that* code use a creaful "delete with flag".

As far as I know, __list_del_clearprev() works fine for RCU walking
too, and that "prev is NULL" works as a "this is not on a list".

Admittedly I didn't think about it a lot.

So my point is more that this should not be some "generic list"
behavior, and I do *not* want people to think that they can just do
"is_on_list()" kind of crap in general.

This should be a "this user needs that particular behavior, and has
used this particular function to get it".

And yes, this pattern started out as a single performance-critical
networking user, and maybe we could rename and codify this pattern
better since we now have a couple of users (bpf and xdp) and another
apparently appearing. But I think that "rename and codify" should be a
separate thing (and done after ths particular issue is fixed).

              Linus

