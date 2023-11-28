Return-Path: <netdev+bounces-51505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0007FAF08
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2949E280FDD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA83A2A;
	Tue, 28 Nov 2023 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PyEgxNWL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE919D
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:29:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ce627400f6so38999695ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131367; x=1701736167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBhH3SH8gSBwN/mjOaVSdplaO4ytPruThkgoguaYPkk=;
        b=PyEgxNWLeJ3KP8hUS7Ok5YSMoLLYB/ml3itP1fDeV5zzMq6GeWq7Yk+5qYJFlWMz3N
         M2hG48me0XDZH/2YaYA5EuA2ZUobganXhFT3/he5pdHZkDEvHVXNsvUG/6vZqdcAiPmu
         s5ehbXKbSfdq40VxQneA98J3UKPHGyCYYXQcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131367; x=1701736167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBhH3SH8gSBwN/mjOaVSdplaO4ytPruThkgoguaYPkk=;
        b=SwPIIxx3FAf1HrOvdL4rEp+j3BIM0lONaRF0Lw35ZZpJThe/PP1WREarT+J2Ea8so+
         noztAFazXl6oVl1ceecX7M073s4DKfi5SEf5LtSW+ToGN8iNmC1PqrRS73C5R4GS0Cw0
         Of0zgNA3MAco4L6hHRxY1xuHO6QJiZobuCUhJBVSmBxsj+1wkcKdN+4aw/gyVfe89JZa
         s6loxGwRmjHfewlzfYzB3tZuvs4ihBLphTwBbofyUKbS/g2lZC7eZwTIRv/KZf0sJ8Bx
         fbmOSwiZfSPHx7gjjiWKKvLsB+k1i7aaDJyCyxe6fDPMtr/Dvve2W920j3tlsPeeI40n
         SXQQ==
X-Gm-Message-State: AOJu0Yz81f75vBkgpITvF7yLJ1FdJ8NmjHKJe+6FI02fn0gA4nnOBU8g
	u4O6RasQNRtD0BTq489i7UMUVw==
X-Google-Smtp-Source: AGHT+IHfOT26JhpsCCRBM96VOFEk0SgWcQnWOKyzAiCxrKsjcBUu975ao2LlZFeKW0Hd0NQIfUCkxA==
X-Received: by 2002:a17:903:22d2:b0:1cc:c273:603 with SMTP id y18-20020a17090322d200b001ccc2730603mr14361492plg.42.1701131366965;
        Mon, 27 Nov 2023 16:29:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902b94700b001cc2ebd2c2csm8824250pls.256.2023.11.27.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:29:26 -0800 (PST)
Date: Mon, 27 Nov 2023 16:29:25 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bill Wendling <morbo@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] neighbour: Fix __randomize_layout crash in struct
 neighbour
Message-ID: <202311271628.E5EED48@keescook>
References: <ZWJoRsJGnCPdJ3+2@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWJoRsJGnCPdJ3+2@work>

On Sat, Nov 25, 2023 at 03:33:58PM -0600, Gustavo A. R. Silva wrote:
> Previously, one-element and zero-length arrays were treated as true
> flexible arrays, even though they are actually "fake" flex arrays.
> The __randomize_layout would leave them untouched at the end of the
> struct, similarly to proper C99 flex-array members.
> 
> However, this approach changed with commit 1ee60356c2dc ("gcc-plugins:
> randstruct: Only warn about true flexible arrays"). Now, only C99
> flexible-array members will remain untouched at the end of the struct,
> while one-element and zero-length arrays will be subject to randomization.
> 
> Fix a `__randomize_layout` crash in `struct neighbour` by transforming
> zero-length array `primary_key` into a proper C99 flexible-array member.
> 
> Fixes: 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
> Closes: https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yes, please. Do we have any other 0-sized arrays hiding out in the
kernel? We need to get these all cleared...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

