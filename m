Return-Path: <netdev+bounces-194666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 576DFACBC52
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD407A7260
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554486334;
	Mon,  2 Jun 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DkXBYGaF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E354763
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896353; cv=none; b=MVTFleR/1ZlDW7vr1OF8d7a81ffSxZbCTdGTwvRHTrQKxJt9DJlB02xVu+K5S76TG+HIZlllko1RMu+MQVsKW1jV0ylMuAZK2vZJvoPXFoXse/ff6sSWrC3c/TFzpBwyUKcNs6kdI42qTyStC5P6epUI0IEwJWg1S4Ow2rc6SMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896353; c=relaxed/simple;
	bh=8YiIX5ztUCFTVRGP5ikeIXl0ygdPG4cKdB4yaiFbsu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCdJwk4PanER8C+gAy4KSWLulBhRrsgC29N1Pql8Z+KST7IElaW5ZTggDbr75LVb/SLkk4xLbfy0tviurfcXpAMeREliU+9mMZDdOaB+B5Su2iZ52OQDUaBkY2RBqm0P6ro/4pf3raWaHR3GG60nPp7vhVe9wN1WnhFmxW8sH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DkXBYGaF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso5596469b3a.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748896351; x=1749501151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKY0xpRlWescwikOdDS95zv4h4U6S+cJGZjjK2bypvc=;
        b=DkXBYGaFgDWDDERQCtv9kg0VfeZoKjiSTnGW0XZOJdOcfz4vo+nuVujZmgMlgF06k/
         3N86PcioIC3bH+rQYW4eWMTpQNzdIkeBk8Txu1U7DJurEp4jBT0E+8NCspW+TbFEh356
         Ssdu740CiS9gK8Ieuw0Z7weKwoQXVMoIJPDfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748896351; x=1749501151;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKY0xpRlWescwikOdDS95zv4h4U6S+cJGZjjK2bypvc=;
        b=IASV9zpGTdm4Y1FT5EJ+NOeQQm0lqN5PQGuUKruRsmrhPM48DYFZcofta5R8uMoUai
         OIshMIoDFPDJ5bv1bS2N5RpeR/W2rVg05NPNSgabzhnAL3zHSC+MPz9CwPT2vhZMFSVq
         02tuaIxplzamJsEKU1pZVilBfsAnXcpNH3oKKf1GcsvRqevNy27U5tZv+OXgKEn1QGtL
         CPdCvK79IkmLrSfn1pVCRur2eAblTNgKpSaXZKdw/dL1GvLxUoVLa61OkMNh/EXpAQlJ
         x96///JKvHQZwxAJkA/kM4ZGe1vukaAfTTm6iUYK4LO03AdYRwQHBX0azRg+KqqhLZ/g
         Wskw==
X-Forwarded-Encrypted: i=1; AJvYcCXTJICiVWWkWSQCQQhVnRqK42s+B3s/iaLvDdLL4ZYvIeLECxzxpBUA3q1jXTl2otjhwQEp6vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZS6lcb6rEe/QwvcezJ8RdB7ShzyJ73/3CJz5UbMj7QCERtGK
	DqN4cddz9q3LNliXdfLlIWaPmE3YeeyHFpJKSdIotsQGkVPUtTwOq+qCQM7W+Gj0AyY=
X-Gm-Gg: ASbGnctUBi9cH1G1s1UHNx42pNcFruuy+Mf8IfxXj/CMNFJpfs8FZanWKWi/zKsLasr
	ssTSHkcLnxPcxMaDjXnHY48IoC7JPigsOfveiH81oGViylw1ELq21uDD5n+ky6ktak+4JrOTLgV
	vHznsVVxTUlP4R0TcviB+2f0EdMTRIbTW4FeuxAPsM70GF5w7JPCU9yzxy0sEFSAWSpt/M1R2pp
	x4D2RjKdJSQ1hq9sV34QXYx03XRiY1dnXCFbXEX6FgtnQ54Ng2RswEyNHVVzFm0ZGGQVnR2zfUQ
	jsNU9InCe147tZxVigOvV6miJpBt+flvU06SsfbWnk1bhi7HXOb9YVraRZnUzKGVyx6QQXi5J0J
	tIH+9EOOFXqPzoe6kcA==
X-Google-Smtp-Source: AGHT+IGneH3ZjE1X55YkvRRC0w/esHFCwi1QDRyB+2Z4QhUh5mHCAaiOucMZE/mRoa8hbPYbxu9YFw==
X-Received: by 2002:a05:6a00:847:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-747bd969f9cmr16919224b3a.6.1748896351553;
        Mon, 02 Jun 2025 13:32:31 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affcfa0csm8279352b3a.131.2025.06.02.13.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 13:32:31 -0700 (PDT)
Date: Mon, 2 Jun 2025 13:32:28 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	john.cs.hey@gmail.com, jacob.e.keller@intel.com,
	syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] e1000: Move cancel_work_sync to avoid deadlock
Message-ID: <aD4KXAj0ZlZ5b42f@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	john.cs.hey@gmail.com, jacob.e.keller@intel.com,
	syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250530014949.215112-1-jdamato@fastly.com>
 <aDnJsSb-DNBJPNUM@mini-arch>
 <aDoKyVE7_hVENi4O@LQ3V64L9R2>
 <20250530183140.6cfad3ae@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530183140.6cfad3ae@kernel.org>

On Fri, May 30, 2025 at 06:31:40PM -0700, Jakub Kicinski wrote:
> On Fri, 30 May 2025 12:45:13 -0700 Joe Damato wrote:
> > > nit: as Jakub mentioned in another thread, it seems more about the
> > > flush_work waiting for the reset_task to complete rather than
> > > wq mutexes (which are fake)?  
> > 
> > Hm, I probably misunderstood something. Also, not sure what you
> > meant by the wq mutexes being fake?
> > 
> > My understanding (which is prob wrong) from the syzbot and user
> > report was that the order of wq mutex and rtnl are inverted in the
> > two paths, which can cause a deadlock if both paths run.
> 
> Take a look at touch_work_lockdep_map(), theres nosaj thing as wq mutex.
> It's just a lockdep "annotation" that helps lockdep connect the dots
> between waiting thread and the work item, not a real mutex. So the
> commit msg may be better phrased like this (modulo the lines in front):
> 
>    CPU 0:
>   , - RTNL is held
>  /  - e1000_close
>  |  - e1000_down
>  +- - cancel_work_sync (cancel / wait for e1000_reset_task())
>  |
>  | CPU 1:
>  |  - process_one_work
>   \ - e1000_reset_task
>    `- take RTNL 

OK, I'll resubmit shortly with the following commit message:

    e1000: Move cancel_work_sync to avoid deadlock

    Previously, e1000_down called cancel_work_sync for the e1000 reset task
    (via e1000_down_and_stop), which takes RTNL.

    As reported by users and syzbot, a deadlock is possible in the following
    scenario:

    CPU 0:
      - RTNL is held
      - e1000_close
      - e1000_down
      - cancel_work_sync (cancel / wait for e1000_reset_task())

    CPU 1:
      - process_one_work
      - e1000_reset_task
      - take RTNL

    To remedy this, avoid calling cancel_work_sync from e1000_down
    (e1000_reset_task does nothing if the device is down anyway). Instead,
    call cancel_work_sync for e1000_reset_task when the device is being
    removed.

