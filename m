Return-Path: <netdev+bounces-260241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAtDE37VnGkJLAQAu9opvQ
	(envelope-from <netdev+bounces-260241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:32:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD9417E642
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B093091CB4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C6737B3EC;
	Mon, 23 Feb 2026 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlj6Xwxq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51978379998
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885831; cv=none; b=DjBWQH5En0h/74OEgrSzpFhoGxJur9h+iJQT6DSMrKsNqgP4p1CTQRjUhy1ITBABkE3nf6SyNHwCFpWA/MqIbLftMGvvX1TuGu4atXL5H0BeatXzxfFOv1V8y1n1S+3tG0q5ImmC/LGz1UGkQ6YqRjKq44JC54b+CMWdpkZmsPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885831; c=relaxed/simple;
	bh=0VlpHhi2y0rFrqGJFDQ/NBjLnbFM+sKGKyZTVcdakcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lI5DkqiuLIIUW4FiMDjJNJRDlxZn2g0XrIJpyciBzmwmFwmhDV8sVb8357nbM18t2cGupeCL6whZ8uebpTRlZKm5HUSsf+U3OCKx9Z7LnDxLwExiU6faETreYoivOE11pP8UUORWY/FR7dwZ0aG0XSC+1Thq9SdtvWtvf2SMK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlj6Xwxq; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2bd8097c709so1046635eec.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771885829; x=1772490629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8EgsQhmVSW7VwtA3nRSTOdrTq9lGaEIsGf7EwqHv3s=;
        b=Dlj6XwxquirOSuGR8DuOQNjUn1ckIssQsszVi8eCREhbOFeTkq1qt3PRy5BMUscYR1
         pMU/JgLVTjPax935qASvp0uRDsW/XLwbAteiEYovs7emoP7u4wzE+b5dxIAf2MJhYQXq
         bc/hYEPJZx4dqQ0jQf/PKlXja2GHcO2IrbKYqTQloaIhfhvfcQIt0LLhQ6lMpExIHs//
         oWQG7VofxjB+hCx4W6ge5tjpaAKpHlsjJervGGBRT0ZA8F+b7QmlzfCRpJCx92Q9cbz1
         pJ7FnrEFlM1CkoE3qqCnwuztN/8R7b9KB7WGzWV7Bl/ZiLQce/EthkFc3KDv4Yq5oucV
         jbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885829; x=1772490629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8EgsQhmVSW7VwtA3nRSTOdrTq9lGaEIsGf7EwqHv3s=;
        b=RkYy0/0OnoY6ayB6fVmfuBK7PDEeA1j8gUzVkwvd+iFjnbtc97OOylh9/VFH9JE8pH
         K/+ZQlJq0KnwF9ZZGtdoo3aekTfv+cRlELBDHSiL4Aa7daP1S9DaVqz7VEhFlIv6W64c
         9fa6GIa1I/ke9nUom94nTRuMyCAHeJyPaPxG2EM2WEzrZwxaibj8FsF6s6p/NHo5WHeS
         4ZXsZqlmMMCZtGbsw36RM80y8pD442PRQ7uFhJG9/b81KH1lzYey4LN6ro61kcb9dbrL
         k5WmBVCm80xjai0kI+K0hPba9aKQx6coeK2hv45ef0d7vDg+rXMhhwNFG8A7eNmjXZ/6
         ETXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGpunhRxhVh6jvGURlqn867nRbTjvPlTROA72M0pw6YU/MY6dg1s6UwjoEID0U75YVFXV5gR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyX5sX/dgnD2dvR9FTy+cZfLnvdE+W3z2iaEIpQmzlRcS2COH
	iLUz8ZiXVER0wphKuImCK/OrW3w7ibdQMZeHiUcb0LpwFKYcRpukfrAKkkX+mz1D
X-Gm-Gg: ATEYQzwBas7y1Y9ngd5xWxLB9HA4PZqVPJ/579v8wpn6dyHkbrVnPsRBJ51zA+2nuQl
	MVG2RGNGoCXHSVjISwritoK3VEJ+JhQn3q4ye/VVuOKvAuNCCz0HHHW7FnWVRa6yQBs6wjo6mjD
	8bS98hadOxlTLBT/fhdVlkkr73bQA1FGOgA4tX6YzdNFDwUKtqyNkGtYkTh+PmPPychx41YwhgQ
	kKjjqceVOAYRLj1DqyB45Agi02JDCZkEqt9xg8G12duBBbUw4ylo/EisgAjNO4w9CHUQrxwISJR
	hMJxiwLaYu11QTntTCldjqwD0KqUXygNUXdJP20rZBnL3FQQU2pp53rAUjARCxYDLDoPCBXyODL
	1FJmivYKG1jxjHdwXcFjloAWh1T8uDYpg9gNnVSt0AyF/CX+TI86RuHq4z5IEWHG1Q+31sntPSv
	rMUt8Q3sPLyrY4T9SzA6THQ8lh7iQufr/POBzQOJqz+FZBnejJVlNQ+ShQEiptM+JoH/1UL7TFz
	PW4gFZ0zVUkqUVCVTynIZscY6/uF2dgGgSgoc6Arf4D1EMEo6Sff4sB9QDqJYtmNf7t8E7UJ059
	THL4FXKQDmdST+8=
X-Received: by 2002:a05:693c:2d8b:b0:2ae:55ac:3ff6 with SMTP id 5a478bee46e88-2bd7bb52054mr4224221eec.1.1771885829332;
        Mon, 23 Feb 2026 14:30:29 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:b343:b0de:3e59:4e65? ([2a00:79e0:2e7c:8:b343:b0de:3e59:4e65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe82d3sm6307740eec.21.2026.02.23.14.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 14:30:27 -0800 (PST)
Message-ID: <ef9ba34e-49dd-445e-89df-8a8e6af0fc87@gmail.com>
Date: Mon, 23 Feb 2026 14:30:26 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/62] bnxt_en: Make bnxt_resume() easier to analyze
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
 netdev@vger.kernel.org
References: <20260223214950.2153735-1-bvanassche@acm.org>
 <20260223214950.2153735-18-bvanassche@acm.org>
 <20260223142344.62457ab3@kernel.org> <20260223142448.6f59bc7d@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20260223142448.6f59bc7d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartvanassche@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailroute.net:url,migadu.com:url]
X-Rspamd-Queue-Id: 9CD9417E642
X-Rspamd-Action: no action

On 2/23/26 2:24 PM, Jakub Kicinski wrote:
> Oh, not 13, 5, you already spammed us 3 times with this. Sigh.

Sorry for the spam. I have not yet found an SMTP server that can post
the entire patch series without reporting an error message halfway.

smtpauth.mailroute.net reported "quota exceeded" while
smtp.migadu.com reported "4.7.1 Error: too many recipients from 
2a00:79e0:2e7c:8:b343:b0de:3e59:4e65".

Bart.



