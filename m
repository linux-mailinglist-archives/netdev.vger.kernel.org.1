Return-Path: <netdev+bounces-75406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A05869C89
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69991F24774
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF52576D;
	Tue, 27 Feb 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LkYecG4b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C644148FFC
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052069; cv=none; b=WJe+JCX8kwAOgDtJYLevgJWhTwFN9H+t33k6tNjWhUnQ/v84yoFDfTpWirg/VNRjMviT8TLoUZzelnNfwF/y1mgtZBVeqZfZ7sz70tIW1jherwQ0veURkEKsLHNCmonaJiW7feWHOlCKurrz/98G3vAHaLn/J/rMWhjndGKnD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052069; c=relaxed/simple;
	bh=tvywUN6/E7Ka8rIVl8IMQLLez8maZ8MXwrAXcOAlmiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V87HSbbx5MbhVkEjIPL2FBwvreFaqG+HStxj5OsPB3g1ieCk+PS8fDtLx5UN1AESgD7jS7y0vnpN5ZUpwwoklOt8AV2S/eWYlXS1k//bDw/abjETbx7BDC7gVwTGRmUb6Rv/IMuATynGo3HCi7BmJzyLAwBO/LrOa8r2cuaBPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LkYecG4b; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d568fbf62so2556302f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1709052065; x=1709656865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c2Z3LOs5GnCA7G7ekT1Aa4kct8RHQ+4+bxiy9WG1ZoY=;
        b=LkYecG4bE7SgRyflim8Z/flzJgVHlk+kY6xCBMEx/vCdsxxTmpDT5NbHY8iYTeFpHP
         qnCGcqNNzw1jbi+WvS6eEdxlfegj+OUeOXDHrkoGSyOY6XYnrf653S+9d/NGUG54nV/J
         ejXBIqlL1Nk9QMXuifh6zcTj3qMhJjXybLx/8Ujy1QEcHWHSZ/Z+Zi8PMxlV36H+u0hz
         cI64EJowwG8fXSfvEUtUY1Aoaj0gM3f5HOc2/gxrE6LggOo7IcyCR1fYFIaAFbPkxrTG
         BOokaNhXFnQqc/WbIpQcjm2dT0V8J//EylXP3hAmm2kj5A/QPfxqRISlt8YYQcXKrNUZ
         51vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052065; x=1709656865;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2Z3LOs5GnCA7G7ekT1Aa4kct8RHQ+4+bxiy9WG1ZoY=;
        b=m2S/CWjxUqNQdtYTJzcfq9PC+bRA7VfjJHtkBZEUOv6PqADPS1IiQVEic7ehJQVYew
         jm2Ewdk2uc7P0qu9rjgUZqJ9UgSi6F73E+bYT8yR1Pefu0V0wB6uoTV/NEIS0NKmo1qC
         +4LaeAteT59OzbAKwPZSKrHJjmCK2tpnS+1M3YR3yh4uXMVQqPphtC0BWKa9gwmEnRFp
         OKUS70FaBCWukXaC+zGQNMIWBCrbiLcM83zD6hYxKyfw/h2hHCYkYIQFOxRL+rIzOaU2
         FyOeGKMhsMcepEMJuDQ4GtoQdlGax3EJbwicMaJzuey8CawZ2eSJ1N5SpCJJlY3qP0gE
         Y0GQ==
X-Gm-Message-State: AOJu0YzGoI5wgeq5aO6aKHgHTRSTLBUeT1BtGNoWH97QrWH2gkBUsEb1
	YqUjsYaJhRpMT1VLzB31G1wd0ctpn75TryN+6f1YquBhf5GfBWfpWtDyUCIwBaFlOGLJAHOaSPp
	D
X-Google-Smtp-Source: AGHT+IFUl2MmO7Ut/LopsDL6YFAkSNelmDkVa51hFYJjfr8nbuEbKHdSmud2VkQlFqwLRLQUyQMdYQ==
X-Received: by 2002:a5d:6201:0:b0:33d:e25d:b926 with SMTP id y1-20020a5d6201000000b0033de25db926mr3247261wru.20.1709052064843;
        Tue, 27 Feb 2024 08:41:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:535b:621:9ce6:7091? ([2a01:e0a:b41:c160:535b:621:9ce6:7091])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b0033cf80ad6f5sm11767517wrs.60.2024.02.27.08.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:41:04 -0800 (PST)
Message-ID: <4fccb2e2-97ac-4f16-8f56-53a38a269b69@6wind.com>
Date: Tue, 27 Feb 2024 17:41:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] tools: ynl: fix handling of multiple mcast groups
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 willemb@google.com
References: <20240226214019.1255242-1-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240226214019.1255242-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 26/02/2024 à 22:40, Jakub Kicinski a écrit :
> We never increment the group number iterator, so all groups
> get recorded into index 0 of the mcast_groups[] array.
> 
> As a result YNL can only handle using the last group.
> For example using the "netdev" sample on kernel with
> page pool commands results in:
> 
>   $ ./samples/netdev
>   YNL: Multicast group 'mgmt' not found
> 
> Most families have only one multicast group, so this hasn't
> been noticed. Plus perhaps developers usually test the last
> group which would have worked.
> 
> Fixes: 86878f14d71a ("tools: ynl: user space helpers")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

