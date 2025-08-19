Return-Path: <netdev+bounces-214993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A76FB2C86D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262FE189059D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F4280309;
	Tue, 19 Aug 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYi0cQo6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C52253FC
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617241; cv=none; b=VtixXthiLSEByhe0QXSm5KQLvW9ys8XPHu0+gFocbEOtLJfgnBZCqbxHU/5LwjttkF+uFKtxfc5/AbUzOQzZKFarMDnnQ7/IMiKz5ldhl6xRegbOsqNKf09jJ3/QVCoahxWYD7jFrs9a1+JKrnG5LKDicpYFpO3nfDrG/rona8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617241; c=relaxed/simple;
	bh=kx/GzuouxRwTCCBdO8w3Xfyf3qijQtKFpqtG9tzbep0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR3MDb9FPgdeD7rBUZXAEDXeTqIJN7Eja1EzZW1GsXjM5pqgqP1+qVV/5os7knOBWNoMN/1eFd4KGEKqfzcLpBkoSAgVCylSis/CSnyBNd8VfhPAJcv6BpFDDwclDU6JE+eaTKabwUMJsE0FtqwT5/hdTlBwxVRkbG7KqwTPup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYi0cQo6; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e57376f5abso47999425ab.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755617236; x=1756222036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kx/GzuouxRwTCCBdO8w3Xfyf3qijQtKFpqtG9tzbep0=;
        b=gYi0cQo6p3Nr4+SU7PsVEFWz1tTqjOJuMv1TMkJdsxWJrZyDa+Mo6i6f3J2hltrtkz
         RsHGQfuJTvfXX860Jzy8p7Qg3yHR5OilNE6ARy22Ltd2mylRGawMbSJTOek51W/LlERP
         K9S6+YPWS5PLtYDbPYZDW+dFA53SjhJZANXZtD1zHfP4hDspqbq0gUdTdjhj/Imp790z
         jNNTJMuTfLSEIL1TH4XGio2N5op7Of5hGrUNNpyslS9hdsFdX9vBd+VUh3clHvyoURZr
         SOSzjCSYfpPJQSvWrppDTdAi5iN5Lu53+3WkfKzTdY2wTBwIa6E5z0fx4jKvsg8F0vGS
         OiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755617236; x=1756222036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kx/GzuouxRwTCCBdO8w3Xfyf3qijQtKFpqtG9tzbep0=;
        b=k8rL9fgNQ8vVwkLOAL0dwM7WUfBwPOLwYvrVh0h4IXWbygXN3KWUXhixwuAEskXSWA
         aSvs2cy4k9DtFh2SHtcLoxgMpMobNHKqR6aKDAHm2tRGfYlkXPgWwexNmOQUnhEUqjgi
         naBlL45CaJfFb5W8C1Iid+NBkUeFl6gcaTcfcFcXA8D+CoELgPbs49e/0SFnbKqmUBYO
         wjGGXKcf8CRgxD6Hyh498uAKKzmZcE1BZpXF4IswfPRfoPRf3SRAMmP8fPqZ1+0VbcbY
         ugSkLabuVJbYwP/LIvTYFA/EVDGVGvcDw+bQeItPHEnpB+PzYUWv9SuhQO7xwEW9WKRO
         AH7A==
X-Forwarded-Encrypted: i=1; AJvYcCXxmufVVaGNKc6LW3J+lseDGPI3/TVQYqOtNAZbT0NYo0DBGLQiHfsnDKj6GxP4IAkA9G0eqDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMR48a7eNxJRkGJ453NOGE+dZSagTqOL8MoJ5rzZOOnQlqT32
	2z8U3aSLXXJ4o9tBrgd0vRCd9JH+GZ1JzeFcD2BVV6VAxCUNQE7EmBG373P8pw==
X-Gm-Gg: ASbGncufbdWXmo3WOzCrrS3u8P6vERP/9IPFrWPqxf2zRAOgkoJPa87PKqkcyuXNZ7t
	BFverZBCuqZmti0H+TCFbA4OVOkY2hYCe3r/fYdYqOENQyY3lYgwHDTbww6J5bsvUMYC2Rp5rq+
	XTzrSpmR2zSUGANPS2lWNy/k2OBWgtMeJPopKgDfWWdccWomV1KQ7BEIGMR5nT5Jd8y8YkNUNV+
	i4IRVez5ZeafsJE7eaYkdsvVBBGrKhZRgHFQQKYMOTrkLtmJqq4Ox+IODfDG6g4PEn269aDvFPr
	hCzh6GKcWp0DlnTa8+NYVgHOjf4EiQV4/R4T63EQFoidWF3EXvXlG0VoF9Z/vCB6YL+Y7idFUf0
	mp1U+/QMReRr8N4S333nDGUIjz0wDBYkbBAEfIeVqzTWI5I6yyepQVjFwbn5d3DgZyq1kkMsmex
	webPlkc6iN
X-Google-Smtp-Source: AGHT+IHF+nFW+z/2RTzcP2bxGRWDmwnTGZjR/y/TjjOcRwbT8dky8oL7l9/Nlm8fq4qHaU6RE2BnIQ==
X-Received: by 2002:a05:6e02:17cc:b0:3e5:3a99:97d6 with SMTP id e9e14a558f8ab-3e6765e2e42mr53984435ab.8.1755617235794;
        Tue, 19 Aug 2025 08:27:15 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:e053:c52e:48c1:18df? ([2601:282:1e02:1040:e053:c52e:48c1:18df])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-50c949f76d0sm3455959173.73.2025.08.19.08.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 08:27:15 -0700 (PDT)
Message-ID: <8b801c6c-ee90-41ec-88dc-0b57b7bb7ca2@gmail.com>
Date: Tue, 19 Aug 2025 09:27:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to 'ip
 link' for netdev shaping
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>, netdev@vger.kernel.org,
 haiyangz@microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@microsoft.com, dipayanroy@microsoft.com, ernis@microsoft.com
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
 <20250816155510.03a99223@hermes.local> <20250818083612.68a3c137@kernel.org>
 <31e038a1-5a17-4c13-bf37-d07cbccd7056@gmail.com>
 <20250818090010.1201f52a@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250818090010.1201f52a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:00 AM, Jakub Kicinski wrote:
> I'd be very interested to get a final ruling on YNL integration into
> iproute2 -- given its inability to work as a shared object / library
> it's not unreasonable for the answer to be "no".

kind of hard to answer that without some proposal with details on what
an integration of ynl would look like

