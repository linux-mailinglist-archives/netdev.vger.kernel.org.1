Return-Path: <netdev+bounces-204936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEEAAFC94A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E1A3B9403
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182392D876B;
	Tue,  8 Jul 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="PKYRN6oU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCB2D8787
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973243; cv=none; b=VGkU7HuOBCgVxoLvV8KqT3OQ8VqwBqcTQ8g7XsIOnIKglGSoWUnXfmMpVTFw0wC9EObbXQBeYzDsLc1dY5BKUoO9bIQm9oHTjWc/7iLK6dtbs75n3FLGFW05GgoqC73q3CxG6io0aa7xPeuECJ8T9GuomOMSZHzZpDuJyXXeLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973243; c=relaxed/simple;
	bh=tzWm/pf/mHBdimjs3cIWjD5mmhbVNT9GnOsirEoqPeI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IhHcO8ss9ZnCndlqPO9ynfQ2mXn6yBy/1fJMquwrnj6iTOW3Qt4blvxMQPyAAtHwQ6I9nbAcxL/mhtX3+BDf9qty3U1J8Ml9nV9dTTK1GJK8wAWwEdQlW8jIRuV/2WBLc6UoR8kanQlscUU3yD9e4Ty659K6snyNln09cDZwTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=PKYRN6oU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so893836866b.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751973239; x=1752578039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HsvAJSLDaymS5Tj1dZnIcmrJZYcW6e5LGsOhp7xuFRE=;
        b=PKYRN6oUXwhHA5N5YVI8p3/puQRK4uxVl9S+rzBFegSxY8gLTckUwidoPMTjPoC9Zr
         wfSMo2M9/2PiAucR+5JX0tEU+9U1KmythyyzrBhwQUpW520kEvNi7YWYXJnEMkOO7Ya1
         SYPUa01Eje3OyXVsDlCd3VfZm/UfUjGJVDUKiXW5WV/XNtvVNQSLdTTadH1QA3jnIF1L
         5/Yq8VuFzzyrtF3Mf51CSNlK2bXlLs1WTpfFzrH4v0+mYqcEyIZ1t4nT0Hvt/cdzLLyo
         DmdfC98wNxfFbZrs5deYOFjwQcKlcqDipWrpfIIaPBrIkAXdL8b+32Tdo44WtbQMgPDG
         7WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973239; x=1752578039;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsvAJSLDaymS5Tj1dZnIcmrJZYcW6e5LGsOhp7xuFRE=;
        b=Er+zNYM5MdZwo7Tfmt+mLY8EnIX//1voDHa05b2qmrQLNq/KbRllQDHNZRzgbYZ3G+
         D4Kw6C9vBub9hfLQv7IK/7a58NbgLYxKrwA6DSTwQldomvC44x3WrrdeFuUJqUDqH66G
         hSmQvnC5G3EbYLoitH6fQs3YsEgwKMiWMRoA6TBkvvhzksOEP8ll6kbTiPm/HJm7anSH
         6MrVAatz+82uw0RN8AgMP2Xv41OGbc44jW827FAeDc1mjrEwZyoxFJTVXLulxcIViMsg
         Nn+XLoK24alHSiehy31WYTc3p/iKJ6KYwglpGZeiBGk0h0ceOsq5L4A+7uRNju3E88c9
         xtyg==
X-Forwarded-Encrypted: i=1; AJvYcCXTosre/nWx2Q7y80Z/H9AZiGIOIpglpO6uJ94Eugl4snvv4Albc5n9sPBJrzfN1HE/AVJLR4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpwKb49m/u1bM4MVlT/JqBlwoB2W7a/Y4X9jLzvZwtWIYXEML
	L/eFH0+VgJezl/RidPFoiwo4hjxlDgiUDzZJFEm6UKoOekxkpIeAD9SyPSrQrZRdzA==
X-Gm-Gg: ASbGncvVItrlubZ0i+n2WxoYG6T4iHSIkRpHoefmfE7UA2VhrqOfECpEdM3T5GgFXZy
	+zZn+lOZ2/K0w3sNfk4hwW9ZF3WS59YcsQnVPZo6a9zTp+usaXHA3PvPcZlh5bJAK4Rq+KpxcPs
	IGTjNZFedlwQ5E36sP50ygSD24ZcOZfQyW8L5KCgL15rrGjm7E/wkd/xmSztPB52D1qGMZOajWj
	7THqfvvjb8Hz1ocXLR/+Um57qN2onl/0q7pfWqBVsYv/BSiM7ihmpit6+iKcpwG/qXC/PSUK7cu
	8ooTzgk9fUp9GZTECqn1yrU5zOwTv7XCKVGjoiUbyYOCZRcs6F4kB5fs9iVXcNAej/x31DABohU
	=
X-Google-Smtp-Source: AGHT+IEJkJqPpNFxB/Atqrd91/lgHGhPJPD80WjRy1F+MJTPvST0ALfz0vkr7NM1so4XFRp1DaUqGA==
X-Received: by 2002:a17:907:3a85:b0:ae0:c534:2cea with SMTP id a640c23a62f3a-ae3fe7491dcmr1054557966b.50.1751973239215;
        Tue, 08 Jul 2025 04:13:59 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b0336asm876942666b.115.2025.07.08.04.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:13:58 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <06b5938a-0238-4da0-8b8b-dc2df95210f1@jacekk.info>
Date: Tue, 8 Jul 2025 13:13:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ixgbe: drop unnecessary
 constant casts to u16
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <33f2005d-4c06-4ed4-b49e-6863ad72c4c0@jacekk.info>
 <IA3PR11MB8986B9D474298EEEFA3C57E5E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
 <b3273f0c-c708-488e-88c0-853e4e8e5ed5@jacekk.info>
 <IA3PR11MB898618236CA2EA46C0A861B7E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <IA3PR11MB898618236CA2EA46C0A861B7E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> So, the change looks scary for the first glance, but GCC actually
> handles it the same way.

Basically if there are differences, it would be a compiler bug
due to violation of C language specification.

-- 
Best regards,
  Jacek Kowalski

