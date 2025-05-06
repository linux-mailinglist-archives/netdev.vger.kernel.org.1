Return-Path: <netdev+bounces-188416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6FAAACC73
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348C91C052A3
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83C21CC62;
	Tue,  6 May 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="a/exqWQ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DC20B806
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553589; cv=none; b=ndKvnCp2LQ171gZlUAKctcpkKv0aB4Mj1pF0t6J8nch7nlQXZzFD5zaLqGra33BK3SZ+sVi/ggVGMuqj5s/jl7uyuxerDDfwym3XJW+GAqnMU3/8vogUlLxNK/NojBsdw92R8PvP7rTNm1Paho57QDbid3EENtZWLzqQeutWh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553589; c=relaxed/simple;
	bh=JphBOVmCqX0wYmM3FvIOi8NKH7hyfPQQFD7PpU6fERc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJQv//tiVlbEwOSxVnldKiSGJvyGu1DpbIxRxITjIBq/diREQjF82OzoOKG2Z27fNteixY7FkMYw5EatstkOgmzyeLaZrrhpTsA6ltHwVBBGvkbd2W1Ag9uA0RM4aCV3yox2iZWo1b4AozwrZrzy8OsjRqqhMv5VK44dpqTRYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=a/exqWQ4; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fUu5inMFOYZcgUIaWPTQvlVDgdfo/XkmY9anrk5A1QQ=; t=1746553587; x=1747417587; 
	b=a/exqWQ4Nz7trc7PDi3pXd7Jaa3MnxLdQFierB0s9FYIjKC6yijDXfBhBebN2OJcdwWkHeNTXpQ
	KlPXYwDejf9QWNX9vx4yHK0S7jMef7PhShcO3I8bwndzFStHLILGFlu23xmEAr2yJBuqF1KvPRaTm
	3h8KQpFrFA+B09GfqG0orQ7IKk8ZB2wz1NUbVuvwhDytJ5Fg1xa1SFIWJ9uFMxY6q+fT9NLZQrdja
	9Pd+sSXwsJTDZv9vEsxutWc206LloKVtHLOAKFiA+I+h8jXvRuoeqjpTvLCCoRSd/3chAcTron4Zk
	HDnmvJIpQE+loLc8XZxQHEze3IGbYXN67jRw==;
Received: from mail-oo1-f41.google.com ([209.85.161.41]:42216)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uCMN2-0004wa-2g
	for netdev@vger.kernel.org; Tue, 06 May 2025 10:46:21 -0700
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-606668f8d51so82890eaf.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 10:46:20 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywfx28A0pstK8FYyX5cSl4LfPUm75ATyDQ4Y3bULDaawcKlxrIL
	nAj32uhR1kyT9s5NrirUfsEaqobYI2KeF74MhL/ep0oSV5ST6wOlSll8N56c+06lFC9DMD7URxM
	G7BECH9FLv01nZ0CENIWhONpJV/s=
X-Google-Smtp-Source: AGHT+IETJyzEY14boBRlid8F6DMIjDVwL6/eEPEd93ZqEAvx7MwagUWtzGPXgOixkCv34Ygm/s+TfnFkGLaq7an38IY=
X-Received: by 2002:a4a:ca18:0:b0:607:de46:fa94 with SMTP id
 006d021491bc7-60828322836mr468393eaf.4.1746553579484; Tue, 06 May 2025
 10:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-4-ouster@cs.stanford.edu> <521265b1-1a32-4d5e-9348-77559a5a0af4@redhat.com>
In-Reply-To: <521265b1-1a32-4d5e-9348-77559a5a0af4@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 6 May 2025 10:45:43 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyd-dgHh7bmA4g_ZAG=VTBHiNOJ2SCVOjmzF6w9AQLnng@mail.gmail.com>
X-Gm-Features: ATxdqUGcReLpOZdMvfkJPRNx-P4OngSQAoCEFj9fFNz4szJ_WVMrtPKvygSMpb4
Message-ID: <CAGXJAmyd-dgHh7bmA4g_ZAG=VTBHiNOJ2SCVOjmzF6w9AQLnng@mail.gmail.com>
Subject: Re: [PATCH net-next v8 03/15] net: homa: create shared Homa header files
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 00ae0dc23c387355c0c9f5c46aa55045

On Mon, May 5, 2025 at 3:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:

> > +
> > +#define sizeof32(type) ((int)(sizeof(type)))
>
> (u32) instead of (int). I think you should try to avoid using this
> define, which is not very nice by itself.

