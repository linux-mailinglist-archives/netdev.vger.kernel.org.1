Return-Path: <netdev+bounces-147491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD2A9D9D87
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD71164C2F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54A1DEFC2;
	Tue, 26 Nov 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3F/ta+NN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C21DEFE1
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646503; cv=none; b=Yp8s7cs4V+7p3RBXNQaRxKaVt32SbabbnH909oGzOuwwnCQoJAMQ99PhbAuByBOC5BOWjX5GW2WEaaud35vJ7lLA6GJehPvWGvfk7Zfj7aMGFiHsVNWFCiQoMSFwu9lOfkxCiIdjf8n7/8Wfvlj7cWoRqpUBrYXF6xL2/I4x0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646503; c=relaxed/simple;
	bh=WZBwx+uuVO2x26etOfo5N73Hj6joBduj2MDGX1arT2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eV/xLVTQszrJtsLIGWzFWPJm1N934MQO89WxZgb1Zv0zZlOeQvMWTpxbYqZ4RP+CcfjAGeqD+VnC/gqT8kukM4Qbus+lrqpjDUynPuVtCqPJ1aJgNh6HW+9W3QNizQ2ViaKByzpeW87aDZa/d5o4EZCS1m7psJcwXYMMNoTlYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3F/ta+NN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38248b810ffso4517340f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646500; x=1733251300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZBwx+uuVO2x26etOfo5N73Hj6joBduj2MDGX1arT2I=;
        b=3F/ta+NNAGPnbIEsoxV3YArpABLBYrsjNbFc4FNdeA5ZwggDfbVx2lndIDNlfC7BSG
         cYBH9au7INsLr4JzCvud25Ydie4hWwZ7HllQslSISAGP0rtCPTFcWw+bG6A7vSyGYiyj
         y+VgipJOo3CAyVA4EoNWl4c5UQoOf1MShW+WUse+TC/6MqTQkfwXVed03XrEtjA0dFti
         A7bZTItWA32L7RVwRhQ2nKaH2o+jiZoTJEoWsNOb2IcyYJLYzUr6vTaJApviIV6M3ojL
         jgw2YSE7KPS7VNGQ3Ays0bjjmcZegzFsZlDvC+I/Ia9VWmGBwCWyaJ8D3tmsXtEqEqR+
         D8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646500; x=1733251300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZBwx+uuVO2x26etOfo5N73Hj6joBduj2MDGX1arT2I=;
        b=sDnj14y5QSmPdD8tOR3gFo3IhvC7Py0+a1GqtGpvyry5uBXUHI4tmLnm618H0YgQlh
         cR9WqkZX8eocoQLbzGV+MkGGdi3GjKvVfVni7OW/3LepsGYC2ObTJPOXcfePEEwR80SC
         SJh32UjaW358STZpAsFDpelhhFBrEL1a6d1i0amV14nwjtWVWbapdmHo/iYqCyrKASV8
         q9BYZOYrCvnXz8Xr3168RXiR2Ro2p/c6F61VaSdlnfPDL5YVCgYAYypspH0MQiu81aQi
         Oujom8OcFdQuIgyku7/iXCKZyHywVA1plw1TtsW95ubNi8SWAhJOA3LDZF47aa6Qo/LY
         EnLg==
X-Gm-Message-State: AOJu0Yyof7WK7Y01RKWLnxvYqEdAugg59GTPx+dWJ+D0J5akScmPqwna
	X2oMLGjVtRl+ng5nGt61BhPIN7gUOMkcVX2JxmMJ0hYcFyOL6ukWGvO7adAMHV/tI+GKSJBUH80
	8U2AqsxdlBrH1t8OKwJzi3CAFWaSpD+fo7cRYlPoYc5iplyhMP/DcrPg=
X-Gm-Gg: ASbGnctY21Jkmu70QoppE5bZSauF4DKSjstXOfo7ZxQZ288Y9RdWoz4/urZP2dRrB9V
	snRrIkqzSHlCn357k7a4G6A2qbHGNW6DG
X-Google-Smtp-Source: AGHT+IHlrLGlqP6EFIWIJRhmjwDQ3xGZiTySTfv+izIg5Gg5kuxAPaPWzVMkKFkf7QO7dfZrKevN9fR4HIiFfBEG4vw=
X-Received: by 2002:a05:6000:2712:b0:382:495b:7edb with SMTP id
 ffacd0b85a97d-38260be6712mr10607806f8f.58.1732646500082; Tue, 26 Nov 2024
 10:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126175402.1506-1-ffmancera@riseup.net> <CANn89iJ7NLR4vSqjSb9gpKxfZ2jPJS+jv_H1Qqs1Qz0DZZC=ug@mail.gmail.com>
In-Reply-To: <CANn89iJ7NLR4vSqjSb9gpKxfZ2jPJS+jv_H1Qqs1Qz0DZZC=ug@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 19:41:28 +0100
Message-ID: <CANn89i+651SOZDegASE2XQ7BViBdS=gdGPuNs=69SBS7SuKitg@mail.gmail.com>
Subject: Re: [PATCH net] udp: call sock_def_readable() if socket is not SOCK_FASYNC
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 7:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Nov 26, 2024 at 6:56=E2=80=AFPM Fernando Fernandez Mancera
> <ffmancera@riseup.net> wrote:
> >
> > If a socket is not SOCK_FASYNC, sock_def_readable() needs to be called
> > even if receive queue was not empty. Otherwise, if several threads are
> > listening on the same socket with blocking recvfrom() calls they might
> > hang waiting for data to be received.
> >
>
> SOCK_FASYNC seems completely orthogonal to the issue.
>
> First sock_def_readable() should wakeup all threads, I wonder what is hap=
pening.

Oh well, __skb_wait_for_more_packets() is using
prepare_to_wait_exclusive(), so in this case sock_def_readable() is
waking only one thread.

>
> UDP can store incoming packets into sk->sk_receive_queue and
> udp_sk(sk)->reader_queue
>
> Paolo, should __skb_wait_for_more_packets() for UDP socket look at both q=
ueues ?

