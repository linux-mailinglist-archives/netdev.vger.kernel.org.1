Return-Path: <netdev+bounces-231781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA0BFD67D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53675565B47
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D9359FAC;
	Wed, 22 Oct 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbnN3bDQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AC35971A
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150517; cv=none; b=a0XqXeTnlZchYfTRFCGJbg6WA7i77XMt+8c6zXAIYs5pVVyhkbXoYfrG9N57if5Plq7cm8iuuyWdu0eN59dsWczhfRkwO+Y2/csuz8vYbGy91fUwdI9UP5+otYDpifn8Mh9d54u9NlmO9woFwq5XuIeico9267QtjDBKiLUn1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150517; c=relaxed/simple;
	bh=jz2HdK0Ih54fb0mhqTghzLrg/4rLGwrJQTQBb9v8lPk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na+dC5KC2oWEoqj5N0ZlUdxl1HZxkIluLhpDBLP5PqhlJTRPncEFeDPVtaFw9pVHzvraJ66YFOgX8FAgxWE9Ni21TRL5MzDeM182kdP7IUGFaorw8N/RZamk1AjxDkueeXINPI8aO3y2g9/mni/z3Mw/iTwnTlcyJsnQkOiOKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbnN3bDQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ec291a325so5096602a91.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761150515; x=1761755315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vWDPEez/Pn/tuHveZVqlQ/l+YWt3ZfTtD2FdR44qSs=;
        b=IbnN3bDQCMng84tfaYf8jItC/PSyvEkFfZzNf4NhnVPBVjsciOVlugbdWSfHhQvB5a
         fTbNMTgHqZwxMw08jciI0/skm5YpTev61XQRrTU/YoRr+gB0xVQ/cUWgT2dwI5CUSGB+
         rR4MQZ6H1tQxycU72LMiTK3lGXZQolevZcgfiWXS5my2T+fN0vn8PAArqUXdhM11MwE1
         Sb/lPodwPILzmjfsym29OikRmfsLGkqirnpsLjAOaz4/FpLMFulIWrpGJk2goF4aS/Pb
         4dbv/txJrn59jJe8pa27aRd5AhSnaW37TUxJLW01QKbda2LPAsiCOBfy8c49IXic//Hp
         8OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150515; x=1761755315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vWDPEez/Pn/tuHveZVqlQ/l+YWt3ZfTtD2FdR44qSs=;
        b=Zxp9V82eTsdhMw/KDE02CvCmhmFjrRrH4IyBuUw8xFYS373nNbKpWIF18HpLpeeEU9
         kN7twCGeV6s3Oxfl7XKS5F01I3M7kZ6vsdsjtFFdpfyLKDnaZH40AHhE8KHOpYruKe0N
         SOFtDt75FEGboG5iwX/uKJhJEBzxsQRMUU730gezU4qdjarbIIzzIcoh4AnXV1vgaOHS
         Tfd9XEk6A//mvVG0tQztY8TbvzYtiMVxXJ7BuO6S3hU0506bur3C+JLRsWH2TY+4Nt/5
         7PeNVykrzyB7AFPUWB/HSuFiYdqtKapYwvNcjPCvfu8oiz2G0IaesJ2Fibh/C2aEzQMF
         A6+A==
X-Forwarded-Encrypted: i=1; AJvYcCVJWtLyyLinis1+yJw8p3MrGsiU+G2gjYM3DTezzOA6w/KDHkEcGQSBawxKu3mKJgdxiMBzTQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOR/Yg9zxdYQmKZ2fqMwo4YNEhn+r6ak8uz1QETImIG00OScPa
	Hi3d3ii6/Yf6Bgy8vfehdHxNiLq7Z4mpiV62yjIBioOvCNriV6q5z1wa
X-Gm-Gg: ASbGncsg5ZP5k0tC8fjUjX8vfMKeNvl9/19SC8RERN9IpgjOKS4veyXFCmwG/xEdknR
	A48gJ693jyiLuAIdob97Lqaj5z0x+moV8nAN3VlGrLYzUb03szY5vMxmpd37aMwEsurXbhVx3i+
	i0dXPT6rsmVMbh2fEZ6fOyXhKAqmsGWAzUtH1Obz/A3+/Cby9zxIMriKf5mVT3QU11hKWpcCDfa
	kbK2EU91A2cu5uPYG/FTyvEbNQ9w7MxP2Ev88lJX80NpIRUUsiNdzOlTKHMlOG7pXWlBjzo/dEB
	YAyy1pweBNdeNNkeZcUU+P9qnVY4cATrKTyUl9C5Tg4pjBiZ8mbjlSm6YT6YZhn+Yv68TvLO9iU
	MsoYghUJZNF4BaUUzLzBQmQgroBxukXjn4PLDiQWnWkvkz+1Vlb68Sh3ZHQqYu5N7+cmB+9TUK/
	6HZqU=
X-Google-Smtp-Source: AGHT+IHusUArV++0TfBaUizLya7hy6xUc0z7VcX1xC32O50I38HzPymcYuHT2IKLOX0EfF4dDywsEQ==
X-Received: by 2002:a17:90b:4c92:b0:32e:32f8:bf9f with SMTP id 98e67ed59e1d1-33bcf8f9960mr25809884a91.30.1761150515038;
        Wed, 22 Oct 2025 09:28:35 -0700 (PDT)
Received: from lima-default ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm3041328a91.3.2025.10.22.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:28:34 -0700 (PDT)
From: Your Name <alessandro.d@gmail.com>
X-Google-Original-From: Your Name <you@gmail.com>
Date: Thu, 23 Oct 2025 03:28:26 +1100
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Alessandro Decina <alessandro.d@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aPkGKqZjauLHYfka@lima-default>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com>
 <SA1SPRMB0026CD60501E3684B5EC67F290F3A@SA1SPRMB0026.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1SPRMB0026CD60501E3684B5EC67F290F3A@SA1SPRMB0026.namprd11.prod.outlook.com>

On Wed, Oct 22, 2025 at 05:41:06AM +0000, Sarkar, Tirthendu wrote:
> > From: Jason Xing <kerneljasonxing@gmail.com>
> 
> I believe the issue is not that status_descriptor is getting into
> multi-buffer packet but not updating next_to_clean results in
> I40E_DESC_UNUSED() to return incorrect values.

I don't think this is true? next_to_clean can be < next_to_process by
design, see

	if (next_to_process != next_to_clean)
		first = *i40e_rx_bi(rx_ring, next_to_clean);

at the start of i40e_clean_rx_irq_zc. This condition is normal and means
when we exited the function - for example because we ran out of budget - 
we were in the middle of a multi-buffer packet and now we must continue.

If I understand the code, I think that in that case we just set
entries_to_alloc to a lower number and return fewer buffers to the
hardware. 


> A similar issue was
> reported and fixed on the non-ZC path:
> https://lore.kernel.org/netdev/20231004083454.20143-1-tirthendu.sarkar@intel.com/

This is indeed exactly the same issue, but I'm not yet sold on the
diagnosis :D 

Ciao,
Alessandro

