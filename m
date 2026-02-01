Return-Path: <netdev+bounces-255586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP58AnEWf2mCjgIAu9opvQ
	(envelope-from <netdev+bounces-255586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 10:01:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72952C54BC
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A99D3014773
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B931A06F;
	Sun,  1 Feb 2026 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK9lUsSg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1PRsJnp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65192882B7
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936489; cv=none; b=dmDqUeVT8DCquT9+4R4MxO74B0numDbz9lS9f5mVeegQpQ0kNO238BZ5rwmqGxO4R99doRAKzb6gR2ix2W6yqJfVHN424vwD6T/bFuFRj2B1Wp8Wny264LOLyT5Jy31T6hC8TEfxALrab1t/2GVTcWWc+gtFYdnxhj7Z37Wc+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936489; c=relaxed/simple;
	bh=uLCjGvitM7MZI+iiZOhsAyamc3vLUAP3Bnzyj3zmxmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/KscdZdfoxuoMXsw2/21F/qNhbPvxxlduKnGrbnBes/fLUKV64X6+/VHgHJYu96/bFgb1qTJvfYe+GB+Sjo3DfBilpz/B4rWQg5wf3rDpqTp7XSaDf7guuSi8MH92sNyT2DMnu8sPvGVaXRPiyG1cI4pwqmznCImnWU/ZVZCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XK9lUsSg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1PRsJnp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769936485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbdMtd8ZV0Hoqg/gvmWguCwsRV3oQaDigUGA5FFlPEw=;
	b=XK9lUsSgv5NmGKEW2yTbUcVZFlIN3gn6FVpOPZzTGj2iAkW6M30LRWxWBpmXbgMYy2zEx4
	UmOIm8j8nIfsLX05vipwZJ4njvGoLoJmOMchwA3pBhCJKiaE7YOXEPMnz0TBmZOaKHP1uf
	Gh9ewvy+u49vmQVe2LPZZ50PPddgPA0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-UIfcD8SLO5G2q70SIwIGGw-1; Sun, 01 Feb 2026 04:01:24 -0500
X-MC-Unique: UIfcD8SLO5G2q70SIwIGGw-1
X-Mimecast-MFC-AGG-ID: UIfcD8SLO5G2q70SIwIGGw_1769936483
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325cc15176so2182656f8f.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 01:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769936483; x=1770541283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PbdMtd8ZV0Hoqg/gvmWguCwsRV3oQaDigUGA5FFlPEw=;
        b=U1PRsJnpLnDt6xCnPPIfMra8LELIvxROw7qE+hyB2URGbVFeGBJYqSDEMOJTQHzdz0
         sDU/W86iLqgbUjCCjzfMTgiU1RUqOMJX4JYQ0GkjXnFS9s+vz2IFyaZW2m+2IpTBPcnL
         aUkKcz2iMSl9NkFKMkFjzOqGutRASDRxfHCHm15rFQHSvFKhQOG87K8K5aY3Acvgq2jM
         tq0Pm/CPPV7qmTU98/vkqmKTyQXUECl0Elpu9fFtMSj3Sq42fkHau7FchxSsoW7j+wny
         +R1Zm2Eg7mDrF1pwYypkCy5597RqUFl3s47MSvwzspuQwKubwTmJnQjzE9Ny1gG/YxQ8
         sDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769936483; x=1770541283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbdMtd8ZV0Hoqg/gvmWguCwsRV3oQaDigUGA5FFlPEw=;
        b=oL5hJkJ5uoF1LglONeIvN6nIlAmTME7eXpHy6sr98MEnf7qn0lw4oEgs5j6+dNJCiK
         kOO6kBxAADGpPYb4zmxX1CzElFtMdSNVvEO6NaRxK9cuOfov1qfQKcXPz6kxgX7wyikR
         OUQh76IIYPa3LQS64/dMb8QyOqkRhqE2j9R+Z4T1hMPYKcnWA+OhLH4t+AZR38eFXE8E
         yd9mtIX5CxkNeBSG1akiYLQ2xA+2AclxTnqISXCsHZHlDkMUH5uusj9e46kNPeesPdug
         fvLJ8WA1fJi4hZ9bITUGbBmA4OmCny2Z9RA/q0dCEWhqHa7VFzAn0JzmcTOL2dRb0KSj
         Nsaw==
X-Forwarded-Encrypted: i=1; AJvYcCUuYMqhAaQntQUcKgMWE27K7iBJxxTdfXe9n6m5nXpV5FhhS1r8Jbrdy7wOCwdcI+kB/0TDzNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyunLyUqjPRM8vRZlEvZPB5+Y1e5KNzm3t6Q7GttKAdazTxwmP
	dw4ibDSDe889+OPdhV2jlX7/dnPTUf/m5HENUrAouLHYeIo+RF0BPUqwU5hjk0U23pW6Oy6I+3e
	zsMV6cPUh++HJOa6HBX7SUwH0Ci/NCkIOGZpgrw3ehbgt2WPEmpH+M1opxA==
X-Gm-Gg: AZuq6aKBTOozPRQ0VGdU06XXBDMKPDuR0atEGRvrLls7xDsfM8g0hoPzTDDs0XoRJ8L
	X+2ueDJ9pf8P2lQJL6jvs+7UZAqU5/+OaTqHkGC3pSFpN8W9TPjvD4Gq5Z17wZoAbPaMzVSxsm6
	g/CEz5yv9CRdi7ERmRKhw3nnrvyZ95CrwAok0NzvC41JuxXHQwGxdCPyJpAi16v5QjbHFBoZun+
	pT1xKwMGcC8mlmZSETzX4Bfu/ndF3lVDIFU6VhnqPCtzC1CRa8RboIDhSWiOj3oiEjpJk032fef
	k0fnZfv0yPgDSKht/duqUVrHcb1H6TT4NiKEKPk5wvw5u7I6WT1VSDac/r6vgAjw/azuNKj5so6
	GU91sexj3+ehZXFa0qSn9pgyaxFsTFSIGgA==
X-Received: by 2002:a05:6000:2883:b0:430:f742:fbb4 with SMTP id ffacd0b85a97d-435f3aaea5bmr11593875f8f.43.1769936482925;
        Sun, 01 Feb 2026 01:01:22 -0800 (PST)
X-Received: by 2002:a05:6000:2883:b0:430:f742:fbb4 with SMTP id ffacd0b85a97d-435f3aaea5bmr11593790f8f.43.1769936482295;
        Sun, 01 Feb 2026 01:01:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce70sm36590005f8f.27.2026.02.01.01.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:01:21 -0800 (PST)
Date: Sun, 1 Feb 2026 04:01:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: tariqt@nvidia.com, linux-rdma@vger.kernel.org, shaojijie@huawei.com,
	shenjian15@huawei.com, salil.mehta@huawei.com, mbloch@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, eperezma@redhat.com,
	brett.creeley@amd.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v1 net-next 1/3] net: update commnets for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
