Return-Path: <netdev+bounces-281494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLr7NmzP72nZGQEAu9opvQ
	(envelope-from <netdev+bounces-281494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:04:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED99F47A7E6
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13E4D30046BC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7055D3A7848;
	Mon, 27 Apr 2026 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db4jaSZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0E3A6B6D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323878; cv=none; b=DgmUGeKq3tTP8vO1G0LewNcRW/bX/xkN6EnwRIKvPKA+vz9qwyfcAIf+cplfKBnsyULY5pKGEglIazsgGJgc14VfkDv6RvtRpX0RzcO2Xe81d9ugNkEHbDPEmbdXtetH4vgdv9n4I2+NU6duhJTL4Oanrxul+WSK78dGXaLAiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323878; c=relaxed/simple;
	bh=PhAmHIuLvpNp7ctmaH4tezCv2LiyD081BC2kdmANgsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvEv3l/NlsKzWGa3y6SvJ6RZ8zDxreWWBm/BlgiVpNu5rFKRjm5MA6hzx8l3lh51e4TQ8UpVKvQ4SJ+h7o25+4Y+Sywypv6t1rqgrdYwGCd3tHgI64BEiYOU4dVA22SSVvceGcBC/SEnfyrQJMUcM5r8LFERf2m66gnURUgxcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db4jaSZH; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d6d5e45c43so1190316485a.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777323876; x=1777928676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhAmHIuLvpNp7ctmaH4tezCv2LiyD081BC2kdmANgsI=;
        b=db4jaSZHAantfFW8rIBMy/kgpZFYhDyDHjLx0K32yRwR8s3YldNXAonFByV+wggFAk
         8rsbl6KK3vy9knSEYbJ5eid7H0Qo951uZThL8QMAeh8+i3UHeSvovALhHUSYklFpmh2O
         1I5r7QXIqdl3A48cTPb8jzszgpQT2hMZxiYHP4tVSs86u8nhGjrFVBWzzNY/xOMNOcVv
         6Tt0mkS7ibtYHHVGTntz6hIBvqXi4IrZ5eScTGlE2A3yIxO3/jT86AQT3eIuOvVfsopL
         hu/qjlNKEkDhzZBuouBeYKYQfMS7X1lgsmIgzzJQ/zl9C/MAFB6rsMhjCPp1G+/JWZdj
         FxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777323876; x=1777928676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhAmHIuLvpNp7ctmaH4tezCv2LiyD081BC2kdmANgsI=;
        b=BHFtpZ4/8gptCUN/X9C9FjJQLuMDIQmNqHJnmcMZhURdrhxMGuKuZU2rQnIB/f3T0V
         uKY2iFkTSjFdl2/DE5RXMDg2YTwmzx6IB/NX4UPGhRKnY6EBHTAlgipF/OPCref9vMkh
         l1tt/cCXr4Igjrakwc1V5sXYyHdcyV4B1b9xSpFE8zWFglRPQulkZmnW4e3FTVXrqarP
         FwnLoG5jkFSphFXLi7JqEVXVw/sJQ5utWxNuqElmyuTnkbqEoED70ZC3iKCDGzZLdko8
         fwQChIb6u0W+GP0WPA9/235yCX8t28ZB6Up89zl1zb2vrxWvK3OdLdt3q0OUjxmhUtLc
         f+9A==
X-Gm-Message-State: AOJu0YxVk8oZ+H/Jp5gH7ZIiDT4Yd73BZSfvJ5TIg+mlQ5XF2/4Eun7V
	C07ZNXrf1hpIt49PNSkeCNTV3dGl9zcrykX2N/zguRH7a4/94VLsXQcv5SlEYg==
X-Gm-Gg: AeBDietXSS/bJ95T1SwhGaN2+9BXe1q//s6bRicphAhvg8GqDKBywTuKBBp3L1wkuSZ
	fKUHyGerqPVNRTiw47YChv6ElugmKCmtTwIvwh4gA5cPGba5qIcwV/+sF/8k0RyWZ4jrjZI6BmL
	XUWbpvDXnigEBXDeJ6bfTuJ4K+or4o8ITbFGBGO1HYxLkZ37Q+aQFe8vZe3jWxKYC3Nu9H+8kuM
	pPtBP7HwGLPRqmI4pLt+LRCjwUcQdEWRXAqF5TMVgIhwA+4vcAUOEta/T8hu37oxVXvrKaPE7mH
	677XgB3xfQJ8Odz1V/cWtMBxsvSPgPAH57VKNBKJQrVgdERLu2FcQNuiUUxhNxFxAfpsHTqnrgS
	o7pGTFm6rxIIeVuL/lh0qdl2iqY6K/tFbvh3euVbrEYx9ZGLIHvyqdsfkt87bIOeCSPZenF8ck9
	8wNH3tGNQtSS+M1fQW5BhkCX0NjKqdeYvWO2gsmUqCU9QLwPfKpyJ+RyxseAXxxVwZHI5ndNzfo
	8EJ3vUJ
X-Received: by 2002:ac8:7d8c:0:b0:50f:b61c:ec5b with SMTP id d75a77b69052e-5100e101a2emr2826771cf.11.1777323875937;
        Mon, 27 Apr 2026 14:04:35 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11d1::11a0? ([2620:10d:c091:400::4:304d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100da66595sm3442071cf.10.2026.04.27.14.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:04:35 -0700 (PDT)
Message-ID: <56faf6ae-885a-421b-b945-8255edd04331@gmail.com>
Date: Mon, 27 Apr 2026 17:04:34 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: psp: require admin permission for dev-set and
 key-rotate
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemdebruijn.kernel@gmail.com,
 donald.hunter@gmail.com
References: <20260427195856.401223-1-kuba@kernel.org>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260427195856.401223-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ED99F47A7E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281494-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


On 4/27/26 3:58 PM, Jakub Kicinski wrote:
> The dev-set and key-rotate netlink operations modify shared device
> state (PSP version configuration and cryptographic key material,
> respectively) but do not require CAP_NET_ADMIN. The only access
> control is psp_dev_check_access() which merely verifies netns
> membership.
>
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>


