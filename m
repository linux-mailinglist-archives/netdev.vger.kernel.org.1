Return-Path: <netdev+bounces-263635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB+ENNznp2mDlgAAu9opvQ
	(envelope-from <netdev+bounces-263635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:05:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07F1FC27F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6531313C7DC
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABF3845AD;
	Wed,  4 Mar 2026 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eff5y1/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E53914ED
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610801; cv=none; b=GWscGhPC+YEsKG+IxB70swo4vnLWATIvXe2S1bi7C7bMCpNd8flc176T5hFOCnLBK8ibzALSbnTkVGajfr+vFyNMNUounFS8jjXbbJi0grrqC/vQE0B7v38xBAA/U8EwDBx5unfGlDUGLUl3TTESLDnciIsqaV3e5ieR1QKwr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610801; c=relaxed/simple;
	bh=zJHPsWfDN8vhL0lXpTzuNlyk4zC+SXOHgJXn5YGKlds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDfnM1NIgR6i+wSgMjXw/+vf12HH2YMNOItH2caaB5U7v/GTe2I/fNd/gPLFoN/paLMsNt6wtcoieJTfnRQdPYzjLqdn3p7EM2z6qqtWb+R3VZQCe0rJh6VlITHm/RDbY8MhQDGkfDqu1IQ5pk9CIFBDjGP5DpPiOYT/PW1BkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eff5y1/c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso55023885e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610797; x=1773215597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KxuO5Rk7JZpEpUdLB/tVR1B3/xHR+F3Wb0f9SDpeYI=;
        b=eff5y1/c6m7XH1JN3yogWBC2SnoYxGkKWROBny8WT7hTdmrCiyKSNYFAwRoN1ktBzq
         VF3QXXnjoexsgWtwSgGixDNfhEgLktP/94Tim+aOdYIFi0QDZ9GGfvgB1aZcuK8sf005
         wXPlPAO4fH3xYoxb+z0yLUY8QFdZMLFRAKj18zAJGtQmnX9brebNz9N2w2ZbiAMaTFOw
         +akkhRhasxY0w5E6h/ESaaJIClwd4ylIL7ljRpDx5ba1WtA1Z/zpzmh3hK7vPETT1o6y
         FDfsLgZrR326OhMrVvZ3imlEs8kfq2k2eo3olOgcUy1NgOXv6iveVZca52+HyRSUavYN
         HRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610797; x=1773215597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KxuO5Rk7JZpEpUdLB/tVR1B3/xHR+F3Wb0f9SDpeYI=;
        b=uwJucB/gN9INNXq4z5mJWmH3ZJX6N8EMazdCE97k463vwWRc32HeN5i30k4BTlUkNC
         Qu9VZoeglShqSAX3CAFdMNLzQ24IUfeYofTxlz58eQQ1E2nNaZToYOcKGXcYJ0d4XvGa
         ZViV/JI4BdjusZO+j8XMAYvyKIeesuapvpu4FPUy0aCnbXRi8fbbiDYcftbUdEl0o4CH
         bdZfGxok4QxqEZ7qrtnLqDZfFZC8p0api2T4BbyU15Oyx545ECzqt9YUJqZk9BQyaiqp
         fPUXTtAiHTXrwQQglQjXqYoRP5rzYoxqoxLwyFS3PPybuyOHVhaM/RCZ3VvIQu4VGsJ4
         WNsw==
X-Forwarded-Encrypted: i=1; AJvYcCViw7PBBlDWjt61dqvEuSk3F8LHUMz+THTKjZLwreIK6ZlTmixXqgzwe+j+m35v2scuq3yS8qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYRwk2F+msdCLbNhALlSYWlSXKX9IVO5Tvt1dKGXwm5ywbOLx
	i3c434oJL6S4FnK5nPNgn2A7sGz+M8rGw5jP+dCOf2xNxdIxNetvWAA/
X-Gm-Gg: ATEYQzw5UOLzdl6ubz+mZgDDoZprzPPMOnqlEuEBNnD/yhhXnS7cj1jfRDzpd/9F4qJ
	eKbKFbLvdGkKq5PajSVNFK6h3qanFzW/Nby3EAVQCpBtO/mxSwptoTL2PBd4RBVxTwVzc7LpQ8u
	TQNYhwkr5XBGZ+Qa4d74OUmq6NOhuM/TpXeor96xwrRdBqtf3VvVHuF0CkIGjNdtP8ZHTOKbDAS
	PaU5utyKE4sVpzc4X/3W91xIqXWwy+ICZI1UaAmBXAt55fxm/cSy8M4J0CrsUD1R07E3zZkUZ3u
	RoGh2N9X271AHZSaZ90ciFPSvGx6BGRSgmd1rQD0LwxyXfQPlDxWKiaIOBLC+843oGlqcODzXvI
	ydsQhcuC1ttf9RHXkAvNkTZcWj/dtUiNupgsCjXwXjN8vGoRmXrHDThsQf5Mgk1AQQUEN6aGAf7
	kwRT9xDsBAQ00FiCfzOjbar1U5tyA/K2ObhfFAN5fMhrTDulyW95As3BQ1Bw==
X-Received: by 2002:a05:600c:3b29:b0:483:7980:4687 with SMTP id 5b1f17b1804b1-48519899381mr17703535e9.17.1772610797310;
        Tue, 03 Mar 2026 23:53:17 -0800 (PST)
Received: from [10.125.201.152] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851887fc54sm37182745e9.10.2026.03.03.23.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 23:53:16 -0800 (PST)
Message-ID: <8b501a1f-9c5e-4f3c-a136-277fc24af154@gmail.com>
Date: Wed, 4 Mar 2026 09:53:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5/core: Allocate ttc_params on heap
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: charlie910417@gmail.com, jserv@ccns.ncku.edu.tw, leon@kernel.org,
 mbloch@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 tariqt@nvidia.com
References: <20260226114219.2111793-1-yphbchou0911@gmail.com>
 <20260226174601.2120282-1-yphbchou0911@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260226174601.2120282-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4E07F1FC27F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263635-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ccns.ncku.edu.tw,kernel.org,nvidia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 26/02/2026 19:46, Cheng-Yang Chou wrote:
> The ttc_params structure is too large to be allocated on the stack,
> triggering warnings for exceeding the 1024-byte frame size limit.
> Consuming excessive stack space risks causing stack overflows.
> 
> Allocate the structure dynamically to maintain safe stack boundaries.
> 
> Signed-off-by: Po-Ying Chiu <charlie910417@gmail.com>
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> ---

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks.


