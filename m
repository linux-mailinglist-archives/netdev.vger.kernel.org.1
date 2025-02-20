Return-Path: <netdev+bounces-168270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE821A3E514
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE619C1BBD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E5424BD04;
	Thu, 20 Feb 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tb0o+BRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1881264606
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079901; cv=none; b=X+c5cz+WfJKfbWVn5jnpum/rSYHxo8I2vu6eaAba/PzoIwnF+PTsJgJ+FDNJuZYa8gzOlKyP7cBfFOOzWgxismEgub2FKDkzauhzs4drR4aE80W+qH7GOSMfdJ/HWTsEtRzDLpVOLvhispTVXP0mWICfhumr6r/N+Ugqewugy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079901; c=relaxed/simple;
	bh=gjVdv85IOtwSGAPeN/DiEKYGwxtv5Bo6wthVJs5FDQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyyo3zkZcjPECyRhvmHnZ8/du2t95eqM+YtMEZPMfEdmiN2rD6WhdLYy7X9HrqpCVmhJPG+b8kJKaNT44UnsvyIoZLhldqmwt1BXrm3vNN9aBmKiMRn9fZS/dDZGPCYho/mL9CrBbc9fqik/RQocQ6Cknqi6zRnEwaAHdbeh8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tb0o+BRp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e670d29644so10160266d6.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740079898; x=1740684698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iS9RPpdCDKZmMxP1N+PjKfIkBE/dcA+MACPgAylfD3E=;
        b=tb0o+BRpFEP9PNhtHdX7MxbsLBxLNXRut9pEM2RP/Gfa+xFTnpyFVTv2Z/U+Izug7O
         AGEKPO62W4ml7qGBeW18zJSkXyVpehdTQTzTLnedr06SGyJEOn8f7tRVgcjwqSylox/+
         jqUa4zZsPl+yJ1WYrN8UkzGl9rns67VS7+Siw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079898; x=1740684698;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iS9RPpdCDKZmMxP1N+PjKfIkBE/dcA+MACPgAylfD3E=;
        b=GqXRaeh017FJ2xL+2tBa+3sMtaXs54W2BRvjpZFuvBP/7iHMFpf20hxxGD2Jvn1cH5
         OOHTQwDfEZzF1P4lrN0+bqW0YsIZoOl/RrsM1k0pvyxZXlfBbNIA2TxTNBwbdr3YrIea
         2Z7E/yV4jqx7lTJ78ahcMdjeBjoYV7as3BXJphFtH0n1lFpaE1TBRDFP8dJyWqa+fBcE
         TZH0Ag0kXvsfVkvFV+mHHspPJTBHs8B+ovENv74hymdur/dMeXHhlzV7faE7m89ju7Ju
         xpyDOqH3fVRoHx1Ulr5buKzgKmVAX5yWYozwF0vXaUr48JQUTYGIq/cREK9MH1yTcAwg
         Flmg==
X-Forwarded-Encrypted: i=1; AJvYcCVpQtUOBxflVKmQN7gYb7vvsVCjMDrBGVwoDRlALc7kU0JoP//PDs1GU4vI5RJWBJJr0IrIdJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhlJVCDg6N/RFt78SsuZ4R3IT8jqKhJ6Ql9UEW02qJsmQ5T4lY
	4x1mNEdwVga/kROOwegvwB6vE0Bb56WfD6Qkm5rxXc5JXVE+X5rPUpehZXKFprs=
X-Gm-Gg: ASbGncsZuIrtR/3ElHYNnyTfNlGsIbuSx+wqmx/q+poLSaQVTawNC+XNkpbH6XL/G9V
	G39DETvkNsz1qxGGMSr2iX2XUA8col+IWrehfvy7htWBfWWnFL0vToKmvJ77NJwC0mH3Cr5KnVp
	a3gYWkXtVH9vPWql1vHJEOGQ5IRFS7cv8WQJXEjdYfth1q3m/tYath65kEC5woHNBB63NZ4xucX
	9BAl/+QUr0wIlKP0F/l+rsnoRVmARWuAH5ODRGm76w4QtH0uaFPJ+jLCnvFbgL//zrCPpiFBGc6
	k6GarUORXqgzYW4f1Jv7oVv9Idhwl9RAzSZmgZerDrHSDyJTDknNBg==
X-Google-Smtp-Source: AGHT+IEQSqMpqsfTnva3rqQOV9C+uu9Nj8fYZJDtwaS9M8lvfXXPqXstgFWJ+ml90MAEpOq+PenHVg==
X-Received: by 2002:a05:6214:2426:b0:6d8:9ead:c665 with SMTP id 6a1803df08f44-6e6ae888819mr6046096d6.27.1740079898151;
        Thu, 20 Feb 2025 11:31:38 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77927csm89073026d6.10.2025.02.20.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:31:37 -0800 (PST)
Date: Thu, 20 Feb 2025 14:31:35 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	stfomichev@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 1/7] selftests: drv-net: add a warning for
 bkg + shell + terminate
Message-ID: <Z7eDF2lsaQbWl0Yo@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, stfomichev@gmail.com,
	petrm@nvidia.com
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-2-kuba@kernel.org>

On Wed, Feb 19, 2025 at 03:49:50PM -0800, Jakub Kicinski wrote:
> Joe Damato reports that some shells will fork before running
> the command when python does "sh -c $cmd", while bash does
> an exec of $cmd directly. This will have implications for our
> ability to terminate the child process on bash vs other shells.
> Warn about using
> 
> 	bkg(... shell=True, termininate=True)
> 
> most background commands can hopefully exit cleanly (exit_wait).
> 
> Link: https://lore.kernel.org/Z7Yld21sv_Ip3gQx@LQ3V64L9R2
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: new
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 9e3bcddcf3e8..33b153767d89 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -61,6 +61,10 @@ import time
>          self.terminate = not exit_wait
>          self.check_fail = fail
>  
> +        if shell and self.terminate:
> +            print("# Warning: combining shell and terminate is risky!")
> +            print("#          SIGTERM may not reach the child on zsh/ksh!")
> +

This warning did not print on my system, FWIW. Up to you if you want
to respin and drop it or just leave it be.

I am fine with this warning being added, although I disagree with
the commit message as mentioned in my previous email.

Since the code seems fine though:

Acked-by: Joe Damato <jdamato@fastly.com>

