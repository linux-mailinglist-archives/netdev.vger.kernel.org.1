Return-Path: <netdev+bounces-70831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511DD850AD1
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 19:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B15B209FB
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E95CDF6;
	Sun, 11 Feb 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJzAgZWe"
X-Original-To: netdev@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3265D471
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707676161; cv=none; b=ro6lwIdkq2YuacD1BJLzcQo7hzo8Wx2Oqzkc1/LroJDzu3M8eE08TN/llfaRPoTOLebGwQCQW8AZjYP+qWEbiOJMDIw4u4rNUJLHaHO9Ekhlub/z+B/VttZkBDL2iAANe9BpxYraf4f8POklPfKQEQ3C2yASjYiLQba62+gOcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707676161; c=relaxed/simple;
	bh=y5aM9W41dpBCL4D7DJSScJRxIujH/vHwPjGAI9FjPfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twnpygMrn509DGo+AG7qa6GdGG1xzyRuY/7f/eQBJkBe79pe3WmnGP8UqepMWorTHCGrzlGXIeHwZBu4uN0EDy53IKqC+myXSJkFdqIgf9y3RM0AkyxWE5efqCkCc+2Q7K+qCQkT0x8h/YQ32S6I36qYD84l50bZ2GkCvhuDfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJzAgZWe; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id C7E915C0079;
	Sun, 11 Feb 2024 13:29:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 11 Feb 2024 13:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707676157; x=
	1707762557; bh=3MBL4pdWRzAekiY4RB9EojjlxmdLdn51lKxlR/Yh1wY=; b=Q
	JzAgZWeXXe3X0gniOFyi78OyAHKiMu8cP+3ul+vNRHG1KRPckP+EYRdCeEVuQ7G5
	cNbjH5hcshU/Dgfz5wjgbunkGfNXk24lD1VQMh9QPw7cCVHKh3aDNPyAsx8LYDxS
	eWpEifPggABZl4FmZ2s0SRUIMH7Y/nMx6WN1Km3xW3/G8d0Vwo6fMnBp0DdcZttb
	EOsnG1fvnIbeXHTEfzmCO6qip2Ec7gQUyM9/8i//dvVqi4xEOmxOg2YjYG/bP3fc
	poHrmamRfPtKnC2guKCbRDjxl4IzULzNbHmqG6jG6CI9O/Vq1la6jDByZF7cXGVO
	mrhqG0yZAO0ihH5z5O5wQ==
X-ME-Sender: <xms:_RHJZW8SwPNQVs1KcqJA04UxJet3IS0mVif-dWinrAm9Syq_GOqQzg>
    <xme:_RHJZWuvoeGHbxiETR97m9OaPBVpbJiZUDEa2m4Q_yVrQGVzMKMGF-o1OyhZy5VeP
    o7CQkueVY57fXk>
X-ME-Received: <xmr:_RHJZcAqds3pMCw3-p62w90fI0vxphyb9WFaM1srC80PTP8bAEZsZWT0EUkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekgefggefhuedvgeettdegvdeuvdfhudejvddvjeetledvuedtheehleel
    hffhudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:_RHJZecfnNMmf3KThJZXVvFyyZtVIOHaLE37_vZxFGn9b98oerPPcA>
    <xmx:_RHJZbPjWlWA_Jxvd3SooQPQRlDRTF3O2OBCvHvbFXjFpOHwnUScQw>
    <xmx:_RHJZYlhMKTdneuUl7ToWFM3YDaT2F36-EDAwlQ2iA2DyTP9RmGPvA>
    <xmx:_RHJZUoPRkyaq8985OZgQpVxiRQvQTFg3MdMiNnnUYI7gkSlJuUreg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Feb 2024 13:29:16 -0500 (EST)
Date: Sun, 11 Feb 2024 20:29:13 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/2] rtnetlink: use xarray iterator to implement
 rtnl_dump_ifinfo()
Message-ID: <ZckR-XOsULLI9EHc@shredder>
References: <20240209145615.3708207-1-edumazet@google.com>
 <20240209145615.3708207-3-edumazet@google.com>
 <20240209142441.6c56435b@kernel.org>
 <CANn89iKMEWTMkUaBvY1DqPwff0p5yFEG4nNDqZrtQBO3y8FFwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKMEWTMkUaBvY1DqPwff0p5yFEG4nNDqZrtQBO3y8FFwA@mail.gmail.com>

