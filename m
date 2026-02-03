Return-Path: <netdev+bounces-256451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZQV2GgFSgmk8SQMAu9opvQ
	(envelope-from <netdev+bounces-256451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 20:52:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093FDE45F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 20:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06B83300532A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C03242AC;
	Tue,  3 Feb 2026 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5ckSNkZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0F2D7D41
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148345; cv=pass; b=mWBdVDSQo9kWL44S05sAyfSBh1gE/6HkAzsdmvY+cEcAEoQKIxkvETy+fOoB2NHkihx4AlkBJ/i5GrvboZGOz9ndUxjB2NFnnizVQf1Nup9NtfhBPPGtHfKuNW7zELe6VbAndG/RZ8VI/W8ttLu3Lu9r/gOh9fl1q5tpVsodzCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148345; c=relaxed/simple;
	bh=+KAh+xvIiuzTinmuwZkrGBCwy1I/jlikotrCcBlMtwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyybkc0RUBJWioSqKQytBAtq6wwJ6WGxjffKkb9vMvXc1IsHbRkkj1i62xGSOYdDXKf1QgDumIwwNmMbRpEeOLIBX/l7pkqq4T5O67vN73eIZc8GTD9Wd9YPN1aZD1PYoc3m5eYuQ6baMBlIwzphhPofU6fJzkwX6nj5lHeTbwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5ckSNkZ; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso10455936a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 11:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770148343; cv=none;
        d=google.com; s=arc-20240605;
        b=gS3b5QM6TjUc3MGZxCwfgHGBvgCUxe6At09crHKXrYg10FwlG6sIpAvoSQvvVA1Xhj
         gAfok/wS6OpdOqk1Ro/upCPwCcxBTVFn989g0KkjdDokjcg17o0Q6nAJVhWpGk0swrXn
         29c9O6b0Jz1IjPwY9zdAhfnnagRDDqd+eI0pXcsnagCjUtmQFX6paQkdNx+CC88Ye+R1
         3wmUc8VwkkQFYV8TAr2gJeDl8PAQR8uLeUgyFDAtCiJSwVPI7KPUxfyR4Z6hPW8Pyou1
         ouvSs4YbPG3kgGotnK8Da6jBiGx0NkPyoEyf2Kkdjvi7fMX7svdYUNtpCL21Edlqukvh
         B4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KAh+xvIiuzTinmuwZkrGBCwy1I/jlikotrCcBlMtwY=;
        fh=ea6iwhPt93VCp/g2qdaTgOSdIIiEOVRm3J+7QJbF0Zo=;
        b=FcOqaAX3OJfMYHxEs7VD8f1naJkTZMtFEnG1jm2ysHz0KfndknrYmLO2y70+laIpvC
         uZiNvAWBsoX/6qFRH5JNS4wP5aM8EQtdyIxbbH6uKmjh/nEW+TxlagMtyP8e+o3J0gHh
         09j2PyT5W7lRSeyZVSQVp+t4H7GSBc4SzMslQ7ZL9k8H/oNheYjSrAkwY33FEFtHkyrd
         Sx4QQeXwJC/JXljtT59HyBtBTlv4r9e+LC26NdpAZs3qvb848Y6CTzlJ/EID4LE/pzyx
         VHTmNyPwRxJ6yzNUXaAw91OWOFBvwcSmod3JxMlUmnnpH1j2nCee4TQ+ggCJrJ/lEJgl
         Bp6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770148343; x=1770753143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KAh+xvIiuzTinmuwZkrGBCwy1I/jlikotrCcBlMtwY=;
        b=Q5ckSNkZnRHMRtC+i4Qw9XhZJErh3c+gu8TxzMYxLLR++CyV7Jc7pKsOvTQFTBkDfh
         5eP4gisgaUa9Qij5Elyw3AY+6pPtH0OYRYgTASQm6vWMaGzYUoiEC37UVMJJIK9Ipbxi
         zQAAjDOgu/RxFXwIPVwivxyr/u83Gwcnb9hTEHn1tZ4bMnvY11Ja62p0ZhEiSBHNupef
         2+eM1YtAbG2Trhbkx3Lq1HI6JJHlkwT+7A8koCAPPmvMZKy+vrq8UOd2vNVHPxU2m7vF
         +1QV60LjP6Yr7zoZ1I3CaBC+cHa0zWqa+326zDu47HuZziwEEKZ9Rz1uPAplAPzSrCgp
         SmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770148343; x=1770753143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KAh+xvIiuzTinmuwZkrGBCwy1I/jlikotrCcBlMtwY=;
        b=hNVjBc4OSNd93iam09XjifqH6koznHgUr3ig/IL956kYEVYAmrWXRLmemtBXR5w9tx
         RWl3MSf5icon8fV6jFEAUctAKx7oMMmm7pOENN2lPSxiuJM+gEvvibylx7YkNEdB/ual
         2Z6ihptGpo1HT1fkdl2FPmkBozik6spT8snWx6n605uPzTwwsz2jgeoxafFDz0AUe4WL
         T6T3Q2e3EQ0V866ZQzP6AVS6hc7BNlMm4pAjr/mOHQnE+VOnKfabjiWskGoehWZu+4YZ
         zfWDCbR9Lk1uPppex3lgYOWzxv7bvAlsrpm80U8L99ASFArd3HJ7r9Ia8JE/WebRgjw8
         zQRA==
X-Gm-Message-State: AOJu0Yyz9P3GmVu+SrggF3Qt3jWu+uKWh8bEsLdsdVMMvo9XyowkXJR6
	OaOhe3aZK20fPtBrFG5P8sf++MZPwPVva0ZOgwdH3b4jvwmt5nGx0VJ7z3qKXgTldJEloBlPkJA
	N4QUTnOHqVAwFhmIC9E1GV/Nq3O8Fvno=
X-Gm-Gg: AZuq6aI4/fvtL5JE6FEkTahwQc4eFCRsQLFqIWxgVwDDXhLAUaPdhifnZ0TR8oO2Stw
	gJAQy/rKgaX1abmh62sRc+c186g/HpTDEHk47FSB76DpxMZVavBYvr/IbeOTlWqdg60hVmjzpAf
	MW5is4YULhW2FIJjvDJ6SPJWu/BikQXYi2OzLp6icQNGleuiQmnS/sOjvwq3GXrKj2xGuaczBv0
	M0Y7T4axaM4TnxeKIimh5O3oz7GXb8AHxe0xsu8dypKguZnq14eMf3HQNUZwlwt2NqWOnZBl8ok
	uCdUdrku
X-Received: by 2002:a05:6402:274b:b0:658:eca:1fa5 with SMTP id
 4fb4d7f45d1cf-65949fd4a88mr530985a12.20.1770148342590; Tue, 03 Feb 2026
 11:52:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202214634.72738-1-rosenp@gmail.com> <CAMRc=MfwuhrUZiFp5v0EjbMJw0fYZTfznqPN_6yuMWxnD4ircQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfwuhrUZiFp5v0EjbMJw0fYZTfznqPN_6yuMWxnD4ircQ@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 3 Feb 2026 11:52:10 -0800
X-Gm-Features: AZwV_QhUhGkiHiwFOa2GkG39dG5L-lytsv2PhBNzT1qvMKtk87kXCYDBtdnQZMk
Message-ID: <CAKxU2N-zUJsgX8dFewAQk-xVdjHULDDGVy0zht8-qYd7_8Asow@mail.gmail.com>
Subject: Re: [PATCH net 1/3] Revert "net: ag71xx: use devm for register_netdev"
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256451-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7093FDE45F
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 2:29=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Mon, Feb 2, 2026 at 10:48=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > This reverts commit cc20a4791641a1cbd1525695fac0d4725dd72509.
> >
> > register_netdev gets called after phylink_create which has no devm
> > equivalent. phylink_destroy must be called after unregister_netdev and
> > not before.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> Can we just use devm_add_action_or_reset() with a callback calling
> phylink_destroy()? It will surely make error handling in probe easier
> and avoid mixing devm and non-managed APIs.
netdev seems to not like devm, at least according to
process/maintainer-netdev.rst

Anyway, I'm wary of custom devm_add_action_or_reset calls.
>
> Bart

