Return-Path: <netdev+bounces-176716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84581A6B9A0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26101760D2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB2221D90;
	Fri, 21 Mar 2025 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0kS/I9nq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CF1F4199
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555601; cv=none; b=MZYVHjyK7knWJ9GYX2pUNrWNOj9rHx9psXjeGCsnL9PnUnB7ZcQ1E9FnZfiB/3++PfBN5SB4bHkI6xYmZpSLtl0iaQcg/nvgtQBjezWlR5pc1rS9EhTh+WYO8U3BiHQx0f2juQO2dL5Qw/fECPb+WhTHWJigumf91qQWHi4eweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555601; c=relaxed/simple;
	bh=Hmzep4r/qnqv6GW31fSKCsmKzGeRT4wJnCbWjxChcS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FCDZ9F2STPdfjSpLdgXjWbBCuCt3qmfY/tow1NLjQnkcL4PCyJcM1bCWt/oV5vrww+L5F+h8tOeAvIIrULgB5zrGB/mgheq6JEaYtiBwGU4l0bdByFCdgZ2RwqXmdYlEvDyLsj1Rsu/OO/+Cs08NF/zRbUIyEK0aWCtNePhWW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0kS/I9nq; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so9320865ab.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742555599; x=1743160399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GU1mioN3yYu+dqCSLi0JNZys2k6P/lp2jvvl8BCayA=;
        b=0kS/I9nqO3NAUxktJG2RcocyuYVkyyP7jamU7na1KUS34OFrc8GaSI/szEztga6EAP
         WUMZRq+BL7VvkN4DFtjC2a9k44yiB6KfYDdxZu8rv33JY1EhN5kA+IhQUCO/Ya6iu5vB
         Odl3Gp/NE8Chn3uH3C0RAbVZfj1G6hX/E68jtBgyQLu1jiql1JgzugOlrn5GlPfHLZwI
         AhjMDJkL+nD9XI/7cCFryPdVZmv0SFTHevzArWOkAFLWLwqPuCul9RbE7zIvJDKPJyfq
         DkTU0KMnmLa8QGJIwqUFsxLcFyG9rG57oLxnY5tNjZIWoGoVTG5qdvp9lqqPyNoU/apq
         tfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555599; x=1743160399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GU1mioN3yYu+dqCSLi0JNZys2k6P/lp2jvvl8BCayA=;
        b=vpiNDdCVklB/K+6H5Bs8robjvmQJLsHq27qWPYXfzQQRxIdLE22scn2WYBDC3gDGoj
         yiXHDg6keq7VN7IBPEvP2sHXCaSqM/2xEzgNcEOAVSeEiYb03ewJ5rqwoNVSI4wYNfgs
         OqxV3l8X3fwFsJebivLmwZljERM/+KC1+X/kImZqfJpaPMQDkt+jw0pJRPG2wpWAXhJi
         PCWfYycviNNBj2tg8DWM227Tb+QmotZspU6YbVMJYhWtGizDZpMQXXsyjAE4NdAQ5Y2e
         tcsFVNKjerJpl680hX/cwGzM/Zm7mxpyRDCwQXk8yL+TtXBz4SK/Tpn97Xr5hJ20ixEV
         AMow==
X-Forwarded-Encrypted: i=1; AJvYcCV7bL7hKIRrhNTgA992ltzgkgJJMlO3a2MhreOm398F6gwVtH4emrpczHhmLdy7DknZNxEbr28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrjsaObVWpr4gV7ilZGVt+kG1NGKvXGGKV7LwHWgCajg/Z7jBC
	itvITTgmjAU18ym0ioBHzllhh0w+8pU20X4VYxarQ+gVc0/QfOm9k2BFjngZUJY=
X-Gm-Gg: ASbGncsKgeEjMHLiU9nF7Ljn/KK2D5vWr7E0S5llkSbKyMLTfMcNb3P57cqSGt2e3Fc
	v50c4uUbWTJVK29zoDrAVyT9hkGhIFne/yjAHdxHTZFZKaNnFyQiPMouBxKzNhDptL4+DKoEeOt
	/FCkB4z281JCFVi5aFZPiEU1blfXF21mdCzFPrgq/alMqagHzcyLRHihUnr6PYwG6K3sPgxk7TY
	QcgzOuDSGcvNIGswhPMnY/tU9auQfdIdzJAGEcrTIqmk24QA2QVlVSHPMI+a2dyUvS7C0KbD3vn
	md3P9mkI6xpJ7Pa7+qNU7r+aE2vJkMy4OOpkA9a+go0a6Dq0eyLh
X-Google-Smtp-Source: AGHT+IE4R72AbB+TfxAbg1d+CIr5rwWjI2An/4PBDvRcXhmPZW2MsPHBfXAQqwTzT2tbv7bQgxVxog==
X-Received: by 2002:a92:c042:0:b0:3d3:d08d:d526 with SMTP id e9e14a558f8ab-3d58e8f551amr57616695ab.11.1742555598985;
        Fri, 21 Mar 2025 04:13:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd15fbsm376223173.44.2025.03.21.04.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:13:18 -0700 (PDT)
Message-ID: <8e415edb-4d77-4e25-ab12-99f0e291aa60@kernel.dk>
Date: Fri, 21 Mar 2025 05:13:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9tRyeJE5uKDJAdo@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9tRyeJE5uKDJAdo@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:22 PM, Joe Damato wrote:
> Would you be open to the idea that sendfile could be extended to
> generate error queue completions if the network socket has
> SO_ZEROCOPY set?

I thought I was quite clear on my view of SO_ZEROCOPY and its error
queue usage, I guess I was not. No I don't think this is a good path at
all, when the whole issue is that pretending to handle two different
types of completions via two different interfaces is pretty dumb and
inefficient to begin with, particularly when we have a method of doing
exactly that where the reuse notifications arrive in the normal
completion stream.

-- 
Jens Axboe

