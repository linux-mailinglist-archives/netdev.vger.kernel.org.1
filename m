Return-Path: <netdev+bounces-106788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774DE917A25
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06692B242D5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A515D5CF;
	Wed, 26 Jun 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvzm7Lwn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458115B0FC
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388378; cv=none; b=YYl/RfC8sg3NZEWfCT2VoGn7klQxqHjPyjEKpN5qatebum97jJ92H54WPZU1mv8YZxCDyLBTxwl7HkHDpRPlsFet4NNundKDa1BRsnyTjq+dRapNq9OFkSypXBbT1WET6fZ8K1MDl7CF5ZkCghak8NrgmFt+Vk/yTxg8HfxW3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388378; c=relaxed/simple;
	bh=U4wu/v4LXIMjJbnXQEUS5N/tOZwUCIwjd6RBuDr2u2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EweiZOTuB6NFMc13bXe3FJDNXQS/U5JOlsWQQmkcg2mHYNIWJ/eaqLRM+Q/+zOCzxTQhSj/eftXrnhrfVlrK6hwDgcYEBPTAm+46cgm2iDhzZ0rlELK7COXANMv39p/1uumQH5tDBaaENVwQDIbzXOcLFE655iNeWtIjO/U7/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pvzm7Lwn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719388376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbhQ5Bt84GkBvdJqLycJ8eMJD8s7TH9FNQOxnZ/P/54=;
	b=Pvzm7Lwnn57sz5WhuOWc8ZvDMgyS7oZONATyjVVQ+QX/fAxdu6PZtcZwcKIcYdI0ehhQc3
	Ex5mID9ianracnqLA+gp2SKbRDwkwXJ1HwI5qEbjRcw2b6w+M0ObZikSScYY4OGLvF6lWk
	Xn/7TC1twZHjROpHTcABYZarYRuwWPA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-B24ZrEYXPA68gRl754e_hA-1; Wed, 26 Jun 2024 03:52:54 -0400
X-MC-Unique: B24ZrEYXPA68gRl754e_hA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec5f22cbedso23862281fa.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388373; x=1719993173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbhQ5Bt84GkBvdJqLycJ8eMJD8s7TH9FNQOxnZ/P/54=;
        b=lGGLlsg4d0WuOyqKBPTIW+ioC7I9DK+pFeJBR5/IfuocFoiyaJNugAJ0POU2e3MCEZ
         +8PgrXIX/VvTIS/Pxv0GXL0eSkpnf5xbObiD4qTmEqb+Kqcyd4K1pr6xTfBbJUXdUJxX
         dvUic3WEF33SWpdhsr2mkYinl7o8YDf/bDz8r9xemyT4xpn/TLbE5wuXoDEABeF5PWXb
         nwLIxaRi7GB5e9jwtuehtrdHReqcYA3tAcz/e8S66qaUyjNobTsyX2nStFwTd/8kBLq3
         mENaGjLAiu2DZWHlJ0yI21MlsB5w7RbmeC4E3dZQeAlGVkiyGMCEu/daKn38MdLcUUNX
         QjBw==
X-Forwarded-Encrypted: i=1; AJvYcCXkbPXt5YK/V85OAQF/nz14AE0la7hMmwQsxi3NDbcO4xyzTUo1syYJYdwhmam/DQw60xBwXUPt1/r+1scJcqqXgC13f9KE
X-Gm-Message-State: AOJu0YyI1WB57ftwtZTU+ApAwBiIuVq9u4cnXly9Koxj1zETB2RRVo9i
	wsqH+HTRhIKu8i5uOJDb/Ztlbs6xpIHMJdSG3CRc2tkirWtffirC3u2bq4uo3wkpXuuKwFRhPmt
	hXU+0ypNVLxOFbqsBZ2wF4kk0eU1EJR8jL3QHdg/rz3KPPUu641t+P6Zr/y6uWpOD
X-Received: by 2002:a05:6512:1154:b0:52c:9942:b008 with SMTP id 2adb3069b0e04-52ce18325femr8818742e87.2.1719388372849;
        Wed, 26 Jun 2024 00:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBePmSX2xltrQ1Gn2n2dv1Ce9/shcHte7tpXYQEQJvsTYn/f4RpL4bX2GtXjheFQQMtpVfVw==
X-Received: by 2002:a05:6512:1154:b0:52c:9942:b008 with SMTP id 2adb3069b0e04-52ce18325femr8818718e87.2.1719388372008;
        Wed, 26 Jun 2024 00:52:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c838099esm15062065e9.40.2024.06.26.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:52:51 -0700 (PDT)
Date: Wed, 26 Jun 2024 03:52:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240626035132-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
 <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org>
 <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
 <20240625043206-mutt-send-email-mst@kernel.org>
 <CACGkMEvO+hAd-JeM-LEAavZqogEhSBPQRhSQK6hPMaVyEHH7jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvO+hAd-JeM-LEAavZqogEhSBPQRhSQK6hPMaVyEHH7jQ@mail.gmail.com>

On Wed, Jun 26, 2024 at 09:58:32AM +0800, Jason Wang wrote:
> On Tue, Jun 25, 2024 at 4:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 04:11:05PM +0800, Jason Wang wrote:
> > > On Tue, Jun 25, 2024 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > > > > Workqueue is used to serialize those so we won't lose any change.
> > > >
> > > > So we don't need to re-read then?
> > > >
> > >
> > > We might have to re-read but I don't get why it is a problem for us.
> > >
> > > Thanks
> >
> > I don't think each ethtool command should force a full config read,
> > is what I mean. Only do it if really needed.
> 
> We don't, as we will check config_pending there.
> 
> Thanks

And config_pending set from an interrupt? That's fine.
But it's not what this patch does, right?

> >
> > --
> > MST
> >


