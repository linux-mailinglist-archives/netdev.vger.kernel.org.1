Return-Path: <netdev+bounces-57331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A7812E47
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49281C215AF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CBA3FE5A;
	Thu, 14 Dec 2023 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5v3xfU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AB28E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3333a3a599fso269420f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552361; x=1703157161; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMV8u/r154wiParO3LDm2hiATatvloB0iOB9pv6UZXk=;
        b=H5v3xfU3+xKNiCWja3Fze+dtVm1xIknb/cN0mzBS8yiRsHLj7ggYuSMwjQGMkRs3YR
         c4JZS/DyFAbBf0kirKYqfP59mOb4iqEST8fjOOVjDqLy7aNEEHr9ehrcCVbKMmJYw5cw
         kEIvbxjlisF1B4BzMGKqQrGd0T0BJZ4ujK/P+kYdIRcVSwd3Y+4669r7R0dmCd6zwkTe
         vSbgUDPmss1YIZXYbL8xhpRMaEBKsna08X3NlX8/8Fy8Q5l6iCHvbo4HX33yR7oBs5kg
         Qhp+Ty7Wkr5la2VG2qur+7x/M+mSEqIVTN5UCVamyiOZMxm4Y8pYNZjtG/UPB1xjiJPM
         9VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552361; x=1703157161;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMV8u/r154wiParO3LDm2hiATatvloB0iOB9pv6UZXk=;
        b=Il3F9cizir3ofMhWzDpbr/VvFaAh6goHn2FRQeQfzfwbvXwR6h71T/Qhlx5KHuV7vr
         tIgPdMnvD+PIv9UZFfThk19djYHnDP03UWyd3yTRKynpKmgWBVKy4ZdjGVAuwPIZPHH9
         EDtNGUCJEFFg6MmdCS8AhZ2PEyTEtrOx5AtzcIDHzN0YlgZxbDHc2lqBWnLzz+0CZx2C
         FjIWdTzDIbJS/VR5C6eM29x36iU2MK9sYiApCqMt+4rSf4cpVYyavTrKxtA8i+CzBXql
         qNVvXQGKWuA8gGie9OwZL5MEohYFXvXb/EgFx9Cji2wzNzTVb69IKrsisvVwh5crgefJ
         Fpqg==
X-Gm-Message-State: AOJu0YyjFg7GpEYOwbqNohkIru3yuzpSTLmIuPk+Iwf3x2j1Yn17kFBv
	UV/IZoJ2y/ZKCNAOFa0tQe4=
X-Google-Smtp-Source: AGHT+IFX14QJVureQZqjMM85VQ8cpgAUskldP/7KbDUUjxshDawdEUrwk4UCPZWfjvetiWHR27cPMQ==
X-Received: by 2002:adf:fe01:0:b0:333:4169:2ada with SMTP id n1-20020adffe01000000b0033341692adamr5127198wrr.44.1702552361095;
        Thu, 14 Dec 2023 03:12:41 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id d9-20020adfef89000000b0033342978c93sm15742896wro.30.2023.12.14.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:40 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 4/8] tools: ynl-gen: fill in implementations
 for TypeUnused
In-Reply-To: <20231213231432.2944749-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:14:28 -0800")
Date: Thu, 14 Dec 2023 10:58:48 +0000
Message-ID: <m234w559uf.fsf@gmail.com>
References: <20231213231432.2944749-1-kuba@kernel.org>
	<20231213231432.2944749-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Fill in more empty handlers for TypeUnused. When 'unused'
> attr gets specified in a nested set we have to cleanly
> skip it during code generation.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

