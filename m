Return-Path: <netdev+bounces-42786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FA7D025B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E41C20C8B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294F238DF1;
	Thu, 19 Oct 2023 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PQqN1Srt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931232C64
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 19:18:04 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90AFCF
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:18:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso14063939a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697743079; x=1698347879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iXwCx1QyFHd74if3jkrD/AR9CcBz0fWjvPdcZXYAff8=;
        b=PQqN1SrtcoRmIm4ki4nImyjHvgOZ8wYeOSzlcgIo9KonJAXQB7hwfWrFJXkStnUPuM
         iAcnPg7/66eBRiuw+6wU8bpoBy3zn+yhsLw9QYl2lOEFJgox6JsG5VJVQBNnIwxgHauT
         2oqJvYQLEzqxH7JN4kyTcI+oTV69E99ldO5RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743079; x=1698347879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXwCx1QyFHd74if3jkrD/AR9CcBz0fWjvPdcZXYAff8=;
        b=gjESeiGXHhiYLqMnBmwUV+MwTbKNKxTBM+/Y/yR78QuS9oTQYMGLq1qKuwZ3tSRtdS
         TRPxPxL0NsrTCiqCGm8wEtBRNeomnNZDWhQ4YNkhKIpgLqkfLdjJfbNmz2f3sGrk9Err
         Gcg13QPWUSHCLTs+W9C8RNSY0nVk2Kc1gLg4BthpMQ74A3q3YMq+cZetpSDOIoZlEJMN
         /mhlwvFhoHvCy8ZZJKsU+0fAwcTgFGVi+WUDfVOhORAp5jFdfzUL00n+YRlTJrDKbTVP
         bamtNXhfC5ZbCFxvDWYsMU4ik6oZdFCF86tuNTrOTvdXgN6yuf9NS6QhIkd8R85ip7OS
         QycA==
X-Gm-Message-State: AOJu0YxTV4H7wEljMYry+EvCyseTisS5po0f35Lk01CeY3NV7F+1wJkL
	+IO12vIQqqnEKNKga1yVyIzhj+4FY/KtwIX9HKjKQjQA
X-Google-Smtp-Source: AGHT+IFpZeiE73hz3IiiKX4F4O9CdFEvXXzHXKmLMXnJHNtX6bT1In3AICyqk8g4IeV6JHSrMpvqYg==
X-Received: by 2002:a05:6402:358d:b0:53d:bb21:4d90 with SMTP id y13-20020a056402358d00b0053dbb214d90mr2202480edc.40.1697743079133;
        Thu, 19 Oct 2023 12:17:59 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7d51a000000b0053dda7926fcsm101928edq.60.2023.10.19.12.17.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 12:17:58 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9a6190af24aso10951566b.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:17:58 -0700 (PDT)
X-Received: by 2002:a17:907:3687:b0:9be:aebc:d480 with SMTP id
 bi7-20020a170907368700b009beaebcd480mr2243860ejc.24.1697743073410; Thu, 19
 Oct 2023 12:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019174735.1177985-1-kuba@kernel.org>
In-Reply-To: <20231019174735.1177985-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Oct 2023 12:17:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0jmsuetiD_k+M9NHt=ZH=9AyBa-3+MYDfBPMw6tsaOQ@mail.gmail.com>
Message-ID: <CAHk-=wh0jmsuetiD_k+M9NHt=ZH=9AyBa-3+MYDfBPMw6tsaOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.6-rc7
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 10:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Happy Nov 1st to you and your surrounding spirits.

Well, it certainly sounds like *somebody* has surrounded himself with spirits.

Of the alcoholic kind.

Just _what_ does the calendar on your wall look like?  Is it maybe
spinning or looks doubled up?

                   Linus

