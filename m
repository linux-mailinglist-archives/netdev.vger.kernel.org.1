Return-Path: <netdev+bounces-247959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B662CD00FA3
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 05:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99FBB301B13F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 04:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DF291864;
	Thu,  8 Jan 2026 04:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GG7/ztLi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nG2XQrLl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E132218EB1
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847131; cv=none; b=uXKkjBIKtVbjJvPyepU0JxhyLxEc3F9jauYwoLx5PtY5ZjGa7UjWmivLMxQMRMMy7+PjDVoWAuQjq/6fQ48U1Q9t5VpDdj1sJHGntWJY7GiNj+/B807yIqtZ3vcCH58jgxiBnBYSLR1WMDEBKg1FeFoZlPmqO9yPBvF2J/3fBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847131; c=relaxed/simple;
	bh=1Mw4+/RnBE3HC1Gi2CHwhB4Ll3ThRjwOgtBMJvxn2cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdEnQBPmcvD0Nrh+Iy+7QXVVNHuQV3Nh0d/LNSKMeRdiNnA3yj9dm6ibpEzphjNtoKVN6Aah2c3LaGOftSZZVRqngC4q+MzNRWYTqoNgBIzUYa4zsczZLAdaDMNIcooWJnQCr2YsX0n7dfWCbgr2/cu/qdO9Hv9vbdBt9MFVxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GG7/ztLi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nG2XQrLl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767847128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITK/RdRB2R5i8Otgr7paxSBzAk4X73xXTbyRHE7SKp4=;
	b=GG7/ztLi5ftZNh8vtEnStI3pSrtSbPJ1btNCJHg3mnVRyLzdBz5Gf6Y3wlEbOrr/JDcSga
	TGA0cYwt7odG85rldIHPtWRbbhbhtmT7N3GfErJOxyF9y9tZjaxAEy+HIynr0hrnt8GOB7
	rq4SkGG3uYqvNO1hXu1C0HVqNEmwxpg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-TQ7RRSd1MbG7uwDBwYWgug-1; Wed, 07 Jan 2026 23:38:47 -0500
X-MC-Unique: TQ7RRSd1MbG7uwDBwYWgug-1
X-Mimecast-MFC-AGG-ID: TQ7RRSd1MbG7uwDBwYWgug_1767847126
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c704d5d15so4825251a91.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 20:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767847126; x=1768451926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITK/RdRB2R5i8Otgr7paxSBzAk4X73xXTbyRHE7SKp4=;
        b=nG2XQrLlbnNvnowuc2AJ9dIbbao5IkNAebpJRgdV6bsrH3vB47LwGOpKKtW4a50cDj
         mIeXKolHhq3k5D+QZ1UwarGlQUd+Ar6pKUcbNblZFSuCHxXvpr4+jhT29rUzHvmXZwIh
         kb0gJEM6t2xlT7FpLLJhB+Y0Sq/ey1SvnyKq2fnlHwnWOhUQuU94pzsEIy70MvjPAanb
         gl0TUt/PEe4fFLfjTE4gT6N2wjBzyPykM8id/4Dw8r3bO272iktm/ZiabUVK8I8Y2q+f
         jI+lRcKA66G6SqLNMck1msqrzVA7Yb6v8/oBbGeVjYgA5Oupu9WcHRmxZMhrS1N7dqjb
         xBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767847126; x=1768451926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITK/RdRB2R5i8Otgr7paxSBzAk4X73xXTbyRHE7SKp4=;
        b=KQy0RI5erUPuiURalIHgWfgKuHeeOVy5Pa20JzxXiKP//NO+2nf4lqOlWRngCHGNet
         NMwzrzM41CnkZRJW/g8i41uopVxFO7MFzUnejG7TE1zVSP83JBp8zq5v8sjgMCQ6vDj1
         cbKUBW7j5Qvi1Zi6IGTnwPsyfa5FUO+ZlvoYsv5LnmnT/oUl/o5LC0XR9WbTSJIBeDo6
         s2X11OU7wvHeegeDw9x1kFdRFrhm62QYloHTM3FCpOsZwIuIXTTV0+PWPoRcsohpDWSq
         yk+qFLyCeCpdwLJZNiCwOVQcXVuGS6AFrp/hxkEZ2BDcZ1aTowu307/3VlqT930hBY77
         ua/w==
