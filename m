Return-Path: <netdev+bounces-299857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BM/0IQ5SMWoEgwUAu9opvQ
	(envelope-from <netdev+bounces-299857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:39:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03629690016
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:39:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Z/m4mnvS";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299857-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299857-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0124305B299
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397331E83A;
	Tue, 16 Jun 2026 13:38:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762230AD05
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:38:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617117; cv=none; b=MPMmMi+2gmYS/thUtHgAcv6mylCJpC2MvTrKrpH1rRfXsb8pHDZanyxsO8RaTas5Qx6RQCo9g66GWIAnOd0ky5P7Xo9UtAwMmDBQMBpaNaw5veKGloJGGE2fbWBQjNKW8hcmgiEVjXloqVljZOV+rF8AszIpWtNj7sVu4ZoOCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617117; c=relaxed/simple;
	bh=qW7osbIRRAEMl/uce0SxNjK/WwUdEX1WtCXQLlH/bS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uaUXqGtAAaXViR0S2dgxlG5xO84rZl7n2o+8RNSlsQmBxjEmQT1/m7XMaWUHasRjeFVifbJGWh69MWJrUFa0cnBqTuFxeHPjG/0dTd/zSSg/izV3076xUPLl7rcfEauVTWUd0Vl+ov2qcRUiXs6R/szH9w3DY4qzd7YM1JmH9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/m4mnvS; arc=none smtp.client-ip=74.125.82.42
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1397ad67f5eso3324513c88.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781617115; x=1782221915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pj5yR2Fpwr4Odx8FAQY/JzEYdk1c+qdSCymB4T7A9U=;
        b=Z/m4mnvSjHN425dGDvYcLsrcBG/4Q4lLzYkTKBk9NN/vdAK/fvh/zn7Poj78ztUGHw
         cYbMZDXiGg22C0lmehDnsvBv9vtLWKnBeeWQ3CfMLh487XXgVjQkeG0k1nmkarOsFItM
         yq6SlBD7TRlqt+GVXmv+tu1QQf8at7TQflpEPXguETLRwp949UY3VAMDtDOlqg2/LCsQ
         4JkmEpaaamXRZNyLLpeaOG9rF2qdF0Hu8pOr7wyKIjuQf+WPhurfSL8nG944hm7dVHBR
         ebMQc0a8OhJJwagsg4WoplVos1rrXcSWRrzezyOM/sK07zqFfilOcnz+9M9W1gMfjVXV
         t4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617115; x=1782221915;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pj5yR2Fpwr4Odx8FAQY/JzEYdk1c+qdSCymB4T7A9U=;
        b=IrJ2LeHTnkstlaOkuzgm7pkCo+ktzPmDsov4kI0u4CPMZqNFwBt1vdK268O2EId9CM
         Yzu52wwkbd8CubYxV/88wao/+z7CohcR8FaHGhXHXKl4G4UhApeFlfd/ps1ga5wfYpUs
         PXx4AmqLIOP+2dOkYYKnJ67CYJj2X0V2qid/gLXig3VaaHVU2Tt1QxRd6OMZwpGcwLMA
         bpoa7b55IZjxuwYI7uJwmVR3n1SNn9L0w3Jq/OJw7J83PP71Gbw1dTmS+HDEH0K0OzSM
         ajoomVwuGNOVEn/3hQB/eLwcQvZaRT0LPpjFogMxm7YsS2DG/+Z/EMs3ibdeXrhcxPXj
         M+jw==
X-Gm-Message-State: AOJu0YzW3WgE5eDKLOXgPYANqZ/swX9GrtFzOjqnTZRNdTnATaTmyy/l
	WkpDsIbhWOVHINhfws9NL7AMXg3NaQsaRLQ/UOtXtVCTor3ZYIXK5yJMraZx9tVXH2w=
X-Gm-Gg: Acq92OE6g5WTiWw7gZbF75EHBkoaMLbpd6qP0k9f0BjvKshToYXB+C340dYAGa+0Tr/
	qtYAwNy7TXif4pcfnCwegQ4w4KvNABewm6rbxfCQbOmxYeEuO8Qa22iT5/ATz+fAp4Jd+j1FrNu
	gOPtx1QZHogxX28H5ptYMaV/0HiWxIZRoUhOWMUwVCz4MbC924chi4RGF6PkGGlCXShIvF4m2LO
	SssxhxeiWayoSk7H1iS7+JTgNdKqvQbHSOyOoMCuLLrYi2WnEa/5/WK72K2VEITCOCKddXQmHNb
	n/zv0zfT87DlA6TFrUL2cEyrlTqW4wsjP6nQnYD+RZtuZXq/JArXaxsdnbP3nq3hbJ7G+qd5teX
	cE3RDeDr8dVXXiORJQ8aOTCWVrf0HrfDCJbT4euUwA3SECwuYA4NbyP0XNZ9pnx4/V+Dnz2nJef
	FzgQEtRe2E5JZXNRPedL5mOBjnzzZ7CEOKbPiPVCm7kA3q
X-Received: by 2002:a05:7022:98e:b0:138:236a:c521 with SMTP id a92af1059eb24-13985e96053mr1878445c88.2.1781617115305;
        Tue, 16 Jun 2026 06:38:35 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm14169831c88.13.2026.06.16.06.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:38:34 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:38:29 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: [PATCH net v4 1/2] ipv4: account for fraggap on the paged allocation
 path
Message-ID: <ajFR1eLAIs42TN3g@DESKTOP-19IMU7U.localdomain>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299857-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DESKTOP-19IMU7U.localdomain:mid,vger.kernel.org:from_smtp,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03629690016

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
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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

