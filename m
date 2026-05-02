Return-Path: <netdev+bounces-283378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJvUB7yT9Wm8MgIAu9opvQ
	(envelope-from <netdev+bounces-283378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:03:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A474B116F
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CF5C301106F
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 06:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A72A2D3220;
	Sat,  2 May 2026 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="P//+BWXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365781EEA31
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701816; cv=none; b=j3ClmVRSAEYhNcIbkEEsGxtno5mwsUaS5HTCaObEkc8TunHuox43JREZhze0jmDhN1HB923Q9sL5zuLLCtptsAygT7fLMzVv7uRHjedSB2e5g8zbDZYtoTb9u3Md+A+mX8Xu5QSN1ySJUslkL2MuEGiOX+skX633I6/6mdqn78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701816; c=relaxed/simple;
	bh=S7Lb+q3oEv3NVM0NPPBYU6eUyq6N8yTsNyIwBajUKE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbDJ+bJznKASXDrDPcRXngpuTf8K3esvu/fnB9GsRx1b5zxGL7O534qcrKJWc5PxIdsfmTZCqBu8fyqWGMDHJJ8HvGry+jeXA0u6kOtctWQ9yUggDfqzs3nu2EcY2wXrG43ekgeYX2HEvoRTRoSqdTtHUg2lmLMUhyX0Nv+r8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=P//+BWXz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso19864785e9.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 23:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701814; x=1778306614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZREXi6KS9s2NVYeEPr0xKFupND9na8xQrKsYAgQ4Cc=;
        b=P//+BWXz7ZP9o+BvGp8jKVHG4AfZwRgsVPatQpCuJY2QiFkDW11orO9/bIUt2VGN9s
         Q37Z7pUIY8cBu/GZ6eiGk7gVD58NEGFzsxhVEbJ7Bb4oph9RH28nr6FpMMv12A+t/t/p
         jQTUinTDanSdC71tD9/BtGHoYiewTKjwWLFJK4y82EJdKu7QNKFcHgL5aBJkkUVutsbL
         WE8Ns2q/YlHU5SZPVuM0lr/Neaqgd/kYAas2MK6sYDsKdtLqQikQh5E9W8yDxKGU6P9P
         u2Eaxc4yU/ZPhMFe/OIl0jDZrSAyfrTLLDn8LVea0zCB8stBZhC0dQAMNRKJjoh2zTBo
         oxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701814; x=1778306614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZREXi6KS9s2NVYeEPr0xKFupND9na8xQrKsYAgQ4Cc=;
        b=TUDSF8p8kCV7dU4UWlI8+jQZ3H/wGmyx2K69kQXsBWkQ07rMrfOCnuTbWPnYAPKKr3
         oVFbsqrUDPFCcAOfKogBFfNe7Gr7HhpNsKiwuJDZrWxSuIrLnwuW7ud5F1vX94EnJ0Ce
         WV6MJ43xZn8DV7ADYqbAlzfAoQWWsSLORmx+emvBOt2NXDTBAcmvqHZ9pP46jpSZ5SeW
         QlUR+SQDoiqLFxCq9m+0dnduNBzIqmMk3nlk2+JWxLJkRgtQnFy0lF8+9zRM+Qr1oZmN
         v1aeJjqAv39pS5FLe2zz6zj8qmazM2iuvpQRRie94IaF5aaM8ElZvQDaUFAloCavE08v
         ADPA==
X-Forwarded-Encrypted: i=1; AFNElJ8w6zrsEA1wlzeWsV+C4RAk1XkdDhTLCDUYCfIZhxNaF9zLJx2lyN+v9EVMCe93zcpzn7FJ70g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDre5lV38yWrI9D8hqrMTETRgJE6dr7l72f3ls2vuvXLIZdK3V
	jThXv3pxAJvxZ9Phlb6d/Etq1VC1mGRlrJC0DRi9kwCI6Jb6hOq85FV4GofreG59oi8=
X-Gm-Gg: AeBDiev2RNT0EPeu4u/4gkdBFh8IH+7XwsWbZJuFbAz08ylmQSUvUOShX32lZwbRwr4
	5TTD08qOYLo72/F0KRuduAqcvoaRJRTzrjSmxsVmQFJnj1ySYamBtwV7F4KCA6TM/1PKh2JBckp
	edXNNp3+SgesgBCIxz24hllRozejI08nBhsAiwlCSzCVknWQKk6ujQYMYkBwoATJRGrpaozrtXT
	3D8W70p+RfTNQuMs+wr/VbG7/jXXPYzBKwp5ie9HfEbCrD+Axv6ZQQJ8goNcHZaO5FaWVlAoZ4s
	ntzlBng0+YLvpDKGUBFlKBjY0S/EOShGSYyO8CRwMFTv/1JQqE7qAGBlsEpVgJQHAAPN0u0JXJ7
	oByaPz/H+g1JrMI9vbz92StV3972j3/RYAoB6+iK0J8egFM1oP+rKksJqapbqfA/nUMx4VWWOpv
	nYGZOwsDgrOrfGQThTWcCLj1YlqmqM12nwPEb/2YXUiQxBifQDpIY8YqS/vqaZzTbe
X-Received: by 2002:a05:600d:8453:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48a9852f5e7mr19973775e9.3.1777701813598;
        Fri, 01 May 2026 23:03:33 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee4d60sm27091805e9.19.2026.05.01.23.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:03:33 -0700 (PDT)
Message-ID: <82343bf4-18ab-4482-9241-2f235f6f1449@blackwall.org>
Date: Sat, 2 May 2026 09:03:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] ipv6: mld: rename mldv2_mrc() and add
 mldv2_qqi()
Content-Language: en-US, bg
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
 Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260501173130.3486-1-royujjal@gmail.com>
 <20260501173130.3486-3-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-3-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 89A474B116F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283378-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid]

On 01/05/2026 20:31, Ujjal Roy wrote:
> Rename mldv2_mrc() to mldv2_mrd() as it is used to calculate
> the Maximum Response Delay from the Maximum Response Code.
> 
> Introduce a new API mldv2_qqi() to define the existing
> calculation logic of QQI from QQIC. This also organizes
> the existing mld_update_qi() API.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/net/mld.h         | 66 +++++++++++++++++++++++++++++++++------
>   net/bridge/br_multicast.c |  2 +-
>   net/ipv6/mcast.c          | 19 ++---------
>   3 files changed, 61 insertions(+), 26 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


