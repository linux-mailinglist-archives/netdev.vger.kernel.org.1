Return-Path: <netdev+bounces-272382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKdFJocmxmnQGwUAu9opvQ
	(envelope-from <netdev+bounces-272382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:41:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196A733FEDF
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 066B5315585B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC338B7B3;
	Fri, 27 Mar 2026 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7bGfVKf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E93A7F73
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593185; cv=none; b=ObIfQweB+aZKxYTVvQ9NF+RgK9gJbXMJBb1oYTRTY5Qb6qMW561VmksCr4aladITB6lyITYlJllVbzeGU8H3SkhDo4AFDl2JsBdF/bWnErkmxT6tCSFTDZ1ZMykkoyBI3wWsGbx4lS2IijSmYio22CjnwWK5oee4ZTpfsXxCpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593185; c=relaxed/simple;
	bh=R+Wyx2quThKO6kdxp3NboLSs48m1AeEp3SSFm3vLIIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhFcPC1ItaUQKa6JcjYMtcXCUQ/YGNRjUbXKwA8XDL2AWpZDHVbbh+0bsHtl+WBu93vIUmrLIUVNLtOmPpzn7ixvEQXLLmSGnpUkAKarI/ew7pSDf5Noquc1GpdzZi4RVMpIPk+rKKfuH/YgkNBDYmzi+MwTTk1FQn68GLwe2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7bGfVKf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aecf52fa69so1985075ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774593173; x=1775197973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYhDafFa6ifxo2/1PziNZDy5gbmYZ4I4QcjogoZ5uUc=;
        b=L7bGfVKf5H6+UJk+J+qFOYg/U0GF6J2FQhf6p07IRZH3sJxY/URQScJ4FV1xVHI4wN
         Tum9VElXlV56xaVrQPhdJcuIqO5duuQYI7yYfkqIJv3QdI+cCjeVKeQoJTkLj01SYOfx
         g6JIl8eazA/Nu2tva0QeJmMug/UatZgSth4HPmdihe3GGRFFRjKuoMcz3lsXAUGLXdQF
         iOjYev1Srf0IbPh6/84P8luMgrDx79syDsCr0x1hvhxiD44iX5RPs7Wf1Qn4BhRazDzZ
         Gj2N20O3KtMIK+uyDvCTFN0HRKShEA7v+BNz0p3L7j3Ha9RakGMvNKZShepMGk/aP1Mq
         38EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593173; x=1775197973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYhDafFa6ifxo2/1PziNZDy5gbmYZ4I4QcjogoZ5uUc=;
        b=sbvyFyaEnBpnPgF6+cxF4EnF4etsld0/q2zi2cinWGwBJOmSedckQAZvu1CjaIBHz4
         DsdE6TlyC7DMmBNpG7z+laUtUO91Mab0PQS0tROeizUiJKAwWyMdQjxaPXz50dbRjF4t
         dYJLKmChUqcqMthKEUAxxu6GW7NO+tXwAhNXJn8lflgyzzo7NfHUa/pcxj1CIYNxJMrS
         OHI23IW9412sGAgKw7/87hYKnU9zep1wWETdd9JKQgwYuYpkRHhvEu6uHR/MiI30//c0
         xjoygf5IA7yzm2Z5ITe36jUziBUJGDoHd6nAirC1x6hJOkcFgwM8iUMc5y+FeMp5Z0vz
         zscg==
X-Forwarded-Encrypted: i=1; AJvYcCWqbZccNYew/sBSy3ytb91LgmrjN3AW5QVarc0kl7MmUrtDKjxLTHriV89DU8y0Dd/dae/cdRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCqt1sGAQsSDPU2rri07jU1LC/IDnkPgcPkXo5eHT2lboQEqs
	sbL9LZs2AUKEbQWr08luqvN5fs9fJk1MBokQ6xCoT8AJWPh9gimIyM/F
X-Gm-Gg: ATEYQzxfqHetrswMAihUzCVCgQQ2CBYv0lyQTnI+w8pmy7mbqmwYA40aDClY90s+BDA
	MOzn0ocBICiPjiuxQYhL8gywRig4UMlWK+bKNGAUBeZRKF84U72BxIjIaGX5IIRLRHEZtn/QfNc
	ubWVElgUq+9GAIP02f6k5Bta1GTPUb5I7OOJUfihT0IZxlfIenjK605t8ZpC7OoKgzz0Oqa3Lh+
	MRwwNeG5Y1eM7CQCIWa4wg2lG05Ti4OdaooFGHSUYbPVRgEsz0uCE/ZDjz/WxrZfwQhH57p0NYr
	I/iymll72Yp8qs+EJXEFAvdSMXHmzbEjLUZUz12I5vxo1a4rg85y9F/vVAurtSvdlKrcu09qONh
	BZM9nPS6hSyV5rotabFPiWFw3dGLKsp82NWqawKVp1ZgO9vGq8zf4n/rulCq8neV6FVEn02mL9W
	lFCOnjtFmdYTj+3vgWtB8OO3bcFLWcATFv
X-Received: by 2002:a05:6a00:2da3:b0:82a:68e4:da90 with SMTP id d2e1a72fcca58-82c95ee3d68mr849669b3a.4.1774593171986;
        Thu, 26 Mar 2026 23:32:51 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3bedeesm4498146b3a.42.2026.03.26.23.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:32:51 -0700 (PDT)
From: sunichi <sunyiqixm@gmail.com>
To: i.maximets@ovn.org
Cc: aconole@redhat.com,
	davem@davemloft.net,
	dev@openvswitch.org,
	echaudro@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sunyiqixm@gmail.com
Subject: Re: Re: [PATCH] net/openvswitch: fix trigger-able BUG_ON after ovs_vport_cmd_fill_info
Date: Fri, 27 Mar 2026 14:32:27 +0800
Message-Id: <20260327063227.2069909-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3813e7fb-e234-42ec-b05c-7bcb609de3ba@ovn.org>
References: <3813e7fb-e234-42ec-b05c-7bcb609de3ba@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272382-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,openvswitch.org,google.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[sunyiqixm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 196A733FEDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 1:01 PM, Ilya Maximets wrote:
> On 3/23/26 8:14 AM, sunichi wrote:
> > ovs_vport_set_upcall_portids() does not validate the length of the
> > user-supplied OVS_VPORT_ATTR_UPCALL_PID netlink attribute. A
> > sufficiently large portid list can overflow the reply skb allocated
> > with NLMSG_DEFAULT_SIZE in causing ovs_vport_cmd_fill_info()
> > to return -EMSGSIZE and triggering the unconditional BUG_ON(),
> > which panics the kernel on most distributions.
> > 
> > Any local user with CAP_NET_ADMIN (or an equivalent unprivileged
> > namespace capability where applicable) can exploit this to perform a
> > denial-of-service against the host.
> > 
> > Replace BUG_ON with WARN_ON_ONCE to prevent kernel panic.
> > 
> > Signed-off-by: sunichi <sunyiqixm@gmail.com>
> > ---
> >  net/openvswitch/datapath.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index e209099218b4..50c2945081a1 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -2202,7 +2202,8 @@ struct sk_buff *ovs_vport_cmd_build_info(struct vport *vport, struct net *net,
> >  
> >  	retval = ovs_vport_cmd_fill_info(vport, skb, net, portid, seq, 0, cmd,
> >  					 GFP_KERNEL);
> > -	BUG_ON(retval < 0);
> > +	if (WARN_ON_ONCE(retval < 0))
> > +		return ERR_PTR(-EMSGSIZE);
> 
> Hi, sunichi.  Thanks for the patch!  Though I don't think this is the right
> solution.  Instead of just failing the request, we should allocate appropriate
> amount of memory for it instead.  The fact that the array is sort of unbounded
> today is also a problem.
> 
> So, what I'd suggest is, let's limit the number of upcall pids for a vport with
> the number of CPUs as it is done for the upcall_pids array on the datapath level.
> This will give us some reasonable upper value as there is no point for the
> application to have more handlers than there are CPUs, and the existing userspace
> never does that, so the limit should be safe.  Next we can create a new function
> ovs_vport_cmd_msg_size() similar to the existing ovs_dp_cmd_msg_size() that would
> calculate and allocate the appropriate message size, so the allocation is always
> correct.

Thanks for the detailed review, Ilya!

Agreed on all points. For v2 patch submit later, would:
1. Add ovs_vport_cmd_msg_size() to calculate the correct allocation size upfront,
eliminating the EMSGSIZE path entirely.
2. Fix the memory leak on the error path.

> P.S.: This patch also needs a Fixes tag and should be targeted for the 'net'
> tree, i.e. have [PATCH net] as a subject prefix.  Also, IIRC, kernel requires
> a full name in the sign-off tag.
> 
> AI review also points out a memory leak in case we just return without freeing
> and potentially leaving half- or even fully configured port while returning an
> error to the userspace.
> 
> Best regards, Ilya Maximets.
> 

Respectfully, sunichi. 

