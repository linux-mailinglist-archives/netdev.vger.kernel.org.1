Return-Path: <netdev+bounces-198507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA83ADC75D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8B418839EC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76132C08D0;
	Tue, 17 Jun 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VtgTVgEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4E294A0C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154458; cv=none; b=KJLjb9cnltKTgwkm6zO0Z2uGxeWVs5/W695UWcPu8wmsM4Rjr3Mp1HH4Mz0OW9eoOdhVmCGgVhZrcHAB+lmrzHzPhFynz90dOgmYZGrT+wAeuxHu6MyUoRH3CTYpOUQO5tfAadRyeDJZ2aDCwhAxsKOMuWkiOshS2ZttvkSNrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154458; c=relaxed/simple;
	bh=63f0TqEe7ZSJlAEEDh5c6QP7qrLi0rXRzYggtZFz3+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8upXwt0JuAnif96X4guIddh7LFw7DEG0zwrbrxeMyoRP8zWObfSeJivbrRsVCOCYtx38o1mHjuNfXH5A3eIh/j3fSu4ikS8r2hRPdbTZOn6PkbP7cGpJ/hEaWNjd6Kip/IHsScEbWKoCyFlKZobmaft6A0TiJceCzTRTUKWLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VtgTVgEO; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-45347d6cba3so5806855e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750154455; x=1750759255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63f0TqEe7ZSJlAEEDh5c6QP7qrLi0rXRzYggtZFz3+4=;
        b=VtgTVgEOKtrCkqMX4unbbSIrCU3tRWd9VRML+CeTM68VOv88gNhJWuZyGajcecdP0O
         0/bY5iuY1IIQQG5tFi2LHNRh/5/JLztDNAdK8S8XyfAHD/WXkPgfgD1kQ9koR243msbM
         0F/aNKyTokJmbblE+CDTCluN/IadEGieSO3ws805DcT7TQu6V8lD+/va+AzIM342/HqD
         akpEjYm00QtlpfJBzpWIF4XccQkq5ELeo8Le8DT5MycagWkrRrlV5tBoU9zQ8cC0b4we
         d1tEsS14ibTIfOYAYLzUMn8NfOhPXOEMh1Aze1XvAZzjlqfM9rDJhx35B3Hhs6VuVDK+
         v9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750154455; x=1750759255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63f0TqEe7ZSJlAEEDh5c6QP7qrLi0rXRzYggtZFz3+4=;
        b=ePgyiBCpMnXYp5SJ8ZjUFfRleE8dVyJoMH/n7VrqwBt3Qra7YhrZzy1q2/q/9/BCv9
         WMfKn20Tv4xDgA/h2OLyO/i1n06lNiMN0S6WZQyOdadJUfEHRm5VgK3XUhJplPuve7dv
         2211oIIaaLNPhSL83tG6EgdZhdtUX65vjKlwHOO8+SLvVnhrzipm3Ew5yN9U9XcjSc52
         xx19NcQl0mSlW6GkAXOPTknoiCn4MoZyIl88z9qdw9uix9e0n4TR4ujFMpQtQcQWfIlN
         Zehuj8B/rgfeXO4muVoyjhVOaZrOJ7gmyv0bDy1yvqis7VGzr0de4sGLhLPJMcLrah4T
         4VNg==
X-Forwarded-Encrypted: i=1; AJvYcCW5nZ1yWtCzPTnlsZVTyyp9C+OlvT+zhxygEPm6KdJX9HyznbqlJMI5sup+pu96NsyrdbU7vD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mgcWHgHczrOhzKZmFFHPoDTjT/nlVE9aL4/i3vW75K5+sABY
	YdgWlro3nRDjrZCClvo7TGqnE65ZHf6iiiRhXxPn+7XCPywOOJZ8aTDz0P+2fRJrvvk=
X-Gm-Gg: ASbGncs3qCdoL41V0zpcd7OMKjKWsabT9TEjncbNVNOwY9jAEb9pGIFJKrlX/l6MzCE
	0Xy+9WQ9VljktFIZBb27kytOAmmDqDlLATvDdhz8pFpJxQkr2s3TFTeqtIEj1X397pGE7y7u83r
	BhYa84jcAsIIbGU3QqEPEyz64rh3M5lFkBCIgOVFqf4pFbOKyhcngkhNjOgDi52p+264XKWklVC
	/ArmHFrpFYyGScACe3YPjrfDrafYonXXrGGIroQEMnBGVwa4RtQYAmbMj036ZOi71bJUEh9zqKe
	QKaPCXXkV37RyfhwuQZczmezvjiwndhgs2vJarFffW0rslZX20BE/phYwp8sdN8+
X-Google-Smtp-Source: AGHT+IFOY4uMo1XQEX4RuwIHAMfgibmwRB22iBO5mpSJQ1+dfkCUk/eEmOPDTUbzxCn/VYVxqmedIA==
X-Received: by 2002:a05:600d:10f:b0:452:fdfa:3b3b with SMTP id 5b1f17b1804b1-4533cadf885mr65921715e9.5.1750154454019;
        Tue, 17 Jun 2025 03:00:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e195768sm171790845e9.0.2025.06.17.03.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 03:00:53 -0700 (PDT)
Date: Tue, 17 Jun 2025 12:00:51 +0200
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
Message-ID: <qzzfped7jds7kcr466zahbrcw2eg5n6ke7drzxm6btexv36ca2@mici3xiuajuz>
References: <6751e769.050a0220.b4160.01df.GAE@google.com>
 <683c7dee.a00a0220.d8eae.0032.GAE@google.com>
 <p32ytuin2hmxacacroykhtfxf6l5l7sji33dt4xknnojqm4xh2@hrldb5d6fgfj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="krlwbo2bq63d5qwa"
Content-Disposition: inline
In-Reply-To: <p32ytuin2hmxacacroykhtfxf6l5l7sji33dt4xknnojqm4xh2@hrldb5d6fgfj>


--krlwbo2bq63d5qwa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] general protection fault in
 __cgroup_rstat_lock
MIME-Version: 1.0

On Mon, Jun 02, 2025 at 04:15:56PM +0200, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> I'd say this might be relevant (although I don't see the possibly
> incorrect error handlnig path) but it doesn't mean this commit fixes it,
> it'd rather require the reproducer to adjust the N on this path.

Hm, possibly syzbot caught up here [1]:

-mkdir(&(0x7f0000000000)=3D'./cgroup/file0\x00', 0xd0939199c36b4d28) (fail_=
nth: 8)
+mkdirat$cgroup_root(0xffffffffffffff9c, &(0x7f00000005c0)=3D'./cgroup.net/=
syz0\x00', 0x1ff) (fail_nth: 23)

So there's something fishy in the error handling.

HTH,
Michal

[1] https://lore.kernel.org/lkml/68403875.a00a0220.d4325.000a.GAE@google.co=
m/

--krlwbo2bq63d5qwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFE80QAKCRB+PQLnlNv4
CFc5AQDFUQDIxN7rZwIY/4HwJm40c4uz7Kwbk8e3RX9sQwVOOQEA0j9JsDa/0bOB
mCi/pTl0V4lRqubAZXTV4nhvtAtknwY=
=+ozi
-----END PGP SIGNATURE-----

--krlwbo2bq63d5qwa--

