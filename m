Return-Path: <netdev+bounces-51268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D177F9E3B
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3C91C20A0D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C684218C3B;
	Mon, 27 Nov 2023 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPI7RUHR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77710113
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701083594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5SSLJWdAkzBNtn/oUSsX/Xv/vew1gRLoJdndkA2WJo=;
	b=NPI7RUHRbmkCSFsbFaP72Hj4cIG4Hv7cfKNxpjRiUrBMsU9+JJpNHuYyhQ0QKYDNpf4VNh
	uVH7zyGQZ0VDeGbw70xogzyJXE55fyrfUX1YNuCAMRqSPPl752BNO/sNOCae9qBzwGNqNc
	JGM6wnCwjrhmfR00qTsRBLfCjgKYpRI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-ESNLPzrdN3qwEE5PHAFlUw-1; Mon, 27 Nov 2023 06:13:13 -0500
X-MC-Unique: ESNLPzrdN3qwEE5PHAFlUw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50aa94aeec4so891436e87.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701083591; x=1701688391;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5SSLJWdAkzBNtn/oUSsX/Xv/vew1gRLoJdndkA2WJo=;
        b=F95XASGVI2XiaH6UOG/L5YPb1CVmax8/O4955BD9h96x6ztRUCr5yKjDtMlC3zScrg
         +SCOpxHWzYGP+6qN6rhAuJIKJSqifaX4+w46KhIqEIbSceQwxIOyWeh4R1lbiBYgJnCE
         CED967LEd8AK2v1FbcyAYRqJsuLQG9nOyNj2wRIQNGHkiz3XYLvpAPdVLQEBJLX7uXle
         w1k2z1hbb/VQfj6rEL6ncIub+pw1WwsPG9vhW26635myjKm1VzQbKCh4QrON8dj21He4
         kZb2eme2JW65IQLKdHxKD/sRLWf5GxkqPP1T7UTDle06dQI7nWzTxzYBq3Fw61VupJQy
         r1Sg==
X-Gm-Message-State: AOJu0YzagAfrVx1gO/zfTmO11YZVCMl8G3GrILlP7UyEeWfwNUVfBpSQ
	qUkxCURzZgk7VjssDs3Adhbg7qi50FCjmPRRXGrfC70la6/SfZHu7QTBRArN5+OttgY1HbnbJOd
	HVm6Vw/OsEyLTxPkXWIzJgyj/
X-Received: by 2002:a05:6512:3c89:b0:507:9861:2be9 with SMTP id h9-20020a0565123c8900b0050798612be9mr7066547lfv.6.1701083591606;
        Mon, 27 Nov 2023 03:13:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDIGCyRTyAmMF5BHen7ZnfG/3FPPLcy4z0HGMeTFutUEX1iQ/LMTJAgRuQAj8g6A6HUZ0FYA==
X-Received: by 2002:a05:6512:3c89:b0:507:9861:2be9 with SMTP id h9-20020a0565123c8900b0050798612be9mr7066530lfv.6.1701083591283;
        Mon, 27 Nov 2023 03:13:11 -0800 (PST)
Received: from gerbillo.redhat.com (host-87-11-7-253.retail.telecomitalia.it. [87.11.7.253])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906074200b009d268e3b801sm5557727ejb.37.2023.11.27.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:13:10 -0800 (PST)
Message-ID: <c1ac61d8a51a985f25848f480191c0677b3ed0b7.camel@redhat.com>
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
 jacob.e.keller@intel.com, jhs@mojatatu.com, johannes@sipsolutions.net, 
 andriy.shevchenko@linux.intel.com, amritha.nambiar@intel.com,
 sdf@google.com,  horms@kernel.org
Date: Mon, 27 Nov 2023 12:13:09 +0100
In-Reply-To: <20231123181546.521488-6-jiri@resnulli.us>
References: <20231123181546.521488-1-jiri@resnulli.us>
	 <20231123181546.521488-6-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-23 at 19:15 +0100, Jiri Pirko wrote:
[...]
> +/**
> + * genl_sk_priv_store - Store per-socket private pointer for family
> + *
> + * @sk: socket
> + * @family: family
> + * @priv: private pointer
> + *
> + * Store a private pointer per-socket for a specified
> + * Generic netlink family.
> + *
> + * Caller has to make sure this is not called in parallel multiple times
> + * for the same sock and also in parallel to genl_release() for the same=
 sock.
> + *
> + * Returns: previously stored private pointer for the family (could be N=
ULL)
> + * on success, otherwise negative error value encoded by ERR_PTR().
> + */
> +void *genl_sk_priv_store(struct sock *sk, struct genl_family *family,
> +			 void *priv)
> +{
> +	struct genl_sk_ctx *ctx;
> +	void *old_priv;
> +
> +	ctx =3D rcu_dereference_raw(nlk_sk(sk)->priv);

Minor nit: Looking at the following patch, this will be called under
the rtnl lock. Since a look is needed to ensure the priv ptr
consistency, what about adding the relevant lockdep annotation here?

No need to repost for the above.

Cheers,

Paolo