On Sat, Feb 10, 2024 at 12:23:30PM +0100, Eric Dumazet wrote:
> On Fri, Feb 9, 2024 at 11:24 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Fri,  9 Feb 2024 14:56:15 +0000 Eric Dumazet wrote:
> > > +     unsigned long ifindex = cb->args[0];
> >
> > [snip]
> >
> > > +     for_each_netdev_dump(tgt_net, dev, ifindex) {
> > > +             if (link_dump_filtered(dev, master_idx, kind_ops))
> > > +                     continue;
> > > +             err = rtnl_fill_ifinfo(skb, dev, net, RTM_NEWLINK,
> > > +                                    NETLINK_CB(cb->skb).portid,
> > > +                                    nlh->nlmsg_seq, 0, flags,
> > > +                                    ext_filter_mask, 0, NULL, 0,
> > > +                                    netnsid, GFP_KERNEL);
> > > +
> > > +             if (err < 0)
> > > +                     break;
> > > +             cb->args[0] = ifindex + 1;
> >
> > Perhaps we can cast the context buffer onto something typed and use
> > it directly? I think it's a tiny bit less error prone:
> >
> >         struct {
> >                 unsigned long ifindex;
> >         } *ctx = (void *)cb->ctx;
> >
> > Then we can:
> >
> >         for_each_netdev_dump(tgt_net, dev, ctx->ifindex)
> >                                            ^^^^^^^^^^^^
> >
> > and not need to worry about saving the ifindex back to cb before
> > exiting.
> 
> Hi Jakub
> 
> I tried something like that (adding a common structure for future
> conversions), but this was not working properly.
> 
> Unfortunately we only can save the ifindex back to cb->XXXX only after
>  rtnl_fill_ifinfo() was a success.
> 
> For instance, after applying the following diff to my patch, we have a
> bug, because iip link loops on the last device.
> 
> We need to set cb->args[0] to  last_dev->ifindex + 1 to end the dump.

I was looking into that in the past because of another rtnetlink dump
handler. See merge commit f8d3e0dc4b3a ("Merge branch
'nexthop-nexthop-dump-fixes'") and commit 913f60cacda7 ("nexthop: Fix
infinite nexthop dump when using maximum nexthop ID").

Basically, rtnetlink dump handlers always return a positive value if
some entries were filled in the skb to signal that more information
needs to be dumped, even if the dump is complete. I suspect this was
done to ensure that appending the NLMSG_DONE message will not fail, but
Jason fixed it in 2017 in commit 0642840b8bb0 ("af_netlink: ensure that
NLMSG_DONE never fails in dumps").

You can see that the dump is split across two buffers with only a single
netdev configured:

# strace -e sendto,recvmsg ip l
sendto(3, [{nlmsg_len=40, nlmsg_type=0x12 /* NLMSG_??? */, nlmsg_flags=NLM_F_REQUEST|0x300, nlmsg_seq=1707673609, nlmsg_pid=0}, "\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x1d\x00\x01\x00\x00\x00"], 40, 0, NULL, 0) = 40
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 764
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=764, nlmsg_type=0x10 /* NLMSG_??? */, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1707673609, nlmsg_pid=565}, "\x00\x00\x04\x03\x01\x00\x00\x00\x49\x00\x01\x00\x00\x00\x00\x00\x07\x00\x03\x00\x6c\x6f\x00\x00\x08\x00\x0d\x00\xe8\x03\x00\x00"...], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 764
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 20
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1707673609, nlmsg_pid=565}, 0], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 20
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
+++ exited with 0 +++

The fake sentinel ('last_dev->ifindex + 1') is needed so that in the
second invocation of the dump handler it will not fill anything and then
return zero to signal that the dump is complete.

The following diff avoids this inefficiency and returns zero when the
dump is complete:

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31f433950c8d..4efd571a6a3f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2267,17 +2267,15 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 
                        if (err < 0) {
                                if (likely(skb->len))
-                                       goto out;
-
-                               goto out_err;
+                                       err = skb->len;
+                               goto out;
                        }
 cont:
                        idx++;
                }
        }
+
 out:
-       err = skb->len;
-out_err:
        cb->args[1] = idx;
        cb->args[0] = h;
        cb->seq = tgt_net->dev_base_seq;

You can see that both messages (RTM_NEWLINK and NLMSG_DONE) are dumped
in a single buffer with this patch:

