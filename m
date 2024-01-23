Return-Path: <netdev+bounces-64970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B5838964
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 09:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BE4282D1F
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D85647B;
	Tue, 23 Jan 2024 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhzaqwCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B500524D3;
	Tue, 23 Jan 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999561; cv=none; b=WaR4OMBJtQcjrSzsPJ/f5yj4uKxTkr1z8TRaxPsvNa2qi+BTTSBntpDTJ9gjQZrIUSdHg3WJ1Wo8WhGz3A5azlpKknwfGkliPYejYHWgdVAVKamrB3ota6tYfCjgFMRUSehKNVkcG5lMOziw6Zhvsm6LguqcYAKVJ0WfZstNfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999561; c=relaxed/simple;
	bh=D6kFih88yvMnBk9zA9dsUoEgzAg0hzTFRkDJKVgFzw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq4dfhD8TK4pzBgaVa5ppAQE8WgEI6PrnAM910X9QCTubdbCOyEINcqu/R3au3x3kbh3oXdTvgp7CdIhZGvnPDojKBSTQakVVCQ2BdWYCvhYv5w0LBQC6nvqE9BL9Esv+pdRUCxfDuuuHdzthUQNyFALk0VpXMi/nYeIRvo09fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhzaqwCz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cde7afa1d7so1907522a12.1;
        Tue, 23 Jan 2024 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705999559; x=1706604359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQRv4fqGuefJZzCa/VEJBQ7RQhXLXMbvCA1HYRXseVw=;
        b=AhzaqwCzfWVJBYoruPhEviT6kyCEvNX63pA686Jq/wSUHtRnUA+tjVZtHA55tu365y
         HF3d/MMPS/+kUqLEtKaVYzfXLEzNNvK0aW2ucVuJ0WeX/UOadzBZv1kkXWmLlHK3Nha7
         acJC2JLh6LZdXFkjg5YCYFOWZF+XtMJYJA+P2m5Ly9qv0/0/zYfDzgH2HpjlwGeVOYhr
         A72czGX42/gWY3QYUmFjK4jjvUR453MQXvuiofpHTusLSWLeW+pn62ZdFGibgbAshq0h
         yiZX1ziZYm1f/WW9JY26rROqbgvWmOhd0TJxHYsYyp+I75VUJwvo4AFCxBBMwy6Rfns6
         1aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705999559; x=1706604359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQRv4fqGuefJZzCa/VEJBQ7RQhXLXMbvCA1HYRXseVw=;
        b=FUOkC+8dtyKdFkCmLdhwLlrUJ5Kr9uTfFAPopgAIQ11+1bE84kxdaQJy3fpO9s2QpD
         dVJMm545O3qVk29Tk51weMDhRJAP3NGZxPhhQpneBxkqjqLGaI2mbUeKJLkGNKTWo0Fh
         qq7q3Epon2I+9FlDZDMJmpaqITqo242LyVX6gpbKLtkpIgXHBoZZc1EZpJ39uR244cx+
         v1RuUZecUMW9O1mv6cbm09zWrXIZVCL7JQb2PIXpRR7qUJ1z7zasE87ixhYQzUTghkdM
         6O/IBWy5hvslkIqoYJDdl/RPh2uybodoLwGdX6t45I0kUxHAiS5L1A/3FzHzBsEmnk0k
         exEg==
X-Gm-Message-State: AOJu0YwlJ530ym36eSKRZupBxrO3erzfgXAqiPB9XMEbj8IwNF/nKOoF
	HSlnLZDvuu67YYWjCdGtVK4ey+vEG4gIq9j7T8Jrc0t9EhIu0HYv
X-Google-Smtp-Source: AGHT+IEEdgziwXWLFKlvhKXvh1U2LmbCMN8LgpGqzcf3imoIwChjsBkGSUY1XTFmEj5sXRtkUCbflw==
X-Received: by 2002:a17:90a:db43:b0:290:9d34:c897 with SMTP id u3-20020a17090adb4300b002909d34c897mr1486452pjx.98.1705999559224;
        Tue, 23 Jan 2024 00:45:59 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id sl7-20020a17090b2e0700b0028bbf4c0264sm11142553pjb.10.2024.01.23.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:45:58 -0800 (PST)
Date: Tue, 23 Jan 2024 16:45:55 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <Za98C_rCH8iO_yaK@Laptop-X1>
References: <20240122091612.3f1a3e3d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122091612.3f1a3e3d@kernel.org>

On Mon, Jan 22, 2024 at 09:16:12AM -0800, Jakub Kicinski wrote:
> Hi,
> 
> net-next is open again, and accepting changes for v6.9.
> 
> Over the merge window I spent some time stringing together selftest
> runner for netdev: https://netdev.bots.linux.dev/status.html
> It is now connected to patchwork, meaning there should be a check
> posted to each patch indicating whether selftests have passed or not.

Cool! Does it group a couple of patches together and run the tests or
run for each patch separately?

> 
> If you authored any net or drivers/net selftests, please look around
> and see if they are passing. If not - send patches or LMK what I need
> to do to make them pass on the runner.. Make sure to scroll down to 
> the "Not reporting to patchwork" section.

Yes, this could push the selftest authors help checking all the failures.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20240122090544.1202880-1-liuhangbin@gmail.com/

Thanks
Hangbin

