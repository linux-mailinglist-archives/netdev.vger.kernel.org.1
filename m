Return-Path: <netdev+bounces-231630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725BDBFBAA7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B83AAA54
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B1633DEF2;
	Wed, 22 Oct 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnqcW51w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60607350A1E
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133054; cv=none; b=UibVz9LV+PwHS9qkc5xbzV0oIHLWD3DAx0gthaq/ERW6zAQKWKNIlBSxN2t/3VT4yifyHXQcbNoF6kBgvDSv4mTXDg+8+Ow479yT7aPt2DmL4a5qKTNzeJbFCWYEhavIpSYmINb/PosFf1Okb/XPq4tWdMhfN8Tr8XPcPs3DN0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133054; c=relaxed/simple;
	bh=FG/sqVsd+Fkf+vzSHEKocUTNSQsoT3V83aU84GAKYY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDm7Yk+XINKuR70bnK1/gWDJmmGoGc2sktD6ofuIU5S3LTJBhN6HCQuu2h4+q7WPANb1h9XNDqtrm4MvobeF2w973ZLd6Eql6IuUsLkp4lYwW7veAm+t/a17QosaRlFJU+3yhe+N1O3NfrrLZ2fO6bSHquDzw5wLdWeWA/5hWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnqcW51w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso20014255e9.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761133052; x=1761737852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FtzE1rGRbv5DLLs6IdqszbOo09k06GGLQDtP8qxuLo=;
        b=WnqcW51weQjU3Gms5L0SW1ZFHWG+92KccPkiO40aEri/GJwAudkF8Um6MwChdcpyse
         8/8LuAkj65yHcdzQoRu9d3swlL2bDbl4iWk8UpIYdBo6PPn5zvhR7YUu3lRgTGSe638Q
         c75CbpMuMegPz2F5YqTOB4xTbxOhsE3094pggEsB5zuP9Bs1lBsjxAPcLh6wCsHwkdHe
         9FKJUOppNWQLfBVp5irZ2FZE35N++Zi7usoQ79Gury3+kr38Cz+rectEPHUygxmG3v3S
         TkNlEbFUCQbNax1EU0vNTy111DThxkdlSmyJrJM6Gt5VjFSXK/Jnlm4YLy9OoH7DD/P+
         O5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761133052; x=1761737852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FtzE1rGRbv5DLLs6IdqszbOo09k06GGLQDtP8qxuLo=;
        b=VT2Pit+vPAYCrfqmglDedecVeiPBITVxOhNMHVu3oNZCa3gboKnm41J8jqhLUT26SR
         EB7T7r/1nn8qG/J05ibvYPk62Fpi6ia7dAGJKL4lW3uGtqoDANJ/RbWQbnQWtXDFknoM
         qqNolVTTQER17RiPbepNJ5W4xhTduHHKRP3h4Tkj4ft9sqdSprVMd4KCK6yvjBoj4FHP
         xeVf8kgIDB7KtnEaluKblVTxGEOU3D9JPoPWIkwWxd+bcvnNUzaBduO5hyhz1dmR+OOI
         f1HC9UszfpJ7CUGEcBawn9CrN1+pqwPANfAOqKWypZTcDbFS57CKXhgoBdTSaxEKwkkr
         33qw==
X-Forwarded-Encrypted: i=1; AJvYcCUqWUWlwrdtGdLwcqBZbqTkOjLPiD2ng2h7a/sD6AwEVRGyv7Gly7lh5LchiUO/oGoxwJvad8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24q921c8LJ89oQvF1PJwB+gswLWELhQ3g/gt5MswbKF77GugB
	9KjBL+4BvRKekO0+98Y9Z9tMgLbS6h6DCGSoo2Hz1Rs3gaoxo3L2ZhW19mjSPA==
X-Gm-Gg: ASbGnctZJZBKAWBuWUmU8MhLUYZ1+XWbu4gBIbiuIcwiEd+Pc1T1csCnbphaK5gf7St
	6kY40z7sbqMA/kMXuh+4gZGFiY9CVi6DKgblv9KxsoakeK+PpTOO14U+QcdV/CPOD6l6umCFwTk
	sOY0jLrsHH66fNGLyvDBaXKIwvvSLfBbfnC6oJvJtmCSYFrnr+cEzaUIZ8bQWEhwjvJvu9tC1qE
	TGTW7T4gLlHPVd7/NHmem0Ji7BSNPUAvNrwV3plX6RLLvOs/rG6aWUh5+X4D1HdY3bIcRCyASd8
	eiMMGEzQqbelzyyK2I8AL0CUxOrUTjJedO5mE24dK3GXqPsIVKQrW9ORoaSOQ7xUNSl2rI/6bA1
	f0t+EC3UQ1oLu2QKxgOER9uJlU+xzjal/YU9pMQnVi59owd7FvVlUMW5f8mldVMprKWz8n+Tvam
	2WWsM22iCtCzjKLd8iQiFZabyJW67km7AinYSebq5cylY=
X-Google-Smtp-Source: AGHT+IF1K9hk2a0iyyh3ud+8OPJTCJbS/H5dwBoY8Q+Fhh4l8AUQ8L0NbvpOr/KEqwF+bTLI+BK+gg==
X-Received: by 2002:a05:600c:3104:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-471178a5c6emr144735275e9.18.1761133051582;
        Wed, 22 Oct 2025 04:37:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:b576])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ac30b4sm36090325e9.2.2025.10.22.04.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:37:30 -0700 (PDT)
Message-ID: <60d18b98-6a25-4db7-a4c6-0c86d6c4f787@gmail.com>
Date: Wed, 22 Oct 2025 12:38:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring zcrx: add MAINTAINERS entry
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
References: <20251021202944.3877502-1-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251021202944.3877502-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 21:29, David Wei wrote:
> Same as [1] but also with netdev@ as an additional mailing list.
> io_uring zero copy receive is of particular interest to netdev
> participants too, given its tight integration to netdev core.

David, I can guess why you sent it, but it doesn't address the bigger
problem on the networking side. Specifically, why patches were blocked
due to a rule that had not been voiced before and remained blocked even
after pointing this out? And why accusations against me with the same
circumstances, which I equate to defamation, were left as is without
any retraction? To avoid miscommunication, those are questions to Jakub
and specifically about the v3 of the large buffer patchset without
starting a discussion here on later revisions.

Without that cleared, considering that compliance with the new rule
was tried and lead to no results, this behaviour can only be accounted
to malice, and it's hard to see what cooperation is there to be had as
there is no indication Jakub is going to stop maliciously blocking
my work.

In general, if I'm as a patch submitter asked to follow rules, it's
only natural to assume there is a process and rules maintainers keep to
as well. And I'd believe that includes unbiased treatment and technical
merit rather than decision based on mood of the day.

-- 
Pavel Begunkov


