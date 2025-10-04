Return-Path: <netdev+bounces-227844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B206EBB87BA
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 03:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69AD54E04B1
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155C13AD3F;
	Sat,  4 Oct 2025 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzdGLc7v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB73BB5A
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759541109; cv=none; b=pumIWQQYvRkJyD5cG5vuP0+66f5NOqxXmzYyC3PECsuuJtL/8OOl2cNhRSo09u3ktxZSfMOrsWQZOIsftnNyYvq2Eselr18Vr9xIRuw6NAkYOB4Lu/OUIkouK/Yac4jmsysuHajszhGUq0/SnsaLoBMTf7ucKUZH4ZwmcDSUAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759541109; c=relaxed/simple;
	bh=+To9qhjGZdWqvjUJUjoLEc2FFSywFbjQYQhvvHv1UpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRv5TuIlWvnjJIgzbF1eajAt7Z325AVfAbDbroZDm289mA/DHv/4R4Vyt7YCvQ2Dtj71yFa9+S/gb7p5NUW4m5i4Xr3M5D+egzhPOlooDDGp60QvOJh71jXpGE/VZYx2X/ZQy60bCUKYU57F3xOP1mGFrtVnz7dXCqao5bqsEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzdGLc7v; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4de66881569so185551cf.0
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759541106; x=1760145906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g4bxCs/sd8CpCoj1f+doQE0G5h0wdZMgsM/YAEitD8=;
        b=uzdGLc7vYgCyiiYfUq4bBya68ncUQ7iZskGmXSDjy0fkiVCYrqRrCwrlPpRYMzJwnC
         yPAJyIRUMpWR82VMD2Tk7QYT7/lAGYOAqmO0ieyK3fG8tK2r8RI5KwtBotwdtRQjpqap
         xMWoeT/Vb+O3K2zzo/xXK3LXAVAf5Ka+lEPgrUES4DoGKO6a3Rb63IwVBpPOAKfVVYJh
         Egjd/dsqaD4KyyuHMdCr0jrLvVVfSFI4e5XNZMZibH3v9653GTMWYsqC9nmhyohB+JAT
         QGYPRBjdGbd6RU1P2PZbStj6UDKNCo+yQ14dNJKRc9TdDb/kC1B0/2a/xakxIMFL9LnV
         ZDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759541106; x=1760145906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g4bxCs/sd8CpCoj1f+doQE0G5h0wdZMgsM/YAEitD8=;
        b=SklnkqMgXVa4qmu/UD3ludUoBMQYtazixa13IBwjq3Fi5PWUsuvt+PNQqJ4rPbwSed
         OCJ5eZJkd4ZmRZNxUd33TUmzBSuTp0H5nLVqtH795aSzq/04v1RCYmcL0q5AiwrzM9ZT
         Cb7XImF1CE7jvscejxFwt3WfDvRgd82uJl53zSECjzuG4lVgWm5gVVgq4WL8LeX0SuMV
         xJGu9PHaOALh/JS5hNuxaGcClh640syu/frBFqlwrjFNB3wrHfDDjXMVpSggOy0wc8tQ
         0R/LTHZ31DRUxHGbuGcMgsloej3/ZXRBpdaI4e/feLn4P94JtHY4fNcx7xMIlwvMosjs
         EecQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiHAsQkrNUe6J+c/sGVWWnNeOCI9MyJReDcQYW50sy9dYzf+uXSIQ+/JXhdWpOD7zKwlk0Cbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIIm9Dy4mhaaiVeast/C5djOcy0xnFkqyadpHI49eQukCyce7
	6XBPxk9UyPRPn7OSeYHUjeeLOmZPoEsQsB1KL+QK61tGJ071TBdWGTT1eCX9YqRQxgyetL4w6my
	+cvV58hEQM8vwPiRi/XZqfs4K/9uHj874N0ZISZ0C
X-Gm-Gg: ASbGncvqZ3QGfYT9NQ+DGc73Z6C0dSSAUl9i2VTTiUy+5BwYU2h9oj7mkBgbWDHbV0V
	t24Xl1rMCZG4PIXtpLUoeqPybmT0mLe0iukrKGl8EURMXYj/SZSezVJom54Vcj9ZYnbTaTbYy7k
	IX+7C0g8Su5pfl1S5iVQmZUMhIDJZN5RyoZKkGHJTRtvCIHCHiTnA+HmyHRLCmJ0FH+jygqKP6K
	CIrrP7mQ4NWBarh8mzGb/NSkvbhyXWMDX1g2JPaJIHl5d4ZpazH6cHTFzy5dXTaVxDOiT2arBXm
	2vSTqVcEeT4eHvrd
