Return-Path: <netdev+bounces-178129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4BCA74D4E
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFBB176599
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F315CD52;
	Fri, 28 Mar 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9aElTJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2F35972
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174280; cv=none; b=AlqdNlT56z5pYd4uPiXBlozKynN7K6JRuu31XIyc0yoS4BpvzZdtoCu+9zyrUHTDqKOWZQEizU1K8sqEAxho/s0xcmw2H+5Dyanpv/juE9ERSb+/uXoBorCQybqbTbuyMWEnM6d+xZBqHI/EBrOLAnPVMbzORBXNySPR+FngmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174280; c=relaxed/simple;
	bh=Lk32qZX6WUf/tdhhw0XkOQ1MI+tnBILPMQgLRNCat5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQmJ5e3SLu5gvOjbv415FwZ2pkHpgGjC5jHGFg502AHjKfL7DSZCwAzBD4gzR0WpC2SKmTb6CwqxiAjOTWZZQ4vrghMHwLHeIUzY8iM/C8G4i8Qrn7EfX6dYD/vOBRRR+BTO8rFL+n2jJIXqXYScWy1QsILPlt2Brl3D/lQZyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9aElTJm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22548a28d0cso64399035ad.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743174278; x=1743779078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPYovihPkM+Y3BEmJi+XkH+sEkiiKDi5esUpGOMc0sI=;
        b=W9aElTJmT9jsvflySXtpR0Gxx94ORhugC0hmWDpBRkWLU5JxKyi0ppHz/1oV/31UFg
         7/aiOJPQJY6mlWN+a3kWVWfzRLq1ILyXMQHdLOnk0hHYgkN5UgTi7KM948G2byLLXM8j
         r2Ic0342mFFgsIMtvPoIjWnOTgXbHFgIMJ9A30j11NUE8HcZml2GtHdwzfX27zvdVRZV
         UihxP7KLnCxmIlVhXe7FSyrilEqDz3NuAfxXXtTTxAjJt4bSih9whTjiTZqcQAdnNfWb
         oaNMNjX1/8aS+vqD/f4W1Zk2qwbT6u7pqz/SDG1Z3TvuOS909u1rTM5GOc7iS5Y/SFEP
         Z9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174278; x=1743779078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPYovihPkM+Y3BEmJi+XkH+sEkiiKDi5esUpGOMc0sI=;
        b=ha+HviDF9LOaqOu9rwTe+2yXdrCqeFadQm8pTWiPBt+1apOSfYxVbUt+QenI9p6XO7
         lFI9wuAj0/eka25L4E9oEnl6/lpZr6TDAGyNdEuPN9nMHLCPSiDQRfs8joEBiALDsvrW
         4EShmUZ1UqfC3ArZ0uqhZm24RVruuTuEvOvNGwrqPQqdbGDiT71Bv9Wi29cAukO/D5FO
         dvFH5AeBZsdp8L/B/CxVFt1Oi47W1h2EizqfWVowTjdZOBpGWV/xGnI7QA4oEDnydqgW
         bPDkPrNPm2EMzplgoKaJ/M0H8edfcPrtUUj//ifaCyZ6pgGRhacDH3sRB9Jmb41/Z3v+
         gmSw==
X-Forwarded-Encrypted: i=1; AJvYcCUmXgrWyAlG5bs34gfMkPhDHvHXUsrjo0Pquvjm8M6CKVk0FGmzbcHCgFzH4kVOHRof9EDlAaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CIVX1HZY3R2MERpyFSfLy83Qyh7pWNIOHW0I8I335FCBSRJK
	jlqc2+TtdGdun4iJ3fSI2UCkyn4pvZcMyNoqzGifVpdwkHonRM31MxD0qyUexg==
X-Gm-Gg: ASbGncv/CNJAqkI4zYmqukp1AIFeVMsWHYqRg5AvtFeLt8b8IyNJaf6mQLWmw34b4MH
	U0AJKSfAva4/MNfaFJDRteyW3VNHk9LvBdK099S5l1/CEfqbR9VJcNHRV6OP0S64XT7Irq/LFlS
	nb5j3NeGDVGM+kJ8mAjNEhSY9p9aDlIXUH7g5Dh9X56uhovOKIrTeienfOoxWDQ672rOvnMVY77
	UyCTnKR7kahWlFhFNu1tPKheIdI59VV6RTqixuKYxvbxyMXZgRYxD6R5xRGAeLM/nTFfula+OUR
	nkT2IGoFzNRXVbyegJzUmORU69bFUpGPCyIKdAqBh1cU
X-Google-Smtp-Source: AGHT+IGI/lnwlacULAd25rgC7BwcbahGUP2PH7hF+WnZQjeccQsL5QcqY7A7uS3SYVEyc4VnyZX+Fw==
X-Received: by 2002:a17:903:41c6:b0:223:52fc:a15a with SMTP id d9443c01a7336-228048c655fmr100639595ad.33.1743174277983;
        Fri, 28 Mar 2025 08:04:37 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1ecac0sm18821985ad.213.2025.03.28.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:04:37 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:04:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2 06/11] netdevsim: add dummy device notifiers
Message-ID: <Z-a6hF7Ki3uAnQTF@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-7-sdf@fomichev.me>
 <20250327121203.69eb78d0@kernel.org>
 <Z-W9Rkr07PbY3Qf4@mini-arch>
 <20250327144609.647403fa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327144609.647403fa@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 14:04:06 -0700 Stanislav Fomichev wrote:
> > > Can we register empty notifiers in nsim (just to make sure it has 
> > > a callback) but do the validation in rtnl_net_debug.c
> > > I guess we'd need to transform rtnl_net_debug.c a little,
> > > make it less rtnl specific, compile under DEBUG_NET and ifdef
> > > out the small rtnl parts?  
> > 
> > s/rtnl_net_debug.c/notifiers_debug.c/ + DEBUG_NET? Or I can keep the
> > name and only do the DEBUG_NET part. 
> 
> I was thinking lock or locking as in net/core/lock_debug.c
> But yeah, it's locking in notifier locking, maybe
> net/core/notifier_lock_debug.c then? No strong feelings.
> 
> > Not sure what needs to be ifdef-ed out,
> > but will take a look (probably just enough to make it compile with
> > !CONFIG_DEBUG_NET_SMALL_RTNL ?).
> 
> You're right, looking at the code we need all of it.
> Somehow I thought its doing extra netns related stuff but it just
> register a notifier in each ns. 
> I guess we may not need any ifdef at all.
> 
> > That should work for the regular notifiers,
> > but I think register_netdevice_notifier_dev_net needs a netdev?
> 
> Hm. Yes. Not sure if we need anything extra in the notifier for nsim 
> or we just want to make make sure it registers one. If the latter
> I guess we could export rtnl_net_debug_event (modulo rename) and
> call it from netdevsim? I mean - we would probably have the same
> exact asserts in both?

SG, reusing the notifier handler makes sense, will do!

