Return-Path: <netdev+bounces-155417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA6A0249D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C271649FC
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB331DDA0E;
	Mon,  6 Jan 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSDnJM3T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FA1DD529
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164660; cv=none; b=HSmd1wY2EA8XM2p+onFRQHmaHo9WRDK/n9ro6jmSjPj0ERfqEXSVrZNeg3i+xz4DTIth9nJ3fIr9Y0TK8QlvIS+MHN/p00pYT4t+Rycx63Dhzvug0Wh5ePVRsp68Y1rVNt+uD9ksyoCkHWKLJvQN5g1RQ2FrizoYq89mwuBZp/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164660; c=relaxed/simple;
	bh=0BvLeSwPFGIe0JNPn+dQ7fJ+5c+Vr5p9XfEK/Qv/wMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/i/lSqjbbZ8T3uz+n9dBtHIX2VXMzEg+j0BK9bv5mkuDQbRQf/81IdvFdxBQ602b7QmG8YDUUGU/PAWjOucRMdRC29Qz+xO21+G7lkwA6jXLAuOq8N4QQFKjEjma0+DW75akLS8xrac+G5ffc4nBdk1AelL19K/tSX7AXA3JM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSDnJM3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736164658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjd4v5jBzzQ5xGcj0DxHwQvDcprK+i5SjBDg4phMcHE=;
	b=FSDnJM3T9flR8xZ93hu70tm6IhBpRDV79Cp41PUfU0P+9gJGYsSwmyE4Y4A1rGGg+MJyrZ
	WdSlJa5lXYz8kfMe+RQrIXJILbfqwp1A6QpFz/frV9c09BfzOg4NwLk5Et8w4A5wlX6loy
	4/GBxSwfK8CjJ7L4dIvo8PbnIagVRxw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-_z3nKWK2O1G4sd3MkjdeeQ-1; Mon, 06 Jan 2025 06:57:36 -0500
X-MC-Unique: _z3nKWK2O1G4sd3MkjdeeQ-1
X-Mimecast-MFC-AGG-ID: _z3nKWK2O1G4sd3MkjdeeQ
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71e1aa14f64so4794251a34.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 03:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736164656; x=1736769456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjd4v5jBzzQ5xGcj0DxHwQvDcprK+i5SjBDg4phMcHE=;
        b=lSDABz2YXFyJnY50IgbK2J29xHRlyjG8KDSSbbFvnlOj1VyYwSk4W0U9gyvj1wZs1W
         mv4Bzby3BzoirQdpi6dp7KGsUaq69eXHenpxujsFp06ITcfJO9KAtHZ6PCETYfySM/Xz
         AQBVN4wPSkCsHU2pG9MwbW1S10HfZCEsTdl55TvOuT/7OWyGYNtKzBcNJifp2yo4c5P7
         1dVfyp6Eok5LwelThQN6g6GCUKCIrHLA6dvQohkzdLkuSLapd9wTfdVewaSTk3mTYPdM
         0ZHI2h+Kry9FEPuAy6HZvpAxKPp+dYctqvbbGDCDPvx+3gNtisAPf92gSVgp9yvg5n7E
         2Yng==
X-Forwarded-Encrypted: i=1; AJvYcCW7qTOpkPmFanFGnLLFNugOkLgBRJY2zEBTnkm7AScQWfsqr/uidSfwHoc+00k7ZnokyQQq5qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/dk3S7os2NrwEKKGX5tCA1SGFuV0t+ZqDdJcYy6fv7EM3uVMr
	BN2OFM47zxkdNaA/0w4WLTt+65ZRnIJz48R7u3ymMgF3u9uCiRjWIiS6ncY0meC+FoGk2/Vz+/E
	E3yLb19CgW+JXY1E6oubDLxjzkn5yhFwdES1nSjzPYfUM0BRmNxbFSU9FhvdI3E1pXukQ8QX0xK
	3Umd+McXXgcOXA+lD6M0nODzPecjrq
X-Gm-Gg: ASbGncv/wR1ElGuVWaM+P/gMutfYcZOfx3mRz/W8o/uBL6AQNWtkOXievvf5gNrvGZ7
	rLNfu8iNdi+mD3m1+h+qM5IlYsjtc/sB4hdC1jA==
X-Received: by 2002:a05:6830:6e17:b0:716:a95d:9ef with SMTP id 46e09a7af769-720ff6ab504mr42189118a34.2.1736164656084;
        Mon, 06 Jan 2025 03:57:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESLkcL9OsNaaOZKCPT4x2oLZP7s/kiwoLATbvj1WDB2CGIxsZWpSmUPcz2hRteTFGh7BFbIkPbE7BIlzFOxoU=
X-Received: by 2002:a05:6830:6e17:b0:716:a95d:9ef with SMTP id
 46e09a7af769-720ff6ab504mr42189110a34.2.1736164655832; Mon, 06 Jan 2025
 03:57:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734345017.git.jstancek@redhat.com> <2a9b6d5a782acfa71ae5fb2f4d3cc538740013b6.1734345017.git.jstancek@redhat.com>
 <m2ed2791me.fsf@gmail.com>
In-Reply-To: <m2ed2791me.fsf@gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 6 Jan 2025 12:57:20 +0100
Message-ID: <CAASaF6yj_E1CTi8SjUa_nBxBiWS0cH+hPCPDYoRFu8wE-eefNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] tools: ynl: add initial pyproject.toml for packaging
To: Donald Hunter <donald.hunter@gmail.com>
Cc: stfomichev@gmail.com, kuba@kernel.org, jdamato@fastly.com, 
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:10=E2=80=AFPM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Jan Stancek <jstancek@redhat.com> writes:
>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
> nit: missing patch description
>
> > ---
> >  tools/net/ynl/pyproject.toml | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 tools/net/ynl/pyproject.toml
> >
> > diff --git a/tools/net/ynl/pyproject.toml b/tools/net/ynl/pyproject.tom=
l
> > new file mode 100644
> > index 000000000000..677ea8f4c185
> > --- /dev/null
> > +++ b/tools/net/ynl/pyproject.toml
> > @@ -0,0 +1,26 @@
> > +[build-system]
> > +requires =3D ["setuptools>=3D61.0"]
> > +build-backend =3D "setuptools.build_meta"
> > +
> > +[project]
> > +name =3D "pyynl"
> > +authors =3D [
> > +    {name =3D "Donald Hunter", email =3D "donald.hunter@gmail.com"},
> > +    {name =3D "Jakub Kicinski", email =3D "kuba@kernel.org"},
> > +]
> > +description =3D "yaml netlink (ynl)"
> > +version =3D "0.0.1"
> > +requires-python =3D ">=3D3.9"
> > +dependencies =3D [
> > +    "pyyaml=3D=3D6.*",
> > +    "jsonschema=3D=3D4.*"
> > +]
> > +
> > +[tool.setuptools.packages.find]
> > +include =3D ["pyynl", "pyynl.lib"]
> > +
> > +[project.scripts]
> > +ynl =3D "pyynl.cli:main"
> > +ynl-ethtool =3D "pyynl.ethtool:main"
> > +ynl-gen-c =3D "pyynl.ynl_gen_c:main"
> > +ynl-gen-rst =3D "pyynl.ynl_gen_rst:main"
>
> I'm not sure if we want to install ynl-gen-c or ynl-gen-rst since they
> are for in-tree use.
>
> Thoughts?

I haven't seen any downside and thought it might be useful for somebody,
but I'm happy to drop it.


