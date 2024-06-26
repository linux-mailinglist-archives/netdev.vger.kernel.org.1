Return-Path: <netdev+bounces-106804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793A917B2F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3A41F26882
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB6166300;
	Wed, 26 Jun 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PQ8CfgrK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65A13B78F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391399; cv=none; b=jc3PQanjbVXqMuOx6NVD6Lbc4MZ1e7Yxt3bYBKMaIoRz51IOOb1+0llZ8TkA2nsLXckXubsk8+BLBGCiFe6hfaQl27pLY5b4/qwzbNEPHyy8WhWtpcBDDeCKG14mWpmsi8rzV7Ap2EB3fhg5mXO02P0ehnx6PigyfTeptKqLoNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391399; c=relaxed/simple;
	bh=C2ox0KqbefqgIcR1h5oqnPkIXq4UGVS9kbaYWQ6dfb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRUybNAXwW1+Fv0aVr6o+bsqKjKRGniIE8CG6Qqj4F/366Z/JwjUOly13MwRPLeI4n/E2KHIiKppzTEpFRKiAVxg1MCA9rKolVKWSMbIKu7gNmKAu7RMHYQikS+8YbqLy4XzTxcRXNk71G8YQkZ1sxgAoT+KhyLH41Inqa3NPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PQ8CfgrK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3620ee2cdf7so3954252f8f.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719391395; x=1719996195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+vu6CAngNKGlbKo6gG6ckEU4iEDVbJhe6KmDGwESUxA=;
        b=PQ8CfgrKE8YYw8abPkOn/L/jrONrwAxoTd4EcVw/ao4+KdVrN+pl53xH+HQ5aoxDRH
         WRXqfBXqKJiE0RHtfKK8pvg+AAkBj2CEpZ/wLtIpg+acyVfaORBajZTYnYkQjn+G6IRw
         D20I1MhGTvV2qKJ/Rz8aVLFnSGWBoGIQSUcj15TlfbZ3WaO0ePU64Femy2pKBoLAZqqG
         xrDXx/R7Y8q0OJb7117FQnK+ea9DfPXvX4gt6aEg5jQwObfWRMIjL13ZOD4gC4iBJzaH
         h6/+GXeGmAzcckOi1lTlLpEeaciyiOYc+4caMpYLiN9y7fyd3Q6HUpYzAdxAKkvvtXeW
         mYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391395; x=1719996195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vu6CAngNKGlbKo6gG6ckEU4iEDVbJhe6KmDGwESUxA=;
        b=dodwpOl8YqXeoiVQu56Q/rQd/hDGKPOMaxEHLsC1mDdiwOlJaN8BzXeAbkw2mpu6Jc
         zJHMZ4YsQgU9d+4yo+Y3v2AvaA+4/K1hwacAlLBFEGfe4fYKDke7OKB/orRpOY8kk+4n
         bz6JgjY4aO4s4bV/ruC86leZRXsao0RASSxkDV2Hm2FW3FaulH16hKir7EaWWSJh3Qr1
         giX4gfR2aNgwqqmJ05wv1MWG0TlDzkxN9eVdG5FzSj7/PV+Oh8bdPH+b5NYyzlNssYIM
         4oxE9wt1y9+q5iAFlnpDGjESO/qEoEZRvBhoylI+SyEMAb+qxxJzMX2yA3L6ovXukfVz
         xedw==
X-Forwarded-Encrypted: i=1; AJvYcCXIoB8xNg1ziERQ3AyVGqKz0xRyBgjPK9srmFRJjEbcBrngbKTiMGAXuwBy/IBA8Dxf5TaYpZRmZnWlM0g9+rjYQRziUIRg
X-Gm-Message-State: AOJu0Ywow7TiaMERA9fAF6RdoDTtbZQMluQDL5jOrw9JtXcW48qTLZCa
	9GbYQ4Q3OUWX2dHNIloEYzL/5oSMD73pvq50ByQe240lOZMiNsjDkRVplbfLwFM=
X-Google-Smtp-Source: AGHT+IEkBVGWG6r8INvHXHS1OoC6a2g8D6yuEsFL7uFC/fiKvKH09PT6Z5FhZ0ah6BTan5HW5rn3eA==
X-Received: by 2002:a5d:526d:0:b0:35e:4f42:6016 with SMTP id ffacd0b85a97d-366e7a35de0mr7166540f8f.30.1719391395042;
        Wed, 26 Jun 2024 01:43:15 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f973b7e5sm6345965f8f.14.2024.06.26.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:43:14 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:43:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <ZnvUn-Kq4Al0nMQZ@nanopsycho.orion>
References: <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
 <ZnvI2hJXPJZyveAv@nanopsycho.orion>
 <20240626040730-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626040730-mutt-send-email-mst@kernel.org>

