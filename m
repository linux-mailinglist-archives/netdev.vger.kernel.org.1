Return-Path: <netdev+bounces-176413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA7A6A271
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881FF189516F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152E221DA1;
	Thu, 20 Mar 2025 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc2AJ48X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0020E32B
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462469; cv=none; b=sE056E8Pu4TpmsDz9laeL0lEimRhoMP/HGxFs4Zf13FuJJHDA1tHEurQM/qUiFu9dZI4TfEd+cgJaEdCyQxJQkbmQuNdjOVPPgR8di6o1YcjsmVOQrWQr1W0lodB7yr17LKaIpF7Evb9Wf//dTta1z1ld7PB5plXnzEWOp6uH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462469; c=relaxed/simple;
	bh=e4dH9wUBMw5WFrVQjzb4pZql51U4KOcoBn+Aq7FHrEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyYPSDCoHSvXuJpZsWK/ANouTulLhutWAH1XeelzxaNJ6goh7u5WJt+Qta/t3oT+gSX+Qozu49YFEe7PhPHWm4em0b801D+hymP0TdfjDbs67yTGzX5Jg3o5c0x4gnhQLYIuOo3z72oqotJNJineFEBPA8EYMYYmoeCY4sq2DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc2AJ48X; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso1058937a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 02:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742462466; x=1743067266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sm6oorFvkOexn0ubUKkqDUbSVLnqmVP5NuY9g+uHVlI=;
        b=Gc2AJ48XKqhiA9oRxfJFDvQkrT5IzmRfVZi8iRreQU6RhYenULcxIiA1FDS2KvbK0G
         cIdfly2yWd+Wvi8y+a3g/nTjefKivPGkCTjXXIZ3V4p+hsWr0rfS4Jm0/xd5lBXwb94G
         b3Wo+E72WuTo67clUWo+G1hRy1+/lrkzstITOeRBKL2UNJlyRFdToPZCs6mcG//IMbfJ
         4UF8Fosvtn5vyHh9NV1O+2qLQOryBxsFhySQh9sqC4miziiPoJa6nNH++Oti57ZognPj
         L5S6G95L6iG2Ri7i4tTyQ5SIcDAAjh7orHAIXJEF6itoat4WachdLbJgwAg3pKE3uX1z
         jypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742462466; x=1743067266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm6oorFvkOexn0ubUKkqDUbSVLnqmVP5NuY9g+uHVlI=;
        b=H3jdkIKnAtm6qZ0a1ppthq53LN7t9tfjlWtsrMANMX2X/a9UYYcXo02Jfbb3zcMUQM
         QbQoLK4MkpUgsKLH8qZN4WFQ82/NUcxX2Pqm/FZrFwAKFSuB1VPvnPh0jC/3Zq5ucZVP
         XDSxrIC0eP9EQlZBbLUnWqVHWMYMnJ1hjdF0jlnJGqTgJQ/SWHCLeyhQyAvCIiwCbfm8
         5AJMwfB38aqcaBJxBbDQH+MYdWgMYGg+2qQua2fp1zaO5biIWaBHvX6lr3r6noqUl5v7
         6WU4NI5p29bC76pBUFh4MI66TPFVITyTiRNE0gIq+tTD6RjbMsBDwU5UHkBIJQBIoGu0
         OSQw==
X-Forwarded-Encrypted: i=1; AJvYcCWrt532ozgGkNCrNy185MnBTRoto6wdKh96MjwP6L9cE5tHRf9I11MAam7yMgAh5gNYhHqpPIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnBhPb6/Yc/8p3vmodeckRkrr7ghnQajoPAj4hPzfXRWRg3nr
	Fx5pQjpa0dDPDXfjd1hd66HfVLjAoo2LDj/+bAgixWQbvStH1+cG7RklJTbQ7XX7aD+UWFq4QS/
	tmpvbX/uI2QQK2lhztgqu+D6SwVo=
X-Gm-Gg: ASbGncuRmp4ZLfDdipL8JGioZ91JPy1h+xVJU4bO5yBHHY3XXf7kKJShhVUH9hxJOZz
	OUmEE7ZR3qQbPCEHgwTOoFPk9A3t8aw6n8TN3S9HyzFGgokUZ8IgSQXyEa/luqikTUkEJ4FYDx1
	Vii9QODfKuLA1fOMtupwQe57lUTZMnbg9d6/JvtA2Se1UEnWI0B5JAixOwWA==
X-Google-Smtp-Source: AGHT+IFiImGQ9hNzP19ORUvyFmBLx2u5M1vOAxyM1NmZs6HCjkxGHCojTLD/acZjSzPucHqeYJvtSQzp1giksQ4TSog=
X-Received: by 2002:a05:6402:40c9:b0:5e0:9959:83cd with SMTP id
 4fb4d7f45d1cf-5eb80f705f6mr5610683a12.21.1742462465794; Thu, 20 Mar 2025
 02:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319124508.3979818-1-maxim@isovalent.com> <fadfb5af-afdf-43c3-bc1b-58d5b1eb0d70@nvidia.com>
 <CAKErNvrbdaEom1LQZd6W+4M-Vjfg+YRzgEz3F7YWoCXB_U+dug@mail.gmail.com>
 <fe4b2e7b-1704-426e-99e7-da55375b676d@nvidia.com> <8a92051f-8169-44a1-a26d-85efa71a5e31@gmail.com>
In-Reply-To: <8a92051f-8169-44a1-a26d-85efa71a5e31@gmail.com>
From: Maxim Mikityanskiy <maxtram95@gmail.com>
Date: Thu, 20 Mar 2025 11:20:39 +0200
X-Gm-Features: AQ5f1Jpo5NQTsdDMMm6pIr-ijyIQR_KzYf21hr4OUlSE6tMA3mUF9o2nLP_suRM
Message-ID: <CAKErNvrnTEDNg+Fi2G2OyZuv411YRX4ELd-R-91sS4neHcB_kw@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS context
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 10:58, Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>
>
>
> On 20/03/2025 10:44, Gal Pressman wrote:
> > On 20/03/2025 10:28, Maxim Mikityanskiy wrote:
> >> On Thu, 20 Mar 2025 at 10:25, Gal Pressman <gal@nvidia.com> wrote:
> >>>
> >>> Hey Maxim!
> >>>
> >>> On 19/03/2025 14:45, Maxim Mikityanskiy wrote:
> >>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> >>>> index 773624bb2c5d..d68230a7b9f4 100644
> >>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> >>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> >>>> @@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
> >>>>        case ESP_V6_FLOW:
> >>>>                return MLX5_TT_IPV6_IPSEC_ESP;
> >>>>        case IPV4_FLOW:
> >>>> +     case IP_USER_FLOW:
> >>>
> >>> They're the same, but I think IPV4_USER_FLOW is the "modern" define that
> >>> should be used.
> >>
> >> Yeah, I used IP_USER_FLOW for consistency with other places in this
> >> file. If you prefer that, I can resubmit with IPV4_USER_FLOW.
> >
> > I don't mind, up to Tariq.
> > We can followup with a patch that converts all usages.
> >
>
> Please keep using IP_USER_FLOW for consistency with existing code.
> We may converts them all together later.

OK, sounds good to me, keeping as is.

Thanks for the reviews!

