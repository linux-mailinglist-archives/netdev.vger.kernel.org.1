Return-Path: <netdev+bounces-201658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44CAAEA3F1
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A004E27D0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7F2EB5A6;
	Thu, 26 Jun 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKisp8kf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381C2E7179;
	Thu, 26 Jun 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957202; cv=none; b=XbODoiqxyoEUU2LMyU8PBdUvF+Qw6n85V7Sf1ngX9iWnOdrEjKWHQksKihiqb03q5h2e4BtfTRxVq6PBCqedLBi+sQbwLUVKBQN+7S6KROvhnggeZ3J3YGljg7ZU+qXly2DO9gugQE5bb3JLGJYy0i89G1sUPEcJCNqhYwOwsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957202; c=relaxed/simple;
	bh=Bo6oxtzL0W1GxO/VSlDn0dbBOu/B/7fXMahDuNOFn/w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dr2WvE7f+uGh51Ft2uUwQqkeOnkp8zYsA9/w2NwHVjCJaGIf946YtyHFa02kofOOBzq5oSKHCRcOTgyXPTlqh/gQVQSJMcDkrzxTQn3/9ux6lyOJlaTrh+QP1sZ4+NUnLfRFhLuplBlrzi/X1UvEaWU+xZBDoPfnkbHQsfz5mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKisp8kf; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e82314f9a51so929973276.0;
        Thu, 26 Jun 2025 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750957200; x=1751562000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mkb2HmUMZIP2Rb2qugNA8k3jpv7TnOwxrJKFq3ITnEA=;
        b=BKisp8kfyeS+yp1ctYUjYit2JSwnIdTo/hEE4K8IxVnxV3lJIoR45gTWS0m0K30OT2
         t3iAg2jpWeAZPVE77S2pdNmu/E88tukKoGz2AR+NBFy7/fR09AYXvevicNHZlWj7NNru
         ro+EYWJPSESu3/fg4gb8InDe/MFvuGm3GRvBpYmcvCruCkMCC2wRVJRqVxuInCCIGDV4
         z0cOuVVdTU4+Q8GaY8ueBdHOsAC3GFLvUCfffc+274Y6VNl7kY2KJpQalkeRzs2KBlWg
         8wV+A0QvVikG3FaU0/3BXQ4mx49B5D4XjDCjOCCuWde3/ksWN2wKABYXMQTLWXIMiK8p
         0bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750957200; x=1751562000;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mkb2HmUMZIP2Rb2qugNA8k3jpv7TnOwxrJKFq3ITnEA=;
        b=crS41Hg3vukPG6gMYDusiLu90nznaM6ijhZFtnfUTHUoLQChy5WA7qUsIAA4p3mvdS
         AehphCwk1ERf7Po/mwvspXThgolkvsTqMFyf3xiGZYar1WkiUHT9/nkgctGLufqUi0kF
         tF6L4sCXeuceXqHKv85utdl9+br5mSYEya41Ffn70ORKhzxarJMmjIGd3ZB94ifJJUrO
         BKYHcbeXII7D1fBA+Ffxmt1S6d0Sw1jNlojhJhvjAW/w2w3f5PHvc4DfixiwExWSzj1T
         GBaJNwxMahSH0jm3239+yDC/d1hjDWUz2q2PlCuwUeRAEbwsPNeAjQDKvjPSw6yypGoW
         DwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1oz0xxs6gUJ1ALtcZ9cBH3rGkbDh4bZUBrmhGPiybJD27NA0KUkyFPHr+c8nfF403HFDeyHJLkVuj/yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zE7OF+ZRNN1nIC1ws3UaaheIWtP8yGBUlW7SUvozLv//BCi7
	aGNVOPM/51TxrFn/0jGz7xPURv4E2rrW4154vqBzevLIvBt7yQV7GukH
X-Gm-Gg: ASbGncvDKuZk66Vk3OhXxyyI1TNSNt9miaBGtk1wSwi43tp4qj5U+9dJmEM9qQMllYv
	oci5pkzbzM/gmvWrVKrgfmVzBlxUTaQHQkuk+geDIsikkh6IO244x0BDg2Rm+sRhAGw+5FWeAcW
	CtnPCtwQJO9Wbf60ILZ+5PM8wS6A/3OSpG/PHLTF2buft+bSADMfza+dTjSin7+iQz0+/7npK8y
	NMrNIuIL9B9a/ky4NNKH2pEq09srbbbl8mpmynbbUHQTYdYBr0vESoyr9XoTU/qRBNRR44vJqWn
	DU2eAKHhP7FkZ4wkQRYWSjSpnivSNbXh0HtJKvyTDntgvClYNIFwW7vl3ymN1Lg5mQlClqq+Vwb
	2He5DVN/5u//wwf78y8kAHPCQsx8iugCDsxGvgUwt4X18Gz1r3LbH
X-Google-Smtp-Source: AGHT+IHSgie8fw6PjGHutaIA8FKdtcevCg+f97UD5nQ6Qv0RVto5ZdWE0vRUQrfByGAa+C+Dn0BrpQ==
X-Received: by 2002:a05:690c:ecf:b0:70e:326:6aeb with SMTP id 00721157ae682-71515fb3045mr8687597b3.10.1750957200084;
        Thu, 26 Jun 2025 10:00:00 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515bee153sm674257b3.5.2025.06.26.09.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:59:59 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:59:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
Message-ID: <685d7c8e25747_2e676c2944e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250620-netpoll_fix-v1-1-f9f0b82bc059@debian.org>
References: <20250620-netpoll_fix-v1-1-f9f0b82bc059@debian.org>
Subject: Re: [PATCH net] net: netpoll: Initialize UDP checksum field before
 checksumming
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> commit f1fce08e63fe ("netpoll: Eliminate redundant assignment") removed
> the initialization of the UDP checksum, which was wrong and broke
> netpoll IPv6 transmission due to bad checksumming.
> 
> udph->check needs to be set before calling csum_ipv6_magic().
> 
> Fixes: f1fce08e63fe ("netpoll: Eliminate redundant assignment")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

