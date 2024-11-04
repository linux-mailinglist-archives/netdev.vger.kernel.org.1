Return-Path: <netdev+bounces-141660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8449BBEC5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4466F1F216C6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9041D0BA7;
	Mon,  4 Nov 2024 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAhPkchJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333091C876D
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752024; cv=none; b=YB/Af+HA0Cv1EuDFfZ8AtThYMz0ojm7TS1f49tfyivFFi6jv7AUqItoYY7VNs4LNzyKwBZ8uzFOV3OWKEFBKypInDzNVSpDHAtYNN7rICYek34+U/Yq1df+PxpF20b3Jrt/Q3Evr/Q9G39fmTnrJPeqMTEdYZu0FiImUziZoQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752024; c=relaxed/simple;
	bh=zdFwE3OsRShjhkCn5U/X88T0Tzr/smV8EQjUqGs3Wqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3VdrVSpHUbNJN7WYZfNurFYXJeE1b+3oq/aTsJ82epdsGuwNvhm+WRjFOwOVC/RKqS/jNQYLoQu2dYYQ3ak64rciEr+ylU8cMBTDRLy/NjBjbNt+zWO/QVbgX5FHcNkjNaGYQ7QaWEpSFC3aHHWlEcHdBqTbhzd9vlzkKaO0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAhPkchJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a628b68a7so727331166b.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 12:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730752021; x=1731356821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/UfZ4Cz7Y1bNy6RHnPO48j4sD4LyZr/skcSH+vAkkk=;
        b=TAhPkchJdNNPm+ATe3oET24V/ptXepBOCKhtCYVCsoYybDAWcUZb5gghYD7taWOWLJ
         Tgtd6Mx/IVPEThm2TEXBqGIE0ccmnxHx0F4omMuBXdp2wgNgfKVafmMiklqQpVMZQBfX
         46UdffhXw0YXIGD9adbG5/gT1KcTKhA41HKCsHRcLMGY9JR8il8fLWgBd0zxgnE0UCyc
         AD3IJzfPKyq+CU0ycf4aQN173yoZDMVnUpaMpAjSFQuoaMD0odhllu26lDwWRxXW7m8s
         /YUNEDBdQCRzeptoV7voen48oXlMdG0ln9ZI//H2vTQ8NYWdULBq5AppPqx7nq6Oecvy
         f+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752021; x=1731356821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/UfZ4Cz7Y1bNy6RHnPO48j4sD4LyZr/skcSH+vAkkk=;
        b=VKYx8X/QUu1bN29N0C5Q0BSnTYZBZHMD1zmEHByW2pEBWOud3x2c/r4o7n1MdFOuI2
         uI+Z1Gb+VLr7LJhoPBdfbN6wvuddxSpVX5bI8n9g+lkgWCxBYnvJGCQmYoHvYGDvV+u9
         1eMXkV5n5IhfH96wy9cyJS9cqk2ocyCmG5ol6EVI2FtxBQo8rza7xEed74VEatz3ZzHi
         crbu3ar0I7fnS/898J8RGGMJBaa1Ag1FIRJuCI0IrqcSi6/cx537hZn5uXLjNs6yeCKI
         j+a4HXlf6aKG52+K+Z9lf3tSgKKaAJM00I0kRaQDtoEmkBCeETVsBpeDHmJ/xJpFep0l
         aUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZkdPp1Ep/gOr5PZ49ErdMqQmaIA3foattg83IbXYmQDm8Dlark3NlA/ZQeTHpvbCSrCweoj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhks9r49hnQo4SVqaRwIZljn8U8IY4Xo6OOisGS/R04JWMZKZ
	O8RPsJNrBsyUnCQKHAA0H1VpAcDRBvycM+JUOtyLgWKgbltYi+Fp3nLSdTxP
X-Google-Smtp-Source: AGHT+IHPydjt7oTYZ5B33ZNy4xdSE4Kb27iZFcqLDIv7zCL9J1hoW+lGOR6ZRQx26VTOUZvOjTmPgw==
X-Received: by 2002:a17:907:6ea6:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-a9e654d1c56mr1236613166b.24.1730752021238;
        Mon, 04 Nov 2024 12:27:01 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d6714sm27520366b.64.2024.11.04.12.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 12:27:00 -0800 (PST)
Message-ID: <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
Date: Mon, 4 Nov 2024 21:26:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Pedro Tammela <pctammela@mojatatu.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
Content-Language: en-US
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
In-Reply-To: <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2024 18:00, Pedro Tammela wrote:
>> 
>> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> 
> SoB does not match sender, probably missing 'From:' tag

Due to dumb administrativia at my organization, I am compelled to post from my
personal gmail accout in order for my posts to be acceptable on this mailing
list; while I'd like to keep my official address in commit logs. Is it possible ?

> Also, this seems to deserve a 'Fixes:' tag as well

This would be the initial commit:

 ^1da177e4c3f4 (Linus Torvalds           2005-04-16 15:20:36 -0700   19)

Is that what you mean ?

> 'static inline' is discouraged in .c files

Why ?

It could have been a local macro, but an inline has (a bit) better type
checking. And I didn't want to add it to a .h that is included by many other
unrelated components, as it makes no sense to them. So, what is the recommendation ?



