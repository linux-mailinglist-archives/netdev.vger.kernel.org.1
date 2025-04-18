Return-Path: <netdev+bounces-184118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4F4A93639
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E02445C62
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5516270EAA;
	Fri, 18 Apr 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdv0/bXA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A474155C82
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973997; cv=none; b=T/ovlhbDQkP3w9EDeSIXY1ysFkGIgq3mNJYbrMA0aL4yxXRiY/2tkq2ptwPxs8HOM3/r8jTPMgRTpP0jFEZ4nmQ7AluHQ3JofL9hU9P7xhvEDmP0D6njtnRr5eLWk+HH3i5wzWdELuy67ZoOfcI8cb2A33/CDSmweggx5kT0Tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973997; c=relaxed/simple;
	bh=JiXwjWY/g8Zcn29jXIMWCOF3/D+1O5PQTJ+QCzs/c+0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=c2EoFEEp9ER8V6CnBtGU+LETIHaQB5ar8aoyKGN2NpvgZfbbNbMcsf9MCvIG0RxFeiDBhDOm0gvCFE9lecuwIJmzxNVDRlJVmO6qG5FGz+ZU84J4rzWckGRJ2HM1yV9haX7rg19ESxXYb50ZQdfh9bdPPa1V02H8ESIA+q07zjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdv0/bXA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso12336145e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744973994; x=1745578794; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiXwjWY/g8Zcn29jXIMWCOF3/D+1O5PQTJ+QCzs/c+0=;
        b=Bdv0/bXAPncIQcv/axTouasB7XAcH5/rc+Ma7DxbCfnK6VagIQdbMm1Hk74V9V1Yqi
         2N58KgemOJVh2YMIcixabStyCMRxGdzAOz1h+11gVYEWCJ/C4WdrdmN3vAgc3bxpquI1
         MU2G/s/2o48HjoiBcNv8sThznDGji5AxKgUJ2fy5PUCAhdJ6hwZ5YSFPVdSq5glP1EEX
         WvpyfFspS0GHfZfIr+MWp+sYO1/SYsaltZaJDbbmQv8P0qYfG6xfnyp8dvJNfe0DpNjC
         R9JBiCO168unifNH3LMJiHTBweewe0xre/X6UZ2kRExPSTqwlSn/DuPMqlmueTEG/8Ir
         4suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973994; x=1745578794;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiXwjWY/g8Zcn29jXIMWCOF3/D+1O5PQTJ+QCzs/c+0=;
        b=IybpWGIHRH21+xF+/VQ61beb+83yGfS0ubS5DNHx8VBJ1WsL41WCHPazza/Vl49nAs
         hzmO567Dgx3IVA/ae5G4uunuuszT7cPTTNoLnTAt+6lapKSRRGwmdcKKu5TuZi/KLxHp
         LsY14XgGIShGV13DsBpE2z7sug5nYBbty5pXuPsUsyczVURt14fPHf1P5tzJsxdBN9Tk
         sqZqLUM8amEwr0Us2CEG7J9DxThrU9hysWDUd1w08UNTjxIbwokLM5wYCkktp2RkJBoz
         u+g6NMn1F7PSE3Gi61KWgJQFcOf2UxjC1ha6pHxe5/1ouhYIOVhiCzXACnEf2WIEePdj
         6R+w==
X-Forwarded-Encrypted: i=1; AJvYcCU3x+rqqyvJGeugWaXo0cFkSXJdRhT0XOfWRV6QbT1lf9WFSsM8oo0RIaTEctBDswW6yzjeK6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnrTvVhD9bqQZV2Lb6bPDrcxsT9vF2A2et/qQogqMOmTgIGjE
	svntfeAnQVyRogUrAyNKjuBQXE2I+dpaEGsR4vyfvLElj+l9ONai
X-Gm-Gg: ASbGncuzvp3/a+0TRgPOoYMrxWU6CgZ+ot/+kLLVFjvL7JIlZIri7PwzRd0JFUNZr1u
	DPqV1nD8ii6bkeNne5nNHEvQIOxgeKbGtFlVly/+VECA5K/H03xRNJhN3/QpNX+ygzexQv9bopV
	IEFqsZ6T9UwAO9/MAvt6Cc6bw4yBL/lXFUa7x3pNz706I07+q4Qs/2kHETODexZzA/9anXrWSAR
	0DnXlUhiONr/CQYj/i/qURWqaY7B+9J4kTszZKR2PuPQ1Pv+GLsi+F9+UEgywUlUI+dyUjzwtNN
	WaKL5vz/9IBfCYxqnm/m2tyHMvApGuC1oxyP6KR1mE17HXR9fs7tK7ZDUIs=
X-Google-Smtp-Source: AGHT+IGUCNDdMVbqSeCvkbUWoT20AEjvb+wi+ck9ZHPR1/bqqANo4JqbpR7sMTs78qlmXoRiXaWsCg==
X-Received: by 2002:a05:600c:1554:b0:43c:ee62:33f5 with SMTP id 5b1f17b1804b1-4406ac1fd90mr18550825e9.27.1744973993850;
        Fri, 18 Apr 2025 03:59:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6e034csm17681295e9.39.2025.04.18.03.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:59:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 01/12] netlink: specs: allow header properties
 for attribute sets
In-Reply-To: <20250418021706.1967583-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:16:55 -0700")
Date: Fri, 18 Apr 2025 11:20:40 +0100
Message-ID: <m2a58dkbyf.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> rt-link has a number of disjoint headers, plus it uses attributes
> of other families (e.g. DPLL). Allow declaring a attribute set
> as "foreign" by specifying which header its definition is coming
> from.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

