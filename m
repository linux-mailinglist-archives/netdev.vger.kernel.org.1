Return-Path: <netdev+bounces-75321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8188694EE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BEB28D105
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5713F016;
	Tue, 27 Feb 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLTjksPq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161A13DBAA
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042253; cv=none; b=h3IrR7QTm1f5xIRo+HPuxny900XlCCzZ0Wq5OBEA4MkSKKyOwa7Gi7JYtG6CixZBDJ3lkzehjyQQXAo84xpRHG+OhLeJ+eMx968/jDMiwd/dpaM92UrXSDFrRmFQxKhoPoVAiBDc3w5gQsEPDT233J9aypEukEfPa+lA02j0VD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042253; c=relaxed/simple;
	bh=PmZNHE3juc/HM/OJWA30j2D6gXFLiVkVrbLOoNv5bnY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=l+pwLsxBIW6VKRpXZQt+BIdipg/V31nS+4zS7qf1cVKtoDyGnfiWTzYUYvJ/xlOgDtKKTZCpduEmdOfxOCngvDTJuJfa5buoB++Y7xjzTTbPjYKEDl6t4trQ3znw85jqgy3r6sG4x9axhL5qUYJwBpNwMDzL+VS9S+5NRMdNJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLTjksPq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412a3901eaaso17937925e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709042250; x=1709647050; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmZNHE3juc/HM/OJWA30j2D6gXFLiVkVrbLOoNv5bnY=;
        b=JLTjksPqF8gvxLv3pUBy2I/Q+doJXmP+VJkz88maQ8D5852AGwDNNjakc13VjtKQch
         BoxBI1hST94DJyIkvuvH4aB2fUUgK4bE2NLm9C+eLcaIR9ZcW0ibruBrnU6M+EvK7276
         MXqBjTSz6wFCz34CtBwPUJxfwHlNVswLCNi/WPrr1ymvBhM6kYE/GwzS1qQApAfHpe8h
         5pshvnk3OQ2OsiImdbb/7NbzzqJiz8MemKXJ1k9Ct5YFukjvSFJiOYfclAvaVfnpOtD8
         fSgYv6ikEUakUY7s3oi/Aa1krjbAjl1jIwJxrW2DN1vLggfpP/lEIRFjAc91YUfGF6bl
         UT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709042250; x=1709647050;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmZNHE3juc/HM/OJWA30j2D6gXFLiVkVrbLOoNv5bnY=;
        b=f/XYd2fN6FvaNzqUItmrH6YI4tgw0MvBEf4Fk/ZmuqOqugchquy5L76I7wSVzn1LPj
         vZAW8TqWHrDfB4WXXYXsVraMk8/bgxeSheFaEW2qNAu/yhsx00JxEKdaooBhA6J3hpkM
         hBk7q+0BQGggjZoABDH9whUsXdAqw4A/7OEMDMSuo2R7swrvkip4yW53ihp9vsLpePn5
         9rWmnFzeZAC7P/NKnxO82aYpQ4aIv51DYPU+Jk1Z8o3XbB+tAsLUXZE+uGIos55GQzXW
         SCm9nSaO3LHpjmZeDjp9V6shJVhr4tKmrnMiPWhbYx882VRGKOG3/Ks+QZahxJDnd2f6
         gTBw==
X-Forwarded-Encrypted: i=1; AJvYcCVLCdagLsb06dvjJwA6dDse9/xh/1RiVX9YMFCUmVT7dXtUO8bgqGPjVwZTqxEdWegOHJOhgC3+PMfeJ9qh/yPVSjqgLloy
X-Gm-Message-State: AOJu0Yx20qxtUlUwzADqforCYdQ5M5qTiyDLgKFBdZnt8PIy31hkV3In
	Tgw7gin0sfYQoCw4WzDgjtZADnxNFZ4vRW9vABSYKWwzLKIWflF/
X-Google-Smtp-Source: AGHT+IF4Y8T792FBQfsEliI4QoVZA6lRZiJk14sMirwxPLYFkf6nSR65rokw2CBc7SWGoVA0WZqxIw==
X-Received: by 2002:a05:600c:4f0d:b0:412:9d49:64a3 with SMTP id l13-20020a05600c4f0d00b004129d4964a3mr5942142wmq.24.1709042250345;
        Tue, 27 Feb 2024 05:57:30 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:58f7:fdc0:53dd:c2b2])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b004128da16dddsm14850982wmm.15.2024.02.27.05.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:57:29 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next] tools: ynl: protect from old OvS headers
In-Reply-To: <20240226225806.1301152-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 26 Feb 2024 14:58:06 -0800")
Date: Tue, 27 Feb 2024 13:49:10 +0000
Message-ID: <m2h6hum2zt.fsf@gmail.com>
References: <20240226225806.1301152-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Since commit 7c59c9c8f202 ("tools: ynl: generate code for ovs families")
> we need relatively recent OvS headers to get YNL to compile.
> Add the direct include workaround to fix compilation on less
> up-to-date OSes like CentOS 9.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

