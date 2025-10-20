Return-Path: <netdev+bounces-230888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54188BF128A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A248C3BA6DA
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F62ED872;
	Mon, 20 Oct 2025 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="SiezfAyv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAEF1D5170
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962959; cv=none; b=lGLEeo08FWHJ+QUQFlMpVomFfwQ4Gkxn4CgviMKN2iMS/4RclzqvocKMkL/pAnc/oqSR9NFvg1Cl3M1Wthmq1oKkuujYPKpFshhU3r1I8iadetWvuXuTKqwNEkIYyqE1SAuUoYWfWaeezmnBzUHGF92RXygE2hp5aLaASw5sylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962959; c=relaxed/simple;
	bh=8ft+jmCQCfZuIzmn67p7V4LMdT5dmLh98yth90IXhuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDceklxdcsfBKaNrsJVsa/uSE6N/j4KCZSwvToBQWqoAUYlMPSqu7BMa2ZfUrgyUN/+ZNPNZH58iPRTpYu7lHoeguAKnc4U+pH2nU4OImTDyNk+oonxEFBpjYdJxOZNrn/sABmbwh1DJ5V2aTlKypge7gj4KVKH76YgHmDXyVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=SiezfAyv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47106fc51faso50904625e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760962956; x=1761567756; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H8tDZLvdGKk81oVa3y58vCqSLtUHc5O4ZhiwAE9zRxg=;
        b=SiezfAyvMkaTs4kv25tsEt3AFOCGemWiVDVu2igGRxDX2wfLVfSEIUAMPdXn9I/XSg
         SLJm4Homi6E7RZmGgz+WM2k00+1DEA2BYJ6cDwUIvEHJ0Bh25DTeEblLc5bq/3+Aq2cl
         CYockWiqU1mJPWkcu4y7ZdTwuZcHa7IQmqf522+hNzo/AMPMXCRVRXukgQ4yVRnEUpsu
         79Im3ptYEs+IvH+Xg0qXnPPjOLRssx0FiIyTdCjs6VQn+AF3gy4n2PjieOOQqBV+JKID
         n5aRXt1h2cZUSeID6OnCTRiypDa4ls4wqki4i9scDVjSUPz+UGU8mvTQtiT34w9c3oNq
         9gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962956; x=1761567756;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8tDZLvdGKk81oVa3y58vCqSLtUHc5O4ZhiwAE9zRxg=;
        b=MQNb07mmp9r729BDMcoeyo3QE26N0V4gaSGFx3EMTPXjEy4BuaV/B7DZmVfZWG3/Y/
         9+Xo42+fiaJ1b1jmYbGVDdEiVVhxiI/UgoaAqoHY9sfCwt8JHBgSxoC4XENgZOCreXqs
         YBXR5p27/sgvpQrB3EnpmoqMSaSJiFXb7O6oTSjQDO86b+xww9X15jTLGdYdD/EGFbxK
         KHDP2o0Q83YILDiygf64l3WljtHDj8Ek7PQ6ZnDH/P69AP/0Zq+OVKLShva8rLEX4W5z
         BSzYqzqNEbetYc/F1RtKRIe+qtqmtnnK815hQnEWDcNNXtGZ04tgJ8YfTrMsa7E10KuI
         CVaQ==
X-Gm-Message-State: AOJu0Yw0VoLzWtjM6G4tznmkx4nC95mJ3V9UBBrOQ2pcIGjqzXKb9Vim
	m9KWXP+JJkX/dICvnU3AGBTSfgsGn7jgz0Jqk8JYtpTCMt1JMOqJz2sp5Rg7X7VxC1A=
X-Gm-Gg: ASbGncs6MuBl0VGTZzjQxxHIN1VQ6E3MO3cnDrYenpLr/eDMRgzhLoQqntpImSg1Qkp
	HOKwF46PrnXyI6SuBFqO+x1Rz9ooLDA4J9KStJgCSI3WH/irTgbjuKcSBvTfMYg2QvSoO4fI1wi
	GybAJekYKqvch+oapc2yk/Dn909apVxpatBwOpk2RPvEkLI2cdLLXR45A65ilRST69WiPsDfPsr
	zIucIy5NpCzqCTFJLt9TUJWVSYyQFyIX45GSvgJLqn8U95/qHNCo3Exhppsv45NSVCrqIlN5lfo
	/HVKChhzDDoYFevevEnRpExJubHss+AMljp4MuXdr75g1YXe3ahH4U6rUT90xAM5Cc2GBkXLgUM
	5Ki9LwDZpPat09Viaz2B2orXASAxgV4bsWRaGQxX5g65w6h5gMlB2K4VMvfsKq/egZZs/qk5ELh
	0lGSsE/bS4bScu3Qs8nu/alXv9IG8+CI6MD9ITlKfBPV+ZdMIJiXnBT0VxBQ==
X-Google-Smtp-Source: AGHT+IHgLzx99J8GWbZRHcjjrd7pNIgygLsBTBU8HAQNM5wwB3D5lZdURdY0QIe+kEM8yPKfRwwMmg==
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:ed86 with SMTP id 5b1f17b1804b1-4711791fbdemr88588945e9.39.1760962955363;
        Mon, 20 Oct 2025 05:22:35 -0700 (PDT)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce56csm14930455f8f.50.2025.10.20.05.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:22:34 -0700 (PDT)
Message-ID: <59cdb31136683ba0163a7499158c4a8090fb4e41.camel@mandelbit.com>
Subject: Re: [PATCH net v2 1/3] net: datagram: introduce datagram_poll_queue
 for custom receive queues
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>, Mina Almasry
 <almasrymina@google.com>, Eric Biggers <ebiggers@google.com>,  Antonio
 Quartulli <antonio@openvpn.net>
Date: Mon, 20 Oct 2025 14:22:34 +0200
In-Reply-To: <aPYMOwuD_PO7Nim_@krikkit>
References: <20251020073731.76589-1-ralf@mandelbit.com>
	 <20251020073731.76589-2-ralf@mandelbit.com> <aPYMOwuD_PO7Nim_@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 12:17 +0200, Sabrina Dubroca wrote:
> LGTM, just a small nit:
>=20
> 2025-10-20, 09:37:29 +0200, Ralf Lici wrote:
> > +/**
> > + *	datagram_poll - generic datagram poll
> > + *	@file: file struct
> > + *	@sock: socket
> > + *	@wait: poll table
> > + *
> > + *	Datagram poll: Again totally generic. This also handles
> > + *	sequenced packet sockets providing the socket receive queue
> > + *	is only ever holding data ready to receive.
> > + *
> > + *	Note: when you *don't* use this routine for this protocol,
> > + *	and you use a different write policy from sock_writeable()
> > + *	then please supply your own write_space callback.
>=20
> Maybe you could document the return value here as well, since you're
> touching this code.

Will do.

--=20
Ralf Lici
Mandelbit Srl

