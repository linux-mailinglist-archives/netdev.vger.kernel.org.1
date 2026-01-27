Return-Path: <netdev+bounces-253746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHMpLBJyeGnEpwEAu9opvQ
	(envelope-from <netdev+bounces-253746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:06:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2879790EC6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33CF13038FF8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050402853F7;
	Tue, 27 Jan 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPGh519B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="INgneyKm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33C2580EE
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501192; cv=pass; b=joDMU9Gf0XVq8CwMDmCm2kzqXALXap9FJzsSRdswbzA+ktU25mCq8ucIlyWhOvdnwHAPIvnkvF3uDlhv678O8AJemEMLafzq4JQOkS6SCiiQgu4qBrxRo0hRXKShTuI4Did3VGATvAiS1W6looF0xygJ0PPYNuk0PoS1nahWxRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501192; c=relaxed/simple;
	bh=TTzX35zi7e2uDGzGbD+UvIWRM4CrGZWHR2CuACTNbQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNRvrG6FJNeeYamcjpdBEhpubuZk9o2lEnebOaLQZIIxzt6nb11C4rCw6jGyTzv+Ai4YjLRN3+Q/FrEVmn6UKXLTrNEcoXGONbc/XWWAaCVzSlhNlNwRO8C5bkuueKB438thFwGiK595ymVRzL8/eeQa+3px9IY7VD/+0JdLCuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPGh519B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=INgneyKm; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769501190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Np7Cptnfw+XZkLrXgFu9BqaG1+Fb7vNwdeFnlALDuRg=;
	b=iPGh519BSDvaatI9Gjwaq80ZU6Fnmwnk73oXnbp0+BlhFLgfYUAy5Ln7S6WpVgDhKOpMkx
	HWrK8nqYdjWYRxLE6/upL+BoscE/Ng3BcNLkdj8p6ol4ex0Ug6R38zbgO6vAlEhf76fnom
	FlhzY6DUaH0Ftf7WisRjd7lc80y5+ew=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-8_2yIX5bMUq1rIVT6TbBag-1; Tue, 27 Jan 2026 03:06:28 -0500
X-MC-Unique: 8_2yIX5bMUq1rIVT6TbBag-1
X-Mimecast-MFC-AGG-ID: 8_2yIX5bMUq1rIVT6TbBag_1769501187
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so3581796a12.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:06:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769501187; cv=none;
        d=google.com; s=arc-20240605;
        b=X8Wk6kKrhBf/Zzq+w5XTZMwglluKxCP+upvQlCH9jBu4iwOGgRiocUq1scjEJD9W0k
         OafmPpVvICIvdYUmuym1X6MBdV8Hc2m68TOTo9RZXlaHtzuk1/MOuxhx0+scvK1QDvff
         OwFalIq1tmtDUGmRpE+8Q2qR9YEyB2nIHcUSrnmuWOPPp6PaPw+VjDhm5rPqDkKiQkW9
         GDlyonRGyQFKtTd127ne1YD5qriMGPYLHo+PaL/OlzsijwqX8TEYVDkIq+9VX7DjS4Gr
         lG00XD5EpiV3pOxNbflfN/nP9KFUM0YFDWY6rLOtxANiLKhu9HiHUPxjqDh7Ipok7pga
         5jiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Np7Cptnfw+XZkLrXgFu9BqaG1+Fb7vNwdeFnlALDuRg=;
        fh=BuHJe0fgThetL32TQjziygVp6ibpprbt8Cv8Oj3VPdw=;
        b=EHKous2tmzCnsj4/bkq6HyJl0CsgaGz3qPdrCU/We1YrS1OWvZQ0t3kXrHKdt76RAX
         8BiL0JfEPcRiElSGVzjbnXM/pzYQczxqC0HqtBYDcQOuTTTNcGOu7Yi3dqYrniQpMrKY
         v7RNjX64ypZ3pi4EZ49ZuL1amufbipqbLR/9MF24gu3KLe0qQPXC+U8vVe8cYwF3YRcM
         4X1hrWQChAx1X9SqcaNmtKWY17x8NhpR2TCDcaW4pFasbCWI+5xCvkuQjGAAYmrQr81x
         Zv3Gzv3c9TNl3kMbz+iGXmG30A9a+xOTE87JjF8BaG1GlJim1KdYYDxwJFmXu284soen
         uoPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769501187; x=1770105987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Np7Cptnfw+XZkLrXgFu9BqaG1+Fb7vNwdeFnlALDuRg=;
        b=INgneyKmshgy37aWaFP8agBtMa1uB45+DBZ0PqCVbvKYdO+PU819WCH3Byn7/D8ZSW
         RZLjyZfALZr4lOwuI23kmVFusbhxp4SppwqvseVvl8saKek5tsdX23Rt6R/47xiBU0hf
         9WtTy3+HRVsddbeFE+L8zD06ibxHL42bgwG3MAePhO5peX+nenc/Ooovbmn3JgpTmWfF
         ihswjFWhJgztjtT+I3vMhBU23yOJj6HjLJp2ICjE6uk2nzVdI/UfC0Kkb0Fvlb2ORXLy
         EEzxDCpo6SVpOqHMXF2+d/AVd91On+uiKT7TLSG4BCuq4FWeXk2NBdSLznjRT56yp/Yq
         W2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769501187; x=1770105987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Np7Cptnfw+XZkLrXgFu9BqaG1+Fb7vNwdeFnlALDuRg=;
        b=mwPXt51My9OA+njU0Z4GsU1vxvPQRIg/pQtvGQmHLdSwXrmuZEAYNamds2kceC4C2K
         SS1tKSIDZgPf1gmqm/lHIIlAmq32vM9p8Faddbz/I/+JI1gqzW9d54qMmS27vPOZ+XVO
         caCSK6pNhg35wgzlYBIWa9aUIxbWZ9CefPLB3CRxwbptEi5sqwKSMriQ/cs8C0jtSLAb
         z2E40HPYJZadbVMr8ZxEoRIUC3fBdbGvLudVkDCsKG3SF68gAV/QM4R4+2PTkiPcjTAB
         k7Rd0UfSw8tYUpYG7b1fdyal7LisK5cC3MlplrKbxGC+quM+mQYJ+ZeTenkS2po873NX
         sz0w==
X-Forwarded-Encrypted: i=1; AJvYcCVMINsJFBzM2jStY1akwENAKMiWdSO4Mi2AGA/mWE8yHgf3N/wlk2SgkbO8X1rRPtVLZka7ddM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQS1YPlzG1B2IXUx4AKju0HofeLIjJ/RHfN0kn8aaD3ggiAEYP
	c/KKb0H0HSjzX+ijwVLFkvUIGgtps91iQubYX5QU0Z1cnyE6x/faFepX0efigBtx/h9sPxyKTsN
	8joh4yWkyyHDf7m47o6xlGJ5COjZETvJd/TnWaNSUJ5Dy6ZTKnrSkwCeZJL5sXt5CEtbFtwmEPm
	h1V+2tVdxTLZzXLvRE//Xn+TTsfY9x5QSx
X-Gm-Gg: AZuq6aJM3Jn1rFWJ2H5JbT+FE6sq8+qcgb/g2QbQFUV0wSmgqy5rslA+zkPPW/EJy0v
	cqt6xD98zLQwv35tCe3XpfhTDDxuq0x9/L0HDrp1ng3Qxl/rFmZXFHxX5MmSEM6s3EeRCKGamoO
	iOl2djnoDPbsn3LFaIiz6D8KLetMySa8Vn8V1htC9qu5rwMeb7TOXe7TzZMQ23kw+9hUs=
X-Received: by 2002:a05:6300:670b:b0:361:63eb:d024 with SMTP id adf61e73a8af0-38ec62c85f2mr864711637.23.1769501187110;
        Tue, 27 Jan 2026 00:06:27 -0800 (PST)
X-Received: by 2002:a05:6300:670b:b0:361:63eb:d024 with SMTP id
 adf61e73a8af0-38ec62c85f2mr864691637.23.1769501186706; Tue, 27 Jan 2026
 00:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127073921.175981-1-lulu@redhat.com>
In-Reply-To: <20260127073921.175981-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jan 2026 16:06:14 +0800
X-Gm-Features: AZwV_Qi9BNqEGOfaJTvxImo9xsBd4ZDBvvBGEwTUkdPThnSlmVC_s4smZpdhUJw
Message-ID: <CACGkMEuEjtnY=-BFj-hhn7JG+N=LtjOJYM1HSonjgKo+wf3m5A@mail.gmail.com>
Subject: Re: [PATCH] vhost: remove impossible check in VHOST_GET_FORK_FROM_OWNER
 ioctl
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253746-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2879790EC6
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 3:39=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> remove impossible fork_owner check in VHOST_GET_FORK_FROM_OWNER ioctl
>
> Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode sel=
ection")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index bccdc9eab267..889481c92236 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2338,11 +2338,6 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>         if (ioctl =3D=3D VHOST_GET_FORK_FROM_OWNER) {
>                 u8 fork_owner_val =3D d->fork_owner;
>
> -               if (fork_owner_val !=3D VHOST_FORK_OWNER_TASK &&
> -                   fork_owner_val !=3D VHOST_FORK_OWNER_KTHREAD) {

There's another similar check in VHOST_SET_FORK_FROM_OWNER?

Thanks

> -                       r =3D -EINVAL;
> -                       goto done;
> -               }
>                 if (put_user(fork_owner_val, (u8 __user *)argp)) {
>                         r =3D -EFAULT;
>                         goto done;
> --
> 2.51.0
>


