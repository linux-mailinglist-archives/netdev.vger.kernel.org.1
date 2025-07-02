Return-Path: <netdev+bounces-203280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD2AF11CC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6CF1732D3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E270255E4E;
	Wed,  2 Jul 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mGb7Bmlz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8423BD0F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451973; cv=none; b=uRj0NeAbnPS5/e4FrMWlDXPpCXT1y5hd6aFsd2gRe+A+NWtZncWkouBIHo+PfUGnOYxE9ecoVW0HxGlmam3P09paj+hohvQaQs6VPQwJPEcAqa1t7WnRHsFCElBi7GFraoAnyYMA7QgLnn9xRII/3T6cS9PJoaD1/SCedxcH2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451973; c=relaxed/simple;
	bh=A7Ag2M/xCPgnbM81/Ed1DfzL0YgWiPbRTDK/kNWLRz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMzonNnZK+zc/QPvrqzsfMoBMRNowdiosQuiA7Xmfn+3xMYW7k0ZJZMqgHBXppnoAd+rq/hpZRQf6mkKmbDLJ0W27xd7VKDJN14xYqKaUG0J2s0H2+84eJRJRdVXjLtyL2bg0Ln2kvIn0HWGDBlNWXdhk1XjSLvmWZHV2MA/OAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mGb7Bmlz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so44057735e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751451970; x=1752056770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yN3/Rce9O/Hh8jlflcA/tOl9nLaEQorrzHfucHxWn78=;
        b=mGb7Bmlz5/GUSD+zaFlQiXe4qbRmr+J7MCz76Kw6ja5yYPuwSBnB/0kEVLxM9abifM
         ZvwkBIcyzD5eaygzZdztn/QN0ZOkXhetgxNo3mn40WWpAEMsuj5Gx4pum/JA69pCOP2k
         +GBT5oJkj0Ga8rXxr1/6mpaGntuhSjAScFxktzwC0ZlhPeZbBNEQrwINQ62lKqXNTPjz
         ZMn3Uj664DcLFuZihjd3bZudbJTDgUAI8yYMrKTzIfsR3y3nyLzxygYfuFHlkUWGNT1e
         UTUuo4MtxoJg4rPu5IwfiMVDw8EOW1mbTyfXRUOAl78sp2DQ8m7MXAANO6C+MM6D3SIv
         NFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451970; x=1752056770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN3/Rce9O/Hh8jlflcA/tOl9nLaEQorrzHfucHxWn78=;
        b=orROfe3degsmBbD1SHZlzkkdnOS7VhkUh+3EXLSuXS5ZD/KeliInTBGO3tHzpFrtyz
         wNnZ2WU4w/3CO6uLeJUBvvbfnmu8LFY4e82W2FHX3egKlH5ONwczitw4ZM7u+RY8VhIv
         +GHXAkytEzBZHF4+XySX3/2tVaqE+aR2OD2heVIBYiCRJJZ2jplgsMqA7YIj4qCYuhaz
         X0boXKgxoM5Urj7a3ZrNRpp7j5z3RXEdq7E/M/40SkxuwMyonhXXQ1P4XE+gEDyZHIde
         tnQuX8TvM4JLi3d1LOgLTPkUUPxx4yVEy+r6odpTUD6WDsvn+aCW0QtmFbjRBr0+Xsc4
         z7+g==
X-Gm-Message-State: AOJu0YwaXa9Vsu6o0TGsj8GgsuX/PHLkO78G65b06LOpgcAEuuPMstJq
	EwkYOA8NlE0v2OSm8q1ajGI39wtF+ePjLzphuWbVn6dwDEijvAgW4RacDlO4BiALeYA=
X-Gm-Gg: ASbGncukSJCG8YoLc+7Z2ufY9pQw55yNEnhC88aRZL+z48Egrv0J4hvpKacXzw8+kpz
	NFTuBqAT28JIuNpUvheUuTK/WwLGq6HIEo3WsLS0Uh6L6HpNaLVs80SmNIBBReRmN6mWX/grCO7
	uq4nVvGRTIC9Ev8f7HXjmauFm/eXBTeqHVeHi+vjQal6fTkC6iBt1Gy8kY21Ihz1bT8P75zc5Ri
	jf0U3lsi4UV/3YcswgTLxbcT+YMDm/GdEFNC+2SNJc4kl3Iq8Bjw76f8G+4VaVUG4ATk2tzFv69
	L82CyRC90UNwa0gkYVh8NbB8Tl1ujEbh29p23x/sNHbf9nmvcMRngy2V1Noi/kzfxlTS1w==
X-Google-Smtp-Source: AGHT+IE3Ue/jFuqGKk2j82UXQrlkpofLQZxfY4sZQlx7+9veKW80qJCzF944xSFEweUYweW+L+RcHQ==
X-Received: by 2002:a05:600c:698e:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-454a36ec56amr26467775e9.14.1751451969448;
        Wed, 02 Jul 2025 03:26:09 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f8bsm16191924f8f.17.2025.07.02.03.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:26:08 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:25:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v12 04/14] dpll: zl3073x: Add support for
 devlink device info
Message-ID: <x23jvoo4eycl5whishhsy2qpb5qajsqcx36amltwkqwu5xuj7s@ghg47je4hbjt>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629191049.64398-5-ivecera@redhat.com>

Sun, Jun 29, 2025 at 09:10:39PM +0200, ivecera@redhat.com wrote:

[...]

>+	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
>+		 FIELD_GET(GENMASK(31, 24), cfg_ver),
>+		 FIELD_GET(GENMASK(23, 16), cfg_ver),
>+		 FIELD_GET(GENMASK(15, 8), cfg_ver),
>+		 FIELD_GET(GENMASK(7, 0), cfg_ver));
>+
>+	return devlink_info_version_running_put(req, "cfg.custom_ver", buf);

Nit:

It's redundant to put "ver" string into version name. Also, isn't it
rather "custom_config" or "custom_cfg"?



