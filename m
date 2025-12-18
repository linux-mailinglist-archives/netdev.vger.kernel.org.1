Return-Path: <netdev+bounces-245353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FAECCBFB7
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C5933078A58
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0704325483;
	Thu, 18 Dec 2025 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+s3WPdH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71433468F
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063996; cv=none; b=FLniTEls8Xoxa6Z/qytg4frmMvopU7Dx4BF/7AdSsIGx/li5oT8jlCmDGgxJzi0/cVt8v++3EYVykhWH/cBMBxlaqgjLY40J32ZjgzhCbgzObpQ7NammaQqjd0Vk9XdHK33BbRY8J6Hh0OBDLxEdW1V0b9lVECBecXVGd1ay/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063996; c=relaxed/simple;
	bh=EnwfDLWUY+Fw2KC3MOQ+Ckn2SxrU12E1/NErfevgd60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGlu/ORKzeZd4BeNJjdMSPlijPjcFZHioS57U8VSDSFNRfDqUiFfOizXUFsQkAoPn/cgA/oD9dWCyYWFFz2XWrGUhYv344zhSORgh2I5O1EGHpUFoidR0UWSKJEY9QKClU63KFe4l34gg004e7Ylm37q/DScsyXv9E/XsYycjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+s3WPdH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed82e82f0fso6156811cf.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 05:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766063994; x=1766668794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPlb2PglMzu8yHMN62qZs2ZNPe5MYbdq5uqzn5IaBQw=;
        b=I+s3WPdH3oDtJvSDLJlJfGQUz+zd+/3ADD/lN2tXkOJSCPbt2C+QFkL0RWvU1NQfGZ
         0KUB9JpLuJULXx87q5BrsioLzvMPEkg2WmtAafVOKF9mhKlRUxhyZLhJx7hPdIIJ7rc0
         1Af2IIsTL66sJ9Jb7j5GIG8DrcwWRL+iXHneWXjqWrFs3m+5DOwwisTuQ6VvCFrfj7g8
         urukwfqZ5D9pr6wJS5BZSy4SneE2wGy4foeFYRyx3C5ZWn7Sz03y1XZWsvTXIepkLIEL
         231qA/ffJDDJe2qym/Vqx0Vlb2gJbdZQgkBJFECPuaC3dQyYtNDtfg766oeWx+PXkhfQ
         d0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063994; x=1766668794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPlb2PglMzu8yHMN62qZs2ZNPe5MYbdq5uqzn5IaBQw=;
        b=RakphwGjq/zRKysv0OfRBc0/bWNMiOeQodtBb72fbS5f/m/zH/L6CfmppvJdaJ+2Xj
         BtaXztNGmfi4eQcfPEilrSV8yi3DV+8XEUQuarz0KaQu7voaWFQdqBrScQB6QhM4W9jD
         y983pFmyMJquS9WUb7MU+lq66i3YWQwiNgOLQd6Fv6EWukKsT2k3MCmu01Ryp/VHTY3M
         K401pASK6VsPX5nt8qq67dOg7lWR21BlFF2g/wI3lUtAdGMWLZNyaBLd5YOd2ELdyiul
         r6EAjU7j5COfUwjkkfso7sQvkqTNsPLSYJNPWfZENmhJ4IFjDeEtLtermChwM+f9CCWA
         fx+A==
X-Forwarded-Encrypted: i=1; AJvYcCXPlScylTU8RjGi9GKoWV9oFPZIOtrQY6+F+9OUDf8+FJDVAc8BUs5uBTVSxQO+IP6IUT4rFEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGmqtBCOQ6DKRr9wIDLTwUJou6XQjmfzrJRbFgXxKpQ27l4fT
	Ps14OwnIAJSSMJUjCNP/F0wb6JlCROqyBTBfO/PrRJkImMivYbuLfZXnBOrVugGLA7F8pmUfWwG
	QRnP1z+BTCkFuAQWfaI5g2X3kyIfMGMX/ZLpYDwys
X-Gm-Gg: AY/fxX4jin8kNttGDQGgHA/9jRX86VuoaDl8wbZQAM71ROFEKyPmeeKTh/up3J0d0ZU
	AUskYwY0CsYXDq9+15JbExYGtXqjdQzqH9pxHCcpbR8vibJIXEKHcXCcfr8bQK43GwqpQq0LewD
	3zvNW1Y8H4h1s75RIQwzJvt8vgKpoRxJ9G0DD5E45M1B/Qac4JhEZONmBS7GQ/0ndP/e+Tx1SeY
	fknjL9KI77P1BjH/SiDGw+pjzDbxCqRIrG6bFGyGDIKFyCSfMMHNi8oySKQKsId4TN6ra0H
