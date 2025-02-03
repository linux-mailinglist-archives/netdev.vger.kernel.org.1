Return-Path: <netdev+bounces-162233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1BA2649D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F46A7A1E6B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255B20E6E7;
	Mon,  3 Feb 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3PQHQYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD420E02F
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738614912; cv=none; b=FWaXsVrzjIeS70z0FZihoil22ux/2qtqVqM81n7MX4MC8thylh/I6B9JBnUYyXm5QFP/O8bTmissZ4pX+j/xBltVzDj8pQMGijCerEbRBJ7F/ExBeXHqEG6ZgOu0Q9dZsqP0D3eWqcIyEIgE5L0GVl2UivinViMN33w3ynPcV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738614912; c=relaxed/simple;
	bh=zftbiS8Hfywf0TfWipInZ0lxKQgQqcHCaFGIYn3ViCE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=lNNnQJ4SvRkU1mPiwJqSvwdlM2soio0xxABZEhkyCGe3sq/GRbc9GFKWs4DzAmWxjYRv3envnT559bQVgf0DcmxITV07zid+kXFrFAW4PpcXdzuxlqr9PQuun4uPBEBi0KupoogxgjRuT7iuWlpfuQ9IFYbWgsiz/qfMWIwatCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3PQHQYh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5db6890b64eso9339968a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738614909; x=1739219709; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/q+jS0s3IQVWHRvBVw/r26vnYUdHi6TkFumGF6Z9Yo=;
        b=m3PQHQYhc7wJyl6l28pEwDW9f6uJk6O4qFsqtROmKCs8yHedztTysqmVfpdC9SUnmG
         WH+YlNsCEbmdfZwx1fl7k/1J5QBnhQbqfhGbvh1Ob7c/laJT2lgayYU4pQYhxJnmJR4l
         l0od7zLbf1mupZhY0EOBgxZOVpR2X3r7SjdZiZ9W8OTlmbO6XvQJwvWr9GsoHx7okhXX
         7NLe9Vr+KE8K93zxA5qkrv6vAnkPb8DQAOqtuaGWm1P7KPfKtWOpXpnlrCkz6Pg5ba13
         ehgdb/obyOpvl/uEYCn8lveIrkL6BqjcE1OKp0YQY/7fvFhmE+85Svjwlw5H9pqWcoko
         916g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738614909; x=1739219709;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/q+jS0s3IQVWHRvBVw/r26vnYUdHi6TkFumGF6Z9Yo=;
        b=XTyVikYKRbHf0IGDf1yPIWPp/gQvn6s+ra5IV+aLXMXcYqkgIfwl8aqWpAjnAYBu1R
         i43rTUkBJ7cR3qSd2CwRZbgNGvkpiwR6HnGXtPPjsVBHWQzhppTyEAwwiNc1I3Bc4K6L
         CbiJBxCJrrqLqC/7CZbih42FXirdk+Of7yQ14IdUkCCYPv3Ck5R7oGmFPpzxeWZG4GcJ
         rjRwKTavws4Bwvw2bAnuVF4cetzyLqtTD6nmqy34qjyTy22RaOnaO8t8Pspgn6CKIZUj
         ezQxPbWhEaq/yvixmp81RdA/QdbJdWVgFvI1YSJmQC9WXRHXOomeT0/yelsts8GdQ/YZ
         SjQQ==
X-Gm-Message-State: AOJu0YxeOhdD4pNla0rSfzEswsDP9EVXttIKpWqmdNRzeFEwgydw5PBA
	Zt5Dy21rv1ApKIl2x34/egz0tDKKKrEu1LH9iWb16bEDdbCff6q70xYS78K+
X-Gm-Gg: ASbGncsAvePtKWTzKZDWDPlI3wsvU70jAz1TPaEQZyCUG/JfNHvWiDRMdoyzi97uMXJ
	7KntuP4iQVSvzCS3CZGs6hv90gUY1yCP59CGo8ziDFfQeMBrsdhn8mOGTNax7Z3EYMsjb2JNP10
	cXqULPiQSkw5N/kwtvnCObwJWi6gJlFjZkI88k7wJ6UuEbChoECoNIsb5/j3ZVMP/OLaxcLF58G
	Y+Kls0xy1t/nHf0v+waT+/+e1FQ+MjHr3QGJ7AL1CfxSCl4xxOD2cM5ZUXqaPPfE4mHWUZ48h8D
	jSoMuAx5lMG7Gj8HrdWb+d0CW+97tiI+wKZx/jWG5+P8EPXudsUXjG/HhCBo19hZPDeWZmRzQf7
	vuso9N0foysHn3ZQmWCS1PhYLiykIFXflu3PFMIDs1+29CpEIdzHiOtGRIzV/qIi2vT0allcvd2
	maQkotBS8=
X-Google-Smtp-Source: AGHT+IFEzKXfra1PqYt2xesNzUI+TuPFJ6Nl1AW8sAI//WQNvn2KCBTfTpIQSIqgVdeUqjJeHa0KzA==
X-Received: by 2002:a17:907:72c1:b0:aa6:ab70:4a78 with SMTP id a640c23a62f3a-ab6cfda4254mr3078972866b.37.1738614909086;
        Mon, 03 Feb 2025 12:35:09 -0800 (PST)
Received: from ?IPV6:2a02:3100:ac6d:8e00:811e:2e8d:e68f:ec04? (dynamic-2a02-3100-ac6d-8e00-811e-2e8d-e68f-ec04.310.pool.telefonica.de. [2a02:3100:ac6d:8e00:811e:2e8d:e68f:ec04])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab6e4a59862sm814238466b.178.2025.02.03.12.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 12:35:08 -0800 (PST)
Message-ID: <d29f0cdb-32bf-435f-b59d-dc96bca1e3ab@gmail.com>
Date: Mon, 3 Feb 2025 21:35:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: make Kconfig option for LED support
 user-visible
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make config option R8169_LEDS user-visible, so that users can remove
support if not needed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 8a8ea51c6..fe136f615 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -114,7 +114,8 @@ config R8169
 	  will be called r8169.  This is recommended.
 
 config R8169_LEDS
-	def_bool R8169 && LEDS_TRIGGER_NETDEV
+	bool "Support for controlling the NIC LEDs"
+	depends on R8169 && LEDS_TRIGGER_NETDEV
 	depends on !(R8169=y && LEDS_CLASS=m)
 	help
 	  Optional support for controlling the NIC LED's with the netdev
-- 
2.48.1




