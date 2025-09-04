Return-Path: <netdev+bounces-219771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A64B42EBE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704085680F6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D063F1B4223;
	Thu,  4 Sep 2025 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjCqXDKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACF3D984
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756948644; cv=none; b=tFVEaUT0Z9XF3M9iYmfp1v4x+afnkP2iPXd6O6y2V1SRJ3w1DbuU3BUAmdaaWqWqjuKyUWIsyaWgkPrHD2ks3Dcf9mSZw89EdoUsScosxp+L8273I0O9Usj7+dGnYDw+Af8jcc8BClQFqVKz78/VWf9OhQd8OEtizmerW4fzekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756948644; c=relaxed/simple;
	bh=8WHvKqvvSEubjuAjLqach/gWo8VeUE96OgFtsrxG0zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/gmLfvJcy3O4R7pl2v14t+cz/spEFqwd/PG7+sEI0awvmqVLE1nkQsExBg5UJyRaBtLBA7gPQ97iK4+tkatFMvTCuXav9qYjROc5EtAF1LDGLYwqFQMxiJzHBcZHH0vYW4U+8DgbbravA7aQQ2EukS7o/1YGhFc8bvzfkKIKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjCqXDKC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so5513a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 18:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756948641; x=1757553441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WHvKqvvSEubjuAjLqach/gWo8VeUE96OgFtsrxG0zY=;
        b=sjCqXDKCHJLkX57C1R322AwwlPTY1QdFRIEkjF2JXSFpTHZ7/DXxV/d2G1GFCyFuR5
         kUl/dI5lJzyNInlocXVz1Crl/nNmVFnLEavGUmhS4eJAQWaFcYxbfImFZBLoHZ6hYl6K
         srczSy+hQM4TobdUPYxrAbkFhfoH0JcI2Pn27srZnEX3Vi8CX1jkJ5Eh/d8RPkWqv9Bv
         aEFZlz6zWHguC1XOV/9vzIYmDaIcfLlnoFfmTZVdKYQMM7JlFluzyoWimUTVeoikoWFt
         qcmsGOYns/+lgiA1KsL8tx2YU9Z7XMXW+7BjSeISAGPXpWHdSBg75KgGeu4sYVw5Q0CZ
         HkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756948641; x=1757553441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WHvKqvvSEubjuAjLqach/gWo8VeUE96OgFtsrxG0zY=;
        b=jykvML7oY5R4KIQiTale/J3R27hm1XWhHiXI83Yx07DpdYtquet2IAbRxe6xUIXY19
         BOzCyZk2y1R1JNyjoEz52d6HGkF5yfTRKKeA/e2Hc0vv9uB6B2ohRES/pJ5hOL4BYJwW
         sgecSaJJWsYrctQ+iDPye7EbCfaxlM5ERZehTNUhcLcKh4RkkKhGgqVNtejpDxzp/o13
         KAnywUCnNIQKhEau+5/rBW9j79jjLCWi40/gRR7cWQrf9Rae5gqoPMaROWy37OyXEglY
         a8fgMdjNRiY8+m4nJdGs7dGdH/4CdBjw+i9xPIsH82/C/Vy86SbveTWFIetz7f1Lhq7T
         iZEA==
X-Forwarded-Encrypted: i=1; AJvYcCVy6Z+pmgyeqD8duG9XI+q5jyVbi+8rDBxRTALG67sXOEBagcBcI0i3Z75HodxWndpXuznXuCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT18UKdQQdjaU0RN2ZQIIbOiDxTpS/cOJ8IPvI4trUqpNG0KR3
	VkNkC0c3US32Hepp9+p+ChkKmWSN9BW4FkCDFMhXyDdr5Sk7fLvtWpilWOsdaOCnaWxKvU88/GR
	hWIPZzvxsV+mDrQQ4OA2HNrjWiulx8epZ5cduKXHv
X-Gm-Gg: ASbGncs2j/NM5OBt3ESStI88svxLvCActxLmdh8JIZH0HDjbMGoq0vQLgc2NFf6S9JX
	9iQuGf7K3k4pM6ie7JlQn1WSdEENK2fRFCNL/xUpCgbl3HkcLH0De2hweQhSCH31SnJ4p/u0MOD
	8pE2xYN3OaNQV6MFNU1AA/rsKNXNGPSkeeJUDBe2+BRbyOVEaAJZYqztjpaDVp7tQSB5HJbiNJ3
	3dRi9SGLkmbCX+nmoBIk9XvqoXr28k0DMU0Ze/Vh/qPLg==
X-Google-Smtp-Source: AGHT+IGNaVDWuTXLfEYCkZcF780c5W6sUlcccbr8SJ/Dixpmi2WMVpg+C3u1b++4ueIrG0C3O8SsxYci+0qeFibVDbI=
X-Received: by 2002:aa7:d497:0:b0:61c:e774:38da with SMTP id
 4fb4d7f45d1cf-61f5c00d99dmr3416a12.5.1756948641405; Wed, 03 Sep 2025 18:17:21
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902235504.4190036-1-marcharvey@google.com> <aLjlLl03-YJ_avaa@fedora>
In-Reply-To: <aLjlLl03-YJ_avaa@fedora>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 3 Sep 2025 18:17:09 -0700
X-Gm-Features: Ac12FXyfm3TngUE4mQAcz9NuluXDmrgAEDjytvy5pH-XdliFBTbBKspeqvai7_w
Message-ID: <CANkEMgn4UT7GyN1MjdGCJKD13ENJ8BpAEvLotT=FkReZ9YBRyQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Add tests to verify team driver
 option set and get.
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com, 
	willemb@google.com, maheshb@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 6:02=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> w=
rote:
> I didn't find you use namespace for testing, so why include the in_netns.=
sh ?
> BTW, It's recommended to use namespace for testing to avoid affect the ma=
in
> net.

It does, at the beginning of the file it runs itself inside a namespace.

