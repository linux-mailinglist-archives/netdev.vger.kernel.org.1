Return-Path: <netdev+bounces-149903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F99E8124
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFF51657D2
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57014A615;
	Sat,  7 Dec 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTHX3whf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E43CF73
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591276; cv=none; b=PRlNDLfEQ+iR5XUqbxw/s6hwRnMqZq+H54sg68h5rNe5aOge7wleJCEFGybqsIBvjgqn8QRIQlCFgXHHVGdODPkbiMoyHHW1Am8jXtTCU8PxbVY3gZwyWZ7wppkjCrbuzGxZSUHUtWO/2Z5q1pfNfOep1aDvkhJR6zoqTE1mf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591276; c=relaxed/simple;
	bh=6Fwkd5+NYkMOBlBy1d/flglYMZo39/21KFlyI6RzobY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCDV/4VH6gt02WTckmyo7e9qWSRwOCzm+UPPgt0E+FoG65v4wGFyBK3bpVHNsc5n6xFCMTkdZht75h1oDPOaaKGAiccnACJhLAEBZhNf7wCsK8qzFb/LcZkhzsXEMNv4+NfOsrkxQ6O8M5NEyNnzAkiX3VHQqZVs4GF15CnsoOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lTHX3whf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4349f160d62so20279755e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 09:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733591272; x=1734196072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjZHyEC8LMjiZRbwtvjzRgv7YlJDtkKDxaRNiR/V4l0=;
        b=lTHX3whfrTZLt6PH2gQ8KvOJuzVBBPWmCR2DZEZxUP9VDMUCoQWsZbj4udv9XgCa2Y
         WYdXvSwKcr638CjMwjaTJwOjz/xy2kc/w9AxyZt5Hh1Vl6Cxc7mubJmjieqt2zfRZ9hP
         +DS5ERml2as9AEChYSABsgnpiJTMmPRxGHYG2ZfyJUfE7ncDTtSmUYRLqrry3drPoyqY
         FlfS5UH0cLKOadEllobva6JNCxTtF8tbafsm3UAmEWPhBtUIetaQOqZm+tk+npahwaaR
         uQx6EdOaJEOc3zme1Yhu4D4uaF4ORtH6XJCOR5cAciP1gKFuS8v+RwrnjuWocHOCt/TL
         JCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733591272; x=1734196072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjZHyEC8LMjiZRbwtvjzRgv7YlJDtkKDxaRNiR/V4l0=;
        b=iACZJfy4mFdDde/wGGXxWKymSyh/L+V0hgxlodQpXtNcXL+ZgBcf/jH4Nhy4TjI0vp
         DucR+DO4MDJ7pXG2cf2L1chQ2qJlgodO6C+kP/wqhC8DI+uDkH9e+fATHJt9e68dNeLZ
         RuOMWKKgLaLMUO4VzZDcC0K6391fRzpIRyzpyKsYWDr7o1/mftiQHqijVblyHBqb1lj9
         bfi6erz5tytX7BFA4wp87At8jh6voKTVWhdSWGdeFEWMgU7ggLQug0wMT6edx5O36AJY
         AWJVBNdd2pLLYadyENccubcQMEIbg9GJva9dNwslIPIZCpV0LxD7AiF18aUHuq2Pndr+
         5CJg==
X-Forwarded-Encrypted: i=1; AJvYcCWkhOT43Uy2g+OVYZdax9K/oBKdyV1OD+2j/TpH4+hykvztaKq/Oq649dCO9VcaGxFJaNlwCq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4Pec1lLO07vMezVh8eoHGKu7fjkEnslGcUrAo2OsKczOrqK3
	IQi9xVohQEzYwkce7OvHHJt1yXSNl2xHIZutxg8Za/hdSc35m7V/FkPf2ePTbhQ=
X-Gm-Gg: ASbGncv8ghFSc+3unbltkkgwhqmU69t7PKWSwCyJXFvMaCDL/SFkkHMSfO/rTD6eZ/8
	VW9K8I56OlV9ObRcT7chJiHHlbj7m86uBKSGvzJTmFbSCu72NKupQkGTpqtf8YHY8f8jyixgefb
	3rQ7+/6xd5fqAjgVO1I09S+MmD6sbWJV10UjwymUENOUPlkvwvHCWQ7RC8bxNeP6ew8ECuXdJvj
	DVpni1pdhPPBMl/+r1uKgMygUaTKYEiavRdQVY0r5Kbov6ndR8Gzxo=
X-Google-Smtp-Source: AGHT+IH++nUpXJiDBC4Fh9UkriWZ5KGl+qJZ3UNbkzOLpeFQE0OB7VJDLKVp6G3O8SOriSIauNPMjQ==
X-Received: by 2002:a05:600c:4ecd:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-434ddeadafcmr61344335e9.4.1733591271628;
        Sat, 07 Dec 2024 09:07:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862e975194sm4251385f8f.74.2024.12.07.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:07:51 -0800 (PST)
Date: Sat, 7 Dec 2024 20:07:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, idosch@nvidia.com,
	kernel-janitors@vger.kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()
Message-ID: <4639f75f-d081-477c-bd61-a9ece93db5c7@stanley.mountain>
References: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>
 <20241206232731.38026-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206232731.38026-1-kuniyu@amazon.com>

On Sat, Dec 07, 2024 at 08:27:31AM +0900, Kuniyuki Iwashima wrote:
> > [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()
> 
> This should be tagged for net.git.
> 

Sorry about that.  It was a mistake in my scripting.  I'll fix it.

regards,
dan carpenter


