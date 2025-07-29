Return-Path: <netdev+bounces-210841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28AAB150FD
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0DE3A987C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26EA2980A4;
	Tue, 29 Jul 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od+ws98a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057EB293C60
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805510; cv=none; b=nobT+vAsbOd/8vlfG8uxIBn464ryWsSgbA6tfn9Uml2DYntC82t5SWTKWGVuL1URTeVCSzBh/bip14vudafOy715woa2uGHF+0yA1dd+7ukVsn3ouddQNjllgIUnKPJnyzqofc3CCELK0S1EfTCBnDkyZ0ycAjsnccD+Na4tLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805510; c=relaxed/simple;
	bh=PX4fG9CcYQBzQMp8UxaZxWIRuN9i1/H8DTQW/uaGF6Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qERH9SotQ9TUcBIu7Et7AFq9W8aKbtO8tqdjpcYPyT4AUU6yeVjxS8q86eF9OyP8PffPG5xfD4Y6OQv9xAvEpCENmFY41o57xUelP5BO/7hCu+0aDvlaiiLBS7Q4ihO3Q+jt4xUUMgsO6PhD8DIGgyU5PIFtEi0Yll458ka15+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od+ws98a; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8e0762f77dso2542397276.1
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753805508; x=1754410308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgaverlvzE+bvKTwT3xAS5ujjtOXz2AUbC7iuyCzNwc=;
        b=Od+ws98alXQHka+uA+PCS8F4nD+JT3SbUHmRRvxewQLrsJFUhLidQTbpK9YfGETmTx
         Hj5xwbExMjMrfwy8i2klF8C6mxU3dZDVzjkVmqzbzGqmzx0fLC77QEf32qpOD9b+lZDs
         WG/dC+kBzjDsAi06usDwUDLFeaACLrmON9fY+qmV2OcgxoRbNlaLJgdomKXv+QR1fHfz
         QRrXVJcgtk03xm7Me94w2C4Gqwrut1t7Z+dqn1GoNCL+dWztQTFy/Ro8xkoHfJMOngP7
         4Vf08YvdbZuPJg8WdwlMXXsD0sGk/uLdBW9TWJontpdzmkNT785SNntR3cO+MnhEgrdj
         Pjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805508; x=1754410308;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EgaverlvzE+bvKTwT3xAS5ujjtOXz2AUbC7iuyCzNwc=;
        b=XjM/64xlY5hdDNjx+8LsSEwo7ZtCyuF2Ug+kOTYkoyxAXPhC9mA/0/tIOdj97N3jia
         ivWlpic8eXSYm+237bFovEqxiUUZIHXI6ztzjU+uHKAkPW51kKidly8nsnsrfELFq39A
         IrnTSnNsw1xzcBLyzBqR4Flmkb1AXu3NccpEYbik8lo7rEeRMPGXuc0mJZpOKxZgCpd4
         RrxDUYP0215rSajrkM6HdGEpA/msSGRd2zk9NXsVWYY2nFYV7BG6RdQwHugCMVppu4Yw
         IReLHmlQHfbpP3CIefGPuOWJtqeuOi9xGDnE42ab0+zqM8WbcIwoOSi5mw56ylK/yazw
         3+lA==
X-Forwarded-Encrypted: i=1; AJvYcCVgvb3YZgGSPVfKdPJ2fAtpjefttS1YTfNzmRmtmkROBKzIkOAlbkrYUNtpFW/NuayG4T5w8KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsSHaqMSSfNDTk481ypxMq9wPbPxexZtJyqqK6BR+mtIpr/1X
	chXO3QNW7lwPGNSL/CKZnKvVhai4Va1QuyPjf1mXM+Iu5ogQMUuOsmNP
X-Gm-Gg: ASbGncsTQy3Z9mhQoGVXvdGZ5PsMp76qSOMAolaMtdvJNImC1xD5oKYqLNLsHKc+jML
	/QHsk8YHDZUYpeFav4eMIWCMA+9reqviwJRRGYj/JQNX4NAgrvnBvwlZTLgWkdJjGz8Ndlw7mh5
	wKER9843L++I+G97Tkhugu22bT7xltgNYdFb9lC2hMTNi3+Emv+xRMeW+kDa29akBdsqkPLa5bF
	KDePLro2br2EyAk4ask82lnyAtDhTcFXAg0d+D8cxYozOOKsPzD0nGqvV3raa6EIGMgJRS4o2EI
	+b/Lna57h6RAgoH1bR7wKQTdrAuXsFUVo6zoo7Y80nDKp/J9AXHmRdgpNwtSBhPHj+NBOUphV6+
	7PlfS+0DRaCHUIXnDJNxIEDmhyGxTjRTgr3zLeZ1HQ+a5H+HBtDs6gFsiK8/5H6NSYwgFWg==
X-Google-Smtp-Source: AGHT+IFuadvkY5862XyWhcEezNjHKQgTNXvr9GSPr9tlvEoMKKaikXHJtVSgydPe5+Y/cnuB+rkh2w==
X-Received: by 2002:a05:6902:728:b0:e8e:1c02:c8f6 with SMTP id 3f1490d57ef6-e8e314d86fcmr292568276.1.1753805507303;
        Tue, 29 Jul 2025 09:11:47 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8df86c538csm2757074276.25.2025.07.29.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:11:46 -0700 (PDT)
Date: Tue, 29 Jul 2025 12:11:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org
Cc: quic_kapandey@quicinc.com, 
 quic_subashab@quicinc.com
Message-ID: <6888f2c11bd24_16648b29465@willemb.c.googlers.com.notmuch>
In-Reply-To: <b6beefcf-7525-4c70-9883-4ab8c8ba38ed@quicinc.com>
References: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
 <6888d4d07c92c_15cf79294cb@willemb.c.googlers.com.notmuch>
 <b6beefcf-7525-4c70-9883-4ab8c8ba38ed@quicinc.com>
