Return-Path: <netdev+bounces-190622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D75AB7DA0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7920E7ADE1B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA4296FA8;
	Thu, 15 May 2025 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjiT3WgD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCD296D11
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289679; cv=none; b=esMHoS+DfvtEkiQr7hdZjoBO1p+xWD68E+5UWqmZ+rHsiyJ24V6DRygiPX1yNQzymKQagGkQg6Y1jRIyUiPl5sx+pHpmEMvg9JySDMBc4m2npIf1FemfPxosnPumiLSSkYsZZCxmaE4ywPGODTLI6a0QEJ9cIz7Nf5GLI57attc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289679; c=relaxed/simple;
	bh=GHX8SKnuRhPHg4JVM24oLTd/BzpBHMkfXNZOoDsAupc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4W+km5NAraLQ6zznDtBB2bC/PWDUYGUG5EqIb7hQxwM9k/BeJLEp7nMaeVy1XJ8o/dycGRjEn43xlU8Hm1JCZ5o7oE9ZETW6dDViBcwL+ijXZtzrh+PucYEIrL+6jJUdfVUTUO2lWj8AebmpOHudYI0oFA9MxbwYyg9WNeqIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjiT3WgD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747289676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0+9WuDoVK7seiIekMPOn5cFsp2sTkD5ZfvmbgrYAn0=;
	b=JjiT3WgDVFVylFVRhxTCCWIFpZTWFnNZfOiVQH5cF9SF12jYaCAhgoUO1dE0o6RopSZr1B
	ZzuJTJz5lQrsvYMmfmeI+Canam9WLNPZMeyo7cVH1ArD/wzMstywH/BLIhSVzbnvn0m93M
	IlOjnWZGLp9x1zVDhP0NMezoMRNKCb4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-I-8SPotBOdy1uF46tSeUsw-1; Thu, 15 May 2025 02:14:34 -0400
X-MC-Unique: I-8SPotBOdy1uF46tSeUsw-1
X-Mimecast-MFC-AGG-ID: I-8SPotBOdy1uF46tSeUsw_1747289673
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso2723685e9.3
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 23:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289673; x=1747894473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0+9WuDoVK7seiIekMPOn5cFsp2sTkD5ZfvmbgrYAn0=;
        b=qUuXP2OhdQ/KIwxAj566sNXgM7nFukOhFCKI6ufLNcnUn8lLg3uc7i0IbJdO/X6mEF
         /RZrZSrrQ9xAaejCgHgk2ZDcw1a5+uBSmgQ7U8dphs9TSKIuudIbv0WnJl4RW71HCA5l
         f5T95JZ5ml/RTzNu/70oLTZqHmxt33MxVea7uKnC4KTMpwqDGPGoeOFmGYtSBjvFkqBg
         x0bqqR7KzUmZCtIsDfd37Ymp4ZZlEgHN/ijCacgw5R9fJ+GtD8HBfb7uz2qYrTxACa7H
         RMxuzM1UcmQHLY9YyWID7wSWep6spFp3/iSHmzo3896I4ANXOmVvam2RAfRS03h1Rgc7
         5SRA==
X-Forwarded-Encrypted: i=1; AJvYcCX2sGpRRGN5ZK2c+KHeB3zFV2r1bFZAmyEonS0jUb3tbVnRuxfQAveaBaN9uqqpVJJe7koN4sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYDo/tFTR5FKiKZstLgbLzHX8Dd0qcIPAjUGpAsfDBYGkkv4P
	ncZtxx73sTddcoc4mcWRvBkWsIcjSo64IokbAXXoHrzN51IwrUKGysZ/dO6OIYaIJ3ttQlZ0uA4
	wU3GE5tKg9kGig7UuvlBHhse7xvn+XuNsJclrcXU2X8LKfYILk2jmrA==
X-Gm-Gg: ASbGnctp8/A8brKF13vAxJkygmF4BWull/lJvEYQlcl7srNnwkLj35Ld12rowuxZNKt
	6nGdKFrw+hpxIWioc9PiZHSm2mQizKb3nXGG/Uq44TkNTOi5d+RQCBfjjlJjF3lj3ibXMhK1PfO
	vxPGAFpiaSysB07DRNDK9K0IvyWG78W58PoPECzzV5UbdnWHsDDCayjV75Z6d9BIzlZ+hNvYgZ3
	FfC7elurCIRrqC+QBkQc+EsssGbOutE72HoPwIiZSPOu3LJNOcE6G3GhJk8+AfM6UIqqNJHtfPg
	578asw==
X-Received: by 2002:a05:600c:8289:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-442f96ebbdcmr9334985e9.14.1747289673390;
        Wed, 14 May 2025 23:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3PEe9C8rgBo0TvQnY3+NCOLyFxB24dQVnG16aVk1y3CI+MSZSiHnCWnpwcLn7wNlLIVXpyg==
X-Received: by 2002:a05:600c:8289:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-442f96ebbdcmr9334755e9.14.1747289673051;
        Wed, 14 May 2025 23:14:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e8578sm57255445e9.29.2025.05.14.23.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:14:32 -0700 (PDT)
Date: Thu, 15 May 2025 02:14:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250515021319-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org>
 <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org>
 <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org>
 <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>

On Wed, May 14, 2025 at 10:52:58AM +0800, Jason Wang wrote:
> On Tue, May 13, 2025 at 3:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > On Wed, Apr 30, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > On Tue, Apr 29, 2025 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > > On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > > > > > > is disabled, and any attempt to use it will result in failure.
> > > > > > > > >
> > > > > > > > > I think we need to describe why the default value was chosen to be false.
> > > > > > > > >
> > > > > > > > > What's more, should we document the implications here?
> > > > > > > > >
> > > > > > > > > inherit_owner was set to false: this means "legacy" userspace may
> > > > > > > >
> > > > > > > > I meant "true" actually.
> > > > > > >
> > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > > > > applications need to be modified in order to get the behaviour
> > > > > > > recovered which is an impossible taks.
> > > > > > >
> > > > > > > Any idea on this?
> > > > > > >
> > > > > > > Thanks
> > > >
> > > > So, let's say we had a modparam? Enough for this customer?
> > > > WDYT?
> > >
> > > Just to make sure I understand the proposal.
> > >
> > > Did you mean a module parameter like "inherit_owner_by_default"? I
> > > think it would be fine if we make it false by default.
> > >
> > > Thanks
> >
> > I think we should keep it true by default, changing the default
> > risks regressing what we already fixes.
> 
> I think it's not a regression since it comes since the day vhost is
> introduced. To my understanding the real regression is the user space
> noticeable behaviour changes introduced by vhost thread.
> 
> > The specific customer can
> > flip the modparam and be happy.
> 
> If you stick to the false as default, I'm fine.
> 
> Thanks

That would be yet another behaviour change.
I think one was enough, don't you think?


> >
> > > >
> > > > --
> > > > MST
> > > >
> >


