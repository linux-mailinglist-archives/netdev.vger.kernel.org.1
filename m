Return-Path: <netdev+bounces-261187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EQcMNjQn2l+eAQAu9opvQ
	(envelope-from <netdev+bounces-261187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:49:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D091A0E4D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2271B305E9B8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E338551E;
	Thu, 26 Feb 2026 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bC8602pr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="THc/X7P7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EB2C234A
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081365; cv=none; b=U1Naires2hzddvsFAZLbXTjaT248TuTlep7JbPGV33VyV3bTtuRcYUqKw4ak66y+tnhLcA8u4rvVb9vb3mrfj5gUOREaIltUfGjnZQLrzutA/kWyD/1pdNhmJDfdx940vOjQQBPKWxSvfl3Csi1cZxnFr0a30YqcTg+RCiiiZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081365; c=relaxed/simple;
	bh=H5qxSCBG01Q7pikuwlbHhR0uTwKCvOEAkKOc6vfLdTk=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=s9LpNsS4AJiijNbRgrhvxozMODBndtiYqO+ZZbz9Pw7OMDDjzwCl/pgJplma8d/Gj3Cgwo5wHSAM+Fiz6WY3kMo7kbURh+QdhtG3j3cASCU7eLduVq5owNGlPgrBMk1dCN98q4glK6vbxoY7yvrtY2JIm5jDdJRzSRwogOB9IvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bC8602pr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=THc/X7P7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772081362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/Q9Fe1CwGeENSBEoJzHP9jotxWoK79l4lySB/6YOl8=;
	b=bC8602prWQPxedamhD5H08S2U95QOMxpzDQk77MB/LnZMKxxMxx+yNM28EDLdQ32D2OJQg
	solsn/4p4jv+1NOl5lQzIrbLqB+JvbMVk3ZdhVgHHeeDZ0wZHUXl8sgrGqpluKjGo8rrjq
	Y6Ewf7BCduiLKcdl3GvpXzlkvezcQn8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-PyFr8DwkP6OzsoWl1Ry_9g-1; Wed, 25 Feb 2026 23:49:21 -0500
X-MC-Unique: PyFr8DwkP6OzsoWl1Ry_9g-1
X-Mimecast-MFC-AGG-ID: PyFr8DwkP6OzsoWl1Ry_9g_1772081360
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48379489438so5384475e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772081360; x=1772686160; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/Q9Fe1CwGeENSBEoJzHP9jotxWoK79l4lySB/6YOl8=;
        b=THc/X7P7QzfV/SdTgWJpVL87e9SptrME01bweuF9Gn1pEWLUcoGI9XURlHfKBrykHk
         xvJhWDI2SfqnbHbKXOUmp83DS/dXwXf2bzlA5j0H/Yy1DG/A2IsWz2/V6g9dJQ3eXSDP
         zLQmFoefMwKTQZ1V54FSloXvmCEX/wsBPkF9EmHpzmfpKlyFqMFj4tOd1S77c6TsFt4f
         kt16gTInFR78z5m+zm2TSlExuAAecgyEu9hpg0vyt0pdftm+hyVnMbHO1y3kN9nfmrn+
         6dX8P2K67ClfORZPYV7Kb8Y5hLxsEc9RvfqR83wrtmBzu4zzgAJ4g/XsjFomM13VRubv
         LXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772081360; x=1772686160;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/Q9Fe1CwGeENSBEoJzHP9jotxWoK79l4lySB/6YOl8=;
        b=exT6mL60ead0tUBU4sl1e+dUJoW9yArK5k4QBwgBOaP/6MpADye7xaNWBHNj4M9ENs
         hliufHWnHKd8/69KQBBCdei5KKmJQPyOX0ih7Vvz9/DDmouPXXxEemRGlan3zGWKlTzJ
         c37tISh/nbBaeQiKVLH4eXfQW39TQvmdxm8FgEoodgVe60A5XqC3hk68aWZv0FBllnAw
         oG6PE6hBUk4mYALDeuRswHwtfxPcOImW8fkUf2aEMHlUyvtPGCZNgDauV2vylNf22fDj
         HqLpLjxVqDpaudirhkdmNYNwv8sH2eYO/3pNygMP+jEh8C11qu4f/v2kkl263G/PlX65
         nnFA==
X-Forwarded-Encrypted: i=1; AJvYcCVhehhpzvju8mwBYeEriEBKYyExNJA3DiV9EcpCURYIqjQmHH0eTOCP1bx4WWCbgl24LJ42l0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAI9qo3VUrZTi6hVvGumbf/ClkXJN3CgQBpsUO8Pm2jOYA1ILo
	iIKMFinSPZHtalOIEXaC8MAfTBAkhkYyMqBG7bh8gXw01srRbO/QsEgOandXPa+7Bd5smPpLl3e
	D6zbFvyd2dYEuMygxQNgYuSvJopKBTo6i2/12Wp5e1AQF93W76zsOgMWObg==
X-Gm-Gg: ATEYQzzVJQlR7F9n3f7WEkAyqzaTEG4Q/GDBq9N6rEZDhGfRkCI4w68LLWzy5WN6Grs
	uqj7vl3esz3LZvOBRN7HZCxnzrZetY3834wIefaQLWcQGCp82kAAwC76xaf/+plxgeW6zE9nN/g
	hBWVh24KF+GrbH9DFaH6CACdCZL5qeOJWC3vF2liTHtJH9dOaHtWL9nlsfxcB9eXVj1YPLGpLVh
	buEPYFwm9dOM3Gcri8ICML28R+eTOyQHRhsPK6/9G8eER5Cdzcv/qzBTz9w+Rk/nwRTk5N7OP8i
	H3zuk4HCBRXGHYiP4mQlBtjNr/Yh2BerkHQSdBQnNlqqZF4qQM9GvgF0OqBigkTV2PBgL2mW/j3
	hufXITtWs/7q6nCUjRN6Y2n8CINAY9es7
X-Received: by 2002:a05:600c:4e93:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-483c3df874emr9572435e9.34.1772081359723;
        Wed, 25 Feb 2026 20:49:19 -0800 (PST)
X-Received: by 2002:a05:600c:4e93:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-483c3df874emr9572045e9.34.1772081359245;
        Wed, 25 Feb 2026 20:49:19 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b7713csm15418055e9.11.2026.02.25.20.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:49:18 -0800 (PST)
From: Stefano Brivio <sbrivio@redhat.com>
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, David Ahern
 <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, Jason Xing
 <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, Shuah Khan
 <shuah@kernel.org>, Christian Ebner <c.ebner@proxmox.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/4] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <20260226054915.55f95c7e@elisabeth>
