Return-Path: <netdev+bounces-54443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB3A807155
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EB4B20E93
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1EA3C46B;
	Wed,  6 Dec 2023 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3WZRGs4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEE6D4D
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701870955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7s0RODaU0CONE0ORnylh3BqAbb5cnBkp4sJTs7k4Oo=;
	b=g3WZRGs4sKcnJwO9HBtnHNa1jMkWtdfKjo4kGUeelgpDdEkAXkTHxvSQIDyllEfuLDxpqm
	dTe4qGmgcpdaQdlI5jeK1ECd5qjv0OzenWu+LOGlddmYugwYujT+d6qbly3isH5nrQ6og+
	HgT/Dc459pU+XjQ79cRn27xMCPp9xYU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Ndfu2W8CM6-OiWkh-aNMHw-1; Wed, 06 Dec 2023 08:55:53 -0500
X-MC-Unique: Ndfu2W8CM6-OiWkh-aNMHw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50c0047a34dso2671836e87.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 05:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870952; x=1702475752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7s0RODaU0CONE0ORnylh3BqAbb5cnBkp4sJTs7k4Oo=;
        b=L2L9J+57pEAazoy4qoc5YHaSOSI2b8WdZMZAgos7YWrfG6rMfQFrUKwNTbCrrXVLwj
         cWzfE6juErWXYot/0ccxHHqXkAE4yIFeNgE7YspFe5WMgCJ6p4FylTxCO/Q6lv5kUPVG
         bW9bUAC0IEuHFUlkQcVHI6JKe+X8FL2WGb+7HbnG/al2VpuHD86T4n5xEVWs1vI8z7/h
         D9LGLBGfhbxZxHuMkij6XfkaqRceE0ObvTaYQznNLrNE77hy8F567Fl4ULGSd/uQAXe7
         tGJZq81mQ0oTAxhfTDBWHI8/GPVynwcwp12u6YDZJbw25j4bzk2EtZUQsPSMmIejlOo1
         hVCQ==
X-Gm-Message-State: AOJu0YzG8sCnWIAnUmwqF4volArmpmiTXahkrUP5JZs6eNdOSvNyWu4G
	FlywahwUaSQFWoJ3XxUPnK0IjFeKTfHSdakqZxXlm3u1hG7WOB8YLUUeD4CRozuPE6mX68Bj8Q8
	ZLUTF540eQ0XaLPkxLN0AVPx3fivd8Ntr
X-Received: by 2002:ac2:559a:0:b0:50b:e60f:4baa with SMTP id v26-20020ac2559a000000b0050be60f4baamr577483lfg.47.1701870952244;
        Wed, 06 Dec 2023 05:55:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGySLmvleNpyWCKhp6Ms6z7L9oDKbB5Ep3UDcXrZEAKc/ZMomNHiJ3gmUVz0bLloH+uuuwybbA9sE3pt4kNYMU=
X-Received: by 2002:ac2:559a:0:b0:50b:e60f:4baa with SMTP id
 v26-20020ac2559a000000b0050be60f4baamr577466lfg.47.1701870951874; Wed, 06 Dec
 2023 05:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206135228.2591659-1-srasheed@marvell.com>
In-Reply-To: <20231206135228.2591659-1-srasheed@marvell.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 6 Dec 2023 14:55:40 +0100
Message-ID: <CADEbmW3bn7btX_8RiOEncyh+M+WMK5Kxi+Gy_o3P2pi3u7rzHg@mail.gmail.com>
Subject: Re: [PATCH net v3] octeon_ep: initialise control mbox tasks before
 using APIs
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com, 
	vimleshk@marvell.com, egallen@redhat.com, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com, 
	Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 2:52=E2=80=AFPM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> Initialise various workqueue tasks and queue interrupt poll task
> before the first invocation of any control net APIs. Since
> octep_ctrl_net_get_info was called before the control net receive
> work task was initialised or even the interrupt poll task was
> queued, the function call wasn't returning actual firmware
> info queried from Octeon.
>
> Fixes: 8d6198a14e2b ("octeon_ep: support to fetch firmware info")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V3:
>   - Included Fixes line in commit log.
>   - Corrected typo in print statement.
>
> V2: https://lore.kernel.org/all/20231205130625.2586755-1-srasheed@marvell=
.com/
>   - Updated changelog.
>   - Handled error return for octep_ctrl_net_get_info
>
> V1: https://lore.kernel.org/all/20231202150807.2571103-1-srasheed@marvell=
.com/
>
>  .../ethernet/marvell/octeon_ep/octep_main.c   | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Good timing. I was just going to write to you about the typo :)
Looks good now.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>


