Return-Path: <netdev+bounces-109851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72A692A14E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CD61F22065
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E455D7BAE3;
	Mon,  8 Jul 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Q08iRbQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E1101E2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438849; cv=none; b=JbuwhpunhNjt59rsMyWTbSB/ArQ59A+KVkAClZdzctUDofjRGY2tO5k/Nsxz2ZX9I8fkRhWNhComq3EzOAhMQC9+4LYIe7b8jZelCb1T/8mM3YU9lbVdFJBUQdGK9kmUtEzztVLKjwqsqJqVU4d9HBCqUn2Wx3egOrQWHBNn6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438849; c=relaxed/simple;
	bh=4DQccTifEBBNX8gHmRvfdps4Uo3dR3DK7HsIbN7lBJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCvsqoEcR9qsZgDRcVungjRH39KYFXgOnol79R0wHee6TxVMC0uPNmfkZaFwCDWdYW5O/G6nJKEDl6itDOyiOUlwRgl2TWxi0AkHcBd5vFiEP4HGo03wBsuUZX2vfgKgrEH95ZBjx8a8KDqxOVZ8vZL/EBTJh/dfkXoeNkmMFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Q08iRbQ3; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a77c1658c68so392507066b.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720438845; x=1721043645; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Oj9hVhewV9lGX86mRsVY7ZBdhsddt781yMM5sK/aJ0=;
        b=Q08iRbQ3UeC3aLaVdgCzH3RB59V33xQGmMtI7s0J3Gbfqo9UG9pOTCPk2KksI6ZNo6
         K9xcAqiaj/CuhWDY/ppnHyz4bNMInr6dUbbpV3B1wtzHDKxAmVH42E/0Ctl8utRGBZhH
         z+zfBGFbB7KNQy9qgHOIaCZYEuxZFMqsP4wfuRJ993Jg5iseOtOHhLAFktL4NC1efPIu
         /l9/awtWGf+Crv1zV1HBeD/RnQOU2+2/6nVvOEj0hRlLC5iokkY1jyDL/OfCJYsnkY1i
         dbvIk+2XU2db7XoqNo8USIjeJcaxVmZrbrfQaDTIgyiAOC9/N6u/9aTkoFNnL8kRW4Bv
         iBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720438845; x=1721043645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Oj9hVhewV9lGX86mRsVY7ZBdhsddt781yMM5sK/aJ0=;
        b=pvfE1SodZ4ACC3h8nC46zPnB3HaZWnD5Q2TCWZRIN15UtMd7NZmIcYwIbw9QLXz/IB
         /7vlg1PtbElTs4GOknqura3jYTdSegdGakcq9KSvBcvBoSMwfaxEFguwfN1xyCtSVeKo
         NztQOblIQQtDvrt7eFTz9F+dPtXZUrSMyAh928q//mSdnVbFByEZEN+nwE6UgTOUB//t
         zNNiz5SGVG4ea9PTqIvq79W7hhOAWxtb3pqI8oR315hwgSYUkMF+RBRWpafRrf04nF+X
         +hsO5aQ+x5MA+iW2UUZ31eBxipo+wgsRi+c2KoGYHP3wQ41xh330osHfJ4pRXarPBGpz
         Iy7w==
X-Forwarded-Encrypted: i=1; AJvYcCWjHAWUvqxFt3w2SNDOBukVmsaJMSZZ3IZuycfjG4v2WtZQ5RN/1eFIy+1HEo7mK6mKWkkZkOisTvXCGZgRAI74D5ybOXtz
X-Gm-Message-State: AOJu0Ywaitkoxr3n1enmq7dXQGTMUP/qjHAmqgB53GyE/El+/xKHLpb+
	ea+Y1OKggpbKju1ay2yD54qfcl/dTXti4glH4wRdhzmmg/RURlvkKecKkLZRxys=
X-Google-Smtp-Source: AGHT+IGByAobiVYXxBMrpQrkE5cUurgwnnCaXBM6PFdoW6K3shR38ZsJV83iB0L93Z7GXll4KYSabA==
X-Received: by 2002:a17:906:897:b0:a77:eb34:3b50 with SMTP id a640c23a62f3a-a77eb343cb9mr341666566b.20.1720438844745;
        Mon, 08 Jul 2024 04:40:44 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77ec25ec18sm164889866b.39.2024.07.08.04.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:40:44 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:40:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <ZovQOpmfOMs77lJ2@nanopsycho.orion>
References: <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
 <ZnvI2hJXPJZyveAv@nanopsycho.orion>
 <20240626040730-mutt-send-email-mst@kernel.org>
 <ZnvUn-Kq4Al0nMQZ@nanopsycho.orion>
 <20240626045313-mutt-send-email-mst@kernel.org>
 <ZnwApCUjIijZ7o0b@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnwApCUjIijZ7o0b@nanopsycho.orion>

