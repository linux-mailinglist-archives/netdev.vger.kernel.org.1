Return-Path: <netdev+bounces-279857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGKbLcxd5ml6vQEAu9opvQ
	(envelope-from <netdev+bounces-279857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:09:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CD430A2D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE43930A043E
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99F3346A8;
	Mon, 20 Apr 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5KDz3qB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216B333445
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699747; cv=none; b=eXvfhq44sDNfilDA1ltlMw8KmVZrmqi2woReTJyI8+9rVclKcJsTpAdRzp6hkh5LPkTdOvPy2pD4UCQW8kRERh5D0dmP9NCJfKjaqjvK/VxYV/hfNXlXTKC5nY1gjSPaTrFdNXQ52xFZQspO+tfj2PYzN8YG0T47an19kSSoyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699747; c=relaxed/simple;
	bh=44qe80/QSt+UsH5belC7Uf4kOLbqbaTN9nU607Wf6AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMGEw9dOFHaCV9GVJjffu3BorXclZxZDh39aJ4bPLv6Tq0KTr+cBFavTRc4TFtDVgX4c3j51dSYFpSYUR/5PVZfU6CyfPD+Jf4vLw+Wta/JL6GEwIzvTJAGpZaOZlMrFX8c6OUz46K6UJ7exZnfrfGXldYTgg0KZiu+nu/a9mEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5KDz3qB; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7dbdcb85067so2832027a34.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699745; x=1777304545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjg0skzP3DdQUa9EcuJqwNG3yFODQ5AzDlPtuY9w8s4=;
        b=N5KDz3qBJkQYY0kuxbJNvJ9VvySCT4ouS3fwGjAYd7EJFwQb495ltujLtOOjgxEnOA
         CkUqIfCoJXk1VRXET0/ntqbAACz6VhsFMuq+dnG0XQxB1sTXMwhM2X1PijFhiwVsoLLy
         8mRTkB+EXPqRZm4uygVlwoxcLitft8nDkJjiFFbDdw4LpGXFysdHCxqUT61pJnYGH+Fp
         alcbsSwhZpPqVx/ETxQp/vm151eN1iCeVZg1+gi/o/OZgM2BXP1tXCLsI+eUIoEh+HqR
         26x2HEBDIs0LFeitMzltn7yeBNNIu2G5PYIO/uOGs3LM5is9MjYboXZFb2RVOIn7E4Jp
         op0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699745; x=1777304545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjg0skzP3DdQUa9EcuJqwNG3yFODQ5AzDlPtuY9w8s4=;
        b=Dkb8obzEbBKWtNvPLt2PgNIRsQ8ycfJdH/cE/OQvgJYpG716PvWkcgaPsAzkS+Pdsa
         uvaHnRizTCYoWp43ygGbaK22lw6KBGdNHXuZQ93ISP6JYjWXRRAMuAiEkm0ZJijppoYv
         l8aglhRU0oJWif2nxvecPIy6CKsRXUZTUk2/N9TI3OgUKlbUXJsDKU3XwaRewfFdf78v
         7o5KdPOz06Rc3oEuSKZ1d+4F2hDteX9fx0BygC/u9wTH0PpEgXAz+cNr756mWjkws8Zu
         mUQMKYr4WTG7TCaTLoHcj7uNFbjQ1gFpoa+VB1IxEV5dEp5JnWBMaf1OqJaXWzwahF1E
         OeSA==
X-Forwarded-Encrypted: i=1; AFNElJ+BMFBBKV2wK+wfbAkponaaRl+rc3slkdgun+ustKmymgf0i8muG9hoi00lZmeQedyJYhdt+Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8DxY530sv4g8NCQdewZO0FXdzWbWOhgyr+kcNoAkdAvgqaln
	g/CbdpJnqVp6ZZKZ1DCmxjtdQqNr3KxksRKDmV4pOm6hYGOup+0BGUDmDsj12ZNr
X-Gm-Gg: AeBDieuOk6FMIq9URWi7HU20XVj5p7s9GIBHM2GCDrk5bPCYAqy7j85G8FInafW8szq
	aplcTTJLvo6pUIwSAFI+xAS6QueJEQQTXWHn0xRJz7nYs4S7YVnYclKUfpgBQY2VHZFTf8lqE/Z
	MmRDl/EhWmm3LRpxgc5r3RYrpgkUCuZJ764wWvjHbwVx/lsvcjtpqtNtu7fqq9t13U54XIPXUgb
	X+fr0+GdK45bHQK5FTEODZQXsYKG4GBY0htEQB2KJzHtkhq7+dVyl0CkWLbxU+MC1kBMrPaYqDV
	Tc4xJDYIPFeFMF1YaLyshgT6//5yJTIWzOm5ZyGifnYisSf4wACEigZEOvTPZbG414gr8fJTFMl
	f0wsbL7jVXc//3dSwJ2r77akcILOIASAm4ykoW9RrFpDzeFHWRUaRtziQxbM7MB8rZupXsG1DX+
	s1OhaauZVOGkDckSgEkQcgHLLp76uT
X-Received: by 2002:a05:6830:6724:b0:7dc:c4ae:a679 with SMTP id 46e09a7af769-7dcc4aeb1c5mr1428895a34.9.1776699745301;
        Mon, 20 Apr 2026 08:42:25 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc892c515sm1707582a34.21.2026.04.20.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:42:24 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:42:23 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Message-ID: <aeZI3ig6w0PhGaVU@devvm17672.vll0.facebook.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-2-kerneljasonxing@gmail.com>
 <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279857-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,tencent.com:email,devvm17672.vll0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 573CD430A2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/20, Stanislav Fomichev wrote:
> On 04/18, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> > 
> > Fix it by explicitly adding kfree_skb() before returning back to its
> > caller.
> > 
> > How to reproduce it in virtio_net:
> > 1. the current skb is the first one (which means no frag and xs->skb is
> >    NULL) and users enable metadata feature.
> > 2. xsk_skb_metadata() returns a error code.
> > 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
> > 4. there is no chance to free this skb anymore.
> > 
> > Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
> > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Actually, I take that back.. While looking at patch 2 (which always
confuses me with that -EOVERFLOW handling), looks like we set
skb->destructor in xsk_skb_init_misc? So this kfree will do
xsk_cq_submit_addr_locked? Not sure that's what we want? Should we
move xsk_skb_init_misc to happen after xsk_skb_metadata?

