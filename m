Return-Path: <netdev+bounces-283725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOIKEWRP+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:48:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D844B99BB
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9358B300F53A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198830595C;
	Mon,  4 May 2026 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="D7WP5BEi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F482F0C79
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880635; cv=none; b=YLe/413Jod0KyjJOmckHV6EcsGgqFvya2+5b35UQNKXradRs8hp2fH0zjpCthGJvQpH0VhFU4rOJMdZIF6M4b67+sGluBD/e5b9zvVeotRm6iJ9vU6VQnYp4SaoHd2OKS0RtpUtoUArHowQKG0Dv/unRLq/TncurRYr0WdGXi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880635; c=relaxed/simple;
	bh=boGwKw02j+YN2/NIEQgBpXs69EV5KI3+mVKmW0Vhc30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8O6hE1AUmCMN4pQr+MfQlzPd7fxEsyyjpCm5FT7eJMNLD4Xlp6KCmP8cgMD4y+323BAS8Wylpeo+7M6ezS21HVY8xl3LynkRH8h4YIGHGu2btABCTdKtL8rZt/ZR+xvJE7FEgBmL/vnRGzZuUPyY7LHTv1rhBZwPhUra7oR3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=D7WP5BEi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48896199cbaso33352905e9.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880633; x=1778485433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyNdEo2zQTUk85Np/ZYvwEJkoha6O3/ZtIdB/pJF5MU=;
        b=D7WP5BEiB6zf+NnOkiTUWSsBttOjGnxnz7KjwaqJR1BCL78lrksqQ9bg7VzqdTSaJH
         EE0ryx1CVwpFeHfOgl76nh9rvGmB6Vs+Qj+oTNtR8q1nL6GWWErF1eDpDZEfq1bq8WR/
         TzLTf2fY9NO4tANLqVrVSKQR8Ij2IeZPLrDi5NyI70Em/ibdUFGQ1sC12giSg1wF6nkQ
         G7eGTgJKxojtQz+N264J9mbYHqBcP9Ryf4QJU9e7D0j20o/ItW1uc/u8uVp6GwEp9O6N
         S9x/54g1MWTxZaRQOZupW0m/j21u1crXkU125fOAAsmMcezb5uNiqvwh606ub9Vu8Rhw
         UV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880633; x=1778485433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyNdEo2zQTUk85Np/ZYvwEJkoha6O3/ZtIdB/pJF5MU=;
        b=iODT2EOmztHO1iuaW5fQunuKWX5PTxY1nrts1Mueg23Sgbeur5gd5/n+o0WDuAmLc0
         9otsBwwx5aonRvw6Iiy/AW3e7WuBxWzT/4LqAcavpxn/sXtHHi2YNQvS4IAfpHFR4aXM
         HmcQytPrFK7F+8gkHSzeKJN6/yxg9ikcoXZVw6AloWEioun+OL+y26agzJGEUkazRVQ6
         dvfajC5TXNxsEZDncOq7BJsNWRCAB7XZ7lEWSnJg/6rmhVsQ+5SEzoHJ7qdjoNuxtCTC
         wRUg06Tjtyo5d5O+y3YHMQxgrAQvMQX1arDJ5/pTozulXVM+4mVKlECZzJ4dzlQb0C1M
         S5+A==
X-Forwarded-Encrypted: i=1; AFNElJ+5UG/7YwPMIdLVAyxlSAhLrrqMiJJUKCrL1RprAUaHqOtCNZ7D8gs2NjDR70Wi1QgrNbv2kwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweqwGbDPHt2uuZTx3mjID5MrS+0iLdyp/wSS6Zjif9kjNIBtVY
	MWirRcTTNQ0qDjK4QlLXgikBwagnsJy/pVKeSTZzLdjqXI5TauPtMjUN+Hx60NhgP2Y=
X-Gm-Gg: AeBDietVpMW8OiDHm8RvXSJQM0cIyv1+Biky8zZTAasPDJ4oGovYxaLoe3ZysUoTld0
	LmVEwu5xV4UA7tAR2Pod9ksJWgl5ZgYcFgZu2XEsRY9pEwqJtc7K2ch746MKsl3phdmgthfRSEM
	3dLMXZiHQMGeQv+fWV45zGiNAnxo6XmU88P+/7E1sayRmFlKiPUjIbuBjTeP/yD0kaZZoubIzFD
	sTp4cM6ukaXvBbe/i7D3kxRJ8IekqUfccwQUTrxDsAQv5Fo2rwoTQcxNY+FyUo8IN5RxdYxbpNM
	2MKf9FG1DyhRLHVebv79IChmjymRsY0zKswzR1Ep94CLiI5VFFczODKhhfiuIEZcvoMdnHPYGzg
	2la41Qy3IdDbT3ay8EnzZOaerVRbLqoMVHSoGRJl5O2ZBONrVzyrLBwgVyqW5ha9L17ARUk22ak
	ERQxUrLvMiVsa9k8fEkVaa/s6j86ACip2mIQLUcQOz+RZAY0YNok5w/HMuSZq2Oscd
X-Received: by 2002:a05:600c:1604:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48d0562f7efmr35523185e9.27.1777880632919;
        Mon, 04 May 2026 00:43:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6b89sm306862325e9.1.2026.05.04.00.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:43:52 -0700 (PDT)
Message-ID: <f3a36ed5-52b2-481b-aee6-c2080cf5f14e@blackwall.org>
Date: Mon, 4 May 2026 10:43:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] bridge: Add per-VLAN netlink handling for
 neigh_forward_grat
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-6-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-6-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 96D844B99BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add netlink handlers for the per-VLAN neigh_forward_grat option via
> BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT attribute.
> 
> The per-VLAN option provides fine-grained control, allowing different
> VLANs on the same port to have different gratuitous ARP/unsolicited NA
> forwarding behavior.
> 
> This enables control via 'bridge' commands:
>   # bridge vlan set dev eth0 vid 10 neigh_suppress on
>   # bridge vlan set dev eth0 vid 10 neigh_forward_grat on
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/bridge/br_vlan.c         |  1 +
>   net/bridge/br_vlan_options.c | 24 ++++++++++++++++++++++--
>   2 files changed, 23 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




