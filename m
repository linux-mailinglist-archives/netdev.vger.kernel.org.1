Return-Path: <netdev+bounces-241145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC2C803D0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84C614E3197
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF122FD7B2;
	Mon, 24 Nov 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvm2hGBn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYVgTCWO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FFC23B612
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984520; cv=none; b=fsjpCjajKcB4UJGj6wkHQKkKeOFg0QZ0jdTTfBYE2hcRIXFjX9dECGAzQzF1wVrmNHNVJIp+/9CI4KLvWe2k51sBJNFlRpiu3uN9MVnxHf0K2zVzRtByT+ziPkFHKmtJp59r53kcP1aqJZKTmZn8jnvAMsnhbCq7FHsuEkqYTSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984520; c=relaxed/simple;
	bh=uRfp2lW2gNOwFoOfgY6ePrvjcAHpd92TJ4csW5PyI+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKCc1mcKTx43nQwvzQAchNL6yNc2hpSGbzu17wWOQTqE5/O61ZyDIyzO+U87gDhmR4CWFg2tIjSuCaKJGcCcwc35yvfx+3UEBMYJ201lX0fEVBqa07gKRO8UGEQ5TQmvb3v/8uit1cHPzwzQUg5pA8r5/Ayzb9EQJCyhffLMCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvm2hGBn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYVgTCWO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763984517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59ffXYnHIKK4VAVsmKOed/k3AlpgsniAKYK68betyEk=;
	b=fvm2hGBnKLB7qygGz3WiK0LjclJFMrf+ZIe4/mZFE7WyHATgxsenCAHW/qAtXfBaqnxm2I
	2WISXv7iEJ9n/d50gEc2EvPU5guFLV4xzvSYSbx3EVdgriomBMI8cjRp+5gYL9nEt08eKO
	XVpdVgUhXmb+5ENQxNyTZvB4K77xUFA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-cKGYBW_ENUqzDpzxWdTPxA-1; Mon, 24 Nov 2025 06:41:56 -0500
X-MC-Unique: cKGYBW_ENUqzDpzxWdTPxA-1
X-Mimecast-MFC-AGG-ID: cKGYBW_ENUqzDpzxWdTPxA_1763984515
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477939321e6so24518775e9.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 03:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763984514; x=1764589314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=59ffXYnHIKK4VAVsmKOed/k3AlpgsniAKYK68betyEk=;
        b=WYVgTCWOvrURBb8MqTa1niK1SjAVHWZU4kUqZepH9d0TyAGdBICY7G9pWfFZIKpjcC
         XTAyjf++Qib7cxu79TfWyfLvepS6QVmpf2TSNrs2tP5d3Z0zQpYAiMjIgMWsKTsnadwc
         ueucXdMPKKwuGGxL2RKujYpurlTQDnvsxI8fmSc3iUkd8m1BL7bTCmcT7wvdFt0s/aeD
         IUqbhnLT7qBSKFOnkfjAkf/OGUXIsqnehiI36OmMV1Rj1i4bRpTZFyo5Y4C8xdBgPaT7
         ZVIuyNREJqbyeRHh41zrwXEwS+0rPEndroYxTrZARuaRgFdf3ESIGrdOilUL2K0M4qNu
         PCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763984514; x=1764589314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59ffXYnHIKK4VAVsmKOed/k3AlpgsniAKYK68betyEk=;
        b=XM54M9CPpSz+e1O+N3dJ5qQHzGCU2Eq/NyreW1jj4GE1aqS2HyAjh0606xoGU9cfKn
         1c6F3c9U5GaSs2hLwPfLKsdzf1FkzVjsEEeJnt4Fq5faxb1CEsfGipEa+xfYHgheOKL+
         iLF5L9kpqiCkHwcRGYatVogTakncjUAMhPwL2qZwM3r077dVEyfHpytBPv2YCUMgYll+
         ubEW/7uurSAxJ9mqz3iPZLQq4HRWtDNMS7mpgLczKtZWMUHyVpsFsrnbvYwwxm9frKV1
         HPv2cx+KgXhYaDc1fOxv07oCmTgl3UXzYESPmUzTKsaV/wqE7EM7fevWbFOEhEJaUXYB
         UM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWh7HVf7rWQYvGA+ZmarX7ICt/MVk74Nzw2/5pFXmmQD2l5gBhsiNbMhO/+vH3qzbPMUEzxSQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsK9JP8hZnujxPZZ9MqLe1C62Sc1JWiUPZDjX0iaQUASJ5CoER
	nOOu5u0Bukm1CBl0oB7k4DvQs3cweKgEaNK4G6I00oCASdAmXZHvs8VHa0cpx7kagYOXS5PrHfm
	SQKSlgFroyu9VMFYYtZfTLNdN0A18Ns4YZUNHM5hUTJFAqm26IngGVYgVYpahWMWF6w==
