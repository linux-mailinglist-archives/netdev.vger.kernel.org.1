Return-Path: <netdev+bounces-243135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13BC99CE1
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 02:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5754C4E011C
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655EC19E819;
	Tue,  2 Dec 2025 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMTZi07q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1513C3F2
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640522; cv=none; b=VwNQXJUaj+KV0A2j0e0frPR9OzO22/rHrQafk3a618XjbykfxPIVpmrGz4sVz15NCjdKytTRR2cHZOMSbvEssiNV1+rI1R7BuHQRJfagjQXVD8GiuYaTzkUflLoEu1aIAzguPUv5QlDt+90EX+oIjWY4rscjQRlWozmdfEAQ3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640522; c=relaxed/simple;
	bh=t/U7b3jzYyNqPJPthFID2ueRnn3hV+8zALTT9I7QwfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZPg6gjjudsQEssTLpGP4h555wi5nJw2IO/caO0y5ZqUOWVN4zJz/BxQ1GBRg8lfOExyO4FpYos8ETpAmogPPV6f6uQvE46NurqD5QpSYfhNloK4RsH4YGFQPelU6EoN33xTLDbbkPi38aJdJCdsUGaW6Bv+UiRvr22NsmgpPns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMTZi07q; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45330fe6e1bso1612629b6e.2
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 17:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764640520; x=1765245320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/U7b3jzYyNqPJPthFID2ueRnn3hV+8zALTT9I7QwfQ=;
        b=mMTZi07qbo6aZc2XYcsa9to96n+vbwI4P5RpI5gt4aJkF/mYdRv+ZUXd0o19mK3a6y
         KGFJtNBrs1NqH12wzO/u8Rm425D3rteiI49Jk2G0rMdNLnuFfToDzqNpocuSDZLz8DBI
         Hv3OlI02zayrtdRowsIZ053WENyeiUzQ3GmyyDKpuJ5dkm7/aK/qDI87OXgknXablFmR
         Md8hVGLQOJFOuWhW2tzgBIOzPphB4g1RGDuUiIng/S72BrC+GMkbTUhXRu6XN55doUvZ
         ZPqa6KW/IdTy7xrSPkuPaqUSPShFI+RPryWR2IzNmtRJp4u/hL+myOlNKy8WdQND8Qvz
         ev/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764640520; x=1765245320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/U7b3jzYyNqPJPthFID2ueRnn3hV+8zALTT9I7QwfQ=;
        b=ZpDmjadOb27/XF1ki+fIxZTXOxhc/uIJSZBmGB+5LAk4pnN/C33lfknVkYRKcmSCOo
         l6XuVVCEx+qQoi4xxgFyJR933ucGBaV4lMW6xvGIL/tm+or7OokrRMn2kAqX+wUaHNto
         b5xLQAIkLGScuEju0xhsfQHFgQ06TK3eLPuaUkKF6fml41hnSVWGA3ViFWYBtpMXw4UA
         Eud36P0x9QeMNI4PR0o1i/jtZZgJOJAQqDPI0AJlhS3cWOCqNd+8KR6edCAxBuYqaCn1
         lPnWpDJknsbP/Fk3a0jEzg5rK0OvVy7Y633J82N+YvqHQuRB8Oyux3NT65NQE2UIFFEK
         Fqtw==
X-Gm-Message-State: AOJu0YykbcQPXV/a4FrEKyLB7EQ7ACyWIU5TX/0i7txwdEQx4zKb+uWq
	5tkfnjs49LtI//vdFZdD8iN8rb7N9ps9HYdueEJxvqA1u8RNRrA4JCQKq58zMUUmJCUB7A5tC4o
	eLj4JvAkXfjtAqMXRRH36EfnBYkNvIIQ=
X-Gm-Gg: ASbGncuoofsGoweE/CKzsh461QAJ5C+uUE3r/0jzd+5b6nXiWvYAsrmP8pMlJC3z31E
	v+HczJeSfQAdj0dw3na7vPGyPtQcYw4c6zGMyNESs6dxBmuOmLJHrNaEJ0MgGwsI5/daeESwcRf
	ZvOpFYmlNeZEBhN3Vofw+cCV6ekjz/loSwULFj5g/BqBpZ+YHKQW0veHfCllgXP2PuvKxhEBbPC
	tq8PQk+iFIponjXEOYzCrc5OaT6q6qIUu7JyRDsNfh8C9syKUUoC7zMC8icqN7JF/BezFY=
X-Google-Smtp-Source: AGHT+IGBW1Ac9LbrQDGXTEqBTPOHJif17rP1SVE932tLSg1jDtOySwh/+G8W4TJLAk9BrA1sj2mX0r3xWcUZSNt9TCw=
X-Received: by 2002:a05:6808:21a9:b0:450:abd0:d815 with SMTP id
 5614622812f47-4514e65deedmr12073317b6e.28.1764640519833; Mon, 01 Dec 2025
 17:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130074846.36787-1-tonghao@bamaicloud.com> <20251130074846.36787-3-tonghao@bamaicloud.com>
In-Reply-To: <20251130074846.36787-3-tonghao@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 2 Dec 2025 09:54:43 +0800
X-Gm-Features: AWmQ_bmAvqkgITUeYuiFjKeRRbyKE3k_A31wjvEsNgXj4qBrZBMFQGFRycEWtUQ
Message-ID: <CAL+tcoBJOuLCr1tvFr6cMbTjBOO_JRW__h4YN90Bxg-TComtsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/4] net: bonding: move bond_should_notify_peers,
 e.g. into rtnl lock block
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 3:49=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.c=
om> wrote:
>
> This patch trys to fix the possible peer notify event loss.

s/trys/tries

Is this patch standalone as a fix since you mentioned 'fix' as above?
If so, then you would add "Fixes: "" <>" tag to manifest which commit
brought the issue and then post it separately to the net tree. It
would be helpful for the stable team to backport fixes.

Thanks,
Jason

