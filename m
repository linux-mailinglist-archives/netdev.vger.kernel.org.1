Return-Path: <netdev+bounces-127947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E316D9772C3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A51F2428F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0A1B9853;
	Thu, 12 Sep 2024 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1+lOXEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0218BC19
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173351; cv=none; b=IKmIifTrGvj+evag9/ph1FA+QKOT0XwxUm1+0sgi4Xpwkvf3SOPpjIjL4b6ca1mxO5iuUpVNIFAc9gM6l9yfYOYtxdwdO2jPH1RfK0Uu9dtfwyhSm9trVwaP/1q9UuTDgIpNuJOwPm0Wkdaa3omdEQIowzAAYD8Ha2Fltd2dbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173351; c=relaxed/simple;
	bh=HmqxVAuwqYYO1+yuVkbRztUgGkLpCt8pKDM+zHbSFxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DktjWsyLde3ZWf2YRIOIAoTmIqMj8GuA6ZYgTOl8FZmnSZwn2MJcoTS57weN/KS/89WHFWYCqwTQlm3HNrE1BSXO87Z6hTDDQ1AGqUwGWdefecxb5ehTIwlc9Uxio+ujX7NiYqBEXoSLC5sN4b4RfVGc1hk2GF5k3RH/XsivVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1+lOXEw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4581cec6079so77201cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173349; x=1726778149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2vEG/a69XGd3EtjQSAbLhNcxHNwPDgjvUzBtNy67iE=;
        b=r1+lOXEwMSqrRzUIYur0hFywiZdnyK8U0MEJcFZVkFc3kmwPrR2/Rz9ckB2mZ09xfR
         Cg8J+0/C3T4l89bqAbHOCsJrvK4rF/Sv8ZxFDERl3bUtIU+1Ir1wWLS207fv0PQ4vKW7
         ck+sCQ/VzagHaaKxwWuG5gOnw/TIPAnpp16h9MWgSqkVFE7306tA1ycyNT9F+i7XDGnj
         pqSHClKUNfgCxpck2YU5aDum4Doer2czclj5t0+3RjgkMh7IitYA4fRXIzLlF9iiCbbb
         B1r3PqfNzAR/pNRuu5ohXo+7wWgFIF2SSokMCc1HIx4gh62kVGEDLJCb6fSaL45ADvFM
         truA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173349; x=1726778149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2vEG/a69XGd3EtjQSAbLhNcxHNwPDgjvUzBtNy67iE=;
        b=WRIWeO3DRsE6sQVw1AoNc6hT4mvG0sqGzq1BkZOatB/mX9681/29yIMSpJGYWEDZCT
         6/4XboYmz3noaOKTCalir1n4mjJDoGTgVT3jl9qzLWgzHznRd53/j/dY+xil4vt45JCx
         fj+IXG5lIFw4/VP7nSr/f6y/pvmejfw9lwD9CfjS5rpSiPIyuapdgnObljU+KWQbW9a7
         4Fxp+e0KUV5GZPYQUnqdn0u4tXUMZz1+J+lLJexTdSPxl4iFeFjlk40xPjDXDlSUGuXL
         88dMuOoy8VULjU/bLHlwo6HuSf1BxJZ6EVMQiL8gYNZloCwxS5bYj+pljOv0NXeNk7W9
         Y+6w==
X-Gm-Message-State: AOJu0Yy07/LJM3KWIBQVaCYiIJr2/mQzwtbCS65rntxwkyXNtfInutgD
	f+hoyCgMRqEexf8+nfRRhiEfJbcpdqwApSGQ3/tYOlxW8aLuSsvFvp98uUeJDBAgnGvucH63lqJ
	IENb0tJ9iadjINd/fU6NNYAcJYi5mYVXNKI1K
X-Google-Smtp-Source: AGHT+IEOt2vEb5Xvn3xNiV3LECjWDyO7bF6UVE76vOSJXMb+511YVnrbSaRN5VtX2rQV02brHAR6JVIJiEyBq97d7rc=
X-Received: by 2002:ac8:7d02:0:b0:44f:e2c1:cc75 with SMTP id
 d75a77b69052e-45860780694mr5278601cf.8.1726173349011; Thu, 12 Sep 2024
 13:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-7-sdf@fomichev.me>
In-Reply-To: <20240912171251.937743-7-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 13:35:37 -0700
Message-ID: <CAHS8izNbzurO3TNFNmzdxnCeZBizaBP4KFidxV2xtDj2nuobQw@mail.gmail.com>
Subject: Re: [PATCH net-next 06/13] selftests: ncdevmem: Remove client_ip
To: Stanislav Fomichev <sdf@fomichev.me>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> It's used only in ntuple filter, but having dst address/port should
> be enough.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index c0da2b2e077f..77f6cb166ada 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -62,7 +62,6 @@
>   */
>
>  static char *server_ip =3D "192.168.1.4";
> -static char *client_ip =3D "192.168.1.2";
>  static char *port =3D "5201";
>  static int start_queue =3D 8;
>  static int num_queues =3D 8;
> @@ -228,8 +227,8 @@ static int configure_channels(unsigned int rx, unsign=
ed int tx)
>
>  static int configure_flow_steering(void)
>  {
> -       return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s d=
st-ip %s src-port %s dst-port %s queue %d >&2",
> -                          ifname, client_ip, server_ip, port, port, star=
t_queue);
> +       return run_command("sudo ethtool -N %s flow-type tcp4 dst-ip %s d=
st-port %s queue %d >&2",
> +                          ifname, server_ip, port, start_queue);
>  }

Oh, sorry. I need 5-tuple rules here. Unfortunately GVE doesn't (yet)
support 3 tuple rules that you're converting to here, AFAIR. Other
drivers may also have a similar limitation.

If you would like to add support for 3-tuples rules because your
driver needs it, that's more than fine, but I would ask that this be
configurable via a flag, or auto-detected by ncdevmem.

