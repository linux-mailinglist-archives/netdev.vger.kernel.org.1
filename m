Return-Path: <netdev+bounces-105682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3B912454
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B101C24A4D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131A17B42D;
	Fri, 21 Jun 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1jOTtZO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862A17B400
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970385; cv=none; b=NWn2g3B8Tw0AT1ExcHAENVE8GPgPsf4LdAxhPIBnnxqIxm7rPsU4MHA+hfdhP76v9rrHxbA9N3pKdTVpwA760LRftScjUa7CRqzwC3XjT1vtBOdu8WqHjk2LoCtWTviRKr2UmguWMW8kX2fmmMqnYgEw9pp3VUUoGmVT/kyT9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970385; c=relaxed/simple;
	bh=1IpAvpTRxIRxo5VanpieLOtLdE7IC44p9KaY+cIeyIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw+y3GZDHNFkeNj1tPfL/nZAb/tpFJepTuqOpY1toqkiTcqpCspMlKZVW3FbH3WtKcOgCE38+2ws5IA3sTEhQls80aE+y94+oLdnNQpZlz0JkE3h++T50Tvy9EfBgn1QTJo+nRubtORFCLsdY2+fivpKizy0N9SPdxd8zxwf60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1jOTtZO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718970382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Cit9SRlFcxDWmmjhXeXZeOyIYLc7gueEfceyAPz18=;
	b=K1jOTtZOYxcM5He2isxLop068jz13HGlZSE41hMWNVCIwVGdqeh9NcFT5pZSugtAkFlKPU
	DqHn8Bg/iNh9WEWbBejBCUjHG2LrGthGy9QKjf7I58cWnr3+2UbxL/kwMjvSrHG5TftfZD
	+m/AUCRcNxiEBhXUbViAkqoxKEwYA1I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-gXzbrmSuOkm_JhyB0RpWOw-1; Fri, 21 Jun 2024 07:46:21 -0400
X-MC-Unique: gXzbrmSuOkm_JhyB0RpWOw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6fad35a585so99249266b.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 04:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718970380; x=1719575180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1Cit9SRlFcxDWmmjhXeXZeOyIYLc7gueEfceyAPz18=;
        b=pznQ7tACTSgHBOF/0wWlYo/JFfdbHz9hIO+KT0TLYnO6LcpSIdp+1/OCXlTMZYKxG2
         R50K1/2X46kNIBT2qqoNnDuvumqJEYqqEXR/2/xVEwVLIfs7i+f8aEuQBg2nwGA54S+p
         DxUfk6WVI/ftxlBE7O1XAs2kwBNbwG31r3+owobnWaSr2ayQgUYrMTSHc0u1HhKjrpoL
         1EekDr2IF9qfJ2e9v2AWcO2XeGPlgU3GFPZ82xM508kwKEqiO+FwAb+dNrLX85r9jbeB
         H430lcpyu4Adu/nXstIt3GN+fvP/xwah+wzQE6IhFa5KMGmnc5N9vos05Kgiy/iKwKks
         TVYw==
X-Forwarded-Encrypted: i=1; AJvYcCVrcWHKYCO9ISckXAmgPuDkl3UT+rhOkgagw3DMsHh4QRHX8n/90TJ7zK4lJNnUJnNMDAVmSn93NNH96Q8LEPR7xqZeiuUc
X-Gm-Message-State: AOJu0YzvpPJ9BCpaDXOUz+IK0xtt6zBoR8xvIJB6Ex9XvJeMJIwZjf7d
	2v+fM1m5N9tLmUfRuqngxNYUmgO3Sv0e67YYwRpcFqcIoem1NbP4razK4Rbg/mh3KCxrlcDqyVp
	sAey4eep/jq0LDM+KoKWTwLYF5S1A479ebP7/GnzO0EwJnlpvF/uANQ==
X-Received: by 2002:a17:906:99c7:b0:a6f:6cde:150a with SMTP id a640c23a62f3a-a6fab602e5bmr544837266b.15.1718970380252;
        Fri, 21 Jun 2024 04:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQoGxGRe5CedU96dhaZZV00ox86DbPEZsuKXasfa4eI8tUBpcDbIuQ7vEmkWgI8WuV+xppYA==
X-Received: by 2002:a17:906:99c7:b0:a6f:6cde:150a with SMTP id a640c23a62f3a-a6fab602e5bmr544832766b.15.1718970379451;
        Fri, 21 Jun 2024 04:46:19 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56eef6sm74646266b.225.2024.06.21.04.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:46:18 -0700 (PDT)
Date: Fri, 21 Jun 2024 07:46:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240621074023-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718955706.2555537-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1718955706.2555537-1-xuanzhuo@linux.alibaba.com>

On Fri, Jun 21, 2024 at 03:41:46PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
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
> > > These aren't buggy, the spec allows this. So don't fail, but
> > > I'm fine with using polling if not enough vectors.
> >
> > sharing with config interrupt is easier code-wise though, FWIW -
> > we don't need to maintain two code-paths.
> 
> 
> If we do that, we should introduce a new helper, not to add new function to
> find_vqs().
> 
> if ->share_irq_with_config:
> 	->share_irq_with_config(..., vq_idx)
> 
> Thanks.

Generally, I'd like to avoid something very narrow and single-use
in the API. Just telling virtio core that a vq is slow-path
sounds generic enough, and we should be able to extend that
later to support sharing between VQs.

> 
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


