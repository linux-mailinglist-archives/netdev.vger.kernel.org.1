Return-Path: <netdev+bounces-206990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D68B05137
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982354A6555
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 05:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ADB263F3C;
	Tue, 15 Jul 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKWLQJOG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232C12DDA1
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558554; cv=none; b=IQJ4YEvzWuiHqgRQbx4i+ZWOxC2igvCMNnGDh/PZmpHnniTzVkmvY0lwXokbBbp66n/FIFLYEcR65/kxcRCB8Xs2Bos59zxwP3OlBJariCpNt4KqkJZCUzaYXcRUxDeSLClu8ze3UO+PiLGilnB1v9ZEyYKSUpWh93oD7MevdJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558554; c=relaxed/simple;
	bh=kFBYaHi99g+zJqrDSAM4z24Bb53x4OJTfWRHfSVAYqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2Bnw7Zb32LFXpO61bs6SxHPKVfjAYQI/Y/zQ41zhkmgFDdDYOH2EQ7jxvIMM5SEAFEwuvGhA4iHcC2sIvfOUek8zO95xNddsMgxfMZdQL/XhzHFs8guQ5Zkwkx8m+zqOvDXT8Kepfv7YsUecGmB7Kg/v8WBFaRo2hsV8pNbw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKWLQJOG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23c8a5053c2so49192335ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752558552; x=1753163352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFBYaHi99g+zJqrDSAM4z24Bb53x4OJTfWRHfSVAYqk=;
        b=KKWLQJOGmSLjtT6M7N+YlsngrHL34OopUrpWR7m49b6uZyMYLto2Al5nnvakfGT7Dl
         pJ+hjWwscKoBlsptTgYLiyOoItdDn+MGdwmb/A2RX9+DLqrx7UHyXRabbcnEdY2ykKsB
         ax1O0/0N1a1Wz+ju5jHJ5/Mv6ASyzfGMUAcOAfHAfvml9O1XYoNPtfdU0zijJ6Dep26W
         HBb8KcOgtsxwdy5bC7DTV/wPmPAwK3q2gO2pGyrqxPg72Lm5OjCudqP1AJ5J/Sw9u9yt
         WNEUKjee97LlxwLp3jHDs9jZE7Oj/RYc25z1W2+5RLSBpxIaaW1ZlTY9BWbMl46jIYwg
         Z7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752558552; x=1753163352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFBYaHi99g+zJqrDSAM4z24Bb53x4OJTfWRHfSVAYqk=;
        b=iRpfb9Tv4EwsXOOXfe7d26mQfyBpys/3ww5HToO5/X3DbBy7I4a4qqJ14It0nt/k8r
         YAuGCMdVEOx+oMdX4/shn7x+SQfHk+D7BWfZSheEEkcY5r/vsYAPuX8H6AuKxX2UoYWJ
         e+TpEpUe07Yx1tE9j6rKAuMxEVEot1mV+ER+s/Dri05hO1slG+svs/KuhYaLPM14CAN2
         eqWixgHeZNGv9bxmUlaOvYK/sUTs87m1ZOjTycxw57BWF56uDz+kTi8FZAZMjTxoKZTr
         QkpSR1gk/aVH2+u+L52iOf4DSmpeYc/wEur4EgPYxPbsq4Ms79e7KymqwKYMGJ9MaWUN
         KtnQ==
X-Gm-Message-State: AOJu0Yw/DSEhchtCxVnhsXEjHa4t3rPJ70bZKSLw3DsERxQF3QALCvfN
	CSCZwiC3mPQSMxy9u/1E/xH5McNxX4RWTEx0MSg6LnHRzD8TyumpSiLEdqg5weUhrlOwS/JAtDQ
	9XlNm/T1rPL0wIeDnTjXzFUQW3iB7foR7IO9Q
X-Gm-Gg: ASbGncudoznthffpHtCk8KxQzrMVxLtGG5Ev6RxGiLbJF10Nhr47c3maRT2VoI0rau0
	4YuAtr633FCSo2rsxHwxWb+dLp94YOvCVN0hqANqAtbWasFQWctHpl6cvP3285eNLZb7rVSwVYu
	DC1qwSkv/2gpaxcJp4a2awEOMH97F3IGCG6SKpBA5JRY+gVhKkXOI+DyuoKI545CXyqGzfpsoZU
	3I9l1m6
X-Google-Smtp-Source: AGHT+IE00O9FqGGIu6PazW7EAC8qPfOWWwWnPJhYl9t5dEnEIs9jwyWTpbI+j0yTbAFYN4OUEu1lH5F2cpH97xvdb0M=
X-Received: by 2002:a17:902:cf0d:b0:22e:72fe:5f9c with SMTP id
 d9443c01a7336-23df0943513mr195288025ad.42.1752558552536; Mon, 14 Jul 2025
 22:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708081516.53048-1-krikku@gmail.com> <38cb3493-1b13-4b8a-b84c-81a6845d876f@redhat.com>
 <CACLgkEah6FthfCg0CX3GrJxE2Tpuqiwdfw7gHvyQKECfOYKE3g@mail.gmail.com>
In-Reply-To: <CACLgkEah6FthfCg0CX3GrJxE2Tpuqiwdfw7gHvyQKECfOYKE3g@mail.gmail.com>
From: Krishna Kumar <krikku@gmail.com>
Date: Tue, 15 Jul 2025 11:18:35 +0530
X-Gm-Features: Ac12FXyySNecCxXP4IeZQPPzweH3vU1Fb0qOtHqBUFGojN_XV4TW7J9sjnaLjAw
Message-ID: <CACLgkEYao_RjVEVgcEqwZPBmmFC+5Y=Lu7VE4Wv=WhDGEhbftQ@mail.gmail.com>
Subject: Re: [PATCH] net: Fix RPS table slot collision overwriting flow
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	tom@herbertland.com, bhutchings@solarflare.com, kuba@kernel.org, 
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, atenart@kernel.org, jdamato@fastly.com, 
	krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 5:14=E2=80=AFPM Krishna Kumar <krikku@gmail.com> wr=
ote:

> Thanks for your review comments. I felt the patch was preventing an
> unintended behavior (repeated reprogramming, early flow expiration)
> that disrupts aRFS functionality, and is more appropriate for the 'net'
> tree? If that is not the case, I will test and recreate against net-next.

Grok suggests these are to be considered enhancement patches and not
bug fixes - same as what was suggested by Paolo. I am closing this and
resending as two separate patches against net-next.

Thanks,
- Krishna

