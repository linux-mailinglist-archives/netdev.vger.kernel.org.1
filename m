Return-Path: <netdev+bounces-20276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616275EE84
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9740F1C20456
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73020FB;
	Mon, 24 Jul 2023 08:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D7185A
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:56:44 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B1BE52
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:56:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so3929448b3a.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189002; x=1690793802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdceaXikzGdbm/uAqLorieUBWrh2jqhzULJ0ZT2BVFc=;
        b=mBJlLFDRNG6ECkMidt9NZy5SvXnvNDenErKWeNEnwIJpe6J4u36p3/C+h6BB5gE2G7
         a+JZCBKzBtvV3qD0olqNW1VcXAImBfTUWFhVHmYG6x4RfoPQgiXZAK2QQIB/+CFNKKRt
         uR/IHeqJYXo5NkdfdhAqpgtvtk4m2te/WJuvEL4ZsffCUxcMclvWje/HBS6HiLljAaGx
         vj0r+lkq3VtNpArQp5TOMrBMqazNsZgE7FdeuX/AnlpG2YyETXCVg2TRDhXHmoiIegWj
         QqygynVUyrdSkiZ72px+Pwh8eHopvG50BwtO6ILi/hiRr7DNjk412aJoFMMovVQf2aCr
         HgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189002; x=1690793802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdceaXikzGdbm/uAqLorieUBWrh2jqhzULJ0ZT2BVFc=;
        b=jgxbM0AKL/uk9RNPR5H8f/RnOV25OZq8zLNpN5aOUIwX+cmA3zFj9LXHhttKy+d3zM
         LYprvyryo4FysphKgkJuv+t5ouMmwvlge0xakSvdn64ik3M5ahq7fYKbD1gMSbxvA52y
         qj25vwxzGgH/n0jsfBjjNXh9a16+OKrwk/YVEyuYAkU0Y5u//7XHREsD82QO57Y6WSQq
         v1ox3ls7cJ8UqSPz5Ygqe0une1hJLGChBb9bA6PzqDcYH3PfFcXLukLMVV65jNNAmrXc
         Y9BSD6sZehpxcikUDzEEERk0k0q4aveZa26BW2RgIYleMkghezRAg4L3q2FofehQ/HjO
         otbA==
X-Gm-Message-State: ABy/qLbr3WgctDdJajYSB16OF9W4Ie9m3XLJpDDTIRJvACCC7SQfuzBI
	RTAACUwRMEmCF2peGw+rYwo=
X-Google-Smtp-Source: APBJJlErFaHpzzQ+5v1YB1XN7mrcDlbmH4XP4W0T43PlZLQTR8AgchBsuSh9spqaS7l4J7AD4nql8Q==
X-Received: by 2002:a05:6a00:1388:b0:682:a6c5:6f28 with SMTP id t8-20020a056a00138800b00682a6c56f28mr11441995pfg.32.1690189002337;
        Mon, 24 Jul 2023 01:56:42 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x8-20020aa793a8000000b0064f51ee5b90sm7267312pff.62.2023.07.24.01.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:56:41 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:56:37 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZL48xbowL8QQRr9s@Laptop-X1>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLzY42I/GjWCJ5Do@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 23, 2023 at 10:38:11AM +0300, Ido Schimmel wrote:
> > > >>> @@ -2088,6 +2089,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> > > >>>
> > > >>>                         fib_notify_alias_delete(net, n->key, &n->leaf, fa,
> > > >>>                                                 NULL);
> > > >>> +                       if (!(fi->fib_flags & RTNH_F_LINKDOWN)) {
> > > >>> +                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
> > > >>> +                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
> > > >>> +                       }
> > > >>
> > > >> Will you get a notification in this case for 198.51.100.0/24?
> > > > 
> > > > No. Do you think it is expected with this patch or not?
> > > 
> > > The intent is that notifications are sent for link events but not route
> > > events which are easily deduced from the link events.
> > 
> > Sorry, I didn't get what you mean. The link events should be notified to user
> > via rtmsg_ifinfo_event()? So I think here we ignore the route events caused by
> > link down looks reasonable.
> 
> The route in the scenario I mentioned wasn't deleted because of a link
> event, but because the source address was deleted yet no notification
> was emitted. IMO, this is wrong given the description of the patch.

OK. I got what you mean now. Is there a way to get the device the route
bond in fib_table_flush() so we can also check the dev flag?

> 
> I assume NetworkManager already knows how to delete routes given
> RTM_DELLINK events. Can't it be taught to react to RTM_DELADDR events as
> well? Then this functionality will always work, regardless of the kernel
> version being used.

The NetworkManager keeps a cache of the routes. Missing/Wrong events mean that
the cache becomes inconsistent. The IPv4 will not send src route delete info
if it's bond to other device. While IPv6 only modify the src route instead of
delete it, and also no notify. So NetworkManager developers complained and
hope to have a consistent and clear notification about route modify/delete.

Thanks
Hangbin

