Return-Path: <netdev+bounces-54465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A7807260
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FADC1F211AD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EE33EA66;
	Wed,  6 Dec 2023 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA//4kfL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EFC1A5
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701872883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQemMj12WIGjBZr47gXsOW9zpJs6p0UbQqP4YLY+F/c=;
	b=dA//4kfLfxPaqC9SDU4hKqGna0m8xNvsefdJBi+aJ2nmgLXp7DhRmui+Eb/G9rbthO3tJh
	wOnUMKdwFbP1yynYm2425WR/zCNh8UmzIzlx/RfbOpu5H4hsdzrcv77mfBPomB4GoL5a7o
	F+d83iS6gOPTJZkHpzcHpwKv58c4Ewo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-9U7HJMHVNo-0odby3Nv45w-1; Wed, 06 Dec 2023 09:28:02 -0500
X-MC-Unique: 9U7HJMHVNo-0odby3Nv45w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54cc6ae088bso213423a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 06:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872881; x=1702477681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQemMj12WIGjBZr47gXsOW9zpJs6p0UbQqP4YLY+F/c=;
        b=Jp7CeM3ddxgvZNeNkDXJmrQCWVSQ5venNeTo4xgD0Yq3PN4mNFZVJ7fA0bgcWrKzMC
         AB14tMd1owtFHTmGjJA5NAdsrjLO95WcJGh8mXmPB4s+b0MHhRyShGSgs0a5ecjCH/ib
         4ylVAGWLAVORUss752RQhMTXiisRyV/cRYpuXayQisopCP5i0WqchowM6E35B/uMmtVn
         eCYpY6CpcjUhIF6EBrb/20y2he6vH4ahnt4uxHTdsspw+d3Xiz6OA8APDDMwThtVnrO9
         fH8o7Vl/z5ZlcPRRcWVbhW7iMadZ8wRXKNhRUy6uDHvKMDy70KUg6WJrgki6zvl/JbO/
         PSjA==
X-Gm-Message-State: AOJu0YyvLytNoZKeh694Gl4osfYExjE2P/iG7wLCw0y+rERpYMAWZkBU
	xG60k8XftXU/kpAOnvZHMI4GN4r5p0eoBjv5u9CAURVuqUug4n5/zWUNtqPFh8ovVpggC65JzUK
	9aiiY9Iml+rp/5PlR
X-Received: by 2002:a05:6402:51cc:b0:54c:672c:c361 with SMTP id r12-20020a05640251cc00b0054c672cc361mr1531610edd.4.1701872881141;
        Wed, 06 Dec 2023 06:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHugIYgkAQma+u3Rcpl7xfsrIA7QBzIlc/Fe/J91NHiDKxoNEHxJfIq2dPWK0/tYzv2Md7dIw==
X-Received: by 2002:a05:6402:51cc:b0:54c:672c:c361 with SMTP id r12-20020a05640251cc00b0054c672cc361mr1531597edd.4.1701872880773;
        Wed, 06 Dec 2023 06:28:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7c05a000000b0054c715008f5sm33117edo.6.2023.12.06.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:28:00 -0800 (PST)
Message-ID: <d94ba990b99c01853cdb190895185ef3b7834fb1.camel@redhat.com>
Subject: Re: [PATCH V3 net 1/2] net: hns: fix wrong head when modify the tx
 feature when sending packets
From: Paolo Abeni <pabeni@redhat.com>
To: Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com, 
 salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  wojciech.drewek@intel.com
Cc: shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Dec 2023 15:27:58 +0100
In-Reply-To: <f7588e40-0fea-4350-89fe-c432eacb68f7@huawei.com>
References: <20231204143232.3221542-1-shaojijie@huawei.com>
	 <20231204143232.3221542-2-shaojijie@huawei.com>
	 <ffd7a4cbefa8c4f435db5bab0f5f7f2d4e2dad73.camel@redhat.com>
	 <f7588e40-0fea-4350-89fe-c432eacb68f7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 20:31 +0800, Jijie Shao wrote:
> on 2023/12/6 19:18, Paolo Abeni wrote:
> > +		priv->ops.fill_desc =3D fill_desc_v2;
> > +		priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tx_v2;
> > Side note: since both 'fill_desc' and 'maybe_stop_tx' have constant
> > values, for net-next you should really consider replacing the function
> > pointers with direct-calls.
> >=20
> > You currently have at least 2 indirect calls per wire packet, which
> > hurt performances a lot in case security issues mitigations are in
> > place.
> >=20
> > Cheers,
> >=20
> > Paolo
>=20
> Thank you for your advice. Currently, because the hardware behavior is=
=20
> different, the two versions of ops are retained to unify the subsequent=
=20
> process. We will try to unify the two version ops, and if that does not=
=20
> work, we will consider maintaining the status quo. Thanks again! Jijie

Note that even if you will have to resort to call different functions
for different H/W revisions, from performance PoV you will be far
better off doing a test at runtime to call the corresponding helper.

Or you can use the indirect call wrappers - have a look into:

include/linux/indirect_call_wrapper.h

Cheers,

Paolo


