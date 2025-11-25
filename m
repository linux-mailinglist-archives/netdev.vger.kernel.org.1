Return-Path: <netdev+bounces-241646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D1C87171
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C4354E1809
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4B92DF146;
	Tue, 25 Nov 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkLU+TAE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED5241679
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764103446; cv=none; b=DW8YdtQRg1ocoxxhgadqulWEYOoVQpB8J7c8f19RqAq5VuPuZFMsqi35SwnGNMnlDDMolngGAqY8etJbpmnU7IaYIoOjS357AVnJGgfYAMwPcacXS6HY1sHjA/GvbDwbQF5yfOjTmbMrGIkn2Q9svtjfbYDqFFYoDbfxqbtb330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764103446; c=relaxed/simple;
	bh=9mdznmO3wUK4MjEQ+LZho0iNWTstEZv+If4W1+7o9bU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iDrHfFsqC8jsI05KlD5c3zloR+51/Wje7wi5VPhNO35LeONbt8nds+tXaphT+0V5ocObfSLY6nZEDH9pO7uV0xmOoKFfzeIwiKGBPTT4VHZ4DwepS3KsYb37nvYRhDp2jqsyHcRAP3hb7akqrdpqE9QYUdwwlkUPdRa8fbqQaDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkLU+TAE; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64306a32ed2so3506268d50.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764103444; x=1764708244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+khoHZPaphdRPp3QxoZeI3NByUKX1JJPYRUrZ2Auvtw=;
        b=AkLU+TAEGqFbZt14UR4nSom/rWtydJPVmiaRPvKhWGSCLmdycxwpGRuyFwENEdMSLS
         LayaBpVaeWkcNRO6c+hfoWpqKOy2Xmx6yy9KM4bes+yh27AI8bStVrSiN0zhhMsLxvqB
         v6htzAp7FySxQIt9ohDPzGg+0e2cLVmGI7Tucey/a49x9one/OWgFO2Kf6MuSRe/hPCy
         6dUAl5SOOOhND6laRZItXQg6Vz+ZVtH1TxFmYfGEh42dhUmNNuZfRIB4JEzI3EwCcHrT
         ylPlUVGfEmYcCogUKDsGV0KeQz739cABX2DJuDHsB6UPCiVwrHx+5p/E2gqYlFpJS2Ml
         iB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764103444; x=1764708244;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+khoHZPaphdRPp3QxoZeI3NByUKX1JJPYRUrZ2Auvtw=;
        b=QVrSl5QSzOKWv0kD7ZlDdwIjkFjglFoaIld2mMmAGb53NAwnlO4SzAgqxlHdxugPj5
         cxul33lvfsJ2I25YsRBy+WX1M93tpBsvweLvmipgJqlLsBsQJ10u5NhkVaG2OUgluzaY
         b/u5OMK+tNo0mna5MwES0Lu/NGzdcjCMzE9s5gopp1F0gS4hjKpZ19yCyKHIjSt9AnWR
         FjVfCgaY8+19Ptn34VjnRIF1eAgFrYU2BqLqilQLSKvzwUqFnuzM7Zn/O2NlDIr6ODCd
         6CwERtcFkyZNEPoTpD0zf6Ijph5QE2g//eeDFpPjecAOv5onwd/+co/qkWNORCl/0IsD
         BisQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkz2ALI68LJ9Zqap0ZYfwC8RwchIsPmVjlZRCzVki5BAOX43VKNMi93VzIqRwOPmMfC2gwWdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzDJe0H0TRFmedsjYPpMvMWfOKEF/t6QDoSelnGzl8W4N8LdPA
	zV7AJK3x7sI/DvkSYV1GrsjRtnO/sHLcvDbaGdZhBwYtEKglGX5+Bd8Iw1+qhA==
