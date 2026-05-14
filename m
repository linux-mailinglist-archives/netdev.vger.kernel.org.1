Return-Path: <netdev+bounces-287933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JgDHU6wBWppZwIAu9opvQ
	(envelope-from <netdev+bounces-287933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:21:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B90540EB6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E111D309300B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA4393DDA;
	Thu, 14 May 2026 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbNPHEsw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbYMl5hk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B73BED59
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757500; cv=none; b=d1BlJfrcZoIOewLmirpVDdnn0ToFsRc/jX8xVI6NS6mbnND1aJHkT/YE6c/jMlKWHJ9X1NA/v0MurQcp7jrZrBYKs86ENujbVpS1O4LjTx6eleBm+kXsLsIakQlC8+GZWBxQ2UXEce+O3BF4ukJIIQMmhTXM41iYWIHHYKa4dSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757500; c=relaxed/simple;
	bh=QY6s7AfEenXtWFuj8Lf7D6nSgMrs3WQlj/inWWmt53o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK/yDTyuf/R1VzISZSYoymEDtKNzvHnhTe9EEuVAwG9KiHqGXMVNAhnrPKAQorp0Lx6j2o256YaTn1WFDT+PEu21fe5ZoRU/U1j4sigiFYXalHpM+KN1En4IKCCXoS75UblQvdZdYjKpBqO9nVTeM4cKF7s3hZLV6XrxqP2fhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbNPHEsw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbYMl5hk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778757498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COO41hKBYdHBD+YBwmNP96xVT9h6SMU1rdVHr5HzbAU=;
	b=NbNPHEswY4vcLNb8Wz6a0bUv+7AirwYuHumB+baYLf8K+KetluDVxqqkoz6TmtvQlcx6zV
	/i+nHoXCL3HzoTuxrPRROvoSuxlymrwuZduyVh4f9H70kU9LTQimepj26NuuV7MfzmZ5Os
	d9dT8dLpAyTWN3avqV/SxoL3Z44/GQA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-I-a3-iaiM62WO8xfiy2bEw-1; Thu, 14 May 2026 07:18:17 -0400
X-MC-Unique: I-a3-iaiM62WO8xfiy2bEw-1
X-Mimecast-MFC-AGG-ID: I-a3-iaiM62WO8xfiy2bEw_1778757496
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so5123289f8f.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778757494; x=1779362294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COO41hKBYdHBD+YBwmNP96xVT9h6SMU1rdVHr5HzbAU=;
        b=SbYMl5hkfLdNudDn2lvbSgbKw/BIXNh6GPXz04mPmgMXmCFU34E9HIVC+USF6gg0+c
         xNkGFS3ZLtkCuhmYarMNcwp1vAs/BZVzm6pqr4ERu4BQ69RzFzN3aQ/tiO04DT/OgU23
         Q1KB2VpdMKIPxyk3KNjYOt6Ben7bOOxUqzYb37TFpcTSuY+Rp6tInG6D+19wDZ+j69/c
         QsVR29gJuR5NleO5cpb4jn9hVHfElkW+08JOa7BNGZJtY3Lep0vE3gHCOlBVyfAqnjx0
         paEqHzX1KU8EK9eZmBUt19OnhmD32bxzMUL1k8hZZiW/gUN1IDTt3PHC5GCc7jbm4+O8
         NXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778757494; x=1779362294;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COO41hKBYdHBD+YBwmNP96xVT9h6SMU1rdVHr5HzbAU=;
        b=KEviNd68jphThU83KgPV3BV7xegbsTR4hLIxyqfPsBl/VuFSgdQTWR46yWUkPPlQib
         r+wTUsyAwfgYVhuTAgtbLcKsrfZh6wpH0TT7PFTxrpSVM0M0oXAueAR74u/B3RFy02tn
         11zsMqY1/dSrdHuAn1j/lu7sBp76FbF6DBb+pLV5ucGxbkwghiVAGdn2kFXweyjjc5Ev
         aQQ44s/K4Qg7v43uC+Zpx2WkTSxzQ18a3DH9+bJ+UT/XU5U94HfIJogdUrzr8aPT49Q6
         jVMLbemSjyvXSVytIJ98A/R9T0kV+m6N7J2llHl+7f1qdKeU8r4VdXMaabFTV7j4zoSR
         pE8g==
X-Gm-Message-State: AOJu0YwkCtkFRYwcn8deAh5+Eloji6qndkX1QSfqo3+WFBb7yeVgzN8q
	Mkh4KPn9M1GaE+6JwZgQA9MWrzMRWQ/kdOe5Kh2uWRGQ5W18e2RqMfwXIcJIqrgDjWEg1b7JEnf
	9kxXO8MeTG5dLLGMMZFyuP2UJNji21RutFnWfylRL/ydJlcnZRSUjYMplEQ==
X-Gm-Gg: Acq92OEVHIKT9i8R7I5/pFUiK2CsnMvm2I3v+UYVqlEzPqFedcLJO3UcNSZUJ2Ipkx1
	x459KWavilHmatz1/o0DROvJKS77ITD+esINUQm5EMyINSgbzrNiTemk3BYid82Or3EXOWE+384
	3Ek0cZPyTUp7plFbTYqIdaKtyeUyjFoPoFfpW0ZA/9GmAJU8VIEg4GeG96xBLp+Zf4JAmJWavvU
	eA9KTAhPKDxb6FPxVo7bmNEtRTLDieG19WX8NKoLGbm22JxFM1Erlc2rxtmPEFAY1pNthvzaG/9
	QJ/a3VvH/UofIhJwYO6TXkiYF8JogR3tmySZ8cOig9Bb6JE6pO1y0E8DqoS46MWVzTxONvWFEfg
	dlMv2Zq72JPHYUTdZ1BF6BjIOZlkiRgGVFuu8HcKeMe/OEx98SHEYksM=
X-Received: by 2002:a05:600c:468f:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48fc9a028bemr103922755e9.3.1778757494238;
        Thu, 14 May 2026 04:18:14 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48fc9a028bemr103922145e9.3.1778757493719;
        Thu, 14 May 2026 04:18:13 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6498cdesm71780365e9.5.2026.05.14.04.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 04:18:13 -0700 (PDT)
Message-ID: <a83d79d1-b932-458a-b5fa-1cb623fa03f1@redhat.com>
Date: Thu, 14 May 2026 13:18:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 4/4] net: tls: remove bad rollback and UAF on
 ENOSPC
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sd@queasysnail.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-5-kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260511174920.433155-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E7B90540EB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,kernel.org,queasysnail.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-287933-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 7:49 PM, Jakub Kicinski wrote:
> As explained in commit 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
> once we call BPF there's no way for us to rollback the iter
> and copy data, since BPF may have modified the message.
> This is regardless of whether BPF set up cork or not.
> 
> Remove the attempt to roll back iter completely. This removes a UAF
> since BPF may have modified msg_pl and rec, so these pointers were
> stale.
> 
> Note that I'm entirely unsure what the expected behavior is here
> for BPF. Feels like this path must not be exercised by normal
> applications / existing deployments in the first place.
> 
> Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/tls/tls_sw.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 360f71fd7884..22b77840e35a 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1164,11 +1164,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  				else if (ret == -ENOMEM)
>  					goto wait_for_memory;
>  				else if (ctx->open_rec && ret == -ENOSPC) {
> -					if (msg_pl->cork_bytes) {
> -						ret = 0;
> -						goto send_end;
> -					}
> -					goto rollback_iter;
> +					ret = 0;
> +					goto send_end;

The sashiko report here looks like a pre-existing issue that could be
handled separately.

Still let me play safe and merge just the 2 first patch in the series.

In case of a repost, please fix the typo (repetition) in the cover
letter subj.

/P


