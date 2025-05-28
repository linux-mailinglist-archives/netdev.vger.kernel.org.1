Return-Path: <netdev+bounces-194017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358DCAC6D3C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E3116A659
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08363288526;
	Wed, 28 May 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMy++B7K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF8286D6B
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447571; cv=none; b=hDdh9yEYz4NO6RmhbUFgZ/ztZKGU2FplG7+SDN2t31T9Urecon4LOOzoVbUeXlgrvJ3ZCnlzCwv94OEKhPeMa3Phs6+U2PQwE1QWr6ruPFM825GIMz9hT1KtW3NlTq7pwh5/3UAgQ7w2fa+7m3FFd60MAldl61B55kaFWLeqA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447571; c=relaxed/simple;
	bh=1AuiYxt9wheUfpQNwAghwjODC0aacqklfmGY4Jxz5C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLQvR6A2FVITvzcnXiECw4YCUhsRe2bGO5SVw63pCVUjKWKW+/ct6ePuAnmYs2Z3mCcoe46aeSIevQLNWJ5Ajgz3/Tm6Q28Vl60+hciyqNXtnbhJsUhixE5zvGi5TSCJM+cRjxCps9ytdVgsMtrZwxOBQ6I+WBJ8j4rbi3OMd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMy++B7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748447569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Fxn+bAt7Sa69EdSggCcGgqNvtlrt+HUBgriTvfTk/E=;
	b=SMy++B7Kp6FZIxCImordARRra8D26JksQlvnoCYeo6pHI+jcSHppYcJ6bmlU/7ljB+Xuoi
	Hl1wO8RHq2i+Qo7bYMeXePtwYzpH338rWMOjfP76RSohxcN72LbucILuX2Psv36HM3PlPD
	Wyx3MuiVA8oGh2c6s9ZkBWthVQx9R8w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-nqHNDw33MnS9P-1RxG9tlw-1; Wed, 28 May 2025 11:52:45 -0400
X-MC-Unique: nqHNDw33MnS9P-1RxG9tlw-1
X-Mimecast-MFC-AGG-ID: nqHNDw33MnS9P-1RxG9tlw_1748447565
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4c8c60c5eso2869261f8f.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 08:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748447564; x=1749052364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fxn+bAt7Sa69EdSggCcGgqNvtlrt+HUBgriTvfTk/E=;
        b=lQMF0ksTPWPh+hrgtpjqtIuxG3Kqk5lhtpjsuCx4/mEinxrazVYM19syqC77Qff1iV
         ZdoHfOwQ31MmMjpBnZrtnd4STfcVYp7KAoYarJDBGKAMO2glaXZ+QmV8ZkR+Do+7YYtW
         XJXF4DeC5H9qKBJDdYLczjNr0CCm3Xcnj7pgO+La9Od23AhAJWfra4d1ZpsI++GAU4c0
         6+fLJyZuMvdrYNNorBNsfoaVri0TBRC0EVA4f0bYnVdz1rGUmQ4oCEokiZhKldXwGw7G
         rtVWZuz1MTKKTCNCPoxKsobGhO5RsFtvp5Ma8G5cXzfb9DcSUbobus3yPpfU4KxTYnoi
         Xybg==
X-Forwarded-Encrypted: i=1; AJvYcCVbzQvP6uuW36qASPERsmhOwj704jRsGIl67dhIvzSoC/MzY1TjAq1ZIk41M5DQpsfqFcj2+oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtzwUW7f564pfIxdhTw7Eu+PPYCT//6JI/zd6xq4jnh8nS8m1l
	oDruOSJhICHQ/EyJr+UxLMcYdgHaywKVbCKrQ9I76F1n2Ys4qbQMRE3AekWHeb0C7augaLgRJO4
	WPhD2Nbl9pS7UxVThvoao0LARkm/QtV9VGnNiGeSXJ/TTJXHIqo/TCGU6mQ==
X-Gm-Gg: ASbGncuO556n0VmPsraHGp7+loDWNQsdllUXHUVEnB3saBgKtnrh/7PnHasWaymnQv/
	dvrP2/W/LyYr7rmIxRtdq3PcJUc1SHN3+vM4Qdr5Tb4jDzLck5OXvQYiD5JQ1RatFWuDLshj6TL
	XmncDAuiZVkOlAPJPfHZL8oopSiu+9B8wqbzGu0l0q2rgbTA0cvp4T/weenLa+BCG5XPiRSAKYX
	fF++FbmaLC3f/sh8R1QBCJtFXC1w42OuJFn1elomNKo2YV6M29KPnvsLoZbwd/5OAWFqFkTfLo7
	frMsEA==
X-Received: by 2002:adf:fa10:0:b0:3a4:cbbd:6330 with SMTP id ffacd0b85a97d-3a4cbbd63c3mr10023333f8f.24.1748447564626;
        Wed, 28 May 2025 08:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTRAmOB4QvJ4Ec9y3aJrQbDgS+0ExpK73TLFVxf2YDjP20HKOoFamIMyGY7+K3KWCYFdCrTw==
