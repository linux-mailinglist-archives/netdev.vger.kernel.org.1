Return-Path: <netdev+bounces-149068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561059E3FA7
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F182163B92
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BF20B80D;
	Wed,  4 Dec 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="GGtSD+/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866124A28
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329744; cv=none; b=eRsirOAcqbH4hr33DzEo6UWskXdIreKpq5Wd/hfvenkSV6BKxAtoa1ULK5S6UtUHQkAWLvJVfeO8z6nxBjhXahk6MaChM5LHoW6hhom7YxnNHwXQtPfVJTXQhBxblHIosQpj3OpzZsvCeSJhqkgdItTQi8Q2xrbU1RGTaNGp7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329744; c=relaxed/simple;
	bh=BaiNk8zk/S96u4pRQNs7OcMqgpSVqzMAmy1/IaK1ZoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ou3F18rs/hUXoNNpOXaLuLgkzBO7a5t5fKeXsXsjfFWbhjyg5dEykqllyIp79Tz7D/yXuMAgZVhWa/Bd/ogPZ+aOncUSX621eXoBLT4Fg6zzOdw+oh6oxNbdbsimL8EzemsTuBXn6VrMRKmRmMczq2/hOlGkCeH8SUxI3ONZOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=GGtSD+/n; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72590a998b4so683944b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733329742; x=1733934542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onf6poKdC/MdUF+6FfngpVu/rb1qprvIuOQ9zWYC92w=;
        b=GGtSD+/nbb1GJw7h9i/d5wXZNbrN1Jn/7ARFsJm/eI5W1K3Jm17gzB4+5BfJhFTouI
         0N44bqq9OaC+2YLLB+xA7OO6MiQxIYZZyu+ZETgMTcPG/8aBK54nvdMDB+EDjHczBYxj
         2Sc3Tx6Mg3ZgSDjL9sPTkJ9EwcPiW3owBxxPff4OIOE7pRqWyMg6uEmEwPg9axfNDCiZ
         2lpOM+h0PZBtipeoex4J/c10ka07Mbl1UzFIEJlpfeFM2EuGh99pjW5aOI94yrbnrNoc
         U555Wv7FkswNUTz9JUUgT9dLpvlnzGb08eZMTqchMh+00ClATE7pCM9iTPWDojuIjUZf
         VvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329742; x=1733934542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onf6poKdC/MdUF+6FfngpVu/rb1qprvIuOQ9zWYC92w=;
        b=ItqM+e1Q2cUE/k5j/lPCIGvBf/c18fCwmLz0VMbEDOOEB63CZThVfju38J65pLJRgr
         O36IblyuT8pyzGq36wUHuWFeUkXtvPP8oXMz8GHfZgzxoZer2wdHN3kwgnk+zrWLDKnU
         tXf5XSx4gk3KWXc6IZtcpsTvDmhdzOS2SDnDuTq0cDjaUUb0rzHT5NtnBgD9sB2w61Ju
         Y9a5ZO0E5xnVqh3Juo2yO6qsZCwG0I0LYwhXVHMATujuMotxtNMvxFPmoRI816h1b8xF
         fgpxQDLrRLNDF+nRyq2srBR38cfh6kFUWc841X6O2TL8nKehGsB+yIx6/YLpKGQ3t0qe
         YrYA==
X-Forwarded-Encrypted: i=1; AJvYcCVNqb+Z+E+ihHTUId3lpicslsgPJZQjxTPDkhH7cgki0Jj0KVE6FAxJwWmNDKI3ENBZQ0nQldc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFNlZdfU8JTdwn+iOAPc4b9Ni2xlMudDfOF1VcRQVju1Sj4BK
	QJznaOqWnYBcJApWvr4Wq8tDaYtDQv6IWdM0kBxI7s7LHwJpBTg6Pv8JSt9TyCo=
X-Gm-Gg: ASbGncvV83tpKv9KVvPhBaKd6t7b//17hR7gX5/0Sp1gDh/ahAaWLBzUNGK7xnisorg
	1bC17VQx0OKfm3gDfAX0Hc1nAhijXByGakmoUTCMRTOWrvOtP/UfSC/rQmohunLYkJlY8xif7eq
	DNs6T7b5Gvhbc/hgKNl1xpfqx8BWal1BHY+SoBkDlOPQT60/g9UpD5mDT3sYvNw6psUX0RQnh5m
	q7rqieX4Kb+PItKS1tjly7+bPqxgqVqbhdZAH8uiUXwk0tZvBq+2cLtywR+MT0o9/r/Cwt/uS8w
	vjx/ecnCn5LDFubdKhUgCy2zb2M=
X-Google-Smtp-Source: AGHT+IF/kGceHP1aSb7zekvp4svsOdmeV0etN4fJaUHSQDZehFmAACGQ1FPASw4P5+7VKPzayjaO9A==
X-Received: by 2002:a17:902:ceca:b0:215:7e49:8202 with SMTP id d9443c01a7336-215bde11763mr94406835ad.13.1733329741641;
        Wed, 04 Dec 2024 08:29:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157f8dc404sm63664175ad.220.2024.12.04.08.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:29:01 -0800 (PST)
Date: Wed, 4 Dec 2024 08:28:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, "Maciej
 =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <maze@google.com>, Lorenzo Colitti
 <lorenzo@google.com>
Subject: Re: [PATCH iproute2-next, v3 1/2] iproute2: expose netlink
 constants in UAPI
Message-ID: <20241204082859.5da44d1e@hermes.local>
In-Reply-To: <20241204140208.2701268-1-yuyanghuang@google.com>
References: <20241204140208.2701268-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Dec 2024 23:02:07 +0900
Yuyang Huang <yuyanghuang@google.com> wrote:

> This change adds the following multicast related netlink constants to
> the UAPI:
>=20
> * RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR: Netlink multicast
>   groups for IPv4 and IPv6 multicast address changes.
> * RTM_NEWMULTICAST and RTM_DELMULTICAST: Netlink message types for
>   multicast address additions and deletions.
>=20
> Exposing these constants in the UAPI enables ip monitor to effectively
> monitor and manage multicast group memberships.
>=20
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---

This should get automatically picked up when David does header update.

