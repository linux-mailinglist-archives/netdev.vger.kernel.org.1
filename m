Return-Path: <netdev+bounces-284721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B9+K8nn+mlIUAMAu9opvQ
	(envelope-from <netdev+bounces-284721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FA4D6EEB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56BEF301A3D9
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F036B06F;
	Wed,  6 May 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUDt4Gdy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB336C598
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051000; cv=pass; b=vBl5ORifSKLbtnAMHD3NeLu6n1kWUQhNRkkNVL+hGfNP/lj8SwwxhgLzpVejzxG124XPUWU0Y+JzsPElmISz+nP5cMApVpRw2rllGcYHA35wbwu62oWQYMUoyChOR36NpiL4UxkLiwlWvFlkQktNGkRxTneoaQxB9PcmWzZ/3Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051000; c=relaxed/simple;
	bh=msWHq9oWGgdNM2kAFrrJd2OcOR7l/yhU403EI6PSLDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujUfKKFTvSBdVInHurjq2Zn3H9+75aBmZR3ahgJKvb7lC4TN7Q2vT4a+cL6OsixqbnxrcSL+E8UFN5W0iNB00UDI0QP+2PwelhA7VQydiIuUTD5D13OaODCerd5CAsBzZlcZz5GsZA0zpcsi9YD84dPjldM1epiDpHguH3ZPa5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUDt4Gdy; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-449e96a8a80so3609467f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 00:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778050997; cv=none;
        d=google.com; s=arc-20240605;
        b=QHCDhpBAUjz0q0vPDbMXLIVCDgTqdXJi7y7U9E2vqkILM+IJY6IOgIUZSXGJfmOPKs
         7fISJ3ev6eM/+LAUr3DOYF+bDUOo++TQIQW0T3s1FaKdCJIhH13EwvlVv1x8ZjHuhS9T
         5A1ONSAZRnI0iMXccCbobyCdpi7xp7s9DPfwZdoT9G/JF4UEKP37PXxc22jvFAvyunyR
         jmW5KC3EF+j4C05cop9dp34bAniWVhLj82BmtjSxfElSc4UhFaDD60Dmi+QqmAgPw5ML
         3+nqZRqROa6b08SgycTbZA+6hfnLN/CcIdeb2Qwk+8JbjCG2Xv929EmUkl60P4AslFfB
         ycmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=msWHq9oWGgdNM2kAFrrJd2OcOR7l/yhU403EI6PSLDo=;
        fh=7v3oj6RdPPeGLwgO4rr4evHUhXi4g7A8/aYVRbz/i3E=;
        b=IcPy3EXg6EmJ9uCmWHXbk1BYYlXdVTT6Y+ecQH/zGa9miqxJN5wsfUSRDPGKfWbqQD
         4/sWT9ecyDhey3przYD3kdAPRT5NmnRAj2vlswwYmoSIdwR0XNAyo51WX8Plcox3iEqD
         X6dTfXgw1XlAp1kh1c/9JBEaH6e4gzi/ifAylJXAQ7oU3i3Fd40xDAIUvjBf8kyQUs9d
         1Q4lOa+ijpwVnBaiCXBuS+JV2hMvzFzL38Ew1u0653K8DDOBEBewmDzRJW2uAIBwJdW2
         qMdOr+4pTN3UJkuhw0dArnz0j4vrYUD3W9aEY7ITZ2Uzzio4VUlabSWRhmHDLHGzdnvz
         LwvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050997; x=1778655797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msWHq9oWGgdNM2kAFrrJd2OcOR7l/yhU403EI6PSLDo=;
        b=GUDt4GdyLfOXR6KMg8cIsn9NhlmXb7oTG0V9cc7WmzGIfDgRmW8hAwjGYtBiJDDM2d
         krv4Kh+0Pt96y9UfJpNJL964eyLmTdpDn89L3+2YbWdH65NsCUdGXTvg0icCtEPYu53r
         uZrE3QW6GiH6lfvAowsNRJieHXcKbA0TvoG9UBifXNCzatFC/tICCtIy2+B0aiq3bst/
         i98fxfcLIbpYeRqvqw75sJf1wc6KUa6koS19RGyc4uyGpl8g/26PbJvxuFqUJD4NftOK
         D8GEOpGe0E6QEBt1eQKcUJsCA0whWi6MM12W7xWFxKDB5i93rOKrqaTFI6geyBIwPOaA
         /wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050997; x=1778655797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msWHq9oWGgdNM2kAFrrJd2OcOR7l/yhU403EI6PSLDo=;
        b=JnSTaT2R9Af/Z/XQ8kwCiR4Vgs9m0vGCpZAgEmH/hfec5KpIfuFsO7OvMYDTK6vd6Y
         HjRusXpDkjuUTUqiriM0RGLsXahhn2DV4IcxEMdRWUT8UH5Ylkg9Oqy9ub+C3JXmTNaD
         NPErFFiF/vGlEDCZg4qygU+n/GY3eR1ydKEvHDygzprgoP88W0e5UjKDV1TIOTbrhJXb
         Urt216+5NYWnNTDOblwQJbDbfos1QIQGbGUJ4ks2D29ca4+UcEY1HWq3U0euj63i1MDy
         4FIK1rh6dcirEQH3JSSTk7h+BJSru4sNZQPo4vvoj7I1M2+tnakQDh1bUpUkP3y9PUJG
         HSmw==
X-Forwarded-Encrypted: i=1; AFNElJ85jf0ESHB12AhSycklN3T6fVZqCNV+TPXgzmDAOBesNvxQz3v1Kv2YU0jrvQ8AKZGNjVeb8j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiX/5erPAApWs0NDWiCGQArj2QmwvBQtfImtoFL93b14Hg3u0J
	SN0Pe87uE3u30Yckzyd9x5OjdC+LuLRsIJOHVGjoHoZnKtqylWd8EVIOUjnvHc7jUwAQBuTKww0
	KiN/DrdBN3YhxBfZgiO9sEhtpSH4JDuM=
X-Gm-Gg: AeBDievcLxmri1i7tN2/7u+IONJFMftSWPoqYPUaDJxZdFFkYcd+zTCPZ94BBxSOxXz
	YPQfQC3pGcBvLwnO27pYoMf384civwlDzykNVfJdWgaYygmLz8oi/OgGJIPO3yPr4O3p5LTE0rw
	gt3XxEZqJw5b12EcYT0fP56D1lOxN14vEvq2tQRQ6WKUTw6zkOjANYnEvKhTrW4Tz0Exx9mJnmy
	OLbEBEK55XiVI0RauVkGS/3/dKGx8L4MzhYw8EZpXetxjzFr0xn8j5ulfVCn5I5zB/xOGhhLLTd
	Qk2UDzGSo6ZaHR463g==
X-Received: by 2002:a05:6000:22c6:b0:44e:7284:5f21 with SMTP id
 ffacd0b85a97d-4515b9f4c7fmr3577789f8f.18.1778050996944; Wed, 06 May 2026
 00:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
 <20260505072015.1672730-2-maoyi.xie@ntu.edu.sg> <willemdebruijn.kernel.2b6abb6aae1d8@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2b6abb6aae1d8@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Wed, 6 May 2026 15:03:05 +0800
X-Gm-Features: AVHnY4IHYi6g460Zc-J1tqBob_f27_Zqaq9yQz8MiephHqEYYoxSoyau9SBzTWU
Message-ID: <CAHPEe=HRsdOeWEUTmJ48nqjrwfOzgo5ruAcNyR=LHR5MNRCF2Q@mail.gmail.com>
Subject: Re: [PATCH net v7 1/2] ipv6: flowlabel: take ip6_fl_lock across
 mem_check and fl_intern
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DC1FA4D6EEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284721-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[maoyixie.com:server fail,ntu.edu.sg:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[ntu.edu.sg:server fail,maoyixie.com:server fail];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SEM_FAIL(0.00)[104.64.211.4:server fail];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,maoyixie.com:url,ntu.edu.sg:email,mail.gmail.com:mid]

Hi Willem,

Thanks for the review on both, and for the Reviewed-by tags.

>> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> Please update either your git config name or Signed-off-by to
> make sure that the two are the same.

Sorry for the noise. We sent the series through Gmail because
our NTU SMTP does not accept git send-email, and Gmail rewrote
the From header of the resulting mail. v8 will set the email
header From to the Gmail address and inject an in-body From: line
with the NTU address, so the trailer matches the author.

>> +/* Caller must hold ip6_fl_lock. */
> nit: lockdep_assert_held as used below is preferable over
> comments

Will replace the comment with lockdep_assert_held(&ip6_fl_lock)
at the top of fl_intern() in v8.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Will add the same Fixes trailer to 1/2 in v8.

We will respin as v8 after the 24h netdev window.

Maoyi
Nanyang Technological University
https://maoyixie.com/

