Return-Path: <netdev+bounces-168268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B0A3E502
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF0F189F13A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3B0213E80;
	Thu, 20 Feb 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RRmEwbzP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520F15A858
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079692; cv=none; b=M1tUCA2qIYVujMEwWX2MJOFlOwh4HaaYEG3YbxiD3v894PnUzetT8HwelYVBZOa5qJOBWgtiR7lx0DxxBYtqsOG+2qixKVbCe0T2KkNDZboypp9K+KYr90ThuKOEtJU+CqMMRcUMvRbAYBzxChgjfPuzy3TKKVohCE7/f2UPJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079692; c=relaxed/simple;
	bh=lxJ8DRO4LbAq58ApllHqpBhd72kC6FGxNkkvIFrj8B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=musxaOoObp2EwyEnPiOAfW1D4y2Iw2OJNsmDqNVquF5y/AeeOntnv05UuCij4febbwkKixJ5K+jao4e+bbUSKSn1kyG2v0V7lqutmb8M6utAHQE1AYKFXOodEe6/jAf5xdHpTHSs5YsMRHyxvqDm0EtVMOejbNEkKNgQPRSVw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RRmEwbzP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c08b14baa9so116661285a.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740079689; x=1740684489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwZnGfSncIs0AKFNQ0zDNx+f2k9gPLsLtHCo/R/edv4=;
        b=RRmEwbzPwXFVKqy4svHMqC4G9NzG4DISizI/Eqxge1qJGAEUFmvcUeG290nvlK5PQj
         T6WejqroBSaGfo6UfythmUD4a/8XzDjCdbqCSH1/aw4WGV9+qRc3+kfxJ06k2h2vA9/l
         YuDGXSzEnAz07Wr2a1EqLiLnob7nk0qUfdJAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079689; x=1740684489;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwZnGfSncIs0AKFNQ0zDNx+f2k9gPLsLtHCo/R/edv4=;
        b=AHdvPJ7XHn7keLzwia4odRHZ9IbXi7oc9hj+CBV8b85zLHLBFq3yrplmYSEfuFEOMh
         AWI30wGcgOwdiATs3DQOi0Y3qzH8NYtQPC2NbGYo7hwnODW+pnXtw3mLBPpZZRgvl6bI
         Kk6v4DmQV5f4LWFSHmeDKS974VYlF1vlS0c/4q6o50wClNSEB3Fnkel4CYuR2VQfCNpK
         U/GisFg9/pcRcySdk+QN0KZpnpF9LoEH4C26naz+ONGm/PRTaYyoaqgjzLkJvQCjRbcU
         cErkFpsvSgLOrWYE9fLmV1g4z0ZLt68yUNVExz3LjvQf1QKca/A8Eerraws3EAZzw7bg
         iaRg==
X-Forwarded-Encrypted: i=1; AJvYcCVedR9VEia9JTG1zjr9P+dI/TCmJeGnZv9tLOoDijcI2jyfh/GgUjctfxtj0ldVcz4x0b9toFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wQrGf5clQSBkyjz2UA5OhcY8wHWN9Ae6kovPa7c7s5qeKXWd
	qnvKZdJ0EeDV0gWwCNkVasQ5vaPBQleO9051Ha4DXZk5GYJSdCjibnwj238bHdk=
X-Gm-Gg: ASbGncuQSn8O797sTNi7n1E1GfVPQCtFzAjKird5VNmUmT2/w9jP5ku6SvRuB4FrqJ8
	7dp8n6+pyYj7iWhOCo2Rae9UqsR7cGs85L2pZ8tlhKAgKavBjYMmUTbMzaqUqi4WM3QkwHCi40U
	tXLkQs/2f4ldHDUEG2ckkvRxVdkD01vqhje/E8RWjI0mTng3JDfcFUJCGa9FAo/JXBpi9SWReYN
	TtFVGAysMn+t5kyc/O1M9WQsbQ7IqYqJMqHNbfYaZIyiCp0FuJiOSSDRfZG7ZZMrY/Fae4dTNVM
	l5OWQsBXUBF7+6QKp+mNs94A3aLT8y/ap0zLnx3MSswZmDEX7sUDZg==
X-Google-Smtp-Source: AGHT+IEBjps723zc4N7Ysmbk/q7LYlm5WwldsVoYsYZsGc7LzxkLtzikzqSqZ3k1Pyjk6fOqmjt8BQ==
X-Received: by 2002:a05:620a:394e:b0:7c0:ac44:d452 with SMTP id af79cd13be357-7c0cef64752mr76642985a.48.1740079689483;
        Thu, 20 Feb 2025 11:28:09 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b8387dddsm218007585a.94.2025.02.20.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:28:09 -0800 (PST)
Date: Thu, 20 Feb 2025 14:28:06 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	stfomichev@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 5/7] selftests: drv-net: add a way to wait
 for a local process
Message-ID: <Z7eCRlx-8Y9jLBbB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, stfomichev@gmail.com,
	petrm@nvidia.com
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-6-kuba@kernel.org>

On Wed, Feb 19, 2025 at 03:49:54PM -0800, Jakub Kicinski wrote:
> We use wait_port_listen() extensively to wait for a process
> we spawned to be ready. Not all processes will open listening
> sockets. Add a method of explicitly waiting for a child to
> be ready. Pass a FD to the spawned process and wait for it
> to write a message to us. FD number is passed via KSFT_READY_FD
> env variable.
> 
> Similarly use KSFT_WAIT_FD to let the child process for a sign
> that we are done and child should exit. Sending a signal to
> a child with shell=True can get tricky.
> 
> Make use of this method in the queues test to make it less flaky.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - use fd for exit, too
>  - warn if env variables are bad
> v1: https://lore.kernel.org/20250218195048.74692-3-kuba@kernel.org
> ---
>  .../selftests/drivers/net/xdp_helper.c        | 54 +++++++++++++--
>  tools/testing/selftests/drivers/net/queues.py | 43 ++++++------
>  tools/testing/selftests/net/lib/py/utils.py   | 68 +++++++++++++++++--
>  3 files changed, 133 insertions(+), 32 deletions(-)

This appears to have fixed the test on my system and the hang is
gone. Thanks.

Acked-by: Joe Damato <jdamato@fastly.com>

