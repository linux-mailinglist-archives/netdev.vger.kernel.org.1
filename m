Return-Path: <netdev+bounces-194152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B0AC7931
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 08:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD2716FB07
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5C202C49;
	Thu, 29 May 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5BPMV7v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B4C8EB
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748501283; cv=none; b=SCpwm4IxJm8LeN8eFHoqqrY8wbAWuPk9PUZ262YMd0xrzQPDoQLpSpa8ZH7OIm50GIa3aCOluY+ZiyJiAWvqe0nqoV6AWVqu573aEfnOX2+hcg9myj3o1QngowSxnsGa2asH2s4nO0FcWe+DFd9swcLH4EscPABg5sv+nnZog9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748501283; c=relaxed/simple;
	bh=1fbS/Ev5Sd8gaucxtNZN2NqHT7aWtDJ79rRoNoySgk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaYWfvqujlOLl79xATcw1oztxficfY6yfxECaoi5owBC3e+ItuBy1W3cYqvXRozBnerIokB58yfG0MKMl3DEn2eu6Q301jCTXD3dNP9xIyIbYbCc1yZzL7TGy2rTtrtfglJLcZQwgqkT3O3niaKwC7QVO6O2NHd9qO+OQXCw6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5BPMV7v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748501280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMuc9cgQoEf8UuMw4POuc5bnLyfr5YSzP4kZ94xMcgg=;
	b=f5BPMV7vdB7Rqx/fEPUvPeY6aMa3vNArHXM8h9IY5Isi0T8W34u/W6hJdisCI9zhLJTyJa
	e4hQFcYkW7OU2r1nlhnEeEtz5TVm3ecvRe4/oNyzeIyRYih9Jlj/5tvwACH3w2vRFxUmHH
	hAquHbwF2w/mbqNkJxzwQIVv25UmI94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-kW2QfFHROGW3LMbP89lOgQ-1; Thu, 29 May 2025 02:47:58 -0400
X-MC-Unique: kW2QfFHROGW3LMbP89lOgQ-1
X-Mimecast-MFC-AGG-ID: kW2QfFHROGW3LMbP89lOgQ_1748501277
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4d863ac97so218693f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 23:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748501277; x=1749106077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMuc9cgQoEf8UuMw4POuc5bnLyfr5YSzP4kZ94xMcgg=;
        b=VSzLBoKDoY2VIgqTvpjW0/RzbERJegE7DO2N7R+QhHWD3IndIKpCLOPOD/zFzsgcWA
         kDINgoCxXZRVBU14xy5CAWygpfze6yM8cUJJ6t6hqnxySc30eKUmWZQbq4ay++etkSjD
         pLfZQoShsn9aDSF3vg6Ig0q9AtG2/t8h7BiGqKrnK4lT7nYqBEoEUfAGJqEEouU9asF/
         idbDsiqAu8M0OrYNylk/jFpaSNHLMrlHsQFa5620lHLX1mOv0zCMlZl1JPM/0hyY/C1/
         cyAYppKQeXCyguIw6yjAl/D6jIilFyT72OE5aa4QBzfTxt4pol8e+uAfQC/BrhRoQvNJ
         RS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVug2bosoDZfo7FYptF1IY/DCh4szR9WWOVXueef5UDIFjJZQkTqo1ODQgla31zxpjbtoKBplw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzteWGrvwVdNtTBws21agALesQOI/Hkpx4CVG2LQnlHAleEYGkX
	rdeOU7DBThAOWT9gipNWnLWvykSK7Q/oe3lwBRaTPC5PgTGZWql2d0pw9oG2jRpb5eUt5pXLnLB
	GGCC61yj4gyW5QrXYSEPiNN/jOHfMEVtkVg+XWrtutWE4EHFENDrosKP+EYAai8imng==
X-Gm-Gg: ASbGncu3MOLvVEOM+75wYrSK9FhM9XrwTady5+0ETrf43//GKGan+LCPxmR0oFzu2ix
	1e/dcXiY6MtofMqa7MbVrualA/aBXz8a1hdOqlF2TKjcgBqDawqweKzYpbOZnK3UIxynQwUYGp7
	byehT/T6kLyh3t+FRaonriSrB4QAP8v+HTmaED5wAWbT/q5fo7TdheqpXtpedqrSPnUfBVcOmkt
	Ged+u62I9zOlo4i9Wcl7Rnj+iAX8Jafygi0mu6BK4/naErymaUnGGtXxBKFgs/k7p7Je7ADpOe4
	sMXf7THH3SGKvql47Zg6R+sqmVm3+Mw+m+nmMoZ+dnShQx0etXQ8+1TxheU=
X-Received: by 2002:a05:6000:188d:b0:3a4:dd8e:e16b with SMTP id ffacd0b85a97d-3a4f35b69e4mr707982f8f.20.1748501277259;
        Wed, 28 May 2025 23:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmaFT8LYjFaC+myZjagymMCOO8GMv8kvRVpJoRgXhOkI01smhZMOpldi/g+qfIFn7s2uYMjw==
X-Received: by 2002:a05:6000:188d:b0:3a4:dd8e:e16b with SMTP id ffacd0b85a97d-3a4f35b69e4mr707965f8f.20.1748501276819;
        Wed, 28 May 2025 23:47:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8b3sm1014514f8f.20.2025.05.28.23.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 23:47:56 -0700 (PDT)
Message-ID: <58dd23de-ffba-4bdc-8126-010819c6d0ac@redhat.com>
Date: Thu, 29 May 2025 08:47:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] rxrpc: Fix return from none_validate_challenge()
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <10720.1748358103@warthog.procyon.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <10720.1748358103@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 5:01 PM, David Howells wrote:
> Fix the return value of none_validate_challenge() to be explicitly true
> (which indicates the source packet should simply be discarded) rather than
> implicitly true (because rxrpc_abort_conn() always returns -EPROTO which
> gets converted to true).
> 
> Note that this change doesn't change the behaviour of the code (which is
> correct by accident) and, in any case, we *shouldn't* get a CHALLENGE
> packet to an rxnull connection (ie. no security).
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lists.infradead.org/pipermail/linux-afs/2025-April/009738.html
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org

net-next is closed for the merge window, but this is actually a fix for
code that is already in net (since Linus pulled and the trees are
forwarded).

We can apply it to net, no need to repost, but could you please provided
a suitable Fixes tag?

Thanks!

Paolo


