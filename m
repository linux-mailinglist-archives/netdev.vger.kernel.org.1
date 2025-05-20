Return-Path: <netdev+bounces-192049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E79ABE5DF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543817B1DA7
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632C22DA0D;
	Tue, 20 May 2025 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SATGsQUV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC8213E74
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775763; cv=none; b=UixjG+nczVHEagA0vl+1EyDjronsHmw1lt13iSGPBqTMErzC/zROcnFivahzjA99Gud0MlGj6kt/NrngUwOavOuekcmz4kkbSDUj5Ak4g2/oVu8SuemfTtttCYNTbNyZWkLF0cJj8JNrOl/2kUKlE2XQiRa0WLX54tPcNOaOtZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775763; c=relaxed/simple;
	bh=PokIbil+4vzb3IM+d56Xpj4Mvgib+ySxP9q4ulJxR48=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=f0xGbDxtfrpYdCzVgUJI3ohxAYhAnXigee0ywa8nQQsd/o9WIVEqFmvB4NRPphNKOBOIRlXDHuOJzzDnSanNucgcVYsOz//5Z776f2pVMNqyPIzxQlMqqpRh/nt9kyuMBaHFZW7rwnkLYGt6942ivAip1B+u94qNnmYcdPEIhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SATGsQUV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8cad66696so35443896d6.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747775760; x=1748380560; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Vcim2IrvThidRodNsg/OfOdq2fd5gLucgy52LkkAJU=;
        b=SATGsQUVNCcWA5EQ2sN31YQi0KcO0OMgg67xcYs16ITaMOe6Op0u1D+gq7ILTSB/DL
         FQdpiltkvmAEgWIanzWiNeydwbuD0aYpWwjtKgHSWO2+a1IMCM/L2d/EDsMDVqiR/t2A
         Dr4vo7CV/Fw3dsrFiU//gjBLuMSUaBhq8lVdNQAtdZY1PTDlbLXocFdQ0S6bxFniWug3
         JssnaOmXDTxnsZ7//pEfNyN7VOKN1Tmeke8pl+mCHHEZ5Qa9IcHIRRtY9bPIi/qbv8Zm
         XyXzgURy4XykbyrKYNDGCVpAz3iq+XNE3u0910/h/s0G2OWeoqOMatHPvm/cFMZvW8ps
         LJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775760; x=1748380560;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Vcim2IrvThidRodNsg/OfOdq2fd5gLucgy52LkkAJU=;
        b=ITAGA79T1VSrLOnF7hMdtsEze+mVehtJDsuj9l+7U1fxL4HZXFMddrNuLrF9LXsdGo
         nVYycZbBC3XPq88BNDCNGAKVgxgySYi1b3hYSpCOaGMTp1dJwiVRV3XvYwEcbc2FdWTZ
         sIWK0K7voTEo4K1QaaF8MgIA1Z18XiMUsDHYkXKQKMkE7JEryu4yfEZ+o5OL2LO15yHy
         Yfdq6FI62p29QYjg9rtOKOjzdrQU6XPd3rNd4CHtFg8goIWlRoo/a1Ot0eBgkDYAOJbB
         iXxG3K0qej1OOHOnCY5qtjb3QU2GO2ivtx3o9ZSeHlnklCdQbqVGb8P9/tI5EEJPxEUJ
         tbdg==
X-Forwarded-Encrypted: i=1; AJvYcCXcROH/UlRK7QXWN2+BA53bJsUM1nWY5rdJkIS1zOvMRIJRkf4jqXz0EjrG4w9LbHwoLXOhh4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9st4GqomanPSvPiK64lde9xYMeiMFxpWEzaWFMqGp6uODT0vj
	xnhxEFGRMbznGaJdvQJ2UnUwC/0MPwultURsWFoSEE5lKzB1sM7W/NrmVIh7pKU2BA==
X-Gm-Gg: ASbGncsEytWU38uE/vktvgxnWni97OoFKq0QhAuD6L21ZI0dTMSIs0ezyIi7FEoOz3e
	9pgZB0uqm4+lBOjE3iTGGv3eiI9g910ldIlI+1zhL10eAP2O5j0gJwAZkxabCZBAtYo9hOOkDQJ
	2h/NCNSjhOlf4yDk550k54oljdjdfw10Vofv4cijnnBBQmUtWFFRkQ1G+N+D3Wh8VoJg3emgSI1
	b5yQCZ1SwKeUDNdH9HVhRkYyn3qg8NTAOJ3VLO0zwmBj00QrzdY3OWDZXEehWPabVlY7ZlsiEX8
	eXl8BuCFYPbzEuPKLgIpbxHb8jJGtebLc4cxEj6lp2O6iBvwS6TtXS2dU7cgZKtVhMCjR+b2tHT
	TUc9XeGcb7+2P3mlT3912RJZzqGUsAfE=
X-Google-Smtp-Source: AGHT+IGXRcWfO4AHv0ErYu9MQe8pxWB5OkTwD4jggVmmRyicMFT0cpUlaxE7iaZV/7atuSeHLh1gYg==
X-Received: by 2002:ad4:5e8f:0:b0:6d8:a8e1:b57b with SMTP id 6a1803df08f44-6f8b0873ba6mr330435226d6.36.1747775760552;
        Tue, 20 May 2025 14:16:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0883b93sm76456226d6.14.2025.05.20.14.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 14:15:59 -0700 (PDT)
Date: Tue, 20 May 2025 17:15:59 -0400
Message-ID: <eb68761b5a2d53702f4d6b80fe2a6457@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250520_1533/pstg-lib:20250520_1521/pstg-pwork:20250520_1533
From: Paul Moore <paul@paul-moore.com>
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, maco@android.com, joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com, surenb@google.com, omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, hridya@google.com
Cc: smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to  binder
References: <20250417002005.2306284-2-dualli@chromium.org>
In-Reply-To: <20250417002005.2306284-2-dualli@chromium.org>

On Apr 16, 2025 Li Li <dualli@chromium.org> wrote:
> 
> Introduce a new permission "setup_report" to the "binder" class.
> This persmission controls the ability to set up the binder generic
> netlink driver to report certain binder transactions.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  include/linux/lsm_hook_defs.h       |  1 +
>  include/linux/security.h            |  6 ++++++
>  security/security.c                 | 13 +++++++++++++
>  security/selinux/hooks.c            |  7 +++++++
>  security/selinux/include/classmap.h |  3 ++-
>  5 files changed, 29 insertions(+), 1 deletion(-)

When possible, it is helpful to include at least one caller in the patch
which adds a new LSM hook as it helps put the hook in context.  With that
in mind, I think it would be best to reorder this patchset so that patch
2/3 comes first and this patch comes second, with this patch including
the change to binder_nl_report_setup_doit() which adds the call to the
new LSM hook.

--
paul-moore.com

