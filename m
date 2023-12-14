Return-Path: <netdev+bounces-57332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C28812E48
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C803C1C21494
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2E3F8F9;
	Thu, 14 Dec 2023 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScxSLKsR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30997B7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c2308faedso82091855e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552362; x=1703157162; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WY6V/EuYOgr05Aa2pH43QYAE0TQDIKxakfFLhSs3zSQ=;
        b=ScxSLKsRgjY4ibxgsXiA23MtSPWAPp2I5aTIjovr8+S3mHfIcCuMy+g3XsV0arZAjg
         c8g8A+D45rczvTMYb5g7f+ylSnfBIdm0jaoV47y7KLAzjnnxRUakDY0CzBUKHywiOhcM
         JqsaaoCqnRgowwLslqxZeT/P7NYp02mM4vtSpYxZKtawebihRoo/RkgansMSUJYUirAc
         Ju8bhA1EHWQGvquk7B2h3ujwf26xfIuti7nCtGyTG5VIy+zlv7EgThXVdhn5bCG/oc9M
         aqqKQahRzJ8mkWshQiV7AVGL2Ii/cAL0jUsPlgTriJlOyuD6aLMywBJQ2/QSMxXptXAz
         ZjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552362; x=1703157162;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY6V/EuYOgr05Aa2pH43QYAE0TQDIKxakfFLhSs3zSQ=;
        b=LXTVs1E0ouFJxY9la3pQgaf9sKebXhXoOf8UTsglc73KB20J0V0ubVeOGWNCDPsB2b
         sxWwKsa/IYAdKkK0OSOjrhs7itNZQXmXTciODC+1SiE9uZuRoMprCt1vb1qq5V6VbQSp
         wj/x7ZPBcm7kd4suY7jowKgAnLS7XxfNqYFdcyPt6JdCcEFC1TRgJWOW05vwMX7uhsG9
         eDCH1cIpImjWelLp/oCuNhQ0N5F4s9klTufwirlHsz8GenWox41V6KUc3zt4BuNNB7ZO
         ec3Dj19mo7ENxShyqc+0KhdtU3P95cCtzhbofUKbq4c4yJP4VK5lbHcYAzYXhJJJtLHM
         +Ltg==
X-Gm-Message-State: AOJu0Yxv0vV1N8nkmpmZFDjB4E+0vsLecjLrrebhfvCNooEnHwq/onYJ
	rNtrvoTH+hWTzM9Puh3KDCPH5CYhIH1kug==
X-Google-Smtp-Source: AGHT+IGk4uUR4mYDDEa6wBGX9mitupl8WNjEcqlxmRfM6ghr/zWN13rkTZjK9m1XMzjBUXO+Y1e1dw==
X-Received: by 2002:a7b:c4ca:0:b0:40c:386b:9356 with SMTP id g10-20020a7bc4ca000000b0040c386b9356mr4621186wmk.72.1702552362592;
        Thu, 14 Dec 2023 03:12:42 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b0040b4b66110csm24345566wms.22.2023.12.14.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:42 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 5/8] tools: ynl-gen: record information about
 recursive nests
In-Reply-To: <20231213231432.2944749-6-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:14:29 -0800")
Date: Thu, 14 Dec 2023 11:02:16 +0000
Message-ID: <m2y1dx3v47.fsf@gmail.com>
References: <20231213231432.2944749-1-kuba@kernel.org>
	<20231213231432.2944749-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Track which nests are recursive. Non-recursive nesting gets
> rendered in C as directly nested structs. For recursive
> ones we need to put a pointer in, rather than full struct.
>
> Track this information, no change to generated code, yet.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

