Return-Path: <netdev+bounces-150109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F59E8F09
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87A31883237
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DEC2165F5;
	Mon,  9 Dec 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwtaXjSX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F86215163
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737618; cv=none; b=Gd7w/SuGH729yHyR15Ji6qqsSMrtFCd2gj88H3eV2ks1EyJgBexlHfKgzwQUq5F/aropVo0Es3Asbg0b5FqHxEgaADlD4IG0cKXzsmYfWN0afWfG1INeiSqIN+ZsjoUNN3XWaqZN04QqM/g3G8gaBQ7wBnD7j8yHpE0RrInh6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737618; c=relaxed/simple;
	bh=/4yCcmtI9X8BI1PJ3TBHSU8LfIPaaUkVMzOZ5/bpD/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X72+xq7tVaeskwkgd1dzQ4JBTPYz7IcYRPTjICxqgSX5lzuNrilYMUPSzn3GQfGzDMtOA30D+liHPSLDVjkzR2cWPQT5tmrCPc/uwA86nGcx+8B4ac8YPQnbWgyOPTVf8rVWJnmMztStUM9MJ2YYmGOpRQZ70oPNg1VbXorbS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwtaXjSX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733737615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4yCcmtI9X8BI1PJ3TBHSU8LfIPaaUkVMzOZ5/bpD/E=;
	b=GwtaXjSXK4uaAQ93UmSUdZGW/clZcH/MiiVTmNUZejondxSnfyLx8VKAMlOjcUMhrh8GoG
	ecfmmbwuR8RCBvTNBdusHmAoO5Jb9msNbWgn3f6OtDUO1RgSg2QBQxwtvupTiklbTKBKE/
	uugsJT2j6WK9eyvj0ElPQk8m5QJ4NfU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-gUGl389zOTCf5B0h-YB0lA-1; Mon, 09 Dec 2024 04:46:54 -0500
X-MC-Unique: gUGl389zOTCf5B0h-YB0lA-1
X-Mimecast-MFC-AGG-ID: gUGl389zOTCf5B0h-YB0lA
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3e4e09ae7so2028894a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 01:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737612; x=1734342412;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4yCcmtI9X8BI1PJ3TBHSU8LfIPaaUkVMzOZ5/bpD/E=;
        b=qtZnCeYNRCthqOj1GhEJxPFj01Pfac25GtcKkRbORudiz7l6C/JQwlJWl8CGFtHwUY
         tSBFx5QEkYDf+20B8psrjCVDo/IJsa1TFHIWjki4z5oDAicqWs6rGod/D2WV4r8bvC0g
         Xk8MowR60zGXcMZ5Np3AzbcgxtQI2bs6gVBmFqWC/kkBCwOzuju0Zfw+z8hd5dNA0ZEh
         LDk6bABqUiaBgisxTFF2QslgEhqApRkFjQc1O2LFINEjpjEDPZq2NkUbzPWT6SyCXyAa
         BOijb49N8TGFzA10Q4fIC0e7XxMoffBp6mcHOWhNUtX3eE2sa7oVkgqa/1sFA0v03tqf
         mOsg==
X-Forwarded-Encrypted: i=1; AJvYcCW3wCFVBEP9v6xFdDkuQQMVNPcNHhZTbsAjLLHUcNPkKUF5FkmtJMlAcLXlX5o4rNu8oujEfnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9YhbW75VDD+rH/ao1m+NmKM+503fVqNX28dWsEyw2DnOZ0jR
	p0PCCG1lDzThrIN/dbKfUeny46ZNcPjhQJrYmStImR+NTWl73BmVYVjoF9tcZQZSDHLjcA07voo
	X5Q7gD4jNrdpyzlDdbjmq5k4fQ5xy9sMgFi7vT6zWMIfq5fBl103DiA==
X-Gm-Gg: ASbGncuS+8DNcClTyF1U/X0vWoysJKRP734m3R6SezO/LNliSVd829i2MzKQurhY3sX
	iZz209sl8zoLtPj+ynYh1PPRG2Q30INUC6RcfHAQyO0E7ld/chtd9KYYKgK3NYmhXePPNot2u4h
	HAk7ORD9H/hr4Ml13sdtZni+qMOKZEBLCYIKXACVozbl0VLFdKABdJhfVsvq8rvpNXeSc3p5qGd
	yOLS1VK1EzI21F9eqsEjIz3eW+iHOrEMwzncMTPi26SeNvCz8irWos3m7cZNI/KhWM/jGVKYxo=
X-Received: by 2002:a05:6402:1f12:b0:5d0:e560:487f with SMTP id 4fb4d7f45d1cf-5d3be6b51f6mr13070168a12.11.1733737612325;
        Mon, 09 Dec 2024 01:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+SM0HMMf3rLKQaHWVX8CzFTGrQpKPYgN7rKoWJXvIPMd3Duz+8mjeqy9B/SksYJY5E9rQEQ==
X-Received: by 2002:a05:6402:1f12:b0:5d0:e560:487f with SMTP id 4fb4d7f45d1cf-5d3be6b51f6mr13070149a12.11.1733737611993;
        Mon, 09 Dec 2024 01:46:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3db53b828sm3387904a12.74.2024.12.09.01.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:46:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 84C7B16BD8AD; Mon, 09 Dec 2024 10:46:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: pktgen: Use kthread_create_on_cpu()
In-Reply-To: <20241208234955.31910-1-frederic@kernel.org>
References: <20241208234955.31910-1-frederic@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 09 Dec 2024 10:46:50 +0100
Message-ID: <87v7vt6ved.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Use the proper API instead of open coding it.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


