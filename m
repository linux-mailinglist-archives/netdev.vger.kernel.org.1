Return-Path: <netdev+bounces-273300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNnqICrJymmL/wUAu9opvQ
	(envelope-from <netdev+bounces-273300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:04:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1E3601C8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78336302A190
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C89218EFD1;
	Mon, 30 Mar 2026 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHidwdej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B341E8320
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897382; cv=none; b=HfFxHvlmuK9S5GOeFVSRXKKUzVNtTp0B15ockEQjkvAbAZM+lsSKbQ/CU1ssAqPdb0BjkOAkkJIq2NhDJ1n1f+rAUJwc2hyg+sTdHMMNw+IFpPXsp4wO5umpEEGkw3mYOOJFRzAkft7QCyNxl1D6OnNwsXkRrf2+scFxLk31dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897382; c=relaxed/simple;
	bh=8evj0OpjHZ8r8nnKmE4JkW59JXSG8Um37Vl2FFdMhBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5gK8TCL8DI0/3AFNglB75EzjXB4s1fKPyazJnBwDfN+nM3zfhg0WziyN0ie1hsV492L5lY/PEARQHxaNS6MTB6O3Bo4FRMzWdxh7p6oghU9u411THcltAb44JWz8drrKQEuAc2JU99y3cgdYn5OGfWI2PpiWQznZJnNCqwDqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHidwdej; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4873ce69ba9so13833735e9.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774897380; x=1775502180; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kB3VJ5DsNIbZ3UksrkiocR0BgDr2YRaTFnnLRxLiWCY=;
        b=CHidwdejGVZzugVA4nRipAoBrfSUjdpRSjZ4/wiH1wTpOd5YDybiMj1l/wmbAIuXPW
         hh3gEmVAGXDTecRHcvrj7U28nVnYMLffQe1566dfKunK8nWpgZWXdaP9SWzwGNMeXq1e
         PEgiA7JgoCKQXq7Pz1ki7co+CAL8OVHL01FD7nV+UF8C+UV4tipeu7PkDXxXzCrmq0fB
         OstifrhQy5QZ72RZyVkC9aauTtJjtdv543jIC4+AUxh1KH7mSMODp4Smr0HZ5chZKokG
         SxOoncWoFTm/volDeUd8prNsxq8SgnKY/zeHMO/sG0rB/6Y4sro02JTGPPWr5vNmt2YH
         aABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774897380; x=1775502180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kB3VJ5DsNIbZ3UksrkiocR0BgDr2YRaTFnnLRxLiWCY=;
        b=p2JRdx2i+xaXPgG5FLV1e82znr7/vyys9h+CNK5moUKKNvnDDbvZIHTTLkqhUWq8Bd
         t25l0zFFT/HipqxsX9T62lCH0nvk+LKwkpIPqdNaZxX9QT5NJhACOHU8XD7UCxNrTm1h
         8zU8EpZJM+EB9Rh4hZ6N+BAYUuN0wZKyUhdQyLug5D02BIe19GPzgnyL9PpT32Iv9bYR
         m+aGPz4mQsPmVZhA6VpKl81gpgJorNUxKwKE7B7ZFokNVqKl5BZPrEpGDXntmEnE5mBV
         80ZBMW7iM8QoJGbnil3yPIY6grmiVDqdOQtRdaLeXW+XS/r/nlFwETAwvVKn1lsqrXBt
         y61g==
X-Forwarded-Encrypted: i=1; AJvYcCWWxHWwwe5EhrTepyctgmXbsYYMmu6G1d/qjE3zIMbvASfuScC2Ik3UuZ1utHcJN7EiQaGcMmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjj9VH4pXzipAuJKMO33NtYz7sotcb+g8k7Aq0SuUPogX4gsF
	+GoHiJUWujsPUpxrcXegpb6zho6GFSZJQEt8u0kF+Pog7+ba7lI5a9mh
X-Gm-Gg: ATEYQzylnQUYOJ/OJ/Qp1SaibG7ipZs/Jv1FBMGG55+Q6jH7Xx9JK13HprTBTqRAqmH
	bA7Ds2KACPLe0mV9X/XCmad4Gnh9+oA/KX792tm1o5fchQwr6Maoov30EuBtTREQGAruVGhgbMy
	TMR6Y89JbKXrUR0bwWUOFelZuNJpgZwx+oC3sGyAwB+T71LpCJQDVCnGt8o1CHp2Xwf2jHPwCQ0
	SCmZpB7eAlSZP2BiVx+x43rL0k9jN3q0aY6YfHRbpwh2ZDgzyc9x+TNDczl59spD5CG5qZL77tR
	On89iRmCu/f/C+zyNvvVnp5zNkL7qyKswneGVC+R8auANklDh+CQU+vuKPezoEsn2gqLniydh2R
	2Xi5Sa7fgZxEty+nHqjbZnPmvPF9wEmj3KrrZlfn2Krh8XTh4QAD+Zjh40Hqtj8KDWyIl9jQJxq
	hyrQRIqGCjL8fmb5YxMpEnsOLmAs1o4EUQENMSADz8goYEGRd/
X-Received: by 2002:a05:600c:1d1c:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48727efacb3mr220126565e9.20.1774897379590;
        Mon, 30 Mar 2026 12:02:59 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730688694sm187287435e9.11.2026.03.30.12.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:02:59 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:02:57 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v8 01/12] lsm: Add LSM hook security_unix_find
Message-ID: <20260330.a2fbe19c0689@gnoack.org>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
 <20260327164838.38231-2-gnoack3000@gmail.com>
 <CAHC9VhRktViRp_U3ZAvo2e7vbjUd6RZb-y8+YPXhtLpt7hsXYg@mail.gmail.com>
 <20260330.ie1eth0ex9Pa@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330.ie1eth0ex9Pa@digikod.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273300-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,canonical.com,namei.org,hallyn.com,maowtm.org,gmail.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:email,gnoack.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,maowtm.org:email,paul-moore.com:email]
X-Rspamd-Queue-Id: 1ED1E3601C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 06:02:05PM +0200, Mickaël Salaün wrote:
> On Fri, Mar 27, 2026 at 01:55:58PM -0400, Paul Moore wrote:
> > On Fri, Mar 27, 2026 at 12:49 PM Günther Noack <gnoack3000@gmail.com> wrote:
> > > Cc: Günther Noack <gnoack3000@gmail.com>
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Cc: Mickaël Salaün <mic@digikod.net>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  5 +++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            | 10 +++++++---
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 43 insertions(+), 3 deletions(-)
> > 
> > This patch doesn't look like it changed significantly in this
> > revision, is there a reason you dropped the tags from Georgia and I?
> 
> You'r right, the patch didn't change at all. I added Georgia's tag in my
> -next branch for the previous version, I guess Günther forgot to add it
> for this version, but I updated my branch with the same tag, so it's
> still there.  Thank you both BTW!

I only missed to add them by accident, thanks for adding it back,
Mickaël, and Paul for spotting it!


> I just included a one-line fix because of the m68k warning, we'll see if
> it works as expected, and we should be good to go.  It would be nice to
> have John's feedback though.

Agreed.  John, I would also appreciate if you could find the time to
have a look.

–Günther

