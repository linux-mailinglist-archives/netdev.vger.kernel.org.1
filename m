Return-Path: <netdev+bounces-173586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48DA59AB6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EE63A57BE
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACDF22F175;
	Mon, 10 Mar 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF8IuDSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202122F169
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623235; cv=none; b=ul5K7KfFfIWG2KmEtS+rhshHFinAHltyhY7F3uwg2kLcuNJ85MBZ4LZryMjcSuGd4hgv96eyB+K28pmxbgShmJztpkDMu95myvN09IygwfcJlMUCHChmGL8v7634Ws5Tmw6oZoUza7UX8wt8JWQl6NcZfAPUI1V7T0i3LDeXFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623235; c=relaxed/simple;
	bh=8cdP/X065XIpFmNvk5BwhOe6MhJWL1zf/s7vWeqVm4s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cU+utkuK5p6HXNvTZzBtcY7r43GAk6E42q4m4kMO4ACPuhzs11Xd5VRDjsLoEYd0zyjghgIgzV1YJSOl0FSbnMYacsMZBKHWCGFpdOWag5gabD1+eYz4wZaSTpUHTLBAVeAOXlNFn86PNeYbk9S2E5WbTO/FwdPn/JkYyM9F9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF8IuDSX; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-474f836eb4cso33609031cf.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741623233; x=1742228033; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=COVpYdBoouVgCpAOQPtxH+KEsi8ZTYSoNxnFzj5nsjU=;
        b=AF8IuDSXmTb1BTGAVy8tzU3hjTdQ4EzTJ65x6dulkX27LVAg3IZi0Px7Q7wR7NO/Wo
         I/EiJ5K9JzdmtVytCRpqa6qUtNyzJ8QIzLZq9ppJPdqSweVoK79D5KkXhpS1NbfEzB81
         QX1j3jl/ROz8JGlGsMWr/fyEuOyDk9BoHcZPMuJrnr7Sn93MQVpVVYISrtpLDG+Q0hUx
         hwFQDtSiu+6H6X2ukX7hVYr01GfoppJLXvI4mNmkVEw2NTp0utjDOQEQuC3/U/eGpN1d
         jxByeQU4XBMo/RLL9h2R41VDwjQyakA4RmfBYTLkhk1KTSwXlUTGSiOcySNczFbEA9tZ
         ta/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623233; x=1742228033;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COVpYdBoouVgCpAOQPtxH+KEsi8ZTYSoNxnFzj5nsjU=;
        b=Rfft/5tyXQSTvotr9DgaGILwwNSi/PZlpkPfnrDq4RfnDMS7yg7cMrixNj1LSPgW+r
         2b3rVpnTb8glxXzsgzrZk7M34Af1oQ9IHJkd+gSe03RTB2fEk0F/b1zxOgKIUHbuBLOk
         NMZJp/sb2ga9FYxwq9CNAowtY2BTpt7D+wSaXB4G4j3S5T3lT7c6oI/e/PayNCeR4Unz
         JkXigF096DCCkVzVfxVhrgscd8vywSfW87U9fz6gKB4TonElWqv5uFjltSk2OOhcrfY1
         XIKQAKqqeFY12YhOOIsFKDHX7XzP0DCtPQpYN9DRs6/VQeVNCmNZu5SpBFjtNkOCxWDP
         5W6Q==
X-Gm-Message-State: AOJu0YwLpcFEg/UTJMnn63iX3VyX+UoGJDA00lvKZrNYyQ7CgXRSCkrb
	9yCOzxE8LIN8Ue7OXCQ78oc8T9n+bBussUOn2dqtv5LsaPSTiWiM1XWpjQ+qyGn+nCHwYRnrnkS
	LJIIQnI5cV5jUIXnl5QBLGTlEKv2ru/3vN2k=
X-Gm-Gg: ASbGnct/TdKEGBqFrZC2Fc5tp5V0nDAJI5PQVXqMrF4cmhTb7Iv3AgPr3PnskE5+p1b
	PoLbbdAwitB+2qdJXOqDZVrJmlOQa8d6zS++E0Bjm8CmlcKv/3mWYQy7kvQSkxh8wcgqEXUrMSG
	Po4TvFLgcb8qGHVGXM1sM1mL0=
