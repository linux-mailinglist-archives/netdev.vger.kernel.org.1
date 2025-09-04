Return-Path: <netdev+bounces-219979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E635FB43FCF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D231C82D91
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE992F6587;
	Thu,  4 Sep 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E0Jfvwby"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B346302CC2;
	Thu,  4 Sep 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998018; cv=none; b=SVYPQ0p4eMmi26kCiQcYbAMfQFeMOIvoT3De1E77qUJDScyennvmfT+3tZZLKoPaSwd8DfNgLZGcpKlCeIrox15yJl5erV7RE4j+GzumeoC3kT2nunLaDe8i4tfsKsI6gVwBNcoPEM/jV/4W4cn1hy04g0+IH49akvuEnch3wWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998018; c=relaxed/simple;
	bh=yN93/JGK3+gKg6XI5Xt7d/9ipacWhWqRUwi0NIAfa+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G5Eix9a38bEGVBcaHGoOqe6ZRRdRp6uXM0YUxXQl6eyQIgGDveG3csq9PWChKU21xtBscts1ScyzY2TEBtvWzL3ajXa8ji4BqXxlMvSjc2eU6TeBB16HW1tFMzMrtkIFD+MkyLynihicUh2JuFQam66bmNksV0dAc8wOrRoDh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E0Jfvwby; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=/5lazZJk/6vmmNJZ9fd2QJzdDNBwqyugP2eqo+d23QU=;
	b=E0JfvwbyB7IR9YTyCr1TTOrYCnoCDnLdX5772564KPstCJWzAD5BpgpjvFvuNS
	fJkxQwpg9M6BTL9nt0FtoqQdIhO19hPU1vcUaHkFf+Zhi6ybvOVT8/nzrslAYFaj
	0kWCsWEhvdRZ28AavrRGR/SZkpz92flTda1UEFkAy00x8=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAXvVNIqbloVZcuGQ--.61807S2;
	Thu, 04 Sep 2025 22:59:21 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: kerneljasonxing@gmail.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the retire operation
Date: Thu,  4 Sep 2025 22:59:20 +0800
Message-Id: <20250904145920.1431219-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXvVNIqbloVZcuGQ--.61807S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryruw13Xry7Xry5WFW7Arb_yoWrXFyrpa
	yjg34DGrZ7tr1jgw4UAan5Xr1SvwnrJF17Jrs3ta4YyrZrtF1fGa42kF909FZ8Xrs7u3Z3
	ZF4fKry5uw4kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmjgxUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRx6+Cmi4+XeCpgACsV

On Thu, Sep 4, 2025 at 10:50 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> > In the description of [PATCH net-next v10 0/2] net: af_packet: optimize retire operation:
> >
> > Changes in v7:
> >   When the callback return, without sk_buff_head lock protection, __run_hrtimer will
> >   enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expires while
> >   enqueuing a timer may cause chaos in the hrtimer red-black tree.
> >
> > Neither hrtimer_set_expires nor hrtimer_forward_now is allowed when the hrtimer has
> > already been enqueued. Therefore, the only place where the hrtimer timeout can be set is
> > within the callback, at which point the hrtimer is in a non-enqueued state and can have
> > its timeout set.
> 
> Can we use hrtimer_is_queued() instead? Please see tcp_pacing_check()
> as an example. But considering your following explanation, I think
> it's okay now.

Okay， let's keep the current logic as it is.



> > /* kbdq - kernel block descriptor queue */
> > struct tpacket_kbdq_core {
> >         struct pgv      *pkbdq;
> >         unsigned int    feature_req_word;
> >         unsigned int    hdrlen;
> >         unsigned short  kactive_blk_num;
> >         unsigned short  blk_sizeof_priv;
> >         unsigned char   reset_pending_on_curr_blk;
> >
> >         char            *pkblk_start;
> >         char            *pkblk_end;
> >         int             kblk_size;
> >         unsigned int    max_frame_len;
> >         unsigned int    knum_blocks;
> >         char            *prev;
> >         char            *nxt_offset;
> >
> >         unsigned short  version;
> >
> >         uint64_t        knxt_seq_num;
> >         struct sk_buff  *skb;
> >
> >         rwlock_t        blk_fill_in_prog_lock;
> >
> >         /* timer to retire an outstanding block */
> >         struct hrtimer  retire_blk_timer;
> >
> >         /* Default is set to 8ms */
> > #define DEFAULT_PRB_RETIRE_TOV  (8)
> >
> >         ktime_t         interval_ktime;
> > };
> 
> Could you share the result after running 'pahole --hex -C
> tpacket_kbdq_core vmlinux'?

I change the struct tpacket_kbdq_core as following:

/* kbdq - kernel block descriptor queue */
struct tpacket_kbdq_core {
	struct pgv	*pkbdq;
	unsigned int	feature_req_word;
	unsigned int	hdrlen;
	unsigned char	reset_pending_on_curr_blk;
	unsigned short	kactive_blk_num;
	unsigned short	blk_sizeof_priv;

	unsigned short  version;

	char		*pkblk_start;
	char		*pkblk_end;
	int		kblk_size;
	unsigned int	max_frame_len;
	unsigned int	knum_blocks;
	char		*prev;
	char		*nxt_offset;

	uint64_t	knxt_seq_num;
	struct sk_buff	*skb;

	rwlock_t	blk_fill_in_prog_lock;

	/* timer to retire an outstanding block */
	struct hrtimer  retire_blk_timer;

	/* Default is set to 8ms */
#define DEFAULT_PRB_RETIRE_TOV	(8)

	ktime_t		interval_ktime;
};


pahole --hex -C tpacket_kbdq_core vmlinux

running results:

struct tpacket_kbdq_core {
        struct pgv *               pkbdq;                /*     0   0x8 */
        unsigned int               feature_req_word;     /*   0x8   0x4 */
        unsigned int               hdrlen;               /*   0xc   0x4 */
        unsigned char              reset_pending_on_curr_blk; /*  0x10   0x1 */

        /* XXX 1 byte hole, try to pack */

        short unsigned int         kactive_blk_num;      /*  0x12   0x2 */
        short unsigned int         blk_sizeof_priv;      /*  0x14   0x2 */
        short unsigned int         version;              /*  0x16   0x2 */
        char *                     pkblk_start;          /*  0x18   0x8 */
        char *                     pkblk_end;            /*  0x20   0x8 */
        int                        kblk_size;            /*  0x28   0x4 */
        unsigned int               max_frame_len;        /*  0x2c   0x4 */
        unsigned int               knum_blocks;          /*  0x30   0x4 */

        /* XXX 4 bytes hole, try to pack */

        char *                     prev;                 /*  0x38   0x8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        char *                     nxt_offset;           /*  0x40   0x8 */
        uint64_t                   knxt_seq_num;         /*  0x48   0x8 */
        struct sk_buff *           skb;                  /*  0x50   0x8 */
        rwlock_t                   blk_fill_in_prog_lock; /*  0x58  0x30 */
        /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
        struct hrtimer             retire_blk_timer __attribute__((__aligned__(8))); /*  0x88  0x40 */

        /* XXX last struct has 4 bytes of padding */

        /* --- cacheline 3 boundary (192 bytes) was 8 bytes ago --- */
        ktime_t                    interval_ktime;       /*  0xc8   0x8 */

        /* size: 208, cachelines: 4, members: 19 */
        /* sum members: 203, holes: 2, sum holes: 5 */
        /* paddings: 1, sum paddings: 4 */
        /* forced alignments: 1 */
        /* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));


Thanks
Xin Zhao


