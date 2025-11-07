Return-Path: <netdev+bounces-236609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B15C3E5A1
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 04:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A64C4E32B1
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 03:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44861C8611;
	Fri,  7 Nov 2025 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVgaffeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382118027
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 03:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486502; cv=none; b=dOvIpK0c4LSbPlaUcCMdWlgG6wvkJJpMNikMj2Xg1GtVG6laqaOe/VDqZxisjcjPNEWS4JTnRKpOwjzgCyezfYzcjTti8TYuI5mdAucn2KeKDXZAsNNwkZNXW1uskmdf83qHMNqJxbzqXHlkS5laMpw7OCeqavAoxlf/HMBNBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486502; c=relaxed/simple;
	bh=/sdZ8+zzSN4+VevI0KHO+cKwje7e1ceK2OpOYkJQVIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8YQHHvFBgE9fQXCAtcl0e36AnJHL9w5A54NljlV0bMfistJLv3Uogfaz1avIy2M6iJFfNqEUDuUrW/Z3JtemWjHpoLVJL3QMBCdUi1+qK0YU/el+eyTD/SQDop11XJwGYbiKodKw01elWIsI1sBsvJsy8PfBB3fhPo4mZ0lfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVgaffeO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-786a8eeb047so3051097b3.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 19:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762486500; x=1763091300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sdZ8+zzSN4+VevI0KHO+cKwje7e1ceK2OpOYkJQVIM=;
        b=hVgaffeOwm2jWKVawg5d65K8HRPxDR8c1ZpEb7OgWxQ6NeLAVX64e66pzS6RlJ09dG
         NK0OW2eG/H8fpNitUyQuJu9plu0NdP/Os8pYFk7ZWgz+3cYX0vtOCOoFe3tX8fZCQpsA
         gdS6eRDsv3f1Hrp6Twl3vFbs5LLkqlWE5C1OkPLhBT7VBKjaYtDf4sI2k7X4XDRVwJE3
         G0WUL5o2HrLFjWj2nwoqLjSBAN8H9lpeW1zgbqzD9qbOyr1YwJFi0ppi4O4tetx7vOrF
         gF7h1mG/m7qks+2TZCvEp3Y0yRuR+zt2P3nX+8Zc1dC5FtBvj8+GI3QQ1ZFWqkL12raB
         1/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762486500; x=1763091300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/sdZ8+zzSN4+VevI0KHO+cKwje7e1ceK2OpOYkJQVIM=;
        b=cZo7kyg+jWeg5BkWokPTgoEsIZUNNeI7rd+Ioy7jp3zcVku3Ieejz3cM1ySCWLydQw
         2dLdiMLVd6Nud78v54CMyikcjkA/yfq/ERmX+/L8apxC4//2CAGzhdxR3LAxg3+0ni0J
         x5n0/0KJ4pNhfS0Tn20pbMf0av+FouTI8NuGG2cALQ2y5O3kRVz3xOv2NXKI8dtyiHEE
         Bb6TcrMnDWv8jSrSfW/87QohzvQRij2SCskrPcc7UqA5TJi/8+Mi+IwaCWoMwVic4+rt
         ZszGsbU2k0r+8TYfs8W4S6Nus3rhHPf1hSximdPsruezAHmfrJ962EQnFZKybwCIUDQe
         11qw==
X-Forwarded-Encrypted: i=1; AJvYcCV5pGulxby4+ILOgaUr2ls3QHGbcXKmIiSAoLjIZNAyWBZwWPFYNQuf9Aw2Qzy63sGYOu15KTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidNbgr8H1AWHcZQxMdxWWRXXZvhOLpuG6cS9AdLbXL7IAIfP4
	IHOc/Inlql/e6PPj4+MRCt69DiuS8Q0ndIa40DW/CSVmXO0ZAvN9PAU0vH0C2/ptm/Z415qhDyw
	4CE2KerCXICLkemWNa7sa1VP1UuJ+n68=
X-Gm-Gg: ASbGnctgzLFWzQh5BIiew1XwHTCo/8eSJPZcQWWWLM1+KCg9EUjKYtsvucq01ouTWjJ
	b7FVNUn6k6m5qbw7Ku+uGWJhGS5tBtLyhZIonRWJh+7jOYz5Y28iNwKiwuwl0UyqLdFvHFBVvBt
	tCEXbhwqdgESbEpzNg61KVA8WttT9afTRsiZRSXI6DDIxDYvPkTEdtHOKnw5K4HU3KDBezv3vq9
	iW6jZbY24KX2DNAaJuX0wlYIwOqDmw5m5z+YavwS9QvByao90LaiM9UFh4iGllHW5XVztLMkzTr
	s9WWP8msrS4QhZ0b5f0TcWiZpFjH
X-Google-Smtp-Source: AGHT+IGDDqqgBqEgNOx4AELZAJ4xLLz45gA1UT45FyOO8v0dFg5xdJ6oOobqThWQoYeziLebEVo9RMmVybURSqYFTCM=
X-Received: by 2002:a05:690c:48c7:b0:786:61c6:7e5e with SMTP id
 00721157ae682-787c53ab9bcmr16461667b3.44.1762486500242; Thu, 06 Nov 2025
 19:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103031501.404141-1-dqfext@gmail.com> <d9b8ec8a-f541-4356-8c42-e29adced59c0@redhat.com>
In-Reply-To: <d9b8ec8a-f541-4356-8c42-e29adced59c0@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 7 Nov 2025 11:34:47 +0800
X-Gm-Features: AWmQ_bkkdncyWIw-Q3XtM-gpdPTe01VHbfYOl_wXWnzhLVqHYoEvskEhg06aKs0
Message-ID: <CALW65jbNbnDJkHA5imp6OR4MST7=G1XMQ3+ddQ38YuQThuKMLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ppp: enable TX scatter-gather
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 10:19=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> Instead of dynamically changing the features, what about always exposing
> SG and FRAGLIST and linearize the skb as need for compression's sake?

I was thinking the same thing. But then we also need to linearize the
skb at PPPoTTY drivers such as ppp_synctty.c

