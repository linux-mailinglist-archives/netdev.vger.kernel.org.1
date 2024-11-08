Return-Path: <netdev+bounces-143334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0129C213E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2653B246B1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0303212D35;
	Fri,  8 Nov 2024 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0eo4T/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1A1E0B66;
	Fri,  8 Nov 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081320; cv=none; b=KKB4WLkfHyzUaAq29M/eXTxstNZhSErkf99Ycvq9E2h/6si6j3o7OUVtc2uUOulvV5QrqeiZh6Zm1wgvvh9A258lhPSTf6eiavD7pKrjZl++nbkRiZjx3Ro6PjBJpqm2SVguEvb5AcctDcBga1XTRzXDEBNBd0vglbohvZ4bLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081320; c=relaxed/simple;
	bh=XjOk8HJiuV5VDxXuhNVyfuqIiTIo5g3RBPdllXZRfPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h04fdhwU7bzCw7PFAgxxj9DgIDx1Utteyg8460+spOfGtS7vV45MV7guftSEtOYwlH5dNDDYd7zMJKTT0l1q7UC9E4kZ9Y6QbyqRWGhsRHpCL4AvkqynamcSs41SiUuBYJsDVnXaZ0O2En7qSwkvhEbvdfS6D9qcbFTvazsVl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0eo4T/f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca1b6a80aso26926065ad.2;
        Fri, 08 Nov 2024 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731081319; x=1731686119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=346H7VQteBq6tLKiTJ0ndUa/kjlvPm0zucay4amUDJo=;
        b=a0eo4T/fwiuzezwJqqnDBq3Ohlwu484I94LspBqqNk5Go5NWi08/Gp6Yz0UMdmgZ/9
         eWUc0xy1eODpjvNsfb6EJlNxXrBqDAVirR+6v1xIlF0Byvqoo/aZsUEc0YOVuearGh00
         vgeSxv1Qk/NbBhPD1/NJivAYQSoNOx155oDWm96jMksvD3pNlLOR10NbeiIdtRjT3/Gj
         8zM7HEnWb1tuFohOs1dDo+3L+/he2BZN8PwsNrvjIMJM9LE3ekEn5da1m1jDjJ7A0sUh
         3NWozxKXLM/0KtlXlhoT19oLwloLSKCP6Dgi0mILW1hWrdWgPgLfYSQxKF4OnJXU4PZh
         sO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081319; x=1731686119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=346H7VQteBq6tLKiTJ0ndUa/kjlvPm0zucay4amUDJo=;
        b=jTFhK6UT9j5GVpYxXWI1UzU79a1VE1nW/eAb8oXlXO1/0mcHtIisV4Mn7vm6hE2imH
         IXdYKYhKit5Zmm/8WSgPQH/m218q3hcUOxpGfnn740DJ9/1xZXJBJU/a1Vn/jF+RBiU5
         2+j+p+CT2WPu504tmt0FBgW4hSsu/w8ZHirBFJuQ8uKeL32A0U2rvNxLmLqs2p3sUsXg
         8A1e2u8+6CSGzFzgEtYCF4M4O7DXFyNqWVg5ZFDb6vQ2jU+8cEJIBg1287QhPuSbXRol
         42TynwM0Mzb5RtxD8dQnqYci1XEQjEVw8an7SBnrw30Hw5D/54tcnR9Xd2qM8pDNVMXQ
         RDew==
X-Forwarded-Encrypted: i=1; AJvYcCU3LtCXQxSEhQuvruvmm+hJN+AQXARaplSVc6L4gy4KWsldtNEIeeVK7/uNaUs9MwmjkKbCR3NsaG0+XqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfDUv0ea7Cu465eQuT9tUK783enn19ICMq0unYXrzOkxscUga
	yWY9KbakAyHrrTkZd21iIoBlQSLAqTQbfWD3ieIQbFxVqIZfSbI=
X-Google-Smtp-Source: AGHT+IHunf3N50AH6QM2SYxiKQiglhsG0P1cPtUBRC/ubYYfMvIZuimrC7fTI4fDS5yLppAL6c37mQ==
X-Received: by 2002:a17:903:27cb:b0:210:f07d:b3d9 with SMTP id d9443c01a7336-21183c7e147mr33229645ad.6.1731081318794;
        Fri, 08 Nov 2024 07:55:18 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7fc3sm31935625ad.30.2024.11.08.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:55:18 -0800 (PST)
Date: Fri, 8 Nov 2024 07:55:17 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 5/5] netmem: add netmem_prefetch
Message-ID: <Zy40ZQEQhS_f996w@mini-arch>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107212309.3097362-6-almasrymina@google.com>

On 11/07, Mina Almasry wrote:
> prefect(page) is a common thing to be called from drivers. Add
> netmem_prefetch that can be called on generic netmem. Skips the prefetch
> for net_iovs.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Needs some extra includes to make the build bot happy, after that:
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---
pw-bot: cr

