Return-Path: <netdev+bounces-229433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC4BDC1BE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6903B52E5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 02:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FCA2F9D98;
	Wed, 15 Oct 2025 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOFfHOG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246C25C711
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494006; cv=none; b=Ab4xCVk5cYvMTgsIiITsOMo6h/mZcPOaeOlakv1Se83rdYNnAKerfJQCLARmWVrmtzQHnLQjFVNMVrrFG3/2sv4jdoD/k6pptbFZD0jv5N+dYU6aDtVNNUzVa74pgOVtu6sHJKafhB4lZxSJtfPBqT5ytTnerKOGlzsigOme1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494006; c=relaxed/simple;
	bh=WK14FIORj96xH40drvBlojMi5RAPdVR4haPtDwAaIaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHZaDfACuhpVDJM2oY/UU16oeFWiwQ9TsnUaGMc6WharZHW85Pn8Br2NL4jUOx2rKujnFKee416CgyFf9FqjtZrbLSy41taV3pUPQmHwrTFLWSWqhZb6M+awkVMVoBESMin7PELnW9UOT9RtTBTaJxrZIQ4MERwUz8MnR3TfTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOFfHOG/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e0798so95569505ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 19:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760494004; x=1761098804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK14FIORj96xH40drvBlojMi5RAPdVR4haPtDwAaIaw=;
        b=pOFfHOG/kMZe4bKVKv4Skq55zdhbRtJiMrF9nuu1s+iWFj2dZRMIS6nIBaLGaKVSYm
         qQkRqicJ5QTTRxDdoTK+S7kjj4DjSZxiwIZr/fkuHH8Gm7Q2JMUOOLZrtkQNmZAYH9aT
         BP18ye3soGvUzXIgv1is23eXMuCF5mtwiYSWTqwkTuCBFhfz4KTVOnXbixicnrF/YyLN
         D5Z16hDAv9hlrNfNL6E/cqA+aJLH4FmTjdDb/I5O58h5DPYmsDvzpyI9pI95HnhNdqGu
         Xm1Ry7KTYTjWs2lExwimlOq5trFbdc0sha/eT7ad6AoVTTKo3cSjOeO6OyyBZiqM1cYp
         JcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760494004; x=1761098804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK14FIORj96xH40drvBlojMi5RAPdVR4haPtDwAaIaw=;
        b=IP3ytdwEJqzphrp9Z3bF3jGuonhPyuAcdO2JSZFZ/haBAZ0rkJr6q3yflvk9TXnn6k
         rDaq2JQ1tnlDjP8Q8NO4gmWyFxreLTWm1hYf3brkEAdg++L4zgFcH3LZDU7/tHaYidpk
         CQ648m1Cye3t7bM0UlsUAslnUBioSWvH7SjTH38IH1AkJAyjOb/Sox/fQMXPZwCaSwP1
         87CzC35aBzxu8VXuSS6/RjLaqkYR0j/JJ0xsgW6PRDuNC0Qk/QzyHxg2tuJs8rElO4nC
         5xz7X2Gtci4ON+TWYALqSJcSkrTPIa7NLvR/X0yL9NI4M5keuTSSzaKJMgggb/ASPpra
         zBhg==
X-Forwarded-Encrypted: i=1; AJvYcCXG8yGQZtr6DAJCI1SLDbju/hdg99gknq5H392sebnyq+1itdTgF0SO2ezY0P4T64V5Jxxwgac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk7YU1hpmm75+Siz0UePHULKpYgmky32U3bpivnlI+788T+I/
	5IiIz5o6h7nlcFWHrSqCVPMIoC6UYev1boTAbSZNy8n1RItUMhhURzWaL4o3i1KBTjoMERolOD1
	dKBYUmsl5ltaSEtyazEJyj9mNSOqbJ2Ldc0IGxqwp
X-Gm-Gg: ASbGncvsbqkPQRFDN9+JpMCys9AmrXqnTng5QfsdXwySvJWCYcXrgWSp8Eg/7eed7qZ
	pEaHtM4k0AEDqcnfWTpifKSniH9v5FJMwOk/kma77roQ6vmt6xuJYaXiu+O8oNu6wW67ZjDtgWC
	IDqWp6Vb6Yt64kgTnjyhpGpHPrEqGtMaSso+zzzIPEUqjcXevcDZkKeEBIuLFotw28LEw64S2YD
	iA1HZ5mq5XAuJbziyKR12M3DyRvberOi8JdAR4gkKIq4x1W8L8EiREYXu/4xYxmigTqyD7k1Uc=
X-Google-Smtp-Source: AGHT+IE+6xoTU5MkWj/sHFLyhIBmLNIIb/miQp3rwgY8IcgZYwbb6VMBbVj8iz0to3PmSJIk8XQOERtbEhug4WNeTLY=
X-Received: by 2002:a17:902:e785:b0:288:e46d:b32b with SMTP id
 d9443c01a7336-290273748d3mr362575005ad.17.1760494004090; Tue, 14 Oct 2025
 19:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014140605.2982703-1-edumazet@google.com>
In-Reply-To: <20251014140605.2982703-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 19:06:32 -0700
X-Gm-Features: AS18NWDQCPY9TkLsO9LhTxHRoAIQ93p7CGMcYNKUFNdDjnHRN-YoDW13snzI22k
Message-ID: <CAAVpQUCUYCA4_EchpaaZ8SafmtYkYAMKCmS9oDM3bCxzeo5Ebw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove obsolete WARN_ON(refcount_read(&sk->sk_refcnt)
 == 1)
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:06=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> sk->sk_refcnt has been converted to refcount_t in 2017.
>
> __sock_put(sk) being refcount_dec(&sk->sk_refcnt), it will complain
> loudly if the current refcnt is 1 (or less) in a non racy way.
>
> We can remove four WARN_ON() in favor of the generic refcount_dec()
> check.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for catching this!

