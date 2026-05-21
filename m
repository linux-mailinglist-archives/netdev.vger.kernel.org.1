Return-Path: <netdev+bounces-290279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCYRM2bDDmqiCAYAu9opvQ
	(envelope-from <netdev+bounces-290279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:33:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD25A11B5
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00099309E199
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907D5361DBF;
	Thu, 21 May 2026 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8VZUagU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxFd7xv9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC035B137
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352050; cv=pass; b=MSFF8Lek0Aio+oNE2xbQvfxUsrMKZm5RVrnxygzmll1Vn4eO+w+0McCWtA3Ab8QF3Prp9wHzHQUEUCnmUaYa8lKrxgeXpaKyayiBkcKctDlqg2B6qaXc8mxFoXLSrErNN5SyIzBr6uGzvQ6021gBQNxpihkamnpaoD3Yji7FdNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352050; c=relaxed/simple;
	bh=Mea46XcA70zxzmyZqyD+qyEd3ZA9s42FFfqINPOE7cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBzVqqqizF9trxelcMtkvxD434Il/HK1bMDCjIV31RNL5Fw2V8nF0MwlyVefA7b0dP1DvjuBsVdDGTo1KdByNA8y+aVFofzhTKbcesLE+ZA8cM/5XzUEbQ2WdxveeoCvgurPxdz1PaQJspvug9b38tCBkgfWTDPghEPFR74UwBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8VZUagU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxFd7xv9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779352048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
	b=U8VZUagUhR3xhguPgv+jzwkwgNboMvr8k1lCViWaoXh+BTOH8D0WDglE6S2miRz9tUVcif
	F6PeZY8XWmBJLoRXo9n2i2IOPLhCfEUB3LtpUZ8KK8w3giZ3PnSS9ratQrMj1GzCGDxsHa
	nJJH/ILS5maOj11iX90whB9hcEv3s/M=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-z4FvYmoXN-mQY73zLMfIcw-1; Thu, 21 May 2026 04:27:26 -0400
X-MC-Unique: z4FvYmoXN-mQY73zLMfIcw-1
X-Mimecast-MFC-AGG-ID: z4FvYmoXN-mQY73zLMfIcw_1779352046
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-65db7715a7eso2218657d50.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779352046; cv=none;
        d=google.com; s=arc-20240605;
        b=NwqpBCZMbTbgFQ6akcr2ouiqUH2gApJ5EmX4AB+kWsint27Tl/+qud3XjybfW6cLAu
         FCj+Y+qDVQmDl0MUnOhMsj/1qx4OpnqL58g1I8ifE4JExDvBbCaiJg8844F1oqTcZ3VZ
         //bKdzudfyuQQx/INgBTt+8MGfhzFwYRSbvh7s4/a1eHHXZ/gFuDHj5AqcWuoYmEOetf
         Vu+/0iI6BSR8V+8OT3xkBSX3iD1EtOKE66qiZ3gKluc9O+MnNDnJGQ5aYjPEfuck9T7N
         JYWQdcqCjedG94H74VOeQsii3wjHeepAUpVxRVedijPVJq+BfMWxQCUkeqKZk4w/zlIT
         KiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
        fh=4uzLhCs6Suw8Jewm0pzPBkaoKaa3ghLXolxFTfJHmUc=;
        b=QRs2WrI86dZD5xMrgBSkAslnkIvZoekY0eY58tzOb92LXgZbDXHCEYaeyDBZ/Iw/1D
         hoSbiN7h8lg9ACJC3Z4kjXuoWfanxSBBaIyx7yJdzkMrwHoGZllUEkLplpBeUoPDgNZj
         5DjWHCuslQozZRRZIZ4/bn00VFPCh0/jFVDBs4xxd9DcXhZjTAM+Quuiv4S5PpWmjM/q
         lkdLCh1DDzx4zfqME0iFox5ziic0q29fYdMvdIu0Rj0KshmWiCIp2qGg+Xys+TmvP3Bz
         otvrsQlnjmA0ENgWPCWf0DpmDO8IjEuGw2povLqweiTNYaM8g4SLa8nwigcX7nDp9BWG
         irAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779352046; x=1779956846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
        b=PxFd7xv9n5Lh1trRRIkPAY7LZu/Wzo99r+UATtnqVECSVvybuDD50SwCYpEQGqL+HJ
         JwqBIi28MkizhMFkuAGDtzTrHe4ARSxKLNteND8xkg4vWudnbnVsMrpa4FKa6vLmhN8R
         XL4uBRm1nVjXxh+V4yC56DwYPFYlunqsJ9yrbGTT0nykdfj46Ew84JCaqzkFostmSZU5
         bKsl/zlglluoYTLSu7naM4KINIBnNBBDtHrkrfpbSCKckwNgWto1cknNmX3FlTP5vzHX
         Z99RfWf/XFq13hBMQiIReak6cesY3flXqusRMWkFY5HGb1kQgqCk3ny2/TeRDmDmbXBW
         qiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352046; x=1779956846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
        b=J1xPtG7cCf/8eOLOTYLvSFofvXP+Gl8W5rSSueslj5qqzieuRtHVhuq0lVIY7jDDQQ
         SuVbORXKA2VXYeEvt/1swUJQz20xdkJqPtuyGOIUuAii3pXQfQpLt6HvJ9aQKWmge+ZR
         NmnMuq8Q23X5sf4AmktbGTm3RMZ2nkUkIeVcV/3F+pcsdk8g70HDE7Eb8js//q3IX6b7
         F84HuR+gzZch8u21EvG1WH0m4g51X9X90G0SWV+Fx8+TAVbr+N7LfB8CiJ9+VqxwXEaH
         THqZoRE2xTD2IphbyEjpwwlZuuokVObdyVFzqMD2Ta+109kVIGzCuhDDJ0z3/SsVYWjm
         jRZg==
X-Forwarded-Encrypted: i=1; AFNElJ81nC7UpTkFcQ5DgykTzXMp+tflsjzQIslWlgeztzVLeakTQqvma0i07Rjvn1SOP0r1ODXOI6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQeJuUPLCzs3CdFYcfKibLlm3a0pQGQ9ImpKzEKgIPyRGUnT3T
	q1MsZJ9lkDXVjdBX02XZnAL+hxd/ry+4JlnKu+rr0XTogpOIMkSV2dTq5YhC6GKxkf4V1ir4yOB
	eIwoOjl0oWft6Dk9PtzWVgaGwzM4Ex5iM/WO+klS2k2W4FVzZQDhfemv+8DjfkChq1yU+gb4nN4
	yomNHl38tY8kaKIvEjP5APf+Pcui75LYXx
X-Gm-Gg: Acq92OHneXeIWPpCRBT9TvBXHP4vHp+AE9Cx9sGaSm/XhgUha9UR9sm/jJ8+pScmfsx
	WWohUnUFXVDilOMOqmF94/4L7ggLiq3IvzN2zTVrusC+vjQlAlog054uoIxFZtx9Z2Oy3ZpaouG
	RwGOcai+GsaTCWssceKFaVBWi3pHLUglbonMnYsoanze6N4BR6qtPDDHotXXPtRVvhJXgdxmdHX
	3J4X+C5ae3J9Q==
X-Received: by 2002:a05:690e:400a:b0:65e:3df3:1c71 with SMTP id 956f58d0204a3-65eae3402d0mr1402734d50.43.1779352046124;
        Thu, 21 May 2026 01:27:26 -0700 (PDT)
X-Received: by 2002:a05:690e:400a:b0:65e:3df3:1c71 with SMTP id
 956f58d0204a3-65eae3402d0mr1402702d50.43.1779352045681; Thu, 21 May 2026
 01:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511094504.1619893-2-dtatulea@nvidia.com>
In-Reply-To: <20260511094504.1619893-2-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 21 May 2026 10:26:48 +0200
X-Gm-Features: AVHnY4KzvfnK96jq_WEM08qHvg7RJR8HuiYmXJ5atCT1OCaQOTYbbzhAXG5NZTQ
Message-ID: <CAJaqyWc6gA=TU-YMYdttH3_MjBo+644kgmah1XZnvxP58Gxzag@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Expose ASID group change after DRIVER_OK via
 backend feature
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290279-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6DAD25A11B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 11, 2026 at 11:46=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> The commit in the fixes tag blocked VHOST_VDPA_SET_GROUP_ASID operations
> once DRIVER_OK is set. That is too strict for devices which can safely
> handle this during live migration flows.
>
> Bring back this behavior under a new vhost backend feature flag. The
> feature is supported by mlx5 and vdpa_sim devices.
>
> Fixes: 3543b04a4ea3 ("vhost: forbid change vq groups ASID if DRIVER_OK is=
 set")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  3 ++-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |  3 ++-
>  drivers/vhost/vdpa.c              | 13 +++++++++++--
>  include/uapi/linux/vhost_types.h  |  4 ++++
>  4 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ad0d5fbbbca8..f89177957c76 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2906,7 +2906,8 @@ static void unregister_link_notifier(struct mlx5_vd=
pa_net *ndev)
>
>  static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa=
)
>  {
> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>  }
>
>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 f=
eatures)
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 8cb1cc2ea139..253c7fb35ea0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -428,7 +428,8 @@ static u64 vdpasim_get_device_features(struct vdpa_de=
vice *vdpa)
>
>  static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
>  {
> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>  }
>
>  static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 fea=
tures)
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 692564b1bcbb..67b3f49fa709 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -682,7 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>                         return -EFAULT;
>                 if (idx >=3D vdpa->ngroups || s.num >=3D vdpa->nas)
>                         return -EINVAL;
> -               if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
> +               if ((ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK) &=
&
> +                   !vhost_backend_has_feature(vq, VHOST_BACKEND_F_GROUP_=
ASID_AFTER_DRIVER_OK))
>                         return -EBUSY;
>                 if (!ops->set_group_asid)
>                         return -EOPNOTSUPP;
> @@ -791,7 +792,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                                  BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
> -                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
> +                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK) |
> +                                BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER=
_DRIVER_OK)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>                      !vhost_vdpa_can_suspend(v))
> @@ -805,6 +807,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *f=
ilep,
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
>                      !vhost_vdpa_has_desc_group(v))
>                         return -EOPNOTSUPP;

Ouch to me here. By reading the errno manual:

Nit: By reading errno(3):
ENOTSUP - Operation not supported (POSIX.1-2001).
EOPNOTSUPP - Operation not supported on socket (POSIX.1-2001).

I picked the wrong constant even if they share the same errno value
(by the same page of the manual). MST, is it worth changing it?

> +               if (features & BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_D=
RIVER_OK)) {
> +                       if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_AS=
ID)))
> +                               return -EINVAL;
> +                       if (!(vhost_vdpa_get_backend_features(v) &
> +                               BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_=
DRIVER_OK)))
> +                               return -EOPNOTSUPP;
> +               }
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &=
&
>                      !vhost_vdpa_has_persistent_map(v))
>                         return -EOPNOTSUPP;
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index 1c39cc5f5a31..ec1ff8a2e260 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -197,5 +197,9 @@ struct vhost_vdpa_iova_range {
>  #define VHOST_BACKEND_F_DESC_ASID    0x7
>  /* IOTLB don't flush memory mapping across device reset */
>  #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
> +/* Device supports changing the group ASID after DRIVER_OK.
> + * Requires VHOST_BACKEND_F_IOTLB_ASID.
> + */
> +#define VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK  0x9
>
>  #endif
> --
> 2.54.0
>


