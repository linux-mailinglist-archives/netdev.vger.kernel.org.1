Return-Path: <netdev+bounces-115360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BA2945FA3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06627B20E39
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C0200114;
	Fri,  2 Aug 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eme4P2Or"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4391F94C;
	Fri,  2 Aug 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610190; cv=none; b=G0erfm3UhNSLPh7zIMRa4H+f/HmWqts+TR0Ff0QKQJpEvv6Rc85mVO5h3rV9IGnEJXRb0NE1R4L1QOE2MZqrdWkGZiC4nw+nPYSuDgBoqOj2zBSjERgpo62jq7XI8ytiCZNDAo+KjD20eJuJt91COXw/m5z099YN0uMYVmwAMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610190; c=relaxed/simple;
	bh=C0gNPjyqqSGaw6+V9sZvTDgJk/TpHOmXXsbUVayAPRI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=oSOKRhVnLI72v2ESFzDiAlDR/ou+5k6UiYYXiT2vggcVAkcUGGBTrF2tktjX6DgXGPWs6Y69rxK7hGtVTpIZSkzvVVUbMgwvbA6oTDZpjM1oK1QylYC6VuC+eIHQmY62kWJFEyBNUlT1Ua7Dr4u07Um1GeYuxr9Ceu2f08cG9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eme4P2Or; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so19942915e9.1;
        Fri, 02 Aug 2024 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722610187; x=1723214987; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0gNPjyqqSGaw6+V9sZvTDgJk/TpHOmXXsbUVayAPRI=;
        b=eme4P2Or0OKxPBywIXzssf5bP1qBE23icBC05X+YoQwaUT+Yf0Ls+bnD0zOvAAS4Ck
         9gY6U94C6TFgQwj24R6vbrgsapOZAUaOWtkk4dV3Qeo05VJp7gVSUQT2/3fU7RkArA7+
         86UmZVo0w+lDncbaSdND3qfVLHLp6ySmu8iOM1Aou18hwgluzFr/tjVGUzVCly+VljMM
         d5ChSkV8MZqRIDRSapRFPn/w4ZgKW138Iv5DESRfehyhJZCT8XgzX6qTBaFRLvgouSR+
         QjFnGz/noqUrGIswqkVvOeZN1wGqjStnBemVOCx/y37p/2JXXs5AJNHiCnmq8t6p5clO
         aIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722610187; x=1723214987;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0gNPjyqqSGaw6+V9sZvTDgJk/TpHOmXXsbUVayAPRI=;
        b=kV+/3HFvujOPgSzZae9oU+vrsCBMpxoV5DBPsrGsSDYBEGppbvfwxtOSSY/byltZtT
         05KxrqzfRE4K6I82Eo3jS1uEE9Bylm13SPBKIJDnzNu3EyClb9FDuIE6LLE7R1lSpq3C
         BNO3XGmFvVKjqk/OpPJNhjnyqAZSDVzB4kZH94yWJPUpoupsNjhU3c4nf5B4MHCf9fp5
         xGGnY/JROAYa4+vlwQr5TgXp19iJx9O453r0P6T8IpR8YevZn35k4j7+DCCC74legX9w
         L4Mq2/aI74ZAlty1APk6CzIs8OFnPRnhLX3xJTZzpABMcgmhSVgncsFjpNCO58VHwCyn
         iXGw==
X-Forwarded-Encrypted: i=1; AJvYcCV2eUMqWkSZCUFnH9Evk19oymomJgzsHFpvUW0jC+xo19BpYY2/yXgvXXZgdIODSETOR7eSDu95NkDVvu6V4tLJsqYmdtjOXEU5vCrN36wVzBzqC91KkYH5is7qYQGsKuDzfb3K3N3NmkH4jYyMRA9TD62tx+Pcpc1U6hPO+617nrTQObcG
X-Gm-Message-State: AOJu0Yzeg1ZYMRq6dh6HKL4JXt9Ggw+luosoBVpC5zY4cCbNW/e/byW8
	a35rbifCtKl2eka2UaFHdRJ5AVMVHOF0gzfSUOkJ8NUQxPm+Nb6Wb32BEARs
X-Google-Smtp-Source: AGHT+IEshLaLaPr08jZ2Xb5zRgtgxOyOX6PcsquL7FGTTRvgGt+iVdx0Z/DglcsusFlSRBLs6hqa1A==
X-Received: by 2002:a7b:c5c7:0:b0:427:ee01:ebf0 with SMTP id 5b1f17b1804b1-428e4714cfemr47246135e9.8.1722610186483;
        Fri, 02 Aug 2024 07:49:46 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e8ca:b31f:8686:afd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8ad475sm97561165e9.13.2024.08.02.07.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 07:49:46 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Nicolas Dichtel <nicolas.dichtel@6wind.com>,
  netdev@vger.kernel.org,  kernel-janitors@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tools: ynl: remove extraneous ; after statements
In-Reply-To: <20240802113436.448939-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Fri, 2 Aug 2024 12:34:36 +0100")
Date: Fri, 02 Aug 2024 15:45:56 +0100
Message-ID: <m2ed77nftn.fsf@gmail.com>
References: <20240802113436.448939-1-colin.i.king@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Ian King <colin.i.king@gmail.com> writes:

> There are a couple of statements with two following semicolons,
> replace these with just one semicolon.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

