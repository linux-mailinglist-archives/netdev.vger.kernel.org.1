Return-Path: <netdev+bounces-172582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED07A5572E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1531899972
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E44227183F;
	Thu,  6 Mar 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bFPn4Wui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB01270EC3
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290838; cv=none; b=i+/X4I483spCA94/wS+hVYFBbH77WI+vrJmA93OC+EdechUdKS7FGjpaM7nMIzX8APuza8mg/tKwYcYEOrVHXXIv23ngPyfDthgClcii6Q2hP4pD/8XChXj3em4tMjYTeCRMwYzcyOZpAN5EeVOl/KXDMpadkLoQYfgAlq1zA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290838; c=relaxed/simple;
	bh=iSKcr4EnKpiqI9Vm20mF226SY1sqzT7i4gJiswq5lWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYRdB/88BWnnpBpdV2XpkagCFAHZhwyQuMG6K7bE+UiHa+BhDaC68isfjGTFeEvg/HkPxd8xMreZ7gyAAnjrRkkDmW9/xdsOs993TRhEomo6Zpc2PgolCfXpu3KvR8WqOY5+abka7OmL43iK0t2gd6RNfWTv55p349BiBBWQEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bFPn4Wui; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c3b63dfebfso113935885a.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741290835; x=1741895635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvFqmpmbcQZU3HzVSLSr0IyMCuH53u7PNYguyBEwL0Q=;
        b=bFPn4WuihcX3QvOSuxxYYLccbEBmmFAuQln0piO0dO23rDExA7kmxWzpu1EUvB3aqz
         0oMLT8hO4LAyrsKXoerQFoNUj80ay/IhXSu+cQGPVzcYY4heb9jUudUQkRh3ZTdSOHy6
         YXo5fKHrCKYI+3xvNuxabBFl7S4dzSzzyK+nCzSIyv5RNSYTRH3Bkv6pCXMgTQYMDtAD
         qu5EU1IozfpUNKPTETkjvDYPymV/g/Rast9ir6RqBdAuwYQNWDh08E6h1uiw5FgQ68jT
         7lCmfXy7NN+wFy8Pi424vyCqw7blQEgK5T4JAAwyP+xaz6tb7vbcFeNRcPfgltfEE049
         KWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290835; x=1741895635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvFqmpmbcQZU3HzVSLSr0IyMCuH53u7PNYguyBEwL0Q=;
        b=J0SIxdporCf9K7kd85enZnuTiAhgBsw4THBLcCevAM2DNSjcDcvNWIUyXPtD8dea3T
         kIiDTqF4mXBh60ScxCafoqZmEhlcBFxakXJz42iVDWQq5mxWwQGgVaUW37u1qqTibSkf
         rRFIkOylN7Of6+LZSkCexnEd/EK3fKR+gB7xBs02HYFMglZ202jEKerHfHnMnpMZ4P+U
         IYwLM2tVDOnKAo08tE0KJnHe3PCMPa6Zm971EkKn16cCvXLaWr2qQ7fdUnuGeslulbE+
         Q4N7PYjsnqli1SQfdTPAIzjly4EAR3UYqz5DY6Et6TE4Z+R85aIHRq+8X3euMxKJTxrg
         RBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVRQZaYrbFJE199g+aXNWMQh57kj9QbzWiXCvUzxj9NdTQ/pa4eBNn/lXpPF3P8rFJcO0coio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4Uu5FpNyHPZ96Fc2fidfa+NV1HXZDTIg5MDxLYoN0UbUQae6
	s70deR2A/O7nR1R46o5XN6yzfncCN1a+KHzfFzGOVDpfTiAjQNKvEZxrP93pJfk=
X-Gm-Gg: ASbGnctV3Y8fc8KRIeaXwZQb+AdbbZ4nXcdXS+YV83VvCjKrcayh3V+Z4uMbBAyiSI9
	DrTupqrPUjLX1rQHz7cWHpDNDkqNer4/41ET03uDtCKz1afbAUUT1OG3xEz/1iO3VsWjNnXHBML
	Uf0UkpZks9KkblgFlzQzH17RL7pXO/LLqn/vEYxxVGeKFZ1wmQUpxvFl5nzfFPmJKl5nJrNn1XI
	wJdyMb2owlFET9aO50W+8TXPlw1bRCJbfqkCQKXHhnFNr0/cHHlbL54Y/FQ5bB+R+0MlMd2IwlD
	n+KpgVmsSgLgVqeoVswKBNmMQsJ8lFwFq3j5w2+sNkSYwqYUxeEP0AMmt0KYJuYiM/2Mb1afWha
	EQhXeFU7eJmGLtD08Aw==
X-Google-Smtp-Source: AGHT+IH5m1Jox8CfH4jOxkXbL+wqEn5oIztJ9Ikf3gVuh+SbDr69e2lOimMWgZyeibm6K/JApYccoQ==
X-Received: by 2002:ad4:5c8e:0:b0:6e8:fb44:5bda with SMTP id 6a1803df08f44-6e900609592mr5341976d6.19.1741290835448;
        Thu, 06 Mar 2025 11:53:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c514sm10606706d6.24.2025.03.06.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:53:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tqHI2-00000001fCB-20Yh;
	Thu, 06 Mar 2025 15:53:54 -0400
Date: Thu, 6 Mar 2025 15:53:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: longli@linuxonhyperv.com
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle net event for
 pointing to the current netdev
Message-ID: <20250306195354.GG354403@ziepe.ca>
References: <1741289079-18744-1-git-send-email-longli@linuxonhyperv.com>
 <1741289079-18744-2-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741289079-18744-2-git-send-email-longli@linuxonhyperv.com>

On Thu, Mar 06, 2025 at 11:24:39AM -0800, longli@linuxonhyperv.com wrote:
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
> +		/*
> +		 * RDMA core will setup GID based on updated netdev.
> +		 * It's not possible to race with the core as rtnl lock is being
> +		 * held.
> +		 */
> +		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> +
> +		/* mana_get_primary_netdev() returns ndev with refcount held */
> +		netdev_put(ndev, &dev->dev_tracker);

? What is the point of a tracker in dev if it never lasts outside this
scope?

ib_device_set_netdev() already has a tracker built into it.

Jason

