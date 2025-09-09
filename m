Return-Path: <netdev+bounces-221242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42CB4FDFB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E9F188E66C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB60341653;
	Tue,  9 Sep 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vl59Ey6Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4E33A023
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425577; cv=none; b=NgnvYMvHbCAFQ84jHpmazgkEKw/K5aOi3c8Ql+vNYwTd82DjK5tOPmFNLA5+aMeMaKxt0nRu9t5Iuw3yUhYdvVtvOp62S6dqnr/EWDhljq0uvVYS/B1q1ZjoEAbPt78j6VV5w8HyPhPr/YTNiHvehTqCEzmO16pymnJDTI+XA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425577; c=relaxed/simple;
	bh=iyui3WFCRbnX3TQm+JOeYHB7pmGtwCS71OGMN+ivB4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXw8sHepF0fOrf1o8Io4qjeCw+TrEu1fyYQBzIM6uhazwT4Tf8cc5gmjLiWJNxIRt8zDHMZpcAs5PqoTMJiAL5nZIptcdbKEKQPejroDfLdU0U5h1+/pfWjyXib8pr4mIrW0mkdso7L3X5DuKTl0uWf/EPWIwh0FvFfCwXVxLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vl59Ey6Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757425574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wV7bBeWL2zkBttpExZwWR/DTD7bbvUY/ud25t0bISw=;
	b=Vl59Ey6QOwCyjpowtpd9E447jVZUf545s/S15R7bk2oI0mpjOCAy0QC5kwmhELgnScxzxh
	l8ePqYuFUnUUdjdOUG/Jrmr0Uqgodn4C6kCdP8wtI0pGSRFBcrEhXWw2xoWp9iLo955Edf
	lYuTJfjg0ckw2sku8bmFRCe3iwY4f00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-MaUWtU_JN5iIw8djdvzLCA-1; Tue, 09 Sep 2025 09:46:11 -0400
X-MC-Unique: MaUWtU_JN5iIw8djdvzLCA-1
X-Mimecast-MFC-AGG-ID: MaUWtU_JN5iIw8djdvzLCA_1757425570
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3d3d2472b92so3223974f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425570; x=1758030370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wV7bBeWL2zkBttpExZwWR/DTD7bbvUY/ud25t0bISw=;
        b=fWsc8LKrBqy25dIXdwcKf5Z80x3NiixYbHc4SxY5Ln/nefsHSYcNGEmNgKxs+NfSey
         eCiuv2AG/Fdj51S5ZY26vFq04T7H7kDcqZIPKmvEwM40Kzx8AJPERAbSRg0nyvCLPD0m
         Rvdh0w8lg7d/XCVpfAVNiagsHfc0xsQsdoZFDCqP3kJVZgUOK01QCdpCAwpRund8eBne
         LHRq7AlA3YsKsWhkcsFCKamp3ODmVNj4FC1QIfkXeI25NnvYDP4gltZcMLrNH7uLBK0R
         h3R60/Q1DLNdnhHMEC3kCR0kwFSJP+TTkSqGs4S8Uvh3NlcKS6H5n5G2gOEYieZXSlcA
         pthw==
X-Forwarded-Encrypted: i=1; AJvYcCWHSvv/T2j+ZQEAaoPwd0Y+aCT23LAw/I09Dp1m310bb6E16n0XxrXnhU8aC9joE9IPWBX083E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbavrVOfVrM2xh6sNcBvAoQmqj4gt8WYB3/ziAuyxE3pQAHWu
	6sziXS60Vvkt9RFYjgefgZBEcbGneLWZZ2zI48sdUB0RCy/traOjUjCanEo0MHQbZGtJZ6AIWt3
	835pPJ9QJgtttKMM1JQLdIZ+3Z9b71S9o7gJfpiBDLH1VruhHhkMIRwVvrw==
X-Gm-Gg: ASbGncsODaj1Wd9oCic8RN09kf4kM0AWBNovmsid5pHEjEtZUaqMP4X2btxTnd0itEN
	Ry8os829D0aHaaQSbeIByrcv1TZkwflVNFJijyDuM9uqEKJ9cn4CesEr29KK42VPMkd5hA5k9nk
	+8EwzCRJTiJ7tSEBj/mcEfg/u2uvZZXfW9SjKTfTs+XrRm7zLBgm2fQGCVtM/u2I8oInzEWVOvt
	dIgc3JgMt+znma4sQ7GWrHw0ptfVYxfPHtSKFufMEXcfQ7eBEIjS4c20MmaELBYyF7tAD02R7Pl
	bS3HlgksFOWv/825dlr/P8FhIyMfZAkhLnUpDtPGMF5BTxoQiA7iCqro8uGNNdEJapSzVVe01Ni
	EaZGjetBIA8A=
X-Received: by 2002:a05:6000:2506:b0:3e5:6297:dd0a with SMTP id ffacd0b85a97d-3e62b8fa227mr8533312f8f.0.1757425570255;
        Tue, 09 Sep 2025 06:46:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Gmn1ZwbZ1ONly+zUeeryNmRxaRZJqUqpwJ+Qr1nsM7NYyF8FV0heuTDk5kQMXJNHl0Y0cw==
X-Received: by 2002:a05:6000:2506:b0:3e5:6297:dd0a with SMTP id ffacd0b85a97d-3e62b8fa227mr8533285f8f.0.1757425569722;
        Tue, 09 Sep 2025 06:46:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45d468dbf48sm249968755e9.11.2025.09.09.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:46:09 -0700 (PDT)
Message-ID: <7d8862da-5b63-41a1-8957-e1244600f15a@redhat.com>
Date: Tue, 9 Sep 2025 15:46:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 6/7] bonding: Update for extended
 arp_ip_target format.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-7-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904221956.779098-7-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 12:18 AM, David Wilder wrote:
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 28ee50ddf4e2..1f0d3269a0b1 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -660,6 +660,7 @@ static int bond_fill_info(struct sk_buff *skb,
>  			  const struct net_device *bond_dev)
>  {
>  	struct bonding *bond = netdev_priv(bond_dev);
> +	struct bond_arp_target *arptargets;
>  	unsigned int packets_per_slave;
>  	int ifindex, i, targets_added;
>  	struct nlattr *targets;
> @@ -698,12 +699,31 @@ static int bond_fill_info(struct sk_buff *skb,
>  		goto nla_put_failure;
>  
>  	targets_added = 0;
> -	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
> -		if (bond->params.arp_targets[i].target_ip) {
> -			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
> -				goto nla_put_failure;
> -			targets_added = 1;
> +
> +	arptargets = bond->params.arp_targets;
> +	for (i = 0; i < BOND_MAX_ARP_TARGETS && arptargets[i].target_ip ; i++) {
> +		struct Data {

Please avoid camel-case names.

/P


