Return-Path: <netdev+bounces-201616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538CAEA112
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C412E6A38AE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B22EACF5;
	Thu, 26 Jun 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1vK7+7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9D2EAD18
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948702; cv=none; b=AJgNN+AxeF05iW22f3sYh+QfwRvxOA/vQ79EH1KJC7c6L6PwJ8EOjHzFvOsmCvdhGsgAcUdu+pxGITpVuhXk29r6u7LhumW6cvQutW6tpbBbsNuo0vsoQk7hI3001CBQ9A9BwAGmD1WrlE3FPlVJ1euM+cwcCa2tbJc3BB7JsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948702; c=relaxed/simple;
	bh=vJdnI8ZDQngj7w2pWaM1oHs5tlpvFFhrx5aM742X1yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWvVOPyxGO57u2Cplj+GcXEL8hIB2he2Uwz3AKaxsRoGsX2y6kkK/gGwXyU854A0iwC4SrZ13FEs2Lmj/UW7PJHY1FOUuTrcXjAcmGBQYeFsjXwr4dG3HfFbOk7R3SypMJN7cEoRUTlbY10iRrraFreCJeZErmaY5oA0RR49wcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1vK7+7m; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a3db0666f2so23913471cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750948699; x=1751553499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJdnI8ZDQngj7w2pWaM1oHs5tlpvFFhrx5aM742X1yw=;
        b=b1vK7+7mFgvhuHQECutWLP2pZZH4V3ZMsg9lA0Ic8PWDfcxm9AFB96b3l651NUsZGb
         trO/3i4Sca4SBL/oIaQ6WS0DuPZMGPBNb3q3dI9ODfM5NdhgSLgPzVQM70GRj09zYurR
         UMOXe+B4cyNon48ojyjlnHzi+5HR8gXx1GTpPSqabk+g+hifkCnTfAha+FEX3V7yXuu+
         fDokrSxjehotQT7gWnqQ+HoxQ+/RVxGEN/A3Pe/7XNCVq6IoY7D98mAmvBuNE30Igcm1
         JIaHUy0eQ2PHuERfQwdwkFPzAXxsIfe07PBxJAEvqYie1coXMTfPtDJgcXMCs57CH0EZ
         tmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948699; x=1751553499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJdnI8ZDQngj7w2pWaM1oHs5tlpvFFhrx5aM742X1yw=;
        b=cFA1cMGreJMisl8FH6f0rS3uaLbWyyS/nCsDpCbJPHlw/TgAW4gh9N7scC63cMmXWf
         ALBdxNs3yqhpzsKda+XRICKx+J+bRCw3YAujbZD9gU529LWgzE46gQSq+W53vY7VDa/B
         FzQzKTXW4x3+O2Es8ik0BFE625ogvOf8u/rDxVRjkDlSve0lnqZknxAZNCEyw2g+Hn3S
         j2Jlk7jPttpA95uB1YUVOcN2iEN2xUtpS0Q9gs5KRsGE9FjMBAz+QtKY+1MgfwBO0JeA
         CHEsmdhAYNO2m4QLU3e673K6cZKDIveD2FdNqExLef9jI66nGkl/7LFkoDV3LiY4roa0
         vsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiri2yArlhsNTmVsKY/lAjdjFBU6hFCrL2jTYPJP1RjKseRQ3ceIU8pSFLOs4cc5WD2urMAiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWkSdoh47ZryudxmUJIswQyIfurGAV/m8/oUYEwOIf76VD55g
	tHEikwNEoA1ezYAFkURyXa9iNS6jDcTfjZD9Y5cmwT6tWgL9SQUfx5dDEjMwpHRbsuI/LFFrxX1
	IJVV33+kICeJ02kZKSt1kbL/vDdk2j1YL0amcS8kl
X-Gm-Gg: ASbGncuAnVZrR+FlT8RSS+7BU8Hzz24nER9n6W4TTpngmP1dSf6HMzzXPYfa447GSNm
	6SzvR/c2RUTKbnjrkxSq8YiiEu1J67qxlFnPQoGjLa6WnfDsvczdv0mp5hMcn5ASlcU/jM+Vj5o
	NeOd4ZI2cpzvL7qbduTmN6z0MNHRF512mJhc7nR3sg8wBDjnz5agenaQ==
X-Google-Smtp-Source: AGHT+IH5M0Fb8vCL9sL55n/Wfdr7uQHSyKX8Je0OGTW2B31gWq2Nsk/AtCNobSooRsc22VQmLLw2CBzZTQyVHD5DimY=
X-Received: by 2002:ac8:5ac4:0:b0:476:964a:e335 with SMTP id
 d75a77b69052e-4a7c07d09admr94442371cf.24.1750948699120; Thu, 26 Jun 2025
 07:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-8-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-8-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:38:08 -0700
X-Gm-Features: Ac12FXyL2EnTS0sHaxDXgPlOa10M4vcA5n9dCh_5T2nrjiQLHuDL2HCWJjWctCk
Message-ID: <CANn89iJCLfdw9nZmD+nWSK6rO3xoXTPi5tXQa1AqN52S=QwKCg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 07/15] ipv6: mcast: Don't hold RTNL for
 IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> In __ipv6_sock_mc_drop(), per-socket mld data is protected by lock_sock()=
,
> and only __dev_get_by_index() and __in6_dev_get() require RTNL.
>
> Let's use dev_get_by_index() and in6_dev_get() and drop RTNL for
> IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
>
> Note that __ipv6_sock_mc_drop() is factorised to reuse in the next patch.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

