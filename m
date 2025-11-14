Return-Path: <netdev+bounces-238636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5463C5C478
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7ED421A4C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0195306495;
	Fri, 14 Nov 2025 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="JHTZAQg+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF992FAC0C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112395; cv=none; b=F9ZR+7v9edEnFslerigMDXTe3OaSGUKrma1JCWE3oC4TjmMpjINHaZytNwgWiKt6NVCXskSU3sMhPXYVzfRI14pbFh36hFur6IQG5HnvPOjYcTyTV5zG8iU2dYXXWcBwSxA5A2gpnQQWdtx0ArFWwkTo9QYxIttklbklnV+hmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112395; c=relaxed/simple;
	bh=mUQJmBt5v2Y81Juz/lDAcq3JEkoO8JYvgpCc/xs775s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OIOb61E3ndIDA/fgq+fIhxr7ZkOCoLRrxeaTjLUgGmLf/NcwAFQiSyELhV5hkkEJHycC+/PR3bb3VSkytRa0IjbCubXfX5hp5DunPITLD0FhshDsSALvI/zh4Wb9ReiN3rzHU/qdhjzy/U04ttVxtVNR0C+vhBKkxA1MCuKO3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=JHTZAQg+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b2dc17965so1514256f8f.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 01:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1763112392; x=1763717192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g2lcCTJ6Yd8/ZyF4iHNtTEyFkWZXG0siWf5lB3cNykc=;
        b=JHTZAQg++6uhBhkeNScnPYG4DhC0gXk1afpCAsfD3kb+3RDp3vPPXaqkYoZARJ/Waw
         kUBI5OcOK0A35DBeCIglnrK495pZkPf32KfV0DD95lqfz9Iih9aXHt1KAHNzxAuIsejl
         7YiCbCvDoHVcZRiVSAVEGeN1cNprpekv7vSSGdzMwBMVv8BkiH2MCw4d5TduDCwssslM
         uxuZ++Kl5UqkWEN97G4Jc3jOdtAmLC2r4r3sySNKNvDjv/YVL1R/+Dfi+q5t0GWh/zQX
         5I1975OIRk7ohm+LTIHHCvxtg+wIIg1PWODST+1yAQCEHPU9yXykgDYYgbX2UNV6Ru/A
         6nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112392; x=1763717192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2lcCTJ6Yd8/ZyF4iHNtTEyFkWZXG0siWf5lB3cNykc=;
        b=YeOtMZx3jlo8OH6isi9gEAtYVm39IcduKFGls/a8O0YsRAvqX1dcV7kvawg7ZIxJ0V
         zOLBVW4RWJONU6QltAjsyHYkJIUWwIPdBey5qX6VURMPwuabRmo6L3e/kflvJ0whVEZ8
         90bYUNzVjTs5TIKw4Xfx/SzWgMXAarURqzL2W2d209b5UlFVAwZi74kY4fReB+5Lo4Kb
         tncrP8VoY2KE7A5mhVMOU1I88cHzh1bWdCeC7FCDalL0vlBYJqPz/wwqaEmHaAT8LK0e
         wexizM/EP8jq1qXqX9mUz+RXbYhi74+YsYWiTIWbCj2C0ejNguSudkr0q7eC9xAATUt6
         vlBg==
X-Gm-Message-State: AOJu0YxtIhWq+vltq2fuCzY+SUNiQ7RYTHhZxPKZGV1KQ0PU4+uLLlMK
	FJ+zYYqNSq0utChoU30edTImV5YgmpOsKxXIY0S/jv12pJap4s1huuwam3l9xGIpBEHL7ma0Spg
	UR9DYJp8=
X-Gm-Gg: ASbGncv5iYFQ0Iw1GgLEgHdMrVio783JWFFvq+b5LEuB6Y0ZafFp1/iMGShbOBbzgtn
	ftsR4tk3XckC6lJ6540YSHiGdwOQQLXiWBChq3z0nCbndYvLgK+BrlgsxFxPR2NJ3GoCtnmamsJ
	oJTuZ67HY2OlWoxNCwdoa7lRCmV1L468Ryq4fNDPvNsZld8bEn6J0shPDyUuRQB7N2ni6l8wS9E
	qN9ItRf8+HeK4SvjdXMlukdlvfrgJawdhC0EJIxtNi0Uw0VrVMH4rWQIwRSqEOCiwabLcQUoMbV
	E3Y2DWQZwba8fKHKi3eI6HVcdHESq+g3XnsWls0nT6D5bq1Qc79YybnQlBZNKepYhB+L9hPZ/oh
	T3zIUqwlja1SMlbDjAiRz/tt9RYXIp7W3U2B1rxzERMA7Qpbe0vUhmEjl3QJCJMcmec6u9cwV04
	dH/1FFqoF3frwuCK8wO+6W2cAi4qZGXGs26uXOw/47Hy3FzBA=
X-Google-Smtp-Source: AGHT+IG3aIh/L54Zqq+kvuomH7vdXuvospwx+ijQguI7hYwulvm2bn0xzzUBoOXhgncMzSO5EAwL9w==
X-Received: by 2002:a05:6000:438a:b0:42b:43b4:2867 with SMTP id ffacd0b85a97d-42b595a3afemr2127899f8f.63.1763112392258;
        Fri, 14 Nov 2025 01:26:32 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae98sm8826745f8f.2.2025.11.14.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:26:31 -0800 (PST)
Message-ID: <fdf87820e364dda792a962486bef595cd6428354.camel@mandelbit.com>
Subject: Re: [PATCH net-next 3/8] ovpn: notify userspace on client float
 event
From: Ralf Lici <ralf@mandelbit.com>
To: Jakub Kicinski <kuba@kernel.org>, Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Eric
 Dumazet	 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Date: Fri, 14 Nov 2025 10:26:31 +0100
In-Reply-To: <20251113182155.26d69123@kernel.org>
References: <20251111214744.12479-1-antonio@openvpn.net>
		<20251111214744.12479-4-antonio@openvpn.net>
	 <20251113182155.26d69123@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 18:21 -0800, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 22:47:36 +0100 Antonio Quartulli wrote:
> > +	if (ss->ss_family =3D=3D AF_INET) {
> > +		sa =3D (struct sockaddr_in *)ss;
> > +		if (nla_put_in_addr(msg, OVPN_A_PEER_REMOTE_IPV4,
> > +				=C2=A0=C2=A0=C2=A0 sa->sin_addr.s_addr) ||
> > +		=C2=A0=C2=A0=C2=A0 nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT, sa-
> > >sin_port))
> > +			goto err_cancel_msg;
> > +	} else if (ss->ss_family =3D=3D AF_INET6) {
> > +		sa6 =3D (struct sockaddr_in6 *)ss;
> > +		if (nla_put_in6_addr(msg, OVPN_A_PEER_REMOTE_IPV6,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 &sa6->sin6_addr) ||
> > +		=C2=A0=C2=A0=C2=A0 nla_put_u32(msg,
> > OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
> > +				sa6->sin6_scope_id) ||
> > +		=C2=A0=C2=A0=C2=A0 nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT,
> > sa6->sin6_port))
> > +			goto err_cancel_msg;
> > +	} else {
>=20
> presumably on this branch ret should be set to something?

You're right, otherwise it would return -EMSGSIZE which is not what we
want here.

--=20
Ralf Lici
Mandelbit Srl

