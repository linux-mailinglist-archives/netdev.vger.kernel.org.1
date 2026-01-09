Return-Path: <netdev+bounces-248396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C061D07FC1
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 09:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C931302B767
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1A5352FA8;
	Fri,  9 Jan 2026 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCC/f8gE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="on/i7mri"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F4352C3B
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948744; cv=none; b=ZWea9Wcx8+nTWaB7q5D+Ba37hF4Md38CDyVnY9bEMuv0Mtj9ye23dHxHmDWJrLT+xvIJPyrTqt2OHUpmIX4+giBlcksCZsAdbph0XLuCu0E5AKj1Z0yl0uWpNZLwf2nCHAcq5PllduKaESYs+WPA0SP4cmKZ91xcpXNdM/Qa/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948744; c=relaxed/simple;
	bh=E3NMqM+A8CEVRBGBT/M+cmeErAmFmkV5CGQbz1hlnlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcRNhTDGBqylMb/f5bns6wwEuBuuokvnosjYxz7Gog9EUVPmg3D+/aayl5G6OwS9YQdixjKM5L21eSh9H0RM5J9Z7YsU6m/a6q/jk/w/BDQN3oYK5PlqYKgRSunvhfDu3ILO+vaqPAVeFdgy2R9vR/HH0msefyr18Sw+Pn4vHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCC/f8gE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=on/i7mri; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767948737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qd3TxPrGEwbS4GVg26E8iOv4W5rh/N/xdaEX+6CIF7k=;
	b=dCC/f8gECPGM2sOhhiGDz73T1nuz5VfZ3TQDsYw2J8ddDPPQ3m01IbKuXfZwHZxVm9sxmr
	mKQw1JFXJYcHwOtfzIC16HbxdFryv57k1FKG1S9ury0aoPykW/ER6J8OT9EmVGlNynNjDe
	zUaB/TZHre0YA2Qh0b1Yx/5y7H6AqXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-glTmMvvROKmq7QCRMtmRmQ-1; Fri, 09 Jan 2026 03:52:16 -0500
X-MC-Unique: glTmMvvROKmq7QCRMtmRmQ-1
X-Mimecast-MFC-AGG-ID: glTmMvvROKmq7QCRMtmRmQ_1767948735
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso43787545e9.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767948735; x=1768553535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qd3TxPrGEwbS4GVg26E8iOv4W5rh/N/xdaEX+6CIF7k=;
        b=on/i7mriqFGTWZYVvAc0CbJ+AJCpYNvEpDYWPKqMHf6E+JfLX9Zn2X2Dv9xm+6ogoL
         u2aRDzNbOVnnr2NvkAmwiCT547u1qgSdAmBo+3n6z8VsDyuh3LOdlW9TN2zHN0dp78FU
         cK316FDu6EBtIDkiO+abtBB6ePZc2yCG+bdD78+V206MV5nkZFa7rhBK8GUat36aopxr
         Jqi0huRQwX9XZ3Ylosl4CKjLpDwK1URIEap0RmtGMBU0iDEzWhg6E7YcNh8clE2j+l0Y
         iSAUsatvaJS87FLez3LCS3C/vme+SfjOKL6IKa2c1W5mzKxJtvcebzpCYsy1gAbNoM44
         +pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767948735; x=1768553535;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd3TxPrGEwbS4GVg26E8iOv4W5rh/N/xdaEX+6CIF7k=;
        b=Jx5fAYfi+Uk0GB8FO2s2caPUCDf/mHe5+fsGM9qqKGgfbjVco7zZknVyn0nvnJiMG4
         zOrW36QZisky+C5x06pjjwOQkXbEtTLSlKIN1nZwJjzDz/ZtRI+HDZpgdONonhD8Xvk+
         CCkWXB/mgveSWtxylieuDSkg0Yr4l4w3PMt6NMYEkrqyYHsxLuGQdix6yEa3A2EV/x2b
         IDs4gUEGsLSGbvMROw0GQcGuMXNFyQFsKfW/7MmKCUPGHs36ge3h2XUjReewAqwj4eby
         41oaV7WJelNXsYpjAAbZugEZINQZvmxhw1L7yuMfCgEnEviut9MYq4NTD89IC4v0xM5B
         clJA==
