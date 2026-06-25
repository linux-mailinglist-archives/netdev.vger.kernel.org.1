Return-Path: <netdev+bounces-301966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y62/IIk0PWr7ywgAu9opvQ
	(envelope-from <netdev+bounces-301966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:00:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 596986C6574
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:00:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hNibVxz9;
	dkim=pass header.d=redhat.com header.s=google header.b=RLdwYRen;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301966-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301966-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33623011786
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EFA347BA9;
	Thu, 25 Jun 2026 13:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9248348883
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 13:59:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395944; cv=pass; b=iAUCOaOg7i0OA4xZ5MpKya/uU4ANfBCWdqtiqEdsnwL4b7P/GELSVJZKcsrfCooaculxlNzFAWp6hpguDiMkeXMHxGmonWzg6+acD8RgzZ3y+PE8oud8pukwxWnY4liiao9DVhRnhnKcNFrl3jLjRoMhWLqYzMOPJ1hs2J5/pvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395944; c=relaxed/simple;
	bh=09kGKULuxwNRdpnt9MiE6ht8gMXa9r8db2ODWamPlG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIQIURIP+EPkt7XHidd5p3R7KrUyGe17N0Wj6yGarGCz85pD02nfhTnKyXH3xTvYtRNvKLJI3QE9PXOB6mFO5CVykfLNgsE4axrLvM2mPvfLOrNd4Kt7jdaC8a/VAYrO7S8ADCmiqqH0kyz4/+LMB9XseeqD8dFEv1Rx0AAtLYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNibVxz9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLdwYRen; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
	b=hNibVxz9AARGUlrFK4j02kevS9oOccrZNB6u5EjK9ZheP9AXPNSVj2VmbzqZ+YLLnCZHdY
	mEsPCcosWV7DMxjAGCWfQ4YDiDJ9MTR27/vdcX+BIGcf+3dgGXFkrfnNDkEXpFj4VcmdO7
	gR4/X/HcAOZTPjhNvh0H/1vuEg/NRm0=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ta_KWjxiOyaXVHDafoKvQQ-1; Thu, 25 Jun 2026 09:57:36 -0400
X-MC-Unique: ta_KWjxiOyaXVHDafoKvQQ-1
X-Mimecast-MFC-AGG-ID: ta_KWjxiOyaXVHDafoKvQQ_1782395856
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-660d7f1d143so3636575d50.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782395856; cv=none;
        d=google.com; s=arc-20260327;
        b=W0RPvDxY8lrdEqzLmgGG2Dhxza5uENgJsSDGBFUA2c/wd4dEKwNG6kZhkWXEsrhNG6
         2y1jBaGbZwXxNz/148oCXz+k5QN5WV3OhauuoBhchNa9G0U5AvBUeDD/V7tYkWJNuNVp
         8Htur8X6ttfG7XtzON0Y0aMBw6drdFX8gi+5Hr2qgwzYQy8PTb74MSQcIcuPx+Dnk7F2
         vRU4eCISkWiZnhdMuMRPLljHWCmLYBr40IcMUQLTx0LRDNSGbkSZIJrQOF3HBz3e9b2G
         uo0+Fw2hB+xLs5/1Mxz2YY5zzVlpyFNdh+SaGzhyK/5lbAoAmxXS3nDXBfLk/iasfc7j
         j/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
        fh=Ksne4LzhAhKTi4MaUNk+33lxx2pIjld2xMFu4tNLWfI=;
        b=IE6Lw4PUMeneuAABgM8CxSXsX1ohJq0RUbTi+3sy+c2Vl+UtkWsujghpSA2xcR5DYw
         Y3WpUWcVMRfgxtHWiZi69jtH71LcGM3qhDVwyBMeYyDkEtByuVBy7mv5u25P7gitWVXs
         LKzFr6GxZ9KwoCu4Q8KDxndqkMdh/CbxvC/M7mpwVnkrPCzmtSiHCxWdOaUMC5x/snNA
         PM01Rxb5cfkipR75AtTmd3gqj3QylEjaZ+rYh5QIZANyIEm3SuzyJHX7v/6O7MWLoR84
         svhr4lO6TIZ8kBK1zALcNC10mG2AH3teJCujuqNLqXNFThedOC0WA80UuJU5eXQ3UyV8
         Drug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782395856; x=1783000656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
        b=RLdwYRen0dW4CkxlAw3QordlhwpJKtaCTg2zS/uPJ+dxrKH2CYUvzOZ0HKDhIp2ubD
         MSpP42gYfXcAGZYC1RE0ZEJ8Pj3nMmWku4QEgifPQCqync1aoN67QMeFP4c76TlIFlyB
         wmX/bWWcEeRg2lEchp/PLj/Rx1rFxQG9DVwfUIhyYAgjnv6yJG4Q4CrjcS/UPU7MHeNb
         fMIZko1J8LneVxoRwwTqSg5qGUJ9ptCs30tVzLQh7yvytlsSdelwZWl3pN++y8cg5a8F
         CWgRnCLyJwtzMtlvMb44INWHoggHr44y8kzENljxQ8S5oRAdJ9eD72u1kkw8bjujHWSZ
         G0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395856; x=1783000656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
        b=cwWzJCuMvKv2Ds/ipV1dvBqkfg/aM7Wzl0dPWjlIPf1J0PdWeJKMFG1wdei7Jpa0FK
         pb5zpX2kzhnVN0DcmVOEdhka+4veP/ZPvolPqGGNJnyoWZAt2qLSEKF7jr783PkCDjGr
         ceVu2ITcNjXw05HsocrzTjaqjI7+2ulivkus/aWwYG/0FI0OZ/AvvA5KdgE9BT0M6RRX
         J7SxNjSWFRGAqRop8N1NG/yAjaTeBAs32vjILQFi0LmAQUCt29eAgoyGBvEwk8L+Lbsm
         33pFbeRqC/W9X+yryFVGBCZkWV0SbrA1glK1hoDBC8jodZwHSiHlUb89u7FgEc9Ao3Bd
         ZYOw==
X-Forwarded-Encrypted: i=1; AHgh+RpL5I91nNC8lfSZFWYEz6VZYY7ImvZ/p5OBLM4dwJFBXBA3OlG+JplieaO1noCx0K+/ijH6foc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycyPdcdqkjbYSBFOEZQzz+AnvZAKViRDMFoDea3pmVDZ8s0/4w
	f/TFdycoA3rreZKY5qOUB2s15dZiWg1/5PLvTqM0fkg6shC62psJYS5s4Wrbdz9ECvBWCvV7FUs
	0CBv2Bb8mDp7BTwBfc0lLyc9v4TteBFS0CVWqg8jxI3+TX8WPOCVJ2miYA28Nz1AKJWCOF7yBy0
	0TMUcR+7A931pW1TdZlmgOhHbMLkEMmmQz
X-Gm-Gg: AfdE7ckGKk1j3xQg5dftoRp7Dgh23wwSM9Fe9QVQs+y9tdJwLjgFYf+kw1/JV2qHAnn
	l7gz6N4iqvPlYVk+ms52xXeBT0FIza390QjDAGH0umu6hy8/Lt7YxXfj9C8AiioeZ0xsNHbFPtu
	9iD6hgvMRRyCHem6F4OlG3suopJrOta9ZR8EumwMiOSJsu/2kebLr3c2bxpKkTv3IfkZ0=
X-Received: by 2002:a05:690e:118d:b0:664:9032:656e with SMTP id 956f58d0204a3-6649032684dmr1013791d50.17.1782395856185;
        Thu, 25 Jun 2026 06:57:36 -0700 (PDT)
X-Received: by 2002:a05:690e:118d:b0:664:9032:656e with SMTP id
 956f58d0204a3-6649032684dmr1013773d50.17.1782395855647; Thu, 25 Jun 2026
 06:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526080336.61296-1-r4o5m6e8o@163.com> <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
In-Reply-To: <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 15:56:58 +0200
X-Gm-Features: AVVi8Cf6xgF5zkdsxl65CjXk9mAqqpZ16WJN5rElDgN4AmLJNI0ZYQtf2VXrmew
Message-ID: <CAJaqyWeGTKZB7BCHV4MzjRsg0B43qoTDCYjUKvqyyAjyB3edqQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301966-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:r4o5m6e8o@163.com,m:mst@redhat.com,m:jasowang@redhat.com,m:pabeni@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangyufeng@kylinos.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rom.wang:url,kylinos.cn:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 596986C6574

On Thu, Jun 25, 2026 at 3:48=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, May 26, 2026 at 10:04=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wro=
te:
> >
> > From: Yufeng Wang <wangyufeng@kylinos.cn>
> >
> > The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> > at argp, which is the beginning of the features array, overwriting the
> > data just written by copy_to_user(). It should start after the copied
> > elements at argp + copied * sizeof(u64) to only zero the trailing
> > unused space.
> >
> > Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> > Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> > ---
> >  drivers/vhost/net.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index db341c922673..70c578acf840 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1777,7 +1777,8 @@ static long vhost_net_ioctl(struct file *f, unsig=
ned int ioctl,
> >                         return -EFAULT;
> >
> >                 /* Zero the trailing space provided by user-space, if a=
ny */
> > -               if (clear_user(argp, size_mul(count - copied, sizeof(u6=
4))))
> > +               if (clear_user(argp + copied * sizeof(u64),
> > +                              size_mul(count - copied, sizeof(u64))))
>
> The fix looks good to me, but why not use size_mul() macro for copied
> * sizeof(u64) multiplication?
>

Also, could you add a new switch to tools/virtio/vhost_net_test.c to
use the VHOST_GET_FEATURES_ARRAY and VHOST_SET_FEATURES_ARRAY instead
of VHOST_GET_FEATURES and VHOST_SET_FEATURES?

> >                         return -EFAULT;
> >                 return 0;
> >         case VHOST_SET_FEATURES_ARRAY:
> > --
> > 2.34.1
> >
> >


