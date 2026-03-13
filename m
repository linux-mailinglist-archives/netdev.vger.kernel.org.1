Return-Path: <netdev+bounces-267297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D49GM+qs2lWZgAAu9opvQ
	(envelope-from <netdev+bounces-267297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:12:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515727DA77
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 973B63027C8F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 06:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF8331215;
	Fri, 13 Mar 2026 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPIYD5Jn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9owTPyD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D01DF980
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382224; cv=pass; b=fvMKauXYGIy52y/pr8tLKKTmj3vjCoaX4YGvvVdDL2sxHX8ZmeYLOrcsFCTiX4Y7aDCVktalPq4lZDjGL/zUhkaDi5IgjgdGIfUVYqleNZZ8GO4665vnzhWBd/SeAVoulzxKQAuTEXR3eBjm7P/8/NTTt5cAazIBQ50amGV0TqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382224; c=relaxed/simple;
	bh=/iR6H4jr1ARWE/5biMkgTQ9VIqRD+A+nSoB7kUdSyCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPcZ3/xNsCs24HI4oOce/kaHohHPl31T8N0bFfiFzsNOhj5Y9sJg33AARJ02hmo2S4C/CjuH0r7zFkMgicAJA9F0y4RpQR/i9U3+e9N8QIYqzj4WAz5sH9dqVWugojTpELXM8jmnMtsC6c8NNtM/GAW/dZq7xpTVny+cR4Fz7JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPIYD5Jn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9owTPyD; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773382222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEKsLbbuK4rqjcbBkQvwfGzKzEsUkH5eDtzU9/JBt0o=;
	b=TPIYD5JnZ80v5rkh7mo/hOMDFEbKTNXUEqJDkz67btypJ0LZ3Sxa+6dJZbjdqTderpECen
	11nBWWoTUTPjAcJuBK3qKXDnsF/LI67gRKGSx+1Us05zZjrrQqa0/2QByh+P99/ImQ+0tB
	BEe2rAmHYvrjqyi7FpUEVfnB+cAjz7g=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-DEJhUrMpM5i7LtLAb0vrog-1; Fri, 13 Mar 2026 02:10:20 -0400
X-MC-Unique: DEJhUrMpM5i7LtLAb0vrog-1
X-Mimecast-MFC-AGG-ID: DEJhUrMpM5i7LtLAb0vrog_1773382219
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7385a1476aso1029496a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 23:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773382219; cv=none;
        d=google.com; s=arc-20240605;
        b=lMAhjYlrDid6Vpbr+aO4FjGGAtnpJ9slcQfT14G/7tGlwgAytkwEKRjNQWEXdE+cZn
         KNvuv8cqgCXtsFgcIgLLOyJC8KlXjiQWSsrs0znYLYO+TB882EH7YmblUeJeFO+6+eZU
         nJUnSAOLHET3fEh9b+w/9Nbmsuhj5juIEZP8Z2PbsAvw0rzhmw7RxzAwvqJzyPxn59bL
         4cfOf7dD9UqjqT254RP433QM9KWfEP3gSR/XAkzgsI0oC5cWrbRAfinRFRANZNHQFwCX
         Yc7CJSqyadAQqw/Lp6ugzz+3VjzPA4faVxz/0KOX+Il0vHAa8aqEZtHGEp9xM8biF8Kr
         1pOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SEKsLbbuK4rqjcbBkQvwfGzKzEsUkH5eDtzU9/JBt0o=;
        fh=gXsNRxoOaFEQezcgbjVKitfz7JxLH0hp+CKquOLpHMU=;
        b=hykJmIUpRaRHVW8OEnBcHt/sZPsw8qEwSA1lcHvEngJT76jaK1yCuef73UbuTR4D9e
         D8WZKyqtPzEyjL9wj/P3JxyLlyJ8UJ46HyJ+rHah3t3ptueCfvbv46LEgI7hBG6kdZRt
         tCpKV3KT97yieKdM68R3AV6WhzO3WC/y3TvAduMxMfN9V3QA0ejGAYL2pr8Xh1seDxZ1
         hIG9Qy4wu4phSRTheRqdTg7aJx+/8/FMr+IWt3Od1vXXAKNnv+cmgNu5ZCeIT2IK9wK0
         HcthOau6cP2r7nS+Ff6tJnOJS7SNAYnJ4BeLvUVvbIpm+riCTBmr+kpsO3EZ2/49Nee9
         r2ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773382219; x=1773987019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEKsLbbuK4rqjcbBkQvwfGzKzEsUkH5eDtzU9/JBt0o=;
        b=i9owTPyD9w/GQNSKUG2mgo11XDxffAhDPjUv5x0njL+voY/f7lShL+rjxIIiyzB8oH
         Wb6vDgEwgFcgdRg9mxbsYODvVuSzEpWSyJXHW7frruVbIgXQZiha810zxynu3PMouuLq
         2spESxqvhKBzW+Zmpa5utJ2t8fZiIcDNTQEXjLjCfOsc3tcPcX4hZ5ISfgQNCYa+B/ch
         OszsLVFwZRQdSp4hf/88o8Gip3E9EhCkm0PM5qq7RlewxdbTfxc8BsMC3MkZpEMKBzWE
         5bGS9s0q7cEmtrmN5aWG35TMQxHndwOubB1r2yG+B7z30iaObBCBU42JU/QpRcAVqNaC
         gP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382219; x=1773987019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEKsLbbuK4rqjcbBkQvwfGzKzEsUkH5eDtzU9/JBt0o=;
        b=Uf3+Nu2curYUpCuC+7nO1M1QFjuvUvZ/ArlwlsIyC7O/eFbzobt2FQ0fWN6OGadtKr
         2rbLZ+svt8IEJVi5LG0+ZfmVNocqw5xBsX8EFbKduLkfOIx9whhzoAKKBkKWOT0CLygz
         uqjkrSbQuHFeZ3m7yI9BdNQPCgVvPwz5AdpiSPs7FW/kkVRX+yjrsAdVbpkbhnbqUErq
         h2C5JcPiHNfyYAauTWNS0kIfbFWs1udrxoZUWRdpVEooO7v4071IVGhWKJZEeGs2beSN
         fz1SSuTKYsDvjvMo9fqioxYP/F0X4rYXNiEdeqjEavTkd81BDps0Iem9aDv2FQ6zO5iH
         bOKw==
X-Forwarded-Encrypted: i=1; AJvYcCU9iq2Ccj5vUEDNZSex+f+QwMben6ayh5T03Ht3hBga0XOG81jUl8FlIvjRl/rhXG2UxRrEaXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rjBEzI0Prn9yQ6vYM4JUq4VaB0MtyPdorLuE3y6Y5wZY5LrW
	0LBTecvWoASZW5AY67vfMP43WyX0uK9RoM99F34+czGdB8li4Owsrdz9IqTuB2cB7MLmzKNjsyX
	+we83OEZQ8uevCFGIUsZW2j+iPAhvLbv124C6gY477wZoP+j5MYDkToFN5HF5H6g5id55DMrvwT
	iWC/402OKh7f7rfPMBY0D1yOKRtN3L758V
X-Gm-Gg: ATEYQzxj9nvWLw4PK+sDI685vRSlzn1Y7KwIipPEyQIOKTHPmTf26LlCTXQLFfLzq5S
	bOCJoJjoqFhcBIBN2BDcIvMiAUnzq5WssVS779pDNmPi8jWGwg7S3xH2J//VPVtd51eyqTy2vHf
	xyD7dwahmX5zIGq/2ArOSZP3GWZpAM1kXXGFWAiM+0mD1M126z0iZrN+/n8FBzgXKFcps1QIzJF
	bw=
X-Received: by 2002:a05:6a20:72a4:b0:398:c0ba:9ceb with SMTP id adf61e73a8af0-398eca31fb6mr1855047637.12.1773382218935;
        Thu, 12 Mar 2026 23:10:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a4:b0:398:c0ba:9ceb with SMTP id
 adf61e73a8af0-398eca31fb6mr1855016637.12.1773382218487; Thu, 12 Mar 2026
 23:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313013040.896924-1-zhud@hygon.cn>
In-Reply-To: <20260313013040.896924-1-zhud@hygon.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 14:10:06 +0800
X-Gm-Features: AaiRm504cXpHm99uEXVGnGiUvzq_5LRcfaS9FMPZmiSnxPRP_JS7ljpAlHy91qU
Message-ID: <CACGkMEvwR2WWyKvho-WU=_06OmWsYTSDSkML9JS9pSkzOQVkTA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: clear NETIF_F_GRO_HW if no GRO-related
 offloads are capable
To: Di Zhu <zhud@hygon.cn>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, lijing@hygon.cn, yingzhiwei@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267297-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6515727DA77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 9:37=E2=80=AFAM Di Zhu <zhud@hygon.cn> wrote:
>
> Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which indicates
> the device supports dynamic control of guest offloads, it does not
> necessarily mean the device supports specific hardware GRO features.
>
> If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such as
> TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable, the
> device effectively lacks the hardware capability to perform GRO.
>
> In this case, NETIF_F_GRO_HW should be cleared from dev->hw_features
> to prevent the stack from attempting to enable an unsupported
> hardware offload configuration.
>
> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> Signed-off-by: Di Zhu <zhud@hygon.cn>
> ---
>  drivers/net/virtio_net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..49a60af684d5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -7058,6 +7058,9 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>         }
>         vi->guest_offloads_capable =3D vi->guest_offloads;
>
> +       if (!(vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> +               dev->hw_features &=3D ~NETIF_F_GRO_HW;
> +

It looks to me the root cause is this during probe?

        if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
                dev->hw_features |=3D NETIF_F_GRO_HW;

Thanks

>         rtnl_unlock();
>
>         err =3D virtnet_cpu_notif_add(vi);
> --
> 2.34.1
>
>


