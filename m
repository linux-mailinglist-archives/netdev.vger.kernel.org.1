Return-Path: <netdev+bounces-161206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79667A20080
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B1D7A47C4
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FB01DBB13;
	Mon, 27 Jan 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jE1TvHST"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3071D935C
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016519; cv=none; b=UK1up5OIA0BOhgGLZQTHk7qk3/CWqzxQECLCN/GItF2wrmHSZXhmD2Psxj6WXtNfGYta393RCBwlYE5qsouziDKNKFM8hRw6vCKa2/3e/ScfND3+BEDnG29JU8lsH+9sLkMUz19MrEB1Omd5o3w4NhtoKRAlZhiI9tKzXGstxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016519; c=relaxed/simple;
	bh=HfDv8yuZwZYBu03PLHPJuhXwvsGp27tdcr/KfDiKWwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTYalfk1wIoyMvOOD8lrLgQ7QsX3pjG/3UTBGr2CzBp90tw1bH+oi/16B5B0mJEf6XlRO5FXIV086seTfHs38aOAAiISsWbYAgo7YX+U6pU1FErZ35sJJ2Ze+ApoUHbLz6zgOEw/4HNbwGfEuEpm8KwgshI4IlamzENTSUr9C58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jE1TvHST; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f8524f23so636668585a.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738016517; x=1738621317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zgtg9sEYYepf1PWWMu6DdFDPfrhrnEUXJiVlMwbDK8o=;
        b=jE1TvHSTRugP3N5J/Lg4NSlMHOhp1R5ZGLHh4lsSMDHSBlF0o7fAA1zjSpzy9ZOST1
         dZxzveYQ28yn8nI4FUGNn9AqeIdBrIDbqYf0aY19PJVr0CMy9DEHplgSc+syV3jlT7mj
         F7vI6wMWGKSFj5a5f4pIToEq7iyh2VWXF5Vg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738016517; x=1738621317;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgtg9sEYYepf1PWWMu6DdFDPfrhrnEUXJiVlMwbDK8o=;
        b=B2wmOPHY5SqjSr2bdlzufATZO0W2DJloJ8SKE+DqtZzPbrYd9ZHF74TVbGMZ1kqneo
         Igh2gUNqt4Wxv+QI875+QTA2kkAY1Ny4iEm0PUtEWDYxpQaFoHCIBTiz2MSds9KV2rNC
         YXuV2ed1KtFAHOqOPdYHlyc5wM1KHlLmDQkiuRUx5cMqM6rmngARUSeB6ATBEqA17Cmn
         ljGbCu0fqNCxqpgN+lYdT3EcghYm7Q6ZRtXdSuyG7p/H1gicTzI7SWEbpVYMsU9z97ff
         Koi7bMILvzBKl7jTagEZM4vYgol0RfTtDJ7UdX6zJjSPNWCUbW+94loDz056+SPADJRr
         80NA==
X-Gm-Message-State: AOJu0YwHGLHHwQwItU1a3qlSpQBLkORzxKcuxfjfJQpBG4LV0l62WZIa
	Ne14yGrVGifd5K42eTXR32koxHQgn4cn/idSA1qmssnfnGYAHfB6IbYVO0C5yc0=
X-Gm-Gg: ASbGnctIcNCFGd93qvbpvfNrx9Jq56dW5axpZ/vOr5/eywJd8X8c4f5/Bq7luUG7EHr
	jnQKVuxmJO3CTtraJiBJeR6Iyckeqpy2dK6RMMhnbSdyM64ifheAj9jFcFBHgYqSMgCDgGcsKvs
	7FKctkG2hCZLulenPzeWA10LcYwE7wJ2EO4VP6wBDibPRegy7Ds30qDBYxY8X3090sw61xYY3nC
	pucC+Iv5WpB9iAlRpM8Wp82xm5PhrsYJot+qQFALH+y1uDKZDdfJL2PEcoibfiraBre2fRDsOaW
	HxLuy0v7/ET84j6OujB2XUzC/WdC+LX1R2cPEP3fo/s=
X-Google-Smtp-Source: AGHT+IFwEVN1fNwLMWq8+hBoMC0fAeQqthTVKxqiNjFFaEHa55r9SdnkWzcSkqaYij0jYQMDA3y18w==
X-Received: by 2002:a05:620a:17a3:b0:7b1:19f4:c6e0 with SMTP id af79cd13be357-7be63253f1amr6652328185a.51.1738016516733;
        Mon, 27 Jan 2025 14:21:56 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6689c838sm43527321cf.37.2025.01.27.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 14:21:56 -0800 (PST)
Date: Mon, 27 Jan 2025 17:21:54 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	jasowang@redhat.com, leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 1/4] net: protect queue -> napi linking with
 netdev_lock()
Message-ID: <Z5gHAmNpXGBS2Mp8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-2-jdamato@fastly.com>
 <20250127133756.413efb24@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127133756.413efb24@kernel.org>

On Mon, Jan 27, 2025 at 01:37:56PM -0800, Jakub Kicinski wrote:
> On Tue, 21 Jan 2025 19:10:41 +0000 Joe Damato wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > netdev netlink is the only reader of netdev_{,rx_}queue->napi,
> > and it already holds netdev->lock. Switch protection of the
> > writes to netdev->lock as well.
> > 
> > Add netif_queue_set_napi_locked() for API completeness,
> > but the expectation is that most current drivers won't have
> > to worry about locking any more. Today they jump thru hoops
> > to take rtnl_lock.
> 
> I started having second thoughts about this patch, sorry to say.
> NAPI objects were easy to protect with the lock because there's
> a clear registration and unregistration API. Queues OTOH are made
> visible by the netif_set_real_num_queues() call, which is tricky 
> to protect with the instance lock. Queues are made visible, then
> we configure them.
> 
> My thinking changed a bit, I think we should aim to protect all
> ndos and ethtool ops with the instance lock. Stanislav and Saeed
> seem to be working on that:
> https://lore.kernel.org/all/Z5LhKdNMO5CvAvZf@mini-arch/
> so hopefully that doesn't cause too much of a delay.
> But you may need to rework this series further :(

OK, I'll wait for something to emerge from that work before
re-spinning this.

