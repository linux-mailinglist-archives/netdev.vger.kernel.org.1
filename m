Return-Path: <netdev+bounces-183511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C1A90DE6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FD01905073
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60998197A8A;
	Wed, 16 Apr 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cv0P3Qkk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CC22E415
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744839660; cv=none; b=gXa31n6LabQT7gGRic0xctfezoLFyYZnbP4Mo/lR/rVYOZGSlmxMW/bJFzd80b1PcunkQzjyZ54wUsZKFXjXDiOaug2Kg1qMjyo/tidUsD9Og5WR/RRVtzBWFnzhhS0Of1fpWj7G5Gs6PDInQ2TPbW95cnMdC94eDXghG2h9M5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744839660; c=relaxed/simple;
	bh=3O/DlWzUS4KwiP6LLDkYBSwHM0lX4VuHS8MrBTHDEho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yv2pQHSoMoMGSIUqXf4hM14EdnAAOfxhtXJlB6yZCh+gBdVYA3Jrk12+37ZiKnpDiPDfzLFgFefyTsRR3VMmhcE7Omlw28L63zA68wvDINt8j9VB8/Jggjj5wE/GH0CejFSD0aJH0Dkdl4Di+Dqrkdv6Xe4wukAyCJgZySssj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cv0P3Qkk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47686580529so962211cf.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744839656; x=1745444456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCmul9aNyKE7nwk2BdDP/Vg46lNOgbXRm4PZWkpQFGA=;
        b=Cv0P3Qkk5wJVFRb9zmrMYurckTAGlUstUlvyzxnu+w+JyxEfh0EXnF1SNT8tg6xrs6
         7RS1LDLAzk0mgEhMZ4uRoFMT1q2WqpSyKPjUpTeFtHan9FoigsRycQ2bRCw7NfohODXM
         vQKslPrfl12jhdBDzzZLUJ64hUAGB7A4QWWk5Qub4x7rbhRbxmaiXHq67mb+nbPjI3Wp
         ilJwlu56V/e7IvmVnPWaNpbSTXTz3zyq9cq8zIDL46HC0RNZ4T6UBwqWQ+Xq0YyZRwUj
         Lgn8/nKfYlIpfaGZmsQYP2oB6MEWfIz0Gsd36QZJBhCQq4BrkPgXYTCNR0Hh3HQEatHQ
         yjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744839656; x=1745444456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCmul9aNyKE7nwk2BdDP/Vg46lNOgbXRm4PZWkpQFGA=;
        b=X8eydQOw9JcJ4ipa9+hcUY+PPilqt6zKT1Kq6Ly1IpQ5TfZ4tPQDr3MfVczko3D/9y
         /Rbw/ibRxhXPaELoFBxcBh5v/lo848y13BzpwrnvJw/ZUXCgb9Ta7E6qfpV3HHIglTWs
         VF620kH+u6C7/nVoVxnkg7FMlcDeQo/+C+Xxw5HD01YSvu5mnOsYdGpr00pIiHCZpCV+
         Na4OW9wqr1tRLNXzpHBZUZyZT7QbMQfDW7DzyMOk5JezBmSNjvBW2J/f2wDIfdutRUKF
         7HLRj/xfRsMlWe2IfxEzgSHK36n2S/blxbRa4FFRRek10HbLw5mrQ1wCQ9Q0NOMhTXHg
         uJcg==
X-Forwarded-Encrypted: i=1; AJvYcCXTHxF6fL9zl0f5KEqI7pykX0dR3TZcLH5VTvQvwHpcZBE3VSAixq6ik0ZLVdvluLP4c1Y4rVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAu9Fch7FQp/Tjlmwx0JfFFEvsHmQdpjRTR2TpeQon9Hs+aLEz
	4sVnrLCHxRWz0Xx9TEzRAmSb84IbvifmXFqRIZh7JfGKwm7Z2bkoDr6cgNTyWOqlKrsmD/CONNW
	DAMxQrcP9Tnx7k3WPwQd/K5K37WszG71wX+imAbGXg1z4Smzf6rWN
