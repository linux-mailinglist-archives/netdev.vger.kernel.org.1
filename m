Return-Path: <netdev+bounces-188472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613D6AACED0
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2FA1C0667D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A51388;
	Tue,  6 May 2025 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+TTtGL7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D010E4
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746563524; cv=none; b=pm4tWKoTLgn0Hvpqh3ialXHeV0vq5VqM0Rz0b3bFgNt/QbMDuw77DFKVSaLRln4GpPFOryz6cIV0agTfu6kJZX66qP0Wl9CfMvlRTQMvmHSolekRf1knO4B1WWBYUegEmubd+QnkVrSC+LxseFWg3mAokDtta3N9Iehq3FA2IlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746563524; c=relaxed/simple;
	bh=gv4p1Y0c846MNn7hdUEVlVm64teg5S7zr7LVfRvyD4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQ1PuP7lDUXzI/y3ib3MntTnudSyWXMFL5p+Pv34lwuJI5M18kuA4oVW65FD+ro4c9984KDrx7YPY/R9t8FQcYsdcLLj0dYaUudqYbDcPHaxogkEdIU5J1MOVVDGFDQdzR2k5ZLhl0CQsEMv+msXugsrmhUdtcnMtgoHhwdaOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+TTtGL7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0618746bso43856555e9.2
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746563520; x=1747168320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCTM87fiSkBmRUNr6xdpl7egxM8Mg5T9fk+mZjPXFy0=;
        b=N+TTtGL7c7eK6MrXiDVWGvxkZod+XvQzDbMDtCEHj3pCK84xgGWVH+wlxVY0V0NZX7
         783BuEYAJDeez3MQMqWKpw3RBDTQC93F7TvfZy91QwiXWbMXx5/cWvn772NAD4HrMn7D
         az9+M3BYR71/c4CAD2D2tsfSmjKujTxUCsQ1PtapIwkr3gmXLjQTvWaMpD5bIGNl4XE/
         c30RAve9CjvKXNeF8irVmc41Q0KqdgNFN3IvLfBBh8LOmu0IZZp1u7FthaBBhDWfglpL
         BbLwwf3qhc4VORJhM1BCvpjImwW1IgylXDnso5C9bpE8EQBXsfiz5/pyfldTqrtkblmm
         IRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746563520; x=1747168320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCTM87fiSkBmRUNr6xdpl7egxM8Mg5T9fk+mZjPXFy0=;
        b=hIZ99NtT/5ibGK8IkZEvzN/ZlYf4H9aTT+huLGJPHEJ7BA6DA9jVQIJEVVaHRNh0j1
         YNHC0Yp5fwpURO994O8a4QLVzYBQorR2jm8LziSC2+xxHkyhyi8RK/JqC8BNEMZ4Fds5
         gC0JwYbz01nhtTig3bsqCUanMQ209U07O8FjUW+clFxYd1uiaBph9GbWZbotyseitj3C
         tQ2/aERVkKvDqajyE/s1vBPoMwuCqzqjoQEvlCOO4MJyqO5zLbOH+qktgLBVz4xwMSi6
         LUNftQ6bicoWdDp6R2MP1dK+ofGBlbmctu2nYIoK3mO7PcbyOUCgrF7R/SMGMnJgmn9N
         C4yw==
X-Gm-Message-State: AOJu0Yx4++upSQIB9WCMUWKKJ2EXGJpV4Zsm4HGUVhsjTj1wpEwhfqfr
	xzOj8TbJyjZUbCljl9U42YmXADlUKwnSDDhQWEnkuzLSzh65yYDR7PBuxXgvWoSYr3Z1B2OXIGQ
	3KvLtT9Hf/J6TPyaf78drhLSVBhH9ww==
X-Gm-Gg: ASbGncs00yHaXA7NIkEl89uMbtaGosIv4DWK7r5sMdwIemXjSp+yfmFmrna0jvL4ZRj
	qp6gNIcVOTADJaBnq6uNsRuQ+3yWgSACsjtAFvo5sDO2APwJ6jzwbGgORNEGL1TWi8YDLC4mXTT
	QunSfMSYBhueB+IugIGjYCd7D1U4g0r0WjzNWMgr4HkPFNIWNiR8c6FsrwZSqwIvAv8w==
