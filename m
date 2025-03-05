Return-Path: <netdev+bounces-171957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB93A4FA07
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1E83A2579
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC2204F8E;
	Wed,  5 Mar 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG3zW7N5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04493204C35
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166944; cv=none; b=Iq06FY/p5awH2+W/lmZFZqropy4cjB+LtuDKBCgvyX6NMzb/krbVSJM/vDs34pmzzj+xxyR7ZIK0KrNTpY5FaC5/typ//Ud0rg0aQ/TmOSyVj/v6i1c/rw1m9OKxwNVaErOWAjsYXpwxvumIXk29xeD+XusoBx/7qbcbtf5967k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166944; c=relaxed/simple;
	bh=3RyfPyCJa/tpuKGOY4+lgz/0CKbtUzXOOAWxjU4A/sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBU4AVyqBwd5ECQAIvA9NfUzLRo229xAhLvfDPc3qysaybcEWDMEStswO7Wr9tag5wHX3d4g31zXhMt3LPYp+5F3d40n++izF1a/B9oGsNHWQDaT3aYZU4S/4iMedcXDOHyM777jtFYxFEV8Jb1+l+Yalet+mXuu++POQHyal40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iG3zW7N5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741166942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTeYQGmJeU97hLjZUQj6XASwjS9zaIwc0VW0y5NqZ+Y=;
	b=iG3zW7N5VMjN9lIpAEdPKhkfoYfHsWeOwbOxSIVZHRqp/HYRYisLUyfunodkVRhjqN2K+i
	GxWeZaOUXmhLAH+rCNj203JuZ5Uhdws5Fd+bfWHoWHOKaBiiNZdLEqQCrxoVFX88iYVtg4
	hr3BjkdKzfKP8BBjI1AWrnHy/I4/axk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-0AAsvMcnO3C77UrmAHW9Pw-1; Wed, 05 Mar 2025 04:28:55 -0500
X-MC-Unique: 0AAsvMcnO3C77UrmAHW9Pw-1
X-Mimecast-MFC-AGG-ID: 0AAsvMcnO3C77UrmAHW9Pw_1741166934
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39104a3b8e3so2581259f8f.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 01:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166934; x=1741771734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTeYQGmJeU97hLjZUQj6XASwjS9zaIwc0VW0y5NqZ+Y=;
        b=wJalBhF5NjOoaFZa8vHqiwe+xm8CCptwhiRHIIgeNH1SkjKIaiQHsNtIkG6jUX+Kep
         ldo3lMsw7ByVq/XqunFoK8O8hj6w5A9rKFMbDzn9eLmlzAlIaHF/LeLHWWs1haWquE5z
         vuTRmDRcAsOOaYesXPSckEKm81O5Usu5iE37yM73LicfUc2FekrPS1i13hW2SOnuCpCE
         +yWFjbbjjNq2Mtc0ReZUa7thoXK8mJHqbPOr5qWvcW7FGEbhv3U1R61wBu1A21hIXZiQ
         mh5fs6kUs1lSut4J4U8JIEzgiySgw/0S1cY+G2JpFs91z0nQeT+0MMZzCHsnK55gpDzk
         GO6w==
X-Forwarded-Encrypted: i=1; AJvYcCVW8OOxyCSZElJh5fZj/3G3/TOLkmk2aDInWeuiAGe786LA6jHDqf5XP1ehBNOSFPuRFmcxX0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNbFZM5UWxCdqIxshetZNCH8nd3FrW1ab5kOaRJ0c/FuBsjBNL
	eVbkDYsInfWZdV/rsrb8APkH6l/FU0KPFbo3FJx/H9VPFxlFK04ITbgKq/aqnjHMwnPDqwITSbL
	dPFIXb3ZpGEJb6dZRdjZzfyubc92TU50MXbExHa09btRoFJUDo9W8BA==
X-Gm-Gg: ASbGncs+J5jkGHPhqs7EJmtoP2IqQipmeW0xfMt2dWrnkkbD8kUQxG9OYevi1TbhGch
	7v/0/j1Xu2TO0ibIaGma4RC/jJW/YnWaY23FCw6fugKv2kD2o8znE10WjLJgLrZiH4n1EYoM8fg
	OZzktSDsqRLHsqAd2RlTRZvymGkqALilHnyFtlPVGpmSgUOmJYxM7qQex6LXgvgXZUTuOJ5KLtV
	WlZmOWpM4vfq68ip9wpH1uXeFFHbxSh7MtXmw2+2t7dRjtJI2HgOcmDezeQ01UOMqt9RYi3Ip6X
	/U8jsddlQg==
X-Received: by 2002:a5d:64a2:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3911f741aa8mr1774266f8f.24.1741166934467;
        Wed, 05 Mar 2025 01:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqbiZg1q9NO5z1obiHx6s5lNrsAIzRTkNZH2/z7S8MpItFePV0q3Z90uV+qtbX8GSklxWg6Q==
X-Received: by 2002:a5d:64a2:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3911f741aa8mr1774238f8f.24.1741166934111;
        Wed, 05 Mar 2025 01:28:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c5b33sm12002165e9.22.2025.03.05.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:28:53 -0800 (PST)
Date: Wed, 5 Mar 2025 04:28:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <20250305042757-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org>
 <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>

On Wed, Mar 05, 2025 at 10:23:08AM +0100, Stefano Garzarella wrote:
> On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jan 16, 2020 at 06:24:26PM +0100, Stefano Garzarella wrote:
> > > This patch adds a check of the "net" assigned to a socket during
> > > the vsock_find_bound_socket() and vsock_find_connected_socket()
> > > to support network namespace, allowing to share the same address
> > > (cid, port) across different network namespaces.
> > >
> > > This patch adds 'netns' module param to enable this new feature
> > > (disabled by default), because it changes vsock's behavior with
> > > network namespaces and could break existing applications.
> > > G2H transports will use the default network namepsace (init_net).
> > > H2G transports can use different network namespace for different
> > > VMs.
> >
> >
> > I'm not sure I understand the usecase. Can you explain a bit more,
> > please?
> 
> It's been five years, but I'm trying!
> We are tracking this RFE here [1].
> 
> I also add Jakub in the thread with who I discussed last year a possible 
> restart of this effort, he could add more use cases.
> 
> The problem with vsock, host-side, currently is that if you launch a VM 
> with a virtio-vsock device (using vhost) inside a container (e.g., 
> Kata), so inside a network namespace, it is reachable from any other 
> container, whereas they would like some isolation. Also the CID is 
> shared among all, while they would like to reuse the same CID in 
> different namespaces.
> 
> This has been partially solved with vhost-user-vsock, but it is 
> inconvenient to use sometimes because of the hybrid-vsock problem 
> (host-side vsock is remapped to AF_UNIX).
> 
> Something from the cover letter of the series [2]:
> 
>   As we partially discussed in the multi-transport proposal, it could
>   be nice to support network namespace in vsock to reach the following
>   goals:
>   - isolate host applications from guest applications using the same ports
>     with CID_ANY
>   - assign the same CID of VMs running in different network namespaces
>   - partition VMs between VMMs or at finer granularity
> 
> Thanks,
> Stefano
> 
> [1] https://gitlab.com/vsock/vsock/-/issues/2
> [2] https://lore.kernel.org/virtualization/20200116172428.311437-1-sgarzare@redhat.com/


Ok so, host side. I get it. And the problem with your patches is that
they affect the guest side. Fix that, basically.

-- 
MST


