Return-Path: <netdev+bounces-180031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A57A7F2B8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2C37A629D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E384E2356AE;
	Tue,  8 Apr 2025 02:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lK2e8Tx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453011A7045
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079679; cv=none; b=Ud4PrpK1BFIhnNyImTVxMx7wt0LCUY9y8CEZ1LOEnXhKLke14ylsDxfoebp05x4m7AyMHoiIwHZleh9fOzneYxoydvsii0AmAbQS2wamOs7OGRBBsYerF+yKkh2Zu7EG0jMnNJhNjg9VEiv9icmihT+w2mirl0H6aizozI+D2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079679; c=relaxed/simple;
	bh=n1EBPwm6oHt/kqJqj89iNLfrch0xyCl6t5b7nlGhkWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfHJGitfIZBYhEH/K9g/tKulTdYPCma8vm7AuqI80N5Pz2fHakuPLbF/z/3E5/m+rlLcTOP6rphJeOoVdSimdZtWkWRfK738jS1R+jXCXWw7HP4o1gWQI2WmXRn4qGnmDoVEFf1JsLuvdRxXWRW+w9lYwF3dvRQPVT+4vZIHxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lK2e8Tx5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225df540edcso60110865ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744079677; x=1744684477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnXZkpRT7mxbnF2z/cf8ODUkvmDtEsPtOUc9IhkrOng=;
        b=lK2e8Tx5Hi9UgK0+aeC2qEgAYeR8Krr/vCB2NFPzG1pjh4rfOtepIPMAtK54LbGy7L
         kkswAtB8myjy0WDO6BSew24bFDFkwJxcreJIbQIuMvoflhPRw/66VY1BG3s5Wht8X8W6
         mAZSo+VNRBgxkc19C17k258fRZimO52ANRwC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079677; x=1744684477;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnXZkpRT7mxbnF2z/cf8ODUkvmDtEsPtOUc9IhkrOng=;
        b=i9xTU4Qkns61SHdkTIMjL3ngz+Abhyw0gDb7H4DwIUUNlEdvcvOZ2zrF3xvJrZ3cT8
         k7Ttf0JIwSlDv61oojdMwdHTcrvElUP67ord+sU0b8VMEu08SBKUIgYrTioDHvS6ejEc
         DnuqSKOydClQPrYdIfCNJgjhLTOPl6gm9OMDiqN6+mbpN8Q7N1Fwip4WwPFNCrp0hbAz
         EP5pKgV/nro0ETVKU4kjre+tf0nWoOQp9QhUfCIs61KnCunp2DPbFUJTbbdJhKFcO4KM
         j3x3we5pdLbXZdQlxd/Qs72iLh3TZvEx9emq2OApMA97jYjzbufLpbH7KazyYFouf5p+
         P26Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMnqzq9lzDachTrigzrGPtw+ksMpQ0ImkKGh9q3JOxW2kee9Vol3ehFolpQ7HTZv0ZOYJwqm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkZRLvxfTGq7xFNiKKLxtenZ4BgSc5B7PeY5e2F0DH4XtXxH/
	MMjEZBQVR7Egw9oeeG5JBVZxBT0mJs3GHYXwkn9v6wHnEmU6qMFnwGr64lSuxUA=
X-Gm-Gg: ASbGnct6duyud9NPznTsIw4J9CtRcyV4GqOMIuq9nkpK2hPYGigLM+xNKFi8hMzzyY5
	f3CuddCLK+WXPIc+QLvb6NEOdZthGgxI2LIXy1kPlksXQqiKyC5q5T6ePSX+puB+qzUUn0Totps
	TyZMWIyKulbRqA7t3ddbQc7hp1JXPSExZGSY8YZ6Xa9BdVZBT50pfTkdLESRUZuxyxZdDpO8Grn
	gTb41EQlt6v274mw3YJzuU76cldAE9vJgQkwKg1Ay49g3ikzLqiCg7cRF60wt4wE6LeTl1ta8gt
	8Gm7SoCMdcHurnJoZ/T52/37ZQQ2lB7JpoJ1VMqBQ6n7QhXmCQoMJx5PVsfnKhmMIhnRkpoJSRU
	jH3auTUSE33x7Op+3i6jDrQ==
X-Google-Smtp-Source: AGHT+IEtOEfCePoutvJnvI8ake1HKWSU8mdy8FYB0DzEdAp7teWvV3c+lsnACnLFrUOMvQx3YB2NJQ==
X-Received: by 2002:a17:902:ebc6:b0:21f:5063:d3ca with SMTP id d9443c01a7336-22ab5e9420cmr23886225ad.16.1744079677453;
        Mon, 07 Apr 2025 19:34:37 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d2f4dsm9280465b3a.28.2025.04.07.19.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:34:37 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:34:34 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 7/8] docs: netdev: break down the instance
 locking info per ops struct
Message-ID: <Z_SLOkj9EGKg_sRn@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250407190117.16528-1-kuba@kernel.org>
 <20250407190117.16528-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-8-kuba@kernel.org>

On Mon, Apr 07, 2025 at 12:01:16PM -0700, Jakub Kicinski wrote:
> Explicitly list all the ops structs and what locking they provide.
> Use "ops locked" as a term for drivers which have ops called under
> the instance lock.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/netdevices.rst | 54 +++++++++++++++++++------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index d6357472d3f1..0cfff56b436e 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -314,13 +314,8 @@ struct napi_struct synchronization rules

[...]

> +struct ethtool_ops
> +------------------
> +
> +Similarly to ``ndos`` the instance lock is only held for select drivers.
> +For "ops locked" drivers all ethtool ops without an exception should
> +be called under the instance lock.

Extreme nit (which you can ignore): "without an exception" read
oddly to me. Did you mean "without exception" ?

At any rate:

Reviewed-by: Joe Damato <jdamato@fastly.com>

