Return-Path: <netdev+bounces-294747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmHeI6QmIGpxxgAAu9opvQ
	(envelope-from <netdev+bounces-294747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB16637D83
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:05:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WG5oZTh9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294747-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294747-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3478630210D3
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DDF47A0A4;
	Wed,  3 Jun 2026 12:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253A3D3D05
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 12:58:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491490; cv=none; b=E94NJS97yhQmhokrvZjfjBevqAlNiIYNoTl4PCHtYTJgvMULXd8JnPFxajKLD/HddwDxM88wDhxi6TsI8xNYE8LfPPKfVAUaOxwHSLlWcHIN7uqqjn9zRdhxyj/weKuRnV72Fqvj82+m3tFFhCWU7ysXCuWdwqUb/4KyGIo8EKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491490; c=relaxed/simple;
	bh=IjCHpzFMPo3Zup2hVq6+6Sh9BeV/GN6/ak4tKcxbuq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGDbzFE67msclpv9/qHJoOxOGTkWGpX08MGE87AUwUxVMFa0nlZU4kI1Gj75aQxQXBPZ5DKRVK0Dj3UV/PCMvcGLzLqg8aycQVXu30rLU2miuLmSPjqNh+/GL+8NpWsPXxciB3kQT6BN6NSAffzsbocWQ+pfctQPyLBeUkzbpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG5oZTh9; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf30d530bdso52603185ad.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780491489; x=1781096289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvvkmvfezi6AGtrygCv68cidJW9SHBnZeWjAxPlqJXs=;
        b=WG5oZTh9MLLBsQLXi2HW3+LoCzPrAhymVQdslMmSPGndKLv/aD7arPEy6pFn/pwsjp
         9Dr5zqMyoMD3qO5WFsDKSxVvqxuMzTtK58QVc+vvwmBG8ntOoTIQRbfen/AKWZEW5o2E
         rbn7Kf/3NuXiM7qtOYlMH7NWi0HPwcuv6E8qqQAe4wmUNiWDdf2CTQK5sRPc0A/LATXA
         eb/coMiVa6khgEAmvXStyEu++Y9sojmEfAcSstdEzXIvdHAfPMzx0/NYypF3aA8hkEHR
         I0A2tgFb7u4kj5/PKrVDUR7CZExwUvhqOIlFq6rcbd+ul2iFBQ2ppzTOs767gk9bfWkI
         yQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491489; x=1781096289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvvkmvfezi6AGtrygCv68cidJW9SHBnZeWjAxPlqJXs=;
        b=ie8CdCR/7QbZQad+H/ZpgUTlSoJfYbn1ljaZfTFEsMnSUd9q35N/or89iWHZ0mSrOJ
         xBReL1x75WOikmP8DNnYJ2CmtXUGRKtVwh5NmDRgnfYCHEfSnY01/5O3j7TMsF5iIf4h
         PnVHkmqM9zy9EZH/R2BpCqKVu79jWbDiJ5nQT2djX5/04s53+PbypnFe+LTCC43a4TEK
         RhkNfmlg20FLOkeB2dyQr3hfq2975sPVnjG6qNNQg48zwLL7vZ5wJvJgZHQ8UTMi0P6Y
         RWGBS/ngT5Dp2SydlE5JBnHEkfUxK+bdYc96QqewSbKVf4GkOwJLKxFxWzqj2z4ul486
         mMhA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ze0GLpf+Fo4cXJsgssU45mt/hVPXw6Wof3OMkq9gUV4yxDEw6PEJ109thRTlYJ1NoLiPlaGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjxrQzBhUd1qvWRN5po28t27JaUbiUkxBohc78UlDhh965mjJ
	cahxa7pWS/Y4Vsy50ZZG0Jf8lZl43hucw7j/yGVt8K8LhZ+EPpRBph9t
X-Gm-Gg: Acq92OFGKiuogBpn4cBDmVITYDpuEVXtX3+Chb0tsLaD8ofWFq51YuuFPRoG+Q1TRLI
	IYQU/z5lf1nM/rJo+yncMosEQpQkjUEyrG3qlUqUuu+Z0OyH67aCCTCHv4QoS6jVxbD/fcum+Iy
	wG024fOGQfNLbjTZ7PH8j4vmD9Bb542N4V4KQgZbf2Wyt2rsvJwA4sTN6bLqTi8OmvfKe36RFJR
	BIvZmX0CPyswxaxXOnJrd+y5cCukh503vKFSVd8CfVqyTBggEcRdfsYI7yyUsnYIlgCZGV8fJOm
	Plt1RtdcUT0+j6q3oO6b0jf9o/l+rPL9cHMase+hnbJx/avvZSpjbcs9k40CdhWvzMuyJDO++9P
	Lc4RljRz3mdFKNJX17oSNjtaoIL7GRy8xuT3ktH3shFeJpLiXTSfiVS77W9hLZOZq8hYdUVtOk9
	B4wJ/B9c1d8LDIE+IKz2ZcMHVpqY7t2TFvVsYo+PpKFLZ+jHP6j/Rzrg==
X-Received: by 2002:a17:902:fc87:b0:2bf:379b:53d2 with SMTP id d9443c01a7336-2c163a59515mr33557685ad.15.1780491488420;
        Wed, 03 Jun 2026 05:58:08 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e61csm25197275ad.43.2026.06.03.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:58:05 -0700 (PDT)
Date: Wed, 3 Jun 2026 21:58:01 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: David Ahern <dsahern@kernel.org>, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, andrew+netdev@lunn.ch,
	kuniyu@google.com, jlayton@kernel.org, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] net: protect egress device access in the output
 path with rcu_read_lock
