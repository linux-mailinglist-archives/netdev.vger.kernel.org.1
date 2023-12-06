Return-Path: <netdev+bounces-54402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D3806FA0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F421C208A5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F1364C3;
	Wed,  6 Dec 2023 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAOA8apm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE512D3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701865632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s34pD0g97ihvNhP+d7uc8e9tLFzVYhZt7dem/1oEr3U=;
	b=TAOA8apmC3C1abClmQS5PDBWXjdMHOluhzILGbGiSuFQ/PW8rgVVYadM9rAwFmmGD62kLF
	RbdeVfj/sBDiaUnduzy2gu3poKEDcHGnkfpHgQe2Y5Ru3XyaIUCeAq5PGh7RtZ9xTQFxfM
	c+hmqqU3K4Su2Q0im4jNSVOivPSxBhE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-fFwqNvnXMhyesP7Focms7g-1; Wed, 06 Dec 2023 07:27:10 -0500
X-MC-Unique: fFwqNvnXMhyesP7Focms7g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1e27c6de0eso1257866b.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 04:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865629; x=1702470429;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s34pD0g97ihvNhP+d7uc8e9tLFzVYhZt7dem/1oEr3U=;
        b=NVdhslukuIYZQe9lRsIk+poz2z8ym7/CrrvLjJyDUX1x7zuz8cQFNAQpLUjt4hNqMX
         YhXA1jFpADwmtHj2VZ/s5qxTgeViJiNmvCPP4x9EN9ngFkTJKUT7fuRj7buu8moMlAI4
         4WZUjgBeAVLRHZd9ky2lhVYpDqA5zlUX4by0TzGZigWVIDQWoiCVMqBpwiy880HaAaN+
         bry2ePbzZPYMgW+7LpASpIp+1po4N3LmOxCJedoZuW41OPhA3Hks4FtppWUWTSq9NCo8
         pgwJ7moXc9/1dG2oOEeiTrt4asoPQXtK00zsR3mcoem7PBrNBQqPGN2GX4VrcWuOm5f4
         /uhQ==
X-Gm-Message-State: AOJu0YwD0AoNlSWbOTrxMsjuAL+Mh5/rN+iEQlmL4Cz5Vnt0jNb/eufO
	IW6LmvmyfO58NJ1v7d11oFaIBaFP22zs48Yd8V9luymoZ4si2elgPV44gHOKAbK+DwW28CwrZU8
	MyflAYIK9IA+teqxF
X-Received: by 2002:a05:6402:26c4:b0:54d:2efd:369e with SMTP id x4-20020a05640226c400b0054d2efd369emr1234931edd.1.1701865629296;
        Wed, 06 Dec 2023 04:27:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH881FLwuQ+1xk9Fvn62h3FiEQutCuBExRDXKtSbsKWDqWRzxUgCz0CGvLTs+2SDddZcOwsuA==
X-Received: by 2002:a05:6402:26c4:b0:54d:2efd:369e with SMTP id x4-20020a05640226c400b0054d2efd369emr1234915edd.1.1701865628893;
        Wed, 06 Dec 2023 04:27:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id da11-20020a056402176b00b0054d486674d8sm1706726edb.45.2023.12.06.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:27:08 -0800 (PST)
Message-ID: <f36e686e13142d885a6e34f0a4dc2e33567ef287.camel@redhat.com>
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd
 access
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
 mst@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com,
 edumazet@google.com,  davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org,  horms@kernel.org,
 xuanzhuo@linux.alibaba.com
Date: Wed, 06 Dec 2023 13:27:06 +0100
In-Reply-To: <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
	 <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
	 <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com>
	 <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-05 at 19:05 +0800, Heng Qi wrote:
>=20
> =E5=9C=A8 2023/12/5 =E4=B8=8B=E5=8D=884:35, Jason Wang =E5=86=99=E9=81=93=
:
> > On Tue, Dec 5, 2023 at 4:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> > > Currently access to ctrl cmd is globally protected via rtnl_lock and =
works
> > > fine. But if dim work's access to ctrl cmd also holds rtnl_lock, dead=
lock
> > > may occur due to cancel_work_sync for dim work.
> > Can you explain why?
>=20
> For example, during the bus unbind operation, the following call stack=
=20
> occurs:
> virtnet_remove -> unregister_netdev -> rtnl_lock[1] -> virtnet_close ->=
=20
> cancel_work_sync -> virtnet_rx_dim_work -> rtnl_lock[2] (deadlock occurs)=
.
>=20
> > > Therefore, treating
> > > ctrl cmd as a separate protection object of the lock is the solution =
and
> > > the basis for the next patch.
> > Let's don't do that. Reasons are:
> >=20
> > 1) virtnet_send_command() may wait for cvq commands for an indefinite t=
ime
>=20
> Yes, I took that into consideration. But ndo_set_rx_mode's need for an=
=20
> atomic
> environment rules out the mutex lock.
>=20
> > 2) hold locks may complicate the future hardening works around cvq
>=20
> Agree, but I don't seem to have thought of a better way besides passing=
=20
> the lock.
> Do you have any other better ideas or suggestions?

What about:

- using the rtnl lock only
- virtionet_close() invokes cancel_work(), without flushing the work
- virtnet_remove() calls flush_work() after unregister_netdev(),
outside the rtnl lock

Should prevent both the deadlock and the UaF.

Side note: for this specific case any functional test with a
CONFIG_LOCKDEP enabled build should suffice to catch the deadlock
scenario above.

Cheers,

Paolo


