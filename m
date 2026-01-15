Return-Path: <netdev+bounces-250232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B195D256AA
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6EA230B2BB1
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09137F732;
	Thu, 15 Jan 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boiPMRI5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tBSrzjRB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA135503E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491437; cv=none; b=oOSq/VmdS/zCxlsvu9vHToJrm5cNv8XlweskEIW2FkAN7x0gped7IJmIkHgCyFA21U0gdDckMLqjn4WfVIzcoh2USnkFqtCoUNygMcJQDdrbywUDPAspgmIch0WUYpWHMT7VHtmLRbHjBFy/KbCwKMqBfQeOCisngLUgKK7xeJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491437; c=relaxed/simple;
	bh=XF28RqBi4SlwjxDLGtl+8Jh91wjCxXXEOaqjg2L/k84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJ9aNBMQ7vZpORsvsg/UloidYCGHCrxv9gZtol2TYFBEhiacMdnoeTVSh5L+ikBqm0jfydKX7XIj6u1zm7SNMOfxzppQPSof0SZBSayrTKvMZMrX8H3+tog8w/bC7Y8jK4XJq+DzWc5RwkwwJlrGN5m5APv0FhhrIhIAtxg2uMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boiPMRI5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tBSrzjRB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768491435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpXY7FmDacCa1GA7GmUw8ZF/Yt1FqaToqmro4+kI8Ro=;
	b=boiPMRI5ck6FPeYT4KZp31E21Wj196CrVXuGxdZEURizT/TdodaRyXceq5bg4dLjZlLMac
	nUu94F47QsbIbxrdPyaQKvTwqAwBujvfk/D598EsGzdm4hJwS5XpRVoaGIv3IiONFiUB92
	Jgu/TnAOQKWW0eMBW1BtM/9Ye0hW9OE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-Zx4UTpksOUeTqmI5tQEH1Q-1; Thu, 15 Jan 2026 10:37:13 -0500
X-MC-Unique: Zx4UTpksOUeTqmI5tQEH1Q-1
X-Mimecast-MFC-AGG-ID: Zx4UTpksOUeTqmI5tQEH1Q_1768491432
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d4029340aso9296545e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768491432; x=1769096232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpXY7FmDacCa1GA7GmUw8ZF/Yt1FqaToqmro4+kI8Ro=;
        b=tBSrzjRBXMbXr1E75zA1re2aVonmd6e1LSfu4gS7jIvXRHbnEG74BY3nYrh8KUhc2m
         N35QVaboXREXQkBvaDlnA8VBVbx24mLPQfl98Vosfmt5PDXzghj175zgAbz03OZXS5PG
         7AlD2J5wP2POKOktgfv89jGJlipcjKdWiZjzihAcK/H7IiaVbfZVw4zL0gbx/oxz0bAY
         3NQEslNUPiI9GG4KIJimAKnfFVYvXIsn+VNogfTRHkR/yz2EeHH4tF9ujFEr7mb7G8wa
         Enelq6sZa7Ay1fkk/delB2RUFcVCqs7R1orumdvT1QGzEg68WkEK7FHYxe+yl/hNmktX
         r4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491432; x=1769096232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpXY7FmDacCa1GA7GmUw8ZF/Yt1FqaToqmro4+kI8Ro=;
        b=X9NX6F1u+0KRQy0ZSe8tYFD+K43YNYYQf1Qojc3W54KEungFouU3QzINfwfFiwF1up
         C5R/9jYKiuXF/nLdI10ZOisUBRhf/2ZiZGjAsjTasezJiRhPA/XxcRMYBGZkCTeZjfPd
         gBe8KxX4whuCl4MNQreesxOdi2s3WBhTHZZ3pJETYTMS/Xb77+HDbdZITu9/MXjxZ/Eo
         jstshyGhCP/ayiXZd++oUpTn6SnbXPJEnA4WcMLZZcOQYmoBvc1Um5Dov0j4WMnjevqz
         GyYFN79ftV71RAeJ9UnnvXKARxFLR/45KOsMqEsmxdSdkcPwsv8clpjog4ze39Z9CLYb
         oBdA==
