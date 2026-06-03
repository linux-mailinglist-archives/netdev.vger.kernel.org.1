Return-Path: <netdev+bounces-294926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FZCoDSifIGqD5wAAu9opvQ
	(envelope-from <netdev+bounces-294926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:39:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AED1363B6B8
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:39:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=X1yvySnm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294926-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294926-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE11302BB89
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 21:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACD4968FD;
	Wed,  3 Jun 2026 21:37:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83188494A0E
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 21:37:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522637; cv=none; b=RQI1fswdTS71KsJiHmR+xyATGKCAHKwFk+ZgB5/w847sOeTGn2wxcVpFamp4255DPmZ7D4iyhMLD60BW0RVwhL4PbiKubArnS6QRZWYefqwd0vyISwprfBEiphsWY3AthbuyXiRffS4H2KUV5lmZcGfW/o9NpLyqS0IRBqd9maA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522637; c=relaxed/simple;
	bh=G8aqlWT5bLZQV/uLuybjUVkjg96V4exbndaKeusMIxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpN1sfJEgiVuKvg/Oq/5atnnr7xi/tYRAhMkh/cNmyXs1/iQ22wAAIMlIHxSmGtXuj91R2rB/e21FO2+kiuScqyziTdyUqolsGGlAXPp/MAw4IS3N7fkANiCrbdOQ1XnhLdrKXx4fLHgs36t1At9A6b33lsEsuZH13a/ZMkbVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X1yvySnm; arc=none smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so22716a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780522636; x=1781127436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlzwef06CJIrE3LIQnd2Z4dg96b07Ks4mMmqsV33wA0=;
        b=X1yvySnmSrP8qBWKuaTJVC5aT2XNZ+ZeLmuecnonr9glwZRbdUzW5iQ5m0Sk1efVyT
         KR99hT00iXTqzImgV9KCl0vtpTL8qsSf4NIGlkhoXOtO7PWsFDP2WUvEuVu7OmTLKvPZ
         TQbpaU7YXSj8OOOhBjvu7xnRGnk44PUI+yFoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780522636; x=1781127436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlzwef06CJIrE3LIQnd2Z4dg96b07Ks4mMmqsV33wA0=;
        b=bZBJtkS16FXTT1ncFZZCUKYtZgB4g9GC9F22OM21cpJMvcYrX/TG1JYMYW+SxycG2Q
         h5rfUFkWn0aWez8cfFfbKboATXHTf6XQX78kKuTCXjl2YuWTp0aYd3LsAPRuwmz/65is
         qVU2eCe9cltn+9GIGRHMP8vckoEzuvsX9HiNw0xPq8OFjxE4/5a7SS2BQFlY0EykmCnk
         v1aAq4YK60eHCfyxqfJ9yzUifE5JpQDT6S32nu162GhWFwNxuDADp5fmx8qah/itAl1G
         Pi9nGDk05/PXn8wpuf4ay2Qm/JHJ1VimPY/tZzyEys6Nyi4GDgsMyJNxqSvbKcftwFAY
         q01g==
X-Forwarded-Encrypted: i=1; AFNElJ8082Wsa2Fi/4yaJVpJGGyz0+KzaqX8QDkEGfmlht9vlKis+YJS96PARGyAiHfAsRzfPQKjKL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHsfpuvkxqox25MADKPZH5FKgrAcIM0gYJvrmcev7PrIdLPeqo
	h5yNdcT8hZTYBjKfDlBKHzaOsmj/GW75jstweni0gNsyVlvFlh6ae69HfjLTmiclfuFNF5IEagR
	KwxBcodo1FA==
X-Gm-Gg: Acq92OEPyd3fUDc787piu7ubJicoiZc+bNk7AZixJryHQAokMFebw8n2AEOo7XVmdNL
	caPMnzhGTS1A8UvxuMvvy24mLzicieVZW/DHY6AREbx82ReI0bVzGCqAa72Du3URZfO288ag6GC
	EA5b1Ab3N2FYZEgRc7TmvfEjTs2CisytY5smOnVntvUrrsyXfhFbOP5Cxz+52R2Vm4qCxG4hSpn
	29JrM3atGQitQcdcP+Op1Jbi+ZiIcw5ZfX2IJddlhzMZ0wVGfiiljcvk+jqxy2FcpfpehyEKuX9
	+LB8UfdhPnHbRC2ca2noERo82pk2GXhSrLZ9QCWVUaZBA3o4EUa1ERa5A08ufV09AITBRuSrI1a
	ssr2hKNuO09ThhEn4oPM/8zFeP0Ov0cILl0QK1dFz+2YQD09/tK3uxJGAyYfpj0NDNTEwPXZ8kG
	Vd0zaDTztPf3zJPWsxoiX01mIpUIM6FlGm89v5BTfB0uLgKunDHwlqYQGYcjx1V1baj0HOVDIGj
	z2Bpl+Nj+9IkV8=
X-Received: by 2002:a05:6a21:330e:b0:3b4:931c:3c7c with SMTP id adf61e73a8af0-3b4979857f8mr6064470637.44.1780522635769;
        Wed, 03 Jun 2026 14:37:15 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df034a2csm3245074a12.3.2026.06.03.14.37.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:37:13 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c858b392697so11038a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 14:37:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ZL1i9R9t7RTS7e4H/u6hYs/WBJOaaqayjOAsBhrI9sNChqis7OhZiKq5+P314/dBjujQBVG4=@vger.kernel.org
X-Received: by 2002:a05:6a20:e196:b0:398:90e5:a9b9 with SMTP id
 adf61e73a8af0-3b4978a0b2amr4845639637.27.1780522633187; Wed, 03 Jun 2026
 14:37:13 -0700 (PDT)
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
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com> <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
In-Reply-To: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 14:36:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
X-Gm-Features: AVHnY4JdHVy7zfm3YSY570fWNlTEBH8JxW4P9TvGYREa7sUrzYx92vQNA-k2Zxc
Message-ID: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294926-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,amacapital.net:email,linux-foundation.org:from_mime,linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AED1363B6B8

On Wed, 3 Jun 2026 at 14:31, Andy Lutomirski <luto@amacapital.net> wrote:
>
> I think I buried the lede too much and you're arguing against what I
> was trying not to say.
>
> Maybe we should keep an API that does an optimized copy, from one fd
> to another, that can send from a file to the network with at most ONE
> cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> for one.

Oh, absolutely - that's what my completely untested test patch  basically did.

The user space interface was still there.

And the networking side still continued to use the ->splice_write()
thing for writing to the socket.

It was just the filesystem side that basically now instead of exposing
the page cache directly (with filemap_splice_read) now only exposed a
*copy* of the page cache (with copy_splice_read).

                  Linus