X-Google-Smtp-Source: AGHT+IEM8HAxvgs5kElpFYuqDKH+yqNGStIxHemsJi+WY3wS4Mi91Pa9KX+JFjQUrogCT6GICKl82+2l8HVut2cJlOY=
X-Received: by 2002:a05:6214:1d22:b0:6e8:9525:2ac3 with SMTP id
 6a1803df08f44-6e9006adc67mr214194676d6.34.1741623232424; Mon, 10 Mar 2025
 09:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marko Pacaric <mpacaric2@gmail.com>
Date: Mon, 10 Mar 2025 17:13:16 +0100
X-Gm-Features: AQ5f1JrVgDXgCQQdL3nB08fej5300vuPxnI0yw9dU9LEQqA1zBB5820ixkSoUwQ
Message-ID: <CAAup_245hpq0Z52Q-N7ecoen=x9yCSDBMHiRdk_uSf5V4t0qnA@mail.gmail.com>
Subject: =?UTF-8?Q?Issue_with_Missing_Final_ACK_in_TCP_Connections_to_g?=
	=?UTF-8?Q?racefully_close_the_TCP_connection_=E2=80=93_Regression_in_5=2E15=2E12?=
	=?UTF-8?Q?3_=2815251e78=29=3F?=
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Community,

I=E2=80=99m currently investigating a complex issue related to TCP connecti=
on
termination and would appreciate your insights to help clarify the
situation.

Background

 We have a complex network setup involving multiple hops and a special
implementation on the mobile provider side.

 Given this setup, we rely heavily on TCP connections being gracefully
closed=E2=80=94following the standard FIN =E2=86=92 FIN-ACK =E2=86=92 ACK s=
equence.

 The Problem

 For the past few months, we have been struggling with an issue where
the final ACK from our client is not being sent, leaving the
connection stuck in CLOSE_WAIT or LAST_ACK state on the receiver's
side. This behavior is causing significant issues in our system.

 What We've Tried

1.       Application-Level Investigation

Initially, we suspected an issue in our implementation.

We rebuilt several applications, but the final ACK was consistently missing=
.

We even tested with different programming languages and libraries=E2=80=94s=
ame issue.

2.       Kernel & TCP Stack Configuration

We modified various TCP stack parameters, but none of the changes
resolved the problem.

Findings

To isolate the issue, we started testing with different Linux kernel versio=
ns:

Our current used version5.15.123
(KERNEL.PLATFORM.2.0.r10-05800-kernel.0) =E2=86=92 Final ACK is missing,
connections remain in FIN_WAIT_2.

5.15.104 (KERNEL.PLATFORM.2.0.r10-04600-kernel.0) =E2=86=92 Final ACK is se=
nt,
connections close correctly.

Through systematic downgrading, we identified that 5.15.104 is the
last version where the issue does not occur. We then analyzed the
commits between these versions and found that the issue seems to be
introduced by the following commit:
Commit 15251e783a4b
https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/15251e783a4b

What did we do now
We build ourselfs a small patch which reverts the commit, so that we
can see if the false behavior is revered.
After applying the following patch, we do no longer observe the missing ACK=
s:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c

index 420d3bdeaa1b..0580d8719f37 100644

--- a/net/ipv4/tcp_ipv4.c

+++ b/net/ipv4/tcp_ipv4.c

@@ -923,7 +923,6 @@ static void tcp_v4_send_ack(const struct sock *sk,

                              &arg, arg.iov[0].iov_len,

                              transmit_time);

-       sock_net_set(ctl_sk, &init_net);

        __TCP_INC_STATS(net, TCP_MIB_OUTSEGS);

        local_bh_enable();

}

Next Steps & Questions

1.       Could this commit be responsible for suppressing the final
ACK in certain network conditions?

2.       Has anyone else observed similar behavior in recent kernel version=
s?

3.       Are there any known workarounds or patches addressing this issue?

Any insights or suggestions on how to proceed would be greatly appreciated!

BUG - 219849

Thank you very much,

Marko

