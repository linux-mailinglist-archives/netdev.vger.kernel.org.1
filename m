Return-Path: <netdev+bounces-298080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XYsjM2GSKmqcsgMAu9opvQ
	(envelope-from <netdev+bounces-298080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:48:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B25670FA3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:48:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=i5yDUK6R;
	dkim=pass header.d=redhat.com header.s=google header.b=CNr6UvKo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298080-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298080-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41C4F300F148
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C13C9881;
	Thu, 11 Jun 2026 10:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353B3D16EC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:47:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174879; cv=none; b=Pz80hg7tSortnHj788XxCuZkFqxRbfDNLwLQghrI4UA6BcFinz9guo179cRQCxMKgNqRFyQEz+Xi3ErIv4l1UDFQadbI7YugWj/aTLZO88PyQXv7ZtecG+2W2y14/P0Q7eCptunpLbkW0sT52zlnokHrFMoQbCogA8xad1LSTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174879; c=relaxed/simple;
	bh=wr4gfTLT2RE4EnGd421lT4eCHN2636zc8zsjxKy9H+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWiqxlX5AwuwyGtfrbK0iCHlI7X/DveEU0u6WlWGMflz6v8CZNn5TFMfTg6HYBwDfEiUCzR8Uz8OdhameNWO94iOvBYoBCiaJWdMEpskwf3ns562JkKeTz6rMFYlP/j+SsCkFlcBi8Df4DN3MzWpO1+DLKHFYxjI69oH5cEv3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5yDUK6R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNr6UvKo; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781174877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpktyMx1E4RvhE4GSjTWLQbMv1JyRqCDUlXfwsuHV1Q=;
	b=i5yDUK6RQkNKHmtkgppRQRrJgsthkTyEuni5bROK4xZf7hsZPg1Dhzcnc1s2cwyf7REyKH
	kZdfv3vpfwu93IrYjjaYZjJ4QqostwpfFoqyYch8P7+dKdClySiUHP3hN5u3ThB9hBCy3U
	aCOnf6ViaU+HILVNyuysI4hCoA19p4Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-TfKrGNczOHm9iGdXZWXKiw-1; Thu, 11 Jun 2026 06:47:55 -0400
X-MC-Unique: TfKrGNczOHm9iGdXZWXKiw-1
X-Mimecast-MFC-AGG-ID: TfKrGNczOHm9iGdXZWXKiw_1781174875
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso4672695f8f.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781174874; x=1781779674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpktyMx1E4RvhE4GSjTWLQbMv1JyRqCDUlXfwsuHV1Q=;
        b=CNr6UvKoqu00cZfM3D8W3rQw4OP1pBcBsnU3hsLQLyAgR0IsR2smuUot2DYeUISjPH
         oOio+LDNPAQKSH0jwjTmW6Mzvga1+wcNSgqEYimuCg3zp3Fbn1tK36lIraHD7cPjgaGO
         WyN2A06y6SRPV/2JGyShUmcnuF6TWVtnJLO3Q782WNquybtF33Jabcorlvy9AGObAerZ
         B48AfLX3P9CulY9dPLctfMMQbnxIKeklU/F1l7rh1NbuRQlbE0+hjm+hJOaLlvGfOKzu
         lyabMj5smhXMkiUl3YaSA2sxP+cTjgbRjBpwNY4mDTDUeHL15UJYXKMj/1JARxwZMMoW
         pupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781174874; x=1781779674;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpktyMx1E4RvhE4GSjTWLQbMv1JyRqCDUlXfwsuHV1Q=;
        b=Bu+PivdFcwRV7+5vId0i8oDakdtNBYKalDlFIac2JFrS1dtKrm4qfA1tpThX/NoWwb
         fxvE712BsHWcvR4m/4KQaoyYH9Xp4g6Z94QGgUn5HApCBZHzp4qocwcGK7AWmcZfLlfn
         qKiPk/5PLReaj86sRmkf/wrTpb6pytLM7K12tRKEWAqha/d1F/mVobkL6NGNnSth1GhM
         +4GAstoYQdN3DvwlYh1LQEuga/7fPRDF1o9XPv+xxD2rmq4GLQxjL3zdUUw1ADMbkTYo
         Y0HRPAARqc9pcov8CEEVyyliPo6TyXqDHZysOf866e+JP61xN3XXNYON/5qpT+BPMCxN
         Igcg==
X-Forwarded-Encrypted: i=1; AFNElJ+bN6iN5EuAVLKB/Iegd0xAqCZ2EybJAVaijAtjibMK6ZE1FF6WhmAzuj9jIszPjvOlQ1Sjg2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4dm7URjAJvDUjGLdcg1xsL6hWfnAg0ryx6bAt922DtsdTv1t
	EcFJHdg/H29rBvuu9nhXJloCXzfN5OFDTcrPPTWGxBGmkH9LggJb9DiOWMDxzhlV6+brTidmD/J
	Ss3Pn9NK92so6lMdBE1P29qvq4JaT20nX1//bq5zaw5ew4oJDgeCrGgqbkQ==
X-Gm-Gg: Acq92OHnu0yMpzoToL0YazxHVVXS+QvO1gqKRVarfU1s+X7I/WPvNADzKHUVWouYo/p
	K6Hq1HbyxCd+Zn8gA3BrhbebuoSNxnBYrOjOkDJtVj7h+xi0Bo9ooYPXPW5pe2d7BkZOcNVLwGw
	bjV8Ve/9SktficiZyvfSPoYLfQxyrmjCeeZkX/WiNrUdp0pZs/PqDoH5Ee2e8hFGJiuRvJaCdVt
	nIVKZzwJoEbPI+Y+5HfwgXh2I4ykhsdHM6tOwh+a2ORqr9crs6Aq68RJVxCHCWEopN0cDsikUa2
	skazbNFMSyajTivFoLGEMIDyy5Ks8IoZoSC2Vjv/dGDDwpjBfArdqiGtZ8IDhmhYJz1tNBHIyI8
	c5Jbl+46M77aUkfIy21kQ3lPeqRP+UjW3c52EVjZVZS4tE002o1BOkj1T1FEqNUbZyQ==
X-Received: by 2002:a5d:5f47:0:b0:45e:ea9b:edfb with SMTP id ffacd0b85a97d-460677cb174mr3397208f8f.39.1781174874551;
        Thu, 11 Jun 2026 03:47:54 -0700 (PDT)
X-Received: by 2002:a5d:5f47:0:b0:45e:ea9b:edfb with SMTP id ffacd0b85a97d-460677cb174mr3397165f8f.39.1781174874083;
        Thu, 11 Jun 2026 03:47:54 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm74807050f8f.8.2026.06.11.03.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 03:47:53 -0700 (PDT)
Message-ID: <fcc21647-d7ac-4b9b-ac61-42fec517cb99@redhat.com>
Date: Thu, 11 Jun 2026 12:47:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] geneve: validate inner network offset in
 geneve_gro_complete()
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Weiming Shi <bestswngs@gmail.com>,
 Kyle Zeng <kylebot@openai.com>