X-Gm-Gg: ASbGnctnphPnY/GoZrj/fmyxeShvR6EgIG9im0bbME9co86pEadeMJw5TeQfow+mgjq
	6UNGarxlnvFRPvt3EQJtHLvoK5HQOxvFpFS6Sz334x0AAd6Syq6yWcHiXNpyFNS+unE1Fnz04n/
	53lISnIyPa4EOvkjGVCudxnk4Z+Z1edRI3qBGCunkJgWEMYnVlFwiUvd/ahTW6Zp/y65OcCQ+GM
	CRxrQ4KWZpPNDLHXoAXgI4luHrCDWE5TdgPRaZElLTl9fCCS1Dyz4G9K3FSAdtd/+XV429EwS+c
	R+G8Cz1NiZIQWx2+XiIAHqufgktMV1YQ8EusMQ8Uj7OnM2stEN3u47cjxPOBcMFVYCyjV+t1A1n
	Dy+zadd8u+e58IMWgPwImRaRSPbOtGbd0l9bbEi0J1h8NJJbXbIyipGADM7VBJFfmm8CU4M5yUZ
	uWIvRg1sPBN6tLZn1IkhJzgmZeOD2USZaivCf8mlHCPWaxeos6pM+XJTkNWHUXyGW47vGs20ENC
	N5qQw==
X-Google-Smtp-Source: AGHT+IHujq/6V9mKy90dSniQiCQQnRv6pVyD3bQ/oDaXPnP5Iofgu+ymJon2Qds/xkwPr79kQOkB9w==
X-Received: by 2002:a05:690e:4089:b0:63f:a856:5f56 with SMTP id 956f58d0204a3-64302a2a196mr11638191d50.5.1764103443761;
        Tue, 25 Nov 2025 12:44:03 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a7987f5efsm59505087b3.9.2025.11.25.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:44:03 -0800 (PST)
Date: Tue, 25 Nov 2025 15:44:02 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Neal Cardwell <ncardwell@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2303cd61bcc5e@gmail.com>
In-Reply-To: <CADVnQykwTjoTVV_jBmUXAMKato-3MwS+j6PdyVFtTxjndcC=bQ@mail.gmail.com>
References: <20251124071831.4cbbf412@kernel.org>
 <willemdebruijn.kernel.1fe4306a89d08@gmail.com>
 <CADVnQym7Whnbc9xf_dew-ey1fGFBY1dSf6RJ=9qLNP=u+NYOEw@mail.gmail.com>
 <willemdebruijn.kernel.39fa9d8834471@gmail.com>
 <CADVnQykwTjoTVV_jBmUXAMKato-3MwS+j6PdyVFtTxjndcC=bQ@mail.gmail.com>
