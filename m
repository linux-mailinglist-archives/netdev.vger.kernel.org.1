Return-Path: <netdev+bounces-306362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jTTeLWgAUGrIrgIAu9opvQ
	(envelope-from <netdev+bounces-306362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:11:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 249B3735443
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:11:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oJQGrk9C;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306362-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306362-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 028333024476
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5AA3B8BA4;
	Thu,  9 Jul 2026 20:11:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C982744F
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:11:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627877; cv=none; b=HW1UC+u6+GB66MlGJ+BepaMjKEueOYv972cb3QeTJ1AwtohlyhtJLIhIvBddO/c1iKJOYcxct/sVL+44nmUKuFNl70O1/po79kYee2ZMFkgeRq5o8XYVJPCJMUyFgkUvWJfox9FdibwXKff1ngL//tVDMqHS9INRgABO58MIQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627877; c=relaxed/simple;
	bh=4VRlIT3ZBlyJ4lDFsiB1qMzVSbBMDnfmen3AFlovMQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etYWkbw64nP/hba0gxb2z2GAFv8o3SbmcGsLt0WQ/OIreyDhmM9UvVXROz42XXdvnBOezCzFCKgSaoRmyH1M76n+oZD3gKaXfIiCm0Czyxwsq8FGrXy4XkSxP150u4MWZ+y2WDwXGeITdEPT7ns2+ClVA3la+8k5/c26Z7RfBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJQGrk9C; arc=none smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15d5468673so42852266b.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783627875; x=1784232675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yROAaYjafivesMnTmLgsnm47xYMDJuFO4ZbZMka+vDE=;
        b=oJQGrk9CWVLaFCLsiZ0uV6nVFSUAmJQW0QLImL9n8gQHD9UiSfrxfXUY5+m0GwIY2E
         nF6qmBNS3tvIW30ScpuUiCbgDLPIJcpKrLDcB7CjetAR0tWMRliQ9+18/9SWFxk7SRDq
         723d4JD3wT858Ly6av7rcWPmylQSGw4mHmX5aojlzx1yODB1vDvROmWAjAskpvFLq0+S
         y/FZ9T+2Vs6MsXVV9nFiTEXIjwqzEOf6WWOUKav7wt65lZIF56fHRMK0qLHvtyY1mRHi
         toCd3ANxa1dErysegLgkKz1s+hHCehe/J1NnRA9QHmvaQs3SVvaJPC2WCpIKe8wvxmMo
         FPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783627875; x=1784232675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yROAaYjafivesMnTmLgsnm47xYMDJuFO4ZbZMka+vDE=;
        b=ZTJPnfJjojZssvS1+OwevTdvns/icLCWWfT7Sy/4wDR2LtHXHYU8pGSCxAfEXcDqyh
         aKUEH8T/FjjoRfqdpfCcDRljY6cFc0VnZy4mhotqi6fYquvvTumvznWmJmX8loVyB/ei
         jcj235gcbHdSjSmlkL6TQGHLHHjM3d6fTXoOreqJp1NowpR4OVLuJbcmOLnzGTBLaiTL
         0WznuF327QL60dboHimMzGwGS/LhwRNhGa607RtMh3l01WeIAYutsvfhgl+nXHkY3RR0
         Hb8ytQS/EdUzWJ1am2vWN50ylohQVO6vjjfORLTj9qAy3UT0twmlzxnIKtHXeMPugK4j
         NkhA==
X-Gm-Message-State: AOJu0YxukAFd1Bf5y876vDe0p0XK2P/GbaAdKpaLvszClav94Ch1Ddk/
	T7mZFbqP6g48tzrWPyt3JS1nE3uQW6mM+7WcL56gSajViWouR4Xcyneu
X-Gm-Gg: AfdE7ck4oE0irtceqo6hV5tfOAlGzgvOyMVoG02rExJuK3SA/ra8bnqiN7nCV5/bXIy
	b8XkcM0MrSOBwBaoW/3E3paIYWV/yOGPBggalp95cIa/vJG8nqUn+EmbU3P4pEWUSm7p1yiZaFr
	BNkUnp+aiRzTMczWykwnoNkzmq0GDOSO8QO+l+D+FkK4ZMTZXp+PzBqb8jFLIK0MaW1yz4LYdZk
	6mgoNfMyTwG0KyJj9dT7omZFzxub2wLH+NyLKQwazWtskTWW+aQMhGcZFql00SfdlXEDbkxjdSD
	MfZM57A4HVK5Dyzgqe5lQ75X92q+XiDMCIfKwjVUBME8FkxP9Bfrr0ZO3LggMjvbm79kKxtyRyy
	nAhG9re8+3cfR/tlyFuUPHALgTu5MYKngpCiLMnQXsniP7FZlKv0Mrq1FL1THvwGBqoFvZuH6gV
	ORyLLlX/K9WxwYMq5W/a3mmP7NQFpVgmDmEC6W8fMjExdGE+IZ1KBxSGY8p3bdJH4U4Q==
X-Received: by 2002:a17:906:4fca:b0:c15:f704:4e05 with SMTP id a640c23a62f3a-c15f7044ea8mr74668766b.38.1783627874887;
        Thu, 09 Jul 2026 13:11:14 -0700 (PDT)
Received: from dau-home-pc ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d0c3cf1esm308319666b.44.2026.07.09.13.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:11:14 -0700 (PDT)
Date: Thu, 9 Jul 2026 23:11:10 +0300
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/2] udp: fix encapsulation packet resubmit
 in multicast deliver
Message-ID: <alAAXv60KUZ9KYx1@dau-home-pc>
References: <cover.1783372173.git.littlesmilingcloud@gmail.com>
 <5372ccac062193147e02b991d5328a5c3fa3a85a.1783372173.git.littlesmilingcloud@gmail.com>
 <willemdebruijn.kernel.2a3e532d3c28f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2a3e532d3c28f@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306362-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 249B3735443

On Wed, Jul 08, 2026 at 09:24:10PM -0400, Willem de Bruijn wrote:
> This helps the case of one encap_rcv socket in the multicast receiver
> group, so is a useful fix on its own.
> 
> But is Sashiko correct that this would still leave the same issue for
> other sockets in the group? If so, something to address in this series
> or leave for later?
> 
> Might be worthwhile to extend the test to capture that case too.

The clone loop is not reachable for encapsulation sockets, so there is
no remaining gap.

FOU/GUE tunnel sockets are created via udp_sock_create() /
setup_udp_tunnel_sock() and do not set SO_REUSEADDR or SO_REUSEPORT.
Without either, a UDP socket cannot share its port, so an encap socket
is always the only socket bound to its port. In
__udp[46]_lib_mcast_deliver() it is therefore always delivered as
'first', and the clone loop -- which handles the second and subsequent
sockets in the group -- never runs for it. The positive (resubmit)
return from udp_queue_rcv_skb() only happens for encap sockets; plain
UDP sockets return 0 or a negative value there. So the resubmit case
in the clone loop cannot occur.

For the same reason a selftest cannot exercise it: a second socket
cannot bind to the FOU port.

If useful, I can add a brief comment above the clone loop documenting
why no resubmit is needed there.


