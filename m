Return-Path: <netdev+bounces-99390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F346E8D4B3A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72417B23001
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95C8185080;
	Thu, 30 May 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1/QhRrq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAF183A87
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070478; cv=none; b=cgwozc0izn7r05AZ91JNIGJL6M4uEsz/WXM1qPFaE7RlaHYrOSbq09tk9yxqr00dETHarOTD3f805J2ZFEFxBYxUJ4q2BjXvPBAYV11Zu4qnHGUt3tZ/v0mkzEGKpEJOGjSOI0ByMeSr6loRoaX/pu7zvN2r5idGcUrlRtGEcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070478; c=relaxed/simple;
	bh=F0tGok48HTiq6FrotmL0kPKSwlTdlMsze7Fp0/5/AXY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=A5R4E0oy47kAsq5QPtUNrgD6teiX0l0ILqmUxPAXZs9EWdlt2Xriw3iSg+dilEfK3k79WCMgv7u/jBVBK1fpprrfmggYUFGlhmCgp1nvjwuP6h7kfBLCZsTwEUREspVC9QfHobXWgSwDxmDuXyo7SoYFHY9h8hVzFr1Zoa1jcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1/QhRrq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e73359b900so9167401fa.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070475; x=1717675275; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0tGok48HTiq6FrotmL0kPKSwlTdlMsze7Fp0/5/AXY=;
        b=H1/QhRrqlh25QuFBOm15slP27gbLJJaDuttUVNba8EWZzzrrH89xMqf1MnbfMaSJ6Z
         xLYoTVfCLQ+P2y5+U76ZSz4Bz4+LEGCBc6RfjxCgy26udAl3xX0qEKVQ4HJxvB/cRJTS
         xuv1m89h9t8gyfEBCfNxVrKNe0LzHXXv63E4CuoR3CVUIoOcU5RsutVETtb1CQ1iGxLN
         6XQMqJZE72lPkOe2WoiNvsgSJtTO21hDBnC8ealp+sqmX8+7rj0B53BzQwnXfMSQYpbs
         7eaEU32+RO6CG1tOlwWBa7DCD9CGvSPBxc7CSv/vVJPagZaNSbZIbf5S8ayCLN2WqU1A
         d8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070475; x=1717675275;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0tGok48HTiq6FrotmL0kPKSwlTdlMsze7Fp0/5/AXY=;
        b=qzg3hv9ttC+96KXKzCNY/UyG84+zFGaIduJzLr2Nw3/mFa3oXLCI+HxfcdDjSlAZd1
         vNEWrjjiiwpPa+S9aRPizqO2G2vKwzeFLZXGoq+cfyTJhfDXSrGOcF+Y0p8tyRW+Glzq
         ypcJktBIsg+kkBuU0piPgPicwyOx7jw21uyMgovpWJ1n+hJ6c7sRvYhfRa2UFv0NyspU
         BfllXZ038pMuDqycawAP2j149TC1QYhxopNdz270KzDaNwI0LrT3hmCz6ScN8uqpgXQ5
         SoAM2+7J5ulj+y97awDU+JyHjPht9QfvU13Rl2OBQdscguS8JUMEXLi2l9neIuRYdaY0
         zVew==
X-Forwarded-Encrypted: i=1; AJvYcCXbHDBf3MPnhn2Jyu3lYwLP0MUfn3Rt5FmDqKp3uUD31/hG0CjswUPDeJa9Z9ohDgJuYFKq9H/ohQQxWbfZJCMPhc7dHbrD
X-Gm-Message-State: AOJu0Yxm7PLdXHwOnNxkFI5ZgUzIdvEg3OYZgL5p/k3Ht9W3aMo1tBYS
	R79/tVqFH9DJYVtjrVQDjsxXEy7i2g1lbV1j+JJOeBYlgUdEX1KM
X-Google-Smtp-Source: AGHT+IFbF6SXTX6Kc2UGnax9Km4KacDkF/UCUN3E/E5MitIPGaabesWC++0VntUfrKidm8Idp6ijBA==
X-Received: by 2002:a2e:9808:0:b0:2da:b59c:a94b with SMTP id 38308e7fff4ca-2ea84825bb2mr10618711fa.25.1717070474839;
        Thu, 30 May 2024 05:01:14 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:c8da:756f:fe9d:41b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270791c7sm23220305e9.31.2024.05.30.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:01:14 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: make the attr and msg helpers more
 C++ friendly
In-Reply-To: <20240529192031.3785761-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 29 May 2024 12:20:31 -0700")
Date: Thu, 30 May 2024 12:23:35 +0100
Message-ID: <m24jafczm0.fsf@gmail.com>
References: <20240529192031.3785761-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Folks working on a C++ codegen would like to reuse the attribute
> helpers directly. Add the few necessary casts, it's not too ugly.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

