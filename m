Return-Path: <netdev+bounces-234917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE7C29D2D
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 02:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE073B4075
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 01:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53D283CB5;
	Mon,  3 Nov 2025 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNDKYXGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49727F166
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134669; cv=none; b=r+oXkIhgAQ5ccSCom5/e9jdIImpWQ5se8jKpUeuNf6PVwBfxlwu3G0Mo2gS1oYcNDVFH0dmwz91fVjP4AQkJTGSdJ6lDLENPdHeSjWqYzRm57lKZq9TtLo/FEhgC1aVQcB+ni4w4HVDJw7ea+yTrjwjbTWOhOFCqhbN55uzW9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134669; c=relaxed/simple;
	bh=WsMaVYjhEX5xzYsbLkIYbNUU/KAzYM8jBkJPwJqvx+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+1RNJzT2N86UispFxXgQX59V7SmPp3tziH/7rqZLFJrgRoPGUt256vWaCPxPESxL3TTkbd2t/cUxvyRY7OEDopBISGnYhe2YYq/3qgHZmlD02HXIJumdQc9iL6U/eWOMoHbHkhWtXLjSWYNqsq67XneffgqYeeOsJQW5TPZ+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNDKYXGF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so3802690a91.3
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 17:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134666; x=1762739466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys+iXshBYZnizwFhgQPeQbnnGsPPwsLlRfA8FiXKhyI=;
        b=TNDKYXGF1rZb/lUsBfw8QGVsaVNX5gI1ToRvqKZ4HRwWUkhIBGG5zO4+dUcsepfwVs
         Q0yeNvEH1K19ABcK47d/4nLeYKmV+BfWLZHlXnCIyio7zcggEcUkYFOrdBxPQ0ezdnIS
         P/7eGP0p0WgqsOq2pkZzUNwmzcpNeFTCjLwu9a4GIMN6+eAw8k/U4Ctx7zmmKNTkxqQu
         kgVxUCeYtfewt3FYD0xwb4oh7bgaUSxqEZUSQYKmF0RgINMFgvQYd6KRaAGmDY6JO4sn
         S2w4fZUmY1VVFRqdFrqiPFPaBQjZr3a7eoDtN3q5FEeX1u9PeXlMF1xwZoWQrlrKvLmg
         KyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134666; x=1762739466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys+iXshBYZnizwFhgQPeQbnnGsPPwsLlRfA8FiXKhyI=;
        b=gZG8OB02lW0Aqt6rNw30EywjYPMMD6t/+B2rjXqx0R4hN4wpOtPRwzfyvvSyf9dh4s
         BhQeYkQt52MdQgmG1zmFsbvGriC7wSQ+eu5x/nLp9nsvddzHrxeQr7/T6JQCl9ZZBrAc
         b9EHdBs3FEK/ED+n4ourXSxdr+5Oz/AmPh+qf5CHfNkjIWFvcZ5Yc3pJMLY0I0pTLT++
         5B+eknfCnWmCtpdgUDnVeHGEJU8gnPlvrtDJNEDYxV0i0E9mvwMyWGj9nxH/Us0Cv0ep
         9UPsZfG17UVA0QjPTVy3azXSHW7LOfxP8qqV/tE8+rc55VqMldWtUUE6FY3INidpIfKA
         TG2A==
X-Forwarded-Encrypted: i=1; AJvYcCU6ssH9yXEjhZckR229MmJF+VP0ROCqPXKFvf9/rAIn19nl/8tMVl9RA/stnma9Zy07l0mKZDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WcWK0OM4pJl3SjY1AEj6hphaQqtVKOoY3sezLJM3MoZi4KHA
	vaQLeNmcxBp7+UN194QxVE9bqi0vR+PyA+RUH0yoDTAEDGzb+2kExUZ5
X-Gm-Gg: ASbGncs/UAD8mvn8KV/sXavykQFb2yy6ctMypKAp56iQnWyAZ7OKvsrllownkhKxpK7
	yZ2dK+wjYnnOPhGawe7y2rTw8HOqMYdJ2xdJyuawcXtN5iRzfWGk592ebHuw/KicS2jLyW9jGRK
	66BgHBgSG/x5AAkhKkvnEotR+fW7hAPHlmpPqU7FfK/ljMyCIENp1RjcFguSsrhOgfzgTcahrDv
	erc4h4Quy3NXztdkolx6cJLCg4OjonOpkQH1U5S6FQ9IW3S3fif/Xkup2Y/w23dj00jq/TcuAPr
	8B/8wODoHbUnkQdARZQuLqRwp683HtLMf6VL9AFpMUZfjxKwh/lDIQ64OUpqGhH+rJq2lm9jBH/
	0/PjNxBfO74jc0sHnRuAXLHIsMCaXf/5I1NSTaQwTO1B18gSB/iPdBSgejcfHJHCwMfJEerIx78
	VkecuxpKlkQjHciU3Svu/4Hg==
X-Google-Smtp-Source: AGHT+IGWgVa6WHTDfT17DDH7arAJVN5amdUFhvm3NGYTyUI83zaE0YwI9XGN5/sUPrGGtBHIlkh23Q==
X-Received: by 2002:a17:90a:c2cc:b0:33b:d74b:179 with SMTP id 98e67ed59e1d1-3408308ccebmr12489063a91.27.1762134665741;
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bd9616c9sm8943505a12.23.2025.11.02.17.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D29634222E2E; Mon, 03 Nov 2025 08:50:58 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v3 1/9] Documentation: xfrm_device: Wrap iproute2 snippets in literal code block
Date: Mon,  3 Nov 2025 08:50:22 +0700
Message-ID: <20251103015029.17018-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=bagasdotme@gmail.com; h=from:subject; bh=WsMaVYjhEX5xzYsbLkIYbNUU/KAzYM8jBkJPwJqvx+Y=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnBVNS7fVNz35EfL+ofJHi+aUxa2XouZ4bHVdcOLnC 6byj9fOdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAif68wMnwK7GHTzox5mG8y 09ubc7Vt0IvMSR7+BT5hkm4r+5yXrWFkmHy/9rjHrIydYveX7nsZ+9MqaVNDpd6Sq/uS1r5LUNJ nZQAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

iproute2 snippets (ip x) are shown in long-running definition lists
instead. Format them as literal code blocks that do the semantic job
better.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 122204da0fff69..7a13075b5bf06a 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -34,7 +34,7 @@ Right now, there are two types of hardware offload that kernel supports.
 Userland access to the offload is typically through a system such as
 libreswan or KAME/raccoon, but the iproute2 'ip xfrm' command set can
 be handy when experimenting.  An example command might look something
-like this for crypto offload:
+like this for crypto offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
@@ -42,7 +42,7 @@ like this for crypto offload:
      sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp \
      offload dev eth4 dir in
 
-and for packet offload
+and for packet offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
-- 
An old man doll... just what I always wanted! - Clara


