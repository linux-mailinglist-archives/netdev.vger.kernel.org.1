Return-Path: <netdev+bounces-167263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E1A3973A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A0F16E578
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA95E22AE42;
	Tue, 18 Feb 2025 09:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82422CBF1;
	Tue, 18 Feb 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871397; cv=none; b=XSVHUXaEu2Gng9YfsSDjFy9pyDss12o/TZasa8ySjma3+I4H36JsFAY6zb1dinT9+13iPpTADoyZ2XwYNdyr42pFCnXhU+A7bMtQJr76PkRikrCZTFd3X0z9i4Glf6mdJEU0SxFv8h/+wp4GvN1Ie0UhTOT//ZhfyIEuZDE8JxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871397; c=relaxed/simple;
	bh=h8i2+8Y95agTc6zEvs2lAXFlJuYIMa3vpyoPwzxwvIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWNWhhDtK2ijlGESii6Nenc+dhXXo8BxMs2pYtx5PoJ+ySaCZ6lSfTS0YouS8oE/Cs0TdSRh7rP+rqW5Ie5EDDnFuSvjVFi5rPqGTMAp9GSDxVQkuCkFMD5eYYnbOzDnBcp3L/RmgoSUcQD9x/oyfdWJllHj75+jwFeX0AyMWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb8e405640so321526266b.0;
        Tue, 18 Feb 2025 01:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739871394; x=1740476194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hiBgrSSBArk629qXOdLhb48MutUgMJq3Kv3WZOzM/0=;
        b=E36mBSsqy+X2XJ/YDruftM3bJnjbzkZlDekFJ1yAoqYIeIXws7S/sILQI3C3R474Oc
         RDABfFt0AjSY6rrk8YnAUGrmG84sjdnbJZ5FIe3cxL/QUDvSCu4NqFoFd9onkw65Ix7t
         Mdz1YeylWUkIePMcTW9SGSmODqYZdV7uTGkTDVxPcaHUiS3dA5ikLHXkdicT/f/KjzpM
         y9hZmIC92yQ6xJ4AqvUp/AHniKdDdZp9xsKiT4kdpTIUpvJgvRCG68VVMdliLJXX9Yzx
         /ueboyDav6eejAKLb1LOpfF92ks7WTCQMGhNT7mjwZfp2IUW/5mYIL3E+Puop0uYNG7i
         Eq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCGnE81M45PXAa7XKM0M7kH86f875NBnPGitOnnAkTnHNOsOyvAtsGUzzGrMAbMhKPUHZzwTuw@vger.kernel.org, AJvYcCWoz5upcvVbP/aNSGvstC5b9P6X8jlOGsisQFiBNHp+0EAT7TSa5E57ybmASGMZOY5x9He1qzbmMLhc5Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPg8Ndg3OwUQS6oxufGf1shCt9UqyQRHNQwT0ZowJmVAuuyfMZ
	psQxRxWglAuVyifoIrrysktwNCuRYOCu2K6VfwaMElDRAaGc1F8V
X-Gm-Gg: ASbGncsik9mKuEguBOBmzCqgnhfXz50UIqG6nvXTX5S2KtlPDDbQjPbS8CEMFw9nNqk
	rwApjwUKmdLzSht+yY/vJO5srcEeXTUho61vy/x4hRTUcGaWC+pr+5WdNhJB6P4f92UvNtYowWR
	VIE7ccu7gkitPNVjcRuG+21sStLO/KffUsEiD2TtJeiGAB0mmj+ornC/vCzoKpMRrVXl3wpLK4T
	JBS1AWifgSLiTMXJ6azzvpp5WufBGtWOfqZPYyeM9QDXQ19WI1mUtqx5eCps1znJnfGkTWy1/6q
	Xtc6vq4=
X-Google-Smtp-Source: AGHT+IE6uWhyRfngWfVt1pLoeEJzXbITYg8VYoknCayHGLJmnZ5SFuHiHcNZ0yETnlRS7ouPJoJVHw==
X-Received: by 2002:a17:906:370c:b0:abb:519e:d395 with SMTP id a640c23a62f3a-abb70a959d9mr1066105966b.20.1739871393908;
        Tue, 18 Feb 2025 01:36:33 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb1e1bef3esm710432166b.146.2025.02.18.01.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 01:36:33 -0800 (PST)
Date: Tue, 18 Feb 2025 01:36:30 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	kuniyu@amazon.co.jp, ushankar@purestorage.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net v4 2/2] arp: switch to dev_getbyhwaddr() in
 arp_req_set_public()
Message-ID: <20250218-debonair-smoky-sparrow-97e07f@leitao>
References: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
 <20250213-arm_fix_selftest-v4-2-26714529a6cf@debian.org>
 <20250217163344.0b9c4a8f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217163344.0b9c4a8f@kernel.org>

On Mon, Feb 17, 2025 at 04:33:44PM -0800, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 04:42:38 -0800 Breno Leitao wrote:
> > The arp_req_set_public() function is called with the rtnl lock held,
> > which provides enough synchronization protection. This makes the RCU
> > variant of dev_getbyhwaddr() unnecessary. Switch to using the simpler
> > dev_getbyhwaddr() function since we already have the required rtnl
> > locking.
> > 
> > This change helps maintain consistency in the networking code by using
> > the appropriate helper function for the existing locking context.
> 
> I think you should make it clearer whether this fixes a splat with
> PROVE_RCU_LIST=y

This one doesn't fix the splat in fact, since rtnl lock was held, and it
is moving from dev_getbyhwaddr_rcu() to dev_getbyhwaddr(), since rtnl
lock was held.

