Return-Path: <netdev+bounces-107775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3591C481
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBEF1C21819
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639A1CB317;
	Fri, 28 Jun 2024 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vTqxiFPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605DF1C9ECF
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594555; cv=none; b=sqUC3Z4oO0nGepv9XAs+CV7EOv05dZHMEu9lU6w54gLLZWGD4fRh8b6M0ABkptiT4JeaKmXH4rPj91FueTaF8DCSZX0M+670ob0xdKRcodNZKc1RiXy3H2PJ6KRkXjdq3Vgtugjp80JFCld1q6uXanP+H6naJv8Pw7uLJjKyTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594555; c=relaxed/simple;
	bh=jIaONTjps6miPll4PQVUCzr4NACzEvdJoQIdXLv5i6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piz1wtD1DH7m8NyK1SSTIu/1FCTHzlwQ/ut0Ey0esvdNcJK7tgHxBm+PLeU6wesV4WsDHXp4E2LMXiF9P5yWdO+epopcGwvrtCqYdrxKItnYACvL+yRByTA6HrI/K0zDT2oD6km0pQMs0ncFi1LU1VQJuxF6FjqQKImH4VZdOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vTqxiFPN; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25989f87e20so83677fac.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719594552; x=1720199352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31LE6HFOYQljdlfLoaQEH2FoBjrI6f8xv1wuu5virW8=;
        b=vTqxiFPNFllcDBwWI9uV25W9K0YH1XMGz3vhKNsDERabkfGJfyE+gjMzHfwoldt4ei
         W2PSIB/6qBef3umd7K6YdhSo0EeQ03Z2rJnOkNiqg785Q1Y2dRxe21sE/nS/+9fMwl0r
         wPIHqprj8MFFE0LpMKz3ngZ0MdIwfYi3+gqfyBkhAVOBvoRLUwHqAwu26Qd2xeyyXPGN
         99wyReMlH+LZWtOxzj2aj6J8amxavWQTKBqQ5yxXzu1X+EUuiBFFBCJEMz5ez+gtO6/n
         P7TPOU0pzFeFMZ6KrinAsVvO/hfhLSZTEACUL3p+nMdn/E6mAl9u/Z23WLfN/BxZtUek
         160A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719594552; x=1720199352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31LE6HFOYQljdlfLoaQEH2FoBjrI6f8xv1wuu5virW8=;
        b=IxcKCCs+J9iYPNLenbqVRrDjoll+o4Sl0DgfwZCO8aiM3DSknJlK3qnMC5ocfLt1LG
         fFYDdLN3YRbO1KHZymqx+gXoNrbUpB8qjU3Z79NmBHaHKxQoUGQ4sh0QI2wqOTtG0C26
         voj0yZ6gh0Zjv1K+L9oFiiijeBhL0qvdJyIeVlDikBq5fXtVP7a2yYChZAK65GbsMgXS
         o+qTctqF/GYnq0jH7mIcS/XjMwIen51CnjahDFR38NnvsfUl8wKmp+/1qr7CvT1kCe7Y
         rpSzd2T35nSonZZaRKhqw7jSHH6g26cImm6WaNj0nNxVLZpVBeiG+4oaWtEHzK8jQudb
         m9cw==
X-Forwarded-Encrypted: i=1; AJvYcCXpxTnX7MdvbqhEeyoxQ5SUf0GXf6H7HtNWAm4j8Xf+CpInGkTKTZ+6d1EC6mbv973Gaana6AEmZtB47lcy7eaKtqONahIX
X-Gm-Message-State: AOJu0YysxhFCzut3ZUhqG/HSD+4zU+GD+UghHgQNUQ2ue/kYZau0b6SI
	gfESEe9rrM+GNPPs0ZaQIrSDV3irxO/bsBRwJ3jWzBpkGc+Ajj4URu5ywBHbmU4=
X-Google-Smtp-Source: AGHT+IFtOkPV5QySi2C3Lm+zza2+wpnpbYXp3hFp9W4E1cRPw1hjSl2kL8GPJ2VHtFLXGjPLbRhVGA==
X-Received: by 2002:a05:6870:5587:b0:258:476d:a781 with SMTP id 586e51a60fabf-25cf02d87f7mr19127744fac.3.1719594552342;
        Fri, 28 Jun 2024 10:09:12 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e339bd6sm507709fac.46.2024.06.28.10.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 10:09:11 -0700 (PDT)
Message-ID: <c175bc3c-2d5c-4785-963b-01ae969f8e6a@kernel.dk>
Date: Fri, 28 Jun 2024 11:09:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] zerocopy tx cleanups
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <cover.1719190216.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1719190216.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/24 6:59 AM, Pavel Begunkov wrote:
> Assorted zerocopy send path cleanups, the main part of which is
> moving some net stack specific accounting out of io_uring back
> to net/ in Patch 4.

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



