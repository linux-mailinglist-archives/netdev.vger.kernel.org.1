Return-Path: <netdev+bounces-129210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CD97E399
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 23:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8E9B20D45
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 21:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A374429;
	Sun, 22 Sep 2024 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwBha2NW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC708C07;
	Sun, 22 Sep 2024 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727039066; cv=none; b=Itwr2h4kwMAQFoqp2STvYgDQIBPLRWlxiEiFpykn4b2bUQri1m0qJ3KjOiUUXdE5QnfrjKjJzhxMJEs5KZl8drS3xPXiNN2ulrg4BNePJYPUPYV/xfUb+upwS7kIAl9BkP3LtR857GIR+Hw6f140kVyFR9oRlKKa35SbE61kWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727039066; c=relaxed/simple;
	bh=biAARFvH1GibeXEvxfSGDsj4N5w0YpZ5Rsb1ExkxDd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlETyiLUnsVHCr9UvrEH2tJN7/cPh++UGDpI/DWMoka9z+t2Z/eo3PR+iYP7T8mVgrcggZLC3ZDWNiBh0qnU7zViWxw3XPNH7lAAuk7inxADHPSlEGCLGHirq5Sogqb4FW70AXwqkcfILdiMMufjg3t6xaMYKWgBmfU3KfQe7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwBha2NW; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1a819488e3so2848141276.3;
        Sun, 22 Sep 2024 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727039064; x=1727643864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sLL1YRqiZUoWwvJdj6ouIVhIgSLLyYmmYz/rdh46/s=;
        b=JwBha2NWnSfpX6l1KdolhJkSKMqsQh68apRLkgJ4msje9Qybqs+JccEvNNEn3Ur0Wn
         GTyu1OYCpQKu6+yYatXLF0R1NFKXuusTf1nQj/wlJliORz3U4ugziHvTcgjuVMbSG+RE
         QtCK5EoOprkw5EgX75bJQ8fNZipWnBPZYsACQ3LEhCtvJqt7nPH7Ilz2RS2ObHkqStBT
         Cl29/aTpnsRQtgR1vpq6sH3b97h5Ja//KA7i2Yon/Fr5Rv8ZViELUnb6DGtA6LHlRNXD
         CJQcbMrLhAkL4BTD+5O3KFjYciiDgBTZokoppYSFi5gObGU7OFUzitallhTUP9voMc91
         kBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727039064; x=1727643864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sLL1YRqiZUoWwvJdj6ouIVhIgSLLyYmmYz/rdh46/s=;
        b=c1BeIvLnOJ4MOSAO9A7eBmxQ/8L2U4mw3Z7H/Xn00UUGI6MWoCKKRDm6OZLAdj8dT0
         u8+GeIT2+F2SRlCTWKaSBVABw5189/STi6nQ6Nc6SUfQ9chWQU7sVmfhe+Y9JFhZ309I
         68Dh998oCDWX3xNTeLoUwGFdHKKqTj3wOFU5tUuU/o6E5XTfj3rrHtb8B/XKxMakujtW
         iTxdBfNKtiIMzrLkkzRrZGynbZu6kc23lruMIzpdbiCDTVqIATBHe56ACEgdy3JJN2Y+
         n/8jlw0siYnareKlYsOQsrk4D7wvJmjaMF2SW+Df1URWcEHVL2b9vl6QhpPSqPDzXo/m
         Tzpg==
X-Forwarded-Encrypted: i=1; AJvYcCVBfxx3DPDwny1meYFxvzoIi2bSGSGLs6pMrhNT5EQoeVTsfbx/t/BUEwsqiZRD15pm/OfAII4RZmsqdFE=@vger.kernel.org, AJvYcCVPIRBAUtemGPql1YDzZBYQYOfshDkASuGeMUG7+Cwf1UYVmlx4c06vLN44em/l2WhMD9X1wwXp@vger.kernel.org
X-Gm-Message-State: AOJu0Yygl9e1i1l+5kPr2fIIZmiB+kLAurdodq4r16mlM94yiJWXih3k
	9m/hU5iWY/A89WUBPUr6Y7ZTOVpvBKy0/lyIGUSgHWJeLuTefW+S
X-Google-Smtp-Source: AGHT+IHWLg2skq46AMW9oHhq6uebUn442VU8dWAyqkW+88qG1CuzJ8QBvzKysLL3nnX9jJQMezHw8A==
X-Received: by 2002:a05:6902:dca:b0:e0e:7fb3:cf88 with SMTP id 3f1490d57ef6-e2252fc700fmr4616915276.57.1727039063956;
        Sun, 22 Sep 2024 14:04:23 -0700 (PDT)
Received: from [10.0.1.200] (c-71-56-174-87.hsd1.va.comcast.net. [71.56.174.87])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e202537629bsm1615176276.11.2024.09.22.14.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 14:04:23 -0700 (PDT)
Message-ID: <ef4422fd-f4aa-44dd-b1ff-350761db59d5@gmail.com>
Date: Sun, 22 Sep 2024 17:04:22 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv4: Fix circular deadlock in do_ip_setsockop
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com,
 alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org,
 dust.li@linux.alibaba.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, schnelle@linux.ibm.com,
 syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
References: <00000000000055b6570622575dba@google.com>
 <20240917235027.218692-2-srikarananta01@gmail.com>
 <CANn89iLxa6V7BZSzmj5A979M2ZObj-CcDD_izeKqtRCZj-+pmQ@mail.gmail.com>
Content-Language: en-US
From: Ananta Srikar Puranam <srikarananta01@gmail.com>
In-Reply-To: <CANn89iLxa6V7BZSzmj5A979M2ZObj-CcDD_izeKqtRCZj-+pmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/09/24 12:11 pm, Eric Dumazet wrote:
> I think you missed an earlier conversation about SMC being at fault here.

You're right, I missed the earlier discussion about SMC. I apologize for 
the oversight and thank you for pointing it out. As a first-time 
contributor, I'll be more diligent in researching existing discussions 
before submitting patches in the future.

Best regards,
Srikar



