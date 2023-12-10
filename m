Return-Path: <netdev+bounces-55639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6D780BC6B
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 18:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8951C203DE
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00661199C3;
	Sun, 10 Dec 2023 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAI01CW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E72FA
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 09:44:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d0538d9bbcso33925985ad.3
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 09:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702230268; x=1702835068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SS1+OVcRNomKHQX5A4fgIMvgK+UxWWAQ3wRRF1rhvuE=;
        b=nAI01CW+z9a6IB1Y+OSsRDjx4AA8mc1iXRXH3imRWdmBNJ/YJLmxOC493CXzbbg75P
         dHQJC1GNsM4g2lMASR4ECVaw7y4X+tFo7CPsqzMrIRtvIxPzcYy+T87Fw89b/yV9d7q/
         x/P6ZIAc8ORhNugV15sotrbeL7JQ7YlqZfEdoHxLs9gU3I03znr9utYBdWVHLBgWbbnI
         gdHlqx0ykkH9GNADGzrRUYWXGvYD+djn/ubKDmdZ0OkDE8cSHKtpxfR9fGJQAx8lL7de
         RkuelWGBNPeg90PSCmN8QAMDfURpERHVPpf/46oj3iJwc9eBTl6VaJ91RUDDGH/+CRXl
         cUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702230268; x=1702835068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS1+OVcRNomKHQX5A4fgIMvgK+UxWWAQ3wRRF1rhvuE=;
        b=PKyNpESHD3veJ9K0o7eUAZvc55p/qCQCV7Y5EiIfRZL0zIKJPnkiainLNadlILFm8M
         6OaS2V+n26KlQMkpNeKHiwnh50BNHXV1bKJds5GG/1KQ91VIlawHLJI7wujy5x+5rlTk
         5qOfBYRysywd0FLmPnYWICuhFEULV+ynbk1sMgBWIThs4lSb2mXDG53GURtQtT9HFjBZ
         4v8sWT1WcgkZysPXO0HA760xCU4OSBbhDQSCXl2nr5aHx1VtwozPXXc904HxIpzu05Re
         laU8viafYBhCBokhRBDoXHF6pxv+aFx1hvEUNdrjrSuPS0KNKHrtXD148mTHgBxCvZAr
         o1Lw==
X-Gm-Message-State: AOJu0YwglWK/2sUQj9JbjMm5syefSiv3u+QkG30vAuaGw6dRGB7Yaycm
	jBtl7JhVmOhBnaiEmq0qI4M=
X-Google-Smtp-Source: AGHT+IEhF96xvo6Xnp1QVoczPAt+WLXoaEfAplAdMoxSob7xeDJzlmD+JZ56b+Ee55a/ToSSI8RsIA==
X-Received: by 2002:a17:902:f690:b0:1d0:c502:e0b3 with SMTP id l16-20020a170902f69000b001d0c502e0b3mr3734235plg.36.1702230267783;
        Sun, 10 Dec 2023 09:44:27 -0800 (PST)
Received: from swarup-virtual-machine ([171.76.80.2])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001cf6453b237sm5015101plq.236.2023.12.10.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 09:44:27 -0800 (PST)
Date: Sun, 10 Dec 2023 23:14:21 +0530
From: swarup <swarupkotikalapudi@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v5] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXX49ULoUPOznKhP@swarup-virtual-machine>
References: <20231202123048.1059412-1-swarupkotikalapudi@gmail.com>
 <20231205191944.6738deb7@kernel.org>
 <ZXAoGhUnBFzQxD0f@nanopsycho>
 <20231206080611.4ba32142@kernel.org>
 <ZXNgrTDRd+nFa1Ad@swarup-virtual-machine>
 <ZXWlTYyPF0nj1wof@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXWlTYyPF0nj1wof@nanopsycho>

On Sun, Dec 10, 2023 at 12:47:25PM +0100, Jiri Pirko wrote:
> Fri, Dec 08, 2023 at 07:30:05PM CET, swarupkotikalapudi@gmail.com wrote:
> >On Wed, Dec 06, 2023 at 08:06:11AM -0800, Jakub Kicinski wrote:
> >> On Wed, 6 Dec 2023 08:51:54 +0100 Jiri Pirko wrote:
> >> > My "suggested-by" is probably fine as I suggested Swarup to make the patch :)
> >> 
> >> Ah, I didn't realize, sorry :) Just mine needs to go then.
> >
> >Hi Jiri,
> >
> >Please find answer for some quesion from you.
> >
> >1. I removed the Fixes tag.
> >
> >2. I removed Jakub's name from Suggested-by tag.
> >
> >3. I added new line as suggested.
> >
> >   value: ## or number, is used only if there is a gap or
> >   missing attribute just above of any attribute which is not yet filled.    
> >
> >4. dl-attr-stats has a value 0 as shown below for this reason:
> >    name: dl-attr-stats
> >    name-prefix: devlink-attr-
> >    attributes:
> >      - name: stats-rx-packets
> >        type: u64
> >        value: 0 <-- 0 is added here due to below mentioned reason
> >                     but mainly to match order of stats unnamed enum declared in include/uapi/linux/devlink.h
> 
> So, by default, it starts with 1?
>
Hi Jiri,

Yes it seems by default it starts with 1
e.g. below is test result when value is not added

git diff Documentation/netlink/specs/devlink.yaml
diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index c3a438197964..9d0e684da574 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1191,7 +1191,6 @@ attribute-sets:
     attributes:
       - name: stats-rx-packets
         type: u64
-        value: 0
       -
         name: stats-rx-bytes
         type: u64

sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "ttl_value_is_too_small"}' --process-unknown
{'bus-name': 'netdevsim',
 'dev-name': 'netdevsim1',
 'stats': {'UnknownAttr(0)': b'iW*\x00\x00\x00\x00\x00',
           'stats-rx-bytes': 62,
           'stats-rx-packets': 394034238},
 'trap-action': 'trap',
 'trap-generic': True,
 'trap-group-name': 'l3_exceptions',
 'trap-metadata': {'trap-metadata-type-in-port': True},
 'trap-name': 'ttl_value_is_too_small',
 'trap-type': 'exception'}

Thanks,
Swarup


 
> 
> >      -
> >        name: stats-rx-bytes
> >        type: u64
> >      -
> >        name: stats-rx-dropped
> >        type: u64

