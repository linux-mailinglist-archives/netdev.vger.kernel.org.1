Return-Path: <netdev+bounces-266811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIc0EGwKsml7IAAAu9opvQ
	(envelope-from <netdev+bounces-266811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:35:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A511426BB5A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F315830E2321
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F78342538;
	Thu, 12 Mar 2026 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T6oJT5zW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245633DEC0
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275748; cv=none; b=uxo7WyqGNkP18uMjxhelKgcjCD26TaEdWdyAhK89xWcf47qPsas4Z5QXHM93clNfIQ0WS7+4Dihe3OKIC5W6slzEQzMcpXFFjkDlHiAZaGLepD6y8pbVevB50nySoZMBiiIXESXoVnvgPhksV7uJ3DAWOSCzPEOKb8yhGn1tQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275748; c=relaxed/simple;
	bh=bu9Oih6osFV7rtjEbKgQ3kyOQcVL4TprE4RKoYQKLtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzUSjm9jVFZ3uMKDhSYYnI/PvAjoIXORVogXlkcOQsbUiUvzVEZZoY7lEVWvTBVrRXl66oi1YaK4rD6+ajQJHG2xZrO3aBZ/R3PN8+4nexkBWbgE5HEvgLXtcTfKL0M+cGpgeRyL9r78vuoID2UmLSk3pNbdwmikAanoTeC+IYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T6oJT5zW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ca01dc7d40so41820885a.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773275746; x=1773880546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bu9Oih6osFV7rtjEbKgQ3kyOQcVL4TprE4RKoYQKLtQ=;
        b=T6oJT5zWuYFu//UQ44qIFvKBmmdQ907fAqU0B+SynFOCaH3CICCfLE0JIjo+TrRBCu
         OWMafBCtK5bj9+8WW19IgoMJauzYE3PxouS7PlZhkKO5SK72+SCn5P420BHbtOt0bTmC
         kuwmvPQZMYPvu/jJ3ucg4ED095KdqdtZEW9+LILVV5HHOmD4ibcRTe05tDLb8yag7tkD
         syQ+G3523JJsJZhXT3omA0rJ9+mlqaWOlAx4NEkOcM4eHniVed/UyP8zYqhuVU/3p94v
         qXvRZQSrkZLzBsLQceILOSorD+7MoYauHXw3sIbiclHi/HDiL9n36+GeHX5RM3minec6
         +tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773275746; x=1773880546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu9Oih6osFV7rtjEbKgQ3kyOQcVL4TprE4RKoYQKLtQ=;
        b=kZuFYOJBc3fhT6rwxSfMeGXyrGDDxf4kQ4/+Nhf/ea486X2Nor9VWAPn+F7biLK8fQ
         glWgn2/QyrRU32+2eIrao7SiRVJ/EHh5egniszsSeg+j5S9fXhodHMfE6VKEwG8S04nC
         hfqe7lK0aB7kA4SvVnro07+xs7+stsGJLaB4nR0ctf47QRUi6S4pY69DoaK05NDVHpLS
         PfsJ7Rwmazp0fEX4I9IkukPZwmPfX9Fdspj8xQB354VssTQhOSDlvTGD6hamubxz3/vY
         DJswhXNcr1XYIZWMbQR7XP/l+K0pzeumloE9RAZnLKlXtDR9vLXONA8JOUnXJ+afZkCN
         tcAg==
X-Forwarded-Encrypted: i=1; AJvYcCXo1DTU6fsvN4cllQD5+n++ujbZn49WL9IuAUX/UlwRmmPxZpxb4KFBmMBgjRNaCa0OKPXys5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ApxGaWWjoA+2YTXN6tM0t9GwdwXrFG//l4CKA6dyFRVVUYhs
	UGNiLl2OFB1zEcnU3sSalZJ+1JLF9dEZQ/MAxs0QJ0cm7eIc3PmpLZI1jZ0McIE91zA=
X-Gm-Gg: ATEYQzxt0njXLNE0AaspNqs64MwUXwLs25hNDe540cKnFHztOnSHtXrACn1z8WfRX4q
	+37FsmP4Umk8nPqoTd9oV82qT/tCGVUKjnCn+WNwipfOxV8SxFgs9Y9u7eE0AUFaWDOhiKo1GqE
	tojbeGAtbEr36FrJDvu7MyijQItxsurf/8YprQfI9gSui0zbMpTq3gsxDcGQr6XH1NPn7VHYU28
	DOa2CuX+6I3J8/MdkMK+CSxbYgYUvnNECltds/ksUkk1CKcImQFGvFNpZgkCsQuKdoK44otaTta
	Q0It1NWmCHY5PAnl6hslVYxBBxpDdRvESf12erGhvfasJGb//NxoUiqyJ5eCDZX//7R6RtFVuQu
	zqF0Do7gE5N1MtSrEwfOmz52YDnmj7J59Lx00/I2cdGl1bsb1nur9Maf2msnSI0dXOXIB+p2IWy
	td+DvxBeRPvwezvqK/BwF6oKmbYEFxG6c0FBzcT3kj/gzGwAT2EBQzGxlJK/h+eW6d8SgftX/NH
	eARb5ds/bjPl/V3Etw=
X-Received: by 2002:a05:620a:711a:b0:8cb:5176:f00 with SMTP id af79cd13be357-8cda1a95cd3mr623140585a.45.1773275746517;
        Wed, 11 Mar 2026 17:35:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21100cfsm239690985a.24.2026.03.11.17.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 17:35:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0U1g-00000006a0E-4BUf;
	Wed, 11 Mar 2026 21:35:45 -0300
Date: Wed, 11 Mar 2026 21:35:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Praveen Kannoju <praveen.kannoju@oracle.com>
Cc: "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Anand Khoje <anand.a.khoje@oracle.com>
Subject: Re: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Message-ID: <20260312003544.GB1469476@ziepe.ca>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
 <20260304201151.GI964116@ziepe.ca>
 <CH3PR10MB7704DD1E6B9A671796FC6B528C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306003217.GB1687929@ziepe.ca>
 <CH3PR10MB7704ABC8F3909C60FFDFB1188C7AA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306231024.GF1687929@ziepe.ca>
 <CH3PR10MB7704D1DF6471E59D47ECEB098C7BA@CH3PR10MB7704.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR10MB7704D1DF6471E59D47ECEB098C7BA@CH3PR10MB7704.namprd10.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-266811-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: A511426BB5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 07, 2026 at 05:43:56AM +0000, Praveen Kannoju wrote:

> It had been very challenging to arrive at the cause.
> we went thru many live debug sessions with Nvidia R&D team.
> but we couldn't root cause. This tells why we eventually.
> arrived at this mitigation as this issue is wide spread
> and has been hurting many and many customers in cloud.

It is almost certainly a qemu bug. If you cannot find it, then I
suggest you work around it by having qemu inject a spurious interrupt
around the migration situations.

But make sure you have the already known qemu and kernel bug fixes for
lost interrupts on MSI-X writes...

Jason