In-Reply-To: <aZ-dgdUFe0a7F6YE@gandalf.schnuecks.de>
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
	<20260220-tcp_rfc7323_retract_wnd_rfc-v1-1-904942561479@gmail.com>
	<20260223232636.1ead2b3e@elisabeth>
	<aZ3o8RQehJDK_rcl@gandalf.schnuecks.de>
	<20260225223325.34468327@elisabeth>
	<aZ-dgdUFe0a7F6YE@gandalf.schnuecks.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Feb 2026 05:49:17 +0100 (CET)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	URIBL_RED(0.50)[passt.top:url];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_ANON_DOMAIN(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261187-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,proxmox.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.985];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68D091A0E4D
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 02:10:25 +0100
Simon Baatz <gmbnomis@gmail.com> wrote:

> On Wed, Feb 25, 2026 at 10:33:34PM +0100, Stefano Brivio wrote:
> > On Tue, 24 Feb 2026 19:07:45 +0100
> > Simon Baatz <gmbnomis@gmail.com> wrote:
> >   
> > > Hi Stefano,
> > > 
> > > On Mon, Feb 23, 2026 at 11:26:40PM +0100, Stefano Brivio wrote:  
> > > > Hi Simon,
> > > > 
> > > > It all makes sense to me at a quick look, I have just some nits and one
> > > > more substantial worry, below:
> > > > 
> > > > On Fri, 20 Feb 2026 00:55:14 +0100
> > > > Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > > >     
> > > > > From: Simon Baatz <gmbnomis@gmail.com>
> > > > > 
> > > > > By default, the Linux TCP implementation does not shrink the
> > > > > advertised window (RFC 7323 calls this "window retraction") with the
> > > > > following exceptions:
> > > > > 
> > > > > - When an incoming segment cannot be added due to the receive buffer
> > > > >   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
> > > > >   handling of extreme memory squeeze") a zero window will be
> > > > >   advertised in this case. It turns out that reaching the required
> > > > >   "memory pressure" is very easy when window scaling is in use. In the
> > > > >   simplest case, sending a sufficient number of segments smaller than
> > > > >   the scale factor to a receiver that does not read data is enough.
> > > > > 
> > > > >   Since commit 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks") this
> > > > >   happens much earlier than before, leading to regressions (the test
> > > > >   suite of the Valkey project does not pass because of a TCP
> > > > >   connection that is no longer bi-directional).    
> > > > 
> > > > Ouch. By the way, that same commit helped us unveil an issue (at least
> > > > in the sense of RFC 9293, 3.8.6) we fixed in passt:
> > > > 
> > > >   https://passt.top/passt/commit/?id=8d2f8c4d0fb58d6b2011e614bc7d7ff9dab406b3    
> > > 
> > > This looks concerning: It seems as if just filling the advertised
> > > window triggered the out of memory condition(?).  
> > 
> > Right, even if it's not so much a general "out of memory" condition:
> > it's just that the socket might simply refuse to queue more data at
> > that point (we run out of window space, rather than memory).
> > 
> > Together with commit e2142825c120 ("net: tcp: send zero-window ACK when
> > no memory"), we will even get zero-window updates in that case. Jon
> > raised the issue here:
> > 
> >   https://lore.kernel.org/r/20240406182107.261472-3-jmaloy@redhat.com/
> > 
> > but it was not really fixed. Anyway:  
> 
> Didn't that result in 8c670bdfa58e ("tcp: correct handling of extreme
> memory squeeze")?

Yes, but with that (the v3 of it) we still send zero-window updates
more frequently (because of the 'return 0' instead of 'goto out') and
together with e2142825c120 I was seeing in the captures one zero-window
update almost every time the sender filled up the window completely.

Perhaps it was even desired, I'm not sure, I can't say it's entirely
wrong (that's why I didn't propose a further patch), and strictly
speaking the issue was on passt side (we didn't send window probes in
that case, and we didn't retransmit FINs).

I guess with f017c1f768b things should be sane again. I didn't check.

-- 
Stefano


