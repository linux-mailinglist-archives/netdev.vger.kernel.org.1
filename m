Return-Path: <netdev+bounces-287012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEkAD8HwAmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:20:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25751D859
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A08311E257
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8777338AC93;
	Tue, 12 May 2026 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El2hDXb1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oABKDu10"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E839F172
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576197; cv=none; b=pLAUcPMuK5LIM3B1B9Fs33dyEfCuSsEFId6JGBJbr7VNOWTg0rYw1/I7rBP/aOijboOcyQIDQFjKrCpUjgeckqW2IASrxCEmOAo471IamFPDv/XHx4ApiOK/JTRjHOB+9wLjrNSsnXxI3s6fkeeHRyEU3XRPzuqtf20TVzKmL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576197; c=relaxed/simple;
	bh=lVMwC1V5ByzC5YxGojjAZqoYBJ1DbnrMHPhYH2hoMro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRiqgDfiXTZyqITbfkodiQis62TnnKVE4+ZDp5X0xzdfwyMxwwHaO1GDH6Zk6pSw6YvBbnv9rigQpqHUPh9QS2uS2UNXxoOZmHhtPmTUOrPZBdfcSh0GIT5Z0UdXfCVbjvja/VueZCVMNMQ1z4DkODSlntVUkddr1Kq/7Up6esI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=El2hDXb1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oABKDu10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778576183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkWWhDNAFlws8ghp7HprrN6Kh7iuwdnJHBkxYwkQhoI=;
	b=El2hDXb1tRq3Mm0m2CR6xxOobVJEDGZ02R4n5pgSmp6fWmpRqd97a+VYx2FvXBfgUSvtP2
	KMYSbS7LUrziV/6aqHRWiLNSSzOOa+DeFwy/U4vnUrMH1AO5WLa6QDqTAVWl2eRj0zjz82
	/wFsaOOSOYqt4kGKeXwir2tELP+BObI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-GGeFcHucM0mCTNgepaZ74A-1; Tue, 12 May 2026 04:56:20 -0400
X-MC-Unique: GGeFcHucM0mCTNgepaZ74A-1
X-Mimecast-MFC-AGG-ID: GGeFcHucM0mCTNgepaZ74A_1778576180
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso31619715e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778576179; x=1779180979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkWWhDNAFlws8ghp7HprrN6Kh7iuwdnJHBkxYwkQhoI=;
        b=oABKDu10ErJnGkAQrUqCPq6h2GgJFHRZ76/h2KaNkhIiJAm+dA5k/MbjFpy04YZgFh
         SEwj7Wb0ctLVwXqu5i7Tq09uYEhlNIP2YQLfHSwoy4a+rzttwFTjU3bicLaBgPVLWU58
         dUZEgYDwQBi9dt8EIBq3ft3jRj7qxqz5PggFipmG91to3pZjyUbix7HnflJPCZoj97jo
         4YRoemJZVfia/VgLeNlgQX7w0r/AxqrFNROYDtNr/WpqKbJnWMGujbbQcGR40psPVfcI
         UuUZxEW5zAp/MSIURn3j0q2SNz86GQV/UiV5XHWGIhykY2Pg7KxwsqwVPwyRqT8/oOes
         f6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576179; x=1779180979;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkWWhDNAFlws8ghp7HprrN6Kh7iuwdnJHBkxYwkQhoI=;
        b=hx4ackp8xkUNIcevrKMxT+ac1vlipm8i5Z/ZO3j0V/6avP9P/OCCnZzJI9xxoO8+Bo
         inWnX4IxIupdcssuTl0E4AJzP5myCgY21RyjzTQyYjDgJux58w4Y9LNXZ7me1+4Qwl36
         /mXyXEt7Fxn6mVaDbs8Xkrgk1xNQvldqN9uWqu/T2xTzcVQqQIpqg30KSIDorJZdq43p
         QN2AU7206YArxSHgQ1UdPZcNYwBUPsarGO40wtS/LY2GF2PlFmDPiuZaH0KHTDlxlsYX
         2SGnQoINigaGCfqX2goXeSikMWIMoTqsQYNFGprH1ivcsd7JYwhirvPgBwORR2gjWOFD
         6wMg==
X-Forwarded-Encrypted: i=1; AFNElJ8Vsgs44QvBtQW4aTJyrpUVYaAbEivlQa+K8iZMBzmGk2RPfRS2hGTbUWZaFHVtQd6BI/gkVd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjG2jnqLVoq1SbMN/CBbLo8DoL/pSwfMOdidfN3H5cDRSoPek
	1toz96taZX3MunkMhMykg+WM902bub/Nd0DrxePPwA+xcYqs+gGISLdS/TVjU7XfCZQAU9WMKKV
	UT6QpGDE3c15xp5IYPKZJ4UWm24mObItClXoVmtyE0t1z5AQCkt9j59fy0A==
X-Gm-Gg: Acq92OGn2c73W3LO5ObxBDW33XF9wAAeyZbJZP5doamjPDz6hJf/C19pIW0BR7UNNAT
	p7jaIszs5GHyLjziMn0NEYZssMaw95159dSHSdZZiQrVBy8HR7wGJE0+MXaTe6+RXDB65FK5BtF
	wvhS+Iihf75QlvCiQPxXeUwOtYfBftc7VLR7CqeS2CJXXM8Frj5HeI8alFCJfGzixWaPsA0e9TD
	20e2/JTtlmGXrd+2QmiKgzTsDy93cBGidrL2nwDtT2XyznbmBSagHYVMqjrpU/ZaEPFta6Df9Z5
	bUqnUCWbatnquROPOA/cBXrZu7zbfkStm8wDoofbPzFPZN1Gsu6BqP+Qzs9DPEipz04EbSO4QDv
	7pxlTZZE9dSfaAJ//0tHfSmKO71PUDf03YTV/RnQDMOs682Ko/bPiQdE=
X-Received: by 2002:a05:600c:c058:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48e8fe7fa6fmr21523865e9.23.1778576179606;
        Tue, 12 May 2026 01:56:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c058:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48e8fe7fa6fmr21523595e9.23.1778576179172;
        Tue, 12 May 2026 01:56:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e90536122sm33619495e9.4.2026.05.12.01.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:56:18 -0700 (PDT)
Message-ID: <68e44a69-aeef-4681-8155-7e65e2eb5629@redhat.com>
Date: Tue, 12 May 2026 10:56:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Add port TBF support
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260508065757.2566258-1-mmyangfl@gmail.com>
 <20260508065757.2566258-3-mmyangfl@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260508065757.2566258-3-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8B25751D859
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287012-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/8/26 8:57 AM, David Yang wrote:
> @@ -1378,6 +1390,70 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
>  	return res;
>  }
>  
> +static int
> +yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
> +				  const struct tc_tbf_qopt_offload *qopt)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct netlink_ext_ack *extack = qopt->extack;
> +	u32 ctrls[2];
> +	int res;
> +
> +	if (qopt->parent != TC_H_ROOT)
> +		return -EOPNOTSUPP;
> +
> +	switch (qopt->command) {
> +	case TC_TBF_STATS:
> +		return 0;

The above makes the stats actually not supported; it should return
-NOPNOTSUPP.

/P


