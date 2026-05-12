Return-Path: <netdev+bounces-286984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA+fKd7XAmpXyAEAu9opvQ
	(envelope-from <netdev+bounces-286984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:33:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D0E51BEBC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E81D30230D7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6C847F2E4;
	Tue, 12 May 2026 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aE5Ai6yT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCD47ECCC
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571224; cv=none; b=QUCURRRj24kr1bks5f7hvY8kzCj1gf2ecs1lz0XHAbcuV1QV9DjMmoGgoNVzcjaV7lIfFaxHbomWdXjsg4Uyn3y6MqLixMbBo8GBHcuGRp2y2ORJV6bEOZBXWS/09kjGJenOzCNoZrPY19wBMvNtJyeTs9CGrdV8M/yjGAP+N84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571224; c=relaxed/simple;
	bh=QBQ38YtbIovx3IIfEd+k2QDsSXMDIpaD/PIPsMGP/eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJzAFeXsRpyJHnNOBycSW8e/ouUx2waBgevu8eoOrXqKltIX2n4A+bcw1D8LA85Eh/BGx+XP+zlIyHe8T1Wv3ojbanae5tcMKbiOOjkSx8SK7O7p7bEEu5DWPaYggBDvmTvSJJLyvxc6B0w+miaj2yk5yat69ulyn3ZpfXz/xJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aE5Ai6yT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ba840146so45861165e9.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778571218; x=1779176018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xstN3lLqULmnNo7titfY517Jxb3RjkWAVc79aexWYro=;
        b=aE5Ai6yTRbuLQjQS0Gh7rWS2msdhtmm4d2Ay5db4hAxTfWRO/sIUKw96vb/eorHAw9
         5krYtaJO3lg4tIxoQyBq2yvtA/esub3RgybOWjFb9D3kUffNCtwF2H1EPOl/GA2WSFJh
         QA5ftNjnr02U+YUqHmscgjClveZt1xkYpseBT4aWIkYjX8ZWu/mB+R5lm+xvbFrMOl1I
         DMkS+qbP1sZhWh6xA8uuybHi9Th14KzySGypzXDsT3cuilEbRsdikjRfvqmTbmEp3J/M
         Zc3Pszz0GjAPZhcNzTpRU8EiLPDm4Ha8UoQd5YQDaPV+Yd2hJRmjYd2wR5opvZ4EmOUZ
         akcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571218; x=1779176018;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xstN3lLqULmnNo7titfY517Jxb3RjkWAVc79aexWYro=;
        b=QDIF2RfKcfUtk3PoKyZt2DOEDQshCWGziyxFs6LeZr1lEx/nq6EkUQRzhbX+Ir67ms
         9imNlce+skKtoOYYNJYsGCeSwGjEyESQTxzDAo1Jix5u63xk5ThwBPNBpVnWVISzr6DJ
         Lz9F+e9J5AHBiwdiwi4/4XqkFWwSvp9HxMPaZCgqrJeEH3uP9u/ycC4OQpUhW/A0QHTZ
         ss3TpDnFLb76jBYUXuFGro7CvQNf/Lr1pb2RFSZBu0PQkqHYqoPZPfSKOcbJvGBS02Lz
         6Gc7VxV+OG5ScNxwfFvZBjZCE6iIqo+1SHIe+jfH5QcIZI+WcaBQomLYk+gpxnz+H84Z
         29+A==
X-Forwarded-Encrypted: i=1; AFNElJ/dVMa+v5cm9LfOqXQ/7We1WdA1xKHq805HBOvOgcHkL99YYRm5VqRnDUq9lnFHCAnWGiSyWFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOy+IWT+IJ7B26i9466bm6fD3kXF+uwCgJVfeNTSAQE3XXupWE
	LRxncQyKdtxFYtmuAi4nbUp9ZXw/jG4G36XLFyqLVBrDb8wzVUchsRp5TKPYfvlOPkLRJxG8VgH
	eO25b71/qdbJqAgy5kcUdUtbwyxfv5VUPavB5XVxek9nnYJ96B4s=
X-Gm-Gg: Acq92OGR5fXx3Myxq06Y8Zzf25XBzjBZBhYFKTSHP5rzu2kTj3ZozuyvBGR6SgTkPGU
	3KSZPvvqb4L768vlUhyhGcj5Gbf4Py+FJ+IGOKV1f2qrwBb/quk/7CSqWbJBeGF5ctBLVxmSB3T
	nviSUsOI1qdn0BnzYE/3BckDDAPYk49rM8WBwXvjQ7FyQx6jvELdVa885jHqg6D5U0FUuEfjrHG
	hr13/JqvXkP4f25qJffDTFSGQkuFB9iCICvxF17bF1sNbC/h1M+AwPLoGNYgjsfjX5a7/TsIGJ8
	0x97U6m7v4H7y79RL7/SS2us0QvKJtkZSEO+4e83JqaruaHb2C7AlzmLwK1z6GPOi/QO8gnEEUV
	IdeIfbO5eHfPQ5meI5yJxyiwVlkuAw5OW2EiPDL6EJFSPT1ptBY1lclvWBDhDB3TCgaNweKtDE4
	ZAVlCplLltu0lPq36ZJrhv25bar8sXRJdv5Nfeo2rdbCc0fUCyO5jtWTeuNfCPMA==
X-Received: by 2002:a05:600c:3510:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-48e8fe50c53mr23084875e9.11.1778571213798;
        Tue, 12 May 2026 00:33:33 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:7a81:9c57:657f:40cd? ([2001:67c:2fbc:1:7a81:9c57:657f:40cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e5efe71sm14202915e9.1.2026.05.12.00.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 00:33:33 -0700 (PDT)
Message-ID: <b1d90a50-3419-41bf-bf92-0012a8c1503d@openvpn.net>
Date: Tue, 12 May 2026 09:33:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ovpn: respect peer refcount in CMD_NEW_PEER error
 path
To: David Carlier <devnexen@gmail.com>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260512042036.19870-1-devnexen@gmail.com>
 <20260512042036.19870-3-devnexen@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260512042036.19870-3-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 48D0E51BEBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On 12/05/2026 06:19, David Carlier wrote:
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 291e2e5bb450..4c66c1ec497e 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -462,10 +462,12 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>   sock_release:
>   	ovpn_socket_release(peer);
>   peer_release:
> -	/* release right away because peer was not yet hashed, thus it is not
> -	 * used in any context
> +	/* For UDP, the peer is unreachable until added to the hashtables, so
> +	 * dropping the initial reference is enough. For TCP, the peer may be
> +	 * concurrently reachable via sk_user_data->peer until
> +	 * ovpn_socket_release() detaches; rely on the refcount.
>   	 */
> -	ovpn_peer_release(peer);
> +	ovpn_peer_put(peer);

Thanks for this patch!

Unless the CI Complains, I'm pulling this in my tree and staging it for 
the next PR to net.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


