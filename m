Return-Path: <netdev+bounces-76354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A886D5B9
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C59C1C2382F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70532154C04;
	Thu, 29 Feb 2024 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YoDL5w8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C7154C1E
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240202; cv=none; b=kQVWstTaxjdJzMPF0ZwlZGRJzWUaqcfKUOfqW8tPQSVwundCyJCOrt5EumF4ySArzPcsaMvmaigVY5WuUu4WHlN0T1o0PMjDlozm2ThNDoJrvSMh5we3ObABmQ5BQJgjUkcCZRiof6crL5ZV7qJfPLR9PpsVE4v38Di32JsesRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240202; c=relaxed/simple;
	bh=y/PBEgT7ogzDQ/urnqR6G19WU2LN1p109s1hDqmO6oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBTNvu42m4VgnngA2UNPZl2GZoGpZQaH/tCnlXsllKB+GYsZ6wibx32q8os5BfWaiY6SMv4F4LmZoFh919FA4zqMvzur/JbwFytuHDhW7c6XxtCRO6NGyRTzQZSzkFrVoTv61Gtp1zjwph2XSAwhVQkOpJpH4NlSM4E9VXnZYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YoDL5w8e; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so2109435a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709240199; x=1709844999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SbiT+3jQ0ttBc0H4Cz/BNQ+s/TCQJGrbtGrlFN7KUM0=;
        b=YoDL5w8eGEVzYpM/2D1Cl0258V2S4xQm8Dq/FM2bOcEWUPCnbKUNk+4r619hrjhChK
         h8csdUy0nRAXuVhMM2d0ZSC7ZRPdtC9uprW5zOUM6qM+lKreZQnIpiTFblt/87UrGdij
         mcAXHSCbsjPAFTPPdCopJfkEF7D2rgrZvqAiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240199; x=1709844999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbiT+3jQ0ttBc0H4Cz/BNQ+s/TCQJGrbtGrlFN7KUM0=;
        b=ckeN9WsWKJOvfE1EYBse4d/VgfDSvoPBtlpeT64oDTiW2e0IVuPv1m1zuzMoC8rKwj
         fswGujrLravGpRO+hR1BUfvSJ9aZv9rI/Sks0keMAa+eWTs/PtRV6NzYulfhgK03sDIG
         1BtZG32cBPC04bICISUERGbiqnHxQPBsou1YD/8Dsg48Vodw+Cji+HdYS5vXiafhcKGc
         nDNNAn63plPOzjlh7XTS1TpvoIE/MSbRyM/QblGQMCVupo8EMpzoHD7NsPmUzih3XeVF
         gMsZdnKuiE3hYmKNoLyA/W6+YNdrUsEBrXKdOc4eTU3KNocsztQoQf89J7j49wn8BGGT
         olHw==
X-Forwarded-Encrypted: i=1; AJvYcCVdjA2TdFxuvPi1t84vHk+Hxnf7d7fmGZccy/nazUGWJtxi755ud+aYh43X+w8C5b3IpF2yKu7szXUO7hMVH7MBupqJ/L9S
X-Gm-Message-State: AOJu0Yx1PZ6Ti2sDYh9t3FvQqRmTShRp8igq/kNmzGWWHOb5LI5eDyN0
	BvRpsEQ9gdgCl1mZnym4vQ/BUTg4qsryVFUfX3M0gjI9NQTGeHds1uSIUjlOgy+1UuZZ8HCm9VQ
	w/pmmGA==
X-Google-Smtp-Source: AGHT+IFvvMmaWmNh6lbegiFm+3QU+fjRkAqUqD2qsBE9Fm6HvMRIlprYX5m90oznrdIJ6TmeCcUT4g==
X-Received: by 2002:a17:906:f88d:b0:a44:6643:a558 with SMTP id lg13-20020a170906f88d00b00a446643a558mr66186ejb.16.1709240198498;
        Thu, 29 Feb 2024 12:56:38 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709063b8100b00a4324ae24dbsm1033763ejf.62.2024.02.29.12.56.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:56:38 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so257038666b.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:56:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGGVyqsSVFBJchIFAguUTbqPwOnEmI1pTn8D1W+ptsJ26XQ3pK3ySa+JvQWUQ0wXqZHCjobqQFCx2gN8PsG2F32d+huP+x
X-Received: by 2002:a17:906:40d4:b0:a44:4d9b:9062 with SMTP id
 a20-20020a17090640d400b00a444d9b9062mr58037ejk.69.1709240197809; Thu, 29 Feb
 2024 12:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229203921.3037023-1-kuba@kernel.org>
In-Reply-To: <20240229203921.3037023-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Feb 2024 12:56:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizM+YawbbsvdRnFXLipMXS+iwgD3fahUu4DeyQCKzSWA@mail.gmail.com>
Message-ID: <CAHk-=wizM+YawbbsvdRnFXLipMXS+iwgD3fahUu4DeyQCKzSWA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.8-rc7
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 12:39, Jakub Kicinski <kuba@kernel.org> wrote:
>
> A few hours late, the commit on top fixes an odd "rcu_dereference()
> needs to know full type" build issue I can't repro..

Ugfh. That change literally makes a single load instruction be a
function call. Pretty sad, particularly with all the crazy CPU
mitigations causing that to be even more expensive than it is already.

I really don't see how that error can happen, it sounds very odd.

Oh well.

          Linus

