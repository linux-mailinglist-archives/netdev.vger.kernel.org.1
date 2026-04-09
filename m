Return-Path: <netdev+bounces-276866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yONoCdBW12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:35:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5CB3C716C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEDF4301107B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F034D3A5;
	Thu,  9 Apr 2026 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6h5G+iw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVMLO6RZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025E3081BE
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720139; cv=pass; b=ezrdgIq1eyEpBd6tXN/79ZuYzbfD5fUjIWy6dztGI4fnesriOJlBP+PA6T1DUBcgCjNfD4sPAON4yTrF5csNDav0U4O3sZcJAITfLCbtgOMvJAxcXB/66ZF/O8tk4pWBOliZ9MIm5MhhYns2G/zi1jirDmi2iG6YotqHuEW+wGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720139; c=relaxed/simple;
	bh=3bKzmQkJyzTKRjTvOy7kcrmqjRaQYYlocQzym2zd+o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTzV1DdanfppOiOn//gygHK7FUoZou49SqTFETrhrFElfdY8NqW1S7Jkp2UX2t2NWAwzf9ij5KyFJ6x33t3M72LAma6UBIIE98aOlTTerz8yY0rVF+EMmroLycCaCfknyfRNiFtaPDk58QH8nIBX+i9AQO3M/Y4l8ZfRBQEDtxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6h5G+iw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVMLO6RZ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775720137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxtWQLaJiuu9KyqZaZcyJ40xxhis3WZ4fBy4ddMBb0c=;
	b=W6h5G+iwFbVZGa8sngnB6fzE3kyPnOXF/lOOCHLe8fcDzMprKf50lEnHwaY/z0nbpNpwK4
	Is07DahaTS34YXQpISbUyF5I3GdV9j0BwCK1kC3tZrt7Qt3QPw0rMxwcrnvXTl61fjaomu
	aUX8SEjyuOzfjW8iBWUqQtU5kI/XXbI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-UNOp_iSeNqKIUEBQjk659Q-1; Thu, 09 Apr 2026 03:35:35 -0400
