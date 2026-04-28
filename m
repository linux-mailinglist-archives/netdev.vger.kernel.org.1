Return-Path: <netdev+bounces-281874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMfiFrS18GlwXgEAu9opvQ
	(envelope-from <netdev+bounces-281874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:27:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF244485D1E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9814F331DCDA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8724343DA3F;
	Tue, 28 Apr 2026 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaZXGc2n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="toxJn5ke"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18D43DA4E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382005; cv=none; b=IzX1UkI8j+udgj4T8O+WgieD0gAwFL+YGhmg6lzbNJDTiYePISvOq4IYzgBa/nbmQEgGrQN89v+z3NPOstl6h6N1mYX6T74BoVhk8iyy3HsQWcKpMMUOqipgkM46SnCBHjG8ycvthMxJ/gcvA+ISwpB7nIi/ikuw2ChIMAa0EVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382005; c=relaxed/simple;
	bh=WLTyOgn6Yo2LBw9Q51BSSkcRxJInShuvEO903qRo0V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX5nZp/BghWs8K87E1VDrryuDEKLaDseUTVwBtBKjBB4YbKB3OzDFUlRt7KuiM1WwIoxTNp3/l3O8I1FjLHRwbwGTPSCcZQ83MgboFSD4Vl+jiOEL4FaJLEkiFARggyOPMQBR6xh1LAlJQTsXHQ3taHTEkty2ZHwqWeDzUIRooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaZXGc2n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=toxJn5ke; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6UCJWpe6oz0LWXsTSAYtgVExWdfBVYtrUT8ubfZ6Y8=;
	b=EaZXGc2n5ukuUGfshb2VG82qMAmKtWyEhb3kr/3mKyuaE8D8lQ0keK+ozmRuIu4VwQ+env
	gEa6fFNXo4kKky6gitOYgeUVN2dPH8LPnt7kRCgUA4qyOV1RC3chO3bdfzdbZu8hXR9RMx
	sgKvaJ9i/evUC1uWIONCm2w0HWn2d3E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-tFInvSBFM3yNzPxTVn7w5A-1; Tue, 28 Apr 2026 09:13:21 -0400
X-MC-Unique: tFInvSBFM3yNzPxTVn7w5A-1
X-Mimecast-MFC-AGG-ID: tFInvSBFM3yNzPxTVn7w5A_1777382000
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso97774625e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777382000; x=1777986800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6UCJWpe6oz0LWXsTSAYtgVExWdfBVYtrUT8ubfZ6Y8=;
        b=toxJn5kewFPB/TPe+9eojtCYLkx/tJJ2WhHnqIaa5mCLpMOBdr8do4gHkU/nbw6YU9
         PXYK5J0AElbv87arcI+cWv0xj81xNBeAgDJ90cYT7J3ft9K/pmpgsaaYEFO3VEfGbON5
         pR+NWCj9tTenfoZI08bfmRHWCWNNXL7FOezsGxOTtPAEVMOko8SpWiBbmyfLwabnNBzp
         dW/aoVtPZkF4ISepaAgqk6sxDJCF27xpqZhtuxk/GKgV7VQxqR9OGpx1SA1AsgoUVto3
         bVVoACNJKTBDPd96qO/dyDd0ZheZgzAaMRSM7xx7BxFrlyUyKpvAPGteBNNzLKN0Vx6V
         FxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382000; x=1777986800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6UCJWpe6oz0LWXsTSAYtgVExWdfBVYtrUT8ubfZ6Y8=;
        b=bkmDWUKhi5abm86KQTxBnTElzEqyGaM5sMyHxd7OPr7Ak94HtpqZLWCJDd4J7OEg16
         9dCllSji6ZtWOqc62WaWgkx9FAPDGcti0pQ7h+3ZH0dUSG8HHOxkpJWgeInQaqWnFXli
         lxNYabVyqB4dBQ9FfMBFkd+jktZFnQe5kCkb0v3JiURig5WVKp3CZTotQxE109zotZax
         U7f/1fOAVGVj5jLzt/2BTA6/kJGRUCsf50mg1FVw9wzR1bFN8TDalijELYU2TUjiyg70
         sRglDsh5Eu8kBbQa5oe2ZYyqk6pZmEvvboE3NbRApd63Pupua/yIkuGsqEBugXk7pG26
         xTSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dpW/HsaqrKssaNpheux0tud5JkMS1uOGCwHCmuititoPK5WfLgLsWnrrg9AfZNOWbaoGYda4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUBFTjFPQ6uajpWj5zj6iDUqMQEMgh0pk1yC8m9+NxD/Q3z06
	snhHBP8I32K3SXOKqI/65c7/SUAQc5IdlcGBLB0jkerhxsxqyOSu7npfbkEL/KbQMvzfOr0LEZW
	PgwCjsh/KRMqJow+3KOzXPP9UtUDZQLWp3EA5yV+ZR2J0AP5l7+X1DawqLQ==
X-Gm-Gg: AeBDiesoL/bg5yngCg1FVzKNRmkJr7fwVfNyNl8O2fdDGwJNZRS1TJ9Z+sEgFT2vXyg
	xB7M6jgJKJbTDdb1rBb+qAS9G/wivFizAYY4iku4Kdhlpdilz5uqdb+pO9q1YdFSFx8JwdIG4C3
	ubX8PbIbsN7kfiFbaZIcJ5+19LEqgkmWOSIatbsy/KTTXUDhzY83LcT+Ehh5eps5I8MxIFquv5A
	tk5+fOOZdPnreom136+vpbjPZRYxxD4Sp35XBfi0h9EBB+JfNjl4/J+BQu1hyHu1HU230scF5Yh
	eFNDqXDTOM+qnpVSVshkMu4NTBq9zcRwaLirgtcjgXJ+cf10YHmztV9mvLwnruhzt0ebohX70aG
	+du731km7almvuuBedFQH3WmH/RE836pHWbf9S6cgmQPAmV2hl+UFuPENmtOT2oeC3g==
X-Received: by 2002:a05:600c:82c3:b0:48a:7772:c26b with SMTP id 5b1f17b1804b1-48a77b2608emr50277335e9.26.1777382000175;
        Tue, 28 Apr 2026 06:13:20 -0700 (PDT)
X-Received: by 2002:a05:600c:82c3:b0:48a:7772:c26b with SMTP id 5b1f17b1804b1-48a77b2608emr50276565e9.26.1777381999597;
        Tue, 28 Apr 2026 06:13:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775eb983sm18943475e9.19.2026.04.28.06.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:13:19 -0700 (PDT)
Message-ID: <99816901-6026-49ec-9c20-b548ed362d11@redhat.com>
Date: Tue, 28 Apr 2026 15:13:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 sashiko@lists.linux.dev
References: <20260424053816.27965-2-kerneljasonxing@gmail.com>
 <20260425054032.28A27C2BCB2@smtp.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260425054032.28A27C2BCB2@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BF244485D1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281874-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]

