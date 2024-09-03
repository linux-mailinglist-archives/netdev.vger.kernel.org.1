Return-Path: <netdev+bounces-124717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B66C96A89C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052AC281240
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6C81DB523;
	Tue,  3 Sep 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpGiIJRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB21DB52E
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396062; cv=none; b=ozv0eHWyNzmGegIH0geRnPNp5I0nZxtfNnBaUTCUn6PukS4d8DJJTlBmxV3KiAfRaM0jCcxdJShkucSEFt/uoVvSIBvgVm6cVosERsxMB9OcuA0AWODquRGYS1W2b9L/xQP1ejMohCcyM14x3ODwZ4DBf2z02BUjftb3TBC6rP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396062; c=relaxed/simple;
	bh=oe9RhylqEe17x+ryzbr5rkohLk17zAvyq+SDyAh3Z7c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EYkzweCLh810dC5XMlqckPxCeHU1Mj2ABnm6jLNB/B0FCYGf2NVpuobVar6VgJlHv0vdqq1VNQg5Tj0u+JFEeEM2zJvj0+TpOt0KwfnGVR304v6h/YPhKpSH4Y0Mh8hMmwHreGRGjwoPPCG8Ak8O9PDGGJF/LXoaq8dYt+RFq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpGiIJRB; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a812b64d1cso306117485a.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 13:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725396059; x=1726000859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX0g76QAkBZ2YdKMTi0d5iJw/615ZMAZsqLM/Xn00Qs=;
        b=WpGiIJRB8yV/Ajq6cC+FzB/kSgrK4zOoUkarWS7nPZy0LXaq5lMxyCw/Pg1myESqYD
         8MCBYqeKIkrih2SmT62gR2P9YqtKhgZiN2bw/6kZhNsdGp1iV8JzBwCId07APBA+GCaK
         YjS6JMebSJwr59vXBI/ci4wjqRsCba1DYujsba4AKRjPiozmgjWTeTRwhvK5es1ezSww
         bFz6nQK5Rc7YmJ8KrkKV6S1e7BxVfVfo6NqikMnBp87ejg5GxoQftz5UFS3161Qo9RjY
         xzakIxUlwwcQZ5CZ0cwQFj8VTcLt9Xq+v2vppl9/m7+dqkqRJbm8Z7M4rNfJQxcan5FX
         40wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725396059; x=1726000859;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MX0g76QAkBZ2YdKMTi0d5iJw/615ZMAZsqLM/Xn00Qs=;
        b=OqjHcf7I6BPm5K99X7qPoWWpwvkYL5C77Jfz782MOGTB0e4yewsfSQss+DF4SqQ2OY
         6IEsGtVPgBqMSUKgbp7iO+VtY3KzlEJx5xyAzDQ4au/awZo19GMO8h0QdC5eQxu551HE
         A54EKC/W6tsj6zz21K932ix1CE+jUwjTFn15OcJ+W66u4ibzRHyJ0Ut4bwWBCDPnJ4Na
         xmWEd0ll0Cx9eIF4RKWuw6H/RCAbq+OP7JxXulikHjPIlE5ddFsWQ+Q9FuB2g80JeOGD
         2Zrge7R7nynZzjaI/PQ+KVqQ1U25jlNOZcd6pWOUQzIamas7Nu+H/GEtc9eTnaMqR1Bn
         wX3w==
X-Gm-Message-State: AOJu0YxVMuypUlJFAQsiRpK/sdJgfoegd0OvnmVHF/NpwP5UFaVKpaFu
	GSh1ziWip6OUNM15PDuRN0/sGsCTtGezOy+/NGL7Z7L16Yl9M4wv
X-Google-Smtp-Source: AGHT+IEgC6JkYGOXoy1qnvDuc8cjn6Y3MH5aft1QS9b/4s/6vyyMpMHGxzy7PIm/A106R7AVEhJbNg==
X-Received: by 2002:a05:620a:3707:b0:7a2:d73:ae7d with SMTP id af79cd13be357-7a804291964mr2158973285a.59.1725396058898;
        Tue, 03 Sep 2024 13:40:58 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d61b5asm563631985a.110.2024.09.03.13.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 13:40:57 -0700 (PDT)
