Return-Path: <netdev+bounces-152260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988929F33F0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A301882CB4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE42812AAC6;
	Mon, 16 Dec 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7sl6m0n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211B80C0C
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361376; cv=none; b=UBgrCMiXCHUgCvWBHkPFONEA72hbCvQnyEz+5S+AlU6UfTWAwmE3p1sOsrSbRDWlxva3slfqwtOYD173pPYEIk0ipNe46d4YWj6272SwZZW+IC0t694BPsfuFD+8K/wBbo4+bm72j4+FOYservQQClehYqFWnjtRrTctXpZHOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361376; c=relaxed/simple;
	bh=pBHh7x9MbfgFnr8mnumBL3NUm05HvWpLkiUSLf1aAuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDh7qywWKgkroGnX8zQAi4TeUCJ1PP4ADtkME/q9P/ROVzNs9KipPx1sxi7MEIbE0a2Hrl/AAe418D0NuXNpgjxxfQgPvWFXTVoz02bH/LHz6bv1b/j3d+DrvA3tY0152OppdH4rxQN6sYZdcZ9dHRcSaAQRMv5Wo1ZsAARaKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7sl6m0n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734361373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4UmPpDr2qbnqpLOLD4ofX5SjtNCNlNe7IdvTmByqlU=;
	b=J7sl6m0n8LiJp5/51ixZ6bFackt8R7j+8wMl7No4HdyKTS5/xy62aWk80OsnjD6XriVeXK
	w1x80bP4W6mMyrT2yuzs98tOPMEPBjmC3FTB5A4P5SWxdhT5O9jPw5u0uScgFPcrep3zIy
	PR8h3Onf6Ie7QPU+C84AoLqJn+pHMH8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-WosE-cnlPW6QNtlJTlpHJA-1; Mon, 16 Dec 2024 10:02:51 -0500
X-MC-Unique: WosE-cnlPW6QNtlJTlpHJA-1
X-Mimecast-MFC-AGG-ID: WosE-cnlPW6QNtlJTlpHJA
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e4c27270591so1527087276.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734361371; x=1734966171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4UmPpDr2qbnqpLOLD4ofX5SjtNCNlNe7IdvTmByqlU=;
        b=i3DjRZrQGhAmrU2gBRbJw9yVLgUty/6Fwp/P/iHYv2nD3P+fswohRB/rlDVQcPN3Sx
         goTFMXbXC5dNQbsiuf6UM2mx8CvDXZkRuWW11VPdlp+mTKQV4JdZ7eihvpSUtz/+NIF6
         xUjflB5QaUMmzcYxveU5wk+5QAioaHJmJ3D2TrBA0JUrp1M5+RE8Sp6bV+B8HfS8vdaT
         c6GspsTRmBZtXlwd1ZbQKNfUdMujrhtIOqfg7UoUOJN6WW4xHU1h9tl+T6bYKncsmpaY
         Abgjs4e8QPYJCeVBdA/3BtmaN5QwSui0teCIsZH8B+T0j0BoQmLnDBUBgjbHiSlNYHHI
         vWEg==
X-Gm-Message-State: AOJu0YyqwKCvUPK5lqlGQgFv/Prrs/m1TzE9EZIuxY4nr6p9CEqaNZI5
	JR5HjiPObLY4yuqJABVNXi+VExGmmeIBEkcViPM0IEVaMVKjDXCFBGodascMOjF329yDUNWtW2P
	BjZqpixWDDnvq+r3RA5BqBqmpZc6NFVzz1aaLlpztMF8Drga/Ww9LvfTKLXCaNiEvdLa/aAsM/Q
	1I3ONnYOB1D5GYAyt9PUTmeDRWSv1Qpw4gwTCK1LA=
X-Gm-Gg: ASbGncubeD9tfZuwgAtvnnHR/mbfTtRQOiAAKh7N9tIVVDTACqeU7eE6t3yq/ztW6FW
	jozrM5dG2ww3ThI0PpnQFisKGPOMl5Mz9wcAj
