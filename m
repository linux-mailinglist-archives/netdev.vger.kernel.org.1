Return-Path: <netdev+bounces-152037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE409F2692
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8E11882C2C
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830141BC07A;
	Sun, 15 Dec 2024 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjTJFEkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2FA41;
	Sun, 15 Dec 2024 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734301645; cv=none; b=qmifvTeDNHmCn/WSqUvKUZtGFDNXPVfDpn9tL7TRtFsXZ2xJh+1bV3v+NfNXJSUHX1TMudBlmOvA5ZilX8lPQzHoOYx8qX/cCTSUAJB/Km7K0uWC/i4hU/XniidD+pNfoC0ZVOPqsxsr6k/h+gufDIB4KZ2xKUH4tCbYzD8Klv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734301645; c=relaxed/simple;
	bh=AIYO0Bd9h0cqYoCI56IydpYXiY5Nd9sFqMFDJhSXh4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcI1jsGtUakYnIZeZs8lqGgQhADnxVr8sYP6ela0RCUTNFcRNHkJ9fk0pMF0Z3/NwCTh84GYGZtYy/ltTWTfi3YwpCL+ea33UfnddL06vNPO3+8dVRr7z+2RlSjptSDBut5PZdz5L+82FwwrZfQSL51IyVN9jR4wCP87BXGqPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjTJFEkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1497C4CECE;
	Sun, 15 Dec 2024 22:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734301644;
	bh=AIYO0Bd9h0cqYoCI56IydpYXiY5Nd9sFqMFDJhSXh4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DjTJFEkcVg3Gh5C6z/Rl0ZRE9qXLEprET2G7FcWqS/f0xmQ2C3OhRwxB+06lLGQE+
	 zrxvC0sW9hhMys5teHD5raAKrB7blNaK7yzbCRCdsX1DTmivLIzb9WGKKoLQIzXXIu
	 ijDFO3iX2f5G8O9rlQMAZHSvOht9RUKfV+j91xt8mwrb9YALNAE55uNjy38GH0s1jG
	 pZQDM6TyZaVhCEb7FESrtJ4byX90QnrC55fbWBCLkaj5SFNa+Q6ulEVHg0YI/2eiGK
	 xSFM7ov6oWjYvxcxYYcx38VtueAYe7Ybp9Pv440kbKyXzXZWxwFAVo3JEcZjsTzhVp
	 H6BYu1X6BQgOQ==
Date: Sun, 15 Dec 2024 14:27:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
 cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com
Subject: Re: [PATCH net-next v10 1/2] binderfs: add new binder devices to
 binder_devices
Message-ID: <20241215142723.3e7d22e7@kernel.org>
In-Reply-To: <20241212224114.888373-2-dualli@chromium.org>
References: <20241212224114.888373-1-dualli@chromium.org>
	<20241212224114.888373-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 14:41:13 -0800 Li Li wrote:
> +/**
> + * Add a binder device to binder_devices

nit: kdoc is missing function name

> + * @device: the new binder device to add to the global list
> + *
> + * Not reentrant as the list is not protected by any locks
> + */
> +void binder_add_device(struct binder_device *device);

To be clear we do not intend to apply these patches to net-next,
looks like binder patches are mostly handled by Greg KH. Please
drop the net-next from the subject on future revisions to avoid
confusion.

