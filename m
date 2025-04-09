Return-Path: <netdev+bounces-180753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B226A8254F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2532B1888C26
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D7B264626;
	Wed,  9 Apr 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu9fdPXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182B264618
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203081; cv=none; b=fMEKp2YfS2lx0yATlYvQ2RpzzaKESrE2Fby4aGfJniYErQ7SJieoijFMi17eHMZ5JwNjurPYzR4n7Ko160I9OLqVM8zucnfWMz9OYvPrX87s1f2xda36C/tNU4ilyca9JbPjC+sH1wCHv5VAEmA4luLke19uqiQqdZXG9w5kn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203081; c=relaxed/simple;
	bh=rDfSq5/g/lWZMA395UF1B2KU+/R5g/cUfavaOjOZL50=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qr/aC8zTBwVfCnJPIGgYWbYgPWzd+W9Z0ok/D+8HZ6r49+58ui9/zUb2Df2S4uhSdIhtsPqynI54dEjAO6OfgJ+2Ypic5mlkdYYDXM5kPMjIbapjffclSCy2U2jUWcCOVlpSZPw6OlvykRFEyDYlfqFJ6/ptHmlCadp0a12kTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu9fdPXJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso61267235e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203077; x=1744807877; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDfSq5/g/lWZMA395UF1B2KU+/R5g/cUfavaOjOZL50=;
        b=cu9fdPXJpYCq7+Bcr7EfN1lnfLP0dvBWZBSdaEUs/Y3/6O7hYDOBHyNDCKgRB1OABb
         cRnUwXNWWK+ls3An0RIzQ5n6cVWPyxqKxLbmRpY+YttmFJNcQf0ekyw8ONVqH+bSpWJf
         1wVZp7wLGVcD1jL53qTUlaRhM0PFX4FrihUM8L6VdgwAUMjTe65zE6T8SVjHw80p4GzA
         q1Ib+0C7BclbFsH5dbXGJ+k0j4HpXScibYAE++5sB35QCNqF/WrS/Br+WL1GW27oqK/k
         aouHHOk8ioUS9t2L/VioPTAkH9ciV6+JG8SLm2M9LwFwWAHotejaxTJm/R/UFEGPnxEz
         lozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203077; x=1744807877;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDfSq5/g/lWZMA395UF1B2KU+/R5g/cUfavaOjOZL50=;
        b=R5tOb1oRsRWLq6ZQit78iOC0fIFwfA31sA3wnBBR/tPYQsQGGM3Eeeg8Zi0/juY0QJ
         UtaFRPJGt43N1dMCY3+z2JT/S8xeT8isJPrXWk+/uPuMqmvI5kgGXGqoooIH+HeTROY2
         obu8fptxA+fBPK5QJ5SwCClDmzKuHl8DFTDJ+7gIpg21UQNw6XdPkhQYLORJ9a88epj7
         Cm3VYNSNMf/XSnfSQ9Akn1lCnjLq6q1H2OfHZRDrQZ3Q38X6OQlm/f28aiaL8utgxHrR
         XaMxw1R/524jO5uODIfw4+aGAoSBRvVMlF9O062luqKS+F0/R+93mdVkZx9rt8dOBn6Q
         snnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPYsDLKMmETJUYFpgBPrCxOkITcQP0aQ0yxN2GKWO5C5Xoz5Fpc15/Be6cAfCvxgS20ftA1yE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jtGRxK2lW5ik3HigLISdRPyZehJUeBTCX9LPXUN5kk3G6mm3
	tWXdUQl/9YuuOZtZgNzoARFrTJTwd5oW+pQ1h+EdWu6ZX0BtXRUa
X-Gm-Gg: ASbGncuPqDEXmbCZr2PT6wJ4z48bU0mQ2X6dMGGPIMM9p/yApInPcXj43GxWdpR5Dpy
	jk/BnXN+amaVuSJ6eRv9lRKpVqgPB06R5YmxhF4wTrhtNGBC8U0AbkFJ1CZLAvSgIdB9jtUBmem
	yfr1DctHnJ/Os/lBHPP8x0wIg5d0R2yilYG76jzjBS6RBKyvZoZes1YO0vnAVAtChariJiCL1tm
	nx036VcNkMmczUr0q/eRnBrptCMf9w5S9VIGNUfEGQzawEKqnV3KAwOglZO7MIO3oL5oRgZPnVz
	YAgPngQMs0l4LvPmnCXzk33q1xxoC8T0wFlrnGDHQ+/akPqeLq0LE67N/YFK8cx9
X-Google-Smtp-Source: AGHT+IEvoX7ursHvPu6+9sdImkev/poVrTByuLuopW5Kq4akXWIQCl6HaKjeg4IR7+bHIEQ6fmZxYg==
X-Received: by 2002:a05:6000:4285:b0:39c:1f10:c74c with SMTP id ffacd0b85a97d-39d8853b7fcmr2480966f8f.35.1744203076568;
        Wed, 09 Apr 2025 05:51:16 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89361170sm1560938f8f.2.2025.04.09.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:16 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 09/13] tools: ynl: don't use genlmsghdr in
 classic netlink
In-Reply-To: <20250409000400.492371-10-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:56 -0700")
Date: Wed, 09 Apr 2025 13:26:38 +0100
Message-ID: <m2bjt534ht.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-10-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Make sure the codegen calls the right YNL lib helper to start
> the request based on family type. Classic netlink request must
> not include the genl header.
>
> Conversely don't expect genl headers in the responses.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