X-Gm-Gg: ASbGnct4Z29sjvIIh0raC4SYd1pK0NA6SapOwlEJhGd3pyMDPvRVmh8kspn93Gdeldd
	URJDORqPlx50MbJTxt087xzYw9HVSWKPfyw7A35GOowdM+v562gjpIfgLV3J6RX+RiXyotROKS6
	iygFW2fvhMXpjjzJ/CWXogx2ovMvWTnpMogkrc/xCVPU+BEJi84Qsm
X-Google-Smtp-Source: AGHT+IH1dAmfiL+Vu6bfk9iCwK4N/73fuEuUiYpuTFtYOmxltP1Q2lE0aNv8pNt7DL8QTGiNfI80VelWKdBs4sncrfc=
X-Received: by 2002:ac8:7dd5:0:b0:476:77ba:f7 with SMTP id d75a77b69052e-47ad81363c4mr43905061cf.34.1744839655779;
 Wed, 16 Apr 2025 14:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410175140.10805-3-luizcmpc@gmail.com> <d44f79b3-6b3e-4c20-abdf-3e7da73e932f@redhat.com>
 <CAHx7jf-1Hga_tY4-kJ_HNkgkWL6RywCmYhg2yYYX+R+mVwdTvA@mail.gmail.com>
In-Reply-To: <CAHx7jf-1Hga_tY4-kJ_HNkgkWL6RywCmYhg2yYYX+R+mVwdTvA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Apr 2025 14:40:44 -0700
X-Gm-Features: ATxdqUEiL4dtQhbygo-rKG6oZd-A0jRVyCO3zZbmD_BOMZyF5unne4fdY3-MHog
Message-ID: <CANn89i+beuSWok=Z=5gFs2E0JQHyuZrdoaT=orFRzBap_BvVzA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: =?UTF-8?Q?Luiz_Carlos_Mour=C3=A3o_Paes_de_Carvalho?= <luizcmpc@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 1:52=E2=80=AFPM Luiz Carlos Mour=C3=A3o Paes de Car=
valho
<luizcmpc@gmail.com> wrote:
>
> Hi Paolo,
>
> The dropped ack is a response to data sent by the peer.
>
> Peer sends a chunk of data, we ACK with an incorrect SEQ (SND.NXT) that g=
ets dropped
> by the peer's tcp_sequence function. Connection only advances when we sen=
d a RTO.
>
> Let me know if the following describes the scenario you expected. I'll ad=
d a packetdrill with
> the expected interaction to the patch if it makes sense.
>
> // Tests the invalid SEQs sent by the listener
> // which are then dropped by the peer.
>
> `./common/defaults.sh
> ./common/set_sysctls.py /proc/sys/net/ipv4/tcp_shrink_window=3D0`
>
>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
>    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
>    +0 bind(3, ..., ...) =3D 0
>    +0 listen(3, 1) =3D 0
>
>    +0 < S 0:0(0) win 8 <mss 1000,sackOK,nop,nop,nop,wscale 7>
>    +0 > S. 0:0(0) ack 1 <...>
>   +.1 < . 1:1(0) ack 1 win 8
>    +0 accept(3, ..., ...) =3D 4
>
>    +0 write(4, ..., 990) =3D 990
>    +0 > P. 1:991(990) ack 1
>    +0 < .  1:1(0) ack 991 win 8           // win=3D8 despite buffer being=
 almost full, shrink_window=3D0
>
>    +0 write(4, ..., 100) =3D 100
>    +0 > P. 991:1091(100) ack 1            // SND.NXT=3D1091
>    +0 < .  1:1(0) ack 991 win 0           // failed to queue rx data, RCV=
.NXT=3D991, RCV.WND=3D0
>
>  +0.1 < P. 1:1001(1000) ack 901 win 0

This 'ack 901' does not seem right ?

Also your fix would not work if 'win 0' was 'win 1' , and/or if the
initial wscale was 6 instead of 7 ?

