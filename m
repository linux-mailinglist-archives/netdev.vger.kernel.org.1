Return-Path: <netdev+bounces-150675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216899EB26E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70D21881FB3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993D1BEF81;
	Tue, 10 Dec 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUprwK1z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847311AB523
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838985; cv=none; b=mdSZErPvNmygnYAd+LDIwmDmAgXf3JZ0F3a8P7ECpnJjZ7/l+KlFNKfUUUnHWP0Nrm5tytnR4nt4UHUfPWSSZk50cZT3uOXiHDJD43SsnjDrTo2qTzVSkXwA7uSNAeEHWF9H24pASugZI9EZqliNA3tJrzVdqoM9PUJfb2fSN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838985; c=relaxed/simple;
	bh=r1uDnHbtgZJWUVIR1vTcKu9dipb8j67J8hgLIyCxLBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XRedkWIvE2cxafjr6c+2RY2lH8Bfg1nkKlLlognTjktw+4gh3+357y9n5tEThbeYQELtwiWPLO+IIoBrj1UkeThKJAiDq0vvNN4YMpcyBvhfqpN0WEz728WNrBpWlSCPHR0zimLBednRidMpeeJtj/bbOZS6IF6ZXBpWXhpE+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUprwK1z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733838982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ii60ZcgJ/ZFw2IPUTiPFLc566IQUq/Ff2SMoVtpygM=;
	b=CUprwK1zX3nt3TbjBHD9STv8/pi1Vhp/UBAnAgmQ2V62+yRWIjR02BPOnGR6EN0uaBz988
	1TxWR79TwoWI29YNcj4SPGCvQUIXPAjcNkBV6oFXWwLYc9ZPKDvjAFPxilh41LoBQpG7qA
	50LS2EPuBk0desGn7BsUIC6eoKWKTXk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-UwhWGx2UPSO3eejjegxiZw-1; Tue, 10 Dec 2024 08:56:21 -0500
X-MC-Unique: UwhWGx2UPSO3eejjegxiZw-1
X-Mimecast-MFC-AGG-ID: UwhWGx2UPSO3eejjegxiZw
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-29fb55d5357so1945970fac.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 05:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838981; x=1734443781;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ii60ZcgJ/ZFw2IPUTiPFLc566IQUq/Ff2SMoVtpygM=;
        b=e6rCtXghjehcgRQqgL7WoXZ5/X5Bg2sB0s5kb5gobv9U9GLovw1EwAJxa2TjxUsu0L
         N7Z7HTD8CrT6z2Dxay1Jv17r7I9g735RGdlAuAeRBGW+fGki3ndznqkh1Dh6LCbkU7l5
         IeKTnviA3gsw0fL22675VAxHbcgYPji5O6CkJTiLkP7RBx8BmDiql6AP3p3t/aj8jzv/
         RF8G+lJOAd2hYBOZivdfOhOaPB671HRN1R5aXTEHF7dmyGurPhPeyZUVd7ef44KlqH2d
         jEEH/uDw6x8tCTTNULADmS7Zb3a1q4vE/8DsLIBjmKFP0WU1uGSSxPVJL0psoYfRj0Zr
         NPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmahUrvjl0uXCJXly5xmz2+j/ERscsaSp84BeSu62RZ6ULQKP2lKjR3KkFZ3ljA+lm5YmSQFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnS8GSdcNDY++o1bI5NkfCjYX71UlIVNtVsCoMEjbxoM2g6of
	wZfAUgU2CXwYpHW4LUkIi2rhIgZK9oMg5fsUeUEKzEABiK5ZbUXgRYY/kWCPD47HOnieAvLayDm
	Py50hP4nLzj87/J+5BcPMyBygaauQFPvufvWzM6YH+npo2pN1Y3iCILa8NfcdZsZag7NXOK6V3k
	1j0WJVF+ar0Y0tiT+Muk57L80ZuEWQ
X-Gm-Gg: ASbGncu6os5B0CO/zBUxXtyXN181FgM1KKWFvL8FEY1iNAl8OHjscqyxPx/Repa8qHG
	xTBF2B2qcqLkUnLbKo1APJDaaDJpGBd09Dv8=
