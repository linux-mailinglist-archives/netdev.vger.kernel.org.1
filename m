Return-Path: <netdev+bounces-278789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPt5JBee32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:17:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB2E405330
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C6C30182A7
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8963D3322;
	Wed, 15 Apr 2026 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="dKWI/Bw3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740573CF687
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262458; cv=none; b=KQGeSL10le+87jVmqFrLwmUyPP39FlEbO2Eu38t306emolseHgDUEfdaFYDZPn2X97nYLmLsNtIpgbEX4Xu0Z30dHyq2L31PQrTAJWEc0TgtBRkh/FmQ3uPZ0lzFZcTIGHGjJmTuT+qxpsa6MeBX50CyTjBfl6t1nPccRZUnv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262458; c=relaxed/simple;
	bh=JzOWqrjgdztuRaIpWNeh9LgW1z6VvOKtwb4Ivz1HjjU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=p1ZW5KukOXezg9Tjw3evseQOq3UQiOHtc6xOf/x84lJer2GDznphRm3xHAjZU+mWfoI0uzqYb4fn3SDh+Y+vwX8w/PbmZAGf1d78JbAzxar50ktypr6x8ke8tr1u5S7TaYsiGxQQnA8xTaKmoVyZinLYlK7nZqK/fUMM7CZolrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=dKWI/Bw3; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c565dd3a7so1051771c88.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776262455; x=1776867255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzOWqrjgdztuRaIpWNeh9LgW1z6VvOKtwb4Ivz1HjjU=;
        b=dKWI/Bw3M3nMdxguTR6KYi/hZTqlBODmMX20k5Hk717DNtjROn2aDsS6M7fE1QBL2E
         Z8QhhQQ8R65vREK+lYjJdnYxJsQKqPVMwD/b+M6R54jNLDEMbyYyLVBcXIFdKw4CaFE2
         flpEMg0wQ6fplhrOAL+SeuJ86e/WgRGV3kseO5wOaGPQCsy7umDzpOT5I6m2kCcMn3Tx
         m2e5jCLHtCb6kNxXkjyIAFGyjLxPy3Aioskox/T7sFXbV5oLLloCkiSX8cD7S7d+rmW9
         x1xNOd8B0Q+jm1xBtLy4UdSC3OjCbU1ZtBGUcy0y9hwF8CSW0YsrYlj01wr+IYRfzWYJ
         bxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776262455; x=1776867255;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzOWqrjgdztuRaIpWNeh9LgW1z6VvOKtwb4Ivz1HjjU=;
        b=jCuSzqo5W3Qc6sRhQ1zNmMKKunIaaEuS4mX/c7jWgkEKFD1eLCyGWzj7olfE25o1ws
         97OKpHi0ttKZPnCHB09GbQZl4mTA8OZWs0tFgG+XifJf0ytKrHrIvKGO0erx1JVutK9a
         D/U21hXbNtsZqdR26T70VyNYbaZ2//Muk/oa5NcPJd8GvOfykkN9gVizUBF14n3kQBSY
         5H21PKgX/iUH117gA5mdyvcZW/L2kqRfIMnPNzKVfDaxwsfSCdcLsPQUppRZVpAWQc7U
         RzBeB13LKWOeZ61k3PtKT5ACW4itHmj9VjqgUTpSQQBM0lvbe4l8+h52rYnlnJFVux+0
         37aA==
X-Gm-Message-State: AOJu0Yzqb7fODQ5Hm2JYqqRQVNRLuxP1f2nLZDKGeYbcSyXkZ0aME4p4
	IJlw8f+fDCAxa95K2BBiCZLnIbNeyZpVQjf9tJGS1+3TKRIDlWtxrnNhsazfsUqEVKvFStVuuHB
	6ZVYp
X-Gm-Gg: AeBDieun6TCy86F6wyEzol999O6Omw6coSYuo1TX3ixpwYdjEbAL+Te7WjLiJsYr5K7
	lrJCDcIjpR6z2W0QS0l/QipEcXMhcMkUDK5ZHEe/3ZbmXt0HzwLu6Ek7IlKRNqcJ5FDJU0nQUcu
	CgMkkYDH8fLKmzojkNwI8R+r71ThtW+6pu8zL/sNNzx4NixQSy47zghOHRqFa4vZGuGcVJmGveO
	ECUKJPMvDxQwM/nGzhFMBea3nPKNC/DkJ09XNqPqFw8WGtNNiNfpi+NwnevQbXpHTU6RV2lWJlc
	xsVZgkv0hoQdPt6VV+CZvAIjrPOe/qZLIiMdqc86su2LWm+09HNYoDZY/sj+3xl6EZye/DFSgfM
	gCjUYGMDJBUjcfZK+ErmtZjhuk39tHPMY4vsRIEeHnDkHkUpt+X4qLJSECEipMiLcNeWSWp/kWP
	TUwTrUs70oY1znhME9BICOw9hwU1yE5IOX/gm4l3OMmlVXAw==
X-Received: by 2002:a05:7300:8c14:b0:2c4:ec89:bd3 with SMTP id 5a478bee46e88-2d5898aa893mr12146168eec.24.1776262455291;
        Wed, 15 Apr 2026 07:14:15 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c90cd7esm3417103eec.13.2026.04.15.07.14.14
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:14:15 -0700 (PDT)
Date: Wed, 15 Apr 2026 07:14:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: TCP default settings (bugzilla)
Message-ID: <20260415071409.5f7d4d1e@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-278789-lists,netdev=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AB2E405330
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A pair of TCP configuration related bug reports just showed up in bugzilla.
Getting the right time values here seems like a trade off between fast
failover and not dropping crappy connections.

Given how well formatted the buts are they look AI generated.

https://bugzilla.kernel.org/show_bug.cgi?id=3D221366

The default value of net.ipv4.tcp_retries2 (15 retries, resulting in
~924 seconds / ~15.4 minutes before TCP abandons a dead connection) is
far too high for modern data center environments. When a remote host
becomes unreachable (server crash, failover, network partition),
applications are stuck for up to 16 minutes before receiving an error
and taking recovery action. This causes cascading failures, connection
pool exhaustion, and prolonged service outages.

https://bugzilla.kernel.org/show_bug.cgi?id=3D221365

The default value of net.ipv4.tcp_keepalive_time (7200 seconds / 2
hours) is incompatible with virtually all modern network
infrastructure, causing silent connection failures. Intermediate
stateful devices (load balancers, firewalls, NAT gateways) routinely
expire idle TCP connections after 300-1800 seconds =E2=80=94 long before the
first keepalive probe is ever sent.

