Return-Path: <netdev+bounces-236166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1DC391A9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 05:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22C7C4E47A6
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 04:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97C2D0C60;
	Thu,  6 Nov 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1oXMhKSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09702C11FA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762403782; cv=none; b=a6HA3gpiIgibxQsMQZrBdiNKoFRuilY4vFPyJ2dUTj9jtOD4Lsl3lKIar65GyxaZeZTYTmkVx7WWpUS2n4XIsBgK4J50J3K0a1qzZLvngZGmKq+tdtu+hQFOiD8jo88ewfYiokK0uQN1leSU4ssepWVD4V2wxnlLMkkeMLAxU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762403782; c=relaxed/simple;
	bh=/2n+t6Vpa7SvHTcKa6KgD8GKCvaD25RROF+uWNKWmN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ2hhNhrWSJlOj2fGNrlyakugacpmoU1+axZFwnBBo6z6atTpRZSM6v7xT3gc/TXF2ZaQnL2U/tao04kUV3FxOlj0mfYmUM0Bqm5jrOvAQ89ldNqVfDbZ7SPq8gaI9OUQsOFNIvxOQCevRWV1BcaFbdu59iXJUI9i08eSorihu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1oXMhKSV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-781014f4e12so5183757b3.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 20:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762403780; x=1763008580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YK4JfnHDyjnwEQ8qIB0Z8YQpFfHTjEnJ5dk27m0AH4=;
        b=1oXMhKSVMR3BAOQHsm1DW8g/fRsTaCxhlqAPgonlMRHQeRnO9fR2dK+Wgw7mIf6D7Q
         XHLV7rY1X5wvzHtEKWxxRHfoGGXQpQGvMH2DmoMBf1/WU2uD3q0ff4Y0T4xuHdbHKkC+
         pO6ZNR5tarSTN0CfTLohZ8Y8c2KCy+O1ps6eRjc3gSEZxz6YWX/qDJxV88GhbQcADDTt
         Qd3D5n9yWHVunO8QbF72qfDB3A0wZcjrA77aU54EpEWaTTeZtVOmHzafs7310j3fTQ35
         Ak6C0HfgBZuyOL7hxLI4bDbMcitRVLGRpaz/53vc4bll8KAEUwo0fqyAd0bd8VMGjeRo
         nmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762403780; x=1763008580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YK4JfnHDyjnwEQ8qIB0Z8YQpFfHTjEnJ5dk27m0AH4=;
        b=t+gTS8IFfv4dAJb7lv0flXYEc6mp9yh6jAG34kFgYIiUmbcNrZ7iaBn8yLLe/8tlnx
         V0FvBI3buc+DkNG7vnm9Ny8A7J9Dh9XjJYyiyd+sGil9lHQgxYa8RTJ9oli7UUceYjkA
         R+2Q01vqLopHS2OJFM7xlbUJpHW2vsTt7LRBEa0IxPqzFGrTWaPUG3KHHdcMQx1M9CNg
         o9uAwsWdIhAdP3jqOKOggOcM4/hMv3B58img8uem2upTsJLoQBYw+aPKQ9J6OzeUJg1V
         2x1qTPvUiQh/jXGQsvGgW1YRMVMXN2CLr73boA6yZp+o+0i2nxiXuP2IxrfLPQQC5NIT
         F7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXT2rnKIDMAJuuNaTAZ/AvXKF6jQ46A8gsauGr5WpUMwlr7p6Pk/8dMDL4g4ZXbPZx632L9VPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVR00+abUuCLw/hrmdTpREVbOk7j0a++aURN7qTenjEzxYNvzw
	TUhzJpOMSs3jgA+d9AvZcqSdrGFu57DEDQPtsnhq5usNA4x8xN4yRasA57YawnjQBO1YKEr+E/0
	XPbHpspuhKZQINKzHEKPl6StJgtlJxMLtWzx0zTR9
X-Gm-Gg: ASbGncvP/2FYJrOUeAZhELUatBKLHsIsSXuBJrzQaW+L/lg+fQWGpJ50osgncjizhYw
	VPYERCUdjI7ySGciyOGxSsLGSpRHG860uT4hnkWhzuhZQj3c//H8vSql4UZEE51524m5ful2iCE
	jaB/i6Xb3Ib+RC/MT2fwWc0gPLV2OKQSe6709OLw5/1ybZX/1I81DbRLJBT2DkMmzRODPvOBUQX
	OBcHbFGF+LH+drMLRnaD+Rifo1EUECOr0k6nFTv6vuSlapVfP6apJbHQkmrVgW42vXFGsluJyo0
	XoKfrGKcYDHU1J2fVuvzEtmKqq52O0EX9BWz8SvkzUE1mcby
X-Google-Smtp-Source: AGHT+IFfP9I7Is4+f1a/rhdeYjMmRB5Lw4aTIrzYViO3gh9Ufezr+ev/MJBSqWrYRNLd2uRQjWPiswqToY9ZDNfkpas=
X-Received: by 2002:a05:690e:1517:b0:63e:1c09:30d5 with SMTP id
 956f58d0204a3-63fd35ac731mr3814025d50.53.1762403779511; Wed, 05 Nov 2025
 20:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105182603.1223474-1-joshwash@google.com> <20251105182603.1223474-4-joshwash@google.com>
 <20251105144519.2729e38b@kernel.org>
In-Reply-To: <20251105144519.2729e38b@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Wed, 5 Nov 2025 20:36:08 -0800
X-Gm-Features: AWmQ_bl4KTTOH_1xMsqeeS7CXSaG0I7SZLg7rsK1iURXEmvcIaQ6Wo9YMb3zO4A
Message-ID: <CAJcM6BFGm0xE+dfbv6_srGFYq2F9YbkRjXiM5sWX22-8JRYyVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] gve: Allow ethtool to configure rx_buf_len
To: Jakub Kicinski <kuba@kernel.org>
Cc: joshwash@google.com, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, John Fraker <jfraker@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-kernel@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  5 Nov 2025 10:26:02 -0800 joshwash@google.com wrote:
> > +     if (priv->rx_cfg.packet_buffer_size !=3D SZ_2K) {
> > +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > +                                    "XDP is not supported for Rx buf l=
en %d, only %d supported.\n",
>
> No \n in extack messages, please.

Ack; will fix in v3.

> --
> pw-bot: cr

