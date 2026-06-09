Return-Path: <netdev+bounces-297029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ZL5EyIAKGrv6wIAu9opvQ
	(envelope-from <netdev+bounces-297029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:59:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CDD65FC26
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:59:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MPY2Zide;
	dkim=pass header.d=redhat.com header.s=google header.b=S1Zkh6nf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297029-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297029-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE450310C811
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE7D404BF0;
	Tue,  9 Jun 2026 11:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D692404BF7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 11:54:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006095; cv=none; b=Ui51Q6sX37NjAx5PxHYGsyfFQsjvcPl3b59Fda3rO0jK6lIJv+CfXHuDanK2Se3IMwaAk97CT9UT2b6uCX+FDBokBS0C1piMJ8OZTGTbuci9qBOktUSrFnxaL/ChFHfKR74q/74V3MCbr2kW3pxrG9lWwnng0oD/mv9bte4/oME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006095; c=relaxed/simple;
	bh=pURGLEfOlHNz5lnARlNYJ5uYP4yxdHs6TZKb5qNNxWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNhOoJbAo02QJlMsvzz91DXQnzt75nxi3V6ymrXUAm+GDCROOsDEi4yXxcNww3gihE7L8zxxWy9Yd31AafKLE5tvR3to9ca69157RVAlloTzA8T2mhGJoL7eDhIwWWLZgp/wJqx5mfJ+rwWmlcRiqRLbeQzFYZQzIGcSXqYPltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPY2Zide; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1Zkh6nf; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781006091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dZ0b3532+qnimQ22844Y+HuqWQ6wMYq0EdeEWLSznM=;
	b=MPY2ZideULl+tqcDG1fU3Lmb9Hr+vKpDZlhyuE9/Tlp51FZL8/SX/b3E9yW+BF7eKxqEsQ
	tb4UCWsDGXWLUcx1Cq6i/Ds7OBNra+a1Tjdx6Mo3yVO5JxGZNHXagHT9hQgDuLBcPDCJaQ
	ZPY2V9jr6V35KYj8/u6Atqed+U0ESxA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-F1O2WzfRPDiXMhXxgko54A-1; Tue, 09 Jun 2026 07:54:50 -0400
X-MC-Unique: F1O2WzfRPDiXMhXxgko54A-1
X-Mimecast-MFC-AGG-ID: F1O2WzfRPDiXMhXxgko54A_1781006089
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45eec2ba533so3674856f8f.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781006089; x=1781610889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dZ0b3532+qnimQ22844Y+HuqWQ6wMYq0EdeEWLSznM=;
        b=S1Zkh6nftTyUm1VoiPGgTrQrsjXW4KC57vP2bN+vpseU0ggCpBh6ZPwk7FqrH5u5qy
         Vbtrw4m01SehWjXZkmZyUSgSaO1O7UaZ80GB+oo9R321Zp8HTFC3yeXzz11KxVpX5UXZ
         0od5AqM8xGfobkQUhmWHcjyMq5fwi+IHD7QQZjJr3PmNnfeZ4XoMSRMWIAdENTWlo5Fk
         BVcuflUWDa8z0Pm8iAvQTDOST+DB4y9aMNAbTs8xK+jGBncpMjt/Y7bfLibUv4Y+41sg
         4fcZHO6W8i71jSi8t7AgB5OFrJy0iYDG7IwU1qC6ZRRPxD29q2MfTdwK9KVOWeArC/b2
         7DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006089; x=1781610889;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dZ0b3532+qnimQ22844Y+HuqWQ6wMYq0EdeEWLSznM=;
        b=K0ElT92a+abxNgTBa3VdV8QPLRGXVtjjD/oqahV41D4V1gUBKWNsos5027jjPITOP8
         ID8av2Q086pkm7iIki2W0jNz3r6ojXJMQjCaI0KHTVMDSdnaOq+Q9Ztpl3rB36YEuu/9
         OwryEfP288f7R8xHCzY85+4j/SQqKkGdLUXoqWIZhTZkEiMTnKLXol5kZS5O0/zoRKzL
         8ZqICryC4ZJG0sbRkCPzzs36weygz2lN/vysE25vB8l7HefRjpu0rjFSi9B/jX2IAdxD
         Eync6s9//wvZ1Tn7K7Pm6Nvt9adYm4H3fC3/rlbRvp9Kuv/46fcdmP83+lajrPecCKSJ
         i1gg==
X-Forwarded-Encrypted: i=1; AFNElJ+4wbBwc8CWP9Qu3m62qd0yYh//fvpWlWR+WnA5yGLafD+/LNxys+o4UBUnxFNWf7cvNZCI+3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpF+/lUq3nAzDn2eATXG1s5bft/TmWCnOHsPdflWhglr0WGpcS
	kjHPbRLdORMnigTFfKKllKVhmT0lumBku4042yksfVftPzUc/mm+oxQ78ZMvdSikNyzjd4LsKAo
	nF6t6n0F5cvonGmuVCVGBhzp/kisbwjOT4Qa98iIWhuru3BC7eNX3MTclkQ==
X-Gm-Gg: Acq92OE5BfTTB91FVGZZbmJfT5OpoTIzFTMOIsUvn2Tzf7QMVPDt3sYg569Ox01YZXI
	eNb4ut5MhjA8yexTo1kZnVHSwfGPXi3pIlbitz92wLEA9mvzfUfFPWBaPTcUImTahJWlI1h1tdp
	nhIB+ic5GrRjbMLJBdLPKrKR1Ag8ZCqD5+6i2zvOs2/ygd2T5weH4Vmwxd9XWzRLPjQOm4iTl+z
	0Uk8K4mhBF06ixD6F2IuJsrF+6SRS8s+/qTAqPlwS8Jh7Hq2XbAvN6LuydM8f2Me5jE2ivyemcH
	2X9AhLhKHQ23gCA54r2An04xBkgpxpoKHJ/3byQsTp1eIWo/RNYb+HW1NqI0JNae8eD6wj1oVUc
	lloHL1gUD67qEG7uMBBBE3Gh/TGkPhPNhHFsqjCt8a3CHGhd4ThGZ1qHlc/WeHViwKA==
X-Received: by 2002:a05:600c:1f90:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490c2602971mr335847325e9.28.1781006088652;
        Tue, 09 Jun 2026 04:54:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1f90:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490c2602971mr335846755e9.28.1781006088273;
        Tue, 09 Jun 2026 04:54:48 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm67726434f8f.35.2026.06.09.04.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:54:47 -0700 (PDT)
Message-ID: <f5a3896d-7fbc-410a-b727-e910b6b182c4@redhat.com>
Date: Tue, 9 Jun 2026 13:54:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
To: Neil Spring <ntspring@meta.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net
References: <20260604212246.265079-1-ntspring@meta.com>
 <20260604212246.265079-2-ntspring@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604212246.265079-2-ntspring@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297029-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ntspring@meta.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4CDD65FC26

On 6/4/26 11:22 PM, Neil Spring wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7995a89bafc9..fc8e886f7791 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5020,8 +5020,10 @@ static void tcp_rcv_spurious_retrans(struct sock *sk,
>  	    skb->protocol == htons(ETH_P_IPV6) &&
>  	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
>  	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
> -	    sk_rethink_txhash(sk))
> +	    sk_rethink_txhash(sk)) {
>  		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
> +		__sk_dst_reset(sk);

Instead of touchin all the sk_rethink_txhash() call-sites, I'm wondering
if the __sk_dst_reset() could be placed directly into
sk_rethink_txhash() ? Note that this patch does not touch the
dst_negative_advice() caller.

> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 0a88b376141d..7a2b1de7487c 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -823,6 +823,9 @@ int inet6_sk_rebuild_header(struct sock *sk)
>  	fl6->flowi6_uid = sk_uid(sk);
>  	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
>  
> +	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 && sk->sk_txhash)
> +		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;

I think you could place the above logic in a shared helper and re-use it
in several places below to avoid code duplication.

/P


