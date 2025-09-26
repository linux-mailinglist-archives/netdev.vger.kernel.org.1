Return-Path: <netdev+bounces-226749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46074BA4B34
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA06B4A6AF9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0B3054C8;
	Fri, 26 Sep 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdSYuNVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F372BD5AF
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905147; cv=none; b=jGb2GzyTxVfSKcu9V2DzZS8JXLppbzb3ZRPQIzy8pkIC2EoAyhjPM06x+xRJ87tKRqQ8ZGHhNDEmrVy86VIgIqqKnLczev5api0+VdNnWkYAclDMOdy4PLdZpiwixs5UdlqxZVjsp1SWs3REucgChKA8QLzN9PE49QyLJogMPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905147; c=relaxed/simple;
	bh=Vs6TAGLNP0P+xmbqBciKFWYHtBQhY1DI1fGlxkQza8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GooYe855CBA6w2IVsVw7ETePOkVKmzgz5KVU2sM0xwxa4LtqnriLtbqO3ACqt3Tp0EZAqQs1xrHgbdh1e8bS3gyjis6XBAbonTyAtk6vwFZgAbAgIuuE4szRDNkmst+Bg0ij8wZbTljdwB9Z288t80frCX+d1JTVMJkIvrWM2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdSYuNVf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-73f20120601so25573017b3.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758905145; x=1759509945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWe6l9DFEZIe2QF5kWTxkiV4TR1qHm+R41H6tLR7BcY=;
        b=kdSYuNVflSeyGs5exn2hCuFEhA/ar3DNYHXHMbOPamsIprarYpTD/N0qyrz6fQUWXB
         I9ZKQr9o1NVVic3cnUPTf8fsYMrT4zaasu84yQ75dBmTJp4zWBdYZg8vN5NGlnCvkWkw
         iJ6GSvEa78eLw0aYSYLaoUR1RR52IAzb6ZWL1iPpzk/o6JtizVsUQAwqlkhbHSbO/u3h
         0FyCWNKL6pj0gBIkcUT5qs01ViPgvzPODmdhiDMYBfhHb+E3ElbGpdBbO7nv2APHkHua
         uRKRN7xMSoaIhZc8R1NwGa6era3VDyR7gXTrOasVfyzGefV0iyLKXe56YVW0I9ANOTr3
         nzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905145; x=1759509945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWe6l9DFEZIe2QF5kWTxkiV4TR1qHm+R41H6tLR7BcY=;
        b=kmjn4N35N4SeBMzmUafFNOFU4hm7oPevwRBF+3evwB2i01ahUSY1J4ZynWJ/8mOa3W
         mBDgVBLfc4/TPbKzEHcOCY4l8EC5SECl5kyWfOTGoeAJSH+Gc552Rkj13CTV+cYfttyH
         49xeklUUmhY2TRj+6Ua99fqV5eylSb1yPuT5gTaxsISbBtamqybesJkYzLO5VE+F+JLD
         9c1fl5YubSUqLpwHS2CRB9WskfNrDqqMl0Erj0ISfKNTntU4m49adaipCOH0hySmEqP1
         u25wESjPMrRZZxgbhSp22Vi1fNrPM5wEVS99CHLF1CvRgXwdVuj7CIiiuGI7MqljQpjy
         pxtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGjR4uaTtTy0I+TM9E1sj6khG5T0zZmxWCoh4w9TCP7kaEzqMrk3Dp/V1IvU6VUqCwMpuQ6+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ874CmYWtQYhcZbiK8gkmiV6uZcTBY/GNF9uWVFJxigcHAKQR
	Y+RWxGsIApX8NVnX/7aHXgn7mBMEA+VDSVif/yxFrsIuZvkNUH7TwaaN
X-Gm-Gg: ASbGncuwOyQFccBCKOqGbE0GciMl5F98Cs9tRa7Nl/kU6JpOxHVAYYZZZzUuNtlfsRC
	podOOx8EGMQf3bae1KiLJCQAfIFcCSuBLdArwwf0J3EtNu8PkVYWu+oVvJIXJ11VMpXC1heVp4U
	oDMLF7PFuefDDskwHc+GEmdYlpus8ODK9PFIxvoCUOErKRbYUP1Lee8GiuZfi6QvLz7pE8MQcnl
	ifJCVLBbm2DaZzjMraOR4wmOnkuIzNxu3b7JMtVxTUUOKZWBrX2Gx9GvbV1P7X7nTusi/oXBeR1
	NTqMF6VaDWoSeDxeHE+KK2qNP4qUxuK0kFW3GY4BdKjdLk7ww/7GollKSnQIyvhFPmI6KS9Vfgy
	9QcxzjU7lMx/zE5K/WTN5/Zti24QO8ScG6hwSwEoMcho+Jjoj0ZZ3Yi9KMg==
X-Google-Smtp-Source: AGHT+IFpF5cWlNLrT5bHlj24v+44FGgh9yJp1dc+sghREQUf8FAhAKLzfo2Kz30PeNG78RhjMp14pA==
X-Received: by 2002:a05:690c:6c84:b0:763:e43b:3ab6 with SMTP id 00721157ae682-763eae4da07mr94212387b3.0.1758905144931;
        Fri, 26 Sep 2025 09:45:44 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765be47f630sm12074467b3.29.2025.09.26.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:45:44 -0700 (PDT)
Date: Fri, 26 Sep 2025 09:45:42 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 0/2] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aNbDNr8ZHw5AzVHQ@devvm11784.nha0.facebook.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com>
 <aNa3ValQeGEm_WGb@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNa3ValQeGEm_WGb@horms.kernel.org>

On Fri, Sep 26, 2025 at 04:55:01PM +0100, Simon Horman wrote:
> On Fri, Sep 26, 2025 at 08:02:52AM -0700, Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by replacing
> > the xarray allocator with an niov array and a uref field in niov.
> > 
> > Improvement is ~5% per RX user thread.
> > 
> > Two other approaches were tested, but with no improvement. Namely, 1)
> > using a hashmap for tokens and 2) keeping an xarray of atomic counters
> > but using RCU so that the hotpath could be mostly lockless. Neither of
> > these approaches proved better than the simple array in terms of CPU.
> > 
> > Running with a NCCL workload is still TODO, but I will follow up on this
> > thread with those results when done.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Hi Bobby,
> 
> Unfortunately this patchset doesn't apply cleanly to net-next.
> So you'll need to rebase and repost at some point.
> 
> -- 
> pw-bot: changes-requested

Got it, just resent and added this check to my automation, thanks!

Best,
Bobby

