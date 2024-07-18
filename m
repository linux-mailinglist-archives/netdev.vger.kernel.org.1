Return-Path: <netdev+bounces-111978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C87934573
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B9E1C21443
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 00:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A11B86D0;
	Thu, 18 Jul 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUHoXZXn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126363A
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721263965; cv=none; b=BDMGEwmE0WMIXdCR40MYjrcQ6yChQ33hpOcUMvl+oSuUFKp89bXT8Qs6ebbIMENjnobWutAJUz8sH3bRtxV2gpbGiq9VwhsZjmjQQ15eqA/tG7noLh6pC45pTBQrZ7pGf1iwtwnf9jVuZjoOXHRu4AADkBEwhc97LKguaKZZDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721263965; c=relaxed/simple;
	bh=esd7lYe5iq+onNX9j0js0Xwd+FXvQRDJiIeVuo28nhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9nRQCgScyCHadwPFTyGIjn6m7PMzxK8KKPbxDQwqzFx8Axwod8WwRzM120Z25yMnFqY1E/9U1x82V99dh2qAwwdz4dV4EYnzvEJwJ+oYA8/OrppCMitr/EADGhVmLxApAHekW8lDABY9luhhrdBqqjbyxm0eULGfbHyEmx/11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUHoXZXn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721263962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AodQvD7UxAvNv2pUpx69b2DHyG8xaHJX0frFiPMlh3I=;
	b=GUHoXZXnQ0jT/GaD8XAXtk1pEViDje+/t9q2ieOMv8zri+jSAiK/qBknyStQziSh2JZGfF
	OgeL1s62E53mBekPGHN0LJPb1hhEBari9m8eJUwzYtq7bxWCVtUCxyvie/2z3z45GB7KeM
	9UO+XEaGCC5qAByf5i0cvB1f309+8Mc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-0Oys8PCHNyuSa2hcTjYMXA-1; Wed, 17 Jul 2024 20:52:40 -0400
X-MC-Unique: 0Oys8PCHNyuSa2hcTjYMXA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3daa9f23fc8so360978b6e.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 17:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721263960; x=1721868760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AodQvD7UxAvNv2pUpx69b2DHyG8xaHJX0frFiPMlh3I=;
        b=NGjrJb4dv+xVHyy5fRYrYLNHLLcIIpc3gxsmpvaHWvisnYAAdcA7hheFF9NpWiGtij
         9UmiL0m6DCH+sIws3eDE0hEWnKE6wA4sXsdUIiX4Pf4G3ojiRCYPwcUmrmDnX6k06E/g
         rwr9zuS6XTu/cMOCN2sHNCTlFSBKEIwbmmnsx6LdtCOP2vdaL7le6N8tpA6UomhQLVH/
         pWML2mixv3sHijPxET0pYCamL3snRWz8wb5p3zea3Kh7UwZcYkIjQ8lQA9PyZtbZRVjo
         lmkEHZdKC4iFDjRzP8OkSsmJ7Unc1iMCWkepvLmnvR17iurZsGjG3UMSLI3zPfEWodXo
         kCig==
X-Forwarded-Encrypted: i=1; AJvYcCWXCv1dYcqRM0ncHviV/no5QFlE2W2ikyvJYUfvVNaxKozCbTveGVcL+QRwxaHBWJSDpXy/zmPcI0jsOorNBPUUElqLsdJY
X-Gm-Message-State: AOJu0YxGO15vJ4JnfobHabIzY6sCZ6j2SpWadbn0PH6snVRLYeS/ESIL
	z4mbSTROeIwWbrwL3F+DT1i6XA62HajTggrofd/7djdq/iKbAVdNw+QyqMoFKw0pOIkiMT3IR3o
	np4/y4RsyGUnr+dz18m+po2x4ZwntKfbNI+u5pbrJOA2odj5VPgZ6wtVdmzD9sB0JXQ1fNAGeDi
	MWBo32CrhGkha+PER3g0CpC6Eo+RnI
X-Received: by 2002:a05:6808:1a23:b0:3d9:28d0:fcdb with SMTP id 5614622812f47-3dad51eee14mr3145963b6e.12.1721263960079;
        Wed, 17 Jul 2024 17:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9h+0U2xvRbnvYEIv1j3r48AzVXHuxA2+eaNiLAp0VT0zFKA+GDu9vEaf/3S87+CdfT1c71ctDFijpnhuen/I=
X-Received: by 2002:a05:6808:1a23:b0:3d9:28d0:fcdb with SMTP id
 5614622812f47-3dad51eee14mr3145947b6e.12.1721263959710; Wed, 17 Jul 2024
 17:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717053034-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240717053034-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Jul 2024 08:52:28 +0800
Message-ID: <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aha310510@gmail.com, arefev@swemel.ru, 
	arseny.krasnov@kaspersky.com, davem@davemloft.net, dtatulea@nvidia.com, 
	eperezma@redhat.com, glider@google.com, iii@linux.ibm.com, jiri@nvidia.com, 
	jiri@resnulli.us, kuba@kernel.org, lingshan.zhu@intel.com, 
	ndabilpuram@marvell.com, pgootzen@nvidia.com, pizhenwei@bytedance.com, 
	quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com, 
	sthotton@marvell.com, syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, 
	vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com, 
	yskelg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 5:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> This is relatively small.
> I had to drop a buggy commit in the middle so some hashes
> changed from what was in linux-next.
> Deferred admin vq scalability fix to after rc2 as a minor issue was
> found with it recently, but the infrastructure for it
> is there now.
>
> The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780936b=
3e:
>
>   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/pub/=
scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_=
linus
>
> for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b3163:
>
>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07-17 =
05:20:58 -0400)
>
> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
>
> Several new features here:
>
> - Virtio find vqs API has been reworked
>   (required to fix the scalability issue we have with
>    adminq, which I hope to merge later in the cycle)
>
> - vDPA driver for Marvell OCTEON
>
> - virtio fs performance improvement
>
> - mlx5 migration speedups
>
> Fixes, cleanups all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

It looks like this one is missing?

https://lore.kernel.org/kvm/20240701033159.18133-1-jasowang@redhat.com/T/

Thanks


