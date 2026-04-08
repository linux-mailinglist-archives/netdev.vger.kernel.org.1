Return-Path: <netdev+bounces-276661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNWPFmGP1mmEGQgAu9opvQ
	(envelope-from <netdev+bounces-276661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:24:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E64473BF79E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD08D307C2D1
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134063D1CB4;
	Wed,  8 Apr 2026 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="Oaii7BFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33A3D75D5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668961; cv=none; b=bPkPNdlXZeOb3xje0ck6ItZ4KInXNrzzwyvQLmg6jhUjrEuZEGODJwAsY6OX8fLoUmSj7e/BBpWo5ObW5wNuhfNEgKWtlv3FrLzPfbh4gypMBcjtioL1RLFd3VHaQYvO3C3WpzVffnAXyRJXS6trFhyA5yuVF6tw/tezpnkcRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668961; c=relaxed/simple;
	bh=gNJduQx8uBBAIyt5/XG5cTtxBJWJ2wWwKg9EVpn6lE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQUk6Hs68HqV/Jf02Zp0mJnImDtrTinAhYJMJUhnFBFwUdrZJpY0evqc/1RezgA6g8o+jO2BqlHWIYMGTQVKCZbGVP7xlnr7vQH64NrJTuduTDaSTx/V5H82lBbkRNx+WadQ0iWhFpIOnz7kjG6epQuv1QvCj0hhmdtEwQAlVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=Oaii7BFc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso15091775e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1775668958; x=1776273758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyRjAExzptaZ37zBDXbJb6e5/hLDzY5/zkTN8PmV6NI=;
        b=Oaii7BFcfdgtD+RC7d2xsPVPhjXwM8nuzxIspweJl6mn6zyvXxyvnYsAmlkBi6k18P
         8z/BIqcG9ooXBmeVjpm4HVWJrYRvTsIWVGfdU5lwGgIK/SySz3sMPe7taWlKdxeYhVda
         A+RIAPjf3ikRFr7lW4xxFXVKTB//PStJc1ufFQjBFK3KtzXkWu4umnOVWcBmatuFyCej
         c2TYFWNbw/J0hZCdfSJJ+lwEigKyLTNVogh/cuvvMa50EbBn0SdcFgjm0ofNKX9jliwO
         m8LS2aCVYAJVBhMk6pbaNsvnMh7wGGmGLTUneryK2tRhQ+IHDrfcDYgWzRTdoSfxKFTM
         OD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668958; x=1776273758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyRjAExzptaZ37zBDXbJb6e5/hLDzY5/zkTN8PmV6NI=;
        b=gVy0DOHL4rJlaToSRV6yS1g3oNWdfDE+iIeDJcaTfUe98ioAn7tsvtzNIb8/nDLToA
         2+p2+sDFL5cgsr1uFdxr6g4sv4EzH+ettdDm5KfVIjMwYmCUKw/3/6DEdL68FsUrYv08
         mrE9eFIcWQwPsurtrxxzySNHAmNsFnuoEba+n3yhQ0iuAG5HyxHdO6XCoT1FGAVO91ek
         VN/GWHic+3v0xW9zOmo9u499UcKOx282rtNIEpA3mQyPwC2IyQ8uQ3L/MJEowSAE8GEG
         Y2cPKjJyqsMpuefR7jPlYPZDGZyAjP7oeIOVTKJ3LwvAjI/sPlpgsPdiRYSkUC6P3w9/
         EW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoZnTu9aprx+L7c6cb8CEGm9H0Wdo9sBkzR+53fct1ulQXWUFw9/N3/fNVSqEVtbWC4RRfb4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWA7PZWE9E8tZ9Ga2E2iyQbO+M5hzjtpPyU7jzKfKe1uIk7ZiS
	USRekr/3MHAm0LGzQ/lbjRWSIfRpUSn2xfDPvemCNjDmqKCxiI67hfEstG3ydDNaBi+R
X-Gm-Gg: AeBDiesSzYHuhc5RLaBXfvoSP9WicilJI//MQ2glappp9skGLJiZlh8MFUHRlcxLKJM
	4TfUN5FWZgrrXB1jZLmUEUUoRFvbCQoF3lygG5syoGRCk9nD0klPA/ht4b1OAl5IbIb8ZwyIbOi
	pSecjQBXrkVJL42FtY6z268NiQj59uONeGYkJig7BbE5ZcfauNADQy/X5AR/PwKU225XWzrrRLr
	iy4+N20Ky0DSAieebu2Z41jZdIhVuMPEJy4OTGra+ZgE44Sz/FSkdytOxv+IbKWHJV4P9ZT5+P9
	3/En1+4UsOlzcZussK63amydXvJk9lRT+gDQPzsa0R11UZfQftKmHghZltJQFqsbF/Op62N0eY3
	zye1gb6sGJieS6uTxR0c5u7/q8JmPp42TLyvfgi8drNeLn1BzLM2xeI0CmeGG9bQzilvyvrf6lf
	s6Iu3LH3oWAJh3hY9apV/BR7SgaORzJ1wwZhZLyvEKJ++4tlLgFpp5H6Rz
X-Received: by 2002:a05:600c:354f:b0:488:c239:d498 with SMTP id 5b1f17b1804b1-488cd557418mr5167705e9.8.1775668957556;
        Wed, 08 Apr 2026 10:22:37 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd1b57f8sm6879605e9.7.2026.04.08.10.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 10:22:36 -0700 (PDT)
Message-ID: <430cc8b9-21f0-4954-ae36-ec5e63f3ef9d@bynar.io>
Date: Wed, 8 Apr 2026 18:22:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: raw: fix ro->uniq use-after-free in raw_rcv()
To: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Cc: mkl@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <26ec626d-cae7-4418-9782-7198864d070c@bynar.io>
 <c67d6642-8078-4144-8b21-f0e882ecd61a@hartkopp.net>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <c67d6642-8078-4144-8b21-f0e882ecd61a@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-276661-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bynar.io:dkim,bynar.io:mid]
