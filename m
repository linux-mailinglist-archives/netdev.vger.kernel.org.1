Return-Path: <netdev+bounces-249103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A4D141E9
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03B1C3026F2C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3C2FFF90;
	Mon, 12 Jan 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcQHF0XG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4C283FD8
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235938; cv=none; b=oK1y8lDwksw0i68Q7Mxq6GgaIsqtvAxb5GxzzjHc2KZ8Xtzd250BTjQhcbkZBe9/NQm6qpDR8YKqukdwgV8lPtQbtYKi4OtakXWhclN0ie4aF7XGVb5VtOHVeibfU/bKn6xa9LhE+TwZChxb2dSZuiFGd/3/8qQBu8LBf1S1RwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235938; c=relaxed/simple;
	bh=B7swZwa8RHe9Ed3gA1s4NKTAtATSn+kI+HtfvUqzn3c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SkjTg1quZYhhEYiN3SHCdVW8Agcb6b3k8sh+Z6tVwea+A533u9g2usCnaX62696yV9g9rbEKDsXrrWY3gJO1rpl6OKLwy6BnBo65ZoxpoXE/vuVBxXkMT237z1yuzt7ED9DwjUbXE1kU1V29WMPP92+IGsfCYcJQ5VLXhiVZXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcQHF0XG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927b1620ddso23396157b3.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768235936; x=1768840736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1PD6OUIqK72eJtKb8WZKvNg2Z4vvkTyx18AXjOTw+o=;
        b=NcQHF0XGZkTZLzbfiN7wQH4HlXg3RLgCEi/wnPQVY4W4cZCDetTbixQi6411jwUuNO
         9iH8a/cQMRyZy3J3yhXN72JmUqcYhcKznAtFIvzcP8wT1C3MxYXX2LZpUlj7rVF9KfVd
         XC/KClSOgCN8AxbesCtJovRiMsKTzwxDW8gnhyRHj6Edr9bmkjUGFuDbRJNPLTlt/PfH
         /FTnkc/sWesD9KIADTgw6105vV9sMnuxvCH4S6LfFPimD8Mi1EPW56MqL1TXUz0yRkk6
         voP3tihHN8+zMokjpNi+t/ZB7jWEO4FVIvfbshZf07Sd2vvIFkgwWEDbqplQUHXrjP+7
         Zbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235936; x=1768840736;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1PD6OUIqK72eJtKb8WZKvNg2Z4vvkTyx18AXjOTw+o=;
        b=iYu1H0xpL9HnB4Zs+lBaiUvdLUz/A8hYpL5jN8n5Amvyy43aKj/JJEEQs8EVG/rhmK
         jv3TKR2O5NnF7ZMzUAcLL7Yn1N8bqSMESsYQuM7AnAMiIkS461lX9IHa0XF1CKSmK/F8
         BMeHF6ja+WfjK4ZsSsHouGsSGL+jXtgvhSD0wAGkLDzS7PqWdtLQUC3Tn45Bw+iiKCl7
         94jC265MFqrTPlvD4ocZanBkzFKau7UsYJtncUh3jUmAktYqvXcbPnZCY/Vu4gQ+/rl6
         lgkBnTh0dlYK/77RR5oSckiBjBRCBfW81vIacAPgWBUj7wz3Wv/zoK8Wf7n3XPOmy/ri
         TTig==
X-Forwarded-Encrypted: i=1; AJvYcCV1erLGyiQ+nIzrfrDPY35XAww1d1w0A2+LTq/aXKVp0Oc6W1Z99gE7FTEuFaoG2yUqZ5bzHgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SGPFP4SmrQGKSMym8akt3uJCtXJdq44gH+qBlfm+zcJaptHN
	xZqnhtyB4+PAFJc54EMoKoblqpRGi0ZmekwKs6C/ISBX6d/vFE7GYzgA
X-Gm-Gg: AY/fxX5hWjuQAbJn6blL0kB24cueHxL7OGNKiqano53UFKTjCd2p4+buiqRXjg4IU2H
	oOvWmUyyS1xi8B28Od8zOhq7lzZqz69XIHfim+XIbRrZcgyek5swp0dRGkhCOPCtuko8TAbl6oH
	ckL64IyVJS5lIbLha8C1i3H0ayiN1Zve6rmVZiWsTTU3JXjGkVuWWDVtBzrxbQ0tzea05Yp2Uyw
	n2enphNdWJm8U/Q7tt+SM3Asx5B3GY9xtfRsA9G1DSF4MlnYfaaolnAMVzxKiR9Afx/YlONbm1x
	wcrRsBKapTs7mlc8QDMatG3DhurjZmzIpZeIwpiF+GsZLJAcnoac6P2R0+yi70hb0jHa4XoiKIC
	cDsNtGlIil66L+P7brEZR/CyklwN8Et8Km93MvQa2awdnnpdhbM7u5CO6fHM9TJ/SeCrLuz5m+H
	9jaVRcR3s6T5ZXzY+LojdWjXJu0Jy8G2cPXORwW60AKVwuAyeCIFHgY0cjYxU=
X-Google-Smtp-Source: AGHT+IEJ7J1f5iMRJ7iTYZ44RfHB3q6SnE1EW/YnjBBKLwKkh+LFU/U4jooTbc35ulAxuKa1pRbt+A==
X-Received: by 2002:a05:690c:17:b0:78c:2c2a:fc53 with SMTP id 00721157ae682-7938d58b89cmr107657b3.15.1768235936330;
        Mon, 12 Jan 2026 08:38:56 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa592cdcsm69951587b3.25.2026.01.12.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:38:55 -0800 (PST)
Date: Mon, 12 Jan 2026 11:38:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.1ebfc524172ab@gmail.com>
In-Reply-To: <20260112062934.6d1b60c5@kernel.org>
References: <20260107110521.1aab55e9@kernel.org>
 <willemdebruijn.kernel.276cd2b2b0063@gmail.com>
 <20260107192511.23d8e404@kernel.org>
 <20260108080646.14fb7d95@kernel.org>
 <willemdebruijn.kernel.58a32e438c@gmail.com>
 <20260108123845.7868cec4@kernel.org>
 <willemdebruijn.kernel.13946c10e0d90@gmail.com>
 <willemdebruijn.kernel.555dd45f2e96@gmail.com>
 <willemdebruijn.kernel.311e0b9ad88f0@gmail.com>
 <20260112062934.6d1b60c5@kernel.org>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 11 Jan 2026 22:28:39 -0500 Willem de Bruijn wrote:
> > > Can fold in the record_timestamp_usr() change too.
> > > 
> > > I can send this, your alternative with Suggested-by, or let me know if
> > > you prefer to send that.
> 
> Looks like we got 30 clean runs since I added the printing change 
> to the local NIPA hacks.

Wow nice.

> Let's start with that and see if it's good
> enough? As trivial as the change is I have the feeling that is has
> to be something trivial for us to fail 30% of the attempts.
> 
> Please go ahead and submit with my Suggested-by.

https://lore.kernel.org/netdev/20260112163355.3510150-1-willemdebruijn.kernel@gmail.com/T/#u