# strace -e sendto,recvmsg ip l
sendto(3, [{nlmsg_len=40, nlmsg_type=0x12 /* NLMSG_??? */, nlmsg_flags=NLM_F_REQUEST|0x300, nlmsg_seq=1707674313, nlmsg_pid=0}, "\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x1d\x00\x01\x00\x00\x00"], 40, 0, NULL, 0) = 40
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 784
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=764, nlmsg_type=0x10 /* NLMSG_??? */, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1707674313, nlmsg_pid=570}, "\x00\x00\x04\x03\x01\x00\x00\x00\x49\x00\x01\x00\x00\x00\x00\x00\x07\x00\x03\x00\x6c\x6f\x00\x00\x08\x00\x0d\x00\xe8\x03\x00\x00"...], [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1707674313, nlmsg_pid=570}, 0]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 784
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
+++ exited with 0 +++

And then it's possible to apply your patch with Jakub's suggestion:

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4efd571a6a3f..dba13b31c58b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2188,25 +2188,22 @@ static int rtnl_valid_dump_ifinfo_req(const struct nlmsghdr *nlh,
 
 static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
+       const struct rtnl_link_ops *kind_ops = NULL;
        struct netlink_ext_ack *extack = cb->extack;
        const struct nlmsghdr *nlh = cb->nlh;
        struct net *net = sock_net(skb->sk);
-       struct net *tgt_net = net;
-       int h, s_h;
-       int idx = 0, s_idx;
-       struct net_device *dev;
-       struct hlist_head *head;
+       unsigned int flags = NLM_F_MULTI;
        struct nlattr *tb[IFLA_MAX+1];
+       struct {
+               unsigned long ifindex;
+       } *ctx = (void *)cb->ctx;
+       struct net *tgt_net = net;
        u32 ext_filter_mask = 0;
-       const struct rtnl_link_ops *kind_ops = NULL;
-       unsigned int flags = NLM_F_MULTI;
+       struct net_device *dev;
        int master_idx = 0;
        int netnsid = -1;
        int err, i;
 
-       s_h = cb->args[0];
-       s_idx = cb->args[1];
-
        err = rtnl_valid_dump_ifinfo_req(nlh, cb->strict_check, tb, extack);
        if (err < 0) {
                if (cb->strict_check)
@@ -2250,34 +2247,22 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
                flags |= NLM_F_DUMP_FILTERED;
 
 walk_entries:
-       for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-               idx = 0;
-               head = &tgt_net->dev_index_head[h];
-               hlist_for_each_entry(dev, head, index_hlist) {
-                       if (link_dump_filtered(dev, master_idx, kind_ops))
-                               goto cont;
-                       if (idx < s_idx)
-                               goto cont;
-                       err = rtnl_fill_ifinfo(skb, dev, net,
-                                              RTM_NEWLINK,
-                                              NETLINK_CB(cb->skb).portid,
-                                              nlh->nlmsg_seq, 0, flags,
-                                              ext_filter_mask, 0, NULL, 0,
-                                              netnsid, GFP_KERNEL);
-
-                       if (err < 0) {
-                               if (likely(skb->len))
-                                       err = skb->len;
-                               goto out;
-                       }
-cont:
-                       idx++;
+       err = 0;
+       for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
+               if (link_dump_filtered(dev, master_idx, kind_ops))
+                       continue;
+               err = rtnl_fill_ifinfo(skb, dev, net, RTM_NEWLINK,
+                                      NETLINK_CB(cb->skb).portid,
+                                      nlh->nlmsg_seq, 0, flags,
+                                      ext_filter_mask, 0, NULL, 0,
+                                      netnsid, GFP_KERNEL);
+
+               if (err < 0) {
+                       if (likely(skb->len))
+                               err = skb->len;
+                       break;
                }
        }
-
-out:
-       cb->args[1] = idx;
-       cb->args[0] = h;
        cb->seq = tgt_net->dev_base_seq;
        nl_dump_check_consistent(cb, nlmsg_hdr(skb));
        if (netnsid >= 0)

And it will not hang:

# strace -e sendto,recvmsg ip l
sendto(3, [{nlmsg_len=40, nlmsg_type=0x12 /* NLMSG_??? */, nlmsg_flags=NLM_F_REQUEST|0x300, nlmsg_seq=1707675119, nlmsg_pid=0}, "\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x1d\x00\x01\x00\x00\x00"], 40, 0, NULL, 0) = 40
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 784
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=764, nlmsg_type=0x10 /* NLMSG_??? */, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1707675119, nlmsg_pid=564}, "\x00\x00\x04\x03\x01\x00\x00\x00\x49\x00\x01\x00\x00\x00\x00\x00\x07\x00\x03\x00\x6c\x6f\x00\x00\x08\x00\x0d\x00\xe8\x03\x00\x00"...], [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1707675119, nlmsg_pid=564}, 0]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 784
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
+++ exited with 0 +++