References: <20260609041334.2506153-1-xmei5@asu.edu>
 <20260609041334.2506153-2-xmei5@asu.edu>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260609041334.2506153-2-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,davemloft.net,gmail.com,openai.com];
	TAGGED_FROM(0.00)[bounces-298080-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:bestswngs@gmail.com,m:kylebot@openai.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42B25670FA3

On 6/9/26 6:13 AM, Xiang Mei wrote:
> Even with both paths gated on gs->gro_hint, geneve_gro_complete()
> re-derives the inner dispatch type and length from the packet and the
> current gs->gro_hint, independently of geneve_gro_receive(). The two can
> disagree if gs->gro_hint flips under a concurrent geneve_quiesce()/
> geneve_unquiesce() (sk_user_data is NULL across a synchronize_net()), or if
> the re-read option bytes differ from the ones receive parsed.
> 
> geneve_gro_receive() already records the inner network header position in
> NAPI_GRO_CB()->inner_network_offset. Have geneve_gro_complete() check the
> offset it is about to dispatch at against that value, adding ETH_HLEN in
> the ETH_P_TEB case where eth_gro_complete() steps over the inner MAC
> header, and bail out on mismatch instead of trusting the re-derivation.
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Assisted-by: Claude:claude-opus-4-8
> Tested-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: Add patch for race condition found by Sashiko
> 
>  drivers/net/geneve.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index d0dc5d6c46df..028740e97740 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -956,6 +956,19 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
>  	type = gh->proto_type;
>  	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
>  
> +	/* Bail out if our inner network offset disagrees with gro_receive().
> +	 * ETH_P_TEB adds ETH_HLEN for the inner MAC header.
> +	 */
> +	if (skb->encapsulation) {

I think the disagreement could happen even in the opposite direction,
i.e. gro_receives does not see hints available, but gro_complete does.

> +		unsigned int inner_nh = nhoff + gh_len;
> +
> +		if (type == htons(ETH_P_TEB))
> +			inner_nh += ETH_HLEN;

This does not work in when the innermost headers carry a vlan tag.

/P


