Return-Path: <netdev+bounces-264183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LpDuD6kOqWl80wAAu9opvQ
	(envelope-from <netdev+bounces-264183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 06:03:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE02B20AEFF
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 06:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A302301FBAD
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 05:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CCE1D54FA;
	Thu,  5 Mar 2026 05:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUfJB0vs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611CAD2C
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 05:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772687010; cv=pass; b=TYmPkkqL7QlbJ3nfXxRmpMfDLghttAoak2vfqLbs7aKgjRao7W/mO2n5NYvxXLdmv9NjMR63fvP60hZcV+F4+qq16XJbdyoY7v3Jii2aY457QCXAlXN09umNUArjQYCkkASe6FyG5hMnVvpKkhdCzKtUuHBMRUbVhcYOb3DKVO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772687010; c=relaxed/simple;
	bh=H6L4qWUYYdhMJcukPMhlz2vz5zBjYPoz8trSiQkSXdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YabAsvtmunwrLM3WCoEj2hzYp+M5KK/VWJICp3BL2XnC1RLXakoFPl+k2wQjOKHUK4AqbUanpZW8MYciKqQEZXalKoLSEmFhZU5DmAMrdN4z3V/HkR9Rg2cYaF/NfLUGH2trRnHvmPwcfEsGCR1/9h4s/jVcQfN8769xjlm3wXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUfJB0vs; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso115857a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 21:03:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772687008; cv=none;
        d=google.com; s=arc-20240605;
        b=W7o3LzKDBBcLqDNOWwYNXYNoxCzmVmkKTV3UffkYLceiSg/3iBj+o4rEJZ5ORPQG5G
         a5i2bft+G/JSr5xMmJvh9QsqK6r5pJsQAKAyVuVCZ32Ne8j6CBK0uKDg4ebOxuYYszpQ
         uboMwtGlA9eKrelND6QHbPgVF7TRykaITeVkSMmkkZmaSo+xLiKgr/ORHHndrr/iAx88
         VD6qt7mkKo1EXOAp76pyZbS14QTKWyDonIXJmjbTF3sxxqicHAB3P+ZRmNElkZE7QLgl
         g6BxtKHX7ThcGLvfx6iCvN1deanuIRD+zJKLYfvHYWa9rQiUCf2EMjTPuE7swL/RAmHW
         Hltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H6L4qWUYYdhMJcukPMhlz2vz5zBjYPoz8trSiQkSXdg=;
        fh=YzcdMtk0k9Pwgw4CGlU0hfkC6IPWsYJPbDtTL3FFBYs=;
        b=WltWmljLauZvI4i5KDSRclTRTsSQ8MOfblV/4EW/hyu1AdCVne847kCFCrzpW/O1Jv
         NINMayOOB1E6grh6AXxFymogQRl8qKEi7i+ulRpnLqstSWJQYrQ8IKG8IgkkznBnui8i
         vt+lKJKNr4MBV2n9/AG67sd4fZeY+c52BLyxNxsXArUuNiDyPjJHF/579Q8Ny+m8wei7
         sdUcyGKMNysS4Kgognj+2NZxxSGYgo2nHey2qFbuwn1HpQCqGLDYKGan43MnF7wxHduQ
         YtPP+Vu9/v1z2f0IbW6rJ2nxln1WuN0yUpjEwYrsYeIe9wHZDdVnAflT6F/ofQHQPGn2
         quCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772687008; x=1773291808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6L4qWUYYdhMJcukPMhlz2vz5zBjYPoz8trSiQkSXdg=;
        b=xUfJB0vsFk14IoTelp2E4nk6nweIXeBV3T5nNmmsI9LgKODLnuAuWlm9gzj+WNKEEi
         FoDU1CLNIw+BHokibgfmq/b4KckbHFpD4rpSIdQILULwLeVLosjdcDJ/lZerig8weoCy
         8hNJ3gBBuxYct2cWjf9GYcfuTN2Kb1j5Zmlw2mXK1S5bBJ4O5nj93ANoTCs+Gyw8j0RB
         HKZOJUeZZgMAJhelihEcBsMCNfIzsoF/bGrKt1U02BYYBA72A93QDFr/Q6/DgF+uJcTG
         sX4x9LS+RrTxJ9DntE48z9awgerqNWZJ+X8l71skOTGjxsrVwTexw0hzaOEGzDBHiOfd
         zm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772687008; x=1773291808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6L4qWUYYdhMJcukPMhlz2vz5zBjYPoz8trSiQkSXdg=;
        b=Wf4jA1exwtSx1jePU/dUz0OKp0NH048jARh93gsEMAuH3WnA3a1vNXIV8Sl2prqGLs
         Fh7MABl3GoDjRWlW+atIhc6oy4WseauRiLZH9OMxM0S8z8GWvBg0cirZJby94PuyfaZ9
         uNmH50OvFTqgOxpOQn7Cuqa+7eVT0sY2rNVkaMT6/BbFh1WUG9+OrALEY5Lgjyg6a4uu
         YsvQH0wLHNNqNiZVprDe8C6c38Cfzya5rPlrJYyQ6pfKyFX5qpQyPykGH0mpX2uWfzG7
         7hyPJ3gEIribqLDxITNDbPQPAA//il4lmyq5AbBSSVGTiLA0wHx0GFu1MEJFEiApe154
         87YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmZWSLxKkZjY9+fvuL5DmqvO5mr7wL+spcKnDnXWVrZOS7HfoeH9I7jF2FRUc7OXxrY0/nMVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5K/GaLQJMwKgO5MYC7e64hnu4IEMAGw/rkAUXPtT00Omyee1f
	OgZx3ft9rc2FVXTDYx4h+xxxnpslTatf6NocHVwchNtZu3D9M0lIOjnXCH4AhfzomJTZoeKiZaV
	H/KnU1TQuWO659vNXks9mqGNBy5tsqdQmIi6GkfF7
X-Gm-Gg: ATEYQzzM2qTT3dOABuNIa8vs2E4BpQP0kcoOX/7sIsA8mvaS6CRmc+ms6rXUg8CXDqq
	/B2jk1TfMpRs63nR5hyEPP/1GnTq1uuzMFVck9O5C97ZDpbZbP6ToWoAoA5Hj6ltEhsB2XYaYtn
	obO51PwuYKsJD3QP4gNpcbal3hg/a9YmD5u2kC4E0C82G0a5wmEI29Pn+QZndG6woU97kQ1smf3
	s+d77GJZqFuhcKDVmZUAlvqDkvxtzF8EuvD9zfSQTOBqbapyzfNhL2wwl0LyU7EyQDG3opbgRvl
	OmYIY15tjiQK+TyATw1sAcr76tsFKgLxGV4M+MMQPEph2C0lT3huCjJRzHgvY0PLHcPsAOXUMie
	Lmz79zbY=
X-Received: by 2002:a17:907:25c9:b0:b8e:d04e:e506 with SMTP id
 a640c23a62f3a-b93f15afc56mr260135866b.57.1772687007296; Wed, 04 Mar 2026
 21:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVpQUDy_fLy4TQNfJbqj9QVr2g=_bykiH7GSQQRjtLTT0SYyw@mail.gmail.com>
 <20260305045302.96132-1-kmta1236@gmail.com>
In-Reply-To: <20260305045302.96132-1-kmta1236@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 21:03:10 -0800
X-Gm-Features: AaiRm51M-8oAcugkuqe3GIMGKAon8KZuArVhm0sdHzlXeSCzlEafJcHg28mIsQA
Message-ID: <CAAVpQUAmXR+GAOakpfyk=Wt3fnNaa5EirLSJZDGeM3+gmefcug@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: remove unused hash_size from struct tcp_out_options
To: Keita Morisaki <kmta1236@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BE02B20AEFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264183-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 8:53=E2=80=AFPM Keita Morisaki <kmta1236@gmail.com> =
wrote:
>
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Thank you so much for the quick review!
>
> > btw, AFAIU, patchwork does not use git am -3, and this does
> > not cleanly apply after your another patch and you'll need to respin.
> You're right. Since the first patch (https://lore.kernel.org/netdev/20260=
304111517.2088694-1-kmta1236@gmail.com/) seems to be close to being merged,
> maybe I should rebase this patch on top of the first one after the first =
one is merged?

Yes, please rebase and send v2 after the patch is merged
(and 24h passes from v1).

