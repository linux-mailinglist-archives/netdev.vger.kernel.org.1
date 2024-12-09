Return-Path: <netdev+bounces-150319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E09E9DA0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DA1188081E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49725157A6B;
	Mon,  9 Dec 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ArVmHDKV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0013775E
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766906; cv=none; b=ezabRqNNKIA5a5Qtcz+dSHsBmwIEr1YL7AH5f5QPtyXWyKU494akjdENWaraUicFQF0i97o7GizQAkklt+5MhKdCk9hyWLQKgy4O/zyHDCKUCepbQST96qZK//+8PoV7dZil2qpaQY5gdDSPtpu77A2aEaTOfEW7+vwg5F2UkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766906; c=relaxed/simple;
	bh=lNkK2nBCIlciY/Z0OzSqgQSxL2MMqo3qTG2bsE+O6Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=P9qBpZe+FUanpdqieTGZcMBfD1jHbgKqkjrbC06j5KbbyayZi3K68BS6Q3iqK9QKd5evQqTQJdivby1DkPRn9de0cUrlf5eOiLGfRTNAH6CgrgjF7dkncjw3IfOcjuvSVB/qtujiwtdyCdSngu+M+PQLuySoL3NnmuTPOnHDNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ArVmHDKV; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mBqklPlrUSSdu/3hbXKpN+NvmB1QvqTvnR9xURpqGTE=; t=1733766904; x=1734630904; 
	b=ArVmHDKVmHYK0VQfx5/ebhSRyT4JLt9NLgrCmN3DT/XHP3qg3ySax9O5UyF/uYv5dMKUZhcLub+
	T/5XxVxnZaY11qBbbMcS7EdMcI1r9xndFgJHttsooT9s9DIhGGwmQeM0D3mTODnrGepY1QSaW8oqZ
	tGq99HwafakcbYzQJLgn5AJYmlaG0dzOT9nzLwZgsRLOLE0QK/qO0ZHtUOwUq+Nvi3gdIkxbind3W
	GEizGOVs/xmtWtDgTVxCGwePGVE+xOdLS6lw1qNR8pdpPeriuAA02p3FPo5dyrZ7kMO611Rn2I/OL
	epnignqAASqZa10Xj1rUQkNnawvWlJispsfA==;
Received: from mail-oa1-f49.google.com ([209.85.160.49]:52234)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tKhyI-0006UN-Rh
	for netdev@vger.kernel.org; Mon, 09 Dec 2024 09:55:03 -0800
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29e70c9dc72so2487063fac.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 09:55:02 -0800 (PST)
X-Gm-Message-State: AOJu0YxRVE5DhI5qrzBVtl+W+e8BsckTZNIzh3bu9H8Sxds7n99BMqSl
	Uu0ZcsvVgBR9Z7hnaXHx42a3v6k/1vwBTyS/F83q0xp2auUpWpfzU4KVJuwOZFv7fUtw3xOZ71f
	5ClmH4rTCjEMROilQmhSTYJ4S9JA=
X-Google-Smtp-Source: AGHT+IE8HG0/S8PSOaN6cdNbXx1jxJjj8BfP+zLHETBkuisRVyFV/h8x6+2/DV8t9Y8BjfIXGDSKUBUneldsJIbKYy4=
X-Received: by 2002:a05:6871:5c6:b0:29e:3345:74ff with SMTP id
 586e51a60fabf-29fee6200b9mr951288fac.23.1733766902229; Mon, 09 Dec 2024
 09:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175131.3839-1-ouster@cs.stanford.edu> <20241209175131.3839-3-ouster@cs.stanford.edu>
In-Reply-To: <20241209175131.3839-3-ouster@cs.stanford.edu>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 9 Dec 2024 09:54:26 -0800
X-Gmail-Original-Message-ID: <CAGXJAmz+WPtRjjfXBh94fvpLYDsckAaF0hajcx=u-29gof7ZQg@mail.gmail.com>
Message-ID: <CAGXJAmz+WPtRjjfXBh94fvpLYDsckAaF0hajcx=u-29gof7ZQg@mail.gmail.com>
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for Homa
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 08f07bc5394299a69f1fbfe2bf0cc046

This patch was sent by mistake; please ignore. Sorry about that...

