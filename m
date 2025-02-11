Return-Path: <netdev+bounces-165140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1447BA30A9F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00ABD18857C2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7131FBCA2;
	Tue, 11 Feb 2025 11:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CA1FAC4C;
	Tue, 11 Feb 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273930; cv=none; b=gtaWDSiG4D74Je+GE98qKosOHYdEXEow2/sQlkMRAVek1v8PaWTOpNUtHA+WC+A3vsCnZPqDRj4czz1xBNQPgF/J8nWiiO8lUPxv8digPQEx8WelOFFm0c83MJ8rJyv+JPQ5gXayymv87+lhGJnDS3yUWBjdGTkrqqBXwd75IIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273930; c=relaxed/simple;
	bh=esQJSFSJV2MG7fXcEILK8/cHlzRX1o0YSbO38OG4iqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s79OPO97PGNalNKpSnUDNNUkhwoJxL1Qohe9IfdE8RojEpDxRKICGcEpIexknpBvepfzEySWzIsi2g4SAkaItL9Lp/Fe/FhzltoCFFcw0oLx4ihhh27KI9kw4+h+R+wZcSels2Ue3dXWnUwcanZYA0iRNtype378MS2suX+0Mxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so798619266b.3;
        Tue, 11 Feb 2025 03:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273926; x=1739878726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlFZY5aoGndg2I6TKYoK0BWp/w/zJ2eEctwHPxY091A=;
        b=C4L6cCmGzOWfzaS2aOAyJBHww6O0hBwUhfsITjNNHgObP+SwU8KH1K3FDzVUf+nqfh
         PjwSs4tjogLCKOimLsrRroLuODuptr0zq7/4+rbW/40cHkefVBuje+yI6piqwA+6sFqS
         wI5VpE/i16r1+EerECzp0rnxmYAfqWjp0E8TPcrpvr0GYVDIF3EPwueeKKDGqHJH1+At
         SQ0oimlxYl6SRmzblEqvbml/OxIescdKlS7Orgmo17N1eOaJjZqTaVK7jQO7cu6Beotl
         +aBrtH3WMtSGBMsG7PuXr+NyfdmfjmjcaWkAZyQFo89/mBFq/iHTbl8RxmjjNYyU/ya8
         GHog==
X-Forwarded-Encrypted: i=1; AJvYcCXdxCCwF5Ow+wy5e8QTGYryO/P61c6CLXPOwBmoDzvDrEvtNNKlq4HjKSAlhfFs8HcoWUStE+zc@vger.kernel.org, AJvYcCXmukCxEOhOtTSMVXz+mpPriwzEwtbC+YPvu27rALcVo9pzFrcDX8RCQY1+/b4xrE05YHbYPTMm2eNNd2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXy4MyhXCPzvbDYmy9uH0uQbXP+cJQopu7Y9VzdcWhReXaPHF
	w6wrarE5K6VNOiBsMR5HBHjUCWBwTk4xjSBSpTSIuG4aOyySmKVS
X-Gm-Gg: ASbGncuXbyi14I0jeOwC0rC6R2c+LZ7NAyop0fv4ojiDGl2bN5LCghBDIho3XbaL6Kg
	7AEfBtJNyurFQwr3gcqqV3idYl0XBqY/lP/IvlroyzI0dMAwO1t6j00L47dOeUPVOvoquOBJNkx
	dUa591A8yQ7YCb0Mu61h43CYVayrTND9rRGO73fX7fHQSJHH3PfYHgd5Zy1WrSjFtFtwPa3eLu1
	9kpszA0H7BnVuE/NH2u1Xel2L+vq3zlawaLUr2SiOPNmZM2iIzQEo/lgoOHQBXKYGokIhSfi9zP
	svzVn/4=
X-Google-Smtp-Source: AGHT+IFAaYlQ0X+EVXcjwvyQ1GsIu9atYNX3qJEy3O+izH+5QuVer79XDz54pV7B0HFjCBwmJMuC6A==
X-Received: by 2002:a17:907:980c:b0:ab7:758c:b398 with SMTP id a640c23a62f3a-ab789ac0dacmr1784562766b.20.1739273926350;
        Tue, 11 Feb 2025 03:38:46 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7ced6fe0dsm264676366b.179.2025.02.11.03.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:38:45 -0800 (PST)
Date: Tue, 11 Feb 2025 03:38:43 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, ushankar@purestorage.com
Subject: Re: [PATCH net-next v2 2/2] net: Add dev_getbyhwaddr_rtnl() helper
Message-ID: <20250211-zippy-inquisitive-frog-8e7cf9@leitao>
References: <20250210-arm_fix_selftest-v2-2-ba84b5bc58c8@debian.org>
 <20250211010300.84678-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211010300.84678-1-kuniyu@amazon.com>

On Tue, Feb 11, 2025 at 10:03:00AM +0900, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Mon, 10 Feb 2025 03:56:14 -0800
> > Add dedicated helper for finding devices by hardware address when
> > holding rtnl_lock, similar to existing dev_getbyhwaddr_rcu(). This prevents
> > PROVE_LOCKING warnings when rtnl_lock is held but RCU read lock is not.
> 
> No one uses dev_getbyhwaddr() yet, so this patch itself doens't fix
> the warninig.
> 
> You are missing patch 3 to convert arp_req_set_public().  Other call
> sites are under RCU.

That will come later. For now, the goal is to solve the current
netconsole patch by Uday.

So, my suggestion is that Uday's patchset merges this fix, and fix their
own curent problem. Later we can convert dev_getbyhwaddr_rcu() users
back to dev_getbyhwaddr()

how does it sound?

Thanks
--breno