X-Google-Smtp-Source: AGHT+IGeKrn1BtwRLoY8U0eN5oWs+hlpIxXID3ee3RQos5MXwugX1v1GWHX0w4TPh+5BHUQAdA3xCb+sv8UQKM0dRUU=
X-Received: by 2002:ac8:5a8c:0:b0:4e8:b9fd:59f0 with SMTP id
 d75a77b69052e-4f1d0628505mr285636461cf.61.1766063993307; Thu, 18 Dec 2025
 05:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-8-edumazet@google.com>
 <cd44c0d2-17ed-460d-9f89-759987d423dc@proxmox.com> <8f8836dd-c46f-403c-b478-a9e89dd62912@proxmox.com>
 <CANn89iL=MTgYygnFaCeaMpSzjooDgnzwUd_ueSnJFxasXwyMwg@mail.gmail.com> <c1ae58f7-cf31-4fb6-ac92-8f7b61272226@proxmox.com>
In-Reply-To: <c1ae58f7-cf31-4fb6-ac92-8f7b61272226@proxmox.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Dec 2025 14:19:40 +0100
X-Gm-Features: AQt7F2qiRiRsfonJcan7tcn11I8CO5pdAJuDG8PRTH_e2bt1Li56XNKJRilbWxY
Message-ID: <CANn89iJRCW3VNsY3vZwurvh52diE+scUfZvwx5bg5Tuoa3L_TQ@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Christian Ebner <c.ebner@proxmox.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	lkolbe@sodiuswillert.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 1:28=E2=80=AFPM Christian Ebner <c.ebner@proxmox.co=
m> wrote:
>
> Hi Eric,
>
> thank you for your reply!
>
> On 12/18/25 11:10 AM, Eric Dumazet wrote:
> > Can you give us (on receive side) : cat /proc/sys/net/ipv4/tcp_rmem
>
> Affected users report they have the respective kernels defaults set, so:
> - "4096 131072 6291456"  for v.617 builds
> - "4096 131072 33554432" with the bumped max value of 32M for v6.18 build=
s
>
> > It seems your application is enforcing a small SO_RCVBUF ?
>
> No, we can exclude that since the output of `ss -tim` show the default
> buffer size after connection being established and growing up to the max
> value during traffic (backups being performed).
>

The trace you provided seems to show a very different picture ?

[::ffff:10.xx.xx.aa]:8007
       [::ffff:10.xx.xx.bb]:55554
          skmem:(r0,rb7488,t0,tb332800,f0,w0,o0,bl0,d20) cubic
wscale:10,10 rto:201 rtt:0.085/0.015 ato:40 mss:8948 pmtu:9000
rcvmss:7168 advmss:8948 cwnd:10 bytes_sent:937478 bytes_acked:937478
bytes_received:1295747055 segs_out:301010 segs_in:162410
data_segs_out:1035 data_segs_in:161588 send 8.42Gbps lastsnd:3308
lastrcv:191 lastack:191 pacing_rate 16.7Gbps delivery_rate 2.74Gbps
delivered:1036 app_limited busy:437ms rcv_rtt:207.551 rcv_space:96242
rcv_ssthresh:903417 minrtt:0.049 rcv_ooopack:23 snd_wnd:142336 rcv_wnd:7168

rb7488 would suggest the application has played with a very small SO_RCVBUF=
,
or some memory allocation constraint (memcg ?)

> Might out-of-order packets and small (us scale) RTTs play a role?
> `ss` reports `rcv_ooopack` when stale, the great majority of users
> having MTU 9000 (default seems to reduce the likelihood of this
> happening as well).
>
> > I would take a look at
> >
> > ecfea98b7d0d tcp: add net.ipv4.tcp_rcvbuf_low_rtt
> > 416dd649f3aa tcp: add net.ipv4.tcp_comp_sack_rtt_percent
> > aa251c84636c tcp: fix too slow tcp_rcvbuf_grow() action
>
> Thanks a lot for the hints, we did already provide a test build with
> commit aa251c84636c cherry-picked on top of 6.17.11 to affected users,
> but they were still running into stale connections.
> So while this (and most likely the increased `tcp_rmem[2]` default)
> seems to reduce the likelihood of stalls occurring, it does not fix them.
>
> > After applying these patches, you can on the receiver :
> >
> > perf record -a -e tcp:tcp_rcvbuf_grow sleep 30 ; perf script
>
> We now provided test builds with mentioned commits cherry-picked as well
> and further asked for users to test with v6.18.1 stable.
>
> Let me get back to you with requested traces and test results.
>
> Best regards,
> Christian Ebner
>