X-MC-Unique: UNOp_iSeNqKIUEBQjk659Q-1
X-Mimecast-MFC-AGG-ID: UNOp_iSeNqKIUEBQjk659Q_1775720134
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-66dd1d75657so650899a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775720134; cv=none;
        d=google.com; s=arc-20240605;
        b=Rl9W3BN4naOoMO6+9BmKlOJy3XJg7zq6IfWOGioO6yyw+aJ8UzBN7lQVi4pqH+2oQh
         vtr84eQSaunSkiAXZUoCC9RIfT7so12tLU1Fn35ciyzyEfSTq4n2bSPxVwBi/SGy/DXO
         OvMkFo/6OskdHii1RaIsIvG1I1ZGheo+0KL7tgHvTWzEJtFmsCRJAvpSl7r7HTglLFX3
         LaH/rKoBlo1Y0KHq6PY9f4T/1k7cAIfeyNKV71LSXt9u1oAcfEmCm3gjZIUObyr1Tbgf
         MZB0PsD/2trW+Vq9q/XsGkuFmFYmbErScaSlUn3w5cfcZjF+/VYNVX0XFBskqmvOy8pk
         q0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxtWQLaJiuu9KyqZaZcyJ40xxhis3WZ4fBy4ddMBb0c=;
        fh=Ef/XBhyuJJ4fZ2c9NQUo2an1kv4hMc8Mu3I66oIeFcI=;
        b=ldUwdSaluZn/WfgCEPkwU9Gl5mggV3Z1FVdPQHxa4HK1aLstJKJ/oLhchTPm4ptMNJ
         NHbCslpUwjYUnw8nNwDjWRTgcCy+QG914RDlm1XvYoQEhRr5V9o6MMbBZ8M+YljRUvbP
         uZ+DfNqkKykdbi7GD22VofR5rOVTZc19zIZ9Dsyciuih/V6R8P9EJDTOTe69PmG2pUF3
         XOcAFzCwaZQL3o3a4zulHOWHM3RMrCpNL3LLeKw/JFJKYHXL1R4JX4EGlmhyb2LU5FaB
         eDrX2K99BwOnAjTvODpH7q9BxGAeG8SDH/b6QgajQK+5eNkW2hc0YTHaOEvmc1MdQZYg
         S99w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775720134; x=1776324934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxtWQLaJiuu9KyqZaZcyJ40xxhis3WZ4fBy4ddMBb0c=;
        b=UVMLO6RZ7AeSFRtb+JXO9dysuvsD7uxN+nM88UbMMa0UrIp8NqmjB0jNCbujaDN90F
         46XU2nkV38mYZD7pOH1POirbt+HJUQCySSKA40ZDVAoq3m9+fEWuD84uxaq6tspPzvKV
         DjNiK686rH2q1h2fMd2d9ksFNZiXuaicCrWIyFuuaTPulPhml/6iUB1hLisNoxdTAUkw
         Psd7H2g6FhkX7ot944sGgQ8bqIWLagOEMxvl3n7xfikkoWNBgc6EXQ6Rs1Sl7qHsKtU1
         E6Eufh3MPCCM8FdUbuNiUvUx+pE3hRRT67cfmUEr3xcPQrg7m6u3N29QKBns5gsn+tr7
         lkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720134; x=1776324934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxtWQLaJiuu9KyqZaZcyJ40xxhis3WZ4fBy4ddMBb0c=;
        b=kbdcvHPrz4ZUmf92kbcg8LQYXhGMGuNM+kqh7RIqPkiF5T34G91fCLZN1CFHu4djyJ
         raNe8CrSxqrKX94am6aiu3Si5uchXKA+7qPfG+7bwgah4E/xilENo9M8wG4B138O3sJH
         w+du+/E7UXVZB/gCDG00ZaOm1Lfh5BI4xGcywA1hnxuaE/t13XQTBJui3C3NMrpIzV8k
         1f2B2r9NorAJn6PboAzu21WMDG+xMY2RdED6bD6u0X+bt0Y3+AuNyUDYYMwpaYBGIi0t
         pifls3tI1LUngoMcSmmbPl/mH0HlcD/NjahacCpNY4bXNrvLXece3QKq8t9e7ZlftDOw
         1vLA==
X-Forwarded-Encrypted: i=1; AJvYcCWlG3BWSOZQ9OQHdb7ypmon6TZKLxwKz9ZOPxOK/xfRo6rW+aAi5pgnq+iE1NTNa+gNjw7iXRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5K343fxnvAZrwcXTqfppTjPEBCiwUSbvyx2frrqCGIF974fI
	TAFO6LN7GxZ60NIEdul3S1IJjVEAtxjTHqSqkWS2pz44WN99ahu9TrhROOl24GILwm9ioJ4xQR4
	A6e3AOoiJTY2zAqD1WsvZ2q8yb5z7EGG6PJK19CzpTMmoqdAqLjVf6uvrSUBFkrdNBwVdjUJPC5
	dr5YA/u23LGsa6cuZueT9uWWwakafS6wll
X-Gm-Gg: AeBDiev6ZTKmAbetANV3CcEz5Is/1Su03rScjWj6yH36lzHYJJf7JsX50ydwhbIJC5a
	lGibknwxnMCP5gRQCpMz2FhVs55OhGvQR9I8I1Ead52O0Ni7J1hLNoUNwt6q87QLikA+hhvS7xX
	Lx+QeW9MY58fbbKQHdq9HojBpSfciEeQTpf/ezKasAedIKGXwQX3R/IzZpu60VJxP5/tG5ZWdQE
	DhvWF0=
X-Received: by 2002:a05:6402:1d49:b0:66f:b3cb:502b with SMTP id 4fb4d7f45d1cf-66fb3cb5118mr2434363a12.23.1775720134355;
        Thu, 09 Apr 2026 00:35:34 -0700 (PDT)
