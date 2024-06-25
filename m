Return-Path: <netdev+bounces-106364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52A8915FC7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3E280DD8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78938146A99;
	Tue, 25 Jun 2024 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ev2rrk9s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03F146D41
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299685; cv=none; b=U3BzibO9WqS1dRwuME8hnoGmqhJC9JO6id/u1yOvMZNn4tIbr73teP/4kJj2BNFKaos5sePTx7FV/Spdb1BnzyPuITUJV25QQAUWPUlt6BvAgLJlLlarQNqhhQqPZ4vRx8Byr1GjLG3+7FN1mcoASf8nBeJ9yejTJnAbEbjpzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299685; c=relaxed/simple;
	bh=MWlI6gqiKW7AFxrW0jW8foQWqr6Sk9txhhHrr4oyi4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEPJ6QWGio/q5mMqcDWdz7Es7x+0Jire8C2QQjpcYVAQLbO6WxmEnxcehVYVl4kp1CjlqSUC/I2iZ2YESFslbOknmqBEpHzaXcm5uNchfGfkngX9fiOgi7I3VKC6hqIgqEFR8QJT6eyWP9fzualdA0mFdtndCarluuG4qh/q5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ev2rrk9s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719299682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LebRXIKKc2SwfP9sV4lCluk07RoQVB0AjJsteCADcZk=;
	b=ev2rrk9sfh2Vd1Z56ha60EjKNKhmM8/SBTTQdU5z70Q69iJEu4gaUx3hJ9FNfp36cEvMDm
	zUngHVU5T+xekiJ1vPayOTzaTTHpSimUA4SHGnG1rXwZbtJD2Zq+zuXLPCo8PKt0FNbuGG
	Aw1olMx+DsAiGAzDX3z3QDdWeFf0Q+g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-42sdXHtaMnW7Ksa2UevioA-1; Tue, 25 Jun 2024 03:14:40 -0400
X-MC-Unique: 42sdXHtaMnW7Ksa2UevioA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-363e84940b2so2213097f8f.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299679; x=1719904479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LebRXIKKc2SwfP9sV4lCluk07RoQVB0AjJsteCADcZk=;
        b=v1R7kkKXnN3q5w1aeTjlieUAm2KIrn0QKB6GPdL1+fCfkcpPRfYdmgvKp/0ewkMbfn
         rr51BApZLoL+tEDZvvAXn+CTT0goY2q5x+hGR4JGPPOaK0ZZDi3yzwXDP1wbdgGjZ2hw
         SySlcXuS4ZuWS9DzQTuj9kiwyGXJf/4ViFOBy4TKGZDpC+kyUp9KagHacmyHrfVSRj+w
         dOvb2gxzULT/zqIcr6/95WOCnMuf7T0Dj0jCw4dDbQSvacvNgQ4RzESdwvctNIsPNMbJ
         rme8uakEgXN1Z+TyIOGYoDDlUw8KrdZY9TphlEtAAFqiFB01f9AceIndaQr7kk3Reb/q
         I1EA==
X-Forwarded-Encrypted: i=1; AJvYcCV/GxefMv11SjyD5y64U0Z1FObaOPIY1MVGD/4RToSCKd62VLqpKxUla7mntjqTuhw35AwVS+tME1NMOO+bXHfeEvKxu2wb
X-Gm-Message-State: AOJu0YzQXnzKS3f0d4GZO4bs3F2KCRuBwnEx28aJjDzl5DYBMbwtCyus
	vhFHaHwq/rIAfSCZK30Upo/lf1P/NntiN8QbgBtYPVqfB6BQd2GgS66TqnBQ3D43vSqKqlIuwPX
	a+aDnSRfuXXBDbdh6Jj0Q2xIemvACjgwXlK3oUIAdfxnI8B5KXcEopw8DFxIQhA==
X-Received: by 2002:adf:fa8e:0:b0:362:8749:9639 with SMTP id ffacd0b85a97d-366e7a373f4mr4713217f8f.35.1719299679069;
        Tue, 25 Jun 2024 00:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+RQabaVT0BHWxAQBLc5MihkozylBrOdUtM3UiHMV0ATZoGWoxlVaHU25AglTEOaxNsvlKQw==
X-Received: by 2002:adf:fa8e:0:b0:362:8749:9639 with SMTP id ffacd0b85a97d-366e7a373f4mr4713186f8f.35.1719299678279;
        Tue, 25 Jun 2024 00:14:38 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b861bsm11976184f8f.29.2024.06.25.00.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:14:37 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:14:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240625031153-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <CACGkMEtacpgHvD7GLysXWm7_CybhgyJYx=AMAX+jk6+G4wqW8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtacpgHvD7GLysXWm7_CybhgyJYx=AMAX+jk6+G4wqW8Q@mail.gmail.com>

On Tue, Jun 25, 2024 at 09:27:24AM +0800, Jason Wang wrote:
> On Thu, Jun 20, 2024 at 6:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> > > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > > > > > >
> > > > > > > > >     /* Parameters for control virtqueue, if any */
> > > > > > > > >     if (vi->has_cvq) {
> > > > > > > > > -           callbacks[total_vqs - 1] = NULL;
> > > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > > > > > >             names[total_vqs - 1] = "control";
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > >
> > > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > > > > this will cause irq sharing between VQs which will degrade
> > > > > > > > performance significantly.
> > > > > > > >
> > > > > >
> > > > > > Why do we need to care about buggy management? I think libvirt has
> > > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
> > > > >
> > > > > And Qemu can calculate it correctly automatically since:
> > > > >
> > > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > > > > Author: Jason Wang <jasowang@redhat.com>
> > > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> > > > >
> > > > >     virtio-net: calculating proper msix vectors on init
> > > > >
> > > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
> > > > >     obvious not suitable for multiqueue guest, so we depends on the user
> > > > >     or management tools to pass a correct vectors parameter. In fact, we
> > > > >     can simplifying this by calculating the number of vectors on realize.
> > > > >
> > > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
> > > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
> > > > >     check whether or not host support control vq because it was added
> > > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
> > > > >
> > > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> > > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > Yes, devices designed according to the spec need to reserve an interrupt
> > > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
> > > >
> > > > Thanks.
> > >
> > > These aren't buggy, the spec allows this.
> 
> So it doesn't differ from the case when we are lacking sufficient msix
> vectors in the case of multiqueue. In that case we just fallback to
> share one msix for all queues and another for config and we don't
> bother at that time.

sharing queues is exactly "bothering".

> Any reason to bother now?
> 
> Thanks

This patch can make datapath slower for such configs by switching to
sharing msix for a control path benefit. Not a tradeoff many users want
to make.


> > >  So don't fail, but
> > > I'm fine with using polling if not enough vectors.
> >
> > sharing with config interrupt is easier code-wise though, FWIW -
> > we don't need to maintain two code-paths.
> >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > > > So no, you can not just do it unconditionally.
> > > > > > > >
> > > > > > > > The correct fix probably requires virtio core/API extensions.
> > > > > > >
> > > > > > > If the introduction of cvq irq causes interrupts to become shared, then
> > > > > > > ctrlq need to fall back to polling mode and keep the status quo.
> > > > > >
> > > > > > Having to path sounds a burden.
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > MST
> > > > > > > >
> > > > > > >
> > > > >
> >


