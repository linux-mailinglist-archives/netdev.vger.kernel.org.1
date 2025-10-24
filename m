Return-Path: <netdev+bounces-232587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9456C06CF8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C782A1C2281B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C9239E9D;
	Fri, 24 Oct 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+tcbuFD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C511F4192
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317587; cv=none; b=iTupPhcRTTZnBN84btbJ9VAzfAPym3PE5GwWJXalxFnIjECl9q37z64GQhB2Sm+tO/f7PGHcQRoPfcaKvdHCujJ9OkZu7C5OMYZZCEDoD/EuMBGSTzHig64qPBgMvDZotYCrM8CqjsL//1h6xkaCIpcOpg6nfv/Z4Xs64LdyNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317587; c=relaxed/simple;
	bh=ZFJT/zFPdpxf7CnReiXfSJOOmCkZto6mtirRzazsPg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc9CPV2megoYacH15sOuVlg+vjPxo6asx4KadlHZL5+uk6tcKUUIhckIgc5T5JjW5fvG3C5Q9hxXYwRLkVJxTljpwnGVUSRGPmNnIt4x8KcF9KtQTNM2i3WUTnY2FuNVqpFfyWtpWgAyROdQHGOZNSAm1rZQwF5XPMw0kO3X+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+tcbuFD; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1510652a12.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317586; x=1761922386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFJT/zFPdpxf7CnReiXfSJOOmCkZto6mtirRzazsPg4=;
        b=S+tcbuFDSVBpFntYZyqL+S0oVpGmi5pKD0wy1imNmmOwJ3A3P1LZL87pY5PcMKcZ4t
         V6UNq/Yrcmqgns0quk4kmwX1O0AVkE5XoNFk+v0wdLzNGtaX62HKpc7Zz+LImfYaDG2A
         NUgPLuCAtacY6p6NuHhBKxJGlYN0g5HFzzeETbzxr06vFXXUy93MwbiqZfU5uMyeQYnJ
         L54zRq+8m58HjhJ0wwpGBeC7Xis4OdrNP1gZUS3FAJ3Gj2uWCL688204UV002CvCrhiq
         6UIhtzzjMv7PAzwKLOeOksyJ5+6CdCo2Tz35UoUPwKwhhYWP3kRLxaDW+TxhgwXr8WTI
         Euog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317586; x=1761922386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFJT/zFPdpxf7CnReiXfSJOOmCkZto6mtirRzazsPg4=;
        b=RALtdbRAP+wgRTEP6vl1WhQgBwuZ8ftRFUzLYjSEYtx6Q/3wX7Y7h2xNWjheT5gfnw
         BtnADPpLwdZFyATtp+M7oVzn2FkQd2v5hc3XoNOeEPrA9jUAqKhOqoZnf5rDDNzclooh
         D/iFH8TLQ6VRPzDj1APHqfGIIBAjE5+QeLrBVSZMM1MDIQf0bSJcGMhzkHZRnnvsugRX
         RW9xZ2s+6pfmxAlpjGv4ts4cTYtnhvJDS/HyNmDDLvhK5cfBPnxRnap24kWJIHK1d3u/
         iK51+KGkysyI90VptLcwNJUY9MVx7qG3cLxWWnOGFq1J1LD3EJRfF+8gTsKRagiS+9HD
         VTfw==
X-Forwarded-Encrypted: i=1; AJvYcCVR2IbjcHmdaNqEDrWEQeyFYURiiLxDGVUYucme/xtm+UkaazFNdu2iak7Os2AoILYh3B1JMLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHRDAsh4UU6khEOBv3Qwj6tYcmGzvaMBNSVpj8gFFqjL73pzP
	ntjb7YY0PqMKlCSROIZE4z/LIKhdYJ8MPSEt7UNXeOXjsXLVJCITI6WTeOF7mF6eQhmWDhjbPqx
	9tS6mKh0JAsVcf2esi3Zm1X0pD9ou7/g=
X-Gm-Gg: ASbGncv+H8THCgHp/O4jVZp0GkeNObdOn2N+0/l9oEJwy6X2K6K2/lkRyp+g8TCCF+G
	hPaD53ALe4F/p2NH/TwcvapjLgYNRv699vWTJy3HPbgiw3MHu84H1YzZpWoOkqWwLMB7DRoulhr
	c/ekUkJAXuHXoyw2pcAwgSuG7Oj41Bw6gVz2Uz5HqzESn/2FSZzlML50doqgnYEuI5Lwg36YsU8
	zM2M3R7qobSX7mHm65ZKf48vznFU0Yl5jBckAQvSt0xQjm3vdGbEstU0W5ZuciIQ+H9VZ3PQA==
X-Google-Smtp-Source: AGHT+IHJu8O2kjhyLPfikBasPetUHNar6epUzHrvKPxKuGCDo4EUGGFOt19Ons35bgDupeLU4i6u3rw6hlF9yTXLiAI=
X-Received: by 2002:a17:903:41c9:b0:290:aa7c:dfd3 with SMTP id
 d9443c01a7336-2948ba3c614mr35092075ad.45.1761317585236; Fri, 24 Oct 2025
 07:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-7-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-7-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 10:52:52 -0400
X-Gm-Features: AWmQ_bnUt74r2DpBDPcwbfrgZgj1UTa6pX6nrtDykJYu7O3TQTJivrt-cF7MS1s
Message-ID: <CADvbK_eTxa5usoP_xh1mfrCVxrEyiLzgwPNeUe06uFmQyxmTDQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 6/8] sctp: Remove sctp_pf.create_accept_sk().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_v[46]_create_accept_sk() are no longer used.
>
> Let's remove sctp_pf.create_accept_sk().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

