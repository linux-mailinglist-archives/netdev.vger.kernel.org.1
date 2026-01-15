Return-Path: <netdev+bounces-250279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD2D26C7B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B059312ECC6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDCF86334;
	Thu, 15 Jan 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHJu26Zh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3227B340
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498082; cv=none; b=VD/L3D6ch28cS9U36JOsSeSTwtr/OPE1v9ytzafqghcrLKhVTScc9k1kdrw64Nyf5dOlHRFx/h4MElp+MnAPT6J3QDMr8mKNCsLdHrUhMO9ps8KcT1tClsl0vbGuYtYpInxVUQOkkZE9gu3G3mX3sxyJ0yWglk4iWr333Nvib2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498082; c=relaxed/simple;
	bh=FJ0sQK6gk1UocimofiLMPHqFJzVeYx3DAaltMCONWR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+6H0CVlSbd2URX7cJtuDOAnNZWwrRdUEAuW/7/JWTBBkiz5yfotcnsFjrVkaOUTSq3SRgeYLU3xBvPt4u51ARLWsHWyI1MUtCgyMjzt2sCnHS7W4NBHWFCqjC/87cM4TqqvEYr4oPOzXQe7/EMtxwMFBTgJ2uIPR8fgfDgYtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHJu26Zh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee257e56aaso13111211cf.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768498080; x=1769102880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ0sQK6gk1UocimofiLMPHqFJzVeYx3DAaltMCONWR4=;
        b=gHJu26ZhsLCYqmBhb0fXkB+Jb9p4Is8pPRjmxcJNBYIZ+WDUbQcH13il/LvDDOkXMP
         +ebvi6DuVcErRDhPQYbp75MvIyw3DfAevqUP/84HQy//Gkkje1WpVXpjvkKTwhjQ7gCh
         wR3DtjnkLXmGGFCurIYvq94GshUWgHkPZSpS3Zo+zoUWrw1xa/Dh9HYiGt328lNTgJsV
         bWrK23krehH48mLJKW0OApEoVTxub4T+HZjpAIZecAFe5PRcYonVy4CgS18grFCct79x
         4+CtrUzX37SvMjJjySSlBSsc1JoqaXB/edSKpTMf0AKmixlxqtTOp7bwV/1AfuqTDDC1
         dQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768498080; x=1769102880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJ0sQK6gk1UocimofiLMPHqFJzVeYx3DAaltMCONWR4=;
        b=MSSwlgfA7Ltoks6PA8n7Nh8thTA8DBdA5f9yvchko6R21X/zfgdBtH1weYzaEaZ9Eh
         aN/Uf2/JJcNovvzuStLMKhikkopCTVyykmA6jzhpWPh1PEZmPfsLUzlhQ7GsZCqVkarc
         7DHrDBNK3rQjbqrsjMHidatCIsWrEJhoBye7umXjshj53DSFvzOLKhpi+3Zvjcv3h6BR
         unHaaHs+o8EqveXIsgGUrVGF+RSj3ffGXJL2VwDyeAPqrCEsf90cs/E6GPGcSaLlI/9r
         tTiiX5yawqQtNiGED3TLy4lUq6VHjpgzbqRyB06OIk16wZe8+fVhU+k+XJgyRG3PY83X
         ts9g==
X-Forwarded-Encrypted: i=1; AJvYcCU24pAzM3Q13XHHW6ZnBmgHMb8H6PeIKJTue6lGBkryFwVMFum4GAxFUZtQE0oHn5AvNQRNa0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aiFMV9uHi/yKi0znw15ZurNGMjntBd/Un9y0kOXpqDGpdIHk
	bOLO5Tx0TS2LquTgKbd/C+/8yLiM9orFffCtqJ9dEoU/2vu9TUmL8qdM33YY4ZTl7uM4Zjinf9M
	91PH4h81u3GE+fb6Ktn7eBhM9wGlD+xM3YVQ38AqX
X-Gm-Gg: AY/fxX6wsZ0znWlIeKt897B7h00pQ3L6fhWRxwA42Qo5uXLNjrklUR9eh/tagbbwcuP
	7/MSIg+6BXLkhCZyHcA1tOp7W+FgVA6YI4yoTwWCUX97PRqHF2DrI3JyanNul8aJgEgfJjt88PU
	gOrbG4jm+BRVeSxxLR4nvyC7Z8VxEfm5m5cbtmkimOXGdefoDw5oKQMUbpgIXd2pgg4U29TOTK0
	u5xOwab9rCwB1L/XyusqKupbXVbCJDYYz6Pr/HXWUzAJY8b2uvWEfV+hhFw5Jsr7AjsikkFVVqv
	soQZUg==
X-Received: by 2002:ac8:598a:0:b0:4f1:8bfd:bdc2 with SMTP id
 d75a77b69052e-5019fafcbcbmr50545961cf.41.1768498079390; Thu, 15 Jan 2026
 09:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115172533.693652-1-kuniyu@google.com> <20260115172533.693652-4-kuniyu@google.com>
In-Reply-To: <20260115172533.693652-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Jan 2026 18:27:48 +0100
X-Gm-Features: AZwV_Qj6R-VRnIynUy4Wj7UXBynVpTMYPGcXTCm9-nibykFfYTHV4hXmr3n2On0
Message-ID: <CANn89iKhXwBGZo4SUBXTjcM9zEfEjSK2QF3RXPCd=mMkTMcgkQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 3/3] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:25=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> fou_udp_recv() has the same problem mentioned in the previous
> patch.
>
> If FOU_ATTR_IPPROTO is set to 0, skb is not freed by
> fou_udp_recv() nor "resubmit"-ted in ip_protocol_deliver_rcu().
>
> Let's forbid 0 for FOU_ATTR_IPPROTO.
>
> Fixes: 23461551c0062 ("fou: Support for foo-over-udp RX path")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

