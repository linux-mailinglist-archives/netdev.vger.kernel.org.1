Return-Path: <netdev+bounces-69547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F684BA0C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B9828C72F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FED1339A9;
	Tue,  6 Feb 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHdJ1mvK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C01339AB
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234418; cv=none; b=IBqB8YijkXPXvjDPa1GXNwuWTt9BiOvlvyUfPQOgNG2UHjW4aQNKzd15zQziDl81153q04om/aQ9KNnLJJD1C3q/jzcd0DvOWddsBB4Z/JoRObp85fkperH+1DPbZ74N9is5xk2cNTySBW2lOTV4DFbt05xokVh8zwDomhJmQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234418; c=relaxed/simple;
	bh=954e3Ix2bJjwx9egznKO54Ugb0NxCMf+SU0HQAbW2Ak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amfZG88xZWHv0ONYhmI0+4xTUU1lN56g9y7qsE4Hz8ggcK6wEqV67VEUEBTof1bvpPm5zmaTvqr2fatk9kWdsOw1HLCh7AL0hUssQO9S91yCgLE/rqxP7vytaXn+g//wkr5MRAfx+W7KwxKi51Ftwa/8Ky5NlOfk2fXHjWPDczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHdJ1mvK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707234415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RG3/UKCCHade2ppkekYGF+HmNq9N7uNePqI8BXsMibg=;
	b=cHdJ1mvKKw7aFJS7Ju55VnH0KJ1o0Qj4Z7ONBdWh8F55Mt2FlSMCjKuGBis0QfYVr5eAYP
	d4nPUga0C17ZFByd2e7nDRO5zjpy122kjn7/U/1YQ8FFltoudfffSXpjkU4Y1ZEnNB1YDm
	6NSDevd/KX1hWDHPeFwl/Gn8xct3pX4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-WrXpwPY9PcaBjOnfS4US7w-1; Tue, 06 Feb 2024 10:46:53 -0500
X-MC-Unique: WrXpwPY9PcaBjOnfS4US7w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so13356465e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 07:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707234412; x=1707839212;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RG3/UKCCHade2ppkekYGF+HmNq9N7uNePqI8BXsMibg=;
        b=xKU+TdF00X0Gt7CQ4f8jOJf9d9Aq74V8xLHkQgsUQcx1e8cdce5qAyjasTvxH17ev7
         fr2ETKsOlYSyBubczUF0c3dNb37xHd3G0y3jPHaR/Hyw+oKspQ785lSEJNkZt1Fl+Qzj
         D6Pzw9/E0x3VUc936FwWTz6goJVurbL7RdVcdzZMZLBjowPsptdGiFSF2bYLjo3gvwgB
         /mDElbfmdoRzg52TXLK7rK7a96ToPTsDMVlfO6sRbFg9XnSLBiWWscWRT0/3qF/jRXg0
         EfM6CR8Eml01rpBTY7sd80wXxAcCGAyMdfODSwdr6JpTHN002CDBN1FH/c12OTRn48UG
         /3FA==
X-Forwarded-Encrypted: i=1; AJvYcCUB8HSiAhEa8ZjQ45S5akGwZjgCODgtAy0f8S9XucDT/ci6goq4h2Ed9tnbWP34ISxz8Mj8pWhOire46D5Txof0LGfgnbTB
X-Gm-Message-State: AOJu0YxZljyK72AcVGUgGNlUs1sx5m9kUcWQqx5kTdO/blBb+BDDF/2i
	nadnTwP1HN2LfL8d+Pm8lnbJyrYdq6TkQZAnLnsykMhvyGlohG8OusWUpLaCz65Acm4GZiG54S9
	RvsP/Y7iDraCxh6AFn7HExIX8Mf5o6+Or6BYrT/c1FIamBfjz5ktuuw==
X-Received: by 2002:a05:600c:4f54:b0:40f:db10:5f14 with SMTP id m20-20020a05600c4f5400b0040fdb105f14mr2403516wmq.1.1707234412638;
        Tue, 06 Feb 2024 07:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEITVhzefsqrdtnxTskgmDgSDWEnq2K7bEfxcrzCc13xm7lYnzDhneOwJgB2VlO8nq0dte7fw==
