Return-Path: <netdev+bounces-137555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589959A6EA7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D27B21B50
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA91C57BE;
	Mon, 21 Oct 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fj0Hlxnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6A1C57AA
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525625; cv=none; b=l2hj2DDL83ZsLlP6S+gPQ0CcXc2neuzWXejkei5vvpM6Jxij8JjJutu2BwJ06F4N7vl+8W9Y3mxRSBOI58ZmsK2ZplIUYMkBlaloF5djuedT783COGBYpGjqVk6gmvZLnoacXd6qnjvmzIitj7Wh+/RWzbQuvew6JKIjHlQlwsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525625; c=relaxed/simple;
	bh=LF/v2APQUH1XNOf6nW5RuGpUkrh2C2KCHmydIhInUF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYut9wcH/6aRO9xxP3/+gLicxhriKyJas8V20zxYs4Mc5o/P9ZB3e9Qtw/TNRwXS0pHYcXvP1jPgX+NNavsQaEf5l8uKa9LqX0EEtvrJkMgNrFfNVpB6gtTugxGP03H16YZeWkFmnM4YkjUKAiozS0SwpDTkT4+SCkM6TaTJVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fj0Hlxnb; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a398638ff9so17815515ab.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729525620; x=1730130420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpdiAit/JMF1gHPpQc8Fla49evuVYP+pTUnVRIxMK3o=;
        b=Fj0Hlxnbv91Sqv34ftbYdunF4ZSyqRBhfKbtCP6kjxuCFPdmhz/48rj8sq8xHpbVAZ
         DewooYlqYESUb+Yq4Z5O4OBsMFXqQrSpGu4BEbMUxrvtJh7Nve4f65eSeGxLcHrju1Bu
         QDCaJOK+HhM8cjd/Aq84PBFC7kqPJAqJXP+8JNTn6rWhGhxMcuGoZfHQZccfSa/d3jeO
         W9TOKwOhhG2sXfU1+w0ZbTaSKa9vwQ8JEBy2TIZT1Z8ujizWnOJEvrLMKF5G9WmfUu9Z
         abue8IJotY1IZkpy8bk4WH8QKD/W9SGVYh6H30VSV+wZ5nBJVhbr7dEDtLLRCGYsTKAo
         gcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525620; x=1730130420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpdiAit/JMF1gHPpQc8Fla49evuVYP+pTUnVRIxMK3o=;
        b=MPNMy55JrAg5yl7fapa/BtjT7XH7Y2asMwWs/GblOBHf6BPm7bD/40rA7NlZmSFu5Y
         yWyG6ho5x0qjh/6V/aPwSVZQlDkzKKE1PYnHO20UNSZIyavfTnrcAlTWxpRXi0nVZtuY
         qKWGN0wWDBC9askV0ULFDfl43Wj3fPdMG+eYojFm5RqsgTfcs7UpP7twoQwBl2/8AFa2
         rlKVuP33UfYg44iQSNCutcWl5Ah6Ola4aJo8dHiT4C7RAZONWUmop2bFo+VcVl1DvYpb
         RfFTmmgFPqI877mnd00FhE3E0tG/RfliSOI635DpO/o9Ig1e3V0+xud96nnuV2JfgiVx
         Aw/A==
X-Forwarded-Encrypted: i=1; AJvYcCV1QMeDeMfylfb/5P9JLEsTB2MzwJLeZklajMoczKJBN5N9/H4Nl6uWydExCFs0sBLuR6fjxTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykSn/DukljrPYaWbu9/U/IouVyLQ/grSmsFMLQqzcTFfUa2UHo
	gM01V5GeLQw8Aj4QuXVQq0cv6jNxtjmA1/zeyntjE3zLeW6NmcOUSTdbPLg7DLo=
X-Google-Smtp-Source: AGHT+IHr5og69wO715zXAn66waKEp7aqN8OlLYyE12JW9jdHNg5lcBLqOnMIBg6OrprNLXcTQNFtFg==
X-Received: by 2002:a05:6e02:b46:b0:3a0:533e:3c0a with SMTP id e9e14a558f8ab-3a4cb371e0dmr5991535ab.7.1729525620617;
        Mon, 21 Oct 2024 08:47:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a400b7f439sm12135375ab.76.2024.10.21.08.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:46:59 -0700 (PDT)
Message-ID: <1f6c0a69-afde-4b7e-8911-683bae66e104@kernel.dk>
Date: Mon, 21 Oct 2024 09:46:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/15] io_uring/zcrx: implement zerocopy receive pp
 memory provider
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-12-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241016185252.3746190-12-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks fine to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


