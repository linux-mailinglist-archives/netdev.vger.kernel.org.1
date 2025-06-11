Return-Path: <netdev+bounces-196720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE5AD6114
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA61899605
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0D246765;
	Wed, 11 Jun 2025 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNvIZSIi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6C2AE66
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676693; cv=none; b=adSLMEKC9nbc/Xyj32xm7KuM7quFI7FKcVJKYl6Sv7iJkPnUcSNI5fQm2XiFLP/Q7oCUeHdH162Bo+diwvI105MQc2Axa6h1A/5iAtNudx1nYsJr92McRNtubZKSYrEwdhyjRK3euVB7CIYmojeBv0bCFBbzVMexuyj7v/Z/YyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676693; c=relaxed/simple;
	bh=1Cxgokav6twNCBF6mf9lCWNKPp8jakXrze0vJXc/B2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5/d2p7UjbZwIOex9ro8s/yKfiQ5QM/lf6ZeOZuv127Fj4uQpeBbdMz4W5xBz6ZcpwMwBpqLaa1KoPtJTVA1B5QvMDabDmJkUvcAeQ+r/3BzMxUubOZNCPJOuHbyPJz0DT2v1jWUCPQiNGYzZXoTW+zNrfznUtBx2rXLCVMxoJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNvIZSIi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a522224582so178678f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749676690; x=1750281490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Cxgokav6twNCBF6mf9lCWNKPp8jakXrze0vJXc/B2k=;
        b=fNvIZSIiE7XnLbBHomuuO/m/bv5OHNMExFdN6aluFp+qM82VlfJ3oaO/RaT9hb+4nU
         tfLPOhd2J9P2C+DALCOTO476giZrkPQEo6IWSzyhqNHC4M/1n3WSee5IdxEyH1pLUq1n
         yOzdhXhbN4Y0ouJuOC8WnJ7yQLcdjn+lA0ZwX+hEaAZ1/lo0qOATs78pTsjck3r7XQle
         Ejk5pzYfKdGwm/pXUZu5QITy8kssISTsnc6gZ19phPicvXuh8K8IcwksP+6n/iXiRz3L
         pfKZxOA6gimX4IXrODwVWYRt4U9AtCFH1Zl6POdO3ohAIYfXEvA3tutLH90GgmTEYxj9
         3cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676690; x=1750281490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Cxgokav6twNCBF6mf9lCWNKPp8jakXrze0vJXc/B2k=;
        b=nPtZTELUMyBRRdArwjRekxOdhxkfJ2brjkEiEs0/BEgHqaZJT+gEEZHx3CRqpTL4/B
         hBk/sSH1mw1G6QF/hcgOHExrQp8vd3c+vF/aiLfPsfwghgOXhXxG65CNF1uRTAnP408i
         DZ84zMh7hPCP9lFqAep9LOnr63uf52kg1kRsvHfXRlKGbKuzXyXZkmlF+uvd7uIzqffm
         H26uyRJS6JY/bzTmnwI6vTAd3posYB31Sl35n/8XtetXDdwjtOKQ+ZbIWovn1JM3C5Wy
         aO+FjApa+f6g4EN6UGcqxPD72eurjMn8aXin0hkkEbp2nspF5AFH6OtGc+SKJ6Jq6ZwV
         DVhw==
X-Gm-Message-State: AOJu0YzXa1Ktg554G8X5oCiTkcNjfquxofK10daRj0mAPgRDGtnenRn8
	TqttnuZh+aUQCfndrqUSDI/loCf+2sLSEOiTs6+mp3XpBlE4RS/sZc6E+C/6J0x0xR2boSkW2KG
	r65OKTfdh4TBSsrxtE3KxMu2OlrYImV4=
X-Gm-Gg: ASbGncvpHAFisN3+zH47IYVrU5RsNosR/juC4fYYQ7xWqt1wbfKirk9b7ern2gJDSWg
	lJQ8vCio0+3kTnlGznSSwn36DajkPTpEiRygshiKOtFyhmEKYHn6lmOoecDiwwPoLrpTTSvNP2F
	RUOMLklx9T0eYY5QQG2+OSmGOfGrfX8Wp0NYjuo04a77E1S2lQBm+eBAcQxPMc7p0y/Q8LGmU5A
	Dzy
X-Google-Smtp-Source: AGHT+IEIXHxGtTjyzxH4TGwtRj9tndJfgL09Eok+RfxFR/LcJ1D63Y72/T9FL8ZUg22hkc8M3oj/EZrL1CFtRh7BgIQ=
X-Received: by 2002:a05:6000:4203:b0:3a5:1410:71c0 with SMTP id
 ffacd0b85a97d-3a5586dcff7mr3999331f8f.38.1749676689996; Wed, 11 Jun 2025
 14:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <174956708824.2686723.3456558312805136408.stgit@ahduyck-xeon-server.home.arpa>
 <20250611140032.1b95633f@kernel.org>
In-Reply-To: <20250611140032.1b95633f@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 11 Jun 2025 14:17:33 -0700
X-Gm-Features: AX0GCFs7oSZM-NfYj9e6mkNtoq5dacOykb_TWDV-5soQcwxKc_1DS81zXviqXNg
Message-ID: <CAKgT0UcgKprPn79=qmoztPgm+B8W3iouDhPZYRW0qvThVv-exw@mail.gmail.com>
Subject: Re: [net-next PATCH 3/6] fbnic: Replace 'link_mode' with 'aui'
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com, 
	andrew@lunn.ch, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 10 Jun 2025 07:51:28 -0700 Alexander Duyck wrote:
> > -static void fbnic_pcs_get_fw_settings(struct fbnic_dev *fbd)
> > +static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, =
u8 *fec)
>
> We get a transient "unused function" warning on this patch.
> Looks like the next patch adds a declaration in the header,
> let's do it here to avoid the warning?
> --
> pw-bot: cr

Actually it is a bigger bug as we aren't pulling the values from the
FW as it looks like I accidentally pulled things forward a bit. I am
running some tests now with the fix. It is pretty small as I just have
to not pull out the use of the function in the MAC code until the next
patch.

