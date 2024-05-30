Return-Path: <netdev+bounces-99228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886428D428D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720A01C23043
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93EDDDC5;
	Thu, 30 May 2024 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POWKYB+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C212E6A
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030361; cv=none; b=bQ1Z3Ye7I18R5BiaqRh7FOThDw0XGme+MxAcDZxl3yLHlbzpEjVIh9IBKS1VEdnhd8cgzGtMw3o9wsnOHh9kKLjC2ZiIesOj7OV6znkozxYU9GTIFZdFeeyXq5r6BktpgMIwVOBoASJ4ZOLSc3ht8I9okrF6CgYqxOd2PRx5K1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030361; c=relaxed/simple;
	bh=k4RuBYh6K4krduuzbkfXc9Ttcm2ttLqgshLo45xmBzE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dV79xdudxuRoCanIrUTeAaydFsZFtA2jYXiy5Dd2effcldeV++dUgR/p4x6nOMgH4UIyHl7YJ9hiyGrsdsrYt2HI8R1mQ1ODd5eiFs0L6Dv93whGkd3MqeqyATW61iBaJ/5yhiDxwB+6KJe1dGszCIZGNdSZQLHPXecJ5sMwY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POWKYB+W; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792bdf626beso30622885a.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717030359; x=1717635159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU0yfJhGij//9cKpPVhaZj4C6FyI3XwOW62BOWEZGIE=;
        b=POWKYB+WBynjGRBfQQAncZA6rNMCsSKtL+KUPSv95UWZ9aHv5MBxqLM+8MJbnfbvZT
         xgT/beZJnggcZROZpnsSM4BZW6aF+/lSSzTGNLJlrXSQYTzRhW8mJK5bC3KOB4mvu2U/
         SqO6020oXYdEwSQemVLOmN/w7m+reNyu3rC2/klzoa5ushUzUVXlQcgLAD3j3CfFmkx+
         EHk1+sy02e4LcidUXySqxei6on1vOyVuPOvV+Fi2KP9b4roep7JsgkTljv8gPF2MIcT8
         F9dag+RWpQBb4WB9EFsOJenw75/UINsRWfslQesMbZK/ukxy21jRjsW/iQF8Ptxitn35
         XHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030359; x=1717635159;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EU0yfJhGij//9cKpPVhaZj4C6FyI3XwOW62BOWEZGIE=;
        b=w5T1WwBjdT1bZJhXcGHQhfoGLqAc2YcJizEnV5ZTORkJo/9bw4R54+Y8wrfaXc2wat
         Bem0ohU2ngmx2zkrN73gFuxjxlNS+qWzr5kcSI7xi/L0i9+d58MxtFZfyIQfBei6P8UT
         RmQyfeWJaEqwfdM5aPXtNmZGJdf77O7eIQ0p9VlUVzk/nzvJw1Z+D4h4WyJMErYd6SJL
         0RUpILIex925zlJLG2+6VwbhWULkGusFy8R7OqMY/ZvIBGNohuU7WBmlfWoNGXYjiHSt
         c3rviUnMXrtVPCxjI6lK59HdltAfQPEL+VJ/eTL/9GqdVfGhX3PYuJcEAaj78AFTjPlH
         myNA==
X-Gm-Message-State: AOJu0Yywy3IY+HnOD+H9VCpZYEf255Zp4iTGIL7vkXxq+UXjfHhTdhV2
	CbIVt/poQR2yYfmoqlLY/UlC7kbxPEmPaXO7ku+oeduy/tcgZi0K
X-Google-Smtp-Source: AGHT+IFMyBoExvMCOpsBSrCY86iUKpd/Pyh7aE216Tu1IS+83m+tnVZIiZh4APVW9VEhcdsfFVDcVg==
X-Received: by 2002:a05:620a:2913:b0:793:b53:7f83 with SMTP id af79cd13be357-794eb07422amr77425785a.28.1717030359069;
        Wed, 29 May 2024 17:52:39 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd44ec6sm510041185a.133.2024.05.29.17.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:52:38 -0700 (PDT)
Date: Wed, 29 May 2024 20:52:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 steffen.klassert@secunet.com, 
 tariqt@nvidia.com
Message-ID: <6657cdd65fede_37107c29432@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240529104846.3d0b4651@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-8-kuba@kernel.org>
 <6641712443505_1d6c67294c7@willemb.c.googlers.com.notmuch>
 <20240529104846.3d0b4651@kernel.org>
Subject: Re: [RFC net-next 07/15] net: psp: update the TCP MSS to reflect PSP
 packet overhead
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 12 May 2024 21:47:16 -0400 Willem de Bruijn wrote:
> > > -	inet_csk(newsk)->icsk_ext_hdr_len = 0;
> > > +	inet_csk(newsk)->icsk_ext_hdr_len = psp_sk_overhead(sk);
> > >  	if (opt)
> > > -		inet_csk(newsk)->icsk_ext_hdr_len = opt->opt_nflen +
> > > -						    opt->opt_flen;
> > > +		inet_csk(newsk)->icsk_ext_hdr_len += opt->opt_nflen +
> > > +						     opt->opt_flen;
> > >  
> > >  	tcp_ca_openreq_child(newsk, dst);  
> > 
> > The below code adjusts ext_hdr_len and recalculates mss when
> > setting the tx association.
> > 
> > Why already include it at connect and syn_recv, above?
> > 
> > My assumption was that the upgrade to PSP only happens during
> > TCP_ESTABLISHED. But perhaps I'm wrong.
> > 
> > Is it allowed to set rx and tx association even from as early as the
> > initial socket(), when still in TCP_CLOSE, client-side?
> > 
> > Server-side, there is no connection fd to pass to netlink commands
> > before TCP_ESTABLISHED.
> 
> Mostly for symmetry, really. IDK what's worse, the dead code or that
> someone may be surprised it's not there.. Should I delete it?

Symmetry with what?

This dead code had me scratching my head what it was doing, so my vote
to drop it. If you want something, maybe a code comment instead?