X-Rspamd-Queue-Id: E64473BF79E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 08/04/2026 17:28, Oliver Hartkopp wrote:
> Hello Sam,
> 
> many thanks for your investigation and for the provided fix.
> Excellent work!
> 
> Btw. you also suggested a different solution with synchronize_rcu():
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index eee244ffc31e..5bb9a84f2471 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -431,6 +431,13 @@ static int raw_release(struct socket *sock)
>       if (ro->count > 1)
>           kfree(ro->filter);
> 
> +    /*
> +     * Wait for any in-flight raw_rcv() calls to finish before freeing
> +     * ro->uniq.  can_rx_unregister() scheduled deletion via call_rcu(),
> +     * but RCU readers (raw_rcv in softirq) may still be active.
> +     */
> +    synchronize_rcu();
> +
>       ro->ifindex = 0;
>       ro->bound = 0;
>       ro->dev = NULL;
> 
> 
> Can you tell why you preferred the destructor solution now?

Thank you :) I preferred the destructor solution as it seemed to match the socket lifetime model better and I wasn't sure if the blocking sync in the raw_release() was too heavy-handed for this specific issue, given raw_release() already holds rtnl_lock() and lock_sock(sk). That said, I'm happy to defer to your experience if the sync fix is better suited, I have tested both of them.

> And if I see it correctly the UAF problem might also show up with the
> kfree(ro->filter) statement we can see at the beginning of the above patch.
> 
> So either free_percpu(ro->uniq) and kfree(ro->filter) should be handled after the finalized synchronize_rcu() process, right?

ro->filter isn't accessed in the racey raw_rcv() path as far as I can tell, and I don't *think* there are other racey paths but it wouldn't hurt to handle it just in-case. I think this would be simple with the synchronize_rcu() patch, as you mentioned, but I'm not sure with the destructor.

Kind Regards,
Sam

