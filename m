Return-Path: <netdev+bounces-244327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F29ECB4EFD
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 07:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 476D030062C9
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 06:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7932882CD;
	Thu, 11 Dec 2025 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqPBrMno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3C3B8D47
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435978; cv=none; b=dZ01+1c7TC1mTI/CXRGBadFGmsxRhkG04IBgxjQPPkuPCoS/0EL/9eYjAqc73nkIGWC5D+7erFSaBqWaZg4pa5fk5sq65eSBC2NT9Ps5pw2Qx9tyU8BjwENOmyJkuIDn0hcU36xx+HRMxMzZALlU3ER/N7cPoS0in9B9CK7ftXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435978; c=relaxed/simple;
	bh=Kzvg3heMAGQb9TrZBb+zPfMvuzdlX6Ug94vaIzWp6mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ILtdjs71Uz0ot0wdIifC3G1MJsZeFvxoM4eY/RYq24+Kf10TSMdeO8fEOaRBiY6pt6rofEVlBzB0T6TxiaXT+mYgTZKWI3fWwZGZUxZvDGhJ39ZnhVLqOc27W0YoszoGQuvogz8bO1vpcOuOLcYyu8GCyy1HEw8IqSD12ysiXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqPBrMno; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so373643a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 22:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765435976; x=1766040776; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kzvg3heMAGQb9TrZBb+zPfMvuzdlX6Ug94vaIzWp6mg=;
        b=QqPBrMnoyUc8kcEj2x5qiVuX1XJpTy5to9jDTQcwYtfUiDxCJwQyl241MUFmR7OW44
         RzsRzz4vSKJCb4SgTwtdGPMLPYc2WYoeMdxxlLYOXAQimMt9TOnenke8dZWSJIU4O4D0
         WDJjW3ftAyoiSLjx/3Pc/Jbgea3X9FV4dVH+V8uhTFSqFCIr9mRanz/P5EGI9C/h09SA
         XPPKNGJHm+iIBh+x8cIoUwINCjHlNK7Pvtukb/oKTOJeXH4swjaxZbor9TS3SUh804Su
         h5KFUbm5EL+XaI6R4fNk68/UQdTrdTNR+nONbwi5LQccIDTmv8DKCmIiwbPEbInccyJt
         hEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765435976; x=1766040776;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kzvg3heMAGQb9TrZBb+zPfMvuzdlX6Ug94vaIzWp6mg=;
        b=Uy/dQAm9kdrk5vyRcIhw+m4XKXiwrspuXmq+OOewcWKPjUIjoBa22yj/VTThvJinv2
         IVwQDWGNvqd3+eFTFHNRIe4KhxA4p/VH24T1FeUfb6ySdrxa/MsOXNVdkC7L1+POmbI5
         L+GSCGWoUAPs9KJBxRIrsiJJKzQHeK3yi75cRGAfCBz0Hmd6PgodrbSovQPAyLLplafN
         zpLLoCaclkC/0OwJjbKP5yiqRnqLCXKj1C+0ocSO3Qasx2oIPwZXbGIo3MC3XNy5N6fx
         mUxu7VfgXsQHAYDielqoWB6s3oZodeAZAqPxGWLgBi5pIafcPpBOXrYf+6h+nnBTB2sp
         S5hw==
X-Gm-Message-State: AOJu0Yxatjokmetpb5EDMVzpj0+Os1Er8Sp11fLC+wf9nh+4eM6dcU8W
	Sw1AWG4x82iZsrrhsPGPjD3+1N4/Fc9Bd5z0Vkvmv35frKez4l6iD4uIm8Xep5gsNbc4+9JWrbD
	KeTAjUhn0YqC6tz/YLCJolcfIiF/JBwWvVzBt/aZWEw==
X-Gm-Gg: AY/fxX7Ao1zJndxA1sNS5AmtGZr+mAxiDSDMutp3MmtV3xvpqa35Lg5aZuQBIUxedid
	qmvciR1rp2IYbhA/UOITcyYJZronOid+DBqPFrPodTvifZfj7gT9F25RQcW28U7y2PEhmCm0qXL
	bnTcYTEodl+dQy82IJwXZwXIMSrA3xw6plgVJrl3gDQRE/e6q6YYi/jpDIAFF4QmMwHnipwZCOl
	yZlyOQEsmeLtegnjeg62WJsg5K8xZlQ0lPxtF0xR15px7vwo9qEEu1l
X-Google-Smtp-Source: AGHT+IHCDUBZEqNCx9waE0FMJY3oLGGDjW+YaFswPyRCureVymx8nJ+A5DfrVaNCl6zSeRKgddRkD4IDPUf8KDJYjhg=
X-Received: by 2002:a05:7022:213:b0:11d:fcb2:3309 with SMTP id
 a92af1059eb24-11f2966a276mr4192833c88.4.1765435976447; Wed, 10 Dec 2025
 22:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211014246.38423-2-enelsonmoore@gmail.com> <20251211064620.145269-1-enelsonmoore@gmail.com>
In-Reply-To: <20251211064620.145269-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 10 Dec 2025 22:52:45 -0800
X-Gm-Features: AQt7F2qGxII_c9JRcdQdt5uKcnwl8BrOw8snp8DlPg-9fsxzvxZ80uCkn0UWVUg
Message-ID: <CADkSEUiBcf91fEcveYEtEjf15sTSPwZBfvdsDvMwtrF4v5k7gQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scsi: sym53c8xx_2: remove code depending on
 non-default values of macros
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please disregard this message - I accidentally sent it to the wrong list.
Apologies for the inconvenience.

