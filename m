Return-Path: <netdev+bounces-129837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4DD986724
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB191C2131B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453C013E03A;
	Wed, 25 Sep 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC2hG0d2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F07483
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293611; cv=none; b=Px1o/cYNAGJ9iTOWBEQZIgmfY1ZV6cJ4SIvfNOgP0fbyrtdJ8ikHx3qIpVd6+YI2nzVHahTNHP5hga/H++ljeSNk1HgR3nlAYfrTYNQ2/5KmJLioh7z8xzCjRBP+z4QxzX8jJWQwZg05efjLf23HyQJxQL+mIJuosk/LnxykHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293611; c=relaxed/simple;
	bh=CjoA6H3JUQH02K/LxMTeks1Zry4xj4gWtROtwrz2Iyw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EaKIvi+eUZWlzdhHjKpIdHfoaZj6agqzoi+RgsofUTjwfosHW/PydwFpjCUzVbmWTJlvMpdm6iXul5/Y8gtgq3PHY+kz8R5hEGNyp1hrgnr26ra4Vh0rOE1OOoUgfFVr37f9D5BLc+TOVzzuc49u0tW7l0bQdQGP38dJANLCjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC2hG0d2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a93a1cda54dso32148766b.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727293608; x=1727898408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjoA6H3JUQH02K/LxMTeks1Zry4xj4gWtROtwrz2Iyw=;
        b=OC2hG0d2iDg61FHzdn2ulJ4GKco+9nN/hKqqQrlky5K2F/AdgkTl+ibZo/qeGff3z4
         gdF/UA2MDt/97OjJ+xpwYcAPqjK309ldIiNTwVplDnzxH4+7A0rRkZCvbl7i+gfHgc1n
         443nj0zGkTQUSZ2+0P4t8jbJtMM8aNmITNDThG5AX+H12v68E/McZ/NMbE0olMR76x8r
         24q0uvBIygpbTmsNaMATIyR/C2KEE6gwT3kDckaWWWgmwRkUvzsJl8qyC+m402PY0IMN
         TpN7Jel1QbbDeHTLkj2fDHAdswHgIw3v6Ec7SUXBDh3XuLHQDAGxuKwVBma4mxSPWgdZ
         oSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727293608; x=1727898408;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjoA6H3JUQH02K/LxMTeks1Zry4xj4gWtROtwrz2Iyw=;
        b=bjD3DOq29wwqVYTUNP8IRpME30nCAzBOxl/+ytKx/0MKoybwYFCTNDhipPEVTC1JsJ
         d+MGOqjNksPljSObpk2S7mY6FJySq4KSNNcWwEFtOdIFxba/tMduVoC4Z6EqfHlKeXId
         jwpbWUJRTFifh9MnErWn4IMLVVTOPeDQA+tQJTwmhf/GcWA/tQyNXqZzuJOpNmjeRke1
         pCB6aDe/2YcWBRjicVlhYgRJatjYnU1rhEoTKmN0P4/hMH3kehzaZSeM44H9REwPnLk9
         +5DJzT0pT2UkY0m8kPMa/cU+n5KCaedWNmZTw3ym95WtHsWEz2IJdISq8/WkPozeTgb+
         wkog==
X-Forwarded-Encrypted: i=1; AJvYcCUyuONEtp/yEAPB2H3BDvvxuaWyPr4OoyNjA1VgG6rXTfRfs+/i3WpR/coaYd08SB+H6MhSjxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHaYItstH9zeWnIis9Qf1MnijgDtZ+MBwtmyoHv653zZMG6/qe
	sIsZPV82xEd7g3di916tlsTgsvrbjv8zAimgHXjB8GYI1tFEbfCC
X-Google-Smtp-Source: AGHT+IG5ReOc9rv09kiDuSfe4r4ZkWfl6NIUsoS6N35u+WriEYTKFtsbklQYKPml6Bw1W3x8zx6RCw==
X-Received: by 2002:a17:907:f1c2:b0:a7a:9ca6:527 with SMTP id a640c23a62f3a-a93a03200b8mr351443466b.8.1727293607519;
        Wed, 25 Sep 2024 12:46:47 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134bd2sm251102166b.214.2024.09.25.12.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 12:46:46 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <8e3fcb81-0b3f-4871-b613-0f1d2ed321a3@orange.com>
Date: Wed, 25 Sep 2024 21:46:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Massive hash collisions on FIB
To: Eric Dumazet <edumazet@google.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, nicolas.dichtel@6wind.com,
 netdev@vger.kernel.org
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
 <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
 <c739f928-86a2-46f8-b92e-86366758bb82@orange.com>
 <CANn89i+nMyTsY8+KcoYXZPor8Y3r+rbt5LvZe1sC3yZq1wqGeQ@mail.gmail.com>
 <290f16f7-8f31-46c9-907d-ce298a9b8630@orange.com>
 <d1d6fd2c-c631-44a0-9962-c482540b3847@orange.com>
 <CANn89iL0Cy0sEiYZnFbHFAJpj1dUD-Z93wLyHJyr=f-xuLzZtQ@mail.gmail.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <CANn89iL0Cy0sEiYZnFbHFAJpj1dUD-Z93wLyHJyr=f-xuLzZtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25/09/2024 21:25, Eric Dumazet wrote:
> On Wed, Sep 25, 2024 at 9:06=E2=80=AFPM Alexandre Ferrieux
>=20
>> [...] why are
>> the IPv4 and IPv6 FIB-exact-lookup implementations different/duplicate=
d ?
> =20
> You know we make these kinds of changes whenever they are needed for
> our workload.
>=20
> Just submit a patch, stop wondering why it was not already done.

Sure, will do shortly.

However, I was not wondering about the history behind net_hash_mix(), but=
 more
generally why there are two parallel implementations of FIB insertion.

