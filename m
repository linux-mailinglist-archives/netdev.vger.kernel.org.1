Return-Path: <netdev+bounces-228331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B640BC7FBE
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9854F5DC2
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F2277CB2;
	Thu,  9 Oct 2025 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpaM2M+r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E72609E3
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997756; cv=none; b=I7dSHSshySa7K9xG9nL1tuDP97gX5eDqawXmR7Fic/hZqO3J/u6HB5eypjU94wEVtV0jqcB8Mu2hLNJ5ZmLLt3JOb+pIDOWMQms6+mA892TeFDlQzfsuTc2jyXPzaidMcrw2BPuJ9To/fjknzT5zC/zcb4V0kmdvaqeLcNYE8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997756; c=relaxed/simple;
	bh=m9XiVtTAN/QcQjl8cEjXtLDaFvDP8ICTqR1U2yHijVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfmBITdqr3R0NLa+1zngXoESCVYK01Obsj64MJlmHdt/SKHmSLXNdlf8v+kLoAWybUC1jRScD5DtGNyRQvWWta78x06WxLSuzrYS7xD6403+ZslcFqDQ7KhuMst31nl2p+jMYXVwikLLuQ6ZQCmbG7ebQ1vg2GmY0TPAvkAFQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpaM2M+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759997752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRe9k9uGBBpiKkw7TBSCO4t/JPzp2ByEOYJUEhSNCs8=;
	b=fpaM2M+rVjj1ccMzQ4+AdPUZNuek5W9X6RcZZg50LqDi+PCq3nC6BdsDahvcMa8ubHAv0w
	X185ijS29XsllI9vwAaaWYc9hM4o1wC0nJYmR0P6rsiXIwGQpfYoJ/UcqzmDUYgvKZSK/r
	uUDBB6nMnYDmDhybweUMEtv1O3q4EIk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-7YGZ80tvNxaH-NgJfR-fVg-1; Thu, 09 Oct 2025 04:15:51 -0400
X-MC-Unique: 7YGZ80tvNxaH-NgJfR-fVg-1
X-Mimecast-MFC-AGG-ID: 7YGZ80tvNxaH-NgJfR-fVg_1759997750
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so8425405e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 01:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759997750; x=1760602550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRe9k9uGBBpiKkw7TBSCO4t/JPzp2ByEOYJUEhSNCs8=;
        b=YyaQutVi4DNTyGBYRtQZB2yd4lM2W6TFRRKJsmgTXfoRZA/ivyx0jEiNFbmwnwg1UQ
         QYlP7n3DTllg+82tVm4QuQ1dK1btZvdCcAGQ5MQObrlMkg2JWLhWBEheXnuh2sjgk0Wn
         qAYye9oIpQh7++YLhODUDDvZwVdhspBvdz/WeZJ7FKey24RE5mNqftjvJqAnU54WDUGv
         YbR+uEJqUhjvVzBU9L+4OrvlNzl9JohKzuxjZHiKGZOgHbuQHcp71GmvItFIs8O9qY6R
         JIVrMHmFOAZlcyTq0JEjTQraAqhwzC83iy+ia/DOcF3ZgLe+V6Dj+f3FxdNvXX+gKzLV
         27Og==
X-Forwarded-Encrypted: i=1; AJvYcCWlretYK5644/mEn3TUO5ToT+qfBXnacRnYCtj/YLsLlD4HVJ46a7tHD/96H9EdsheaaywpsWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeDFzu7nkOhg1TbxU5uq5wOA+PALJd04XnFeNbTUkTUDtL6grl
	frNJ3hv13g9luz1KkvW+yrL5omMoAwFHRTYxl4Kc7YYfO3x8pHwzoEyPPjh7BafiXeStLrkbpVV
	2EelkeHSAVwsJIerLWaQMeZKvNccur2SDEPZScc2bL9hmO/um2C5NyeNGh7Pr6JZUBg==
X-Gm-Gg: ASbGnctbL+58oaxqizLSjwZovkbUHRQ3v5x7Yu3ZR1JgykmVILdJFUCo8TQlrw5s9Kd
	uGbGd47ljQD0SpTa5zhHKVreqhKfljI8GOAeWZVDDAuv86jrIUnOAxW6SnOfhYAln+/VVoKPhq6
	CQNbgpfHBSuXjLRblK6xRvRvpASDAdR8wdGRsopJNfJS+KiW4juUVcBlNFCKhDdfkCMBLTMDKYI
	tmLOit2o8boaaddcBgk7D+Djk19gH6ybUwxqW9b5MiMYHEAqiwgg6u+FdfwQ/cI+P1gIV6FiO4B
	aY7gBVoqApq+6p78L9gyqaEFfzr/uprFjoBy7P0zbGiSb0dE8CaL3TIodubxKGzhh5RvQ3xYhGE
	93clwn7R/ih/nu82LmA==
X-Received: by 2002:a05:600c:1e87:b0:46e:345d:dfde with SMTP id 5b1f17b1804b1-46fa9a9f051mr57108915e9.16.1759997750106;
        Thu, 09 Oct 2025 01:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/NKmEyIKDnjxYZK02GhdTjC9WGAo5EZp8s6qd6Yj74nKrU+HmnBUFXfjEDbRJZ4WcC3QcWA==
X-Received: by 2002:a05:600c:1e87:b0:46e:345d:dfde with SMTP id 5b1f17b1804b1-46fa9a9f051mr57108585e9.16.1759997749648;
        Thu, 09 Oct 2025 01:15:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07992sm84826105e9.5.2025.10.09.01.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:15:49 -0700 (PDT)
Message-ID: <32800363-aed6-4e59-9ad1-435e819bca80@redhat.com>
Date: Thu, 9 Oct 2025 10:15:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
To: lilinmao <lilinmao@kylinos.cn>, hkallweit1@gmail.com, nic_swsd@realtek.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251006034908.2290579-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251006034908.2290579-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 5:49 AM, lilinmao wrote:
> From: Linmao Li <lilinmao@kylinos.cn>

From: tag is not needed when the submitting email address matches the SoB

> 
> After resume from S4 (hibernate), RTL8168H/RTL8111H truncates incoming
> packets. Packet captures show messages like "IP truncated-ip - 146 bytes
> missing!".
> 
> The issue is caused by RxConfig not being properly re-initialized after
> resume. Re-initializing the RxConfig register before the chip
> re-initialization sequence avoids the truncation and restores correct
> packet reception.
> 
> This follows the same pattern as commit ef9da46ddef0 ("r8169: fix data
> corruption issue on RTL8402").
> 
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Please send a new version including the fixes tag as asked by Jacob.
While at it please also add the missing 'net' prefix inside the subject.

You can retain Jacob's ack.

Thanks,

Paolo


