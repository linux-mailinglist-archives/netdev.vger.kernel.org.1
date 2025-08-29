Return-Path: <netdev+bounces-218066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210EBB3B04C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED767A38CB
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B151D5146;
	Fri, 29 Aug 2025 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPSJ8dfb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB01DB154
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429916; cv=none; b=czhtcqNWZWz+G3y9Y9EuORE92yAvEhfevjRN/hbCCbW69NpmuVRVJhP5Aj0aaHycS7HBAljs30WvbbOe8vGmAU2BXX6ZEj0CzUAVRm2w9XF7flcm2hKJqw4zuHunVnEY/bRnRJANmCxMm3tR/n9Zd5LYxMdljaSDryKLpFGMzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429916; c=relaxed/simple;
	bh=OH3iX6GfzWMasBkNeKPO6bPl7O97Usyx0RVxLJssIus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUn/9nufCHW9k1Tr71JxTRxwEmwetyhgGVvMVf0F3LQocPOEnodUfK1LOt+9TC3TCVMZm7OiEVibHKRNJ84qGuJSf7ZWIP2UUHC9YhC9PLc8UgcsbjtakQkKRoe+ua0iq95Nf4CIDnf3csJN12U6Ap/ZF0ZU1BqT8N7Pr3kKLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPSJ8dfb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso751544a12.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429914; x=1757034714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OH3iX6GfzWMasBkNeKPO6bPl7O97Usyx0RVxLJssIus=;
        b=hPSJ8dfbVEIoGwnSy8ikg7S4OKGLrjdS5XnvhRJhmwKrqOJEK59uWVoou0jWuyV3Tk
         jd5N195NbTAl5oI4lJK35/O3Ls5jBQaPwLk00E2F+InEdpIDGjLlfGGTtdm0sK2+tXcD
         mSYYmy75sznQ1ZAbsGLIgBRagRS0ua0F3wTm2lQJs44PsBK6sLXHmTfL5SPpw72Bkujb
         KXNoQyGjknNlVCx8AzdSlk5RRr4DaA8lyYac37d35v9rxq2sueQ1SFvAjyWjo+DU6tMp
         WNNHAaOoqYgZ9Nwl9vDfWbAnlRJ4Ob0N3eRNQed9IqIPvLyhtDspxsXWe40RFWzXjh3v
         frlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429914; x=1757034714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OH3iX6GfzWMasBkNeKPO6bPl7O97Usyx0RVxLJssIus=;
        b=LssL3cIAnOp3hTubvwSirFxlSW5PB+djv3lvUm28rNncxHrgp+68aQucrNrp9I9tyE
         0H1J4Pr3uI6+e+r3Fem1uXU7nFzTdLERV0k7c58JlxZI5Cwgwc2WKAnBHGpM9zbP5LA3
         /lktPVyBuXq6c+d2UbcRTA3gVP6wjlpXtOaKRdCyMQR5nDol0kObfzU/5vWyjRAuyEYT
         13F0dF92+u7fWI+Jj6azrqtH8yqCAojbOpyOiE1lgG1Q82LpzrWbHH7ALe9T38Z50ENk
         decNqkJq6pe2hMHRbsEzMqTftAcuIY70pSp3pCbTKdS19UkEAxYe+AKJr7IZGzeP0WAv
         eJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR1Vw0M+fTWgqz81at0jR/z1fDNbrltiy5X896qHkUVldnUBhwYr7EYq3rQTSMFuLYNyFK+yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBfts7tJ3EKM5HTYiLaBXpFsBXXMS/Ac+EvwTaFlxqdM7A22kA
	blwV/UwdGzlVyPqV4N/yRjnSjTvuXqLXwJ1T7ExgagmvncOm5EhnHcIBbo0J0dMqx6hVisgWy1m
	nm9ycl0kRHoTJPPnkdFSwSO8v4C5F3Pmcox2GbbC3
X-Gm-Gg: ASbGncussMn39DLkQSCnRsvP2mo3PlBfEKuAwn/wmPpUFyvCPH9JLtLT7Dam9oMtPte
	dcNGZ3UwhUeWTPn6BN8nFUqyknDyZmsmb5w2dXOQnhln+AGoSiMjzzOBj15GiIDGbcoML0whImF
	UkmaTkQZK4VROLidKOxSSMXp1uoHX6eo6HKGq2gN9z4aYV0yGr8SUIsNEus1YmZHrBPrmIk7Ro+
	7iXlbLvD8w8pEg1u7BfjFV93vQl2nT80RoHhjGy5BrkB7nMF4CM4UprRtaQ5FX7HMCPCNY8jrfe
	N33RYnHckF2/aA==
X-Google-Smtp-Source: AGHT+IF0C5LHDdsWoQctI5L18Y7FnU1v8qIlVhhuy/FpWHbULuK/hyUw1l0lYpTHQB8IXC2HKj+eNXpq4qieUqF+hrc=
X-Received: by 2002:a17:903:2290:b0:248:95cd:5268 with SMTP id
 d9443c01a7336-24895cd5bb4mr130598065ad.46.1756429914410; Thu, 28 Aug 2025
 18:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com> <20250828102738.2065992-3-edumazet@google.com>
In-Reply-To: <20250828102738.2065992-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 Aug 2025 18:11:43 -0700
X-Gm-Features: Ac12FXwPvYMSP6nX0rhpOSL_IQeKtGE_sb077pmA85kDaL3tNSEb60nh3zy9BH0
Message-ID: <CAAVpQUAd45j0GbRoSxN4RRop7FRmHFHRSm9myD61xAoy9AZ+8A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] tcp: annotate data-races in tcp_req_diag_fill()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> req->num_retrans and rsk_timer.expires are read locklessly,
> and can be changed from tcp_rtx_synack().
>
> Add READ_ONCE()/WRITE_ONCE() annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

