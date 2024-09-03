Return-Path: <netdev+bounces-124423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD2E96967C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B19B254CF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B867200117;
	Tue,  3 Sep 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsirezBG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368281D6C4E
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350776; cv=none; b=uW9LUaBNIQjLaLeWhLEqwNFXi3zm9WILFA+hVqem7TH/Cw2Jnx0LDAHho7dVTI9FrB6FlR0aTzMqpyJwKsY33oG9xxOVPOoxQnaEhwKNfZ/Y0lEwZtWSjZ86Cd5Nz3kugyrORhO09rfHP1GCekjVk9aR8CZF/dwYI4Jqz9r7bfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350776; c=relaxed/simple;
	bh=f7LUo3hTsT+L2FIrBHneZfLc6P5rRvCzXONBT3NDjvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZStzTaa6FDzBvLkUevj7oXQrajw3WwXWz9iodvEMu7WChtS9l37SReOV3DjuzVSXH2CXJlJ+FWVPbSGVMHYl0mlHvmiFXpRFWog8TqlskLB7mJ/gcF+IPaqTVolvOs7vqcQovaYDLSGnTvVS7bA/Rz4uzX/DiobOZUNdFEHHM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsirezBG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so31739655e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725350772; x=1725955572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+jcNvXwcZP7sFCaxD97WcBtfhr0bQjpaJNmIlWmdfk=;
        b=vsirezBGmsZ/2h7UZQpNd1Bq1/VC5sVA3ohBZoiVxRDSRGm1VZ9igdxXCdH53YoDE5
         3Ex6rldGMV4bVzuNiDyG3wWlrHhd6jpORLPl0o0rgjA++FxdwOo9WU8FnfuT2vIsKjxA
         7L0NJwCCqweOU/95A/p5kHBnGT2Kz5dTBBDU5UUk4V3xbnyT0i5a/lpjsLznnecAvpEH
         oPcBpMm2ChuvWQTam9clJCDDgmcKdI5QM3EN8cbjmpfs9BdBoD/C5wUWTHSkrq0+uXi4
         vZ3diKn7o2+IKcYzHrzUNy9Xm+qC4KHz7ZSgi9bSykehwz45EFMFauvyMAdkdDbd1Kwu
         H+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350772; x=1725955572;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+jcNvXwcZP7sFCaxD97WcBtfhr0bQjpaJNmIlWmdfk=;
        b=NCHF8Cm27oRCvvEPMq4D9EP+eMj1M8v0DC/pZYTtECFbjmWc9UMYNTHRqtFEGNc8JR
         VPWv00Szzr3VQerQ6HOAljgDs6pVQbPTzRAVXAZ1G6NWYv5zCLlmBPGjwJwMO+UNJpgW
         He8uvV3e0OLehOr0URcvFJZu+gMJ/OKg8ihfAVYcGFya+4IUZkx4K0w9bXjYfcMD0A1w
         f4BaEdPfTtVXiDIRxbF/cBNtDKYhx/m99eC0YNbBZHwM7OAja4z1sGnmjLocnbIYkfcd
         T+NYZQdsNMQQn9k/0GiS8mhhuJCRFu+eV9UXMorWLoDOylBuQu4qf/3bKrCa8+dcYueo
         nwVA==
X-Forwarded-Encrypted: i=1; AJvYcCUFyfeQelfNvZ096kPi+6dbHLY6WK+wEZF8aJNa9w1KJwekAf7TIC0vKmb/f+VpHvVlKTY93qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQSGqMDMwczgMazrz23cAGrUQ85A1xFdj5ebBmxEMu6DcSyd/
	hyDBiZfpF4cNKzUMFz+NqkQsml+6YN7+Od5OETjFvVx1VO6Hox+PHNlNhB5mXP8=
