Return-Path: <netdev+bounces-187696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF9AA8F1B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92601897050
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6AB1F4639;
	Mon,  5 May 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aG99vJgc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E631F2BB5
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436440; cv=none; b=Iih11FMMpm3vMd5Y70/qvT6u0BDwR06YY2zQ96SzANdbHAXgDeePm8O4HUWpldKQ+AXHaefnBCpuI8cUsGgibqV3FkHr65YHtQ5khA6q8OD2c4le2SHP0AlORV+k48iXHObmrxrd33hF1wkSJu+l8C1EuBzlujJDxub68gbwI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436440; c=relaxed/simple;
	bh=k1IcIw8oEyJYviPuUQqrU0ETws0CuY9iE8gFyKeLrvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=opqiyHeM/UXIaHYJrM6OkK9+LaBpDZ82TR0bMjpUYbXa/AY5Jpgte40cYhE4qv59PJBXXUCfhHnHFfZeDklWIhDq/wl3WC3EHfJku/IMz1Lq/3fEBvAbzd2k+R1tfa6JveUY9dFZoSaBFUtxjI/plY+SNqMDcXG1hTvO++9Yt7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aG99vJgc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746436436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1IcIw8oEyJYviPuUQqrU0ETws0CuY9iE8gFyKeLrvQ=;
	b=aG99vJgc3lC8DNa6Oc9XUfiFI0j8scCol/KKwWJY3/FdmN5hndf9aKlN6O1HXWNb4aSiJE
	qffZ8xe4DJOj/fRfU8+qZwwuBuSK5UA8AoMeFvKCfwO+d/+TJ70Oth00zX5C5TkSDRn0lY
	1kTUarnkAJitjCKof4AxV663pKM1a7g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-eozjT1ZJO72dIdvqmiwsLg-1; Mon, 05 May 2025 05:13:54 -0400
X-MC-Unique: eozjT1ZJO72dIdvqmiwsLg-1
X-Mimecast-MFC-AGG-ID: eozjT1ZJO72dIdvqmiwsLg_1746436433
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ace99fe4282so461421166b.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 02:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436433; x=1747041233;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1IcIw8oEyJYviPuUQqrU0ETws0CuY9iE8gFyKeLrvQ=;
        b=LgG3Lirq0CDBeMbDAAP4nTmhwuL7T1fPGwZrTJeZ8UitUAhpIFDSwZVCl2ZIADmHwE
         REARqVlpyNLkihiCknVKVc1RFTry7kC+fuMtTsC2ynfl7z48g6zypJIVwXae2+pBHKp1
         be66XP940TXd8HOmVCoP5w7BbmPXlxp09iwjNprKqaJcA2XIqZMzIfJKvR14PcIjr75h
         Z03xQEr+X3nXwKNDAxEjyCFxRlr0DAtV8t8bNR+QW5PBsKFZv4g8WamOmySpxbqUMvFx
         nW8xfEefcTyYcd+wp9pE/NMPKpm543v6rSW7MoSr+3oSymy4UOXmvZJgfQ5zLGzKdYnk
         ckqA==
X-Gm-Message-State: AOJu0YwGnoBOS660Zk6rVHmf6q+P2IWFHU23k9IVI1TZ7OI6J96zlBxp
	1YclmvTXha4ZKPCyPfv/a+29eq7tMaPdZLapZU4fwdtXkSPKSE22CuBs67yEl84an7v3mNd4na6
	LI5pmK6VoQwzYNJ0nIMGPYOjNB3K6r6SyD4XpSKRsHbiGIo0JHMyVrA==
X-Gm-Gg: ASbGnctXiRbCyIZTjVb6om0M99f2aYY/PIAEM3Q0CJcJtihlT5pKzUcA0JMqRV6d6g7
	bcOIiWE+6jD4JbxM+XYly7U7gxFoXc0HTl3I/DqI9kk5ufCkzMUT+9qcvyrHTbLZZBwuex48Orw
	MSBEMZd9Eu5O2ZQyzFe4nzmkZETTL+wu7wRyKY74SKvkrmp+jWJjf9Ya3i9yFYHCMoatEiLkFhG
	lsNWX5WtDcVUPsqLeRNuc/lXR5DQnJiZHStERV7i1Hlw5yZt84Ku3mA1HvVEN7LQ0RXOKJyQoeD
	ui6HR0PV
X-Received: by 2002:a17:907:2daa:b0:acb:aa43:e82d with SMTP id a640c23a62f3a-ad17ad44558mr1016883066b.3.1746436432768;
        Mon, 05 May 2025 02:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzH7nbUKnkvNU50lx2bKZYCMG1O7IVV7E6VLNwRUOWFhfv66iShat4B39Dv/kpSXct4T08lQ==
X-Received: by 2002:a17:907:2daa:b0:acb:aa43:e82d with SMTP id a640c23a62f3a-ad17ad44558mr1016880466b.3.1746436432331;
        Mon, 05 May 2025 02:13:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895402c7sm456179466b.164.2025.05.05.02.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:13:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 848561A0BD4D; Mon, 05 May 2025 11:13:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
In-Reply-To: <20250505085713.ZAgyY1mJ@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de> <878qng7i63.fsf@toke.dk>
 <20250502133231.lS281-FN@linutronix.de> <87ikmj5bh5.fsf@toke.dk>
 <20250502150705.1sewZ77B@linutronix.de> <87frhn57i3.fsf@toke.dk>
 <20250505085713.ZAgyY1mJ@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 May 2025 11:13:50 +0200
Message-ID: <87a57r5sj5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-05-02 17:59:00 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> I had in mind moving the out: label (and the unlock) below the
>> >> skb->protocol assignment, which would save the if(skb) check; any rea=
son
>> >> we can't call xsk_buff_free() while holding the lock?
>> >
>> > We could do that, I wasn't entirely sure about xsk_buff_free(). It is
>> > just larger scope but nothing else so far.
>> >
>> > I've been staring at xsk_buff_free() and the counterparts such as
>> > xsk_buff_alloc_batch() and I didn't really figure out what is protecti=
ng
>> > the list. Do we rely on the fact that this is used once per-NAPI
>> > instance within RX-NAPI and never somewhere else?
>>=20
>> Yeah, I believe so. The commit adding the API[0] mentions this being
>> "single core (single producer/consumer)".
>
> So if TX is excluded, it should work=E2=80=A6
> For the former, I have now this:

Yeah, much cleaner, thanks!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


