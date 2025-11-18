Return-Path: <netdev+bounces-239338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC4C66F73
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E086329E1F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C03254B4;
	Tue, 18 Nov 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw7Cgvul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D4324B2C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431667; cv=none; b=q8pARY+v6Gk7j2j7j31MGVbF4Xm9Kyt1a6rWOMXeiRV0BDZ3mP6I7Zia8z+YbGELilww27boZoxw4RHLerNc6rTFprm46wYTI0xae/U6w+ykR/TKzFuCLUvCvACHgxo3H97+VwnvRWikh7fS3kyXxJQCeUCxOyhccTc9oJVtiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431667; c=relaxed/simple;
	bh=zulHb8HLblzFI3a01kSRRJXRLphS/NHSMEh9xUMRuSQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GnstK0KMEH0wik1/ChHXfffVdU9Zl57qs7aFHxDHsQQN5wG8Tvlk1xejlh5JJ3SbOdUm3f7ELMHXl264yJxYLSbwgeflyXsk91/OpY+eyoZHUYKpR7CN99yjv5dDsexXlk2kK+grO8KyRwsHMNjqSMC6SVaITfeGJFaV9+xOfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw7Cgvul; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-786a822e73aso52532037b3.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431665; x=1764036465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUE0IIC+wUoASvGIKd654X7nuyMKJdJFQ4SB1lxt2/E=;
        b=Zw7Cgvulv2NtCwkhjzjdu+t2FDLKlZVds6WRKGWBDFIbGahVvmAK7Cmk/kLAeDjnG/
         nzh/or0mh9mfxORpkVw7ArvjHnPkOEDovukg+ug8FPtmjcYUHIzgUru6x3tjTCZ82pSW
         iBBz6kaj85ez3xrjr5GUpvB4i0YFLikEIFcu7wT4FDmFn7K7KGVKcWdx/vpfGlyQNtDl
         BKrEN2PSLjuFTCAjgkF072DjEAcSlQgva8OiK0UMXJRoZCact3Xk5CZP5FtkO/6LfBY3
         gaKYjyZM3pDFTXPkDJsD+zABX5+aXZWa+kmZB6sZihU7K0N5k4dtRvaGnBqjZCv4xV0s
         RAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431665; x=1764036465;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUE0IIC+wUoASvGIKd654X7nuyMKJdJFQ4SB1lxt2/E=;
        b=q5RTQdUgTTIACl24jnlpplMpdTeAFxJuQdBFhP4hdWESAjNJjxkuW7/ZbwM3kzEdAf
         UhoGtpP+nITfSu2TERhu5fwA1hmoYyHUT8kwKSA4vnujQevKuBiM3alMVJnQSXPbCt5D
         XyVA26PKfSBosb3I3a9fmFPeVApUkYaiPDKOszf0/Sc7ZutYxOTBblvVz65WRXszpnpF
         DGp/2cLu4c54ffOjVup51GyRt/La+qBGMAECFFOKX+0Xu8AkITSBWADVtIU9tAVS3sEl
         OwWrLXc/Ae0QIqhxAgeoEYBQABWzkmT8wby9Cs+BQS6y91xnfA193MULJItpyr0yADzb
         6YKQ==
X-Gm-Message-State: AOJu0YzuMits4KkGk6GQHIEOzDAvwXOUNzsomGWk+Qoa5+Y5Z2DenOjT
	DseRr/nU2nQ9DAq3Zb9Yiw9jj3tzhQPMCMaPFMBwPJXWUhBcAG7n6NqB
X-Gm-Gg: ASbGncs48W/+tq8iO/dICU5frtkyNM+hC1ixstRYn4CZYuIKSnoKOfyZX0Sv5z2fMpq
	AWPDy0Cm5fC5bilVI6VvTrsmlbWGGojeG34U/3HFuVxpeJV1ipSd+Ay1GRfKDDBKiWnrmL5G6FF
	2B5AmS4XUTuZPUAf/gbwT2eYM+N4jQ9O6PZjnZM9BkecMzOWZeo2LjESmQVv76Ky1X7xESJpPGc
	W8yjIeXWvdpAMZa/8WBENS0P3x9rFjINN8Tz6xa+yZIXtDeJljbQ7Dgxp34KsBLxr5efQnQwFGQ
	BTSKArof4VGUeem1nLaNWfR4HMEkV7sTc9NzySbzX5WAIuwhz8fp86dBhgx50l782qCbQDhOvHX
	Xbhz7oxIscg/Fhq8zTQ0eplf7WxVYzMFL0geraktLgJdi0CuBobEtXJi4w1yJOW7pXTK/9uSgel
	gErxrr5YtyKgM7IOAjH4Nzb6wUgzFPM/yjjsrEKYjTWkAoULqr4wPEe9JJ
X-Google-Smtp-Source: AGHT+IGeaC4GKAyV7ipin/XG1dYVhnDBsRRn2eLksOzMNTKNMaqNZZNWaW168+t+ahhygJPWcmrPyw==
X-Received: by 2002:a05:690e:d8a:b0:63f:a856:5f56 with SMTP id 956f58d0204a3-641e74a41cfmr12289102d50.5.1763431665061;
        Mon, 17 Nov 2025 18:07:45 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6410eabb558sm5294781d50.15.2025.11.17.18.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:07:44 -0800 (PST)
Date: Mon, 17 Nov 2025 21:07:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.fa82e73170d8@gmail.com>
In-Reply-To: <20251117205810.1617533-9-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <20251117205810.1617533-9-kuba@kernel.org>
Subject: Re: [PATCH net-next 08/12] netdevsim: pass packets thru GRO on Rx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> To replace veth in software GRO testing with netdevsim we need
> GRO support in netdevsim. Luckily we already have NAPI support
> so this change is trivial (comapred to veth).

compared
 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

