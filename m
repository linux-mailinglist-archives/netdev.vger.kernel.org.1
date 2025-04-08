Return-Path: <netdev+bounces-180029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 877FCA7F2AC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BF01898636
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD941A7045;
	Tue,  8 Apr 2025 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvcZ2GII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCF199237
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079469; cv=none; b=iSfrB8rRbHhH6F0XYe0VurBVpORG9vRw0NJRrGFxG+ldaboTj0l1Jhqn2YnsFJ4I25hzT/eQQtOyhGoV+sFufqTvAisjqZzV/ZHd8F0zC0tcjiedsW/oJOzUuh02+Bne6uDqEn1soCqPEfgh3fFc9RdcS8rkuKGZHt38GWy5hSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079469; c=relaxed/simple;
	bh=ULiawTzzcBI0l8+9GwJzrB/Fi34oOjWKCS0baHQcsvc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A9s8P1AQz5U8kWb5qosHzwiIc+yHnaolhN6wesNPWT0deCnsJuEazUf4WoLntByG6AjeA2tPbrS9CX3gv0ztgJNqNT3lTIY7eMEpxPuhJJ/blm4AW/TVUh38Os5jFy8V+NgH7aT1HAdkht97rkbqJe4Vbxqobp0G/XivGQtIBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvcZ2GII; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-739525d4e12so4450610b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744079466; x=1744684266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0XeNG3jGLYlFMTgDDHqxozjF1bFZ6tggy7TIhhUzXfs=;
        b=TvcZ2GIIWAC44Y/U7vtS8urS6bfDf7V/jrlsdVoRsFz1FEwKUIfGNJtCEKH0jIKU/H
         mRFVOs1AER5gQS4meBl1UjdrrcmVqoTEidMjVnOx5SWcCUbFttgVEhiFbrw0iw8dE6uM
         2MtqPMAlpUNJR4ecR3m+OaZwNfCq8ZoqgIyOzmzVr3BQf6ugfige41EBAaBlwvcGdBQz
         vCHYwAwpND0QE77Wx8hrOYvmFyKv3hH6XDQCbOBQA3q90vjQhiKljdVxpmYLahuCL5bz
         3UehZY0kr7Vy4M1Oym4mt3Fdt4UKs7HStoIaTq/kfslHd6xX2ohZgTSs+MCfZBwsC07D
         xcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079466; x=1744684266;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XeNG3jGLYlFMTgDDHqxozjF1bFZ6tggy7TIhhUzXfs=;
        b=X9frYxgBAYYCJJAlXJs3qGEHG1d9v9dMNV0zCMkkkdFBPyfYGGqaTQ+lIwCHq2LQyv
         JSMX8j5Bm+GWHG1PK8kygb45FpW2dr55sOxE3sBuFVBwaFdmWMOvlpyP/sVHyaSAdo5u
         It55qE6CYCdGqpcUe69NAumMS8oc3w4c5V4hgbNcWHSNOAYgYKYQLztwvfBwc7A3lFyX
         iDmxDE7raRlsFDgwyg2imrvsprt7YZXmuFl1RX/PuUePGn5xsqya6c/hPkq1UHWARmKB
         4Q8cdUQ4eG0azvwjnDaQHmhY5gDAG8gGfz6fk558P53isAplmneiznZrHQeAy+WgRQ70
         xBmA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQBRDMpmXrTHmZYbZF18EB80OKpJAxzG39rvF7Xsr/gLYb0fpnzc/4B4O6Szpt/cQ08GZMrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VfJuP6ti323dYRlDyBaXzWjDKRMNthaZBZT7UYbb9T3OoTs7
	guddY+p6BnB/XXTxSJfWvMG1oxr1fOCEo/179ACtAK72DkNVgmD3
X-Gm-Gg: ASbGncslD5sUOt6jA8218AMajwB2bB+9udTfq/VgkZ7c5cDVECOaMsaJmBOwU9cdF2q
	0IrRn+hmlUMIhi/x2oq+xHxDRLSRdyWVPmuqFzBhumo3MXcbQVO5dpZSkzFuGkNZ1P3r2GkqsQs
	FczIdtsswRrsb+laHxt47QrhQ8RvNzECgLTWwvxWEzhHLp3mMM8zhMd6tlVodkacXkJ83ainJkf
	qzng6tUu4ix1ZJ/iRRgWPCQAoF6/UtMCJBOmdBWsdhyCFqlcIjaWrkYzP3WgPZjcrcE58wUl6jR
	F8j2Hf3n48ycElXL2qe7UuEic3dFBkRS41+VGuCB
X-Google-Smtp-Source: AGHT+IEDFD/40gt6zSyn2KjKWUB0p2WUkvFI4RMhTFPmXVmQ5T3Y72T7U/3+q7be8sq1muwPVuc2tQ==
X-Received: by 2002:a05:6a00:14d1:b0:736:33fd:f57d with SMTP id d2e1a72fcca58-739e4be3e20mr17476554b3a.17.1744079466513;
        Mon, 07 Apr 2025 19:31:06 -0700 (PDT)
Received: from [10.0.0.122] ([144.24.8.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9e9dcc6sm9595837b3a.99.2025.04.07.19.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 19:31:06 -0700 (PDT)
Message-ID: <72bd4d1d-ea06-4bcc-a77d-a56b5772c282@gmail.com>
Date: Tue, 8 Apr 2025 10:31:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Qiyu Yan <yanqiyu01@gmail.com>
Subject: Re: [bug?] "hw csum failure" warning triggered on veth interface
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <36566e86-57df-40f3-80ff-7833f930311d@gmail.com>
 <67f3e84d8304_38ecd3294aa@willemb.c.googlers.com.notmuch>
Content-Language: en-US
In-Reply-To: <67f3e84d8304_38ecd3294aa@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/4/7 22:59, Willem de Bruijn 写道:
> Can this be a packet coming in over the physical NIC, forwarded
> through veth to the container. Either using ip_forward or some
> redirect.
>
> Do packets arrive encapsulated in a tunnel and what does the
> decapsulation?

Yes, they are, by looking at the skb address information and compare the 
address to the route table, those are traffics from/to a CX4 NIC.

[Internet] <--> [CX4] <-- DNAT to Container/ SNAT from container --> 
[podman0] <---> [veth in netns]

I did not enable any special encapsulation on the internet/CX4 side.

