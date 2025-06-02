Return-Path: <netdev+bounces-194611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769AACB266
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C143BE98D
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09971228CB8;
	Mon,  2 Jun 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K4N6Fdfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6E2288EE
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873763; cv=none; b=FE2A1khLEK4nQCBLW5lAsmcm4gc+3fdjo3ZtZ52trd4gxlAeGfPhdMhDELDDfqbof9W02GJHUsLeSkGQqeVe8LgkTfdqblErxaRRA6i3y0WTNzn+O/YZhWTDWf5Of219jNK8mkoAkIVQPPlJQJHR5rdKgk5yr1aUId8zKwIms4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873763; c=relaxed/simple;
	bh=dF5GAuwDgKDUST16OT0UxWR0Azq7MMy0XSykEj/fkT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR5MVuvO58F6ikLOu8MkfICwiQ0AMLHQxKU1LgzOJBiKBLKhLxgQP/HcCSL05k/4nYV4G59pNFIJwJCft0Y2Ho0RJDtXNyLfxX7seBwVEoPbHsmbfWQsB19ZvXd0FheRFYz5rE/wNmFYk1LkowB1OqaHeZgg1tsmRGSmo1t+gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K4N6Fdfh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso29890995e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748873759; x=1749478559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pasRCSC32VgEjcQb416rK5+EN/XRXvQF7vBXVNk/1Wg=;
        b=K4N6Fdfh44MAAVtfDadHVtymwVSqSRQTUlsul/VCRKcKGCLB0vvsfs7GKxRzlBR4j1
         WFJc6/4I2CunWs+BKVvgNRTOW+goTFDQxJPaPdDtiksIOCnZrYuAsKdLT1Bx1laQ2aKC
         rpyFXyKWpynKJm4fQB/7GLIncOoxe6+5+3aHG51Ql1m/MHg5mQqXlCGBPUzGytiL7woV
         XpkKKAWFQTZ8zT7SPqGg/qzIB1WEb+tPQhvFz4wr/wAOsysFnTJ3asbh+bDJlJvS3IXX
         mYrqdH1y1CQS8254J0BmIq9DvF7xONiwI4h4MgVmutVCz01Vt1wKukGRAIpFhhpcdfxt
         co/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748873759; x=1749478559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pasRCSC32VgEjcQb416rK5+EN/XRXvQF7vBXVNk/1Wg=;
        b=hdmHUL9+H8PqfJOPkKx4q60hFRpgLgG8lMjSiyYfGpZlpX0b0FvWvweIhXAGnms32x
         jVzK0vt7TyGH+pP1aV8at8giLAhRGtKDDxms2NndFZ4am2m6NCHwhaR3UGHKJ9r8XzVe
         72CRDQI9svBy0gPDixMhVjRHK8qhF5tzEr7VM6aYD+6/06zF/IljxWNxmYzWEBKMLd3M
         ejD9pcUkKFWwAz3MeuKqdaPS1e/Vt6usUxWyKhkG+vFJL0fjTV3jAIY4W8Dk9/Se05OG
         Sya1dgH8Qea8OWl51FEuEQRBcKuFQlyt8oZziIDSz9v5b5BzeVqRMgbP58Sq/Z8pdNuo
         CLPA==
X-Forwarded-Encrypted: i=1; AJvYcCUBOajIMs/X0PbuAJLCzIOOTw5zhttZ5zXkqtMdCEnuiwTN+Ele+t1hwnNIjcR2GXYNk2e7u2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMnjp5V3QFEIMV723Lmj2K3c9MHRzH1y01e50U8GutwqGYgD3b
	bKvDEiX3IPkIMivolmGTHNPS75FEMYyHBwpJvbtMtNTQYLdwuqGP5xGVCMvW3uD5yh0=
X-Gm-Gg: ASbGncvDYTmmMjRfyDD6mITb8r3Dk4Mv3fvnF29LoBkfV3zSxbeg5tKAfh7zhDkI1AA
	oPYCazLaz19tSF41pcSvc5rB54BrG9z4CoVCOXfV+yt57WK4ZesnVKdndAwyNFdV44o/q2LReo0
	4tythAV0ORKK6GuJhX+HpKI7nBA5EMRr50c6wZCs1M/fGeQsLxOBLjP0/kQPuzXUhuIIpmcT0C6
	Av6saKLSkLmwZPaLIvpM8qj2JDHB55H/tGxL9xm5XXIJ5+6w7jzzdCy/voQNT7rajFKfEzKYx9c
	zUV9c0FGKPe8syDn2ubD5bnqu0z7NkTM08md+2Vab94VoEJMTqKUNQ==
X-Google-Smtp-Source: AGHT+IGeRpd8VDsT9tzxbCNKifu8MjL161GTIQbbUw44DS6V6JSyR7z1tMRcG6paU3cdSynR/larLQ==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3a4f89a7f0bmr10299120f8f.5.1748873759286;
        Mon, 02 Jun 2025 07:15:59 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8f194sm125483535e9.4.2025.06.02.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 07:15:58 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:15:56 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>, 
	inwardvessel@gmail.com
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	axboe@kernel.dk, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, hannes@cmpxchg.org, haoluo@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org, josef@toxicpanda.com, 
	kpsingh@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, mhocko@kernel.org, 
	muchun.song@linux.dev, mykolal@fb.com, netdev@vger.kernel.org, roman.gushchin@linux.dev, 
	sdf@fomichev.me, shakeel.butt@linux.dev, shuah@kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, yonghong.song@linux.dev
Subject: Re: [syzbot] [cgroups?] general protection fault in
 __cgroup_rstat_lock
Message-ID: <p32ytuin2hmxacacroykhtfxf6l5l7sji33dt4xknnojqm4xh2@hrldb5d6fgfj>
References: <6751e769.050a0220.b4160.01df.GAE@google.com>
 <683c7dee.a00a0220.d8eae.0032.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kzcsf5ktx4jfm6ch"
Content-Disposition: inline
In-Reply-To: <683c7dee.a00a0220.d8eae.0032.GAE@google.com>


--kzcsf5ktx4jfm6ch
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] general protection fault in
 __cgroup_rstat_lock
MIME-Version: 1.0

On Sun, Jun 01, 2025 at 09:21:02AM -0700, syzbot <syzbot+31eb4d4e7d9bc1fc13=
12@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>=20
> commit a97915559f5c5ff1972d678b94fd460c72a3b5f2
> Author: JP Kobryn <inwardvessel@gmail.com>
> Date:   Fri Apr 4 01:10:48 2025 +0000
>=20
>     cgroup: change rstat function signatures from cgroup-based to css-bas=
ed

It says: "This non-functional change serves..."

However, it moves the *_rstat_init in cgroup_create() after kernfs dir
creation and given the reproducer has a fault injected:
	mkdir(&(0x7f0000000000)=3D'./cgroup/file0\x00', 0xd0939199c36b4d28) (fail_=
nth: 8)

I'd say this might be relevant (although I don't see the possibly
incorrect error handlnig path) but it doesn't mean this commit fixes it,
it'd rather require the reproducer to adjust the N on this path.

0.02=E2=82=AC,
Michal

--kzcsf5ktx4jfm6ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaD2yGgAKCRAt3Wney77B
SVQoAQDHq+sRBr9VIovCUMvE0lKEciOvnR/BAoR4DPgcg+NOwAD9Fm1hrpnED7c+
obYDZ0tb/tA0+9khXt2TrVelWDcc/Ao=
=n7f7
-----END PGP SIGNATURE-----

--kzcsf5ktx4jfm6ch--

