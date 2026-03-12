Return-Path: <netdev+bounces-267024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O8oIf+fsmkOOQAAu9opvQ
	(envelope-from <netdev+bounces-267024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:14:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5D270B42
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CC23300B8FC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5EB39D6E5;
	Thu, 12 Mar 2026 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="id1Z/3dT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdI7izUU"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04639BFFA;
	Thu, 12 Mar 2026 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314040; cv=none; b=QFL2obtDTxZGDvVMNqEm5D6GUxLSKI6dyRkhbKnoTsI6eJI8zYTpApwEVUllYzEBwl+ao/E2Ry07FbUZlYA5i/cOqiAa0Dtqz+2+KOVeyt483Ja0AoFhFV+Hwwdy9ZD3eEBmFJ09+Uc41HyybvOjl9P2czCRl3blEvNjnqVS76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314040; c=relaxed/simple;
	bh=0XdpQrXhtnWbL+mwUEXr2gN7/lR78+TTds+tdxJxm3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLScXoN1CEqTsl1kNIeny6/b7tlrZMOuhfgTuCe3MYwC+LFNu5W+RDTeI2U+GC8tVNgvm5nbKTkFn9ENA+PmZsBTKT7NgOQHEc24MCU2q6vEu4uBVhLUQiCycsjB311mUHPEqcTyVWDerjj7DL4ycEWftlzTeu8Dgz/Gf6TvDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=id1Z/3dT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdI7izUU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E06721400269;
	Thu, 12 Mar 2026 07:13:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 12 Mar 2026 07:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773314035; x=
	1773400435; bh=ILkp3krwCY9KceXPRK4lYO0lmYmanAidcUSQL9jXG7U=; b=i
	d1Z/3dTqWMGyau8nmqmsftQJZDVXI7t63cG6Z9sSUCqJVSIBp24HZN9FlfnppTA/
	Deh0R7w/ABjjJ7XFxa85y1Nj1un1qOCItNLkIW4W1PivZztwBun5rw0OEKYhh1x/
	03Lcy0NlcUVVMIFYtF5oH46B+dNchQvKHKSKjq8Z4/TQ9A+0g+Hyid8XM+7P3Ulo
	gG/g3Lemkvo5RkbWnK72KO+Ll2r6b8Za+W6QM1orLSYJHgkLMYRPPlqVlMCp4gi0
	blZiCLrWqJvniyMOPI8rO841l4XJQe/+NpfyJ2PJI9vIZ0ivK0imtrOCnmy/0MIt
	yeBFZsnNeO5l9VhkJVHJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773314035; x=1773400435; bh=ILkp3krwCY9KceXPRK4lYO0lmYmanAidcUS
	QL9jXG7U=; b=HdI7izUUduXL6/7i3635HLgpPKhN26c7qgpfxf1SlxjLAuKHjS1
	mq2fSL85jAjSVXg0W4h5Zx0w75IX3MQl6OxchzIVz6XcsxE6buWaEjPZ2tlWjbxq
	qizRiINI1Pib7pY99H7zOORWnbWoNGz7oG/WRUPJU3e8TjGtUhSXtLf+YtEjJRqg
	fuKeFXnorNtpQPv4o0h9G7ucALFjGEjGLoKYoQn42eYo44kYPBz5l7DOQVg9ABoA
	WSxKNlb6bmWAJ96vcoZ+fNMHx9BTnlOaQOcw9mqD05i8Mn7HSXRBHvOOjqEUlcbh
	h5kSA3FAp0zydzGFad2anhonERiOGO0gtvQ==
X-ME-Sender: <xms:8p-yaZIJJ1K7KEtlbo6lPyFZfiULC3MuTDyhOkKzO-viOp0ftkEQAA>
    <xme:8p-yaWjW6t2u-mSPMEMnWXUzHZLlVeZA_KJKjVFVnh87aGSw3JjcmebOTnPEpUrwu
    NWFBFyBAx2QdgXoge2wRCIIU_R_gphA17YSHl_GLwpHRR3e55w5Yho>
X-ME-Received: <xmr:8p-yaa95Ne0-fZ39-nY5gRAHRe4_Bo2L_ai-RdCzoim0-0cczE4NsObasjy9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepteffveefhfeuieekjeegiefftedufeevgfduueejveehudeuhfehfeet
    ieekfeetnecuffhomhgrihhnpehlihhnuhigrdguvghvnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhn
    vghtpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhuhhgrnhhgsghi
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehshiiisghothdotghitdelkehfrgejtg
    dujeelhegvtggvrggtsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
    pdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepsghrihgugh
    gvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgu
    ohhstghhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:8p-yaSrAYv7m8WytVD9YXVJfQaRRG11l3LhEpuOcWLyfzgfjm7Jgug>
    <xmx:8p-yaXOXD7GzBDRPe19zAtgLfXFeYo0bZbJ_JnBJyWBQHXUchVY5lg>
    <xmx:8p-yaY4rnNJd1e5whNllIoLjLEQk5IdDdjEhTFnZ6K1alrghU-KSPg>
    <xmx:8p-yabVxd_hP_tGifezo462NUvpAutdA-6frR4pLfp_PQITn-fLZZg>
    <xmx:85-yaT7UUdllFlfKkwP3vKZ2eDD4Ca1xhk0FhQ-SnePGxKZ-PyS8bRgu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 07:13:53 -0400 (EDT)
Date: Thu, 12 Mar 2026 12:13:52 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
	andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
	jiri@resnulli.us, jv@jvosburgh.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	razor@blackwall.org, sridhar.samudrala@intel.com,
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features
 to ndo_set_features
Message-ID: <abKf8Fg865Fhipwk@krikkit>
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com>
 <abBuLV3P6aTzUg3W@krikkit>
 <abC7rdjxv9ENw-tA@fedora>
 <abHcP3GTO29rfKML@krikkit>
 <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267024-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,lunn.ch,lists.linux.dev,davemloft.net,google.com,kernel.org,nvidia.com,resnulli.us,jvosburgh.net,vger.kernel.org,blackwall.org,intel.com,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ci098fa7c1795eceac];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88B5D270B42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-12, 10:40:43 +0100, Paolo Abeni wrote:
