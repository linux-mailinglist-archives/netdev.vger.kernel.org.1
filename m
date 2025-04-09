Return-Path: <netdev+bounces-180749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F38A82552
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CD04E2533
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F40263C84;
	Wed,  9 Apr 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvAyI2KA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32808262D00
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203072; cv=none; b=KpOAFdPkjNhNeF2quEXsO85i8NY0JZBG55h9tDawnHcrFu9+q/dOmxMfv7YGGPhzsCVR+24OFAwuV8cG5kzXGY9REtlZTEsFeolABN2CMk0+084KXNNpPaS7w121X1XXnd+4RHailvfYVDg8O7YAs33H3UdxJTnLVl29uRoljL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203072; c=relaxed/simple;
	bh=ySMosH5p76nbVxTPHwuRjodcBHLjAECfu8dLmntPlCA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=foSmXxcHRJHOCYp0wv32ASVuZrxhshi4xmCjeaxO8NDaEZiLdJezkv5eHlRipyYbwsS+/CL2IJ8BAQewM0atq/kjJ8AF/nGR4kT052Q33Ltu88lBfjiz3xX3IhfScW1UY7MQzK29Nipp59BEnUroEIIvcPYly4RFqO+P0n2Nvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvAyI2KA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39d83782ef6so426017f8f.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203069; x=1744807869; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySMosH5p76nbVxTPHwuRjodcBHLjAECfu8dLmntPlCA=;
        b=AvAyI2KAPWHgTG5FbHOFuJFS643PgmPBLcldC8DnyBJoqDr4psaVeRvPJuApwV0WIB
         plBTi4NQRatPy+pP+PAbobOnTDn5QVxgc7PNOKeUsXWbCzmfTxuKT0disiicyUs053hz
         H3nq2JyJ77gMuAcJ7+6XC6il7plO/k0YyWBNx9Rq8zdQlcVt42M075XDWnFNihFw+gdN
         e443NFSlXmSWvcIpyiDIT0kQBUP0nb5t+2mbq3/qG+WG1J7CtHNVpmjrIJPMeYN2rANv
         F2cJswj47jaJt7xJBreNA5b/Brsu0dO7zTXbkanvkPyz3GMUANKghjUy2Gl3G2ore2MZ
         AC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203069; x=1744807869;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySMosH5p76nbVxTPHwuRjodcBHLjAECfu8dLmntPlCA=;
        b=kz/W4bmrVOhnQtoXVMvFOmynCvsFiGp4r8dWLGISACo3sXpYPVY+tU1wbVvVM0dTNZ
         wh7b7EUM5/DjI7UmJyzXFwKvG5A+uJy6bq+kj+3Ekh+g4wSW93joOmJxIGtylgDTQC4T
         yspqUXuu7eOeysygz6SlsJ7n4Qt4FreJje4HjcEWaM+8oPHri70rwY8jbN1FhdCzPpzd
         sE0hKDETm6iqzZlGRNG0psDNfad5OLiaJ+vnedFz0lQQTwNDWrgkCtes2IwVngk7dYu1
         qdZpUKwSJCKTtRfNRCMgmMsxKE/9jaj3abWExaxzPf394YtQ+GtWZfuU1lzzei23WPu6
         nWVA==
X-Forwarded-Encrypted: i=1; AJvYcCVrGos839VB0HrLtPQ80SyQgt23cFthhDQ42kppG2nFb693JpWbDMdCmE8xUiAIrE/N5BHaibM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpJOKvo7brQTkL7AUlPYBeCJ+GXH+IAytKzvFDkDnZ8bTKVcjs
	9SQgkDy9nez9tMczpxghhtVPvWBStq3AvKs6Nw6olG7vMum1vJ8k
X-Gm-Gg: ASbGncvswzRcPKgZMrvBmSxVPxXD7EJkSIgdUNlaT4aXVMdLJ62eTw9XIbrU02hN5yr
	t7ADoHm/vlhNxNYf+SRK+YoPmSaNuUikCK2fsKiJaIyrsN0bXtuXork26ZwStV/eugGWQ12uYWU
	2Jk9fHmaVCN24Z1lwHrZFLV+X2GQr34bkuBmZjURgUhOm/m4gKdNqwWcUAXQ65a81IpL2AZ4g2s
	+JtcKi/nos/sC85y+MfdRrD6d/kdUcB1jXSC1shOGljIXphldA0cV+eeM5Ke/8jMVK9wbLNICyH
	biAWTeDk6P+qqtjj/XWYfR+9BLMkpEflXRGiunxrOO3P7OxnnyKlyg==
X-Google-Smtp-Source: AGHT+IHVGyVP9tr8rVDT6KieVeXChR/3Ob/Fb05vGRONWwTBA1ZKHf2c+8sWbaJy0qlK3yS3QreT3w==
X-Received: by 2002:a05:6000:1acd:b0:39c:1efb:f7c4 with SMTP id ffacd0b85a97d-39d821116d5mr6501684f8f.25.1744203069398;
        Wed, 09 Apr 2025 05:51:09 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23572d43sm15092885e9.31.2025.04.09.05.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 04/13] netlink: specs: rt-route: remove the
 fixed members from attrs
In-Reply-To: <20250409000400.492371-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:51 -0700")
Date: Wed, 09 Apr 2025 13:20:46 +0100
Message-ID: <m2semh34rl.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The purpose of the attribute list is to list the attributes
> which will be included in a given message to shrink the objects
> for families with huge attr spaces. Fixed structs are always
> present in their entirety so there's no point in listing
> their members. Current C codegen doesn't expect them and
> tries to look up the names in the attribute space.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