Message-ID: <aiAk2Q-yNs6It6g4@v4bel>
References: <ahveCu-zzFlpeVut@v4bel>
 <20260602154523.GA537996@shredder>
 <ad40bbe0-f79c-4fd9-9670-5dab01a8e57f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad40bbe0-f79c-4fd9-9670-5dab01a8e57f@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:imv4bel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,v4bel:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAB16637D83

On Tue, Jun 02, 2026 at 10:24:09AM -0600, David Ahern wrote:
> On 6/2/26 9:45 AM, Ido Schimmel wrote:
> > On Sun, May 31, 2026 at 04:06:50PM +0900, Hyunwoo Kim wrote:
> >>  drivers/net/vrf.c       | 16 +++++++++++-----
> >>  net/ipv4/ip_output.c    | 27 +++++++++++++++++++--------
> >>  net/ipv4/raw.c          |  4 +++-
> >>  net/ipv4/xfrm4_output.c | 13 +++++++++----
> >>  net/xfrm/xfrm_output.c  |  4 +++-
> >>  5 files changed, 45 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> >> index 46209917ae4d..e9a1dd961805 100644
> >> --- a/drivers/net/vrf.c
> >> +++ b/drivers/net/vrf.c
> >> @@ -833,17 +833,23 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
> >>  
> >>  static int vrf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
> >>  {
> >> -	struct net_device *dev = skb_dst(skb)->dev;
> >> +	struct net_device *dev;
> >> +	int ret;
> >> +
> >> +	rcu_read_lock();
> >> +	dev = skb_dst_dev_rcu(skb);
> >>  
> >>  	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
> >>  
> >>  	skb->dev = dev;
> >>  	skb->protocol = htons(ETH_P_IP);
> >>  
> >> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> >> -			    net, sk, skb, NULL, dev,
> >> -			    vrf_finish_output,
> >> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
> >> +	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> >> +			   net, sk, skb, NULL, dev,
> >> +			   vrf_finish_output,
> >> +			   !(IPCB(skb)->flags & IPSKB_REROUTED));
> >> +	rcu_read_unlock();
> >> +	return ret;
> >>  }
> > 
> > Patch LGTM, thanks, but what about the IPv6 counterpart (vrf_output6())

I left ipv6 out because its callers (ip6_send_skb, ip6_xmit, etc.)
already hold rcu. Though some niche paths may not. (maybe rxe_send?)

> > and the other similar existing issues that Sashiko is flagging?

I couldn't find Sashiko's review. Could you share a url?

> 
> Common locking at a higher level than dst->output seems like a better
> approach. This function is called under rcu_read_lock for some paths.

Adding rcu to ip_local_out would protect all functions reached via
dst_output in one place; raw_send_hdrinc and xfrm_output_resume still
need their own patches. What do you think of this diff?

As a follow-up, the rcu in ip_output etc. then becomes redundant and
should be removed.


Best regards,
Hyunwoo Kim

---

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5bcd73cbdb41..26b51ef0763f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -126,9 +126,11 @@ int ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	int err;

+	rcu_read_lock();
 	err = __ip_local_out(net, sk, skb);
 	if (likely(err == 1))
 		err = dst_output(net, sk, skb);
+	rcu_read_unlock();

 	return err;
 }
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 68e88cb3e55c..555e62eacdc6 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -410,9 +410,11 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 				skb_transport_header(skb))->type);
 	}

+	rcu_read_lock();
 	err = NF_HOOK(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
-		      net, sk, skb, NULL, rt->dst.dev,
+		      net, sk, skb, NULL, skb_dst_dev_rcu(skb),
 		      dst_output);
+	rcu_read_unlock();
 	if (err > 0)
 		err = net_xmit_errno(err);
 	if (err)
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index cc35c2fcbbe0..c5ac360da38d 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -594,6 +594,7 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
 {
 	struct net *net = xs_net(skb_dst(skb)->xfrm);

+	rcu_read_lock();
 	while (likely((err = xfrm_output_one(skb, err)) == 0)) {
 		nf_reset_ct(skb);

@@ -601,12 +602,14 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
 		if (unlikely(err != 1))
 			goto out;

-		if (!skb_dst(skb)->xfrm)
-			return dst_output(net, sk, skb);
+		if (!skb_dst(skb)->xfrm) {
+			err = dst_output(net, sk, skb);
+			goto out;
+		}

 		err = nf_hook(skb_dst(skb)->ops->family,
 			      NF_INET_POST_ROUTING, net, sk, skb,
-			      NULL, skb_dst(skb)->dev, xfrm_output2);
+			      NULL, skb_dst_dev_rcu(skb), xfrm_output2);
 		if (unlikely(err != 1))
 			goto out;
 	}
@@ -615,6 +618,7 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
 		err = 0;

 out:
+	rcu_read_unlock();
 	return err;
 }
 EXPORT_SYMBOL_GPL(xfrm_output_resume);

