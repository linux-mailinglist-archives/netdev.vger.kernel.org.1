Return-Path: <netdev+bounces-72350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDED857A79
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E351C21B9D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9377E51C44;
	Fri, 16 Feb 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d22jyz4u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FA50A79
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079905; cv=none; b=LXBr8F1L2AX2hEgNZ1KFA8Pk6EaDYclM2Oz+DVvFeTJi8SHwwfDfHBLEDdvHbfTj5J+S4LfJM6hBAJuyJ5UQ2ZA0acI3CHmeBUGMJ0bPXgs0uPrgoIqGuBzplZCqo6se2ZKKp+ny0gNmnPPEt/3o0+zmsbG8X3s9vQppB1s2okI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079905; c=relaxed/simple;
	bh=uXS0K1Hemb43XKcyT4HTpQeAHH1Vn8JgUmz/2CBpgAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9i3W0abZArGEUBOK0q278PprMR+P7HkW3rC7XR1hMxKKZNfbm5IyVPybJooOuA/zN/mrbnCvPJRzIRKRBBXDRdQbGulRIdPGV9StqPZgyq/+xRA55Or0Ht18/LQsfkFVSdutQz2zmHlO89P2nh4JkLLjFzFuhBPmWm+uiXy6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d22jyz4u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708079902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uXS0K1Hemb43XKcyT4HTpQeAHH1Vn8JgUmz/2CBpgAg=;
	b=d22jyz4uEd8Pu9i8n0t5eHWN1pWnJZ2W8gR7FpvzcF4w2veU4FIzKgiNqeJmTI8m1kgbm4
	Vk+j47GlPTa5hvSGPZCcCI47Tl2VrwBNmkBZMabqG6gOmghcxdoCmr1XE7Y4xOtwrnBTuF
	NrTaeNMAX4HY+YuzKZ1QJRFHVqxoOnY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-z9lX2JWFPAKrnFgWsV9U8A-1; Fri, 16 Feb 2024 05:38:20 -0500
X-MC-Unique: z9lX2JWFPAKrnFgWsV9U8A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33b226e710dso130828f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 02:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708079900; x=1708684700;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXS0K1Hemb43XKcyT4HTpQeAHH1Vn8JgUmz/2CBpgAg=;
        b=SYB96eFXKgo4ZJiHOV2ccr774Tp6Y3ec35a2DrvD0tgs4vswUzTS6UPPTNhY9BaMsY
         2pWz0Ex5j7AJhNKb77KAQAyou0fBzsGOnD3XZl2VmWZj8qKf7yS+nYliabKn0yh8vZrx
         zlCueTwNYVPcYf1pQ2MjuHMyKqxiVtBQi0XlvBRw6q8aKjE8DXARwFYlSRW5sGjDoL7I
         gss12onlnddxniJ61ZhNENPIMLIec02W8NSSs0z5MPSTdPzaAGaPjx9Mnk7LkQNG7CTX
         3mrmXGZXua/B9CQ9y/q1Z+ezc9sUFwpWtclPSwD5oPjCwqKT4z05UTK4vIuH1h1hz9i2
         V3kA==
X-Forwarded-Encrypted: i=1; AJvYcCWDVJemGs/sO60DCj1qCWb2HS3d4IrvrKT9N2zAieh8XbHyAE38B9znUkUXCbKg3S3reX10YdxWK7tXfw0SGOF27JzkQ8w9
X-Gm-Message-State: AOJu0YyAb9g/5L6sfiwFENkSWwLi64E9AWzWJ1cC7bO1Xvbd7jgTtKqD
	VGxZtTPGmXK0sIVq9fLQkFuePrpAJJiCnBtjLi6sMkkJknmPQBD/98CGcvFT9UZQCIWkGzMBjDX
	2VdEJDb+w5MFLIBsLtEWExcKna/0fQTdKhlnnbJ1yHzoRbwhd78bDwQ==
X-Received: by 2002:a05:6000:a15:b0:33c:fa05:68b with SMTP id co21-20020a0560000a1500b0033cfa05068bmr1506631wrb.0.1708079899854;
        Fri, 16 Feb 2024 02:38:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOpUnHvWrvjuBSsXLayos3wTqurw1S/vs1tdzJsC2+R2S85v+XZoA+fg7qbxJU/ThZhN7fZQ==
X-Received: by 2002:a05:6000:a15:b0:33c:fa05:68b with SMTP id co21-20020a0560000a1500b0033cfa05068bmr1506614wrb.0.1708079899480;
        Fri, 16 Feb 2024 02:38:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-239-108.dyn.eolo.it. [146.241.239.108])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d6192000000b0033b6e26f0f9sm1811706wru.42.2024.02.16.02.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:38:18 -0800 (PST)
Message-ID: <ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs
 between ports
From: Paolo Abeni <pabeni@redhat.com>
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	 <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>, 
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>
Date: Fri, 16 Feb 2024 11:38:17 +0100
In-Reply-To: <20240215194325.1364466-1-dw@davidwei.uk>
References: <20240215194325.1364466-1-dw@davidwei.uk>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2024-02-15 at 11:43 -0800, David Wei wrote:
> This patchset adds the ability to link two netdevsim ports together and
> forward skbs between them, similar to veth. The goal is to use netdevsim
> for testing features e.g. zero copy Rx using io_uring.
>=20
> This feature was tested locally on QEMU, and a selftest is included.

this apparently causes rtnetlink.sh self-tests failures:

https://netdev.bots.linux.dev/flakes.html?tn-needle=3Drtnetlink-sh

example failure:

https://netdev-3.bots.linux.dev/vmksft-net/results/467721/18-rtnetlink-sh/s=
tdout

the ipsec_offload test (using netdevsim) fails.

@Jakub: it looks like the rtnetlink.sh test is currently ignored by
patchwork, skimming over the recent failures they are roughly
correlated to this series submission: the test looks otherwise
reasonably stable to me.

Cheers,

Paolo


