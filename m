Return-Path: <netdev+bounces-50547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CEA7F610D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5318FB21690
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D62FC2C;
	Thu, 23 Nov 2023 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDd3sVge"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97661D48
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:07:55 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b3f55e1bbbso591841b6e.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700748475; x=1701353275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fndfJCwgQ1H3nATDA2gXkw25F384XEdKUqVLbEdHiAg=;
        b=ZDd3sVge3dRcrZAkTxuLEEs288393loya1o2RbPLyHeLruAFEgUZrhEl1DGsj9WseR
         Dz/H7voPT7t08vdHDnyIFwdJaeOnbUqYqiaUzeBLmqq298jlyJAU6xPsiEZO2HNjnzyW
         K1UMkUIjdUEaLDqOZLR0XXjMwKZBhEvxAzUdqEup3aIDJYA7h78a3vQcsxb/NMviIqPK
         0DmMixPHN72TV4dGgUJb1mQwX0GMEqbuT+huB1RAo83oylpWPo/h4/kWI+3VWNQUej3D
         6gIfjeI4lYDR/IvjXlqwx1ED6TYZooosvrfQsfrzjwKka1ghhohWsF+tNmvkLm0GlYwN
         Rjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700748475; x=1701353275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fndfJCwgQ1H3nATDA2gXkw25F384XEdKUqVLbEdHiAg=;
        b=mJDu1bmRc26UMxsydJpRLuNz+XGCzTD/B/DX3VeN+Te0ra7VCwVxViI2pNuY/yabKg
         V3vStx6NmQbcM9+Kzm4ISLu0xzsSFUvvTscatUAYNxpHUhoLjbIGYG0vl9Y2wsIGdgHf
         Muikx+Tj19Qy7RPp7rRXwWoHxG3Nje0pH0Bi/SRBFgIJx3IEImyTn4nnxswHexAvygNO
         QR79djmYUc1nP34h7+8vOOlOyUC/k0wp4+IswdsGOBMKxM7ECy3f8bv4x/i/AKt52zED
         Zo/fEWrYN2RNSN7SIcebuOtwP50FZJTH2AYPNojYOJL4GgZkNQUlbSOLhe7NJGPai8mP
         NRLQ==
X-Gm-Message-State: AOJu0Yxhn9YK6g4VqjuVX4vphpAqymAKb6rHBrFU5aOvZj+2kmN1Qu+q
	ZIP81jwaGNJxve4Ya8RA8+Q=
X-Google-Smtp-Source: AGHT+IEqIPBOsUlB1wwxF3Qi4U3qWKKkSBmMze/UuE021V6g65AwkgJwQ0WdcR1UOh5P0uUdgrlQow==
X-Received: by 2002:a05:6808:14d3:b0:3af:9848:1590 with SMTP id f19-20020a05680814d300b003af98481590mr7307222oiw.6.1700748474849;
        Thu, 23 Nov 2023 06:07:54 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s78-20020a632c51000000b00578b8fab907sm1396276pgs.73.2023.11.23.06.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:07:53 -0800 (PST)
Date: Thu, 23 Nov 2023 22:07:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: bridge: add document for IFLA_BR enum
Message-ID: <ZV9cs96B4j0YEbYN@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-2-liuhangbin@gmail.com>
 <20231118094525.75a88d09@kernel.org>
 <ZVwj3kb/3BdvKblG@Laptop-X1>
 <20231121082127.62a3a478@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121082127.62a3a478@kernel.org>

On Tue, Nov 21, 2023 at 08:21:27AM -0800, Jakub Kicinski wrote:
> On Tue, 21 Nov 2023 11:28:30 +0800 Hangbin Liu wrote:
> > Thanks for this info. Will the YAML spec be build by the document team?
> > I'd prefer all the doc shows in https://www.kernel.org/doc/html/latest/
> > so users could find the doc easily.
> 
> That's the plan, it will render under ${base}/networking/netlink_spec/
> 
> > It would be good if there is an example in Documentation/netlink/specs/ (when
> > the patch applied) so I can take as a reference :)
> 
> All the operations, attributes etc in the spec accept a "doc" property.
> The html output is just a rendering of those doc strings.
> So the existing specs are already kind of examples, although they don't
> have doc strings in very many places so the output looks a bit empty :(

Thanks, I will investigate how to convert the bridge yaml. But next week
I will be in vacation. So I may post another patch after vacation.

Regards
Hangbin