Message-ID: <20260201040043-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260131225510.2946-2-chia-yu.chang@nokia-bell-labs.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255586-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72952C54BC
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:55:08PM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> No functional changes.
> 
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Subject: comments?

> ---
>  include/linux/skbuff.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index e6bfe5d0c525..30a8dc4233ba 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -671,7 +671,13 @@ enum {
>  	/* This indicates the skb is from an untrusted source. */
>  	SKB_GSO_DODGY = 1 << 1,
>  
> -	/* This indicates the tcp segment has CWR set. */
> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
> +	 * subsequent segment in the same skb has CWR cleared. However, because
> +	 * the connection to which the segment belongs is not tracked to use
> +	 * RFC3168 or AccECN (RFC9768), and using RFC3168 ECN offload may clear
> +	 * ACE signal (CWR is one of it). Therefore, this cannot be used on Rx.
> +	 * Instead, SKB_GSO_TCP_ACCECN shall be used to avoid CWR corruption.
> +	 */
>  	SKB_GSO_TCP_ECN = 1 << 2,
>  
>  	__SKB_GSO_TCP_FIXEDID = 1 << 3,
> @@ -706,6 +712,14 @@ enum {
>  
>  	SKB_GSO_FRAGLIST = 1 << 18,
>  
> +	/* For TX, this indicates the TCP segment uses the CWR flag as part of
> +	 * ACE signal, and the CWR flag is not modified in the skb. For RX, any
> +	 * CWR flagged segment must use SKB_GSO_TCP_ACCECN to ensure CWR flag
> +	 * is not cleared by any RFC3168 ECN offload, and thus keeping ACE
> +	 * signal of AccECN segments. This is particularly used for Rx of
> +	 * virtio_net driver in order to tell latter GSO Tx in a forwarding
> +	 * scenario that it is NOT ok to clean CWR flag from the 2nd segment.
> +	 */
>  	SKB_GSO_TCP_ACCECN = 1 << 19,
>  
>  	/* These indirectly map onto the same netdev feature.
> -- 
> 2.34.1


