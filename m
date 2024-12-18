Return-Path: <netdev+bounces-152966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4719F6759
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFAF1888819
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591CA1ACEB7;
	Wed, 18 Dec 2024 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRG94yQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D817C219
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528834; cv=none; b=S7IpjnTWWgjojEhHwjX5F/+lyhUtNpRuJebVxGBakIBjCYPjOh0gGAeeKNmA7uaxMY4cgBWjGcULx14qrsVsKLJDlhCor/j/JY/+v/uvj3RGVvo81rjZxGW4+fGWV7oAKYg+QqPtEBjnyrkMIY7UX6ZLvKMoasQX3d4N8tb3uLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528834; c=relaxed/simple;
	bh=/x6POKQ2jqawB+VQH91Eb7vTwY62fr79VjnEuQ0y24Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daEZtId54DPUUhkVeVlLJEpCkOzpAsaGb7/5iG2hA5AcNmJTCxjriHwAwN6I7hNmbZzMj2VrN0DYdW5TuYFhwc+AbbKGwMEx369Mwn/D3L19OfyVgJrly1y1ILweYB+VstfvaG/NKlF3B48k3YeGOxGI1N/7cqp8nu7l44uuoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRG94yQi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so3851632a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 05:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528831; x=1735133631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x6POKQ2jqawB+VQH91Eb7vTwY62fr79VjnEuQ0y24Y=;
        b=ZRG94yQi8t3ym9CATphzzwThtwIihup7rBVlf+XLDtWnxjYKWp5jAv8G0uNMu9B3pp
         KCw71320zjcVW2/4YJnSJPObEFTzYs3EPTiCyLpXyTrN0la2kSYaO+L3NUINK76HXStc
         /jGw574qQnhTqb9utVa33wS3Y7s7M6reu0Im0uA7CgRN2Cv/MLQLclJCssavonqsSAEO
         I13bDUmPe7NmQQeeo7bWaM3KrLlVV29cxepwNgb4h+ErioSvBoaUJ/ya+es3Pr3Vw6d3
         I4nQIb3ulMaOrwRLvHlWPFVUKmzU3+Oj5P9WOIEBF6JJOrLxciULTUbG5HnKk95iszb9
         PK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528831; x=1735133631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/x6POKQ2jqawB+VQH91Eb7vTwY62fr79VjnEuQ0y24Y=;
        b=N6W/h95V94HN6MQioDyI3FtNQ1jlTDCMrC/4g2ZgALgveIUrYdigVJB2v4gimhdjdB
         5YBVYFzedVnZ3k46ziOC5546KxJNcYRu28Neqc0E8TQwx13KyTt+ES1MyyCgOZuRyoEj
         D9bMJYHrQV4N+10M1hcIiMDTfggYyf/RY2AeyG23+ZGhDqd8tGqxIHNQqyKUY7aOGFor
         /d5aVwJC/ta17kNgJmddnt0AOOLJjq7/6ExuU532JF8+ypFTtuSVctD/oGTv7sjvvh3Y
         GwNdcnzuqldlNsi4zw85u7ZQHG/WjDonw7vqty36QGOLBcKgrr0W5yPV/6q1Dbh9uwZI
         4/vw==
X-Forwarded-Encrypted: i=1; AJvYcCUYGeva/hQEaxqxKpa+o+B17DhiaN6nb7HvHrTHm77ekVmZZt52Aee4lwndzmPNITDhFEOeNLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu85BCmhqMEXQudHuEv3NqTVTpAFYrduQoCIDrNcy/8ta6v/JC
	a6RqSN+tI3lqNzrhsyNnuGI61SkDk8FyYF2jaKW9SS+tqrNIg2G7AHzBO3pZZ0pWxjxp3D6A4yJ
	2nAR1Nv5Plw8C4xT2J2AC425hIEekHoF7Of14
X-Gm-Gg: ASbGncvvZixbbRpntpKlAjzq2Kau1Ykn2MEGhClXwv2zKb2EDxHC0V11mAg2Ad8ICY3
	klZMR/xPBT5IxIHHVREhiuGqW5ZF7FjInnxtujCMt/nSzTG/ny+XTdQVNrrTB4c03+ddndWk=
X-Google-Smtp-Source: AGHT+IETX8zlLe43FoP+qMsYWDGY/BRu+1bXdAWyFW+g8iJOO+sdAxkXQrY/LDx/KnE3+LcjshD2nQJ1Slq6MhpW1IU=
X-Received: by 2002:a05:6402:3510:b0:5d2:2768:4f10 with SMTP id
 4fb4d7f45d1cf-5d7ee3b5737mr2558020a12.17.1734528830639; Wed, 18 Dec 2024
 05:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218090057.76899-1-yuyanghuang@google.com>
In-Reply-To: <20241218090057.76899-1-yuyanghuang@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 14:33:39 +0100
Message-ID: <CANn89i+1-it-nLix4JHdbt0TRTOoC1GX-0RstfqBmW2b1D_1mg@mail.gmail.com>
Subject: Re: [PATCH net-next, v2] netlink: support dumping IPv4 multicast addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com, 
	netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:01=E2=80=AFAM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> addresses, in addition to the existing IPv6 functionality. This allows
> userspace applications to retrieve both IPv4 and IPv6 multicast
> addresses through similar netlink command and then monitor future
> changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.
>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

