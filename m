Return-Path: <netdev+bounces-180652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC7EA82076
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275F37ABC53
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793301DED5C;
	Wed,  9 Apr 2025 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHV4ZhI9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE4156F3C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188372; cv=none; b=aztQOPiOconjOJu0Msd1QOdh4AAhhWh9rE0nskEI0Cp8+m3ZtPC9FdHq4y3svdziRXUTITtTu2xKk8Ja3Ke9ZGkN9UmU7WAWEN+GYn6gjaaKIUMI8HIhEQZbyQ82m2+Cde90uudfF1A1dWfS/XgctmQ3cJsjuOv7E5qx8qRUYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188372; c=relaxed/simple;
	bh=dQ7J5ZfHMqTxNORuD9L37MipaEmCnlNHy8y+o9CamKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSkO06HrCsr/Ju6i7wDRVPBID7qKZ1+j7+ermCBThOP1zjBU3Sa2UxP9Aa2TE/8dqvGxCrH2UH8m7pVuWQmvHbqy6D73scWqhc88zJJm/fmreRVnGR/QYBvCbvH2VIhdwyNmXY1X9ytJeM/4bMaCLG62rPKxJ6kTAhYgz1y+U+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHV4ZhI9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744188369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GRaecEdfuWriM7C+yo0bHf6awsUkAtrtSOEV6bJJCA=;
	b=MHV4ZhI9yPO3LnEm28W+ZCCxkTLrt4OWySpTS9UgB8Y2ORL/N/mcaDwb3/xZb9IToPD3UY
	Mqtp+sxiWMJiSCRLxgPLNMGlu7nBHCLFXzFstpyfa/MJpTvPDuwEq7++0HwJNCaMhdWHxf
	h4nBqCW4uDNkwLjMKYc0mBcAD/9+llU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-0sV0W8r3MOGCzLrFB-GArQ-1; Wed, 09 Apr 2025 04:46:08 -0400
X-MC-Unique: 0sV0W8r3MOGCzLrFB-GArQ-1
X-Mimecast-MFC-AGG-ID: 0sV0W8r3MOGCzLrFB-GArQ_1744188367
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39131851046so2853773f8f.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 01:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744188367; x=1744793167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GRaecEdfuWriM7C+yo0bHf6awsUkAtrtSOEV6bJJCA=;
        b=jukG6lfXTf1KXewNQUDMpeC9YD8Rfo0ke6sEHNJB1bWCvQJctEgHMtPv6ddjz6GaS3
         2jyTxKI/IQnYxO9oWt5sOrm8a72tgUX2r4f78GNWOKlbbCQxjU9VXlTPY8cUOo1loeTJ
         t/CN11phCfQjCzf1A+1FuVDoZvWCIlY84ljrXTFMkcAER/A/gYA5BBCjx433fv70n/ax
         JSiute7hHhdVCizmSokpx/CKXSPbnxhN/DK4cgoYzxJCTMrjgsKImr7+A7PV0zwAYBNk
         8wyBObDLc/IXMVev9iv5oLTtbiDb8elPwCUUeedE+3BtNNfTQC3EFNJ76pRIvE1M5ALn
         nJfg==
X-Forwarded-Encrypted: i=1; AJvYcCURo6bKIhYV4zS9MdS5Vj4zlVfKCzv3vtJ5O/uDOE9pjlW7QYKpKL2yArIoKCcvPGm6XBHumDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBDx0xw2XwWjtZOEMMNXa1iIX7828/QjNvkWWPQQFH2eT3P+t
	zNZPHaflE38NW5MsiqDbsSP9G2USm1jUwpBe/kViUZ/9UO3Gepk7W3Gt5J8CTwsXWd7JBL5WEsQ
	QDjHruXaN4b0NmUf2QMKBzzh1D2WIRkdd3vpyP6WT7EtdmIST8pTm5w==
X-Gm-Gg: ASbGncvAVLPdHk1pb+tzaCtLIWla5ab78cnyGXqCoeSww8/jRzgTzrgW73mXpbbXX/Q
	VmrFLayDc5+llkQcNoNQJc6Jzacn2de/jGiLhhHC2ADFiuNRAPmmcFUVVVQMOBqoxCxacm0jqgy
	tO+SNEtf761wxl6JufuSF5p1PehMMlPY8uFdcUAMtKHQvhTGrf6aJFYdw/+1gNuaS3ojnd2hj9l
	nSjzw9L3yutD8+eUVUSG3zFnJYJ9WOSCEDlSbv+U1Fq1p2on+Q3WMy6ARIEHbCnmxIhRfRpVQ73
	itnYkEeJlg==
X-Received: by 2002:a5d:59a8:0:b0:391:3b70:2dab with SMTP id ffacd0b85a97d-39d87aa83f7mr1836445f8f.17.1744188366939;
        Wed, 09 Apr 2025 01:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy+550CSY65ENB+HIM0YP9gUefmg712FU2KtH7qBXHCJBM64fPaYYk4BYRgiS6DoCFcosTjQ==
X-Received: by 2002:a5d:59a8:0:b0:391:3b70:2dab with SMTP id ffacd0b85a97d-39d87aa83f7mr1836423f8f.17.1744188366581;
        Wed, 09 Apr 2025 01:46:06 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89389f72sm948917f8f.42.2025.04.09.01.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 01:46:06 -0700 (PDT)
Date: Wed, 9 Apr 2025 10:46:05 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: Add matchall filter offload
 support
Message-ID: <Z_YzzeUVd8ww6sjf@dcaratti.users.ipa.redhat.com>
References: <20250409-airoha-hw-rx-ratelimit-v2-1-694e4fda5c91@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-airoha-hw-rx-ratelimit-v2-1-694e4fda5c91@kernel.org>

hi,

On Wed, Apr 09, 2025 at 01:15:32AM +0200, Lorenzo Bianconi wrote:
> Introduce tc matchall filter offload support in airoha_eth driver.
> Matchall hw filter is used to implement hw rate policing via tc action
> police:
> 
> $tc qdisc add dev eth0 handle ffff: ingress
> $tc filter add dev eth0 parent ffff: matchall action police \
>  rate 100mbit burst 1000k drop
> 
> The current implementation supports just drop/accept as exceed/notexceed
> actions. Moreover, rate and burst are the only supported configuration
> parameters.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Validate act police mtu parameter
> - Link to v1: https://lore.kernel.org/r/20250407-airoha-hw-rx-ratelimit-v1-1-917d092d56fd@kernel.org
> ---

for v2:

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


