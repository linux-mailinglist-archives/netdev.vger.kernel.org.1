Return-Path: <netdev+bounces-207699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02384B084E6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48918564737
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE31E2312;
	Thu, 17 Jul 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1pPHusI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DEA79C0
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733873; cv=none; b=DLAQ75RCP6AMJKCLP82lJeHYG5Y14hRgg2URn+fSfNzszz2/i+xKgHuEy//mca2D5lJ4iE31/4RraKK6SGehuimMdQY485uQN2zqi8+QPKRYNtutdrCA3AvJmQ/RLZYaTyyMOCIBoOzW8nBUAODtlzCn2XiwVFQpQ6frFEoCd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733873; c=relaxed/simple;
	bh=nGt6mjY502NYQJQNLQHOqJ0cX0q0+Ew5UUFrSaN7eOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syZhMg5XTjrGWMIFWQiZn+OqkeF+3Qg9sssXyYD827gkgeOzqeao+EVzM9Y5CasSWVCMbALacMsC5eJez2O7St2LDDaDSwbkjE7iow7aryNDyOY4SHDuEjgra1ArDfcAYzYEe069H8YEOTu8bqqFJpMiX7jdug5mDTIOL9P4Q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1pPHusI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752733871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvK5vwyLkiwd45XXL+NYQb7X8wlfzvJMgGcpvl9Wm5M=;
	b=S1pPHusIkIPXMBHA9XGAuP/VSQsXuEfuUNLzc8uFrIOBjoC/sSBDuR/OeRe//flv2sq3yW
	YSqY+471IFOM5Tl/Dr5PCPVVuvB8BX/kkzjt9l/qrmNZp0lD+rXzmJ36aONrOXjcuJmcZ5
	6EOSliMGybOwho70twKyirwK7DZI2Bc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-Fa-Nho7kODmJ70v6vn8LwQ-1; Thu, 17 Jul 2025 02:31:09 -0400
X-MC-Unique: Fa-Nho7kODmJ70v6vn8LwQ-1
X-Mimecast-MFC-AGG-ID: Fa-Nho7kODmJ70v6vn8LwQ_1752733869
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4538f375e86so5599265e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 23:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752733868; x=1753338668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvK5vwyLkiwd45XXL+NYQb7X8wlfzvJMgGcpvl9Wm5M=;
        b=XahVRuL81TmiZSmlS0D7qmkBqB3INE/wkfrmixf7OYA5bCfwhToP0MmTgQoXyD330D
         8SD+gLzZtMwu3RdhSJU4zLU5lHMPL/qY4eBTSJdzBdSV31Gz9fdmsjAq7esX35KyTQEK
         768X7s1Tq3xDxTM2oD9/OAwQ6zRsn4lECkPKhT75/o2AEmhiLJBcUXF/sULYpR/XkwDc
         39YnwG9DIROxLdbsK6AVW8FRoedubjj9pzCEUmoo1Zo4GLXF0Eusdsc3UyvcwEZgu3PA
         ziny43Jxhkiotm5Xaw24JafXLze92wirHIt77fr5du3co6z7Gm0MSqW7SWE6g8nKp2RH
         XAig==
X-Forwarded-Encrypted: i=1; AJvYcCU3Idhl5L0McFDWifYiKaD9VGRWtcuiU8izWfFu2OrhpaImB2KNPZ835MbaP0+6BrVHQSr4Iyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy029S+S6VK8uko6a4K5eYzydE/9MJj7qVTcMCPwHmNF8qeGbX
	nIKOXjrMaTKLtD63vCkXfyqczCMXo80UoxGEdpa0SArc8JaEuYWQzxHh5oidZM3YY1tOFg+MVXw
	n1n9XZZ9wUlFVWHEouw2DckdejZb4S9FZyCr2hL6DUWONzUue5ywZDBwk5Q==
X-Gm-Gg: ASbGnctIMYNeVOgYe5eej9KViDhw/fd6AlkZKKCCtLa/kgYcmlRc3u+QqCotCmIQ2Ib
	fH0k8I8v4LwE8ta10mbOtDbjwUadxcEs5xmX5c370shr0QSNA4JcxT1tbkgdHm3lswjOCvhntzz
	3hasft4AWYR9CVR23z4eM3GSydb1MAJAfUBSyCK2NLhno9K34nXtmlLGJjMB7sKBF/mGAoqyF2C
	b0ieDbQeac4769E7PyjN1S9mFv/uIAweAOLGBw/SDfkwgkaPkj+Jm4LWlnHPXWRhwZugCVytMoB
	oM6xVEIACzEK9vJvu7gjf9UFbK5pO6FD
X-Received: by 2002:a05:6000:4a06:b0:3b3:a6b2:9cd3 with SMTP id ffacd0b85a97d-3b60dd827a9mr5402533f8f.48.1752733868541;
        Wed, 16 Jul 2025 23:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENDhNrlMdoGwMnp3S2sOg05qA/z2rX+K2yXyqiJ23p15NQvqO+DN/Tziiqc7jgSgj6yaxfLA==
X-Received: by 2002:a05:6000:4a06:b0:3b3:a6b2:9cd3 with SMTP id ffacd0b85a97d-3b60dd827a9mr5402502f8f.48.1752733868012;
        Wed, 16 Jul 2025 23:31:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a62sm19679812f8f.40.2025.07.16.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:31:07 -0700 (PDT)
Date: Thu, 17 Jul 2025 02:31:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
Message-ID: <20250717020749-mutt-send-email-mst@kernel.org>
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>

On Thu, Jul 17, 2025 at 02:01:06PM +0800, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> > > On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> > > > > This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> > > > > feature is designed to improve the performance of the virtio ring by
> > > > > optimizing descriptor processing.
> > > > >
> > > > > Benchmarks show a notable improvement. Please see patch 3 for details.
> > > >
> > > > You tagged these as net-next but just to be clear -- these don't apply
> > > > for us in the current form.
> > > >
> > >
> > > Will rebase and send a new version.
> > >
> > > Thanks
> >
> > Indeed these look as if they are for my tree (so I put them in
> > linux-next, without noticing the tag).
> 
> I think that's also fine.
> 
> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
> 
> (Note that the reason for the conflict is because net-next gets UDP
> GSO feature merged).

Whatever is easier really. Generally I do core vhost but if there is a
conflict we can do net-next.

> >
> > But I also guess guest bits should be merged in the same cycle
> > as host bits, less confusion.
> 
> Work for me, I will post guest bits.
> 
> Thanks
> 
> >
> > --
> > MST
> >


