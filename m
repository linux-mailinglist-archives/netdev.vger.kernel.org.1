Return-Path: <netdev+bounces-216839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B214B35720
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A423B7400
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED29E2FB632;
	Tue, 26 Aug 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIMGdEu5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E914A8B;
	Tue, 26 Aug 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197316; cv=none; b=pZAStsLd2GB1C6wasQl5QQCduyRr714tENRSqfsYmvKeRmzHMv+xk4utjmqvaJtCtvosUUfys5IK9LJmzP8Lm9J8fh+xsWp7jCrnP6a5iPqHnf29qL8sLUrKO3GxN0upnuvy6dpcShnGPOw84ruUJ4Is6c+Tc1aGVL6TkVmWLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197316; c=relaxed/simple;
	bh=wF2iqRuPq649nB8WnYrSESB/yuS8sJCOpTTxDXnS6sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0Dx+4rSUM9K1pbMsLXoGV+KDIf/JVohfd/nyzIqmgUpkH+TUVzVlHlkgH011ski0uPlPcoigdzWVi5rI3TgTbR7Y5iLLkXmD+r7tBVNbw3qFlq0FTVorIzgwqFZ95xPRekhMLitVtdhftg3Bj/9WT+u2OOEdaA1fK8zD3X30Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIMGdEu5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603acc23so41825417b3.1;
        Tue, 26 Aug 2025 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756197314; x=1756802114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac2/FoHy2PuIcNAfbmtOH9apRTI3pIQbhyR2CE6Z1Qw=;
        b=NIMGdEu53a5IW/5M5WWa8dcv8iG/PI5pN242pItMfF0m5olmtMSUHTqBy6RwqwBFNt
         3sDGdJDhznUqXHZnYSDP1YcQOZMiXX9Uo0CHsIy5yo5nqFgBCVladJPYaMkvl69fCBuC
         hMFfzZFhQWt8zwtpnFl2DUcVx1dMRrxWFQeW+Tz6tqoF3+VCy9yuMUPhBRxPOGsiPh5x
         jGZOUsMNFvVgYQk6ckIduHK5AHEqkjj8Z51E64SFZCEKIX4wvxjxihZMWehTrmpXvsZS
         srZXov5KjZd2XmEisee8NWqKnbyUBMskaV3H7S+IDjl3Tbqz2zrKKxYoRXM1i2wV3prM
         Mkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756197314; x=1756802114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac2/FoHy2PuIcNAfbmtOH9apRTI3pIQbhyR2CE6Z1Qw=;
        b=OuQxcS2hW7C5G2UY4eVrJK1DiLLB2H9XiyilcNSW2eFb/IVBHJLqqjm92n4SOCI00L
         QBLo6h7HkMGNsLn5Z5H3yLxSrBYOP8R/O4iIpXfCZa9kq+1L1dxzPt92n6YxuhuKBnGO
         QKxRcVZOKUpeGDfv9MUqquc1gD1XCOnT6ms56EK3O2xIZImO18XOXdKijsG9wnNqzbYX
         ESJkkwwuHkbnXuEHsp4tLykgaPJgX+g4ybqAZsCIH+hw1SwwEYlH8GJe2tPdN4rHDqbj
         u15ldPEHAsCTPZDbv96rmV1rU7N6wmvwVyDIuC6buGcufZvvzqbNQQ4scknmifV6EAot
         Xy5A==
X-Forwarded-Encrypted: i=1; AJvYcCWVGEGtQBAEEfI7YPKJ3txTdU2yAK8VHd2ko7te2zjLYm/BISJj2WHagzh1GjNeSbOCGmBN+MKl@vger.kernel.org, AJvYcCXJXo4Tz7dkw7xgSfqfuK2/JgFsvTwS5+VaW4JxGbWEDibZiCc/AfMSbysJFbKrguaSaN1MCKX9csMWd5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DnGaO1aETeDN67Mth4W1StrZcCpx13tQoPBpDWR0yn4e+dv/
	Vor7z/MLYk7kSnquWxeONR/s2ShyA3lTF3FWibH28e2ffELq08R/kn5Z+VVtYjQVCwoaPw+gKx2
	FZkKL3VflW+rBmtBZ4FyqwmRm5OlPqRQD8FgtKGltdA==
X-Gm-Gg: ASbGncsdD9kGovgyBBtd1bI2QuPquk/tLmn8lZt3iH0Y9yyfA10lmqqpJixx8BGaW21
	DmINiOuTKzWCkogYbZGr/xYG7IwMS1q8u33mqpMV3qh2tzDm5s+N8QIiGjNyTsYkJo8p4isSXWf
	AnE9EthqqqN/77nAShbCmtQodV1VaB5Y5g6jcopATgnyH16BIQ5dh/+jGjD1IOdEbBku7lP/T5y
	6hAfFZbQhjBx1ulS1ZD8/Nh8MAhbz9eVsQA5GkkFyzkqsICBA==
X-Google-Smtp-Source: AGHT+IEsxj9AM63XvfJuRmA8fh9Cj786c121WPw8M1n+C9wqWvFJ11QETiHRWLoG7EY1dbwavQKHqRNShZHq7/t1Grc=
X-Received: by 2002:a05:690c:c0b:b0:720:631:e77b with SMTP id
 00721157ae682-7200631f187mr88570537b3.2.1756197314230; Tue, 26 Aug 2025
 01:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826023346.26046-1-dqfext@gmail.com> <CANn89iLZUkQrsfqvEZGmz9ZVoVk1CNQzaZyCcJ53o9e2-1GTPQ@mail.gmail.com>
In-Reply-To: <CANn89iLZUkQrsfqvEZGmz9ZVoVk1CNQzaZyCcJ53o9e2-1GTPQ@mail.gmail.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 26 Aug 2025 16:34:45 +0800
X-Gm-Features: Ac12FXz2ge7S7Dy3y2jx-XnVfO4WuvDi4NOphRSkwyzQlihg9mJfEI-kpEJzPcY
Message-ID: <CALW65jZwrO5hQs_rm1Qo_+p-6yiKm+AdC9ZjkfjZnoWAm+i=Bg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] pppoe: remove rwlock usage
To: Eric Dumazet <edumazet@google.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> Are you sure that RCU rules make sure sk_refcnt can not be zero ?
>
> sock_hold()  will crash otherwise.
>
> if (po && !refcount_inc_not_zero(&sk_pppox(po)->sk_refcnt))
>     po =3D NULL;
>
> I will send fixes to drivers/net/pptp.c, net/l2tp/l2tp_ppp.c,
> net/phonet/socket.c, net/qrtr/af_qrtr.c, net/tipc/socket.c

Nice catch. I'll send a v2 with your fix. Thanks!