I have removed that #define and switched to sizeof everywhere.

> > +#ifdef __CHECKER__
> > +#define __context__(x, y, z) __attribute__((context(x, y, z)))
> > +#else
> > +#define __context__(...)
> > +#endif /* __CHECKER__ */
>
> Why do you need to fiddle with the sparse annotation? Very likely this
> should be dropped.

Without this I couldn't get the code to compile. Homa declares
"__context__" for some spinlocks to handle cases where a lock is
acquired for the return value of a function (so '__acquires' can't
name the lock otherwise). For an example, search for 'rpc_bucket_lock'
in homa_sock.h. I'm still pretty much a newbie with sparse, so maybe
there's a better way to do this? In general I'm having a difficult
time getting useful information out of sparse...

> > +/**
> > + * homa_get_skb_info() - Return the address of Homa's private informat=
ion
> > + * for an sk_buff.
> > + * @skb:     Socket buffer whose info is needed.
> > + * Return: address of Homa's private information for @skb.
> > + */
> > +static inline struct homa_skb_info *homa_get_skb_info(struct sk_buff *=
skb)
> > +{
> > +     return (struct homa_skb_info *)(skb_end_pointer(skb)) - 1;
>
> This looks fragile. Why can't you use the skb control buffer here?

I was not aware of the skb control buffer.  After poking around and
asking ChatGPT, it  appears that information in the control buffer is
not guaranteed to survive across networking layers? Homa depends on
the information being persistent.  For example, it's used to link
together all of the skb's in a Homa message, which will be used if
parts of a message need to be retransmitted. Why does this look
fragile to you? It's pretty much equivalent to skb_shinfo, except with
Homa information.

> > +static inline bool is_homa_pkt(struct sk_buff *skb)
> > +{
> > +     struct iphdr *iph =3D ip_hdr(skb);
> > +
> > +     return (iph->protocol =3D=3D IPPROTO_HOMA);
>
> What if this is an ipv6 packet? Also I don't see any use of this
> function later on.

This function isn't used anymore, so I have deleted it. It's probably
leftover from before the addition of IPv6 support.

> > +#define UNIT_LOG(...)
> > +#define UNIT_HOOK(...)
>
> It looks like the above 2 define are unused later on.

Oops, that code was supposed to get stripped out of the upstream
version of Homa. I've now fixed the stripper to keep this code out fo
the upstream version of Homa.

> > +extern unsigned int homa_net_id;
> > +
> > +void     homa_abort_rpcs(struct homa *homa, const struct in6_addr *add=
r,
> > +                      int port, int error);
> > +void     homa_abort_sock_rpcs(struct homa_sock *hsk, int error);
> > +void     homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> > +                   struct homa_rpc *rpc);
> > +void     homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb);
> > +int      homa_backlog_rcv(struct sock *sk, struct sk_buff *skb);
> > +int      homa_bind(struct socket *sk, struct sockaddr *addr,
> > +                int addr_len);
> > +void     homa_close(struct sock *sock, long timeout);
> > +int      homa_copy_to_user(struct homa_rpc *rpc);
> > +void     homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
> > +void     homa_destroy(struct homa *homa);
> > +int      homa_disconnect(struct sock *sk, int flags);
> > +void     homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa);
> > +int      homa_err_handler_v4(struct sk_buff *skb, u32 info);
> > +int      homa_err_handler_v6(struct sk_buff *skb,
> > +                          struct inet6_skb_parm *opt, u8 type,  u8 cod=
e,
> > +                          int offset, __be32 info);
> > +int      homa_fill_data_interleaved(struct homa_rpc *rpc,
> > +                                 struct sk_buff *skb, struct iov_iter =
*iter);
> > +struct homa_gap *homa_gap_new(struct list_head *next, int start, int e=
nd);
> > +void     homa_gap_retry(struct homa_rpc *rpc);
> > +int      homa_get_port(struct sock *sk, unsigned short snum);
> > +int      homa_getsockopt(struct sock *sk, int level, int optname,
> > +                      char __user *optval, int __user *optlen);
> > +int      homa_hash(struct sock *sk);
> > +enum hrtimer_restart homa_hrtimer(struct hrtimer *timer);
> > +int      homa_init(struct homa *homa, struct net *net);
> > +int      homa_ioctl(struct sock *sk, int cmd, int *karg);
> > +int      homa_load(void);
> > +int      homa_message_out_fill(struct homa_rpc *rpc,
> > +                            struct iov_iter *iter, int xmit);
> > +void     homa_message_out_init(struct homa_rpc *rpc, int length);
> > +void     homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> > +                        struct homa_rpc *rpc);
> > +struct sk_buff *homa_new_data_packet(struct homa_rpc *rpc,
> > +                                  struct iov_iter *iter, int offset,
> > +                                  int length, int max_seg_data);
> > +int      homa_net_init(struct net *net);
> > +void     homa_net_exit(struct net *net);
> > +__poll_t homa_poll(struct file *file, struct socket *sock,
> > +                struct poll_table_struct *wait);
> > +int      homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > +                   int flags, int *addr_len);
> > +void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
> > +                      struct homa_sock *hsk);
> > +void     homa_rpc_abort(struct homa_rpc *crpc, int error);
> > +void     homa_rpc_acked(struct homa_sock *hsk,
> > +                     const struct in6_addr *saddr, struct homa_ack *ac=
k);
> > +void     homa_rpc_end(struct homa_rpc *rpc);
> > +void     homa_rpc_handoff(struct homa_rpc *rpc);
> > +int      homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)=
;
> > +int      homa_setsockopt(struct sock *sk, int level, int optname,
> > +                      sockptr_t optval, unsigned int optlen);
> > +int      homa_shutdown(struct socket *sock, int how);
> > +int      homa_softirq(struct sk_buff *skb);
> > +void     homa_spin(int ns);
> > +void     homa_timer(struct homa *homa);
> > +int      homa_timer_main(void *transport);
> > +void     homa_unhash(struct sock *sk);
> > +void     homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rp=
c);
> > +void     homa_unload(void);
> > +int      homa_wait_private(struct homa_rpc *rpc, int nonblocking);
> > +struct homa_rpc
> > +     *homa_wait_shared(struct homa_sock *hsk, int nonblocking);
> > +int      homa_xmit_control(enum homa_packet_type type, void *contents,
> > +                        size_t length, struct homa_rpc *rpc);
> > +int      __homa_xmit_control(void *contents, size_t length,
> > +                          struct homa_peer *peer, struct homa_sock *hs=
k);
> > +void     homa_xmit_data(struct homa_rpc *rpc, bool force);
> > +void     homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk)=
;
> > +
> > +int      homa_message_in_init(struct homa_rpc *rpc, int unsched);
> > +void     homa_resend_data(struct homa_rpc *rpc, int start, int end);
> > +void     __homa_xmit_data(struct sk_buff *skb, struct homa_rpc *rpc);
>
> You should introduce the declaration of a given function in the same
> patch introducing the implementation. That means the patches should be
> sorted from the lowest level helper towards the upper layer.

