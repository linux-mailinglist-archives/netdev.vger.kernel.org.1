Return-Path: <netdev+bounces-297832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EGWrF5TFKWpEdAMAu9opvQ
	(envelope-from <netdev+bounces-297832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:14:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B306866CB72
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:14:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kMwBE7D7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297832-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297832-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82A5C30262DC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810F039280A;
	Wed, 10 Jun 2026 20:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30F93FAE11
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 20:14:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122449; cv=none; b=puFRysuQATvqgzqqPCi1uhFHXo+JzpSfbPmJyBerUCUkL/DbCSVKgx8e+u14PMyKx4jpliTWgSFw1F9b2tBzuCLswDv0P1yVp/HOrcrh9y1rdHJiRH8N1gQyclLpKuikx2E2sYXiveEvKAzEFJh69UBTR20u/s5RWWg+GuEa4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122449; c=relaxed/simple;
	bh=44clPBx7JvYZT4KcrLdHV/lSf1rdmn8+/hrBQhmk33s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmdlWQRmcHbF9dGONLGQKe4pFqafGMMlZ/IDmOee8Xlcn8Y/kH2CWskigJBLUL3SnxHPyg4RbjV33iMIm6X/6POZ5l0E6a6TC6eWop8fMxeyIjjkVrgkMfDTHeeWasofPUPM/6+AS4RrPEJrR3QiFlyhxh3KhvE2fOFStlMFB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMwBE7D7; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso61106555e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781122443; x=1781727243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iV0raLdT8rN4pmtFLooLhBeUwEIA3jAESS/ARRshoV4=;
        b=kMwBE7D7CW858EefTdZ9bEVYyJ6VqtNsZCMLDF7lJm6dVAUspvOSkJ4S7SlnHIsEJv
         rdoNakIpdAfz8Zsn6CDLlH+QTnTQaivAJcnnF7iZqZg493gRUFaGe4+WA5UwArydlc5l
         8hBev786O+Cc/Wvbjnu7eSbhhJF066DsNbWZXGhcuXAdoY/0ldM2wf+CYoKAsuL+m9xS
         Xkp9hG8NggwpwNdEw3XDJ2J1YzgpeakhY8yNonZ0hGSUzm1MAhv0VLfvU6kj7ErMPpO8
         IeM6bJYi97um5kLsa1lNpyEZfIq3ES6UXkFOle3+zlkFa0ibxQhyRjKQuQOyNiwlKiIh
         o9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781122443; x=1781727243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV0raLdT8rN4pmtFLooLhBeUwEIA3jAESS/ARRshoV4=;
        b=ViakjUUvgXHd849NrPQ++KnptKdRsIjG5KbUcubJ4mc43kQux3R4tkIF0/cysEMpat
         coPyd9O6yE5HJYedljh+4V922XIVQGe7MXIkjqiUn3q7xISRlUVLV9JIX9Kve06K808F
         uEQZrOKYJbgUUQQgQ74X4gRU9geJ4Ix0foXNdW362ZV2pdhGdlmuK4mXIuS3mV/Dp07h
         GvL7DsYPA0T3Txs2hsicVlcMNKZBKsIMRWJJuLHqo6LlyMlU+s1sNHGfUMl9auokeVJg
         Nm8ODztD8dkF9IUqQl+e29HQJS8GLEQYZIzZ40RETa/ItRZAxv38MNhULLZbtvGC8NgI
         Kgxg==
X-Forwarded-Encrypted: i=1; AFNElJ/rW8boXuk1JfDCaXaDqtyfYec5n4QmUtPXafw7m4JIHoodMkoEpHewMS5kNKRUPuzmZ9w3CrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOBvfH9fVELyqo7MdcV1svjOW6OpcenFnGzmFL24xbWdygaLM
	6exSSZPpMobJsn8TyUZ5hwzqiLOv0NGOGolDtVWmeQdl1jJ+FkkU31PQ
X-Gm-Gg: Acq92OEB+AhS22Tcr4jSo1f/o5C+bHYprdSKVwrXLik41Xx100ypZJHwLBUl0LWwL3X
	h/qJkPO3IK8HwxPUUU+j8fa+eG+8IWgo2vUoPckpXWnh6Af+BeFxhtzF7LUrnw2yDnuvzNovwEH
	ub4hU4RxmcRThSFoI+mUuY91fEj2VyZgUFzNVrYpKuX+8B1/9Vlakwgs2YWqd9lqnKW0UuMiBh9
	PukIRcV+YeosDT4up5afxWQlHpmOK60uVQ9gBEFdzV+xYYzn52xf9+Mc5BFTj0NqEgTgDHp9ak3
	92mLZt0GB5Uzi5eabIHVPtgAIXvYqV0V5osJ/C/0rMAP4uBp9bqKIzIl/fmj5bmcVjPelZgYl/T
	YhJf1oR0pouQ4cX71jgfgNdxrYYGvoFPI7Sy8gOb1xhm7joeFAG2CrUt0G9ze9eSy1GPAsy0Ji7
	wMOd4GqVGrOvxFqraQzJzYxfhBn3DrD8QpHv6SOBI9i2MSX7WegYBSTIoATRyJ8w==
X-Received: by 2002:a05:600c:4708:b0:490:bde3:d112 with SMTP id 5b1f17b1804b1-490c26038e1mr422668935e9.30.1781122442918;
        Wed, 10 Jun 2026 13:14:02 -0700 (PDT)
Received: from archlinux ([143.58.204.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dcaa924bsm169834745e9.1.2026.06.10.13.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:14:02 -0700 (PDT)
Date: Wed, 10 Jun 2026 21:14:00 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] netconsole: clear cached dev_name on
 resume-window cleanup
Message-ID: <ainEY44D0Qkrg0eE@archlinux>
References: <20260610-netconsole_fix_more-v1-1-a18652c47cef@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-netconsole_fix_more-v1-1-a18652c47cef@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297832-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B306866CB72

On Wed, Jun 10, 2026 at 07:26:04AM -0700, Breno Leitao wrote:
> This makes the resume-window cleanup consistent with the notifier-driven
> one so a later enable does not let netpoll_setup() pick a stale interface by 
> name when the user bound the target by MAC.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Reviewed-by: Andre Carvalho <asantostc@gmail.com>
-- 
Andre Carvalho

