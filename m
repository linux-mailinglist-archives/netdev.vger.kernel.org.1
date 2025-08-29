Return-Path: <netdev+bounces-218067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3128B3B04D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F589189BD94
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB47019F40B;
	Fri, 29 Aug 2025 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1mlQPTa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEA288A2
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429975; cv=none; b=YnqpK72hMSxeyhBHxs7OGy2LhY6EAQpkWlEJNrOOt/LOygYQBt54YIwa2AIfX884/9Y4GqfCbpBhYxF8F8Qjm+JCdrBXchOGg8IwlPcAXExTEM2zmZow9Sf/kgtJfoRgkWThotT8RCAx/4uOYjcO5hT1Hz1REKkvB1clOnxnr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429975; c=relaxed/simple;
	bh=Sw+htma6bBnwVAe+67qJEaxofTADmJVfIwN88rZB19g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcVntILf1fx6FhSQ/o90r0hFsLh9esLyqHkA9hVfrQ4xqkSiRq+vbGFYP06t1J5F+TnNoTPFpiddWjptjgXSW05p5ZaQs5N3L1EXRLrLC2y+DkGqPsB/yzkn3f8hEYiJjgEOIyvqx6m2O1E41vPtIHDZxTD8VwYOtSFZRUh8KSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a1mlQPTa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445826fd9dso19113865ad.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429974; x=1757034774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw+htma6bBnwVAe+67qJEaxofTADmJVfIwN88rZB19g=;
        b=a1mlQPTaV0UprRY3c/hnEGh9rkmqyiDXQ91/oe9m6Zwfo21+Lb9bSLDrylh8HZH9wf
         KmI5J8HmkOa1UNIukTkMEskZiyP4/pO/i6r8Ex0Q25ioIIYqzuAoXzew0A1tbM6jYAdm
         9XGYARSfh4F/qV58RjHSLeXDnaPqsdEaHkVFeVZNtDq0L7tO16mVFhmS6LI6YKuujpx4
         EU3UsxB5jY2a55LaYXiB8tlEOtuwDxmriZosqy/R8eLDfThzMfp/NXxNh8Xg9Qmn0Mgc
         66Zxb8OOHESPDBq/7kKDP7a/N6MH/FLvt33yrBsXbhGJcSFAl5MxgQFq0IYvRHwWQpu7
         7OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429974; x=1757034774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw+htma6bBnwVAe+67qJEaxofTADmJVfIwN88rZB19g=;
        b=pAXLf7AFbnKrT6Qi6d0SDW5J/prsAGEFEVqFCqyjVVfxKKmdsDvAzHcmhE7PvZ6K18
         Dr/3qGArWCln6mNrkjyFqT0HkfL1eDgAOvmLqHf0YedCwW9oDJuOMcp7Wq+QFDVHxY79
         8Nz7vR25tXC7vXAQkj2uxvQN1htqLo5nnkMJSyTYbxDgq14EPAzW17EKloTv3WYLGBw1
         llOHVK3IqZSjxEoziQlUiP8IR+mtr7txicVTN4TmpFERilCF0/crqhopLcIcd7HsLkaQ
         zyTlKDcdxKnJUtl5afIbGYh60mP7lCImBjHmhzeI0SGnRmk05Y7duSJv2+Glv7M29Sii
         RvFw==
X-Forwarded-Encrypted: i=1; AJvYcCWBfZQE/SUpNw4tQ+m9qMf27Yys0S1/zQXirqR0cTKlYRAUgN33ufassxPxp1I/FHM1CTvuASk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSTc4Wh8WSMfGK4Fb9+w7gixWfbRYuArKmMvBDm73DiXM8HoR
	lNhVH+aIKBr0fZBqZ7sdBlSwUgHeA4mDhY8ygpeOvDL4WwFKovhMQgSuaqrO1iyrIzvtpYzC3hV
	S26CoxNoUvyBY03A4JSc5x3Ie98VHoX5x5dISLnz8
X-Gm-Gg: ASbGncsJWBRKVpA32pbDwlWmD5XNLst0iyu+fFLhi0y/bRARU4pvJfhL+Ouz3YajyKT
	v1siQnh2hPP/WqHSS3pgvALSK+Gy8ebSYckkUWG8Yj9Tc0jsm7S5JtdtuJta/W0jRaAWIQ8I6HS
	tmNdRYG9xQdqZ6J5ygRS3Z8jY3rzlA3cbIx5teCvYWrOUFYRFj1sz729f2g1/EOSBprWlBnvNW2
	Z+6jGqgJJ50HDwdSczaS+OjKJLOO73X7ZLDnNETXfgWdkqtW4uFBSEzwqQoowUMa/JzU6m+GhYd
	ymE=
X-Google-Smtp-Source: AGHT+IEzqU902CXtvsAqXiE7O/fwIdsf/VaeIv85wnxobu75D5WBitiq7pm6E5s/a3huQyoQQ9H7iKYarrKiVMh/sHg=
X-Received: by 2002:a17:903:2290:b0:248:95cd:5268 with SMTP id
 d9443c01a7336-24895cd5bb4mr130639695ad.46.1756429973540; Thu, 28 Aug 2025
 18:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com> <20250828102738.2065992-4-edumazet@google.com>
In-Reply-To: <20250828102738.2065992-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 Aug 2025 18:12:42 -0700
X-Gm-Features: Ac12FXxxCel5PzQkrBFYZHTReh1XP8ihOEhWuLK3fuZE4sFoJ5Hrcym7R6BCFEs
Message-ID: <CAAVpQUCFkcM_JFVL1ec+_=ZQj8m-8KixUoMwu4LpD_1TBnDFaA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] inet_diag: annotate data-races in inet_diag_bc_sk()
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
> inet_diag_bc_sk() runs with an unlocked socket,
> annotate potential races with READ_ONCE().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

