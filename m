Return-Path: <netdev+bounces-262124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLCxF0Duomny8AQAu9opvQ
	(envelope-from <netdev+bounces-262124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:31:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B11C33D0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69EBC30292FD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792623EA87;
	Sat, 28 Feb 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="p0tZkj45"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136051F63D9
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772285499; cv=none; b=EkLh3fuQFlFfyANi+UYvvCUaJJx+ITwrzOj5EFUKCbpnykPwxpL1hCAnYMjADibOpBnuuU1LpvauNovzXPqaKO+JCxPbM0xTa2Wx1SF68M1ELmEngn8bVYNNK7DYvZ8ZdTO7owAvBdFxeT4FOUjzuJin5mEFNIVEOrRExzs9/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772285499; c=relaxed/simple;
	bh=3Q3yyKFfqXOwKJ/RByuaIz38UMKmlRV82Mq+qHpC40E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8x0JlqqtDmvpPU+LmfSxa6ZQFGoZqx33Afbm3oaiFvWc3mLz1+wRAB7L+WRgkyPQXxgpcRn5e/C1TQIQN4R4K9XzFwV12BY4eYJCVBgIMNfXwKWF+Z/QC8HqYwsdlv0tdBDtI7uyhytg9LhfoZ07ncxYFrr27KGl2xJ9wwp0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=p0tZkj45; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso19818835e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772285496; x=1772890296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ztFs+gCm7Ys6eM9DB05iXHZYDFLj2KUnU+IxnYtdgtk=;
        b=p0tZkj45Xq0OXmEjvx15mASiLMqu8RqPYLlsk7j3UGLdf7bXgGWpC/bhQPBQObrm9H
         /Ea2YckYaYQzmCoMsWKrcVeLyM4TVI+zh2Qg1A5IlxzJ6OnDjV7paYeYtKp1hy/JQR4k
         092Y2eIVB/DW5dWKkbEXAJmGkfMMAm5VvU+kR/7BYAmA85lWMZ32uABPTNcRVTesfF1c
         cORAi4c8vzfT7VjTf/q8YO7QgH1IafO94Lzi/vmQRtGPSkzgQuCvyEdOyck2FrYKnYzd
         FXexVN2oVuq9HSUdPCD2oiyBZPqSconIXLOpAYe9rtsBnvrOoWQiqckhz/U7V1l17zej
         cLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285496; x=1772890296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztFs+gCm7Ys6eM9DB05iXHZYDFLj2KUnU+IxnYtdgtk=;
        b=aT8O8PgZf7LuNlysF/onqrvLsYFM2G+wGxWYkNVXXZfqkFa+b+7p7Eg+MX+a24UrQR
         4HvZbaHhBNFZnNyDeiz3C/B1XQvxChVD+6N2nb0IFUfFTtcGi6FtVWvHt8KA9j57l/HW
         dL1M4vxsDW0JHlj2+Ly2BxhHwudnKupHc2K4GuaSqS18NnBOjNOYtAmzMgq4gG3uODFd
         4rqEf7hZTW877Lya+QPShhdj8pQu/lmUeNHiO71jSDNito6UIHXPzOsEPetk2yC5ZHEw
         OAKwk/V8w0QMuZ2BIPozqSxyVNx9pygZh+nRqSLUlia+XO38W5Q/vit3BqlqbH8lJoV8
         dj/w==
X-Forwarded-Encrypted: i=1; AJvYcCXn1NhFtXOkGrs31q+YdiIcp7uuK11UQbBHZ3BYNQa5AijFLEW4Jlcne5LlGc5jJLLvW2d89WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2o6LRk85dATebWbDXGxesEHOXmFIn/l72Hcq8C5T1iOiGhlXe
	jXLkOTV4TEWDRZ0Y8uVrvfM7MWWOAmeKcIASfpk1oK6Sc0D38WQv24rI/sQRRR9R5ts=
X-Gm-Gg: ATEYQzzmjGeQAjVoOXKw/yn50655AlVgyLMsEWvhaDkMwjTHdPn16G45Refu5tW9SZp
	Rn+LRb5Qj+pHG8nCxMD7sEJI7QLdzHPQHCuBJMUMGnpyWJLnXV38VsI2msVNU/cJzOaoQwGgwMv
	ZJHcVcDxakc6k34CVoXprRgqR44QgofjGRNoULYFLngASzaNoksj/gdpwlDRvwoW0ViDYaDIiTO
	Q4YTv/0fwENQkNg2HjoesIbR5VPgIqVDMOdinNcvVugLu1J06F3nud21eoxqhS1uoA6EGpTO2Sd
	DS+Za4B6mOHFy9oYXd08rIylrMZ1r0/HdshaB6hkFFMIMoZ0oGO5MUnU5C36GmSSx8GAl5D3p37
	UqV19LDcS56yuUKi/zBmCP0IdmgWF1tNBwAkT6uzALq/vBDcvKQMp89gaaQPJhEhzDBnW+Yc+6A
	81qzAAeWP3PnTfjb07J+4EmQ5dvOd5DA==
X-Received: by 2002:a05:600c:4256:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-483c3192683mr110413305e9.0.1772285495739;
        Sat, 28 Feb 2026 05:31:35 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b7713csm155767645e9.11.2026.02.28.05.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 05:31:35 -0800 (PST)
Message-ID: <6201770d-82bb-4b51-ac12-11156c5004b5@tuxon.dev>
Date: Sat, 28 Feb 2026 15:31:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] net: cadence: macb: enable EEE for
 Mobileye EyeQ5
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
 theo.lebrun@bootlin.com, phil@raspberrypi.com
References: <20260227150610.242215-1-nb@tipi-net.de>
 <20260227150610.242215-6-nb@tipi-net.de>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260227150610.242215-6-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,tipi-net.de:email,tuxon.dev:mid,tuxon.dev:dkim,tuxon.dev:email]
X-Rspamd-Queue-Id: B66B11C33D0
X-Rspamd-Action: no action



On 2/27/26 17:06, Nicolai Buchwitz wrote:
> Set MACB_CAPS_EEE for the Mobileye EyeQ5 GEM instance. EEE has been
> verified on EyeQ5 hardware using a loopback setup with ethtool
> --show-eee confirming EEE active on both ends at 100baseT/Full and
> 1000baseT/Full.
> 
> Tested-by: Théo Lebrun<theo.lebrun@bootlin.com>
> Signed-off-by: Nicolai Buchwitz<nb@tipi-net.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