X-Forwarded-Encrypted: i=1; AJvYcCXT46C/yIk4M0nYoqbHrc8p06ExngaRlTA/y5Equ83xA3k37XZYf5aASAPQGZkgFRn3/aVIJlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQR5A3v3e7q0tmhjvVtmQ9Uy3Fnt+db5mhcHRdQbc9bRxAKBm5
	inXSenpeLySzQfVGnJKUmWI+ATU3OpOVH5d1O64qpTqdKZePqwA8OVL7Ypsky9P3DiyjAh7363g
	KTKJ59usaBJ886uOGmLjHteCDcJF+tSGe2BZiSvxtevqCn1M6jrePk8JaPw==
X-Gm-Gg: AY/fxX428mqN3jNDzefdkJUb9wnrk+I1uuEeUgE2rn40tRiGmQ/gBa3rKzMUzxA1od+
	Rg7m3pJabVEB+lcGx1aLr6HGIPvuJFiRWudKbgxKrOmWZZhmfbZm8mI4RzTGXw4XpccHBFP6Ceu
	bs+6GaJy4KodZdJnIWAySsO9R/yBPw2zObTkRohcuqjmRt6pzTsYvWiwB2W3NgAQU2XstlcTCFE
	deD7MUAYD63Rmxgh2xJI8BQ1G0oOyLWqQnlunQ0vRLZgSmSxE6+LLhuORVS8KfI9WBQZ+GGwAY3
	33bwnMcDTxDiytQrcjKPCsWwKaVH2l51vaPZIzl2hSw0Y51XxynN9g9lDOT8JJ0eCj6sHyh08YG
	0I9lKky0Pi/51Bw==
X-Received: by 2002:a05:600c:3504:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-4801e2a95fcmr2863795e9.0.1768491432443;
        Thu, 15 Jan 2026 07:37:12 -0800 (PST)
X-Received: by 2002:a05:600c:3504:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-4801e2a95fcmr2863485e9.0.1768491431977;
        Thu, 15 Jan 2026 07:37:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee2a5e48asm44798015e9.20.2026.01.15.07.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 07:37:11 -0800 (PST)
Message-ID: <a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
Date: Thu, 15 Jan 2026 16:37:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 davem@davemloft.net
References: <20260112150908.5815-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260112150908.5815-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 4:09 PM, Oliver Hartkopp wrote:
> This patch set aims to remove the unconventional skb headroom usage for
> CAN bus related skbuffs. To store the data for CAN specific use-cases
> unused space in CAN skbs is used, namely the inner protocol space for
> ethernet/IP encapsulation.

I don't like much that the CAN information are scattered in different
places (skb->hash and tunnel header section). Also it's unclear to me if
a can bus skb could end-up landing (even via completely
insane/intentionally evil configuration/setup) in a plain netdev interface.

In the such a case this solution will be problematic.

Could you please explain in details why the metadata_dst option has been
deemed unsuitable?!? I *think* something vaguely alike the following
would do?!?

---
diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 1fc2fb03ce3f..d6ee45631fea 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -13,6 +13,13 @@ enum metadata_type {
 	METADATA_HW_PORT_MUX,
 	METADATA_MACSEC,
 	METADATA_XFRM,
+	METADATA_CAN,
+};
+
+struct can_md_info {
+	int can_iif;
+	int len;
+	int uid;
 };

 struct hw_port_info {
@@ -38,6 +45,7 @@ struct metadata_dst {
 		struct hw_port_info	port_info;
 		struct macsec_info	macsec_info;
 		struct xfrm_md_info	xfrm_info;
+		struct can_md_info	can_info;
 	} u;
 };