On 4/25/26 7:40 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] The patch incompletely fixes the WARN_ON_ONCE in skb_checksum_help() triggered by pure-fragment SKBs. It successfully prevents the explicit fallback in xsk_skb_metadata() (which wedged the TX ring), but leaves the implicit generic network stack fallback vulnerable. If a user sets XDP_TXMD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device and the hardware checksum offload is disabled at runtime (e.g., via `ethtool -K eth0 tx off`), the core stack's validate_xmit_skb() takes over. Because NETIF_F_SG is allowed to remain active even without checksum features, skb_needs_linearize() evaluates to false, leaving the SKB unlinearized. The SKB is then passed to skb_csum_hwoffload_help() -> skb_checksum_help(), which hits the exact same WARN_ON_ONCE(offset >= skb_headlen(skb)) because skb_headlen is 0.
> --
> 
> commit 86ab0a4900aa60bee0c3df7393a2846b5ff74ccb
> Author: Jason Xing <kerneljasonxing@gmail.com>
> 
> xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
> 
> This commit attempts to fix a warning triggered in skb_checksum_help()
> by AF_XDP pure-fragment SKBs. It rejects sw-csum UMEM binding for
> drivers advertising IFF_TX_SKB_NO_LINEAR at setup time.
> 
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
>> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
>> index cd7bc50872f6b5..d981cfdd853578 100644
>> --- a/net/xdp/xsk_buff_pool.c
>> +++ b/net/xdp/xsk_buff_pool.c
>> @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>>  	if (force_zc && force_copy)
>>  		return -EINVAL;
>>  
>> +	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
>> +		return -EOPNOTSUPP;
>> +
> 
> Does this still leave a path for the warning in skb_checksum_help() to
> trigger if hardware checksum offloading is disabled at runtime?
> 
> If a user sets XDP_TXMD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device,
> and hardware checksum offload is later disabled (e.g., via ethtool -K
> eth0 tx off), the core stack's validate_xmit_skb() will take over.
> 
> Because NETIF_F_SG can remain active even without checksum features,
> skb_needs_linearize() evaluates to false, leaving the SKB unlinearized.
> 
> The SKB is then passed to skb_csum_hwoffload_help() which falls back to
> skb_checksum_help(). Since the pure-fragment SKB still has a headlen of 0,
> won't this hit the exact same WARN_ON_ONCE(offset >= skb_headlen(skb))
> warning?

My take here is the issue describe above should be handled separately.
(And on top of my head I don't see an easy way to address it short of an
additional check in the tx path, which I think we want to avoid).

/P


