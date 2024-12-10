Return-Path: <netdev+bounces-150680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9AB9EB2B3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DAF286A55
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277C1AA1D9;
	Tue, 10 Dec 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="fZVbANU4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6731A2642
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839662; cv=none; b=EGPmVtbW84WRn/sjVik+QIw56f0jpUpCaneURirWEoclWbffsfbpBuHmbUzWiJKHb7Py/1f2cnjSJEVFyYu1vmbKHezEIIsf5+TD2ACz1Ha+EtyjEvAK6N0xntE2v1G3x8aMbi4zZlWOK/S/nmy6yYuMuj4oUB1OdklS9pD/OAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839662; c=relaxed/simple;
	bh=PN9P0OZCHVXjb5PEKzNNz/5dD19d7IQhyZQGCzzg81E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XP8mrKMneXC3IjW3cZS7KmDyfsVWzJ/wPAyxl/pwgYYpu8v3+lnt74PDOdnvgnLG4odhzI0XJwIy00FtWZjKZmL2GkNcBecKVOIIlP0dbNiuaNS+DJC8t8+4xDuANkiLWmGLlgv7JXCn1yeVfXCnSfdAyNPJ7Ny3p+zwD3jPDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=fZVbANU4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so3320822e87.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733839658; x=1734444458; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P62G9a1Zb8Qnhqq1Lf59f1gM2Lc5OLJOd8rceLtX0ek=;
        b=fZVbANU4l8Eyw8d1NKYAQHuR+fGdWQGLtkWTzQzDTihTuKXYewnJ6PVNzZi1WJC+Qf
         6wpsJo0854NyPBFvYDKi+qsHw7bBTVZY4T7xvu8p1aqPjaWhhxuVogxD3ajj0NYG8g0P
         XXFy8oSxQcPSRzO7O2tPCZpKWzi2qZzNAk35xqbq4YGX3zTqPPlSMi/Ng5mV2n5fQvL1
         o4OEGDEZh0n66JRl9EMMXCJHwooCLwg2Bkghng8d+Ie9PY3dzHodWxFEqQ8W4zkkYvY1
         2/GcgIhIYpLtklAD953SlwBVXQ4+m2Vc+kuxaeb1/1z+BD+qmy2DwL3Xhfx6dY7zICUF
         DtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839658; x=1734444458;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P62G9a1Zb8Qnhqq1Lf59f1gM2Lc5OLJOd8rceLtX0ek=;
        b=Wmj1mwLZRpthYXkY40BhvzJ32U8wiBdTsMau0SVuNn1VTry/4WZIwsFyRt2VqfjP5j
         cywrDANYpvslrxBDtUmPEIBmmNEJ/W9kKty+zByk4hmmMv0iLMDLymic3DGo+dAlEnVT
         CWt7qKIXU9+VwcX0aiwX/ol2ntECa+KTAKe85S6gJDrFjgj2O+x9zPwrlQB4/QU+kTXq
         6CXubyK6zOqr00L3aJl7YCAmcgAqS83Td8n2HqbBHHoPAzS0d7ICaS1nniLt4fxWTHsH
         iBc7K7ZTIpXwJF6YHn+XokDOc/0vLka0pakPxtcayvfP7t56JERNO39Xq4zbLf47R4jD
         EL1A==
X-Forwarded-Encrypted: i=1; AJvYcCW5wg41fBkORduCtTjLkuKoTEW0im3BCaIe/Dbug4/ogD4Pi0+T50aoL5fEcvz/2IW3lHPuGXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8UslfZmVuCMMIloPxE8QPRnM7eI7SHqIqAEn4JRAIY56NJt3
	7ltjLDeArH7IgnO4+FdRCDFM0LFpm8plX2WH8vYwZj3xa2RHS25904KrV66a8ko=
X-Gm-Gg: ASbGncsEW3YUkn7HfjEmgjJMA07+cdqob4+ShI4ZT6eRkd+PqlC0HLTFI3nbEn7CeaV
	E2MyhivXLpAinsR6TMmviuGw84A9mPBPKs41h3LSaSRqtmKmhIUoHEYn/azeHl2VcKAZHC/GzWT
	7wwYQVY761RwbqMbBDN0S6D2LaLo62lyinMRscGKeU+2z0fP1/Y67rQ3wuJdB6u/9mpRngQ21sI
	Zv7EKvV0EUM8LI9QBDbUyL1BifvRmZ+99PQ/iy7wpmH0vsxjh7LkPU6A7ZLzS8FFQtKYZv8gvoU
	+u7dHiCE
X-Google-Smtp-Source: AGHT+IGEE+8eJEasCHcA24luq3w9Yl24xXxb+Kof5jHn7V5dZh7uqDT9DQ5irULEgKRdIL6BNAEwzA==
X-Received: by 2002:a05:6512:b11:b0:540:17ac:b379 with SMTP id 2adb3069b0e04-54017acb5a1mr2777781e87.25.1733839657421;
        Tue, 10 Dec 2024 06:07:37 -0800 (PST)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e2efb917asm1344755e87.205.2024.12.10.06.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:07:36 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
 chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
In-Reply-To: <a9c93b21-71e4-431d-9ab2-e73d47d12dd8@redhat.com>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <20241206130824.3784213-3-tobias@waldekranz.com>
 <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
 <87ldwt7wxe.fsf@waldekranz.com>
 <a9c93b21-71e4-431d-9ab2-e73d47d12dd8@redhat.com>
Date: Tue, 10 Dec 2024 15:07:34 +0100
Message-ID: <87cyhz8wd5.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tis, dec 10, 2024 at 13:10, Paolo Abeni <pabeni@redhat.com> wrote:
> On 12/6/24 14:39, Tobias Waldekranz wrote:
>> On fre, dec 06, 2024 at 14:18, Andrew Lunn <andrew@lunn.ch> wrote:
>>> On Fri, Dec 06, 2024 at 02:07:34PM +0100, Tobias Waldekranz wrote:
>>>> +
>>>> +	if (err) {
>>>> +		dev_err(chip->dev, "PPU did not come online: %d\n", err);
>>>> +		return err;
>>>> +	}
>>>> +
>>>> +	if (i)
>>>> +		dev_warn(chip->dev,
>>>> +			 "PPU was slow to come online, retried %d times\n", i);
>>>
>>> dev_dbg()? Does the user care if it took longer than one loop
>>> iteration?
>> 
>> My resoning was: While it does seem fine that the device takes this long
>> to initialize, if it turns out that this is an indication of some bigger
>> issue, it might be good to have it recorded in the log.
>
> What about dev_info()? Warn in the log message tend to be interpreted in
> pretty drastic ways.

Sure, that seems fair. I'll lower it in v2.


