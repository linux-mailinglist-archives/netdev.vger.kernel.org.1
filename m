Return-Path: <netdev+bounces-223179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7767EB58226
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964091887CD4
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171201C3C11;
	Mon, 15 Sep 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="C1UAtHVj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AA25A2CF
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953903; cv=none; b=PeVEpQG+8tGUrHSP3x0d0c5KULKg+ZsX4p5N3isr/BhjgLKuJFFpVFwLwlrEWQpXIZiGIBycPz2Cp9kAijwGlK2/ZAi/c5VRkzqQjPv4HHK0V+oh10T82jkUlev7t0dA15D2strAO3M/yt5gXmM8t0EGk3oMnztJIacgJsz9occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953903; c=relaxed/simple;
	bh=YL2r0/deajtc33mo5VHnH0EW0hOU2juwCR4OtwxmmK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3cKoap0MYg9HZoyJqd55b8p3mKSWtYZCx0Qv2aOgIM9U3jQTnnNYWYA8/TZqsDwkcVMp/YyxO2ppaCCVquaS/2qy6G9qxx5LEuWAFKs/AZJpRWfpQgNTbyB+9oZjBFTlCxjA/2Fy+jMIAccO+4YtrMeffMqvHcSC3Y/0RklMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=C1UAtHVj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-56088927dcbso5591991e87.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1757953899; x=1758558699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Jt1+UfETZdYDXjYgLzR6vo2AiP+w48VdZv8wawn+0M=;
        b=C1UAtHVjXQ32+jBbLa36XXI7+MSF3RZQaWI9XckVGc2NP3ZJOtU920x1Q0yWbkaBin
         wExOKJYQp/FG0h8xm/wSileZHH8oOmM1ve7SABx8eXCKIiJVELFpZZ9COg1TrqRm4//X
         Vx8Bl6DM2HWhPmKBAm8ZJssXRrzp4neseiay18iADMLNdNDafFnKG132aA+14MFnDmEu
         4Fu7thvt7KZLso//O9nBLhgFHjQHMS1zYuQTR0EpTI5/nLmkap09P72A9kjsFSMLdlp7
         65o7Be1c9csBaAMhS8oHVPH9cbgeaAdn3Ahv1noQNLaG/lFFLKefNVcPLbRsFPhxQDeK
         Jfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953899; x=1758558699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Jt1+UfETZdYDXjYgLzR6vo2AiP+w48VdZv8wawn+0M=;
        b=oksN0pFAOl3ULOgTD2q1foRBOPeOg5nORu/SCyQjqKinVs+z7KH/2HG2s+hsN0N9Za
         jtDV3YKM2DixkR9ZVxB70BWjawbRimGnQgiZw1uOMT+dpghqwGv3lCscz5t4tlqSN/0Y
         0izHlpprpkQz3u+JBzxg4xdSVb3OEbozStv6Wcf2k08mvXVr58ncFisiILWxn/8T6NdX
         99iTbX+PidZj7OlyfLHkD6qsJaSKZCjosDHX7TtHUqm9pyokdE9h9VVrbm8TAna/P0MK
         eTzQ9Q/HJkLNGJNZKAgJ3gaeHy5SQsNTajJ4nCiGEiYPAW+hddCv2/QooqF35RFhNzDp
         TtRg==
X-Forwarded-Encrypted: i=1; AJvYcCVgT2rPlTDBaNwp2s6Pagxqhk9tRnPYh8PtedHlei9BQhnV5DcNudTucOHBwUP8b3ZGO7RGMMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiMd/M/9gxStji8PE/o4RUYDMZqWB+wxI1GLt3Vsz5yB61yv3m
	kH23HACiCNMkeGmIQTI54cOBbM+HKY/QTI/8HDq4nnrlnS1q8LyYZCSIAAhFu799jbS0eBI5O+y
	ubRpJ68PQRlwWeDKhHidhNI+MT8+qCI4=
X-Gm-Gg: ASbGncuI97oPNQaAUAuzEG2ecwJ2eN4hpdlmJW0chLDZJX7otrgJUvfN2/xyqMKoN2/
	J2mdorJCffw5J7IuKEvbWM37ldfGmaPkLym+PdrsR98+A6VXmXytsfKYata7SFFqRF40CKWiBz7
	apIbg+04kqKpd9tmGnNE7DzvCYGYVM8JcFrsGKCi60NSLtBlkpFaSG1e6w18pHCg9A36T1jjnvX
	dMT+UO+caB34PaKNHLl955bWhL6lu2Mb7F+TFmbB84eJl7pPK0=
X-Google-Smtp-Source: AGHT+IHtnSmph/h0KC4z9f50Q+6BzwUwJ7iaIGmhibPS8jP1Axx85iUNHkIBK0jPFftttcjbVKygL9roo+c760YHvw4=
X-Received: by 2002:a05:651c:23d2:20b0:337:f597:60e8 with SMTP id
 38308e7fff4ca-3513e8e00d8mr31239581fa.32.1757953898612; Mon, 15 Sep 2025
 09:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905024659.811386-1-alistair.francis@wdc.com> <68e45231-8344-447d-95cc-4b95a13df353@suse.de>
