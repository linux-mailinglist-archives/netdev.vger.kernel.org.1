Return-Path: <netdev+bounces-173063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A2A5709B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5193518939BB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331C24061B;
	Fri,  7 Mar 2025 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU7WveBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECA194C9E;
	Fri,  7 Mar 2025 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372491; cv=none; b=mUkV7W8Y9Fr5PrZ3XQ45ixBdtCvrlLgqL5Gllz1+G5lyqEj2bOOzKYvIFAacajqdgTeCEpmmiZko9/HjHlk1hjGjCEIsMasJiWfjzuH5MDfPU2ltU261v/kZavHRLZMjbrYQJBggldI7dEJv7avXaFrpQ6S2qXmy6ylLpgEwmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372491; c=relaxed/simple;
	bh=+9gDGcZfqpQByrzcz5GniB5ENASVWayTOdWAGshyqxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMoufD8TsIdoihfOKgRFwGb/9Zvty8YsimwaaQ3XIJnDjuMHN3tihTo/tRZ4iSXGJbhiK7K6R7joMzfWyNiLKFdEFGxN6XwwrMtDU+wjbLSmaeEizG3Nn2bENRUHJY4wl80ugLJS7WWlO+Nlc4dBP5UkTb9hWelHfM5V5fy74zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU7WveBb; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f254b875so16595836d6.1;
        Fri, 07 Mar 2025 10:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741372489; x=1741977289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haDsDg9goM1Uf0CHzwm79RjyrC+9rpHKIsMViflMU/Y=;
        b=NU7WveBbTWuSDzj1xF/sdhidWew4hjiQl3aaBDVy8nAZd014ARpf8uWuEpfXJ73wAu
         Q1yo65w4sW0OWBJWfXEh9KUEqHbxbnK+dGvT2jd8/iMBDrfeydB7jS0ODmRHirXmky2f
         lWWO8YglwxB75xhVttGwYY7WZgt7idEDj4r/3ADOS/s6wKKU9LWnT6RLUC5ZDEEQ7QBE
         V5aWPtPlK/HsVHQo+Oam1XEDpJrrjoN9v59DtmuiEmj3ArQ/06BsNKPhktJ8H2cfCjVi
         uZh0357LYkL3R3s8dHoYv0x9oMrWv9afPoSRCgHRUWlzuGozo2kQUBD4aDQNE8Q9zaQf
         jgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741372489; x=1741977289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haDsDg9goM1Uf0CHzwm79RjyrC+9rpHKIsMViflMU/Y=;
        b=vddouuw4GZBx33hKmFZCW31TjE0h2KE6lRp6x7gGha1GMO0WX5ntFIMRJQLaZb1tBQ
         TtEnKoXx1MTbdIk3+HX53pnkhQPMZrGFlHv77yeoWRSqyXp38WokJoY3ICRw/tQXvCbR
         KoHP/GiD4tDAAHu5Bb0SMgZU8siP40KE8vnXSgSXGqFirtqxjMVW9dosBb28+1loetGL
         oPonWwJWCxhgZexEfZOoHpi+eQ36L4YMYR0nwgxNJ7mPOi2LpebwNteR4XzsrMjG90Na
         FKs5EtuVAElDrS/s2EzgiQy9s8tll9HvYFaoSKpoMvo9cqIH0sg+sdiNCnMd3ylYC/Cj
         ivZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGuO8biFUz7de5SspMqiCERckIBJQoJO8QTKknAh71JoLCYTffCiXNqVo87yNp2w4Qq6AV4OFZZ22DAtE=@vger.kernel.org, AJvYcCVweNnLumdjNj0FJkRY9XJe46+/xr1yZzQYoQ0wyjzCOEkJRYoW9/kHiw7xqZdBgdMDSUixAUF3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7v5k7CjuiUVFNfZnEjNtox3OT96zFg3QStVxH3XuGTFw5Lp66
	f4YmhfW7vKWEj8tffCYyMcmJgTqsw93J7PloXWoi0wsFfz4Jrtu6
X-Gm-Gg: ASbGncsDnw6HtJJ8nPBLh5UBBa3DBkkKTl/UZg1gH8hRHGGOzHNKe9/szreSNwuZOdo
	3uWYXwretPwD2KxP8/phXC73LOmv+2f/Hlw6qMzdfXqhe9B2Te6oGBbFcHfO4XlV00+42fO9SIE
	8ZeVm8lrnJLjBhZaGnRwsyGFBNyoacL14T5aEC2lYnnPw8vCwGXleedi/AvYcsD1IJUHIIODpsz
	uSFkWdCt4viKpb5EYNV46nltW+RrU/49xt3g6RySZ1/mFzRLQLiQGwTjqfE5X9FkJkGPiEX7OCM
	E8aLbMP4e5rTCXg4Md0qKyJL9jLW0BD37ni/gtn6KADSkw4w0ZARLNvsfk81k0V0lw35AFVhXPv
	WNdanm1sD5Lal4RCE6Kt19P+QIZ7iy5/BkqE=
X-Google-Smtp-Source: AGHT+IFLDTDJ/m0lNtsyy0A68/QZ3C8P/SJZ5YIt5SuaIL7ydu9Y1k+o8fmDRJBpD9rUl+4VX2rTSQ==
X-Received: by 2002:a05:6214:4c11:b0:6e8:fd4d:dba5 with SMTP id 6a1803df08f44-6e90067f388mr44623226d6.33.1741372488754;
        Fri, 07 Mar 2025 10:34:48 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715baaasm22100866d6.85.2025.03.07.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 10:34:48 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id D876B120006B;
	Fri,  7 Mar 2025 13:34:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 07 Mar 2025 13:34:47 -0500
