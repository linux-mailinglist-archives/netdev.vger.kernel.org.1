Return-Path: <netdev+bounces-241642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4354AC8711E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 491004EBA93
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E042BE625;
	Tue, 25 Nov 2025 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUxYIHYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907241E25F9
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102729; cv=none; b=pSwOrvfV8CZ/l8MXVx2EgUTn+28vZ83qjUmjbs78k0dT54iQHvgtZJHTCdDaaqbE2OD74j4R/tUyo5ljQMKeH4N5y8nfCnFFkoe+kQjyYmxlD0SdVsi+rlX78jpYceux1KJT2DMMTiHKO/MssUemg0W/yXI5MfgNV8WhUmhuDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102729; c=relaxed/simple;
	bh=9p/la36FN0nkrLv6pq97dETJa4dCwhxLFxBNfPhB00g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMqmvp/xfRfpTHknvB/My6RJHIeST8jNamHUp2+tXTJIzFOrULUNW72TMb+lPc8DBBeHVLztCRQo+o1AHGNMoDSSMhv7/3ixTDlsFl4SV7qm4eJ8u4zeD86CW+CkfTCebfx0HTIwdDjQg9dckzSp2gmls5vryJSNAILELsixpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUxYIHYO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee147baf7bso4631cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764102726; x=1764707526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G1XD0VZbwscK8PXMIxNU/1qlPKOKyQosYKapJe8Hhg=;
        b=mUxYIHYOhkqDyIg7jTWkzg7HG74vEYEpwOrn4ZpCuwjJhrZczc05THB8a39+tIn28+
         Xrb3/z+/lKU70aVA6YkOCiFsbJoDeKg1252S11wtbhb/nQoLLuHYstsqVAQidoq7lVIN
         Pmq0BsUmmdFzOkrj0vVJ0wsH0WqJArUdJwBfFGX6eEIi/SZTz0WexdG2hs4dwq19IVyr
         oEXgFBpkKlMBgJ8UHeRD+8YLobpiHPwE40Ebp2JGDK3LB2hXULce3ZqixKIaWKCxSgz7
         IeQk1c2DiYAGiaP3zJQDJIoeeDG38c3/PfMJghMaY80r9FRXKgaohlIgtpv8Jprhe9Wu
         aqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102726; x=1764707526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/G1XD0VZbwscK8PXMIxNU/1qlPKOKyQosYKapJe8Hhg=;
        b=guUwClX45ZzJLL+Y8EzRWd+28xGrg3chhZLXRCStYdxhTwtF5+incyz6MGGFKVMzno
         4sAL2fN/jwzHkPP63OFSNtCmEX6FhQdtcN6XoHWxrZlr+t+T24SjrOVMnCohlvQVthVS
         jktJIuaR6zuxkmRBc9EM19+0T1pwFwLKsGCPhfwHldJz0vlHrypIppW5agOp6UwD7WOv
         kaWcHDUIVSrihT96IWSOqjcFVGUivWOXB5Ao6XUzt3Qn2EMXnm9fyoB686qA40j8+w0C
         QU2BwIZ5u2scNdC3x+lc8+aYgioJOoaW5Krrx7vJ2iR9H+gZeKsR7uPh4F/IzhkV9d4S
         mYKA==
X-Forwarded-Encrypted: i=1; AJvYcCUqTOD63p/VtXNZrt01EE8NoRXrUUH/VTWS/dnyyGn5qnhpnPQR9kONU2xoIp4/HBhYQtdADNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS59XfMfz8XoaYlvPKjKh4BPwCDfLUWm3D6CIUJ8lCxBuBGUL6
	bx+2da8OSHKduC4s/EWdrEHKMFF+ndUAc1f+h4fcSci92XlrTfpygttUHys3TIYJ/vhREABfpbq
	SSRlHdGmNGsu/ssgucXjTEogg8ew4LmhLnMu/tip5
X-Gm-Gg: ASbGncvKyXxB0cex/NnI4CoxOggOu63aSQiWyJxUE6PmGwP29ZgeRs/drZs2O+VWsgf
	845oOlrrNjSpbuw36mTMLEiN2PVppOUqhZhYiq/L5dzcRnrX3YC137C+/b5iDLtnI1PEyjKVm0C
	U6Tfa8tDBrMuJjP0p5yw1L5IVN0oF+EbahTcuCZRUulUXTT681m6oIMBB8rNhhAcCUsLfwdAk7J
	5Nei95gfCBGv9SrqOEWhSXf1xbEwwGsbayO589+6m8x+n2tt0ZiSBpAjlTOu0D0epeCQQyBcjJc
	+3XJG9oZuUnb7MIrJ5/AFYfiTOJjD8nXTMmLn3pHrAN3mnZ2gTLpiq6cKk2g
X-Google-Smtp-Source: AGHT+IEFRPS5PfoUTrizLQZ3z7I+Tg+Bs9grfKetOQRpq+t3o5zVi6bEpiK21wiXhWYa6kTE5PcdwwHXf8RsgWIWZWc=
X-Received: by 2002:a05:622a:1446:b0:4b7:94d7:8b4c with SMTP id
 d75a77b69052e-4efc6802e0amr835881cf.0.1764102726135; Tue, 25 Nov 2025
 12:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124071831.4cbbf412@kernel.org> <willemdebruijn.kernel.1fe4306a89d08@gmail.com>
 <CADVnQym7Whnbc9xf_dew-ey1fGFBY1dSf6RJ=9qLNP=u+NYOEw@mail.gmail.com> <willemdebruijn.kernel.39fa9d8834471@gmail.com>
