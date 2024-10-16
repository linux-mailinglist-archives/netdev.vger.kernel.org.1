Return-Path: <netdev+bounces-136198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624989A0F87
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB3A1C21E4C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B520F5CB;
	Wed, 16 Oct 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuHKFKLE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA112DD8A;
	Wed, 16 Oct 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095807; cv=none; b=jmY9j2UHAn87rwZE+kqPGLmOTt8OJW+G33lMt1HvxD5SFWRNYcyE84U3+SuyuIgW8PTUcyTw9x2Se8ywvbr2Skqs4lrwnVqAClqRInbSBa8Jc4xgbktkfWXkXU5JR5AD0Njka1/lyFjc6wC4MCyAdzcwUf5h54BkQZHakafKJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095807; c=relaxed/simple;
	bh=1BQ2OjRpyiDw2g2stbTQFI+FzPWBKEQi93YUtJmVsbs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KkgJfXhgbXrn9MsESgwdIb9vSqkKEff9IdH29+Y0M591TVZaR5m3Ax7HNNACawyHUO4e1ixhTRqsejcMAjqjIZsABLXuJZ20T/ZXGLgrCsxCDSRJUmbXqOB0C7YPqgu3h1VwQUhgqQUqqg8kPHg2nsB4QyTWSdksbS8DrTSp8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuHKFKLE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43140a2f7f7so168025e9.1;
        Wed, 16 Oct 2024 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729095804; x=1729700604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHQi4sDcUkh4HrcchY9/4FMu7XZ+1dZcINfwy3wM6SI=;
        b=AuHKFKLEfRB97YeaTjw1KX5Q5FFoNECrGYwxl06q+kBey5d7fBRt+ztw9A+nHRazDl
         O4Pp7NHi5Lj/Z9qO2qcsgMTYJYLCSOlmpG/USKeBSFKvkw/0RoeZOkoh0nmZGWKHkJBB
         JiDyiVFapqQf6qReuTz6Ss5H2z6Z1fZ5h/EfAIM4ugud0ZPpSqjDQZwRP3TcaALPhScu
         CqzhrIfvjvQg26ZkcaKDIauUJVZMU16HrJfQGDOU1ZrJXGhsl5M1BY28jPJnjgy3EySk
         YBTr5FrBjC/FZ0cYebknypKQFBpqYPF8qWam13r2TdAD3yJi+SOv/ygZI0OOWxoAZWdR
         kE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729095804; x=1729700604;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHQi4sDcUkh4HrcchY9/4FMu7XZ+1dZcINfwy3wM6SI=;
        b=B9UgMG6O6QITvb2/jnAwAwHRPTPuz5d2Sd9m6YZGrBvmEmI5fSdyaokdwfJxPgNbMU
         EryQiCbMdwHdgKhQyC4Q64p5JIMuc+DvEr6AlO62X3adF2pULDfzO6yNx3UDl3yPB6D3
         yCJxtBficZmAvQgRT89hORz88b917r7Hy5xgqiRz8mbpCmHS0XYwgPDtLDxYj44/T2tC
         TYFrZjFD27wuchSFIhjzSmkmkpEAlosgYWrWENN1XE7Sm7Pcm3l2FRBnTVCdN/VtbMhl
         W0CJmbKyAlR0/7pPPZt45W1vpecri6cHJZssJLtyN2jKjj2k45mZyOXHTDYj0ctWmHIS
         GxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh9CiF3WJxfjDl0cWoMCHrqTMc07qu8NjWPyiKiLo4bCrWaRr3KlHBdAK1AVm/OkUcXfXSP+aRM7PnBVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcK6khHyRV+OZGsaohe9nNJCvB/hsKmW7ttNuUR2dX/1kCpFQ4
	U89VzSIAQyTomftEcfz0TipWrQdeF+D3SPY7B/4agxUjJYrIMB3EPKUKHw==
X-Google-Smtp-Source: AGHT+IG0sUIYFY463O8t5Ty2rTEwo91mJXa/m5lTA+AfWloVFS9zJvnAeMcjLXsrrvP2xMJ1hXOr8g==
X-Received: by 2002:adf:facf:0:b0:37c:c892:a98c with SMTP id ffacd0b85a97d-37d86d70bbemr3146554f8f.56.1729095802697;
        Wed, 16 Oct 2024 09:23:22 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5d7fsm53764965e9.42.2024.10.16.09.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 09:23:22 -0700 (PDT)
Subject: Re: [PATCH net-next 1/2] ethtool: rss: prevent rss ctx deletion when
 in use
To: Daniel Zahka <daniel.zahka@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
 <20241011183549.1581021-2-daniel.zahka@gmail.com>
 <966a82d9-c835-e87e-2c54-90a9a2552a21@gmail.com>
 <43a98a99-4c79-4954-82f1-b634e4d1be82@gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c32a876f-4d20-c975-5a2f-3fa0ab229f05@gmail.com>
Date: Wed, 16 Oct 2024 17:23:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <43a98a99-4c79-4954-82f1-b634e4d1be82@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 15/10/2024 17:31, Daniel Zahka wrote:
> On 10/14/24 6:10 AM, Edward Cree wrote:
>> Imho it would make more sense to add core tracking of ntuple
>>   filters, along with a refcount on the rss context.  That way
>>   context deletion just has to check the count is zero.
>>
>> -ed
> 
> That sounds good to me. Is that something you are planning on sending patches for?

I'm afraid I don't have the bandwidth to do it any time soon.
If you aren't able to take this on, I'm okay with your original
 approach to get the issue fixed; I just wanted to ensure the
 'better' solution was considered if you do have the time for it.