The patches are already sorted from lower layers to upper layers, and
after your last round of comments I tested and reorganized so that the
code compiles cumulatively after the addition of each new patch in the
series (with one exception where there are mutual dependencies between
files in successive patches). homa_impl.h is a grab-bag for things
that don't fit logically elsewhere, so it has declarations for things
in several patches. I will try to distribute the function declarations
over the patches that contain the implementations.

> [...]
> > +static inline int homa_skb_append_to_frag(struct homa *homa,
> > +                                       struct sk_buff *skb, void *buf,
> > +                                       int length)
> > +{
> > +     char *dst =3D skb_put(skb, length);
> > +
> > +     memcpy(dst, buf, length);
> > +     return 0;
>
> The name is misleading as it does not append to an skb frag but to the
> skb linear part

This file (homa_stub.h) is a temporary file during the upstreaming
process (see the comment at the beginning) in order to reduce the size
of the initial patch series. In a later patch series the
implementation will be replaced with a full-blown implementation of
skb management that actually uses skb frags; this version just puts
the entire skb in the linear part. So, the name reflects what will
eventually happen (which is implemented in the GitHub repo). I'd
prefer not to have to rewind the API back to what it was before "good"
skb management was introduced into Homa. Would you rather I just pull
the full skb management code into this first patch series?

> > +static inline void homa_skb_free_many_tx(struct homa *homa,
> > +                                      struct sk_buff **skbs, int count=
)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < count; i++)
> > +             kfree_skb(skbs[i]);
>
> 'homa' is unused here.

Same issue as the previous comment: it will be used in the "full"
version of skb management.

> > +static inline struct sk_buff *homa_skb_new_tx(int length)
>
> please use 'alloc' for allocator.

Done.

-John-


-John-

