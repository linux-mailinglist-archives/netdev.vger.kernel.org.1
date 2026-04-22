Return-Path: <netdev+bounces-280496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H+eDPf26GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:27:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1481448A33
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83FEA30227F0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1EA2E62A9;
	Wed, 22 Apr 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="IU4+rDeU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA735295C
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874867; cv=none; b=B5qIn1WnjMAngEeAbA0L85JNt8sV62loEtBgnZDmTMUTdaDUU3rdqPoDN28ER5U0c3sHozzjZOCKLdtBtjf6KPS3n8wUPENxQXG6uaDIVvoH8BRQnvxmjQ5yQW6rzbsA7+QUnCZQ2VzARS3gB1hgkBStJ9bzWF9zjaBpSbDObTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874867; c=relaxed/simple;
	bh=2vOCaghTB04DOGLCW3Jo0NNSWAf+IfdGN8S1H1sYy1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFA1gDx8r7odKqCU1MNDI3my3SWAX2229L6Q19HSTzIV357upS8JUXfp0XQpJfnDuMJdRxJtdzpyMSFhsJzrn4UCxMUDDatqVonyLn8zo526mC5eCglVb2K7EogyqMVppGb/4ZfNBrBt0gOUC8X/oOEyufujpglXe+12T5uGF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=IU4+rDeU; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479fc1fc048so994063b6e.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776874864; x=1777479664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk20s6q0mQczBiHCPHHRevnIyEhlrBrSTHUSrQHOrNY=;
        b=IU4+rDeUGYy8GOiVQuMyg+Il4uTudXR/jzdzSPs0JDiBNw/zVyTJsvHkwYZKq3Uvry
         JW2MtwLjKLuB+DvBhRkis797bXAhL/zfZUql4INt2cHelQ0Y45TIyvU/DGqsJgdxijOL
         oV+RHmaDx3c+QklWvYPDB3lH7G2tR0C0iGnhsrzdb9tZY9ufGpqHPZzezlFdoPUIljz1
         /uTAcnlZO8EnJMfnfGPrnkmhbpJH9q5Tm7htUi9nnRYg0bDLoKSf5KCats8dsYrp17OT
         sRvQR4no3YXQnqQEERX7FlylPUl/aHDm0a62YdG5eEyKlKuFVHxagwuFwQBixshWNvyI
         zpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874864; x=1777479664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sk20s6q0mQczBiHCPHHRevnIyEhlrBrSTHUSrQHOrNY=;
        b=Wo2agBUbJa/5ffdacjMaY3TCE0DQRE7NOMoMcLjsoeH0PI/OXq7zBlTugujqOYYWyG
         OyRKkcz3b+vH4NObRasFnYhSWe+vhfQCoQ0bQ1pDqhQUKuCToB/HPPdFh3jWfnSkjl1B
         m6Uhd+DqtJzqj0Lih8xjJPUO7ajR6t/qKFLbmKpTT9nHrTyGXODLXADgTWbDH76sIP2J
         TGYuZKZmbGeGhOGT3suxG13LVN6O5jvvJEzhw0Q/XgWaOPrx4gvuMWrl0Xr2i4ynF91o
         ETrzhtn56pzNXOD5z4dyiAdkVR5NgvJz9zUCjSKSTYS6W72Nmu+RgJRRtzCu+5Vj84Ij
         CErA==
X-Forwarded-Encrypted: i=1; AFNElJ/0Uu9/bTLhcs7hdy0Qjb6GkKyzDAL0bBIRc7rpOIDkkQDhLfuGLdUlIyZfkRDs3VAbzC49l+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNrGxSQ+gPo+gP+etNv4Qgzct7yqdaRQufLan94PDXr3MD2zW
	L/9LPDpNxONijweoPr1n6tHhrJ2N6O+BPOLo9uJE3RzUX3ilxQrRNvMpklkiObV1A1Y=