Date: Tue, 03 Sep 2024 16:40:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <66d77459a0df1_ce32f2947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <932f7ff3-6087-47cf-91ec-2601da38ebec@linux.dev>
References: <20240902130937.457115-1-vadfed@meta.com>
 <66d5cbbba9669_6138829497@willemb.c.googlers.com.notmuch>
 <932f7ff3-6087-47cf-91ec-2601da38ebec@linux.dev>
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> On 02/09/2024 15:29, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> >> timestamps and packets sent via socket. Unfortunately, there is no way
> >> to reliably predict socket timestamp ID value in case of error returned
> >> by sendmsg. For UDP sockets it's impossible because of lockless
> >> nature of UDP transmit, several threads may send packets in parallel. In
> >> case of RAW sockets MSG_MORE option makes things complicated. More
> >> details are in the conversation [1].
> >> This patch adds new control message type to give user-space
> >> software an opportunity to control the mapping between packets and
> >> values by providing ID with each sendmsg. This works fine for UDP
> >> sockets only, and explicit check is added to control message parser.
> >>
> >> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> >>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >> ---
> >>   Documentation/networking/timestamping.rst | 14 ++++++++++++++
> >>   arch/alpha/include/uapi/asm/socket.h      |  4 +++-
> >>   arch/mips/include/uapi/asm/socket.h       |  2 ++
> >>   arch/parisc/include/uapi/asm/socket.h     |  2 ++
> >>   arch/sparc/include/uapi/asm/socket.h      |  2 ++
> >>   include/net/inet_sock.h                   |  4 +++-
> >>   include/net/sock.h                        |  1 +
> >>   include/uapi/asm-generic/socket.h         |  2 ++
> >>   include/uapi/linux/net_tstamp.h           |  3 ++-
> >>   net/core/sock.c                           | 12 ++++++++++++
> >>   net/ethtool/common.c                      |  1 +
> >>   net/ipv4/ip_output.c                      | 16 ++++++++++++----
> >>   net/ipv6/ip6_output.c                     | 16 ++++++++++++----
> >>   13 files changed, 68 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> >> index 5e93cd71f99f..93b0901e4e8e 100644
> >> --- a/Documentation/networking/timestamping.rst
> >> +++ b/Documentation/networking/timestamping.rst
> >> @@ -193,6 +193,20 @@ SOF_TIMESTAMPING_OPT_ID:
> >>     among all possibly concurrently outstanding timestamp requests for
> >>     that socket.
> >>   
> >> +  With this option enabled user-space application can provide custom
> >> +  ID for each message sent via UDP socket with control message with
> >> +  type set to SCM_TS_OPT_ID::
> >> +
> >> +    struct msghdr *msg;
> >> +    ...
> >> +    cmsg			 = CMSG_FIRSTHDR(msg);
> >> +    cmsg->cmsg_level		 = SOL_SOCKET;
> >> +    cmsg->cmsg_type		 = SO_TIMESTAMPING;
> >> +    cmsg->cmsg_len		 = CMSG_LEN(sizeof(__u32));
> >> +    *((__u32 *) CMSG_DATA(cmsg)) = opt_id;
> >> +    err = sendmsg(fd, msg, 0);
> >> +
> > 
> > Please make it clear that this CMSG is optional.
> > 
> > The process can optionally override the default generated ID, by
> > passing a specific ID with control message SCM_TS_OPT_ID:
> 
> Ok, I'll re-phrase it this way, thanks!
> 
> 
> >>   SOF_TIMESTAMPING_OPT_ID_TCP:
> >>     Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new TCP
> >>     timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how the
> >> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> >> index e94f621903fe..0698e6662cdf 100644
> >> --- a/arch/alpha/include/uapi/asm/socket.h
> >> +++ b/arch/alpha/include/uapi/asm/socket.h
> >> @@ -10,7 +10,7 @@
> >>    * Note: we only bother about making the SOL_SOCKET options
> >>    * same as OSF/1, as that's all that "normal" programs are
> >>    * likely to set.  We don't necessarily want to be binary
> >> - * compatible with _everything_.
> >> + * compatible with _everything_.
> > 
> > Is this due to a checkpatch warning? If so, please add a brief comment
> > to the commit message to show that this change is intentional. If not,
> > please don't touch unrelated code.
> 
> I'll remove it, because it looks like it was some unhappy linter...
> 
> >>    */
> >>   #define SOL_SOCKET	0xffff
> >>   
> >> @@ -140,6 +140,8 @@
> >>   #define SO_PASSPIDFD		76
> >>   #define SO_PEERPIDFD		77
> >>   
> >> +#define SCM_TS_OPT_ID		78
> >> +
> >>   #if !defined(__KERNEL__)
> >>   
> >>   #if __BITS_PER_LONG == 64
> >> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> >> index 60ebaed28a4c..bb3dc8feb205 100644
> >> --- a/arch/mips/include/uapi/asm/socket.h
> >> +++ b/arch/mips/include/uapi/asm/socket.h
> >> @@ -151,6 +151,8 @@
> >>   #define SO_PASSPIDFD		76
> >>   #define SO_PEERPIDFD		77
> >>   
> >> +#define SCM_TS_OPT_ID		78
> >> +
> >>   #if !defined(__KERNEL__)
> >>   
> >>   #if __BITS_PER_LONG == 64
> >> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> >> index be264c2b1a11..c3ab3b3289eb 100644
> >> --- a/arch/parisc/include/uapi/asm/socket.h
> >> +++ b/arch/parisc/include/uapi/asm/socket.h
> >> @@ -132,6 +132,8 @@
> >>   #define SO_PASSPIDFD		0x404A
> >>   #define SO_PEERPIDFD		0x404B
> >>   
> >> +#define SCM_TS_OPT_ID		0x404C
> >> +
> >>   #if !defined(__KERNEL__)
> >>   
> >>   #if __BITS_PER_LONG == 64
> >> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> >> index 682da3714686..9b40f0a57fbc 100644
> >> --- a/arch/sparc/include/uapi/asm/socket.h
> >> +++ b/arch/sparc/include/uapi/asm/socket.h
> >> @@ -133,6 +133,8 @@
> >>   #define SO_PASSPIDFD             0x0055
> >>   #define SO_PEERPIDFD             0x0056
> >>   
> >> +#define SCM_TS_OPT_ID            0x0057
> >> +
> >>   #if !defined(__KERNEL__)
> >>   
> >>   
> >> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> >> index 394c3b66065e..2161d50cf0fd 100644
> >> --- a/include/net/inet_sock.h
> >> +++ b/include/net/inet_sock.h
> >> @@ -174,6 +174,7 @@ struct inet_cork {
> >>   	__s16			tos;
> >>   	char			priority;
> >>   	__u16			gso_size;
> >> +	u32			ts_opt_id;
> >>   	u64			transmit_time;
> >>   	u32			mark;
> >>   };
> >> @@ -241,7 +242,8 @@ struct inet_sock {
> >>   	struct inet_cork_full	cork;
> >>   };
> >>   
> >> -#define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
> >> +#define IPCORK_OPT		1	/* ip-options has been held in ipcork.opt */
> >> +#define IPCORK_TS_OPT_ID	2	/* timestmap opt id has been provided in cmsg */
> > 
> > typo: timestamp
> > 
> > And maybe more relevant:  /* ts_opt_id field is valid, overriding sk_tskey */
> 
> I'll change it
> 
> >>   enum {
> >>   	INET_FLAGS_PKTINFO	= 0,
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index f51d61fab059..73e21dad5660 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
> >>   	u64 transmit_time;
> >>   	u32 mark;
> >>   	u32 tsflags;
> >> +	u32 ts_opt_id;
> >>   };
> >>   
> >>   static inline void sockcm_init(struct sockcm_cookie *sockc,
> >> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> >> index 8ce8a39a1e5f..db3df3e74b01 100644
> >> --- a/include/uapi/asm-generic/socket.h
> >> +++ b/include/uapi/asm-generic/socket.h
> >> @@ -135,6 +135,8 @@
> >>   #define SO_PASSPIDFD		76
> >>   #define SO_PEERPIDFD		77
> >>   
> >> +#define SCM_TS_OPT_ID		78
> > 
> > nit: different indentation
> 
> Hmm... that's interesting, it's ok in the code, there no spaces before
> #define. I'll re-check it in the patch in v3.
> 
> >> +
> >>   #if !defined(__KERNEL__)
> >>   
> >>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> >> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> >> index a2c66b3d7f0f..e2f145e3f3a1 100644
> >> --- a/include/uapi/linux/net_tstamp.h
> >> +++ b/include/uapi/linux/net_tstamp.h
> >> @@ -32,8 +32,9 @@ enum {
> >>   	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
> >>   	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
> >>   	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
> >> +	SOF_TIMESTAMPING_OPT_ID_CMSG = (1 << 17),
> >>   
> >> -	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
> >> +	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_CMSG,
> >>   	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
> >>   				 SOF_TIMESTAMPING_LAST
> >>   };
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index 468b1239606c..560b075765fa 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >> @@ -2859,6 +2859,18 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
> >>   			return -EINVAL;
> >>   		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
> >>   		break;
> >> +	case SCM_TS_OPT_ID:
> >> +		/* allow this option for UDP sockets only */
> >> +		if (!sk_is_udp(sk))
> >> +			return -EINVAL;
> > 
> > Let's relax the restriction that this is only for UDP.
> > 
> > At least to also support SOCK_RAW. I don't think that requires any
> > additional code at all?
> 
> RAW sockets use skb_setup_tx_timestamps which does atomic operation of
> incrementing sk_tskey when in _sock_tx_timestamp. So I'll have to
> convert all spots (can, ipv4/raw, ipv6/raw, 3 x af_packet) to use the
> same logic as in udp path (sock_tx_timestamp) and add conditions.
> Or change skb_setup_tx_timestamps to do the logic and take different
> arguments. It may look as a big refactoring, so I would like to make
> it as a follow-up series.

You're referring to passing the whole sockcm_cookie through these
functions, right?

Agreed that that is a lot of churn and best left for a separate patch.
Would still be good to have it merged together in a single series, but
not a hard requirement.

Other than that it seems a small change in _sock_tx_timestamp.

@@ -2668,8 +2668,12 @@ static inline void _sock_tx_timestamp(struct sock *sk, __u16 tsflags,
        if (unlikely(tsflags)) {
-               __sock_tx_timestamp(tsflags, tx_flags);
+               __sock_tx_timestamp(sockc->tsflags, tx_flags);
                if (tsflags & SOF_TIMESTAMPING_OPT_ID && tskey &&
-                   tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
-                       *tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+                   tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
+                       if (tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
+                               *tskey = sockc->ts_opt_id;
+                       else
+                               *tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+               }

> > Extending to TCP should be straightforward too, just a branch
> > on sockc in tcp_tx_timestamp.
> 
> TCP part looks a bit easier, as you said, I have to adjust
> tcp_tx_timestamp and the logic is straightforward. I still have to
> provide a pointer to sock coockie instead of flags, but there is only
> one caller of this function and it's much easier than with RAW sockets.

Yeah, the two are intermingled. If you want to pass sockc to
_sock_tx_timestamp then all callers have to pass it. And TCP
currently does not.

> > If so, let's support all. It makes for a simpler API if it is
> > supported uniformly wherever OPT_ID is.
> 
> If you think that the way I explained for RAW sockets is good enough,
> I can send all of them as a single patcheset. Otherwise I would like to
> add RAW sockets in follow-up series.
> 
> >> +		tsflags = READ_ONCE(sk->sk_tsflags);
> >> +		if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
> >> +			return -EINVAL;
> >> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
> >> +			return -EINVAL;
> >> +		sockc->ts_opt_id = *(u32 *)CMSG_DATA(cmsg);
> >> +		sockc->tsflags |= SOF_TIMESTAMPING_OPT_ID_CMSG;
> >> +		break;
> >>   	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
> >>   	case SCM_RIGHTS:
> >>   	case SCM_CREDENTIALS:
> 