X-Google-Smtp-Source: AGHT+IH2lS/4Gy0WrVP8+Bx/RqT5XU/9tkO3Gb8fEzLTaF0NnczqJC1FzN6tNPYC6gtkL0hMiwKuBPp65QCF9s0yMdA=
X-Received: by 2002:a05:622a:1444:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4e5821d9f66mr2188601cf.13.1759541105852; Fri, 03 Oct 2025
 18:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
In-Reply-To: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 3 Oct 2025 21:24:49 -0400
X-Gm-Features: AS18NWCQxxjtgSMyPF9xqMmn1Zy4-359N_8BGDZpkrSXUpWR_gst5dfQXbAuVXs
Message-ID: <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
Subject: Re: TCP sender stuck despite receiving ACKs from the peer
To: Christoph Schwarz <cschwarz@arista.com>
Cc: edumazet@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 8:29=E2=80=AFPM Christoph Schwarz <cschwarz@arista.c=
om> wrote:
>
> Hi,
>
> tldr; we believe there might be an issue with the TCP stack of the Linux =
kernel 5.10 that causes TCP connections to get stuck when they encounter a =
certain pattern of retransmissions and delayed and/or lost ACKs. We gathere=
d extensive evidence supporting this theory, but we need help confirming it=
 and further narrowing down the problem. Please read on if you find this in=
teresting.
>
> Background: We have an application where multiple clients concurrently do=
wnload large files (~900 MB) from an HTTP server. Both server and clients r=
un on a Linux with kernel 5.10.165
>
> We observed that occasionally one or more of those downloads get stuck, i=
.e. download a portion of the file and then stop making any progress. In th=
is state, ss shows a large (2 MB-ish) Send-Q on the server side, while Recv=
-Q on the client is zero, i.e. there is data to send, but it is just not ma=
king it across.
>
> We ran tcpdump on the server on one of the stuck connections and noticed =
that the server is retransmitting the same packet over and over again. The =
client ACK's each retransmission immediately, but the server doesn't seem t=
o care. This goes on until either an application timeout hits, or (with app=
lication timeouts disabled) the kernel eventually closes the connection aft=
er ~15 minutes, which we believe is due to having exhausted the maximum num=
ber of retransmissions (tcp_retries2).
>
> We can reproduce this problem with selective ACK enabled or disabled, rul=
ing out any direct connection to it.
>
> Example:
>
> 11:20:04.676418 02:1c:a7:00:00:01 > 02:1c:a7:00:00:04, ethertype IPv4 (0x=
0800), length 1514: 127.2.0.1.3102 > 127.2.0.4.46598: Flags [.], seq 138089=
6424:1380897872, ack 2678783744, win 500, options [nop,nop,TS val 217589851=
4 ecr 3444405317], length 1448
> 11:20:04.676525 02:1c:a7:00:00:04 > 02:1c:a7:00:00:01, ethertype IPv4 (0x=
0800), length 78: 127.2.0.4.46598 > 127.2.0.1.3102: Flags [.], ack 13810195=
04, win 24567, options [nop,nop,TS val 3444986302 ecr 2175317524,nop,nop,sa=
ck 1 {1380896424:1380897872}], length 0
> ...
> (this pattern continues, with incremental backoff, until either applicati=
on level timeout hits, or maximum number of retransmissions is exceeded)
>
> The packet that the sender keeps sending is apparently a retransmission, =
with the client ACK'ing a sequence number further ahead.
>
> The next thing we tried is if we can bring such a connection out of the p=
roblem state by manually constructing and injecting ACKs, and indeed this i=
s possible. As long as we keep ACKing the right edge of the retransmitted p=
acket(s), the server will send more packets that are further ahead in the s=
tream. If we ACK larger seqnos, such as the one the the client TCP stack is=
 using, the server doesn't react. But if we continue to ACKs the right edge=
s of retransmitted packets, then eventually the connection recovers and the=
 download resumes and finishes successfully.
>
> At this point it is evident that the server is ignoring ACKs above a cert=
ain seqno. We just don't know what this seqno is.
>
> With some more hacks, we extracted snd_nxt from a socket in the problem s=
tate:
>    sz =3D sizeof(tqi->write_seq);
>    if (getsockopt(fd, SOL_TCP, TCP_QUEUE_SEQ, &tqi->write_seq, &sz))
>       return false;
>
>    // SIOCOUTQNSD: tp->write_seq - tp->snd_nxt
>    int write_seq__snd_nxt;
>    if (ioctl(fd, SIOCOUTQNSD, &write_seq__snd_nxt) =3D=3D -1)
>       return false;
>    tqi->snd_nxt =3D tqi->write_seq - write_seq__snd_nxt;
>
> Then we cross-referenced the so acquired snd_nxt with the seqno that the =
client is ACK'ing and surprise, the seqno is LARGER than snd_nxt.
>
> We now have a suspicion why the sender is ignoring the ACKs. The followin=
g is very old code in tcp_ack that ignores all ACKs for data the the server=
 hasn't sent yet:
