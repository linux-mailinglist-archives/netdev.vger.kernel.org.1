Return-Path: <netdev+bounces-168045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE7A3D2E9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F8818937D3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C21E9B31;
	Thu, 20 Feb 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxpIs/rn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D511E9B2A
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039289; cv=none; b=Z347dSO/QVNMBJJA1+A2wdi1Vp0oX/d/lXB23yqzlRYZNSsVdG+ntzZSRxyHXBj2tKbO53eYMXBvlvi2Pt8USoqRenc/S0uRVF3bwj0XPAJvCVcz1PvRYJ+iOZN/jFplWuwdq9Y+UkC1J3LVGjCz17lIuslJr9BtSZBQ+i3caDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039289; c=relaxed/simple;
	bh=XUvPfnQzE7lfY5mPUyEfWJL2c1rZL5vq75arq0rqCc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeFbktOkQox47aQuPTNGY9F1c7+qY527j3GLLnSOBYqi7K3ju7g+h7MeQ1KiEabXbhdof7DA1qglBN8P1BdxJx6rCpcVeAenPaJfEadpsegZ4ttYLRkSw0SKVZIxLkw2An03/PdABtQBPkt0Xgg6o47ZhkrnjLhVy3Y7jv0Q2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxpIs/rn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740039286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUvPfnQzE7lfY5mPUyEfWJL2c1rZL5vq75arq0rqCc8=;
	b=KxpIs/rnKmXUlz6NZ0UOy+npDHjVktvwTmFFRnFEnqwpQcSoaynKR9kray6hVRcpLkScAg
	GktcbVHF1haHnAiM1G8mBH6Ppzx98ZOEzgHmoLq/Sq4SIqh4BrBcHPHPUbDsRCB6Y/8MeE
	QIROg4xbO7sQqUi7C/nLGpX4mYWIQwk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-UltbCurTNwiydWPVy_n7cg-1; Thu, 20 Feb 2025 03:14:44 -0500
X-MC-Unique: UltbCurTNwiydWPVy_n7cg-1
X-Mimecast-MFC-AGG-ID: UltbCurTNwiydWPVy_n7cg_1740039284
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e65a429164so14977546d6.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 00:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039284; x=1740644084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUvPfnQzE7lfY5mPUyEfWJL2c1rZL5vq75arq0rqCc8=;
        b=cEzwOgA/+XshOJiyKcsNJvkSIAThI46Rf5j1R3qfB9dqj2XiJJj3IYCZ9umJ51HqoI
         vOqR3oV2XC5AMtWx+VE2UVWOE369WaBbjWA/EyzuSnhrHzHKljO6d1fLvQflQn8cv130
         LcCH8vUvQEZrG6SjR7FRdzmoAscLYmDKt2a16AcvOLKWSWEAwfuzJsa4ByoASREYErdy
         Z+ZjuSbBi+LFHqBS5h4/Iw2tJtkfb7//QDtPMvu8Q+zpz/0EyEePY8XrcitPcnYyNKGn
         ygJxJdJuOW9ein3tqPlzEJgils25O2/uIT/wGdThfpYWJLpttoWBSOdm9QcvSLxwsvoL
         kG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyiOl39o+udly0lC8otxfVdkJIhzBP04cwY3AymRtzzh+ppNv9WlgiEGwiU18T9GZAQ354kAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5l5EPjvJEPVjZPC2PTWEBKNxaYSyCtLumPE1GgwIctHQvYG1
	tF/qZuS9+gCEcfa0PTbXr6XV943iHOklbCtrSV8sNbifX81C/MeOswIfPwnRhGpYjxC3anwsdsW
	tdgmvOM2NEaFYpKAYBfqVqgdwZO/D+T9PP3fElQjskLYCPx8VieIDB29E0IQqpMr+BxVy4fyA0J
	GgmeysPmjzfMWMFYx8RRlCKp853uJw
X-Gm-Gg: ASbGncvUvbc5uVb9xQgh1UPBYynGQXWM1ihPJR7rBnd8SlQmLX0z5gfD9LtT6GWaf44
	shbAVoNDISOnGtbbSmTReIgJ7uoBXdfw3VnDN2ZY96jpD5kZaPhrendFinBrv5lY=
X-Received: by 2002:ad4:576b:0:b0:6d8:d84d:d938 with SMTP id 6a1803df08f44-6e66ccf044cmr321011846d6.28.1740039283823;
        Thu, 20 Feb 2025 00:14:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtlPzw//q1hAwa2ePYztZsTCOpeskyG9v95G2Qts48RCBK8DZcFPadLubWbNjT1kvqJhdsEToBx472mGP79nI=
X-Received: by 2002:ad4:576b:0:b0:6d8:d84d:d938 with SMTP id
 6a1803df08f44-6e66ccf044cmr321011706d6.28.1740039283524; Thu, 20 Feb 2025
 00:14:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87mserpcl6.fsf@toke.dk> <Z6yWa3ADgWmu+2TE@boxer> <87h64zpb5y.fsf@toke.dk>
In-Reply-To: <87h64zpb5y.fsf@toke.dk>
From: Samuel Dobron <sdobron@redhat.com>
Date: Thu, 20 Feb 2025 09:14:32 +0100
X-Gm-Features: AWEUYZm6qG-NEpMn7AVT-IN6n3WzJafLvL9EWsupwhFO4ww8G3ugL1W-uUwCaaM
Message-ID: <CA+h3auMzvFk6bA2AjFsz-+rmNuuLeULJYEK_PuiP_6tQAGCxRQ@mail.gmail.com>
Subject: Re: [ixgbe] Crash when running an XDP program
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Chandan Kumar Rout <chandanx.rout@intel.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

Thanks for cooperation. The issue seems to be fixed in
kernel-6.14.0-0.rc3.29.eln146.

Sam.

On Wed, Feb 12, 2025 at 2:04=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>
> > On Wed, Feb 12, 2025 at 01:33:09PM +0100, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
> >> Hi folks,
> >>
> >> Our LNST testing team uncovered a crash in ixgbe when running an XDP
> >> program, see this report:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D2343204
> >>
> >> From looking at the code, it seems to me that the culprit is this comm=
it:
> >>
> >> c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
> >>
> >> after that commit, the IS_ERR(skb) check in ixgbe_put_rx_buffer() no
> >> longer triggers, and that function tries to dereference a NULL skb
> >> pointer after an XDP program dropped the frame.
> >>
> >> Could you please fix this?
> >
> > Hi Toke,
> >
> > https://lore.kernel.org/netdev/20250211214343.4092496-5-anthony.l.nguye=
n@intel.com/
> >
> > can you see if this fixes it?
>
> Ah! I went looking in the -net and -net-next git trees to see if you'd
> already fixed this, but didn't check the list. Thanks for the pointer,
> will see if we can get this tested.
>
> > Validation in our company has always been a mystery to me, sorry for th=
is
> > inconvenience and that we were bad at reviewing :<
>
> No worries, bugs happen; thankfully we caught it early. Also mostly
> meant it as a nudge to try to give XDP testing a more prominent spot :)
>
> -Toke
>


