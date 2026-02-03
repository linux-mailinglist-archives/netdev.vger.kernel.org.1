Return-Path: <netdev+bounces-256441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNnkOGhDgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:50:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E6DDD84
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAB923011117
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03226738B;
	Tue,  3 Feb 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="U5Qb4Uzy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CE1F471F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144493; cv=none; b=EhPDSd9huOvJMygkIaAlFpfVvnA8jD+Q9OBRGQCc+rkrhiP2rpb/iEMKZPn9GEePpJE65xuUFbrvysh12RBstNKkwhaOQ2N8PyYqIsQc33nqVQN+mg1E7MfmNH0gT8Khqfosv/tIDcnmMfHWgMQOAhsDobmIYarHAYPe4L2bcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144493; c=relaxed/simple;
	bh=0ZkS/2V7FPAWDAK6Lzd7Dzyu4NHZhHfR6598dZr3Uds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CMGWR52kVho/4rWhatS9FCYaR/ky0kUeO+icxrol3vHMTZ7xI471vJee90x6taXah3/OId5YmWGIIHkRDkVsJdfazTneLG2rHNZfG7k3uzbetCi6jkS75lmLMjVeBDtFIJesHJ0/NFfwekzSSaNssSA8hKyhl3HR9fK2fSe8M6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=U5Qb4Uzy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806bf03573so29748055e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1770144490; x=1770749290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gT8iugg3DypdsymaapbZQnPM7bd63J+XzwPfRkwzGAw=;
        b=U5Qb4Uzyvi605Vf8zBDOA8iIlymqiwPq4vuSTHgMmhrqrqfUByLgMTkLVIwzs1EeTq
         J9f6hPJMWsBEFWn+IVG9jCEzmnB2XWC8H9DE7bBguYyChycZrunD3oIoPoeS3jFRmqfs
         q+PFvaZQXexiD36QzfutjDsdKj2/XZlQvA9UODzjPqh1adviJ6rCyw00E8qa92e3rmoN
         Ar851tCqcuqAwxmmK/5jukDeLFKEGfdhTkWfmj4vaSuxQRiDzcJRoBE8IYfaA0OECKxH
         h4ih2RySTUn9fcFjlLITIhaM0DGbWI4m9UaA4e+jVcnh5z0EEoOqQyNux4aiy3kf17rz
         Ew2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144490; x=1770749290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gT8iugg3DypdsymaapbZQnPM7bd63J+XzwPfRkwzGAw=;
        b=o8HyDFP3pagHVVL8RJtjHFmrhPrJblgtWus/OIEkIFpKhUoI2di6yDEJ2vfQj5C56j
         Uf/amk1qEbwTH/yxxiS16R4mI9AlIlHdO4Rti9Do64CQPU7TrDyVEgroWseQik1qzwwe
         DR0X7Ls1Iyw663W4kSTi5qCEXNtoLV5nIGNinHwBXd7EW++cGjbnxBSsXDB23JQMFKHY
         4J7u3Jf2HDCC0o011IjkGXov6yZiHHdOvNRlW3OzUp2Sq/DLB0VOVn/wrpJZ3AkuQ+DB
         bQt3ee+TEfk0o88T2AVcqBoHgBPnYLT6ShsJI/JhYceD3+rPwTTKxhV7P6ycpfBwGkiZ
         SAng==
X-Forwarded-Encrypted: i=1; AJvYcCVGQCU5GZlMvsWEI0VSarqSjAxZ4I0aZznVzUoep0T0dfB4I/mNURKzqD4kS7t3sjBOlALcQmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTd+wA/NsRZMMOl+Z/EgkIH8gN1FgGVhZkSQc4H6QTN7C2drpG
	718qyBF5zOj2wwYnc3y1DCLaZhffiePxa9YZ1kv9N6lI8SQ7V8ogstlN07/T1ic3IYA=
X-Gm-Gg: AZuq6aLRkOpJgS9KTzmNJ/HF+/N1IjkRQ1HsPeZxQJ4hd94JQw7aK+QAiI72eZcRe5U
	JoxQwVPevdqRzojPkjaNLdik46PXNr0A4POdJoEG7N44qKTc+hPCQAw4w6/6ZYK1uX0vsz9twBi
	lAl1W4PcKmokmUGyH/QTmHLcqfTTBFNbu7KGbNloYw4gCjqOkBXmM8RECqdcrmv+bJfNHiU7qcj
	ksqr6uXFEL4Kz6VPpvsTHKFyvSYxBK9kN+wFpTmBEYBPB/Cs51pCfrGsIbssggQyGMAHhCB73Q9
	CK8LSWJor2lcGWafFWoiWqquOS9bNVGo1lQVe/5L6tKvCHkQBZyyXRFDa5epToggBz0BUnjtqbf
	MX3d/G9ZbeyZ9KDtNoS8Lo0sTk5MnXDocpZGs24Ie/plUeW3I9I78JTV9i6Dg+qFSiMoXH9Qn9c
	Zvawr7JjKjmJBYP6nZ8yEVMnkY0cL55EWvFqXLZ1xf2RgY2FgRt1wD
X-Received: by 2002:a05:600c:1f93:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-4830e94e543mr8295085e9.14.1770144489805;
        Tue, 03 Feb 2026 10:48:09 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830512e0edsm85320555e9.7.2026.02.03.10.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 10:48:09 -0800 (PST)
Message-ID: <2ce5f52b-faa3-4d5e-afc7-08544bd8e241@blackwall.org>
Date: Tue, 3 Feb 2026 20:48:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] bonding: only set speed/duplex to unknown, if
 getting speed failed
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Weiping Pan <wpan@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260203141153.51581-1-tbogendoerfer@suse.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260203141153.51581-1-tbogendoerfer@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	TAGGED_FROM(0.00)[bounces-256441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid]
X-Rspamd-Queue-Id: 050E6DDD84
X-Rspamd-Action: no action

On 03/02/2026 16:11, Thomas Bogendoerfer wrote:
> bond_update_speed_duplex() first set speed/duplex to unknown and
> then asks slave driver for current speed/duplex. Since getting
> speed/duplex might take longer there is a race, where this false state
> is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
>   update port speed when getting bond speed") this race gets more visible,
> if user space is calling ethtool on a regular base.
> 
> Fix this by only setting speed/duplex to unknown, if link speed is
> really unknown/unusable.
> 
> Fixes: 98f41f694f46 ("bonding:update speed/duplex for NETDEV_CHANGE")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
> v2: corrected fixes tag
> v1: https://lore.kernel.org/all/20260130111904.144024-1-tbogendoerfer@suse.de/
> 
>   drivers/net/bonding/bond_main.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 

Please CC all people who were involved in the previous patch version review.
Looks good to me,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


