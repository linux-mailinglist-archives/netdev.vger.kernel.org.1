Return-Path: <netdev+bounces-136151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC109A08F1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01261F22B6D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A8E208224;
	Wed, 16 Oct 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AO1Pgs59"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE8207A3B
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080062; cv=none; b=ByOjdd1mVVun4NHXbBDvSPX+v1IoYOWACt6bo802bNVfwXqJcPrgVLy2LHYs8W6QP8JEaQkz49VYijxJ7dzLAehkvffCTEgRA9SWlVuOGc/7dzBpw9SjRElSkA9K9W1bUJVuscAfXlVHR2N6ZcT2eashIVsamWz1LECheQpWKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080062; c=relaxed/simple;
	bh=0Lw+Eq66P7NfS44Lso7KYw34p/OzXMsJYc26nL52TW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaXSGoq8NZBuFkHpD8UAiTaFknqLA59DWWZPZa99CjP0yIA8PjQPh90flbhCY03gE+LRIQoSpB4B2VsRNcwDDgMX0mlrDMCmtQgqqqF5Z4j1Mq5uLEzPj4EOMczOxZv1XHZAYz/zwO1Q+hEytVD62PO3axdFfOzF758G3DtMZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AO1Pgs59; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so5004356f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729080059; x=1729684859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lw+Eq66P7NfS44Lso7KYw34p/OzXMsJYc26nL52TW8=;
        b=AO1Pgs59rIKTTpvzLJLwZhhPZngoD4fv1iuB5Ftnwppsm5zNvEmMBkz2lKdzwAUpHm
         OgNqyYS1Mt8UkHWJy5VIxh3i83LKO8KEkVdsPRj93c25epvGG2CPg3liMWVZLcBzYb4T
         uOm/jFq+xS4RRm2dPExTDMAaP/hJbxahuw3EMHmQWv9z0Y7PRVmz4HcO/PaNHMHT7I9g
         XTn1lNd5/h/5FHRdj5H0csYFKgcBlVV2/1sr+L0JDbAFBqGj9t7NPqGZBdiP7xNSChNg
         Q8hpGGkzEJ9zZakz8IUY9Lp20OHAMeVbkX2U/IDac/ocX0Ri+USy5YkuBkZkWBYwS8Jm
         7iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729080059; x=1729684859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Lw+Eq66P7NfS44Lso7KYw34p/OzXMsJYc26nL52TW8=;
        b=paTXY4QprCa1kep0KerXh9oia4ZJqfddTDBZyZw/Xl1e2hUohvNFn4vdVPPvanRsvp
         avBQwcd3NWtfY3WiCwOTcbfXY6vcIdVFmXk7ITMDj+gtOIddWC08UlzUh4G2iGtJBz9B
         Nw9CHjl3gaLugUi2Km5GjPZ56agj2YTrzISABRNQUjtIqfrWpNUig4+RwfbrLekR/GXN
         HF1zedAD4xggeV76ZPLfLcE/A6paBsrtN57dylVyvcOAwLzkHP8hB2myCPly01rSeCjE
         +s5llYBMvHaAETpKMuYwaFNucHs8cBa3Hv/pmHOCqfS8h4NIbH3Gg+sbwz6ztm4qQ6sK
         glfg==
X-Gm-Message-State: AOJu0YwP2+6alggoFYHgC5C7lcPVfFbqwWUJ4Ee3Sl04O4QDoAAn25Tu
	WLa72V4stZoVr4flwSIVQ/pUD6YLDnQ5E3F3/pTHExpEik7iV6f1W6/LZNCInkqK1huedMsw0zF
	Ie10crYYesapdh9nf+BMvIJ61YfMmE27f3uycd+d6f9ukZ9JBVHKU
X-Google-Smtp-Source: AGHT+IG++/cNgr19EfMpH6beYBtK6fUiWPKsTgxPAigPR59gCZR0fTXiXujH2g2pJV49ZkvbJ74JnUmFlRl5KtJgjRk=
X-Received: by 2002:adf:e54e:0:b0:37d:45f0:b33 with SMTP id
 ffacd0b85a97d-37d55184ae1mr12139641f8f.9.1729080058727; Wed, 16 Oct 2024
 05:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-9-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-9-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 14:00:45 +0200
Message-ID: <CAH5fLgiuZf2jzhtnJLVUHjDMLsj+xXcME4Co=hH30u-nXeQDEg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 8/8] net: phy: qt2025: Wait until PHY becomes ready
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:54=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Wait until a PHY becomes ready in the probe callback by
> using readx_poll_timeout function.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

