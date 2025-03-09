Return-Path: <netdev+bounces-173382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1381A58914
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 00:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805FE3AC20F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B632144AE;
	Sun,  9 Mar 2025 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="eJFmYpSm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8361DD894
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561549; cv=none; b=ddoCrKu+FAufAHgZY+NcQX+duniXrhLsgMmcWKp0J3XMeQloFpdhJUmkjvazUKX+qQR4c+iMIjIPDhvLvspbf2AI15VD9P9Jff/FSThbibpLjRgr0l8wDc7sDlntRxFvkTaLHN0O49w5qt/S7+NIkxD0uhKcNGmFh1qAhCAFuic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561549; c=relaxed/simple;
	bh=MffiF0Wn82Seqcw01SU8DY1OW/G1HSa353Cqemk5vvw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ZZlG/THp5vaZQvP5ew6jlkzIRp78ZtqIoJPpsbL+g2EvAdS7y+3HBeTLk3j3dMiS8ZlRBofnnd1dOVypeCsrnlq756NBNphwZaOwtHceh8hTqS0ounCfM2ziQ4Ywsm+XSjHBFyp2HUag13o522uMVl0wLlACQnv0kMMXRTtC7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=eJFmYpSm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240b4de12bso51689915ad.2
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741561547; x=1742166347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0keXZkPsTTdBL/rvExQtd5iE/L2t/Hwn43/MiqZGYk=;
        b=eJFmYpSmmIp6CxONaTxt6x6WspzHjzVSCRGcsglVtJmCH2G38UhXlDr3TWe3VZ6V0p
         dUsMK4iub9m9o8yybzoT5HCpJiR+JjfIetv+X7BeGonFBAx61ZGqnCKbSB/711LZXIZi
         udCLauU+eR/U4jCmizH5s9/JRgCTd4S0ss54YS83VhFkr+oqVr7xYnDz1nmF6IOdXaVw
         z+MG7Fa6wrgkWLO+mWtSjK+A2jB43s/MT7Xmht2npdMDzjB8FmAucuftmJ9zAAf+qhcc
         EG4akL35P6n5rslI/EYj5ngANsegUoxrZv9aNy38CJYYqD1a3SDZzuqg9rTfXLjaUQa5
         tOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561547; x=1742166347;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0keXZkPsTTdBL/rvExQtd5iE/L2t/Hwn43/MiqZGYk=;
        b=NAWdvhz3POnkgzbu3dQQGnzvY61fC6AU1ws5hXoQofUCBZnL6pWooxOtZ/U1QIupul
         ODdJXCWMEfXSSxzNgW4a2Hg4UKUfGuNzdRQpE21Cky25lBoDgdGWqZL9Fh+/K5a5DoBW
         S6aMDlqMmsUTkbK+xb0HosTbP0c0Lu7uhy4sfc2Z/8FI3IuFHEI7IaO/TyJW3rfdXLKV
         60LeXFqfpu3Crjk6/ZqxSPMbvtMMSFkZygxQyz1ajf6vLAAydZEy245opmA9Cyeldn2W
         hiZnFnAQZkZQcX7p6HR7P8QwD5akjtAraHc1xvHACQd1BZH14T3BgDwPlCc7lTlBqs26
         yoEg==
X-Gm-Message-State: AOJu0YwwmAReTQPKmdbUQd5Hxof4lsqMeqY/BQZp9a9AuRFdUTGWjOVK
	yyYl9zLcKHdK+MGHjjt1U/SElEnhVbQ/8yvUghQVArPQoOwbX7OBecdbwNKtouZpCWWfP2Zdx3+
	G6cjaJg==
X-Gm-Gg: ASbGncu1RbwKF5dXPKvQ6VWVuwwFm/RTt4CeCewYQhl2th37cHdnbh8FzEsXrkTSOdA
	8pPs94pg7v+XV58XAKwiGrX+WscnwzpAI56lOQBC86aIDgtXbX9X8iN8ZH6MmhHVPuajOlSHFSq
	D10wSgC2YjItfLAxFD9NEzn4v4B5Rkdet4eL5BWFh6hB3mexKbOAyhr7lExiYBzKhTSj/0963qY
	XJmoeLu22gnFCjJZllGoBx5ipL1is0gxabj207roPof2E4FhK1eC7vfmR8KQXrhJqfNx331LShY
	qRG30T1toZ0NRpVkikBEJc58BsRQSO89+TxmTfocNCdDhzb4u85waISyuaeTRMHvp4mgL3yGMYH
	H6dMVau/H1iu2cPoppg9ADQ==
