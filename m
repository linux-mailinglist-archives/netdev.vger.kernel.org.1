Return-Path: <netdev+bounces-220859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EF7B49365
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288D07ACF3F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC12F0C78;
	Mon,  8 Sep 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYdlS8X3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AC30DD39
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345404; cv=none; b=E36WFQnKMS2A0H90m8pf9U/WGi/K5q8GntBHP7dIn2k7sJpjaDezy5bfzF0sHaUHPfpcrwGMxoLfdsb8J/chbjk/RlKBHtzfkiy3xfHYWMhxyZCC90p6ZOTyGB9CG67XWhCTOcyiWamG5tMGcuLUFPifmhZAMbiI1JLuiPP7if4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345404; c=relaxed/simple;
	bh=5lSDnLkZ7myVZUZI6n/3qtnzVZzYmSK06DfdI72+tO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRms/IJtduTyMCtK1bLkc71L7l+oPco2aBX8zUSSBToHrf4gybsFYHQzhnBNnTTLXbAe6YdE/h4JhiziYzTfg3f9kiIOmvRe42BZXZabkBubSV+j54ARr1TateBxIFoS3rWcOyE2rz5Sc3PBXnRSYDGAfOaZIab8cwGY3XK64dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYdlS8X3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329b760080fso4345120a91.1
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757345403; x=1757950203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lSDnLkZ7myVZUZI6n/3qtnzVZzYmSK06DfdI72+tO8=;
        b=QYdlS8X38XYWzdqAMNyDbxymcmBPxTW1NEH8pM1XXAv2tn3pdlon3IwNZ15mwyMcth
         O4r9jUvl8LS9Ne8VZn9ycWF5pHggp5xXvT6wUpwq1RrfYQu28rlCNql8E00sBupn7y2X
         aSXGXJ25J3kiwueAY1NHiNxaxp1vh9qbaOBXZBG7ko9i7rAIC4wz/9H5aPaEHVsatEnx
         +Cilx3ftSX8CfUk/2yk5zjRn3+PqINAFUYAREaETqflESpf0UHl0aUibbYDalyHQls98
         u9kXyhKuX87DrMPBqAk1WOX8DUQbK7V6hAFTFnBertd1s4UtE5TErHYxbWAAlqUb3vk8
         JyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345403; x=1757950203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lSDnLkZ7myVZUZI6n/3qtnzVZzYmSK06DfdI72+tO8=;
        b=stNW1qHaJKshCuVdu5uJ00cABmEdXy93VIuVb3u76+prpcDeBfWOONbtvyNgH4rqOM
         BZTQX/nG0+BNw9naszmoic+GrdEPs6XY5gb3eFsvxpYTYeWczvunUkixu1bhzRpjOYC1
         V7It5SMQXQsJZGLtoMKxaQdxxSY6HYQlYPZbsnsHAjLIxhR3fk1Ixyx1E7QLcmviP3QC
         6MTXEp/JTxjuDElISGf5g+mdCCfM8bpAKOslG0LHPydW6AV1SbtfcvmBfulzakv+9mGX
         Qcx+LN6q6PSWwxcqcluTa8FwKdWBnM54a6EwU+3RZ7BfAKZ5uPlIaBJBBH8c66NnuNeM
         o9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZV0qUeS17ffRyCmnr+L5gFreMR7C9p3PkEzhieGGYrqgrpYFWlPX3b0fFT6rNb6WxfhxOW7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyILGI83A449RqzNUHevlpI23H9kxySurCQkjxvZKsFOi3B9iBY
	wVmtXVF70OTFS/ghAXopLZzW+E/gNlt5PfgcL8U9L2QhM23EZfbjQBEkPfBo4gtlJbim0tvIn2x
	TtVr5UkJLs+/+UPCRMN6Xui8uB0EvL4x4fTCf
X-Gm-Gg: ASbGnctGt4zW5I+moKb0ZgEdnJnsDmnmyMp7IgCxwbguSB8q7DFn+s7EMiApHsZkskA
	+Xu9v0tTodC/o51/E4gb+Yt12qZMWp+yX02Dqhg9QGgHQHHwBN0ZIWNI0LQSExm1MpzHss8JP1S
	N+rIFHxElUVcYv6S/yIt/MYdfgh5lBv+pzQCpuZvnkpjYVQa1rD6WsRJYO7B+gyrkNDlCXIWVTz
	d4fQ3NvRA==
X-Google-Smtp-Source: AGHT+IG1VchiuCSKQAMQBFpXzSTNr+XcQj06jFeE3Bf8TSY1n+W0rjq+NmhlYELQIm5gC4hGdhgaEmwUa05bBsYsIkg=
X-Received: by 2002:a17:90b:38d0:b0:32b:d183:facf with SMTP id
 98e67ed59e1d1-32d43f76ba9mr9282351a91.28.1757345402623; Mon, 08 Sep 2025
 08:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com> <20250905165813.1470708-7-edumazet@google.com>
In-Reply-To: <20250905165813.1470708-7-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 8 Sep 2025 11:29:50 -0400
X-Gm-Features: Ac12FXwujSsEKaLHoJuWiSJw3bG6wsg0eiXssQGs66CFQNtzGWQe0zwB91hZtqI
Message-ID: <CADvbK_d0QKRr0oyiQPQ5iVvYteEqcb5q-Qr=KDSa81-By7pqug@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/9] sctp: snmp: do not use SNMP_MIB_SENTINEL anymore
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use ARRAY_SIZE(), so that we know the limit at compile time.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

