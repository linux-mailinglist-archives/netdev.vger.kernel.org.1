Return-Path: <netdev+bounces-267484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JjZIwgntGl7hwAAu9opvQ
	(envelope-from <netdev+bounces-267484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:02:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD7B2857C9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2F1B3136A09
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A43A6F1E;
	Fri, 13 Mar 2026 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO2A4zvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D03A6EFB
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413443; cv=none; b=qkw19WDXEmEB8M8d1qMLPHFdxOujYG28knH8vNAqFgH4qBCxFKE2X0z+Ldg+05rCjfLq5kRpl5FBHgj3bMq01AwaCN4CAplZunKklljC7eW7LaU+JwQvmXstFkV0GH7RgHCyIEDEbXGNVnQA6RfLOGM6WrDbhbmOS9SQ6mRL3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413443; c=relaxed/simple;
	bh=jTpNmNzq5hb9oySY4Wy9mvNAKspFAqshWPXkSwe0BYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqYL+Ro0QNMNQS5w5q8T+TXSOAJqBOfw7+fIfB9oGDVfIViL6U/5oR+0Q+k5yGGULG+L6BehdJnVsHfhY//pbfB1I6raHZRU+AKEv87+Cg9eTpTc4ccx1pNXd59Aj8Y6dKlmRo6HyNzJZI81kFMkRTw01CHNdQJ/OKgDhRiiwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO2A4zvJ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2be4781d2baso6271042eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773413441; x=1774018241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AMQmdUQA1m4tr/S/j/CmgmciqopOGOeSDwB5uJ/htY=;
        b=BO2A4zvJMnga7p1LULepnyLlAn0RdzrgE00Fjfgc72GbNvjfM9jWO21PTtLOFdVTWS
         t+zHP8+CSyVDSc9nkMdszMNkidPwICAoVLXdqyYnBDREiKLvUtWsCgQw9oroAf2KWiZm
         OTvDrNK8YZxmRrNai1Ejh5eOccm2JBgx7tIzHm9uAdwT+jFzlrN1xBof1Q/VblFNTEwf
         /pW3ITx/VZR6lx3VKfICk3ZEWIurHLwL3trhNsStV5aL5N5IlAe7nDoVqQtNTkc+lv8s
         VqnL1rj10/2s5Jz9/2tJ0s8nRs4KofOdFoN5i5IgXSVfIIS33sJhHnQRajzU2+lEvko7
         n2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413441; x=1774018241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AMQmdUQA1m4tr/S/j/CmgmciqopOGOeSDwB5uJ/htY=;
        b=dPJhwK2UUzVQXSnGEm2YXhuaCwuG4Z1pzV5Sh801C1X2cO6kxXrCbbku1dSOLh3sME
         Sj3qMm/eHqfyOs5KSFlyE/Q2/Ga9aGGElVsP1Uv6V17Pp3e0xRYySL7RFQODR5/uG/bx
         MHdj7+W0DywTB/KOdhVryeL6gTpQsos9G5ZR9mcWAn3OadDWAKRZ+9wLyDl8/0gqxT/u
         oHvxaI5nse6M2avTsG2qf6I41M6FR2c59Vl+8Ypd4ISIUHO+EF9j/aChUia/SPXxOn6L
         OnSHj3fsNpXB1k6rfbRGTnrXyLAXOcWd/647uRCuOuu5oTrFdgS30T3bbCCgTPPYbOUJ
         Eqew==
X-Gm-Message-State: AOJu0Yz1QQdlwnS5YzGmGyD3Lv3+w0ICBX5jtnvGnq0qc9xfGlOrObhp
	W9wicz6hHL9O5SU+iJ1Moq+K0yACoKQidML2+3FVi/b3zPJDCpjVOOd41C3E
X-Gm-Gg: ATEYQzzZGwB/tgDs+tg5v/mfvW4s6NsCTDRUVDkStxnxKR3bUbbCQmtcsQVmyqZtkSm
	MktcWo30yiPBtZMl1s3u0dPeigfWKFko3+ZroB1EmJJOD1+WY6uYb8ej07opOBVtZyqImsJCWW7
	8FvOEmsZEyf38AruZZvT3l9ynMAVeVTmBlgae+sMhA8qh2oyvYKpXtgr0HIN56Dh/d7q3Ca2aKf
	zYUITUtvqkyRam/lnVbHd/riag24mvu44OsagIDT5jGxjuGsfkEFox4CpQH9Ib7ohP9lAPHEFtL
	Lsxg8VUxxOS9UKKXk+xilz6AJPLp9HFqmdwoTxa6GwMT4t91qBILHOFpWTSWrP7TtmUato1WyDH
	jbk3KxDWhZmguYOZNBymeDgXEkznwvks8rE2633ESKvK6MVY9KgOBO8Gwd4OkELkbsSE0UeQJyI
	uKEf0dOCOd2oZe3U8JvgFmiEHB8sXKU3X0a6fBMw82CQZIc4yihN+ayvrlk2Os85qhcXoT52GaR
	YVYq4e4i6TDh97MpiOoYY4QQoWI
X-Received: by 2002:a05:7300:1893:b0:2bd:f280:58d4 with SMTP id 5a478bee46e88-2bea541a70cmr1860057eec.6.1773413440904;
        Fri, 13 Mar 2026 07:50:40 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a1117sm3382462eec.3.2026.03.13.07.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:50:40 -0700 (PDT)
Date: Fri, 13 Mar 2026 07:50:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2 net-next] xsk: remove repeated defines
Message-ID: <abQkPzFIjAowYsrF@mini-arch>
References: <20260313111931.438911-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313111931.438911-1-maciej.fijalkowski@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267484-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FD7B2857C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/13, Maciej Fijalkowski wrote:
> Seems we have been carrying around repeated defines for unaligned mode
> logic. Remove redundant ones.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v2: remove another repeated define (Stan, Paolo)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

