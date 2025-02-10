Return-Path: <netdev+bounces-164863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12ACA2F6F3
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5105D16639C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326CF255E24;
	Mon, 10 Feb 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xPwBYCoP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91122257D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211953; cv=none; b=iacDfMJv0BIRfXu/Hk4SMF4C+5lZVcnOMMX0bAsvBLkWuMzQppyIiQNWHyZ8euCMvl+nvN+stBn6KVpc9Qw27Crm5Mh/sCe/hoYMXiEEYzynrgtwtWVGOdXxzKvrkjOVYJ7kyTiiILixsrDH9e+J4sft0gT8YP2zLIVZAWNrpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211953; c=relaxed/simple;
	bh=un6QQGCdV/jIvAwfpJI8Uq+adWEITlFotZcQe0NcveI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNHFyhhj3nm2RSX47aakIX3+qbUOOAnsCw0XkVLFy293uMg/2AVE5aAfHTh5Lx3a4SUmXLpxn0W3Z7aSpBq8/CAFxMfLxAtnWZkQM4UD+vp5r03ue1ai44GIEc3C4/6dF0yH4YgVIbJtSC3l4idT2ly8c9PSW642RkCwoERG3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xPwBYCoP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so1459846a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739211950; x=1739816750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBLXfzB522A5CbhK5TFNajhZ+MxFO1T0Mo8nWMaVTRQ=;
        b=xPwBYCoP1g2HmKw7tnOeyWizqyeOoK8TjK6//BkARsEDggd5VAV0QXo4fAEETIDMVp
         W+NbjaVU++pdVbm/Ht3+pFW+Uoj9x4D3ZyHVxiRt/CGhzZkxS8pN95jRg+RYCTDnEoti
         R/7FP4EWLUYTLhEU2Y1lKRVGxUQEETkc8Xaws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211950; x=1739816750;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBLXfzB522A5CbhK5TFNajhZ+MxFO1T0Mo8nWMaVTRQ=;
        b=sKnpBTY+pZ16T/rbQncVGj3y/aE1XRDu3a5dzTycRznO4bXhd+4qqnPOg3V+AwDTIH
         gZPW5OWuDBpgfdchxNJFITYOlLFgBc2/mAA3cXEeGQnlE9LonvUCZ1LZ/G9UJcCDx7gO
         3C+Sd2QKpUT/QfdVjyqkQ7IdjCa2c5KtKzFlvDAGFudtbYOfpWrl6M75MEhTEwbiI/F1
         KZhYIg5anDFDdAedstntDCljyh6cpfVJw8aopU4/VFEWZs5Sw7NpS/8fIHw8oV3biLJN
         5+FYNDcYgIDoHEKLLztKWLeCMVJnzzEpTa8pjSTkB8uhZ5swhXqZ8A9C+O6FJbwUaTvr
         zJqg==
X-Forwarded-Encrypted: i=1; AJvYcCXqg8HDkICHcDHIhFGo8db25Pf54qQRISp/nu1gyKnVNP81klCLOOHOGHq7IT1P7Y8Km7+O3rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIc4mslFeGqQUI8V5mI2yrCdOidVRg9Va/cq4EDLTJlSpLMz9
	nHfLYrinyzBc3XDObuKfNMiBZc3ZUVji8Q3/8tqbBBVct6AKeJ2Yv78jJzl1lr4=
X-Gm-Gg: ASbGncv7DwU86gol9KeYXzI60JmkhpmDm0lVJeoIbqSDelvcfpCEPy1aDC7rDEy6tCg
	CaqeJW2QsIsL+2atCgJKL69J8b2BSZ7enP5grbhDAEYTJcJBqG1sJd71xSwjmI/4sn3zN5AydpK
	4/l2hOfaTJquy66rW4HN96WQRTWxeC+sO6lrP2a6sJtaCfJXxCH/7iH6yLH8uKMs36bbqZW1e6O
	B127uGkzmryOKMaNQIRABydL+empkT9lRKt5ysrJfzmquBqax3BO8Z4kc/87awBw19yK9KX2nnR
	5gNv6A4eVzRk+4Jkpfsv5RTggRMUDZjfNtZRR78uzBl8bwkCNt8hcjlMXg==
X-Google-Smtp-Source: AGHT+IEeGi/YxACQdrn8oE1WkyJdsSg+jOCxVIUUqafmiRNWAw7aoFvnfDNnWa0QFcaXWTLwctzU3Q==
X-Received: by 2002:a17:90b:3e8a:b0:2ee:a76a:830 with SMTP id 98e67ed59e1d1-2fa242e74fdmr23095209a91.24.1739211950624;
        Mon, 10 Feb 2025 10:25:50 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e2373esm11431743a91.37.2025.02.10.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:25:50 -0800 (PST)
Date: Mon, 10 Feb 2025 10:25:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] igb: Link IRQs to NAPI instances
Message-ID: <Z6pEq9fs5RvglrVk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
 <20250210-igb_irq-v1-1-bde078cdb9df@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-igb_irq-v1-1-bde078cdb9df@linutronix.de>

On Mon, Feb 10, 2025 at 10:19:35AM +0100, Kurt Kanzenbach wrote:
> Link IRQs to NAPI instances via netdev-genl API. This allows users to query
> that information via netlink:
> 
> |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> |                               --dump napi-get --json='{"ifindex": 2}'
> |[{'defer-hard-irqs': 0,
> |  'gro-flush-timeout': 0,
> |  'id': 8204,
> |  'ifindex': 2,
> |  'irq': 127,
> |  'irq-suspend-timeout': 0},
> | {'defer-hard-irqs': 0,
> |  'gro-flush-timeout': 0,
> |  'id': 8203,
> |  'ifindex': 2,
> |  'irq': 126,
> |  'irq-suspend-timeout': 0},
> | {'defer-hard-irqs': 0,
> |  'gro-flush-timeout': 0,
> |  'id': 8202,
> |  'ifindex': 2,
> |  'irq': 125,
> |  'irq-suspend-timeout': 0},
> | {'defer-hard-irqs': 0,
> |  'gro-flush-timeout': 0,
> |  'id': 8201,
> |  'ifindex': 2,
> |  'irq': 124,
> |  'irq-suspend-timeout': 0}]
> |$ cat /proc/interrupts | grep enp2s0
> |123:          0          1 IR-PCI-MSIX-0000:02:00.0   0-edge      enp2s0
> |124:          0          7 IR-PCI-MSIX-0000:02:00.0   1-edge      enp2s0-TxRx-0
> |125:          0          0 IR-PCI-MSIX-0000:02:00.0   2-edge      enp2s0-TxRx-1
> |126:          0          5 IR-PCI-MSIX-0000:02:00.0   3-edge      enp2s0-TxRx-2
> |127:          0          0 IR-PCI-MSIX-0000:02:00.0   4-edge      enp2s0-TxRx-3
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index d368b753a4675d01b5dfa50dee4cd218e6a5e14b..d4128d19cc08f62f95682069bb5ed9b8bbbf10cb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -947,6 +947,9 @@ static int igb_request_msix(struct igb_adapter *adapter)
>  				  q_vector);
>  		if (err)
>  			goto err_free;
> +
> +		netif_napi_set_irq(&q_vector->napi,
> +				   adapter->msix_entries[vector].vector);
>  	}

As far as I can tell, all paths that lead here hold RTNL:
  - power management (__igb_resume)
  - ethtool set_channels (igb_reinit_queues)
  - and regular ndo_open

So:

Reviewed-by: Joe Damato <jdamato@fastly.com>

