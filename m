Return-Path: <netdev+bounces-77683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F6872A53
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 23:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F59B2723E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 22:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AE7E590;
	Tue,  5 Mar 2024 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uz30EHnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18191862F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678547; cv=none; b=TxBPvod0JTfWnfw/i67eSDXp9C+3pJUuqW74pBM+EbCZ/vKRbBefD+Ie41ziJoAvIS75yXR8OffmxaHKbnVgQ6K68qDYaTPmgx4P95oIUUsVYBUFyyl/klQ7XdfY54+ILG4XT7A6P1VqmcRG5UfHa10heP63Frziay0JxQ+BJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678547; c=relaxed/simple;
	bh=Kla2R5bcfkPkylWdIGVABjeBtsnshT/GLsxGridt7Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaQRJVqTCtXz8sKKTbyeOmaiMSQ5capVoWWVdp70X6AevAOU9enSWycr8kXJ6JL67LFr+F7IPhkxcVa656IUiXTZtJ00rNNTc/yO+4LMO/Uu/+H4bltNd5kp5dcx3SMq5T6+jkUJIjgGcKmXzEQZUfOKkMvptJwMnxazBrJYNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uz30EHnX; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc742543119so6311832276.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709678545; x=1710283345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kla2R5bcfkPkylWdIGVABjeBtsnshT/GLsxGridt7Qg=;
        b=Uz30EHnXgL4NUZASHqK/PqkK5NhT//dXPGTvlHs7BxPo7ZOaCovK3EzbxEDFbuZJjm
         S5ty8ErsqAnztmN482V87In5Erc6Hw+UalRdKuoI9Kg92qUzSsnCgPIU28qsBiPl2++a
         SG1Dtcjzk6ZGRdPauq1AziXSfAUHaIX9/Q3508lPGUEp66+RS0uzLYkUzqmDMQV8QN7Q
         BjK95qtF1S6phqRoqx6qbmldzN8/MVxnCbmm838W+xPKh/gwkIKWRY3/l/HprpGQ1SFa
         PbAkqzarbWLbSG9JPkjiGe+ovVPCYP8fPYaE4vDYqbqE4sRJ8DyEt4WEIT07NOmrUz0C
         nW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709678545; x=1710283345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kla2R5bcfkPkylWdIGVABjeBtsnshT/GLsxGridt7Qg=;
        b=d56F9HD22E1VxLauH/2NuuwDuaNVLQiiBQpikX0BtZK4AYuVob3hUQ6c6/N+SOxH2F
         eiTxRMbKD++vh6mBiSFv7JW0vyA+7Cb6Wnte9JDL4XdbewRLmK/0npWojFSkvqLZdamf
         hkI72VHfn8YImvDhY50sO5STyPgcf0B2U8Ofva21r9PuOBhFYNPsC0CuLGExhJn0tU59
         1xbjFdbGz3ojFBBK2+CvIJC7hMThEjKMx5YpJGxrU8KP+tAb12SZkE5plGICFi1WTbiO
         TiVf1dNnSqgk3bXrOSijyQCWPcUzslZ6j0anzVhTn3D/BMSpAQydEW4mK/maUS9FVFJ3
         LZ5A==
X-Gm-Message-State: AOJu0YxmJNGSPDSdhJE8BDKagwUxZDgO2/vPdlXOHXFj5b24g2gtcpzU
	XSSzUh2i4UHdQCUxUnrHJf4w1Rubeo8KujjPWf0zdUxy5fmjMMKtFszB5FqTye5k1KCJqKD3Tcd
	I8CuGYgg4/AGp+ckIREqJ4oEzinif5J/Tksr4Dw==
X-Google-Smtp-Source: AGHT+IH4N2Owa4TsElQeWkLDp0eXqWO7MZkEd6Rq0/nmWb7dSWHk/5oMtnM56ZClu8pvW+FdTVEgJ+wxMYTmVHVRzAc=
X-Received: by 2002:a25:9845:0:b0:dcd:df0:e672 with SMTP id
 k5-20020a259845000000b00dcd0df0e672mr9528207ybo.47.1709678544834; Tue, 05 Mar
 2024 14:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-7-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-7-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 23:42:14 +0100
Message-ID: <CACRpkda18OgXdbVvUVvq-un4cpi-EEfxyfjqoQas+=BScSB6OQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/16] net: dsa: vsc73xx: add
 port_stp_state_set function
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This isn't a fully functional implementation of 802.1D, but
> port_stp_state_set is required for a future tag8021q operations.
>
> This implementation handles properly all states, but vsc73xx doesn't
> forward STP packets.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

This looks like the best effort to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

