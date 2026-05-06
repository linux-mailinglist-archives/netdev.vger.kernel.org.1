Return-Path: <netdev+bounces-284703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ffu7H3LR+mk2TAMAu9opvQ
	(envelope-from <netdev+bounces-284703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 07:28:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C281E4D64AA
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 07:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F066E3012E89
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 05:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43E2FE074;
	Wed,  6 May 2026 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZaCWRu1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135C2D1907
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778045294; cv=none; b=b4hTl8MyQ0wCPOCk0AJT/K8tzSzYqCQ6yQUP45CBNCospdrXFYoLi4utLFSiyFVvp1Oj8rRacYOHHKPSHLMMlzIySZSP+S2fp8S6rLcmuihVhbHnqRDNH8qeS8+AMcj9m5QryrbK4EetwJW0Bkts0QZghF8OVqh2oAg2dg7j6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778045294; c=relaxed/simple;
	bh=R4/Nb55H82dxLsUwa93a1bVV1PnW+s3jp/QrCouACwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MpxXKcwwS9B69vQNKaNLHvW7W4Je/JCILrMbXuze01WENwQDWkgVkKhYnopotHTMmT8jGrC2c8Ji1NgKdpYTa3wDct1gbccVAdYsJMG+jS0ee2ZhlZdG04ijl0P65uoj+5VdlvGJPPEws1wnZ99v8ysE+PNR0EAhjmP3hX0lfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZaCWRu1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbaada2f3so11108144a91.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 22:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778045293; x=1778650093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m47zHgEiDR9fbW1scQRVClIJzCPKz1PBLPZ9osVCg=;
        b=AZaCWRu1S5Vb4XoDL5qmOWQOZNh2f2LCD9wcjfiKmQ537qcAoLt3r6TDGwk/tT1bqu
         mVQGlR1rUKsfK/ak8Su24ZjcnOFx/QqpxxNy80Lgyn6iPJr+JCxYFKIK5y+/Lac8bmKg
         aJW+7PqhHQZEl5Gs9cS1mWcL+pw4Waz3Ma/PZv6YMLGSuHYvdIL+1+OM4spw9DdgGOJD
         IFYdV64X023IFJVV9mPJy56TbYYKptcrbrS+/NR498XFeTlSWyO9Tkts/wEJZWgYX9DY
         vRcKB1kOQAOdzR6eGgTmaV+P51zLFfe/yUI1FI+Na4s3l7I0hvvXyKDPJpPL/WJ6oD2/
         iXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778045293; x=1778650093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m47zHgEiDR9fbW1scQRVClIJzCPKz1PBLPZ9osVCg=;
        b=ZVsXXFANa+IZt0vU04pxoHqZfuStAtLRPyS+nm9uTiWBO/L/5tw1mmO/0Qb5wrPC8Y
         8qC8pytwxL3pf1xaFQdJbS3h8EgMD7Tfi6ofOxSeSnhxUCAef5uJiExGbdCa594agT9n
         hgd/m+bGltNyKUgapoKMfITqyIG28HmPJTYj5LOUwIp+P0cojc70XGNGy/9augKp397J
         BnmKipbPWf8Da4v3u3E+0g2Q2zybUo9ZMHzKKBXaQnyaIBcZ9OuerUwWVsXShG+8KDEi
         1PZORzlvjdRiaVblg+nizCyss6+ezGJXRpRoMz8ADdyEHAwcKoyk7/naae9WMuDd8/HZ
         tqtQ==
X-Forwarded-Encrypted: i=1; AFNElJ81AwVliFMK/VE90vSt5q0UQGWubbFmi/0ksIVEtiuUC22CGIZeYP5JHzcFPprqfvsVKMWbEzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH79cALQGxu/tOe8lMbKFC8yT+/5lvgOBasaSahdomwYliuvym
	e3Rpw9XpD0uDSXqlx1yqh1LR5F5SjCWsbsAuAjEi9YfyKwVqjDlRwuCdKVddAj0CM0U2TlckLkh
	ZT+VuPA==
X-Received: from pjbcx22.prod.google.com ([2002:a17:90a:fd96:b0:364:df06:9c9e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e49:b0:361:423d:203d
 with SMTP id 98e67ed59e1d1-365ab9d9fb6mr1697790a91.8.1778045292634; Tue, 05
 May 2026 22:28:12 -0700 (PDT)
Date: Wed,  6 May 2026 05:26:56 +0000
In-Reply-To: <20260504133626.4155933-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504133626.4155933-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506052809.1613281-1-kuniyu@google.com>
Subject: Re: [PATCH net-next] ipv4: Flush the FIB once per dev nexthop removal
From: Kuniyuki Iwashima <kuniyu@google.com>
To: cratiu@nvidia.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C281E4D64AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284703-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

From: Cosmin Ratiu <cratiu@nvidia.com>
Date: Mon, 4 May 2026 16:36:26 +0300
> When a device is going down, all nexthops on it are removed, and for
> each nexthop being removed the FIB table is flushed, which does a full
> trie traversal looking for entries marked RTNH_F_DEAD and removing them.
> The performance of this is O(N x R), with N being number of dev nexthops
> and R being number of IPv4 routes.
> 
> The RTNL is held the entire time.
> 
> When there are many nexthops to be removed and many routing entries,
> this can result in the RTNL being held for multiple minutes, which
> causes unhappiness in other processes trying to acquire the RTNL (e.g.
> systemd-networkd for DHCP renewals).
> 
> In a complicated deployment with multiple vxlan devices, each having
> 16K nexthops and a total of 128K ipv4 routes, this is exactly what
> happens:
> 
> nexthop_flush_dev()                # loops over 16K nexthops
>   -> remove_nexthop()
>     -> __remove_nexthop()
>       -> __remove_nexthop_fib()    # marks fi->fib_flags |= RTNH_F_DEAD
>         -> fib_flush()             # for EACH nexthop!
> 	  -> fib_table_flush()     # walks the ENTIRE FIB, 128K entries
> 
> Change that so that a nexthop_flush_dev() does a single fib_flush()
> after all nexthops are removed. This is done with:
> - __remove_nexthop_fib() no longer flushes the FIB, instead returns
>   whether a flush is needed and is marked with __must_check.
> - __remove_nexthop() and remove_nexthop() propagate this return value up
>   with __must_check.
> - A new wrapper is defined, remove_one_nexthop() which calls
>   remove_nexthop() and flushes if necessary.
> - The two direct callers of __remove_nexthop() get a WARN_ON, since the
>   nh about to be removed should not have any FIB entries referencing it
>   when replacing or inserting a new one.
> - Callers which need to remove a single nexthop were migrated to
>   remove_one_nexthop().
> - Callers which need to remove multiple nexthops keep track in a local
>   bool whether a flush is needed and call flush once at the end.
> - This is plumbed through group removal as well, so when removing a leaf
>   nh causes a parent group to lose its last member, the group's flush is
>   also deferred, accumulated via remove_nexthop_from_groups() ->
>   remove_nh_grp_entry() -> remove_nexthop(). remove_nh_grp_entry() gets
>   a __must_check as well.
> 
> This dramatically improves performance from O(N x R) to O(N + R).
> 
> Releasing a nexthop reference in remove_nexthop() now no longer frees
> it. Instead, it is deleted when the last fib_info pointing to it gets
> freed via free_fib_info_rcu(). All routing code is already careful not
> to take into consideration routes marked with RTNH_F_DEAD.
> 
> Tested with:
> DEV=eth2
> ip link set up dev $DEV
> ip link add testnh0 link $DEV type macvlan mode bridge
> ip addr add 198.51.100.1/24 dev testnh0
> ip link set testnh0 up
> 
> seq 1 65536 | \
> sed 's/.*/nexthop add id & via 198.51.100.2 dev testnh0/' | \
> ip -batch -
> 
> i=1
> for a in $(seq 0 255); do
>   for b in $(seq 0 255); do
>     echo "route add 10.${a}.${b}.0/32 nhid $i"
>     i=$((i + 1))
>   done
> done | ip -batch -
> 
> time ip link set testnh0 down
> ip link del testnh0
> 
> Without this patch:
> real	0m32.601s
> user	0m0.000s
> sys	0m32.511s
> 
> With this patch:
> real	0m0.209s
> user	0m0.000s
> sys	0m0.153s
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Looks good, 3 nits below.


[...]
> -static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
> +static bool remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
>  				       struct nl_info *nlinfo)

Since you added __must_check to other functions,
remove_nexthop_from_groups() should have it too.


>  {
>  	struct nh_grp_entry *nhge, *tmp;
> +	bool need_flush = false;
>  	LIST_HEAD(deferred_free);

Please keep reverse xmas tree order here,


[...]
> @@ -2701,6 +2717,7 @@ static void nexthop_flush_dev(struct net_device *dev, unsigned long event)
>  	struct hlist_head *head = &net->nexthop.devhash[hash];
>  	struct hlist_node *n;
>  	struct nh_info *nhi;
> +	bool need_flush = false;

and here.

