Return-Path: <netdev+bounces-171041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3585A4B434
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 19:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268A616C9E7
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABEA1EA7F0;
	Sun,  2 Mar 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="OdR0dY61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7D1E9B32
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941531; cv=none; b=GtgQPpHr69P4UNlOSpdwln/mhHVvZmgMZWG1LeoMvKHsOnqWnijZp3NIswmLhGMY90jqyqgVyFhU2PozI4ics3fHWISHDtPKTV2H7kpKVrrOzpre3QohKnGQNhlT0cEKxUx860NH93KCOvv4GcHeLv4k2WlIMvNPqWspJvuP1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941531; c=relaxed/simple;
	bh=2YMARwFzpT/2fxXckH/UHsQeqc+WpNlGXz87LpMaUd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ic2ow8jCqULQp1WDZEzWh+wBb+ol5LorB6+dh+F0kj2fUJ3BvNuYJaaZCAIFnEvW9RSHCAoO6TLiWl7VReGuyKmHtoGIq2/lpE7p+xAShSmZLEJcKHj39jdhYuEx/+9piDpq7K7d/xmY5wLO2oPqUr1SrhoVAg+sZN0ZbEo/ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=OdR0dY61; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so15993055ab.0
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 10:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1740941528; x=1741546328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7l7zFCEphXv5rcB1xTH7E9WWTKLPr1rVfyP4hQcYq8=;
        b=OdR0dY61TX5AJXZhlonjpCk1JIgVFFxqwClSDjuHlNrLbhwDKGADhJYbTUTb7sE1+5
         TsraLkBGn5nBVt2Ozn3J1q4LdUraaoQyd6t8+HTdGAhUkQ4ZuxmbQ2QHDVwsNHqX0EV2
         /cHB8KhgnalUvlDxl2W0aC9R5R91lKzZsy4yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740941528; x=1741546328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7l7zFCEphXv5rcB1xTH7E9WWTKLPr1rVfyP4hQcYq8=;
        b=O5xZmeT3SQtthSnsiEueWyK/5JNuKC/m6/XEnFU3lOk/LDgCjxadFynm3XDhw25yIH
         XRaHQONruHnpIAsaf95dHGaprISi1aT4OdEcBk+mlkeEpsfR2QAGcZ5X+gG3kWFW7GBv
         mHhjerBnnh6N1H4jgXrMu5GIEBGz4QGVTDbMbwelxIj5yfP5zfK9q2kkz2JYNc1wx++F
         2XAVLwIQF+YL0gnSRkKXPnVPnIW3tnV+J8LZfIYEODN1EmHeQ76xDESsvXyzF2MeF7/+
         kaVdUoezZX5R4nYu6IXkPq7K+IWcQY3Dl0sMdfElutr9Gy5Lj/jC1Fho/T0AxT9Uok7Z
         7UtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvhSpeIJQEUx8HOW4UwXdHGYit1zEegEd66LGtZstzqypnXw8VDohXc4gJajvjaoxv1j4dLeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyA/ZgbuMso0FViTNEhjosBVyUQJ/TdbzjeYleBg2rkRlYVRxW
	RYIPEiiDuHY0PXR4njWKxag5pcDZwgLJJMaWmaKBwHNIY/xphRWWhA/6tfm+WA==
X-Gm-Gg: ASbGncsMX76YEXtwJ19AAK2Sb97f7Wa+Dxv7r/uoYs88mFy/H5H/UBAHTw7Z5gwlBf/
	e5fit0etkR6CBfEkbDEwXGghhKr3rboJJkCFMEY6Y1MLeFDuI/qfg1k8mJ4JdvQCSFnERXCYRWu
	jqP8qQ/gf3IBZ+dEFMHe/Vtr6bPjJEbjWjDMmZztZQxXqogxxhSb4n+xNyqQPg8navIq3O/7JQp
	H1PmJFkI0FfBokhOodtD8Yfciiqod160ff0HQtzXeI2IRb3s6jG1W3le8GSFeFtelDfbc6kJS23
	pJh7Ou/cQ1s9ENDdX1GF01slZv4QlMXM+ZvNhpP0vccJsJcCBJR7X3dBd7QtT/D6ime4GxDSZLD
	8NJSZEZpCV+NW
X-Google-Smtp-Source: AGHT+IGaYwptaiL4qcE0O0nJBy5S6QCvEaXlN2oaucVjj+jdPUcbQMj/htRswkhfxl61JYv1Owe54A==
X-Received: by 2002:a05:6e02:1d87:b0:3d3:f72c:8fd8 with SMTP id e9e14a558f8ab-3d3f72c907bmr39999795ab.6.1740941528462;
        Sun, 02 Mar 2025 10:52:08 -0800 (PST)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3d3dee70df6sm20104735ab.36.2025.03.02.10.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 10:52:06 -0800 (PST)
Message-ID: <16588001-9fac-4508-87f8-026acfee8b34@ieee.org>
Date: Sun, 2 Mar 2025 12:52:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fixes for IPA v4.7
To: Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 phone-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
 <20250228145246.7b24987e@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250228145246.7b24987e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 4:52 PM, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 11:33:39 +0100 Luca Weiss wrote:
>> couldn't be tested much back then due to missing features in tqftpserv
>> which caused the modem to not enable correctly.
>>
>> Especially the last commit is important since it makes mobile data
>> actually functional on SoCs with IPA v4.7 like SM6350 - used on the
>> Fairphone 4. Before that, you'd get an IP address on the interface but
>> then e.g. ping never got any response back.
> 
> Hi Alex, would you be able to review this?

Yes I will.  Sorry, I've been sick this week.  I'm
feeling better now.

					-Alex

