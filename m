Return-Path: <netdev+bounces-65133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5783954A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844751F2FA63
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73281272D9;
	Tue, 23 Jan 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE/zZSf0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7781AA4
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028341; cv=none; b=kNHZSeToL8Jn2cmjusmCwUO61IdNGuwE4XPCUaSPwiYM+HHLHbwd1VIh02UI+aAfDfdEUdjM48jd2VyRkAu1UQoHAMSEcCgSgLLN+QlXo7YtXye5g0GVQM8V4dDNeSvyDhKkT6uoSP/hsZ2BGPx3IuzyveOR5+1RECQfdqx1HoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028341; c=relaxed/simple;
	bh=cyBYyI33oH3F851iInqK0o+xYwK/Fpcr5BbwIBBazQE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=P8sNpxq+JOy9jsNGm/hPKW2XTZd6hTN/cuK5w8lltzuUKwVkRpqZwLJusdsKBZH37CcdhdK249gPz0WEnuL+Xw4a5iXBvhYLSX4dauJEKsuecZ0EtH6Q7oqMC/HS0hLlyySoo4zUugNvkVkYftL/2aq+tc5RjQdMF1Ic9p8qJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE/zZSf0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ebfc5fb19so7425725e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706028338; x=1706633138; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyekzzgK7+KB7J6LBIRtHxlOmNM+ByOT3l+fqC5IEc4=;
        b=JE/zZSf05qVEjyRrkmxkHREu+4ilRLVWwOuzwVTq+6DCWlu/UsWjL9i9lgvtRKfg0n
         3ibWOdT3Rlb+lSRxqpgYbR2fDGEtAL3R3KmRhXVlUJ0hZURaOPNoetLlvfTJFSeRbacL
         yCwT2ayt2rMoXkuTwtJlSi2XK+auozt5JwArboTFI78l2HEbhjmcqpGDpGqVTvTkWvGc
         sIOVigwJQwGZAYo7tBOxUArg9/SxsI0vc1qVgklDSbT3JTu2hGFYeGL6iAgfawUODxGo
         Yam7sQ4lKCK/KG2r4vmxaUzNuh9eKcBeLrBegoFw0sZTpw25E/ldu1tnXO4VbKz5IGoR
         HAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028338; x=1706633138;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyekzzgK7+KB7J6LBIRtHxlOmNM+ByOT3l+fqC5IEc4=;
        b=OTjeEYRvcCbSghrSXcOOkaBCLL6cWW7F4KlRRgXb5CDdXysdU7ve1SnT31rqN/E0AT
         DSV8fAKut3ZiJCwopyloWWuiOntTqxm778sRt1Mg3AIwdJ3dQtUhOQspL+3oDVogViTW
         7XVe7cCn93661alfmPVn+lFH///Gq0koxpktHKNxzqAiQOmqQepNu8esO4Gg36zX2PfS
         laRTKIKa0A9v0jP5U9MnX9pO12Owy4+eYxhNIAQYoY1GHgKCuBwD+/65Ptu/ZRsuyDCe
         SyocEsEwrHtHz6SbCiWoteiQZb5S7KmhKBVwbG9M0RjhnSIClKObvY08+8ZYgWzzF2Fp
         +joQ==
X-Gm-Message-State: AOJu0YxwU0leyrrzbXqOBF6t6kG1fx8NBEKWlSm0BVU67nvjFlTU+ndl
	tVvD1PDC3yIxw7RZ51ylK+bQz+fXONpsnI7HHzvxx+Ati3SNoGYkQyV7rEasu9bi9aqu
X-Google-Smtp-Source: AGHT+IETC34SiXruLiimvhYDeUYkUi3nM6ZsBcAv4eyo9BiLMlv/OPTjRm3wcJbbSMTDv8xAxMddww==
X-Received: by 2002:a05:600c:2152:b0:40d:6af2:f965 with SMTP id v18-20020a05600c215200b0040d6af2f965mr220290wml.106.1706028338105;
        Tue, 23 Jan 2024 08:45:38 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id bi25-20020a05600c3d9900b0040ea5ae94acsm12381484wmb.27.2024.01.23.08.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:45:36 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  sdf@google.com,  chuck.lever@oracle.com,
  lorenzo@kernel.org,  jacob.e.keller@intel.com,  jiri@resnulli.us,
  netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] tools: ynl: correct typo and docstring
In-Reply-To: <800f2681d56b5195c8b22173a3b83bbac021af92.1705950652.git.alessandromarcolini99@gmail.com>
	(Alessandro Marcolini's message of "Mon, 22 Jan 2024 20:19:39 +0100")
Date: Tue, 23 Jan 2024 16:28:38 +0000
Message-ID: <m24jf4ypxl.fsf@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
	<800f2681d56b5195c8b22173a3b83bbac021af92.1705950652.git.alessandromarcolini99@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> Correct typo in SpecAttr docstring. Changed SpecSubMessageFormat
> docstring.

These docstring updates lgtm.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
> ---
>  tools/net/ynl/lib/nlspec.py | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
> index 44f13e383e8a..f8feae363970 100644
> --- a/tools/net/ynl/lib/nlspec.py
> +++ b/tools/net/ynl/lib/nlspec.py
> @@ -144,7 +144,7 @@ class SpecEnumSet(SpecElement):
>  
>  
>  class SpecAttr(SpecElement):
> -    """ Single Netlink atttribute type
> +    """ Single Netlink attribute type
>  
>      Represents a single attribute type within an attr space.
>  
> @@ -306,10 +306,9 @@ class SpecSubMessage(SpecElement):
>  
>  
>  class SpecSubMessageFormat(SpecElement):
> -    """ Netlink sub-message definition
> +    """ Netlink sub-message format definition
>  
> -    Represents a set of sub-message formats for polymorphic nlattrs
> -    that contain type-specific sub messages.
> +    Represents a single format for a sub-message.
>  
>      Attributes:
>          value         attribute value to match against type selector

