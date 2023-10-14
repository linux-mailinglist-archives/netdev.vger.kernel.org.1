Return-Path: <netdev+bounces-40942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA67C9269
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 05:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B22F282312
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76298A46;
	Sat, 14 Oct 2023 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOt6Xo5w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ACD367
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 03:13:12 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A0B7;
	Fri, 13 Oct 2023 20:13:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so32623031fa.2;
        Fri, 13 Oct 2023 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697253189; x=1697857989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kczTBtEmRiBKNmdXxJoIn5oWpUhD3mts59tfdc3H1g=;
        b=KOt6Xo5wmJ/EG/2KdbJdlFGQTKB6Yim1TS4eiJUuePU6nBeAvsa5HRxI+uSyOCTDt8
         eHJR0/yqRF0wiF1jiOjawaohzi/SfpAdrzJwXMqXYfwkricrPtRr4BJTkS/2RTGcSGUz
         JbLtO8PRkD3RFXuwi4JFUm9ntcYBjce9eMMeepIkU7GkpxE5ObbQd52MCqvgCX9hfCs7
         +2drIa+zU0GGz6i7y1vGdRVIqfVJVBpjKyhGRyPPqbiPlbE/vLH+XqoPoh9MTEFnNmzv
         WHKiiwE2FVfLi5DwYQCn2Hwag0I+S89Br0oSvqJVSRLJ4iOXLsSINBPNxafIRTObm9nI
         e0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697253189; x=1697857989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kczTBtEmRiBKNmdXxJoIn5oWpUhD3mts59tfdc3H1g=;
        b=vuvb/UWynkIRb3MPgXHslkS4FwUZ/+XhkVUvvVs1/lox8Sa8H4nbDmu1Y34bMeO9dS
         zufwUL9zRwRjBVnjn/MsL++bkp8WjZs6XRwvzvCx06AAn2WexrtPVV+Sg2gfEOnz6d6R
         Rew5Uq1/vY8LgWlQYmcbGg/eSLuPalL05P7WXemnuzgrYtR73H3BS9kGJIMWuhBOzP4R
         FBzIuJPUURIbmzoLqv5xt2ayYT89/e2EL2hOs3/5gXKrwbylxrLqa7MBQ5p0rl4Tm+4q
         HLlMj+XYDTOe/eN5/1wq4ffP8u/+2xzN3umqkf7ewAH1E4UxSxV5DIT34YPSWWs2+hWx
         cQTA==
X-Gm-Message-State: AOJu0Yxhm8W95WerNizs4AExwU2LPT1PgBM0tUfLcphhv7juuUQRw5go
	wkk3I20rNWR64bralqj7ZcKLBQRzR83tYY52yg/D3hFWqQ+KtpJc
X-Google-Smtp-Source: AGHT+IHe8+SyPHcz9aA8FyvWw325/ne8Vx3vooCEnOjO55pTXKNU9F/C3QGfXYzC3RzT+r9MqfG5CzquORjyp81s69Y=
X-Received: by 2002:a2e:9b97:0:b0:2bf:d379:275b with SMTP id
 z23-20020a2e9b97000000b002bfd379275bmr27820357lji.20.1697253188843; Fri, 13
 Oct 2023 20:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011191524.1042566-1-luiz.dentz@gmail.com> <20231013175443.5cb5c2ce@kernel.org>
In-Reply-To: <20231013175443.5cb5c2ce@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Oct 2023 20:12:56 -0700
Message-ID: <CABBYNZ+A9Zk8HbQBPNXFLbaR_maCY7o5qHtx_MTJqhQ=LNBMPQ@mail.gmail.com>
Subject: Re: pull-request: bluetooth 2023-10-11
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

On Fri, Oct 13, 2023 at 5:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Oct 2023 12:15:24 -0700 Luiz Augusto von Dentz wrote:
> >  - Fix race when opening vhci device
> >  - Avoid memcmp() out of bounds warning
> >  - Correctly bounds check and pad HCI_MON_NEW_INDEX name
> >  - Fix using memcmp when comparing keys
> >  - Ignore error return for hci_devcd_register() in btrtl
> >  - Always check if connection is alive before deleting
> >  - Fix a refcnt underflow problem for hci_conn
>
> Commit: fc11ae648f03 ("Bluetooth: hci_sock: Correctly bounds check and pa=
d HCI_MON_NEW_INDEX name")
>         Fixes tag: Fixes: 78480de55a96 ("Bluetooth: hci_sock: fix slab oo=
b read in create_monitor_event")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> Commit: 6f0ff718ed67 ("Bluetooth: avoid memcmp() out of bounds warning")
>         Fixes tag: Fixes: d70e44fef8621 ("Bluetooth: Reject connection wi=
th the device which has same BD_ADDR")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> Commit: b03f32b195df ("Bluetooth: hci_event: Fix coding style")
>         Fixes tag: Fixes: d70e44fef862 ("Bluetooth: Reject connection wit=
h the device which has same BD_ADDR")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> Commit: a9500f272b3b ("Bluetooth: hci_event: Fix using memcmp when compar=
ing keys")
>         Fixes tag: Fixes: fe7a9da4fa54 ("Bluetooth: hci_event: Ignore NUL=
L link key")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> :(

Not sure what I'm doing wrong, because verify_fixes.sh doesn't
actually warn these for me, or perhaps it needs to be used in a clean
tree/new clone since it may match commit ids of different
branchs/remotes? Anyway, I'm preparing a new pull-request.

--=20
Luiz Augusto von Dentz