X-Forwarded-Encrypted: i=1; AJvYcCWQoAwZRUKXsWecN7rCRRcYQpg742zuSzCmgGXXOckL4MwUD4yzTUOyIlxEk6dQU25cyUMFh4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzyte++P+iqdzenQLLEAtOH3Hf9QqC6WzCkBD59ChTAlxJuOSG
	bgv0PWocBYyOjFZDRsxnOw2JNLjTpwwVLmQYFhKtG2TYB/wKVRDQAsFYMPfriSEATubhhIUycWQ
	D61kKrlBNJatxK7mVXWoecVJ70EYG416SrBvsNQicqty/ZNWS6aV4DLwYKbgg6oIBlyziO9JlUl
	rrKUBA5h23pwL37aL0HNOHc86Z7Z8vM74s
X-Gm-Gg: AY/fxX4Jw1tA9nTMxrikRbzXvtgHAdAKQ65VJioxPXQsVPZCfKEp8t/xbG8YgdFSlds
	wLNvy6ahNwUhw6z7BugGZwy0xTqsBlf/BLFix7C9QfJ1NkILbDTztHC7+Y+VZsC5RFalck8QKDD
	zjasADxl2AFubkUOHQgf8gmT0vr8W2Uy5Kg5MHzN0SIA9l2cLhFtrHM+iy8cZ0bn8=
X-Received: by 2002:a17:90b:38cd:b0:340:ad5e:cb with SMTP id 98e67ed59e1d1-34f68b8325amr4472104a91.8.1767847126205;
        Wed, 07 Jan 2026 20:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5VQZiGe7r1S4uFGT8iu+UqDGLcVAm47K+xxuFBZErtPwJUSS5ANbzbriNBgtK4Or956wAzsqxr3sqB3YdRdc=
X-Received: by 2002:a17:90b:38cd:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-34f68b8325amr4472074a91.8.1767847125793; Wed, 07 Jan 2026
 20:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-8-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-8-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 12:38:34 +0800
X-Gm-Features: AQt7F2ojlTg8w4ZELX6uaVy4snIzQbNmqFa41GC72EmW5kfc8xJcEouDgWh6mwE
Message-ID: <CACGkMEtndGm+GX+3Kn5AWTkEc+PK0Fo1=VSZzhgBQoYRQbicQw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 7/9] vhost-net: vhost-net: replace rx_ring
 with tun/tap ring wrappers
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Replace the direct use of ptr_ring in the vhost-net virtqueue with
> tun/tap ring wrapper helpers. Instead of storing an rx_ring pointer,
> the virtqueue now stores the interface type (IF_TUN, IF_TAP, or IF_NONE)
> and dispatches to the corresponding tun/tap helpers for ring
> produce, consume, and unconsume operations.
>
> Routing ring operations through the tun/tap helpers enables netdev
> queue wakeups, which are required for upcoming netdev queue flow
> control support shared by tun/tap and vhost-net.
>
> No functional change is intended beyond switching to the wrapper
> helpers.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Co-developed by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/vhost/net.c | 92 +++++++++++++++++++++++++++++----------------
>  1 file changed, 60 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7f886d3dba7d..215556f7cd40 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -90,6 +90,12 @@ enum {
>         VHOST_NET_VQ_MAX =3D 2,
>  };
>
> +enum if_type {
> +       IF_NONE =3D 0,
> +       IF_TUN =3D 1,
> +       IF_TAP =3D 2,
> +};

This looks not elegant, can we simply export objects we want to use to
vhost like get_tap_socket()?

Thanks