Subject: Re: [TEST] tcp_zerocopy_maxfrags.pkt fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Neal Cardwell wrote:
> On Tue, Nov 25, 2025 at 2:49=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Neal Cardwell wrote:
> > > On Mon, Nov 24, 2025 at 11:33=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jakub Kicinski wrote:
> > > > > Hi Willem!
> > > > >
> > > > > I migrated netdev CI to our own infra now, and the slightly fas=
ter,
> > > > > Fedora-based system is failing tcp_zerocopy_maxfrags.pkt:
> > > > >
> > > > > # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrec=
t outbound data payload
> > > > > # script packet:  1.000237 P. 36:37(1) ack 1
> > > > > # actual packet:  1.000235 P. 36:37(1) ack 1 win 1050
> > > > > # not ok 1 ipv4
> > > > > # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrec=
t outbound data payload
> > > > > # script packet:  1.000209 P. 36:37(1) ack 1
> > > > > # actual packet:  1.000208 P. 36:37(1) ack 1 win 1050
> > > > > # not ok 2 ipv6
> > > > > # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
> > > > >
> > > > > https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/resu=
lts/399942/13-tcp-zerocopy-maxfrags-pkt/stdout
> > > > >
> > > > > This happens on both debug and non-debug kernel (tho on the for=
mer
> > > > > the failure is masked due to MACHINE_SLOW).
> > > >
> > > > That's an odd error.
> > > >
> > > > The test send an msg_iov of 18 1 byte fragments. And verifies tha=
t
> > > > only 17 fit in one packet, followed by a single 1 byte packet. Th=
e
> > > > test does not explicitly initialize payload, but trusts packetdri=
ll
> > > > to handle that. Relevant snippet below.
> > > >
> > > > Packetdrill complains about payload contents. That error is only
> > > > generated by the below check in run_packet.c. Pretty straightforw=
ard.
> > > >
> > > > Packetdrill agrees that the packet is one byte long. The win argu=
ment
> > > > is optional on outgoing packets, not relevant to the failure.
> > > >
> > > > So somehow the data in that frag got overwritten in the short win=
dow
> > > > between when it was injected into the kernel and when it was obse=
rved?
> > > > Seems so unlikely.
> > > >
> > > > Sorry, I'm a bit at a loss at least initially as to the cause.
> > >
> > > I agree this is odd. It looks like either a very concerning kernel
> > > bug, or very concerning packetdrill bug. :-)
> > >
> > > Could someone please run the test with tcpump in the background to
> > > capture the full packet contents, to verify that indeed the packet =
has
> > > the wrong contents?
> > >
> > > This would help make sure that this is a kernel bug and not a
> > > packetdrill bug. :-)
> >
> > I'm not able to reproduce this on my own machine with the latest nn.
> > But could reproduce it on the netdev machine.
> >
> > I assume all payload is supposed to be zeroed. And indeed the packet
> > seen has a non-zero single byte of payload: 0x60.
> >
> > Is there any chance that this happens on some kernel with
> > unsubmitted patches, but not on netdev-nn/main on this machine either=
?
> >
> > ----
> >
> > tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect
> > outbound data payload
> > script packet:  1.000169 P. 36:37(1) ack 1
> > actual packet:  1.000167 P. 36:37(1) ack 1 win 1050
> >
> > 14:42:01.330694 tun0  Out IP6 fd3d:a0b:17d6::1.webcache >
> > fd3d:fa7b:d17d::1.50901: Flags [P.], seq 19:36, ack 1, win 1050,
> > length 17: HTTP
> >         0x0000:  6000 842c 0025 0640 fd3d 0a0b 17d6 0000
> >         0x0010:  0000 0000 0000 0001 fd3d fa7b d17d 0000
> >         0x0020:  0000 0000 0000 0001 1f90 c6d5 f7fe 05e9
> >         0x0030:  0000 0001 5018 041a e883 0000 0000 0000
> >         0x0040:  0000 0000 0000 0000 0000 0000 00
> > 14:42:01.330723 tun0  In  IP6 fd3d:fa7b:d17d::1.50901 >
> > fd3d:a0b:17d6::1.webcache: Flags [.], ack 36, win 257, length 0
> >         0x0000:  6000 0000 0014 06ff fd3d fa7b d17d 0000
> >         0x0010:  0000 0000 0000 0001 fd3d 0a0b 17d6 0000
> >         0x0020:  0000 0000 0000 0001 c6d5 1f90 0000 0001
> >         0x0030:  f7fe 05fa 5010 0101 e21b 0000
> > 14:42:01.330727 tun0  Out IP6 fd3d:a0b:17d6::1.webcache >
> > fd3d:fa7b:d17d::1.50901: Flags [P.], seq 36:37, ack 1, win 1050,
> > length 1: HTTP
> >         0x0000:  6000 842c 0015 0640 fd3d 0a0b 17d6 0000
> >         0x0010:  0000 0000 0000 0001 fd3d fa7b d17d 0000
> >         0x0020:  0000 0000 0000 0001 1f90 c6d5 f7fe 05fa
> >         0x0030:  0000 0001 5018 041a e873 0000 60
> =

> Looking at the tests in tools/testing/selftests/net/packetdrill/, I
> don't see anything that sets the --send_omit_free packetdrill flag.
> That flag is needed for TCP zero copy tests, to ensure that
> packetdrill doesn't free the send() buffer after the send() call.
> =

> Because the test didn't use the --send_omit_free flag, packetdrill
> freed the buffer. And the memory probably got reused before the
> transmit. Perhaps for an IPv6 packet, whose first byte is 0x60, and
> thus what was transmitted was the garbage 0x60.
> =

> Does that sound plausible, Willem? If you agree, do you have cycles to
> cook a commit of some kind to fix this?
> =

> One option is to put the  --send_omit_free flag near the top of the
> /tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
> script.
> =

> Thanks!
> =

> neal

Thanks Neal!

I verified that that fixed the failure. And that our original Google
internal runner passes that flag on the command line, only for these
zerocopy tests.

I can send a fix.

Only, the ipv4 test appears to be failing with a different error.
Equally surprising. It times out just waiting for the SYNACK.

    ./ksft_runner.sh tcp_zerocopy_maxfrags.pkt
    TAP version 13
    1..2
    tcp_zerocopy_maxfrags.pkt:25: error handling packet: Timed out waitin=
g for packet

Which corresponds with the last line in this snippet.

    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) =3D 0

   // Each pinned zerocopy page is fully accounted to skb->truesize.
   // This test generates a worst case packet with each frag storing
   // one byte, but increasing truesize with a page (64KB on PPC).
   +0 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [2000000], 4) =3D 0

   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>