X-Received: by 2002:a05:600c:4f54:b0:40f:db10:5f14 with SMTP id m20-20020a05600c4f5400b0040fdb105f14mr2403497wmq.1.1707234412207;
        Tue, 06 Feb 2024 07:46:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnVu+AB/zm07rLgZYpibnwCW7WQJGeU/AyL+y8x+ugkKHMrqUcFgDIwEhb1QrRHQxLHKJqNGXTCzpfA5DpgzfhXBPTkUOnlMTbw3RF4Bf8a9SVyLSk2yttSfR8cpfQOrDFP2Ae7TJO55jgSwNMZHlbc1LFtFVidEo=
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c4e0d00b0040ff1abf708sm971882wmq.18.2024.02.06.07.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:46:51 -0800 (PST)
Message-ID: <0a94e0e2579028761fd1829ed5ad7e9daa87d9db.camel@redhat.com>
Subject: Re: pull request: bluetooth 2024-02-02
From: Paolo Abeni <pabeni@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Tue, 06 Feb 2024 16:46:50 +0100
In-Reply-To: <CABBYNZL4vUMUgHGd_TFWTwKtZzsBRazg_NVnVcqzgJpgybZPMA@mail.gmail.com>
References: <20240202213846.1775983-1-luiz.dentz@gmail.com>
	 <f40ce06c7884fca805817f9e90aeef205ce9c899.camel@redhat.com>
	 <CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com>
	 <69c9e55b40ff2151ed456d975755d9d4e359adf0.camel@redhat.com>
	 <CABBYNZL4vUMUgHGd_TFWTwKtZzsBRazg_NVnVcqzgJpgybZPMA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 10:32 -0500, Luiz Augusto von Dentz wrote:
> Hi Paolo,
>=20
> On Tue, Feb 6, 2024 at 10:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Tue, 2024-02-06 at 09:45 -0500, Luiz Augusto von Dentz wrote:
> > > On Tue, Feb 6, 2024 at 9:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > > > On Fri, 2024-02-02 at 16:38 -0500, Luiz Augusto von Dentz wrote:
> > > > > The following changes since commit ba5e1272142d051dcc57ca1d3225ad=
8a089f9858:
> > > > >=20
> > > > >   netdevsim: avoid potential loop in nsim_dev_trap_report_work() =
(2024-02-02 11:00:38 -0800)
> > > > >=20
> > > > > are available in the Git repository at:
> > > > >=20
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git tags/for-net-2024-02-02
> > > > >=20
> > > > > for you to fetch changes up to 96d874780bf5b6352e45b4c07c247e37d5=
0263c3:
> > > > >=20
> > > > >   Bluetooth: qca: Fix triggering coredump implementation (2024-02=
-02 16:13:56 -0500)
> > > > >=20
> > > > > ----------------------------------------------------------------
> > > > > bluetooth pull request for net:
> > > >=20
> > > > A couple of commits have some issue in the tag area (spaces between
> > > > Fixes and other tag):
> > > > >=20
> > > > >  - btintel: Fix null ptr deref in btintel_read_version
> > > > >  - mgmt: Fix limited discoverable off timeout
> > > > >  - hci_qca: Set BDA quirk bit if fwnode exists in DT
> > > >=20
> > > > this one ^^^
> > > >=20
> > > > >  - hci_bcm4377: do not mark valid bd_addr as invalid
> > > > >  - hci_sync: Check the correct flag before starting a scan
> > > > >  - Enforce validation on max value of connection interval
> > > >=20
> > > > and this one ^^^
> > >=20
> > > Ok, do you use any tools to capture these? checkpatch at least didn't
> > > capture anything for me.
> >=20
> > We use the nipa tools:
> >=20
> > https://github.com/linux-netdev/nipa
> >=20
> > specifically:
> >=20
> > https://github.com/linux-netdev/nipa/blob/main/tests/patch/verify_fixes=
/verify_fixes.sh
> >=20
> > (it can run standalone)
>=20
> verify_fixes.sh HEAD^..HEAD
> verify_fixes.sh: line 201: $DESC_FD: ambiguous redirect
>=20
> Not really sure where DESC_FD comes from, perhaps it needs to be set
> in the environment, anyway can you send the output it is generating?

I usually do:

export DESC_FD=3D1
verify_fixes.sh HEAD^..HEAD

Cheers,

Paolo


