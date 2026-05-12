Return-Path: <netdev+bounces-287020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sASVLmTxAmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:22:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318A51D92A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E278308EE3E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935E3B530A;
	Tue, 12 May 2026 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCidrxF7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ru1UWVw7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F13B961E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577386; cv=none; b=UNcWQoClLWl4CzHoWmoh2iBnxjxfc1dKPCbBBQoCEV4P7EPthHaBmqu6yjA7OP0Vejn0bWv20He0foQpZag0VN6Mhj9SJrcl0YsMvu9Dfifjwl5PBs15kQi4aH0oEPkPUVwAvDjq2fy032J0iEEkaryei0gvcO8audCrahXZtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577386; c=relaxed/simple;
	bh=futRt67P5rvSyTaYMVnQ8pClOdHlc11Lor1YFVdYXk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvnKBP47zhDCkmpCvZDdLUGTgdqn/OQQ8eCY6uAosuspVf1pY2nFWl/Ew+zNHXWbof01FJPLgouZ93E/pr7vYLfJ/d5bLG5TPPaoRLvXoH17n+c2rSKtjUGz5dftdlFWwoQrGvwf8OQEYFP+MMpUCUxlC+p5zF+5uPsawlTjYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCidrxF7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ru1UWVw7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778577383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNE3Rk33BLnqQIXsr/N6cTDhMglkdYFEZqFp6412RHc=;
	b=BCidrxF7Bf7u18WW2xLca1uJz67J5NWRk9yQcDup7iWHl3mKuTCMHKne2fkr1gFHCuAwSX
	mQuZtKReoIjm9qCFnW9jaA0pl13FJ+gX0WSdLCnJtG3U2Y/5oM3kPMT+qfnBmNXgCc9B6I
	ueLg7UduCsIiKj1vaDoRAUDIrWYCLGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-mJLJaWFxPMW1Ctg9CeHHdw-1; Tue, 12 May 2026 05:16:20 -0400
X-MC-Unique: mJLJaWFxPMW1Ctg9CeHHdw-1
X-Mimecast-MFC-AGG-ID: mJLJaWFxPMW1Ctg9CeHHdw_1778577379
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d1b294dfeso47786415e9.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778577379; x=1779182179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNE3Rk33BLnqQIXsr/N6cTDhMglkdYFEZqFp6412RHc=;
        b=ru1UWVw7vjGZb9dVNK44LdA7e5LOCZw8PvmF0L9KRGFd/Z7vhjPNfCmwbhfdZmgc8I
         fUgDkcM9f7kIwf3y/ajxWUqMKf3TCpD0cWHd+VKzh70126LjovW/sEeIlep3DAFkJpfa
         779+9URTGsQ5cKM05DtQiltZLUXA3OwNHRtEwABRzmg71uYWpNufvHnLHptaJNouwk/i
         4aqadAQ3U702r64r8RavEPNUIH3N/+4Mvg3tdPIb3hRAn+x+8CGpcEhqv5CWwaiSsNxe
         5cvLJW/ow1QAtulhzbOOWj94KlQA13afDrPhOMPNP7mB26jtg1GCIwkZ92VQtvy/Buv8
         uPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577379; x=1779182179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNE3Rk33BLnqQIXsr/N6cTDhMglkdYFEZqFp6412RHc=;
        b=HhXj4VWyg4THJzufss28UoLy7mcsdvErkravBipjIMwnS2Eq35vpB+mDOIqYHCanJA
         s4guUdFovAw53lb8HuIOGPvnlhd3BGcIYI1X57DM1FNoqlVQFjZ4vvi4vonYi7f+FbQd
         6julbHDoV9EHxgqxAgvEiwz5XhRxPW0SZoXx8zIZtGmjhUcHdX2yI5EBk1l1nYpBsz6T
         cfwDb2Fb9h1TV8WF/A+ZkVqukINlKzNDSYP7QJ0mxDvOu1OlMc8nCje5GRNysFraL9z5
         2DYHSBNPK6Z3ZKt1n02s6Zk9ReWqEf+MgF0EdLVfhdB2A0h72hIbKnWQYDkseX2SvuLf
         682Q==
