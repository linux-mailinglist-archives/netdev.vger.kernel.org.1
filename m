Return-Path: <netdev+bounces-227191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53773BA9E76
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD13A48D6
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6F30C104;
	Mon, 29 Sep 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWJBQvKT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7030C0F2
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161530; cv=none; b=hYOf4VWOW2Ic07g60vvbCPuoB+Gqw69E4VwWliu6G4kDDHp3W/fHL+N+1l2+uyLmAkYqNy8mcdOabNAtZIwrFm4N9PK+rzryWH11AQxvyFFiLg5Y1+9MOYmUjNVAgvPRL2ULw5FW/lLbEZV6x6KCsPNAC5i3IgYVZcgK8bY4G8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161530; c=relaxed/simple;
	bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHzddW5bDGDf8FfzZvkWxeq4TQnxd+e5Sy4gWgb/IuvV6Hl4HP3wEwI2imZ0p8lQbKnueaxhbmh8Gw85diNhFAPtVM1hgHhpGTW7IP7DqKWWiujRC/if+TkZokCYOgh/CvIslmiHWdh+NT74MpNAuptQ6C3vv1HHct+ZINFiuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWJBQvKT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b41870fef44so39264066b.3
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759161528; x=1759766328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
        b=ZWJBQvKT9Qc5PmNyldyHZaLCt3fwNojyu977328l5tFx8x1FT10gVhl8DQFhgpBpuW
         wKoP8TajHfA3LEezjyvdudvDtyJpPLd4nQ1l6EP3rMvjgRT97rWShu2jP6YgeH+jMSiT
         jZGaBmt3cPJneNkKbaLPDm/T6/JnehPZQNrw0DV/+8/BVclpkEUyexlc1wjjMhl8OX+c
         /JNPJQD4vKsVnFs+StQM92uXQWiyG2+KlJVF+8Fwd+Yg/b6SSUnbiDnUC+4bwW+U1pSh
         4rDQpya8OMl10l91QqpUNLfYXD2bEYp8XZQ+Qh25jHzLL9NnCZ5RcRJcAbVMJFDBzaNO
         /SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161528; x=1759766328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
        b=RGoIpL9nkzKJ9KgdmlS3rnHmPb+mF2FCUh5y6oTokFGxD5AKKVfqS1bHdSiOljKFVS
         Em6NTeBwNGJlHDa3DzLWFFjFOU2xLuSHpPcKbsJW5ZpbLiXC9e5s8ngsY0zkz/VE5l7x
         i5scbtjtM1AYC/VtJJ/PZlBTPz8RCq4Ii5h2ZmYOr2IlA7R8NyOvQ1WQp626Hkh+Wf/7
         Nrh/t4aFXL/wuon+gssyO75Q5jP0NEslhfz62/So5XIvrDBfSFwZfonfReLH2T4tTh3x
         7v3ZENWTv4fgYHtZPO/dDnWbo2R6ib/+XG9ytpYemhTeqXRkFD48mLbkeSMKapVHn8F9
         JG5g==
X-Forwarded-Encrypted: i=1; AJvYcCU131qRCIcuuvsFQ29U2wymu0fxL8Pk20TTSccXmlWkffUm6CXcbEgtHpl3+nPATVDi8wAQHhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6R7F/8wkPzSFttRGghSiTcmrVNRHO8eNW1LRPQnbyLDQ3sGe
	ARc6Vr+6K+hv2UZ9Gl+W0UqxBHw1t61DOkh3PoypDp/FTtacCpU2cELuf9szDOhUucUe0KmFK6E
	ROuOswU9RDhW+8GAm3Gsg7Yo2Lhy9BP8=
X-Gm-Gg: ASbGnctFWXgs9Dsc5uv9ScszHr955vLGHbkNWMstUWG51PvO4KvL693vAjn+Chw6/1J
	akDzRFfYO/qq1AmNh0W1BFR+O9QGZhXriMh35MO8S16oQxywiwAciESD3z1nisIbO1P5WO0XFKU
	PIhKNvyZpaKaXDuutyw2NrSyvj4FfTX5n5NXorGd9grndXC4QE2+4rGJqnXmG17Ptg7Rj88jBxY
	EbS4ryMmtbmAcFrO0setFD2rJQmyEZnvW0CMvVMuw==
X-Google-Smtp-Source: AGHT+IEyCADO6J8WiEBVdrcDX+0EvoZzPtvlyZ0fcAEpiz0fGzu77FQXIwzegr8XJ0+/55shLRsQasieeKC3kMA42EI=
X-Received: by 2002:a17:907:9706:b0:b3f:6e5:256 with SMTP id
 a640c23a62f3a-b3f06e527cemr412737666b.32.1759161527436; Mon, 29 Sep 2025
 08:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929114356.25261-2-sidharthseela@gmail.com> <willemdebruijn.kernel.a37b90bf9586@gmail.com>
In-Reply-To: <willemdebruijn.kernel.a37b90bf9586@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Mon, 29 Sep 2025 21:28:36 +0530
X-Gm-Features: AS18NWCgnPycz7t2entTrmTu5YC-DafC0Q0uYk2zgNL_KC7OWEjNYY7xyUDcjPI
Message-ID: <CAJE-K+C9_En-QWYrTJmMH-H8CP_1wgpREjFst1ybiE-bJtF13g@mail.gmail.com>
Subject: Re: [PATCH] selftest:net: Fix uninit pointers and return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 7:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> [PATCH net]
> and a Fixes tag
Thankyou, I'll add that.

> Does not need a fix. The default statement calls error() which exits the =
program.
> Same.
Yes, you are correct.

> Agreed on all the occurrences and the ovpn fixes.
Alright, I'll send v2, with improvements and a changelog.
--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

