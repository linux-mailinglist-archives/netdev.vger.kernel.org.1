Return-Path: <netdev+bounces-189991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8CFAB4C7A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA18169BAA
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3031EF397;
	Tue, 13 May 2025 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVULcS66"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C31EB5EB
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120166; cv=none; b=r89VUrEj6Vm6KCG6PJ1dnwwM/sr3FPbZKQVUdBXI6Ogucj2EHq2RE0W6XEyuOQPC2j4169cQ9ez5UVbwVB3DONv/NCWd7jHs5+MDAnS2HpjfqD/m0rVWR03dluKbr7mO3vhYepX+ZSipLWlMomH3Zk7Ftussp6qkTf1tnBnxKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120166; c=relaxed/simple;
	bh=twHcmA7LUXTu4ZuLwMdsdfHh+CfPFxHnUVLG+BwD4io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOtqhV50kgk7sipxM16oto16CEHitXD5VSJuLdDvSn8DqIWGmAMuJdPXutliyBbaKU6QVPjTJyUufOJXzv+7eAau5A4eWu7OlEVO+na2wuseJj2kuXJZTJP+QxQqGPWhT8Qz5srdis+Ey70HxeCkYeWaMSrsWL69JQnl6U7RnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVULcS66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747120162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ictuYZNb6FVZjqSx9xqiqhjaQBRlicpN74huBXSGg4Q=;
	b=gVULcS66vx14dyQOM/SV6OV6DU0pPELz5jA7iGpSWgA+JrO9dXkmVwQj/XMY5aGa5vaIIW
	MZ3jkV0VaVjyb8Ej5WG5du6qhqHfCkt0J57zzWwLQLDxFOlbADdVj5h0DhDhEodXd9qPb+
	Bry3OIqtCYrDHC7HZvWy0/eybx5pWgI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-3I_QEOZEPyaJGMafKbVrSg-1; Tue, 13 May 2025 03:09:21 -0400
X-MC-Unique: 3I_QEOZEPyaJGMafKbVrSg-1
X-Mimecast-MFC-AGG-ID: 3I_QEOZEPyaJGMafKbVrSg_1747120161
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7caef20a527so1448771485a.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747120160; x=1747724960;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ictuYZNb6FVZjqSx9xqiqhjaQBRlicpN74huBXSGg4Q=;
        b=FSkIb44VRl09aOzyfQ62fPWEGskgJrOFOiCF76ha3j3bbmJGVwWEc8ByoajkFHkapg
         6F2mn23T0GSaJ8+lCGuJxiesE/Qx7ylJaKTRfoSEiathSUMWv4XYGoPJMPmKJQ435wde
         yvyu0alV4o99ruM3F5tmYf39nYdKhHOdoWL9h0GmkY92+lFC01m1ijcM4xkDps2vXvRG
         NXDTnff/hL6pHn3IO0J/OzinLbC6SkTHvuc73InzT10Ol7+hUdvKphl8/4xWnODnjZrB
         MdLxDGhKEPR1F05MAXMwHFm3p+y7DrmgOC11k1qur3MM6kIx5iH35OyFbsrQap9exao3
         qqog==
X-Forwarded-Encrypted: i=1; AJvYcCUR+MbivdcblbChS10/EeDaAK+qmf36oZ5b7IA3hFes09Fbx8zR2NXSdD9rnsGwIXPWsDaMwLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqtwRCdDQE7J6lstKV0laIuuUIKmRVgsMhHYTGcaCGjFy4t6R
	PnvVPCCt6s6hSNvauDvtx4IZS73gZG069G34JVDKHXJixuQDKCVD4jJQuulbIN4/NagRnGfxpUn
	YlbhI6WqbU88wvQz2/WOhdp66yqFfp7e7/gjMnRX0rU6am90BZk59yV9bM1vrPQ==
X-Gm-Gg: ASbGncvPWyyyA8X2FJtdWpJjOt93fFyVuCwUZpWAzfRjQcf0xHBWZQHs61whEJ5N7fF
	ws0SUJMtpM/M1FqOrS12LRVczlEhOpfNRy+QCFzULagCKIa3S9bPA/DHzM3zFO9EpHtisKpwoNB
	Rn1Niy8gkTM6krsZ28WFx14tkIP1Zb2ZaxKZUCRgVGIFSOxk5NWiv2hMQHyzK6qMwEhzMXWAtU7
	N++mjMcRLj7XQOK2WHavv674a7U6EiiG5IkhMt/id9fPECShd8x/79pTcbcxwjP/AOhGGwnX2Q=
X-Received: by 2002:ad4:5aa5:0:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6f6e47c75camr261567556d6.25.1747120149184;
        Tue, 13 May 2025 00:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHE6qp6nrOSTcG+29z71S/WIjLeU7OplRtOWMeb0fjKhF4V91wQ9LbTTAnYfdMSFrrXtZqgw==
X-Received: by 2002:a05:622a:2290:b0:494:7835:1013 with SMTP id d75a77b69052e-49478351232mr90416531cf.36.1747120132570;
        Tue, 13 May 2025 00:08:52 -0700 (PDT)
Received: from redhat.com ([5.28.174.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49458d378b7sm56066541cf.14.2025.05.13.00.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:08:51 -0700 (PDT)
Date: Tue, 13 May 2025 03:08:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250513030744-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org>
 <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org>
 <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>

On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> On Wed, Apr 30, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > On Tue, Apr 29, 2025 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > > > > is disabled, and any attempt to use it will result in failure.
> > > > > > >
> > > > > > > I think we need to describe why the default value was chosen to be false.
> > > > > > >
> > > > > > > What's more, should we document the implications here?
> > > > > > >
> > > > > > > inherit_owner was set to false: this means "legacy" userspace may
> > > > > >
> > > > > > I meant "true" actually.
> > > > >
> > > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > > applications need to be modified in order to get the behaviour
> > > > > recovered which is an impossible taks.
> > > > >
> > > > > Any idea on this?
> > > > >
> > > > > Thanks
> >
> > So, let's say we had a modparam? Enough for this customer?
> > WDYT?
> 
> Just to make sure I understand the proposal.
> 
> Did you mean a module parameter like "inherit_owner_by_default"? I
> think it would be fine if we make it false by default.
> 
> Thanks

I think we should keep it true by default, changing the default
risks regressing what we already fixes. The specific customer can
flip the modparam and be happy.

> >
> > --
> > MST
> >


