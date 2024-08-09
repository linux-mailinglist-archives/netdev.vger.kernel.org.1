Return-Path: <netdev+bounces-117250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4F94D4DF
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483041F22148
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB6720DC5;
	Fri,  9 Aug 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HtzYKJt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC841CA94
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221729; cv=none; b=HI69wb3CJr34NpyB6XnokXFo1DUHJcf3WuEpOcFnmKscC17F9haGQqZTlb7m+Bngbiws263neiNdCOl5vgCLNj/PjcXPpwSlKhKiUko0IFM+6ri0AS78MLajbcJv7Dw55r2558m9qgaPcHZ+C/3keymzmQo5ydGeDxb7AySn+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221729; c=relaxed/simple;
	bh=5QIavNohw/UnZ+iYVJ6jnEmILfZebfqlufkySWpOPPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fK/SF8raFxS2wlg5WX5PTAgEovojn+7AHD9jv7TNR4+AvrV9++TfaZTJnORhY/moucslVIgbQ2UPIe5hKhtWdy7ZFW5LXoLfkUkOvs3RuDUFqv8Nn19omYCJztir4Wp6IdaSFQBYmz2Iu0FZ9DlTCRPRdo+BLMA4FPG9oMOMgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=HtzYKJt9; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db1d0fca58so1497249b6e.3
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723221726; x=1723826526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzuVtB2v6flDP47Da5zBNwElSW8197o0ha4r0qeCzWA=;
        b=HtzYKJt9C7sbG4xnOcF8wKLM+VVy1kiDVyELmF/4Jpoh1+q8AtCS9A5fgisS6Dhg77
         6pvk4DU3c9ZHMBWg+Pehnjx2n8VFu5rceBdqJouVrDVlmVS3HbejqPHIC7Sy2vUb3zhh
         y6P1lCLTX5xbv4ZxM2xErVdeORhoCF4nQUndL3qJLJAZ8DT8eQ6JULKDJVEM3jIJTbKO
         06/wIlgDOpEQmwe/0lKq8DEQTbVwpd1gcl0THqeIeMfPLYbWBhS0X0JrMrh/wfdSrT1g
         Dm27GxgNhmbFLv8oTvkh41khW+m/NjuPYaHR3gmWs0lAnRmxOUWSs0efyLSiqtzGL4sv
         5wLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723221726; x=1723826526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzuVtB2v6flDP47Da5zBNwElSW8197o0ha4r0qeCzWA=;
        b=qOc/lnlLFKBYdDhn+H5gLAv+jNGkHhTss81LTiAgVo7adYiQR7456tw/MdbMEB3/JQ
         6Gluj0It9Es/zHT+aiJNrndAjB8Y0xWZS9hgcJ2so1zbvbNe4hzafvApc9fy4eutPFPx
         vEUGKDiPyElengNdYSeOkeEeXD+CYKNc3k9QE9g68iLhnpSv4KV5wB+o0TteBiy00umM
         652L8zaNzAmlV0cznXxWXT1noPyiVJh6B4eGiff9RPwVEUz7MhbWGWFMTEe4Kk+MUkuK
         cO/XVt6tj1CWUWXZoaWggkZ+qoWj3tPr2Y/G2VvJK3K43epszk8OzZtvyVOZecGKiE7C
         VtYg==
X-Forwarded-Encrypted: i=1; AJvYcCXbu2CZnFYwRYnpl4QlxM9H4tozT6QyiQkbwbONhMh7pvrkcuHCgdPp9LfEcgnKI+GQqG3rZafa8avNs22qcbTO317mB77U
X-Gm-Message-State: AOJu0YzpXn26mW7Tjl2gfJOiHVTKYLkdfJA3d119qZSFKfbzJr2o3T10
	LKoc1E0jUrJGIExaVgQ9CfvP8mPflg0GxLmmCdpA9W5igG/NVK/mwOZE57hAGzs=
X-Google-Smtp-Source: AGHT+IHSihy3BzUjozeYZvvsK5K12DhAcqxa8bU0v3dyqc3p2o+V1bmf3nTK94hnjncm1DJo6yMPJw==
X-Received: by 2002:a05:6808:1453:b0:3d9:e22a:8fb8 with SMTP id 5614622812f47-3dc4168b248mr2480400b6e.26.1723221726620;
        Fri, 09 Aug 2024 09:42:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2ccf1esm2820658b3a.129.2024.08.09.09.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:42:06 -0700 (PDT)
Date: Fri, 9 Aug 2024 09:42:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] UAPI: net/sched: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20240809094203.378b5224@hermes.local>
In-Reply-To: <ZrY1d01+JrX/SwqB@cute>
References: <ZrY1d01+JrX/SwqB@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 09:27:51 -0600
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end has been introduced in GCC-14, and we
> are getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `__struct_group()`
> helper to create a new tagged `struct tc_u32_sel_hdr`. This structure
> groups together all the members of the flexible `struct tc_u32_sel`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct tc_u32_sel` to `struct tc_u32_sel_hdr`.
> 
> This approach avoids having to implement `struct tc_u32_sel_hdr`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> So, with these changes, fix the following warning:
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h:245:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Tested this with iproute2-next and clang and no problem.

The patch might be better split into two parts?


