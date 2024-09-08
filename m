Return-Path: <netdev+bounces-126305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429797098B
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 21:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F610B22312
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006E1741E0;
	Sun,  8 Sep 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfAPEEMO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559082206E
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725824339; cv=none; b=YVsPAUwxGCmyOUaCmjpRnjUaVkSWsk0zvhI2YlqodXvfl1XeDkN8bJpLy1Rppxc7zMWzVTk4XjEpyz4As4nM+zA58RdWfsd0EbPeoXwavMnwEqPUuRvT++Li6oJeprIoCJbpg53+V5pDNIFzPIw9c9dqoV7YgkAVlxURxjMMVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725824339; c=relaxed/simple;
	bh=b78tAKcRS4epmgnAYIwAGMxqn2q0gumpr1tdaNU5Pvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyMdX0ad+rFge/ck4YM4q5VAPH02Ntn58WFUQ1MpgVyGAxfXJhzIb47RTttGaYU6agedqewhp8c193PVBEUI52sXjjilQQjVIeCCxNJt2P7SVbdb+jYuIDimwzxtCORUKjjK860Q/BVwURyw64OuuQAB3ZsZ42OJRVCIoJlzOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfAPEEMO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725824336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib4Cg1mwnO6N/iUumzqg1slbWobcDxhzCttJjbOrRIo=;
	b=MfAPEEMOZ5QoRM0SRK5nxhKn+ZMPaVTF0WIh9PJr3uMXQBkeo7xzz1xiRbQ2/WswV/fDci
	KAJ8Smtl5GH4oiw7g0GBvPW/FxT8Fs43z4nTNbJXd9tMX7BZBMlnlHC8W+u9LPYBNvJIeG
	pk6BCDihvrLPqwrBigVlQevVePRKA/g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-wLTx0ErVOYigcRbch7zxOA-1; Sun, 08 Sep 2024 15:38:55 -0400
X-MC-Unique: wLTx0ErVOYigcRbch7zxOA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c581ce35so1837260f8f.3
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 12:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725824334; x=1726429134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib4Cg1mwnO6N/iUumzqg1slbWobcDxhzCttJjbOrRIo=;
        b=RcDRtVHlHcYotlN6BmZgITw2dtly2kpiOdodcSxhWaZjtD7CsFE+0GvRpSy/70FK0Z
         uK5GDZsE8bpFNoSKAMUwvsgvc4VqoKJohuTfaMvHlMSzvP2NiFDhSnUb0FsFyK7AOgwJ
         L2ZnqmgMsUJJr3pTCIe2WC4hH5iqUmJCOo5zIGONLVlmDnZOcYYh7HJJx+3c4cNJQ/3w
         Lb8EAMMlfDFxTXo+T3nwjb0W3xlZP9FatMMm0j7DVIigynxu6WbyToklu/Subo4GswGg
         Tx+0dxagNRAsqjTtykngV7snVj9ICyc6AqrI2387oH++JURFKE9s7V9oHpkEX4iMecco
         k/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXnVQWnWKTwFKozIJeoue9vofZRekordGIy4MgMxkTEweQxOTSxWLoLkyzCyI34Px0EqEMxxRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8DPL2UlRcEl20XQ2iKzF5ZlpYEac91FWPwMaNEKeZGQ4KiHm8
	q/du6VRk5kSfXsKOaTfCviPzxqH+P8bwGm3BwY94ZdcpeMgNUk8KB1icj1dof3q6ZbJ/v43F/Fa
	KfgK8iRySchg7x8J5qO40MeKrgvmcmfD63J2BRZE19X0QL9QTVhKBoA==
X-Received: by 2002:a05:6000:18cd:b0:368:68d3:32b5 with SMTP id ffacd0b85a97d-378895ca930mr5169709f8f.13.1725824334260;
        Sun, 08 Sep 2024 12:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYoGWEjuYnS32HktLwjz8Iy78rl7gj33gQqlWLnq5lNTQ++a1rzU1N3LGu/UZ9Tp8g8Ri5mA==
X-Received: by 2002:a05:6000:18cd:b0:368:68d3:32b5 with SMTP id ffacd0b85a97d-378895ca930mr5169695f8f.13.1725824333389;
        Sun, 08 Sep 2024 12:38:53 -0700 (PDT)
Received: from redhat.com ([31.187.78.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a1a0sm4057332f8f.23.2024.09.08.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:38:52 -0700 (PDT)
Date: Sun, 8 Sep 2024 15:38:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240908153712-mutt-send-email-mst@kernel.org>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>

On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> 
> I still think that the patch can fix the problem, I hope Darren can re-test it
> or give me more info.
> 
>     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> If that can not work or Darren can not reply in time, Michael you can try this
> patch set.


Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Takero Funaki <flintglass@gmail.com>


> Thanks.
> 
> Xuan Zhuo (3):
>   Revert "virtio_net: rx remove premapped failover code"
>   Revert "virtio_net: big mode skip the unmap check"
>   virtio_net: disable premapped mode by default
> 
>  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 49 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f
> 


