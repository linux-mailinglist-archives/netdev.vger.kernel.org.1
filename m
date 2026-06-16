Return-Path: <netdev+bounces-299859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V/LrIdNUMWrZgwUAu9opvQ
	(envelope-from <netdev+bounces-299859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:51:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA18D6901DC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:51:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Qdw1YpP7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299859-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299859-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AF9F307F278
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9533C182;
	Tue, 16 Jun 2026 13:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F52C3248
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:46:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617584; cv=none; b=nSBVimafMe4axFo8NmpT5CzvCZXSc3Iwg9gwNNYu8ydKB8fNdWCeynTVSA8VZolth+1DwaMLQxNlp2LyBFjSTxcxShqXqWByibo9CNM8U0U+c6o2I6PW/9NcyjsLMShzWRo1Xwi+2yoGZNLI/TrFskQzHozJkt25XMwGWCoPBJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617584; c=relaxed/simple;
	bh=IQKsrQJkAsqKFyit1PTpecA+eqpPAXjfHvgrSb1OhIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LZx68DT6gBkKNu0qZbUkS+wcLWVsRaujtP84i8ryDPPo94KitBQ9ObyLtwlXv2/3aPEvN46w62O+FW/viKrGF8yj8IzoKg6oF/b6VIdWuxWGrrRuPmGXMfW83Rs1Z0m9A++whEp5Vj7ny2b88zZlXjf/rO0u5tkLnE4NteOZ/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdw1YpP7; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f420455so2172115b3a.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781617583; x=1782222383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxrY8fVLohFGy2k8B6MypVKUNgyzg73dFvQO0sGxYic=;
        b=Qdw1YpP74Yh4Dd8aJLLripdDeygsTCoZXNLS6QvnDYumRqCrF0/7SVjoQR/0AY4uPl
         9f6fJlgRw9+R+S9jcpH/Ev+vPLmrhzIkd5Oy2gCj+ajLk84XMypR6uizplKszDL7ZDwu
         Q64A66YcZ1mC5HsI6J7yUrAXAPuiSncCLBvmhdc32A0AbQCc83HvBF+VeiIpEiHBypp/
         nd76aKkiGK/fibc3PsXHZW8mWIGTRZ0ps0RSQGLPJtgf6c09vekcgupENY+M1pfGDkZU
         hngMBqSxnJDeZeEMDwAIcIMFacIXMH7c+NYkSRpB/AR24vIMLlg4fkr3H4sSgMi1Vv+0
         d5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617583; x=1782222383;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxrY8fVLohFGy2k8B6MypVKUNgyzg73dFvQO0sGxYic=;
        b=gA52Kbj3xlvuKpkNUH6g55gY9vAEdlviDtkfZAmUPofNO+liKOTETtWljuqUrp3vWy
         EtPAxMyKQhOFSN/NTa4wBlVwj0Hh98BktPuFOwuK7/t9YJK7imr4Ors5byezVmkDbVFj
         I0EbhvCWGGtWq6PF1ccbBDYFARAE73MK7bZNfYfTiatN+ejJBMIV3gKnsY+xXl/mgv1Z
         KyLbPXklp9b6+D2Axj0rQo0YxZJCM2WShJy1lvTPWTWFd6+nZ5/Zmt48bmbc35kaYcLF
         YtGUn3qRvWlvAudRfnYMQZGMTkRlMDAyyhP0eV9XbnbE1IACQm4Bvag+NO7e5QkkzI6B
         TglA==
X-Gm-Message-State: AOJu0YxF5eO1IgkMbfpFMeKFIHpoi9RfjLFAI/3nBpp4BTxxL4uqsgM4
	DMuQkoKJI8VCn+nMSkemLwnHRTYz4dP4D8Ge5JUfqU33b3Wa+HlCj7MespB8pMdH1BY=
X-Gm-Gg: Acq92OEYm5dVZhVqMzGVnTQHIbs9PZvVg8bMKjWQPmvFGZYE+gKzdtn8DBcuE/pRtli
	j0Nd3EbpTtI3NDom8at9SKqc7TvOG3S4lyzU/I5BL00t0wE+WTZyB0Rv3j4GNGCIrfhXrUT9lJg
	C1alQ2RPgTMmp+dPZUIedwfAe9/efGlLoFTI1eiuzlryXC7ubc6za3vMBWaYfBCBUbVkxi4c6rD
	4N7SwaxwDFEQIUYs9CwqaMwTPp8NCakbgjMxZCDskcXc04Bjwg7Hri5JiJaMtfT1PTNuE7Bs9nV
	vj+5NdaJmk3KeI16ojCcNpY1A3srLvfdGGyCW1S0D7yzavokVeEgdGA3p5come4GvsV+Qzuelq2
	P1PX1qBGTxjRXHK3KElyJcenaKpiwVfnhBqPeY/pWB0RKDzBLjsA5nRwiID/HXMykOnl6+6m+n3
	xtw4zS5lsZFGeee10He/pJHdOEgQEbZW6tDyCxHRtNbSaT
X-Received: by 2002:a05:6a00:3491:b0:835:6bdf:c87f with SMTP id d2e1a72fcca58-844e1939be5mr16342024b3a.9.1781617582687;
        Tue, 16 Jun 2026 06:46:22 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-844e13bacc1sm10786587b3a.56.2026.06.16.06.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:46:21 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:46:17 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: [PATCH net v4 2/2] ipv6: account for fraggap on the paged allocation
 path
Message-ID: <ajFTqRljatR17fFy@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajFQn6yh43eDeQm9@DESKTOP-19IMU7U.localdomain>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299859-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:asml.silence@gmail.com,m:dhowells@redhat.com,m:willemb@google.com,m:jwlee2217@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,DESKTOP-19IMU7U.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA18D6901DC

In __ip6_append_data(), when the paged-allocation branch is taken
(MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
computed as

	alloclen = fragheaderlen + transhdrlen;
	pagedlen = datalen - transhdrlen;

datalen already includes fraggap (datalen = length + fraggap). When
fraggap is non-zero, this is not the first skb and transhdrlen is zero.
The fraggap bytes carried over from the previous skb are copied just past
the fragment headers in the new skb's linear area. The linear area is
therefore undersized by fraggap bytes while pagedlen is overstated by the
same amount, and the copy writes past skb->end into the trailing
skb_shared_info.

An unprivileged user can trigger this via a UDPv6 socket using
MSG_MORE together with MSG_SPLICE_PAGES.

The bad accounting was introduced by commit 773ba4fe9104 ("ipv6:
avoid partial copy for zc"). Before commit ce650a166335 ("udp6: Fix
__ip6_append_data()'s handling of MSG_SPLICE_PAGES"), the negative
copy value caused -EINVAL to be returned. That later commit allowed
MSG_SPLICE_PAGES to proceed in this case, making the corruption
triggerable.

The non-paged branch sets alloclen to fraglen, which already accounts
for fraggap because datalen does. Bring the paged branch in line by
adding fraggap to alloclen and subtracting it from pagedlen.

After this adjustment, copy no longer collapses to -fraggap on the
paged path, so remove the stale comment describing that old arithmetic.
Since a negative copy is no longer expected for a valid MSG_SPLICE_PAGES
case, remove the MSG_SPLICE_PAGES exception from the negative copy check.

Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")
Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/ip6_output.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c14adcdd4396..13463c95c7a7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1668,8 +1668,8 @@ static int __ip6_append_data(struct sock *sk,
 				  !(rt->dst.dev->features & NETIF_F_SG)))
 				alloclen = fraglen;
 			else {
-				alloclen = fragheaderlen + transhdrlen;
-				pagedlen = datalen - transhdrlen;
+				alloclen = fragheaderlen + transhdrlen + fraggap;
+				pagedlen = datalen - transhdrlen - fraggap;
 			}
 			alloclen += alloc_extra;
 
@@ -1684,10 +1684,7 @@ static int __ip6_append_data(struct sock *sk,
 			fraglen = datalen + fragheaderlen;
 
 			copy = datalen - transhdrlen - fraggap - pagedlen;
-			/* [!] NOTE: copy may be negative if pagedlen>0
-			 * because then the equation may reduces to -fraggap.
-			 */
-			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {
+			if (copy < 0) {
 				err = -EINVAL;
 				goto error;
 			}
-- 
2.34.1

