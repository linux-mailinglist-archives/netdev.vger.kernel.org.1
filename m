Return-Path: <netdev+bounces-231688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B6BFC96F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7ECE0348E8B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2521FF30;
	Wed, 22 Oct 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dp5c5CcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEC288502
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143754; cv=none; b=KEY7GOiGoOjE8MJUeNHEdgErNC8ExP5V36QSMYHv3KjbFMzCwem3fhvZ8Z70YTD7lt2rkhRi1/A2ne80CwVcmmJUnR8IXAP47cRCJvZGPh+CXI4Z7Kjjl99eCCwyFHQyDJ7arYZJyeeqsjVRhbfWUbZ/18U3Oq91Y9cN2dz0YE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143754; c=relaxed/simple;
	bh=n0+FVFMo3bxk2B1drC/UjH6vvWV9aCmMZ27jl1iDwkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcmczAC1sq+0WYChKqfuBdDvnB3+8nf9mAgdV7TVTmNxMdI/Xvkpl1D1KjV8Yimwg/hfJZ+fWqodwh7/eiZ9sR+n5mTdNH1rb/+9rssOvVXZh+BawsF5/i/HsvLPzEBgWLznp0R3u2wP4FdikE13I/oo/bSDsXe6gNVP2fXl7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dp5c5CcJ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430da09aa87so16757375ab.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761143750; x=1761748550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mspyCYDPZYp41/uackHpPucgl+4rC18nGgCm/5Ygfa8=;
        b=dp5c5CcJ1aHWns1OShkxQ44FKGjDCm+hqOWOqE1HgRd72EF8UaPGXWSbYHM7r8B+6d
         HJdvFk57BhSq4MFWPfJ/8M29DvwOmdOr363tQhnK9xSpWyC7n0mcCs6dYJzLWOrY9mBQ
         Ps5WfsaaBEbVRhriZC5MnoBcDvefEoQXJB19DZ7nvXyqqP6xCsJ4uwqCVufrdPPs4B5f
         SL6sZRHYHTPKzg4CaJpc41Dx9tDSZ7SSxwdtXB0T+/8IsH+AHzhZwcemUdVt3bgQ3ddr
         c3tH3k8lHDKn+dVNaV7BBZNGofeImBghsCRad3wSP3U90koPnkZ1nkFORFBXOcfY6Mm5
         diBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143750; x=1761748550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mspyCYDPZYp41/uackHpPucgl+4rC18nGgCm/5Ygfa8=;
        b=RstcDF/i9DPcfD4GqvbA3gv8vModVAAYJMDA2otpWAzM29dmQUKtluWux249hd+64q
         RlxBZ4BWTIvO/bef6+h0KjBVHFJJkROYXczcBe8UcCJGYoMotGLKRzGiAd798/BllQcr
         QK8Ee65RiOzryzkRmf08XtOMEqgIkhJLfibZ14k8H9LiGevCoC5JuajYFtadDmVM6VOJ
         WZ2hTGbL3HQF3KFupBpNuPsJcIZkN8M1n3hG8i8tWssU/ZjcH1bHSbvADO5RIoCCiU1J
         cliUq1m1sMItV3LM2hHaEeUbPw7syI/uwLJvNclEjzht+eP5/oj3JpZGdRtl697AnvMc
         eQng==
X-Forwarded-Encrypted: i=1; AJvYcCVlLTpZCNAC7SY5hGZS5VseRgKNBiqZ+SvkntILrAeNhbfcuYgaZAPGC3O/Y8xecIDskJeMTe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4Vi8lOlCWn3y7X0MlrKvsCoq4lDLUOw0bXpYXiA+su38yMu1
	6Ic4mNDJ3tgURPizRRTUpoc4WPau4KJiPYTJzhkv7KTerOsxlp0PmoeUcnQAuSAn+tQ=
X-Gm-Gg: ASbGncuYd6mgDNDWwIHqN+iVGSHOONkT9xGP4GZdIlVRqReoQn821ABPrLH2nmcg1NT
	yKQT75AcF/yd8iTXP+OZ6iEH4xJfH0J1nXUlEE5nskBc9hsARcpbyoGVwoTmlHiIYkFVlVXo+lE
	q5FlvBxja88oT582zl8gKNn5mBCnVp2ctHHb7IE1uhKoIHPGV/SIbIPq5bR8hbvY7Wz16tA55sk
	rxmbF/op+VYcwU3tu3idSEuEYUt0hNtE47Q16cdDyzVbNX40Wk9g8cySxRTjfNXMNetqB/UJeYR
	mVd5lWCI/lvwZLU5r0VtScRQW/OXjamZUL+ul4Mj6GhqidFWC1kLMhjZMk4zFfNuSmIpDBsqlw0
	WsbZieRZ+IjrGwNE6JrvSpFKB87qhywwdkjmI+0QwkFO272ZY9me6W/qi0PySJ0I1BQsvRzvyam
	L4n8yeoaU=
X-Google-Smtp-Source: AGHT+IGN4eJTVT+2/UI7BLnlYma5IHsr43gRsfgtrYleslJZuc6r9UKlrGWP+OpvLZfJIaoiMTRG8Q==
X-Received: by 2002:a05:6e02:1445:b0:430:aec5:9bee with SMTP id e9e14a558f8ab-430c524ce96mr85904905ab.7.1761143750419;
        Wed, 22 Oct 2025 07:35:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9797c36sm4973736173.56.2025.10.22.07.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:35:49 -0700 (PDT)
Message-ID: <89b2ece7-e1a5-4936-b5d5-7b484e004d1a@kernel.dk>
Date: Wed, 22 Oct 2025 08:35:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring zcrx: add MAINTAINERS entry
To: Keith Busch <kbusch@kernel.org>, David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20251021202944.3877502-1-dw@davidwei.uk>
 <aPjqn2kdgfQctr-0@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aPjqn2kdgfQctr-0@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 8:30 AM, Keith Busch wrote:
> On Tue, Oct 21, 2025 at 01:29:44PM -0700, David Wei wrote:
>> +IO_URING ZCRX
>> +M:	Pavel Begunkov <asml.silence@gmail.com>
>> +L:	io-uring@vger.kernel.org
>> +L:	netdev@vger.kernel.org
>> +T:	git https://github.com/isilence/linux.git zcrx/for-next
>> +T:	git git://git.kernel.dk/linux-block
> 
> Is git.kernel.dk still correct? Just mentioning it since Jens recently
> changed io-uring's tree to git.kernel.org. I see that kernel.dk is
> currently up again, so maybe it's fine.

Yeah true, it is not. I missed that. David, see the io_uring MAINTAINERS
entry for the correct URLs. But I can just hand edit that, no need to
resend anything.

-- 
Jens Axboe

