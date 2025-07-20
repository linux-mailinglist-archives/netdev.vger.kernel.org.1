Return-Path: <netdev+bounces-208385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50622B0B394
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 06:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F248B189C5EE
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 04:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E90A19DF66;
	Sun, 20 Jul 2025 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvDXH/WL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C81C32
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752987220; cv=none; b=b4aU3zKxpAHG+5aot9w/l9fkrmqXgSemsJ6hXAjOEqHmofi0ZZUAq7MWxaacFVXa+PGbc686ujNCe60JxLLZBtvd7VVhcfyEdcvAW5jktM1dibv3mM4GI8omtTNy1/6VM4LxRK+Tk/buTFrATNzl8/5cWfpac05b7WMYNakQaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752987220; c=relaxed/simple;
	bh=1pbmUFZkS6Rn8eyuak4flVQ/+1I09AKCZZT24rE+7PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ni0H3jinwQ7od0pUnoNTEBll8D4k6KpeJIUC3NeeJ/JVZb83euOKjz5MQ/9OjwZiU8I56EXfrdDps/hKv7530XSp0p54stiRLZq4bKhWnAeyIHd/lVaLeFOhmZtCzH/Q3Ot4szoxJO+ffrz4PHYyLmi0ls1gKJOAXYoeodT6p7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvDXH/WL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313154270bbso3315499a91.2
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 21:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752987218; x=1753592018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TunjkI95IMphLR1F3DEmcSNcHuqiDjdUWsmvhl/oSFY=;
        b=WvDXH/WLI8OM26IEmSQI7CyD66JJIyBWrZQmx48Fa7Q1psb68eNc4NLcdUFCjWm6uk
         RuEjrxcKNn4vi9a2vjCQQeQWF8ytu9KeG/8HmqzqFigZwEWY6DpUI/JfeW3PWsuw+tzB
         VJ2dYYP07K8l6syq2sOHZbXEKri6tU2w80bSaBmf0lxVJncB+2n2mxcU+mJDHsVI5K9i
         9v+U29IG12bCCFQ4nzxn1GAfQ0qyQg4kIOxV7fxOQMy554rgGeHMMjJa2MGMelhpA/UD
         qZJM/BOn/Q8EwILX2OtAjNTg1AMWmmkLvcPK2bcUvVQZwqmRJYiU58IOl12ion4LIE6f
         27mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752987218; x=1753592018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TunjkI95IMphLR1F3DEmcSNcHuqiDjdUWsmvhl/oSFY=;
        b=WY1T74hIo35n2mylXSJyqjz0sShQCgPD0eWKi1E3c0lzW+fV0iwjz3wZILyVs4jJYc
         bwfKL2AM8fz6zV8yA8CK/JjOin+PEusf8Rr89pnrNuteQhWsmYn8s5CiSZzpzkx+Wgtz
         Q/qlohqH87NVK+MGBX3crZ5fnpaF7TdJ+KovqW3aViEFz57Feqkna0CGEbGsPQv6ioHm
         dspRbmrfV29nG1csoc7bz9e8Pva2BRqsyqE04MQexpb0tJEdnNXOLBbrpdpH0G8AK4IH
         7uo3vHKqKP4l7TSadrLVxOrWkFA57jtH/7c9L6oXg4wouxwznz4HY+vpXInFxOdZOgVr
         laQQ==
X-Gm-Message-State: AOJu0YwZSaRe5LuGrNIB886vvKNqqN4xzVXzBlaIPDl7bTAY3aWP9Suk
	biap12euYFiXurNlwu00MTeo/9KtA0CHLPTnM/IS8zwXVOWfJWocXamQLaNnwlTNp9u447wMpHS
	Ne8jZhvIP2gYtXEJ93Bb+y4NFt20oHV8=
X-Gm-Gg: ASbGncttWSLU+cKbXkszJau/YAdOKcwhljl7wSA51VCVsOF2OOIi4WcBu9f53ZxEyZB
	YpmOmOIQtdhx7wShkYAHmNo9UsapQtcuJIOXyfAU4qjstyT3zjT3T7wZk+DEoZ/ZCza4E7CMQEN
	pMI0duIBXMUq/b7NV6rQ7YdZ7D2fwBBTeXriRJ/f3Q9ync/FsFdBgmm08HVvI8jW+BORYqRXBmJ
	DmZtQ==
X-Google-Smtp-Source: AGHT+IEVGIAPYT1CpQi6h+NQ+HllxEdUZ8h5B5er7u5BHtAQasr1UW/VtHh+u6gtno2vLTc7vBMKzlWUbKcwS5+q+kg=
X-Received: by 2002:a17:90b:5307:b0:313:db0b:75e4 with SMTP id
 98e67ed59e1d1-31c9f48a241mr29150949a91.33.1752987218240; Sat, 19 Jul 2025
 21:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715112431.2178100-1-krikku@gmail.com> <20250717075659.2725245-1-krikku@gmail.com>
 <20250717075659.2725245-2-krikku@gmail.com> <20250718175847.4f4a834c@kernel.org>
In-Reply-To: <20250718175847.4f4a834c@kernel.org>
From: Krishna Kumar <krikku@gmail.com>
Date: Sun, 20 Jul 2025 10:23:01 +0530
X-Gm-Features: Ac12FXzVvBD3okmLtvZGXsuu0v13BhYU7sV8HDWOi95Y00TSwd68_5lF291UM-U
Message-ID: <CACLgkEZVa7+uvK9hn43=jAne-8X+3b=vUV-gSR8zGQtvrZbjUw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	atenart@kernel.org, jdamato@fastly.com, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack. Thanks for your feedback.

Regards,
- Krishna

On Sat, Jul 19, 2025 at 6:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 17 Jul 2025 13:26:57 +0530 Krishna Kumar wrote:
> > + * Return values:
> > + *   True:  Flow has recent activity.
> > + *   False: Flow does not have recent activity.
>
> This is not recognized as valid kdoc formatting:
>
> Warning: net/core/dev.c:4856 No description found for return value of 'rp=
s_flow_is_active'
>
> I don't think we need to enumerate this trivial set of possibilities,
> how about:
>
>  * Return: true if flow was recently active.
> --
> pw-bot: cr