X-Google-Smtp-Source: AGHT+IHZpeduoamkg9M98Ak7B6SSldudVdVCYhswl6uRte+6RP2UeB3LdiJ2f+ejcbtU/TqwFrOojA==
X-Received: by 2002:a05:600c:45d1:b0:42b:afbb:1704 with SMTP id 5b1f17b1804b1-42c880ec5e4mr20890285e9.6.1725350772292;
        Tue, 03 Sep 2024 01:06:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641db12sm200059275e9.35.2024.09.03.01.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:06:12 -0700 (PDT)
Date: Tue, 3 Sep 2024 11:06:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Message-ID: <150aaaba-a26c-48d4-bc3f-f3b1eeca8b24@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902130937.457115-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/selftests-txtimestamp-add-SCM_TS_OPT_ID-test/20240902-212008
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240902130937.457115-1-vadfed%40meta.com
patch subject: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
config: csky-randconfig-r072-20240903 (https://download.01.org/0day-ci/archive/20240903/202409031142.3dSuW9Oo-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409031142.3dSuW9Oo-lkp@intel.com/

smatch warnings:
net/ipv4/ip_output.c:1284 __ip_append_data() error: uninitialized symbol 'hold_tskey'.

vim +/hold_tskey +1284 net/ipv4/ip_output.c

f5fca608651129 David S. Miller          2011-05-08   952  static int __ip_append_data(struct sock *sk,
f5fca608651129 David S. Miller          2011-05-08   953  			    struct flowi4 *fl4,
f5fca608651129 David S. Miller          2011-05-08   954  			    struct sk_buff_head *queue,
1470ddf7f8cecf Herbert Xu               2011-03-01   955  			    struct inet_cork *cork,
5640f7685831e0 Eric Dumazet             2012-09-23   956  			    struct page_frag *pfrag,
1470ddf7f8cecf Herbert Xu               2011-03-01   957  			    int getfrag(void *from, char *to, int offset,
1470ddf7f8cecf Herbert Xu               2011-03-01   958  					int len, int odd, struct sk_buff *skb),
^1da177e4c3f41 Linus Torvalds           2005-04-16   959  			    void *from, int length, int transhdrlen,
^1da177e4c3f41 Linus Torvalds           2005-04-16   960  			    unsigned int flags)
^1da177e4c3f41 Linus Torvalds           2005-04-16   961  {
^1da177e4c3f41 Linus Torvalds           2005-04-16   962  	struct inet_sock *inet = inet_sk(sk);
b5947e5d1e710c Willem de Bruijn         2018-11-30   963  	struct ubuf_info *uarg = NULL;
^1da177e4c3f41 Linus Torvalds           2005-04-16   964  	struct sk_buff *skb;
07df5294a753df Herbert Xu               2011-03-01   965  	struct ip_options *opt = cork->opt;
^1da177e4c3f41 Linus Torvalds           2005-04-16   966  	int hh_len;
^1da177e4c3f41 Linus Torvalds           2005-04-16   967  	int exthdrlen;
^1da177e4c3f41 Linus Torvalds           2005-04-16   968  	int mtu;
^1da177e4c3f41 Linus Torvalds           2005-04-16   969  	int copy;
^1da177e4c3f41 Linus Torvalds           2005-04-16   970  	int err;
^1da177e4c3f41 Linus Torvalds           2005-04-16   971  	int offset = 0;
8eb77cc73977d8 Pavel Begunkov           2022-07-12   972  	bool zc = false;
daba287b299ec7 Hannes Frederic Sowa     2013-10-27   973  	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
^1da177e4c3f41 Linus Torvalds           2005-04-16   974  	int csummode = CHECKSUM_NONE;
05d6d492097c55 Eric Dumazet             2024-04-29   975  	struct rtable *rt = dst_rtable(cork->dst);
488b6d91b07112 Vadim Fedorenko          2024-02-13   976  	bool paged, hold_tskey, extra_uref = false;
694aba690de062 Eric Dumazet             2018-03-31   977  	unsigned int wmem_alloc_delta = 0;
09c2d251b70723 Willem de Bruijn         2014-08-04   978  	u32 tskey = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16   979  
96d7303e9cfb6a Steffen Klassert         2011-06-05   980  	skb = skb_peek_tail(queue);
96d7303e9cfb6a Steffen Klassert         2011-06-05   981  
96d7303e9cfb6a Steffen Klassert         2011-06-05   982  	exthdrlen = !skb ? rt->dst.header_len : 0;
bec1f6f697362c Willem de Bruijn         2018-04-26   983  	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
15e36f5b8e982d Willem de Bruijn         2018-04-26   984  	paged = !!cork->gso_size;
bec1f6f697362c Willem de Bruijn         2018-04-26   985  
d8d1f30b95a635 Changli Gao              2010-06-10   986  	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
^1da177e4c3f41 Linus Torvalds           2005-04-16   987  
^1da177e4c3f41 Linus Torvalds           2005-04-16   988  	fragheaderlen = sizeof(struct iphdr) + (opt ? opt->optlen : 0);
^1da177e4c3f41 Linus Torvalds           2005-04-16   989  	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen;
cbc08a33126f8f Miaohe Lin               2020-08-29   990  	maxnonfragsize = ip_sk_ignore_df(sk) ? IP_MAX_MTU : mtu;
^1da177e4c3f41 Linus Torvalds           2005-04-16   991  
daba287b299ec7 Hannes Frederic Sowa     2013-10-27   992  	if (cork->length + length > maxnonfragsize - fragheaderlen) {
f5fca608651129 David S. Miller          2011-05-08   993  		ip_local_error(sk, EMSGSIZE, fl4->daddr, inet->inet_dport,
61e7f09d0f437c Hannes Frederic Sowa     2013-12-19   994  			       mtu - (opt ? opt->optlen : 0));
^1da177e4c3f41 Linus Torvalds           2005-04-16   995  		return -EMSGSIZE;
^1da177e4c3f41 Linus Torvalds           2005-04-16   996  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16   997  
^1da177e4c3f41 Linus Torvalds           2005-04-16   998  	/*
^1da177e4c3f41 Linus Torvalds           2005-04-16   999  	 * transhdrlen > 0 means that this is the first fragment and we wish
^1da177e4c3f41 Linus Torvalds           2005-04-16  1000  	 * it won't be fragmented in the future.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1001  	 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1002  	if (transhdrlen &&
^1da177e4c3f41 Linus Torvalds           2005-04-16  1003  	    length + fragheaderlen <= mtu &&
c8cd0989bd151f Tom Herbert              2015-12-14  1004  	    rt->dst.dev->features & (NETIF_F_HW_CSUM | NETIF_F_IP_CSUM) &&
bec1f6f697362c Willem de Bruijn         2018-04-26  1005  	    (!(flags & MSG_MORE) || cork->gso_size) &&
cd027a5433d667 Jacek Kalwas             2018-04-12  1006  	    (!exthdrlen || (rt->dst.dev->features & NETIF_F_HW_ESP_TX_CSUM)))
84fa7933a33f80 Patrick McHardy          2006-08-29  1007  		csummode = CHECKSUM_PARTIAL;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1008  
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1009  	if ((flags & MSG_ZEROCOPY) && length) {
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1010  		struct msghdr *msg = from;
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1011  
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1012  		if (getfrag == ip_generic_getfrag && msg->msg_ubuf) {
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1013  			if (skb_zcopy(skb) && msg->msg_ubuf != skb_zcopy(skb))
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1014  				return -EINVAL;
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1015  
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1016  			/* Leave uarg NULL if can't zerocopy, callers should
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1017  			 * be able to handle it.
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1018  			 */
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1019  			if ((rt->dst.dev->features & NETIF_F_SG) &&
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1020  			    csummode == CHECKSUM_PARTIAL) {
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1021  				paged = true;
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1022  				zc = true;
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1023  				uarg = msg->msg_ubuf;
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1024  			}
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1025  		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
8c793822c5803e Jonathan Lemon           2021-01-06  1026  			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb));
b5947e5d1e710c Willem de Bruijn         2018-11-30  1027  			if (!uarg)
b5947e5d1e710c Willem de Bruijn         2018-11-30  1028  				return -ENOBUFS;
522924b583082f Willem de Bruijn         2019-06-07  1029  			extra_uref = !skb_zcopy(skb);	/* only ref on new uarg */
b5947e5d1e710c Willem de Bruijn         2018-11-30  1030  			if (rt->dst.dev->features & NETIF_F_SG &&
b5947e5d1e710c Willem de Bruijn         2018-11-30  1031  			    csummode == CHECKSUM_PARTIAL) {
b5947e5d1e710c Willem de Bruijn         2018-11-30  1032  				paged = true;
8eb77cc73977d8 Pavel Begunkov           2022-07-12  1033  				zc = true;
b5947e5d1e710c Willem de Bruijn         2018-11-30  1034  			} else {
e7d2b510165fff Pavel Begunkov           2022-09-23  1035  				uarg_to_msgzc(uarg)->zerocopy = 0;
52900d22288e7d Willem de Bruijn         2018-11-30  1036  				skb_zcopy_set(skb, uarg, &extra_uref);
b5947e5d1e710c Willem de Bruijn         2018-11-30  1037  			}
b5947e5d1e710c Willem de Bruijn         2018-11-30  1038  		}
7da0dde68486b2 David Howells            2023-05-22  1039  	} else if ((flags & MSG_SPLICE_PAGES) && length) {
cafbe182a467bf Eric Dumazet             2023-08-16  1040  		if (inet_test_bit(HDRINCL, sk))
7da0dde68486b2 David Howells            2023-05-22  1041  			return -EPERM;
5a6f6873606e03 David Howells            2023-06-14  1042  		if (rt->dst.dev->features & NETIF_F_SG &&
5a6f6873606e03 David Howells            2023-06-14  1043  		    getfrag == ip_generic_getfrag)
7da0dde68486b2 David Howells            2023-05-22  1044  			/* We need an empty buffer to attach stuff to */
7da0dde68486b2 David Howells            2023-05-22  1045  			paged = true;
7da0dde68486b2 David Howells            2023-05-22  1046  		else
7da0dde68486b2 David Howells            2023-05-22  1047  			flags &= ~MSG_SPLICE_PAGES;
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1048  	}
b5947e5d1e710c Willem de Bruijn         2018-11-30  1049  
1470ddf7f8cecf Herbert Xu               2011-03-01  1050  	cork->length += length;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1051  
b7399073687728 Vadim Fedorenko          2024-09-02  1052  	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
b7399073687728 Vadim Fedorenko          2024-09-02  1053  	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
b7399073687728 Vadim Fedorenko          2024-09-02  1054  		if (cork->flags & IPCORK_TS_OPT_ID) {
b7399073687728 Vadim Fedorenko          2024-09-02  1055  			tskey = cork->ts_opt_id;
b7399073687728 Vadim Fedorenko          2024-09-02  1056  		} else {
488b6d91b07112 Vadim Fedorenko          2024-02-13  1057  			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
b7399073687728 Vadim Fedorenko          2024-09-02  1058  			hold_tskey = true;

hold_tskey is never set to false.

b7399073687728 Vadim Fedorenko          2024-09-02  1059  		}
b7399073687728 Vadim Fedorenko          2024-09-02  1060  	}
488b6d91b07112 Vadim Fedorenko          2024-02-13  1061  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1062  	/* So, what's going on in the loop below?
^1da177e4c3f41 Linus Torvalds           2005-04-16  1063  	 *
^1da177e4c3f41 Linus Torvalds           2005-04-16  1064  	 * We use calculated fragment length to generate chained skb,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1065  	 * each of segments is IP fragment ready for sending to network after
^1da177e4c3f41 Linus Torvalds           2005-04-16  1066  	 * adding appropriate IP header.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1067  	 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1068  
26cde9f7e2747b Herbert Xu               2010-06-15  1069  	if (!skb)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1070  		goto alloc_new_skb;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1071  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1072  	while (length > 0) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1073  		/* Check if the remaining data fits into current packet. */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1074  		copy = mtu - skb->len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1075  		if (copy < length)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1076  			copy = maxfraglen - skb->len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1077  		if (copy <= 0) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1078  			char *data;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1079  			unsigned int datalen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1080  			unsigned int fraglen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1081  			unsigned int fraggap;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1082  			unsigned int alloclen, alloc_extra;
aba36930a35e7f Willem de Bruijn         2018-11-24  1083  			unsigned int pagedlen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1084  			struct sk_buff *skb_prev;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1085  alloc_new_skb:
^1da177e4c3f41 Linus Torvalds           2005-04-16  1086  			skb_prev = skb;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1087  			if (skb_prev)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1088  				fraggap = skb_prev->len - maxfraglen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1089  			else
^1da177e4c3f41 Linus Torvalds           2005-04-16  1090  				fraggap = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1091  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1092  			/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1093  			 * If remaining data exceeds the mtu,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1094  			 * we know we need more fragment(s).
^1da177e4c3f41 Linus Torvalds           2005-04-16  1095  			 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1096  			datalen = length + fraggap;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1097  			if (datalen > mtu - fragheaderlen)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1098  				datalen = maxfraglen - fragheaderlen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1099  			fraglen = datalen + fragheaderlen;
aba36930a35e7f Willem de Bruijn         2018-11-24  1100  			pagedlen = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1101  
6d123b81ac6150 Jakub Kicinski           2021-06-23  1102  			alloc_extra = hh_len + 15;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1103  			alloc_extra += exthdrlen;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1104  
6d123b81ac6150 Jakub Kicinski           2021-06-23  1105  			/* The last fragment gets additional space at tail.
6d123b81ac6150 Jakub Kicinski           2021-06-23  1106  			 * Note, with MSG_MORE we overallocate on fragments,
6d123b81ac6150 Jakub Kicinski           2021-06-23  1107  			 * because we have no idea what fragment will be
6d123b81ac6150 Jakub Kicinski           2021-06-23  1108  			 * the last.
6d123b81ac6150 Jakub Kicinski           2021-06-23  1109  			 */
6d123b81ac6150 Jakub Kicinski           2021-06-23  1110  			if (datalen == length + fraggap)
6d123b81ac6150 Jakub Kicinski           2021-06-23  1111  				alloc_extra += rt->dst.trailer_len;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1112  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1113  			if ((flags & MSG_MORE) &&
d8d1f30b95a635 Changli Gao              2010-06-10  1114  			    !(rt->dst.dev->features&NETIF_F_SG))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1115  				alloclen = mtu;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1116  			else if (!paged &&
6d123b81ac6150 Jakub Kicinski           2021-06-23  1117  				 (fraglen + alloc_extra < SKB_MAX_ALLOC ||
6d123b81ac6150 Jakub Kicinski           2021-06-23  1118  				  !(rt->dst.dev->features & NETIF_F_SG)))
59104f062435c7 Eric Dumazet             2010-09-20  1119  				alloclen = fraglen;
47cf88993c9108 Pavel Begunkov           2022-08-25  1120  			else {
8eb77cc73977d8 Pavel Begunkov           2022-07-12  1121  				alloclen = fragheaderlen + transhdrlen;
8eb77cc73977d8 Pavel Begunkov           2022-07-12  1122  				pagedlen = datalen - transhdrlen;
15e36f5b8e982d Willem de Bruijn         2018-04-26  1123  			}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1124  
6d123b81ac6150 Jakub Kicinski           2021-06-23  1125  			alloclen += alloc_extra;
33f99dc7fd948b Steffen Klassert         2011-06-22  1126  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1127  			if (transhdrlen) {
6d123b81ac6150 Jakub Kicinski           2021-06-23  1128  				skb = sock_alloc_send_skb(sk, alloclen,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1129  						(flags & MSG_DONTWAIT), &err);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1130  			} else {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1131  				skb = NULL;
694aba690de062 Eric Dumazet             2018-03-31  1132  				if (refcount_read(&sk->sk_wmem_alloc) + wmem_alloc_delta <=
^1da177e4c3f41 Linus Torvalds           2005-04-16  1133  				    2 * sk->sk_sndbuf)
6d123b81ac6150 Jakub Kicinski           2021-06-23  1134  					skb = alloc_skb(alloclen,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1135  							sk->sk_allocation);
51456b2914a34d Ian Morris               2015-04-03  1136  				if (unlikely(!skb))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1137  					err = -ENOBUFS;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1138  			}
51456b2914a34d Ian Morris               2015-04-03  1139  			if (!skb)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1140  				goto error;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1141  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1142  			/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1143  			 *	Fill in the control structures
^1da177e4c3f41 Linus Torvalds           2005-04-16  1144  			 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1145  			skb->ip_summed = csummode;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1146  			skb->csum = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1147  			skb_reserve(skb, hh_len);
11878b40ed5c5b Willem de Bruijn         2014-07-14  1148  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1149  			/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1150  			 *	Find where to start putting bytes.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1151  			 */
15e36f5b8e982d Willem de Bruijn         2018-04-26  1152  			data = skb_put(skb, fraglen + exthdrlen - pagedlen);
c14d2450cb7fe1 Arnaldo Carvalho de Melo 2007-03-11  1153  			skb_set_network_header(skb, exthdrlen);
b0e380b1d8a8e0 Arnaldo Carvalho de Melo 2007-04-10  1154  			skb->transport_header = (skb->network_header +
b0e380b1d8a8e0 Arnaldo Carvalho de Melo 2007-04-10  1155  						 fragheaderlen);
353e5c9abd900d Steffen Klassert         2011-06-22  1156  			data += fragheaderlen + exthdrlen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1157  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1158  			if (fraggap) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1159  				skb->csum = skb_copy_and_csum_bits(
^1da177e4c3f41 Linus Torvalds           2005-04-16  1160  					skb_prev, maxfraglen,
8d5930dfb7edbf Al Viro                  2020-07-10  1161  					data + transhdrlen, fraggap);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1162  				skb_prev->csum = csum_sub(skb_prev->csum,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1163  							  skb->csum);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1164  				data += fraggap;
e9fa4f7bd291c2 Herbert Xu               2006-08-13  1165  				pskb_trim_unique(skb_prev, maxfraglen);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1166  			}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1167  
15e36f5b8e982d Willem de Bruijn         2018-04-26  1168  			copy = datalen - transhdrlen - fraggap - pagedlen;
0f71c9caf26726 David Howells            2023-08-01  1169  			/* [!] NOTE: copy will be negative if pagedlen>0
0f71c9caf26726 David Howells            2023-08-01  1170  			 * because then the equation reduces to -fraggap.
0f71c9caf26726 David Howells            2023-08-01  1171  			 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1172  			if (copy > 0 && getfrag(from, data + transhdrlen, offset, copy, fraggap, skb) < 0) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1173  				err = -EFAULT;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1174  				kfree_skb(skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1175  				goto error;
0f71c9caf26726 David Howells            2023-08-01  1176  			} else if (flags & MSG_SPLICE_PAGES) {
0f71c9caf26726 David Howells            2023-08-01  1177  				copy = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1178  			}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1179  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1180  			offset += copy;
15e36f5b8e982d Willem de Bruijn         2018-04-26  1181  			length -= copy + transhdrlen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1182  			transhdrlen = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1183  			exthdrlen = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1184  			csummode = CHECKSUM_NONE;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1185  
52900d22288e7d Willem de Bruijn         2018-11-30  1186  			/* only the initial fragment is time stamped */
52900d22288e7d Willem de Bruijn         2018-11-30  1187  			skb_shinfo(skb)->tx_flags = cork->tx_flags;
52900d22288e7d Willem de Bruijn         2018-11-30  1188  			cork->tx_flags = 0;
52900d22288e7d Willem de Bruijn         2018-11-30  1189  			skb_shinfo(skb)->tskey = tskey;
52900d22288e7d Willem de Bruijn         2018-11-30  1190  			tskey = 0;
52900d22288e7d Willem de Bruijn         2018-11-30  1191  			skb_zcopy_set(skb, uarg, &extra_uref);
52900d22288e7d Willem de Bruijn         2018-11-30  1192  
0dec879f636f11 Julian Anastasov         2017-02-06  1193  			if ((flags & MSG_CONFIRM) && !skb_prev)
0dec879f636f11 Julian Anastasov         2017-02-06  1194  				skb_set_dst_pending_confirm(skb, 1);
0dec879f636f11 Julian Anastasov         2017-02-06  1195  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1196  			/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1197  			 * Put the packet on the pending queue.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1198  			 */
694aba690de062 Eric Dumazet             2018-03-31  1199  			if (!skb->destructor) {
694aba690de062 Eric Dumazet             2018-03-31  1200  				skb->destructor = sock_wfree;
694aba690de062 Eric Dumazet             2018-03-31  1201  				skb->sk = sk;
694aba690de062 Eric Dumazet             2018-03-31  1202  				wmem_alloc_delta += skb->truesize;
694aba690de062 Eric Dumazet             2018-03-31  1203  			}
1470ddf7f8cecf Herbert Xu               2011-03-01  1204  			__skb_queue_tail(queue, skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1205  			continue;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1206  		}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1207  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1208  		if (copy > length)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1209  			copy = length;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1210  
113f99c3358564 Willem de Bruijn         2018-05-17  1211  		if (!(rt->dst.dev->features&NETIF_F_SG) &&
113f99c3358564 Willem de Bruijn         2018-05-17  1212  		    skb_tailroom(skb) >= copy) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1213  			unsigned int off;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1214  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1215  			off = skb->len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1216  			if (getfrag(from, skb_put(skb, copy),
^1da177e4c3f41 Linus Torvalds           2005-04-16  1217  					offset, copy, off, skb) < 0) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1218  				__skb_trim(skb, off);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1219  				err = -EFAULT;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1220  				goto error;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1221  			}
7da0dde68486b2 David Howells            2023-05-22  1222  		} else if (flags & MSG_SPLICE_PAGES) {
7da0dde68486b2 David Howells            2023-05-22  1223  			struct msghdr *msg = from;
7da0dde68486b2 David Howells            2023-05-22  1224  
0f71c9caf26726 David Howells            2023-08-01  1225  			err = -EIO;
0f71c9caf26726 David Howells            2023-08-01  1226  			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
0f71c9caf26726 David Howells            2023-08-01  1227  				goto error;
0f71c9caf26726 David Howells            2023-08-01  1228  
7da0dde68486b2 David Howells            2023-05-22  1229  			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
7da0dde68486b2 David Howells            2023-05-22  1230  						   sk->sk_allocation);
7da0dde68486b2 David Howells            2023-05-22  1231  			if (err < 0)
7da0dde68486b2 David Howells            2023-05-22  1232  				goto error;
7da0dde68486b2 David Howells            2023-05-22  1233  			copy = err;
7da0dde68486b2 David Howells            2023-05-22  1234  			wmem_alloc_delta += copy;
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1235  		} else if (!zc) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1236  			int i = skb_shinfo(skb)->nr_frags;
5640f7685831e0 Eric Dumazet             2012-09-23  1237  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1238  			err = -ENOMEM;
5640f7685831e0 Eric Dumazet             2012-09-23  1239  			if (!sk_page_frag_refill(sk, pfrag))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1240  				goto error;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1241  
c445f31b3cfaa0 Pavel Begunkov           2022-07-12  1242  			skb_zcopy_downgrade_managed(skb);
5640f7685831e0 Eric Dumazet             2012-09-23  1243  			if (!skb_can_coalesce(skb, i, pfrag->page,
5640f7685831e0 Eric Dumazet             2012-09-23  1244  					      pfrag->offset)) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1245  				err = -EMSGSIZE;
5640f7685831e0 Eric Dumazet             2012-09-23  1246  				if (i == MAX_SKB_FRAGS)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1247  					goto error;
5640f7685831e0 Eric Dumazet             2012-09-23  1248  
5640f7685831e0 Eric Dumazet             2012-09-23  1249  				__skb_fill_page_desc(skb, i, pfrag->page,
5640f7685831e0 Eric Dumazet             2012-09-23  1250  						     pfrag->offset, 0);
5640f7685831e0 Eric Dumazet             2012-09-23  1251  				skb_shinfo(skb)->nr_frags = ++i;
5640f7685831e0 Eric Dumazet             2012-09-23  1252  				get_page(pfrag->page);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1253  			}
5640f7685831e0 Eric Dumazet             2012-09-23  1254  			copy = min_t(int, copy, pfrag->size - pfrag->offset);
5640f7685831e0 Eric Dumazet             2012-09-23  1255  			if (getfrag(from,
5640f7685831e0 Eric Dumazet             2012-09-23  1256  				    page_address(pfrag->page) + pfrag->offset,
5640f7685831e0 Eric Dumazet             2012-09-23  1257  				    offset, copy, skb->len, skb) < 0)
5640f7685831e0 Eric Dumazet             2012-09-23  1258  				goto error_efault;
5640f7685831e0 Eric Dumazet             2012-09-23  1259  
5640f7685831e0 Eric Dumazet             2012-09-23  1260  			pfrag->offset += copy;
5640f7685831e0 Eric Dumazet             2012-09-23  1261  			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
ede57d58e6f38d Richard Gobert           2022-06-22  1262  			skb_len_add(skb, copy);
694aba690de062 Eric Dumazet             2018-03-31  1263  			wmem_alloc_delta += copy;
b5947e5d1e710c Willem de Bruijn         2018-11-30  1264  		} else {
b5947e5d1e710c Willem de Bruijn         2018-11-30  1265  			err = skb_zerocopy_iter_dgram(skb, from, copy);
b5947e5d1e710c Willem de Bruijn         2018-11-30  1266  			if (err < 0)
b5947e5d1e710c Willem de Bruijn         2018-11-30  1267  				goto error;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1268  		}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1269  		offset += copy;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1270  		length -= copy;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1271  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1272  
9e8445a56c253f Paolo Abeni              2018-04-04  1273  	if (wmem_alloc_delta)
694aba690de062 Eric Dumazet             2018-03-31  1274  		refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1275  	return 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1276  
5640f7685831e0 Eric Dumazet             2012-09-23  1277  error_efault:
5640f7685831e0 Eric Dumazet             2012-09-23  1278  	err = -EFAULT;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1279  error:
8e0449172497a9 Jonathan Lemon           2021-01-06  1280  	net_zcopy_put_abort(uarg, extra_uref);
1470ddf7f8cecf Herbert Xu               2011-03-01  1281  	cork->length -= length;
5e38e270444f26 Pavel Emelyanov          2008-07-16  1282  	IP_INC_STATS(sock_net(sk), IPSTATS_MIB_OUTDISCARDS);
694aba690de062 Eric Dumazet             2018-03-31  1283  	refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
488b6d91b07112 Vadim Fedorenko          2024-02-13 @1284  	if (hold_tskey)
488b6d91b07112 Vadim Fedorenko          2024-02-13  1285  		atomic_dec(&sk->sk_tskey);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1286  	return err;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1287  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


