Return-Path: <netdev+bounces-230851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4189BF0882
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9383E3AB675
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBD2F617E;
	Mon, 20 Oct 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IMHcVSVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651261E9919
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956071; cv=none; b=bF5WnUMLRZdOmKS2eE3L0zD1FayWRjmARD8HE6RKbZ0kVa5wAE6OcRbEHObdpZDMdPDDUkzcISs/pMfGLPKKxj3W19MosdFK4hGYV56CPU0QJjR9V3M/3Q2qK3g0RzaJCYCTIff8J1fR6hIfe5hvxXxhq7kdcyqjQaReWMMMln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956071; c=relaxed/simple;
	bh=YdJQT23MmkSBi0ZaNdhCdqOffP2+xSjXp9ntW1Fk190=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2ccaiY4sUw+DmdZqshJZaP7mB9WfChLZvmCfI185vBi4hQxVR6ZvP6x4pLgO6Iv2yxn6LyYq5n1KM7PFd4/GNTlU68y/azu/91ZO8q/Jv5riTZLd1m22iDz08o46fai9h8Ik7qi1NSA92hypeSxwLEcXvv2jCAmN/Ks1GuZLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IMHcVSVk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e542196c7so33356675e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760956068; x=1761560868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dvtYsvwys6UCmfh+4mUwt2dao0xzogPu4+lUcRk6l4=;
        b=IMHcVSVkfBD/+AZS0X1KRxJODyFg+227YpSjHD8cOia4U7Zt1OraRcqyjTDyAdeJ3G
         Dqqj+kvuuAhuFo0G3IhIaej7b4CsUbvJPem9+qHDxAa6Ax1GQDWIt2n8hClm16HqvGwV
         p7hgTsH7xKhRb7Jlt88lCkeQFPwREodmEpB2Eq01YVii02SqlW8ontAya5c+kgYZsjRb
         BYBsm5/bVWLqz1g/Yfbdo3F2N0vFevsXtE/DluQZsZCfPGuCrAzSFsj9ij1B++/VOQZT
         /mdpzuCFb76kUu1L1lO7KBqWUh7SN0sVQnUt08QKEqfAwd/qEFi2ozLJcq++1X13v/QO
         xHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760956068; x=1761560868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dvtYsvwys6UCmfh+4mUwt2dao0xzogPu4+lUcRk6l4=;
        b=VBsdzfsamLRxVLq/YQIsKpHRKG7we2uEBKef3ZEVxT0BhPTFg6RHZuGWgMYj60Cm/D
         6X4TDXon0+2egMnuo2xYR/flGkilCfQeJbqj9OLqov04af8wDitpT7JjON2uBXIB+TR2
         rxf6sxOMAcuBh7ucBc5oPQ2A4qFG6/+7iBp7MW6oaOeyml1LJDxJO7murH7cDGeqzKpl
         Wa79xxrSWYZdh7F1Hpx9Yb4iDMVXoxTW9yzXH91OFDtBRp7wvGd1zMJCTbGG/z/1VIsw
         qzFykuncMHjr9d08sq949y5gjCUGfq5lLrEGqkTwzr2DBsx+vXcC/iEadRTEDuMCYDlJ
         GneA==
X-Forwarded-Encrypted: i=1; AJvYcCWYzpZrAZ7FMaMCiAraGddCLQWKOTY/+jru1yxvoD4/cB+ciLG4OnXm8LlGcoFRsFGlHzhYVHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGreNnyf1M26OhfVNZ9Oc5OjBbmeJJgFLqYx0/eJEWXKXD7Yo
	0RenNgP59KRl4qF1DLFRUedRDAqI5Hai1xcXrVvwhsGY7rciNxJ30rp2GTOb2eHUhsM=
X-Gm-Gg: ASbGnctJCaz5/MjyJn/4HXBOGfaE0K5cQtDSSf8GJL96g59wqmQp8BtXmTVoBg9tZwp
	ryEQse7UOtWeeDFU6mO0QfcCZzubnEbw4+GetpNv5BdJ78E4idGJDA1VsLZkuixslT8YNQH8V+p
	IeZswl7KWO1STHXNoF5yLSN40cOBlAoXY2JE5AMFbBYIQnNOGPev3PD2Y3AnPn+sw5E1bJ2OkvC
	t6fsflJnpLpffWssuOC3QTQETqy6YEKdmlaRu3EHZtaD7HBILZfEitW361n90dICQB970Vou4a1
	xez52sLPcuBXUR/FRS0qYDZztsN3xxHKDZU+6kYbw4QXa/tuBPmSBkJ44liq7pv5NkBedgHmh4y
	4vPIV9g1uBGutnZgYayeHbuZ6/Pbx0SfLOTH1CSJzdzF7qZYMDqUph10aFXG+K5YqOU9f520e9M
	3dBzKKs/STj/peW4XtMEj4EDcaEKXSSmtqkl3M4mPq4jJTlmUzWg55ZQ==
X-Google-Smtp-Source: AGHT+IFjlH+J8EM55S3REFmZyZsIciSPk/zzo+ozqFlEcxZKYkS0tz+EKjw+SI9tTxE3OLx1rl1AVA==
X-Received: by 2002:a05:6000:4b08:b0:427:55e:9a50 with SMTP id ffacd0b85a97d-427055e9a5fmr11181093f8f.22.1760956067678;
        Mon, 20 Oct 2025 03:27:47 -0700 (PDT)
Received: from ?IPV6:2001:a61:135e:6601:24e0:f40b:1a23:7445? ([2001:a61:135e:6601:24e0:f40b:1a23:7445])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f7dsm14383873f8f.4.2025.10.20.03.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:27:47 -0700 (PDT)
Message-ID: <c522fde0-97ab-4285-aa78-40c5ca39b5b2@suse.com>
Date: Mon, 20 Oct 2025 12:27:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
To: Michal Pecio <michal.pecio@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
 <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20251017191511.6dd841e9.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.25 19:15, Michal Pecio wrote:

> A less complicated improvement could be moving the common part of all
> cfgselectors into usbnet. Not sure if it's worth it yet for only two?

Please leave usbnet out of this. The selection of a configuration
belongs into core code.

	Regards
		Oliver


