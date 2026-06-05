Return-Path: <netdev+bounces-295887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V/ZLIbr0ImrmfgEAu9opvQ
	(envelope-from <netdev+bounces-295887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:09:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E56499E5
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:09:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=HM3tvW6B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295887-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295887-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5E08305760C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF96E3CF66F;
	Fri,  5 Jun 2026 15:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C435A397
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:58:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675140; cv=none; b=PPuI/qWQwfTWQPO29fJkxEVALpC52BIbPJiw++jAQEpBClMzLnhK8WiKLdd8yhXJJVXQL/vYubVItA1KgZwWyG9mrbcPRLXaeGFisvPuezFTinCKzA/lpbU8QDHqPmoIAsAvjQeh1betrxKlu/IiwkO9lalSY4mLSg2qj9kuYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675140; c=relaxed/simple;
	bh=cHDeiU+5q6zHW354GymA6FXFmgmlOGfgwP7cdr1ffak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8FUkGeFg6WNk7Dg5pjoqoUdY1FdJhOKjOIokI+5/sfGTMHIwvAfKbFnTNkctu4pCS5vrWrmAiSUMS8Jp0sGT8ACc583Zht6Z39nHFaQMMWZAXXWnKDnErzgkUcD3wp1M6l4JFRouDYrDzAGvgI0mjKVJRz2JBOSWGeLEk/L7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HM3tvW6B; arc=none smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bf1141c26ecso287012666b.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780675138; x=1781279938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUZ5QahFiUWTYdBZUTA5YwtlfS/dH2OxVTaDuMHjYEI=;
        b=HM3tvW6B/2VpTg0s8h95hg2vEKlZK5JsisKPXVnZiVv7+VXsyD2Dy36cAkhsJU7XRN
         LhpnGRJHIuVnLue6e57+Q4FygpbDfEc7bUWuJKNxSU9DtZ2+QK/VRCRikZGJ+TRAko3L
         y9+yvj0vzE4hpOwf7y4IVFNonA4Qofx5G1wEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675138; x=1781279938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUZ5QahFiUWTYdBZUTA5YwtlfS/dH2OxVTaDuMHjYEI=;
        b=B/n8pCLETrDhzMSbaOwN2wq5ozioCpfiRa0wdagyLcRS6XfMStJavbsNV/vjTqYh4K
         j9mH4CabUyKCKcE+5nw6HyDik3et+N7EfjOVZOXN+RIAIyfCXQmUVlSQwCHal5DJDxs+
         cmbqL5+BnE9kjB+YGy6sioF34n+XVIkwZ4biCZNAtoR7LYjcJpqMwZkOWC1ISxmgJLJW
         VN+puvEtO7TEVTpwJZ1lH4VgNNXvtWCDp5hl/W9pCKFWfnEZNDMG0S03YaYKu2hraeLe
         yqoK1ALwavtQomEl2P/uNtscDroqvAfLVbxDpXMZcOxa1iNlCDAirK52Cqa2rUGoDS8p
         Aplg==
X-Forwarded-Encrypted: i=1; AFNElJ963m7d+uh39LhoMQNWL9p902Eycfv++/acN7XMrJNgG7ZVjNBe7QJ0u4AciZHippve8Nqv5/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0HNKrZe9FolFf4sxoZRzhfHFyGkc+ehM/B8JRN0rxSqxg9jS
	b21uTYCFh04vZbjuDVTDumEvyQlYchTeZ+FQ5b+Cd5EX3zlC+o7t5T6fx4LHqCdNeDjy0T8nU/4
	wfCR+w8Zh7w==
X-Gm-Gg: Acq92OEbcK2SL9NHvREAHHH0pyhIzbwaP7P/beigCHiYomNW5e2AQ3asr2nIueljrQz
	O06RzjXMCN3b7hsSgDrqHGzdKn0W6JKxdLEUnpu98XsxFxpswgCD+QSBYvzmZtPv8Z0DHMa6C3m
	Vdhgmig8R1Lz6a3mAKC8hNKBdIKnDm9NR+FLlu/gN2nTBFI0YJoZVcMlJyUEDayt4m+/2imZiRm
	j0KUiXSacOWjexOxVksplz2tEl43PKGtg6n0z2PXOqV7f/wTli6XqQLLQeJF2gHcsgxyBjgwcUp
	/Fqpk+Hi/LgchTq8JA7uu8Xh+W1zlWbhKHon1ICNhezGwGkQhdA9+P0Km5+qUuIecUajvgSGMsg
	D0KFvCOXsRspAlro1zh7hZpMYXlIevk/v9C8/u6Vj2Gh4x2Qfz0hRCiGe5dkP3JmE3w8XZTPjXA
	CZDiMYcx2A7pjgYdtyuvvgXC/8xCTsyQffSZRFXKzj91Z6+GwPaA14mvK/rqB7qgSQDgAM6imh2
	Vb8Zx8wkkc=
X-Received: by 2002:a17:907:7b8c:b0:beb:c3a7:9cd with SMTP id a640c23a62f3a-bf36fba1c96mr226606766b.8.1780675137572;
        Fri, 05 Jun 2026 08:58:57 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0553040a7sm479405566b.50.2026.06.05.08.58.55
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:58:56 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so3879882a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:58:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8RG945Vc1PLUVnfchhCW9He0SBKBvto4Cjz7jYpznGGgZ1maeGFHYfFannP9DDbvfAYBSUHHw=@vger.kernel.org
X-Received: by 2002:a17:907:a03:b0:be2:dd37:facd with SMTP id
 a640c23a62f3a-bf370e6211cmr221318066b.20.1780675135190; Fri, 05 Jun 2026
 08:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
 <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
 <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
 <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com> <f1c7fbbf-5be1-48b0-8927-2d9b75a35816@samba.org>
In-Reply-To: <f1c7fbbf-5be1-48b0-8927-2d9b75a35816@samba.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 08:58:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL0oLvmh3FO9SapDhgrXMT_d6qkP2V3OBjysOWXod2Og@mail.gmail.com>
X-Gm-Features: AVVi8Cf0FjZlqJePEzD8bhzCDc_NK8sni3u4Z9RMJefCrCHFLhBrwtWwfg4F_Wo
Message-ID: <CAHk-=whL0oLvmh3FO9SapDhgrXMT_d6qkP2V3OBjysOWXod2Og@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Stefan Metzmacher <metze@samba.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295887-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:metze@samba.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[amacapital.net,gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,samba.org:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC2E56499E5

On Fri, 5 Jun 2026 at 08:15, Stefan Metzmacher <metze@samba.org> wrote:
>
> It means the most common workload, e.g. a file only opened for
> file serving (or simple opens in general) would still be able to
> be optimized.

Nope. If your web server opens files with write access, I'd be
extremely surprised.

And if you don't have write access, and you're sending out data from
files you opened just for reading - the onle sane case - you hit all
the existing problems with "I can certainly look up pages, but I damn
well shouldn't pass those pages to the networking code without copying
them".

               Linus

