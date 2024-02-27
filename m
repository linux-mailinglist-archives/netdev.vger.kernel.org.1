Return-Path: <netdev+bounces-75308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA0869162
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AF91C2660C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D713AA5D;
	Tue, 27 Feb 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="M7Uvpsyy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3431332A7
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039276; cv=none; b=AzUO8aWy+caG0F1DwLOZRhuTLaN5sWrNCuSKpfEDq29pGGuBFmuOKO7Nsz2k1nnrIEypF22gjJicXq04uw7MFg5rZ084r3H/O0JzWcRwBXnB6WrnDLa0BOET7u248e2+uY0XeEvNdOe+BaPT/jDWo0cZ2qYI3G0GDMxzV+R6MM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039276; c=relaxed/simple;
	bh=1WxBAiZy/0qlVchzRdF6ZXMfaH+mXqGjh5x7cP3gBY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0SrZkh6T73ZkRqOpW/SBJyIX1WulD4IrfXFRwp5JOdtKeTAe8kWc7LZ66VjneZ+cahC4ttMl0FmwlvyvY3c5CBGtevrIok+dBvdX+Nwwk4vVdXgc2xDJ/oynz7QX/mWhryc0db2d8iCiHhxa4rWtS1Ayhl19Ig2TP6YyObfawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=M7Uvpsyy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ddebaf810so939023f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709039273; x=1709644073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3f8UXKffxuu/SZG84Qq7Qm9pXyudjr9up0pqIXIfTXk=;
        b=M7UvpsyyQTgYMhdRXukM5nJlPdbv0OeknvflRil3PLkE1MpRTxw4DyjWtp75/DAIZI
         Zmz6hSpm2MBryyQax22MWW+eb8SuT+1UyzamyLrsEW9PAXkF4Z0eUuhNYr4H76AWDv8g
         jZDaQ39mlT6Tup1nWUG76Ibl11luksn/mgW6GaKbfyawGbJgiZgykUmRAwVbmHEXxmpl
         TZzMnLVPpFn+4th7+TOPSl5LYoQDz9P/X198eqS+q1awSEXl5ASgHz4snI0ZcsVeHsqU
         WwM6qG5E9x4ivMZuyQxCp4+XCCZGuUAj5dKIIgyOqWNWAaHk/ypa/Phhrfjla6CbYt0Z
         VNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039273; x=1709644073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f8UXKffxuu/SZG84Qq7Qm9pXyudjr9up0pqIXIfTXk=;
        b=IswAiSMfjDJ/Xc2v7ozTtkM6ky6JjcscagNGx/EXRHLWOsa82n0O55a6GL9XVKsgCU
         I0xycqVeJtl6N4tRU+WyNK5II19t55MNgqC1AemGu3Gpf9+d4HiToc7DhS3yoQDYRlMI
         8qJKHsCsjBWZYL/rC6nkHrpnYQxjWj7xiQBuRfc+r0+apK7WLys3brdgDAVNjGtAq84n
         cH3941yI+EtB15FNcMYCy0IC6fRRI3KgHGuRGkseisssj2UhFe4Ii8ifrhnZBB/srNdA
         09rYF2v2XGwg2AmEiG9VFi6YWCnNn9SzsaPCOXHLNO9o0y+yIW/hE0uFeflN6A4E6jMk
         rZng==
X-Forwarded-Encrypted: i=1; AJvYcCX2lOWIB+uDoomm2raErJ1MkBWm0yKb7Y66rrMtUgJCKQNtoCpr+IMias5DP7nWsdiwvhDZT/HDSG/IiRpigincW2lL4Dt9
X-Gm-Message-State: AOJu0YykItT+eqxEnRD3QZdFyZ5BhGm4ciOuFCUxSQ1ZAySkVEjrXFbx
	/J62n+OhcWh6orDKtOV3uMZEcagX2BW/lAH/ZFal7hg8+7zc6d97c0gLPHsNJ4Y=
X-Google-Smtp-Source: AGHT+IEEYJBrcFZPLk14vhagkXTwLD37r6SqTXRlAS1qQ3UsjFY930MOD/SoQVHGCEte2LwJxONb0Q==
X-Received: by 2002:adf:f391:0:b0:33d:3072:e38d with SMTP id m17-20020adff391000000b0033d3072e38dmr6324237wro.21.1709039273069;
        Tue, 27 Feb 2024 05:07:53 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c1d0f00b00412a31d2e2asm7926618wms.32.2024.02.27.05.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:07:51 -0800 (PST)
Date: Tue, 27 Feb 2024 14:07:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/3] inet: use xa_array iterator to implement
 inet_netconf_dump_devconf()
Message-ID: <Zd3epaTHEllJIeRO@nanopsycho>
References: <20240227092411.2315725-1-edumazet@google.com>
 <20240227092411.2315725-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227092411.2315725-4-edumazet@google.com>

Tue, Feb 27, 2024 at 10:24:11AM CET, edumazet@google.com wrote:
>1) inet_netconf_dump_devconf() can run under RCU protection
>   instead of RTNL.
>
>2) properly return 0 at the end of a dump, avoiding an
>   an extra recvmsg() system call.
>
>3) Do not use inet_base_seq() anymore, for_each_netdev_dump()
>   has nice properties. Restarting a GETDEVCONF dump if a device has
>   been added/removed or if net->ipv4.dev_addr_genid has changed is moot.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