X-Forwarded-Encrypted: i=1; AJvYcCXkLdhIsV8L0mE/D001qJDTLMkoeQPcbsizP0T8TyWbOgmg49n5aynDVrPxonii+qpnsLb6Uik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvLjvfZ7ZrhfIy3yfZDHaEMsaq9XHBBoz4JWgyg1H7AluUye9
	JiCzYk+JQRTBxNij+FyIR26zR4QXvuF7Qa2GYaZ6cIf4rS+p+34t2H716eSjCKLI6U6jj7xK9Rm
	tB4/5mrobisTJQu/INNpD4W8PLPSECG4Ai+Us/AjCwMY25oQH89KEwUoO
X-Gm-Gg: AY/fxX7HkiQl+j3GcxA/NRgtQRUHHWhx4DjmOcl8F249O42ja++AgqkGP0vrrD0EVmL
	WyM2R985K8gFys09Mej27BlbtxANyle9wVvmpewxyYhrSgQq1rrrIZvgegfz/jMLavXnYy9pVio
	zCTPhq2miXCwfydIwR/zH8B7t6etwrXOwi4wra7jqI5KCks6oaCw0ZzFijIgpZuNGupjml916i9
	rLC9RlsT/niV4P9D0dP2bX+84ipIe0RsHKx2NK34mbTcGIrqX0q5gKgF+W6i9AuCLBZYOBr9FSJ
	GHyghcFWCUq5WgiwQejQGgIr4I7LzEiS/l20qkjzDQ6pIWJackPX/afPWMjs0dJ7nRRSMS+uwYs
	9TdGUPee7Y/tNeS+kczSRy/cpRh7M5M1QqKJqDKvATNQN
X-Received: by 2002:a05:600c:4ed4:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47d84b40ae5mr105450725e9.26.1767948734932;
        Fri, 09 Jan 2026 00:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+OFAHyxfPesOUruCB2DRAXrjgnW+eYi4VghBgkUB+GFBY8GQZwQg5dZXLwXvSMhkSZcxTww==
X-Received: by 2002:a05:600c:4ed4:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47d84b40ae5mr105448925e9.26.1767948734236;
        Fri, 09 Jan 2026 00:52:14 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871a1e11sm55516855e9.19.2026.01.09.00.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 00:52:13 -0800 (PST)
Message-ID: <1fd29f17-a0e9-4032-8349-a85c9659a5f2@redhat.com>
Date: Fri, 9 Jan 2026 09:52:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/4] Use correct destructor kfunc types
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20251126221724.897221-6-samitolvanen@google.com>
 <6482b711-4def-427a-a416-f59fe08e61d0@redhat.com>
 <CAADnVQJVEEcRy9C99sPuo-LYPf_7Tu3AwF6gYx5nrk700Y1Eww@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJVEEcRy9C99sPuo-LYPf_7Tu3AwF6gYx5nrk700Y1Eww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/5/26 17:16, Alexei Starovoitov wrote:
> On Mon, Jan 5, 2026 at 5:56 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 11/26/25 23:17, Sami Tolvanen wrote:
>>> Hi folks,
>>>
>>> While running BPF self-tests with CONFIG_CFI (Control Flow
>>> Integrity) enabled, I ran into a couple of failures in
>>> bpf_obj_free_fields() caused by type mismatches between the
>>> btf_dtor_kfunc_t function pointer type and the registered
>>> destructor functions.
>>>
>>> It looks like we can't change the argument type for these
>>> functions to match btf_dtor_kfunc_t because the verifier doesn't
>>> like void pointer arguments for functions used in BPF programs,
>>> so this series fixes the issue by adding stubs with correct types
>>> to use as destructors for each instance of this I found in the
>>> kernel tree.
>>>
>>> The last patch changes btf_check_dtor_kfuncs() to enforce the
>>> function type when CFI is enabled, so we don't end up registering
>>> destructors that panic the kernel.
>>
>> Hi,
>>
>> this seems to have slipped through the cracks so I'm bumping the thread.
>> It would be nice if we could merge this.
> 
> It did. Please rebase, resend.

@Sami, could you please rebase and resend?

Thanks!

> 


