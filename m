Return-Path: <netdev+bounces-268633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ9rIFZnuWmZDwIAu9opvQ
	(envelope-from <netdev+bounces-268633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:38:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A92AC1D7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38EFD30530D4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0D3E7147;
	Tue, 17 Mar 2026 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2Z7fOOM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwgGlpAO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76B3E6DEE
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757977; cv=none; b=c88bxbghchSCd8C5hszsT+ztiDU/PSQ1/IQGH6c/NTQn+cDeFNVfEEIQ+4G6dFNxqOYzuoIdXoNg7PpaHoEdjeDyJ7SnHKWYYmC1hO5VAvUcTxOQ6hdXxAGUhE2F6TkaYtra90LTnDWEI0aTi6vMeHy9yYni/NLcgh+QvpQ3CdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757977; c=relaxed/simple;
	bh=UQhy86RBpO6F0poicol7tkVEH4GfMsaYZqbSFAbiD4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V491LMESK62SwiCEBG+KfpfH9WqOAQ1ze3kkkGc1+uTC+s+JC35SSm9GbsHU83xK+HvRa3RCUy8vbYsjiMpq+C6weINyOGBaYWk+RqXnuJB+c/xm4RxNrSMqq9cArXfC1NAbmtEPLZlfq/4uvMNvJowjpdASbHAMoksSfNnb6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2Z7fOOM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwgGlpAO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773757975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D9W6spqw8VAUPjpA4QQ9ebhqahz4Vs6fKnlo8CL3p4=;
	b=M2Z7fOOM8XnULD51FCiiBNLLIH36XnojRLkaJjksG6PmbFiNxwI+cynxaqbY174AV3HC1w
	sAEHvxTm3dQpscqsYR6kUv0YMw4oqtWdt52JYMBxyRkT+SX+erHkDZI6R14ir4vgZ9EhMa
	sb8Tovmdjg2JQXp8Kr152RRwbptzh+w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-ELmerPn4PKe2_w_AwvLihg-1; Tue, 17 Mar 2026 10:32:53 -0400
X-MC-Unique: ELmerPn4PKe2_w_AwvLihg-1
X-Mimecast-MFC-AGG-ID: ELmerPn4PKe2_w_AwvLihg_1773757973
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439ca4b3d0bso4782363f8f.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773757972; x=1774362772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8D9W6spqw8VAUPjpA4QQ9ebhqahz4Vs6fKnlo8CL3p4=;
        b=gwgGlpAO32yPu5rSk0MwfJDZA34ZshIuQOudeogeY9kXajKWXYTaII3pVYL6vZ+Kpy
         Hbp1dSyaQt1FcDGZ2rysEFiQlm+2SaYf860IpEMB2c3zOPAxFoWtYrah7Xy2gQiNBliQ
         hyqudPVnhezP8dwFy+VMoyBG4nx6o9gUq7TsCZn1YTRCvzeTWI9LZE21Y/pDyv9DGZJM
         5Iv1MVxr/fShLY/+mXntBuKyFH+Ie6wFE+18ezlrfV7AOf69mRPISncC8TClHd7KAJX+
         mzLtde8raT9399y+zdJBcOAwgcHphpBx+NmdMUyhdlIJ9ILCqciJY/W8YxeBHXZlT9Gr
         SgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773757972; x=1774362772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8D9W6spqw8VAUPjpA4QQ9ebhqahz4Vs6fKnlo8CL3p4=;
        b=NNyuhiWqUiUHeLYZCwcJDUIQZW0JElyhH4C8K6D1FeFCvA/Z01YjA51ZlnpNgUh4Nd
         k+qBrdGoALNZreWzKDQxEfO7/d51ezBILm3Cs8dLZzwN/4A/lMGMB/31sVdqWZbyHlXZ
         b6QiDwQMWKsccbcihEEpzI4f7QN5xoNCzMquMHjWEOCxYcbLHIvwRPGtcGiqbXEOvboQ
         sPQh0gHfpEwQrXi/QAkDJwQ/CdPReWaZeDHwQw6qva3/8/bn1uCUmUFIUGebKLm2FOIs
         HqBy6zI4YbUwxR84sfOEwlGmqaUh1ozJ9eQpxeMrNpBh6nmDPvauYGHEswUhk+ZOgsYn
         P5sg==
X-Forwarded-Encrypted: i=1; AJvYcCU08t2ghBsAmziLGrI/1u7yvtAid809rJVk6Qdf17Do1Ul3gJrqZIl576vArzeEEHEDmWj2HB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYO235KQRgntklX8iSUZ1HZfBrrRi2CRX0lJfe3R5TmgnV7gw
	L0FOj+gGC39v73JUCeWsKobRPO7W5gMUispzNPC8f652Cx+MtH7fdy632gub0QLkqNUt3F+6klU
	Ydjb2/ryaPvgYuQhADzPGO1pK6Ut0DqNijGm8wxAbBgkwi+6osCs7CI5irg==
X-Gm-Gg: ATEYQzxqnzTR8yQa9Hvgti4xeqzdQc7ckJXVIqDCzC31MFXNs8+lPN+BYsDT5337bEf
	paHi2gZkAqqoIasqicVJQyIfGkr6oL4AWLYCUgcSHINPW+VHQx9Q8seDzMx8bCm42hplofsvUee
	Qwj2DhLLeyRKnx3SYvxopH4jVfCU7GpgaPPRTf5fqfrZ8Ld4Kep/AREUZwduO5KzRt1HyNE0eFG
	BJ/DTyaaMObXLFtXvJjg4vh07gigqG38e6e9z+EMoyDu27LEDbZRxjKgCz4sra66JtXhXU5dA3S
	hOkSyQSRok9JwpJDJ7TIpm75PuuJBmeUatbGgWiZGgC8pJG4TqCBG6bihM3W/Wct/3bzTnt9+ri
	yLppI2/Wi5+mR7c8xfwJSRCk5JpBA2nZMjlCwy8PKA9N/o4XWV7fUvqQ=
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-485566ca967mr277855725e9.3.1773757972534;
        Tue, 17 Mar 2026 07:32:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-485566ca967mr277854775e9.3.1773757971893;
        Tue, 17 Mar 2026 07:32:51 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855777bd37sm191300515e9.3.2026.03.17.07.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 07:32:51 -0700 (PDT)
Message-ID: <f5edbbfc-9d42-4911-9dac-e2597db7a2bc@redhat.com>
Date: Tue, 17 Mar 2026 15:32:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] selftests: net: move common xdp.py
 functions into lib
To: Mohsin Bashir <mohsin.bashr@gmail.com>,
 Chris J Arges <carges@cloudflare.com>, Joe Damato <joe@dama.to>,
 Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 David Wei <dw@davidwei.uk>, Daniel Zahka <daniel.zahka@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-6-carges@cloudflare.com>
 <f790d4e9-7f17-4878-860f-8d21c4c9c307@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f790d4e9-7f17-4878-860f-8d21c4c9c307@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268633-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,dama.to,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,iogearbox.net,fomichev.me,davidwei.uk,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D5A92AC1D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 7:48 AM, Mohsin Bashir wrote:
>> +def format_hex_bytes(value):
>> +    """
>> +    Helper function that converts an integer into a formatted hexadecimal byte string.
>> +
>> +    Args:
>> +        value: An integer representing the number to be converted.
>> +
>> +    Returns:
>> +        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
>> +    """
>> +    hex_str = value.to_bytes(4, byteorder='little', signed=True)
>> +    return ' '.join(f'{byte:02x}' for byte in hex_str)
>> +
>> +
> 
> Since format_hex_bytes is not exported in __init__.py, Should it be 
> prefixed with _ to indicate it is private?

I agree such cleanup would make sense.

/{


