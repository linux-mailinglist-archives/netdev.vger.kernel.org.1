Return-Path: <netdev+bounces-46641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFFC7E585B
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263B41C208C3
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFAD199B9;
	Wed,  8 Nov 2023 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5GEGOY5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824EC199AE;
	Wed,  8 Nov 2023 14:08:49 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0581FC1;
	Wed,  8 Nov 2023 06:08:49 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77bb668d941so14619285a.3;
        Wed, 08 Nov 2023 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699452528; x=1700057328; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kX7CM/+HFOuoWO0RSAPK5Wud7OOKi/SdZQGaJwTivkY=;
        b=O5GEGOY5RtmTjVbIHWJkBLUmvS16Tr5+Wqd8c+KSLvlmMYjaHssDM3nSxH6HwZIFbl
         OtTTtNmaiuKUYVlhZNxdfaPtvdyvNRul+My7wczh9NRQyNGqWr80zhQytulWVePdmGTL
         z9aVwQQOqWxBH0FfArUKdF8QtrvUe5QWlKBSBKbJQ8KUFv5SDs9OX3nSn2NudeniC+ew
         wO3QcZ7/u91vmecn5suNEh5t4vbty6e7m+TqE4ryc+tlqAkfezpqP21UjKBDiKHz23VF
         Yl+flBKAWsjua6yDV9cSWWRHOOHdY7FP3b53JxuOydxKTgeaV2vwnCxUya27cZdH71KJ
         CbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699452528; x=1700057328;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX7CM/+HFOuoWO0RSAPK5Wud7OOKi/SdZQGaJwTivkY=;
        b=tZw/rwOO461W24QK9fGvfnRXg6zeAxoZBnr2w+PodfzJ226zTTDR8VoBBa/3p7XHHc
         SFqhim3w155XjUCXgFGWdcdPudnQMkq3p/UjU5fwf+0jn1nljN2SQpxGYX48goFl4yGP
         WjgENPPVYMFytkOC9OkHa6p5fsCDy/DP3JufKotKsUIeCOSZCjyWXLSawiEE1qFppoP9
         +q6621VFYd0t0Aa9s017RFTboh68bCqWmTa8eoLWHvSYF/hLCMI1Gi2CqT+O0+oSuNSy
         bXsW5NwcfQpkfOThFYCixjsJiyUM7Sx9JIStwCimuA9bQV5Bce1roCmjNAz7FX79pqbD
         dP5Q==
X-Gm-Message-State: AOJu0YwJ5LlciLufeqaUeovPhBwCrfnWFbtO4FEfG6s87TQBbgsEQggi
	uVq1GqSA6JIhh3sMFg5J7Bw=
X-Google-Smtp-Source: AGHT+IHagkHKV+raaU34iTpMYbk7LfATLSymRnVvtHbHkjUYDy0VP9t2kHDEzXzWsAmbc5ZJ20SQvg==
X-Received: by 2002:a05:620a:2801:b0:77a:565e:3ff0 with SMTP id f1-20020a05620a280100b0077a565e3ff0mr1678930qkp.31.1699452527943;
        Wed, 08 Nov 2023 06:08:47 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id d26-20020a05620a141a00b007788bb0ab8esm1075318qkj.19.2023.11.08.06.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:08:47 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: corbet@lwn.net,  linux-doc@vger.kernel.org,  netdev@vger.kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
In-Reply-To: <m2y1f8mjex.fsf@gmail.com> (Donald Hunter's message of "Wed, 08
	Nov 2023 14:03:34 +0000")
Date: Wed, 08 Nov 2023 14:08:24 +0000
Message-ID: <m2pm0kmj6v.fsf@gmail.com>
References: <20231103135622.250314-1-leitao@debian.org>
	<m2y1f8mjex.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Donald Hunter <donald.hunter@gmail.com> writes:
>
> I quickly hacked the diff below to see if it would improve the HTML
> rendering. I think the HTML has fewer odd constructs and the indentation
> seems better to my eye. My main aim was to ensure that for a given
> section, each indentation level uses the same construct, whether it be a
> definition list or a bullet list.

Or what Jakub said, use more (sub)+titles and fewer bullet lists.


