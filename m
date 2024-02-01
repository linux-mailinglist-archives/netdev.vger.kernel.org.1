Return-Path: <netdev+bounces-67937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C0845730
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59847B2563C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625815D5DD;
	Thu,  1 Feb 2024 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UG+OYTja"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406B15B961
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789833; cv=none; b=uBLmrKKS+vqRhxW+hlf1PsEzqor8szTpS/qiIDLWfXrKu3N+WxlRMTHyXkNOia9W6/8LjRT5Vsb0pYONxXQB6etUiN1tXnhKMpDP7qv94Y4YVycrRWkkwl7uMg1Ti8YQtn73v0iwmTCjnuKqEYdP6QLcwbU9leUzfd3gyn1a9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789833; c=relaxed/simple;
	bh=BwJpDPOwCZ6hfhgM0pcatIEqybTJEyMIprXRX53mYX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aV8P13I8N5NvjQcGok9LArQ8SkOKA4l7eeaGJJSgDLHNHwwKkjP3fJstzlLQ5zFFKUpBtlaECzlK/TJUagFKCU9uF4UnFOyOgFkoWmstdou0EFayFo1WS15SEdNBC81ZyPArBXFxAcxdSoI2kvc7fcQWD5aVaZR+W1x3AdcHF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UG+OYTja; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706789831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tw6s2u4skiITOY45sxaPiA4OOpT4GcNpssXuxLDJLFs=;
	b=UG+OYTjaJ2Nni7vjVDYHwhtWIJIQ/SQ+f9VvQMDx0cyhVw5w9Huyi+qRAA3Zbx8BUXBVTF
	oaLnX3DlK1EI3BBbs0f6fR+BA8i07bgYMoDkJjhrnjixLkK4G4AonWuOvp/vyDILnAkO2k
	wYn2LSMJfpIp0kebRNXI/1S8DRcxW/A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-5fe8mJIzPhuQ6-AYGu1f7w-1; Thu, 01 Feb 2024 07:17:09 -0500
X-MC-Unique: 5fe8mJIzPhuQ6-AYGu1f7w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so1574645e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 04:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706789828; x=1707394628;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tw6s2u4skiITOY45sxaPiA4OOpT4GcNpssXuxLDJLFs=;
        b=O4z0mS7LGCgtplYkCz+0HOP2+1OG1Ie/gvifJMw4grJryOq4wo7FyrBhC/ZyzIy2Xe
         OSfoYo3EgXS+xF/s8VTwsvGXlxRsanLZkJGss67iYxDSTJ9EB8tjiz8czXMTxH7HDL65
         +qLo2taXmYa7smAS0N0FqMpcg1daRnGBYE0ynZueW40w6+yflhjpKijtXz8fR7EH6JrQ
         Xs94TaQ6QMoitJITjhkQBYkKI9QjrTqBopxuH921xjDOXeqzVr47F2HCemTgCkMIsihG
         i5mMm274bM4ri+bO0sPu9/Dpi3IjHepNGPGMa+j7mK5NRUCPRmt1Y6URwf66GKP3ONcf
         ve6Q==
X-Forwarded-Encrypted: i=0; AJvYcCXhpqebme6XztfgzC9tKgxRlzZ0ueHIkZba7+YZxVAUWmdWEgdSfWMxwrCPrkO1HcxRcU+rc3jBk0uY0QsdC4EY0+RYeZP/
X-Gm-Message-State: AOJu0YwG9qccZ1hQOepg0ULEN0tH9bxm0tApEr6IuuS9cv7T0RhnGJe5
	EaSVxq8uHH3UMIdBuZUQHZNcaP4bXznqQv9VWFq/AVtJBH81fOLIaFiDUXQz7F/ffk8HJmW8jsL
	G9YS+3lyQYxdJBIWXvifHeYYVehy3xn+qJr0fQZQgjBGvFcnZ5R99lA==
X-Received: by 2002:a05:600c:5199:b0:40f:bf5c:4d59 with SMTP id fa25-20020a05600c519900b0040fbf5c4d59mr691810wmb.4.1706789828341;
        Thu, 01 Feb 2024 04:17:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb6f73O1wdOjHEv2nYccE1wvnahWmsXNq5lTYCZkBdHWIVA++EqcyWcJ1kXUyESSp5wkl7Lw==
