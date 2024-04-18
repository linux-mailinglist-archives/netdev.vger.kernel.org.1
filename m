Return-Path: <netdev+bounces-89236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF38A9C1F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C695FB25E93
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD7165FC0;
	Thu, 18 Apr 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XluG0W2G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB116C6A5
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448906; cv=none; b=twfVtmscUfNaJDRxswidMnRZ7HqTbUm2jIYG+IRp4z1hnZwYshnR7OJnuMj2AfGfb1zSyk7rfhJhM2MAOocPC7kXic4p7NUC5e2b3kioymhnGKpoLOsxnsfz32aYkQGj+WYYnMpLx1jr0ebI9PX0BTtZXEeWUrPnCNvfapWVnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448906; c=relaxed/simple;
	bh=NuA8jATjIIqF/IVkKGqTZXIcUP3hSh9mrpEvpO3Hqbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpCgeuc50abDjCpQWyw22KNqu5TwTblvALm0eA4POjPODKv/zZ/A1NX7S4yXjwVf6HhdiKbHbCDwYOg7yjIPB7KLTvtRYUfYCtnpadRdSmnAZLyydm8XVPI6M2TYYodF15J455ASqFQA94IBDSPtDWjEYqNEeqdImo1z9pl1ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XluG0W2G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713448904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuA8jATjIIqF/IVkKGqTZXIcUP3hSh9mrpEvpO3Hqbs=;
	b=XluG0W2GtYSUIZ60sFGBT45+MOlqsBQTWx8SFbd77dNhfiNEYIbPtw26XHMRJywOcW3eAR
	i+EEC8Jrd6ylAVSRr357S6dbLWM10HCJ6Z0bP6JgVyLOfKgUgqu8RKUFClyELjKIvnPgtt
	ZuyRolaObKl9CxYBT+sB3XiYy/25SYQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-3nmHsVThMGmzaRwsGMf1vA-1; Thu, 18 Apr 2024 10:01:42 -0400
X-MC-Unique: 3nmHsVThMGmzaRwsGMf1vA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5dcab65d604so969765a12.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448901; x=1714053701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuA8jATjIIqF/IVkKGqTZXIcUP3hSh9mrpEvpO3Hqbs=;
        b=RZrheS7h14sKA8IXwfUMa37ZGD2s3/0RO3xkltX0PchC+U/YLDT/Qj+vF9Oqmd7DN/
         i5WIX2YKUfuosj6WIWWENVw/JTnzoQ8lW8j/GQiEyAvZfHtiuNI+QHpcv6Z8coTSK7Pb
         m2S/tES/3La5/zODb7qHxTphAlRireqB4Ldl7dWx3idjnwHUqWMfzsvpB/aKhOVj+sSW
         Pvnp/vCmqoX49iGgpjwYF6Z5mM2NVyLefzezdr7zUU/dlkRl1YT+gO7cjK6t1rHyuqG1
         QVc/oNDFifkULj6DnOtD0MKgNkFsv9gHXAkBwLVEFva5EZCKgH2UqGMzgH8RCjszr4IR
         3RRA==
X-Gm-Message-State: AOJu0Yyub3cYg/5EpTHck6bF62l6MgefdEJMmogQaiK0b/LhQPRytF+3
	rlzGkLvh+SInemE4d+8hfLl6WLEMEDmWMd761NEPsP4e0TGxWqsltwFHo1siZujamtOmf+HXkmg
	HO4a5SAElJcqJMcQhw7PTyA8Yu0u/Nbl4spnyVhSw/nDFcKeGeFPAOAgdRY5ZX11UkDup+i23IL
	3Ptfrser9s66JmofoHQWtHZydMz50vY95MnFkQ
X-Received: by 2002:a17:90a:8990:b0:2a5:460d:72f1 with SMTP id v16-20020a17090a899000b002a5460d72f1mr3031308pjn.1.1713448900933;
        Thu, 18 Apr 2024 07:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0XIyjmlzWFn0xaXYHRyeptwkOlH9+UTapBdjSursnSLjttl3zb4Xmwm3bQ0en5OXX7u+DDJDKzyLdz8eTzJc=
X-Received: by 2002:a17:90a:8990:b0:2a5:460d:72f1 with SMTP id
 v16-20020a17090a899000b002a5460d72f1mr3031249pjn.1.1713448900281; Thu, 18 Apr
 2024 07:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com>
In-Reply-To: <7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 18 Apr 2024 16:01:29 +0200
Message-ID: <CAKa-r6tZkLX8rVRWjN6857PLiLQtp92O114FYEkXn6pu9Mb27A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: fix false lockdep warning on qdisc
 root lock
To: Eric Dumazet <edumazet@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Maxim Mikityanskiy <maxim@isovalent.com>, Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, renmingshuai@huawei.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, xmu@redhat.com, 
	Christoph Paasch <cpaasch@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Thu, Apr 18, 2024 at 3:50=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>

[...]

> This happens when TC does a mirred egress redirect from the root qdisc of
> device A to the root qdisc of device B. As long as these two locks aren't
> protecting the same qdisc, they can be acquired in chain: add a per-qdisc
> lockdep key to silence false warnings.
> This dynamic key should safely replace the static key we have in sch_htb:
> it was added to allow enqueueing to the device "direct qdisc" while still
> holding the qdisc root lock.
>
> v2: don't use static keys anymore in HTB direct qdiscs (thanks Eric Dumaz=
et)

I didn't have the correct setup to test HTB offload, so any feedback
for the HTB part is appreciated. On a debug kernel the extra time
taken to register / de-register dynamic lockdep keys is very evident
(more when qdisc are created: the time needed for "tc qdisc add ..."
becomes an order of magnitude bigger, while the time for "tc qdisc del
..." doubles).

--=20
davide


