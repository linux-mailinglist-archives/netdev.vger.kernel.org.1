Return-Path: <netdev+bounces-161248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02761A202E1
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 02:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9673A28B2
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26A525A636;
	Tue, 28 Jan 2025 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7BQTTEf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046E18C910
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738026538; cv=none; b=LgQkmSJ10aoHApPbSq7nTOMtQe/K7SWO1cT9udVmIKS/2QNnhAayznMHRgNLjRcnYsI+O4D8ENsem75egHNKGhMy0EwtktiZzWgR3r6u5xuq6lwOVF9+viTjlPnEJsf17mh0gd5CVEKW1pNO2xOoOexKQXnld+BUnh7CU+VEWjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738026538; c=relaxed/simple;
	bh=Wjr6JSoOhjKACq0TrBE03Tq18AZgxaolU3lUxHzMUoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmubw3iqWk92pZrohu5lbmvQ/yEtZBgBiTG3OQnShL0FW1DAZgiGIJG4ai6VujH4rzEX42X4U/3Wn/cm55+/URDOuDuxEZkgr8TrgCRcwkLysLCN9X6jbGNw0eX/0v8UUHhYq4DSBFMTmGclLvgbeSOfgECVD7KD/on5aY2L3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7BQTTEf; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85c61388e68so1049943241.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738026535; x=1738631335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltp4PoFbd9a2JjDxLDumhbcgzCFaEqThZRQcV8ipsaQ=;
        b=l7BQTTEfVNZMsUTFi1coy0RLlOTLvVejZAR7B1DWUwvv0R0qjCj6B0UEhdF6PqOdpN
         E/tfgwC1HS3yCQxbsUWt58cgY1tIaeaoYGKpsC9c2CKtPbhyk/JCKRhaAIkJfAsWI+xI
         EGsMUAixDa9QJy+Fs10jUuGldXYRFDUjprtTWIfsCno5TpZb45ZZssX1EcPpoBxbUGAr
         GK6wKydvf1txPvzZ978QKkHdcSJmyOHOC6zqJ2OmXSiq52YvbKb8FTdR7tza9wUeHJoA
         0UIPYdGaacwRDDL+JWp294AaXnfhGCPrWJTTJO8aj05+fagbpsrziNQjYNhX2g+xYkCZ
         XM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738026535; x=1738631335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltp4PoFbd9a2JjDxLDumhbcgzCFaEqThZRQcV8ipsaQ=;
        b=eMLGi5f2nBxYevd4oPCUMOzA4EjftL2fR9geFzd/H5PE41xL+U1Ie1I03pZ3Sidh8n
         mtZGZ8DgZSPpT7Dr9Wy2+rm5YUX8EqgqwlcrdnTxRR2mnTH/CfpTA0EHSGv70uKyBR1i
         tv4ozNgXfERlxMHjy84w1NmjXc6sMKYvV632xku6QrXgS9cfnQ6W8F7u8VEXve+VirY2
         eYeeP6V3F6NZITQby5o6GnD+tHj7mJV31EXCtM2S+KwbQoxlbb5PvIAwutk/TA3doqcQ
         +zy3Ch4IF3DWpgZmsuyJNlF8DOWY2aJ5mJ7WbqKrPBEQWRwMgiRiRLjmUKqzJn709BL6
         rUsw==
X-Gm-Message-State: AOJu0Yw+EOtgG9YD8Vc5TkBY6kDYf3+dxBkr9vQl1TjZsGszm/EOqPek
	qWdUxMmOUCvot4r0Ycj3ZmK7DI9refdyowDhgj+2YmXq19cBPz8jyjHJ2MI2JXCsYRRtOa3AL+t
	XUdxs0QuYsPlBAJOWQpSWJkUZZKQ=
X-Gm-Gg: ASbGnctAuf9+EmFl0okytoL4Oo2mFiSgscuBbUbpEv0vbFoDjVbk5t87NjhnvWPn8Nu
	jXt7waCYbgyzIdczKlD7BbkhRApDBEFQqZtkgTXSqgNNlXRQsZLRi6rEE9KKitaIskrwsTlKty4
	slfX/qkcQv7N6JQgbOjdo=
X-Google-Smtp-Source: AGHT+IEdnzutJB+xnI2X8yRgBgDWBxkJBByyhXZp2tjJ9ep14ARm1nzFKesHnuudJp/ydTfUtp9GxD2Va+eX2NETs6A=
X-Received: by 2002:a05:6102:162c:b0:4b2:48cc:74f3 with SMTP id
 ada2fe7eead31-4b690bdc67emr37527748137.12.1738026533393; Mon, 27 Jan 2025
 17:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
 <20250126041224.366350-3-xiyou.wangcong@gmail.com> <20250127085756.4b680226@kernel.org>
In-Reply-To: <20250127085756.4b680226@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 27 Jan 2025 17:08:41 -0800
X-Gm-Features: AWEUYZlP6UoiQF6XQGg6l85wt36PIMcvMaB1l0Qqkhy_8V-5SIXbCoJTTTAA-ic
Message-ID: <CAM_iQpXaf9132bjg=MkJYttoz7ikypmeJbpo=-t6qJmutYe9-g@mail.gmail.com>
Subject: Re: [Patch net v2 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	quanglex97@gmail.com, mincho@theori.io, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 25 Jan 2025 20:12:22 -0800 Cong Wang wrote:
> > From: Quang Le <quanglex97@gmail.com>
> >
> > When limit =3D=3D 0, pfifo_tail_enqueue() must drop new packet and
> > increase dropped packets count of the qdisc.
> >
> > All test results:
> >
> > 1..16
> > ok 1 a519 - Add bfifo qdisc with system default parameters on egress
> > ok 2 585c - Add pfifo qdisc with system default parameters on egress
> > ok 3 a86e - Add bfifo qdisc with system default parameters on egress wi=
th handle of maximum value
> > ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
> > ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
> > ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress wi=
th invalid handle exceeding maximum value
> > ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
> > ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
> > ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
> > ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
> > ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid forma=
t
> > ok 12 1298 - Add duplicate bfifo qdisc on egress
> > ok 13 45a0 - Delete nonexistent bfifo qdisc
> > ok 14 972b - Add prio qdisc on egress with invalid format for handles
> > ok 15 4d39 - Delete bfifo qdisc twice
> > ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit =
=3D=3D 0
>
> Same problem as on v1:
>
> # Could not match regex pattern. Verify command output:
> # qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
> #  backlog 0b 0p requeues 0
>
> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/966506/1-t=
dc-sh/stdout
>
> Did you run the full suite? I wonder if some other test leaks an
> interface with a 10.x network.

No, I only ran the tests shown above, I will run all the TDC tests.

This is indeed a good hint.

Thanks!

