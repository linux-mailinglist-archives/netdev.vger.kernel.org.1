Return-Path: <netdev+bounces-178292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B23A76686
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23877164D3A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D30210F49;
	Mon, 31 Mar 2025 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qwswnt5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC221018F
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426391; cv=none; b=qqAt4/TIDRyBpctM+8qiHwMT+l1x1qCAtaxNHr0Zkt9Qlg3lptiw+s6WAEutyOrOZ5wUa9Yjn2DNzNdZsWBgaSBVYr1HjfVLGwLZwj/1GkSG6Sr9Y4DW5xjE2IKFETQODmTUkOLc0Ew/UMERW/x2XHAvmWAPLHnIRlnJH4D+9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426391; c=relaxed/simple;
	bh=mcAaep7az2IXgNWtbA18kng/OcJv9/IzN/RsMRS03U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6MYAAqFbfgnBxHmHbVSVZZFJmYyKhV9iq/gBosfT2q2riXBgCwk1xi+EANhq/ODoE/gKU/7wd1XYEKrpmVIIVqFiwkqPqHvMlwA6qXZoxSXT0MjctMaUqaCjwEKCbvPLoav9bECQy7v+eivwx7mO47gqCLOMiG7ti95C1Nn7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qwswnt5C; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so36768875e9.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1743426387; x=1744031187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKqRgOo9ICGMLscPuGCAwbGjrupX5+2/wNr+qcVAz2o=;
        b=qwswnt5Cw3rhISj3fBQVnmj+HttrknyU4HcPrk6nA7cux365SOHes3ADxQDtKJzBZG
         NZ1CciRC1H6huHozAFQKjEhk0Sb1LtvhBAtSslgxsUNkpXKL3djfqD1uyLM8DqLQmnPL
         tbYj/60VkCfIe4cSjrJRQqFv6rjTeloieZ7rfTSFL29Xd3lIHMeqETYlClNSGsiubtW1
         JmqOsSJknygpvXO2NtSch5XHngDrZzJxhoGpgYHI1Ux1AluGFiNssHy2f+8EWNvrmY+u
         qSjyHWE8fX8HnEDuCJdgvG8qaJ7xZ00a11JqvkIRrqDzgeG6z5Rh3BMgwZZv+DcpQ423
         fkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743426387; x=1744031187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKqRgOo9ICGMLscPuGCAwbGjrupX5+2/wNr+qcVAz2o=;
        b=ebuxBt5i764fNQE4owap9l/J1kTQk2KoPUVn4gy1ZQOiDJujxDzhSYzpsmxVrxTWEn
         Lk2BdiqqPxwJ4QFkxGneTiJVbdjxisK8NNZMqafBTSyVsvUJ52mKMS4ATxXptFkwIUeB
         10fOkdFOpbSmJldyGXX8ZQ3VgcwtJPgXHcYo7KS+Zw8TvkEtMzUYTsHmI5kkjwVvFAUl
         L7lXSHXeyHHrDbjo2EtoxhDBvTxMFEWuR3QIQb03hdOsfRjNbebphdCKcYfkn+5umVok
         oHtL1UBuDdQTYs1m6xEvoo6YsGvrHw8Uq0ZmDK9J/N4U4jx3mSuVzyLy9ljqINSIxH1j
         u9mg==
X-Gm-Message-State: AOJu0Yw9a3aizQkDadM3p0/m6jiHpdoZQJDMRctqAl2U6tda/O7R8g+X
	txlNzF6mneK19eW1fGKL2iVuFGYWC0nEZjhNjUAATPvi9iCH5Uf3tv/5E5Hgz+s=
X-Gm-Gg: ASbGncuJRuK2HT091lytfqvZ0WmOIQ7+UZ/PAeECaEYDZfFJ8lVcjQnGrrgeNxhwkCi
	t4leLyxAEt9WUC3Oz5KYrEH/FT7gcfwU0OWmz/qtwvXFY4iqqwh2bxG5qfPqykq5fGCQ9pBA4ZA
	MNQbj2izKJr8BbUxh+zMf911oOyppPtiwA9wvo3uKrp9BvGodQpZjENan+ISWrU8/QM/riQGFq8
	gFx3iFA6+E5T60cwbaUC7A3AhXuE01F88vAahw5gLLesp6FscHqEkQ0TZxwoL2twUzr0aNBIKAF
	RhpfWV2FNhLfG1jGK9mVTzeHfK296eDaovu4yqXbnyhfbp7nytMB70e6Yq4QIlxW0b0OXnrljkT
	8
X-Google-Smtp-Source: AGHT+IFW6K32JK9eHC0Kt7zLWvssQ8BeXi8oFW4GCfAtxVEV6BU8VHXWWXGbzHh2N+yph2HKZBaAXA==
X-Received: by 2002:a5d:59ac:0:b0:391:bc8:564a with SMTP id ffacd0b85a97d-39c0c1369b5mr11939643f8f.22.1743426387044;
        Mon, 31 Mar 2025 06:06:27 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d9142a5f0sm94745545e9.0.2025.03.31.06.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:06:26 -0700 (PDT)
Date: Mon, 31 Mar 2025 15:06:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next v2 2/4] net/mlx5: Expose serial numbers in
 devlink info
Message-ID: <6mrfruwwp35efgzjjvgqkvjzahsvki6b3sw6uozapl7o5nf6mu@z6t7s7qp6e76>
References: <20250320085947.103419-1-jiri@resnulli.us>
 <20250320085947.103419-3-jiri@resnulli.us>
 <20250325044653.52fea697@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325044653.52fea697@kernel.org>

Tue, Mar 25, 2025 at 12:46:53PM +0100, kuba@kernel.org wrote:
>On Thu, 20 Mar 2025 09:59:45 +0100 Jiri Pirko wrote:
>> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>> +					     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>> +	if (start >= 0) {
>> +		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> +		if (!str) {
>> +			err = -ENOMEM;
>> +			goto end;
>> +		}
>> +		end = strchrnul(str, ' ');
>> +		*end = '\0';
>> +		err = devlink_info_board_serial_number_put(req, str);
>> +		kfree(str);
>> +	}
>> +
>> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
>> +	if (start >= 0) {
>> +		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> +		if (!str) {
>> +			err = -ENOMEM;
>> +			goto end;
>> +		}
>> +		err = devlink_info_serial_number_put(req, str);
>> +		kfree(str);
>> +	}
>
>I suppose you only expect one of the fields to be populated but 
>the code as is doesn't express that.

Nope. none or all could be populated, depends on what device exposes.


