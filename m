Return-Path: <netdev+bounces-214757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 019FAB2B28F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 22:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEDAC4E2A2B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D8F22F767;
	Mon, 18 Aug 2025 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="KIS7/VzB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59930225414
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549584; cv=none; b=iV75+/ImCkjL/Z+zdrO5V1pEejFGU72Z3hYRZ4Gf4iP0g/ypFCTzrOjoszFfAwOdTlYdbfbvznf+4I5G4f5yqu42iB0sKJGzIxs5TwwSKXqYFbMxmECJtzwmsDmtFb7Ot2DooFqtaQ5qne4U+DCL1dGRG0FjGBNkRAq4kSNtmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549584; c=relaxed/simple;
	bh=LGHYnrWJRclj06Tx3t/lzCX9xCVNb3QiOuA1nsQlHIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xa9eVH3FbQoNsEkKvcUO8uHNIh1IR+c5iTjAwoJCsPJE/Mp/aNPnd5E3bYCcdgiM2hyN3AL/OQoB3600UvdW7uH+D7RakrNXYdORtDOLHRrAPfhiP3GguxtAU5Th8Rse+OhUDwyi6ZD0luu0IkH0vb7yIw1Sm2oRoPRbqQ8zI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=KIS7/VzB; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NN6Oq88tHhGcTiHDvmzeyiln3YeVDyykl2sSsnungYQ=; t=1755549582; x=1756413582; 
	b=KIS7/VzB/R+Ggb0O10BqnYElWu1TdTGo/ue2Pz7ZIAUMuKCv2c4ZqPjzwcR3roYAsHbxcI+BYep
	XrWKCJo2KeMHrHwe0B5OrpR+TupE1JXphX7e9ahAvLYDbS8M5icw504cHCuW88YifzaVbsr7z40EC
	FCd1AZYEFAha6VILS2HUK4mEqQSPE9HiARUhOm4EiVPbdJouEL/YkGu19oEbCMysX65fHqFLaI/Lk
	eEHwGfNmUBpPaJrwX1uel6VVYY03Kqx3fnkH7vN/kQRgroo+B6wTWgP6HXkzJ+ZVRJMlfAa+ESXU/
	RRzRziNlj5vBBvZZB8K5HHaVFun6tdcQOz5w==;
Received: from mail-oa1-f46.google.com ([209.85.160.46]:55601)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uo6dn-0000UP-Qf
	for netdev@vger.kernel.org; Mon, 18 Aug 2025 13:39:41 -0700
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30ccebcc7e4so2017607fac.3
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 13:39:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZtJij+t5PynWRy9iIaRN6a8oNNdUxhj2ObU3LXHxOOsgqHY/U
	jnoPIajJTMdn62YsO5+c1AMH86BiqM4yqQ5KqKvA+YzUqIAwNF08kSsMPczgcG/kNmEt6s8ocdp
	P1Uj/iWaTu+mtoYejIXgNUJUnr+MlRAk=
X-Google-Smtp-Source: AGHT+IGYATq2ZQ3NDmSY4TavpOhxO8gfVIoE6z4NOH2BnfL2m1WoJlLiOo/5BRW6CfqY5FYQm+Z+/IKNo9HNA/Fa2ms=
X-Received: by 2002:a05:6808:1825:b0:434:2f0:2e0e with SMTP id
 5614622812f47-436cdd1c09cmr110457b6e.29.1755549579104; Mon, 18 Aug 2025
 13:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818202756.1881-1-ouster@cs.stanford.edu> <20250818202756.1881-2-ouster@cs.stanford.edu>