X-Received: by 2002:a05:600c:5199:b0:40f:bf5c:4d59 with SMTP id fa25-20020a05600c519900b0040fbf5c4d59mr691790wmb.4.1706789827970;
        Thu, 01 Feb 2024 04:17:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVN+z+HoaSYHdzstnGLWu/q0hqh37ZT3gPCPibuvoBBtQR1WAoprf2SYudBiVTx7L6vioWc6TCEAthDhCMtPSYlBe7JA9zrNCrlR6OSUKP82VaUSAPfg4FuDU/ABpZ/Zh+TJBb7Ko7TC91UYesn8bbKHFNojZvE57xJgqLJIAx5ma7jHOLw8jqE4/aPcWAVch7Aq8Pahu1PMahGiwnvEw5PW232Jd+P/Be2mLFaBHyan36RcdbCAYnEjfC8cszc8JN1Gg8IfT9ktBrornt1Uwq2YadfUEi1geEsBonQ99XGzduX1xuHpIJtnjWm/eXwflXfzwPLSHFCFY1oNayWQvIl7EX5cq1N9JRWhIfY6WGyjEuuKwG2C3rJcpX1kBpv62LWUb8gA9D0qklHYfNVCUfVevN7YxtFnwlnnZw/ZAyB3w868qR/RpeoX3jRodkj7Tz/XGjdEq6mAYI6CtqTyHNUZ639unXuLSbAk9SUIPt8dOvHYvhb/OURcMe/GNyolS5kNUKgmhwqvQBUOONAMH6jgYkvMzA/UtrAXhYBu1YtE/+7sL8VcLUEYxEawJg+eTibYRGyn1ambJfMthXgwDrHgwu9lE1Yk+o=
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0040eec8b5e22sm4364126wms.44.2024.02.01.04.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:17:07 -0800 (PST)
Message-ID: <1fd466f101f22db4ea57f2c912e1fa25803d233b.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 07/11] net: ena: Add more information on TX
 timeouts
From: Paolo Abeni <pabeni@redhat.com>
To: darinzon@amazon.com, "Nelson, Shannon" <shannon.nelson@amd.com>, David
 Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>,  "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, 
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>,  "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Koler, Nati" <nkoler@amazon.com>
Date: Thu, 01 Feb 2024 13:17:05 +0100
In-Reply-To: <20240130095353.2881-8-darinzon@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
	 <20240130095353.2881-8-darinzon@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-30 at 09:53 +0000, darinzon@amazon.com wrote:
> @@ -3408,25 +3437,45 @@ static int check_missing_comp_in_tx_queue(struct =
ena_adapter *adapter,
>  			adapter->missing_tx_completion_to);
> =20
>  		if (unlikely(is_tx_comp_time_expired)) {
> -			if (!tx_buf->print_once) {
> -				time_since_last_napi =3D jiffies_to_usecs(jiffies - tx_ring->tx_stat=
s.last_napi_jiffies);
> -				missing_tx_comp_to =3D jiffies_to_msecs(adapter->missing_tx_completi=
on_to);
> -				netif_notice(adapter, tx_err, adapter->netdev,
> -					     "Found a Tx that wasn't completed on time, qid %d, index %d. %=
u usecs have passed since last napi execution. Missing Tx timeout value %u =
msecs\n",
> -					     tx_ring->qid, i, time_since_last_napi, missing_tx_comp_to);
> +			time_since_last_napi =3D
> +				jiffies_to_usecs(jiffies - tx_ring->tx_stats.last_napi_jiffies);
> +			napi_scheduled =3D !!(ena_napi->napi.state & NAPIF_STATE_SCHED);
> +
> +			if (missing_tx_comp_to < time_since_last_napi && napi_scheduled) {
> +				/* We suspect napi isn't called because the
> +				 * bottom half is not run. Require a bigger
> +				 * timeout for these cases
> +				 */

Not blocking this series, but I guess the above "the bottom half is not
run", after commit d15121be7485655129101f3960ae6add40204463, happens
only when running in napi threaded mode, right?

cheers,

Paolo