Wed, Jun 26, 2024 at 01:51:00PM CEST, jiri@resnulli.us wrote:
>Wed, Jun 26, 2024 at 11:58:08AM CEST, mst@redhat.com wrote:
>>On Wed, Jun 26, 2024 at 10:43:11AM +0200, Jiri Pirko wrote:
>>> Wed, Jun 26, 2024 at 10:08:14AM CEST, mst@redhat.com wrote:
>>> >On Wed, Jun 26, 2024 at 09:52:58AM +0200, Jiri Pirko wrote:
>>> >> Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wrote:
>>> >> >On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>> >> >> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
>>> >> >> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
>>> >> >> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>> >> >> > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
>>> >> >> > > > >
>>> >> >> > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>> >> >> > > > > >
>>> >> >> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>> >> >> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
>>> >> >> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>>> >> >> > > > > > > >
>>> >> >> > > > > > > >     /* Parameters for control virtqueue, if any */
>>> >> >> > > > > > > >     if (vi->has_cvq) {
>>> >> >> > > > > > > > -           callbacks[total_vqs - 1] = NULL;
>>> >> >> > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
>>> >> >> > > > > > > >             names[total_vqs - 1] = "control";
>>> >> >> > > > > > > >     }
>>> >> >> > > > > > > >
>>> >> >> > > > > > >
>>> >> >> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
>>> >> >> > > > > > > this will cause irq sharing between VQs which will degrade
>>> >> >> > > > > > > performance significantly.
>>> >> >> > > > > > >
>>> >> >> > > > >
>>> >> >> > > > > Why do we need to care about buggy management? I think libvirt has
>>> >> >> > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
>>> >> >> > > > 
>>> >> >> > > > And Qemu can calculate it correctly automatically since:
>>> >> >> > > > 
>>> >> >> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
>>> >> >> > > > Author: Jason Wang <jasowang@redhat.com>
>>> >> >> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
>>> >> >> > > > 
>>> >> >> > > >     virtio-net: calculating proper msix vectors on init
>>> >> >> > > > 
>>> >> >> > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
>>> >> >> > > >     obvious not suitable for multiqueue guest, so we depends on the user
>>> >> >> > > >     or management tools to pass a correct vectors parameter. In fact, we
>>> >> >> > > >     can simplifying this by calculating the number of vectors on realize.
>>> >> >> > > > 
>>> >> >> > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
>>> >> >> > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
>>> >> >> > > >     check whether or not host support control vq because it was added
>>> >> >> > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
>>> >> >> > > > 
>>> >> >> > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
>>> >> >> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> >> >> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> >> >> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> >> >> > > 
>>> >> >> > > Yes, devices designed according to the spec need to reserve an interrupt
>>> >> >> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
>>> >> >> > > 
>>> >> >> > > Thanks.
>>> >> >> > 
>>> >> >> > These aren't buggy, the spec allows this. So don't fail, but
>>> >> >> > I'm fine with using polling if not enough vectors.
>>> >> >> 
>>> >> >> sharing with config interrupt is easier code-wise though, FWIW -
>>> >> >> we don't need to maintain two code-paths.
>>> >> >
>>> >> >Yes, it works well - config change irq is used less before - and will not fail.
>>> >> 
>>> >> Please note I'm working on such fallback for admin queue. I would Like
>>> >> to send the patchset by the end of this week. You can then use it easily
>>> >> for cvq.
>>> >> 
>>> >> Something like:
>>> >> /* the config->find_vqs() implementation */
>>> >> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>> >>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>> >>                 const char * const names[], const bool *ctx,
>>> >>                 struct irq_affinity *desc)
>>> >> {
>>> >>         int err;
>>> >> 
>>> >>         /* Try MSI-X with one vector per queue. */
>>> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>> >>                                VP_VQ_VECTOR_POLICY_EACH, ctx, desc);
>>> >>         if (!err)
>>> >>                 return 0;
>>> >>         /* Fallback: MSI-X with one shared vector for config and
>>> >>          * slow path queues, one vector per queue for the rest. */
>>> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>> >>                                VP_VQ_VECTOR_POLICY_SHARED_SLOW, ctx, desc);
>>> >>         if (!err)
>>> >>                 return 0;
>>> >>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
>>> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>> >>                                VP_VQ_VECTOR_POLICY_SHARED, ctx, desc);
>>> >>         if (!err)
>>> >>                 return 0;
>>> >>         /* Is there an interrupt? If not give up. */
>>> >>         if (!(to_vp_device(vdev)->pci_dev->irq))
>>> >>                 return err;
>>> >>         /* Finally fall back to regular interrupts. */
>>> >>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
>>> >> }
>>> >> 
>>> >> 
>>> >
>>> >
>>> >Well for cvq, we'll need to adjust the API so core
>>> >knows cvq interrupts are be shared with config not
>>> >datapath.
>>> 
>>> Agreed. I was thinking about introducing some info struct and pass array
>>> of it instead of callbacks[] and names[]. Then the struct can contain
>>> flag indication. Something like:
>>> 
>>> struct vq_info {
>>> 	vq_callback_t *callback;
>>> 	const char *name;
>>> 	bool slow_path;
>>> };
>>> 
>>
>>Yes. Add ctx too? There were attempts at it already btw.
>
>Yep, ctx too. I can take a stab at it if noone else is interested.

Since this work is in v4, and I hope it will get merged soon, I plan to
send v2 of admin queue parallelization patchset after that. Here it is:
https://github.com/jpirko/linux_mlxsw/tree/wip_virtio_parallel_aq2

Heng, note the last patch:
virtio_pci: allow to indicate virtqueue being slow path

That is not part of my set, it is ment to be merged in your control
queue patchset. Then you can just indicate cvq to be slow like this:

        /* Parameters for control virtqueue, if any */
        if (vi->has_cvq) {
                vqs_info[total_vqs - 1].callback = virtnet_cvq_done;
                vqs_info[total_vqs - 1].name = "control";
                vqs_info[total_vqs - 1].slow_path = true;
        }

I just wanted to let you know this is in process so you may prepare.
Will keep you informed.

Thanks.