X-Received: by 2002:a05:6402:1d49:b0:66f:b3cb:502b with SMTP id
 4fb4d7f45d1cf-66fb3cb5118mr2434344a12.23.1775720133842; Thu, 09 Apr 2026
 00:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775527362.git.xudu@redhat.com> <b65f95793e03c1cb3ed3af4e1b2bee89fcf7e648.1775527362.git.xudu@redhat.com>
 <20260407080844.35368eaa@kernel.org> <CAA92KxmXOpH=CUqEdVV2948XhU1oFh8PBYLUt=ktSsK3sOh40g@mail.gmail.com>
 <20260408172741.39e65ab3@kernel.org>
In-Reply-To: <20260408172741.39e65ab3@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Thu, 9 Apr 2026 15:35:21 +0800
X-Gm-Features: AQROBzCSiYIn_6eIL4l8IyUTl83-XelT37kb_7xCVKSrMKxgPHpsrqohje2yz8Q
Message-ID: <CAA92Kxmka9=GEvNwxOy7pSEuudqsaF3WGJttyQpYEkTyyYhgLg@mail.gmail.com>
Subject: Re: [RFC net-next 2/4] selftests: drv-net: tso: add helpers for
 double tunneling GSO
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276866-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DA5CB3C716C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 8:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 8 Apr 2026 10:04:09 +0800 Xu Du wrote:
> > On Tue, Apr 7, 2026 at 11:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Tue,  7 Apr 2026 10:45:09 +0800 Xu Du wrote:
> > > > As the YNL Python module cannot be invoked across different devices=
 or
> > > > environments directly in its current form, the helper abstracts the
> > > > YNL CLI calls to ensure proper configuration of the tunneling devic=
e
> > > > features.
> > >
> > > Can you explain more? Why can't you use class RtnlFamily?
> >
> > I want to test the gro-hint parameter functionality of the GENEVE tunne=
l,
> > so I intend to use YNL for the testing. I am conducting the test betwee=
n
> > two machines using SSH type. I want to add the gro-hint parameter on
> > both the local and remote nodes; however, I am unable to invoke class
> > RtnlFamily on the remote node via SSH.
>
> Oh. But that's not really what you're doing:
>
> +def ynlcli(family, args, json=3DNone, ns=3DNone, host=3DNone):
> +    if (KSFT_DIR / "kselftest-list.txt").exists():
> +        cli =3D KSFT_DIR / "net/lib/ynl/pyynl/cli.py"
> +        spec =3D KSFT_DIR / f"net/lib/specs/{family}.yaml"
> +    else:
> +        cli =3D KSRC / "tools/net/ynl/pyynl/cli.py"
> +        spec =3D KSRC / f"Documentation/netlink/specs/{family}.yaml"
> +    if not cli.exists():
> +        raise FileNotFoundError(f"cli not found at {cli}")
> +    args =3D f"--spec {spec} --no-schema {args}"
> +    return tool(cli.as_posix(), args, json=3Djson, ns=3Dns, host=3Dhost,=
 shell=3DTrue)
>
> You're not deploying anything to the remote system.
> Are you assuming that the remote system magically has the same
> filesystem layout?
>
> You can use the ynl CLI but it has to be whatever version is on
> the remote system. Just call ynl --family rt-link, don't dig
> around for the spec paths etc.
>

In fact, I have tested this from two different locations. The first is in
tools/testing/selftests/drivers/net/hw/ using python3 tso.py,
which utilizes the specs located in Documentation/netlink/specs/.
The second follows the testing methodology described in the
README.rst of tools/testing/selftests/drivers/net/, which uses the specs
in net/lib/specs/. Based on this, I include that different processes utiliz=
e
different spec locations.
I also referred to the implementation in net/lib/py/ynl.py, which employs
a similar handling logic. Both using the source code repository and
installing the package can meet the requirements for remote testing.

--=20

Regards,

Xu


