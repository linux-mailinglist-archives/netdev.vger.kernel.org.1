Return-Path: <netdev+bounces-112124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0993521D
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE2A283AB7
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC11459F6;
	Thu, 18 Jul 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+cSf4/D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E014534B
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330893; cv=none; b=bhAC6DfAqzvlvT/GuNYpUZuqq/teQKQgV7UMepbCsEy4LMenzbdclTL7dvJwh1l+9FMVXbSY7YP5O9M77ftehwZHq6CBTJlU+HlZjqAVXV+Dp6cncPSksh0mDY1A/3JurjDYjzTLcGGoQMBIsy4Nh8+MVc+3c9ZIp8BjCfNFDyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330893; c=relaxed/simple;
	bh=hOXcRf1xMFrEzhzW/LnjACR6jGvf86F5VJttf9LLjy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/jpJsa5B8+s+QnMDa5tRCRjGwEtnTqASGyNYLCilKK3MDGCLasUKpp+fTztI475EWX9FIlr09JKey9rpU/wQ0cseKs/nIT+z3zOY5uxLIUTxGSQyy2ji5ASOfDIuAMo41jtDuXFG8MUb92G6JOOzJKoV3vO5x4HfBJiFr1+7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+cSf4/D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721330890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDZ5M+z92pHpshwG1/cax9lDFRAQ589w+2UZ+nT4yxw=;
	b=D+cSf4/D20/tHWAYFyH4+imEKQ+FI3TMOGSlT0VaAeNZawk17iDVAS0lvciqxKjzE7P4MG
	YGP+yXXFDNswdMxZt2nwVTcWKPSebORbLxpvikYz4X3l3sDxgpITL7UnosPbaF5gWymY0v
	NXA5ZJARUKoHJFDdYYJ76oHc4yff2V0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-SqzaqIOmPcaPQQfGJOGs1A-1; Thu, 18 Jul 2024 15:28:09 -0400
X-MC-Unique: SqzaqIOmPcaPQQfGJOGs1A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a2a0e94a66so230497a12.2
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 12:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721330888; x=1721935688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDZ5M+z92pHpshwG1/cax9lDFRAQ589w+2UZ+nT4yxw=;
        b=mE6/07eeMJ1phjOKmSnwFJUKL/5S3+Wiqr2NfTJ39nrpir0XPFQ70CHFtlz2qm7jxj
         d655wGfL7RqwDfC8KAHyj1B8lsYW3Ol5jR6IfLkYk1WEeslEXUb81oxv4DW1Lem3xA8t
         De4l4HxJn+2TsxqlYPHB5F5IZB0MTTqGnIKyy0gZ7wEtneZ3EzESLvE1z5nsX7wtbXpo
         E8ToJHhWebG0fkbaQiZ+ORPqdmazq35w9a0kztz/jFwxpiqbHo8SKAXiVCIESeQCXCvb
         izGN9DXSiks2WH8i5oIT65ObOLy+watJOogjXY2SJt4eDAv66rxHj4SzwqNCBUV3dypR
         lNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLJR/Bu5eDfZQmnDCEH6JIo78A/+pFJ1m1sauP2qVq+0en8V7HUCNKCfJkBiGQNtYTcoZ7amO813z10OMxVcAZL4qLRrO1
X-Gm-Message-State: AOJu0YyDjnZ3wCJ/KXVbhz0IhnCKMDBvJCncxCu2QOXkkZ53wc85KtCp
	20qxXI0Uu21Pv3JMyTMP0Z5yO0+dKpZBoTyl79VIYf1g7sFJyjNnzWfoXzkGFm1GZAwgMHPjLGO
	3pl3mIsUw35BicNJ/807YVQQbdXXRbouug/0GFYQo3j2A0WY7pKMJGg==
X-Received: by 2002:a17:906:615:b0:a75:3c2d:cd8e with SMTP id a640c23a62f3a-a7a011e5879mr431239266b.27.1721330888276;
        Thu, 18 Jul 2024 12:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNBugtdGfi6vyNKd7H45kvEtMDZ7Q+4JtfeFiuLdziqbae7sxeS5yTAmkCgh9bauEMGzVKwg==
X-Received: by 2002:a17:906:615:b0:a75:3c2d:cd8e with SMTP id a640c23a62f3a-a7a011e5879mr431232966b.27.1721330887696;
        Thu, 18 Jul 2024 12:28:07 -0700 (PDT)
Received: from redhat.com (mob-5-90-112-15.net.vodafone.it. [5.90.112.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368727f29c6sm399103f8f.45.2024.07.18.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:28:06 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:28:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, aha310510@gmail.com, arefev@swemel.ru,
	arseny.krasnov@kaspersky.com, davem@davemloft.net,
	dtatulea@nvidia.com, eperezma@redhat.com, glider@google.com,
	iii@linux.ibm.com, jiri@nvidia.com, jiri@resnulli.us,
	kuba@kernel.org, lingshan.zhu@intel.com, ndabilpuram@marvell.com,
	pgootzen@nvidia.com, pizhenwei@bytedance.com,
	quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com,
	sthotton@marvell.com,
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com,
	yskelg@gmail.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240718152712-mutt-send-email-mst@kernel.org>
References: <20240717053034-mutt-send-email-mst@kernel.org>
 <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>

On Thu, Jul 18, 2024 at 08:52:28AM +0800, Jason Wang wrote:
> On Wed, Jul 17, 2024 at 5:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > This is relatively small.
> > I had to drop a buggy commit in the middle so some hashes
> > changed from what was in linux-next.
> > Deferred admin vq scalability fix to after rc2 as a minor issue was
> > found with it recently, but the infrastructure for it
> > is there now.
> >
> > The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780936b3e:
> >
> >   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> >
> > for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b3163:
> >
> >   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07-17 05:20:58 -0400)
> >
> > ----------------------------------------------------------------
> > virtio: features, fixes, cleanups
> >
> > Several new features here:
> >
> > - Virtio find vqs API has been reworked
> >   (required to fix the scalability issue we have with
> >    adminq, which I hope to merge later in the cycle)
> >
> > - vDPA driver for Marvell OCTEON
> >
> > - virtio fs performance improvement
> >
> > - mlx5 migration speedups
> >
> > Fixes, cleanups all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> It looks like this one is missing?
> 
> https://lore.kernel.org/kvm/20240701033159.18133-1-jasowang@redhat.com/T/
> 
> Thanks

It's not included in the full but it's a bugfix and it's subtel enough
that I decided it's best to merge later, in particular when I'm not on
vacation ;)

-- 
MST


