Return-Path: <netdev+bounces-273645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMcRKVvVy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DACE36AB14
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D9A13087D19
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F23F87F2;
	Tue, 31 Mar 2026 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Wwe6pP99"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB83F7E95
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965667; cv=none; b=Rr6OMggNLu4glWeu2x8qjAnlQhJ76HlQDB7gCksZzgCLOF2GSKdE172tfIxYjxtRHJvCPVvIPWpwjYtR50y8BT7m9XhK9lH2wkmPKIRyJOAXoWeJDS1jXNmKqOtbNFb169F9rLTH+eQB5GkY5Do3yV62UZ3ANrdbGxtItdMiqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965667; c=relaxed/simple;
	bh=I7abis5xbIirbrT8n0kZPAKdzz5Kim8gr02kANHDfAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCsYC1JToajFilKmyyjqcHn5W5ckN14l9xNUh4e9a9uq+PyT+HKdaRjQ7WjVbzxj1XjHApEgRMgZYpSGNfsggcMWiuDdNESzblL4XVSqcvBGe8CjlZlwLTXj7kMUNv0nnc99On5NGUTtwAYx0FcmdXK21/sBujrXc1i2JYellzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Wwe6pP99; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d0292ae5aso147711f8f.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774965663; x=1775570463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5e22xzMCOaDxYZRzPV4ZDtfQOQTcQNjwf3GeENv8Hug=;
        b=Wwe6pP99JGKKbj9DlRoKkXfC1bApr2QVnme3dYI7VT9JGjc6ZPvGCCOxnyMXxO1zQX
         EALsyCE8VMEDKAPHFWgDRU6WaFXiws6N0jJYYuMwtOVVyBHrzKaeHZVXNwJViaAXJ3uA
         rDbZX+C8tpx7sPKzMEE3ZXo8YY32+6WLhjvK6ZxukOgdExSnMDnBZiiQw+Avd5NF2OFx
         Uga77bzTkhUyDzg1cHif4fK45j8Qt7EkpsM0eXo7NIR5IRf5+oZaxtn3WcLi1slDQ+Ms
         G/tVRJBNF7rgbF9aVhUIsEjW+lCvW2FIgi+BygYK4CG8E/T0hYzm8E6Xg6MG79Z4c45I
         1umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965663; x=1775570463;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e22xzMCOaDxYZRzPV4ZDtfQOQTcQNjwf3GeENv8Hug=;
        b=XloO3RGRnolVOf/PUuAwo+ajoOuPqJPwHbxfwZab/3EFJLS1tdROnpPmA25nWQ1HJm
         lc+edIAXI98HRv4kB8hF4gT8bTlhfHEAoAqxWAgyYhwuQ2X5dlsIz8Kj8xUuY3UvWTwR
         J5jDjcpDPLtokBPx3YYxMoMv28z3Rqv9EKlUKI73E5KLTUjW00/fSNWEtY+bCB67DV/W
         ORBcxbzdi3pnbSWe7BMh4/uBHbzf+zEytQpwTIX0BEeqt7ZYZNktx4kvHky775nUj8Ff
         kBzTpKm1U2SsCrzF0kQ0GdNus+ghSNXCyOMOHr4wR+1h1tW8ymkw7L/OsEV7MYVELKrn
         Ifzw==
X-Forwarded-Encrypted: i=1; AJvYcCVT/J8090q45yO15L++bupF4quRYkwfP5xTPb7bqmet5qe9pSaYICtX2UkQ2KduJde2KeypUxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSPE24OPvL3c+N7apFUCsjfVJg3kT2yZ/flQGyuI9Oebp+Oj4
	ekPHWzG5Gebl+IAc25lN/1p5jlN/mxLkke3smzVRRclMgvYz/8tL13soV4STlSssPuw=
X-Gm-Gg: ATEYQzx7/JRf3KIi9adSDtocAbmPgEl2ST4cdBkesjTuvSlbrgGyLwRobFG8UGIiEDs
	IRhsZ53SJfWOQtZQFWq0THB9mgfvIglxeIkyslSJ2pNJmZNARyzajAvpNnsOXgPgffboJA5nBCW
	QdGTnMUHLOyffebl4qrJAcazIgDTolRr3gInpA5S/oYTrIdUBdAWiz3gEpgYuLYkYlmrd9JmU30
	DFjoWVcKxuL3wPxB6OtNOaCk7tRczBoHInOfPNtZ+2P9t9K9TcAg8T0ScmzTF19AhA6UwhSQ/h+
	0mVl1C1KnxsoRwGIn75Z4pxSHDvoSfuuvqr1EAU4Kq0xct8sLJWTWkdrR7DuMwOjN8ZJYI+zv52
	qEYAXk2v8fREUtQq5e1oITxMjq2UCR2HYiZYO/kb1r58WJExmzzE9q+g3mB1nDTjXTKTKJ3OVvT
	6dczpLDus5QHSH8wVnetY9XbN3c7aYUiW2p6G7AqJy8btTobx2m6vRqvmq3eVfXyC+iCWSI4BB1
	iE/
X-Received: by 2002:a05:6000:2903:b0:43c:fdfe:bdda with SMTP id ffacd0b85a97d-43cfdfebea4mr7332158f8f.6.1774965662629;
        Tue, 31 Mar 2026 07:01:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2577cbdsm28379964f8f.33.2026.03.31.07.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 07:01:01 -0700 (PDT)
Message-ID: <b586ea61-8a70-4367-b26e-a88644d944d7@6wind.com>
Date: Tue, 31 Mar 2026 16:00:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2
 device
To: Stefano Salsano <stefano.salsano@uniroma2.it>,
 Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels@cisco.com>,
 Justin Iurman <justin.iurman@6wind.com>, linux-kernel@vger.kernel.org
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <2bb55d10-38a9-4595-baef-678d59bf4059@6wind.com>
 <56dca998-220c-4c29-bf3d-2a94292d6d32@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <56dca998-220c-4c29-bf3d-2a94292d6d32@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-273645-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:replyto,6wind.com:mid]
X-Rspamd-Queue-Id: 3DACE36AB14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 27/03/2026 à 02:09, Stefano Salsano a écrit :
[snip]
>> What is the gain of having two interfaces?
>> In term of scalability, it is interesting to have only one interface.
> 
> among our medium-term design goals we have:
> 
> 1) achieving the feature parity with vxlan
> 2) being at least isomorphic with vxlan in terms of exposed CLI mechanisms
> 
> in this way we can port the existing vxlan based solution for cloud
> infrastructures and container networking to srv6
> 
> on top of this, we can design srv6 specific machinery for higher efficiency
> 
> therefore, the bridge+sr6 solution has to be supported to achieve feature
> parity/isomorphism with vxlan
> 
> on top of this, we also include a solution that does not need the bridge and
> terminates an L2 tunnel directly into a single sr6 interface characterized by a
> mac address (this is for the decap side)
Make sense, thanks for the details.

> 
> for the encap side, we are considering per-mac solutions (see our answer to
> Justin) in a way which is aligned with vxlan design for the reasons mentioned above
Ok.

Regards,
Nicolas

