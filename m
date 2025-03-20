Return-Path: <netdev+bounces-176386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCC8A6A01A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C83E189A16B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB71E1E0C;
	Thu, 20 Mar 2025 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbRIszxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BF819
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454362; cv=none; b=G5eKAUQuC2HshO/H62BSWh+GhEC4ZJKB68wxS11Iw4gdUVizrldL86ZcJwhGarRzPuGbViHlCPUkS2z3LUgu4QAA9yjYS/dlDRpuEMkF/jHAu5bDdH6EktWtULrEz28Iy9Bh23SK79km1b8WlACa1GM0XRiY66Ly7THjCY2ZJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454362; c=relaxed/simple;
	bh=FjDOYjC4l9kvoxsmVRQy+Q7EOw54z8JRckRPVuC20vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+N49uF5u2LPxaDrcEB6n7Qqdz2zbIOhTBZZnh72O4fJHtjvipkP+Bxvy5i9yX170UFp6zUF1HaHT6P6LmRjjmr3l0g1L/uCAk9hGITxYFI/fSMGIqII7RMFACJaZCp9pxcw3k9QtHFmgpkDjHIr7jArsUh8mkz6+CDcIG1V05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbRIszxn; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4766631a6a4so5163321cf.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742454359; x=1743059159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjDOYjC4l9kvoxsmVRQy+Q7EOw54z8JRckRPVuC20vo=;
        b=IbRIszxnppfvu0MQWdjqe4QCTgPB3Jhak2Ia1YRCh0rHsTiA9/8Q0SdxIRiPJDpq7i
         QmdXdkgmxxBMMFWEvR9Ayilgwk2GHip3JYET/ZdpkpTbuIvRAw0YCzLgtDRDVHJ1MRgX
         CZ+nNiUHIbAMU9Dm3/vz5y9AqlUcrnLO1jy9LkBqMCwJKhUhu1oFpeHnWX/ZtyFqI4E9
         1eGdIYjD5NjgBDO0l+6LZ1PFD1HrGycH6siToAu1D17sVDTAjfQuljPsy1sZIJutOWKU
         kioit3etUxPBKnXmDr26ZW/4ScjPSfCUTY5Fz1RgAlA/+RpqzVVBWRe1kvGKSYWU0Fjm
         8pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454359; x=1743059159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjDOYjC4l9kvoxsmVRQy+Q7EOw54z8JRckRPVuC20vo=;
        b=KibgH+aIjqYsbrSZLM0sz3vYGq5HVd4yGg1iqbFc4vV5UXPG5/tLgm/VS6ONrJraoM
         sKfTkbRCiwTHS/IrVdtL9lcQjFtMDXg4b4HJZKwGKajIy7vXjuS6aax/IP0XMadiu03o
         Fx/ciEtea+ChDMRSbHjkIYOLmFYO1xpBgOBBQ5SNccuuFLtWDuZX51807n5LqoDyy1T/
         JKWV1JU2yz9VJsAzxMmIhjLF30ZXJvkTuwxuzE5BzNVFYyC7SaBRLAYzaWWH9qAGM0y+
         wQXBYpCr898spWw/ZufpVJuWI7fTv/vijRewyJb/Z9vXpoD1YW4+SBfoDsOouePF5JqP
         RRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZCHG9iCqFqJ08eYFk3Ghq4XKU99HM4PnaP1JjIVagkl1/lL33B1WlxUf4lSEFqZmlhcK0YEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3zASfJLm3erI9YktwA8i8rIj3ttPSiEQ06HhtKSAbOUsAUFG
	zSFdVBxoQDw2A2luzO5aCGDdJUwbXWCgeLJ2vvv52UmtPMR9klLSqe1rbOl9cElmmh056a4tJZp
	0+BRfn6bzs5SHY0YMtps4GPKWXlgq73+ZJCLd
X-Gm-Gg: ASbGncv3R4hfk+K2jUjc6uUmuElnH4iONu2aav4YQtaQk4gV+fGJ35cT7/qbTXOYhrG
	Zoc1YILeP9OAq8JRYIUbfGG3Eoe1CRhm+mkfuOP+Y50tz+Zi0wIEID8r2G+XOldmQmFfSn2wjWW
	+1wkOcl3+qEhfyNmLRNfJhrKQ+
X-Google-Smtp-Source: AGHT+IG0YssUVBzrXRlSzgafcoDVXvxWwMvT7zy42m6QCqAp2rNiA/K4QAkdyCskTPLhPYs/QqOGS5VoOntjEmBTdlI=
X-Received: by 2002:a05:622a:5810:b0:474:db2f:bd32 with SMTP id
 d75a77b69052e-4770838f052mr104121741cf.38.1742454359165; Thu, 20 Mar 2025
 00:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230743.65267-1-kuniyu@amazon.com> <20250319230743.65267-3-kuniyu@amazon.com>
In-Reply-To: <20250319230743.65267-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 08:05:48 +0100
X-Gm-Features: AQ5f1Jp9eyKe7K_ByVLSediNzE5nAMV2ZScCnKX-OwRMFDKhhqYhL0M2cSbGssw
Message-ID: <CANn89iJoSMSxgrtE5-VVLEXo6FmzHy250QWLBAknOasoZZruKA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/7] nexthop: Split nh_check_attr_group().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:08=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will push RTNL down to rtm_new_nexthop(), and then we
> want to move non-RTNL operations out of the scope.
>
> nh_check_attr_group() validates NHA_GROUP attributes, and
> nexthop_find_by_id() and some validation requires RTNL.
>
> Let's factorise such parts as nh_check_attr_group_rtnl()
> and call it from rtm_to_nh_config_rtnl().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

