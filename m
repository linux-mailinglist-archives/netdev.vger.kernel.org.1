Return-Path: <netdev+bounces-275091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMGYBfTVz2kQ1AYAu9opvQ
	(envelope-from <netdev+bounces-275091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:00:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B96395712
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02BCC30334D9
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392793C6608;
	Fri,  3 Apr 2026 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Pek+yKed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12A3C554E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228352; cv=none; b=tChME/LDspBm67H65m402GasoAHOAS0BMtf65XGr5u3l6+44NmiM7J6K/P1DOyaUsnC3gPt1SaRyPvWDRVj48CgUYy4op0kdn9jhkxiXZpIiOzeQj5cXYuoQrWIbKg6u4kRxFKX9sWRNos8uJz+78dc0NKw8G41XsomTtqLXfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228352; c=relaxed/simple;
	bh=Xbc4Ra681nc48aNuM3ATdRJApIcuteTB0BIdE8dIwPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnNuY4a9MPgrupB7u3mrrQ6LpOSpmKBxCtnQaspXiXaPqY5wGsvc9xFw9+Xs5tVKuQ84VYbS2OJ0sDHaArjcYzE02Q1o/0T9/+igwfTz8B+qii88LuQ0LJFRAH6MgGDct74uHtf/VWp9S2ejQndwN7b8Hg/P15ahaiFycQUlkUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Pek+yKed; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so1122544f8f.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1775228349; x=1775833149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGPv9Bco5NsmxbV6+XT6L0Y0xbtKDX3C4wt1tJqNE8Q=;
        b=Pek+yKed/p/gP0CKwElduNgaMtMzNXgHpli/3hVJJy9b4yXOlHNwa9ASUHroWDKE8f
         kpE1Z1thIg27hYOkyG3HOakIQF+dyX9fCUOENEklsGb7/iowZbKCDrvABvsKgGmmHyzs
         wM3DT5p2WjKWNUEva529aI2iiR/Sm3lgQMdF3kHOYzCKioEJOkKfRfL63v1PdRfH9nrz
         DShwFKmIzNoA26P+eFj/JTz8JB5Y5Lq9ia9Pub6n5Xj4Gfb6oumQPGh4f33CRG1sKPpJ
         TacuG7aWQVBV+h+vPmgn+rRq4xV2sFJYWHu1QnoT0uXx1VMcaM6Dhf24/KOq6bRcncfL
         RNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228349; x=1775833149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGPv9Bco5NsmxbV6+XT6L0Y0xbtKDX3C4wt1tJqNE8Q=;
        b=Po4UPBLrffdDebjt2qKjgq84+9hWiunhQNuqOfVrBeV6EY8piWnDPYG0wRWRFFnh0p
         uxZqiHP28LLzaCreZ39dERzNgXkNBQUjUrCVqQqOrglprJ2QqK3XwWb9HEIHNSXzTZ7A
         n15GMIK/MJHQjOonzZNjK5BAi1/KS5y6qj0ZX9n0yJ+0teyKRrjKsV3hBIdaWWyHajjy
         g8L38A2BkJTL6Yow9cltY25jfGhKjnNROuXkf3ly/V8HclXBA0/qJi1nkiZzFvCNy0HX
         aHPewJINu95qM087s/xXfOuh9nNZoYpP35ziPF1c0RRdekFDasyQ793lGW3LrcmGR+gf
         gYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkmMYlRg/OJT7fNt0rOVvF4j2hh8x46nA+QMTB48dy38rF6cMVn4dsb3OrDCaVd/Yz8tjxtQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXDrtbY5nV14EJW3XWdqK6DRR/Q5ElhSIJ+BecXYWyiMKge5Z
	Yo8isUVdg6uykwMA7G5mEOoKSlueBbWOPATHNORJ6zXQE4Sivn0oui/Y8vV+wpseQWI=
X-Gm-Gg: AeBDieuRFZh/JGAL9iN4dUCQbv0EZ6du8rawLaGU+eT7hQiSBOLrqL09WzkGslsrjDh
	2JYZDT6wVcH+odWqYlOu4f7ndwP34UxXy3WI/y2Iox3y7HKUsOSGvGtkNKd4nCyl9qQ8iV27pPl
	MU3nKaJoUIIXLm3wT+X7UITf6PSUAuyT818xEy2molAcLVB6z5l9y6jlu2IEk8m3SOGjUpl58LZ
	ev4FcX2KBmXugVNcvqlw8wr0I0yYbivlMLEUHJVjZtLdQw5YJjMaraKOZpG47/xBTFsPAhcWC9U
	k7vgtVJ3vkLuioWfOg7BiEiTFefR03n7Qf5+oj3Iu7+sBaPty1X3Lt09yonQ5hkASwgbX0b/C2+
	PuldTLLEE7W865xs04qLwe7sdzF6z9ByBaAMGAMlpzsEV0J7ClN7PxtO0iDlYBE55BdgH1w+90F
	tYY+LX9Moce0qlkME4B89ejddyEV28S535xjV4w/9b0a9fh1GLCYrEeg==
X-Received: by 2002:a05:6000:4382:b0:43d:60d:944b with SMTP id ffacd0b85a97d-43d292f1452mr5756991f8f.37.1775228348596;
        Fri, 03 Apr 2026 07:59:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f1a99sm18426635f8f.32.2026.04.03.07.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 07:59:08 -0700 (PDT)
Message-ID: <98bdaf08-6bff-4ea3-9e74-65b41da1447b@blackwall.org>
Date: Fri, 3 Apr 2026 17:59:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: guard local VLAN-0 FDB helpers against NULL
 vlan group
To: Zijing Yin <yzjaurora@gmail.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, petrm@nvidia.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260402140153.3925663-1-yzjaurora@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260402140153.3925663-1-yzjaurora@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid]
X-Rspamd-Queue-Id: 41B96395712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 02/04/2026 17:01, Zijing Yin wrote:
> When CONFIG_BRIDGE_VLAN_FILTERING is not set, br_vlan_group() and
> nbp_vlan_group() return NULL (br_private.h stub definitions). The
> BR_BOOLOPT_FDB_LOCAL_VLAN_0 toggle code is compiled unconditionally and
> reaches br_fdb_delete_locals_per_vlan_port() and
> br_fdb_insert_locals_per_vlan_port(), where the NULL vlan group pointer
> is dereferenced via list_for_each_entry(v, &vg->vlan_list, vlist).
> 
> The observed crash is in the delete path, triggered when creating a
> bridge with IFLA_BR_MULTI_BOOLOPT containing BR_BOOLOPT_FDB_LOCAL_VLAN_0
> via RTM_NEWLINK. The insert helper has the same bug pattern.
> 
>    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
>    RIP: 0010:br_fdb_delete_locals_per_vlan+0x2b9/0x310
>    Call Trace:
>     br_fdb_toggle_local_vlan_0+0x452/0x4c0
>     br_toggle_fdb_local_vlan_0+0x31/0x80 net/bridge/br.c:276
>     br_boolopt_toggle net/bridge/br.c:313
>     br_boolopt_multi_toggle net/bridge/br.c:364
>     br_changelink net/bridge/br_netlink.c:1542
>     br_dev_newlink net/bridge/br_netlink.c:1575
> 
> Add NULL checks for the vlan group pointer in both helpers, returning
> early when there are no VLANs to iterate. This matches the existing
> pattern used by other bridge FDB functions such as br_fdb_add() and
> br_fdb_delete().
> 
> Fixes: 21446c06b441 ("net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0")
> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
> ---
> Tested on Linux v7.0-rc5 (upstream tag) with clang 20.1.0, KASAN
> enabled, CONFIG_BRIDGE_VLAN_FILTERING=n.
> 
> Bug independently reproduced with the attached C reproducer
> (repro_br_fdb.c). The crash triggers deterministically on the first
> run with CONFIG_BRIDGE_VLAN_FILTERING=n on a clang-built kernel.
> 
> Exact crash signature from reproduction:
> 
>    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
>    RIP: 0010:br_fdb_delete_locals_per_vlan+0x72/0x3f0
>    Call Trace:
>     br_fdb_toggle_local_vlan_0+0x3d/0x1d0
>     br_boolopt_toggle+0xba/0x1a0
>     br_boolopt_multi_toggle+0x129/0x250
>     br_changelink+0x1100/0x1490
>     br_dev_newlink+0x115/0x190
>     rtnl_newlink+0xe15/0x25c0
> 
> Note: gcc 13.3 with the same config optimizes away the NULL dereference
> path (UB elimination), so the crash does not trigger on gcc-built
> kernels. The code is still incorrect regardless of compiler behavior.
> 
> Reproducer (C source): [PASTE_URL_HERE]
> Kernel .config:        [PASTE_URL_HERE]
> 
> To reproduce: compile the C reproducer with `gcc -static -o repro repro.c`,
> run as root on a clang-built kernel. The crash triggers during
> br_dev_newlink() -> br_changelink() when the boolopt toggle reaches
> br_fdb_delete_locals_per_vlan_port() with a NULL vlan group. Note:
> RTM_SETLINK on an existing bridge may not trigger it due to different
> code ordering.
> 
>   net/bridge/br_fdb.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 0501ffcb8..e2c17f620 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -597,6 +597,9 @@ static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
>   		dev = br->dev;
>   	}
>   
> +	if (!vg)
> +		return;
> +
>   	list_for_each_entry(v, &vg->vlan_list, vlist)
>   		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
>   }
> @@ -630,6 +633,9 @@ static int br_fdb_insert_locals_per_vlan_port(struct net_bridge *br,
>   		dev = br->dev;
>   	}
>   
> +	if (!vg)
> +		return 0;
> +
>   	list_for_each_entry(v, &vg->vlan_list, vlist) {
>   		if (!br_vlan_should_use(v))
>   			continue;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


