Return-Path: <netdev+bounces-52424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7097FEB1F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED721C20B78
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC5D2FE30;
	Thu, 30 Nov 2023 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHKcJXP/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB312C;
	Thu, 30 Nov 2023 00:48:49 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so6177315e9.0;
        Thu, 30 Nov 2023 00:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701334128; x=1701938928; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3ajxpNuNT1dCx3mefyTr59eDGpG6y+eao1lQOpzASM=;
        b=kHKcJXP/mo50B3GlcW3AB23B9gCjFXIn0lSC7zr5UqrBv+U36lHSz46Ffrlg6L/bNK
         7nmicSvaAj8rGT2prMmb8oJ28chhJAZoYT8RGN6qjNjI/j6+E69DlyHBistj1D1Xw5hf
         2fhoyD0+cSnUiCrUB02Pxh6HWVRC4MXIo4x8PpWqqqTZWS3cadMYd+yyU1GagO66xc1b
         O88vTkFHJhL9iJuof7OawUsP1zkv8ZuhuEvimxRVJw1ZNY+KKxJeImukzABMpPWpUEKa
         jJfMBi0aKR9gwFS+9EoKM7sSc9/tGqFIY8s7lrZal0gseYycvc94K8LqpTppvCKOWYLC
         M5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701334128; x=1701938928;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3ajxpNuNT1dCx3mefyTr59eDGpG6y+eao1lQOpzASM=;
        b=L3aIaEB1IqBnS51LXnv5MU4/nPbFv7TAA2pA8q86W2AKgJRwokyrnvFOczCIlKYeaZ
         wZKOAwP3Bh1k/Pcy7GCp4q03/eN08ZhGrgYIsz7+Ca4E7N73LHV95Z0W8fnFAS4z/MbA
         f5jbN8CXfcmChkFIKj85/tpMlEEFYRz4bNeq43JQCTDc7dEFAAxylZRpsVABSDz2M5UV
         mrpRJugRMLS0Df4zUpfq/oz1cWDZysfxRA0/V86ovfAr79IS93Q1vmUmWz9ne5NANCxj
         gQ4PQ8RN3eN2qPTbZfBB+6tThcgUjJyQI8m+gHe/5JZOwUtsiQt2RKDgSlil88Wfd/7W
         xHPA==
X-Gm-Message-State: AOJu0YwKFdCqm5Wp4TkBRvLxb0YIG5hmysZeVOPiywI3Watr5gpG/94t
	Dzgik6ksdPJimedmLuuXLKs=
X-Google-Smtp-Source: AGHT+IGAQVJP/FzQhN1xlzFrdJXK+CEaUamkwsCPSkwa6a8V8/i6FRfWyzBnjtKOZPSed4yFY2eaew==
X-Received: by 2002:a05:6000:c03:b0:333:92b:5f47 with SMTP id dn3-20020a0560000c0300b00333092b5f47mr5871965wrb.48.1701334127750;
        Thu, 30 Nov 2023 00:48:47 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:1c53:9d4e:6a62:308f])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b0032f7fab0712sm897142wro.52.2023.11.30.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 00:48:46 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,
  donald.hunter@redhat.com
Subject: Re: [RFC PATCH net-next v1 0/6] tools/net/ynl: Add dynamic selector
 for options attrs
In-Reply-To: <20231129094943.13f1ae0c@kernel.org> (Jakub Kicinski's message of
	"Wed, 29 Nov 2023 09:49:43 -0800")
Date: Thu, 30 Nov 2023 08:48:40 +0000
Message-ID: <m234wn8w47.fsf@gmail.com>
References: <20231129101159.99197-1-donald.hunter@gmail.com>
	<20231129080943.01d81902@kernel.org> <m2bkbc8pim.fsf@gmail.com>
	<20231129094943.13f1ae0c@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:
>
>> Did you want an explicit "list:" in the yaml schema?
>
> You mean instead of the "formats" or in addition somewhere?
> Under sub-messages?
>
> The "formats" is basically a "list", just feels less artificial
> to call it something else than "list". No strong preference, tho.
>
> If you mean under "sub-messages" - I can't think of any extra property
> we may want to put there. So going directly to entries seems fine.

Sorry, I wasn't clear - yes, under sub-messages.

Thanks!

