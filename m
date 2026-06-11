Return-Path: <netdev+bounces-298015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id voftAht3KmqKpwMAu9opvQ
	(envelope-from <netdev+bounces-298015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE80067006E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:51:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ISCmgUN1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298015-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298015-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C9EC300F762
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346F23BB112;
	Thu, 11 Jun 2026 08:51:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13B2DCBFA
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:51:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167888; cv=pass; b=RPbQgPgm6nq6jbTAIPqjnrrgvG5/vLiNOiAqyJPI/BpQy/xSbmTqmDMW5GoVdhej1NfyEG5A3M1LO92+VmH+RyUZUlqaiVNhxAzhBM/q2/orjnKY8Gj1kQ5kDmIOYNBynJmlp3vD9dN48X/a7ojgMQ77XzPEi+F2ZqVbrf2uUV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167888; c=relaxed/simple;
	bh=Gu6SXLCI0/eC/AnJZSyIbfVO8bAqJ5On3y51xTlO4vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK5txF6KukvJRqB1UK0rpr2k5nly3VOgFBfYB4iXOekkKEc6FNRd4M1xtTTwnRsQEgbV0qhXvfHvyjHw21AVwZZnvbp997O5wHuYOvakThKqC/VILkxC4U+kGulQqGiYAklzz5qFdbh9MeATlzz7F+hUw4iWz7b6Ve60zr/qUNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISCmgUN1; arc=pass smtp.client-ip=74.125.82.172
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304f8e80b7eso592176eec.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781167886; cv=none;
        d=google.com; s=arc-20240605;
        b=DjcUoHyqBpXWI7VEh8T402AghYr1R+4oM3LRpaQpB8Dr2JHMh9hWW6fwqcnciPhapg
         B2nhyyZlns4+R1rR4y+FvSENO4saVJmNV2xuXMR/OmT4U3PaL2Y1eSZVYGFjZ5YHrazU
         sYZEFVWi/0YnjukONpUv+4Yds8eg5R8fa4mDC/3ivQyN8g1e1GaF4fuIL4rkSAJPEXtj
         zxVaDZqb1ZvGwkzFWnI/pcl6EO9hNfyIW6TfSIy6nn+Y67GGxLZ88pmVV3cFhy5/c46L
         94aLOffCSd3dYmpwlZzubIB3g0WyAkj1D6UvnWtR+ZBcnO3cgI3jB1COtCKeMgLNyM9O
         ax4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gu6SXLCI0/eC/AnJZSyIbfVO8bAqJ5On3y51xTlO4vw=;
        fh=LVnluWFonX6/0ueVZxsWhvJZ9l4CxRJi8ASN8lojZ9o=;
        b=Hpo3CWs7xyL6PC5khhGqLx9PiSPux0sgeqATk8+LI6F1iqebwgif5MR9CVRp8V+Nih
         o1lGOhC3GVw06lU7vOFJ/P/PM0R3mVK+mz4HSRe8genA6lHEZXFN7r4TE0QY4WYiVuKx
         hUOhuqCgZvgqxDSLLmc7l9zt9YI5KVcfAcW3wXktz6LV77DQ+NgWmrWZ5hIheTLTwhXP
         hzx/F67a+p/DpyU5Ruvxm44GTPWBWSuLFyiEP4nBA2VFmghPwkMxUVNUEYRsznxkDbnt
         ZW5LmjTdSnSu4qT+2b/1h8jVl8OJRwOHq25aFQsW/aTZzO8gHXE4oKvNhb/Ufmv+IUo6
         +wmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781167886; x=1781772686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu6SXLCI0/eC/AnJZSyIbfVO8bAqJ5On3y51xTlO4vw=;
        b=ISCmgUN127MnDQmZvuNvPua5E2Z3wejAYTONuNCTVxFJsgyvuoJa6RUjQdsaDOAcju
         sh2ui9Me9SP3L/dG4+Bvjoikthl3LxcUTCn3TNbexIIcMHXX1iSfQr8K4aTSpjVXLo44
         Ji7/nuwDdqtang3hiKJySGY1m3pmdlzPhCLJZFsRE0hQUGKD+O4i1xlEWF/l0Htra1QH
         Qj6DvqL9DewNlJI533GII9Ag2qrdtIE9nvyGz6bq1jWjaDWSwZR1lrBZIr/MfB+W/0QD
         hLvF0S1KstRi0ZgrIDgzP9JQaGl+72ez7/KNOLWQL9JKLBTu8zAvAsWmg28PaFXswxtU
         ciIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167886; x=1781772686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gu6SXLCI0/eC/AnJZSyIbfVO8bAqJ5On3y51xTlO4vw=;
        b=FSOiFokKpsLY5wOuRBVKmV9vHWv64ZG+UtGNeOdf+766eSTxPXvWr0SSaCo4vOlKNw
         jopMTpj7Bd3gmrHj8dSmJ09+84O+Emae6ULOcWo6/vgDe17bKJPwYUl3UAi97+krkg9C
         J4fflDdgx4UZnF8igWHd4VvbOW6Ddo8+599XWe+RLRe0ww7u06vduoEa2PKnWa60wwxm
         1RPpYSFjUrWAtWZnMDVxxqdasoSNqd8WYWZEwRGwuA/NBnUCHSRitO0aQ9hPJLcoqbUq
         yYFO6NTEfgxjZ61WUMqbofbRrTk8rEfA8lmcDuG5pPspsGHuzsaZP62hxYCoTQcpxsiE
         27LA==
X-Forwarded-Encrypted: i=1; AFNElJ/VGqudnq9OYdAkgGgLCfEi8InhAZvGnLaASf9bdDGL6BmEpWKMMeljkCtYAaGyqnv8MVpgcc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYothK7HtDZ+ydPHL2YD2Al7pO/9MrnWL7LY64+TNUJCtBz9zu
	SYH7aQ97+NEBzfk2nGSMNiMiKlxNnYif+5MNg1WW2G0OEGYiYs4tQ9Mz9vMsLMKjZsp4Cu0K6/T
	n56lztXM9Gj5BBFNeMOkosWALxf4y1zk=
X-Gm-Gg: Acq92OG/SNYYWyXeqxoDVQWvazJxhQtwG46XCDRQn/QHc57VyrMlSeQoiYybFxbCltM
	eHJ43f3wFQPhY4/FIaH9f6/0rSG+3lB2Vhs0lQ9kjzppkyyXJ5y1j4c1XZbd+pUfeRkWbWtoVjQ
	ugGkzvuIX2enZGgeVFVlKx3BEqHh971h8ANpS/84oyaUdZMQCiNqL8ussnKa+jprrClb9D6Q4h+
	wcYo5m0T2V330cfGanEljBKCCZFpx9SGHFR99n6c7SFkWciJt1csAiUaWkpUalBFb0o5hC+fAGy
	wuoYAn3uegzTbJSx5fNVsntz8g+Nl7E6q866NXSSqbM0frY8gmxNSoonABd/lT/r/ZqlaCE8SZ5
	aCqJSA/PIryoHgBNzA3EY+tCM4VLD5GXAEQ==
X-Received: by 2002:a05:7300:8184:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-3080410050emr652555eec.0.1781167885763; Thu, 11 Jun 2026
 01:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net> <20260610072947.338278-1-ojeda@kernel.org>
 <DJ5A6AM2FDGQ.19T1Y9N1T6JST@garyguo.net>
In-Reply-To: <DJ5A6AM2FDGQ.19T1Y9N1T6JST@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Jun 2026 10:51:12 +0200
X-Gm-Features: AVVi8CeZqdEWXPdGh8thUTK4-wo6B8DARvooPGXEOY6tr17NX-f1ZHtJHf1zMrU
Message-ID: <CANiq72khOCLC5kG5vWhDeXpHv6n7Yo9Nv=PewNS0D73AxUDB4Q@mail.gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related macros
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com, 
	airlied@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
	boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com, 
	dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
	fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	lossin@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	netdev@vger.kernel.org, nova-gpu@lists.linux.dev, peterz@infradead.org, 
	rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org, 
	tmgross@umich.edu, will@kernel.org, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:ojeda@kernel.org,m:a.hindborg@kernel.org,m:acourbot@nvidia.com,m:airlied@gmail.com,m:aliceryhl@google.com,m:bjorn3_gh@protonmail.com,m:boqun@kernel.org,m:dakr@kernel.org,m:daniel.almeida@collabora.com,m:dri-devel@lists.freedesktop.org,m:driver-core@lists.linux.dev,m:fujita.tomonori@gmail.com,m:linux-kernel@vger.kernel.org,m:longman@redhat.com,m:lossin@kernel.org,m:mark.rutland@arm.com,m:mingo@redhat.com,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:peterz@infradead.org,m:rust-for-linux@vger.kernel.org,m:simona@ffwll.ch,m:tamird@kernel.org,m:tmgross@umich.edu,m:will@kernel.org,m:yury.norov@gmail.com,m:fujitatomonori@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298015-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com,google.com,protonmail.com,collabora.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,redhat.com,arm.com,infradead.org,ffwll.ch,umich.edu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE80067006E

On Wed, Jun 10, 2026 at 2:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I think if the re-export is of form "use crate::build_assert::*" then it =
will
> still be the same semantics but would be appearing now?

If you mean a glob import (within or outside the existing `use` --
same behavior), then that makes the glob import appear in the list at
least, which is an improvement because at least people have a link to
the module (i.e. but not the individual ones).

Or do you mean something else?

Good first issue?

Cheers,
Miguel

