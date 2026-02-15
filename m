Return-Path: <netdev+bounces-258806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJuKImpDkmlQsgEAu9opvQ
	(envelope-from <netdev+bounces-258806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:06:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5EB13FDAC
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952403029AE2
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB73283FDB;
	Sun, 15 Feb 2026 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DHv8+wQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92442050
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771193191; cv=none; b=ubsHDR5nQEE3jb9OnbpwWZq6f6QQo0dJGKKXUY1CO9UeXqKmnKs57XEtgssBygwtQO/G/KfeYHiZc+bTZ0ZeciLyoiSvNpk+FQxadp7AGcwa4F7GopRVdR0+FuEO2beETAJCTEiq4dLjoD1AnAzPslLMUW7d9HJBBNsU8GWrJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771193191; c=relaxed/simple;
	bh=U1AjVNwMu/te1d9My1Mfcw/XYWeECisqD2NJXnhTCK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpV5TTYTUgOfePqBrOZ/6CxK8Iep6+ku1kV+yCZL4BvTs3Q7LI0Fa3SAxUQbExOOs3ZmvdeOi2DpoB4ZCgfRTIMhbLjRtkg7iyF0u3pZ5L/QLJZkHiEH0FnsvFYYjwgAgg12FZ7qlSOpkivxWIZJZV8CT5EIwXPKkLsOezhzZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DHv8+wQj; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f053b7b90so1738023b6e.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771193189; x=1771797989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQsTkVXWNw2lGAiVrI25BUR4VE82mzfjXec+uQAYTEc=;
        b=DHv8+wQjKpG2B5M5TSYIfiCUFp3mFy6NE/24AuKH6GaWWLg2gX/RCeNWEopsbcLXqI
         JRZl/ehiacYrzekwpoaTuxK30ytRGB/Ph76U+FpF0tJdvAWN2OBlL8c000n/UEs7rVq/
         JCa+0KMj4paYKRVqchfEptVirETG5Fha9eH49CBjpf7tHXRJ1h/Hlx87aRc4+XkNBg0O
         zFyVVjneH9T2tRbGf2qXTwUtlwOXILUQUJ/8m0LnfdHm4KOEbB0j79ZhVh8QxbCf5OdK
         aeXJhIo+dh0+pXBhUmnHM6fzcfB8/tu591bAW3K8P2F9nCwRJKDmJmMwiWDTgoT0T52T
         gv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771193189; x=1771797989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQsTkVXWNw2lGAiVrI25BUR4VE82mzfjXec+uQAYTEc=;
        b=Ez0Nw82sXNP77nFGxbYd99RcDaPS6D6wzyfnGsTNvPBIvFxfhl/tjj0qohsTBDixz7
         HJ5zpqY77+txSJJzWqEtyaBTV67xIBtT8KIQkD21m6NAv/5wd2en+PgNf5VqNYdqgHBe
         spHIRg9mrfQksZmwI+sqFVCwKQtjJP3d8PZY2hqfN/+zKVb/8ZnwHvlozLT0eOT1cc58
         X+eLTlZCNkEiHrZP4YiWjxU4cJ2AwhWwAat8SsYDXxexl1apuvIEl6LNgeATNwVy9GPC
         ZGT2QfB/qEkDlULhrgVkL2zAgSCseT2wd9G4P7lyNEuQx6OmWT7Pv+tBouHSqhlkSlwQ
         pCyA==
X-Gm-Message-State: AOJu0YxX5yb1AtX9luRjKeEvAut8npjDDWYUd/Bcpvs3TlyqcW0e4Y+S
	sMEdSa5DKIPq8zUou559An8iwb6/+v5Zd2ag1hrJykzdarpRGpr9d6iDv61Gi50a2PU=
X-Gm-Gg: AZuq6aKv1DTj/XFwdInxUicLXLMqf+T6HGyAmSWPk4bQSYqHfDu8ygP9QsV7jyWhyao
	wHCwZa3oRIRRpqzyBYLT6Xe0kpNug0d6FbaH+BwSrY5NPM7KLlmZ0vzpYxjO0TmeYMibLd4PSyi
	yWPF1CZuFtSXY7iljIIdO9W/1BCO34RMd5JMoSYKRJx9YfkpFdNp+kipjLyXRf/2pwtQ6cW2Tmg
	vAL4uqmaOhDkNy+vQfakSZbd22YcXSwo0zpVU7apHyPhJdqk8mnuOQehGw00Ows7QnVaDPZ4q8S
	SIhZJ+CNI99RKjIzi6aSoxCEjjff6do72CuwDdftAWuhtE/+ISloaFkkfM0HW7X+YyushW3ZoBV
	KToERyjooQFkWnvBs7gn0dQyzrY3sS6q72Y/W/niRLl3W7o0nxtAadEiTvKkwXnJ2MAdO4tvHI6
	C+bbjZeElQsIYMofwra1nNSGlE8NjkshaUi4GSX276zrytT+UpvJ4wGOMg7o4jhoNmfgHKnP/YQ
	xtwX6U2Rg==
X-Received: by 2002:a05:6808:181d:b0:45e:e1e7:625d with SMTP id 5614622812f47-4639f235c46mr4158734b6e.54.1771193189584;
        Sun, 15 Feb 2026 14:06:29 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463c07225a6sm3149003b6e.18.2026.02.15.14.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 14:06:28 -0800 (PST)
Message-ID: <b9c6eea4-cc66-43ae-bf87-907b35db9c8e@kernel.dk>
Date: Sun, 15 Feb 2026 15:06:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.0] io_uring/query: return support for custom rx
 page size
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <2e8280467c93ead0c61ed3d68c036d6a0474bb78.1771188227.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2e8280467c93ead0c61ed3d68c036d6a0474bb78.1771188227.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: DF5EB13FDAC
X-Rspamd-Action: no action

On 2/15/26 2:34 PM, Pavel Begunkov wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index fc473af6feb4..6750c383a2ab 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -1090,6 +1090,14 @@ enum zcrx_reg_flags {
>  	ZCRX_REG_IMPORT	= 1,
>  };
>  
> +enum zcrx_features {
> +	/*
> +	 * The user can ask for the desired rx page size by passing the
> +	 * value in struct io_uring_zcrx_ifq_reg::rx_buf_len.
> +	 */
> +	ZCRX_FEATURE_RX_PAGE_SIZE	= 1 << 0,
> +};

Well I guess one comment - supposedly ->rx_buf_len is going to be added
in the future? Because right now it's not there.

-- 
Jens Axboe

