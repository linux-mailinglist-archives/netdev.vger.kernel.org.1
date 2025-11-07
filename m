Return-Path: <netdev+bounces-236672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7468C3EDD3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 133B734BB12
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5A26F29F;
	Fri,  7 Nov 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yWLrePen"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B920C037
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502617; cv=none; b=ANODMx/i7kM2aYM/lWgngIjwkd6X1yxYC1iq6AIZxA+/SmQZC5yD8cxN5E8KWMhnDLPaKgjHyYALatJYnwDmsJgKFLWpV/bTQpVv6H396K2X+NisDbx40pFzOq3oRXFSNUltMXqxvhuPy2seXzR8YGFOyBE3N50YV6PmvYSS5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502617; c=relaxed/simple;
	bh=oIBZ5RQrJT6e49mGPoien2jwEDhpOShrqgkKEjbeAac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSkAS1yUIFnlWpX+4z5aRx8Lt4Aaglv+cjnVxpyVrA4SiJQZ4vVjzCl412Z7BSkMxIYYiphUi0YvRbPh3CFoIEydMrN/N8TmM0sICr6qocV4wnE47BDvMzwUORMGOtAIPSbHO5HM+0ts8FMNyYzM9Bw2n6hQ0mBgYTNIazjKLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yWLrePen; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-786a8eeb047so4563527b3.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762502615; x=1763107415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIBZ5RQrJT6e49mGPoien2jwEDhpOShrqgkKEjbeAac=;
        b=yWLrePenLXDTTbUt5QA36Whd4h/2UhMnD+MWRbJTNa4e8uVE9AymzU+zafUQIFkfBv
         xyMKOUw93WM/psGKzlr3VBVlUYyNAL5lxIvSV9cYHUpfJx9IYTVn7lncxEa3W6tUT5ao
         c3FCFIKBfJ3wJc99tBY6CVf3aRwQJ/NknwOGxV1NH66AbnPs4lF4rfitlpPb1iONx0WN
         AN+5g8ZTtoq4yHckybzKdsbLfXNk7QbVWSUm24giwyijYzHNk3iYqRoTcxoqwyqR/S5q
         HVAPDYzUGAkIR5FpquQVjoyRhbR3cJxgCIO/myMWPB+shqPFSWNrLft4jp0Kux1XlSkX
         sR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502615; x=1763107415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oIBZ5RQrJT6e49mGPoien2jwEDhpOShrqgkKEjbeAac=;
        b=KR//NIFp4+Y5JGAFF5ZzLKiukzOny4SRqiLuI3A0BCXT3yoQddJUkNyfeRVLIl79WU
         WDCmhPmy0uS8go/2PLFuUxqDTQxmrR7WyU1MgbnGIaumGMGxoC/NPbglkfx9rLSLV1PR
         oLE5GztJSOfhQx3/Mx84ygCs3ukqnxBeYliP/zHgXNjXP1Mq0QfMwjbBvbEIlqG6NsBH
         NUrwMVjDG5V8MoEkYaBH9lsEEegibqU89VMohD15AXn2bwdi7YQAepFCeohlBha0bR4/
         U6fm7kc4BKXosLLTlI/hpUsuLOICXvsaiYvuTOrJ8Oz5fOOZPWPUvYKa33HRDQklo3gf
         nNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3prAs/fcUK6KNbJ8peHTXjtutfyKo4uK6kwCgjn1hs41G8dNNVCGry2/qiZeyqvQZh76cRsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0ZJgLXspjljWuOO9mkRweMjjDGe6z/09z3lqrM7FUTaWNCrJ
	fLAXOr8VLGp3d0cnBDbUCY6f2pR+9PY3TJ1ECkmZjsZjGacJxcyeTDruvbD1lyEKWWZajKCPWD7
	u0Ftr8BSxmfORyZVZlVoRXECtTfDb7fWbjm8gRUfU
X-Gm-Gg: ASbGncvOWUo/xa70NTnf/B1vXS2VOQGgZy83jSi057NPWzWL4IiMXaQjmZMp8GPgTub
	oLdJuOx8N3xR9Yws6D12/vyqmHRp/izhc/7HJ+PJ24QEeiNMBsVkU0pecGRQFA9H4bbYFutuGQt
	tfJrnF1qCsyPkq8UgOGB4zVo8+S49t2JVAo/Qcv/ZXh5+sIhFiLMI2Gi6RR2xPFfG/fIrOrogx4
	XdYfcAKvsylo9auESTM4lM1sGK0xdtcfACPxlI1Z5l2cduNYbt4kIb6BAj7ElnNCZ4PYGtJrzzc
	M5aGRE4=
X-Google-Smtp-Source: AGHT+IEnIwELqZp9YMSwO+uSxnbiXT/146SzPixm5gaz3zVqNhyWt1vmgWqfrW9p0suZDiKTW0VUTjalGp9v56SOWeU=
X-Received: by 2002:a05:690c:a08c:10b0:785:c2bc:7aaa with SMTP id
 00721157ae682-787c53d473emr17359647b3.47.1762502615006; Fri, 07 Nov 2025
 00:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com> <20251106003357.273403-3-kuniyu@google.com>
In-Reply-To: <20251106003357.273403-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 00:03:23 -0800
X-Gm-Features: AWmQ_bnP6I9uw5J-pyzMj2zC5ApJ4t09Cy_s-vgSAWOocbfnnfZGW0PObpzEl28
Message-ID: <CANn89iLRK5Bteu+qyp0gdHgYDq6zeSE-JSDL47-zdqNZ33RSvA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/6] tcp: Remove timeout arg from reqsk_queue_hash_req().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> inet_csk_reqsk_queue_hash_add() is no longer shared by DCCP.
>
> We do not need to pass req->timeout down to reqsk_queue_hash_req().
>
> Let's move tcp_timeout_init() from tcp_conn_request() to
> reqsk_queue_hash_req().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

