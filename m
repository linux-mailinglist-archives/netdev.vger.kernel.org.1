Return-Path: <netdev+bounces-298144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cr9DNAC5KmorvwMAu9opvQ
	(envelope-from <netdev+bounces-298144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:32:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7C26725AA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nEepmE8m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298144-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298144-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 918843007BA5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD782EA754;
	Thu, 11 Jun 2026 13:32:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727EC40D57C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:32:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184766; cv=none; b=Z4dP/wT1HwO/6b+NBEDYAZGqBoYCCHymmmjkwj8md6x2BZjCZ07YCKhqRXzZFQ77TKNOdqYPAXdOK+Iw4lc54/zdgKgbTzrxcBI+xnapIgHoib51AVDxT/2TNzyJ7iBypsLnz3heXhRq8isBXKjsSNHdLBJm0SGxLsbv46E55EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184766; c=relaxed/simple;
	bh=zSqtwwcnipS47ZLUT/sGBWRXUR0qGCSVnnz+38LgQgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mFH+j0z4N8W0GhLDssylQUFcF0A0Y2UnQGn1A4D9aTmxqBz0dk9cJezS4wT+xma2aOclX+07AMS7ugVD+qU5vWEY0vTmmX4VyDNkt2AsO42Z7sM1C1C7ZSE/uwwb89sZxyHmX8OlAH9MhNBBK3R3VBcLgH9x5AgQ3jaNQTtGE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEepmE8m; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2247e38eso80876405ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781184765; x=1781789565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOPM/5bug94aarA6WFjCC00WG2G7FCnR1OR2KHOKmLE=;
        b=nEepmE8mp6teAAu/kCrLtV35Kx/yNf+l668u1n+865+cRr5wE7b2dLUBeKt15EQ+ky
         S69NX6CNmW13VbZUPluYAAP43dpZMvH/AYoqfxdU9qVtbjuwC1gt1ME9NxP4GbCr49oE
         ciONWjwqpjlUWW5uxk9XQT92adbJNaEf6CGbEU5av+xarq5upewxYSlfS4JrnsbiYz9r
         Hn/jl7sCaxl2UdBHxcoxxYrts+r80qQ8GCeKKcRUj+gRVgmMZKOe0gioT3B1xZbRpN9A
         Z6dYEZjfVMxbrt+dgg7HYaBolFdc1nB+GoKY7nAJvU9cwqHQyQF9yZtS8i4dXOhj6c20
         RzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781184765; x=1781789565;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOPM/5bug94aarA6WFjCC00WG2G7FCnR1OR2KHOKmLE=;
        b=lg7N0iPjj129D7OcMhMa5aGt38lsqri9tWjhVqj8AIqJUx9lkxjd4qXClcF4orCeTw
         7udUy44/4aCwNCl0dzjzo5QWd/iKFjq0ZB/CSeiFq5NeicNRmU5poS6i1cBIfEOxZFT4
         28sCy3CqIw7ZYljtx9nfKoxrRnBsDG+WG78Y+PWZhOhRDJwA5dgPpDgdpz6l0R94JsS3
         ioyIrvwcvjcFO+7XXFW6+cYKG8dw6Z30l/Y6tv9EdodzQ1366cuYGaa/6bgg/y7s3Orp
         oG7Rl+PqUHBKfkRmaEliszHybSXbP0pP0HnZPqxfralT1c4mWKH7LjAHQaXLG6M9bSjb
         xIEw==
X-Gm-Message-State: AOJu0Yw3VvjKsuthA5gd1k0RxDRY+fRgiZdCjrbsvbTZrZhbcvriVoKL
	vT3Qxj03aG3iJ06/LShNfOAaJbJBxMFMzIx5Zdmy99nEMnjJislAkFQSCVX9JzjaDgM=
X-Gm-Gg: Acq92OEPH/1niSWPSqqBsyfApbIKkTx9uc6PRLkTTHDHOfVx5C/TID4Py1ucbneXxLY
	vGTh2Xpi13MqbA5QOT4NsrphoRDy2UFS3ep2hjXDYMJH5wb+b04gV0XpUVWllKsWuHtLaI3znih
	5zlVsIo99XZ+SX3STQne6JO8URrnB7U9cun4+JkzXJQdSP+eI8ZVPoPNgADwto8O90bmXT6dnVj
	aCRj53QfWIBBWbOs8C0A77CvxEPHNrLRenk0Ud4YZ3NkyFoewYTJt4wMfuPFWD0Gsh9HKbE58A+
	Wtwqvt+vna6QmOP0NT3An+fw8WixlIOkS3ioYLmJJ23coql2r8+JvcHVpTc0i6bjRWJqURr4BP+
	6y+rbDO1LYTARKNr7A/fqV6Wd5pYTnf9UaAfy60xMphA0g8OhuW5bT92KOakbkdLFds/eW6+lgu
	Gec2ZIfH9qzYyA+CyBI/WXLjeqg2cJIcXsD5LHdaBuWelzOTgEjfkYgLIsMUsqAFYf4Q==
X-Received: by 2002:a17:902:e5c7:b0:2c0:bb2d:a314 with SMTP id d9443c01a7336-2c2f23a5721mr32607275ad.28.1781184764713;
        Thu, 11 Jun 2026 06:32:44 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d318sm296582495ad.15.2026.06.11.06.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:32:44 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:32:39 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: [PATCH net v3 1/2] ipv4: account for fraggap on the paged allocation
 path
Message-ID: <aiq491nYg2Qf/f1N@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298144-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,DESKTOP-19IMU7U.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B7C26725AA

In __ip_append_data(), when the paged-allocation branch is taken,
alloclen and pagedlen are computed as

	alloclen = fragheaderlen + transhdrlen;
	pagedlen = datalen - transhdrlen;

datalen already includes fraggap, but the fraggap bytes carried over
from the previous skb are copied into the new skb's linear area at
offset transhdrlen by the subsequent skb_copy_and_csum_bits(). The
linear area is therefore undersized by fraggap bytes while pagedlen is
overstated by the same amount.

The non-paged branch sets alloclen to fraglen, which already accounts
for fraggap because datalen does. Bring the paged branch in line by
adding fraggap to alloclen and subtracting it from pagedlen.

After this adjustment, copy no longer collapses to -fraggap on the
paged path, so remove the stale comment describing that old arithmetic.

Fixes: 8eb77cc73977 ("ipv4: avoid partial copy for zc")
Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
---
 net/ipv4/ip_output.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5bcd73cbdb41..ec790bad1679 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1117,8 +1117,8 @@ static int __ip_append_data(struct sock *sk,
 				  !(rt->dst.dev->features & NETIF_F_SG)))
 				alloclen = fraglen;
 			else {
-				alloclen = fragheaderlen + transhdrlen;
-				pagedlen = datalen - transhdrlen;
+				alloclen = fragheaderlen + transhdrlen + fraggap;
+				pagedlen = datalen - transhdrlen - fraggap;
 			}
 
 			alloclen += alloc_extra;
@@ -1165,9 +1165,6 @@ static int __ip_append_data(struct sock *sk,
 			}
 
 			copy = datalen - transhdrlen - fraggap - pagedlen;
-			/* [!] NOTE: copy will be negative if pagedlen>0
-			 * because then the equation reduces to -fraggap.
-			 */
 			if (copy > 0 &&
 			    INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
 					    from, data + transhdrlen, offset,
-- 
2.34.1

