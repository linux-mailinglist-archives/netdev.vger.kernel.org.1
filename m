Return-Path: <netdev+bounces-210543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E613B13DD3
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C644189BA07
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B101F30CC;
	Mon, 28 Jul 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4FKqUpX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9ED1A254E
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714972; cv=none; b=B8nHeC0/3NwDvzuUIyI/NaLN+0zUt/tPUPuYn2wix3kLwmwOc6z4X1FE1iCcby0II39supoWXlwMOLWCzrPti1tAbB01KcDCoMp07q/+nJOBuHL3gmG8dYEK+K884g0/oYvjvALd+U8MzZBuT1ah77dTZpRjvxhKY8mbBPPHHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714972; c=relaxed/simple;
	bh=9V5uARInC5Q4yMpfHW+5tnasYIvRscaRNGAw8xedVIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgXSmrjeCAISqu1b3tJQk34ioTTLMjh47DMQGm53ApTZXEDmdxjBUchiOn+oOmtzZ3OCJ489SfjS/mWRTcYznUAzJvhwN5+MvYoX9nzZIP/uz9If/wyUwoP7qkUuMVmroe+ZGrnd15cK5UB+5uzMGhuNADyOLkwtCvWbpPLA4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4FKqUpX; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e3d0cba6a7so9997995ab.0
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753714970; x=1754319770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EsEznO+FXb+/Lati8gFZUTLgQlfu9JAplyIdwoqG48=;
        b=R4FKqUpXrn/1YESYUNORIl50xKbNALdLFn8zZ+Se2Nr1XCRJCvGJSvZboYaEfPkvkx
         sNuBcYnUJhIG/VS6uZ6RdWfwhs8Xp9KO+m+0q1knjO0lbN1WHy3ZNDTMsEGGdhHdomlA
         m4VUOkmko3lfdU0xdQkAlJJYpgaqqU0RfigzI0CWcsMxXHedMTbLQSKOWieA7cyONDh9
         4n+Eg56QS4+x3Fev/pN6GF8uuOqnfT/xyqyf+4JjurJcw1nYkbMPQYhYjFCC75vyzkjx
         O9hmM8nTvJ6EBRvPSgZGBAzIpjEF0VvjkqWOeQUaN0cRRdBR/4Po+QdDC1SnzdTY1t4d
         5UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753714970; x=1754319770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EsEznO+FXb+/Lati8gFZUTLgQlfu9JAplyIdwoqG48=;
        b=sXm4OIneGJ8IHCcy95mTSFyrWF/o+e05wcGvW8rvG8lP2OymDoTNhN1tTlBoIy9/lf
         ZWg/rm60u427VKzyrxR91PP0SAXuvbhewkX8wKM7P+ynoocw0LADrm/jTClHNGo5UNT4
         6tDXoSyiY35VQdonuthViKymEfleKgp5C/R2E9VHLbrD44zHnoJWqhZK5a/SmHXbGLqK
         gIEa3CJ0SoUlO0Fd0JZoefH8seTldtOVDX50sZ++egWzLUeoGMhn1o6S8ujbl0qewLYc
         XqQvNxpWUgWulkMxpIrZKIn/lz+jFLIlo03jfp5afTC35CaHXASgYZXQDvVMD1G91s/w
         Q+xg==
X-Forwarded-Encrypted: i=1; AJvYcCXpF6hqMbkcaTrF4HyzRbLBYjMagtIhAaNOMOs9Zgnc+xIXvejFFXaMDI6gy2BDobnhVKwmPjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4UHKwPFkkg6yXEaTuHhokZvZ+4jnlQ2DLYljrjXtNWpWFqyqD
	qH9xIkS908TJyxGUW1A+Sj904z6UEnli2RCS3o5HZGuMSDr7jdUyeEaN
X-Gm-Gg: ASbGnctScjxc6DxlRtAGrQiR4PIt/aYDGkw+D2FVDd+jHYH6ph41a24bVeLDm+FXJci
	Alg+gNLMr78vH2MFpV/2bUVphb3EpYmp4SOu2Gh3iHtpfqYbCamsjul6FkDG42yDTY/heBaJ2Bb
	aaeMQgxVYVxMX8pIyNo/k+VMEZ4oriRHafwvD+u2puFBYYkI2OifsFcqsoofZ8nGbLl+kWvx1Dl
	G8F2XMDyFJHgb1X1VVjWhsjksTkbZsx3rJ6geHgeqq2MZcMEjkgpubV0we3J1rsiqpzG8BJpgAj
	cfQY75pIwLEaTDkmZEsDNadIZ0YM+ZMrkXU3KgwWHJJ6LG0xN2bq4PhsgEKSSFc6MqAUD4fSrnS
	zKt86exZlXTsytz1VZN57TkCZKk/fG9WEIP8yuzDoAJJbYc33OgYrkPj+k2jjzMUbaF2NKxkgEX
	9XUMxo5ijefENX6lIYMqY=
X-Google-Smtp-Source: AGHT+IHsd23gzIELv8CuwdECj4cIRmoeu+0G2zWdyTxe/mqg0d/dXObes5bNcz4pOy0cMwhPutcHOQ==
X-Received: by 2002:a05:6e02:1789:b0:3e3:d63c:3a35 with SMTP id e9e14a558f8ab-3e3d63c3f36mr115626235ab.22.1753714964313;
        Mon, 28 Jul 2025 08:02:44 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:1122:1338:f1d4:15b5? ([2601:282:1e02:1040:1122:1338:f1d4:15b5])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3e3cacd77fesm26144255ab.46.2025.07.28.08.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:02:43 -0700 (PDT)
Message-ID: <a1e239c0-ee99-47c6-af63-c9fba3b903ca@gmail.com>
Date: Mon, 28 Jul 2025 09:02:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] devlink: Update uapi headers
To: Carolina Jubran <cjubran@nvidia.com>, stephen@networkplumber.org
Cc: Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250728140554.2175973-1-cjubran@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250728140554.2175973-1-cjubran@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/25 8:05 AM, Carolina Jubran wrote:
> Update devlink.h file up to kernel commit 1bbdb81a9836 ("devlink: Fix
> excessive stack usage in rate TC bandwidth parsing").
> 

This is doing more than just updating the uapi file. Please re-send with
an better subject line and description of the change.

Since it blocks my ability to sync headers using the normal process,
please re-send as soon as possible.



