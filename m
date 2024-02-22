Return-Path: <netdev+bounces-73949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A385F6AA
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79DBCB22866
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D174405E5;
	Thu, 22 Feb 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ET1bB7SH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEF3770E
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600979; cv=none; b=rfpxBatgRmy6+mU5gforeTAN1e3nzEuhnu4AX06uiWplzf25OJOFXJjFVY7PmtLVqm7pbwpwA0ek+++CmVl/fNyIwk3sHUB0wth4E45/eghXUlD9VbYhtpMbKYr0+IqMhlQ9RAPhi8S3NduN/Mzni80ZXOmX4zMYOYpJTK237Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600979; c=relaxed/simple;
	bh=UmGLIhroLxenmawYtbE6MsRjSzDmB9LJRFYbCs37luU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JeLjSJeuBmkoO27M1RBa7gfexhIRKaTMpIQF1trl0tcjnY+Nl9M8Rqalss8MNinKh+krew3i6T9qjkW0iczH+wF0R22vMI0EiEtWS6mt1GiYG3AkTR+OVcCilXzHaBJnPObWISudqmPVIk5XL/oMfBy20qIsE6F17tIxsUmMXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ET1bB7SH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708600976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmGLIhroLxenmawYtbE6MsRjSzDmB9LJRFYbCs37luU=;
	b=ET1bB7SHENnaGyp0QxBoLe12AqpH1GwKwXpVPSJH+QjVaaYuHPNg84Ng3cSOrSoSO6SNVA
	lAOgkSG+oa55VkjJWVb1sqdZrIMQ5Zo/U9OsjL6/QHdCnQgu9H6/tSDVMWKBbABTpj2VcM
	jVAzBe3dqlz8Zk7Y2yic4Wkz7CLz+40=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-q_7jvGVaOhOIO_aRj8FpAg-1; Thu, 22 Feb 2024 06:22:55 -0500
X-MC-Unique: q_7jvGVaOhOIO_aRj8FpAg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3ef988b742so173283466b.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708600974; x=1709205774;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmGLIhroLxenmawYtbE6MsRjSzDmB9LJRFYbCs37luU=;
        b=v79EZ+sYi+SPpQofqo7SEZORDnCiTH0D7L84HGTNRg482Cu9XcPetgas/kMZrPI3AO
         LXru2WSsO8h1nXLgE8ZljolYW2qYzWhG7oO2WoFW14JGPJP7WzFA1rqK3qYPCp/lrjHR
         NCm5yCl5sFwJ8CRWRKvwpb1JCTq+c7zypUuSYLT8VKgQ7rfWz3HENmfbadYeDhVvOFtS
         6OHo6a/D8frLKF0GhxNXrHWt/v8FgddEwjFoGPAM5BJCX6c6/DPpH+zNeTi/NXp4A2ds
         wAWh+0eiY+mfffl8oRWZ88w9UNHL5YG9oanRz9q73rFnTtR+f3XIRPLa9YSci+7l+6Qw
         1Naw==
X-Gm-Message-State: AOJu0Yz1ZhxWPaSGyPzP9lGFC0HAg5Mh/sdnsN5FEN8O0OOtRjbCW6Ax
	gmb3Hs1oKTKFgT7H07RgtHMV4VJay3Phvn2JieQfswMaUmWGl+wVrY75lyAyP2OGkuJQbRCh1F7
	LAof1RNHxfTMr+70UxdNod4nFSqBEjqXCbvLLtxhbJweQCCKop1eEog==
X-Received: by 2002:a17:906:24db:b0:a3f:9d69:3643 with SMTP id f27-20020a17090624db00b00a3f9d693643mr391914ejb.32.1708600973942;
        Thu, 22 Feb 2024 03:22:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEjrNN+aOdZDuU5mf8rweAqu49zGU+J0mprlepI0SfSnT/W32ayidgFn/ECWt5gnuBWmLw/g==
X-Received: by 2002:a17:906:24db:b0:a3f:9d69:3643 with SMTP id f27-20020a17090624db00b00a3f9d693643mr391896ejb.32.1708600973637;
        Thu, 22 Feb 2024 03:22:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c1-20020a056402100100b0056486eaa669sm3407854edu.50.2024.02.22.03.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:22:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A8141112DEDC; Thu, 22 Feb 2024 12:22:51 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 lorenzo@kernel.org, Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>,
 syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] net: veth: clear GRO when clearing XDP even
 when down
In-Reply-To: <20240221231211.3478896-1-kuba@kernel.org>
References: <20240221231211.3478896-1-kuba@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 22 Feb 2024 12:22:51 +0100
Message-ID: <87y1bchhf8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> veth sets NETIF_F_GRO automatically when XDP is enabled,
> because both features use the same NAPI machinery.
>
> The logic to clear NETIF_F_GRO sits in veth_disable_xdp() which
> is called both on ndo_stop and when XDP is turned off.
> To avoid the flag from being cleared when the device is brought
> down, the clearing is skipped when IFF_UP is not set.
> Bringing the device down should indeed not modify its features.
>
> Unfortunately, this means that clearing is also skipped when
> XDP is disabled _while_ the device is down. And there's nothing
> on the open path to bring the device features back into sync.
> IOW if user enables XDP, disables it and then brings the device
> up we'll end up with a stray GRO flag set but no NAPI instances.
>
> We don't depend on the GRO flag on the datapath, so the datapath
> won't crash. We will crash (or hang), however, next time features
> are sync'ed (either by user via ethtool or peer changing its config).
> The GRO flag will go away, and veth will try to disable the NAPIs.
> But the open path never created them since XDP was off, the GRO flag
> was a stray. If NAPI was initialized before we'll hang in napi_disable().
> If it never was we'll crash trying to stop uninitialized hrtimer.
>
> Move the GRO flag updates to the XDP enable / disable paths,
> instead of mixing them with the ndo_open / ndo_close paths.
>
> Fixes: d3256efd8e8b ("veth: allow enabling NAPI even without XDP")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Makes sense!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