X-Google-Smtp-Source: AGHT+IEEWMvD8gAKYFfq9JmZmpDpAt6BktURu45aJwBj9+ZQCQ5HeIrlT67Tvw4UrAuJLdAM7aBqTw==
X-Received: by 2002:a17:902:ce83:b0:21f:c67:a68a with SMTP id d9443c01a7336-22428a890c3mr206081885ad.31.1741561546944;
        Sun, 09 Mar 2025 16:05:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7fasm64726165ad.115.2025.03.09.16.05.46
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 16:05:46 -0700 (PDT)
Date: Sun, 9 Mar 2025 16:05:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 219849] New: Issue with Missing Final ACK in TCP
 Connections to gracefully close the TCP connection =?UTF-8?B?4oCT?=
 Regression in 5.15.123 (15251e78)?
Message-ID: <20250309160544.31536ac4@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Begin forwarded message:

Date: Fri, 07 Mar 2025 19:35:26 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 219849] New: Issue with Missing Final ACK in TCP Connections =
to gracefully close the TCP connection =E2=80=93 Regression in 5.15.123 (15=
251e78)?


https://bugzilla.kernel.org/show_bug.cgi?id=3D219849

            Bug ID: 219849
           Summary: Issue with Missing Final ACK in TCP Connections to
                    gracefully close the TCP connection =E2=80=93 Regressio=
n in
                    5.15.123 (15251e78)?
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: marko.pacaric@mercedes-benz.com
        Regression: No

Created attachment 307779
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307779&action=3Dedit =
=20
Wireshark_cutout

Dear Linux Community,

I=E2=80=99m currently investigating a complex issue related to TCP connecti=
on
termination and would appreciate your insights to help clarify the situatio=
n.

Background

We have a complex network setup involving multiple hops and a special
implementation on the mobile provider side.

Given this setup, we rely heavily on TCP connections being gracefully
closed=E2=80=94following the standard FIN =E2=86=92 FIN-ACK =E2=86=92 ACK s=
equence.

The Problem

For the past few months, we have been struggling with an issue where the fi=
nal
ACK from our client is not being sent, leaving the connection stuck in
CLOSE_WAIT or LAST_ACK state on the receiver's side. This behavior is causi=
ng
significant issues in our system.

What We've Tried

1.       Application-Level Investigation
o    Initially, we suspected an issue in our implementation.
o    We rebuilt several applications, but the final ACK was consistently
missing.
o    We even tested with different programming languages and libraries=E2=
=80=94same
issue.
2.       Kernel & TCP Stack Configuration
o    We modified various TCP stack parameters, but none of the changes reso=
lved
the problem.
Findings

To isolate the issue, we started testing with different Linux kernel versio=
ns:

=C2=B7         Our current used version5.15.123
(KERNEL.PLATFORM.2.0.r10-05800-kernel.0) =E2=86=92 Final ACK is missing, co=
nnections
remain in FIN_WAIT_2.
=C2=B7         5.15.104 (KERNEL.PLATFORM.2.0.r10-04600-kernel.0) =E2=86=92 =
Final ACK is
sent, connections close correctly.
Through systematic downgrading, we identified that 5.15.104 is the last ver=
sion
where the issue does not occur. We then analyzed the commits between these
versions and found that the issue seems to be introduced by the following
commit:

=F0=9F=94=97 Commit 15251e783a4b
https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/15251e783a4b

What did we do now

We build ourselfs a small patch which reverts the commit, so that we can se=
e if
the false behavior is revered.

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

1.       Could this commit be responsible for suppressing the final ACK in
certain network conditions?
2.       Has anyone else observed similar behavior in recent kernel version=
s?
3.       Are there any known workarounds or patches addressing this issue?
Any insights or suggestions on how to proceed would be greatly appreciated!

Thank you very much,

Marko

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

