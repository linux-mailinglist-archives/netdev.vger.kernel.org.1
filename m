Return-Path: <netdev+bounces-299837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cB6+Cm9FMWopfwUAu9opvQ
	(envelope-from <netdev+bounces-299837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:45:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7414C68F7E1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:45:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=LkPMS57S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299837-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299837-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D857831FB9EC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580CB3624D4;
	Tue, 16 Jun 2026 12:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98851FFC59
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613623; cv=none; b=K2jvdQNl+yqX49sLaRVIC3gdcAQgTp+JdWzRGtSGcT3jEtLJYZKj8c3JP3MNdcYqy606fASZY7A41bFIAXUGwOT1RCgW0CPhqKRDjGuK7Qks4VkyTDx0ohJAHPDfYYY3NN7m9DsQSBYOdWL+2kbqEdge67zbQoKYTz+Qw5x21ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613623; c=relaxed/simple;
	bh=tPbjX8dfzPLu8onhnfm0DNzfCkJoWXqGLy1Lxvc2NUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfz08Eh07eiS1LZ0p9w8Opz/5QCQNfKoTcyL+H8cJSkbfG59aHBk+QJIcqO8oJ837iA6JxYdHCir/UFIi7QxnPK8Br+UGIgSDxhrrMuE65eO8Xug2pFi8tfS76LK76La0Dsd2E/1F44uIw9kqYVmZvk6slaKXJW9mH/7XKhl1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LkPMS57S; arc=none smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5177ad0cc67so39287921cf.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781613621; x=1782218421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPbjX8dfzPLu8onhnfm0DNzfCkJoWXqGLy1Lxvc2NUs=;
        b=LkPMS57SheHWUiSvnK76MNPuPeTpmepRr/zvfJ4ZpBSaUTrCEOpDnjQIDbl4YV/8pK
         0RvEWX124XtPixmZGL7nu5gP6/f8YLcuJcemmDyc9fyshX/R+SxjdOfeGu82kKdDYZho
         Cd9Pz1ccepPbodA6fjVyV8/JveKyJe3KP8MRwGAwYk9TlUcvrqnzf0p67yRmqK1zFBkn
         ueRtbFdomSo6KVgL++OLAEQDKjcHqEnR+zzX9N0gqBkuWhJN80xWe9ysGRvBjlwR0mH0
         ufusAQb6vCoO1JcuHxGMggFcSZTI3SlLFb/IbD7/qTV/l7St0K9Px/RxVE6ka7P8+N04
         W1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613621; x=1782218421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPbjX8dfzPLu8onhnfm0DNzfCkJoWXqGLy1Lxvc2NUs=;
        b=m3sZuqbDED/reIBfEDpMmnGjyjWvubRa1284Tz/wOlyZ2qTAdVOhx38hL4qp+c7iLp
         Tl63QNwYOdO6T6xThYrFXgnWBpMGZhuOMG2z4Vcm9HWOvxfxtj48A7thdcsf7a1CzucU
         m+YRYY8ZbPJQzFtUWCTcbS1zno2m3IB9LXWBrRZhk6Xw6mbAFmrIwGuwKXAUd8zR3Ghj
         ZtJpHId89arEZiJVYJd1On2iK9SlBluKhj3tLzsGzLrf7qKghITZ2QVdi77tvWMh2x/U
         8+S+E2Nj6BtsTzuck3FJlYtlqLSTGHHEPztdxbSJQ9A7wDWF8j50Or01CbqueAyF26VH
         GmlA==
X-Forwarded-Encrypted: i=1; AFNElJ9vMp9nDnTen1eKS4j9T8L+/7X+/NL7x5YJ1P6NQBUrTd/N+cc2NZpzsI9vL0rQKzMfdUNqpYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybYdSI1eaFk/3XajMahZSkDf6xEnLIj689tVnWEPz12CeDlg7r
	CvhqV6LT5SoqNMPIonla+q1oe9jz8RrY53O+ExEG+NfjxbM4wumYCLdNJoznWdd5SKA=
X-Gm-Gg: Acq92OH4Wo4p8OJ1KkQxgfjUMSiZHeSI8Xby6Zo2hlAs2Dd8U+SQdwQQbNL+MdKNNch
	tELgeJKXGGx5ZMnXpE0FjblmBQk4VJSeqHy8Pzi7td1PeUbRV3KPkXC4wRMwTtcPM30Y7eT8iPS
	/HrFX4ZgVuUaUwC8wax6YdnOQ1waeMwOQIbfQXWaUyEBwKJEQDTXoCBOsJwWKPhkSTuuGRTCTLt
	KE3t3MtcNcmJJQDiJMhzPF3kM+X3cSO2qHzgv7bc8+hPVkEFUUiY+GoGA8jn0KYRbXwoOPt7ZZm
	I5to4LH4DMC1eEXTVidNffixpVMuVG7RyON2pxmlYYzfbBN35yM8H123i0tezT/QJy+pEbBMSXI
	3CjMHmxCYneghffPdOGlt/p3/q2JmtCiNuIybqqFPNlaGiZgGAuy5Nsrg7VBe760jqiWWn4kaXy
	O/Zt/nJAsMC7FMKDaD1Od8WQiLJxLbYXD9HOYIowY1H6Vpz7OtlYLzxMQigHupjmLp4VnbZYSyF
	LspIQ==
X-Received: by 2002:a05:622a:2282:b0:517:6804:1fb3 with SMTP id d75a77b69052e-517fe230d82mr282972431cf.18.1781613620607;
        Tue, 16 Jun 2026 05:40:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61d948sm133785221cf.1.2026.06.16.05.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:40:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZT5X-0000000Fzb5-0uZr;
	Tue, 16 Jun 2026 09:40:19 -0300
Date: Tue, 16 Jun 2026 09:40:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"almasrymina@google.com" <almasrymina@google.com>,
	"matttbe@kernel.org" <matttbe@kernel.org>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"dw@davidwei.uk" <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
 folio
Message-ID: <20260616124019.GA3577091@ziepe.ca>
References: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
 <20260611-tcpdm-large-niovs-v2-2-ee2bf15e7523@meta.com>
 <IA0PR11MB71852246277F773AC41DAAA3F8E52@IA0PR11MB7185.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA0PR11MB71852246277F773AC41DAAA3F8E52@IA0PR11MB7185.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299837-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vivek.kasireddy@intel.com,m:bobbyeshleman@gmail.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:almasrymina@google.com,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,linaro.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,fomichev.me,blackwall.org,iogearbox.net,davidwei.uk,meta.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7414C68F7E1

On Tue, Jun 16, 2026 at 06:04:03AM +0000, Kasireddy, Vivek wrote:

> > This is helpful for importers like net/core/devmem that expect dmabuf sg
> IMO, udmabuf needs to detect whether importers can handle segments that
> are > PAGE_SIZE and set the entries appropriately. Please look into how the
> GPU drivers and other dmabuf exporters/importers handle this situation, so
> that we can adopt best practices to address this issue.

Importers have to handle arbitary scatterlists, devmem is just broken
if it can't handle the output of sg_alloc_table_from_pages().

Jason

