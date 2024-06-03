Return-Path: <netdev+bounces-100302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7E98D8742
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396A31C21498
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57D13664A;
	Mon,  3 Jun 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwAeZjFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287B13213B
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431993; cv=none; b=Hq4ddYJCN9LqXSMoV/zbVdyqelmDtha19g97l5rhN8SFiVNKx/0WJY3mtN6LijtFlYYKPcoER/hqlXxCAYSjqw7AOEGutfWB3gYsodO0yRyJ994z8JW2e2ij8cXEcD9cBGngPh0U8BVS2CruxPdPMZTAYUGZQUE2Pm+VH0q9uDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431993; c=relaxed/simple;
	bh=22EqqaxbM4HGxv3TszZ9BCmY5sdK22o5tsfD7q6nh6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1czWZb/PWUHRom858Uti96OjbpHJK3gexWnVdYB0n50GLsWpKJllVquQP0Quznjb2NJk3aE+n0FD4IKjilDztT5cp7k4NCLvvhCDZv0prJ94U1T6qr8grWyB++HzKquJEjwlkUqboTreqcikqlZPYZ6xZs9iOjf3KvGKeC8RnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwAeZjFH; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b2e942171cso2687934eaf.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717431991; x=1718036791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8CkUtHwGXe1uhSPhtIrr2bvyUYFM8p08hrXi+18hG0=;
        b=ZwAeZjFHglV1Rt8yk8qXiRH/b8FOP5S+O2yFfT6cQj/Ru2iv4jnyQy+P7ejzYfvTws
         MK1qXNgyvDmN9iMhH8+3Mv2tJpQe8k2bww0BxJ1B7RIJs6hKw2b6Zt+TIyuKdEn2txX9
         4ZpaxAYvD+4LeZVCx2KcqFPE8ylRyAHPkayFb2ro2YOjpyAU5sV+4NUGR0Ckyt6nGmCW
         tcaPvyi2oxxCw+tJUEl9sRz/4lKqCSu6a8qvVqdYHUJIDjf3IYz/26eJjdta0nGAvWKJ
         FKWnZthwTCzFxwWMbsVv5HDE5kJwJm6k3aQpVk9qCLSQuJ5O7ngrpns8LErXNFH6LyFj
         JUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431991; x=1718036791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8CkUtHwGXe1uhSPhtIrr2bvyUYFM8p08hrXi+18hG0=;
        b=lXV7S4RRrvdwaUGghp8DmwtPGyaohdVUD1v8GQxedHHVlcdRQzDBjU99qWS7CQ3mPh
         y5J7EZMsmXtm9l/0VNzFDpoM6o6PbjQ/kwPPXuHXrA91R06dAk5HHbKBPMN61bYNRBt2
         VrcsfENO9JMGolNjWq6J2TtBnziACjbRyh7MEI8Zv24SwbOhGOjSodQwFSYPs2EZ5QBJ
         gmRnPgDCYmCP5b9V6ZPvyksY5iMYT0CWuEWozoqjihybHRntVFFtbXPBnlMhciYdC1+n
         ybFuWJqSqFSt9VXdgPuLI3ORXsUAqYH+HTkW7shL0qRl9TyBvmn45Xl/bW22/ywsnske
         OfXg==
X-Forwarded-Encrypted: i=1; AJvYcCWWPdc8/5C6LZ2cs6AukUw4F3258BAVsFSlzpj3VGmGNIPYG9lCe0Aj25jIHFxQMtxD2AkTCOV59kTbU3V3UEwfTL+by72/
X-Gm-Message-State: AOJu0Yxz+H8zA2fjMqBLXk2ndxrshuAPYdz6Qn1m7OeGhn/XC5XURxnH
	iKE3FQRW6LhgWFzsRiUBuvErXroZ/3n5I0qNgLEb7olLtDDk+Lsm
X-Google-Smtp-Source: AGHT+IESNm+OYdOl6QNLKm7lpy+gEGeUX90k7+szR3pZx2a+uPJzRwhZYxu79sh+fYBuPzvmEwl3pg==
X-Received: by 2002:a05:6358:8a7:b0:19c:2cb5:4e8c with SMTP id e5c5f4694b2df-19c2cb54f4fmr72278655d.27.1717431990860;
        Mon, 03 Jun 2024 09:26:30 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:2d6e:32ad:faf4:991a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c353f0b2c8sm5608893a12.2.2024.06.03.09.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:26:30 -0700 (PDT)
Date: Mon, 3 Jun 2024 09:26:29 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH v1 net 01/15] af_unix: Set sk->sk_state under
 unix_state_lock() for truly disconencted peer.
Message-ID: <Zl3utZZF/Sa7OnAj@pop-os.localdomain>
References: <20240603143231.62085-1-kuniyu@amazon.com>
 <20240603143231.62085-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603143231.62085-2-kuniyu@amazon.com>

On Mon, Jun 03, 2024 at 07:32:17AM -0700, Kuniyuki Iwashima wrote:
> -		if (other != old_peer)
> +		if (other != old_peer) {
>  			unix_dgram_disconnected(sk, old_peer);
> +
> +			unix_state_lock(old_peer);
> +			if (!unix_peer(old_peer))
> +				WRITE_ONCE(old_peer->sk_state, TCP_CLOSE);
> +			unix_state_lock(old_peer);

lock() old_peer twice? Has it been tested? ;-)

Regards.

