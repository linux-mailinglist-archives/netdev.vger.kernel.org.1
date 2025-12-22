Return-Path: <netdev+bounces-245694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D74ABCD5CC2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFC53033DE2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5F731576D;
	Mon, 22 Dec 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXzgBmfw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lVwhqFOG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A6314B63
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402577; cv=none; b=mLskZ73f3L2S6J1QjiMkSQ8NQdwjzFZqdE6rYmaDk9B+uks0Aj4y9bpqwJYI5sh+VJmDN/9nzKSh+e9JwN9OxdiI4b2Vh280C+tgnTAPRioqbIQxS4m5sAjldvpg663BsTnd1mxmEwIL31f+zl+k5vKm1g+9ECSg0sAEmo0exy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402577; c=relaxed/simple;
	bh=3EDT2YGcpGPjKAh6PX/CsKFrGwQHcQW5gaRT0iFTaLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wo1CMD+rlTIuQH7WWWB5ZrShsOu6ypEUT0pas4E1UdeJjoR2jTtx2ItDlFC+3Y28N7QIRnN2qgtn4yqyXYvYn0GfcnRHKviJe3qWeLq6zfk2awfI2vdCAeQ4Cwyt9J8r5uUlNrITn/mwx1mEQG5dKJRxXSX46C/abYoF2zzwdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXzgBmfw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lVwhqFOG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766402573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E611Te8S5GGNcR/OcA740JjHL11EeYDX7twJdcHlP7E=;
	b=UXzgBmfw4HX1lBcoODoksvi5OKt0xWVC80CqsoW+sSWvKevjr1iI1rrN1GGmXw3Qyfd2rn
	ID7o4o6UV8ugwv8jw72eJfnDXGZiBEWBjyO7RcrqwVcyGwQkFxde8VpBDG/f1+X7TJHcty
	HwT9pcIyvdH53TDOmG2mSNGsYQzxtaI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-dX1CVBd2O2arSQQ137r96Q-1; Mon, 22 Dec 2025 06:22:52 -0500
X-MC-Unique: dX1CVBd2O2arSQQ137r96Q-1
X-Mimecast-MFC-AGG-ID: dX1CVBd2O2arSQQ137r96Q_1766402571
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779b432aecso20525435e9.0
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 03:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766402571; x=1767007371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E611Te8S5GGNcR/OcA740JjHL11EeYDX7twJdcHlP7E=;
        b=lVwhqFOGpySOLHUlyVIpVxJD/nuv6Dr6pgzQyt0GOL/OBMOXarRCkxz3vgG7DhFDSn
         gtfO45SsudhxEUlcxvpZRR3xWe8UeqZNP43Z7rvmjEtFrroF5sJWwCCHPTaDM/5lxVz+
         tE+mZ526nM5habS+hz9vKYvE7FvnzKcfeKHYD/HSgtoKmgAp/rs5YG+6cIAF3l/ZqmG7
         d/If/g3Bx4H7NuETiX/LpcrZvQ+qTjoveixRIkNlFBPv1BIP429bV2Iyf23nfvXG+ZZJ
         +Z1sEEzZszJtXgbrg/THRkwL4CE0gvaY68QT1jNwce0BmQbifP7EiqGp/hoTMGvIuNsc
         h/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402571; x=1767007371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E611Te8S5GGNcR/OcA740JjHL11EeYDX7twJdcHlP7E=;
        b=A2IR1yZSQFcOUmpeEjchCl0DAE9fGN+P/mX/goIaeBjNssezkNbMFRdp+kKDAMEve1
         QC2GB/EbwsHWkmM3BNpsDk8QJRN4SGCR5z4G4QQDPRNSWh4ySCogrfAoOgRewDajvBC9
         D+oB/UGM+kXT2OyZe6NEnQR2oiD1IqLvAsuNJaDymOt5PXz73wiahcNFxxoXd2RNQYQY
         kmZ7LfpTBMoAdlOwnLyVsyIV+eHj3bma6G0B/P6sGUwhquYTog4TXHnYVvtH9HfPY8+0
         XkZPwLKB6VaWY5+JjiLf2eAFt7HB+L2rfIY1JvXDqtPi+fqJua+1odiPVBmWyuzcaOi/
         COAg==
X-Gm-Message-State: AOJu0Yz9t2x8zXY8BC2Q3dzyMM+72UxPhWMiFHV//Iz/xwUMjIu/OCsa
	7jo90vCEuEMZvARob6fWSjEYubiWjRdYtYA/u2+B3jYCFbz21P6J8TxpCIdKR0cZndwIgKiuPdY
	WVL0dYGQRBow4xXgLB1XuEW77LzC3MLmiOIib1WLD6tOVWZfWPoU8bklegQ==
X-Gm-Gg: AY/fxX58TSc2ujb7thnbTNM7tYMuAE4JBv4P3XNua4RrgmVc1xfi9LuTHtqOg3Y+gBl
	DgnKU/ZVPaUkNgRrLf4amQVKlz6+uTGvPyEVeVgRl1lzMwpHMIQLkTj5n7g2Mis95/ORKomIEad
	FuzctajNd4V7gNoyuZazw6UZbdzGjqLrQsjIJLvW08QdFbEeJuwLVSsE+3IfftF4arscNRVUO8A
	0YdQSzx7jzlLEJGW4J4oqk6PnbZVnrXGG7Ap+YJmsdzMSVdGrrpZqd9wLKI7ACgunHJZdnqOdx6
	UXIj9o8aGQTHYLuRa3V9jXfqZen1rNrdYtp7waJGRst9HSLaidG2jpAWXN8qAhRuySUFXg2U+hu
	JRedLQwv40EDX
X-Received: by 2002:a05:600c:1d1d:b0:477:632a:fd67 with SMTP id 5b1f17b1804b1-47d19546487mr113312245e9.12.1766402570956;
        Mon, 22 Dec 2025 03:22:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHODwFI47CgIXphDpn1wtHlksrz2DCs3hJs+zlz//ffQSsxh7pqn8vOMXSoNOZVxv8Xdl/KA==
X-Received: by 2002:a05:600c:1d1d:b0:477:632a:fd67 with SMTP id 5b1f17b1804b1-47d19546487mr113311985e9.12.1766402570609;
        Mon, 22 Dec 2025 03:22:50 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aee5sm22132821f8f.4.2025.12.22.03.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:22:50 -0800 (PST)
Message-ID: <211811d2-1b61-44e0-8474-3a62461ab5dc@redhat.com>
Date: Mon, 22 Dec 2025 12:22:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add an additional maintainer to the AMD XGBE
 driver
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Raju Rangoju <Raju.Rangoju@amd.com>
References: <20251211112831.1781030-1-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251211112831.1781030-1-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/25 12:28 PM, Shyam Sundar S K wrote:
> Add Raju Rangoju as an additional maintainer to support the AMD XGBE
> network device driver.
> 
> Cc: Raju Rangoju <Raju.Rangoju@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

@Raju: you should formally ack this patch, just to ensure you are
aware/ok/onboard on this task and the new entry is not stale.

Thanks,

Paolo


