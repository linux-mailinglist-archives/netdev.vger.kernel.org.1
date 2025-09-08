Return-Path: <netdev+bounces-220850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B3B4922A
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF38C3A3E64
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204322AE5D;
	Mon,  8 Sep 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J5wBbnbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5B1E2312
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343423; cv=none; b=LvEALbdLXN83iAmVb4E3t3f4YS7EfCo54zFw+628Kr3DlTHEQnk1WM2GhK12HSooR+CiSfbMW7r7F2TIlur6M+dPur26Zg5SlgYlFuRQfwiQy41ZYM4BCZJoEZTse/eh+sXieb5RwvR8BjaqUMNZHGbR0PHqNVWNL1VjNDW7pdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343423; c=relaxed/simple;
	bh=nJ7sp5xQcOIa5DLqGeRJkB9n66pjV7vMzujgYqkfLas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc0H7Q4m0f0hfhl9TlkyRCihVsaWmdR2dOAB4vWDOS1pZCq2K0qT4YggPTDE/StOX1xkuB4W8QtcEZwUKJOoRI7YXPXLwuOA2SuOa3gymkNNBouqihS13kuSOhXxyaQY6cUsbbJwhCAxovgUq8AT//fSEiD1aFtYNZFVZZBtU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J5wBbnbI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772627dd50aso5950183b3a.1
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757343420; x=1757948220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU8FxatW81cOabetZiOcfGAPBJWCkAJeu5UKKc9gwyE=;
        b=J5wBbnbI4jZ+B8pq9EJrjFIgDUVHES5nE+lzt3N23vE/aCYUjB+/d1oA8U5QMlznbE
         jiP7DiBz7xA7p5GJtSzaGMI8hYkuePDfzZvarDnYxUuoKsgCPdgM7c/gP4T1YQImggX4
         1jmoRoIcuZidy/AgrErGtajIf3X/VKTwrMZzBVvQmH0/ta85WMIKsOamgvhiGySwSIT/
         lf7G8MWtqMtWIqDv+8VnfnB24vEkmW3rboSzekyTSF/YT+dB3WKzjgI11pCtxsMbpBD1
         2ZIEIxlH3W76yn1MJBPBJA/C1JnGy89RCmBPeMOxawFjEEmbJcrJQ3LOq1Ya4aw5jcfW
         BLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343420; x=1757948220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU8FxatW81cOabetZiOcfGAPBJWCkAJeu5UKKc9gwyE=;
        b=gJOQMz7We9S1NqojUgxFYK5Dn334tAHARa2hKTcH1MfTeDcVbEEvMb3Ppi7ZuVsVOm
         63kUCFAHe/4VBSekyIvgpJ7Atk2rgA4LUpHmBtYd9v0FA1p4dN+VpjU/4TaH63cRP4TH
         wQcnRYKSZFu4GtdXC7Hr/PO5HLxq4snK26MyKXLLvVtTBV81PrpTS/Qd8bZGCP0a12AH
         7gmrpRb2p1URuW6nnDsGT2mwrqOpB77Z+QxiZp268phO2+qRqdWDc9HxYPAni8pvZi4y
         q9R5Thh7nhxKFONrSHilYTkHSHiqfyxZGjG1OOhtren+EOgN3J5gFSjVxRGgRh7cNEXf
         NiZA==
X-Forwarded-Encrypted: i=1; AJvYcCXKP3MJBvLMQMnkzaLra7pbV5QCwHwcoixxdAlZ877bvXxgd05HRBAMwwEGmDupEzXouOCbCzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUi41NPrNbcBXKVZW1CXEsOFzx1LNp8O35QNuhygPtayqlWFzM
	VrfqINEiR5zbhqMxVuheOtSdK1l7dA6TThgBo6YyfOz3KxQMOs2HAJ1b/4J7FdKaAdn1qlOvJPZ
	DZBogOWuRiCgDOKU1Bq28IVTzGKqvRL2/cBF+vgnK
X-Gm-Gg: ASbGnctKescGmm9yxW5xRu6rx1CKtVCyBGkEdva/DX/dxH1Sn1g/WqwY4sViSwS6pWt
	wM3XYMN/f9HuLs04uxz4MvgplUp7L7o8Gx4+SoW7bYIIMLZ7q7+fZ2NoGqfAFmDQXIWaWh+majn
	uiQ0Tkh9PWWGEDfJl/J9D3svSgqSGCtN4Tp8dky9c0yiJsW1fw1eztQqejYqSAwyA806bwOJQWL
	Bub+PTKK5ClMquU/Q==
X-Google-Smtp-Source: AGHT+IHOVwJywUKXVFutEZ8uan3V8oZIgGRcqfvtWr1hHJt7vL5KC1U56eIkh1pmMovIBzN0ULcTJNffb/AaR5BhD+o=
X-Received: by 2002:a17:902:f681:b0:24c:aa17:e727 with SMTP id
 d9443c01a7336-24ceda27231mr182105095ad.0.1757343420515; Mon, 08 Sep 2025
 07:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908080315.174-1-chenyufeng@iie.ac.cn>
In-Reply-To: <20250908080315.174-1-chenyufeng@iie.ac.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 10:56:49 -0400
X-Gm-Features: Ac12FXzMxCDiGVcKpWfmBpMLNILN_FwCYkHPZESXCrTX8f1O1nIdp4ZlI0e5x2s
Message-ID: <CAHC9VhSs8fi4N1BkF+n8MQboET7sXoVbqVQuKEWB+Nxe+gf7iA@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: Potential null pointer dereference in cipso_v4_parsetag_enum
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 4:03=E2=80=AFAM Chen Yufeng <chenyufeng@iie.ac.cn> w=
rote:
>
> While parsing CIPSO enumerated tags, secattr->flags is set to
> NETLBL_SECATTR_MLS_CAT even if secattr->attr.mls.cat is NULL.
> If subsequent code attempts to access secattr->attr.mls.cat,
> it may lead to a null pointer dereference, causing a system crash.
>
> To address this issue, we add a check to ensure that before setting
> the NETLBL_SECATTR_MLS_CAT flag, secattr->attr.mls.cat is not NULL.
>
> fixed code:
> ```
> if (secattr->attr.mls.cat)
>     secattr->flags |=3D NETLBL_SECATTR_MLS_CAT;
> ```
>
> This patch is similar to eead1c2ea250("netlabel: cope with NULL catmap").
>
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
> ---
>  net/ipv4/cipso_ipv4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

