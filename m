Return-Path: <netdev+bounces-152996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D440A9F68D9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E818987A9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFE31F0E21;
	Wed, 18 Dec 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GNdiAf9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6D1E9B0D
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532830; cv=none; b=AqaaO8LDw9Bn/qmzJgM3WMSwdtpOBnIiUl8M/Eq6l8G4weGNNK6CxZwp387pxtVawNpKeoyWJZ+yuH0bjJPZkYeGOYPi3aPyd6YKntk/1T4B0layUscj5mBJ9jgXIytJafQAFbkBMxRJEVmRQeUHzuf/euiuQN9CaLueXpzXKZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532830; c=relaxed/simple;
	bh=NutV2UpKj6s7PqPNFOfGdNacIA0IVdXlKusPGgaLyHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwxnCXrUORG8MNPiMfuN7359Pp2hmfwM4Orow4jKZF5uouWpdkLP3UtOvmdUkpa668nEdOkaGr8tup3qu0WFT7R2wzlQUYQYsdd+G9rdZojETBOfuDl/kmZdizsPghxEurOslQ8BXrZrBxH+aa+hqqqpjZf/8rMVHssio/OiL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GNdiAf9m; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a78b39034dso18746745ab.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734532827; x=1735137627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJDGOuIdnuxZMwEFopgwHkwjXajkMEZIhm8f0iRuciQ=;
        b=GNdiAf9m06sL86/Eg4ULKAAtQIq5lElpM8xCMYTMqwIOY5dW6ZyK+M//PtxEhaL26K
         t5st5UmxzBvcbkC4j47oMvQUhjRpgIZi5qCv2Bfa4ufxrXiA7Aj3AtHCDU1siGpxouGk
         ne4BgAsCIXRgYreySZOfVLl/3Ef9kXG4s3UlX0F3pt/FzJrS5xqwEAntEF9wA3HJBF40
         hPoPW04Uc6YCqJMtRCV4Pp5I6pKhiVDybjQm1mpX2GOl4UkQM0RofDxYE8wRTce2xOfr
         miUWxfQHIRBfVybXqjC9nJ/iHP2LA3lhEMqrEEjRZoOGgioeR8jjj0QyLZcoW70Ug5eR
         pS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734532827; x=1735137627;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJDGOuIdnuxZMwEFopgwHkwjXajkMEZIhm8f0iRuciQ=;
        b=w+Pqq6YQ3p8J5jsKIi4tEm2Ya1/cs3PXshxHelbvyEqVXuhuTkiOTlwqmuEXmBduh8
         ZDaiq/bpM9qBFDXqaU+F6fCj8zCXVrRGJMjmbBWmbjB+QWc38s53+ZWQagTwoFCoknbU
         70V6GFsOty+1hQ1Gb1AesHg8HgrM6uCwRvvoagpPV2QYPSWeQLvEVnGiZRnFJA6OqJyG
         31kdBzMS9SMOgfvQ/p340bhD/3VeCkFUeS5GqrDj1nO1C4Tb8NVvj/eX7ajUszyWEbRS
         ViQZAzAFclAXtgWuNxohkj5aGpkMAb2mhvne9yasKJEsB6twT4RI5OqgCGZHGrSnLRBa
         VGfw==
X-Forwarded-Encrypted: i=1; AJvYcCUOUAPjehB0J3PFgbs4J7IPrbhUsMuPuH4ZbuCe2QfN1doFSqxKAiGND+TW7SznteG+8788WKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+5WyEkXTSkEwWh94OfDxuuEq4S36TbgzgOQPK2cbWm9EfyCb
	4f6YJmFG8jp9VFJGSx4r7f8SsgcUHJ16ahuLDOwrqRSqGq5NnUoKvsZ1wXAKFHk=
X-Gm-Gg: ASbGncuEcKJQT3thw8wfrb8gc0v8ve4QBJej74OjT6TmdPwXC6RXLljLxTJ6iLuJx2A
	Hv2l782vZ6+XhJvOAP9UnQcHaIyVpi8zRetQ9Ucfj74IKOlT+pC/gb7cMQguzveuXzSn6wV0H0b
	eIXox5anCxr7/vsPXHimmzLBPurSDdzOhnz5rkhs4DLcoLXl3YnuIrzhl6GFjIlGU073civMZ4K
	2RKsqMWYnpyd/JuNkH5uEIfyiGBACxcxwtYsre8QX5VtcFVmBvm
X-Google-Smtp-Source: AGHT+IF1xjYTetHQMKzb4AksPKutzVdeTKW8D1c5CoJVkGJ3rlE6ZV7s0twdl7FAByD4Ss36+SV8bQ==
X-Received: by 2002:a05:6e02:3308:b0:3a7:a3a4:2d4b with SMTP id e9e14a558f8ab-3bdc1b2ac71mr28204275ab.14.1734532827048;
        Wed, 18 Dec 2024 06:40:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b24d8dc980sm26733005ab.67.2024.12.18.06.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 06:40:26 -0800 (PST)
Message-ID: <25bcc402-623d-4449-aa48-82b809040f6d@kernel.dk>
Date: Wed, 18 Dec 2024 07:40:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v9 00/21] io_uring zero copy rx
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241218003748.796939-1-dw@davidwei.uk>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20241218003748.796939-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

For the io_uring bits:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

