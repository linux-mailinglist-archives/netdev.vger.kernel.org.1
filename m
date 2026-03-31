Return-Path: <netdev+bounces-273533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJSwFkeNy2kuIwYAu9opvQ
	(envelope-from <netdev+bounces-273533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:00:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E879B3669AE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06A5F302D171
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3BC3EC2C7;
	Tue, 31 Mar 2026 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBpxXh6R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDFWdzJF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7403E95BF
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947200; cv=none; b=sxQx6XsX5lUpY0Y6ww5fgRLZ1bcNXEll8dtuZ/9j2A5Unul6zKWO7/pXhgPBCqL+JX10UUtVpSJHepnkTBu1pHf3ZBAROXotpe7Ftt+OCANAAlDXPCkhkz6kJX0hwp7u4XqdPDi3jEfhP4IL2wWL/yPmgGEU6Mx17x+raTy+U8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947200; c=relaxed/simple;
	bh=thC8dKPPg10Dwy3GkW1HAmocWcEdKSG9PDGRZZ8FwM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3+VJR69CwcZJcwG3w8X8O4+d9SO5X6Qd00yIzRzrzxse/WipSFBOj8j73lQRxlNUeFWexfEWMLPXDyw/PV2F7vXIL3RS1on0wbHTIMKKvqKh/c4tdrogOCPXwQs3sqAbrqqsaU6OvyFOkY3Zxc6nLSBaWeYH1PIAcr/VydpE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBpxXh6R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDFWdzJF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774947197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ijzCtFAXBZs1VKX/fdttYgHcCCLP+6BaG79bNB08zw=;
	b=YBpxXh6RD1nuqjXsP6EHsbdZTp7kFQy5p9+6D9jAYtuDhwTpwpRQJxYfLAQAG2EuFWngf/
	Ak6mx+oupo/meNhaK+ip4JUFyanUSFSnEps0mhsrQJsFaa2k6eBBRokS55tkZB/DnbcaWA
	Ml14BWLwGmTrxyf3mNmiHmy0ymMkQXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-kxDm2oV8M3ih8tIpEadW3A-1; Tue, 31 Mar 2026 04:53:16 -0400
X-MC-Unique: kxDm2oV8M3ih8tIpEadW3A-1
X-Mimecast-MFC-AGG-ID: kxDm2oV8M3ih8tIpEadW3A_1774947195
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48532df52c5so58832325e9.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774947195; x=1775551995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ijzCtFAXBZs1VKX/fdttYgHcCCLP+6BaG79bNB08zw=;
        b=WDFWdzJFR/88nZ32ZwnkG6UWTzT2exFj/ccpTgd7V52g38Rqf3kK2unj7oCT0vZwXT
         RGda2wYPPEROEe8P2n4FycpeZZA84yZ4vV4rdfFW8Yk7Xttplas13g/fr4Uxd7ZzseG9
         uapzavVkbPYl/MWOGCXn5CJF+QkCE6lePhSPFsVbNGANJaI2tSzEDN0TxIYjZdWyeU75
         H3X+PkrIjQdJFfMpVs9kIujjiIIT7fxbRsaf0rjfQMuw31+hh/lAtD3RlH21PqRbgQTR
         OVaDvhZcLk+OS1KspAvV+4xYz8golfFmsuQCTaR6WsV97Bp3+AsSWup6+65qSJ4UdgfM
         NwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774947195; x=1775551995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ijzCtFAXBZs1VKX/fdttYgHcCCLP+6BaG79bNB08zw=;
        b=ftKwnFtQCxQkStU/rLv1FOwUi27LWCiwqVfUuy1TiqjKII3Vf1xxv2wENch8potpaS
         olY6QqTA4PyXEThHdRZooUQ2lyqsF7dW6pscnMiKtSpo0Cm5tsPSLjnLsmPfZ1RP7jkQ
         xIPuJgC57tr7gMHm3fGVmUd+9H1ou6iNI1iFuwBGnrxXUc3EMTYkaJ1unFwBLYHsSqnV
         VxNHuzcYh9AjDD7AoVbi9GP/Aafw9H4hxLGL0GH4zmrV4NGj8DEEHL4LSqlJT3LbxcJR
         KGhH4baf7IGT99NyhmF4Rmcoel62fUFtSc8IwoPoRYAEC5CO6eCBoditUBv3p8iDgQMj
         Wi8g==
X-Gm-Message-State: AOJu0YzlWU1PDXCtRXbD+ZoJnynLXwTXcRX+n//txvRuDS0TagV3eRAO
	Y9YXf5xCWAJ+dVAwaB16v8SpsFST23GbkHBJQKoEt1TL/I9U8xCW9LtNg5pPUsWJV2D5IfPh/ZW
	E02J82bJb6UARMdbSjqMzlTGVbkdxtqGjsP8Th9yd2FGUO+sKDBmHqJo5uA==
X-Gm-Gg: ATEYQzzcrvA97jBgdXJ7kB37TPrU2KY3BC8xfTcdy+UB2vSoymK81FTWlt1hciqvZ7t
	MCAqNu7m0MNMPGmROj++6Y6wR+nMahE+O3m8GjinODFdiY44OE0a36B1c3sBRN+cH0D8/lWovO2
	lejwcIQ2PRROjEDjyQHevXcCMw+j6WIuyJn1gLPjSnW2/LskfsYCe4BThwIB/gPu/3biiZlnzWL
	tMf0lBpFUPYXz4PAGsz8cz9oLy9kFOD/vdn+sk3wFOqWvHonHDa6grHJfx5hkASJ0TJZXpEnKkM
	vzpLApF96VTA82s11oj+JHqyRUmctwDjAlkqgYhFRJIquIRt2l05ST6Xd4wW+FxM7NK8BCnsDCc
	+zIP4afZYDdm+6EloAm7iej/Y2mxt1AvgBTmUQac94K7CC2yAVT1LQej7
X-Received: by 2002:a05:600c:4f53:b0:487:18c:7acf with SMTP id 5b1f17b1804b1-48727edfcacmr262359235e9.25.1774947194719;
        Tue, 31 Mar 2026 01:53:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4f53:b0:487:18c:7acf with SMTP id 5b1f17b1804b1-48727edfcacmr262358785e9.25.1774947194239;
        Tue, 31 Mar 2026 01:53:14 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm18127025e9.12.2026.03.31.01.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 01:53:13 -0700 (PDT)
Message-ID: <88cdb95a-3bb0-4e97-9fd2-a6ef9911edb2@redhat.com>
Date: Tue, 31 Mar 2026 10:53:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: bonding: fix use-after-free in
 bond_xmit_broadcast()
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 bestswngs@gmail.com
References: <20260326075553.3960562-1-xmei5@asu.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326075553.3960562-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-273533-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E879B3669AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 8:55 AM, Xiang Mei wrote:
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 33f414d03ab91..a5484d11553d1 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5326,7 +5326,7 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>  		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
>  			continue;
>  
> -		if (bond_is_last_slave(bond, slave)) {
> +		if (i + 1 == slaves_count) {
>  			skb2 = skb;
>  			skb_used = true;
>  		} else {

The above removes the last usage of the bond_is_last_slave() helper,
which in turn could/should be removed, too. To avoid delaying this patch
too much I'm applying it as is, but please follow-up on net-next
removing the stray helper after this patch will land there (i.e. after
Thursday).

Thanks,

Paolo


