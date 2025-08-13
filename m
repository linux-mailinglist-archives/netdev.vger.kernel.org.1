Return-Path: <netdev+bounces-213326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E10BB24907
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20DD7BAF2F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E08B2FDC59;
	Wed, 13 Aug 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3CgdtUvN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932212FDC5C
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086469; cv=none; b=gAT+bk8u4mOoMbFTFhliZYKixLDh/P4n5d+O74kB65vpGQmdtQLfxWdaCABuqc1LkqFEdHt6MbqORNVI6tuv7LzGOcH/ZY8l6NsNEdCFcH0wMmFGt6uiSYgW7jIB8YhsXqvC/y90v9wK4w5Fj2ZEpWANh1F3oEoCNm2fn0WpzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086469; c=relaxed/simple;
	bh=21uThjRFNAFsflTR+fbg9LLfAhuNOCf8lYl89FYFvPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmRkc/+uWJPqNxqN4pUbOINzllz7oxpEJJFAkOxnZ43cwrmg5BRmpTI32GHRWvNXhvAznxU+ArxAERh64pGnWg1znsPrxDndyBxMYzbPsSxMHGRzN3az6tIClMGZnS+Gsu83wc8KtpBUzg/G/+3RnXWEvV5GE/ttLjwaFSDLkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3CgdtUvN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b422863dda0so4573313a12.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755086466; x=1755691266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHAMFL+QvUwvR809KrjC7Pfdd1oqWDB417E2cPRN3Do=;
        b=3CgdtUvNQdoEi9/k0FypYsChhiVMub6+mDZ+8Ld3Wvs7JQQOAUOTJQIeH6I6Nt/4iK
         l+r5bdp0PGq9tL1PHrvlOblfEdOu2XpjKv7MKUr8HMtALywWCLkqpY/HjjZQAIk+zHrC
         I39Tc2jkjEXOVdlPaZaYDPJ+/4flia1XIpJBk9GDe9lg9lTuqIO3A5JD+2O6UlK7bfc/
         2vgAacMbOQMBWq8Cl6DlW7bI5HUXSxyNRx3rmM6J5uLYUmubFPmPCtfDO6NxvZwrPEL8
         Rwm8hsbeywhCrqV4iTwj3VJRcijNHUpNFMkW+GcUWdeJEqEkZBXE2vrIbamM21jOIY/p
         dS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086466; x=1755691266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHAMFL+QvUwvR809KrjC7Pfdd1oqWDB417E2cPRN3Do=;
        b=UZTcHgjsmCreyu7nZ6VMGmMqeywjyklzQ+dUdzJuXD2KzGqgFVOlQTUjgFixxU0Jbs
         1kXiaviPne0XNl72j5peN0mavT3TeIwrO9UtuSrxXsPcmYVCAkGvePJa1dX8AuJ+QunL
         OPnBTwHTIzNYCLfEgPABwNmbTDnLF9CRHkPhNei5r84336ZVQRrx7+A3Q2YEBm0KFEJy
         FLFK7zSIrkGINl74mhkxgOsI0OHP5NA095IfJD6EvE7D/8xVDrbSBF9zN3XupKDvbxKD
         BUs9738ytXkx0uveitr7LiekLf/SsVUPbXmrwa5Qcq1uRWeMRdgZT3skghh7Md005DIH
         ivVg==
X-Forwarded-Encrypted: i=1; AJvYcCX81H8qfhS/RMSdfvrDG0x85sEGECcFK7c8hztTyN9oouViF0m2QpMjevzr15At9bL1985XJ28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JFMpc/6HHD/vj8VXBhXxAM85Xl97KuHSZYP2tYlJrrSfiMLw
	fKFzhaQvYn9o6AfTmhzwPIG9MTH4hTBm013+ctymJA5HJAPceiLzOaGKxcLcJIRmaA==
X-Gm-Gg: ASbGncuTMcEUYM/OITVpAkL2rAtABa4Yus94n8qBmQztZOeFWLYolAam4hbDsdfCyD7
	JzcQpukPoFxzbfaWKXjcTeEiaDtKWvsrmxa87e/LsrYzVt+K6xXtaj/tkWM6YhVb9qyeeMg6pM7
	84kGSfqmBdbEBkiBP9I7rbmnh9+ypvO/HJYvRyRQmOJXMIJxnoX0Ro6rL8a0lJn92pZ2fR6CmQB
	hMBmHlpTIq8jU7q8ibihQb7EQOf/vXJYNX83CrPlRRLCQy65XFnYHKCneDA6An3krG4nueZYzyV
	8FA0n3yoZFNgy6p1VmM2XlDz9PtWMVwQ4q08pMNJwxDR1neW7zf8ihQQ1ZRzosK4sCN0PtTxbMf
	WR+bu51lTJpswI5U8n1RvG9CNqtQOwhbTGcfGn96yoef5RFSkK0x4FeZHxG884/PRGeU7
X-Google-Smtp-Source: AGHT+IGHJuWaV+FD+QDrxC+U/4b+aMqI/qdu++bCKwWu4Xu4dpSPZ/7FiJccNWtZT0ccGveemJpAoQ==
X-Received: by 2002:a17:903:1965:b0:240:3239:21c7 with SMTP id d9443c01a7336-2430d1cdae7mr41229705ad.37.1755086464176;
        Wed, 13 Aug 2025 05:01:04 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea? ([2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242b0934d33sm160769535ad.46.2025.08.13.05.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:01:03 -0700 (PDT)
Message-ID: <7d3108e8-93f5-416f-8eaa-e63af851756d@mojatatu.com>
Date: Wed, 13 Aug 2025 09:00:58 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests: net/forwarding: test purge of
 active DWRR classes
To: Davide Caratti <dcaratti@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Lion Ackermann <nnamrec@gmail.com>, Petr Machata <petrm@nvidia.com>,
 netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
 Li Shuang <shuali@redhat.com>
Cc: stable@vger.kernel.org
References: <cover.1755016081.git.dcaratti@redhat.com>
 <489497cb781af7389011ca1591fb702a7391f5e7.1755016081.git.dcaratti@redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <489497cb781af7389011ca1591fb702a7391f5e7.1755016081.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 13:40, Davide Caratti wrote:
> Extend sch_ets.sh to add a reproducer for problematic list deletions when
> active DWRR class are purged by ets_qdisc_change() [1] [2].
> 
> [1] https://lore.kernel.org/netdev/e08c7f4a6882f260011909a868311c6e9b54f3e4.1639153474.git.dcaratti@redhat.com/
> [2] https://lore.kernel.org/netdev/f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com/
> 
> Suggested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

LGTM, thanks!

Acked-by: Victor Nogueira <victor@mojatatu.com>