>    +0 > .  1091:1091(0) ack 1001          // dropped on tcp_sequence, not=
e that SEQ=3D1091, while (RCV.NXT + RCV.WND)=3D991:
>                                           // if (after(seq, tp->rcv_nxt +=
 tcp_receive_window(tp)))
>                                           //     return SKB_DROP_REASON_T=
CP_INVALID_SEQUENCE;

I assume that your patch would change the 1091:1091(0) to 991:991(0) ?

It is not clear if there is a bug here... window reneging is outside
RFC specs unfortunately,
as hinted in the tcp_acceptable_seq() comments.

>
>  +0.2 > P. 991:1091(100) ack 1001         // this is a RTO, ack accepted
>    +0 < P. 1001:2001(1000) ack 991 win 0  // peer responds, still no spac=
e available, but has more data to send
>    +0 > .  1091:1091(0) ack 2001          // ack dropped
>
>  +0.3 > P. 991:1091(100) ack 2001         // RTO, ack accepted
>    +0 < .  2001:3001(1000) ack 991 win 0  // still no space available, bu=
t another chunk of data
>    +0 > .  1091:1091(0) ack 3001          // ack dropped
>
>  +0.6 > P. 991:1091(100) ack 3001         // RTO, ack accepted
>    +0 < .  3001:4001(1000) ack 991 win 0  // no space available, but peer=
 has data to send at all times
>    +0 > .  1091:1091(0) ack 4001          // ack dropped
>
>  +1.2 > P. 991:1091(100) ack 4001         // another probe, accepted
>
>   // this goes on and on. note that the peer always has data just waiting=
 there to be sent,
>   // server acks it, but the ack is dropped because SEQ is incorrect.
>   // only the RTOs are advancing the connection, but are back-offed every=
 time.
>
> // Reset sysctls
> `/tmp/sysctl_restore_${PPID}.sh`
>
> On Tue, Apr 15, 2025 at 8:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
>>
>>
>>
>> On 4/10/25 7:50 PM, Luiz Carvalho wrote:
>> > The current tcp_acceptable_seq() returns SND.NXT when the available
>> > window shrinks to less then one scaling factor. This works fine for mo=
st
>> > cases, and seemed to not be a problem until a slight behavior change t=
o
>> > how tcp_select_window() handles ZeroWindow cases.
>> >
>> > Before commit 8c670bdfa58e ("tcp: correct handling of extreme memory s=
queeze"),
>> > a zero window would only be announced when data failed to be consumed,
>> > and following packets would have non-zero windows despite the receiver
>> > still not having any available space. After the commit, however, the
>> > zero window is stored in the socket and the advertised window will be
>> > zero until the receiver frees up space.
>> >
>> > For tcp_acceptable_seq(), a zero window case will result in SND.NXT
>> > being sent, but the problem now arises when the receptor validates the
>> > sequence number in tcp_sequence():
>> >
>> > static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
>> >                                        u32 seq, u32 end_seq)
>> > {
>> >       // ...
>> >       if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
>> >               return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
>> >       // ...
>> > }
>> >
>> > Because RCV.WND is now stored in the socket as zero, using SND.NXT wil=
l fail
>> > the INVALID_SEQUENCE check: SEG.SEQ <=3D RCV.NXT + RCV.WND. A valid AC=
K is
>> > dropped by the receiver, correctly, as RFC793 mentions:
>> >
>> >       There are four cases for the acceptability test for an incoming
>> >         segment:
>> >
>> >       Segment Receive  Test
>> >         Length  Window
>> >         ------- -------  -------------------------------------------
>> >
>> >            0       0     SEG.SEQ =3D RCV.NXT
>> >
>> > The ACK will be ignored until tcp_write_wakeup() sends SND.UNA again,
>> > and the connection continues. If the receptor announces ZeroWindow
>> > again, the stall could be very long, as was in my case. Found this out
>> > while giving a shot at bug #213827.
>>
>> The dropped ack causing the stall is a zero window probe from the sender
>> right?
>> Could you please describe the relevant scenario with a pktdrill test?
>>
>> Thanks!
>>
>> Paolo
>>

