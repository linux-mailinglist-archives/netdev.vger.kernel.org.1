Return-Path: <netdev+bounces-101794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5C9001AD
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19EFB230FA
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F8187322;
	Fri,  7 Jun 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLn0yDGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881C18629A;
	Fri,  7 Jun 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758678; cv=none; b=ZwY5m2URNL6bDGRMtS74zUmZVVxY4RKd2MqXFBY2wsgdqsmNuMJDHZi1F7j7pqKbwXjeR2kRURJztG3aBqBt3/5REQ/GD0+JDhUi5+luIE1V2xNkOLxgKEIOfBa8f1iNEWeOV3OEKWhlBmRR9XVlC4SLeBFya0L8Lwi3NWd6JP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758678; c=relaxed/simple;
	bh=ZPFTJ5yasowPxg7hUr2RBqIEH2zwoT4/yuIeTMpnX9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQIjSJ7pCglVh4MldK/nPZ4jpJcxuegKAx9HPbE2ptmL1hCgS19khydvs9vgLQjHne8D4Boyag0WNPYn/fv0LQWv3umGN9V0h0l0laVAZ+qpB1qQWEh+U7ulM0PO/DoqlIeKvT2M6MoZA0YlS3ym2mZH91YsS1VPjX7T/RFnuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLn0yDGF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6267778b3aso231338566b.3;
        Fri, 07 Jun 2024 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717758675; x=1718363475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpKQh1M9zH+SHw3creNA1Bp7WxwNzo71mQTRHpq2w8U=;
        b=JLn0yDGFxUPzoka7bm88g3alTofLLST+8ONVsWjeIuM5fBiAe6byLl9DzKJxoogLWK
         sniG5BabqAGpy/PYPsO0HFGn7ZGbzPHpEyGuEdRjBz9LiLKPOOcIMaBO7DPI1T6yA6e/
         1xF9br02q8kMwI3GU79PM6SPnYU2gLyQ/OoYwDsxwoeZvjjW86HGPQ9esOyQdxaxs66t
         2Hp7ipLPE8Sue60BaZkiCrsR3vOqLQM3bJG17qyTNzXsrHbNnbYh5VdSaPMA+DeftKYp
         LQyGiL7RhXyzxaXfZqWn443Wvs4wsoXVm+bry9t45WOBsEkUCh0y2IGgmLNrr3RqTA2R
         b+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758675; x=1718363475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpKQh1M9zH+SHw3creNA1Bp7WxwNzo71mQTRHpq2w8U=;
        b=sxVrmr7gQYYdrub+8UP8HJxEWsH4xCiCQ6GxnWjs6vraWXy+afRcYGKsfoIaObSw7+
         4zAt8m+TOj7y4AUCHod5tX+TsswMMGzcCfwlExEVwKQvA6/ForqNHTcavqlcqn04/MzZ
         T7DI/vHaTNe9905bOgvr4nB9P9LsjJEiR2I5x6nWoJTmKtOk/fMbtdrBRQ2uMrUVJXg4
         07RO1FRR8TkWqyxWheaPEQSZpYAYvTqbqt8F2r8htkoMlYIR6DWMoiJJKyIRyzEVn2lH
         7wr6srQ8MEVyeSuKIRbjCs9mWiwxOknrtM4wmq8b9/ftsfrWLvppXcEZlgRoAWz04vPt
         4U5g==
X-Forwarded-Encrypted: i=1; AJvYcCWsGKpc+jefr6GqKCf14LGsEuX8tjDCqvcpDtPcgyx3H5xz9VINfKd0sO02aEZ37aSNAcpBBcmenWkboF1E2kYnAT+n49GGgOBSKsODTX9OQJaidPYf3TaoT1PhzN2eDNpZuOD4E7lsrbkFsUbLrpt2xinVyehTOtMlDWskxyM+vA==
X-Gm-Message-State: AOJu0YzFhdBSP/b5Xj/9ma52NIMSITgTXDDgBHWZaP32zDoxaPx9do/j
	gR4TgpzVXxAIpoN57C9KKEQoxvhVXwe//b/bjs3AM3PZfFX5S0Wk
X-Google-Smtp-Source: AGHT+IGfqtQEhItZrXv4I/ZV0EqxLdW+/lRPZ5A37w5vumHcgtSUFcIqygtj3emK9EyEYBTTE+VqTQ==
X-Received: by 2002:a17:906:fd85:b0:a69:edd:3332 with SMTP id a640c23a62f3a-a6cd5616814mr205281866b.12.1717758675303;
        Fri, 07 Jun 2024 04:11:15 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e839sm232436566b.176.2024.06.07.04.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:11:14 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:11:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/13] net: dsa: lantiq_gswip: Don't manually
 call gswip_port_enable()
Message-ID: <20240607111112.tuilkvwektzohvrq@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-5-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-5-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:25AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> We don't need to manually call gswip_port_enable() from within
> gswip_setup() for the CPU port. DSA does this automatically for us.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Not to mention the first thing in gswip_port_enable(), which is:

	if (!dsa_is_user_port(ds, port))
		return 0;

So the call is dead code anyway.