X-Google-Smtp-Source: AGHT+IFNbaKHDKQHczrz3LmXc6s6e0CHxT3BkpuEGcq3yqeMVhLNQzsXfsfY2bgggoAy/J1nI6eIYMuSMKCE5HU4AGc=
X-Received: by 2002:a5d:64ad:0:b0:3a0:b448:e654 with SMTP id
 ffacd0b85a97d-3a0b4a4b28bmr622373f8f.47.1746563520627; Tue, 06 May 2025
 13:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654719929.499179.16406653096197423749.stgit@ahduyck-xeon-server.home.arpa>
 <b85c0c94-6c31-4c27-b90a-0e8c540d8751@intel.com>
In-Reply-To: <b85c0c94-6c31-4c27-b90a-0e8c540d8751@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 May 2025 13:31:24 -0700
X-Gm-Features: ATxdqUGoD8U9SynepkPrTPZO65QiJAVuPAqcQU-Y7LBAQIA_7p21j8m98-J19Zg
Message-ID: <CAKgT0UdF53M8mJ43SuZNdsF4J4EoDOURwp8X2GaeHi29cn6ccQ@mail.gmail.com>
Subject: Re: [net PATCH v2 4/8] fbnic: Actually flush_tx instead of stalling out
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 11:52=E2=80=AFAM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 5/6/2025 8:59 AM, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > The fbnic_mbx_flush_tx function had a number of issues.
> >
> > First, we were waiting 200ms for the firmware to process the packets. W=
e
> > can drop this to 20ms and in almost all cases this should be more than
> > enough time. So by changing this we can significantly reduce shutdown t=
ime.
> >
> > Second, we were not making sure that the Tx path was actually shut off.=
 As
> > such we could still have packets added while we were flushing the mailb=
ox.
> > To prevent that we can now clear the ready flag for the Tx side and it
> > should stay down since the interrupt is disabled.
> >
> > Third, we kept re-reading the tail due to the second issue. The tail sh=
ould
> > not move after we have started the flush so we can just read it once wh=
ile
> > we are holding the mailbox Tx lock. By doing that we are guaranteed tha=
t
> > the value should be consistent.
> >
> > Fourth, we were keeping a count of descriptors cleaned due to the secon=
d
> > and third issues called out. That count is not a valid reason to be exi=
ting
> > the cleanup, and with the tail only being read once we shouldn't see an=
y
> > cases where the tail moves after the disable so the tracking of count c=
an
> > be dropped.
> >
> > Fifth, we were using attempts * sleep time to determine how long we wou=
ld
> > wait in our polling loop to flush out the Tx. This can be very imprecis=
e.
> > In order to tighten up the timing we are shifting over to using a jiffi=
es
> > value of jiffies + 10 * HZ + 1 to determine the jiffies value we should
> > stop polling at as this should be accurate within once sleep cycle for =
the
> > total amount of time spent polling.
> >
> > Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> >
> >       /* Give firmware time to process packet,
> > -      * we will wait up to 10 seconds which is 50 waits of 200ms.
> > +      * we will wait up to 10 seconds which is 500 waits of 20ms.
> >        */
> >       do {
> >               u8 head =3D tx_mbx->head;
> >
> > -             if (head =3D=3D tx_mbx->tail)
> > +             /* Tx ring is empty once head =3D=3D tail */
> > +             if (head =3D=3D tail)
> >                       break;
> >
> > -             msleep(200);
> > +             msleep(20);
> >               fbnic_mbx_process_tx_msgs(fbd);
> > -
> > -             count +=3D (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN=
;
> > -     } while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
> > +     } while (time_is_after_jiffies(timeout));
> >  }
>
>
> This block makes me think of read_poll_timeout... but I guess that
> doesn't quite fit for this implementation since you aren't just doing a
> simple register read...

Yeah, the problem is it doesn't quite fit. Our "op" in this case would
be fbnic_mbx_process_tx_msgs which doesn't return a value. We would
essentially have to wrap it in something and then add an unused return
value.