In-Reply-To: <20250818202756.1881-2-ouster@cs.stanford.edu>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 18 Aug 2025 13:39:03 -0700
X-Gmail-Original-Message-ID: <CAGXJAmx+m5kpvgHqRmPrZkZxjN7tZqe=ExTSij6bXi-wcrJLNg@mail.gmail.com>
X-Gm-Features: Ac12FXxq7nuLaC1oy8m0646AjMOqXLwUDWpQ06Q28t-P93a_HOAfZbgzVzQNmYw
Message-ID: <CAGXJAmx+m5kpvgHqRmPrZkZxjN7tZqe=ExTSij6bXi-wcrJLNg@mail.gmail.com>
Subject: Re: [PATCH net-next v14 01/15] net: homa: define user-visible API for Homa
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 57a1f5ca7c4fdc0e65477960e4e21f50

Please ignore this patch series; it is damaged because of garbled
Author email fields in the commits. I will submit a new patch series
that is properly formed.

Many apologies for my error.

-John-


On Mon, Aug 18, 2025 at 1:29=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> From: John Ousterhout <ouster@cs.stanford.edouster@node0.ouster-266167.ho=
ma-pg0.utah.cloudlab.usu>
>
> Note: for man pages, see the Homa Wiki at:
> https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
>
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
>
> ---
> Changes for v11:
> * Add explicit padding to struct homa_recvmsg_args to fix problems compil=
ing
>   on 32-bit machines.
>
> Changes for v9:
> * Eliminate use of _Static_assert
> * Remove declarations related to now-defunct homa_api.c
>
> Changes for v7:
> * Add HOMA_SENDMSG_NONBLOCKING flag for sendmsg
> * API changes for new mechanism for waiting for incoming messages
> * Add setsockopt SO_HOMA_SERVER (enable incoming requests)
> * Use u64 and __u64 properly
> ---
>  include/uapi/linux/homa.h | 158 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 include/uapi/linux/homa.h
>
> diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
> new file mode 100644
> index 000000000000..3a010cc13b25
> --- /dev/null
> +++ b/include/uapi/linux/homa.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+ WITH Linux-syscall-=
note */
> +
> +/* This file defines the kernel call interface for the Homa
> + * transport protocol.
> + */
> +
> +#ifndef _UAPI_LINUX_HOMA_H
> +#define _UAPI_LINUX_HOMA_H
> +
> +#include <linux/types.h>
> +#ifndef __KERNEL__
> +#include <netinet/in.h>
> +#include <sys/socket.h>
> +#endif
> +
> +/* IANA-assigned Internet Protocol number for Homa. */
> +#define IPPROTO_HOMA 146
> +
> +/**
> + * define HOMA_MAX_MESSAGE_LENGTH - Maximum bytes of payload in a Homa
> + * request or response message.
> + */
> +#define HOMA_MAX_MESSAGE_LENGTH 1000000
> +
> +/**
> + * define HOMA_BPAGE_SIZE - Number of bytes in pages used for receive
> + * buffers. Must be power of two.
> + */
> +#define HOMA_BPAGE_SIZE (1 << HOMA_BPAGE_SHIFT)
> +#define HOMA_BPAGE_SHIFT 16
> +
> +/**
> + * define HOMA_MAX_BPAGES - The largest number of bpages that will be re=
quired
> + * to store an incoming message.
> + */
> +#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1)=
 >> \