X-Received: by 2002:adf:fa10:0:b0:3a4:cbbd:6330 with SMTP id ffacd0b85a97d-3a4cbbd63c3mr10023319f8f.24.1748447564241;
        Wed, 28 May 2025 08:52:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4500e1ddaeesm25380995e9.35.2025.05.28.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 08:52:43 -0700 (PDT)
Date: Wed, 28 May 2025 11:52:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
Message-ID: <20250528115015-mutt-send-email-mst@kernel.org>
References: <cover.1747822866.git.pabeni@redhat.com>
 <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <CACGkMEtGRK-DmonOfqLodYVqYhUHyEZfrpsZcp=qH7GMCTDuQg@mail.gmail.com>
 <2119d432-5547-4e0b-b7fc-42af90ec6b7a@redhat.com>
 <CACGkMEsHn7q8BvfkaiknQTW9=WONLC_eB9DV0bcqL=oLa62Dxg@mail.gmail.com>
 <3ae72579-7259-49ba-af37-a2eaba719e7e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ae72579-7259-49ba-af37-a2eaba719e7e@redhat.com>

On Wed, May 28, 2025 at 05:47:53PM +0200, Paolo Abeni wrote:
> On 5/27/25 5:51 AM, Jason Wang wrote:
> > On Mon, May 26, 2025 at 3:20 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >> On 5/26/25 2:43 AM, Jason Wang wrote:
> >>> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >>>> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
> >>>> new file mode 100644
> >>>> index 0000000000000..2f742eeb45a29
> >>>> --- /dev/null
> >>>> +++ b/include/linux/virtio_features.h
> >>>> @@ -0,0 +1,23 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>> +#ifndef _LINUX_VIRTIO_FEATURES_H
> >>>> +#define _LINUX_VIRTIO_FEATURES_H
> >>>> +
> >>>> +#include <linux/bits.h>
> >>>> +
> >>>> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
> >>>> +#define VIRTIO_HAS_EXTENDED_FEATURES
> >>>> +#define VIRTIO_FEATURES_MAX    128
> >>>> +#define VIRTIO_FEATURES_WORDS  4
> >>>> +#define VIRTIO_BIT(b)          _BIT128(b)
> >>>> +
> >>>> +typedef __uint128_t            virtio_features_t;
> >>>
> >>> Consider:
> >>>
> >>> 1) need the trick for arch that doesn't support 128bit
> >>> 2) some transport (e.g PCI) allows much more than just 128 bit features
> >>>
> >>>  I wonder if it's better to just use arrays here.
> >>
> >> I considered that, it has been discussed both on the virtio ML and
> >> privatelly, and I tried a resonable attempt with such implementation.
> >>
> >> The diffstat would be horrible, touching a lot of the virtio/vhost code.
> > 
> > Let's start with the driver. For example, driver had already used
> > array for features:
> > 
> >         const unsigned int *feature_table;
> >         unsigned int feature_table_size;
> > 
> > For vhost, we need new ioctls anyhow:
> > 
> > /* Features bitmask for forward compatibility.  Transport bits are used for
> >  * vhost specific features. */
> > #define VHOST_GET_FEATURES      _IOR(VHOST_VIRTIO, 0x00, __u64)
> > #define VHOST_SET_FEATURES      _IOW(VHOST_VIRTIO, 0x00, __u64)
> > 
> > As we can't change uAPI for existing ioctls.
> > 
> >> Such approach will block any progress for a long time (more likely
> >> forever, since I will not have the capacity to complete it).
> >>
> > 
> > Well, could we at least start from using u64[2] for virtio_features_t?
> > 
> >> Also the benefit are AFAICS marginal, as 32 bits platform with huge
> >> virtualization deployments on top of it (that could benefit from GSO
> >> over UDP tunnel) are IMHO unlikely,
> > 
> > I think it's better to not have those architecture specific assumptions since:
> > 
> > 1) need to prove the assumption is correct or
> > 2) we may also create blockers for 64 bit archs that don't support
> > ARCH_SUPPORTS_INT128.
> > 
> >> and transport features space
> >> exhaustion is AFAIK far from being reached (also thanks to reserved
> >> features availables).
> > 
> > I wouldn't be worried if a straightforward switch to int128 worked,
> > but it looks like that is not the case:
> > 
> > 1) ARCH_SUPPORTS_INT128 dependency
> > 2) new uAPI
> > 3) we might want a new virtio config ops as well as most of transport
> > can only return 64 bit now
> >>
> >> TL;DR: if you consider a generic implementation for an arbitrary wide
> >> features space blocking, please LMK, because any other consideration
> >> would be likely irrelevant otherwise.
> 
> I read your comments above as the only way forward is abandoning the
> uint128_t usage. Could you please confirm that?
> 
> Side note: new uAPI will be required by every implementation of
> feature-space extension, as the current ones are 64-bits bound.
> 
> Thanks,
> 
> Paolo


Jason, I think what Paolo's doing is a step in the right direction, we
can do this, then gradually transfer all drivers, devices and transports
to use virtio_features_t, then make virtio_features_t an array if we want.

If instead you jump to an array straight away, it's a huge change that
can not be split up cleanly.


-- 
MST


