Return-Path: <netdev+bounces-245646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649CCD433C
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6CC630062F6
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EC2236E0;
	Sun, 21 Dec 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qDAtxnzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48399224FA
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766336601; cv=none; b=sBEk5h2CvwUGZDBs5mPLc/joH0CAOWS9AZwVYnYPbiKon1UImWOkJUEz5Sx452wrt16CQSFfmw8HXjooa2isylIHSnLu1Z8rXiRJVj3KQ7SUvytucNrYFmjuhWQrbhz2X4QMn4sVuSWJMyzMzjj2aU7dfEKQBCfzXaBdYVllNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766336601; c=relaxed/simple;
	bh=8+S42+/mAnbpxEsrbwQkafA3PxBnQ1Ls+D/Wdu9w3II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GORlPrnnvlBPLCRb9OJrzzkMUVREmM+tdu7evA89MVnNCzIVs9s+gge27es6Aj4wvCPpOBlRIPeD+lqBU5Ooj5CrKhhVrCcovxZdZcfjzNME6Mc1gON366v8oFtqk9sOfBmfYGpjZDvSSbmB8liFmWLA+ql18IffA66871YqCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qDAtxnzn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb5810d39so1495552f8f.2
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766336597; x=1766941397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3xMgZXtM33QBle/Xa3xfiOz7CIUOf3uArBMCoy7EDY=;
        b=qDAtxnznIg1P72S+FF08qBjjwfORrn40kJD0EipFZAtfuXVqd7Lz5JX6BVns4xPzMD
         tLgteVMH5kFH2De0PluQBdwhsJezAIQF2IaJAkBdmCBStNfYwy1C9UqP9zljdmu3m0E+
         GAqRhvE46D7VubIc4NtxC5WHQoMcM8eL2+fuHvreDZ6xDWEA4Owk9vc4IWHYOVLVlpKa
         xFeCgeP5LQyeLsCPepCqkcX5J5g3pr+KjOuT5lhA9ECC1LIW5341bbPb67/yt3DunilT
         pNB+k0JSWwiFXGgzXIk23x5FpaifzgML2X3gVe1W52uFsyVoUk7nAjSfVUBRTXqIhc/V
         zPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766336597; x=1766941397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3xMgZXtM33QBle/Xa3xfiOz7CIUOf3uArBMCoy7EDY=;
        b=C1994q0neV5WqrwwmPpgIqNWkmFYi10Tok3mQ2GpL0VgII5h64jmpsk6C/dlkWG2S7
         qX9tFDyRpnGnFJzhGw0uZFiKO6F4vRWE1Fiz4k6FGR7FBsX1rKAc118t3V+jJHvcDfaU
         EqP9TcRZ3gi5jknLQaJfHLYkrPhVwL2DV5w41jFc9qrvfmW1XYOOrX1XmgDmw07p4STW
         w8giDb9uyCw7kqROCKggFWcq2kHvtPsugM0xbdavJY9HIWIK/e6C4p6wKwp9qDgycvA0
         cNOxKgJv0r4tG1vXOs4wpXC3NxkLYPUh5wrZVCW6Fe5Q6ezD2ZIn+rg4Y+Hnv1LMctoA
         LeBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPyR+rpRaQh1fwfTMkA6i16LZA+UHhdDAnYY6DKpjrkon10Z71bFjzJe1cuiYGcqiqQfHaPTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGxXAv4EQY6z/nPz7TzNSmGQ2H/IOhJYgoLWnEj+2YEftJbHP
	9VBihaydyJP5xI6XZiJcIr7mtTCdSLsVTbnoceqbofH+MHHN3qCU+pvd5GP6ALbN2rM=
X-Gm-Gg: AY/fxX4oxcvh3ZTS3zgsJ4VFnophPB3qrIB02LnmHoJ/ir/DBlD/57ByZiX2ppEyflR
	E6ziKzbLWxb+mG/g8xbsJQ1W0FKTsmTn0UavhSX9+24NutVeL9dxNugXMZ0om4ALyuAHHB5zKSa
	bhtqxsO4i5ouGlMtrwZNtPF2yAV2XbAwRVCQsRUU3avIQxWQPOGI0AWJ+17l8PTyDDs8gX/XqIZ
	bQ4Xwnj7Uen2bxcnivgdsN6yUruOZ8b2GImbAaeDlx7a5FVynJ/5EqpDbGy28YMxLYuwAGlOske
	E1Y4BRKPXVlLFwrXeaKngZHMk25J/qDpIkX5aP7D+avjOab+QGx/7Y9N9WBNkT1GiNhJ+3xMXOr
	poShkIYIYppGyMsKxmz003EuJJGgaNz5j7Ml4Jpj4XTwDaRjVHeLe5QAq8ifedXuvhOBIsYj8C5
	hWHYfJtseDRRPC5DSYnWxrW290bUE340g7VUy0u8+7CW3m3mEooUj8
X-Google-Smtp-Source: AGHT+IHDHNbr+z7QKBBlKH2stc/0qqBXIxmxmogpiATCnuMx30ffiXiaj+Foaw0ogwYXfWWbHTamIA==
X-Received: by 2002:a05:6000:2301:b0:431:266:d134 with SMTP id ffacd0b85a97d-4324e50c2ccmr9939087f8f.53.1766336597479;
        Sun, 21 Dec 2025 09:03:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm17589101f8f.1.2025.12.21.09.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 09:03:16 -0800 (PST)
Date: Sun, 21 Dec 2025 09:03:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Manas Ghandat <ghandatmanas@gmail.com>
Cc: xiyou.wangcong@gmail.com, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: net/sched: Fix divide error in tabledist
Message-ID: <20251221090310.60bc803d@phoenix.local>
In-Reply-To: <166583a8-272f-4e93-890e-3dabfa0b2390@gmail.com>
References: <f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com>
	<20251212171856.37cfb4dd@stephen-xps.local>
	<81d4181d-484a-458d-b0dd-e5d0a79f85d9@gmail.com>
	<166583a8-272f-4e93-890e-3dabfa0b2390@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Dec 2025 23:57:40 +0530
Manas Ghandat <ghandatmanas@gmail.com> wrote:

> Just a friendly reminder
> 
> On 12/12/25 20:47, Manas Ghandat wrote:
> >
> > On 12/12/25 13:48, Stephen Hemminger wrote:  
> >> The whole netem_in_tree check is problematic as well.  
> > Can you mention the issues. Maybe I can include that in my patch as well.  
> >> Your mail system is corrupting the patch.  
> > I will resend the patch.  
> >> Is this the same as earlier patch  
> > I have just moved the check before the values in qdisc are changed. 
> > This would prevent the values being affected in case we bail out 
> > taking the error path.  

The check_netem_in_tree code caused a regression where some valid configurations
using multiple queues are HTB stopped working.  A better solution is needed
and Cong et al are working on it.

