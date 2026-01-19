Return-Path: <netdev+bounces-251215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B504BD3B533
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1FE302BF50
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5D3596E9;
	Mon, 19 Jan 2026 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEGjmnTm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6A32B983
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846106; cv=pass; b=teZmNF96w8/JlGoXZBpUSxjTx8yiytI43j1oHsaDA7hKiECuSU/MDI4qYfPVOUA17UJCdTvqsPPEPhBl3Ax7IxPqCy3BqpVsABE7cVB/GXnt9IMGiVXCiQkQKkakwfmnyj48mvtoGwW4FtSd5C/y31UG0c0V6AtAMT5jSbmO6Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846106; c=relaxed/simple;
	bh=q8D+nrqZsm9DrZObP52Gb97lohlLVUehKhiIohn1eHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kz0aFN8AuoUOXLK21ogu9NQxEH1fouOh4VV4LTTJrCIJfL9nH6w96fvCprrzS9FdGtMTNfPQypv01O8CCgC7JJzGvtAXjEPD3pjpgrfZ7CUZ4oXCy1Xto4+DitHKnKEUdjRhYyaiF5tvIKQdxj2CHvo1AHbX/bnhzDv7VEH1VJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEGjmnTm; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7cfd57f0bf7so2796350a34.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:08:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768846104; cv=none;
        d=google.com; s=arc-20240605;
        b=WfFcABwTe/xkNkLkLoDunE9TxdApaFmCSgjEg8r2Ya8MDmqHKBMk5mOaZjWdkStlyV
         NHL9wu/n0duYL14LqpDnG2Rc2ak3rXJGEmMU/DoxK6i/q1lxf46yOtzMka89v8lX1Srx
         Rr10KpXqWzgwrTHNFQKTED7OToqLzktLz3Ta4UVbk5iwJLPBesQrOyIrGc0PYdlWgrUI
         2fKRmGfbM62vpdz8Bs3yWKsJ+wJBCvOcde0V2cXGZImeaAl8l51L7tHHvp2p4a3GUG5e
         6N8bFQrsuC9VK/smogzPJ8ekEui15a/G7DkOyFAi5vOvR9qg7U7e737lPg1SeEaQjYAg
         n5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q8D+nrqZsm9DrZObP52Gb97lohlLVUehKhiIohn1eHw=;
        fh=mv0rTvu+/ERbYeNQs4ZC59kt4rSjFPg+30num9k32WQ=;
        b=L4h0fJYWcJ7LjQQKYr/7L5NzOvgxUqgoA3nRY82EZkN9ShDHmuHMRXoor34nxrEWbx
         HdEZsgEegprcrjZk9P6qYlW4P/lh4ejxsh2pr8YhqMXKMs0zBjydMEBb8Sl+cXYE8uyL
         gjSxJnPY47gvefnEAdcYUbCUzfrVRhfTQUtwHsu1HIaA1EzBFtvigE27aavjTdyNTyZd
         hleW8ZWmeKrxpVnT6SURpnw0UNj+uNIf7rQn9qk/CeIfyrswhR9v3MWoUAcjNlsW2fNZ
         i5ogEzpKjQrgTNkG0qiUUJDR28y4i4kTxuJU04l/cYrDg1ZLDzeovcbFTrHLjBVjIDH2
         cOSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768846104; x=1769450904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8D+nrqZsm9DrZObP52Gb97lohlLVUehKhiIohn1eHw=;
        b=kEGjmnTmuNpGhdPt/vxY78CVQ+d7dd2sV3sx/7HC2TK8RgH55BhX+PqQAbV7jp8vap
         AilJvVKj1ie1iMKKuqohKRvDMC6AHd9PFmmWDGnLAdtG0yTWaA8XW1DbvMaqxCgixvj1
         ClM/YCQqeygCylartdPBJJwUW+J06tgJ/QQ5GNi4bQ7ms2Z3CIk/xNGoUFdEAyE2WsFh
         htknkFqD6RtYooJs9BVxTl8jenEgD606dXBtGvcROsmuRwm4U/vx1vewTADVgR3pkTTG
         zFMcOZtfgO7PBbrL15iS0vXC/Z22WFDJRrgVtN+nPiF78bqz3DOlW0xp1P50YuIACZ0I
         ZIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768846104; x=1769450904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q8D+nrqZsm9DrZObP52Gb97lohlLVUehKhiIohn1eHw=;
        b=Tt4uRPvfJQntBOe0jw9Ci9sm1HZpBTCMHmAwQBFq2KMbqyguMkYAka8p647I1LINpE
         JwoSFMDa8VQNovn/I168+HAL59+V2LQngY5auJUoFNKDkPmxsJw5kmYf2fi0wncm9JgC
         suFLa3OhLD0EcC5LriejUu5bA7Rz5KWEEPh2yev2A07ylNzXxPPFiAJI3QJnJk/qAbiO
         fGESA+7c7dqVCHMy9lG6Un31NdNMnq4UN0W6SzDmtGRNO6nRQhblwFNvpWMbk8j4TXTJ
         vm+1NyEwdrrqzxV7t+rYBCAF1OKt7j70ZltkAy5Xax7cPNXKrYgMIWcYc9rW0VCXYVKG
         +S2g==