X-ME-Sender: <xms:RzzLZ2orjrHfV27h54b3fPqjExMjafv9lTs68nssgbeEkAWso9qijQ>
    <xme:RzzLZ0rUN47xEZzf7DeA0gEVG-TD8C3eXI7ePDroOsP5zPHkTDHp8iyv2DteklI8E
    zd6pp_EfW8iHjAWbQ>
X-ME-Received: <xmr:RzzLZ7M3GI46BXnJ7gIKm1Mu1Hl-ZFu6Oy5Mt2gwo_LtaIyIyO8086X3Qjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcu
    oegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephe
    dugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeeh
    heehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmh
    gvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rhihohhtkhhkrhelkeesghhmrghilhdrtghomhdprhgtphhtthhopegsphesrghlihgvnh
    ekrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmh
    hssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RzzLZ171QRqxpMMiPdPiEv8B0WA1KakX9NmZPDZsjiSPRJe6c7OjBQ>
    <xmx:RzzLZ16xc2OX_ruE8YWGKJzaqRwBK0Gzsnnoz5mPjlIv313MwlUIrQ>
    <xmx:RzzLZ1iVK9GHxKh-ba3DXJA1yj9s3a2a-dEqNGKn9SaD3olmlTF78g>
    <xmx:RzzLZ_43eaft5SYtZ0R-v-bxekmINh5ogxuxuDmgm_JTaUZM6DfMjQ>
    <xmx:RzzLZwLYwyHlLw8xsieywpQzlnkh8DAU9S4tTSoD5BAm1nDzRL3-iIF2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 13:34:47 -0500 (EST)
Date: Fri, 7 Mar 2025 10:33:36 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: bp@alien8.de, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, peterz@infradead.org, x86@kernel.org
Subject: Re: request_irq() with local bh disabled
Message-ID: <Z8s8AG3oIxerZHjG@boqun-archlinux>
References: <20250307131319.GBZ8rw74dL4xQXxW-O@fat_crate.local>
 <20250307133946.64685-1-ryotkkr98@gmail.com>
 <Z8sXdDFJTjYbpAcq@tardis>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sXdDFJTjYbpAcq@tardis>

On Fri, Mar 07, 2025 at 07:57:40AM -0800, Boqun Feng wrote:
> On Fri, Mar 07, 2025 at 10:39:46PM +0900, Ryo Takakura wrote:
> > Hi Boris,
> > 
> > On Fri, 7 Mar 2025 14:13:19 +0100, Borislav Petkov wrote:
> > >On Fri, Mar 07, 2025 at 09:58:51PM +0900, Ryo Takakura wrote:
> > >> I'm so sorry that the commit caused this problem...
> > >> Please let me know if there is anything that I should do.
> > >
> > >It is gone from the tip tree so you can take your time and try to do it right.
> > >
> > >Peter and/or I could help you reproduce the issue and try to figure out what
> > >needs to change there.
> > >
> > >HTH.
> > 
> > Thank you so much for this. I really appreciate it.
> > I'll once again take a look and try to fix the problem.
> > 
> 
> Looks like we missed cases where
> 
> acquire the lock:
> 
> 	netif_addr_lock_bh():
> 	  local_bh_disable();
> 	  spin_lock_nested();
> 
> release the lock:
> 
> 	netif_addr_unlock_bh():
> 	  spin_unlock_bh(); // <- calling __local_bh_disable_ip() directly
> 
> means we should do the following on top of your changes.
> 
> Regards,
> Boqun
> 
> ------------------->8
> diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> index 0640a147becd..7553309cbed4 100644
> --- a/include/linux/bottom_half.h
> +++ b/include/linux/bottom_half.h
> @@ -22,7 +22,6 @@ extern struct lockdep_map bh_lock_map;
>  
>  static inline void local_bh_disable(void)
>  {
> -	lock_map_acquire_read(&bh_lock_map);
>  	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>  }
>  
> @@ -31,13 +30,11 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
>  
>  static inline void local_bh_enable_ip(unsigned long ip)
>  {
> -	lock_map_release(&bh_lock_map);
>  	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
>  }
>  
>  static inline void local_bh_enable(void)
>  {
> -	lock_map_release(&bh_lock_map);
>  	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>  }
>  
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index e864f9ce1dfe..782d5e9753f6 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -175,6 +175,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>  		lockdep_softirqs_off(ip);
>  		raw_local_irq_restore(flags);
>  	}
> +
> +	lock_map_acquire_read(&bh_lock_map);
>  }
>  EXPORT_SYMBOL(__local_bh_disable_ip);
>  
> @@ -183,6 +185,8 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
>  	unsigned long flags;
>  	int newcnt;
>  
> +	lock_map_release(&bh_lock_map);
> +
>  	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
>  			    this_cpu_read(softirq_ctrl.cnt));
>  
> @@ -208,6 +212,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  	u32 pending;
>  	int curcnt;
>  
> +	lock_map_release(&bh_lock_map);
> +

Ok, this is not needed because __local_bh_enable() will be called by
__local_bh_enable_ip().

Regards,
Boqun

>  	WARN_ON_ONCE(in_hardirq());
>  	lockdep_assert_irqs_enabled();
>  

