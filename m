Return-Path: <netdev+bounces-123368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2547964A04
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599A11F23851
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0141B3734;
	Thu, 29 Aug 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pkoYZ1Wq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7221B0117
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945288; cv=none; b=NWU/iWayxNgeWVTeEi9vpbmyE9lSe4WxyMhvJdD+fdFAijMnWUPnPwuiQypTHAXrdH3etbhsopdFimVrFH8fKFNuIvUWCtLFEXYOkqzwt9ntMZ+TBVHUW5WyKomumpemR9j+bdfs5EWWggAG8o+nZVYi6oS2khlSnORQLt0rigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945288; c=relaxed/simple;
	bh=Lka1zm7XmcUB5solzQAlYgxWdcDi74lEnAD6wVdlaB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNLrpsg8ePRIlDxBCSiR9VngM4lRB2+QVWK3hdt1AYqC98yRKibSdxvWW3nCQ84zJH7riYYEPJcp9m53hjIs4ba1VfMzk8FwX9NKLs21xw+KZwR2bkcxCw2djRLZaWGDLedmBq9qJFNrWMasIhJpIUwkPd7KpVNG2jq4mHfN+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pkoYZ1Wq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so902946a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724945285; x=1725550085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6k+Lbp/vKSlk4oMmUj+Nso6RmewTr08uCZE3vQ6ntA8=;
        b=pkoYZ1Wq3kj2PFb0ePlgGTh915DvS0Yya9qBMxgft8N9SVNfy2ngDOB3iIN8DKreJI
         T1bG1/PhxugXBBiF82U/qZjpiVT23dR+4tAlCD04HIxb96+vPurDrK9rMW2jg49stK1m
         5qfufGD0S0OA7egXf91hJmVRQW8dollnc0Nyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945285; x=1725550085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6k+Lbp/vKSlk4oMmUj+Nso6RmewTr08uCZE3vQ6ntA8=;
        b=Dq4SoIFUBKkv0nrld6a1bYJ+aLSM23WJ9LH2e6hVPNbUIj+Ohc3d/WVgEitbb5VSL2
         MJElikH0vm3bbXxGBNIOy68aE/F1MPx9O+Pb9GTKebGNyjzGLpMY+QJ1azl5xWmfwZDB
         EAh1bWqlodcPfa9zyMENlxaK3t5tKWF5Y0xI8KXaGu5lHtqH5GvTrYzwibIhsHG01Z1O
         WfrMLPIDOwJe1SNmc/5fIK/z89JF4Ttxj1HhszafmpZEfajn2rHVMZogQTy6L/hA/v9D
         AAurgc8LtgFQfj1eCbiCnGjdwozcr6ig5dA2tidba55d1qXXU5g2E8Iy5FryqSl9Dput
         F75g==
X-Gm-Message-State: AOJu0Ywxp4/MMDRsIUdecLz7IGe/plBJeeNwEhL+LAhwiBExA8W40SIJ
	1UYztzdaWnJjstpLVFq1+VCTyZBpLZbWEdtgW7vGGxt2boJOEcDgb3SFEZay2vc=
X-Google-Smtp-Source: AGHT+IGb3JIMQyWbOM4dnnyOp1EW2lUPeYUZ2LE2Fn5Y8fixva/Ya5HAMfpZPdTllAZGR3YEgps7qw==
X-Received: by 2002:a05:6402:3584:b0:5be:df7a:14fd with SMTP id 4fb4d7f45d1cf-5c21ed41d85mr2980037a12.9.1724945284582;
        Thu, 29 Aug 2024 08:28:04 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989223268sm90211566b.218.2024.08.29.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:28:04 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:28:00 +0100
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/5] net: napi: Make gro_flush_timeout per-NAPI
Message-ID: <ZtCTgEEgcL3XqQcO@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-4-jdamato@fastly.com>
 <CANn89iKUqF5bO_Ca+qrfO_gsfWmutpzFL-ph5mQd86_2asW9dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKUqF5bO_Ca+qrfO_gsfWmutpzFL-ph5mQd86_2asW9dg@mail.gmail.com>

On Thu, Aug 29, 2024 at 03:48:05PM +0200, Eric Dumazet wrote:
> On Thu, Aug 29, 2024 at 3:13 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Allow per-NAPI gro_flush_timeout setting.
> >
> > The existing sysfs parameter is respected; writes to sysfs will write to
> > all NAPI structs for the device and the net_device gro_flush_timeout
> > field.  Reads from sysfs will read from the net_device field.
> >
> > The ability to set gro_flush_timeout on specific NAPI instances will be
> > added in a later commit, via netdev-genl.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> >  include/linux/netdevice.h | 26 ++++++++++++++++++++++++++
> >  net/core/dev.c            | 32 ++++++++++++++++++++++++++++----
> >  net/core/net-sysfs.c      |  2 +-
> >  3 files changed, 55 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 7d53380da4c0..d00024d9f857 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -372,6 +372,7 @@ struct napi_struct {
> >         int                     rx_count; /* length of rx_list */
> >         unsigned int            napi_id;
> >         int                     defer_hard_irqs;
> > +       unsigned long           gro_flush_timeout;
> >         struct hrtimer          timer;
> >         struct task_struct      *thread;
> >         /* control-path-only fields follow */
> > @@ -557,6 +558,31 @@ void napi_set_defer_hard_irqs(struct napi_struct *n, int defer);
> >   */
> >  void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);
> >
> 
> Same remark :  dev->gro_flush_timeout is no longer read in the fast path.
> 
> Please move gro_flush_timeout out of net_device_read_txrx and update
> Documentation/networking/net_cachelines/net_device.rst

Is there some tooling I should use to generate this file?

I am asking because it seems like the file is missing two fields in
net_device at the end of the struct:

struct hlist_head          page_pools;
struct dim_irq_moder *     irq_moder;

Both of which seem to have been added just before and long after
(respectively) commit 14006f1d8fa2 ("Documentations: Analyze heavily
used Networking related structs").

If this is a bug, I can submit one patch (with two fixes tags) which
adds both fields to the file?

- Joe