> /* If the ack includes data we haven't sent yet, discard
> * this segment (RFC793 Section 3.9).
> */
> if (after(ack, tp->snd_nxt))
> return -1;
>
> To verify this theory, we added additional trace instructions to tcp_rcv_=
established and tcp_ack, then reproduced the issue once more while taking a=
 packet capture on the server. This experiment confirmed the theory.
>
>   <...>-10864   [002] .... 56338.066092: tcp_rcv_established: tcp_rcv_est=
ablished(2874212, 3102->33240) ack_seq=3D1678664094 after snd_nxt=3D1678609=
070
>   <...>-10864   [002] .... 56338.066093: tcp_ack: tcp_ack(2874212, 3102->=
33240, 16640): ack=3D1678664094, ack_seq=3D308986386, prior_snd_una=3D16786=
06174, snd_nxt=3D1678609070, high_seq=3D1678606174
>   <...>-10864   [002] .... 56338.066093: tcp_ack: tcp_ack(2874212), exit2=
=3D-1
>
> The traces show that in this instance, the client is ACK'ing 1678664094 w=
hich is greater than snd_nxt 1678609070. tcp_ack then returns at the place =
indicated above without processing the ACK.
>
> From the packet capture of this instance, we reconstructed the timeline o=
f events happening before the connections entered the problem state. This w=
as with SACK disabled.
>
> 1. the HTTP download starts, and all seems fine, with the server sending =
TCP segments of 1448 bytes in each packet and the client ACKing them.
> 2. at some point, the server decides to retransmit certain packets. When =
it does, it retransmits 45 consecutive packets, starting at a certain seque=
nce number. The first thing to note is that this is not the oldest unacknow=
ledged sequence number. There are in fact 88 older, unacknowledged packets =
before the first retransmitted one. This retransmission happens 0.000078 se=
conds after the initial transmission (according to timestamps in the packet=
 capture)
> 3. the server retransmits the same 45 packets for a second time, 0.000061=
 seconds after the first retransmission.
> 4. ACKs arrive that cover receipt of all data up to, but not including, t=
hose 45 packets. For the purpose of the following events, let those packets=
 be numbered 1 through 45
> 5. the server retransmits packet 1 for the third time
> 6. multiple ACKs arrive covering packets 2 through 41
> 7. the server retransmits packet 2
> 8. two ACKs arrive for packet 41
> 9. the server retransmits packet 1
> 10. an ACK arrives for packet 41
> 11. steps 9. and 10. repeat with incremental backoff. The connection is s=
tuck at this point
>
> From the kernel traces, we can tell the sender's state as follows:
> snd_nxt =3D packet 3
> high_seq and prior_snd_una =3D packet 1
>
> At this point, the sender believes it sent only packets 1 and 2, but the =
peer received more packets, up to packet 41. Packets 42 through 45 seem to =
have been lost.
>
> This is where we need help:
> 1. why did the retransmission of the 45 packets start so shortly after th=
e initial transmission?
> 2. why were there two retransmissions?
> 3. why did retransmission not start at the oldest unacknowledged packet, =
given that SACK was disabled?
> 4. is this possible given the sequence of events, that snd_nxt and high_s=
eq were reset in step 5. or 6. and what would be the reason for it?
> 5. does this look like a bug in the TCP stack?
> 6. any advice how we can further narrow this down?
>
> thank you,
> Chris

Thanks for the report!

A few thoughts:

(1) For the trace you described in detail, would it be possible to
place the binary .pcap file on a server somewhere and share the URL
for the file? This will be vastly easier to diagnose if we can see the
whole trace, and use visualization tools, etc. The best traces are
those that capture the SYN and SYN/ACK, so we can see the option
negotiation. (If the trace is large, keep in mind that usually
analysis only requires the headers; tcpdump with "-s 120" is usually
sufficient.)

(2) After that, would it be possible to try this test with a newer
kernel? You mentioned this is with kernel version 5.10.165, but that's
more than 2.5 years old at this point, and it's possible the bug has
been fixed since then.  Could you please try this test with the newest
kernel that is available in your distribution? (If you are forced to
use 5.10.x on your distribution, note that even with 5.10.x there is
v5.10.245, which was released yesterday.)

(3) If this bug is still reproducible with a recent kernel, would it
be possible to gather .pcap traces from both client and server,
including SYN and SYN/ACK? Sometimes it can be helpful to see the
perspective of both ends, especially if there are middleboxes
manipulating the packets in some way.

Thanks!

Best regards,
neal

