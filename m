Return-Path: <netdev+bounces-274122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNh7Gk0lzWlkaQYAu9opvQ
	(envelope-from <netdev+bounces-274122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9A37BC2E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AF4830718C9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E543CEFA;
	Wed,  1 Apr 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QYebEEnr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840140825C
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051219; cv=pass; b=QauYh4Qul7BUvbp7inSKBBb5sbDkf3vdtR4GPAB+ws3an7e8sm0oIPPskR0Q8/Grb9h0ilZMlrc0hB6LnGa4XEcDed3nth4AL3du8vzv112DS0h8NriZ53eylGrasiRkeCQk5y83CzTtjld6xgWPLdORV1YIzmW0dQS/Fy82kSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051219; c=relaxed/simple;
	bh=M2QHE7KrhXXsCLenOGnANdMwrdPI1+laSLsq8uh1r0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FE+RTj7DLH3HUSXVJFEn5ggMnzJ0Mo8YAZxJOs2T5YJZ3kGyjlzaMQxDyvEqintuaJ/4qRrHzbMSF4EnSZEVmssYwJC+hTcydr2SOr1DQTrqV/VM6o+G64BDE+HPwTxkUBVpm57cRkGtyVEnj9EON1ZWULtCYSoHMvZvLCBJSQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QYebEEnr; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509134ab2d2so54065131cf.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 06:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775051217; cv=none;
        d=google.com; s=arc-20240605;
        b=C8HgNdE0u5UP3m5cuiWiTSIYtcQP0lECOnvCPo0I+OdqevDSh+HiiBr5iLdJpgthy/
         hxUB5PGKRly6rIDlmTi9XU3GHTztif/inEYK9VM4+JAGLKumWJb2hLXQXghmvlzRQh8k
         o11wIbwmn5k0e/gveJqVU7OGXASyS+jmv03YmvGGySdEk6sWfPrv2SxalVuahi4D0K27
         Q4nnaYQIRGsxWugqo8uvANV0E3sPQHbo5bhh0b1192fkV30VdPAEYQHAr3wbW7aSBfRy
         zQXpJ3wmaY/ieKS7+iD3PH9QmYIzv3lOuvHq4VvF5TQoW3fHgjI+Qz7/3C+D7RcRLM2F
         nYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M2QHE7KrhXXsCLenOGnANdMwrdPI1+laSLsq8uh1r0I=;
        fh=jJiDcQtV1uByr6RRdMGMtNLLJhMCJI28DtNr6SWpEkw=;
        b=AmD5EAiwnQLZUdnKOMQT7QULY/P9bhjl+ER4CHK7/l2dpW74bIC8MmAPY6vK5zynAp
         oVSsfC67x6SQuQ+54qe6wBXHTWoeSIvWpiN+fhUvLn6ZVDxM9ORVQpYeZKMyrlswOONT
         avj2ei3mdzo7m0M8ag3wP1A6wCheSjAnky/amD/kFg1Ft3rR02xWYU08T19S4PDn44yi
         4M0X6stA+H9DlI5RYUtR11pDNEb8qlW1NIE+O1uZ+TNkwStQD47AbD5W2dyNquPuvktv
         92sZzkQiPoW2vSycgIsCqPoxQge9bkljY9d9Tgf9LM9+3QCXqsidoKCCXBmbrvIdWITX
         pnfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775051217; x=1775656017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2QHE7KrhXXsCLenOGnANdMwrdPI1+laSLsq8uh1r0I=;
        b=QYebEEnr4pYjqllPKuptQKheLvmGnUhF91Au95xJtL6Kz8RIPLEcSTvkzJYoogx/2V
         nOS3IIlkQrlnbFJERO8MaTKh9zxivI5RNKlBo2zDZ99fnRQT3HV6tLsOgO1mXbSsHmQ0
         tmHegnUysc7xTo9CkzDBNp/KYLOf30F85CtRNNGwVRqRMnUBbX04HrmCcD1vo3uJmxjw
         b1gZiyEbVW+A+ren3uuBRAXo5s4ubiwAdtlQx9kyY3HGiUyYAevIseParCuBLWzJJsOK
         ZAZSoPiUFz2jMLtboxS7XzH87mFWbi327dWF8hVWHn9ydkaNXqz+kveIe5q6z7rl+9Nm
         MDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051217; x=1775656017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2QHE7KrhXXsCLenOGnANdMwrdPI1+laSLsq8uh1r0I=;
        b=baHXV0QHhNSpQE9DUliPxXodVkym6w6iiQWLPAyDigZWxOsuvT5EC6H8R/Cu8+TWNI
         GIDxwa7hR+19iMoOmnlGuVE6vyBfb8BgYSnXVPnY5MGeFfrUkD8A4RTyRzpxcJpWKzVC
         DcyBpHUKGtxmuWCHGlh8yf1SOlSaCacxDeh0BRm6KB5TPmRdaFcfyAnwCGywWLtLfDjX
         5/kc/W49Gk2xkw9BnngOyPrBZrbUUtIuuw1rTHWaqkHJxFfg6n/yZiAwXoDk76pgdYpm
         5ldSA370uPVvOR5K93gtkXsQIWezteb7UaJK0u0GtAToZiLKO0laW7W5GlGeHLVYuLHd
         h5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUnAazR2/RaiN7khrLS/mM+kH+mjJTXwU0FN9q71+qOzh0BLxF9uzUHSAa400nIUYqUcxn8kiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTpmW7+D42GsKqvhU6Z/0h6DP4u8nz4pwkaGI8jFLA7EHN/Yw
	AZVnXBQFiBl5JqMOKvusp5/rVpIHLXgp6bPDJ9trNxc8oscplZ3bbDewYxgXe7tgMPhJglg2rFH
	qAB6wnQeveoBIxaoEGBadpAlSLUeAlWdyiCWLIJtz1p6cwFMlz2pLluYx
X-Gm-Gg: ATEYQzzjXdYL+Sl5238aG8dhHUzFWVm3h3GnGYfClYYZWDTmxpx5YZfkLvcUvKnvipO
	MQWdoPGUAyA7jbEEBlPYF8L8J6rvwHjdK0tnJ1mvBlsPvQz+9fpZKwv4WotfH3AtRNrgIDgWPnF
	JyFRHCJppfjBggtOt7abkirzcFRUagm7x34pMWsKJWUYTFbT3K9xpnPMEklU1FXfEEen65yDISj
	lEWbC05bT62tFrR5QWTqBxOI0T1gs7M6fJowX8zY4UoncZVbaaJULU/8MpPahg+fIR08z8yEbTr
	hKqLJ4FL
X-Received: by 2002:a05:622a:4cc9:b0:50b:34b7:fd62 with SMTP id
 d75a77b69052e-50d3bc9b7afmr49524231cf.25.1775051216746; Wed, 01 Apr 2026
 06:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_bE8JNzawgr5OX5m+3jnQDHry2XxhQT5=jThW1zDPtUikRYA@mail.gmail.com>
In-Reply-To: <CAL_bE8JNzawgr5OX5m+3jnQDHry2XxhQT5=jThW1zDPtUikRYA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 06:46:44 -0700
X-Gm-Features: AQROBzDw-vv9yAeBcQACa0Ha7Hj591DuevJ1YlB80M12Fi0S9_3msdvlSh6I5IY
Message-ID: <CANn89i+XNV-Axy3gDSdVadBaHUYqvxPxJ_OGyZYo8=-EdqRqtA@mail.gmail.com>
Subject: Re: [BUG][SECURITY?] ipv6: opt_flen wrap via repeated IPV6_DSTOPTS
 cmsgs triggers skb_under_panic (local DoS)
To: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Cc: security@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274122-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: E3B9A37BC2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 6:19=E2=80=AFAM =E9=92=B1=E4=B8=80=E9=93=AD <yimingq=
ian591@gmail.com> wrote:
>
> Hi,
>
> I believe I found a locally triggerable kernel bug in the IPv6 sendmsg
> ancillary-data path that can panic the kernel via `skb_under_panic()`
> (local DoS).

OK, but why sending this report twice ?

Do you have a patch already, or are you asking one of us to provide it ?

Please do not CC security@ to anything you made public on netdev@,
this is not welcomed.

