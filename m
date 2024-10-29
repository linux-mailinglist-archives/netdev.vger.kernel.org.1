Return-Path: <netdev+bounces-140034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BEF9B5162
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B871F251AF
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16571DB349;
	Tue, 29 Oct 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fTJU99wk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79A1DCB2D
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224428; cv=none; b=jkhFHCFSIhHZgWV7KzJWjnzk3knQOQWeYWqBkxRX09mlz98QhTz8YMUTAjBhDqa3CEPZM/JArL3FO8zcrmynPZMQlzc08akQcoYn03WHqiy3mJr/Zwu631FsTyMqjhmlDdSKQm2/Pw34htfeVYowSGuYXdzCXOTdNluC/Djozzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224428; c=relaxed/simple;
	bh=WziafT2eTMjBjW229ktOTyL8rO7sTGDiAd1/ejN4CL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+UbwPjLo5nZmd7JgMUKdnFUZGPi4c8K5m8PUKB2w3G7cWJOtmOQWSOfOt/yXkDlw0ugD7DacN9qNPlD+8we48KxhC3dZI9ce8vwbvChLfaZ9vBAR5A8HtBDhm1T/FvYQGT5Hvc7mCvBRX/WX/xpvzN5Xx0Bqcyux0zkyiUfIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fTJU99wk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20e6981ca77so61859055ad.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730224426; x=1730829226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtH9ZoQPDiHEkDhWLDrz6/hg7ImzZ8y8bzq5j1Y7ZXc=;
        b=fTJU99wkY+RRoB7XpBbCXXjI/OIxRM6ZKggywcCD1AQ5CkuWr7kIA2cI0s5AbC7PCx
         xuhVIq/nP7lfy+NqbmQhkHeZVkH+q66Nl1ERPbhAc4SKqzixwiq8/QQHNMS25PoFD7q7
         nXEsapYO/X7NwwAU+j3NSg6e9zQxmhcjVOy5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224426; x=1730829226;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtH9ZoQPDiHEkDhWLDrz6/hg7ImzZ8y8bzq5j1Y7ZXc=;
        b=izqN98CMCDzVysIeYjWc2kVaP1yGvM4UHIjTnuJAmmvqZpuVEYq7SVuMLN7sqHvWev
         GFlnCheHaKRxNO8BiHuhmRfW75r5za5fuOaT8sZ6rwE7GxT1628AZm1aqWeQRExupUht
         xxeiGIF633xZOjsWJPdx7IDeHAI6/xy+veJ3OqgU2qaQBjBf1by/FkBA2042cKM4pTwv
         HvF6Cz5FrrgVYs0OYgIJe8IsJoWri+nBHEb1zHmLCX2LvD08q0oqcSBIZKrboD0A5gnY
         4rjEkF0SvfAOGcOSY0J+q3igvntwyLQHUz04DQk3OPwFhVPvFeF3xoVy7OAhRBHE0v0w
         dG6w==
X-Gm-Message-State: AOJu0YwNmmYTILDezI8JU8od3/rBSvDhA6tS+AbefG576Kv68E/pLO5I
	Ze8kNaOSvxpNh4bc9g9sgygWQ+gMsmRMXbLKPZM+uygks5cH6863I+RnzNl3QgA=
X-Google-Smtp-Source: AGHT+IFl0sEy36nL06f5S7GHxaLAmGOVL3UnW1+PfSkmqSMmqC2WV99zVZZGGp1yXDhj/okALP3/GQ==
X-Received: by 2002:a17:902:d507:b0:20e:986a:6e72 with SMTP id d9443c01a7336-210c6c0906bmr183390355ad.30.1730224426104;
        Tue, 29 Oct 2024 10:53:46 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf88490sm68819745ad.114.2024.10.29.10.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:53:45 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:53:41 -0700
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>, Jan Kara <jack@suse.cz>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 0/6] Suspend IRQs during application busy
 periods
Message-ID: <ZyEhJXCrZgBLMJgB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>, Jan Kara <jack@suse.cz>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20241021015311.95468-1-jdamato@fastly.com>
 <57a0e1e7-1079-4055-8072-d9105b70103f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a0e1e7-1079-4055-8072-d9105b70103f@redhat.com>

On Tue, Oct 29, 2024 at 11:25:18AM +0100, Paolo Abeni wrote:
> On 10/21/24 03:52, Joe Damato wrote:

[...]

> 
> The changes makes sense to me, and I could not find any obvious issue in
> the patches.
> 
> I think this deserve some - even basic - self-tests coverage. Note that
> you can enable GRO on veth devices to make NAPI instances avail there.
> 
> Possibly you could opt for a drivers/net defaulting to veth usage and
> allowing the user to select real H/W via env variables.

Sorry, Paolo, but I took a cursory look at veth and I need to object
more strongly to your feedback here.

My understanding (which could be incorrect) is that neither veth nor
netdevsim use IRQs.

The whole purpose of this series is to block IRQs while data is
being busy polled to increase efficiency. That's in the cover
letter.

If neither of the drivers we'd use to simulate this in selftest use
IRQs, how could we build a selftest which ensures IRQs are correctly
suspended during busy periods without first making considerable
changes to either (or both?) drivers?

Respectfully: I don't think it's appropriate to block this series on
that much additional work.

Please reconsider and let me know how to proceed.

