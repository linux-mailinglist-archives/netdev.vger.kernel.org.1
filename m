Return-Path: <netdev+bounces-216323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53571B331AF
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F364617BB27
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF823F412;
	Sun, 24 Aug 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQMVdgVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404413959D
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756058282; cv=none; b=bHjXd+5gGiZBMBeFKXwL0pMB7aKjkfO5Zqk1skq0GQRbM+Ep4KfvKf4IAQv7zz43Xr++SIZt6hokpbf7p+naamoRANLF7AnFG6thfxhWIz+s5ehrMD77SL8O+afFAMV7J6tsvxgad1Dnsf1crjr9ReUuOARlu78qdnq38rYKPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756058282; c=relaxed/simple;
	bh=oWO76e1aLw3HEUKBlQb3yx7LJvlqYqffct57GCnu/xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgRSomeupGP0HT70pZ+C9/mEk/R3MJMkD5s9kFFLhQb1IBgJQ2pgGBxSvZCcPF1c82L2tfwMzzcEw3uftRJySEyZ7qtitCQ3Lo4hwJ5u6473/2HaI89Qv/rYH+kGy0D/r/OLBvoThcStE6u/l8mL3dez6z9tm5489o8P7EtsJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQMVdgVk; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3eaff77982eso15294905ab.1
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756058280; x=1756663080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWO76e1aLw3HEUKBlQb3yx7LJvlqYqffct57GCnu/xw=;
        b=WQMVdgVkKiYT1MOKXbO2gTfLjeNSBfExmqWuOGeWkjB5RZt9cx/VZkLZuiLwyJkIpT
         yWtSfgz5lFTwIqeTdWXPF9GnUgZbX8CPP54fNvSyCz83PJXZsx073QUJZ+iu+vXFZRuh
         bA7uwNYIiGN3ZitKSYGa9RLJdF50SDKvsVNM5n5kZnkaK5VLrmskEUdBuypBRQ+ztXrH
         Jn+Yk7vt+d4dctCmd+Nw4KvhSRF/2Vcf7YBlrZKEPsTNPUdM0Mw9LpIFi23IHkvbKGsz
         o5za5KWOZYoh6CLqET00rtEaUnx0zhLK85LRTSVPLdBYZHBOo1+jo8RbA9Em0UxwLHy0
         8O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756058280; x=1756663080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWO76e1aLw3HEUKBlQb3yx7LJvlqYqffct57GCnu/xw=;
        b=imEm5almKQ+Ql0AkwNncf1L7PZh6gYMtkfHC5t1eyPH6bAJYRRystNocXsFWHYxauO
         oPQaRqCnuGEFH47f6EZowDdrgzz7iVrewjYWD7/v2BfNy+YHS+YbWme7WH8pzW0gURCG
         AsRKAXtpTkIqPtB7XFA8ED3eloEbmsHFODkaxcWVUsfo9SjC6L86RXhfGAr/RO6obMei
         Mq02iRgqBPKonHABVxL/a7XmNkW6bhdNjz6nI3I61WEF4uvJ0xsxf/bGBTFc2IrpDAfU
         uIheqHtIY9aQlxClnldi8tGTF9W2V5qPkzui0ybcFwfDjPjo3ZBOJp5Lm8Cyt/EYEumV
         J71g==
X-Gm-Message-State: AOJu0Ywh5/KiNXYBT5fS/UYm8ltn47W8nZx7KH7rv69W1lrlIvBlF0bB
	YfMpMaJOJnmV3pi83JOLajABDf6FPS3ClvYW3dpA/YUtkF99u6lkQ4mKW/SyHKrAPMwE1XxF3uC
	dy3fQrDFlXUkprqvHjigdTd1jyrXarv0=
X-Gm-Gg: ASbGncs4+Rju8pCdKHgqQDUTodUYoJ2y6JgR+rCmyauggv74vIIe2sLOQrz23zpreyK
	V/MzoBIL9jg5uXsidgS5/ZR9JH97YOns6pr2K2Z9Shh5wZCE+t9xIneu4y/3fRlHmMxezbThAo+
	OYyqrKOowP7DisIv+bi/wwC4LKJlNuoiHia27gVkaqMTBa0TPBxkvoezH91AL0ab6HqOYuwvVsZ
	0UwvBpGgQ==
X-Google-Smtp-Source: AGHT+IGBOV29qleVzkamd6i+YW/4W469UQcR6Gw8ApcifRy0J3Ys3Ad8SI/KyO5oFwbnC1kzi+hk4yM9yE72iCos3bg=
X-Received: by 2002:a05:6e02:19c7:b0:3e5:6a2e:e3cf with SMTP id
 e9e14a558f8ab-3e9203e6ef4mr138237865ab.10.1756058279737; Sun, 24 Aug 2025
 10:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755525878.git.lucien.xin@gmail.com> <cb74facd-aa28-4c9d-b05f-84be3a135b20@app.fastmail.com>
In-Reply-To: <cb74facd-aa28-4c9d-b05f-84be3a135b20@app.fastmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 24 Aug 2025 13:57:48 -0400
X-Gm-Features: Ac12FXzDJGyjE62gGAfbygYFmkOBVBkIQpXbiCPP4Om7erTA8QBe7gCdmbbkrxo
Message-ID: <CADvbK_f4v916nbx4t0fnkCj44S-buTytj_Paurd3j3Ro2tLDsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/15] net: introduce QUIC infrastructure and
 core subcomponents
To: John Ericson <mail@johnericson.me>
Cc: network dev <netdev@vger.kernel.org>, draft-lxin-quic-socket-apis@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 11:21=E2=80=AFAM John Ericson <mail@johnericson.me>=
 wrote:
>
> (Note: This is an interface more than implementation question --- apologi=
es in advanced if this is not the right place to ask. I originally sent thi=
s message to [0] about the IETF internet draft [1], but then I realized tha=
t is just an alias for the draft authors, and not a public mailing list, so=
 I figured this would be better in order to have something in the public re=
cord.)
>
> ---
>
> I was surprised to see that (if I understand correctly) in the current de=
sign, all communication over one connection must happen with the same socke=
t, and instead stream ids are the sole mechanism to distinguish between dif=
ferent streams (e.g. for sending and receiving).
>
> This does work, but it is bad for application programming which wants to =
take advantage of separate streams while being transport-agnostic. For exam=
ple, it would be very nice to run an arbitrary program with stdout and stde=
rr hooked up to separate QUIC streams. This can be elegantly accomplished i=
f there is an option to create a fresh socket / file descriptor which is ju=
st associated with a single stream. Then "regular" send/rescv, or even read=
/write, can be used with multiple streams.
>
> I see that the SCTP socket interface has sctp_peeloff [2] for this purpos=
e. Could something similar be included in this specification?
Hi, John,

That is a bit different. In SCTP, sctp_peeloff() detaches an
association/connection from a one-to-many socket and returns it as a
new socket. It does not peel off a stream. Stream send/receive
operations in SCTP are actually quite similar to how QUIC handles
streams in the proposed QUIC socket API.

For QUIC, supporting 'stream peeloff' might mean creating a new socket
type that carries a stream ID and maps its sendmsg/recvmsg to the
'parent' QUIC socket. But there are details to sort out, like whether
the 'parent-child relationship' should be maintained. We also need to
consider whether this is worth implementing in the kernel, or if a
similar API could be provided in libquic.

I=E2=80=99ll be requesting a mailing list for QUIC development and new
interfaces, and this would be a good topic to continue there.

Thanks for your comment.

