Return-Path: <netdev+bounces-244456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C783CB7E46
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 05:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40F6A300EA2A
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 04:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABBC2FFFAF;
	Fri, 12 Dec 2025 04:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="U/uYAEaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C472602
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515333; cv=none; b=Qbkm3B6/daoCE0K9RboRUem+EW9222xBq4wRBOG3coS1BBuq6oGHpWImswH0roS1BYwkgyFHIm5mJpkub4QCXrl4Y6NJOUycsKY/c6AURRftUwt4dLy0m2h3EHy62d20BCrguk2ZSVI5H9+S+bfraEWd9pGXkLCa5Uy8gXbeEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515333; c=relaxed/simple;
	bh=NMfje1ccG1T7n+I63z4jAaDAHhF14yriMunadZNuVTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQOqJCFBlarwsD0BZw0DI5gwwU7vT9Fy1g+6jpi/0ZRWynpT3XBpwsC52dH14+yKDlBVVyj3WI7TC3vDAj45RI6ZykFPh2Qh/K8X44OyKnKE8XguE0Cyj10SYCwgpNhzpbkhcs71OSaheTXNfz2jVXjsT3nzOcq71sl/rjNjpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=U/uYAEaz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso869749b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 20:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765515331; x=1766120131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1umCV7pjEEHE4/qmsgbEVQJKX6SXIq1i7QVMIcTPO0c=;
        b=U/uYAEazL/gC9W+rgzc3ymjmBctet4ZgdDBBsBqHTYuvkUb92QKWBbG1Bq94np4664
         UApBrvAU9hJJRhHBtiJrTpZ72qmnd57OJOdSogg5mT6rfBwNwQmOKSt2ZdMYzT5Hfa1q
         Xfxw8RR6jz/Qu+a3+eLvuO+biq9IuqtDPB/zUJCACYHBRMjJWkDH5OPZmOXwHW3WCbn4
         0Tqhs7eCutXOewiOBJZ6vC/oWd8DB/Omv1I6BpYM3fGrbNn/YMvHhVw54HkzdvykEfJr
         IsdzpM/K6MhPORGfxaem2p6alTHRw4/mk//y5Vz/LG8/YLUaGgR0n9ZCDJ+5V99mtxR7
         SVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765515331; x=1766120131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1umCV7pjEEHE4/qmsgbEVQJKX6SXIq1i7QVMIcTPO0c=;
        b=NHrMhnqsELzBhH+ZQPmoAsrhauHUCO6nTFUZGyPaSPR1cdmeaaOg9uPz6R/zVgKHbq
         vWI/vJVpBx3niVjJrZ/JzTvynOX4NWM7vMgfYPrmgC42XQt5P1J4RcmpCAdon+fEpfbZ
         Kl8XEsw+4zxBUxwHVnY31NpnUJzjf2j5EL0HlWpbrPDm2iweKTOYIGcZdtvqPLPoFe6R
         UBNz/AssYJMMS/pIpVYrKtuwjh7fIaNf9adIuc1tpLOWfFkfBHmeGzfJXQdYvDvOCllX
         bjGP5zu7n6up8L0iN3qxgtshMFDl0CGHkTgCyRCav2pmIJa2+YDOpNvLs+B33+Rc0M6p
         0Ybw==
X-Gm-Message-State: AOJu0YxvDMxeOuMa3bXnXwglPAJcTuAWfngGUeUlfmwYpWqG79WQtUG6
	bJhiMXNPtPvm/1mOrF6Nd+3CtujiILEhYcOtxzNXzqDdfEjT0TEQ+MqrZrU60ssYAwk=
X-Gm-Gg: AY/fxX6rF3Pb21q2STA/mcCtMfjvWLOuGlUXq9gkOUpr+zIVRHHLO+eIKyJJreMi4QR
	VWwuUZgwg/KRY2c03+U/Ex8JWCKXSTQ6S+luR/ZkyRIAFmlP1iMmq95JVJl9Pp7jlmKDbluzb8S
	onFEazEQng2LO6LrXpuHZQ+eTVRa8C0FNlUoA4d/MCfslZw+vnB3F0duUPHskJiUL+0dsjLQWJ4
	1txkrolWENtc5cQ9OpWlT+kNwuJX/q0xuCbqsv2bSOoeLbGQufGhtdJnkNRLhdOmrNr7CK4ZwBb
	qqExrQD0OcReCQFl1Z0bZqeGEjcn4VE0SsBS2b8CrjRtps1NjMsk7jTo7sDt/El0JPDBw0DSLWi
	z/5k3IPyv5Ums93+DRF8gsCz+E3HwMPozhtZjbbg5smal0Z1iXAYik6dRMR1s3ABqpd/gnLeJzE
	ij83DrR4iEJrHdR/526nDeSExEerb+xR6yImg9K20C3l1uzOi0VLr0Vi7TWvAW
X-Google-Smtp-Source: AGHT+IEjAinDbl2ZZltNFHDyNS1HihGMUO7M2IPYOG3I4r4S2L/ZXHqvWMIauiKPl3hd9CDAC3+Yqg==
X-Received: by 2002:a05:6a20:a106:b0:35e:2a82:fdf9 with SMTP id adf61e73a8af0-369ad9d676fmr886817637.16.1765515330740;
        Thu, 11 Dec 2025 20:55:30 -0800 (PST)
Received: from stephen-xps.local (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe32d3c8sm222698a91.6.2025.12.11.20.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 20:55:30 -0800 (PST)
Date: Fri, 12 Dec 2025 13:55:23 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] lib: Align naming rules with the kernel
Message-ID: <20251212135523.432c07a9@stephen-xps.local>
In-Reply-To: <20251212042611.786603-2-mail@christoph.anton.mitterer.name>
References: <20251212042611.786603-1-mail@christoph.anton.mitterer.name>
	<20251212042611.786603-2-mail@christoph.anton.mitterer.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 05:18:13 +0100
Christoph Anton Mitterer <mail@christoph.anton.mitterer.name> wrote:

> This aligns the naming rules with those of the kernel as set in the
> `dev_valid_name()`-function in `net/core/dev.c`.
> 
> It also affects the validity of altnames.
> 
> Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
> ---
>  lib/utils.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/utils.c b/lib/utils.c
> index 0719281a..e4e5f337 100644
> --- a/lib/utils.c
> +++ b/lib/utils.c
> @@ -851,8 +851,10 @@ static int __check_ifname(const char *name)
>  {
>  	if (*name == '\0')
>  		return -1;
> +	if (!strcmp(name, ".") || !strcmp(name, ".."))
> +		return -1;
>  	while (*name) {
> -		if (*name == '/' || isspace(*name))
> +		if (*name == '/' || *name == ':' || isspace(*name))

Do you check that this didn't break the legacy ifalias stuff?

