Return-Path: <netdev+bounces-96593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33608C6941
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CD1B21F09
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30813155743;
	Wed, 15 May 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0WSBoyd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B915575A
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785658; cv=none; b=aLg/Q6Fw16vpht4FkqIyZLtooDdr4GclrL8lphBa7jvkog3dkSx28NrKs9yb7cwV4Q4RyHCUszvUZcHTxZn7QhQBg+c+55CyvIsNVCRSuUpPzA65JJ26fZWVu98wW9ridkv8avy6dhJHC5Y5mVo03qHbhAhTEQctN4x37BsxmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785658; c=relaxed/simple;
	bh=nB/Wx+bzRLvAZM9HJrayest7/Jl5WbZCbrJZngd9CQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnyeXEKwGyFR++WmjFKYucKlDnqxw1xhmBrdUsPjRqeE8di3EbjXfwQ9cLxZMDe4ZwThVv0Rv0Nd8zqjxdi7TBf1j7DN9nBnlkhbPOSYamlcpNKWwKTP5zPVbDe6k61qh6MzlCFgxYgK4Sg2bOFVzWzDK14Dw/WWdqvBUlSenjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0WSBoyd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715785655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbrWi8lbFLyv72mKMlVkkmYPCKHUduDQsR6vbInAIJA=;
	b=B0WSBoydQ0DcjpMXt7SB7HRsmBXyO9vec2OngHu3ALAw5HS+4mwaZwF8icTwrIv5qWjPMT
	tPrEepkzYyxijkzCl/fbsp8X8OczeHXhL24vcL4sm2/rIt+Ca+1IEqOe2Wkwv3jlxJ4qjy
	WVbQ26m/vPscnMNtzlGWT/ZilejM4GM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-W2EbU-TTMlGbeKj4SxJEuw-1; Wed, 15 May 2024 11:07:18 -0400
X-MC-Unique: W2EbU-TTMlGbeKj4SxJEuw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e482d3d843so67358941fa.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 08:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785635; x=1716390435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbrWi8lbFLyv72mKMlVkkmYPCKHUduDQsR6vbInAIJA=;
        b=kI9wj7ogQRiWNOPptEn+pGUraBI8gR5PxYUI7IvJj60pdcBKSVcecY0mzq0gFkPvT2
         JPVNu6KB5oy/nMQoflnWWHsoap5D3FIwfQfzxkbv7ZjcJuI9InVS64lfQKpKlIV+kSw4
         hY9VJkd2ZwQOtvnrErZacsEvWHvwvt4agBG/dBmdM7Ov4Yz0hX9OF73DHPD41DzOI3Zi
         N8Ze20XmOYHiL8Fdjldbsk1dLQXX4R/QW2V8q5WVUfuZahT06LR+Y9LOebggH8M/2szh
         ro1N9y9RAWpeG+V00FpnSe8i066K1OQdydGM4RoBagf5wSQ6AsXuHbMGEsRMSPQpOVwZ
         II8A==
X-Forwarded-Encrypted: i=1; AJvYcCUvLuhisyQ3j5XxQ3jUmAeCv7xRGYUiE8RH0ER311nH/fNRZOL3qpx9QILdxy1kHBiJuRcnQvg8G5fE5wbRLkbqoThSN/BH
X-Gm-Message-State: AOJu0YxgqhxVBraBSce+Knkj7D7OimQ4W429Cbov2P2vEymudEZZ4DzU
	/o0HWQFanJttDitdyBURC3soe54voQNSAevptNNzUE5CkJlDgyLeHTkF9XWi+pHnL7QK6BWB24Z
	5yoPQJ+vT6HYFpO0+nLdPPuIa9kBVKJiCGsJqPe6mnb+x7XfHVrzXbg==
X-Received: by 2002:a2e:7c0d:0:b0:2e3:7121:aba6 with SMTP id 38308e7fff4ca-2e5205c61a3mr133092461fa.46.1715785635243;
        Wed, 15 May 2024 08:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA2MjU83PmPbl4SP+crO3lzmgqKP48+f4i5kvUwU7C8/1az1QdYe3lnvRKkMDiMLe7dIqRJw==
X-Received: by 2002:a2e:7c0d:0:b0:2e3:7121:aba6 with SMTP id 38308e7fff4ca-2e5205c61a3mr133092081fa.46.1715785634668;
        Wed, 15 May 2024 08:07:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bccesm16825319f8f.5.2024.05.15.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:07:13 -0700 (PDT)
Date: Wed, 15 May 2024 11:07:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <20240515110626-mutt-send-email-mst@kernel.org>
References: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
 <20240512115645-mutt-send-email-mst@kernel.org>
 <1682873e-eb14-48e4-9ac6-c0a69ea62959@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682873e-eb14-48e4-9ac6-c0a69ea62959@suswa.mountain>

On Wed, May 15, 2024 at 04:50:48PM +0200, Dan Carpenter wrote:
> On Sun, May 12, 2024 at 12:01:55PM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 10, 2024 at 03:50:45PM +0300, Dan Carpenter wrote:
> > > The virtnet_send_command_reply() function returns true on success or
> > > false on failure.  The "ok" variable is true/false depending on whether
> > > it succeeds or not.  It's up to the caller to translate the true/false
> > > into -EINVAL on failure or zero for success.
> > > 
> > > The bug is that __virtnet_get_hw_stats() returns false for both
> > > errors and success.  It's not a bug, but it is confusing that the caller
> > > virtnet_get_hw_stats() uses an "ok" variable to store negative error
> > > codes.
> > 
> > The bug is ... It's not a bug ....
> > 
> > I think what you are trying to say is that the error isn't
> > really handled anyway, except for printing a warning,
> > so it's not a big deal.
> > 
> > Right?
> > 
> 
> No, I'm sorry, that was confusing.  The change to __virtnet_get_hw_stats()
> is a bugfix but the change to virtnet_get_hw_stats() was not a bugfix.
> I viewed this all as really one thing, because it's cleaning up the
> error codes which happens to fix a bug.  It seems very related.  At the
> same time, I can also see how people would disagree.
> 
> I'm traveling until May 23.  I can resend this.  Probably as two patches
> for simpler review.
> 
> regards,
> dan carpenter
>  

Yea, no rush - bugfixes are fine after 23. And it's ok to combine into
one - we don't want inconsistent code - just please write a clear
commit log message.


-- 
MST


