Return-Path: <netdev+bounces-19725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F9F75BDDF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 07:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7928217D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52615813;
	Fri, 21 Jul 2023 05:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1D80E
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 05:46:21 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096C19B3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 22:46:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89b75dc1cso18297985ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 22:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689918379; x=1690523179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKDJwcUNTKC5lp8fLV2ZNM6QnQtozqpoPtfRK159NYo=;
        b=ZcUXsdPZj4KvG5RDcRWlhnYH15D340mrRZtAYO2w3AjFCJUtGSpY49/nRpMKzDM2//
         QLAAk0hLJALT8Bvk4vbmqXCwGvZ/x5ZfDj+LMEcqaVVTr+bEiFBpt66j6D1WMreQQJ4O
         4RQITlqVkvp6xIDC2erWZw5UZGMTWHRCCbahjzLXRRt0MiaP70vyKXZHA55skmdPqnuD
         Brk10eubkVj7H4GqIFlJrJ9mE/hcn6+ch0qHFs5JpX+8GQTSu7Yp1wxp3OzwaLtGqet8
         w+6aIgmy++8+zOtsFND8Wmk5RR483bgDiVSa9Pfpt7Y22rzF0bt7tgTsp22pT4A37ULu
         KUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689918379; x=1690523179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKDJwcUNTKC5lp8fLV2ZNM6QnQtozqpoPtfRK159NYo=;
        b=ivsQ2wCgUi+bNqBEPaVFvwaadW0G7yZ/y/2pi9eD4ajsfEmLfigxvVCKwqNqGBadO2
         4QLX6/tjh1yOPdi+dSjVR7X9Wm+er6FNEHMYjKPiLSZc7DLoFbIQ8B2/Sq3MirpPGvSG
         G+1VN8uXEKbaTytCiJH58bsti6ZjPhTgiT238GZ6MyNkt7tJ8Xri1dRT/+hLkSsACedf
         f1Wk6I4Zy/bvG1UXqE6Ud29yIWhEx41UXpHng1fwULDtIH4NGPnGJ060dLusfO8tklHz
         Cm6/wTDIvJESGfkqt4NE4U8xhVVJZWvrp+XAmRvL0CL2N+VUIhzR5MEzoev0Y6J+CbgS
         9jaw==
X-Gm-Message-State: ABy/qLbwOhbS7ribrDgqMTZlhXLuYkDa1tRDecvqXX/Yg2dy6mB2pEM2
	ETA63iFSHvYbaoznDpjhz5U=
X-Google-Smtp-Source: APBJJlEG2r3vKwJ9Ma5x6Xe38X5vlVVRpQxpr3K8YQhKexozNRUpTHmA5jjPHEOEeHA4Ubqop3/qkw==
X-Received: by 2002:a17:903:22c2:b0:1ae:6947:e63b with SMTP id y2-20020a17090322c200b001ae6947e63bmr1735856plg.16.1689918379113;
        Thu, 20 Jul 2023 22:46:19 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001a98f844e60sm2412046plh.263.2023.07.20.22.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:46:18 -0700 (PDT)
Date: Fri, 21 Jul 2023 13:46:13 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZLobpQ7jELvCeuoD@Laptop-X1>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:01:06PM -0600, David Ahern wrote:
> >>> How about ignore route deletion for link down? e.g.
> >>>
> >>> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> >>> index 74d403dbd2b4..11c0f325e887 100644
> >>> --- a/net/ipv4/fib_trie.c
> >>> +++ b/net/ipv4/fib_trie.c
> >>> @@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
> >>>  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> >>>  {
> >>>         struct trie *t = (struct trie *)tb->tb_data;
> >>> +       struct nl_info info = { .nl_net = net };
> >>>         struct key_vector *pn = t->kv;
> >>>         unsigned long cindex = 1;
> >>>         struct hlist_node *tmp;
> >>> @@ -2088,6 +2089,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> >>>
> >>>                         fib_notify_alias_delete(net, n->key, &n->leaf, fa,
> >>>                                                 NULL);
> >>> +                       if (!(fi->fib_flags & RTNH_F_LINKDOWN)) {
> >>> +                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
> >>> +                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
> >>> +                       }
> >>
> >> Will you get a notification in this case for 198.51.100.0/24?
> > 
> > No. Do you think it is expected with this patch or not?
> 
> The intent is that notifications are sent for link events but not route
> events which are easily deduced from the link events.

Sorry, I didn't get what you mean. The link events should be notified to user
via rtmsg_ifinfo_event()? So I think here we ignore the route events caused by
link down looks reasonable.

Thanks
Hangbin

