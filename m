Return-Path: <netdev+bounces-75249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC79868D69
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790CFB25C11
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4B138492;
	Tue, 27 Feb 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiNtSMHw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53E137C5E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029409; cv=none; b=jLb7ZrTj8Y4qHueVRI3NVtRP5GiinvtthQOcBV6nwVb4SlO6D8sco+pWsovRMBYTi9dAwU90uzrlisAsjI3jE2zSiAGiZljH4vrBb6uhnL0AWOBXgFD/AcRCgrm09GJJLbuVTLsr+ceWuJ/j90ycIg1QLhZesbdz2xGUXXviess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029409; c=relaxed/simple;
	bh=2Q9KDrmM9tt6dM0nCK12JSvCihakXCdWBvUsQ+hydqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qL9dyU4vlj1/GWyGLoohveIMHN3rdGd15t3d6h7CL8BgB7zh7JeM3YS6urLOMAw2BTz4/wDAWHSEMmYSHOl4qnODtxOJBLAYaUrUi9hEFgmiYmtuKmpprSPnfYrD2Z7CGktqqWhaCN811MmXHDaSk1+fbZtmOfnPOedgv3LPhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiNtSMHw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709029407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WtGehCEFfElimHD+TqShgtHsXC4dbFxlCmNc54Gi17M=;
	b=DiNtSMHww6O/gV7Ta0ZGR4KSarrPv4KtoUwUDjkl+0zkaGfc6GfqJep9TrjDAOUp85o1SM
	kt+C3+wec8ccd6js7tJSjGxrUniWYHft9ZMjyP0SovpqRhEpC0UkUVgyAKpMulw5Nw9hJu
	mR5kIxJdMoh6dsQq8FwQpqUVtoJNq5o=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-OsQA6xCOONu3M22V878cNg-1; Tue, 27 Feb 2024 05:23:25 -0500
X-MC-Unique: OsQA6xCOONu3M22V878cNg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-21f6ac80f30so665615fac.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 02:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709029405; x=1709634205;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtGehCEFfElimHD+TqShgtHsXC4dbFxlCmNc54Gi17M=;
        b=p6uok+HBTGh/68LEWZ05/Y7rgz/625/6pr71zFvJE1YyhCtygOuDzCyWdv9y36QenW
         7DOf6heVO02eO7W7MFnGRcnPkvxDf/obUtzv1MSZZrwYKBoQtSnxibFlDpPwrA8vVOKQ
         60rHK1AGA/cyGbvdpB/NcT78o5njCxMZotoI/I8xMNblitvTF6DiF6w8uoEjDF+VlHD2
         KtSm1HQ5Jeqt9Lq5lB4kIhwTV9DXTrXGT02Gz72Ik2lfXsVJ1pcOwTxYBQz6ja2tKiim
         wTxDZ1M9tkaO8lm6vVjCvcOV43uKTxf6qDiyyM4R7pE9ipR0QJaANmSzYBCMwtuQptap
         9AuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJMTAoalZb+OO7TlgBUzy+0UNwXxdDG+xmPJxagWJmcJ76ho3HMXPqdzbvPekfjeBNg0Yy9ctnnfyABxa8AoWOP1W6aThg
X-Gm-Message-State: AOJu0YzEoGJiMGtybSGOVWYrKROwp0yvjBKkq2EKmcvNbavACMzQi/Et
	Jb+PoV0H25p6LszSZAFaI7CS0JJx8WOZn6qiOYobXRwJ6puhfDn6eZxY8NTAULR4rkOHCFEwVzC
	acGZlq4hpVK7emBIh0azAxtERW7i7ijvIU0c3b+oErBBEgPsW9sW/jQ==
X-Received: by 2002:a05:6871:7806:b0:21e:c50a:5e91 with SMTP id oy6-20020a056871780600b0021ec50a5e91mr10378075oac.0.1709029405159;
        Tue, 27 Feb 2024 02:23:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOrA1Nby4BCC+kPq5RbsZ68EDRxHVTjrQk/S01m5vEVtY4OYChDEowwg6U8GBImhvB3q18FA==
X-Received: by 2002:a05:6871:7806:b0:21e:c50a:5e91 with SMTP id oy6-20020a056871780600b0021ec50a5e91mr10378065oac.0.1709029404831;
        Tue, 27 Feb 2024 02:23:24 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id r3-20020a056830134300b006e496865b32sm1128766otq.43.2024.02.27.02.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 02:23:23 -0800 (PST)
Message-ID: <f656e38ff276f6c73d0b59eb301528cf3ae322e9.camel@redhat.com>
Subject: Re: [PATCH net-next 1/6] net: ipa: don't bother aborting system
 resume
From: Paolo Abeni <pabeni@redhat.com>
To: Alex Elder <elder@linaro.org>, davem@davemloft.net, edumazet@google.com,
  kuba@kernel.org
Cc: mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com, 
 quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
 quic_subashab@quicinc.com,  elder@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 27 Feb 2024 11:23:18 +0100
In-Reply-To: <20240223133930.582041-2-elder@linaro.org>
References: <20240223133930.582041-1-elder@linaro.org>
	 <20240223133930.582041-2-elder@linaro.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 07:39 -0600, Alex Elder wrote:
> The IPA interrupt can fire if there is data to be delivered to a GSI
> channel that is suspended.  This condition occurs in three scenarios.
>=20
> First, runtime power management automatically suspends the IPA
> hardware after half a second of inactivity.  This has nothing
> to do with system suspend, so a SYSTEM IPA power flag is used to
> avoid calling pm_wakeup_dev_event() when runtime suspended.
>=20
> Second, if the system is suspended, the receipt of an IPA interrupt
> should trigger a system resume.  Configuring the IPA interrupt for
> wakeup accomplishes this.
>=20
> Finally, if system suspend is underway and the IPA interrupt fires,
> we currently call pm_wakeup_dev_event() to abort the system suspend.
>=20
> The IPA driver correctly handles quiescing the hardware before
> suspending it, so there's really no need to abort a suspend in
> progress in the third case.  We can simply quiesce and suspend
> things, and be done.
>=20
> Incoming data can still wake the system after it's suspended.
> The IPA interrupt has wakeup mode enabled, so if it fires *after*
> we've suspended, it will trigger a wakeup (if not disabled via
> sysfs).
>=20
> Stop calling pm_wakeup_dev_event() to abort a system suspend in
> progress in ipa_power_suspend_handler().
>=20
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
> Note: checkpatch warns: braces {} are not necessary...
>=20
>  drivers/net/ipa/ipa_power.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
> index 128a816f65237..694bc71e0a170 100644
> --- a/drivers/net/ipa/ipa_power.c
> +++ b/drivers/net/ipa/ipa_power.c
> @@ -220,8 +220,9 @@ void ipa_power_suspend_handler(struct ipa *ipa, enum =
ipa_irq_id irq_id)
>  	 * system suspend, trigger a system resume.
>  	 */
>  	if (!__test_and_set_bit(IPA_POWER_FLAG_RESUMED, ipa->power->flags))
> -		if (test_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags))
> -			pm_wakeup_dev_event(&ipa->pdev->dev, 0, true);
> +		if (test_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags)) {
> +			;
> +		}

FTR, I would have dropped the whole 'if' statement above and the
related comment in this patch, saving a few checkpatch warnings. Not a
big deal since the the chunk is removed a few patches later.

Cheers,

Paolo