Wed, Jun 26, 2024 at 10:08:14AM CEST, mst@redhat.com wrote:
>On Wed, Jun 26, 2024 at 09:52:58AM +0200, Jiri Pirko wrote:
>> Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wrote:
>> >On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
>> >> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
>> >> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> >> > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
>> >> > > > >
>> >> > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> >> > > > > >
>> >> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
>> >> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>> >> > > > > > > >
>> >> > > > > > > >     /* Parameters for control virtqueue, if any */
>> >> > > > > > > >     if (vi->has_cvq) {
>> >> > > > > > > > -           callbacks[total_vqs - 1] = NULL;
>> >> > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
>> >> > > > > > > >             names[total_vqs - 1] = "control";
>> >> > > > > > > >     }
>> >> > > > > > > >
>> >> > > > > > >
>> >> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
>> >> > > > > > > this will cause irq sharing between VQs which will degrade
>> >> > > > > > > performance significantly.
>> >> > > > > > >
>> >> > > > >
>> >> > > > > Why do we need to care about buggy management? I think libvirt has
>> >> > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
>> >> > > > 
>> >> > > > And Qemu can calculate it correctly automatically since:
>> >> > > > 
>> >> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
>> >> > > > Author: Jason Wang <jasowang@redhat.com>
>> >> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
>> >> > > > 
>> >> > > >     virtio-net: calculating proper msix vectors on init
>> >> > > > 
>> >> > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
>> >> > > >     obvious not suitable for multiqueue guest, so we depends on the user
>> >> > > >     or management tools to pass a correct vectors parameter. In fact, we
>> >> > > >     can simplifying this by calculating the number of vectors on realize.
>> >> > > > 
>> >> > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
>> >> > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
>> >> > > >     check whether or not host support control vq because it was added
>> >> > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
>> >> > > > 
>> >> > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
>> >> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> >> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
>> >> > > 
>> >> > > Yes, devices designed according to the spec need to reserve an interrupt
>> >> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
>> >> > > 
>> >> > > Thanks.
>> >> > 
>> >> > These aren't buggy, the spec allows this. So don't fail, but
>> >> > I'm fine with using polling if not enough vectors.
>> >> 
>> >> sharing with config interrupt is easier code-wise though, FWIW -
>> >> we don't need to maintain two code-paths.
>> >
>> >Yes, it works well - config change irq is used less before - and will not fail.
>> 
>> Please note I'm working on such fallback for admin queue. I would Like
>> to send the patchset by the end of this week. You can then use it easily
>> for cvq.
>> 
>> Something like:
>> /* the config->find_vqs() implementation */
>> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>                 const char * const names[], const bool *ctx,
>>                 struct irq_affinity *desc)
>> {
>>         int err;
>> 
>>         /* Try MSI-X with one vector per queue. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>                                VP_VQ_VECTOR_POLICY_EACH, ctx, desc);
>>         if (!err)
>>                 return 0;
>>         /* Fallback: MSI-X with one shared vector for config and
>>          * slow path queues, one vector per queue for the rest. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>                                VP_VQ_VECTOR_POLICY_SHARED_SLOW, ctx, desc);
>>         if (!err)
>>                 return 0;
>>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>                                VP_VQ_VECTOR_POLICY_SHARED, ctx, desc);
>>         if (!err)
>>                 return 0;
>>         /* Is there an interrupt? If not give up. */
>>         if (!(to_vp_device(vdev)->pci_dev->irq))
>>                 return err;
>>         /* Finally fall back to regular interrupts. */
>>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
>> }
>> 
>> 
>
>
>Well for cvq, we'll need to adjust the API so core
>knows cvq interrupts are be shared with config not
>datapath.

Agreed. I was thinking about introducing some info struct and pass array
of it instead of callbacks[] and names[]. Then the struct can contain
flag indication. Something like:

struct vq_info {
	vq_callback_t *callback;
	const char *name;
	bool slow_path;
};


>
>
>
>> 
>> >
>> >Thanks.
>> >
>> >> 
>> >> > > > 
>> >> > > > Thanks
>> >> > > > 
>> >> > > > >
>> >> > > > > > > So no, you can not just do it unconditionally.
>> >> > > > > > >
>> >> > > > > > > The correct fix probably requires virtio core/API extensions.
>> >> > > > > >
>> >> > > > > > If the introduction of cvq irq causes interrupts to become shared, then
>> >> > > > > > ctrlq need to fall back to polling mode and keep the status quo.
>> >> > > > >
>> >> > > > > Having to path sounds a burden.
>> >> > > > >
>> >> > > > > >
>> >> > > > > > Thanks.
>> >> > > > > >
>> >> > > > >
>> >> > > > >
>> >> > > > > Thanks
>> >> > > > >
>> >> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
>> >> > > > >
>> >> > > > > > >
>> >> > > > > > > --
>> >> > > > > > > MST
>> >> > > > > > >
>> >> > > > > >
>> >> > > > 
>> >> 
>> >
>

