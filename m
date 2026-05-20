Return-Path: <netdev+bounces-290109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BhaGVhBDmqr9AUAu9opvQ
	(envelope-from <netdev+bounces-290109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:18:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B404659CAA1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340F13306E39
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871BB3803DC;
	Wed, 20 May 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QatC0i0M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA837FF65
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312166; cv=none; b=B27izGw7lrp1aDvOVhGhe2in/ckxNrdYSJJnrSmPhadzAFmn1aUQFH+U3FJIFz8Hdx/2czYxqhDxAQ1RQml8zkNKF/2VvfMSVUex8mim4bAFz6j2wQI8LM21CrwkTFcYw+Q9LdImd1KUzYW5mJQsruOuvUhAOy6XOHQy3IMWZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312166; c=relaxed/simple;
	bh=KRHFm91BkHusMuCr++lqPfMPZLI+rXaXJEU0fHom4mQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H+QsCIbi2HXbuvEsQFvwuSmSWFfneysVK+UqzBSyZ6EWP0VKGcFIy4ifCl2tJrxprxyqfjgP2Khgknthcx6IN99e3XBamS5qyAsQBKk9fGgY4ykRD2mf6CTgVBVX1V34haZVyCMRIwCuBIt+38BoqE6LaLxUG0l0d5WDZiOBMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QatC0i0M; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65890a6ca20so6107358d50.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779312162; x=1779916962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEAw/HLd2Gukf+rbP9FYe175TBnZFF3s9mDfNnhekAY=;
        b=QatC0i0MBfL7me6hBc6CEWs1B7tcbGJbNzngGdQTwqEwcX4V0uIoWHyXDZjbioM3rd
         bkJQfASH+AUp47JfhpMVyZbR44Ue++0hyOwV1fFgmXSrSMC6rY8XQPraGyQ5TEoVOOD1
         Nu5u8y18Eos4Ru5S/2S9FiacZgOI8eLBmWU8e8IAoWdWaidCNHHBuzJ7p4O0QMLjMiuu
         uXLI1CEDTu9ZnziYXRN2SiH5d3nwIEfCI1mrXlZcdaQqfMt+jKTT4RibKD3YGPwjtLdZ
         l4u9zgvKmrE1QquBfH0n3KpsgQAGee3GDRxa3q/EFdc+C7JIzHiWJfRmvH+dwU38Nul7
         673w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779312162; x=1779916962;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEAw/HLd2Gukf+rbP9FYe175TBnZFF3s9mDfNnhekAY=;
        b=pko65Q67dtQxdi9JBwRCClL7st41IszQn6n9u/vVFPWYyf4ASi0kv1ekjPE0BBp2Uc
         ThCfr/RIwSgw2QoHkxBRR7jelqA8OgqPR0xFI5NZLU8QkddP0DeKlvs1/+LTgOjFSy1f
         06NZgfkaZe1d0sMVWrYl2fBKt/ccyqtR9Iiz1oKN0reC0usytri0r24n23RJaqXPaVmO
         6h8w4KGInK3P6vaLtamwY0+BMJf9R84DPBZjpKBHDiPvq0gQCU2fcfZFXgpRZGMWK0qt
         YBfAQ36itsU1KZ3bXfbDqCWC0xySrwG6ga/XirYLpXKQ44DFaZx8CKtsuDHpyHzY877O
         v7qw==
X-Forwarded-Encrypted: i=1; AFNElJ+zHEU/BilywcjiBFK3OOPcs0YKSbH6hl6tRGZWfJBMctfqW0jR+z8of9yvdwhMhlrvZsb0wXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmxgMCGZoT4Q938bO6Dc/YUOkUfL8ZMN1oKYTg+yjPhfgdDrZ
	SY4dDTADXQYxffH3pMARGYafY2UDdRKTIKBXBh6QQwC26wP+yLJG9a8W
X-Gm-Gg: Acq92OFXrjKX4eLNW2m/wTD+s2hwqZVZP8a2Y5vZx2/ih3cj9Gmg91DYNINGqACfGWw
	X3XnhtlZZSqkKkUi2dVaIwgzLuzRbhqIJHCQEmWGg6BRWFxo771UB5kWE6wwLxgbnQi5dfYF0EX
	JP1RMIdjgXAGbzOV6b59bgmf2/1Qwgcqhv87PGViBrDZl0Kzk6b4ulj3D/9QDrcT08xYyCLqzxM
	u0XJpGZCQXpXY76Wopj/m03ejuJujF5ur8cp9m+0BNZgvxp7KPYbvKRnb/WLNS+uID1nAEtOxX0
	PMHjtbIbwdCXd970KjlNw5LcU5nxry38FCQ8L5pVRYX9nUZm/x+kJPLgI5XQQscLnonVW/O66w4
	Dp38ewgHxR49kcrcsX0+h9HdB4f83eLfcuMfvob5FN+F22rYahaa8OoR6Ai5d7FPhRlKCT8oQt3
	ffWsB5fKAffG4mocgy02W3zF2uqTKKgImLf9t76CMau+fxjqKgIXRDSgt/3DDI7t0RBJ3dJhrN+
	Uol
X-Received: by 2002:a05:690c:b88:b0:7c7:5111:5f05 with SMTP id 00721157ae682-7d20d123e00mr2059477b3.48.1779312162633;
        Wed, 20 May 2026 14:22:42 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc996b7d54sm57824987b3.12.2026.05.20.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:22:41 -0700 (PDT)
Date: Wed, 20 May 2026 17:22:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 cong.wang@bytedance.com, 
 stable@vger.kernel.org, 
 xmei5@asu.edu, 
 Weiming Shi <bestswngs@gmail.com>
Message-ID: <willemdebruijn.kernel.69dc20190163@gmail.com>
In-Reply-To: <20260520075736.3415676-3-bestswngs@gmail.com>
References: <20260520075736.3415676-3-bestswngs@gmail.com>
Subject: Re: [PATCH] tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290109-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,bytedance.com,vger.kernel.org,asu.edu];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Queue-Id: B404659CAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Weiming Shi wrote:
> In the SIOCGIFHWADDR path, tap_ioctl() copies 16 bytes of an
> uninitialised on-stack struct sockaddr_storage to userspace via
> ifr_hwaddr, but netif_get_mac_address() only writes sa_family and
> dev->addr_len (6 for Ethernet) bytes, leaving sa_data[6..13] uninitialised.
> 
> Those 8 trailing bytes leak kernel stack contents; SIOCGIFHWADDR on a
> macvtap chardev returns kernel .text and direct-map pointers, defeating
> KASLR.
> 
> Initialise ss at declaration.
> 
> Fixes: 3b23a32a6321 ("net: fix dev_ifsioc_locked() race condition")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


