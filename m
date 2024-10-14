Return-Path: <netdev+bounces-135137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C299C6E3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15F41C2321F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D915B111;
	Mon, 14 Oct 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4WN9/Gi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AA158D6A;
	Mon, 14 Oct 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900638; cv=none; b=R8VdjcxUrWoAsw5sKzK0NlkL9t+cFSlQHto9GUVV5Hnoqyk6A1deHoGAjX3qCzgKkCZgXxcp5Cgrmh/ityuK7ehWfaFwwjgcI+fa+ekktrpQYsjqQLWmM+mVlSOo1jepK1Vq9uP0HDigJG6UXDT0Tjn98Vy25G2wqv9Vj/vYMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900638; c=relaxed/simple;
	bh=bzdp1yBdRjDhQjgFwaq1csTPqxCzv1szUiX6Wwo3b1Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gK//ZHHBlacaYLpVunTk5VnfymYkRCzTQ+YYvZv4fUXySN2R85RfPmpr11HKBct9VTVG+KbPw4LFLPyBYNNDkywE0R43TU8NQEr8xeZ91M2Ju4YPuqAiQTJMsSa1MBe+iAH5fTRU6XkSNmK/c73RXvVrSBH7ojlJxTr0F1uTxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4WN9/Gi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4311c575172so29583805e9.2;
        Mon, 14 Oct 2024 03:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728900635; x=1729505435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/jtJHpZ3TCFw6NZzPBRH9fN0A2Zm4v391WyqXi8gbM=;
        b=h4WN9/GiOzQdyA7SGoG7SUjHWPIREWzOPtWKv7FBb/8pKNzGmLzzVUczITUJibAWMO
         SQ+x9Bni522I+MddMrWIQK/n8Hu5pzGeM0eY+UbcWSOalJyLRfluThLhc9u4zlQWD7XL
         qsQ9csKplur7AzRigjHYtxt24omIrAPxkY0uVCv/hEbYrD6vw9ywm/HUOzE4StWgnlpr
         2pxX8hK3U/fC5sBgjrpU+nF31uQt1E9hy6CpjCy5M3jFvHvKgIo8iYpRUsziiZGJSkYu
         PBq/IV0Q5suaH3jUff9dJBCTPDaxWzSwx7AszSUEmHvT9+eeA40LCz+HdQCkWglOiZok
         +M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900635; x=1729505435;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/jtJHpZ3TCFw6NZzPBRH9fN0A2Zm4v391WyqXi8gbM=;
        b=cE4nvSrCyA856RiNbqPDlTDz5j5y01vTCoO+sxa8pmwGE48lqMeOKkEFX6JqkPB72E
         I1qAGudxKEecDdX1d93maUaT0xhZCt+N0mUuwwK2K+ulGvs7ND6Ox0dq0KRZDbJk6ZSM
         lm1nno9p8ESUBMMLhLYCqNyU6rWcEDJNyhAMSHqJ0HXqWb3+7YnDNt+EtdB5j0qVjg3w
         IB5iz9iwQLc6FVJktExlnxfcQNdQb9hmjnjF7lkU3x6wJbX5MmKzk6SEmMtlXjzhnpsF
         Paw6IlSeEpo7JmoVQSvGLPfGF7ds9VpRxiDcQgJ1M2b6Kz8jmpkR3quNWHkvcwivDYxg
         G+/g==
X-Forwarded-Encrypted: i=1; AJvYcCWUSO6LE/sKaX7tbkrRHYdxD+f+ra880pgsk+YR4aIFk0sAzaXyXCKVWY73hoBkZLROWT57eQ1gHZptBlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/NwzSGWy6C/k59EHpqTiuk6goRBh4U7Cp/oySvuGgiiPaTJB
	gkW8lNtOgmVJY04jxsK14JjSIuE1Miq/4WFBSVBLVWpmKYa+78HhhAtbzw==
X-Google-Smtp-Source: AGHT+IGyppWkVmApOtjCUbtRtDXYHLKnG+Ld16jhz3PIO7i6zKlGxZZwQ2etf+Wu99kiuAYnUiTTIQ==
X-Received: by 2002:a05:600c:228c:b0:42f:80f4:ab2b with SMTP id 5b1f17b1804b1-4311dee6f58mr104057295e9.19.1728900635179;
        Mon, 14 Oct 2024 03:10:35 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7f2c1esm10943702f8f.109.2024.10.14.03.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:10:34 -0700 (PDT)
Subject: Re: [PATCH net-next 1/2] ethtool: rss: prevent rss ctx deletion when
 in use
To: Daniel Zahka <daniel.zahka@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
 <20241011183549.1581021-2-daniel.zahka@gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <966a82d9-c835-e87e-2c54-90a9a2552a21@gmail.com>
Date: Mon, 14 Oct 2024 11:10:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241011183549.1581021-2-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 11/10/2024 19:35, Daniel Zahka wrote:
> A list of active
> ntuple filters and their associated rss contexts can be compiled by
> querying a device's ethtool_ops.get_rxnfc. This patch checks to see if
> any ntuple filters are referencing an rss context during context
> deletion, and prevents the deletion if the requested context is still
> in use.

Imho it would make more sense to add core tracking of ntuple
 filters, along with a refcount on the rss context.  That way
 context deletion just has to check the count is zero.

-ed

