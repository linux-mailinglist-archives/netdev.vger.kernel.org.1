Return-Path: <netdev+bounces-223391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BD3B58FE6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE017AE72C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE37C27780E;
	Tue, 16 Sep 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJOBkA7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239A262FD1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009725; cv=none; b=uxgB+oF5qfZG+Fk0Nwgl+SMz2o1pzkcPy5468MMbOSgXwuaM84Yg/YNeO29r9Qq9OJq4VhiAwsiyup69i0H7hDqxxCHi8ortvz7UkwBpqR+ZTtUwHqCMoF7kU/Wpv+9HLHnE3QfqsyU1/XGm2waCcjc7EtmmG1Ujjco18CdfQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009725; c=relaxed/simple;
	bh=/c+uS3z55K9YBs0B0LxjJ58GG1y6M6O9X37r9lKSK9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMOOGX/VJpO86hVAgyewBQM7nNeRCAkQmoHfEOu1Gs/3p4z5U78+qOF8EmlbQazRnWn00GK/cftIPYlEY+f5FCRRGTpSquIhe0mosvX7lNFLIgucT5qv/rPSj+WRt6dLF89SgB26WK8Y50UkAWjh4UJdL6oHKeJ7gVSNczs8NRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJOBkA7O; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32e1c8223d3so2079087a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009724; x=1758614524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJuKOn+I6/s0kndL2t+dNQy82N/2q2vB7ldGvEkpcpY=;
        b=KJOBkA7Oa2QeHqNxohLIOsqc+v3p53Em9irQA8SX8L0kIwT5OcdlQbKkYU7rFl1+Qd
         OqjDHKVF11FC4+JFygQNzYTChQtzUvCzv53DnhO7TQcYnhDqBBDvxcqZecuOK9Po7lDS
         rujpVZQGXw+gfgfmsQLHGAA0PAApUI017DC+XEXzyq3HTQejwXGwLyPThyB3/kJZD5PS
         pt/zhqZTE93bibqYauPa43/eh4GVdnParhCpXG0iuO0W/6LdiA000E7UPUxb+fmvmZEV
         ERoboHtWoffqs1xuLrgpy8GxVqgk4jKa8Rir/CHpo4nU9hk4Ai9wz6+uutk8h/bsSQhM
         jApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009724; x=1758614524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJuKOn+I6/s0kndL2t+dNQy82N/2q2vB7ldGvEkpcpY=;
        b=mghgXn3CzLE7HiJpWR6B6/QoAawTh5mQYxOmS5QWUAnq/qtXEEAgwz4ryNXLgw2MLa
         Ckeoeme7cdgoxZJ2GGUO/Iw2aCNY0mce30CKO3jPPyFIRbRZXU9L3TlkO1IRTPNHS45i
         J+7jRZQJakJVjWUg5ENhG8j7UN8cGUUiSkh3uwEyi/RGyVx/IaW23yfYBShxH7E4gkju
         A0Hy3kcNmnbe2o16pCYiY/a/OPcnBa2wVJ6R3iFNAoqsKdrU2HSToGwmm6+JpYSVBoUO
         1k/kniUWgtdDRLmrUCiY5Y0JQHOMdUZ4ubOlbWAD+7IQMsAhrkNBgfXYeQrSkGhIhifB
         lbgg==
X-Gm-Message-State: AOJu0YwUGbtLpbSGP/nJOSfybdo8nr8twbs091M34C24pnG/h6AF4Wcl
	BbPEFDv7CET6L2kKr5fBw16VvjURBwvFXUc/JnJWTMQgiCtpm10cr2vx
X-Gm-Gg: ASbGncvJH4rYqtySyzsg29c/wd9x5gKVM7z3OcnYHFTOOJZOpgnWMYqux+qdPXTQGqE
	M6u+U+5/yniXkUxnMz+ELoThNzLf31NUhYoXU1RrCI1hYkHJM4dJQTu0V+zCKXFOUzvVKIAy28S
	ETNOq2DOdLgkJg3Kr9Ldwr3MdRaPL2/SWeWt+VjHBbvT5tJm8XRTsgDRH4zJD4hfMx3nWnqBklB
	lilm1dW/ePZDCF7GJqDz8A6VcUBA01p3sZw3i5iNhkC7EjeyHE4ODENyyLgnaZ8pptS7CrphjCF
	0hU+KPtnGIeb2s6Gji+t93vEHDo7Mb15w3Rv13cEr3G+SmDC8xTpkQSwhu6b8Ya1gJetLZfYLNP
	3Imd7BaUWe2g58lW7YXcJIRqRF09GHyRuJaD2eA==
X-Google-Smtp-Source: AGHT+IFGJgIQjV2oZ020VBsoaPCjwBwY1Kduxv4+TX9KlBn57PgRnR3curv0ncKvPfaRwSENG5MGgg==
X-Received: by 2002:a17:90b:38c3:b0:32e:37af:b012 with SMTP id 98e67ed59e1d1-32e37afb746mr9417837a91.0.1758009723634;
        Tue, 16 Sep 2025 01:02:03 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b346dasm15661934b3a.68.2025.09.16.01.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:02:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:01:56 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 2/2] selftests: bonding: add vlan over bond testing
Message-ID: <aMkZdJqkg8sPThzn@fedora>
References: <20250910031946.400430-1-liuhangbin@gmail.com>
 <20250910031946.400430-2-liuhangbin@gmail.com>
 <a3721ff5-9e64-4a9a-a207-d53af7f8a10a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3721ff5-9e64-4a9a-a207-d53af7f8a10a@redhat.com>

On Tue, Sep 16, 2025 at 09:05:36AM +0200, Paolo Abeni wrote:
> On 9/10/25 5:19 AM, Hangbin Liu wrote:
> > Add a vlan over bond testing to make sure arp/ns target works.
> > Also change all the configs to mudules.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Does not apply cleanly anymore on top of
> 71379e1c95af2c57567fcac24184c94cb7de4cd6,
> 
> Please rebase and resent, thanks!

Re-posted, thanks for the reminding.

Hangbin