Subject: Re: [PATCH v2] net: Add locking to protect skb->dev access in
 ip_output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sharath Chandra Vurukala wrote:
> =

> =

> On 7/29/2025 7:34 PM, Willem de Bruijn wrote:
> > Sharath Chandra Vurukala wrote:
> >> In ip_output() skb->dev is updated from the skb_dst(skb)->dev
> >> this can become invalid when the interface is unregistered and freed=
,
> >>
> >> Introduced new skb_dst_dev_rcu() function to be used instead of
> >> skb_dst_dev() within rcu_locks in outout.This will ensure that
> >> all the skb's associated with the dev being deregistered will
> >> be transnmitted out first, before freeing the dev.
> >>
> >> Multiple panic call stacks were observed when UL traffic was run
> >> in concurrency with device deregistration from different functions,
> >> pasting one sample for reference.
> >>
> >> [496733.627565][T13385] Call trace:
> >> [496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x=
24c/0x7f0
> >> [496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
> >> [496733.627595][T13385] ip_finish_output+0xa4/0xf4
> >> [496733.627605][T13385] ip_output+0x100/0x1a0
> >> [496733.627613][T13385] ip_send_skb+0x68/0x100
> >> [496733.627618][T13385] udp_send_skb+0x1c4/0x384
> >> [496733.627625][T13385] udp_sendmsg+0x7b0/0x898
> >> [496733.627631][T13385] inet_sendmsg+0x5c/0x7c
> >> [496733.627639][T13385] __sys_sendto+0x174/0x1e4
> >> [496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
> >> [496733.627653][T13385] invoke_syscall+0x58/0x11c
> >> [496733.627662][T13385] el0_svc_common+0x88/0xf4
> >> [496733.627669][T13385] do_el0_svc+0x2c/0xb0
> >> [496733.627676][T13385] el0_svc+0x2c/0xa4
> >> [496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
> >> [496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8
> >>
> >> Changes in v2:
> >> - Addressed review comments from Eric Dumazet
> >> - Used READ_ONCE() to prevent potential load/store tearing
> >> - Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_=
output
> >>
> >> Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
> >> ---
> >>  include/net/dst.h    | 12 ++++++++++++
> >>  net/ipv4/ip_output.c | 17 ++++++++++++-----
> >>  2 files changed, 24 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/net/dst.h b/include/net/dst.h
> >> index 00467c1b5093..692ebb1b3f42 100644
> >> --- a/include/net/dst.h
> >> +++ b/include/net/dst.h
> >> @@ -568,11 +568,23 @@ static inline struct net_device *dst_dev(const=
 struct dst_entry *dst)
> >>  	return READ_ONCE(dst->dev);
> >>  }
> >>  =

> >> +static inline struct net_device *dst_dev_rcu(const struct dst_entry=
 *dst)
> >> +{
> >> +	/* In the future, use rcu_dereference(dst->dev) */
> >> +	WARN_ON(!rcu_read_lock_held());
> > =

> > WARN_ON_ONCE or even DEBUG_NET_WARN_ON_ONCE
> > =

> That makes sense =E2=80=94 I will revise the code to use WARN_ON_ONCE()=
 accordingly.>> +	return READ_ONCE(dst->dev);
> >> +}
> >> +
> >>  static inline struct net_device *skb_dst_dev(const struct sk_buff *=
skb)
> >>  {
> >>  	return dst_dev(skb_dst(skb));
> >>  }
> >>  =

> >> +static inline struct net_device *skb_dst_dev_rcu(const struct sk_bu=
ff *skb)
> >> +{
> >> +	return dst_dev_rcu(skb_dst(skb));
> >> +}
> >> +
> >>  static inline struct net *skb_dst_dev_net(const struct sk_buff *skb=
)
> >>  {
> >>  	return dev_net(skb_dst_dev(skb));
> >> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> >> index 10a1d182fd84..d70d79b71897 100644
> >> --- a/net/ipv4/ip_output.c
> >> +++ b/net/ipv4/ip_output.c
> >> @@ -425,15 +425,22 @@ int ip_mc_output(struct net *net, struct sock =
*sk, struct sk_buff *skb)
> >>  =

> >>  int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb=
)
> >>  {
> >> -	struct net_device *dev =3D skb_dst_dev(skb), *indev =3D skb->dev;
> >> +	struct net_device *dev, *indev =3D skb->dev;
> >> +	int ret_val;
> >>  =

> >> +	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
> > =

> > Why introduce this?
> > =

> Apologies for the oversight. The branch I am currently working on is qu=
ite outdated, and this line originates from that earlier version.
> This line appears to have been unintentionally included during the prep=
aration of the patch for submission to net-next. Will correct this.>> +

Ack thanks.

> >> +	rcu_read_lock();

How do we know that all paths taken from here are safe to be run
inside an rcu readside critical section btw?

> >> +	dev =3D skb_dst_dev_rcu(skb);
> >>  	skb->dev =3D dev;
> >>  	skb->protocol =3D htons(ETH_P_IP);
> >>  =

> >> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> >> -			    net, sk, skb, indev, dev,
> >> -			    ip_finish_output,
> >> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
> >> +	ret_val =3D NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> >> +			       net, sk, skb, indev, dev,
> >> +				ip_finish_output,
> >> +				!(IPCB(skb)->flags & IPSKB_REROUTED));
> >> +	rcu_read_unlock();
> >> +	return ret_val;
> >>  }
> >>  EXPORT_SYMBOL(ip_output);
> >>  =

> > =

> > =

> =




