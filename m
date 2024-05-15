Return-Path: <netdev+bounces-96589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE05A8C6901
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2751D1C21483
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF8E15573A;
	Wed, 15 May 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbx7+7IS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15B155730
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784653; cv=none; b=qOP9dG0U/8iEUWW71tGw8usgkKBAhKvbzKQxkaVuf4jEKvqDBbjgGoW6lKgta8CxbGO5forQ+WYa43dqpS2kgrAC+AsVn3c8dZXuL/eMXI6HFyZPw/sQnMRm1/3BvfGVjKRSCjGDEYASQgU5DqhLnSUMNkkW+ZuSbchzLiDEx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784653; c=relaxed/simple;
	bh=5TCp5CXvuptPmYaBhT5jPeD5TXNBV/1+PLyuz7yUB3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuWkPgNSGa0PX9Ua/K1tQheCDDkSOZk+ZDl3u+1l2ugGqj2b6mcIYqGndWtSTNIHM/fF/3BK0CyITVbmNr8qi0/hTNS0RoKQoqqHyfgGarYd9q4lFo0YCM/FldA6UK1LAJ4/pcQnMFmwwznrWg/5uny5XG018qwoXk+4QyQnGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zbx7+7IS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41fd5dc0439so47299585e9.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715784650; x=1716389450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm2oQckW7dl+Jy0xL0CP8kgBBxNAcYsRe32+op0a91g=;
        b=zbx7+7ISHCCqkG5AC7HaiHzS71Te2zaBV42OUjPY+ceSz5DlR3aljW28eUu26s/wPk
         KHGaig/Rns+tZjWhTmXWRMkCxoVu3iduVgLpiT9YxmJGyrLGCJESQ8ESQ03you9uuwsE
         hxRZMelNgjxZ6NbH9BvbjrC5Zlywz9P0VmzSTst62t0bJFxXBzXiUZen0RypWLwtUTqB
         mdN0+yUeEUEblHWb5QwFgs1Ep2AAYan2XKQmnida/kjxA3P8gbZVG0ZvFjLa7h0zcIl5
         uq9t3KsXbcisEjDA2zJ7o68MiE0VsbhV9DFlNHLDBEJo1n6GOT3OEBfi/kHknyABvNd6
         Qq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715784650; x=1716389450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm2oQckW7dl+Jy0xL0CP8kgBBxNAcYsRe32+op0a91g=;
        b=AfqVoifJcLjzES8TD6MJyC1VpFynwoBS2NhPYRR1WFLdyBecQK62BZuF4ebfZSQTE7
         Zl6HZCngRg3iutGcy168qaqTZfp0SGuzLj3yAqeRJjMFQ/rVUqGzDKedv6OeqUf+RJw2
         0OM/cxvttxl/U++OSiJX3Hf4lqOWvv7Bx8EjmyA/YvzYmvDhGCXFVBoq8RzFTEoLcHTb
         5LmPDAUhCaJjYGCod8HuOq4bu8A9pl4eKDEH/cTeIKP/OxORlaHI8gjsVRVydlKDcXo1
         DVG7RS8NET86u5yJ9skY2YB653XxhJbpE0FkMG+6lopG0rW+3Be4GK9kbkwbo/tOqeKO
         bacw==
X-Forwarded-Encrypted: i=1; AJvYcCWfiKmPi/crILE9nPuHaYX1moDOs3R2nmCa9SsyrPoE798Tgi2rfS694SsehhxD4hmKOsjozvvfFDKNnw+gALsOKlY1o/9p
X-Gm-Message-State: AOJu0Yxfjlg3KB0c2aHVpisFJhW3BxKYy5WDtPXqv6VkLyjo0B8ReuDr
	bpBrb0T72kiYz2Kb77yZLCSDEF77r7yD5zpi+B0Y/GCL1ap3ad7lCxmC7vXTjHk=
X-Google-Smtp-Source: AGHT+IHc88s0jQf5xDyEKdeY62SQPNAtebdb3EiQmKtKM1DRT1aZC4sH7hbL/Wt0Qqg56kktMNhVNQ==
X-Received: by 2002:a05:600c:3502:b0:41f:d4e1:5abc with SMTP id 5b1f17b1804b1-41fea927ea9mr107194485e9.8.1715784649874;
        Wed, 15 May 2024 07:50:49 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff063d8cesm202702315e9.46.2024.05.15.07.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 07:50:49 -0700 (PDT)
Date: Wed, 15 May 2024 16:50:48 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <1682873e-eb14-48e4-9ac6-c0a69ea62959@suswa.mountain>
References: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
 <20240512115645-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512115645-mutt-send-email-mst@kernel.org>

On Sun, May 12, 2024 at 12:01:55PM -0400, Michael S. Tsirkin wrote:
> On Fri, May 10, 2024 at 03:50:45PM +0300, Dan Carpenter wrote:
> > The virtnet_send_command_reply() function returns true on success or
> > false on failure.  The "ok" variable is true/false depending on whether
> > it succeeds or not.  It's up to the caller to translate the true/false
> > into -EINVAL on failure or zero for success.
> > 
> > The bug is that __virtnet_get_hw_stats() returns false for both
> > errors and success.  It's not a bug, but it is confusing that the caller
> > virtnet_get_hw_stats() uses an "ok" variable to store negative error
> > codes.
> 
> The bug is ... It's not a bug ....
> 
> I think what you are trying to say is that the error isn't
> really handled anyway, except for printing a warning,
> so it's not a big deal.
> 
> Right?
> 

No, I'm sorry, that was confusing.  The change to __virtnet_get_hw_stats()
is a bugfix but the change to virtnet_get_hw_stats() was not a bugfix.
I viewed this all as really one thing, because it's cleaning up the
error codes which happens to fix a bug.  It seems very related.  At the
same time, I can also see how people would disagree.

I'm traveling until May 23.  I can resend this.  Probably as two patches
for simpler review.

regards,
dan carpenter
 

