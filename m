Return-Path: <netdev+bounces-292623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Xl6FG0cKGGpzbAgAu9opvQ
	(envelope-from <netdev+bounces-292623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:26:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE125EF8EC
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50FD3303F0DE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8F3ACF06;
	Thu, 28 May 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVieIL4w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFNK6Luf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5903AD527
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960125; cv=none; b=dA92RFqKwFEadx15rEh4aV8/Il1Xva5k1L8+pe28ZqbAjeXj+2rzXGOtvfPaVnkj+RsmNvRuydUHLAU6/TyZ4+BkudRw5oxaK8VZVgOOyw7hNTjVdx1YpPu7d1c/8CJZMIJrY2nhvDQ+Gje1kUn4uDqxkXUNDrbh4VB0/+vSGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960125; c=relaxed/simple;
	bh=nJVUxyWZa+V1ByNm3ZhRYPEuoWYvEqyF6CfNU4rh4FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXktq7WoQGuH2ymfqmQ63YRbGq8SOtDuVf6dpFpbbg4SpCZIomBfwmzhp8oKHF1keM7K6B4YcS+xGBsYQonkEFd0tCx9B9nc5F9Ndr6+uIeRKex7ooBEavP4Ja16sCfHAFtbO2IKUm/y/PBpuhq+jbZFkwo672ePVRK3YECxAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVieIL4w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFNK6Luf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779960120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLZf/gEoFeqM9D8bf4wJzukHATe1AKQd4HAbi/Vwpq8=;
	b=BVieIL4wgH6RJKF3J+yPbG4QUmoGQyjqo639tkTuF31YvdEffQ5RkpTr0CoxAURmieLyfO
	odKOMbTDeUBv0hg6BRWnXiCwy4ufjp7oQhrN2mBPJx2Fb5rXQbFHl0HYS3SskARP/D680C
	D5SPb8Qm8ZhgC75oH5f2MOmio24MbRQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-82lffljCMbiy8xdC-2DFAw-1; Thu, 28 May 2026 05:21:58 -0400
X-MC-Unique: 82lffljCMbiy8xdC-2DFAw-1
X-Mimecast-MFC-AGG-ID: 82lffljCMbiy8xdC-2DFAw_1779960118
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49045243094so85517575e9.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779960118; x=1780564918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLZf/gEoFeqM9D8bf4wJzukHATe1AKQd4HAbi/Vwpq8=;
        b=cFNK6LufLD1vr5p+21sUyUrtYEImfjFOfJMs8ayGnT5u0JsevVgOFZZZI062I7zTwE
         GQq3YIUG7N8iNaKogDaH11FrC24dvXDdw+RO6dMEUTRwZs6RrYb680XJ6t2TxtOScE4O
         AiwgEsk3CQE+Dwv335Y2PJbNm2PHkIDxhzXuo8pxE39mchGiT+Q2sxA1JdWsfoRA5PWv
         JOPalqQqB78ZixSG5aKdZFBla4Ef63iYephd81+zyWEhPv5GtULLJ7mbEuZpq1X65wwd
         GSeF1mf9vN86qOKDxSe+ISwpo0NYGVxTzlkenyj2bbOnlkbvjiqEOA4qFFFjrjwTCcmO
         7bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960118; x=1780564918;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLZf/gEoFeqM9D8bf4wJzukHATe1AKQd4HAbi/Vwpq8=;
        b=iLUbDIk8nBZmfSxtgXisAiLH6Rf0OvTx9y6WOqvQA/WFWbH5xn9PAfWMa9eW9uTF4q
         DNQO6fK9wD/dmprDCKytDXNrGR0Bx9g4Q9P2RLt1WFDPYx6z40k9CMzhpsgeqWUQCxaO
         5cg8gQrWxF49qq7plfW5IHbgtPZAO2r58o35g+3rcy6qboF+B5OYhijpU0yf5+BVmPpy
         0st+qgt2zZDnMGia5OAZxtCoOrZjnA3Fe90zfOcYWWpp64TG5Dsc8lOXtDyQOuCE/DtG
         EF91XUuYDUO2kpoNrLpaVSNsZ1gUh/ys2RJ0VwQqdcQOu72jX7htLFnGHuaiTrJaSQrm
         K1Lw==
X-Forwarded-Encrypted: i=1; AFNElJ8uQ+O3TppVzXBTj4NhWk12JcIbQXNVSuzD7avwkx1i05uHGitpbRHjcgtFckvt07LIJI2FcZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf0jAgkm201Biiy49AqXUDje1QPdE8aDDnIe/Qj+R9fZ1fhLaH
	FAY+SjquZZQp6IR0+pYmS50KqOQN2wnqgBynXaFjksoYvcc8+BlxBnVwjUMSNRwJCSNT+/ZcY4n
	Vzd3GQNuzzxPFz4z/gk5IpsDmz6k5uHuyscxavXVE5352RLmTC8ElKlspeA==
X-Gm-Gg: Acq92OGlJOhLfhi5F1rGXbCh1N4l6nAiUaTf9XYRmh3vzRNL4+AiqbVUOamIDhc0w+c
	b/+nsaLy71upd2r/AKnbxOBpZtReuTgJJrfWrghoNNJENhstiviTQO1msVPC+blg4DmuB3kmegQ
	1YLng+Q8WUeB5Ipm+Px7AWBHQWG0KJyfow3ik8jaQnt36IMRcReCeaSEkr0KaZSQogHfhv4kKEl
	n6FHme1LI1y7IRd5o4+m7TPSnxQQg62X9KsM0aL4VLe1bt1OTdOk7mVhanWIOMuyVqSE1YHxMdy
	gEaMUnsTLI3NfdsuuJeQrL2lu9h7U9eYDtYjG+Z5sGSZvrY/bM45D2y9xTl3KQGWI/33HfHTKFR
	PqQvfC9xLE7eKm3Y1Jq5rfiiCXmO/HxS1+jaQxJuMuWi5YeSF/DyqBaXljn6cvppwgA==
X-Received: by 2002:a05:600c:4e4b:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-49069da6188mr214388035e9.13.1779960117633;
        Thu, 28 May 2026 02:21:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4b:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-49069da6188mr214387655e9.13.1779960117166;
        Thu, 28 May 2026 02:21:57 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb549e79sm13177936f8f.7.2026.05.28.02.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:21:56 -0700 (PDT)
Message-ID: <2f9c5f6b-1d8d-4c8b-815d-77a40aa76e23@redhat.com>
Date: Thu, 28 May 2026 11:21:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: t7xx: fix race between TX thread and system PM
 suspend
To: Tim JH Chen <tim770802@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tim.jh.chen@wnc.com.tw,
 Chih.Hung.Huang@wnc.com.tw
References: <5315a3b0-4fc8-4d74-8e27-d7b84bd794c9@redhat.com>
 <20260525031320.519435-1-tim.jh.chen@wnc.com.tw>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260525031320.519435-1-tim.jh.chen@wnc.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292623-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 6EE125EF8EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 5:13 AM, Tim JH Chen wrote:
> v2: Address two concerns raised in AI-assisted code review of v1:
> 
> 1. [High] t7xx_dpmaif_resume() was unconditionally restoring state to
>    DPMAIF_STATE_PWRON regardless of the state before suspend.  If the
>    modem had already been moved to DPMAIF_STATE_PWROFF by
>    t7xx_dpmaif_md_state_callback() (MD_STATE_EXCEPTION or
>    MD_STATE_STOPPED) prior to system suspend, resume would incorrectly
>    re-arm the TX kthread guard, allowing TX HW writes against a modem
>    the MD state machine considers stopped or in exception.
> 
>    Fix: save dpmaif_ctrl->state into pre_suspend_state at the start of
>    t7xx_dpmaif_suspend() and restore that saved value in
>    t7xx_dpmaif_resume(), so a pre-suspend PWROFF is preserved across
>    the suspend/resume cycle.
> 
> 2. [Medium] The v1 second state check before pm_runtime_resume_and_get()
>    only narrowed the TOCTOU window -- it did not close it.  The state
>    field was a plain enum read and written without any lock or
>    READ_ONCE/WRITE_ONCE annotation.  After the check passed on one CPU,
>    the suspend path on another CPU could still set state=PWROFF and
>    begin PM teardown before the kthread reached pm_runtime_resume_and_get(),
>    reproducing the deadlock.
> 
>    Fix: introduce tx_pm_lock (struct mutex) held by the kthread across
>    the [state check -> pm_runtime_resume_and_get -> pm_runtime_put]
>    sequence.  t7xx_dpmaif_suspend() acquires this lock before setting
>    DPMAIF_STATE_PWROFF, which serialises with any in-progress kthread
>    PM section and guarantees the kthread cannot enter
>    pm_runtime_resume_and_get() after the state flag is set.
>    READ_ONCE/WRITE_ONCE are added at every access point of the state
>    flag that crosses the suspend/resume boundary to prevent
>    compiler-visible tearing.
> 
> The original v1 description of the root cause and tested fix still
> applies (deadlock between t7xx_dpmaif_tx_hw_push_thread calling
> pm_runtime_resume_and_get() and the system PM suspend path, triggered
> with ASPM L1 enabled after repeated suspend/resume cycles).
> 
> Tested: no soft lockup over 500+ suspend/resume cycles with SIM
> registered and ASPM L1 enabled (previously triggered in < 300).
> 
> Fixes: 05f7e89ab ("Linux 6.19")
> Signed-off-by: Tim JH Chen <tim.jh.chen@wnc.com.tw>

Please have a much more better read of:

Documentation/process/

especially:

Documentation/process/maintainer-netdev.rst

before your next submission, because this one is still lacking in many ways:

- subj prefix must include the target tree (net) and a revision number
 (for the next iteration: v3)
- fixes tag should point to the commit actually introducing the bug
- the commit message should describe the issue and the fix, alike v1,
any changelog-related information (~all the above) should land after the
tag area and a '---' separator.

Also sashiko has still quite a bit of concerns:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260525031320.519435-1-tim.jh.chen%40wnc.com.tw

and many of them look real.

/P


