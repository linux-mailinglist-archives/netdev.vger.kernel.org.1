Return-Path: <netdev+bounces-171340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A91AA4C986
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861493AB9F6
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB23E2376FA;
	Mon,  3 Mar 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uo272dwA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE32376E1
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021216; cv=none; b=npz8699ZcmmIz5eit+kPCIPOwxZDmvzVPLprHTuWIiOOFfayCX7v/ODQlHF03Y6rnkOD7oOEuiHUqZPrgWUsPvTg8N9dd66zn2+tVtQ0dKhMEXGOymHPNng57YPZBlK0+7xF2zqQ1AoQ2NNeb1riR2ZiBaCIyHF4zU024s0J9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021216; c=relaxed/simple;
	bh=PuyMo56E1J04N+xRFHQpuOme3py1aZX9AvRAkMmg0TQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kF1rSz86iJKjsOCWOYDdj4boY13OGzLVV8BlP0c192cJoelrrjXvP9ZZ7HuVTo2nu3bror8+OsaNYDXLNGrDk1yjVm8Ajmo917Oou6FsDhyn8rFO9edYOpAINet2YWEeJkUHozcO7HEAObQxR1621t4yftXnfFPMfTv/YVwrL9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uo272dwA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0ac2f439eso572609685a.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741021213; x=1741626013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yL69mmP3AaHszBSiFbdb5IOP3AgAgn4Zq7i8mgBTtbc=;
        b=uo272dwAOxyYV3wwlUSRK7y6qAgQ5HoJhHH5wUO+q4kQJ7MijoexJ0Ok4/8vSHvJKZ
         V9CFjNFHIs4Vp9cd0PbwcSNDlgOZ+rPJCoAHTwr/dg1LJMpPFSCcMIhaofmFjMm4yxP8
         OKDl+pH0oMLDZN76zD+cUfgAApjurwx4afWK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021213; x=1741626013;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yL69mmP3AaHszBSiFbdb5IOP3AgAgn4Zq7i8mgBTtbc=;
        b=dRWblmASf0Qge40hkRB+5K0mZPl62wf/x6srwj+HjKKV3JyCpM8FsB08kYsK1unxV/
         Uq63w7kRS27MeA00StdFM259L+koQhkQTYFu7S7gswPwwkk4SZsaPDMUjmKpcxyme+UX
         pD4ngoE/xDxgFXL9ugFSCvcTcRfpcQKNFjD7CAS2JduYmuVvJn2FPKkHDMgW5uBmvWW2
         2BhTgfyiJSdlBiq2D41NIlbAwljORGExF5Yn9sO2b00Hxs9ORTLTKw7j8hlmcg2mZPSA
         cSRTN2DQ9iUHM/Khvk+rzYIRe/neXB7H6f6GIHboZepbaatHEO7d+t+n9cI4CrXOKjJu
         fNqw==
X-Forwarded-Encrypted: i=1; AJvYcCUY79lnu663fi9lMD7UwxMXkSFiHqWU6H0lKSRz+jo2R7psXUtimh4em+sp/Be51GgqYJoSQ34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvztsRmD9udO7U3ie95uLotON7VzKywdnu39+AMjW4NMfSW9yJ
	JXrAGGedgcLS4Etor0ifBgdYmNfeQZE7VaOpC90mWbraWD6fZpLdaF08kmJX0Yo=
X-Gm-Gg: ASbGncvH+Vl6mY+fVibXR9UEJk8kJ2ZUZN22CTTcxB+ymkNh0G7UAD+N970pLnHT+FX
	LpuGHKOpfa/Rn3IiOLeQm456Qx8nLVgGudpEOlUO1umc2ygcrVx4pqpxqMgXzK6gxedhzCC5vEk
	lwkXL6Y3SfUvdbnR5bdqTF+Xgk6WDhhcnrk39dlQcjU+cZnS8uvmZ4xr2k4v7puDHZD9OOdzIC3
	Sz5KuUYGRJvLogk6oow3proCNDTYHOcqSSaRwgU9ZfiepT74wlZca+tOA2f4PVTfxAKyWrGbMP/
	y3QLYbXosBw10pLzs6relaadzlzn04chiEKSIZrzuoCSGQECoRxa4gGw8TMNmY1srUf9VdHjvPt
	LppOpEAY=
X-Google-Smtp-Source: AGHT+IHlpeyEa5ZH06VbJgoLcEMoTEGviZJYbrPAPhw4YUCksto74AOTT5BgLi6sgiQez9Vt7bG6ig==
X-Received: by 2002:a05:620a:27c7:b0:7c3:bcb2:f44f with SMTP id af79cd13be357-7c3bcb3000emr677131585a.17.1741021212762;
        Mon, 03 Mar 2025 09:00:12 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36ff0f3c0sm621367685a.56.2025.03.03.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:00:12 -0800 (PST)
Date: Mon, 3 Mar 2025 12:00:10 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>

On Mon, Mar 03, 2025 at 11:46:10AM -0500, Joe Damato wrote:
> On Fri, Feb 28, 2025 at 06:27:59PM -0800, Jakub Kicinski wrote:
> > On Thu, 27 Feb 2025 18:50:13 +0000 Joe Damato wrote:
> > > @@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
> > >  	for (i = 0; i < vi->curr_queue_pairs; i++) {
> > >  		struct receive_queue *rq = &vi->rq[i];
> > >  
> > > +		rtnl_lock();
> > >  		virtnet_napi_disable(rq);
> > > +		rtnl_unlock();
> > > +
> > >  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > > +
> > > +		rtnl_lock();
> > >  		virtnet_napi_enable(rq);
> > > +		rtnl_unlock();
> > 
> > Looks to me like refill_work is cancelled _sync while holding rtnl_lock
> > from the close path. I think this could deadlock?
> 
> Good catch, thank you!
> 
> It looks like this is also the case in the failure path on
> virtnet_open.
> 
> Jason: do you have any suggestions?
> 
> It looks like in both open and close disable_delayed_refill is
> called first, before the cancel_delayed_work_sync.
> 
> Would something like this solve the problem?
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 76dcd65ec0f2..457115300f05 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
>         bool still_empty;
>         int i;
> 
> +       spin_lock(&vi->refill_lock);
> +       if (!vi->refill_enabled) {
> +               spin_unlock(&vi->refill_lock);
> +               return;
> +       }
> +       spin_unlock(&vi->refill_lock);
> +
>         for (i = 0; i < vi->curr_queue_pairs; i++) {
>                 struct receive_queue *rq = &vi->rq[i];
>

Err, I suppose this also doesn't work because:

CPU0                       CPU1
rtnl_lock                  (before CPU0 calls disable_delayed_refill) 
  virtnet_close            refill_work
                             rtnl_lock()
  cancel_sync <= deadlock

Need to give this a bit more thought.

