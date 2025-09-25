Return-Path: <netdev+bounces-226210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E466B9E1B0
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E3B3ADAF2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1642773E5;
	Thu, 25 Sep 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC33709i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA4275B16
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789924; cv=none; b=EBG/tkPugkX1YWUnaom+aOyaqQ1oxijoQ+CMBD3D44fcQXNsJOp5grqehaIwPw4Idp9J9Dtl7q+PCVvZ5aD1czXP9Ks6rwdj+u0Mev2HjLCFmhwtVDrjz1x7td2jj5ImiSjN7jPzKDcfxAulXC1V0n+G1T1d08sb41t7SkWrshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789924; c=relaxed/simple;
	bh=qC1aIoK5yYcF83FkI9Dqc3KWerwB3ZBIP/sva6h4a9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCcsMgBmQnZnmlmFtBLiSQ0Be7i+B2moZ9aJqGIBoDg80OLRxkxFjkwTivhQPrrr26GqdU7IQQzzA4z0Gw81kzd5z9MBcFxg9GE0y65CnXGdensQgHu2hs451+DIIaumvKM7sVpqOISX69t86sojxC9vQh4q88dUE2DeYThYmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC33709i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758789920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ShWX7vwoNNn+VH+yd+QMji4HEbe496xkh5xSQsMnu0=;
	b=OC33709i+7jes+BNHIYwmWUuhZB5B0QKUBIiVnAHL3sD5hI7uyfsCbs3qWTf1fMmahHwaP
	ucrAMgpbMQgOv3w+UtE1oKHHpj/5fVa1kl+7fAOhJ/4vlP9U/jB3fFefUtUYu0SWpu+KGX
	036BD334KCWcwiWRNnYgCJfetRFOhhE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-KiAcqopgNU2ssD1Ls0Iigg-1; Thu, 25 Sep 2025 04:45:18 -0400
X-MC-Unique: KiAcqopgNU2ssD1Ls0Iigg-1
X-Mimecast-MFC-AGG-ID: KiAcqopgNU2ssD1Ls0Iigg_1758789917
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso499352f8f.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789917; x=1759394717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ShWX7vwoNNn+VH+yd+QMji4HEbe496xkh5xSQsMnu0=;
        b=pqhko4mWWtpXJaDIKR/spZkd97955iqlt64QlfJig4pClpEiWkXLGc0IekMlEAHUab
         Tbi/GVtkEMHftveViUVHNnMVrRpIRRzMPD8ycyxVWQjTf19RYO7OG+CfnPRlk0NWEf9G
         bx+X1u7Pdkn2SQSJMRkojEyCXu5p4K3sbTNwx0TdklOn0GFZ4V9L/SR2LN+ktMnS1KPb
         jLffoItCBhOpCfMFOZmGqkSlAbPulkEtPyEbfMqwRqZsP6HFvHPuXD4FAkqDntcV2wbx
         oW/RFTNtwIekfzcDfxK2RKCQiLpsLcF8j28UOzYCzmAH3xIFv+UHliHwBLxD2mkECE4p
         DJyg==
X-Gm-Message-State: AOJu0Yy0uUPeGfFlbNYD9qQ5hXxVSH7SYGV6d/mhUrSWSN/f8JUTGUHB
	hIiWBdVKSIYuro6iA0kYYVhbnGi9QGD5KZIZvfZAcZj1/QmNtCiwibHSiylXqKYSmmy0iaVsufE
	uf5+uF8x3roSprC8yGJPNGxooDWz0i4pGhBnHdfbiX2+J+ZfAKJly9RK1OQ==
X-Gm-Gg: ASbGncsh0pw7hMtLXyvhSC+Ijd4/wcQdyChdBnXR3yTJEkZDOcscNWhhov8eN4wiwq4
	LN0by0n5JKoRozF/yq7h4lCbqQQJh12bwEYRY4q+CL05OZtK575XkRt3YGbdix5VMiPcJZ6/eyq
	BLKSjEPX2Y9gn+n5EQfWsIvbjhWqZ2K3f3X8sHbtSxjgtlQrLnozmrfovkg4ZfiY8JcHdMoRc17
	RjSdsKbXPiNdCxx0pPpANVSIUkq5ySNnKXlTvKmwak7n/eHRhxq8UMpsFZheuuCJwuPQnz00ZCJ
	ViV5xWTnmkEMB+kq4DBu89Qa91i6aP2lehJ1kVPj//VG+Pq+7PB2phUpPl57/hZ5CibFK7vVF5s
	ZKKgu9lDVssha
X-Received: by 2002:a05:6000:2302:b0:3f3:97df:a2b9 with SMTP id ffacd0b85a97d-40f652293d8mr1558669f8f.24.1758789917246;
        Thu, 25 Sep 2025 01:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8MnKrqVU5iaRZyEisFTtWADltgBvMSKns5i2HHc+LVMjxuzcCkWpGyCR51gWllXQXpAW+mg==
X-Received: by 2002:a05:6000:2302:b0:3f3:97df:a2b9 with SMTP id ffacd0b85a97d-40f652293d8mr1558628f8f.24.1758789916763;
        Thu, 25 Sep 2025 01:45:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm1974284f8f.33.2025.09.25.01.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:45:16 -0700 (PDT)
Message-ID: <f95da89a-152d-4899-8068-3b6aab568825@redhat.com>
Date: Thu, 25 Sep 2025 10:45:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net v3] net: nfc: nci: Add parameter validation for
 packet data
To: Deepak Sharma <deepak.sharma.472935@gmail.com>, krzk@kernel.org,
 vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, linville@tuxdriver.com,
 kuba@kernel.org, edumazet@google.com, juraj@sarinay.com, horms@kernel.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
References: <20250921182325.12537-1-deepak.sharma.472935@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250921182325.12537-1-deepak.sharma.472935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 8:23 PM, Deepak Sharma wrote:
>  static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
> @@ -501,7 +536,7 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
>  	case NCI_NFC_A_PASSIVE_POLL_MODE:
>  	case NCI_NFC_F_PASSIVE_POLL_MODE:
>  		ndev->remote_gb_len = min_t(__u8,
> -			(ntf->activation_params.poll_nfc_dep.atr_res_len
> +					    (ntf->activation_params.poll_nfc_dep.atr_res_len
>  						- NFC_ATR_RES_GT_OFFSET),
>  			NFC_ATR_RES_GB_MAXSIZE);
>  		memcpy(ndev->remote_gb,
> @@ -513,7 +548,7 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
>  	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
>  	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
>  		ndev->remote_gb_len = min_t(__u8,
> -			(ntf->activation_params.listen_nfc_dep.atr_req_len
> +					    (ntf->activation_params.listen_nfc_dep.atr_req_len
>  						- NFC_ATR_REQ_GT_OFFSET),
>  			NFC_ATR_REQ_GB_MAXSIZE);
>  		memcpy(ndev->remote_gb,

I'm sorry for the late feedback. The above 2 chunks looks unrelated from
the real fix, please drop them: they will make stable teams work more
difficult for no good reason.

Thanks,

Paolo