> +               HOMA_BPAGE_SHIFT)
> +
> +/**
> + * define HOMA_MIN_DEFAULT_PORT - The 16 bit port space is divided into
> + * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
> + * for well-defined server ports. The remaining ports are used for clien=
t
> + * ports; these are allocated automatically by Homa. Port 0 is reserved.
> + */
> +#define HOMA_MIN_DEFAULT_PORT 0x8000
> +
> +/**
> + * struct homa_sendmsg_args - Provides information needed by Homa's
> + * sendmsg; passed to sendmsg using the msg_control field.
> + */
> +struct homa_sendmsg_args {
> +       /**
> +        * @id: (in/out) An initial value of 0 means a new request is
> +        * being sent; nonzero means the message is a reply to the given
> +        * id. If the message is a request, then the value is modified to
> +        * hold the id of the new RPC.
> +        */
> +       __u64 id;
> +
> +       /**
> +        * @completion_cookie: (in) Used only for request messages; will =
be
> +        * returned by recvmsg when the RPC completes. Typically used to
> +        * locate app-specific info about the RPC.
> +        */
> +       __u64 completion_cookie;
> +
> +       /**
> +        * @flags: (in) OR-ed combination of bits that control the operat=
ion.
> +        * See below for values.
> +        */
> +       __u32 flags;
> +
> +       /** @reserved: Not currently used, must be 0. */
> +       __u32 reserved;
> +};
> +
> +/* Flag bits for homa_sendmsg_args.flags (see man page for documentation=
):
> + */
> +#define HOMA_SENDMSG_PRIVATE       0x01
> +#define HOMA_SENDMSG_VALID_FLAGS   0x01
> +
> +/**
> + * struct homa_recvmsg_args - Provides information needed by Homa's
> + * recvmsg; passed to recvmsg using the msg_control field.
> + */
> +struct homa_recvmsg_args {
> +       /**
> +        * @id: (in/out) Initial value is 0 to wait for any shared RPC;
> +        * nonzero means wait for that specific (private) RPC. Returns
> +        * the id of the RPC received.
> +        */
> +       __u64 id;
> +
> +       /**
> +        * @completion_cookie: (out) If the incoming message is a respons=
e,
> +        * this will return the completion cookie specified when the
> +        * request was sent. For requests this will always be zero.
> +        */
> +       __u64 completion_cookie;
> +
> +       /**
> +        * @num_bpages: (in/out) Number of valid entries in @bpage_offset=
s.
> +        * Passes in bpages from previous messages that can now be
> +        * recycled; returns bpages from the new message.
> +        */
> +       __u32 num_bpages;
> +
> +       /** @reserved: Not currently used, must be 0. */
> +       __u32 reserved;
> +
> +       /**
> +        * @bpage_offsets: (in/out) Each entry is an offset into the buff=
er
> +        * region for the socket pool. When returned from recvmsg, the
> +        * offsets indicate where fragments of the new message are stored=
. All
> +        * entries but the last refer to full buffer pages (HOMA_BPAGE_SI=
ZE
> +        * bytes) and are bpage-aligned. The last entry may refer to a bp=
age
> +        * fragment and is not necessarily aligned. The application now o=
wns
> +        * these bpages and must eventually return them to Homa, using
> +        * bpage_offsets in a future recvmsg invocation.
> +        */
> +       __u32 bpage_offsets[HOMA_MAX_BPAGES];
> +};
> +
> +/** define SO_HOMA_RCVBUF: setsockopt option for specifying buffer regio=
n. */
> +#define SO_HOMA_RCVBUF 10
> +
> +/**
> + * define SO_HOMA_SERVER: setsockopt option for specifying whether a
> + * socket will act as server.
> + */
> +#define SO_HOMA_SERVER 11
> +
> +/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVBUF. */
> +struct homa_rcvbuf_args {
> +       /** @start: Address of first byte of buffer region in user space.=
 */
> +       __u64 start;
> +
> +       /** @length: Total number of bytes available at @start. */
> +       size_t length;
> +};
> +
> +/* Meanings of the bits in Homa's flag word, which can be set using
> + * "sysctl /net/homa/flags".
> + */
> +
> +/**
> + * define HOMA_FLAG_DONT_THROTTLE - disable the output throttling mechan=
ism
> + * (always send all packets immediately).
> + */
> +#define HOMA_FLAG_DONT_THROTTLE   2
> +
> +/* I/O control calls on Homa sockets. These are mapped into the
> + * SIOCPROTOPRIVATE range of 0x89e0 through 0x89ef.
> + */
> +
> +#define HOMAIOCFREEZE _IO(0x89, 0xef)
> +
> +#endif /* _UAPI_LINUX_HOMA_H */
> --
> 2.43.0
>