X-Received: by 2002:a05:6902:2086:b0:e4e:723f:cad5 with SMTP id 3f1490d57ef6-e4e723fee02mr3202218276.0.1734361371036;
        Mon, 16 Dec 2024 07:02:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgNGinJdcHc6XzDZfGrEOobOoLXldiPWRB3bBnHkAaoUnKeA/mtdO5D0VvgAEPUj3QKg0lMUoGgWt9+qkF6yo=
X-Received: by 2002:a05:6902:2086:b0:e4e:723f:cad5 with SMTP id
 3f1490d57ef6-e4e723fee02mr3202173276.0.1734361370650; Mon, 16 Dec 2024
 07:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-4-55e1405742fc@rbox.co> <bl3osg7ze6bjivu53j5vdlrtkzq35vk3zbp2veosyklp53rf2i@drb2efczau6n>
 <dfc51f68-5013-4c7a-ba0d-d3969ac9ecc8@rbox.co>
In-Reply-To: <dfc51f68-5013-4c7a-ba0d-d3969ac9ecc8@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 16 Dec 2024 16:02:38 +0100
Message-ID: <CAGxU2F6oyu0pGbFOhM-KhmmQaYzib8pTWt3xEpOjO2VRYT8ucw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] vsock/test: Add test for accept_queue
 memory leak
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:52=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 12/16/24 15:35, Stefano Garzarella wrote:
> > On Mon, Dec 16, 2024 at 01:01:00PM +0100, Michal Luczaj wrote:
> >> Attempt to enqueue a child after the queue was flushed, but before
> >> SOCK_DONE flag has been set.
> >>
> >> Test tries to produce a memory leak, kmemleak should be employed. Deal=
ing
> >> with a race condition, test by its very nature may lead to a false
> >> negative.
> >>
> >> Fixed by commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory
> >> leak").
> >>
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >> tools/testing/vsock/vsock_test.c | 51 ++++++++++++++++++++++++++++++++=
++++++++
> >> 1 file changed, 51 insertions(+)
> >>
> >> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vs=
ock_test.c
> >> index 1ad1fbba10307c515e31816a2529befd547f7fd7..1a9bd81758675a0f2b9b6b=
0ad9271c45f89a4860 100644
> >> --- a/tools/testing/vsock/vsock_test.c
> >> +++ b/tools/testing/vsock/vsock_test.c
> >> @@ -1474,6 +1474,52 @@ static void test_stream_cred_upd_on_set_rcvlowa=
t(const struct test_opts *opts)
> >>      test_stream_credit_update_test(opts, false);
> >> }
> >>
> >> +/* The goal of test leak_acceptq is to stress the race between connec=
t() and
> >> + * close(listener). Implementation of client/server loops boils down =
to:
> >> + *
> >> + * client                server
> >> + * ------                ------
> >> + * write(CONTINUE)
> >> + *                       expect(CONTINUE)
> >> + *                       listen()
> >> + *                       write(LISTENING)
> >> + * expect(LISTENING)
> >> + * connect()             close()
> >> + */
> >> +#define ACCEPTQ_LEAK_RACE_TIMEOUT 2 /* seconds */
> >> +
> >> +#define CONTINUE    1
> >> +#define DONE                0
> >
> > I would add a prefix here, looking at the timeout, I would say
> > ACCEPTQ_LEAK_RACE_CONTINUE and ACCEPTQ_LEAK_RACE_DONE.
>
> I was hoping to make them useful for other tests (see failslab example in
> patch 6/6). If CONTINUE/DONE is too generic, how about prefixing them wit=
h
> something like LOOP_ or TEST_ or CONTROL_ ?
>

In that case, I'd add them on top of the file.
CONTROL_CONTINUE, CONTROL_DONE looks good, but also others are okay, up to =
you.

Thanks,
Stefano


