Return-Path: <netdev+bounces-213942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33519B276B8
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33217B585C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1561829C326;
	Fri, 15 Aug 2025 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UTy90Jwe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45975274B59
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228353; cv=none; b=qyDC0wiimFdAWzovvBiPKVjj8LWVIq8dDsrBcauUoTla+cj2rUO9f7nuhWXWvlkP1aO4EuIioEua2i5jjvw+n20aE4reBfAJaSLIg2FSx7hpZWvRqaouqHz/kdUo4JnieyFGjKESBfTGhs7F+LQm93QdqcA7VuJRooLTgj+xqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228353; c=relaxed/simple;
	bh=PJdg2qnj0enHiTuyutu3+3woV8+hTcgzDCVgV816pbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqLpMN70Oy84D/Dnme1ulI6UjXhXnWj+KUhRq6TxNV/BgFo09Vk/AJdF7Z+iv2VAkXDwy4kC90V60U0ONA5ckXrpThTO93nUEHStS3sjl3qAOLNzxCSh48uan5J6NFb1uYXiuPS9hsvviEq9HKymih15EFceowTTtv7elDTDyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UTy90Jwe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so1246205e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755228349; x=1755833149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJdg2qnj0enHiTuyutu3+3woV8+hTcgzDCVgV816pbw=;
        b=UTy90JweiHk+QihDlHIv3C9zyQDP2jNFuoORTcldb3m/DzIXDysredFO4TFamtPMXs
         g/DSVFGgouORpZzJBb/m/OyXK1gYWwOB9dImTzBJWx5CIfavyV7vW3yUUyPoBgRRcbnF
         IVwy9Nz4E4vr2IReImGxIECqKcIG31yKvw1IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755228349; x=1755833149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJdg2qnj0enHiTuyutu3+3woV8+hTcgzDCVgV816pbw=;
        b=ZcMEIPb1ibY80iyGmqbv1nhWxhnum3AK+7Pmv9vErUY+eeOXCNKxXsypggRSnhbFmR
         YCu4DDDWnZnvh6ksskc0IAP14iWTnxBq+IhWMFsQlpWngbIciRTR279XoZ6iNp4doPHo
         CIiOrfFeUM77tpxdTzibOpHzm/CnLf2WkOOtvXEsc5ll868sPHBVIDAIptOlKiBAHZCn
         bCyfbxFJpdOzs435rYKKFZdg8Wm3qpV/agQqAM/oTQ2A45ppaJEtnsN0AlCT92m+qFzp
         EZZvYkLW6t/rGyWYWTfgS4jYXVQ7AUfzjlDQ9rPJKI0E0/lzpkRS3zeZy7wFAE0EPHyH
         //mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxnmLblShw3/CrWN2VMgn9XqRumvY5hf8v4mXlQR3HhiLuT/AYcdeqmE+9wxLaluwyH4T2Upo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLPyx2ZLtIG1vaRalQISyYeKB25iKCE75f0z1tHkisP0iFXOh
	56iW9HbHbx6IkP9iaOu47MSNFzwaaILrqxPOgVGOqSzzLXPw08ThIArKgumr4671Wr+gTbuiY1i
	BBUQ0gTcBkaLBAX1mJRwGXF5KcwXFxAW+QXKKYqbx
X-Gm-Gg: ASbGnctyQ+veIWOkjVGeGicTl2gVn/gLmQUc/W0rpfoP0kEK4X2EPhKSshUSgNZPX0/
	/ez85Im95ZbksddM8u/vWAxo017KdvyU7uWf43G967sZWv7ZfC2uhnaFx1q4ZHOStR9Zbi/Lq71
	dt/Ypg4rKhwCwNgZePU1RkCxB/XCpqmlmxAPl07DeyxxvmFgflQYykAuXIQqK9jurruMJMP4DBK
	lwaKkJ9OjaIJ2R52YNE5MPoomiygi+2YOJ+AYJxiXcqHm1W
X-Google-Smtp-Source: AGHT+IHML+FnX/LTF4Glnv3hTMjadeJlzca/Pry92PrR9MSNtfqTK7+3shW4DsnQEIw8uD+VwPOVAyVIaNye6SvIV90=
X-Received: by 2002:a05:6512:250d:b0:553:3a0a:1892 with SMTP id
 2adb3069b0e04-55ceea26136mr167317e87.15.1755228349428; Thu, 14 Aug 2025
 20:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-5-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-5-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:25:38 +0900
X-Gm-Features: Ac12FXyNFrgNnv9v_gZ4B-DIdoLeQQJfDCsM2y3l0UccKVx-_zcaQDAz8pYASzA
Message-ID: <CAGXv+5F4r+tN4vFVFcL5U=o2WrNZHUQN_VNTy=qLo4MKTrjmcQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/27] clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> On MT8196, some clock controllers use a separate regmap for hardware
> voting via set/clear/status registers. Add=E2=80=AFmtk_clk_get_hwv_regmap=
() to
> retrieve this optional regmap, avoiding duplicated lookup code in
> mtk_clk_register_muxes() and=E2=80=AFmtk_clk_register_gate().
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

