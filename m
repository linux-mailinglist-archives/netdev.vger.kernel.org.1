Return-Path: <netdev+bounces-126317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482DF970A9F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 01:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661E51C20D55
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDDB146D75;
	Sun,  8 Sep 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta+9LwkM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402A3A1B5
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838653; cv=none; b=ntbdBj2pD5RvvGQSxbh/PuekYniqaAD37UchKHY0Tj8V9fqvqN4lu9x3MIW+n6S1NmYWKubT7s9ZL84nIfA2nFDXin7Stv8ewJYeBTgdkLReCuSN5vGt9RgIwLNMEJtIJsRPRL6wNkd0SRm2r8iUCMfHxRv2fHCgF8BT+BJPrl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838653; c=relaxed/simple;
	bh=Cy2j38RMl3IRkdLrnUbsDI976Q4T1Hiqzd3VJRuseEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU1mSnVyvE4/naCUh1INIwzunGTG53UaLenDeYrWk72iByrkCo8+qJAtyevykHap02HvSEQEms+rWCFjEgTHSyR8DSTs9zDrxIgFk/rWQv2brGdozLB+fPI2KgNXXSy/IiBZU20IPscEnXyL8r2ZhwljCJ4Cg3RM1tQ0PsnXXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta+9LwkM; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82ce603d8daso19586539f.0
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725838651; x=1726443451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIuzdvxBbqIWv6m6+F3fynzFNAcLH4nSjM06dWivSlI=;
        b=Ta+9LwkMZ1ovpRtvlHWVod/a70F3kXG4fm23GGidyM/XAp1iB6KtbYkAgyZ89Cbt2H
         6VfdO0kawe7c/yaahbDXgrNuXrAGaTXfYU+c81rhrkEbiHf3yMA0riosA7lC3h7Sumjs
         uMFuk8wGPV++OwSMvgymhjE//LjaRmygh00nTxBgiXZWZg7ZwSOQ4KTmaVAxk2EEuROI
         wgu8asohSEe2kVgKFcnTQswYE9bti8T3a1oGcBjtxj8lYfjjP5cbLXbjE9hXK73DHDlk
         v+8eUGvNMDIN7qcMw6pkX0z7H1P7/Kr7XPb8HgdIgUVEQbHQg1ag6RFt8poQUjF9hJxy
         ilww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725838651; x=1726443451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIuzdvxBbqIWv6m6+F3fynzFNAcLH4nSjM06dWivSlI=;
        b=pk/htqpOq6Ws2zLbOoRUHeHNmlmWCH7Rk3AXAxBc2Zmn5hc8uNMU2SneiecdEIzysD
         zORwluOu2VPgxP2khHUODBwMSo20CZoNrHJjvJoPAO0VMOLXs4Dql61l4JIBvpK2UjPo
         LIqkQBtnKwClUD0Zwe53fPKtg+tXc5nFVILAvDrsKvJHhWtmReqxhlgE2yarZs8dCY9I
         qRRzeRD64is03s9fLKf9WtsXYAsZf6bh/J9kOGhEFwFhi7ppAtywXAYV0NIKTN4eglX7
         NBcNTFr4aiddFbGT2exrjnkee/6AFRJwaPtnAdkmCgNCpJ1fQTqLn6LpbNWQKut98AVH
         dpKA==
X-Forwarded-Encrypted: i=1; AJvYcCViqOikyzDPMzrLMsPG385nEif4YULWT6Zq7Ys8GjrsSKLaI4ZOQnD9U3ahNqidr0vmGqVsu5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4TciVU9lCfn3xO0iknG6cEHpKqdpjuFIhIPBYqqFbISK+ccb
	ERtW5nFD5yd21T3SX4PmO+mdDv/vBNUwtm4FAQ10OsCh1Yp+4UvxdZY71ceMeJ8mGBeFNGu06Q0
	qBD8q3lPfBjnmMfs4XPn0jeUpjozSTpJS3B0=
X-Google-Smtp-Source: AGHT+IExI51jJjL73h1ReBdES8SNPtX+xB0FJDlJrF5NozAbS1Wsv1PLm/Uv7ipJGV71170WJZO2lmXSiECw+MSiwMU=
X-Received: by 2002:a05:6e02:1aa7:b0:3a0:56c8:f7ef with SMTP id
 e9e14a558f8ab-3a05745f099mr64484435ab.8.1725838651648; Sun, 08 Sep 2024
 16:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902130937.457115-1-vadfed@meta.com> <20240902130937.457115-2-vadfed@meta.com>
 <CAL+tcoAjjWNPcxFxWdWf+AJJbvzZJpfv7w+JfU63UMe7KMp5SQ@mail.gmail.com> <44ac9083-9394-4116-b447-1501abb6f570@linux.dev>
In-Reply-To: <44ac9083-9394-4116-b447-1501abb6f570@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Sep 2024 07:36:55 +0800
Message-ID: <CAL+tcoD9WQvJ_UfiYLZz6t=JOu_xPxEG_RKNBggzHnBUADLE6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: txtimestamp: add SCM_TS_OPT_ID test
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 4:04=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 02/09/2024 15:24, Jason Xing wrote:
> > On Mon, Sep 2, 2024 at 9:09=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com=
> wrote:
> >>
> >> Extend txtimestamp udp test to run with fixed tskey using
> >> SCM_TS_OPT_ID control message.
> >>
> >> Reviewed-by: Willem de Bruijn <willemb@google.com>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >
> > Thanks for adding the combination test !
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Apparently, I realised that combination tests had been coded before this
> change.
>
> run_test_all() {
>    setup
>    run_test_tcpudpraw    # setsockopt
>    run_test_tcpudpraw -C   # cmsg
>    run_test_tcpudpraw -n   # timestamp w/o data
>    echo "OK. All tests passed"
> }
>
> This function runs tests for TCP/UDP/RAW sockets (defined in
> run_test_tcpudpraw) 3 different times - with no extra options,
> with CMSG option and with "run_test_tcpudpraw":
>
> run_test_tcpudpraw() {
>    local -r args=3D$@
>
>    run_test_v4v6 ${args}   # tcp
>    run_test_v4v6 ${args} -u  # udp
>    run_test_v4v6 ${args} -r  # raw
>    run_test_v4v6 ${args} -R  # raw (IPPROTO_RAW)
>    run_test_v4v6 ${args} -P  # pf_packet
> }
>
> So if I add "-o <val>" for UDP and RAW sockets in run_test_tcpudpraw it
> will be run with CMSG option too.
>
> I'll remove the "run_test_v4v6 ${args} -u -o 42 -C" from the next
> version as it's already covered.

Oh, right. Thanks for finding this.