In-Reply-To: <68e45231-8344-447d-95cc-4b95a13df353@suse.de>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 15 Sep 2025 12:31:26 -0400
X-Gm-Features: AS18NWAUnzqMw0mf78fw1HcxM7rJw20nnCVSUeVV84heV6QHUZw_m51aGBmhNP8
Message-ID: <CAN-5tyFpuEieD8x83vFGgHy8KZBCsAsm7LiZmzpc6OpWPHVFgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Hannes Reinecke <hare@suse.de>, alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 7:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/5/25 04:46, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The TLS 1.3 specification allows the TLS client or server to send a
> > KeyUpdate. This is generally used when the sequence is about to
> > overflow or after a certain amount of bytes have been encrypted.
> >
> > The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> > can be sent by the TLS client or server at any time. This includes
> > when running NVMe-OF over a TLS 1.3 connection.
> >
> > As such Linux should be able to handle a KeyUpdate event, as the
> > other NVMe side could initiate a KeyUpdate.
> >
> > Upcoming WD NVMe-TCP hardware controllers implement TLS support
> > and send KeyUpdate requests.
> >
> > This series builds on top of the existing TLS EKEYEXPIRED work,
> > which already detects a KeyUpdate request. We can now pass that
> > information up to the NVMe layer (target and host) and then pass
> > it up to userspace.
> >
> > Userspace (ktls-utils) will need to save the connection state
> > in the keyring during the initial handshake. The kernel then
> > provides the key serial back to userspace when handling a
> > KeyUpdate. Userspace can use this to restore the connection
> > information and then update the keys, this final process
> > is similar to the initial handshake.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> >
> > v2:
> >   - Change "key-serial" to "session-id"
> >   - Fix reported build failures
> >   - Drop tls_clear_err() function
> >   - Stop keep alive timer during KeyUpdate
> >   - Drop handshake message decoding in the NVMe layer
> >
> > Alistair Francis (7):
> >    net/handshake: Store the key serial number on completion
> >    net/handshake: Make handshake_req_cancel public
> >    net/handshake: Expose handshake_sk_destruct_req publically
> >    nvmet: Expose nvmet_stop_keep_alive_timer publically
> >    net/handshake: Support KeyUpdate message types
> >    nvme-tcp: Support KeyUpdate
> >    nvmet-tcp: Support KeyUpdate
> >
> >   Documentation/netlink/specs/handshake.yaml |  19 +++-
> >   Documentation/networking/tls-handshake.rst |   4 +-
> >   drivers/nvme/host/tcp.c                    |  88 +++++++++++++++--
> >   drivers/nvme/target/core.c                 |   1 +
> >   drivers/nvme/target/tcp.c                  | 104 +++++++++++++++++++-=
-
> >   include/net/handshake.h                    |  17 +++-
> >   include/uapi/linux/handshake.h             |  14 +++
> >   net/handshake/genl.c                       |   5 +-
> >   net/handshake/handshake.h                  |   1 -
> >   net/handshake/request.c                    |  18 ++++
> >   net/handshake/tlshd.c                      |  46 +++++++--
> >   net/sunrpc/svcsock.c                       |   3 +-
> >   net/sunrpc/xprtsock.c                      |   3 +-
> >   13 files changed, 289 insertions(+), 34 deletions(-)
> >
>
> Hey Alistair,
> thanks for doing this. While the patchset itself looks okay-ish, there
> are some general ideas/concerns for it:
>
> - I have posted a patch for replacing the current 'read_sock()'
> interface with a recvmsg() base workflow. That should give us
> access to the 'real' control message, so it would be good if you
> could fold it in.
> - Olga has send a patchset fixing a security issue with control
> messages; the gist is that the network code expects a 'kvec' based
> msg buffer when receiving a control message. So essentially one
> has to receive a message _without_ a control buffer, check for
> MSG_CTRUNC, and then read the control message via kvec.
> Can you ensure that your patchset follows these guidelines?
> - There is no method to trigger a KeyUpdate, making it really hard
> to test this feature (eg by writin a blktest for it). Ideally we
> should be able to trigger it from both directions, but having just
> one (eg on the target side) should be enough for starters.
> A possible interface would be to implement write support to the
> 'tls_key' debugfs attribute; when writing the same key ID as
> the one currently in use the KeyUpdate mechanism could be started.
>
> But thanks for doing the work!

Hi Alistart,

I would like to pingy-pack on this message and ask a few questions as
I'm a bit confused about this implemenation.

NFS is also interested in being able to handle KeyUpdate functionality
of TLS and having NvME doing it serves as an example. But the general
approach confuses me.

All messages go thru a TLS (kernel) layer portion of sock_recvmsg
(kernel_recvmsg). When the TLS kernel layer detects that it's
non-TLS-data payload, it does various things depending on whether or
not control buffer was set up prior to the call to sock_recvmsg.
KeyUpdate message is a type of HANDSHAKE message and thus non-TLS-data
payload. While I was doing my changes to NvME code I noticed that
there are multiple places NvME (target) calls into kernel_recvmsg()
and thus those places would need to handle receiving non-TLS-data
payloads. Previously there was a TLS alert which is non-data but now
there is Handshake (specifically Keyupdate, but not others).

I guess where I'm going is I don't see how NvMe is connecting
receiving KeyUpdate (ie, identifying that it received specifically
that and not other handshake type) and its handling of KeyUpdate from
kernel_recvmsg the when NvME is just normally receiving data.

This patch series reads to me as it is expecting KeyUpdate to be a
part of the Handshake process (ie., there is a patch to "cancel" an
ongoing handshake, there is an upcall to tlshd with the KeyUpdate?).
This doesn't make sense to me. KeyUpdate, while a type of Handshake
message, is not done during the handshake -- it is done after sending
the Finished message which concludes the handshake flow (and
involvement of tlshd) and can happen at any time during normal TLS
encrypted message exchange after the handshake. Here's a snippet from
the TLS spec:

The KeyUpdate handshake message is used to indicate that the sender
   is updating its sending cryptographic keys.  This message can be sent
   by either peer after it has sent a Finished message.  Implementations
   that receive a KeyUpdate message prior to receiving a Finished
   message MUST terminate the connection with an "unexpected_message"
   alert.



>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>