On Mon, Dec 9, 2024 at 9:52=E2=80=AFAM John Ousterhout <ouster@cs.stanford.=
edu> wrote:
>
> Note: for man pages, see the Homa Wiki at:
> https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
>
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  include/uapi/linux/homa.h | 199 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>  create mode 100644 include/uapi/linux/homa.h
>
> diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
> new file mode 100644
> index 000000000000..306d272e4b63
> --- /dev/null
> +++ b/include/uapi/linux/homa.h
> @@ -0,0 +1,199 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
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
> +#ifdef __cplusplus
> +extern "C"
> +{
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
> +#define HOMA_BPAGE_SHIFT 16
> +#define HOMA_BPAGE_SIZE (1 << HOMA_BPAGE_SHIFT)
> +
> +/**
> + * define HOMA_MAX_BPAGES: The largest number of bpages that will be req=
uired
> + * to store an incoming message.
> + */
> +#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1)=
 \
> +               >> HOMA_BPAGE_SHIFT)
> +
> +/**
> + * define HOMA_MIN_DEFAULT_PORT - The 16-bit port space is divided into
> + * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
> + * for well-defined server ports. The remaining ports are used for clien=
t
> + * ports; these are allocated automatically by Homa. Port 0 is reserved.
> + */
> +#define HOMA_MIN_DEFAULT_PORT 0x8000
> +
> +/**
> + * Holds either an IPv4 or IPv6 address (smaller and easier to use than
> + * sockaddr_storage).
> + */
> +union sockaddr_in_union {
> +       struct sockaddr sa;
> +       struct sockaddr_in in4;
> +       struct sockaddr_in6 in6;
> +};
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
> +       uint64_t id;
> +
> +       /**
> +        * @completion_cookie: (in) Used only for request messages; will =
be
> +        * returned by recvmsg when the RPC completes. Typically used to
> +        * locate app-specific info about the RPC.
> +        */
> +       uint64_t completion_cookie;
> +};
> +
> +#if !defined(__cplusplus)
> +_Static_assert(sizeof(struct homa_sendmsg_args) >=3D 16,
> +              "homa_sendmsg_args shrunk");
> +_Static_assert(sizeof(struct homa_sendmsg_args) <=3D 16,
> +              "homa_sendmsg_args grew");
> +#endif
> +
> +/**
> + * struct homa_recvmsg_args - Provides information needed by Homa's
> + * recvmsg; passed to recvmsg using the msg_control field.
> + */
> +struct homa_recvmsg_args {
> +       /**
> +        * @id: (in/out) Initially specifies the id of the desired RPC, o=
r 0
> +        * if any RPC is OK; returns the actual id received.
> +        */
> +       uint64_t id;
> +
> +       /**
> +        * @completion_cookie: (out) If the incoming message is a respons=
e,
> +        * this will return the completion cookie specified when the
> +        * request was sent. For requests this will always be zero.
> +        */
> +       uint64_t completion_cookie;
> +
> +       /**
> +        * @flags: (in) OR-ed combination of bits that control the operat=
ion.
> +        * See below for values.
> +        */
> +       int flags;
> +
> +       /**
> +        * @error_addr: the address of the peer is stored here when avail=
able.
> +        * This field is different from the msg_name field in struct msgh=
dr
> +        * in that the msg_name field isn't set after errors. This field =
will
> +        * always be set when peer information is available, which includ=
es
> +        * some error cases.
> +        */
> +       union sockaddr_in_union peer_addr;
> +
> +       /**
> +        * @num_bpages: (in/out) Number of valid entries in @bpage_offset=
s.
> +        * Passes in bpages from previous messages that can now be
> +        * recycled; returns bpages from the new message.
> +        */
> +       uint32_t num_bpages;
> +
> +       uint32_t _pad[1];
> +
> +       /**
> +        * @bpage_offsets: (in/out) Each entry is an offset into the buff=
er
> +        * region for the socket pool. When returned from recvmsg, the
> +        * offsets indicate where fragments of the new message are stored=
. All
> +        * entries but the last refer to full buffer pages (HOMA_BPAGE_SI=
ZE bytes)
> +        * and are bpage-aligned. The last entry may refer to a bpage fra=
gment and
> +        * is not necessarily aligned. The application now owns these bpa=
ges and
> +        * must eventually return them to Homa, using bpage_offsets in a =
future
> +        * recvmsg invocation.
> +        */
> +       uint32_t bpage_offsets[HOMA_MAX_BPAGES];
> +};
> +
> +#if !defined(__cplusplus)
> +_Static_assert(sizeof(struct homa_recvmsg_args) >=3D 120,
> +              "homa_recvmsg_args shrunk");
> +_Static_assert(sizeof(struct homa_recvmsg_args) <=3D 120,
> +              "homa_recvmsg_args grew");
> +#endif
> +
> +/* Flag bits for homa_recvmsg_args.flags (see man page for documentation=
):
> + */
> +#define HOMA_RECVMSG_REQUEST       0x01
> +#define HOMA_RECVMSG_RESPONSE      0x02
> +#define HOMA_RECVMSG_NONBLOCKING   0x04
> +#define HOMA_RECVMSG_VALID_FLAGS   0x07
> +
> +/** define SO_HOMA_SET_BUF: setsockopt option for specifying buffer regi=
on. */
> +#define SO_HOMA_SET_BUF 10
> +
> +/** struct homa_set_buf - setsockopt argument for SO_HOMA_SET_BUF. */
> +struct homa_set_buf_args {
> +       /** @start: First byte of buffer region. */
> +       void *start;
> +
> +       /** @length: Total number of bytes available at @start. */
> +       size_t length;
> +};
> +
> +/**
> + * Meanings of the bits in Homa's flag word, which can be set using
> + * "sysctl /net/homa/flags".
> + */
> +
> +/**
> + * Disable the output throttling mechanism: always send all packets
> + * immediately.
> + */
> +#define HOMA_FLAG_DONT_THROTTLE   2
> +
> +int     homa_send(int sockfd, const void *message_buf,
> +                 size_t length, const union sockaddr_in_union *dest_addr=
,
> +                 uint64_t *id, uint64_t completion_cookie);
> +int     homa_sendv(int sockfd, const struct iovec *iov,
> +                  int iovcnt, const union sockaddr_in_union *dest_addr,
> +                  uint64_t *id, uint64_t completion_cookie);
> +ssize_t homa_reply(int sockfd, const void *message_buf,
> +                  size_t length, const union sockaddr_in_union *dest_add=
r,
> +                  uint64_t id);
> +ssize_t homa_replyv(int sockfd, const struct iovec *iov,
> +                   int iovcnt, const union sockaddr_in_union *dest_addr,
> +                   uint64_t id);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _UAPI_LINUX_HOMA_H */
> --
> 2.34.1
>

