Return-Path: <netdev+bounces-69674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21784C220
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A426128F8BE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4DD271;
	Wed,  7 Feb 2024 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG0Fl5r/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27310962
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270357; cv=none; b=mlM/wZon9hqhWASbwz1P09zaGr1Wa7OkOcji5HtrE7Nvdfnfr00FMvG/N1rDcozCRpcmScxUROCOMWxz2PkFQwnRGsOOiESrrFhSysIPJCr6O8+qv/IDfPQjKZVdT8OFs9QLDl48/9VBn/15P35eja4WAh1U8lOq7fP0HDzgoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270357; c=relaxed/simple;
	bh=r8YA/ZTwPxYai29i39djvq0vr1ID4/+uV/LK4EMs1hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APiu6vmXMs2NiU0jlL0FXknUL5t71IB79IhPG+KgZlJRBEmVh8Wad43bb7PKRighKMpjomoVtuTVACPxDDfbzbsVkSxxoZrXvK4nTqEF1j2d0jV2+mdZF5dYo4V9IGItKkU+prVqEQzKN6Jh1HyRx5mCeSTJybIj5fwSxWqMGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG0Fl5r/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-296dc0cab6aso111997a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 17:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707270355; x=1707875155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxfKM3s1RoskVoSnXHHH6seSwo8V6zmijFmN9/TtGFM=;
        b=WG0Fl5r/3563QTMjJluW3CnmZWvlRuj7bzKZOLz7QnWvHwkJ7R51/+nBIl1PQGRO7f
         3TWKXhuXTuzgD1d5GaE+XIP1aL6/Oh/5GNm0siuj7Or7PSxWmbbTt2cwfS6vFXtdKRtI
         KtKvE7i8Xxs2KA407xsVKfRAt0OADw1XwzZZXoNhfqD4X8o4E//jJxkijs/llI9CKuaU
         akF+crQucIskh/obVCdVYbD+rPGIrjn6FLOFGZMxl6F1nor7GWi7eMKHovkcbqPouTEk
         yQAZmjt0msDVoohfnCr6xF3rWFimWA5OKqK+d8r1s5w/1Z8AbiQeijfv2uXW3SDNxYxw
         LNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707270355; x=1707875155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxfKM3s1RoskVoSnXHHH6seSwo8V6zmijFmN9/TtGFM=;
        b=cbn2nnnPGGrV7mHdx4elSjBtBrqQdDwPjjsYqbuGe4G8db2CGGV2OnMj+/tG9+t32j
         pjKp9cugXXzw3MEqn0V2HmEoDGKsMF+aHVhf/sN444ZNHBjrntcQdUecn7OeM+JTii8F
         I7klM+sEIP8Mapgzgp/K6RQ0VV4yGw0tEjXcNouBcW+4XUcGv7I4cykA+rSWZAdVf+PV
         G4BvKMrZWiCU4NnM4xJiFLp659t9xjMtraQoZzf7FBGtf2BytTBJ2q2+e1zhjDxZh+ky
         YcLeYKlLz3qJji1lkPKdVFBf+TlPCvXj8QRpCUeVg5DwWzkHPh78RcKqJrT7AXh/uTUf
         xtYw==
X-Gm-Message-State: AOJu0YxiO7vMkGXTfv+7mZ6sMrJdnA1WIxeOUtA6E00hBf1pso5NKNS7
	+Nqe5atZzUucZ/eA9WoFA2VhwaTxraIohcyQv4xnZ75wflu/tMyL
X-Google-Smtp-Source: AGHT+IGeT0yIwxg/VJvfr1kSAeL058PorKIHl86cQpQSA4LlYffpd7gt+26ZMWDMkasTfP1vOD00vQ==
X-Received: by 2002:a17:90a:d243:b0:295:cf1a:fd65 with SMTP id o3-20020a17090ad24300b00295cf1afd65mr1639151pjw.22.1707270354744;
        Tue, 06 Feb 2024 17:45:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnzjb20AvqERsYOn2XNi2Lb1MTMSolNKEEzno+CnQt5nR5eCMYfzo891UB5ybPGn/UbwIZ++IcKRwfQkjLmpaXf1te0NgHmihnUv4BYRn8dhz5tJCTJ2m+gWq4CVt9w97QZ+ZjbdC+UY/sALj9vf7PwG99b4b31qQ2XCZbyxKsO1C05kaaQ5EWASV7h6+5V0YrcdHPLdw89YLugMWuX9lmbQnGnbdvpbBBs5KIvPk6ERhmquomb+VFqTNRlpmzED2aTg==
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090a065600b00296d2483d10sm246838pje.47.2024.02.06.17.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:45:53 -0800 (PST)
Date: Wed, 7 Feb 2024 09:45:49 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net] selftests: bonding: fix macvlan2's namespace name
Message-ID: <ZcLgzYeGeuSZcXOC@Laptop-X1>
References: <20240204083828.1511334-1-liuhangbin@gmail.com>
 <20240206153515.GE1104779@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206153515.GE1104779@kernel.org>

On Tue, Feb 06, 2024 at 03:35:15PM +0000, Simon Horman wrote:
> On Sun, Feb 04, 2024 at 04:38:28PM +0800, Hangbin Liu wrote:
> > The m2's ns name should be m2-xxxxxx, not m1.
> > 
> > Fixes: 246af950b940 ("selftests: bonding: add macvlan over bond testing")
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Hi Hangbin Liu,
> 
> I agree this is a nice change.
> But it is not clear to me that this is fixing a bug.

Ah, you are right. I also just realise that the previous code also
works as we use mktemp, so the m1 and m2's name are unique, although
the m2's name using m1 as prefix.

Please feel free to drop this patch. I can do the name modification in future
when updating the bond_macvlan test.

Thanks
Hangbin

> 
> > ---
> >  tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> > index dc99e4ac262e..969bf9af1b94 100755
> > --- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> > +++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> > @@ -7,7 +7,7 @@ lib_dir=$(dirname "$0")
> >  source ${lib_dir}/bond_topo_2d1c.sh
> >  
> >  m1_ns="m1-$(mktemp -u XXXXXX)"
> > -m2_ns="m1-$(mktemp -u XXXXXX)"
> > +m2_ns="m2-$(mktemp -u XXXXXX)"
> >  m1_ip4="192.0.2.11"
> >  m1_ip6="2001:db8::11"
> >  m2_ip4="192.0.2.12"
> > -- 
> > 2.43.0
> > 
> > 

