Return-Path: <netdev+bounces-137574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6A9A6F79
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B64B1F24453
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8D1DF754;
	Mon, 21 Oct 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VXZs/X4+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9219413B
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528241; cv=none; b=nlkD/GFNs3M2NLzCptJ1vDKOxD648AdQTPEx0H+jCo9LY5Pxu5qGnrg2cV2N0I+OT9X8WE6MQGLoR0mbSg8r2vKkeDa12V/1DePq85NC4ybUx1KEFWmsX/nb4QCzdxC7N9V2rqKe6488rTk4oMJcRwMFRhxxuvrQ1a4n9PE36NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528241; c=relaxed/simple;
	bh=82EnS5fxs4HAEKp3RYPaUrmzu5xS+BPxemHrEA4kBsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tB1oOvj25RVOi1bm5W8Es9Uc61LDLBitEJZkZLtuwR6A+d0A/++IfPCHlzMJE8hhl/OJnWwqYwrF/H4lch8PE+Z67kMk4Rr5aOw/UbrDNacmYjcjTkTsDyCQ6COddgYxvdyyxYTozpq9R9+3dhDMpV9dPBOVNNvIEUpmttADJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VXZs/X4+; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83aae6aba1aso173451639f.2
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729528238; x=1730133038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O20YdsRWSCZeo0YE58LeV4jhBG07ObRjvq/lCHiTEP0=;
        b=VXZs/X4+8vEvpdozs53EEejC1t03PHtinbnvakquWQNBFsAylz0KWcUnIQCvOHmA0y
         nZxty8Gep6nR5InvsgFeC7dtqdu52LaIGo0yI3uK7ps/U/nabwubfQx0Cjprs8iJhTmF
         vHY8PC3J+ZpDfUm7lHlK2P4nvNIoK3KGeUfn0TNqdlrbcmpEbXvr3BUtVxI3EeF01b18
         t4HrtMcc6B6U5esxITHS+yXPz79aXNuONkC/PQaA3eLgwcypdE11tudSyg/qNzs8deZc
         TrnTcGkOhTl11bB+o6HGbNMGVjA00BMMWdYQfE0fyP4F/DlEigAPb5NhfJxWjwU/emuc
         HOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528238; x=1730133038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O20YdsRWSCZeo0YE58LeV4jhBG07ObRjvq/lCHiTEP0=;
        b=TIEtMzERdpn5BoqI0TVNUhAiA1jm6uriIftX3kWUxNdvkK1K5ZKDPtWijaGBb4n499
         O3/4BEUM/a+le6ymm4LTxyqegfR85kp76da2fUWCifBM4KkoJXpKWZrttvOaxQV38p9j
         sFQZBCFoHXUx9hRqppzhBxs07TGV1JMrvszwRppoL8+LLgIJpKEJkzfrKvfI04QV1dLB
         cLq7so5T0dIA+dEL9q9ldi4PGHpk/r5NLwx0enwmrBMQUDt76jb92cmayz+zVnWe6Fu3
         cglXK26Klax2zt5i6hYX865P8+5u8lfVCLasfhhL495ytSVJkzXRPZyeOZJAX9toC/k0
         Tz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZycYrfhPtROBf0FQnHUwry80m2ZhSPSWa6U4hzskhBsCkFXItSzlj7Vf6/46uDpw9bBr2uk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ2DUgPrGeqyW9KD+biqh5mxAKcl6799gIwz1VJgcsKNqVoPBK
	DUgla6Rk7PpBojy6KOtSbbJ6t0scjqB+cchRGC7nL5O8GfYXdAXCFrCQVi3uU4I=
X-Google-Smtp-Source: AGHT+IFyzr5YupDPlvuIlhBH5/WK7kLbJsqNYWpaCmRhgQMF4ScdKqNoU25XKrBuyCpOWI64VfdesQ==
X-Received: by 2002:a05:6602:3410:b0:83a:a305:d9f3 with SMTP id ca18e2360f4ac-83aba645c6bmr109225139f.12.1729528238162;
        Mon, 21 Oct 2024 09:30:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a52fb45sm1090704173.6.2024.10.21.09.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 09:30:37 -0700 (PDT)
Message-ID: <cae0189d-fe75-4fd0-9b04-cb0bf1df4eed@kernel.dk>
Date: Mon, 21 Oct 2024 10:30:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/15] io_uring/zcrx: set pp memory provider for an rx
 queue
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-14-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241016185252.3746190-14-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