X-Forwarded-Encrypted: i=1; AFNElJ+b91GGXlJHxamzSCfEURDcyuE0js15x23ZmboHzGnNe6subI/z3E4dK4n26guHL3NJP5YUjYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHCeokPtOLXCwNdLtdYeKxzmakEh9F0RwytQPBBKbSCg+7duy
	RAl9GgGxHniIq2QhPkvciDyNEhE52stisC0rVrTUjzB5f7C14Csr8dQTT80nxI2dCGyM1kk7myj
	ZgkxKMl+pe1uRup3xziYE91ZqmPAcuyYi/OPWCLA1lx3IYzqizP/GTZ6zow==
X-Gm-Gg: Acq92OHxV7lzmTYstgdco/Yx8m4tUwfSFsN8pBw4i9c1eAJCFaQfrh6sp4KJeXtM/yS
	xXC0CA1Qos0UFKDE+Nff0jdSZvb4yBouQJx6QPFMCKUTQ2AqDPBIXttvqRQhuCxxNBqmORGMZec
	Id7mjZdRksg5XnG0YCk7OltlHqdqn6Wxs5XgOGMtmT08CZ9Aj70TD3gv1a5d92Dyd9d9MVpXVLp
	aV4AZ01CX6iIg6TzMC3fF7Cgr+ItNtkesRFKykbHA8tDFuQPCk+wcgaMsEAhv4HIvUnTfmtOgda
	a24n9wIlXyz57u2zAdaDsHk5+5ib/d1pZZbdLSQCC90KNB5iWp3qVn7rciFrliOk64jLCD/+DTT
	sXvBuPZ8JptnDqRycsJYKnfiMf/Q22B9RTFBtdZD3ViGjfoNj9ezKTJs=
X-Received: by 2002:a05:600c:3011:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48e73f1baebmr108985445e9.8.1778577379130;
        Tue, 12 May 2026 02:16:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3011:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48e73f1baebmr108985195e9.8.1778577378567;
        Tue, 12 May 2026 02:16:18 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906a757esm29406065e9.4.2026.05.12.02.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:16:18 -0700 (PDT)
Message-ID: <ebabbd70-b406-4aa0-b468-9a71cd7daa0a@redhat.com>
Date: Tue, 12 May 2026 11:16:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY
 support
To: Minda Chen <minda.chen@starfivetech.com>, Frank
 <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260508094522.3952-1-minda.chen@starfivetech.com>
 <20260508094522.3952-4-minda.chen@starfivetech.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260508094522.3952-4-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7318A51D92A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[starfivetech.com,motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287020-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:email]
X-Rspamd-Action: no action

On 5/8/26 11:45 AM, Minda Chen wrote:
> Add YT8522 100M RMII ethernet PHY base driver support, including
> PHY ID and base config init function.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/net/phy/motorcomm.c | 49 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index ebc24f51e626..13d57aba5487 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Motorcomm 8511/8521/8531/8531S/8821 PHY driver.
> + * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
>   *
>   * Author: Peter Geis <pgwipeout@gmail.com>
>   * Author: Frank <Frank.Sae@motor-comm.com>
> @@ -14,6 +14,7 @@
>  
>  #define PHY_ID_YT8511		0x0000010a
>  #define PHY_ID_YT8521		0x0000011a
> +#define PHY_ID_YT8522		0x4f51e928
>  #define PHY_ID_YT8531		0x4f51e91b
>  #define PHY_ID_YT8531S		0x4f51e91a
>  #define PHY_ID_YT8821		0x4f51ea19
> @@ -227,6 +228,13 @@
>  #define YT8521_LED_100_ON_EN			BIT(5)
>  #define YT8521_LED_10_ON_EN			BIT(4)
>  
> +#define YT8522_EXTREG_SLEEP_CONTROL		0x2027
> +#define YT8522_EN_SLEEP_SW			15

Sashiko noted that the above value looks unusual/inconsistent with other
register dedinition. Should it be:
						BIT(15)
instead?

Otherwise using GENMASK() would possibly be more clear.

/P