X-Received: by 2002:a05:6870:8326:b0:294:cac8:c780 with SMTP id 586e51a60fabf-29fee551e87mr2672028fac.6.1733838980857;
        Tue, 10 Dec 2024 05:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBa8ePqNNQyFs98wreteDhgMQxduKEaaCzy2huGooSIR2R4O+8918jdaAC5YT4jq3YL7dMue774KGx5Y4pz+E=
X-Received: by 2002:a05:6870:8326:b0:294:cac8:c780 with SMTP id
 586e51a60fabf-29fee551e87mr2672011fac.6.1733838980614; Tue, 10 Dec 2024
 05:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733755068.git.jstancek@redhat.com> <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>
 <Z1dhiJpyoXTlw5s9@LQ3V64L9R2>
In-Reply-To: <Z1dhiJpyoXTlw5s9@LQ3V64L9R2>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Dec 2024 14:56:05 +0100
Message-ID: <CAASaF6wVb=c2mYJDqSdjbGD2hQ9CdbxmEKopVoT3Aniy+xRJ+g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] tools: ynl: add main install target
To: Joe Damato <jdamato@fastly.com>, Jan Stancek <jstancek@redhat.com>, donald.hunter@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:30=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Mon, Dec 09, 2024 at 03:47:17PM +0100, Jan Stancek wrote:
> > This will install C library, specs, rsts and pyynl. The initial
> > structure is:
> >
> >       $ mkdir /tmp/myroot
> >       $ make DESTDIR=3D/tmp/myroot install
> >
> >       /usr
> >       /usr/lib64
> >       /usr/lib64/libynl.a
>
> This is super useful thanks for doing this work. I could be missing
> something, but it looks like the install target does not install the
> generated C headers that user code can include at build time.
>
> Am I reading that right? Is that intentional? I was thinking that it
> would be really useful to have the headers installed, too.

It's not intentional, just noone asked for it yet. We can add those.
Would /usr/include/ynl/ work? Or do you/others have a different suggestion?

Regards,
Jan

>
> >       /usr/lib/python3.XX/site-packages/pyynl/*
> >       /usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
> >       /usr/bin
> >       /usr/bin/ynl
> >       /usr/bin/ynl-ethtool
> >       /usr/bin/ynl-gen-c
> >       /usr/bin/ynl-gen-rst
> >       /usr/share
> >       /usr/share/doc
> >       /usr/share/doc/ynl
> >       /usr/share/doc/ynl/*.rst
> >       /usr/share/ynl
> >       /usr/share/ynl/genetlink-c.yaml
> >       /usr/share/ynl/genetlink-legacy.yaml
> >       /usr/share/ynl/genetlink.yaml
> >       /usr/share/ynl/netlink-raw.yaml
> >       /usr/share/ynl/specs
> >       /usr/share/ynl/specs/devlink.yaml
> >       /usr/share/ynl/specs/dpll.yaml
> >       /usr/share/ynl/specs/ethtool.yaml
> >       /usr/share/ynl/specs/fou.yaml
> >       /usr/share/ynl/specs/handshake.yaml
> >       /usr/share/ynl/specs/mptcp_pm.yaml
> >       /usr/share/ynl/specs/netdev.yaml
> >       /usr/share/ynl/specs/net_shaper.yaml
> >       /usr/share/ynl/specs/nfsd.yaml
> >       /usr/share/ynl/specs/nftables.yaml
> >       /usr/share/ynl/specs/nlctrl.yaml
> >       /usr/share/ynl/specs/ovs_datapath.yaml
> >       /usr/share/ynl/specs/ovs_flow.yaml
> >       /usr/share/ynl/specs/ovs_vport.yaml
> >       /usr/share/ynl/specs/rt_addr.yaml
> >       /usr/share/ynl/specs/rt_link.yaml
> >       /usr/share/ynl/specs/rt_neigh.yaml
> >       /usr/share/ynl/specs/rt_route.yaml
> >       /usr/share/ynl/specs/rt_rule.yaml
> >       /usr/share/ynl/specs/tcp_metrics.yaml
> >       /usr/share/ynl/specs/tc.yaml
> >       /usr/share/ynl/specs/team.yaml
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
> [...]
>