In-Reply-To: <willemdebruijn.kernel.39fa9d8834471@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 25 Nov 2025 15:31:48 -0500
X-Gm-Features: AWmQ_bk3Nhg98tUfdLqZm6tmMDcNpxgcZZAnzJJI0LoIGYAtnJ6Slw1J2ME9Re4
Message-ID: <CADVnQykwTjoTVV_jBmUXAMKato-3MwS+j6PdyVFtTxjndcC=bQ@mail.gmail.com>
Subject: Re: [TEST] tcp_zerocopy_maxfrags.pkt fails
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Neal Cardwell wrote:
> > On Mon, Nov 24, 2025 at 11:33=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jakub Kicinski wrote:
> > > > Hi Willem!
> > > >
> > > > I migrated netdev CI to our own infra now, and the slightly faster,
> > > > Fedora-based system is failing tcp_zerocopy_maxfrags.pkt:
> > > >
> > > > # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect ou=
tbound data payload
> > > > # script packet:  1.000237 P. 36:37(1) ack 1
> > > > # actual packet:  1.000235 P. 36:37(1) ack 1 win 1050
> > > > # not ok 1 ipv4
> > > > # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect ou=
tbound data payload
> > > > # script packet:  1.000209 P. 36:37(1) ack 1
> > > > # actual packet:  1.000208 P. 36:37(1) ack 1 win 1050
> > > > # not ok 2 ipv6
> > > > # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
> > > >
> > > > https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/=
399942/13-tcp-zerocopy-maxfrags-pkt/stdout
> > > >
> > > > This happens on both debug and non-debug kernel (tho on the former
> > > > the failure is masked due to MACHINE_SLOW).
> > >
> > > That's an odd error.
> > >
> > > The test send an msg_iov of 18 1 byte fragments. And verifies that
> > > only 17 fit in one packet, followed by a single 1 byte packet. The
> > > test does not explicitly initialize payload, but trusts packetdrill
> > > to handle that. Relevant snippet below.
> > >
> > > Packetdrill complains about payload contents. That error is only
> > > generated by the below check in run_packet.c. Pretty straightforward.
> > >
> > > Packetdrill agrees that the packet is one byte long. The win argument
> > > is optional on outgoing packets, not relevant to the failure.
> > >
> > > So somehow the data in that frag got overwritten in the short window
> > > between when it was injected into the kernel and when it was observed=
?
> > > Seems so unlikely.
> > >
> > > Sorry, I'm a bit at a loss at least initially as to the cause.
> >
> > I agree this is odd. It looks like either a very concerning kernel
> > bug, or very concerning packetdrill bug. :-)
> >
> > Could someone please run the test with tcpump in the background to
> > capture the full packet contents, to verify that indeed the packet has
> > the wrong contents?
> >
> > This would help make sure that this is a kernel bug and not a
> > packetdrill bug. :-)
>
> I'm not able to reproduce this on my own machine with the latest nn.
> But could reproduce it on the netdev machine.
>
> I assume all payload is supposed to be zeroed. And indeed the packet
> seen has a non-zero single byte of payload: 0x60.
>
> Is there any chance that this happens on some kernel with
> unsubmitted patches, but not on netdev-nn/main on this machine either?
>
> ----
>
> tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect
> outbound data payload
> script packet:  1.000169 P. 36:37(1) ack 1
> actual packet:  1.000167 P. 36:37(1) ack 1 win 1050
>
> 14:42:01.330694 tun0  Out IP6 fd3d:a0b:17d6::1.webcache >
> fd3d:fa7b:d17d::1.50901: Flags [P.], seq 19:36, ack 1, win 1050,
> length 17: HTTP
>         0x0000:  6000 842c 0025 0640 fd3d 0a0b 17d6 0000
>         0x0010:  0000 0000 0000 0001 fd3d fa7b d17d 0000
>         0x0020:  0000 0000 0000 0001 1f90 c6d5 f7fe 05e9
>         0x0030:  0000 0001 5018 041a e883 0000 0000 0000
>         0x0040:  0000 0000 0000 0000 0000 0000 00
> 14:42:01.330723 tun0  In  IP6 fd3d:fa7b:d17d::1.50901 >
> fd3d:a0b:17d6::1.webcache: Flags [.], ack 36, win 257, length 0
>         0x0000:  6000 0000 0014 06ff fd3d fa7b d17d 0000
>         0x0010:  0000 0000 0000 0001 fd3d 0a0b 17d6 0000
>         0x0020:  0000 0000 0000 0001 c6d5 1f90 0000 0001
>         0x0030:  f7fe 05fa 5010 0101 e21b 0000
> 14:42:01.330727 tun0  Out IP6 fd3d:a0b:17d6::1.webcache >
> fd3d:fa7b:d17d::1.50901: Flags [P.], seq 36:37, ack 1, win 1050,
> length 1: HTTP
>         0x0000:  6000 842c 0015 0640 fd3d 0a0b 17d6 0000
>         0x0010:  0000 0000 0000 0001 fd3d fa7b d17d 0000
>         0x0020:  0000 0000 0000 0001 1f90 c6d5 f7fe 05fa
>         0x0030:  0000 0001 5018 041a e873 0000 60

Looking at the tests in tools/testing/selftests/net/packetdrill/, I
don't see anything that sets the --send_omit_free packetdrill flag.
That flag is needed for TCP zero copy tests, to ensure that
packetdrill doesn't free the send() buffer after the send() call.

Because the test didn't use the --send_omit_free flag, packetdrill
freed the buffer. And the memory probably got reused before the
transmit. Perhaps for an IPv6 packet, whose first byte is 0x60, and
thus what was transmitted was the garbage 0x60.

Does that sound plausible, Willem? If you agree, do you have cycles to
cook a commit of some kind to fix this?

One option is to put the  --send_omit_free flag near the top of the
/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
script.

Thanks!

neal

