Return-Path: <netdev+bounces-295895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 20V/JpX5ImrofwEAu9opvQ
	(envelope-from <netdev+bounces-295895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:30:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C9649C73
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:30:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=APouJqga;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295895-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295895-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 482BF309D388
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B95408636;
	Fri,  5 Jun 2026 16:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E63E7BAA
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:21:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676518; cv=none; b=PQAUGHQ9Wsz9Ha58I9EpOL5eXbl/I9pofcgtjJZlDtvy+59ljgcWAwDV4N+2AqPjrD5mxMovftRgpyeZJmRyEZHPptXlEzuSDz61kDcKHT19ePSmWCQHbKu8x8BdJqrtefwaCsIM0YkFBE1Oo/uLCaO2qvGs2tIbar57/C6eccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676518; c=relaxed/simple;
	bh=ZKZ84/luGj+BWGDyOu9nLN0I3YRngpbvVR4I/PcJFPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHc99QGNMpLGCSnnx19oGYidxvnVF6DKVy7s5yZ0OKXEq+omw06enNndGDOxrr35046PVfO2lvpsEX8fV0GNpX73dJBMNNq0hzt0OsG8jDn9f0zTEb5+mN3wktv2O9B13nCLQo/Xnx/FIouM5BVcRLy+zqbuEzJtFll2w+nmZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APouJqga; arc=none smtp.client-ip=209.85.214.195
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so14788265ad.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676517; x=1781281317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGpdGSSCTZrMcrdmmPXr+aQ94+C8S19ytpnAhcpODSs=;
        b=APouJqgabpEpqMm9h581az8kNoilJERAYDVBaQO88TnjIjURGIvAQCE3M6Q8B7Z+9N
         KXyZ624fW+DtLvALcVTj2lYXIsOmH4n/fnzN9pqg2Ku7SPBt0YGk+eYYm61knfhr3u48
         SRGoIStVwCURBNHCZpMqfLMB21yW2AU/sXjaanDyLeTOstOthWNDsmeYaco499k/Lwsr
         R3vATKoXrmghaRXWkK4vqVhWouC928Z3+ie/yiJXIe0cus7PFMnHlIf9zZJcqsBiJI4O
         cJfDvHgFyV81wnDuOTQCIdfQYfgUv0l0Rsxwnag9ugMSYm16rojCstl5VkOsIBqM5PIC
         /qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676517; x=1781281317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGpdGSSCTZrMcrdmmPXr+aQ94+C8S19ytpnAhcpODSs=;
        b=REfvhlq4MYjyNJb/jAUV6ROuAR876JVbBWEQkaqN+ExgCuL51TepqIVNYreEqKyITc
         LcY7vSgT2ONXTOIauiiAkYZ47tQphmjQz8mkie7UQYxoKFH+w5gwG9g1mYT24B7lDQ5y
         RIJZ8mSzhhFclIjYfCchAquzAlCKH2IibS2srPQo8d87RufxBg3Wmmkk8UZP2KLRNm4j
         EE8f8Sai6v22BPLwDT771WCdnw/BDsrywlR8RcpWimSg0J+eTb2A9EKTt1faMLpgvZDE
         hbLfA2cyauq7tv0u3chnygPci3yD4rkztx9OfMiS5Y/ERwE5xYA/XfS6VtDBGbg39unl
         owzw==
X-Gm-Message-State: AOJu0YwNlPoy9SxgYclUT4fg4cboo3x0AcpdFQ0saDnjEomsRcmGh71e
	bkIgR4s9KXyxoTZBG+PYQu36L8rl8XXVi5wVpVpA2q9N6OZniq12HiyK
X-Gm-Gg: Acq92OERWk3YrRblHz4G96fX1mOM7x62BoeJ/mwcjABMd4p8AeFJib+EaXBC9lw5ZEr
	N+MMuFyDGH65ABiasa8dYvYPwTqFSg9XWfXSq0/vz57C85zB3XgGRjGQllCbuSKxgp4h2iUdVEf
	B2t1LsvbAYmaL76J+7inJ4lBEaULqQ3KlQu/0h0oc8/quALNEGjGMXIW5XamhFCv2GHy8i8KWo9
	ArtpxQ4TBjdTP/Z8aqEn+uiis6sVIz2gsqs9XZ6A3PZ414uEZJZKwa/cJvWdf6jkEjp4aT+phWW
	hVIDOh63hC7JikOpepQwy/2nEcWuPCvsrqUjXT9xepCvBYcyxIJHml5OZjGokThZ5saIp2E7WSA
	2q6PXYzuqCbStDuNO/ZnUkMfcQF/6E7upfvvmXUxbffAgJF4Mlig8bfDoJj0Mpup7ard9F9DGMl
	PnzGhCiZLg+2SFhhWbVC3YM/WHVzY=
X-Received: by 2002:a17:902:ea06:b0:2c0:abd3:32f1 with SMTP id d9443c01a7336-2c1e8220b2bmr47569415ad.24.1780676516833;
        Fri, 05 Jun 2026 09:21:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm96975505ad.31.2026.06.05.09.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:21:56 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:21:44 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/3] net: add retry mechanism to
 ndo_set_rx_mode_async
Message-ID: <aiL3jjFRxyqKuo_b@devvm7509.cco0.facebook.com>
References: <20260603223535.2504695-1-sdf@fomichev.me>
 <20260603223535.2504695-3-sdf@fomichev.me>
 <20260604190142.0ef0d119@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260604190142.0ef0d119@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295895-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E4C9649C73

On 06/04, Jakub Kicinski wrote:
> On Wed,  3 Jun 2026 15:35:34 -0700 Stanislav Fomichev wrote:
> > +	netdev_ops_assert_locked(dev);
> 
> One thing, I guess, since I applied the rename I think this should
> become netdev_assert_locked_ops_compat(). Not that it matters in
> practice.

Will do, ty for the review!

