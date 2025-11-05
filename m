Return-Path: <netdev+bounces-235884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0733CC36DCE
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FB168704B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6FC3271E9;
	Wed,  5 Nov 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcB+7zNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FE31A7FF
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360195; cv=none; b=Av/uGZCdyJJLDCrG2DrrkwJCH5xX8GR9el9zsqgD3wJHNTUa2o32poBvNcIKx+xj/pGSlg7SL1oaUOqxfCxoTp5ldl8An6pHmNAIFoROkqGZcm28/tpN5+NmcfTU8Q9W25ExzMS1YaASbaO773u70a89Qma5U/Sfj3wSoL2FlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360195; c=relaxed/simple;
	bh=jkgNn1+4jXuwy+ixaN/rtdNFuxUuVeolHm9PhEbPJDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quNHJQJy1NUcTfmltxZhYMRs4AH8KHKYIeIDWVOfaixwDPZBXjTv1Tru7OYdrWN1wA6DkZtU9Pvq1rduHIq/S6CaqyJUcYHU1bwAfXgL8AS7DL2vfsD03ONJUDGE7k9otCplKnDmQLl3lo4gMQ9SnwSwVXKc49QgVCLYLwMw9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcB+7zNm; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed69197d32so25268101cf.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762360193; x=1762964993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkgNn1+4jXuwy+ixaN/rtdNFuxUuVeolHm9PhEbPJDw=;
        b=mcB+7zNmAFbFw8VRbC/5zhE1reiZfvmRLnX/FHGT9RcKwHrB1V2sVLz/HGvA0ZI2G7
         lDaGtoyzA2FdHLSmEGtHSQ40ewjPTOpNIU4Eg9hyWFXqUjFhQp+sKAUbWVLLFxLeQ8+l
         Xd30Rd1UHABTEtqgrm5ACN9nQfq/m/gdHtKG9YIw2Bv8Slql1g/SEvcnz9jM530P5h7W
         b2ulslLTr+nvLikQCxZRvbM3Ys+Z/SQ1srmDTc0FqLVrC/HbUKdf+/yb49nW748lyg6N
         fj3+U/0pIhWcvXokkMD3es1g48bxCn0LuGRXNXYzWPBoAqCRgawExIMoqnjL4jqVT+9W
         F4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360193; x=1762964993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkgNn1+4jXuwy+ixaN/rtdNFuxUuVeolHm9PhEbPJDw=;
        b=W691+5A44ZlVBCFjIjGzLiJHHP8AUFYZ98Hit6z9uUFZZE6zxL7zysWMI4NTmr060o
         h0/EJsAXmjzdghcZyEEI0lEKMEF+xbw8SBtOGh22+skL6kN90N2HqKNVjNZsIvTU3GKh
         U9Mxvcz8hQFyflhRtFnwEtnDizgCm2uc4jAWQGuTBBqQtGUO4YIxHZjT+9MGNAY5C5Ak
         Fgq9ghF/qqHDBH2LvRqVuK22e110YL8dHwD5vQw4gTKHydDiC4M6VT5wEGF5hf5KiyIA
         /9+UHFoKzvblLSKRFtIVJbXUfMtNbLgSrlkt63by33WTvbVcd8CsrlI9259I2LbeSoB3
         QlNg==
X-Gm-Message-State: AOJu0YxQyO9CTiYFEm8tKRO2k0aLDa0+kgoMm+F/TRYwP/BSTO9Aepw5
	wF0BzI7g0I3firiLVjavPNMxNcL7PX1fsPMWeITmryy9dXMB+JrkSIu/EwLxI7/YCgvZeUseeEg
	072FK0a7kFqs8WhdnqGIBuxvaq6umw+il5MKoXf0S1ZMOxUZ31TohheEn
X-Gm-Gg: ASbGncsy5I4N6dJqT4+bsrZLSBNNCTtocvEbPs0h8adkUcBxNs/GRwrJ5fVFUp8oNEp
	18eOVk94H+5UFt/WXS9DWj/LxnlWT3y56F1vRJryXD3O78Z2IPgPTKnYrXF5VCzHImXmARYjQTs
	68ZUYwvfUiEgfgaa8sF5tL8e0j0luRtgpc0op6ZT3LCAziwx/6A/KJlZAsRVfdXtD0KpEDOkCXq
	xA+awT30Jb/flDa3Fe8KJOycq1BQSUWrOv7F8Dj12RjDF72gnuBMCTLbizfsBGZJh/zx94=
X-Google-Smtp-Source: AGHT+IEIZjVxK95nJsAKgH1Nu820ZsQt/RsaIyZg90c7rumoFU/fQN7xKpn07wzaK1Nz9W308QqU7P8ohGXGb5TtlTQ=
X-Received: by 2002:a05:622a:1455:b0:4ed:2f02:ab15 with SMTP id
 d75a77b69052e-4ed72602641mr43913211cf.55.1762360192504; Wed, 05 Nov 2025
 08:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com> <20251105161450.1730216-7-skorodumov.dmitry@huawei.com>
In-Reply-To: <20251105161450.1730216-7-skorodumov.dmitry@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 08:29:40 -0800
X-Gm-Features: AWmQ_bm-inBtiHZ-i-Ji7OzkBeuhYj48CizrYi-xeimRs0Xoxc8_UArrOGxV_kU
Message-ID: <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:15=E2=80=AFAM Dmitry Skorodumov
<skorodumov.dmitry@huawei.com> wrote:
>
> If main port interface supports GSO, we need manually segment
> the skb before forwarding it to ipvlan interface.

Why ?

I think you need to explain much more than a neutral sentence,

Also I do not see any tests, for the whole series ?

I have not seen the cover letter.

Also you sent the series twice today :/

