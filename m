Return-Path: <netdev+bounces-53864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE3805035
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5149E1F214E9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7D63F8C2;
	Tue,  5 Dec 2023 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="br+vUaY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF9AF
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:32:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so10988a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 02:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701772358; x=1702377158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcrhIJ2hkpJc4QCFOUPdY3i25/xRQbDoMd7SPQgxE0w=;
        b=br+vUaY4COA6Zyr81n5UF0vIOy/Oodmq4kBb2qkslXEG0CKkF0h9GpTo3bxOjjKWPG
         QZcAkMGKJUOVGs9opR5BUUwubYfRJUbon4FlSqbtqxz5jvv/Xy1RQczuhjpO09NV0u9E
         LnrlFvKBevkhxRM5AIQylFwWTRrn3fwBJq5629++w6LGPerVclZRE8vgF3u4G3ycxMAb
         mA0LdJTUeP7Gw0/ruWKRKRBFIUWy17o6BbjtVR6X4BkNeAkXlfJrYb8sm2Q/DcGte9lA
         b0rRTDnQAsC6xmdocShPsfTHZ/hhW9na8uT1WxQ8ffFPiqh7YDpNs3AQw6L8N/h/f5ig
         pxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772358; x=1702377158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcrhIJ2hkpJc4QCFOUPdY3i25/xRQbDoMd7SPQgxE0w=;
        b=h64HRBLoz+20BkxO6NXrxSLrJzoxIjHq1fi9wmIm+3hLgx1BuU2pXHt6SrsVwNEiAC
         q67nrYVO3yerMs1YucrG79a9GTplQh+T5fHuqtrOQ5UcFOK0CEDRRFRI9Yi1QER2/0au
         I9WTBQcUwHxtptBhvBrW4k/G4l8daqWIgJev5vedCjapoLAPt3IQEGrJ0ZzJ71CPh/Gx
         1PeRdiQVhi/Xkj9M1cAxO25XaaNwi8idADO3TOKFeIN4pkrb1i7tbTSISkZtJ9yYDLlo
         /YgehCkSVwXZtP0jlSLnHK+ln/uctHuARhVIeo/FWkr2DFIPBcBm8icv25E1i4PCf6pG
         zJfg==
X-Gm-Message-State: AOJu0YwxIzyQwX2nq/MPRwv4Cpv0A17dv4MWrxfbH2Bi8f2WWxIDxpjn
	+05FZ+egjecs1T3djOkCRUkVR5p4Pgxu9QjE3q8QeQ==
X-Google-Smtp-Source: AGHT+IGnXGTc/XF9yCxvfmu5BHYL1hEhhb6kzNaBSIK21wv4hIPMjChsOu6dXvMe2kN7y+KdXh7Zo2b9J6CDB1SP7K8=
X-Received: by 2002:a50:d5d4:0:b0:54b:6b3f:4a86 with SMTP id
 g20-20020a50d5d4000000b0054b6b3f4a86mr569111edj.4.1701772357605; Tue, 05 Dec
 2023 02:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <705dad54e6e6e9a010e571bf58e0b35a8ae70503.1701706073.git.pabeni@redhat.com>
In-Reply-To: <705dad54e6e6e9a010e571bf58e0b35a8ae70503.1701706073.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Dec 2023 11:32:25 +0100
Message-ID: <CANn89iL6FsYSjEMN_yLaZRDMQ3dUV2di6Va2aUH79p9RQhJSKA@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: fix mid stream window clamp.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Neil Spring <ntspring@fb.com>, 
	David Gibson <david@gibson.dropbear.id.au>, Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 5:08=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> After the blamed commit below, if the user-space application performs
> window clamping when tp->rcv_wnd is 0, the TCP socket will never be
> able to announce a non 0 receive window, even after completely emptying
> the receive buffer and re-setting the window clamp to higher values.
>
> Refactor tcp_set_window_clamp() to address the issue: when the user
> decreases the current clamp value, set rcv_ssthresh according to the
> same logic used at buffer initialization, but ensuring reserved mem
> provisioning.
>
> To avoid code duplication factor-out the relevant bits from
> tcp_adjust_rcv_ssthresh() in a new helper and reuse it in the above
> scenario.
>
> When increasing the clamp value, give the rcv_ssthresh a chance to grow
> according to previously implemented heuristic.
>
> Fixes: 3aa7857fe1d7 ("tcp: enable mid stream window clamp")
> Reported-by: David Gibson <david@gibson.dropbear.id.au>
> Reported-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

