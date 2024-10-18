Return-Path: <netdev+bounces-137072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9709A4442
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958E81C21646
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE00202F92;
	Fri, 18 Oct 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eb91RbST"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCA200BAA
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271046; cv=none; b=n8/3bgplS1uYGvlaJ0S4auQF4XGEk17f87ty9gjAS28Yg/NtMjMjvCy/YoYR0BAo+9YHqmibClOKh5QpNw4etfANroS66OxYLCf0+XMn8tASSnPDPTXkO9XPjaHetpdo6nKjuQpm9TdJOu5ILuNUOBIdhBFucH3h5m9NLaRTgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271046; c=relaxed/simple;
	bh=wbnIyKNtAOw4mHiY3Yn6y2dFUFqcs9budHj7TLC8Uqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jTDO/SjxEBfSl0azdL3ajzURhSNhV58h0/cH/yVVhHHiSd41i8DDiPEubyQvxrWMXOiyTF3/DlXLg4qrkJbIT5jQaVEuoxgkpY1++79RzlBvVRjM22Y1Zr5RVpPaREqz0rC3RJfzNJEnmXMi2UG0Hw84jvTC1ni4Iy8eDgiwtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eb91RbST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729271043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbnIyKNtAOw4mHiY3Yn6y2dFUFqcs9budHj7TLC8Uqg=;
	b=Eb91RbSTTaeXjr7gBGSZSxKeOmRRCWKySFHz16dWskPOjXlPwkn+wBuLCSO3/eS6YLfA2T
	gdhi1lc8dSdM/Pq5Jrqbx+r/zNZakwGFs9QZPwsG8YMfyRNPDq6gIpkgLvA+6t6wyr8/sP
	7pLHghcx/65jF/Cc8UyBjDwg+tiyWBI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-fUXZq5WCMQK6s1ctE76Oaw-1; Fri, 18 Oct 2024 13:04:02 -0400
X-MC-Unique: fUXZq5WCMQK6s1ctE76Oaw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a2c3e75f0so146930866b.1
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271040; x=1729875840;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbnIyKNtAOw4mHiY3Yn6y2dFUFqcs9budHj7TLC8Uqg=;
        b=TVXBCUunx/SMMnaXgJy8HqrBvmE46vHQLTXCFYCGiKCk0V6yzFCI06WgEFYQfUn3D4
         Rgv8suiqiJ8mf09Jq3RPD2AG+GYYprF2eP1Khs0NOWtCI/PwXDoWCkKH0uE1uAPecq9g
         6H1LR4kyED5cWKsd9dKY9cuGw36NbNAvr4yqNElN73bp8FlZG6GkcVHmxyqflI8Xy5Aw
         Je4Ti83rK2xNyG2D3Fu0mFuJBQvkdI38Y5CezNrrzmUC/R35Dg9A5xR9JTBWs8vQ2fc6
         Et6ab5DNoYpzRQzvrG2FrveywK0jVX2ZpLZVgNVTvHDQxwKws2EtV+T9UQtWWSKFz+NU
         c4vw==
X-Forwarded-Encrypted: i=1; AJvYcCUVk8dFylAb6yaI/6WILDgCYNnN21kl6B2UPlNhXzFOs3v7O3Hb5Pr+beTWguWHC4Dlf+NsTR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbEXFeU7A92jDZMw5zcBU1YLmGMWekgKnWeyJoqV0mK+Y6QAu
	YrHyMyooU6t+GpSseDxgsAqN/NZG5MFPF3uar4/jovwH84+KwvUHHn2buKkIJ2FnuyunPZasWJT
	XFdN9qfPc33Ln8tP1yDb7AiEcOGhzenD5NaMkWNzx2xZLh5QKgRfhqRhlNFaOjg==
X-Received: by 2002:a17:907:5011:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-a9a69ca3722mr225740966b.60.1729271040502;
        Fri, 18 Oct 2024 10:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVj5EoY0vS3pib1TdR5a0IlbIf/nJZCR/F+kKmxn2eePos6zgRqr+6udjAkQbtN7lRT725ZQ==
X-Received: by 2002:a17:907:5011:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-a9a69ca3722mr225738166b.60.1729271040019;
        Fri, 18 Oct 2024 10:04:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bc4a18sm117768966b.128.2024.10.18.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:03:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1519E160AD24; Fri, 18 Oct 2024 19:03:58 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Pedro Tammela
 <pctammela@mojatatu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: act_api: unexport tcf_action_dump_1()
In-Reply-To: <20241017161934.3599046-1-vladimir.oltean@nxp.com>
References: <20241017161934.3599046-1-vladimir.oltean@nxp.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 18 Oct 2024 19:03:57 +0200
Message-ID: <877ca5xs02.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> This isn't used outside act_api.c, but is called by tcf_dump_walker()
> prior to its definition. So move it upwards and make it static.
>
> Simultaneously, reorder the variable declarations so that they follow
> the networking "reverse Christmas tree" coding style.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


