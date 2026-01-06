Return-Path: <netdev+bounces-247386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAEBCF9292
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C6A630ABCD7
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8F338598;
	Tue,  6 Jan 2026 15:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62E3385A3
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714244; cv=none; b=WS4STX6GbSGR8c4OAcq1++fnw7/DpVJx4cU3qcbA0G2S2IrcH4r/orGEWTcsTxxu2OHrwV3x7YqF/+aVppkfGZM/pN59rBuZMX9sZgkm3RTbcQ+c6yXLa0xU9SgQWEF6zUFt21z5VRg0B+BopNtC0nChSqR/ehRbrMnmSvj5YxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714244; c=relaxed/simple;
	bh=BqOpJV9wovi2tuxvyRO/WtX0y33VlCVKPpFXhYRgQAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xxy9lEzj2W6Q5nAbvmskQ5tckMTcLUIwkOrg7BzW1JgyJXztfwikH0/WutDLSttfwoxRPxlc5M1k6treKVl1V1G/xpv7c2S8gZ6Ea8a2AgTZIE5x0chCcNbf9U7Va9QphoaXiqsMV7kcXGRQEeUI7QICrBzOQ3v76+lCdBJEPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3e7f68df436so747935fac.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 07:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767714240; x=1768319040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ/bFBK6U14yUT0svz7qonQ3kLF4PS4+v+BV335c2vc=;
        b=fyyuSLvLzQMH9Weorb8NdC5HJWNhxU11/aG89JdIAsCMO4yF/2onyZg8Xc6zd/dZ7S
         VmIk717el24hniDGftXUvImDoMudgyolxA8enHpqoxPR8Tb9S5f4xXDMGbenB+HHp2kz
         nxOY9UNbDKE3wcsoLNVv4ztIptFlhsTi8pGno74uTsVyUCOzzR4fKjM7EqR+VQAEopew
         Uz6YlVc8KX1MvtpNikEbyKRi5D4xzCDWHiy6gb66KZ5NTDXFxefQ3Bld0pA0UTXQua1+
         WCyq0iISQOrGEvg1wmMQCkiNKyYcGpoIlO8B86/Fqm6wLrBH/IZmsRYz0Hd89ZLnFVem
         UQtw==
X-Forwarded-Encrypted: i=1; AJvYcCVSSDhMxOrnEceo9auSjch4CPA/vqwRAUK5J3JzIYjOUqWfIuixSvUC3bl+JsS1P3G1C1O0BWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy55TyckGlZBSlBAq6OD66VmOPy0DhDH9GjRBFgEUE1ykdzhT/
	JX3/yeKZfSwDhVqWBphDK90PT2y1PysXLPrDE0vd3MGCEM1rUVFxc85W
X-Gm-Gg: AY/fxX4b9xEZSE3LPKd3wkjGxUurbW+9fzsBqdXg9mVF02sXA/JxL6DWPhJkuryUZU2
	p2dinNKm4dKVChhZRvSX/DXIoW8anMwSsi2zD9X5vTCdZcS5v5fWH8fAGUpat9CfzwSXdhrM9xB
	tCgNYHICC8EHAgqIir1JvWDRHpR7Tk3YlkaN0jUsrU7wVzai9qtCPyPyswNUWBN1lGWAIN7E5Fl
	RiSl/oJSOZbAY44Tx67evmOlsPibd/9UG+4PwQixdnNf+WOb7oYrAxM0DWJAnxgPsXIt/ox1D9T
	TFRI4O4uExq/ziYbNpoaDSNnh0PTg+OHCnLqdylULmikyYGIXrqBhIplZjApYX+mOAJ2z32fcAR
	J+WlaDz62ULFLTYrdUU2dgWx4o+MUONfdVcc/AF59474+AQmppiZhOpGY6vIZLqrDTCoD6Eho7w
	86tv9+ySyWrZCyFA==
X-Google-Smtp-Source: AGHT+IFZaWTKnaQ9Tl7M79Sci2bbLgAstL+e7Dg7IjSeMgjB3YuAS16hkGm3jbs4+NdPX4FFb6LIJg==
X-Received: by 2002:a05:6871:4e94:b0:3e8:926e:bf9f with SMTP id 586e51a60fabf-3ffa23e236fmr1839017fac.13.1767714240190;
        Tue, 06 Jan 2026 07:44:00 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50dcfe8sm1434403fac.15.2026.01.06.07.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:43:59 -0800 (PST)
Date: Tue, 6 Jan 2026 07:43:57 -0800
From: Breno Leitao <leitao@debian.org>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, 
	calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] netconsole: convert to NBCON console
 infrastructure
Message-ID: <l5u6w3ydgfbrah22dbm2vcpytqejfw6aomvzl5uzh5vssljqxd@suspm42neo2z>
References: <20251222-nbcon-v1-2-65b43c098708@debian.org>
 <20260102035415.4094835-1-mpdesouza@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102035415.4094835-1-mpdesouza@suse.com>

Hello Marcos,

On Fri, Jan 02, 2026 at 12:54:14AM -0300, Marcos Paulo de Souza wrote:
> On Mon, 22 Dec 2025 06:52:11 -0800 Breno Leitao <leitao@debian.org> wrote:
> > +		if (!nbcon_enter_unsafe(wctxt))
> > +			continue;
> 
> In this case, I believe that it should return directly? If it can't enter in the
> unsafe region the output buffer is not reliable anymore, so retrying the send
> the buffer to a different target isn't correct anymore. Petr, John, do you
> agree?

That makes sense. I undersatnd that the ownership will not be
re-acquired here by just looping through the netconsole targets, right?

