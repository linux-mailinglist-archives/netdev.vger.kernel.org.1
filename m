Return-Path: <netdev+bounces-216189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B15FB326C0
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 06:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA67B0087E
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 04:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1271F463F;
	Sat, 23 Aug 2025 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xbABjUlK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060371EE032
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921981; cv=none; b=dtYEFsNEXhQmXG5i+ISENYXY8BVLUlNXFkQtJG97Hu3YMXZHZwOfQfR4aMsmqb1aYxwMkXjOrkvCrhq18C+0lzWvfFrMeE0WjusZLRrryCSsV7AD+a9P4YPR6s2A1UpJbJwAcHLPu5smIqWmOFTCSv33VBe1uQWI3hGo3jFZqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921981; c=relaxed/simple;
	bh=rEK33iBjZA/mdYJBhgmqwBLq14pIRc2nuelmDRRPyMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fma6WleyJF8mS22VImpPwV4OcLj0kAuVvDjs3hImj7Nw1a5wVkaOTMDB6TUXezILA/Gs6zVj8GIYUfAcY4fT2G+mpyW4uZswMSWZJ4IkxhnbymgNa7ICo01TZ+LdCoFAC2IsCiym3bcMEctPqhuXe23BPXJXYhlNSVNVyehxefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=xbABjUlK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b49ca2ad5cbso655158a12.3
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 21:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755921979; x=1756526779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOqBnKF6PPC3VQMLcKl9ch/BHgpUPRNVu0jRyJUfIQ8=;
        b=xbABjUlKesJaPxlyJDJ6ir9flAweOzunsOPdIPpMk7mVd5mWAGQvXcYs6QQSUJN8Z/
         OgTcAel/vTppf2kH38EvZ56C94oZzE+WEdWBGoFn5Sz2kZGWt7nvXIDAahGaBNeeUlnk
         VJPC9D0v8tK502IdhafR5sz3qpnxwl0hq8yjmFF7o+fjjLzMLryJFD/T1W7MKJxBA906
         NCzEvLenybAc/KwTKH9CAFefkW+nK/ahUub3A0O96unZsCXZHQNm8v7fanYZj00meYU6
         JYn8XjRVXP9iyqQRn394AMwcygRlweqbGvoCwFM4wPtSHy6cgJ9dNcZy9bOA3zAlK2n2
         1kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921979; x=1756526779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOqBnKF6PPC3VQMLcKl9ch/BHgpUPRNVu0jRyJUfIQ8=;
        b=uzkKW0CTHKSlddX0tAvhFPlw946HSJuiF0IoiFJhiE30lGA1P6KcuNs7G2F/YzacaV
         p/K6vTdgijDxf9pubGJlWV9bOzfYwBr9LyfiHDCC/wDlM/uXMxi0NP6rmEBVhdJYHSR5
         9td/8NTtdNhenGRLz+EqLX9OHrNmcd5qtkL+6EUNNFhk2oOHIgZxgz8dTLpDcygIdy9h
         7KTrVRj1aTkcgAt3g5dY+sr5UDcg5LXL1t9AaG+PgHRdhjUelgXSiy31qXG8JIs8oXxI
         CzYVOw2Uo3/ElRGGn2vKCBqbKcI+4+IaZxBbLu2z8xVpXwtd+mgv5rwLpSa7BQz+jDrL
         DkaA==
X-Forwarded-Encrypted: i=1; AJvYcCWIvx1+n6w9DKVTNQTNhlBGAm8eLObFwg+Zud4RM4LLfbNSBmHSrcRNx+DHMJBytqeP041coSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKaSVDrWnYeL1CKo1XI/iq3J+czmav60relTIB7S390CLJjal
	HkqDLcnfnXgAfW5ksuC+D7wvyJ+8lAXsOL/IuNHqJoyJJoUM6G6Xhapy5uHZP/fD0/zn7rFwKdp
	ofsFnuqXFMyd0js5Zleh+4DRk++JG1jd5TNeJE0BW9w3+N0BlPFc=
X-Gm-Gg: ASbGnct7zPutEuBrWsbCIg1kJ4Oz5SMd7sha6833gVgXawUfGa9+CZWv291SRizWkSQ
	q6AaN4a0yGAJYHITRU5qsSExsfl5rdnqgyJAJwd/IjXB1XJ2Xj+TyF6PH/Hi+2MLx0cEpO/TWiz
	zbkK13q42PLRMHZxNGoHsGG0AxmYJGyftIsXtIT6BceakZfZbBxMLhlwP7csWRa/HwX+0pAviwB
	c1y13M7ot5Lr103SQ==
X-Google-Smtp-Source: AGHT+IGWDaKKflQd0DSaqBUH60OEPwL0rDRD+Vwtn5x0aG0tbQ+F5E7KfgDImufZxIrCoFPKZN5f9AWKI5NlXFtGj94=
X-Received: by 2002:a17:903:1a84:b0:246:2ab3:fd7d with SMTP id
 d9443c01a7336-2462ee5d672mr70488875ad.25.1755921979170; Fri, 22 Aug 2025
 21:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819205632.1368993-1-dw@davidwei.uk> <CAM0EoMm06em6GKDyDP94oQ_RPHv4PQ3dK19YZU9jxCiNh2S8rg@mail.gmail.com>
 <20250821072146.4c06e82b@kernel.org>
In-Reply-To: <20250821072146.4c06e82b@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 23 Aug 2025 00:06:09 -0400
X-Gm-Features: Ac12FXygTwYVCjPo0BIP5qE37M_2ZKj7aSVNwyQQQT17S5AuNtOF0_4yvMaZnL0
Message-ID: <CAM0EoMkXXWr5thop9omH3pQszu2JD0XZvHQVyBXuC=N4F5okSA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] iou-zcrx: update documentation
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 21 Aug 2025 00:34:34 -0400 Jamal Hadi Salim wrote:
> > > +Zero copy Rx currently support two NIC families:
> > > +
> > > +* Broadcom Thor (BCM95750x) family
> > > +  * Minimum FW is 232
> > > +* Mellanox ConnectX-7 (MT2910) family
> > > +  * Minimum FW is 28.42
> > > +
> >
> > you missed the intel dpu/idpf
>
> I think you were using an out of tree driver?
>

Ouch, yes - it was out of tree with a few bug fixes..

cheers,
jamal
> But keep an eye out for GVE, there's a patch to support ZC there.

