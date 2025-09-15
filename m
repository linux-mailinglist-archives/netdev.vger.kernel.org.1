Return-Path: <netdev+bounces-223202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B85B58457
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3730B1AA2EE3
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EBF2BE7B3;
	Mon, 15 Sep 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2eXfDhIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5CD26AD9
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960194; cv=none; b=aYWsGyv6m7nxK4Ix+xNyMR8GBKqab8iLL6k8CTOHmX13bFNRAzWYFPvJ1HQ4qgUPj2hILZ9KAg/tCWJvJbbg5msCg0P3hLXCpNggXIW+TcologKpMuIhZZ89KzgNUBmawevZnrdunAzT4Z0VhWuNorf9xxFBcg3BJNWJfzQlQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960194; c=relaxed/simple;
	bh=3xYlg6X5/DRpux/lLDvQhxRqU3D+0eyR6MKYfb1asOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyf/gaU8W1CaHgv5wGWpAXGXjJ4v8yV9ntyoyYRWdoljXyvH/tpyNWwMq6lW8z1DlLlBm6f6MK/aC10mumYI6Tv4TA++hYWhrRdJjbDbzF/HKrdqeL90KLtl5qd2IW+DS53NEJMVjJJxueVFqrV03X24jp/fIN9DkUcmWJK8wpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2eXfDhIG; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-407a4e744ddso23275ab.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757960189; x=1758564989; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NtX47fkQa9jHnEOx1GdOKmNLR8fJwO71Vlqa8YtoWJg=;
        b=2eXfDhIGqVFwmlwmLbZK0WVKvaN0HpCSHsZs2joD/oJ1Nv+cLRqQ2MAE+LwadedpBA
         MxNfcfFw5Opl4b1RJT/m8CoJp4CmtRkaRUJDcbDkqc7Mida2TM+fN5UMDkMB6U6XEtuX
         ON4MxA1IumgA/yaErjFNzEvKjcTuiuqUreYO70ZSRvWDqbdIqNaHsmaSEHhs5F7ArkYZ
         l62wU79MidRe19kCtHwRrXyuGr16QTZIbUQcRf1zrnnWQocb4pOX828yrVMwu3fwp6BD
         1HNgO9CCLBmyUrfndvTlwjPphraOMcT6hG9zzc6N6pLbUyKCh9QxQwkPtq6wTirpqMFy
         n2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960189; x=1758564989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtX47fkQa9jHnEOx1GdOKmNLR8fJwO71Vlqa8YtoWJg=;
        b=NMdCp2Uqu65QuO0PQGSKuBZvfqq6Sst1X6b8Pv5Y4TCb3NvdVpHYP6MqowC0amyNGs
         QBW4GogOhfyX1VzQrpW+Qms3zUb121HONZUMy3wNYdWopXbAMsilyB4biSgvu81kyWCr
         B5Eza/nVWzx4yaMI/vJEmeMewUD/GmY4E6FkzTYbPzKAnw5sng+U5CrUDpEYeZHyWAGz
         9zB4A2TbnFiLCQPgjsZDYAb8g0dwvqSJbEgQkFdFV2bZymj2G+08CwxvGMWz7dWu3QiG
         JxEh2TG5UzsX1/BFdmrazWblP7MLn6hFVqTNap18rf/sfJO48/jzsddpfoQruo7Pj2gT
         rxtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMCVLVtgnZ82mFt5iO9h9tLDbHb2s+QmfGhzKrRhiKQaTF2+UYTdzBVxgS8C9E5Bzie+DGb94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTV3yUvEQlaAUAe4eVE0LEwbfQg1z6hnu1UnZiKU03tstRb9wu
	1dijCmJhD6irc8HkLRmCapkWwvTHB8TDaSTGpAvDvWPkHErhnU7sRApMgWQJi8McqQ==
X-Gm-Gg: ASbGncuGMphjx1S+LcYKjV8J3GRrNOKhLXCbWUb2P2YT25bhu4snF4+n5uARnLv19yH
	Dl3Br7ZVkZ2X7ZTD7xy3nBgM16B7bTTXDZxxBBBg6i5b9Xt2ANc5tztaRBTVhMv3eIhACxxCJn9
	l5UiTS9wGZQSNbsY9pda1j1ygiG6zBvNcTi+NmyrY7oSylMapvYCofxLu3zyX4u9LIC9HgVibdU
	6yvzfnIzRTbjK609b2u+wh7fPYAOkegovMQ4u23kjM8IdWYs0AOD77hocAcwtUcXYxOi2gJ+eTG
	4+ud9YBWEfIdeNor+ylK7ScljAFxoVqwL8FsbJIWzZVEf13kiu1aTq2HvxgoAm+hSTgjyih0xtu
	NPxp0qVb2VJ4YO61NbS0tVjaHnCEoBdJcEXNyHHpXywfYxxenTuSCTA+pPJZWvkJpQyUYU3vBxP
	G2Dw==
X-Google-Smtp-Source: AGHT+IGLxv+X5dcAq5kdSFe7A92djhQUe1RN0cT2Z+x2zYrOn5i8yLwQrVQbWB2EuOFUKb3elV6rcg==
X-Received: by 2002:a05:6e02:1a46:b0:422:62f8:20f9 with SMTP id e9e14a558f8ab-4240e84e6edmr786535ab.8.1757960188971;
        Mon, 15 Sep 2025 11:16:28 -0700 (PDT)
Received: from google.com (173.247.173.34.bc.googleusercontent.com. [34.173.247.173])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41df02f4e8csm62288245ab.19.2025.09.15.11.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:16:28 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:16:25 +0000
From: Andrei Vagin <avagin@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] net: lockless sock_i_ino()
Message-ID: <aMhX-VnXkYDpKd9V@google.com>
References: <20250902183603.740428-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902183603.740428-1-edumazet@google.com>

On Tue, Sep 02, 2025 at 06:36:03PM +0000, Eric Dumazet wrote:
> @@ -2056,6 +2058,10 @@ static inline int sk_rx_queue_get(const struct sock *sk)
>  static inline void sk_set_socket(struct sock *sk, struct socket *sock)
>  {
>  	sk->sk_socket = sock;
> +	if (sock) {
> +		WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
> +		WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
> +	}

Hi Eric.

This change breaks CRIU [1]. The issue is that socket_diag reports two
sockets with the same inode number. It seems inet_csk_clone_lock copies
sk->sk_ino to child sockets, but sk_set_socket doesn’t reset it to zero
when sock is NULL.

[1] https://github.com/checkpoint-restore/criu/issues/2744

Thanks,
Andrei