X-Gm-Gg: ASbGncu0dSlxKwr23qgAO5mconRsQbbFLYaHPDniScA3Ui1U8wR5dD25I6kwkTYt0cP
	kw4V+hkfgACDburZ3KSipeIWwkewAC2nm55gIw3xiHjWqrH22gF4NkwhrsCvlhRNWpPxweF+GH7
	wZMzAP2IH9B09F5yJ5byiThB+6VwZXDqAqYAp7Yuogrp+gWFHS20xENtcvLJGhwAOYpD9mfIf4k
	iK9YqJf2DBLUAkI4fOUI73YvTqjlpaoB8K/TfaLQ6F2YIcaOT+gCOst50S+JN8tAdALozRVWzrl
	f0Er7gkd+m+PkVoKAs4bavP3Rbj/aIGVpVRNyupc9oyh/jtgqW4ivgZJ0KQw6RfCMKjsibkRVy5
	9Om/lD3RUVNM6QhA2QgVYVshaoJWzlQsHx5VPnoJToKVaPUCmDQ/yhP/Jgappdw==
X-Received: by 2002:a05:600c:470e:b0:477:79f8:da9d with SMTP id 5b1f17b1804b1-477c01e9dbemr135366995e9.24.1763984513949;
        Mon, 24 Nov 2025 03:41:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv4eKEkWdkYcAT5ZU1Xz7TGXfRh0Hl/AgIDLxFq57bGT0pkgRagAd1ruOd0IJFZ3Ag0iuVxQ==
X-Received: by 2002:a05:600c:470e:b0:477:79f8:da9d with SMTP id 5b1f17b1804b1-477c01e9dbemr135366655e9.24.1763984513501;
        Mon, 24 Nov 2025 03:41:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcbca9sm148486715e9.6.2025.11.24.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:41:52 -0800 (PST)
Date: Mon, 24 Nov 2025 12:41:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Extend transport change
 null-ptr-deref test
Message-ID: <ndtaldhrxi7vkqw3vidy7yzs3e3td2jf5q7uystv5ctjbcaw2i@lcutm3s5qsfk>
References: <20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co>

On Sun, Nov 23, 2025 at 10:43:59PM +0100, Michal Luczaj wrote:
>syzkaller reported a lockdep lock order inversion warning[1] due to
>commit 687aa0c5581b ("vsock: Fix transport_* TOCTOU"). This was fixed in
>commit f7c877e75352 ("vsock: fix lock inversion in
>vsock_assign_transport()").
>
>Redo syzkaller's repro by piggybacking on a somewhat related test
>implemented in commit 3a764d93385c ("vsock/test: Add test for null ptr
>deref when transport changes").
>
>[1]: https://lore.kernel.org/netdev/68f6cdb0.a70a0220.205af.0039.GAE@google.com/
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d4517386e551..9e1250790f33 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2015,6 +2015,11 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
> 			exit(EXIT_FAILURE);
> 		}
>
>+		/* Although setting SO_LINGER does not affect the original test
>+		 * for null-ptr-deref, it may trigger a lockdep warning.
>+		 */
>+		enable_so_linger(s, 1);
>+
> 		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
> 		/* The connect can fail due to signals coming from the thread,
> 		 * or because the receiver connection queue is full.
>@@ -2352,7 +2357,7 @@ static struct test_case test_cases[] = {
> 		.run_server = test_stream_nolinger_server,
> 	},
> 	{
>-		.name = "SOCK_STREAM transport change null-ptr-deref",
>+		.name = "SOCK_STREAM transport change null-ptr-deref, lockdep warn",
> 		.run_client = test_stream_transport_change_client,
> 		.run_server = test_stream_transport_change_server,
> 	},
>
>---
>base-commit: 73138ebe792b9af2954292cc5cfa780a5e796d97
>change-id: 20251121-vsock_test-linger-lockdep-warn-e4c5b8dea5e0
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