X-Gm-Gg: AeBDiev4u/9XHb/1cuK0EUhiXUbQqzTLuynurUT24U2/ejQ9kYIWAuxliibmT8xu/sF
	OjZcd7LhcoU1sF0pZRbHBS1TofpyqFqgYViAsaQsZGPEehTrQoqCZjKlHlZj4kJ9Er8xZh4OhjT
	xudoc36EqqR2nNFP5/xKK1hbkSVIXvSw+D2HDncrkmVV/tXISmA3HLUBUmPbBMuaNWKaLOqUGaA
	ci7jkrYrMFQL343LfLdr6N+KL1Y/ckk/v+8zfHFsLOXXC1IMw10UO0OEnP6a0U8BqPoQqBm6sDA
	lTQ3QoWFViNvjgNfwADtZxOYKPk12PpP8lSaIfaoHP+z8Y6xs47lSzdA+wGEg0GBt3bJM8UAXwU
	GBcMxjb1d7PNBVg8PElRa2XNmIB9xSJN9Rd4iGvh0CnyMx1POcxSS6h1OU/iEFd+kf0IeedQBXs
	WIIjPyl1wboTTq5764Kyy86yELpn0UfKMVVGe4Pu0uJp+ZVw==
X-Received: by 2002:a05:6808:c176:b0:467:1e5:6768 with SMTP id 5614622812f47-4799caf861emr11656539b6e.43.1776874864069;
        Wed, 22 Apr 2026 09:21:04 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dce5c346adsm2363671a34.27.2026.04.22.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:21:03 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:21:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, stefanha@redhat.com,
 netdev@vger.kernel.org, Mathieu Schroeter <mathieu@schroetersa.ch>, David
 Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2] ss: fix vsock port filter
Message-ID: <20260422092100.46744a32@phoenix.local>
In-Reply-To: <CAGxU2F4C4JbqBEWehBhhOehGaXZJOWLkQ09hjaaSAh8-J5W50w@mail.gmail.com>
References: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
	<20260421163757.31da8751@phoenix.local>
	<CAGxU2F4C4JbqBEWehBhhOehGaXZJOWLkQ09hjaaSAh8-J5W50w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280496-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:email,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B1481448A33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 10:03:49 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Wed, 22 Apr 2026 at 01:38, Stephen Hemminger <stephen@networkplumber.org> wrote:
> >
> > On Tue, 21 Apr 2026 14:35:12 +0200
> > Luigi Leonardi <leonardi@redhat.com> wrote:
> >  
> > > parse_hostcond() uses get_u32() to parse the vsock port into the
> > > aafilter.port field, which is a long. On 64-bit systems, get_u32()
> > > only writes the lower 32 bits, leaving the upper 32 bits set from
> > > the -1 initialization. This causes the port comparison
> > > "a->port != s->rport" in run_ssfilter() to always fail, since the
> > > corrupted long value never matches the int rport.
> > >
> > > Fix by using get_long() instead, consistent with how AF_PACKET and
> > > AF_NETLINK handle the same field.
> > >
> > > Fixes: c759116a0b2b ("ss: add AF_VSOCK support")
> > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > > ---
> > >  misc/ss.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/misc/ss.c b/misc/ss.c
> > > index 14e9f27a..6e3321ac 100644
> > > --- a/misc/ss.c
> > > +++ b/misc/ss.c
> > > @@ -2323,7 +2323,7 @@ void *parse_hostcond(char *addr, bool is_port)
> > >               port = find_port(addr, is_port);
> > >
> > >               if (port && strcmp(port, "*") &&
> > > -                 get_u32((__u32 *)&a.port, port, 0))
> > > +                 get_long(&a.port, port, 0))
> > >                       return NULL;  
> >
> > If you use get_long() then the code could get negative values.
> > Actually have port in ss as signed value seems like a mistake in original design.
> >
> > The port in unix domain socket is inode number.
> > Originally it was int, but got changed to long back in 6.6
> >
> > The port in ss cache is int.  
> 
> Yeah, as I mentioned I think the issue was introduced by commit
> 012cb515 ("ss: change aafilter port from int to long (inode support)").

What about this which avoids the cast but keeps the same semantics.

diff --git a/misc/ss.c b/misc/ss.c
index 14e9f27a..e830e146 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -2317,14 +2317,16 @@ void *parse_hostcond(char *addr, bool is_port)
 
 	if (fam == AF_VSOCK) {
 		__u32 cid = ~(__u32)0;
+		__u32 vport = 0;
 
 		a.addr.family = AF_VSOCK;
 
 		port = find_port(addr, is_port);
-
-		if (port && strcmp(port, "*") &&
-		    get_u32((__u32 *)&a.port, port, 0))
-			return NULL;
+		if (port && strcmp(port, "*")) {
+			if (get_u32(&vport, port, 0))
+				return NULL;
+		}
+		a.port = vport;
 
 		if (!is_port && addr[0] && strcmp(addr, "*")) {
 			a.addr.bitlen = 32;