X-Gm-Message-State: AOJu0YwiVPjPCkwvB1up04C+xbuRlEsHRWL0n7moD9eJFux1JTTh74ob
	y0OS1COIK1UuLFdSXWZ+NKvBj1tygi832t+tbPQnEtJneP1angxXMpd4oPZMVeJZhr+szyuPnBg
	m0HJDvKIkm8Q01M2cx0dY1mbX4HO2ehc=
X-Gm-Gg: AY/fxX6KAqjX8azdMLzoLvtYpfOZGHCLPRBFMT78wBX0wE3CulbAMZOD7fUD/YUTrn4
	Zx4q8J8li+80VjPmf6fsAJQ+pgAhrI9585yDnXiyAAOZt4rt5ZKazl7YtRyM2TxLe5kH7HLPfTT
	Vg50W2ZMyKzv6sw1HlaE6ntlrT5kYNSQ5K6SvMrheDVER3DH4vjAYjb2zMWZ5gI+S0qsHUeyeg3
	4nsBSu/KT2sMSxfpTJrAzw8cMnXkORfTuohPmVv90h172xqIOX5JaPUeIHwZEdnty1WsIW7iACP
	UOi9RYEyMrtCy0aK4djuIlawTmz7jtQojbOIpvfsekRLIZAuppZ+k2AbXIK7
X-Received: by 2002:a05:6820:1787:b0:65f:64f5:5b79 with SMTP id
 006d021491bc7-6611793d4bcmr5481444eaf.16.1768846104301; Mon, 19 Jan 2026
 10:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119162720.1463859-1-mmyangfl@gmail.com> <CANn89iLuo+A3M0BSXKJwwsd4T+crXe8u0KiAns7=ks1TXnWaeQ@mail.gmail.com>
In-Reply-To: <CANn89iLuo+A3M0BSXKJwwsd4T+crXe8u0KiAns7=ks1TXnWaeQ@mail.gmail.com>
From: Yangfl <mmyangfl@gmail.com>
Date: Tue, 20 Jan 2026 02:07:48 +0800
X-Gm-Features: AZwV_QgYa-0zOYsjzwo8YEi6ZVG9_cSElG1hlh5M9B3SsCMIK1usQ7MzaKlTl6c
Message-ID: <CAAXyoMMbfUL78oq3MOk0G0sjgA6jSXHYz2m6SbXqk-cpB+P4ig@mail.gmail.com>
Subject: Re: [PATCH net] idpf: Fix data race in idpf_net_dim
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>, Phani Burra <phani.r.burra@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Alan Brady <alan.brady@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 1:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jan 19, 2026 at 5:28=E2=80=AFPM David Yang <mmyangfl@gmail.com> w=
rote:
> >
> > In idpf_net_dim(), some statistics protected by u64_stats_sync, are rea=
d
> > and accumulated in ignorance of possible u64_stats_fetch_retry() events=
.
> > The correct way to copy statistics is already illustrated by
> > idpf_add_queue_stats(). Fix this by reading them into temporary variabl=
es
> > first.
> >
> > Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> > Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> It seems ovs_vport_get_upcall_stats() has a similar bug, are you
> interested to fix it as well ?
>
> Thanks !

Sure, I'll take a look at it.