> On 3/11/26 10:18 PM, Sabrina Dubroca wrote:
> > 2026-03-11, 00:47:41 +0000, Hangbin Liu wrote:
> >> On Tue, Mar 10, 2026 at 08:17:01PM +0100, Sabrina Dubroca wrote:
> >>> 2026-03-10, 10:02:09 -0700, syzbot ci wrote:
> >>>> batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
> >>>> hsr_slave_0: entered promiscuous mode
> >>>> hsr_slave_1: entered promiscuous mode
> >>>> ------------[ cut here ]------------
> >>>> err == -EMSGSIZE
> >>>> WARNING: net/core/rtnetlink.c:4421 at rtmsg_ifinfo_build_skb+0x218/0x260, CPU#0: syz-executor/6496
> >>>
> >>> I'm not sure this one is caused by this series, but either way,
> >>
> >>
> >>  rtnetlink_event+0x1b7/0x270
> >>  notifier_call_chain+0x1be/0x400
> >>  netdev_change_features+0x95/0xe0
> >>  __netdev_upper_dev_link+0xb20/0xc80
> >>  netdev_upper_dev_link+0xb0/0x100
> >>
> >>
> >> This patch calls netdev_change_features() after __netdev_upper_dev_link(),
> >> Which trigger a NETDEV_FEAT_CHANGE notify and calls rtmsg_ifinfo_event()
> >> to fill the new link info. Maybe the event is a bit early and macsec has
> >> data not ready?
> > 
> > But this would still mean that there's a mismatch between
> > if_nlmsg_size() and rtnl_fill_ifinfo(), and your patch is only
> > revealing it.
> > 
> > I'll send fixes for the stuff I mentioned, no idea if that's what
> > syzbot saw since we don't have a repro.
> 
> It looks like even the nipa CI is reproducing the issue, i.e.:
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/554921/17-rtnetlink-sh/
> 
> more failures here:
> 
> https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-12--06-00&pw-n=0&pass=0
> 
> the fail in mascsec-offload looks quite deterministic, could you please
> have a look?

Ah crap, sorry Hangbin, you were right.  macsec_fill_info() returns
-EMSGSIZE when the key length is unexpected, and at this point we
haven't set it to its proper value yet.

Bandaid solution would be:

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..0f7ef7bfbdde 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4337,7 +4337,7 @@ static int macsec_fill_info(struct sk_buff *skb,
                csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 : MACSEC_CIPHER_ID_GCM_AES_256;
                break;
        default:
-               goto nla_put_failure;
+               return 0;
        }
 
        if (nla_put_sci(skb, IFLA_MACSEC_SCI, secy->sci,


Proper fix (so that the notification we're sending during
upper_dev_link has full linkinfo) would be to move
netdev_upper_dev_link() to after macsec_changelink_common() and fix up
the error handling. I don't see anything in macsec_add_dev or
macsec_changelink_common that needs the device to be linked. But
anyway it doesn't make sense for macsec_fill_info to return -EMSGSIZE
on invalid data, so the "bandaid" should be included as well.

Should this be part of this series (either just the "bandaid" or the
"proper fix"+bandaid), since we never saw a problem before?

-- 
Sabrina

