Return-Path: <netdev+bounces-175526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C3A663DF
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49692421107
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 00:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E3225D7;
	Tue, 18 Mar 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awXbbaAT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C618E25
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257768; cv=none; b=UHwS1xeGDu5w8sykyIfjqoQA5a+1/0tWwAzkM7c4SGMfY7JiwX60JuD8t5xZYf/QNAb60xNZOXQhw0WKQDQ3TObgdNxA+hKAQ+6SMAvNRk3zosYcfZFVbcdF/1i+QzJW0RUWxQB2WGwpsQwMSZ1hH4yF2lINGVVKV7u5kWbYNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257768; c=relaxed/simple;
	bh=Iq6VTTpZ7kMw4sehGuzpV0DZTLHk3gC3ZjUxf5EpShY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG054b9hUU4HiodW1o3txbmwt/4/WudPRT39wKArIxk9I8fxZsIecmi9PKGZWouY1g/mCPAGCj9fajTMEvYEF6R7sANUjambEqMB8BDO8ZlKv40DXTOz7YHLXqbUhJpjtoqH2cudEw9/QXPQ/GNe2m58GnJCqlI2m2WwR3Y0guU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awXbbaAT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742257766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uGlyUD8vqNUb+95XWNLKTz4/ExHYTFqRQ19vbWD0q9U=;
	b=awXbbaATd15Cr9TJKEgbbs8Q6CjvBypaJETSxebnmq1pkGE7L+E8N4gz/fKTxUgTZdMhsT
	/evhWaDFArLjav37LMsud97cEuRnWSDZhv/pwV0UKuA5/yg+FUbnvVPEHd2l9c6Od+s3Yd
	Yoi/EqL6bduLCTzCCyM8Qwc6FSFrM4w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-9Of3M1OnPK6IAYtWfnKWGQ-1; Mon, 17 Mar 2025 20:29:24 -0400
X-MC-Unique: 9Of3M1OnPK6IAYtWfnKWGQ-1
X-Mimecast-MFC-AGG-ID: 9Of3M1OnPK6IAYtWfnKWGQ_1742257763
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso7179326a91.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742257763; x=1742862563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGlyUD8vqNUb+95XWNLKTz4/ExHYTFqRQ19vbWD0q9U=;
        b=we+tcQoOWuRv9J9jUsFDkYDaLnOTKWhR3hJS7JuZ1/5VmcIGewMj397Ta5WMWiJ7Do
         6uKdreHtoqL/CjWkO7TvPqIauRasRAb/wVvfTUv7jojNkf/UFO8wCTv24OBVQdKWXHFf
         8sXOilzf1Irc/rt/yjX7MQ1bIsQio8/RfSoQxlmlB76rYLY8uXe/UdhpYp5tQMK8so92
         zsxelObeX7uNL5X+yfikwd8YMTEKfoXiJy+q2RvUnSjfpJMck3inpKFrA2vzFcyxYkDI
         rI7sfseiL+O8f+3TY+kP2fDnWItXt3mLBpHUfVUvJL4qEc/yWluL0GZbwLRltdQG45Rd
         np/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwGpVmmdGQeR/qGIkhcoDSEATGXATPGNCumFqDZ/J+aS6oSC3GqdtEXCkLtXpDQi8JMKGpeeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHktnS8bEA24nXnHWR3/umR1mYyJZBDgxn5YDBiX2bRJB8kGV
	J09VPBWVKMhpZx5Ns9hUEzeat4bRlF6L3iRh/9qGlPDftfTS3j8G9nkOCveDYmu5VVEN8uRs6Ke
	9syJW/pVPqycGVqlr84Bsir6lQpWQoDMFXZkgLD4v/ztywIBEekZ/4Jt9A58kb8fY0RaFs2/+W/
	5SHFbHvM9FtOJ/skzQbwI/0YNmzr7d
X-Gm-Gg: ASbGncv2w5UhrXoBZL8ngYYjYzgQj5K+ygkk7vFiUsn2KBXa4P1bI3XR9MnqgfgdHKN
	VEKRYC9KqN7OMoPGTp3GJxifKLlJy6fXW32zXN3+zMq8hwsX+FDescfiX3P9U2kmZ3YwAVw==
X-Received: by 2002:a17:90b:184e:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-301a5ba9e76mr360760a91.34.1742257763156;
        Mon, 17 Mar 2025 17:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOGBbCKgtLfnNUEqdVYBOyaNX4J8YQ0wrsnqj7PZlK8HAfiTPLx5TPUO4ZzYQvRfRq3UkxLbm7lMIv7cr07dk=
X-Received: by 2002:a17:90b:184e:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-301a5ba9e76mr360742a91.34.1742257762833; Mon, 17 Mar 2025
 17:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:29:09 +0800
X-Gm-Features: AQ5f1JpeJNqrDdWSKhpRoLtJXf8LNGibcE3CCqsOw8cQQUTRxkqjeK2TKIkholg
Message-ID: <CACGkMEu=pPTd-QHKRDw7noRCTu-18c7JLJNKZCEu5=BHAE0aJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 00/10] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
>
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
>
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).
>
> The patches for QEMU to use this new feature was submitted as RFC and
> is available at:
> https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/
>
> This work was presented at LPC 2024:
> https://lpc.events/event/18/contributions/1963/
>
> V1 -> V2:
>   Changed to introduce a new BPF program type.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v11:
> - Added the missing code to free vnet_hash in patch
>   "tap: Introduce virtio-net hash feature".
> - Link to v10: https://lore.kernel.org/r/20250313-rss-v10-0-3185d73a9af0@=
daynix.com
>

We only have 2 or 3 points that need to be sorted out. Let's hold on
to the iteration until we had an agreement.

Thanks


